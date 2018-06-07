# escape=`
FROM sixeyed/terraform:0.9.4-windowsservercore-ltsc2016

WORKDIR C:\scripts
COPY scripts/ .

VOLUME C:\out
ENTRYPOINT .\Run-Terraform.ps1