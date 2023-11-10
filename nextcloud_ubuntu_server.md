# Nextcloud on Ubuntu server
1. Create data directories:
   ```
   cd /media/myserver_d1 # anywhere else
   mkdir -p nextcloud/data
   ```
2. Install snap package:
   ```
   sudo snap install nextcloud
   ```
   Now open nextcloud web ui once using hostname.
3. Allow network access:
   ```
   sudo snap connect nextcloud:network-observe
   ```
4. Setup data directories ([source](https://github.com/nextcloud-snap/nextcloud-snap/wiki/Change-data-directory-to-use-another-disk-partition)):
   ```
   sudo snap connect nextcloud:removable-media
   sudo snap stop nextcloud
   ```
   Now edit file at `/var/snap/nextcloud/current/nextcloud/config/autoconfig.php`. Edit the line:
   ```
   'directory' => '/media/myserver_d1/nextcloud/data',
   ```
   At file `/var/snap/nextcloud/current/nextcloud/config/config.php`, add the line:
   ```
   'check_data_directory_permissions' => false,
   ```
   Edit `datadirectory` line in the same file (or add if not present):
   ```
   'datadirectory' => '/media/myserver_d1/nextcloud/data',
   ```
   Restart nextcloud:
   ```
   sudo snap restart nextcloud
   ```
6. Setup username and password and enjoy
