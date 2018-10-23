[CmdletBinding()]
param(
    [Parameter(Mandatory=$true, ValueFromRemainingArguments=$true, Position=0)]
    [String] 
    $path,

    [Parameter(Mandatory=$true, ValueFromRemainingArguments=$true, Position=0)]
    [String]
    $owner
)

Write-Output "Changing ownership to: $owner, for path: $path"

$acl = Get-Acl $path; `
$newOwner = [System.Security.Principal.NTAccount]($owner); `
$acl.SetOwner($newOwner); `
Set-Acl -Path $path -AclObject $acl; `
Get-ChildItem -Path $path -Recurse | Set-Acl -AclObject $acl