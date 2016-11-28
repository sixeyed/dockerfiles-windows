# openssl

Windows Server Core image with Apache [httpd](http://httpd.apache.org/) installed.

> Note. This image has only been tested with the Apache tools - [ab](https://httpd.apache.org/docs/current/programs/ab.html), [htpasswd](https://httpd.apache.org/docs/current/programs/htpasswd.html) etc. It has not been tested as a web server.

# Usage

E.g. to generate a [encrypted password file for a secure Docker registry](http://rossillo.net/a-secure-docker-2-0-registry-with-basic-authentication-2/#.WDwyLFyaGUm):

```PowerShell
mkdir auth

docker run --rm sixeyed/httpd:windowsservercore `
       htpasswd -b -n -B `
       elton d0cker > auth\registry.htpasswd
```

That will generate `registry.htpasswd` with a single credential entry, something like:

```
elton:$2y$05$saIVQ.pV.9EPOsLpNP04puj0Mf9r2wMHeGg/XViGhPfdoxb1oaCPO
```
