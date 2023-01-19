#!/bin/bash

sudo apt update
sudo apt upgrade -y
sudo apt install sudo wget git apache2 -y
cd /var/www/
sudo git clone https://github.com/hap-wi/roxy-wi.git /var/www/haproxy-wi

sudo apt install apache2 python3 python3-pip python3-ldap rsync ansible python3-requests python3-networkx python3-matplotlib python3-bottle python3-future python3-jinja2 python3-peewee python3-distro python3-pymysql python3-psutil python3-paramiko netcat-traditional nmap net-tools lshw dos2unix libapache2-mod-wsgi-py3 openssl sshpass -y
sudo chown -R www-data:www-data haproxy-wi/
sudo cp haproxy-wi/config_other/httpd/roxy-wi_deb.conf /etc/apache2/sites-available/roxy-wi.conf
sudo a2ensite roxy-wi.conf
sudo a2enmod cgid ssl proxy_http rewrite
pip3 install -r haproxy-wi/config_other/requirements_deb.txt
sudo systemctl restart apache2

pip3 install paramiko-ng
sudo chmod +x haproxy-wi/app/*.py
sudo cp haproxy-wi/config_other/logrotate/* /etc/logrotate.d/
sudo mkdir /var/lib/roxy-wi/
sudo mkdir /var/lib/roxy-wi/keys/
sudo mkdir /var/lib/roxy-wi/configs/
sudo mkdir /var/lib/roxy-wi/configs/hap_config/
sudo mkdir /var/lib/roxy-wi/configs/kp_config/
sudo mkdir /var/lib/roxy-wi/configs/nginx_config/
sudo mkdir /var/lib/roxy-wi/configs/apache_config/
sudo mkdir /var/log/roxy-wi/
sudo mkdir /etc/roxy-wi/
sudo mv haproxy-wi/roxy-wi.cfg /etc/roxy-wi
sudo openssl req -newkey rsa:4096 -nodes -keyout /var/www/haproxy-wi/app/certs/haproxy-wi.key -x509 -days 10365 -out /var/www/haproxy-wi/app/certs/haproxy-wi.crt -subj "/C=US/ST=Almaty/L=Springfield/O=Roxy-WI/OU=IT/CN=*.roxy-wi.org/emailAddress=aidaho@roxy-wi.org"
sudo chown -R www-data:www-data /var/www/haproxy-wi/
sudo chown -R www-data:www-data /var/lib/roxy-wi/
sudo chown -R www-data:www-data /var/log/roxy-wi/
sudo chown -R www-data:www-data /etc/roxy-wi/
sudo systemctl daemon-reload
sudo systemctl restart apache2
sudo systemctl restart rsyslog

cd /var/www/haproxy-wi/app
sudo ./create_db.py
sudo chown -R www-data:www-data /var/www/haproxy-wi/

sudo apt install sshpass python3-apt -y
sudo mkdir /var/www/.ansible
sudo touch /var/www/.ansible_galaxy
sudo mkdir /var/www/.ssh
sudo chown www-data:www-data /var/www/.*
sudo echo "www-data          ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers

sudo apt-get install fail2ban -y

sudo cp /var/www/haproxy-wi/config_other/fail2ban/filter.d/* /etc/fail2ban/filter.d/
sudo cp /var/www/haproxy-wi/config_other/fail2ban/jail.d/* /etc/fail2ban/jail.d/

sudo systemctl start fail2ban
sudo systemctl enable fail2ban

sudo apt install mariadb-server -y
sudo apt autoremove -y
#nano  /etc/roxy-wi/roxy-wi.cfg