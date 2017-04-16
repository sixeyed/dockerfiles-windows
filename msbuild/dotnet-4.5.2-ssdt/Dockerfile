# escape=`
FROM sixeyed/msbuild:4.5.2
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN & C:\Chocolatey\bin\nuget install Microsoft.Data.Tools.Msbuild -Version 10.0.61026

ENTRYPOINT ["powershell"]