# NATS

Windows Nano Server image for [NATS](http://nats.io) messaging system.

# Usage

Run in the background to start a containerized NATS server:

```PowerShell
docker run -d --name nats sixeyed/nats
```

Other containers in the Docker network can work with the server using hostname `nats` and port `4222`.

You can [telnet](http://nats.io/documentation/internals/nats-protocol-demo/) into the container using its IP address.