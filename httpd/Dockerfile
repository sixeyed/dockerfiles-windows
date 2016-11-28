# escape=`
FROM microsoft/windowsservercore
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

ENV HTTPD_VERSION 2.4.23
WORKDIR c:/setup

# VS 2015 C++ redist
RUN iwr -outfile vc_redist.x64.exe 'https://download.microsoft.com/download/6/A/A/6AA4EDFF-645B-48C5-81CC-ED5963AEAD48/vc_redist.x64.exe'; `
    Start-Process .\vc_redist.x64.exe -ArgumentList '/install /passive /norestart' -Wait; `
    rm vc_redist.x64.exe

# HTTPD
RUN Add-Type -AssemblyName System.IO.Compression.FileSystem ; `
    iwr -outfile httpd.zip "http://www.apachelounge.com/download/VC14/binaries/httpd-$($env:HTTPD_VERSION)-win64-VC14.zip"; `
    [System.IO.Compression.ZipFile]::ExtractToDirectory('httpd.zip', 'c:\'); `
    rm httpd.zip

WORKDIR c:/Apache24/bin