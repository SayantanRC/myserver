# My Raspberry Pi 4 server

## Setting SSH with key
On local machine:  
```
ssh-keygen -t rsa -b 2048 -C "my raspberry pi server" -f ~/.ssh/myserver
```
Press enter when asked to enter passphrase. Keep it blank.

Add the following to your local machine's `~/.ssh/config` file  
```
Host myserver
  User p1c.ash.e3
  Hostname p1cashe3
  UpdateHostKeys yes
  IdentityFile ~/.ssh/myserver
```
Copy it to the server
```
ssh-copy-id -i ~/.ssh/myserver.pub p1c.ash.e3@p1cashe3
```
Enter password when prompted.  
Now login using SSH to server. Now we don't need to specify full username and hostname. It is already specified in `~/.ssh/config`
```
ssh myserver
```

## Disable password login and root login through SSH
On server:
```
sudo vim /etc/ssh/sshd_config
```
Change some of the lines as below:  
> PermitRootLogin no  
> PasswordAuthentication no

Restart SSH service:
```
sudo systemctl restart ssh
```

## Protect root access
On server
1. Update sudeors
   ```
   sudo visudo -f /etc/sudoers.d/p1cashe3
   ```
   Enter the following
   ```
   Defaults        insults

   p1c.ash.e3    ALL = PASSWD: /usr/bin/su
   ```
2. Comment out other files.
   ```
   sudo mv /etc/sudoers.d/010_pi-nopasswd /etc/sudoers.d/.010_pi-nopasswd # raspberry pi os
   sudo mv /etc/sudoers.d/90-cloud-init-users /etc/sudoers.d/.90-cloud-init-users # ubuntu server
   ```
4. Set a strong root password and a strong user password. Use the `passwd` command.
3. Restart sudo with `sudo -k`.

## Setting tunnelling with Tailscale and duckdns

1. Sign up for a tailscale account at https://login.tailscale.com/start
2. Follow onscreen prompts to download and install tailscale on the server
3. Sign up for duckdns at https://www.duckdns.org
4. Create a subdomain
5. Go to "install" tab at top and click on "pi". Follow the instructions to create the `duck.sh` file.
6. Now edit the file as below
   <pre>
     <b>IP=`tailscale ip | head -n 1`</b>
     echo url="https://www.duckdns.org/update?domains=<b>YOUR_DOMAIN</b>&token=<b>YOUR_TOKEN</b>b&ip=<b>$IP</b>" | curl -k -o ~/duckdns/duck.log -K -
   </pre>
7. Run the script. Now you should be able to reach the server using the YOUR_DOMAIN.duckdns.org (as long as the other device is also on the same tailscale network.)







Resources:  
https://www.digitalocean.com/community/tutorials/how-to-edit-the-sudoers-file  
https://github.com/nextcloud/previewgenerator/issues/233  

Good youtube videos:  
https://www.youtube.com/watch?v=fKuqYQdqRIs  
[Dynamic DNS (DDNS) for Free: Remote Access to Home Server](https://www.youtube.com/watch?v=wCJjiHp0d0w)  
