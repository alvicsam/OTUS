1. Был установлен сервер freeipa с именем ipaserver.hone.local  

2. Playboock выложен на github.  
Для применения на своей системе необходимо сконфигурировать дефолтные переменные в ipaclient/defaults/main.yml<br>
Пароль администратора задется через ansible-vault в файле ipa_password.yml следуюшим образом:<br>
>ipa_password: SuperP@ssw0rd<br>
