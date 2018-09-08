# escape=`
FROM microsoft/windowsservercore:ltsc2016 AS downloader
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ARG KIBANA_VERSION="5.6.11"
ENV KIBANA_HOME="C:\kibana" `
    KIBANA_ROOT_URL="https://artifacts.elastic.co/downloads/kibana/kibana"

RUN Invoke-WebRequest "$env:KIBANA_ROOT_URL-$env:KIBANA_VERSION-windows-x86.zip.sha512" -OutFile 'kibana.zip.sha' -UseBasicParsing; `
    $env:KIBANA_SHA = (Get-Content -Raw kibana.zip.sha).Split(' ')[0]; `
    Invoke-WebRequest "$env:KIBANA_ROOT_URL-$env:KIBANA_VERSION-windows-x86.zip" -OutFile 'kibana.zip' -UseBasicParsing; `
    if ((Get-FileHash kibana.zip -Algorithm sha512).Hash.ToLower() -ne $env:KIBANA_SHA) {exit 1}; `
    Expand-Archive kibana.zip -DestinationPath C:\; `
    Move-Item c:/kibana-$($env:KIBANA_VERSION)-windows-x86 $env:KIBANA_HOME;

# Kibana
FROM microsoft/windowsservercore:ltsc2016
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

ARG KIBANA_VERSION="5.6.11"
ENV KIBANA_VERSION=${KIBANA_VERSION} `
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