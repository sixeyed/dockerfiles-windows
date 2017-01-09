# escape=`
FROM golang:1.8-windowsservercore
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV NATS_SERVER=nats

RUN go get github.com/nats-io/nats

ENTRYPOINT ["powershell", "-Command", "go", "run", "$env:GOPATH\\src\\github.com\\nats-io\\nats\\examples\\nats-bench.go", "-s nats://$env:NATS_SERVER:4222"]
CMD ["-np 1", "-n 1000", "-ms 16", "nats-bench"]