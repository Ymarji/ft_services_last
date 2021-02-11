telegraf &

service nginx start
service sshd start

# rc-service telegraf start
# sleep 2


sleep 3
while true;
do
	if ! pgrep nginx >/dev/null 2>&1 ; then
		echo "Nginx Server is down !"
		echo "Quitting.."
		exit 1
	else
		echo "Nginx is up!"
	fi
	if ! pgrep sshd >/dev/null 2>&1 ; then
		echo "sshd service is down !"
		echo "Quitting.."
		exit 1
	else
		echo "sshd is up!"
	fi
	if ! pgrep telegraf >/dev/null 2>&1 ; then
		echo "telegraf is down !"
		echo "Quitting.."
		exit 1
	else
		echo "telegraf is up!"
	fi
	sleep 2
done