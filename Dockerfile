FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 10000

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY ["InvestmentCalculator/InvestmentCalculator.csproj", "InvestmentCalculator/"]
RUN dotnet restore "InvestmentCalculator/InvestmentCalculator.csproj"
COPY . .
WORKDIR "/src/InvestmentCalculator"
RUN dotnet build "InvestmentCalculator.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "InvestmentCalculator.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENV ASPNETCORE_URLS=http://+:10000
ENTRYPOINT ["dotnet", "InvestmentCalculator.dll"]