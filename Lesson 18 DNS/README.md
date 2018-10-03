# Split-DNS

dns-master: 192.168.50.10<br>
dns-slave: 192.168.50.11<br>
dns-client1: 192.168.50.15<br>
dns-client2: 192.168.50.16<br>

Проверка:

Запустить `vagrant up`

На client1:

```bash
vagrant ssh client
[vagrant@client ~]$ dig @192.168.50.10 web1.dns.lab +short
192.168.50.15
[vagrant@client ~]$ dig @192.168.50.10 web2.dns.lab +short
[vagrant@client ~]$ dig @192.168.50.10 www.newdns.lab +short
192.168.50.15
192.168.50.16
[vagrant@client ~]$ dig @192.168.50.11 web1.dns.lab +short
192.168.50.15
[vagrant@client ~]$ dig @192.168.50.11 web2.dns.lab +short
[vagrant@client ~]$ dig @192.168.50.11 www.newdns.lab +short
192.168.50.15
192.168.50.16
```

На client2:

```bash
vagrant ssh client2
[vagrant@client2 ~]$ dig @192.168.50.10 web1.dns.lab +short
192.168.50.15
[vagrant@client2 ~]$ dig @192.168.50.10 web2.dns.lab +short
192.168.50.16
[vagrant@client2 ~]$ dig @192.168.50.11 web1.dns.lab +short
192.168.50.15
[vagrant@client2 ~]$ dig @192.168.50.11 web2.dns.lab +short
192.168.50.16
[vagrant@client2 ~]$ dig @192.168.50.10 www.newdns.lab +short
[vagrant@client2 ~]$
```
