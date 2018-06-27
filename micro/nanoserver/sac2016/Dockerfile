# escape=`
FROM microsoft/nanoserver:sac2016 AS installer
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ARG MICRO_VERSION="1.4.0"
ARG MICRO_PATH="C:\micro"
ENV MICRO_PATH=${MICRO_PATH}

RUN Write-Host "Downloading Micro version: $env:MICRO_VERSION"; `
    Invoke-WebRequest -OutFile micro.zip -UseBasicParsing "https://github.com/zyedidia/micro/releases/download/v$($env:MICRO_VERSION)/micro-$($env:MICRO_VERSION)-win64.zip";

RUN Expand-Archive micro.zip -DestinationPath C:\ ; `
    Rename-Item "C:\micro-$($env:MICRO_VERSION)" $env:MICRO_PATH

# Micro
FROM microsoft/nanoserver:sac2016
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

ARG MICRO_PATH="C:\micro"
ENV MICRO_PATH=${MICRO_PATH}

RUN $env:PATH = $env:MICRO_PATH + ';' + $env:PATH; `
	setx PATH $env:PATH /M

COPY --from=installer ${MICRO_PATH} ${MICRO_PATH}