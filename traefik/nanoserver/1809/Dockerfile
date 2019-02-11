# uses Server Core at netapi32.dll not in Nano Server 1809
# usage
#  docker container run -d -p 80 -p 8080 -v \\.\pipe\docker_engine:\\.\pipe\docker_engine sixeyed/traefik:v1.7.8-windowsservercore-ltsc2019 --api --docker --docker.endpoint=npipe:////./pipe/docker_engine --logLevel=DEBUG
FROM mcr.microsoft.com/windows/nanoserver:1809

COPY --from=traefik:v1.7.8-nanoserver-sac2016 /traefik.exe /traefik.exe

EXPOSE 80
ENTRYPOINT ["/traefik"]

# Metadata (copied from official Traefik image)
LABEL org.label-schema.vendor="Containous" \
      org.label-schema.url="https://traefik.io" \
      org.label-schema.name="Traefik" \
      org.label-schema.description="A modern reverse-proxy" \
      org.label-schema.version="v1.7.8" \
      org.label-schema.docker.schema-version="1.0"

