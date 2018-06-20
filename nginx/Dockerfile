# escape=`
FROM microsoft/windowsservercore:ltsc2016 AS installer
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV NGINX_VERSION="1.15.0"

RUN Invoke-WebRequest -OutFile nginx.zip -UseBasicParsing "http://nginx.org/download/nginx-$($env:NGINX_VERSION).zip"; `
    Expand-Archive nginx.zip -DestinationPath C:\ ; `
    Rename-Item "C:\nginx-$($env:NGINX_VERSION)" C:\nginx;

# NGINX
FROM microsoft/windowsservercore:ltsc2016

EXPOSE 80 443
WORKDIR C:\nginx
CMD "C:\nginx\nginx.exe"

COPY --from=installer C:\nginx\ .