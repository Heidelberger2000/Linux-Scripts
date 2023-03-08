#!/bin/bash

sudo apt update -y && sudo apt upgrade -y
sudo apt install apache2 -y
sudo systemctl enable apache2 && sudo systemctl start apache2
sudo apt-get install php8.1 php8.1-cli php8.1-common php8.1-imap php8.1-redis php8.1-snmp php8.1-xml php8.1-zip php8.1-mbstring php8.1-curl php8.1-gd php8.1-mysql -y
sudo apt install mariadb-server -y
sudo apt install unzip -y
sudo systemctl start mariadb && sudo systemctl enable mariadb
sudo mysql <<EOF
CREATE DATABASE nextcloud;
GRANT ALL PRIVILEGES ON nextcloud.* TO 'nextcloud'@'localhost' IDENTIFIED BY 'HzJiKO56Z7U8iuio9dd2W3w4';
FLUSH PRIVILEGES;
exit;
EOF

cd /var/www/html
wget https://download.nextcloud.com/server/releases/nextcloud-24.0.1.zip && unzip nextcloud-24.0.1.zip && rm nextcloud-24.0.1.zip
chown -R www-data:www-data /var/www/html/nextcloud

wget https://raw.githubusercontent.com/Heidelberger2000/Scripts/main/Linux/nextcloud/nextcloud.conf && sudo cp nextcloud.conf /etc/apache2/sites-available/

sudo a2ensite nextcloud.conf && sudo a2enmod rewrite && apachectl -t && sudo systemctl restart apache2
