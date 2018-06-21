param(    
    [string] $imageName='sixeyed/jenkins'
)

Write-Host "Running container from image: $imageName"
$id = docker $config container run -d -P $imageName
$ip = docker container inspect --format '{{ .NetworkSettings.Networks.nat.IPAddress }}' $id

Write-Host "Fetching HTTP at container IP: $ip"
$response = (iwr -useb "http://$(ip):8080")

Write-Host "Removing container ID: $id"
docker $config rm -f $id

if ($response.StatusCode -eq 200) {
    Write-Host 'Test passed - received 200 OK'
    exit 0
} else {
    Write-Host "Test failed"
    exit 1
}
