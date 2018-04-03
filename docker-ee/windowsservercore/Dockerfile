# escape=`
FROM microsoft/windowsservercore AS installer
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV DOCKER_VERSION="17.06.2-ee-7" `
    DOCKER_PATH="C:\Program Files\docker"

RUN Install-PackageProvider nuget -force; `
    Install-Module DockerProvider -Force; `
	Install-Package Docker -RequiredVersion $env:DOCKER_VERSION -ProviderName DockerProvider -Force

ENV DOCKER_COMPOSE_VERSION="1.20.1"

RUN [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; `
    Invoke-WebRequest "https://github.com/docker/compose/releases/download/$($env:DOCKER_COMPOSE_VERSION)/docker-compose-Windows-x86_64.exe.sha256" -OutFile 'docker-compose.exe.sha256' -UseBasicParsing; `
    $env:DOCKER_COMPOSE_SHA256 = Get-Content -Raw docker-compose.exe.sha256; `
    Invoke-WebRequest -UseBasicParsing -OutFile 'docker-compose.exe' `
	 -Uri "https://github.com/docker/compose/releases/download/$($env:DOCKER_COMPOSE_VERSION)/docker-compose-Windows-x86_64.exe"; `
	if ((Get-FileHash docker-compose.exe -Algorithm sha256).Hash.ToLower().Trim() -ne $env:DOCKER_COMPOSE_SHA256.ToLower().Trim()) {exit 1} ;`
	Move-Item 'docker-compose.exe' $env:DOCKER_PATH

# Docker
FROM microsoft/windowsservercore:ltsc2016
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

ENV DOCKER_PATH="C:\Program Files\docker"

RUN $env:PATH = $env:DOCKER_PATH + ';' + $env:PATH; `
	[Environment]::SetEnvironmentVariable('PATH', $env:PATH, [EnvironmentVariableTarget]::Machine)

COPY --from=installer ["C:\\Program Files\\docker", "C:\\Program Files\\docker"]