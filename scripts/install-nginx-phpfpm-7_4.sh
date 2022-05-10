#!/bin/bash

wget -q https://packages.sury.org/php/apt.gpg -O- | apt-key add - && echo "deb https://packages.sury.org/php/ buster main" | tee /etc/apt/sources.list.d/php.list && apt update
apt install php7.4-fpm php7.4-common php7.4-mysql php7.4-gmp php7.4-curl php7.4-intl php7.4-mbstring php7.4-xmlrpc php7.4-gd php7.4-xml php7.4-cli php7.4-zip php7.4-soap php7.4-imap -y
sed -ri 's/(memory_limit[	 ]*=).*$/\1 512M/' /etc/php/7.4/fpm/php.ini
sed -ri 's/(serialize_precision[	 ]*=).*$/\1 -1/' /etc/php/7.4/fpm/php.ini
systemctl reload nginx
p