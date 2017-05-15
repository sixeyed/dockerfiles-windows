# escape=`
FROM golang:1.8-nanoserver
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

VOLUME C:\src

CMD cp -r -Force c:\src\* C:\gopath; `
    cd .\src\github.com\nats-io\gnatsd; `
    go build; `
    go test ./...
