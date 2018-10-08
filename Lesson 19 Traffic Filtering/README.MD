### инициализация

Запустить `vagrant up`

### port knocking

Для проверки knockd необходимо зайти на centralServer и запустить `telnet 192.168.255.1 2222;telnet 192.168.255.1 3333;telnet 192.168.255.1 4444;`

После этого можно будет подключиться по ssh к хосту 192.168.255.1 (inetRouter):

```bash
[vagrant@centralServer ~]$ telnet 192.168.255.1 2222;telnet 192.168.255.1 3333;telnet 192.168.255.1 4444;
Trying 192.168.255.1...
telnet: connect to address 192.168.255.1: Connection refused
Trying 192.168.255.1...
telnet: connect to address 192.168.255.1: Connection refused
Trying 192.168.255.1...
telnet: connect to address 192.168.255.1: Connection refused
[vagrant@centralServer ~]$ telnet 192.168.255.1 22
Trying 192.168.255.1...
Connected to 192.168.255.1.
Escape character is '^]'.
SSH-2.0-OpenSSH_7.4
^]
telnet> quit
Connection closed.
[vagrant@centralServer ~]$ ssh 192.168.255.1
The authenticity of host '192.168.255.1 (192.168.255.1)' can't be established.
ECDSA key fingerprint is SHA256:FmoGHYw3+Lqhe7PLqJDlEIwuzap0Dvt4k5eQzrMsk5U.
ECDSA key fingerprint is MD5:f7:40:d4:c9:e0:d0:00:b1:84:85:1c:29:4c:a6:ee:9b.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '192.168.255.1' (ECDSA) to the list of known hosts.
Last login: Mon Oct  8 12:09:59 2018 from 10.0.2.2
```

Закрыть за собой порт можно командой `telnet 192.168.255.1 4444;telnet 192.168.255.1 3333;telnet 192.168.255.1 2222;`

### Проброс порта

На centralServer поднят nginx. 

На публичном интерфейсе inetRouter2 назначен адрес 192.168.1.100. Настроен проброс порта с 192.168.1.100:8080 на 192.168.254.2:80 (centralServer).

В случае другой адресации сети необходимо изменить адрес в строке `:public => {:ip => '192.168.1.100', :adapter => 2}` секции MACHINES.

Для проверки доступности запустить `curl 192.168.1.100:8080` или открыть в браузере http://192.168.1.100:8080/ (откроется стандартная страница nginx)