# SSH tips

## WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!
To remove entry from `known_hosts` file on your local machine
```
# ssh-keygen -R <hostname>, this will not delete ssh files, only modify known_hosts file.
ssh-keygen -R p1cashe3
```

## Use a specific key to login to sever
```
# ssh -i /path/to/private_key user@server_ip_or_hostname
# Path to private key
ssh -i ~/.ssh/server-rpi4 p1c.ash.e3@192.168.68.101
```
