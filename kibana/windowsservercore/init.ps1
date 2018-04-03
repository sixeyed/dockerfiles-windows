if ($env:ELASTICSEARCH_URL -ne $null) {
    $configPath = 'C:\kibana\config\kibana.yml'
    $in = 'elasticsearch.url: "http://elasticsearch:9200"'
    $out = "elasticsearch.url: `"$($env:ELASTICSEARCH_URL)`""
    (Get-Content $configPath) -replace $in, $out | Set-Content $configPath
}

& c:\kibana\bin\kibana.bat