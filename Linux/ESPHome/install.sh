#!/bin/bash
apt-get update
apt-get -y upgrade
apt install python3-pip python3-venv
useradd --home-dir=/opt/esphome --create-home esphome
su - esphome
python3 -m venv venv
source venv/bin/activate
pip install esphome

echo "#!/bin/bash

source venv/bin/activate
esphome dashboard /opt/esphome/config/" >> /opt/esphome/start.sh

chmod +x /opt/esphome/start.sh

echo "[Unit]
Description=ESPHome Dashboard Service
After=network.target

[Service]
Type=simple
User=esphome
WorkingDirectory=/opt/esphome
ExecStart=/opt/esphome/start.sh
RestartSec=30
Restart=on-failure

[Install]
WantedBy=multi-user.target" >> /lib/systemd/system/esphomedashboard.service

systemctl daemon-reload
systemctl start esphomedashboard.service
systemctl enable esphomedashboard.service
