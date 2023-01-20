#!/bin/bash

# https://openspeedtest.com/selfhosted-speedtest

sudo apt update
sudo apt upgrade -y
sudo apt install -y docker.io

docker run --restart=unless-stopped --name openspeedtest -d -p 3000:3000 -p 3001:3001 openspeedtest/latest

sudo apt autoremove -y
