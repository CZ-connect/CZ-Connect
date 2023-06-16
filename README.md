# CZ-connect
This is the CZ-connect app repository. It contains the source code for the backend and frontend of the app.
READMES for each part of the app can be found in their respective folders:
- [Flutter frontend](https://github.com/CZ-connect/CZ-Connect/tree/feature/documentation/cz_app)
- [ASP.NET Core backend](https://github.com/CZ-connect/CZ-Connect/tree/feature/documentation/backend)
- [Backend test](https://github.com/CZ-connect/CZ-Connect/tree/feature/documentation/backend.tests)
- [Node server](https://github.com/CZ-connect/CZ-Connect/tree/feature/documentation/node_flutter)
- [Workflows](https://github.com/CZ-connect/CZ-Connect/tree/feature/documentation/.github)
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

## Project DevOps Workflow Summary

This document provides a summary of our automated workflows for this project. These workflows have been designed to ensure the continuous integration and deployment (CI/CD) of our software, code quality maintenance, and routine artifacts cleanup.

### .NET Tests

This workflow triggers whenever there is a push or pull request on the main or development branches. It sets up a .NET environment, restores dependencies, builds, and tests the backend .NET code.

### Coding Guidelines and Testing

This workflow is triggered upon any pull request to main or development branches. It installs Flutter, retrieves dependencies, performs various code quality checks using `dart_code_metrics`, and runs tests.

### Build and Deploy Backend to Azure

This workflow is initiated on pull requests, push events, or manual triggers (workflow_dispatch) to main or development branches. It sets up .NET Core, builds the backend application, and publishes it. It then uploads the published output as an artifact. The following job deploys this artifact to an Azure Web App.

### Build and Deploy Frontend to Azure

Like the backend deployment, this workflow triggers on pull requests, push events, or manual dispatches to main or development branches. It installs Flutter, retrieves dependencies, cleans and builds the Flutter web app. The build is then moved to a Node.js environment, where it's built and tested. The Node.js application is then uploaded as an artifact. This artifact is then deployed to an Azure Web App in the following job.

### Nightly Artifacts Cleanup

This is a scheduled job that runs every minute and purges all stored artifacts.

All of these workflows greatly contribute to keeping our codebase clean, efficient, and continuously deployable.

### Pull Request and Issue Templates

#### Pull Request Template

This template guides contributors to provide essential information when opening a pull request. It ensures that new changes are well-documented and have been tested thoroughly before merging.

#### Bug Report Template

If any contributor or user discovers a bug in the system, this template provides a structured format to report it. It ensures all necessary information to reproduce and resolve the bug is provided.

#### Feature Request Template

This template helps contributors suggest new ideas for the project in a structured manner. It ensures all necessary details are provided to understand and implement the suggested feature.

For more information, please refer to the individual workflow files.

---

**this readme is written in collaboration with ChatGPT-4, an AI developed by OpenAI.**
