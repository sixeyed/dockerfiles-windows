# escape=`
FROM sixeyed/git:2.15.1 AS git
FROM sixeyed/docker-ee:17.06.2-ee AS docker
FROM sixeyed/jenkins:2.89.2
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

WORKDIR C:\git
COPY --from=git C:\git .

WORKDIR C:\docker
COPY --from=docker ["C:\\Program Files\\Docker",  "."]

RUN $env:PATH = 'C:\docker;' + 'C:\git\cmd;C:\git\mingw64\bin;C:\git\usr\bin;' + $env:PATH; `
	[Environment]::SetEnvironmentVariable('PATH', $env:PATH, [EnvironmentVariableTarget]::Machine)