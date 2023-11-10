# SSH tips

## WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!
To remove entry from `known_hosts` file on your local machine
```
# ssh-keygen -R <hostname>, this will not delete ssh files, only modify known_hosts file.
ssh-keygen -R p1cashe3
```
