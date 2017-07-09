# escape=`
FROM golang:1.8-windowsservercore
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ENV NATS_SERVER=nats `
    NATS_PORT=4222

RUN go get github.com/nats-io/nats
RUN set-itemproperty -path 'HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters' -Name ServerPriorityTimeLimit -Value 0 -Type DWord

ENTRYPOINT ["powershell", "-Command", "go", "run", "$env:GOPATH\\src\\github.com\\nats-io\\nats\\examples\\nats-bench.go", "-s nats://$($env:NATS_SERVER):$($env:NATS_PORT)"]

CMD ["-np 1", "-n 1000", "-ms 16", "nats-bench"]