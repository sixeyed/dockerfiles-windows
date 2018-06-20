# escape=`
FROM microsoft/windowsservercore:ltsc2016 AS installer
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ARG DOCKER_VERSION="17.06.2-ee-13"
ARG COMPOSE_VERSION="1.21.2"
ARG DOCKER_PATH="C:\Program Files\docker"

RUN Install-PackageProvider nuget -force; `
    Install-Module DockerMsftProvider -Force; `
	Install-Package Docker -RequiredVersion $env:DOCKER_VERSION -ProviderName DockerMsftProvider -Force

RUN [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; `
    Invoke-WebRequest "https://github.com/docker/compose/releases/download/$($env:COMPOSE_VERSION)/docker-compose-Windows-x86_64.exe.sha256" -OutFile 'docker-compose.exe.sha256' -UseBasicParsing; `
    Invoke-WebRequest "https://github.com/docker/compose/releases/download/$($env:COMPOSE_VERSION)/docker-compose-Windows-x86_64.exe" -OutFile 'docker-compose.exe' -UseBasicParsing;	

RUN $env:DOCKER_COMPOSE_SHA256=$(Get-Content -Raw docker-compose.exe.sha256); `
	if ((Get-FileHash docker-compose.exe -Algorithm sha256).Hash.ToLower().Trim() -ne $env:DOCKER_COMPOSE_SHA256.ToLower().Trim()) {exit 1} ;`
	Move-Item 'docker-compose.exe' $env:DOCKER_PATH

# Docker
FROM microsoft/windowsservercore:ltsc2016
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

ENV DOCKER_VERSION=${DOCKER_VERSION} `
    DOCKER_PATH=${DOCKER_PATH}

RUN $env:PATH = $env:DOCKER_PATH + ';' + $env:PATH; `
	[Environment]::SetEnvironmentVariable('PATH', $env:PATH, [EnvironmentVariableTarget]::Machine)

COPY --from=installer ${DOCKER_PATH} ${DOCKER_PATH}