# Jenkins - Presentations

Jenkins is an automation server - for CI/CD, scheduled jobs etc.

- [Jenkins](https://jenkins.io/)
- [Source Code on GitHub](https://github.com/jenkinsci/jenkins)

## Usage

This is a configured Jenkins image running on Windows Server Core. It will run on Docker in Windows 10 or Windows Server 2016.

It has clients installed for Docker and Git, and a core set of [plugins](windowsservercore/plugins.txt). You can test out the latest version with:

```
docker run -d -p 8080:8080 sixeyed/jenkins:presentations
```

Then browse to _http://CONTAINER-IP:8080_. The startup credentials are in the logs for your Jenkins container.

> I use this for short-lived Jenkins servers (for presentations), so this version does not use a Docker volume and the data is lost when you remove your container.
