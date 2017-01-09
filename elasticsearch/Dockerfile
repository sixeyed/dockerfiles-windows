# escape=`
FROM microsoft/nanoserver
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

WORKDIR c:/setup

# Zulu - Windows OpenJDK port:
ENV ZULU_VERSION="8.19.0.1" `
    JDK_VERSION="8.0.112" `
    JAVA_HOME="c:\zulu\jre" `
    JAVA_VERSION="8u112"

RUN iwr -outfile zulu.zip "http://cdn.azul.com/zulu/bin/zulu$($env:ZULU_VERSION)-jdk$($env:JDK_VERSION)-win_x64.zip"; `
    [System.IO.Compression.ZipFile]::ExtractToDirectory('zulu.zip', 'c:\'); `
    mv "c:\zulu$($env:ZULU_VERSION)-jdk$($env:JDK_VERSION)-win_x64" 'c:\zulu'; `
    rm zulu.zip

# Elasticsearch
ENV ES_VERSION="5.1.1" `
    ES_HOME="c:\elasticsearch"     

RUN iwr -outfile elasticsearch.zip "https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-$($env:ES_VERSION).zip"; `
    [System.IO.Compression.ZipFile]::ExtractToDirectory('elasticsearch.zip', 'c:\'); `
    mv "c:\elasticsearch-$($env:ES_VERSION)" 'c:\elasticsearch'; `
    rm elasticsearch.zip

WORKDIR c:/elasticsearch
COPY config ./config

EXPOSE 9200 9300
VOLUME c:/data

CMD ".\bin\elasticsearch.bat"