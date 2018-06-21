param(    
    [string] $imageTag='sixeyed/docker-ee'
)

Write-Host "Testing container image: $imageTag"
$ver = docker $config container run $imageTag docker version 
$ip = docker container inspect --format '{{ .NetworkSettings.Networks.nat.IPAddress }}' $id

Write-Host "Fetching HTTP at container IP: $ip"
$response = (iwr -useb "http://$(ip)/Bonobo.Git.Server")

Write-Host "Removing container ID: $id"
docker $config rm -f $id

if ($response.StatusCode -eq 200) {
    Write-Host 'Test passed - received 200 OK'
    exit 0
} else {
    Write-Host "Test failed"
    exit 1
}
