#!/usr/bin/env bash

#env
    DBHOST=localhost
    DBNAME=laravel
    DBUSER=root
    DBPASSWD=laravel

# update packages
    apt-get update

# install required packages
    apt-get install -y vim apache2 libapache2-mod-php5 php5-mysql php5-mcrypt php5-gd php-pear php-apc php5-curl curl lynx-cur openssh-server debconf-utils redis-server

# enable apache modules
    a2enmod php5 rewrite ssl proxy proxy_http headers

# enable php modules
    php5enmod mcrypt

# enable xdebug
    echo "xdebug.remote_enable=on" >> /etc/php5/apache2/conf.d/xdebug.ini
    echo "xdebug.remote_connect_back=on" >> /etc/php5/apache2/conf.d/xdebug.ini

# mysql
    echo "mysql-server mysql-server/root_password password $DBPASSWD" | debconf-set-selections
    echo "mysql-server mysql-server/root_password_again password $DBPASSWD" | debconf-set-selections

    apt-get install -y mariadb-server-5.5 > /dev/null 2>&1

    mysql -uroot -p$DBPASSWD -e "CREATE DATABASE $DBNAME"
    mysql -uroot -p$DBPASSWD -e "grant all privileges on $DBNAME.* to '$DBUSER'@'localhost' identified by '$DBPASSWD'"

# vhost
ln -s /vagrant/environment/* /etc/apache2/sites-available/
ln -s /vagrant/laravel /var/www/laravel
a2ensite laravel
mkdir /var/log/apache2/laravel

# host
    cat >>/etc/hosts <<EOF
127.0.0.1    local.laravel.com
EOF

apachectl restart