#!/bin/bash

# Systemaktualisierung
sudo apt update
sudo apt upgrade -y
# Benötigte Software wird gezogen 
sudo apt install sudo wget git apache2 fail2ban python3 python3-pip python3-ldap rsync ansible python3-requests python3-networkx python3-matplotlib python3-bottle python3-future python3-jinja2 python3-peewee python3-distro python3-pymysql python3-psutil python3-paramiko netcat-traditional nmap net-tools lshw dos2unix libapache2-mod-wsgi-py3 openssl sshpass -y
# Installation beginnt
cd /var/www/
sudo git clone https://github.com/hap-wi/roxy-wi.git /var/www/haproxy-wi
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
sudo cp /var/www/haproxy-wi/config_other/fail2ban/filter.d/* /etc/fail2ban/filter.d/
sudo cp /var/www/haproxy-wi/config_other/fail2ban/jail.d/* /etc/fail2ban/jail.d/
sudo systemctl start fail2ban
sudo systemctl enable fail2ban
sudo apt install mariadb-server -y
sudo apt autoremove -y
sudo cp /etc/roxy-wi/roxy-wi.cfg /etc/roxy-wi/roxy-wi.cfg.bak
sudo rm /etc/roxy-wi/roxy-wi.cfg

clear
echo -e "MySQL Script"
echo -e ""
echo -n "Bitte geben Sie die FQDN (example.org) oder IP ein (Std. 127.0.0.1):   "
read domainip
echo -n "Bitte geben Sie den Port ein (std. 3306):   "
read domainport
echo -n "Bitte geben Sie den mysql_user ein (std. roxy-wi):   "
read mysqluser
echo -n "Bitte geben Sie das mysql_password ein (std. roxy-wi):   "
read mysqlpass
echo -n "Bitte geben Sie den Dantenbanknamen ein (std. roxy-wi):   "
read mysqldatabase

sudo mysql -u root <<EOF
create user '${mysqluser}'@'%';
create database ${mysqldatabase};
grant all on ${mysqldatabase}.* to '${mysqluser}'@'%' IDENTIFIED BY '${mysqlpass}';
grant all on ${mysqldatabase}.* to '${mysqluser}'@'localhost' IDENTIFIED BY '${mysqlpass}';
EOF

echo "[main]
# Path to the files destination
fullpath = /var/www/haproxy-wi
log_path = /var/log/roxy-wi
lib_path = /var/lib/roxy-wi

[configs]
# Folders for configs
haproxy_save_configs_dir = ${main:lib_path}/configs/hap_config/
kp_save_configs_dir = ${main:lib_path}/configs/kp_config/
nginx_save_configs_dir = ${main:lib_path}/configs/nginx_config/
apache_save_configs_dir = ${main:lib_path}/configs/apache_config/

[mysql]
enable = 1
mysql_user = ${mysqluser}
mysql_password = ${mysqlpass}
mysql_db = ${mysqldatabase}
mysql_host = ${domainip}
mysql_port = ${domainport}" > /etc/roxy-wi/rpxy-wi.cfg
cd /var/www/haproxy-wi/app
sudo ./create_db.py
sudo chown -R www-data:www-data /var/www/haproxy-wi/

