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

