# explore
ДЗ 4 
переименовывание volume group
изменение VG пути в grub.conf и fstab

Попасть в систему без пароля несколькими способами:

1)при загрузке машины зайти в меню ядра (e) :
поменять ro на rw init=/sysroot/bin/bash
cntrl X
mount -o remount,rw /
chroot /sysroot/


2)при загрузке машины зайти в меню ядра (e) :
Добавить в строку запуска ядра :
rd.break enforcing=0
cntrl X
mount –o remount,rw /sysroot
chroot /sysroot