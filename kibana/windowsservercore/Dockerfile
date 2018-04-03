# escape=`
FROM microsoft/windowsservercore:ltsc2016 AS downloader
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV KIBANA_VERSION="5.6.0" `
    KIBANA_HOME="C:\kibana"

RUN Invoke-WebRequest "https://artifacts.elastic.co/downloads/kibana/kibana-$($env:KIBANA_VERSION)-windows-x86.zip.sha1" -OutFile 'kibana.zip.sha1' -UseBasicParsing; `
    $env:KIBANA_SHA1 = Get-Content -Raw kibana.zip.sha1; `
    Invoke-WebRequest "https://artifacts.elastic.co/downloads/kibana/kibana-$($env:KIBANA_VERSION)-windows-x86.zip" -OutFile 'kibana.zip' -UseBasicParsing; `
    if ((Get-FileHash kibana.zip -Algorithm sha1).Hash.ToLower() -ne $env:KIBANA_SHA1) {exit 1}; `
    Expand-Archive kibana.zip -DestinationPath C:\; `
    Move-Item c:/kibana-$($env:KIBANA_VERSION)-windows-x86 $env:KIBANA_HOME;

# Kibana
FROM microsoft/windowsservercore:ltsc2016
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

ENV KIBANA_VERSION="5.6.0" `
    KIBANA_HOME="C:\kibana"

EXPOSE 5601
ENTRYPOINT ["powershell"]
CMD ["./init.ps1"]

WORKDIR C:/kibana
COPY init.ps1 .
COPY --from=downloader C:\kibana\ .

# Default configuration for host & Elasticsearch URL
RUN (Get-Content ./config/kibana.yml) -replace '#server.host: \"localhost\"', 'server.host: \"0.0.0.0\"' | Set-Content ./config/kibana.yml; `
    (Get-Content ./config/kibana.yml) -replace '#elasticsearch.url: \"http://localhost:9200\"', 'elasticsearch.url: \"http://elasticsearch:9200\"' | Set-Content ./config/kibana.yml

HEALTHCHECK --start-period=30s --interval=10s --retries=5 `
 CMD powershell -command `
    try { `
     $response = iwr -useb http://localhost:5601/app/kibana; `
     if ($response.StatusCode -eq 200) { return 0} `
     else {return 1}; `
    } catch { return 1 }