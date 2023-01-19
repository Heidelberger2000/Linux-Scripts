#!/bin/bash

# https://de.piwigo.org/piwigo-bekommen

sudo apt update
sudo apt upgrade -y
sudo apt install -y install software-properties-common ca-certificates lsb-release apt-transport-https install apache2 mariadb-server mariadb-client openssl install php8.1 php8.1-mysql php8.1-mbstring php8.1-xml php8.1-curl 
sudo rm /etc/php/8.1/apache2/php.ini
sudo cp php8.1.ini /etc/php/8.1/apache2/php.ini
systemctl restart apache2
sudo a2enmod ssl
systemctl restart apache2
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/apache-selfsigned.key -out /etc/ssl/certs/apache-selfsigned.crt

wget https://de.piwigo.org/download/dlcounter.php?code=latest
cp ./dlcounter.php\?code\=latest piwigo.zip
rm ./dlcounter.php\?code\=latest
unzip piwigo.zip
cp -r piwigo/* /var/www/html/*
sudo chown -R www-data:www-data /var/www/html/
