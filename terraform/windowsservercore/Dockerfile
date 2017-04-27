# escape=`
FROM microsoft/windowsservercore:10.0.14393.1066
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV TERRAFORM_VERSION="0.9.4" `
    TERRAFORM_SHA256="d7c220da2f0b9a52d686cbb7278d27fba3af8dd02d785dfe33c4c6e96df27100"

RUN [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; `
    iwr -outfile terraform.zip "https://releases.hashicorp.com/terraform/$($env:TERRAFORM_VERSION)/terraform_$($env:TERRAFORM_VERSION)_windows_amd64.zip" -UseBasicParsing; `
    if ((Get-FileHash terraform.zip -Algorithm sha256).Hash -ne $env:TERRAFORM_SHA256) {exit 1} ; `
    Expand-Archive terraform.zip -DestinationPath C:\terraform ; `
    rm terraform.zip

WORKDIR C:\terraform
ENTRYPOINT ["terraform.exe"]