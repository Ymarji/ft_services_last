FROM	alpine:3.12.3

RUN echo "http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories

RUN		wget https://dl.grafana.com/oss/release/grafana-7.3.7.linux-amd64.tar.gz \
	&&	tar -zxvf grafana-7.3.7.linux-amd64.tar.gz \
	&&	mv -f grafana-7.3.7 /usr/share/grafana \
	&&	apk add libc6-compat

#install telegraf
RUN		echo "http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
	&&	apk add telegraf \
	&&	mkdir	/etc/telegraf \
	&&	mv /etc/telegraf.conf /etc/telegraf/telegraf.conf \
	&&	sed -i 's|.*  hostname = "".*|  hostname = "grafana"|' /etc/telegraf/telegraf.conf \
	&&	sed -i 's|.*  # urls = \["http://127.0.0.1:8086"\].*|  urls = \["http://influxdb:8086"\]|' /etc/telegraf/telegraf.conf \
	&&	sed -i 's|^  # database = "telegraf"|  database = "influxdb"|' /etc/telegraf/telegraf.conf

COPY	srcs /tmp
RUN		rm -rf /usr/share/grafana/data/grafana.db 
ADD		./srcs/grafana.db /usr/share/grafana/data/

EXPOSE 	3000
ENTRYPOINT /tmp/run.sh
