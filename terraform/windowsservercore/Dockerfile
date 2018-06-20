# escape=`
FROM microsoft/windowsservercore:ltsc2016
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV TERRAFORM_VERSION="0.11.7" `
    TERRAFORM_SHA256="5fd003ef20f7a6a85ced4ad30bf95698afd4d0bfd477541583ff014e96026d6c" `
    TERRAFORM_ROOT="C:\terraform"

RUN $env:PATH = $env:TERRAFORM_ROOT + ';' + $env:PATH; `
	[Environment]::SetEnvironmentVariable('PATH', $env:PATH, [EnvironmentVariableTarget]::Machine)

RUN [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; `
    iwr -outfile terraform.zip "https://releases.hashicorp.com/terraform/$($env:TERRAFORM_VERSION)/terraform_$($env:TERRAFORM_VERSION)_windows_amd64.zip" -UseBasicParsing; `
    if ((Get-FileHash terraform.zip -Algorithm sha256).Hash -ne $env:TERRAFORM_SHA256) {exit 1} ; `
    Expand-Archive terraform.zip -DestinationPath $env:TERRAFORM_ROOT ; `
    rm terraform.zip

WORKDIR ${TERRAFORM_ROOT}
ENTRYPOINT ["terraform.exe"]