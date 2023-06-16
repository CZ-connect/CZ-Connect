# connect
This is the CZ-connect app repository. It contains the source code for the backend and frontend of the app.
READMES for each part of the app can be found in their respective folders:
- [Flutter frontend](https://github.com/CZ-connect/CZ-Connect/tree/feature/documentation/cz_app)
- [ASP.NET Core backend](https://github.com/CZ-connect/CZ-Connect/tree/feature/documentation/backend)
- [Backend test](https://github.com/CZ-connect/CZ-Connect/tree/feature/documentation/backend.tests)
- [Node server](https://github.com/CZ-connect/CZ-Connect/tree/feature/documentation/node_flutter)
# Development
## Prerequisites
- [Flutter](https://flutter.dev/docs/get-started/install)
- [Dart](https://dart.dev/get-dart)
- [Node.js](https://nodejs.org/en/download/)
- [ASP.NET Core](https://dotnet.microsoft.com/download)
- [Visual Studio Code](https://code.visualstudio.com/download) (recommended)

## Installation
1. Clone the repository
2. Open the repository in Visual Studio Code
3. Open the terminal in Visual Studio Code
4. Run `cd cz_app && flutter pub get` to install the Flutter dependencies
5. Run `cd node_flutter && npm install` to install the Node dependencies
6. Run `cd backend && docker compose up --build` to install the ASP.NET Core dependencies

# Development testing bages
[![.NET Tests](https://github.com/CZ-connect/CZ-Connect/actions/workflows/backend_tests.yml/badge.svg)](https://github.com/CZ-connect/CZ-Connect/actions/workflows/backend_tests.yml)
[![Coding guidelines and Testing](https://github.com/CZ-connect/CZ-Connect/actions/workflows/dart_code_guidelines.yml/badge.svg)](https://github.com/CZ-connect/CZ-Connect/actions/workflows/dart_code_guidelines.yml)
[![Build and deploy ASP.Net Core app to Azure Web App - flutter-backend](https://github.com/CZ-connect/CZ-Connect/actions/workflows/feature-deployment_flutter-backend.yml/badge.svg?branch=development)](https://github.com/CZ-connect/CZ-Connect/actions/workflows/feature-deployment_flutter-backend.yml)
[![Build and deploy Node.js app to Azure Web App - flutter-frontend](https://github.com/CZ-connect/CZ-Connect/actions/workflows/feature-deployment_flutter-frontend.yml/badge.svg)](https://github.com/CZ-connect/CZ-Connect/actions/workflows/feature-deployment_flutter-frontend.yml)

## Docker Compose Summary and Usecases

This project employs Docker Compose to define and manage the multi-container Docker application. The services outlined in the `docker-compose.yml` file include `czconnect-backend` and `mssql-db`.

```yaml
version: '3'

services:
  czconnect-backend:
    container_name: czconnect-backend
    image: czfluttercontainers.azurecr.io/czconnect-backend:latest
    build:
      context: backend
      dockerfile: Dockerfile-backend
    env_file:
      - backend/.env
    ports:
      - 3000:3000
    networks:
      - czconnect

  mssql-db:
    container_name: mssql-db
    image: czfluttercontainers.azurecr.io/mssql-db:latest
    build:
      context: backend
      dockerfile: Dockerfile-mssql
    ports:
      - 1433:1433
    environment:
      - ACCEPT_EULA=Y
      - MSSQL_SA_PASSWORD=3Q%8C7`5e_dXZ#H
    volumes:
      - mssql:/var/opt/mssql/data
    networks:
      - czconnect

networks:
  czconnect:

volumes:
  mssql:
```

### czconnect-backend
This service represents the backend of the CZ-connect application. It uses the image czfluttercontainers.azurecr.io/czconnect-backend:latest. The build context is specified as backend, and it uses the Dockerfile Dockerfile-backend for building. It exposes port 3000. Environment variables are loaded from a .env file in the backend directory.

### mssql-db
This service is the Microsoft SQL Server database for the application. It uses the image czfluttercontainers.azurecr.io/mssql-db:latest. The build context is specified as backend, and it uses the Dockerfile Dockerfile-mssql for building. It exposes port 1433 and uses an environment variable to accept the EULA and set the password for the sa account. The service stores its data in a Docker volume named mssql.

Both services are attached to a common network named czconnect, enabling them to communicate with each other.

You can use the command docker-compose up --build to bring up the entire stack, including the backend service and the database.

This Docker Compose setup streamlines the management of application services, simplifies the application setup process for developers, and facilitates the consistent performance of the application across various environments.
