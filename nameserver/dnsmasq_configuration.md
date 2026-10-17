## Configure dnsmasq
Install:
```
sudo apt install dnsmasq
```
Configure file at `/etc/dnsmasq.d/lan.conf`
```
# Authoritative only for mylocal.lan
local=/mylocal.lan/

# Static records
address=/pve1.mylocal.lan/192.168.29.200
address=/pve1-docker1.mylocal.lan/192.168.29.100
address=/pve1-docker2.mylocal.lan/192.168.29.101
address=/pve1-docker3.mylocal.lan/192.168.29.102

# Caddy reverse proxy
address=/2fauth.mylocal.lan/192.168.29.222
address=/joplin.mylocal.lan/192.168.29.222
address=/portainer.mylocal.lan/192.168.29.222
```
Restart service
```
sudo systemctl restart dnsmasq
```

## Add to tailscale
Open Tailscale admin page -> "DNS" tab at the top -> Nameserver section (enable split dns)

## Configure caddy
Install:
```
sudo apt install caddy
```
Configuration file at : `/etc/caddy/Caddyfile`
```
{
    local_certs
}

joplin.mylocal.lan {
    reverse_proxy 192.168.29.102:22300
}

2fauth.mylocal.lan {
    reverse_proxy 192.168.29.102:8030
}

portainer.mylocal.lan {
    reverse_proxy https://192.168.29.102:9443 {
        transport http {
            tls_insecure_skip_verify
        }
    }
}
```
Restart service
```
sudo systemctl restart caddy
```

## Trust caddy certificate
Dump root certificate file
```
cat /var/lib/caddy/.local/share/caddy/pki/authorities/local/root.crt
```
Copy the contents to local machine, say `caddy-root.crt`, add to ca-certificates:
```
sudo cp caddy-root.crt /usr/local/share/ca-certificates/caddy-root.crt
sudo update-ca-certificates
```
### Librewolf
- Settings -> Privacy & Security -> Connection and software security : Advanced Settings -> Certificates : Manage certificates.
- "Authorities" tab -> Import -> select the certificate -> check "Trust this CA to identify websites" -> ok
