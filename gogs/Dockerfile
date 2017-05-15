# escape=`
<<<<<<< HEAD
FROM microsoft/windowsservercore:10.0.14393.693
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# Git
ENV GIT_VERSION=2.12.0 `
    GIT_DOWNLOAD_SHA256=6238f65c4d8412b993cb092efde4954f8cb7da4def54d0c1533835f00e83fdad

RUN Invoke-WebRequest -OutFile git.zip -Uri "https://github.com/git-for-windows/git/releases/download/v$($env:GIT_VERSION).windows.1/MinGit-$($env:GIT_VERSION)-64-bit.zip"; `
	if ((Get-FileHash git.zip -Algorithm sha256).Hash -ne $env:GIT_DOWNLOAD_SHA256) {exit 1}; `
	Expand-Archive -Path git.zip -DestinationPath C:\git; `
	Remove-Item git.zip -Force; `
	$env:PATH = 'C:\git\cmd;C:\git\mingw64\bin;C:\git\usr\bin;' + $env:PATH; `
	[Environment]::SetEnvironmentVariable('PATH', $env:PATH, [EnvironmentVariableTarget]::Machine)

# OpenSSH

#https://downloads.sourceforge.net/project/sshwindows/OpenSSH%20for%20Windows%20-%20Release/3.8p1-1%2020040709%20Build/setupssh381-20040709.zip?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fsshwindows%2Ffiles%2FOpenSSH%2520for%2520Windows%2520-%2520Release%2F&ts=1489158684&use_mirror=kent

COPY OpenSSH-Win64.zip /openssh.zip
RUN Expand-Archive -Path C:\openssh.zip -DestinationPath C:\; `
    Move-Item C:\OpenSSH-Win64 C:\openssh; `
    C:\openssh\install-sshd.ps1

ENV GOGS_VERSION 0.10.8
RUN Invoke-WebRequest -UseBasicParsing -OutFile gogs.zip -Uri "https://cdn.gogs.io/$($env:GOGS_VERSION)/windows_amd64.zip"; `
    Expand-Archive gogs.zip -DestinationPath C:\; `
    Remove-Item gogs.zip

EXPOSE 22 3000
VOLUME c:/gogs/data c:/gogs/logs c:/repositories

RUN Set-itemproperty -path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\DOS Devices' -Name 'G:' -Value '\??\C:\repositories' -Type String  

WORKDIR c:/gogs
CMD ["gogs", "web"]

# volumes for data & logs fine - repo needs G drive
# fails on push - trying to use bash

# C:\scm\incubating\overlay-tests [master]> git push gogs master
#Counting objects: 4, done.
#Delta compression using up to 4 threads.
#Compressing objects: 100% (4/4), done.
#Writing objects: 100% (4/4), 876 bytes | 0 bytes/s, done.
#Total 4 (delta 0), reused 0 (delta 0)
#remote: /usr/bin/env: 'bash': No such file or directory
#To http://172.26.192.82:3000/sixeyed/temp-priv.git
# ! [remote rejected] master -> master (pre-receive hook declined)
#error: failed to push some refs to 'http://172.26.192.82:3000/sixeyed/temp-priv.git'
#C:\scm\incubating\overlay-tests [master]>

# script is 

# #!/usr/bin/env bash
# "C:/gogs/gogs.exe" hook --config='C:/gogs/custom/conf/app.ini' pre-receive
=======
FROM microsoft/windowsservercore
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Install-PackageProvider -Name chocolatey -Force; `
    Install-Package -Name git -Provider chocolatey -Force; `
    Install-Package -Name openssh -Provider chocolatey -Force

EXPOSE 22 3000
VOLUME c:/gogs/data c:/gogs/logs

WORKDIR c:/gogs
COPY ./gogs/ .

CMD ["gogs", "web"]
>>>>>>> 9a4480ffe1f0b3f45b7c5fcbbb2475a22b9d61a5
