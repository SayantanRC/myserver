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
