# Kibana

Windows Server Core image for [Kibana](https://www.elastic.co/products/kibana).

# Usage

Assumes you're running Elasticsearch in a container called `elasticsearch`, e.g.

```
docker container run -d -p 9200:9200 -p 9300:9300 -m 2G --name elasticsearch sixeyed/elasticsearch:nanoserver
```

Run in the background to start a containerized Kibana node:

```PowerShell
docker container run -d -p 5601:5601 --name kibana sixeyed/kibana
```

And open the homepage:

```PowerShell
$ip = docker inspect -f '{{ .NetworkSettings.Networks.nat.IPAddress }}' kibana
start "http://$($ip):5601"
```

