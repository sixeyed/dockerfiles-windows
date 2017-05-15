# escape=`
FROM microsoft/windowsservercore
SHELL ["powershell", "-command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
WORKDIR /setup

RUN Install-PackageProvider -Name chocolatey -Force; ` 
    Install-Package -Name git -Provider chocolatey -Force;

# Go v1.4 is the last version which is able to build later versions:
ENV GO_VERSION 1.4.3
RUN iwr "https://storage.googleapis.com/golang/go$($env:GO_VERSION).windows-amd64.msi" -outfile go.msi; `
    Start-Process .\go.msi -ArgumentList '/quiet' -Wait ; `
    rm .\go.msi

# REMARK - this is a primitive build of Go which gives us the bare minimum -
# there is no CGO and tests are omitted
WORKDIR c:/github/golang
RUN git clone https://github.com/golang/go.git
ENV GOROOT_BOOTSTRAP=c:\\go `
    CGO_ENABLED=0
WORKDIR c:/github/golang/go/src
RUN .\make.bat  

# setup for derived images
ENV GOPATH=C:\\gopath `
    GOROOT=C:\\github\\golang\\go
WORKDIR C:/github/golang/go/bin