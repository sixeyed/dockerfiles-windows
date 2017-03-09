# escape=`
FROM microsoft/windowsservercore
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Install-PackageProvider -Name chocolatey -Force; `
    Install-Package -Name git -Provider chocolatey -Force; `
    Install-Package -Name openssh -Provider chocolatey -Force

ENV GOGS_VERSION 0.10.8
RUN Invoke-WebRequest -UseBasicParsing -OutFile gogs.zip -Uri "https://cdn.gogs.io/$($env:GOGS_VERSION)/windows_amd64.zip"; `
    Expand-Archive gogs.zip -DestinationPath C:\; `
    Remove-Item gogs.zip

EXPOSE 22 3000
VOLUME c:/gogs/data c:/gogs/logs c:/repositories

WORKDIR c:/gogs
CMD ["gogs", "web"]