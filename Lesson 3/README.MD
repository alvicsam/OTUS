#### Уменьшил / раздел так:<br>

Грузимся с livecd, ФС не монтируем <br>
vgscan <br>
vgchange -ay <br>
e2fsck -f /dev/mapper/centos-root<br>
resize2fs -p /dev/mapper/centos-root 8G <br>
lvreduce -L 8G /dev/mapper/centos-root <br>

#### В случае xfs делал так: <br>

Добавил временный диск для данных, загрузился с livecd, ФС не монтировал <br>
Сканируем lvm <br>
> vgscan <br>
> vgchange -ay <br>

Создал директории для рута, бекапа, смонтировал рут <br>
> mkdir /mnt/root <br>
> mkdir /mnt/bkp <br>
>mount /dev/mapper/centos-root /mnt/root <br>

С помощью fdisk создал раздел /dev/sdb1, сделал на нём ФС, примонтировал <br>
> mkfs.ext4 /dev/sdb1 <br>
> mount /dev/sdb1 /mnt/bkp <br>
> xfsdump -f /mnt/backup/rootbkp.img /mnt/root <br>

Отмонитровал root, снес lvm раздел и создал его уменьшенным
>umount /mnt/root <br>
>lvremove /dev/mapper/centos-root <br>
>lvcreate -L 8G -n root centos <br>

Делаем ФС, монтируем и восстанавливаем данные из бекапа
>mkfs.xfs /dev/mapper/centos-root <br>
>mount /dev/mapper/centos-root /mnt/root <br>
>xfsrestore -f /mnt/backup/rootbkp.img /mnt/root <br>
