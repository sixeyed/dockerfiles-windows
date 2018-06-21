# escape=`
FROM microsoft/windowsservercore:ltsc2016 AS installer
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ARG GIT_VERSION="2.17.1"
ARG GIT_RELEASE_NUMBER="2"
ARG GIT_DOWNLOAD_SHA256="52e611a411cd58eaaab8218bb917cb4410b0c5733f234be6e581c6a9821b30ea"

RUN Write-Host "Downloading Git version: $($env:GIT_VERSION), release: $($env:GIT_RELEASE_NUMBER)"; `
	[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; `
    Invoke-WebRequest -OutFile git.zip -Uri "https://github.com/git-for-windows/git/releases/download/v$($env:GIT_VERSION).windows.$($env:GIT_RELEASE_NUMBER)/MinGit-$($env:GIT_VERSION).$($env:GIT_RELEASE_NUMBER)-64-bit.zip"

RUN if ((Get-FileHash git.zip -Algorithm sha256).Hash -ne $env:GIT_DOWNLOAD_SHA256) {exit 1}; `
	Expand-Archive -Path git.zip -DestinationPath C:\git; `
	Remove-Item git.zip -Force

# Git
FROM microsoft/windowsservercore:ltsc2016
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

ARG GIT_VERSION="2.17.1"
ENV GIT_VERSION=${GIT_VERSION} `
    GIT_PATH="C:\git\cmd;C:\git\mingw64\bin;C:\git\usr\bin;" 

RUN $env:PATH = $env:GIT_PATH + $env:PATH; `
	[Environment]::SetEnvironmentVariable('PATH', $env:PATH, [EnvironmentVariableTarget]::Machine)

WORKDIR C:\git
COPY --from=installer C:\git .