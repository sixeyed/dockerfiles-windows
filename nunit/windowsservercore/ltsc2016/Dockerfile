# escape=`
FROM microsoft/dotnet-framework:4.7.2-runtime
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV NUGET_PATH="C:\Chocolatey\lib\NuGet.CommandLine.3.5.0\tools" `
    NUNIT_PATH="C:\NUnit.ConsoleRunner.3.6.1\tools"

RUN $env:PATH = $env:NUGET_PATH + ';' + $env:NUNIT_PATH + ';' + $env:PATH; `
	[Environment]::SetEnvironmentVariable('PATH', $env:PATH, [EnvironmentVariableTarget]::Machine);

RUN Install-PackageProvider -Name chocolatey -RequiredVersion 2.8.5.130 -Force; `
    Install-Package nuget.commandline -RequiredVersion 3.5.0 -Force; `
    & nuget install NUnit.ConsoleRunner -Version 3.6.1

ENTRYPOINT ["powershell"]