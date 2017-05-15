# escape=`
FROM golang:1.8-windowsservercore
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

<<<<<<< HEAD
ENV NATS_SERVER=nats `
    NATS_PORT=4222

RUN go get github.com/nats-io/nats
RUN set-itemproperty -path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name ServerPriorityTimeLimit -Value 0 -Type DWord

ENTRYPOINT ["powershell", "-Command", "go", "run", "$env:GOPATH\\src\\github.com\\nats-io\\nats\\examples\\nats-bench.go", "-s nats://$($env:NATS_SERVER):$($env:NATS_PORT)"]
=======
ENV NATS_SERVER=nats

RUN go get github.com/nats-io/nats

ENTRYPOINT ["powershell", "-Command", "go", "run", "$env:GOPATH\\src\\github.com\\nats-io\\nats\\examples\\nats-bench.go", "-s nats://$env:NATS_SERVER:4222"]
>>>>>>> 9a4480ffe1f0b3f45b7c5fcbbb2475a22b9d61a5
CMD ["-np 1", "-n 1000", "-ms 16", "nats-bench"]