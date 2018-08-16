### Задание 1 (файлы в подкаталоге 1)

Необходимо положить файлы по следующим путям: <br>
myservice.sh		/root<br>
myserviceconfig		/etc/sysconfig<br>
myservice.service	/etc/systemd/system<br>
myservice.timer		/etc/systemd/system<br>
Сделать <br>
>systemctl daemon-reload<br>
>systemctl enable myservice.timer<br>
>systemctl enable myservice.service<br>
>systemctl start myservice.timer<br>
>systemctl start myservice.service<br>


Shell-скрипт будет писать количество ключевых слов (если их число будет расти) в файл /var/log/myservice.log. <br>


### Задание 2 (файлы в подкаталоге 2)

Необходимо положить файлы по следующим путям: <br>
spawn-fcgi		/etc/sysconfig<br>
spawn-fcgi.service	/etc/systemd/system<br>
spawn-fcgi.socket		/etc/systemd/system<br>
Сделать <br>
>systemctl daemon-reload<br>
>systemctl enable spawn-fcgi.socket<br>
>systemctl enable spawn-fcgi.service<br>
>systemctl start spawn-fcgi.socket<br>
>systemctl start spawn-fcgi.service<br>
