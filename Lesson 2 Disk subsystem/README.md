### Изменил Vagrantfile следующим образом:
1. Добавил диск sata5
2. Изменил секцию SHELL: <br>
  2.1 Создается массив (RAID5, 5 дисков) <br>
  2.2 Конфиг пишется в /etc/mdadm.conf<br>
  2.3 С помощью parted создается GPT таблица, создаются 5 разделов<br>
  2.4 В цикле создается файловая система на 5 разделах<br>
  2.5 В цикле добавляются строчки в fstab для автомонтирования при загрузке<br>
  2.6 Создаются каталоги для монтирования<br>
  2.8 Монтируются разделы в созданные выше каталоги<br>

### Ломал/чинил массив следующим набором команд:
> mdadm --manage /dev/md0 --fail /dev/sdf <br>
> mdadm --manage /dev/md0 --remove /dev/sdf <br>
> mdadm --zero-superblock /dev/sdf <br>
> mdadm --manage /dev/md0 --add /dev/sdf
