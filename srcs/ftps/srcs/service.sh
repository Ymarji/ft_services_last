openrc default

rc-service telegraf start
sleep 2

# service telegraf start
telegraf &

sleep 3
while true;
do
	if ! pgrep vsftpd >/dev/null 2>&1 ; then
		echo "vsftpd service is down !"
		echo "Quitting.."
		exit 1
	else
		echo "vsftpd is up!"
	fi
	if ! pgrep telegraf >/dev/null 2>&1 ; then
		echo "telegraf service is down !"
		echo "Quitting.."
		exit 1
	else
		echo "telegraf is up!"
	fi
	sleep 2
done