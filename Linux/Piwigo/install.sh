#!/bin/bash

# https://de.piwigo.org/piwigo-bekommen

sudo apt update
sudo apt upgrade -y
sudo apt install -y software-properties-common ca-certificates lsb-release apt-transport-https apache2 mariadb-server mariadb-client openssl php8.1 php8.1-mysql php8.1-mbstring php8.1-xml php8.1-curl
sudo apt install -y php8.1-common php8.1-mysql php8.1-xml php8.1-xmlrpc php8.1-curl php8.1-gd php8.1-imagick php8.1-cli php8.1-dev php8.1-imap php8.1-mbstring php8.1-opcache php8.1-soap php8.1-zip php8.1-redis php8.1-intl
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
clear
echo -e "MySQL Script"
echo -e ""
echo -n "Bitte geben Sie den mysql_username ein:   "
read mysqluser
echo -n "Bitte geben Sie das mysql_password ein:   "
read mysqlpass
echo -n "Bitte geben Sie den Dantenbanknamen ein:   "
read mysqldatabase

sudo mysql -u root <<EOF
create user '${mysqluser}'@'%';
create database ${mysqldatabase};
grant all on ${mysqldatabase}.* to '${mysqluser}'@'%' IDENTIFIED BY '${mysqlpass}';
grant all on ${mysqldatabase}.* to '${mysqluser}'@'localhost' IDENTIFIED BY '${mysqlpass}';
EOF
