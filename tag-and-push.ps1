param(    
    [string] $fullTag,
    [string] $osTag='windowsservercore',
    [string] $localRegistry='registry.sixeyed:5000'    
)

$baseTag = $fullTag.Split(":")[0]
$tags = @($fullTag, "$($baseTag):$($osTag)", "$($baseTag):latest")
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