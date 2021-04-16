#!/usr/bin/env bash
export GOPROXY=https://goproxy.io,direct
wget -O bigsirlogo https://chinapeace.github.io/logo.sh
chmod +x bigsirlogo
./bigsirlogo
sleep 3
. ~/.bashrc
if [ ! $FRONTIER_NODENAME ]; then
        read -p "Enter node name: " FRONTIER_NODENAME
        echo 'export FRONTIER_NODENAME='$FRONTIER_NODENAME >> $HOME/.bashrc
        . ~/.bashrc
fi

echo 'Your node name: ' $FRONTIER_NODENAME
sleep 2

apt install make git wget build-essential jq -y
apt update
apt install curl -y < "/dev/null"
sleep 1
#Install golang
rm -rf /usr/local/go
curl https://gomirrors.org/dl/go/go1.15.7.linux-amd64.tar.gz | tar -C/usr/local -zxvf -
cat <<'EOF' >> $HOME/.bash_profile
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export GO111MODULE=on
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
EOF
. $HOME/.bash_profile
cp /usr/local/go/bin/go /usr/bin
go version

# clone the frontier chain repo
git clone https://github.com/frontierdotxyz/frontier-chain.git
# install
cd frontier-chain && git checkout v0.1.0 && make install
#add command to sys
cp $HOME/go/bin/front* /usr/bin
# initialize chain
frontd init $FRONTIER_NODENAME --chain-id frontier-chain-testnet-0-black-mamba

# Add validator key
frontcli config keyring-backend test
frontcli keys add validator
# Create gentx
frontd add-genesis-account $(frontcli keys show validator -a) 1000000000000front
frontd gentx --name validator --amount 1000000000000front --keyring-backend test
