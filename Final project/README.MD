### Краткое описание

Лабораторный стенд состоит из шести вм: 2 фронтенда (fe1,fe2), 3 бд (db1,db2,db3), вм для логов и бекапов (bkplog).
После запуска вм и ansible-playbook получаем развернутый wordpress в отказоустойчивой конфигурации, доступный по адресу http://192.168.1.100.
SeLinux и firewalld включены.

### Запуск

```bash
vagrant up
cd provisioning
ansible-playbook playbook.yml
```

### Адресация

192.168.1.102	bkplog
192.168.1.103	fe1
192.168.1.104	fe2
192.168.1.105	db1
192.168.1.106	db2
192.168.1.107	db3

### Фронтенды

На frontend используются следующие технологии: nginx, php-fpm, keepalived, lsyncd, mysql-router
Между двумя fe общий адрес 192.168.1.100 (обеспечивается keepalived).
Директория с wordpress между fe нодами синхронизируется с помощью lsyncd.
Подключение к базе осуществляется через mysql-router - установлен на каждой ноде и балансирует запросы к серверам БД (round-robin).

### База данных

На вм db1,db2,db3 разворачивается Mysql Multi-Primary Group Replication.
Для того, чтобы ansible-роль была идемпотентна в host_vars/db*.yml есть параметр mysql_init. При первичной настройке он должен быть true.
После завершения настройки кластера его необходимо переключить в false, чтобы при повторном запуске ansible-playbook не произошла переинициализация хостов.
Также после успешной первичной настройки необходимо добавить параметр `mysql_gr_start_on_boot: "on"` в файл переменных host_vars/db*.yml и запустить
`ansible-playbook playbook.yml --tags mysql-set-config-wor`. Необходимо это для того, чтобы при перезапуске ноды, она автоматически присоединялась к mgr.
Если оставить off, то после перезапуска ноды необходимо будет запустить репликацию вручную:

```bash
vagrant ssh db2
sudo -i
mysql -u root
START GROUP_REPLICATION;
```

Проверка кластера:

```bash
$ vagrant ssh db1
[vagrant@db1 ~]$ sudo -i
[root@db1 ~]# mysql -u root

mysql> SELECT * FROM performance_schema.replication_group_members;
+---------------------------+--------------------------------------+-------------+-------------+--------------+-------------+----------------+
| CHANNEL_NAME              | MEMBER_ID                            | MEMBER_HOST | MEMBER_PORT | MEMBER_STATE | MEMBER_ROLE | MEMBER_VERSION |
+---------------------------+--------------------------------------+-------------+-------------+--------------+-------------+----------------+
| group_replication_applier | 0c478659-134b-11e9-8a34-525400c9c704 | db1         |        3306 | ONLINE       | PRIMARY     | 8.0.13         |
| group_replication_applier | b6f6161a-134b-11e9-9f0b-525400c9c704 | db2         |        3306 | ONLINE       | PRIMARY     | 8.0.13         |
| group_replication_applier | b7485035-134b-11e9-9d15-525400c9c704 | db3         |        3306 | ONLINE       | PRIMARY     | 8.0.13         |
+---------------------------+--------------------------------------+-------------+-------------+--------------+-------------+----------------+
3 rows in set (0.01 sec)

mysql> 

```

### Резервное копирование

На fe1 копия сайта tar'ом упаковывается в /home/bkp/wp.tar.gz
На db1 снимается дамп c помощью mysqldump базы wordpress в /home/bkp/wp.sql
ВМ bkplog забирает эти файлы к себе по крону в /home/bkp
Всё остальное можно восстановить с помощью ансибл.

### Логирование:

Все логи собираются на вм bkplog:/var/log/remote