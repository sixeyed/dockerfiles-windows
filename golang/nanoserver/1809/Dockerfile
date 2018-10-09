#escape=`
FROM mcr.microsoft.com/windows/servercore:1809 as installer
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ARG GOLANG_VERSION="1.11.1"
ARG GOLANG_SHA256="230a08d4260ded9d769f072512a49bffe8bfaff8323e839c2db7cf7c9c788130"
ARG GO_PATH="C:\go"
ARG GOPATH="C:\gopath"

RUN $url = ('https://golang.org/dl/go{0}.windows-amd64.zip' -f $env:GOLANG_VERSION); `
	Write-Host ('Downloading {0} ...' -f $url); `
	Invoke-WebRequest -Uri $url -OutFile 'go.zip';

RUN if ((Get-FileHash go.zip -Algorithm sha256).Hash -ne $($env:GOLANG_SHA256)) { `
		Write-Host 'SHA256 validation FAILED!'; `
		exit 1; `
	}; `
	Write-Host 'Expanding ...'; `
	Expand-Archive go.zip -DestinationPath C:\;

# golang
FROM mcr.microsoft.com/windows/nanoserver:1809

ARG GOLANG_VERSION="1.11.1"
ARG GOLANG_SHA256="230a08d4260ded9d769f072512a49bffe8bfaff8323e839c2db7cf7c9c788130"
ARG GO_PATH="C:\go"
ARG GOPATH="C:\gopath"

ENV GO_PATH=${GO_PATH}
ENV GIT_PATH="C:\git"
ENV GOPATH=${GOPATH}
WORKDIR ${GOPATH}

USER ContainerAdministrator
RUN setx /M PATH "%GIT_PATH%\cmd;%GIT_PATH%\mingw64\bin;%GIT_PATH%\usr\bin;%GO_PATH%\bin;%GOPATH%\bin;%PATH%"

COPY --from=sixeyed/git:2.17.1-windowsservercore-1809 ${GIT_PATH} ${GIT_PATH}
COPY --from=installer ${GO_PATH} ${GO_PATH}