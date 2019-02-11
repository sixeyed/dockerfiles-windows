#escape=`
FROM mcr.microsoft.com/windows/servercore:ltsc2019 
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# see https://support.microsoft.com/en-us/help/4462262 for latest CU
ARG DOWNLOAD_URL="https://go.microsoft.com/fwlink/?linkid=829176"
ARG CU_DOWNLOAD_URL="https://download.microsoft.com/download/C/4/F/C4F908C9-98ED-4E5F-88D5-7D6A5004AEBD/SQLServer2017-KB4462262-x64.exe"

ENV sa_password="_" `
    attach_dbs="[]" `
    ACCEPT_EULA="_" `
    sa_password_path="C:\ProgramData\Docker\secrets\sa-password"

# Install SQL Server 2017
RUN Invoke-WebRequest -Uri $env:DOWNLOAD_URL -OutFile sqlexpress.exe; `
    Start-Process -Wait -FilePath .\sqlexpress.exe -ArgumentList /qs, /x:setup ; `
    .\setup\setup.exe /q /ACTION=Install /INSTANCENAME=SQLEXPRESS /FEATURES=SQLEngine /UPDATEENABLED=0 /SQLSVCACCOUNT='NT AUTHORITY\System' /SQLSYSADMINACCOUNTS='BUILTIN\ADMINISTRATORS' /TCPENABLED=1 /NPENABLED=0 /IACCEPTSQLSERVERLICENSETERMS ; `
    Remove-Item -Recurse -Force sqlexpress.exe, setup

# TODO - Install latest CU, nned to find out how to do unattended

RUN Stop-Service MSSQL`$SQLEXPRESS ; `
    Set-ItemProperty -path 'HKLM:\software\microsoft\microsoft sql server\mssql14.SQLEXPRESS\mssqlserver\supersocketnetlib\tcp\ipall' -name tcpdynamicports -value '' ; `
    Set-ItemProperty -path 'HKLM:\software\microsoft\microsoft sql server\mssql14.SQLEXPRESS\mssqlserver\supersocketnetlib\tcp\ipall' -name tcpport -value 1433 ; `
    Set-ItemProperty -path 'HKLM:\software\microsoft\microsoft sql server\mssql14.SQLEXPRESS\mssqlserver\' -name LoginMode -value 2 ;

COPY start.ps1 /
CMD .\start -sa_password $env:sa_password -ACCEPT_EULA $env:ACCEPT_EULA -attach_dbs \"$env:attach_dbs\" -Verbose