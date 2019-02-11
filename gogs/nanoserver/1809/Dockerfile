#escape=`
FROM mcr.microsoft.com/windows/servercore:ltsc2019 as installer
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ARG GOGS_VERSION="0.11.66"
ARG GOGS_PATH="C:\gogs"

#RUN $url = "https://cdn.gogs.io/$($env:GOGS_VERSION)/gogs_$($env:GOGS_VERSION)_windows_amd64.zip"; `
RUN Write-Host "Downloading: $($env:GOGS_VERSION)"; `
	Invoke-WebRequest -Uri "https://cdn.gogs.io/0.11.66/gogs_0.11.66_windows_amd64.zip" -OutFile 'gogs.zip';

RUN Write-Host 'Expanding ...'; `
	Expand-Archive gogs.zip -DestinationPath C:\;

# gogs
FROM mcr.microsoft.com/windows/nanoserver:1809

ARG GOGS_VERSION="0.11.66"
ARG GOGS_PATH="C:\gogs"

ENV GOGS_VERSION=${GOGS_VERSION} `
    GOGS_PATH=${GOGS_PATH} `
    GIT_PATH="C:\git"
    
EXPOSE 3000
VOLUME C:\data C:\logs C:\repositories
CMD ["gogs", "web"]

WORKDIR C:\git
COPY --from=sixeyed/git:2.17.1-windowsservercore-1809 ${GIT_PATH} ${GIT_PATH}

USER ContainerAdministrator
RUN setx /M PATH "%GIT_PATH%\cmd;%GIT_PATH%\mingw64\bin;%GIT_PATH%\usr\bin;%PATH%"

WORKDIR ${GOGS_PATH}
COPY app.ini ./custom/conf/app.ini
COPY --from=installer ${GOGS_PATH} .