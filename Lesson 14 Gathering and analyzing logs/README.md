# Logserver and client

### local vagrant

Запустить плейбук.

    $ vagrant up
    $ vagrant provision

### Реализация

#### Auditd

Логи auditd пересылаются с помощью плагина audisp-plugins на локальный сислог, тот пересылает на сислог-сервер и прекращает обработку:

    :programname, isequal, "audispd" {
        *.* @{{ rsyslog_server_ip }}
        stop
    }


Также в audit.rules прописана строчка `-w /etc/nginx -k nginx_watch` для наблюдением за каталогом nginx

Для проверки можно запустить на web команду:

    $ touch /etc/nginx/1 && rm -f /etc/nginx/1
    
#### Nginx

В настройках nginx прописана отправка логов:

    access_log  syslog:server={{ rsyslog_server_ip }};
    error_log  syslog:server={{ rsyslog_server_ip }},tag=nginx_error;

#### Критичные логи

Отправляются в конце конфига rsyslog на web:

    *.* @{{ rsyslog_server_ip }}
