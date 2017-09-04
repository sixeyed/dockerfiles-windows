# escape=`
FROM sixeyed/msbuild:netfx-4.5.2-10.0.14393.1480
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN & nuget install Microsoft.Data.Tools.Msbuild -Version 10.0.61026

ENTRYPOINT ["powershell"]