# escape=`
FROM microsoft/windowsservercore:ltsc2016 AS installer
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ARG GIT_VERSION="2.26.2"
ARG GIT_RELEASE_NUMBER="1"
ARG GIT_DOWNLOAD_SHA256="2dfbb1c46547c70179442a92b8593d592292b8bce2fd02ac4e0051a8072dde8f"

RUN Write-Host "Downloading Git version: $($env:GIT_VERSION), release: $($env:GIT_RELEASE_NUMBER)"; `
	[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; `
    Invoke-WebRequest -OutFile git.zip -Uri "https://github.com/git-for-windows/git/releases/download/v$($env:GIT_VERSION).windows.$($env:GIT_RELEASE_NUMBER)/MinGit-$($env:GIT_VERSION)-64-bit.zip"

RUN if ((Get-FileHash git.zip -Algorithm sha256).Hash -ne $env:GIT_DOWNLOAD_SHA256) {exit 1}; `
	Expand-Archive -Path git.zip -DestinationPath C:\git; `
	Remove-Item git.zip -Force

# Git
FROM microsoft/windowsservercore:ltsc2016
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

ARG GIT_VERSION="2.26.2"
ENV GIT_VERSION=${GIT_VERSION} `
    GIT_PATH="C:\git\cmd;C:\git\mingw64\bin;C:\git\usr\bin;" 

RUN $env:PATH = $env:GIT_PATH + $env:PATH; `
	[Environment]::SetEnvironmentVariable('PATH', $env:PATH, [EnvironmentVariableTarget]::Machine)

WORKDIR C:\git
COPY --from=installer C:\git .
