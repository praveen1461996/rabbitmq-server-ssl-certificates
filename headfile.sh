#!/bin/sh

#installing openssl to create server client certificates
sudo apt-get install openssl -y

#locations for our certificates
sudo mkdir -p /home/testca
sudo cp openssl.cnf /home/testca
sudo mkdir -p /home/testca/certs
sudo mkdir -p /home/testca/private
sudo mkdir -p /home/server
sudo mkdir -p /home/client

#making private foulder secure
sudo chmod 700 /home/testca/private


echo 01 > /home/testca/serial
sudo touch /home/testca/index.txt
sudo touch /home/testca/index.txt.attr

#changing scripts permissions to exec mode 
sudo chmod +x /home/prepare-server.sh /home/generate-client-keys.sh rabbitmq.sh

#preparing server certificates
sudo cp prepare-server.sh /home
/home/prepare-server.sh 

#preparing client certificats
sudo cp generate-client-keys.sh /home
/home/generate-client-keys.sh

#installing rabbitmq
sudo cp rabbitmq.sh /home
/home/rabbitmq.sh

#deploying configuration file 
cp /home/rabbitmq.config /etc/rabbitmq/rabbitmq.config

#restarting the server
sudo systemctl restart rabbitmq-server
