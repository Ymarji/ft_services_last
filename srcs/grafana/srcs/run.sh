

telegraf &

./usr/share/grafana/bin/grafana-server -homepath /usr/share/grafana/ &
sleep 3
while true;
do
	if ! pgrep telegraf >/dev/null 2>&1 ; then
		echo "telegraf service is down !"
		echo "Quitting.."
		exit 1
	else
		echo "telegraf is up!"
	fi
	if ! pgrep ./usr/share/grafana/bin/grafana-server >/dev/null 2>&1 ; then
		echo "grafana service is down !"
		echo "Quitting.."
		exit 1
	else
		echo "grafana is up!"
	fi
	sleep 2
done