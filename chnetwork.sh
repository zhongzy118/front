cat > /etc/network/interfaces << "EOF"
source /etc/network/interfaces.d/*
auto lo
iface lo inet loopback

allow-hotplug ens3
iface ens3 inet dhcp

EOF
reboot
