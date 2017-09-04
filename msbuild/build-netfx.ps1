$windowsTag='10.0.14393.1480'
$variants = 'netfx-4.5.2', 'netfx-4.5.2-ssdt', 'netfx-4.5.2-webdeploy'

foreach ($variant in $variants) {
    docker build -t "sixeyed/msbuild:$variant-$windowsTag" -f "$variant/Dockerfile" "./$variant"
    docker tag "sixeyed/msbuild:$variant-$windowsTag" "sixeyed/msbuild:$variant"
    docker push "sixeyed/msbuild:$variant-$windowsTag"
    docker push "sixeyed/msbuild:$variant"
}