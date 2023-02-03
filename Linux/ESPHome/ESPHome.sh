#!/bin/bash

python3 -m venv venv
source venv/bin/activate
pip3 install -U esphome
systemctl start esphomedashboard.service
d=`date +%Y-%m-%d-%H-%M`
V=`esphome version`
echo $d " -  cronjob gelaufen. Aktuelle" $V  >> /opt/esphome/config/1-Logfile.yaml" >> /etc/cron.daily/ESPHome.sh
chmod +x /etc/cron.daily/ESPHome.sh
