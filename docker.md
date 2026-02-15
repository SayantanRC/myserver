# install docker
```
sudo curl -fsSL https://get.docker.com | sh
```
# Run as root but without `sudo`
```
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
```
# Expose docker API
```
sudo systemctl edit docker.service
```
Add the following to the drop-in section

> [Service]  
> ExecStart=  
> ExecStart=/usr/bin/dockerd -H fd:// -H tcp://0.0.0.0:2375  

then
```
sudo systemctl daemon-reload
sudo systemctl restart docker.service
```
Check from local
```
sudo netstat -lntp | grep dockerd
```
Check from remote
```
curl http://<ip-address>:2375/version
```
