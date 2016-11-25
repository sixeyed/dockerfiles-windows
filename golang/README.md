# golang

Windows Server Core image for building [Go](http://golang.org/) from [source](https://github.com/golang/go).

# Usage

Use this image as a base for images which build Go projects, and rely on the latest code.

E.g. the builder image for [sixeyed/registry](https://hub.docker.com/r/sixeyed/registry/) uses this image:

```Dockerfile
FROM sixeyed/golang:a2bd5c5-windowsservercore 
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

RUN .\go get github.com/docker/distribution/cmd/registry
    
CMD cp \"$env:GOPATH\bin\registry.exe\" c:\out\ ; `
    cp \"$env:GOPATH\src\github.com\docker\distribution\cmd\registry\config-example.yml\" c:\out\config.yml
```
