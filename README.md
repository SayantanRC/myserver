# My Raspberry Pi 4 server

## Setting static IP address
On server:  
```
sudo apt install dhcpcd
sudo reboot
```
Followed by
```
sudo vim /etc/dhcpcd.conf
```
Add the following lines at the end to use `192.168.1.113` as the IP (for example).
> interface wlan0  
> static ip_address=192.168.1.113/24  
> static routers=192.168.1.1  
> static domain_name_servers=1.1.1.1  

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










Resources:  
https://www.digitalocean.com/community/tutorials/how-to-edit-the-sudoers-file  
https://github.com/nextcloud/previewgenerator/issues/233  

Good youtube videos:  
https://www.youtube.com/watch?v=fKuqYQdqRIs  
[Dynamic DNS (DDNS) for Free: Remote Access to Home Server](https://www.youtube.com/watch?v=wCJjiHp0d0w)  
