#escape=`
FROM microsoft/nanoserver:sac2016
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV KUBE_HOME="C:\kubernetes" `
    KUBECTL_VERSION="v1.10.0"

WORKDIR $KUBE_HOME

RUN Invoke-WebRequest "https://storage.googleapis.com/kubernetes-release/release/$($env:KUBECTL_VERSION)/bin/windows/amd64/kubectl.exe" -UseBasicParsing ; `
    $env:PATH = "$($env:KUBE_HOME);$($env:PATH)" ; `
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment\' -Name Path -Value $env:PATH