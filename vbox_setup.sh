echo "
auto eth1
iface eth1 inet static
    address 192.168.56.2
    netmask 255.255.255.0
" >> /etc/network/interfaces

ifup eth1

echo "ubuntu ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
