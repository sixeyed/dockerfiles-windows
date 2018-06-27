param(    
    [string] $imageTag='sixeyed/jenkins',
    [object[]] $dockerConfig
)

Write-Host "Test script using Docker config: $dockerConfig"

Write-Host "Running container from image: $imageTag"
$id = docker $dockerConfig container run -d -P $imageTag
$ip = docker $dockerConfig container inspect --format '{{ .NetworkSettings.Networks.nat.IPAddress }}' $id

$args.ErrorAction = "Stop"    
$retrycount = 0
$completed = $false
$waitSeconds = 5
$exitCode = 1

while (-not $completed) {
    try {
        Write-Host "Fetching HTTP at container IP: $ip"
        $response = (iwr -useb "http://$($ip):8080/login" -TimeoutSec 5)
        if ($response.StatusCode -eq 200) {
            Write-Host 'Test passed - received 200 OK'
            $exitCode = 0
        } 
    } catch {
        if ($retrycount -ge 9) {
            Write-Host 'Test failed after maximum retries'
            throw
        } else {
            Write-Host "GET failed. Retrying in $waitSeconds seconds"
            Start-Sleep $waitSeconds
            $retrycount++
        }
    }
}

Write-Host "Removing container ID: $id"
docker $dockerConfig rm -f $id

exit $exitCode