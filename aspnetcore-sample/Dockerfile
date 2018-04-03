#builder stage
FROM microsoft/aspnetcore-build:2.0 AS builder
WORKDIR /src
COPY HelloWorld/HelloWorld.csproj .
RUN dotnet restore 
COPY HelloWorld/ .
RUN dotnet publish -c Release -o /app

#app stage
FROM microsoft/aspnetcore:2.0
WORKDIR /app
EXPOSE 80
ENTRYPOINT ["dotnet", "HelloWorld.dll"]
COPY --from=builder /app .