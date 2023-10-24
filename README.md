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
ssh-keygen -t ed25519 -C "my raspberry pi server" -f ~/.ssh/myserver
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
