# escape=`
FROM microsoft/nanoserver
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

WORKDIR c:/setup

# Node (Kibana ships with an x86 version that doesn't work in Nano)
ENV NODE_VERSION="6.9.2"
RUN mkdir c:\node; `
    iwr -outfile c:\node\node.exe "https://nodejs.org/dist/v$($env:NODE_VERSION)/win-x64/node.exe"

# Kibana
ENV KIBANA_VERSION="5.1.1"
RUN iwr -outfile kibana.zip "https://artifacts.elastic.co/downloads/kibana/kibana-$($env:KIBANA_VERSION)-windows-x86.zip"; `
    [System.IO.Compression.ZipFile]::ExtractToDirectory('kibana.zip', 'c:\'); `
    mv "c:\kibana-$($env:KIBANA_VERSION)-windows-x86" 'c:\kibana'; `
    rm kibana.zip

EXPOSE 5601
WORKDIR c:/kibana
COPY config ./config
COPY docker-entrypoint.ps1 /

CMD /docker-entrypoint.ps1