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
