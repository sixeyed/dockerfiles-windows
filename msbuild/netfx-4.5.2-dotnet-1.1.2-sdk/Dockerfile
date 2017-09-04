# escape=`
FROM microsoft/dotnet:1.1.2-sdk-nanoserver AS dotnet

FROM sixeyed/msbuild:netfx-4.5.2-10.0.14393.1480
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# see https://github.com/Microsoft/msbuild/issues/1697
ENV DOTNET_PATH="C:\Program Files\dotnet" `
    MSBuildSDKsPath="C:\Program Files\dotnet\sdk\1.0.4\Sdks"

RUN $env:PATH = $env:DOTNET_PATH + ';' + $env:PATH; `
	[Environment]::SetEnvironmentVariable('PATH', $env:PATH, [EnvironmentVariableTarget]::Machine); `
    [Environment]::SetEnvironmentVariable('MSBuildSDKsPath', $env:MSBuildSDKsPath, [EnvironmentVariableTarget]::Machine)

COPY --from=dotnet ${DOTNET_PATH} ${DOTNET_PATH}