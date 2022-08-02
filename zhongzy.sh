apt-get update
apt-get install sudo curl screen vim  htop wget git python3 python-setuptools python3-pip -y 

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
"zhongzy" ALL=(ALL) NOPASSWD:ALL
EOF
sed -i "s/PermitRootLogin yes/PermitRootLogin no/g" /etc/ssh/sshd_config
find / -name defaults.vim | xargs sed -i "s/set mouse=a/set mouse-=a/g" 
clear
echo -n "please enter the hostname:"
read NAME
echo ${NAME} > /etc/hostname
echo "nohup /usr/bin/python3 /root/client-linux.py SERVER=mon.5119595.xyz USER=${NAME} PASSWORD=zhongzy123 >/dev/null 2>&1 &" >> /etc/profile
sed -i "s/debian/${NAME}/g" /etc/hosts
cd /root
wget --no-check-certificate -qO client-linux.py 'https://raw.githubusercontent.com/cppla/ServerStatus/master/clients/client-linux.py' 
wget -N --no-check-certificate -c -t3 -T60 -O ss-plugins.sh https://git.io/fjlbl
chmod +x ss-plugins.sh
ip a
reboot
