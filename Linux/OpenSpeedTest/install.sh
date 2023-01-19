#!/bin/bash

# https://openspeedtest.com/selfhosted-speedtest

sudo apt update
sudo apt upgrade -y
sudo apt install -y apache2 wget git

wget https://github.com/Heidelberger2000/Scripts/raw/main/Linux/OpenSpeedTest/OpenSpeedTest-Server_2.1.7_amd64.deb
sudo apt install ./OpenSpeedTest-Server_2.1.7_amd64.deb
sudo apt autoremove -y