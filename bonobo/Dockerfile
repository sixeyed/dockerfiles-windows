# escape=`
FROM microsoft/windowsservercore
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# Wait-Service is a tool from Microsoft for monitoring a Windows Service
ADD https://raw.githubusercontent.com/Microsoft/Virtualization-Documentation/live/windows-server-container-tools/Wait-Service/Wait-Service.ps1 /

# Install Windows features for IIS
RUN Add-WindowsFeature Web-server, NET-Framework-45-ASPNET, Web-Asp-Net45

ENV BONOBO_VERSION="5.2"
ENV BONOBO_DOWNLOAD_VERSION="5_2_0"
WORKDIR c:/setup

# Download & extract
RUN iwr -outfile bonobo.zip "https://bonobogitserver.com/resources/releases/$($env:BONOBO_DOWNLOAD_VERSION).zip"; `
    Add-Type -AssemblyName System.IO.Compression.FileSystem; `
    [System.IO.Compression.ZipFile]::ExtractToDirectory('c:\setup\bonobo.zip', 'c:\'); `
    mv "c:\$($env:BONOBO_VERSION)" c:\bonobo; `
    rm bonobo.zip

# Set up website
RUN New-Website -Name 'bonobo' -PhysicalPath "C:\bonobo" -Port 9000 -Force

EXPOSE 9000
VOLUME c:/data c:\repositories

COPY Web.config c:/bonobo/Web.config

CMD /Wait-Service.ps1 -ServiceName W3SVC -AllowServiceRestart

#RUN $acl = Get-Acl 'C:\repositories\'; `
#    $rule = New-Object System.Security.AccessControl.FileSystemAccessRule('ContainerAdministrator', 'FullControl', 'ContainerInherit,ObjectInherit', 'None', 'Allow'); `
#    $acl.SetAccessRule($rule); `
#    Set-Acl 'C:\repositories\' $acl




