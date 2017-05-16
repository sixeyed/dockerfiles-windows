# escape=`
FROM microsoft/aspnet:windowsservercore-10.0.14393.1198
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV BONOBO_VERSION="6_1_0" `
    BONOBO_PATH="C:\bonobo\Bonobo.Git.Server" `
    DATA_PATH="C:\data"

VOLUME ${DATA_PATH}

RUN Invoke-WebRequest "https://bonobogitserver.com/resources/releases/$($env:BONOBO_VERSION).zip" -OutFile 'bonobo.zip' -UseBasicParsing; `
    Expand-Archive bonobo.zip; `
    Remove-Item bonobo.zip

RUN Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\DOS Devices' -Name 'G:' -Value "\??\$($env:DATA_PATH)" -Type String; `
    $file = $env:BONOBO_PATH + '\Web.config'; `
    [xml]$config = Get-Content $file; `
    $repoNode = $config.configuration.appSettings.add | where {$_.key -eq 'DefaultRepositoriesDirectory'}; `
    $repoNode.value = 'G:\repositories'; `
    $dbNode = $config.configuration.connectionStrings.add | where {$_.name -eq 'BonoboGitServerContext'}; `
    $dbNode.connectionString = 'Data Source=G:\Bonobo.Git.Server.db;BinaryGUID=False;'; `
    $config.Save($file)

RUN New-WebApplication -Name Bonobo.Git.Server -Site 'Default Web Site' -PhysicalPath $env:BONOBO_PATH

COPY . .

RUN $path = $env:BONOBO_PATH + '\App_Data'; `
    .\Set-OwnerAcl.ps1 -Path $path -Owner 'BUILTIN\IIS_IUSRS'