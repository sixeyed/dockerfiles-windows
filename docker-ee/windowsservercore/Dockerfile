# escape=`
FROM microsoft/windowsservercore:10.0.14393.2007
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV DOCKER_VERSION="17.06.2-ee-6" `
    DOCKER_PATH="C:\Program Files\docker"

RUN Install-PackageProvider nuget -force; `
    Install-Module DockerProvider -Force; `
	Install-Package Docker -RequiredVersion $env:DOCKER_VERSION -ProviderName DockerProvider -Force; `
	$env:PATH = $env:DOCKER_PATH + ';' + $env:PATH; `
	[Environment]::SetEnvironmentVariable('PATH', $env:PATH, [EnvironmentVariableTarget]::Machine)

ENV DOCKER_COMPOSE_VERSION="1.18.0"

RUN Invoke-WebRequest -UseBasicParsing -OutFile 'docker-compose.exe' `
	 -Uri "https://github.com/docker/compose/releases/download/$($env:DOCKER_COMPOSE_VERSION)/docker-compose-Windows-x86_64.exe"; `
	Move-Item 'docker-compose.exe' $env:DOCKER_PATH