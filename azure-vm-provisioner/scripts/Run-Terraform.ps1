[CmdletBinding()]
param(
    [Parameter(Mandatory=$true,ValueFromRemainingArguments=$true, Position=0)]
    [String[]] 
    $action
)

$global:proceed = $True

function ValidateEnvironmentVariable($name) {
    $valid = Test-Path "Env:\$name"
    if ($valid -eq $False) {
        Write-Host "Environment variable: $name is required"
        $global:proceed = $False
    }
}

# entrypoint

# validate Azure service principal settings:
ValidateEnvironmentVariable('ARM_SUBSCRIPTION_ID')
ValidateEnvironmentVariable('ARM_CLIENT_ID')
ValidateEnvironmentVariable('ARM_CLIENT_SECRET')
ValidateEnvironmentVariable('ARM_TENANT_ID')

# validate configuration settings:
ValidateEnvironmentVariable('TF_VAR_resource_group')
ValidateEnvironmentVariable('TF_VAR_storage_account')
ValidateEnvironmentVariable('TF_VAR_dns_prefix')
ValidateEnvironmentVariable('TF_VAR_region')
ValidateEnvironmentVariable('TF_VAR_image_vhd_uri')

if ($global:proceed -eq $True) {
    .\Generate-Credentials.ps1
    & c:\terraform\terraform.exe $action -var-file='c:\in\passwords.tfvars' -var-file='c:\in\usernames.tfvars'
}
else {
    Write-Host "Required environment variables missing. Not proceeding with action: $action"
}