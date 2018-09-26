#/bin/bash

cd ~
  
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade
sudo apt-get install -y nano htop git
sudo apt-get install -y software-properties-common
sudo apt-get install -y build-essential libtool autotools-dev pkg-config libssl-dev
sudo apt-get install -y libboost-all-dev
sudo apt-get install -y libevent-dev
sudo apt-get install -y libminiupnpc-dev
sudo apt-get install -y autoconf
sudo apt-get install -y automake unzip
sudo add-apt-repository  -y  ppa:bitcoin/bitcoin
sudo apt-get update
sudo apt-get install -y libdb4.8-dev libdb4.8++-dev
sudo apt-get install libzmq3-dev

cd /var
sudo touch swap.img
sudo chmod 600 swap.img
sudo dd if=/dev/zero of=/var/swap.img bs=1024k count=2000
sudo mkswap /var/swap.img
sudo swapon /var/swap.img
sudo free
sudo echo "/var/swap.img none swap sw 0 0" >> /etc/fstab
cd

wget https://github.com/EpicCrypto/Epic/releases/download/2.0.0/epic-2.0.0-x86_64-linux-gnu.tar.gz
tar -xzf epic-2.0.0-x86_64-linux-gnu.tar.gz

sudo apt-get install -y ufw
sudo ufw allow ssh/tcp
sudo ufw limit ssh/tcp
sudo ufw logging on
echo "y" | sudo ufw enable
sudo ufw status
sudo ufw allow 6942/tcp
  
cd
mkdir -p .epic
echo "staking=1" >> epic.conf
echo "rpcuser=user"`shuf -i 100000-10000000 -n 1` >> epic.conf
echo "rpcpassword=pass"`shuf -i 100000-10000000 -n 1` >> epic.conf
echo "rpcallowip=127.0.0.1" >> epic.conf
echo "listen=1" >> epic.conf
echo "server=1" >> epic.conf
echo "daemon=1" >> epic.conf
echo "logtimestamps=1" >> epic.conf
echo "maxconnections=256" >> epic.conf
echo "addnode=108.61.193.88" >> epic.conf
echo "addnode=45.32.230.63" >> epic.conf
echo "addnode=45.32.129.61" >> epic.conf
echo "addnode=149.28.200.19" >> epic.conf
echo "port=1255" >> epic.conf
mv epic.conf .epic

  
cd
./epicd -daemon
sleep 30
./epic-cli getinfo
sleep 5
./epic-cli getnewaddress
echo "Use the address above to send your EPIC coins to this server"
