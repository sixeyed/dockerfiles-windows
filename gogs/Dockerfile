# escape=`
FROM microsoft/windowsservercore
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Install-PackageProvider -Name chocolatey -Force; `
    Install-Package -Name git -Provider chocolatey -Force; `
    Install-Package -Name openssh -Provider chocolatey -Force

EXPOSE 22 3000
VOLUME c:/gogs/data c:/gogs/logs

WORKDIR c:/gogs
COPY ./gogs/ .

CMD ["gogs", "web"]