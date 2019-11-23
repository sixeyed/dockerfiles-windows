FROM mcr.microsoft.com/dotnet/core/sdk:3.0.100 as builder

WORKDIR /src/whoami
COPY src/whoami/whoami.csproj .
RUN dotnet restore

COPY src /src
RUN dotnet publish -c Release -o /out whoami.csproj

# app image
FROM  mcr.microsoft.com/dotnet/core/aspnet:3.0

EXPOSE 80

WORKDIR /reference-data-api
ENTRYPOINT ["dotnet", "whoami.dll"]

COPY --from=builder /out/ .