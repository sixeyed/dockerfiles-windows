param(    
    [string] $imageTag='sixeyed/docker-ee',
    [object[]] $dockerConfig
)

Write-Host "Test script using Docker config: $dockerConfig"

Write-Host "Testing container image: $imageTag"
$ver = docker $dockerConfig container run --rm $imageTag docker version --format "{{ .Client.Version }}"

if ($ver.Contains('ee')) {
    Write-Host "Test passed - Docker version: $ver"
    exit 0
} else {
    Write-Host "Test failed"
    exit 1
}
