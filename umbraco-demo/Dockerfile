# escape=`
FROM sixeyed/umbraco:7.6.0-windowsservercore-10.0.14393.1066
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Stop-Service w3svc; `
    & cmd.exe /c rd /s /q $env:UMBRACO_ROOT

COPY Umbraco ${UMBRACO_ROOT}
RUN C:\Set-UmbracoAcl.ps1