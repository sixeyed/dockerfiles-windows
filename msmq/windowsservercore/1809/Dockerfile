#escape=`
FROM mcr.microsoft.com/windows/servercore:1809
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Install-WindowsFeature MSMQ-Server

EXPOSE 1801 135 2103 2105 3527 2107