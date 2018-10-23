#escape=`
FROM microsoft/windowsservercore:ltsc2016 as installer
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ARG RABBITMQ_VERSION="3.7.8"
ARG RABBITMQ_HOME="C:\rabbitmq"

ENV URL="https://github.com/rabbitmq/rabbitmq-server/releases/download/v${RABBITMQ_VERSION}/rabbitmq-server-windows-${RABBITMQ_VERSION}.zip"

RUN Write-Host "Downloading RabbitMQ version: $($env:RABBITMQ_VERSION), from: $($env:URL)"; `
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; `
    Invoke-WebRequest -OutFile rabbitmq.zip -UseBasicParsing -Uri $env:URL

RUN Expand-Archive rabbitmq.zip -DestinationPath C:\; `
    Move-Item "C:\rabbitmq_server-$($env:RABBITMQ_VERSION)" $env:RABBITMQ_HOME

# Erlang
FROM sixeyed/erlang:21.1-windowsservercore-ltsc2016

ARG RABBITMQ_VERSION="3.7.8"
ARG RABBITMQ_HOME="C:\rabbitmq"

ENV RABBITMQ_VERSION=${RABBITMQ_VERSION} `
    RABBITMQ_HOME=${RABBITMQ_HOME} `
    RABBITMQ_LOGS="-" `
    RABBITMQ_SASL_LOGS="-" `
    RABBITMQ_CONFIG_FILE="${RABBITMQ_HOME}\rabbitmq" `
    RABBITMQ_BASE="C:\rmq-data"

EXPOSE 4369 5671 5672 25672 15672
CMD start.cmd

WORKDIR ${RABBITMQ_HOME}    
COPY --from=installer ${RABBITMQ_HOME} .
COPY rabbitmq.config .
COPY start.cmd .

RUN mkdir c:\Users\%USERNAME%\AppData\Roaming\RabbitMQ
