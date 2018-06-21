# escape=`
FROM microsoft/windowsservercore AS installer
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ARG JENKINS_VERSION="2.121.1"

WORKDIR C:\jenkins
RUN Write-Host "Downloading Jenkins version: $env:JENKINS_VERSION"; `
    Invoke-WebRequest "http://mirrors.jenkins.io/war-stable/$($env:JENKINS_VERSION)/jenkins.war.sha256" -OutFile 'jenkins.war.sha256' -UseBasicParsing; `    
    Invoke-WebRequest "http://mirrors.jenkins.io/war-stable/$($env:JENKINS_VERSION)/jenkins.war" -OutFile 'jenkins.war' -UseBasicParsing

RUN $env:JENKINS_SHA256=$(Get-Content -Raw jenkins.war.sha256).Split(' ')[0]; `
    if ((Get-FileHash jenkins.war -Algorithm sha256).Hash.ToLower() -ne $env:JENKINS_SHA256) {exit 1}

# Jenkins
FROM openjdk:8-windowsservercore-ltsc2016
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

ARG JENKINS_VERSION="2.121.1"
ENV JENKINS_VERSION=${JENKINS_VERSION} `
    JENKINS_HOME="G:\jenkins" `
    VOLUME_PATH="C:\data"

VOLUME ${VOLUME_PATH}

RUN Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\DOS Devices' -Name 'G:' -Value "\??\$($env:VOLUME_PATH)" -Type String

EXPOSE 8080 50000
WORKDIR C:\jenkins
ENTRYPOINT java -jar C:\jenkins\jenkins.war

COPY --from=installer C:\jenkins .