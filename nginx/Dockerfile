# escape=`
FROM microsoft/windowsservercore
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

EXPOSE 80 443
ENV NGINX_VERSION 1.11.6

RUN Add-Type -AssemblyName System.IO.Compression.FileSystem ; `
    iwr -outfile nginx.zip "http://nginx.org/download/nginx-$($env:NGINX_VERSION).zip; `
    [System.IO.Compression.ZipFile]::ExtractToDirectory('nginx.zip', 'c:\'); `
    Rename-Item "nginx-$($env:NGINX_VERSION)" nginx; `
    rm nginx.zip

WORKDIR c:/nginx
COPY nginx.conf ./conf/

CMD .\nginx