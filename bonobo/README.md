# Bonobo Git Server

Bonobo is a simple Git server for Windows, written in ASP.NET. 

- [Bonobo Git Server](https://bonobogitserver.com)
- [Source Code on GitHub](https://github.com/jakubgarfield/Bonobo-Git-Server/)

## Usage

This is a Windows Server Core image. It will run on Docker in Windows 10 or Windows Server 2016.

You can test out the latest version with:

```
docker run -d -p 80:80 sixeyed/bonobo
```

Then browse to _http://CONTAINER-IP/Bonobo.Git.Server_. The default credentials are admin/admin.

You'll probably want to run a specific version of Bonobo, and have the data files stored on the host:

```
docker run -d -p 80:80 -v c:\bonobo:c:\data sixeyed/bonobo:6.1.0
```

### Notes

Volume mounts on Windows can be fiddly - they're presented to the container as a symlink directory, and apps may not behave correctly if they try to follow the symlink. 

In this image I create a volume at `c:\data` which is what you use from outside the container (e.g. to mount a host path). Inside the container that path is mapped as the `G:` drive, and Bonobo is configured to write data to `G:`. The drive isn't presented as a symlink, so the app just writes to the path directly and doesn't hit any symlink issues.