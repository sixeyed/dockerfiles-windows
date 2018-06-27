param(    
    [string] $imageTag='sixeyed/docker-ee',
    [object[]] $dockerConfig
)

Write-Host "Test script using Docker config: $dockerConfig"

Write-Host "Testing container image: $imageTag"
$ver = docker $dockerConfig container run $imageTag docker version 
$ip = docker $dockerConfig container inspect --format '{{ .NetworkSettings.Networks.nat.IPAddress }}' $id

Write-Host "Fetching HTTP at container IP: $ip"
$response = (iwr -useb "http://$(ip)/Bonobo.Git.Server")

Write-Host "Removing container ID: $id"
docker $dockerConfig rm -f $id

if ($response.StatusCode -eq 200) {
    Write-Host 'Test passed - received 200 OK'
    exit 0
} else {
    Write-Host "Test failed"
    exit 1
}
