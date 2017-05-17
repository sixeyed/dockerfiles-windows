# escape=`
FROM microsoft/windowsservercore:10.0.14393.1198
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Install-PackageProvider -Name chocolatey -RequiredVersion 2.8.5.130 -Force; `
    Install-Package -Name microsoft-build-tools -RequiredVersion 15.0.26228.0 -Force; `
    Install-Package -Name netfx-4.5.2-devpack -RequiredVersion 4.5.5165101 -Force; `
    Install-Package nuget.commandline -RequiredVersion 3.5.0 -Force;

ENV NUGET_PATH="C:\Chocolatey\bin" `
    MSBUILD_PATH="C:\Program Files (x86)\MSBuild\14.0\Bin"

RUN $env:PATH = $env:PATH + $env:NUGET_PATH + ';' + $env:MSBUILD_PATH + ';' ; `
	[Environment]::SetEnvironmentVariable('PATH', $env:PATH, [EnvironmentVariableTarget]::Machine)

ENTRYPOINT ["powershell"]