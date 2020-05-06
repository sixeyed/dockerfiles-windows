# escape=`
FROM openjdk:8-windowsservercore-ltsc2016
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

ARG JENKINS_VERSION="2.222.3"
ARG JENKINS_SHA256="1529d642e29e74f65369ff5611935e9361065d9e8f65344a64912c5660cc0781"

ENV JENKINS_VERSION=${JENKINS_VERSION} `
    JENKINS_HOME="G:\jenkins" `
    VOLUME_PATH="C:\data"

VOLUME ${VOLUME_PATH}

WORKDIR C:\jenkins

RUN Write-Host "Downloading Jenkins version: $env:JENKINS_VERSION"; `
    Invoke-WebRequest "http://mirrors.jenkins.io/war-stable/$($env:JENKINS_VERSION)/jenkins.war" -OutFile 'jenkins.war' -UseBasicParsing; `
    if ((Get-FileHash jenkins.war -Algorithm sha256).Hash.ToLower() -ne $env:JENKINS_SHA256) {exit 1}; `
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\DOS Devices' -Name 'G:' -Value "\??\$($env:VOLUME_PATH)" -Type String

EXPOSE 8080 50000

ENTRYPOINT java -jar C:\jenkins\jenkins.war
