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


sudo tee /home/testca/serial << EOF
01
EOF

sudo touch /home/testca/index.txt
sudo touch /home/testca/index.txt.attr

sudo cp prepare-server.sh /home
sudo cp generate-client-keys.sh /home
sudo cp rabbitmq.sh /home
sudo cp openssl.cnf /home/testca
#changing scripts permissions to exec mode 
sudo chmod +x /home/prepare-server.sh /home/generate-client-keys.sh /home/rabbitmq.sh

#preparing server certificates

/home/prepare-server.sh 

#preparing client certificats

/home/generate-client-keys.sh

#installing rabbitmq

/home/rabbitmq.sh

#deploying configuration file 

cp rabbitmq.config /etc/rabbitmq/rabbitmq.config

#restarting the server
sudo systemctl restart rabbitmq-server
sudo systemctl status rabbitmq-server
