param(    
    [string] $imageVersion='',
    [string] $registryUser='sixeyed',    
    [string] $localRegistry='registry.sixeyed:5000'    
)

# builds and pushes Docker images
# expectations:
#   - directory structure is: {image}/{os}/{os-branch}, e.g. jenkins/windowsservercore/ltsc2016
#   - Dockerfile and context are in the {os-branch} directory
#   - this command is executed from the {os-branch} directory
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
& docker $config image build -t $fullTag .

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