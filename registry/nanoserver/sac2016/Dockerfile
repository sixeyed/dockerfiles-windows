# escape=`
FROM golang:1.10-windowsservercore-ltsc2016 AS builder
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ARG REGISTRY_VERSION="v2.6.2"

WORKDIR C:\gopath\src\github.com\docker

RUN git clone https://github.com/docker/distribution.git; `
    cd distribution; `
    git checkout $env:REGISTRY_VERSION; `
    go build -o C:\out\registry.exe .\cmd\registry

# Registry
FROM microsoft/nanoserver:sac2016
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

ENV DATA_PATH="C:\data" `
    REGISTRY_STORAGE_FILESYSTEM_ROOTDIRECTORY="G:\\"

RUN Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\DOS Devices' -Name 'G:' -Value "\??\$($env:DATA_PATH)" -Type String

VOLUME ${DATA_PATH}
EXPOSE 5000

WORKDIR C:\registry
CMD ["registry", "serve", "config.yml"]

COPY --from=builder C:\out\registry.exe .
COPY --from=builder C:\gopath\src\github.com\docker\distribution\cmd\registry\config-example.yml .\config.yml