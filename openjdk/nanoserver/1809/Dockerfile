## modified from official image 
## https://github.com/docker-library/openjdk/blob/7d6b0528da55c7b74feff4f565c9dbb8907b8c9a/10/jdk/windows/nanoserver-sac2016/Dockerfile
FROM mcr.microsoft.com/windows/servercore:1809 AS installer
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ARG JAVA_HOME="C:\ojdkbuild"
ARG JAVA_VERSION="10.0.2"
ARG JAVA_OJDKBUILD_VERSION="10.0.2-1"
ARG JAVA_OJDKBUILD_ZIP="java-10-openjdk-10.0.2-1.b13.ojdkbuild.windows.x86_64.zip"
ARG JAVA_OJDKBUILD_SHA256="39801db76f04b9f1491b0d0a64258535f14e319a3cd08d3e161b18a6af7a842d"

RUN $url = ('https://github.com/ojdkbuild/ojdkbuild/releases/download/{0}/{1}' -f $env:JAVA_OJDKBUILD_VERSION, $env:JAVA_OJDKBUILD_ZIP); \
	Write-Host ('Downloading {0} ...' -f $url); \
	[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; \
	Invoke-WebRequest -Uri $url -OutFile 'ojdkbuild.zip'; \
	Write-Host ('Verifying sha256 ({0}) ...' -f $env:JAVA_OJDKBUILD_SHA256); \
	if ((Get-FileHash ojdkbuild.zip -Algorithm sha256).Hash -ne $env:JAVA_OJDKBUILD_SHA256) { \
		Write-Host 'FAILED!'; \
		exit 1; \
	}; \
	\
	Write-Host 'Expanding ...'; \
	Expand-Archive ojdkbuild.zip -DestinationPath C:\; \
	\
	Write-Host 'Renaming ...'; \
	Move-Item \
		-Path ('C:\{0}' -f ($env:JAVA_OJDKBUILD_ZIP -Replace '.zip$', '')) \
		-Destination $env:JAVA_HOME \
	;

# openjdk
FROM mcr.microsoft.com/windows/nanoserver:1809

ARG JAVA_HOME="C:\ojdkbuild"
ARG JAVA_VERSION="10.0.2"
ARG JAVA_OJDKBUILD_VERSION="10.0.2-1"

ENV JAVA_HOME ${JAVA_HOME}
ENV JAVA_VERSION ${JAVA_VERSION}
ENV JAVA_OJDKBUILD_VERSION ${JAVA_OJDKBUILD_VERSION}

USER ContainerAdministrator
RUN setx /M PATH "%PATH%;%JAVA_HOME%\bin"
CMD ["jshell"]

COPY --from=installer ${JAVA_HOME} ${JAVA_HOME}