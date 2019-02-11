# escape=`
FROM sixeyed/chocolatey:windowsservercore-ltsc2019 AS installer
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ARG DOCKER_VERSION="18.06.1"
ARG COMPOSE_VERSION="1.22.0"
ARG DOCKER_PATH="C:\Program Files\docker"

RUN choco install -y --version="$env:DOCKER_VERSION" docker

RUN mkdir $env:DOCKER_PATH; `	
	Move-Item C:\ProgramData\chocolatey\lib\docker\tools\docker.exe $env:DOCKER_PATH

RUN [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; `
    Invoke-WebRequest "https://github.com/docker/compose/releases/download/$($env:COMPOSE_VERSION)/docker-compose-Windows-x86_64.exe.sha256" -OutFile 'docker-compose.exe.sha256' -UseBasicParsing; `
    Invoke-WebRequest "https://github.com/docker/compose/releases/download/$($env:COMPOSE_VERSION)/docker-compose-Windows-x86_64.exe" -OutFile 'docker-compose.exe' -UseBasicParsing;	

RUN $env:DOCKER_COMPOSE_SHA256=$(Get-Content -Raw docker-compose.exe.sha256).Split(' ')[0]; `
	if ((Get-FileHash docker-compose.exe -Algorithm sha256).Hash.ToLower() -ne $env:DOCKER_COMPOSE_SHA256.ToLower()) {exit 1} ;`
	Move-Item 'docker-compose.exe' $env:DOCKER_PATH

# docker-cli
FROM mcr.microsoft.com/windows/servercore:1809
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

ARG DOCKER_PATH="C:\Program Files\docker"
ENV DOCKER_PATH ${DOCKER_PATH}

RUN $env:PATH = $env:DOCKER_PATH + ';' + $env:PATH; `
	[Environment]::SetEnvironmentVariable('PATH', $env:PATH, [EnvironmentVariableTarget]::Machine)

COPY --from=installer ${DOCKER_PATH} ${DOCKER_PATH}