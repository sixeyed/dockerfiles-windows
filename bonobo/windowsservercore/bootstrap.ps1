
#.\Set-OwnerAcl.ps1 -Path $env:REPOSITORIES_PATH -Owner 'BUILTIN\IIS_IUSRS'


.\Set-OwnerAcl.ps1 -Path 'C:\bonobo\Bonobo.Git.Server\App_Data\Repos' -Owner 'BUILTIN\IIS_IUSRS'

& C:\ServiceMonitor.exe w3svc