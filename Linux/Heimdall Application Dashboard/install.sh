#!/bin/bash

# https://heimdall.site/

RELEASE=$(curl -sX GET "https://api.github.com/repos/linuxserver/Heimdall/releases/latest" | awk '/tag_name/{print $4;exit}' FS='[""]'); echo $RELEASE &&\ curl --silent -o Heimdall-${RELEASE}.tar.gz -L "https://github.com/linuxserver/Heimdall/archive/${RELEASE}.tar.gz"

mkdir Heimdall-${RELEASE}
tar xzvf Heimdall-*.tar.gz -C Heimdall-${RELEASE}
sudo apt install apache2 php-sqlite3 php-zip

echo "[Unit]
Description=Heimdall
After=network.target
[Service]
Restart=always
RestartSec=5
Type=simple
User=$USER
Group=$USER
WorkingDirectory=/home/lgtm/Heimdall-${RELEASE}
ExecStart="/usr/bin/php" artisan serve --host 0.0.0.0 --port 7889
TimeoutStopSec=30
[Install]
WantedBy=multi-user.target" > heimdall.service
sudo cp heimdall.service /etc/systemd/system/heimdall.service
sudo systemctl enable --now heimdall.service