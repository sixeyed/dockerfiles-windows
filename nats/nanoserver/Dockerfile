# escape=`

FROM golang:1.8.3-windowsservercore AS builder
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN go get github.com/nats-io/gnatsd; `
    go get github.com/nats-io/go-nats

RUN cd C:\gopath\src\github.com\nats-io\gnatsd; `
    go build; `
    go test -v ./...

# NATS image
FROM microsoft/nanoserver
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

WORKDIR C:\gnatsd
EXPOSE 4222 8222 6222

ENTRYPOINT ["gnatsd"]
CMD ["-c", "gnatsd.conf"]

COPY gnatsd.conf .
COPY --from=builder C:\gopath\src\github.com\nats-io\gnatsd\gnatsd.exe .