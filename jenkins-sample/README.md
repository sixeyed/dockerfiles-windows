# Jenkins Sample

Jenkins uses a plug-in model for additional features. Plug-ins may have dependencies that need to be installed outside of Jenkins.

This is a sample image that builds from [sixeyed/jenkins](https://github.com/sixeyed/dockerfiles-windows/tree/master/jenkins) and adds the Git and Docker clients, to support Jenkins plugins like [Git](https://plugins.jenkins.io/git) and [Docker Build & Push](https://github.com/jenkinsci/docker-build-publish-plugin/blob/master/README.md).

## Usage

This is a Windows Server Core image. It will run on Docker in Windows 10 or Windows Server 2016.

You can test out the latest version with:

```
docker run -d -p 8080:8080 sixeyed/jenkins-sample
```

Then browse to _http://CONTAINER-IP:8080_. The startup credentials are in the logs for your Jenkins container.

You'll probably want to run a specific version, and have the data files stored on the host:

```
docker run -d -p 8080:8080 -v c:\jenkins:c:\data sixeyed/jenkins-sample:2.46.2_git-2.13.0_docker-17.05.0-ce
```

### Notes

Volume mounts on Windows can be fiddly - they're presented to the container as a symlink directory, and apps may not behave correctly if they try to follow the symlink. 

In this image I create a volume at `c:\data` which is what you use from outside the container (e.g. to mount a host path). Inside the container that path is mapped as the `G:` drive, and Jenkins is configured to write data to `G:`. The drive isn't presented as a symlink, so the app just writes to the path directly and doesn't hit any symlink issues.