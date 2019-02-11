# escape=`

## source https://github.com/Microsoft/aspnet-docker/blob/master/3.5-windowsservercore-1803/runtime/Dockerfile
## amended base image until MSFT's image available
FROM sixeyed/dotnet-framework-3.5-runtime:windowsservercore-1809

SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Add-WindowsFeature Web-Server; `
    Add-WindowsFeature Web-Asp-Net; `
    C:\Windows\System32\inetsrv\appcmd set apppool /apppool.name:DefaultAppPool /managedRuntimeVersion:v2.0; `
    Remove-Item -Recurse C:\inetpub\wwwroot\* ; `
    Invoke-WebRequest -Uri https://dotnetbinaries.blob.core.windows.net/servicemonitor/2.0.1.6/ServiceMonitor.exe -OutFile C:\ServiceMonitor.exe

# ES - add WVC activation
RUN Install-WindowsFeature NET-HTTP-Activation

EXPOSE 80

ENTRYPOINT ["C:\\ServiceMonitor.exe", "w3svc"]