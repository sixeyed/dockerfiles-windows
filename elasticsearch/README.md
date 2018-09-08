# Elasticsearch

Windows Server Core and Nano Server images for [Elasticsearch](http://elastic.co).

> Ths images uses version 5.6 of Elasticsearch. [Later versions do not work with Docker volumes in Windows containers](https://github.com/elastic/elasticsearch/issues/28590). 

> They also specify very small memory allocations (see the `ES_JAVA_OPTS` environment variable in the [Dockerfile](./nanoserver/sac2016/Dockerfile), so they're suitable for dev. You should override that value for more realistic environments.

# Usage

Run in the background to start a containerized Elasticsearch node:

```PowerShell
docker container run -d -p 9200:9200 -p 9300:9300 --name elasticsearch sixeyed/elasticsearch:nanoserver
```
Other containers in the Docker network can work with the server using hostname `elasticsearch` and port `9200`.

You can query the [Elasticsearch API](https://www.elastic.co/guide/en/elasticsearch/reference/current/_cluster_health.html) from the container host using its IP address:

```PowerShell
$ip = docker container inspect -f '{{ .NetworkSettings.Networks.nat.IPAddress }}' elasticsearch
iwr "http://$($ip):9200"
```

# Persisting data

The image uses a Docker volume at `c:\data` to store the Elasticsearch data. To store data on the host instead, mount the host directory when you run a container:

```PowerShell
docker container run -d -p 9200:9200 -p 9300:9300 -v c:\es-data:c:\data --name elasticsearch sixeyed/elasticsearch:nanoserver
```

## JVM Memory Allocation

Running a container may fail on **Windows 10** hosts if they don't have enough RAM. The Hyper-V container doesn't allocate enough memory for the JVM and you'll see an error in the container logs:

```
Error occurred during initialization of VM
Could not reserve enough space for object heap
```

This doesn't happen with the Nano Server image, but it does with the Windows Server Core image on Windows 10. You can force the memory allocation using the `--memory` option. On my 8GB Surface I find 2GB is enough to get Elasticsearch running:

```
docker container run -d -p 9200:9200 -p 9300:9300 -m 2G --name elasticsearch sixeyed/elasticsearch:windowsservercore
```

> Windows Server 2016 is fine.
