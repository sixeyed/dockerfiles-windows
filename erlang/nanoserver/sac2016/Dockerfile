#escape=`
FROM microsoft/windowsservercore:ltsc2016 as installer
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ARG ERLANG_VERSION="21.1"
ARG ERLANG_HOME="C:\erlang"

ENV URL="http://erlang.org/download/otp_win64_${ERLANG_VERSION}.exe"

RUN Write-Host "Downloading Erlang version: $($env:ERLANG_VERSION), from: $($env:URL)"; `
    Invoke-WebRequest -OutFile erlang.exe -UseBasicParsing -Uri $env:URL

RUN Start-Process erlang.exe -ArgumentList '/S', "/D=$env:ERLANG_HOME" -NoNewWindow -Wait

# Erlang
FROM microsoft/nanoserver:sac2016

ARG ERLANG_VERSION="21.1"
ARG ERLANG_HOME="C:\erlang"

ENV ERLANG_VERSION=${ERLANG_VERSION} `
    ERLANG_HOME=${ERLANG_HOME} `
    HOMEDRIVE=C:\ `
    HOMEPATH=Users\%USERNAME%
    
COPY --from=installer ${ERLANG_HOME} ${ERLANG_HOME}
COPY .erlang.cookie C:\Windows