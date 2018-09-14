# escape=`
FROM microsoft/dotnet:2.1-sdk-nanoserver-sac2016 as builder

WORKDIR /src/whoami
COPY src/whoami/whoami.csproj .
RUN dotnet restore

COPY src /src
RUN dotnet publish -c Release -o /out whoami.csproj

# app image
FROM microsoft/dotnet:2.1-aspnetcore-runtime-nanoserver-sac2016

EXPOSE 80

WORKDIR /reference-data-api
ENTRYPOINT ["dotnet", "whoami.dll"]

COPY --from=builder /out/ .