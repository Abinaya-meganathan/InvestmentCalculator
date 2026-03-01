FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 10000

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy the .csproj from the subfolder
COPY ["InvestmentCalculator/InvestmentCalculator.csproj", "InvestmentCalculator/"]
RUN dotnet restore "InvestmentCalculator/InvestmentCalculator.csproj"

# Copy everything else
COPY . .
WORKDIR "/src/InvestmentCalculator"
RUN dotnet publish "InvestmentCalculator.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .

# Render uses port 10000
ENV ASPNETCORE_URLS=http://+:10000

ENTRYPOINT ["dotnet", "InvestmentCalculator.dll"]