#!/bin/bash

# https://guacamole.apache.org/doc/gug/installing-guacamole.html

sudo apt update
sudo apt upgrade -y
sudo apt install -y apache2 git make wget libcairo2-dev libjpeg-turbo8-dev libpng12-dev libtool-bin uuid-dev libavcodec-dev libavformat-dev libavutil-dev libswsccale-dev freerdp2-dev libpango1.0-dev libssh2-1-dev libtelnet-dev libvncserver-dev libwebsockets-dev libpulse-dev libssl-dev libvorbis-dev libwebp-dev

#sudo tar -xzf guacamole-server-1.4.0.tar.gz
#cd guacamole-server-1.4.0/
sudo git clone git://github.com/apache/guacamole-server.git
cd guacamole-server/
sudo autoreconf -fi
sudo ./configure --with-init-dir=/etc/init.d
sudo make
sudo make install
