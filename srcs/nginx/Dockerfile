FROM	alpine:3.12.3

VOLUME	["/sys/fs/cgroup"]

# install and update
RUN		apk update
RUN		apk add nginx
RUN		apk add openrc
COPY	src /tmp

# create nginx usser and group and homedir
RUN		adduser -D -g 'www' www
RUN		mkdir	/www
RUN		chown	-R www:www /var/lib/nginx
RUN		chown	-R www:www /www \
	&&	mkdir /run/nginx \
	&&  rc-status && touch /run/openrc/softlevel

#install telegraf
RUN		echo "http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
	&&	apk add telegraf \
	&&	mkdir	/etc/telegraf \
	&&	mv /etc/telegraf.conf /etc/telegraf/telegraf.conf \
	&&	sed -i 's|.*  hostname = "".*|  hostname = "nginx"|' /etc/telegraf/telegraf.conf \
	&&	sed -i 's|.*  # urls = \["http://127.0.0.1:8086"\].*|  urls = \["http://influxdb:8086"\]|' /etc/telegraf/telegraf.conf \
	&&	sed -i 's|^  # database = "telegraf"|  database = "influxdb"|' /etc/telegraf/telegraf.conf

RUN		apk add openssl
RUN		echo -e "MA\nKH\nKHOURIBGA\n1337Ltd\nOCP\nOCP SA\nft_services@1337.ma\n" | openssl req \
	-x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key \
	-out /etc/ssl/certs/nginx-selfsigned.crt >/dev/null 2>&1

# nginx config
RUN		mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig
RUN		mv /tmp/nginx.conf /etc/nginx/nginx.conf
RUN		echo "<h1> HELLO NGINX </h1>" > www/index.html

#ssh config
RUN		apk add openssh \
	&&	rc-update add sshd \
	&&	echo -e "admin\nadmin" | adduser 'sshuser'

EXPOSE	80 443 22

CMD	./tmp/openrc.sh 
#&& nginx -g 'daemon off;' && tail -f /dev/null
