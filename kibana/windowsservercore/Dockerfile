# escape=`
FROM microsoft/windowsservercore:10.0.14393.1198
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# Kibana
ENV KIBANA_VERSION="5.2.0" `
    KIBANA_SHA1="6efc6471e074dcfe6da14a6af38a323239822a4c"

RUN Invoke-WebRequest -OutFile kibana.zip "https://artifacts.elastic.co/downloads/kibana/kibana-$($env:KIBANA_VERSION)-windows-x86.zip" -UseBasicParsing; `
    if ((Get-FileHash kibana.zip -Algorithm sha1).Hash -ne $env:KIBANA_SHA1) {exit 1} ; `
    Expand-Archive kibana.zip -DestinationPath C:\ ; `
    Move-Item c:\kibana-$($env:KIBANA_VERSION)-windows-x86 'C:\kibana'; `
    Remove-Item kibana.zip

# Default configuration for host & Elasticsearch URL
WORKDIR C:/kibana
RUN (Get-Content ./config/kibana.yml) -replace '#server.host: \"localhost\"', 'server.host: \"0.0.0.0\"' | Set-Content ./config/kibana.yml; `
    (Get-Content ./config/kibana.yml) -replace '#elasticsearch.url: \"http://localhost:9200\"', 'elasticsearch.url: \"http://elasticsearch:9200\"' | Set-Content ./config/kibana.yml

# REMARKS - DNS tweaks needed for Windows
RUN Set-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name ServerPriorityTimeLimit -Value 0 -Type DWord    

HEALTHCHECK --start-period=30s --interval=10s --retries=5 `
 CMD powershell -command `
    try { `
     $response = iwr -useb http://localhost:5601/app/kibana; `
     if ($response.StatusCode -eq 200) { return 0} `
     else {return 1}; `
    } catch { return 1 }

EXPOSE 5601
COPY init.ps1 /
ENTRYPOINT ["powershell"]
CMD ["/init.ps1"]