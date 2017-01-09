# NATS Bench

Windows Nano Server image for [NATS benchmarking tool](http://nats.io/documentation/tutorials/nats-benchmarking/). 

Use to test and tune performance of NATS running in Docker.

# Usage

Assuming you have a NATS server running in Docker - e.g. for Windows:

```
docker run -d -p 4222:4222 --name nats sixeyed/nats:nanoserver
```

Run a simple benchmark with:

```
docker run --rm sixeyed/nats-bench
```

Or tune the benchmark test by passing different command parameters:

```
docker run --rm sixeyed/nats-bench -np 5 -ns 5 -n 500000 -ms 16 n-b
```

Or pass environment variable to specify a different server:

```
docker run --rm -e NATS_SERVER=192.168.2.200 -e NATS_PORT=14222 sixeyed/nats-bench -np 1 -ns 5 -n 100000 -ms 16 n-b-2
```