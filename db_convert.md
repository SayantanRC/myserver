# Convert SQLite to MariaDB
## From inside nextcloud docker shell
```
sudo -u <user> php /app/www/public/occ db:convert-type --all-apps mysql <db_user> <db_address> <db_name>
```
Example
```
sudo -u abc php /app/www/public/occ db:convert-type --all-apps mysql p1c.ash.e3 172.18.0.2 nextcloud_db
```

`<user>` may be found by:
```
/usr/bin/php /usr/bin/occ db:convert-type --all-apps mysql p1c.ash.e3 172.18.0.2 nextcloud_db
```
Which throws an error as:
```
# shellcheck shell=bash

sudo -u abc -s /bin/bash -c "php /app/www/public/occ $*"
```

`<db_address>` can be found from portainer or [check here](https://stackoverflow.com/a/20686101/10967630).
