param(    
    [string] $imageName='sixeyed/nginx',
    [object[]] $dockerConfig
)

Write-Host "config: $config"

Write-Host "Running container from image: $imageName"
$id = docker $dockerConfig container run -d -P $imageName
$ip = docker $dockerConfig container inspect --format '{{ .NetworkSettings.Networks.nat.IPAddress }}' $id

Write-Host "Fetching HTTP at container IP: $ip"
$response = (iwr -useb "http://$ip")

Write-Host "Removing container ID: $id"
docker $dockerConfig rm -f $id

if ($response.StatusCode -eq 200) {
    Write-Host 'Test passed - received 200 OK'
    exit 0
} else {
    Write-Host "Test failed"
    exit 1
}
