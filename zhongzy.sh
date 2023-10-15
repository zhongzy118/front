apt-get update
apt-get install sudo curl screen vim  htop wget apt-transport-https ca-certificates curl software-properties-common gnupg lsb-release cifs-utils -y 

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

cat >> /etc/profile  << 'EOF'
# for history command
HISTTIMEFORMAT="%F %T "
export HISTTIMEFORMAT
export HISTCONTROL=ignoredups:erasedups
shopt -s histappend
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"
export HISTSIZE=20000
EOF

source /etc/profile

clear
echo -n "please enter the hostname:"
read NAME
echo ${NAME} > /etc/hostname
sed -i "s/debian/${NAME}/g" /etc/hosts





cd /root
wget -N --no-check-certificate -c -t3 -T60 -O ss-plugins.sh https://git.io/fjlbl
chmod +x ss-plugins.sh
ip a
bash ss-plugins.sh
