# Introduction
This document introduces our Node.js server specifically engineered to host the output of the flutter build web command from Flutter. The system was designed with the aim of facilitating a smooth and efficient hosting environment for web applications developed with Flutter.
## architecture
The Node.js server processes the flutter web data and publishes this to internet, so that the web app can be accessed by the user. 
## technologies
Node.js is an open-source, cross-platform JavaScript runtime environment that executes JavaScript code outside a web browser. It is recognized for its event-driven, non-blocking I/O model, which contributes to its efficiency and lightweight nature. Our decision to use Node.js as our server environment was motivated by these performance attributes, in addition to its compatibility with a wide array of technologies, including Flutter.
## flutter build web
Flutter, a UI toolkit developed by Google, enables the creation of natively compiled applications for web, mobile, and desktop platforms from a single codebase. The flutter build web command is an integral part of this toolkit, as it compiles Dart code into JavaScript. This compiled JavaScript code is what our Node.js server is configured to serve.
## hosting
the web app is hosted on azure. The deployment is done with github actions. The deployment is done with the following steps:
1. the flutter build web command is executed
2. the output of the flutter build web command is copied to the server
3. the server is restarted
4. the server is ready to serve the web app
5. the web app is served