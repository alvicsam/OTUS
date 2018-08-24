### Пакет mylogparser

Для установки пакета создать файл /etc/yum.repo.d/samusev.repo со следующим содержанием: <br>

>[samusev.info] <br>
>name=Otus Lesson Repo<br>
>baseurl=https://yum.samusev.info/centos/7/x86_64/<br>
>enabled=1<br>
>gpgcheck=0<br>

Установить пакет:<br>
yum install mylogparser
