# escape=`
FROM microsoft/dotnet:1.1.2-sdk-nanoserver AS dotnet

FROM sixeyed/chocolatey
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN choco install -y visualstudio2017buildtools

RUN Install-PackageProvider -Name chocolatey -RequiredVersion 2.8.5.130 -Force; `
    Install-Package -Name netfx-4.5.2-devpack -RequiredVersion 4.5.5165101 -Force

# see https://github.com/Microsoft/msbuild/issues/1697
ENV MSBUILD_PATH="C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\MSBuild\15.0\Bin" `
    DOTNET_PATH="C:\Program Files\dotnet" `
    MSBuildSDKsPath="C:\Program Files\dotnet\sdk\1.0.4\Sdks"

RUN $env:PATH = $env:MSBUILD_PATH + ';' + $env:DOTNET_PATH + ';' + $env:PATH; `
    [Environment]::SetEnvironmentVariable('PATH', $env:PATH, [EnvironmentVariableTarget]::Machine); `
    [Environment]::SetEnvironmentVariable('MSBuildSDKsPath', $env:MSBuildSDKsPath, [EnvironmentVariableTarget]::Machine)

COPY --from=dotnet ${DOTNET_PATH} ${DOTNET_PATH}

RUN Install-Package nuget.commandline -RequiredVersion 4.1.0 -Force;

ENV NUGET_PATH="C:\Chocolatey\lib\NuGet.CommandLine.4.1.0\tools"

RUN $env:PATH = $env:NUGET_PATH + ';' + $env:PATH; `
    [Environment]::SetEnvironmentVariable('PATH', $env:PATH, [EnvironmentVariableTarget]::Machine)