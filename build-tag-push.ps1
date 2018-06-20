param(    
    [string] $imageVersion='',
    [string] $registryUser='sixeyed',    
    [string] $localRegistry='registry.sixeyed:5000',    
    [string] $buildArgs=''
)

# builds and pushes Docker images
# expectations:
#   - directory structure is: {image}/{os}/{os-branch}, e.g. jenkins/windowsservercore/ltsc2016
#   - Dockerfile and context are in the {os-branch} directory
#   - this command is executed from the {os-branch} directory
# input:
#   - imageVersion - version of the image being built
#   - regsitryUser - registry username or organization
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

$branchName = $path[$count-1]
$osName = $path[$count-2]
$imageName = $path[$count-3]
$fullTag = "$($registryUser)/$($imageName):$($imageVersion)-$($osName)-$($branchName)"

$buildArg=@()
$buildArgsExpanded=$buildArgs.Split(',')
foreach ($arg in $buildArgsExpanded){
    $buildArg += "--build-arg", $arg
}

Write-Host "** Building image: $fullTag, with args: $buildArg"
& docker $config image build $buildArg -t $fullTag .

$tags = @($fullTag,
          "$($registryUser)/$($imageName):$($osName)-$($branchName)",
          "$($registryUser)/$($imageName):latest")

$registries = @('', "$($localRegistry)/")

foreach ($tag in $tags) {        
    Write-Host "** Processing $tag"
    foreach ($registry in $registries){
        $registryTag = "$($registry)$tag"
        Write-Host "** Pushing $registryTag"
        & docker $config image tag $fullTag $registryTag
        & docker $config image push $registryTag
    }
}