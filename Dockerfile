FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /app
COPY Container-App/Container-App.csproj .
RUN dotnet restore Container-App.csproj
COPY ./Container-App .
RUN dotnet build Container-App.csproj -c Release -o /out

FROM mcr.microsoft.com/dotnet/aspnet:5.0 AS runtime
WORKDIR /app
COPY --from=build /out ./
ENTRYPOINT ["dotnet", "Container-App.dll"]