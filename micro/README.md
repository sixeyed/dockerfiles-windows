# Micro

[Micro](https://github.com/zyedidia/micro) is a command-line text editor.

## Usage

This runs Micro, opening the `hosts` file in the container:

```
docker container run -it `
  sixeyed/micro `
  'micro c:\Windows\System32\drivers\etc\hosts'
```

Then `Ctrl-Q` to exit. And hit enter afterwards, because the console doesn't refresh once the container exits.

## Add to your Docker image

Use the published [sixeyed/micro]() image to bring `micro.exe` into your app in the Dockerfile:

```
# escape=`
FROM sixeyed/micro:1.4.0-nanoserver-sac2016 AS micro

FROM microsoft/windowsservercore

# other stuff

COPY --from=micro C:\micro C:\micro

RUN $env:PATH = $env:MICRO_PATH + ';' + $env:PATH; `
	setx PATH $env:PATH /M
```

Now you can run `micro` in your container.
