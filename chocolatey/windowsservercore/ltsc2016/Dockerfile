# escape=`
FROM microsoft/windowsservercore:10.0.14393.2007
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ARG chocolateyVersion='0.10.11'

RUN Invoke-WebRequest -UseBasicParsing https://chocolatey.org/install.ps1 | Invoke-Expression