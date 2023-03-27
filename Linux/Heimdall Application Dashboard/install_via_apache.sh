#!/bin/bash

ip=$(ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p')

echo "das Skript benoetigt root-Rechte"
echo "$(whoami)" | [ "$UID" -eq 0 ] || exec sudo "$0" "$@"

#Install Heimdall

echo -e "\e[33mStarte Heimdall Installation ...\e[0m"
echo -e "\e[33maktualisierte Repos ...\e[0m"
apt-get update 1> /dev/null && apt-get upgrade -y 1> /dev/null
echo -e "\e[33minstalliere Abhaenigkeiten ...\e[0m"
apt-get -y install php libapache2-mod-php php-mbstring php-xml php-common php-sqlite3 php-zip git apache2 -y 1> /dev/null
a2enmod rewrite 1> /dev/null
systemctl restart apache2
echo -e "\e[33mHeimdall holen ...\e[0m"
cd /opt/
mkdir heimdall
cd heimdall/
git clone -q https://github.com/linuxserver/Heimdall.git /opt/heimdall 1> /dev/null
chown -R www-data:www-data /opt/heimdall/
chmod -R 755 /opt/heimdall/
rm /var/www/html/index.html
ln -s /opt/heimdall/public/ /var/www/html
echo -e "\e[33mApache-Conf anpassen ...\e[0m"
wget https://raw.githubusercontent.com/Heidelberger2000/Scripts/main/Linux/Heimdall%20Application%20Dashboard/000-default.conf
cp 000-default.conf /etc/apache2/sites-available/000-default.conf

echo -e "\e[33mStarte Apache neu ...\e[0m"
systemctl restart apache2

echo -e "\e[33mInstallation abgeschlossen ... \e[0m"
echo -e "\e[32mIm Browser bitte https://$ip aufrufen \e[5mFertig\e[0m"
