@echo off

echo "my-cookie" > c:\Windows\.erlang.cookie
if not exist %RABBITMQ_BASE%\enabled_plugins (
    call c:\rabbitmq\sbin\rabbitmq-plugins.bat enable rabbitmq_management --offline
)

call c:\rabbitmq\sbin\rabbitmq-server.bat