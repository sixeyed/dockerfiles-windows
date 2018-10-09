param(    
    [string] $imageVersion='',
    [string] $registryUser='sixeyed',    
    [string] $localRegistry='',    
    [string] $buildArgs='',
    [object[]] $dockerConfig
)

# builds and pushes Docker images
# expectations:
#   - directory structure is: {image}/{os}/{os-branch}, e.g. jenkins/windowsservercore/ltsc2016
#   - Dockerfile and context are in the {os-branch} directory
#   - this command is executed from the {os-branch} directory
# input:
#   - imageVersion - version of the image being built
#   - registryUser - registry username or organization
#   - localRegistry - registry push destination, in addition to Docker Hub
#   - buildArgs - comma separated values to pass as `build-arg` in Docker build
# output:
#   - image built and pushed with multiple tags using the format {user}/{image}:{version-{os}-{os-branch},
#   - e.g. 
#   -  sixeyed/jenkins:2.121.1-windowsservercore-ltsc2016
#   -  sixeyed/jenkins:windowsservercore-ltsc2016
#   -  sixeyed/jenkins

$path = $(pwd).ToString().Split('\')
$count = $path.Length

if (($imageVersion -eq '') -and (Test-Path ..\..\imageVersion.txt)) {
    $imageVersion = Get-Content ..\..\imageVersion.txt
}

$branchName = $path[$count-1]
$osName = $path[$count-2]
$imageName = $path[$count-3]
$fullTag = "$($registryUser)/$($imageName):$($imageVersion)-$($osName)-$($branchName)"

if ($buildArgs.Length -gt 0) {
    $buildArg=@()
    $buildArgsExpanded=$buildArgs.Split(',')
    foreach ($arg in $buildArgsExpanded){
        $buildArg += "--build-arg", $arg
    }
}

Write-Host "* Building image: $fullTag, with args: $buildArg"
& docker $dockerConfig image build $buildArg -t $fullTag .

if (Test-Path ..\..\test.ps1) {
    Write-Host '** Executing test script'
    ..\..\test.ps1 -imageTag $fullTag -dockerConfig $dockerConfig
    if ($LastExitCode -ne 0) {
        exit 1
    }
}

Write-Host "* Pushing image tags for: $fullTag"
$tags = @($fullTag,
          "$($registryUser)/$($imageName):$($osName)-$($branchName)")

$registries = @('')
if ($localRegistry -ne '') {
    $registries += "$($localRegistry)/"
}

foreach ($tag in $tags) {        
    Write-Host "** Processing $tag"
    foreach ($registry in $registries){
        $registryTag = "$($registry)$tag"
        Write-Host "** Pushing $registryTag"
        & docker $dockerConfig image tag $fullTag $registryTag
        & docker $dockerConfig image push $registryTag
    }
}