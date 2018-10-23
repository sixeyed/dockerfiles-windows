param(    
    [string] $imageTag='sixeyed/nginx',
    [object[]] $dockerConfig
)

Write-Host "Test script using Docker config: $dockerConfig"

Write-Host "Running container from image: $imageTag"
$id = docker $dockerConfig container run -d -P $imageTag

if (Test-path env:DOCKER_HOST) {
    $dockerHost = $env:DOCKER_HOST.Split(':')[0]
    $port = (docker $dockerConfig  container port $id 80).Split(':')[1]
    $target = "$($dockerHost):$($port)"
} else {
    $ip = docker $dockerConfig container inspect --format '{{ .NetworkSettings.Networks.nat.IPAddress }}' $id
    $target = "$($ip):80"
}

Write-Host "Fetching HTTP at target: $target"
$response = (iwr -useb "http://$target")

Write-Host "Removing container ID: $id"
docker $dockerConfig rm -f $id

if ($response.StatusCode -eq 200) {
    Write-Host 'Test passed - received 200 OK'
    exit 0
} else {
    Write-Host "Test failed"
    exit 1
}
