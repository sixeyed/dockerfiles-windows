# escape=`
FROM sixeyed/git:2.16.3 AS git
FROM sixeyed/docker:17.06.2-ee-7 AS docker

# Jenkins
FROM sixeyed/jenkins:2.107.1
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

WORKDIR C:\git
COPY --from=git C:\git .

WORKDIR C:\docker
COPY --from=docker ["C:\\Program Files\\Docker",  "."]

RUN $env:PATH = 'C:\docker;' + 'C:\git\cmd;C:\git\mingw64\bin;C:\git\usr\bin;' + $env:PATH; `
	[Environment]::SetEnvironmentVariable('PATH', $env:PATH, [EnvironmentVariableTarget]::Machine)

ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false" `
    JENKINS_HOME="C:\jenkins-data"
 
WORKDIR C:\init
COPY init/ .
RUN ./install-plugins.ps1

COPY start.ps1 /
ENTRYPOINT /start.ps1