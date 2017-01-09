# escape=`
FROM microsoft/nanoserver
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

ENV NATS_VERSION="v0.9.4"
WORKDIR c:/setup

RUN iwr -outfile gnatsd.zip "https://github.com/nats-io/gnatsd/releases/download/$($env:NATS_VERSION)/gnatsd-$($env:NATS_VERSION)-windows-amd64.zip"; `
    [System.IO.Compression.ZipFile]::ExtractToDirectory('gnatsd.zip', 'c:\'); `
    mv "c:\gnatsd-$($env:NATS_VERSION)-windows-amd64" 'c:\gnatsd'; `
    rm gnatsd.zip

EXPOSE 4222 8222
WORKDIR c:/gnatsd
ADD https://raw.githubusercontent.com/nats-io/nats-docker/b2c678c7bcc6bc8d68fb33cb1f169f4b66db308d/gnatsd.conf .

ENTRYPOINT ["gnatsd"]
CMD ["-c", "gnatsd.conf"]