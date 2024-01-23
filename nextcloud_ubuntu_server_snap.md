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

## Enable `ffmpeg` for videos
On local machine  
1. Download arm64 builds from here: https://johnvansickle.com/ffmpeg/
2. Extract
3. Copy to server
   ```
   scp /path/to/extracted/ffmpeg myserver:/home/p1c.ash.e3
   scp /path/to/extracted/ffprobe myserver:/home/p1c.ash.e3
   ```

On server - follow guide here: https://github.com/nextcloud-snap/nextcloud-snap/issues/1046#issuecomment-1374427458
1. `sudo snap stop nextcloud`
2. `sudo mkdir -p /var/snap/nextcloud/bin/`
3. `sudo mv ~/ff* /var/snap/nextcloud/bin/`
4. `sudo vim /var/snap/nextcloud/current/nextcloud/config/config.php`; add the following lines:
   > 'memories.vod.disable' => false,  
   > 'memories.vod.ffmpeg' => '/var/snap/nextcloud/bin/ffmpeg',  
   > 'memories.vod.ffprobe' => '/var/snap/nextcloud/bin/ffprobe',  
   > 'ffmpeg' => '/var/snap/nextcloud/bin/ffmpeg',  
   > 'ffprobe' => '/var/snap/nextcloud/bin/ffprobe',  
5. `sudo snap start nextcloud`
