# escape=`
FROM microsoft/nanoserver
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop';"]

EXPOSE 5000
ENV REGISTRY_STORAGE_FILESYSTEM_ROOTDIRECTORY=c:\\data

# REMARK. There is an issue with Go 1.7 and Windows 2016 SYMLINKD directories which causes Docker volumes and host mounts to fail. 
# This registry build uses a custom build of Go (@0bae74e) from the master branch to fix - https://github.com/golang/go/issues/15978
# Registry version is tag v2.6.0-rc.1

WORKDIR c:\\registry
COPY ./registry/ .

CMD ["registry", "serve", "config.yml"]