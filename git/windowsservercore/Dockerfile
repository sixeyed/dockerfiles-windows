# escape=`

FROM microsoft/windowsservercore:10.0.14393.1198
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV GIT_VERSION="2.13.0" `
    GIT_DOWNLOAD_SHA256="20acda973eca1df056ad08bec6e05c3136f40a1b90e2a290260dfc36e9c2c800" `
	GIT_PATH="C:\git\cmd;C:\git\mingw64\bin;C:\git\usr\bin;"

RUN Invoke-WebRequest -OutFile git.zip -Uri "https://github.com/git-for-windows/git/releases/download/v$($env:GIT_VERSION).windows.1/MinGit-$($env:GIT_VERSION)-64-bit.zip"; `
	if ((Get-FileHash git.zip -Algorithm sha256).Hash -ne $env:GIT_DOWNLOAD_SHA256) {exit 1}; `
	Expand-Archive -Path git.zip -DestinationPath C:\git; `
	Remove-Item git.zip -Force; `
	$env:PATH = $env:GIT_PATH + $env:PATH; `
	[Environment]::SetEnvironmentVariable('PATH', $env:PATH, [EnvironmentVariableTarget]::Machine)