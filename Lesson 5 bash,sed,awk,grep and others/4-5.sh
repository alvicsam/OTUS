#!/bin/bash
#You have to add this to the cron with parameters:
#0 8    * * *   root    bash /path_to_the_script/upd_rep_generator.sh


LOCK=/tmp/cronlock

#checking if the script is already running
if [ -f $LOCK ]; then
    echo "I'll do it next time. Exiting"
    exit 6
fi
touch /tmp/cronlock
trap 'rm -f "$LOCK"; exit $?' INT TERM EXIT
rfile=/home/apt-dater/servers.xml
time sudo -u apt-dater /usr/bin/apt-dater -r > $rfile
#checking if the report file has some data
minimumsize=1
actualsize=$(du -k "$rfile" | cut -f 1)
#generating the report
if [ $actualsize -ge $minimumsize ]; then
    /usr/bin/python3 /root/script/htmlgen.py > /var/www/apt-dater/index.html
else
    exit 0
rm -f /tmp/cronlock
trap - INT TERM EXIT