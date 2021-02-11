FROM	alpine:3.12.3


VOLUME	["/sys/fs/cgroup"]

# install and update
RUN		apk update
RUN		apk add nginx
RUN		apk add openrc --no-cache
# RUN		apk add php php-fpm php7-common php7-iconv php7-json php7-gd php7-curl php7-xml php7-mysqli php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap php7-ctype php7-dom	 php7-session php-mbstring
RUN		apk add php7-fpm php7-mcrypt php7-soap php7-openssl php7-gmp php7-pdo_odbc php7-json \
	php7-dom php7-pdo php7-zip php7-mysqli php7-sqlite3 php7-apcu php7-pdo_pgsql php7-bcmath \
	php7-gd php7-odbc php7-pdo_mysql php7-pdo_sqlite php7-gettext php7-xmlreader php7-xmlrpc \
	php7-bz2 php7-iconv php7-pdo_dblib php7-curl php7-ctype php7-session php7-mbstring \
	php7 php7-opcache php7-zlib 1>/dev/null
COPY	src /tmp
RUN		rc-status && touch /run/openrc/softlevel

# create nginx usser and group and homedir
RUN		adduser -D -g 'www' www
RUN		mkdir	/www && mkdir /run/nginx/
RUN		chown	-R www:www /var/lib/nginx
RUN		chown	-R www:www /www
# RUN		echo "<?php phpinfo();?>" > www/index.php


RUN		mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig
RUN		mv /tmp/nginx.conf /etc/nginx/nginx.conf

#install telegraf
RUN		echo "http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
	&&	apk add telegraf \
	&&	mkdir	/etc/telegraf \
	&&	mv /etc/telegraf.conf /etc/telegraf/telegraf.conf \
	&&	sed -i 's|.*  hostname = "".*|  hostname = "phpmyadmin"|' /etc/telegraf/telegraf.conf \
	&&	sed -i 's|.*  # urls = \["http://127.0.0.1:8086"\].*|  urls = \["http://influxdb:8086"\]|' /etc/telegraf/telegraf.conf \
	&&	sed -i 's|^  # database = "telegraf"|  database = "influxdb"|' /etc/telegraf/telegraf.conf

# phpmyadmine
RUN		cd www/ && wget http://files.directadmin.com/services/all/phpMyAdmin/phpMyAdmin-5.0.2-all-languages.tar.gz
RUN		tar zxvf www/phpMyAdmin-5.0.2-all-languages.tar.gz
RUN		mv phpMyAdmin-5.0.2-all-languages /www/phpmyadmin \
	&&	rm -rf phpMyAdmin-5.0.2*
RUN		chmod -R 777 /www/phpmyadmin \
	&&	mv /tmp/config.inc.php /www/phpmyadmin/

EXPOSE	5000

CMD	./tmp/openrc.sh && tail -f /dev/null