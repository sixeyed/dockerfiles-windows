# escape=`
FROM microsoft/windowsservercore:10.0.14393.1198
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV DOCKER_VERSION="17.05.0-ce" `
    DOCKER_PATH="C:\docker;"

RUN Invoke-WebRequest -UseBasicParsing -OutFile 'docker.zip' -Uri "https://get.docker.com/builds/Windows/x86_64/docker-$($env:DOCKER_VERSION).zip"; `
	Expand-Archive -Path 'docker.zip' -DestinationPath C:\ -Force; `
	Remove-Item 'docker.zip'; `
	$env:PATH = $env:DOCKER_PATH + $env:PATH; `
	[Environment]::SetEnvironmentVariable('PATH', $env:PATH, [EnvironmentVariableTarget]::Machine)