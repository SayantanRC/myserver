# Install required packages
```
sudo apt install vim-tiny inetutils-ping net-tools openssh-server qemu-guest-agent -y
sudo ln -sf /usr/bin/vim.tiny /usr/bin/vim
```

# Start ssh
```
sudo systemctl enable --now ssh
```
