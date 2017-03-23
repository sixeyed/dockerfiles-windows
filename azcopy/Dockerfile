# escape=`
FROM microsoft/windowsservercore
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

RUN Invoke-WebRequest -OutFile C:\azcopy.msi "http://aka.ms/downloadazcopy" -UseBasicParsing; `
    Start-Process msiexec.exe -ArgumentList '/i', 'C:\azcopy.msi', '/quiet', '/norestart' -NoNewWindow -Wait; `
    Remove-Item C:\azcopy.msi

WORKDIR "C:\Program Files (x86)\Microsoft SDKs\Azure\AzCopy"
ENTRYPOINT ["AzCopy.exe"]
CMD ["/?"]