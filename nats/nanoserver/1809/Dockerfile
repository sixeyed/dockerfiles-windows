# escape=`
FROM sixeyed/golang:1.11.1-nanoserver-1809 AS builder

RUN go get github.com/nats-io/gnatsd && `
    go get github.com/nats-io/go-nats

RUN cd C:\gopath\src\github.com\nats-io\gnatsd && `
    go build

# NATS
FROM mcr.microsoft.com/windows/nanoserver:1809

WORKDIR C:\gnatsd
EXPOSE 4222 8222
ENV NATS_DOCKERIZED=1

USER ContainerAdministrator
ENTRYPOINT ["gnatsd"]
CMD ["-c", "gnatsd.conf"]

COPY gnatsd.conf .
COPY --from=builder C:\gopath\src\github.com\nats-io\gnatsd\gnatsd.exe .