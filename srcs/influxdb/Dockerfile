FROM	alpine:3.12.3

RUN		apk update \
	&&	apk add openrc

RUN		rc-status \
	&&	touch /run/openrc/softlevel

RUN		apk add influxdb

#install telegraf
RUN		echo "http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
	&&	apk add telegraf \
	&&	mkdir	/etc/telegraf \
	&&	mv /etc/telegraf.conf /etc/telegraf/telegraf.conf \
	&&	sed -i 's|.*  hostname = "".*|  hostname = "influxdb"|' /etc/telegraf/telegraf.conf \
	&&	sed -i 's|.*  # urls = \["http://127.0.0.1:8086"\].*|  urls = \["http://127.0.0.1:8086"\]|' /etc/telegraf/telegraf.conf \
	&&	sed -i 's|^  # database = "telegraf"|  database = "influxdb"|' /etc/telegraf/telegraf.conf
# ADD 	./srcs/telegraf.conf /etc/telegraf/


ADD 	./srcs/run.sh /tmp/run.sh

RUN		chmod +x /tmp/run.sh

cmd		/tmp/run.sh