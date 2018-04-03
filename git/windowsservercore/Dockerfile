# escape=`
FROM microsoft/windowsservercore AS installer
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV GIT_VERSION="2.16.3" `
	GIT_RELEASE_NUMBER="1" `
    GIT_DOWNLOAD_SHA256="74724a54a456be73df94a4ea44a62bee9b2ff00baafda2936bf5b4e61c79209d"

RUN [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; `
    Invoke-WebRequest -OutFile git.zip -Uri "https://github.com/git-for-windows/git/releases/download/v$($env:GIT_VERSION).windows.$($env:GIT_RELEASE_NUMBER)/MinGit-$($env:GIT_VERSION)-64-bit.zip"; `
	if ((Get-FileHash git.zip -Algorithm sha256).Hash -ne $env:GIT_DOWNLOAD_SHA256) {exit 1}; `
	Expand-Archive -Path git.zip -DestinationPath C:\git; `
	Remove-Item git.zip -Force

# Git
FROM microsoft/windowsservercore:ltsc2016
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

ENV GIT_PATH="C:\git\cmd;C:\git\mingw64\bin;C:\git\usr\bin;"

RUN $env:PATH = $env:GIT_PATH + $env:PATH; `
	[Environment]::SetEnvironmentVariable('PATH', $env:PATH, [EnvironmentVariableTarget]::Machine)

WORKDIR C:\git
COPY --from=installer C:\git .