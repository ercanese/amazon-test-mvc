FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app
COPY . .

RUN dotnet restore
RUN dotnet build
RUN dotnet publish -c Release -o pub/

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS Release
WORKDIR /app
COPY --from=build /app/pub/ .
EXPOSE 80
ENTRYPOINT ["dotnet","Mvc.dll"]