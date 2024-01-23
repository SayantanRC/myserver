# Ubuntu server

## Install stuff
```
sudo apt install net-tools network-manager pmount tree ffmpeg php-imagick
```
Create cronjob with `crontab -e`. Add this:
```
@reboot pmount /dev/sda1 myserver_d1
```
