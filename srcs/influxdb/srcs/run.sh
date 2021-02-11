# /usr/sbin/influxd -config /etc/influxdb.conf
rc-service influxdb start
sleep 2
# rc-service telegraf start
# sleep 2
# service telegraf start
telegraf &
# (telegraf &> /dev/null ) &
sleep 3
while true;
do
	sleep 2
done