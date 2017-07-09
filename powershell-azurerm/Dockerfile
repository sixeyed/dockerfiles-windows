# escape=`
FROM microsoft/windowsservercore
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Install-PackageProvider -Name NuGet -RequiredVersion 2.8.5.201 -Force; `
    Install-Module AzureRM -RequiredVersion 4.1.0 -Force; `
    Import-Module AzureRM

ENTRYPOINT ["powershell"]