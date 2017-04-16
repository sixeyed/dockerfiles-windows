# escape=`
FROM sixeyed/msbuild:4.5.2
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Install-Package -Name webdeploy -RequiredVersion 3.5.2 -Force; `
    & C:\Chocolatey\bin\nuget install MSBuild.Microsoft.VisualStudio.Web.targets -Version 14.0.0.3

ENTRYPOINT ["powershell"]