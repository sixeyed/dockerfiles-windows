# nginx

Windows Server Core image with Nginx installed.

# Notes

Nginx isn't tweaked for Windows in the way it is for Linux. It is functional but doesn't have the performance and scale - it's considered a [beta version](http://nginx.org/en/docs/windows.html).

# Run Nginx

Run as-is:

```PowerShell
docker run -d -p 80:80 --name nginx sixeyed/nginx:windowsservercore
```

And get the IP address of the container to view the welcome screen:

```PowerShell
$ip = docker inspect --format '{{ .NetworkSettings.Networks.nat.IPAddress }}' nginx
start "http://$($ip)" 
```

# Use as a Base

Add your own content into `C:\nginx\html`:

```Dockerfile
FROM sixeyed/nginx:windowsservercore

COPY index.html C:/nginx/html
```

> Note. You can't mount a host directory to `C:\nginx\html` in the container, because the container directory isn't empty. That's one difference between Windows and Linux containers.