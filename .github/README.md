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
