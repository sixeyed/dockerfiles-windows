# escape=`
FROM microsoft/nanoserver
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

RUN iwr -outfile openssl.zip https://indy.fulgan.com/SSL/openssl-1.0.2j-x64_86-win64.zip; `
    [System.IO.Compression.ZipFile]::ExtractToDirectory('openssl.zip', 'c:\openssl')

WORKDIR c:/openssl
COPY openssl.cnf .
ENV OPENSSL_CONF=C:\\openssl\\openssl.cnf

ENTRYPOINT ./openssl