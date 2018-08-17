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

### Задание 3 (файлы в подкаталоге 3)

Файлы .service кладем в /etc/systemd/system <br>
Файлы .conf кладем в /etc/nginx <br>
Сделать <br>
>systemctl daemon-reload<br>
>systemctl enable nginx@site1<br>
>systemctl enable nginx@site2<br>
>systemctl enable nginx@site3<br>
>systemctl start nginx@site1<br>
>systemctl start nginx@site2<br>
>systemctl start nginx@site3<br>
