apt-get update
apt-get install sudo curl screen vim  htop wget git python3 -y 

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
echo -n "please enter the hostname:"
read NAME
cat > /etc/hostname << "EOF"
$NAME
EOF
cat >> /etc/profile << "EOF"
nohup /usr/bin/python3 /root/client-linux.py SERVER=mon.5119595.xyz USER=$NAME PASSWORD=zhongzy123 >/dev/null 2>&1 &
EOF
cd /root
wget --no-check-certificate -qO client-linux.py 'https://raw.githubusercontent.com/cppla/ServerStatus/master/clients/client-linux.py' 

reboot
