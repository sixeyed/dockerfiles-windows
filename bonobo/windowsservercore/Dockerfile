# escape=`
FROM microsoft/aspnet:windowsservercore
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

ENV BONOBO_VERSION="6_1_0" `
    BONOBO_PATH="C:\bonobo\Bonobo.Git.Server" `
    REPOSITORIES_PATH="C:\Repositories"

VOLUME C:\Repositories

RUN Invoke-WebRequest "https://bonobogitserver.com/resources/releases/$($env:BONOBO_VERSION).zip" -OutFile 'bonobo.zip' -UseBasicParsing ; `
    Expand-Archive bonobo.zip



RUN $file = $env:BONOBO_PATH + '\Web.config'; `
    (Get-Content $file) | Foreach-Object { $_ -replace '~\\App_Data\\Repositories', '~\App_Data\Repos' } | Set-Content $file;

RUN New-WebApplication -Name Bonobo.Git.Server -Site 'Default Web Site' -PhysicalPath $env:BONOBO_PATH

COPY *.ps1 /

RUN $path = $env:BONOBO_PATH + '\App_Data'; `
    .\Set-OwnerAcl.ps1 -Path $path -Owner 'BUILTIN\IIS_IUSRS'

VOLUME C:\bonobo\Bonobo.Git.Server\App_Data\Repos

ENTRYPOINT .\bootstrap.ps1
