param(    
    [string] $imageTag='sixeyed/kibana',
    [object[]] $dockerConfig
)

Write-Host "Test script using Docker config: $dockerConfig"

Write-Host "Starting dependency - Elasticsearch"
docker $dockerConfig container run -d `
 -m 2G -e ES_JAVA_OPTS="-Xms800m -Xmx800m" `
--name elasticsearch sixeyed/elasticsearch:nanoserver-sac2016

Start-Sleep -Seconds 120

Write-Host "Running container from image: $imageTag"
$id = docker $dockerConfig container run -d $imageTag
$ip = docker $dockerConfig container inspect --format '{{ .NetworkSettings.Networks.nat.IPAddress }}' $id

Write-Host "Fetching HTTP at container IP: $ip"
Start-Sleep -Seconds 180
$response = (iwr -useb "http://$($ip):5601/app/kibana")

Write-Host 'Removing containers'
docker $dockerConfig rm -f elasticsearch
docker $dockerConfig rm -f $id

if ($response.StatusCode -eq 200) {
    Write-Host 'Test passed - received 200 OK'
    exit 0
} else {
    Write-Host "Test failed"
    exit 1
}
