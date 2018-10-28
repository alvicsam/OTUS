### Инициализация

Запустить `vagrant up`

### Bonding

Для проверки bonding зайти на inetRouter и запустить на нём `ping 192.168.1.2`

В новом окне открыть centralServer и запустить `ip link set eth1 down`

Убедиться, что пинг на inetRouter не пропал.

### VLANs

Зайти на testClient1 и запустить `ping 10.10.10.1`. Убедиться, что пинг проходит.

Зайти на testClient2 и запустить `ping 10.10.10.1`. Убедиться, что пинг проходит.