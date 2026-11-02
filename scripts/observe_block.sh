#!/usr/bin/env bash

# Changes required:
#
# Add the following delay just below [Service], above "ExecStart" in docker service
# File         : /usr/lib/systemd/system/docker.service
# Delay clause : ExecStartPre=/bin/sleep 30
#
# Add to crontab:
# sudo crontab -e
# Add the following at the end: @reboot /var/scripts/observe_block.sh <local_access_ip>
# Example:                      @reboot /var/scripts/observe_block.sh 192.168.29.200
#
# Make sure the entire scripts directory is copied under /var/

LOCAL_ACCESS_IP="$1"

script_dir=$(dirname "$(realpath "$0")")
log_file="${script_dir}/block.log"

printToFile() {
  echo "$(date) - $1" | tee -a "$log_file"
}

block() {
  container_name="$1"

  printToFile "Container: $container_name, blocking ALL access..."
  ${script_dir}/network_block.sh "$container_name" | tee -a "$log_file"
  echo
}

# Unblock domains specified in the docker compose file
# Format:
#
# service:
#   xyz:
#     environment:
#       - ALLOWED_DOMAINS=google.com yahoo.com
#
# To unblock everything, set ALLOWED_DOMAINS=*
#
unblock_allowed() {
  container_name="$1"
  
  allowed_domains=`docker inspect $container_name | jq -r '.[0].Config.Env[] | select(startswith("ALLOWED_DOMAINS=")) | split("=")[1]'`

  if [[ -z "$allowed_domains" ]]; then
    printToFile "$container_name - nothing to unblock"
    printToFile ""
    echo
  elif [[ "$allowed_domains" == "*" ]]; then
    printToFile "$container_name - unblock ALL"
    ${script_dir}/network_unblock.sh "$container_name" | tee -a "$log_file"
    printToFile ""
    echo
  else
    IFS=' '
    for domain in $allowed_domains; do
      printToFile "$container_name - unblock $domain"
      ${script_dir}/network_unblock.sh "$container_name" "$domain" | tee -a "$log_file"
      printToFile ""
      echo
    done
  fi
}

unblock_local_access() {
  container_name="$1"
  if [[ -n "$LOCAL_ACCESS_IP" ]]; then
    printToFile "$container_name - unblock local access IP"
    ${script_dir}/network_unblock.sh "$container_name" "$LOCAL_ACCESS_IP" | tee -a "$log_file"
    echo
  fi
}

remove_existing_rules() {
  container_name="$1"
  echo
  printToFile "$container_name - removing existing rules"
  ${script_dir}/network_unblock.sh "$container_name" | tee -a "$log_file"
  echo
}

printToFile "Wait for 10 sec..."
sleep 10s

printToFile "Wait for containers to come online, removing existing rules..."
sudo iptables -F DOCKER-USER

# This for loop depends on `docker ps`.
# Thus it will wait till the docker service comes up after 30 seconds.
# This will run ONCE. It will not "observe"
for container_name in $(docker ps -a --format "{{.Names}}"); do
  block "$container_name"
  unblock_local_access "$container_name"
  unblock_allowed "$container_name"
done

# This loop will start "observing" container restarts and apply rules accordingly
docker events --filter 'event=start' --format json | while read -r event;
do
  container_name=`echo $event | jq -r '.Actor.Attributes.name'`
  remove_existing_rules "$container_name"
  block "$container_name"
  unblock_local_access "$container_name"
  unblock_allowed "$container_name"
done

