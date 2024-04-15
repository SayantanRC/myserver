# PI OS lite

## Install stuff
```
sudo apt install pmount tree ffmpeg debian-goodies apache2-utils
```
Create cronjob with `crontab -e`. Add this:
```
@reboot pmount /dev/sda1 myserver_d1
```
