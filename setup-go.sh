#!/bin/bash
wget https://go.dev/dl/go1.21.6.linux-amd64.tar.gz
sudo tar -xvf go1.21.6.linux-amd64.tar.gz -C /usr/local 
echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.profile 
source ~/.profile 
go version 