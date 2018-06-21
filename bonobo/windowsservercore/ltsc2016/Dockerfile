# escape=`
FROM microsoft/windowsservercore:ltsc2016 AS installer
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ARG BONOBO_VERSION="6.3.0"
RUN Write-Host "Downloading Bonobo version: $env:BONOBO_VERSION"; `
    Invoke-WebRequest "https://bonobogitserver.com/resources/releases/$($env:BONOBO_VERSION.Replace('.', '_')).zip" -OutFile 'bonobo.zip' -UseBasicParsing; `
    Expand-Archive bonobo.zip C:\bonobo; `
    Remove-Item bonobo.zip -Force

# Bonobo
FROM microsoft/aspnet:4.7.2-windowsservercore-ltsc2016
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

ARG BONOBO_VERSION="6.3.0"
ENV BONOBO_VERSION=${BONOBO_VERSION} `
    BONOBO_PATH="C:\bonobo\Bonobo.Git.Server" `
    DATA_PATH="C:\data"

VOLUME ${DATA_PATH}

RUN New-WebApplication -Name Bonobo.Git.Server -Site 'Default Web Site' -PhysicalPath $env:BONOBO_PATH -Force

COPY --from=installer ${BONOBO_PATH} ${BONOBO_PATH}

RUN Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\DOS Devices' -Name 'G:' -Value "\??\$($env:DATA_PATH)" -Type String; `
    $file = $env:BONOBO_PATH + '\Web.config'; `
    [xml]$config = Get-Content $file; `
    $repoNode = $config.configuration.appSettings.add | where {$_.key -eq 'DefaultRepositoriesDirectory'}; `
    $repoNode.value = 'G:\repositories'; `
    $dbNode = $config.configuration.connectionStrings.add | where {$_.name -eq 'BonoboGitServerContext'}; `
    $dbNode.connectionString = 'Data Source=G:\Bonobo.Git.Server.db;BinaryGUID=False;'; `
    $config.Save($file)

COPY . .

RUN $path = $env:BONOBO_PATH + '\App_Data'; `
    .\Set-OwnerAcl.ps1 -Path $path -Owner 'BUILTIN\IIS_IUSRS'