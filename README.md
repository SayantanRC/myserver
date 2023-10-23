# My Raspberry Pi 4 server

## Setting static IP address
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
