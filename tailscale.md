# exit node
```
sudo tailscale set --advertise-exit-node
sudo tailscale set --advertise-routes=192.168.68.0/24,192.168.29.1/32
```
Approve from Tailscale login page

# client
```
tailscale set --exit-node=<IP> --exit-node-allow-lan-access=true --accept-routes=true
```
For just accessing Router, we can avoid exit nodes completely, and just use routes.

# use without sudo

```
sudo tailscale set --operator=$USER
```
