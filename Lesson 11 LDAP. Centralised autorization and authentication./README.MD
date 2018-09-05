1. Был установлен сервер freeipa с именем ipaserver.home.local  

2. Playbook выложен на github.  
Для применения на своей системе необходимо сконфигурировать дефолтные переменные в ipaclient/defaults/main.yml<br>
Идемпотентность обеспечивается проверкой наличия файла /etc/ipa/defaul.conf. Также есть возможность деинсталляции клиента, если у хоста задать переменную `ipa_reconfigure: True` <br>
Пароль администратора задется через ansible-vault в файле ipa_password.yml следуюшим образом:<br>
>ipa_password: SuperP@ssw0rd<br>
