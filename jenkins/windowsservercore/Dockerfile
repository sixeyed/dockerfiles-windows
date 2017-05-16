# escape=`
FROM openjdk:8-jdk-windowsservercore
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV JENKINS_VERSION="2.46.2" `
    JENKINS_SHA256="aa7f243a4c84d3d6cfb99a218950b8f7b926af7aa2570b0e1707279d464472c7" `
    JENKINS_HOME="G:\jenkins" `
    VOLUME_PATH="C:\data"

VOLUME ${VOLUME_PATH}

RUN Set-ItemProperty -path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name ServerPriorityTimeLimit -Value 0 -Type DWord; `
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\DOS Devices' -Name 'G:' -Value "\??\$($env:VOLUME_PATH)" -Type String

WORKDIR C:\jenkins
RUN Invoke-WebRequest "https://repo.jenkins-ci.org/public/org/jenkins-ci/main/jenkins-war/$($env:JENKINS_VERSION)/jenkins-war-$($env:JENKINS_VERSION).war" -OutFile 'jenkins.war' -UseBasicParsing; `
    if ((Get-FileHash jenkins.war -Algorithm sha256).Hash.ToLower() -ne $env:JENKINS_SHA256) {exit 1}

EXPOSE 8080 50000

ENTRYPOINT java -jar C:\jenkins\jenkins.war