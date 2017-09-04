# escape=`
FROM sixeyed/msbuild:netfx-4.5.2-10.0.14393.1480
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Install-Package -Name webdeploy -RequiredVersion 3.6.0 -Force; `
    & nuget install MSBuild.Microsoft.VisualStudio.Web.targets -Version 14.0.0.3

ENTRYPOINT ["powershell"]