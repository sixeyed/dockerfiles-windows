# escape=`
FROM sixeyed/chocolatey:0.10.11-windowsservercore-1809
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV COMPLUS_NGenProtectedProcess_FeatureEnabled 0

RUN choco install -y --version 15.8.7.0 visualstudio2017buildtools

## ^^ this doesn't work. The command completes but there is no VS2017 afterwards.

RUN choco install -y --version 1.3.0 visualstudio2017-workload-webbuildtools

RUN setx /M DOTNET_SKIP_FIRST_TIME_EXPERIENCE 1; `
    choco install -y --version 1.1.0 visualstudio2017-workload-netcorebuildtools


# Set PATH in one layer to keep image size down.
RUN setx /M PATH $(${Env:PATH} `
    + \";${Env:ProgramFiles}\NuGet\" `
    + \";${Env:ProgramFiles(x86)}\Microsoft Visual Studio\2017\TestAgent\Common7\IDE\CommonExtensions\Microsoft\TestWindow\" `
    + \";${Env:ProgramFiles(x86)}\Microsoft Visual Studio\2017\BuildTools\MSBuild\15.0\Bin\")

# Install Targeting Packs
RUN @('4.0', '4.5.2', '4.6.2', '4.7.2') `
    | %{ `
        Invoke-WebRequest -UseBasicParsing https://dotnetbinaries.blob.core.windows.net/referenceassemblies/v${_}.zip -OutFile referenceassemblies.zip; `
        Expand-Archive referenceassemblies.zip -DestinationPath \"${Env:ProgramFiles(x86)}\Reference Assemblies\Microsoft\Framework\.NETFramework\"; `
        Remove-Item -Force referenceassemblies.zip; `
    }

# C:\Program Files (x86)\Microsoft Visual Studio\2017\BuildTools\MSBuild\15.0\Bin