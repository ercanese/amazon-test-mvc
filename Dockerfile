FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app
COPY . .

RUN dotnet restore Project.sln
RUN dotnet build Project.sln
RUN dotnet publish  Project.sln -c Release -o pub/

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS Release
WORKDIR /app
COPY --from=build /app/pub/ .
EXPOSE 80
ENTRYPOINT ["dotnet","mvcapp.dll"]