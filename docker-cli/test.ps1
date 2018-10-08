param(    
    [string] $imageTag='sixeyed/docker-cli:windowsservercore-1809',
    [object[]] $dockerConfig
)

Write-Host "Test script using Docker config: $dockerConfig"

Write-Host "Testing container image: $imageTag"
$dockerVersion = docker $dockerConfig container run --rm $imageTag docker --version
$composeVersion = docker $dockerConfig container run --rm $imageTag docker-compose version

if ($dockerVersion.StartsWith('Docker') -and $composeVersion[0].StartsWith('docker-compose')) {
    Write-Host "Test passed - Docker version: $dockerVersion, Compose version: $composeVersion"
    exit 0
} else {
    Write-Host "Test failed"
    exit 1
}