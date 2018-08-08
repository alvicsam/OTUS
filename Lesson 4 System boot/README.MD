## Загрузка без пароля рута <br>

### Способ 1 <br>

Но моменте загрузки grub жмем e <br>
В строке, начинающейся с linux16, вместо ro пишем rw init=/sysroot/bin/sh (в случае образа otuslinux пришлось стереть параметры no_timer_check console=tty0 console=ttyS0,115200n8 net.ifnames=0 biosdevname=0 elevator=noop, потому что один из них мешал, init=/... просто игнорировался) и жмем ctrl+x для продолжения загрузки<br>
chroot /sysroot <br>
passwd, меняем пароль <br>
touch /.autorelabel <br>
reboot -f <br>

### Способ 2 <br>

Но моменте загрузки grub жмем e <br>
В строке, начинающейся с linux16, стираем rhgb quiet, вместо них пишем rd.break enforcing=0 (в случае образа otuslinux пришлось стереть параметры no_timer_check console=tty0 console=ttyS0,115200n8 net.ifnames=0 biosdevname=0 elevator=noop, потому что один из них мешал, rd.break просто игнорировался) и жмем ctrl+x для продолжения загрузки<br>
mount -o remount,rw /sysroot <br>
chroot /sysroot <br>
passwd, меняем пароль <br>
touch /.autorelabel <br>

## Смена имени Volume Group <br>

vgrename VolGroup00 centos <br>
меняем  в /etc/fstab VolGroup00 на centos (у корня и свопа) <br>
меняем  в /etc/default/grub VolGroup00 на centos <br>
меняем  в /boot/grub2/grub.cfg VolGroup00 на centos (sed -i 's/VolGroup00/centos/g' /boot/grub2/grub.cfg) <br>
vgchange -ay <br>
lvchange /dev/centos/LogVol00 --refresh <br>
lvchange /dev/centos/LogVol00 --refresh <br>
cp /boot/initramfs-$(uname -r).img /boot/initramfs-$(uname -r).img.$(date +%m-%d-%H%M%S).bak <br>
mkinitrd -f -v /boot/initramfs-$(uname -r).img $(uname -r) <br>
reboot для проверки <br>

## Установка модуля <br>

Создаем каталог /lib/dracut/modules.d/01mymodule <br>
Там создаем два файла module-setup.sh и run.sh <br>
Чтобы увидеть ascii-изображение отключаем графическую тему при  загрузке plymouth-set-default-theme details <br>
dracut -v -f <br>
reboot