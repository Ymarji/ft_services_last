FROM	alpine:3.12.3

VOLUME	["/sys/fs/cgroup"]

# install and update
RUN		apk update
RUN		apk add mariadb mariadb-common mariadb-client openrc \
		&& rc-status && touch /run/openrc/softlevel

#install telegraf
RUN		echo "http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
	&&	apk add telegraf \
	&&	mkdir	/etc/telegraf \
	&&	mv /etc/telegraf.conf /etc/telegraf/telegraf.conf \
	&&	sed -i 's|.*  hostname = "".*|  hostname = "mysql"|' /etc/telegraf/telegraf.conf \
	&&	sed -i 's|.*  # urls = \["http://127.0.0.1:8086"\].*|  urls = \["http://influxdb:8086"\]|' /etc/telegraf/telegraf.conf \
	&&	sed -i 's|^  # database = "telegraf"|  database = "influxdb"|' /etc/telegraf/telegraf.conf

COPY	src /tmp
CMD		./tmp/run.sh && tail -f /dev/null