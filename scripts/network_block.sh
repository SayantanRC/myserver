#!/usr/bin/env bash

CONTAINER_NAME="$1"

container_id="$(docker ps -aq -f name=$CONTAINER_NAME | head -1)"
echo "Container ID for $CONTAINER_NAME - $container_id"

iflink=$(docker exec -i $container_id sh -c 'cat /sys/class/net/eth0/iflink' 2>/dev/null | tr -d '\r')

if [ -z "$iflink" ]; then
    echo "Error: Could not get iflink for container $CONTAINER_NAME."
    exit 1
fi

veth_path=$(grep -l "$iflink" /sys/class/net/veth*/ifindex)

if [ -z "$veth_path" ]; then
    echo "Error: Could not find host veth for iflink $iflink."
    exit 1
fi

veth_name=$(basename $(dirname $veth_path))

bridge_name="$(bridge link | grep $veth_name | awk '{print $7}')"

container_ip="$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $container_id)"

if [[ -z "$container_ip" ]]; then
  echo "No IP found!"
else
  echo "Blocking IP - $container_ip on $bridge_name"
  sudo iptables -I DOCKER-USER -s $container_ip -o $bridge_name -j DROP
  sudo iptables -I DOCKER-USER -d $container_ip -o $bridge_name -j DROP
fi

echo
echo
