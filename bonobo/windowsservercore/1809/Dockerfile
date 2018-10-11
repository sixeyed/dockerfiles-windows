# escape=`
FROM mcr.microsoft.com/windows/servercore:1809 AS installer
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ARG BONOBO_VERSION="6.3.0"
RUN Write-Host "Downloading Bonobo version: $env:BONOBO_VERSION"; `
    Invoke-WebRequest "https://bonobogitserver.com/resources/releases/$($env:BONOBO_VERSION.Replace('.', '_')).zip" -OutFile 'bonobo.zip' -UseBasicParsing; `
    Expand-Archive bonobo.zip C:\bonobo; `
    Remove-Item bonobo.zip -Force

# Bonobo
FROM sixeyed/aspnet:4.7.2-windowsservercore-1809
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

ARG BONOBO_VERSION="6.3.0"
ENV BONOBO_VERSION=${BONOBO_VERSION} `
    BONOBO_PATH="C:\bonobo\Bonobo.Git.Server" `
    DATA_PATH="C:\data"

VOLUME ${DATA_PATH}

RUN New-WebApplication -Name Bonobo.Git.Server -Site 'Default Web Site' -PhysicalPath $env:BONOBO_PATH -Force

COPY --from=installer ${BONOBO_PATH} ${BONOBO_PATH}

RUN $file = $env:BONOBO_PATH + '\Web.config'; `
    [xml]$config = Get-Content $file; `
    $repoNode = $config.configuration.appSettings.add | where {$_.key -eq 'DefaultRepositoriesDirectory'}; `
    $repoNode.value = 'C:\data\repositories'; `
    $dbNode = $config.configuration.connectionStrings.add | where {$_.name -eq 'BonoboGitServerContext'}; `
    $dbNode.connectionString = 'Data Source=C:\data\Bonobo.Git.Server.db;BinaryGUID=False;'; `
    $config.Save($file)

COPY Set-OwnerAcl.ps1 .

RUN $path = $env:BONOBO_PATH + '\App_Data'; `
    .\Set-OwnerAcl.ps1 -Path $path -Owner 'BUILTIN\IIS_IUSRS'; `
    .\Set-OwnerAcl.ps1 -Path $env:DATA_PATH -Owner 'BUILTIN\IIS_IUSRS'