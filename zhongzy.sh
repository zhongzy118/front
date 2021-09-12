apt-get install sudo curl screen vim  htop wget git -y 

useradd -r -m -s /bin/bash zhongzy

passwd root << "EOF"
zhongzy123
zhongzy123
EOF

passwd zhongzy << "EOF"
zhongzy123
zhongzy123
EOF

cd /etc/sudoers.d
touch zhongzy
cat >> /etc/sudoers.d/zhongzy << "EOF"
"zhongzy" ALL=(ALL) ALL
EOF
sed -i "s/PermitRootLogin yes/PermitRootLogin no/g" /etc/ssh/sshd_config
find / -name defaults.vim | xargs sed -i "s/set mouse=a/set mouse-=a/g" 
reboot
