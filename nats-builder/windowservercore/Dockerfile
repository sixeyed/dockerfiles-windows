# escape=`
FROM golang:1.8-windowsservercore
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# ports used in tests
EXPOSE 11224 11424 12444 `
       11225 11425 12445 `
       4222 4224 4244 4246 `
       4443 11522 8222 4248 `
       2442 4242 4245 4246 `
       4233 8233

CMD go get github.com/nats-io/gnatsd; `
    go get github.com/nats-io/go-nats; `
    cd ./src/github.com/nats-io/gnatsd; `
    go build; `
    go test ./...