# Umbraco Demo

Run a stock [Umbraco instance in a Docker container](../umbraco/README.md), add your website content, export the data and build it into a new Docker image.

The new image is Umbraco pre-configured with your website.

## Setup 

```
docker run -d -P --name umbraco sixeyed/umbraco
```

This runs a clean, new instance of Umbraco in a container. Then `docker inspect umbraco` to get the IP address, browse to it and you'll see the usual Umbraco setup screens. Install Umbraco with the SQL Server CE option, and set up your website. 

When you have your content ready, copy the content out of the Docker container onto the host. Use the `Umbraco` folder in this repo:

```
docker cp umbraco:C:\inetpub\wwwroot\Umbraco .\Umbraco
```

Now build your custom image:

```
docker build -t my-umbraco-site .
```

That's it. `docker run -d -p 80:80 my-umbraco-site` will run your site with port 80 published, so it's accessible from the outside world.

## Alternative Approach

You can try to run Umbraco in a Docker container, using the content stored on a host mount.

That would let you construct your website by using Umbraco in the container, using a local SQL CE database file. Then you could build the custom website into an image, using the same [Dockerfile], but skipping the `docker cp` step.

Umbraco needs lots of [write permissions](https://our.umbraco.org/documentation/getting-started/setup/install/permissions) which makes it complicated. You can run a Docker container with a website set up pointing to an empty directory `C:\inetpub\wwwroot\Umbraco`, and mount that path from the host.

Umbraco will start in that secnario, but you can't complete installation with SQL Server CE - it fails to create the database file. It seems SQL CE resolves the full path of the file, which for a mount means a long file name ampped to the host path, and then it errors on the size of the name. Even with the hack to present the volume as the 'G:' drive on the container, it fails in the same way.