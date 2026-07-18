## Add / Edit the file at `/etc/dnsmasq.d/lan.conf`
```
# Authoritative only for mylocal.lan
local=/mylocal.lan/

# Static records
address=/pve1.mylocal.lan/192.168.29.200
address=/pve1-docker1.mylocal.lan/192.168.29.100
address=/pve1-docker2.mylocal.lan/192.168.29.101
address=/pve1-docker3.mylocal.lan/192.168.29.102
```

## Add to tailscale
Open Tailscale admin page -> "DNS" tab at the top -> Nameserver section (enable split dns)
