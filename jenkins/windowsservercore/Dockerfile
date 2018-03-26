# escape=`
FROM microsoft/windowsservercore AS installer
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV JENKINS_VERSION="2.107.1"

WORKDIR C:\jenkins
RUN Invoke-WebRequest "https://repo.jenkins-ci.org/public/org/jenkins-ci/main/jenkins-war/$($env:JENKINS_VERSION)/jenkins-war-$($env:JENKINS_VERSION).war.sha256" -OutFile 'jenkins.war.sha256' -UseBasicParsing; `
    $env:JENKINS_SHA256 = Get-Content -Raw jenkins.war.sha256; `
    Invoke-WebRequest "https://repo.jenkins-ci.org/public/org/jenkins-ci/main/jenkins-war/$($env:JENKINS_VERSION)/jenkins-war-$($env:JENKINS_VERSION).war" -OutFile 'jenkins.war' -UseBasicParsing; `
    if ((Get-FileHash jenkins.war -Algorithm sha256).Hash.ToLower() -ne $env:JENKINS_SHA256) {exit 1}

# Jenkins
FROM openjdk:8-windowsservercore-ltsc2016
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

ENV JENKINS_HOME="G:\jenkins" `
    VOLUME_PATH="C:\data"

VOLUME ${VOLUME_PATH}

RUN Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\DOS Devices' -Name 'G:' -Value "\??\$($env:VOLUME_PATH)" -Type String

EXPOSE 8080 50000
WORKDIR C:\jenkins
ENTRYPOINT java -jar C:\jenkins\jenkins.war

COPY --from=installer C:\jenkins .