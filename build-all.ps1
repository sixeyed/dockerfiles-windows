param(    
    [string] $os='windowsservercore',
    [string] $osBranch='1809',
    [object[]] $dockerConfig
)

$osAndBranch="$os\$osBranch"
$startPath=$(pwd)

$dockerfiles = Get-ChildItem -Filter Dockerfile -recurse | where {
$_.FullName.Contains($osAndBranch) }

Write-Host "* Building $($dockerfiles.Length) Dockerfiles for $osAndBranch"

try {
    $dockerfiles | foreach {
        Write-Host "** Building $($_.FullName)"
        $path = $_.DirectoryName
        cd $path
        ..\..\..\build-tag-push.ps1
    }
}
finally {
    cd $startPath
}