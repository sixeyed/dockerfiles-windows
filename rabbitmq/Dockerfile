FROM microsoft/windowsservercore

# erlang installer download url
ENV erlang_download_url "http://erlang.org/download/otp_win64_19.3.exe"

# erlang will install to this location and rabbitmq will use this environment variable to locate it
ENV ERLANG_HOME c:\\erlang

# rabbitmq version used in download url and to rename folder extracted from zip file
ENV rabbitmq_version "3.6.9"

# rabbitmq zip package download url
ENV rabbit_download_url "https://www.rabbitmq.com/releases/rabbitmq-server/v3.6.9/rabbitmq-server-windows-$rabbitmq_version.zip"

# setup powershell options for RUN commands
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

# download and install erlang using silent install option, and remove installer when done
RUN Invoke-WebRequest -Uri $env:erlang_download_url -OutFile erlang_install.exe ; \
        Start-Process -Wait -FilePath .\erlang_install.exe -ArgumentList /S, /D=$env:ERLANG_HOME ; \
        Remove-Item -Force erlang_install.exe

# download and extract rabbitmq, and remove zip file when done
RUN Invoke-WebRequest -Uri $env:rabbit_download_url -OutFile rabbitmq.zip ; \
        Expand-Archive -Path .\rabbitmq.zip -DestinationPath "c:\\" ; \
        Remove-Item -Force rabbitmq.zip

# remove version from rabbitmq folder name
RUN Rename-Item c:\rabbitmq_server-$env:rabbitmq_version c:\rabbitmq

# enable managment plugin
RUN c:\rabbitmq\sbin\rabbitmq-plugins.bat enable rabbitmq_management --offline

# tell rabbitmq where to find our custom config file
ENV RABBITMQ_CONFIG_FILE "c:\rabbitmq"
RUN ["cmd", "/c", "echo [{rabbit, [{loopback_users, []}]}].> c:\\rabbitmq.config"]

# run server when container starts - container will shutdown when this process ends
CMD "c:\rabbitmq\sbin\rabbitmq-server.bat"