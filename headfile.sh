#!/bin/sh

#installing openssl
sudo apt-get install openssl -y 
mkdir -p /home/testca/certs
mkdir -p /home/testca/private
mkdir -p /home/server
chmod 700 /home/testca/private
echo 01 > /home/testca/serial
touch /home/testca/index.txt
touch /home/testca/index.txt.attr
