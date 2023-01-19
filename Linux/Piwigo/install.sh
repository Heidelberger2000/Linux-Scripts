#!/bin/bash

# https://de.piwigo.org/piwigo-bekommen

wget https://de.piwigo.org/download/dlcounter.php?code=latest
cp ./dlcounter.php\?code\=latest piwigo.zip
rm ./dlcounter.php\?code\=latest
unzip piwigo.zip
cp -r piwigo/* /var/www/html/*
sudo chown -R www-data:www-data /var/www/html/