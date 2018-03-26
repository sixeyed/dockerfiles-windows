
$passwordPath="$($env:JENKINS_HOME)\secrets\initialAdminPassword"
$adminPassword=(Get-Content -Raw $passwordPath).Trim()

Write-Output "***** Default admin password: $adminPassword *****"

java -jar C:\jenkins\jenkins.war