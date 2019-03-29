#!/bin/sh

#installing openssl to create server client certificates
sudo apt-get install openssl -y

#locations for our certificates
mkdir -p /home/testca/certs
mkdir -p /home/testca/private
mkdir -p /home/server
mkdir -p /home/client

#making private foulder secure
chmod 700 /home/testca/private


echo 01 > /home/testca/serial
touch /home/testca/index.txt
touch /home/testca/index.txt.attr

#changing scripts permissions to exec mode 
chmod +x /home/prepare-server.sh /home/generate-client-keys.sh rabbitmq.sh

#preparing server certificates
./prepare-server.sh

#preparing client certificats
./generate-client-keys.sh

#installing rabbitmq
./rabbitmq.sh

#deploying configuration file 
cp rabbitmq.config /etc/rabbitmq/rabbitmq.config

#restarting the server
sudo systemctl restart rabbitmq-server
