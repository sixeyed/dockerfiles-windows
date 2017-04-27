# escape=`
FROM sixeyed/terraform:0.9.4-windowsservercore

WORKDIR C:\scripts
COPY scripts/ .

VOLUME C:\out
ENTRYPOINT .\Run-Terraform.ps1