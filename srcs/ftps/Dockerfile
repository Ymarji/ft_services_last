FROM	alpine:3.12.3

RUN		apk update
RUN		apk add vsftpd
RUN		apk add openrc \
	&&	echo -e "1111\n1111" | adduser 'ana'
RUN		apk add openssl \
	&&	echo -e "MA\nKH\nKHOURIBGA\n1337Ltd\nOCP\nOCP SA\nft_services@1337.ma\n" | openssl req \
	-x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/vsftpd.pem -out /etc/ssl/private/vsftpd.pem 
COPY	srcs /tmp
RUN		mv /tmp/vsftpd.conf /etc/vsftpd/vsftpd.conf \
	&&  echo "ana" | tee -a /etc/vsftpd.userlist \
	&& 	echo "pasv_enable=Yes" >> /etc/vsftpd/vsftpd.conf \
	&& 	echo "pasv_max_port=10050" >> /etc/vsftpd/vsftpd.conf \
	&& 	echo "pasv_min_port=10050" >> /etc/vsftpd/vsftpd.conf \
	&& 	echo "pasv_addr_resolve=YES" >> /etc/vsftpd/vsftpd.conf \
	&& 	echo "pasv_address=192.168.99.240" >> /etc/vsftpd/vsftpd.conf

RUN		rc-status && touch /run/openrc/softlevel
RUN		rc-update add vsftpd default

#install telegraf
RUN		echo "http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
	&&	apk add telegraf \
	&&	mkdir	/etc/telegraf \
	&&	mv /etc/telegraf.conf /etc/telegraf/telegraf.conf \
	&&	sed -i 's|.*  hostname = "".*|  hostname = "ftps"|' /etc/telegraf/telegraf.conf \
	&&	sed -i 's|.*  # urls = \["http://127.0.0.1:8086"\].*|  urls = \["http://influxdb:8086"\]|' /etc/telegraf/telegraf.conf \
	&&	sed -i 's|^  # database = "telegraf"|  database = "influxdb"|' /etc/telegraf/telegraf.conf

CMD		./tmp/service.sh