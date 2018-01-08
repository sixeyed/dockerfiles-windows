# escape=`
FROM microsoft/windowsservercore:10.0.14393.2007
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV GIT_VERSION="2.15.1" `
	GIT_RELEASE_NUMBER="2" `
    GIT_DOWNLOAD_SHA256="59060c93425709d66db1756f884d8f235b012d58f6de0963087afbac46134c57" `
	GIT_PATH="C:\git\cmd;C:\git\mingw64\bin;C:\git\usr\bin;"

RUN Invoke-WebRequest -OutFile git.zip -Uri "https://github.com/git-for-windows/git/releases/download/v$($env:GIT_VERSION).windows.$($env:GIT_RELEASE_NUMBER)/MinGit-$($env:GIT_VERSION).$($env:GIT_RELEASE_NUMBER)-64-bit.zip"; `
	if ((Get-FileHash git.zip -Algorithm sha256).Hash -ne $env:GIT_DOWNLOAD_SHA256) {exit 1}; `
	Expand-Archive -Path git.zip -DestinationPath C:\git; `
	Remove-Item git.zip -Force; `
	$env:PATH = $env:GIT_PATH + $env:PATH; `
	[Environment]::SetEnvironmentVariable('PATH', $env:PATH, [EnvironmentVariableTarget]::Machine)