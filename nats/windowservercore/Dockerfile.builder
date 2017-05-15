# escape=`
FROM golang:1.8-windowsservercore
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

EXPOSE 11224 11424 12444

RUN go get github.com/sixeyed/gnatsd; `
    go get github.com/nats-io/go-nats

CMD cd .\src\github.com\sixeyed\gnatsd; `
    go build; `
    go test ./...

# ports used in tests
EXPOSE 11224 11424 12444
EXPOSE 11225 11425 12445
EXPOSE 4222 4224 4244 4246 
EXPOSE 4443 11522 8222 4248
EXPOSE 2442 4242 4245 4246
EXPOSE 4233 8233