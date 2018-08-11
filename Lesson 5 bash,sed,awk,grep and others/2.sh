#!/bin/bash

service=nginx

while true; do
    service_status=$(systemctl is-active $service)
    if [ $service_status != "active" ] ;then
	sudo systemctl start $service
	echo "$service has been restarted!" | ssmtp -v -s superadmin@domain.com
    fi
    sleep 1
done
