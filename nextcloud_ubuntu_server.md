# Nextcloud on Ubuntu server
1. Create data directories:
   ```
   cd /media/myserver_d1 # anywhere else
   mkdir nextcloud
   mkdir -p nextcloud/data
   mkdir -p nextcloud/custom_apps
   mkdir -p nextcloud/apps
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
4. Setup data directories:
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
   Restart nextcloud:
   ```
   sudo snap restart nextcloud
   ```
5. Setup username and password and enjoy
