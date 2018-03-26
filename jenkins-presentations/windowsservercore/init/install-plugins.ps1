
# start Jenkins:
Write-Output "Starting Jenkins - JENKINS_HOME=$($env:JENKINS_HOME)"
Start-Job -ScriptBlock { & java -jar C:\jenkins\jenkins.war >console.out 2>console.err }

Write-Output 'Waiting for Jenkins initialization'
$passwordPath="$($env:JENKINS_HOME)\secrets\initialAdminPassword"
while (!(Test-Path $passwordPath)) { Start-Sleep 5 }
Start-Sleep 10

Write-Output 'Starting plugin installation'
$server='http://localhost:8080'
$adminUser='admin'
$adminPassword=(Get-Content -Raw $passwordPath).Trim()

$plugins=(Get-Content .\plugins.txt)
foreach ($plugin in $plugins) {
    java -jar "$($env:JENKINS_HOME)\war\WEB-INF\jenkins-cli.jar" -s $server -auth "$($adminUser):$($adminPassword)" install-plugin $plugin    
}

Write-Output 'Plugins installed.'