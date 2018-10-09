# escape=`
FROM sixeyed/golang:1.11.1-nanoserver-1809 AS builder

ARG REGISTRY_VERSION="v2.6.2"

WORKDIR C:\gopath\src\github.com\docker

RUN git clone https://github.com/docker/distribution.git & `
    cd distribution & `
    git checkout %REGISTRY_VERSION% & `
    go build -o C:\out\registry.exe .\cmd\registry

# Registry
FROM mcr.microsoft.com/windows/nanoserver:1809

ENV REGISTRY_STORAGE_FILESYSTEM_ROOTDIRECTORY="C:\data"

VOLUME ${REGISTRY_STORAGE_FILESYSTEM_ROOTDIRECTORY}
EXPOSE 5000

WORKDIR C:\registry
CMD ["registry", "serve", "config.yml"]

COPY --from=builder C:\out\registry.exe .
COPY --from=builder C:\gopath\src\github.com\docker\distribution\cmd\registry\config-example.yml .\config.yml