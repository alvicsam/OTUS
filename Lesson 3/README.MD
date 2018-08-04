Уменьшил / раздел так:<br>

Грузимся с livecd, ФС не монтируем <br>
vgscan <br>
vgchange -ay <br>
e2fsck -f /dev/mapper/centos-root<br>
resize2fs -p /dev/mapper/centos-root 8G <br>
lvreduce -L 8G /dev/mapper/centos-root <br>
