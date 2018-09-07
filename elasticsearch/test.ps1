param(    
    [string] $imageTag='sixeyed/elasticsearch',
    [object[]] $dockerConfig
)

Write-Host "Test script using Docker config: $dockerConfig"

Write-Host "Running container from image: $imageTag"
$id = docker $dockerConfig container run -d -P -m 2G $imageTag
$ip = docker $dockerConfig container inspect --format '{{ .NetworkSettings.Networks.nat.IPAddress }}' $id

Write-Host 'Waiting for Elasticsearch to start'
Start-Sleep -Seconds 40

Write-Host "Fetching HTTP at container IP: $ip"
$response = iwr -useb "http://$($ip):9200/_cat/health"
$health = $response.Content.Split(' ')[3]

Write-Host "Removing container ID: $id"
docker $dockerConfig rm -f $id

if ($response.StatusCode -eq 200 -and ($health -eq 'green' -or $health -eq 'yellow')) {
    Write-Host "Test passed - Elasticsearch is running, health: $health"
    exit 0
} else {
    Write-Host "Test failed"
    exit 1
}