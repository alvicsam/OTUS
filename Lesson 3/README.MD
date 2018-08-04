Уменьшил / раздел так:

Грузимся с livecd, ФС не монтируем
vgscan
vgchange -ay
e2fsck -f /dev/mapper/centos-root
resize2fs -p /dev/mapper/centos-root 8G
lvreduce -L 8G /dev/mapper/centos-root
