## Запрет логина по выходным

`yum install -y pam_script`

Положить файлы blockuser и checkdate.py в каталог /etc/pam-script.d и перейти в него. Сделать файлы исполняемыми.<br>
blockuser - проверяет дату и пользователя (есть ли он в группе admin), checkdate.py - сверяет сегодняшнюю дату переданную в него с элементами списка праздничных дней.<br>
Сделать симлинки
```bash
	ln -s blockuser pam_script_auth
	ln -s blockuser pam_script_acct
	ln -s blockuser pam_script_passwd
	ln -s blockuser pam_script_ses_open
	ln -s blockuser pam_script_ses_close
```

Добавить `account     required      pam_script.so` в system_auth_ac (системный логин) и в password-auth-ac (sshd)

## Дать рута

Создать файл `/etc/security/capability.conf` и вписать в него:<br>
>cap_sys_admin   vagrant <br>
>none *

Добавить в файл /etc/pam.d/su строчку `auth            optional    pam_cap.so`
Залогиниться под пользователем vagrant <br>
Сделать `su vagrant`<br>
В системе сделать capsh --print и убедиться, что у нас есть эти capabilities

