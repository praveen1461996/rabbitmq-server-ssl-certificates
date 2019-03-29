#!/bin/sh

#rabbitmq in ubuntu_16.04 


#In order to use the repository, add a key used to sign RabbitMQ releases to apt-key:

sudo apt-key adv --keyserver "hkps.pool.sks-keyservers.net" --recv-keys "0x6B73A36E6026DFCA"

#The key can be downloaded and imported without involving a key server:
wget -O - "https://github.com/rabbitmq/signing-keys/releases/download/2.0/rabbitmq-release-signing-key.asc" | sudo apt-key add -

#Enabling apt HTTPS Transport

sudo apt-get install apt-transport-https

#Source List File
echo "deb http://dl.bintray.com/rabbitmq-erlang/debian xenial erlang" | sudo tee /etc/apt/sources.list.d/bintray.erlang.list

#Installing Erlang Packages
sudo apt-get update
sudo apt-get install erlang-nox -y

#Erlang Version and Repository Pinning
sudo apt-get update
sudo tee /etc/apt/preferences.d/erlang << EOF
"#/etc/apt/preferences.d/erlang
Package: erlang*
Pin: release o=Bintray
Pin-Priority: 1000"
EOF

#rabbitmq Source List File

sudo apt-key adv --keyserver "hkps.pool.sks-keyservers.net" --recv-keys "0x6B73A36E6026DFCA"
wget -O - "https://github.com/rabbitmq/signing-keys/releases/download/2.0/rabbitmq-release-signing-key.asc" | sudo apt-key add -
sudo apt-get install apt-transport-https

sudo tee /etc/apt/sources.list.d/bintray.rabbitmq.list << EOF
deb https://dl.bintray.com/rabbitmq-erlang/debian xenial erlang
deb https://dl.bintray.com/rabbitmq/debian xenial main 
EOF

sudo apt-get update

sudo apt-get install rabbitmq-server -y

sudo service rabbitmq-server start

sudo service rabbitmq-server status

#enabling UI plugin
sudo rabbitmq-plugins enable rabbitmq_management

#adding user with admin as user and password is password
sudo rabbitmqctl add_user admin password


sudo rabbitmqctl set_user_tags admin administrator

