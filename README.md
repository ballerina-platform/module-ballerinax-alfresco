# Ballerina Alfresco connector

[![Build](https://github.com/ballerina-platform/module-ballerinax-alfresco/actions/workflows/ci.yml/badge.svg)](https://github.com/ballerina-platform/module-ballerinax-alfresco/actions/workflows/ci.yml)
[![GitHub Last Commit](https://img.shields.io/github/last-commit/ballerina-platform/module-ballerinax-alfresco.svg)](https://github.com/ballerina-platform/module-ballerinax-alfresco/commits/master)
[![GitHub Issues](https://img.shields.io/github/issues/ballerina-platform/ballerina-library/module/alfresco.svg?label=Open%20Issues)](https://github.com/ballerina-platform/ballerina-library/labels/module%alfresco)

## Overview

[Alfresco](https://www.hyland.com/en/solutions/products/alfresco-platform) is a modern, open-source content management platform that enables organizations to manage enterprise documents, digital assets, and records with efficiency and control. Known for its scalability and compliance-ready architecture, Alfresco provides powerful capabilities such as document storage, versioning, collaboration, workflow automation, and access control. It is widely used across industries to centralize content operations, streamline business processes, and support digital transformation initiatives.

The `ballerinax/alfresco` connector offers APIs to connect and interact with the [Alfresco endpoints](https://docs.alfresco.com/content-services/6.0/develop/rest-api-guide/), specifically based on the [Alfresco REST API Version 1](https://api-explorer.alfresco.com/api-explorer/). This connector allows Ballerina applications to perform core content operations such as uploading and downloading files, managing nodes and folders, setting metadata, and handling permissions. By using the Ballerina Alfresco Connector, developers can easily integrate content services into their workflows and build automation solutions that leverage the full capabilities of the Alfresco platform.

## Setup guide

Before using this connector in your Ballerina application, complete the following:

* Create an [Alfresco Account](https://www.alfresco.com/try-alfresco-acs).
* Once registered, you will receive an email with instructions to set up your Alfresco environment, including the default username and password. Use these credentials to access the Alfresco Content Services API.
> **Note:** This connector only supports Basic Authentication (username/password) and does not require or support bearer tokens.

## Quickstart

To use the Alfresco connector in your Ballerina application, update the .bal file as follows:

### Step 1: Import the module
First, import the `ballerinax/alfresco` module into the Ballerina project.
```ballerina
import ballerinax/alfresco;
```

### Step 2: Create a new connector instance
Create a `alfresco:ConnectionConfig` using the Basic Authentication credentials (i.e: username and password), and initialize the connector with it.
```ballerina
configurable string username = ?;
configurable string password = ?;
configurable string serviceUrl = ?;

alfresco:ConnectionConfig alfrescoConfig = {
    auth: {
        username,
        password
    }
};
alfresco:Client alfresco = check new (alfrescoConfig, serviceUrl);
```

### Step 3: Invoke connector operation
1. Now you can use the operations available within the connector. Note that they are in the form of remote operations.

    Following is an example on how to get list of comments in a particular node.
    ```ballerina
    public function main() returns error? {
        alfresco:CommentPaging response = check alfresco->listComments(nodeId);
        log:printInfo(response.toString());
    }
    ``` 

### Step 4: Run the Ballerina application
Use the command below to run the Ballerina application
```bash
bal run
```

## Examples

The `ballerinax/alfresco` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-alfresco/tree/main/examples), covering the following use cases:

1. [Upload a Document](https://github.com/ballerina-platform/module-ballerinax-alfresco/tree/main/examples/upload-document) - Create a new file in Alfresco and upload content to it under a specific folder or path.
2. [Download a Document](https://github.com/ballerina-platform/module-ballerinax-alfresco/tree/main/examples/download-document) - Retrieve a document stored in Alfresco.

## Build from the source

### Setting up the prerequisites

1. Download and install Java SE Development Kit (JDK) version 21. You can download it from either of the following sources:

    * [Oracle JDK](https://www.oracle.com/java/technologies/downloads/)
    * [OpenJDK](https://adoptium.net/)

   > **Note:** After installation, remember to set the `JAVA_HOME` environment variable to the directory where JDK was installed.

2. Download and install [Ballerina Swan Lake](https://ballerina.io/).

3. Download and install [Docker](https://www.docker.com/get-started).

   > **Note**: Ensure that the Docker daemon is running before executing any tests.

4. Export Github Personal access token with read package permissions as follows,

    ```bash
    export packageUser=<Username>
    export packagePAT=<Personal access token>
    ```

### Build options

Execute the commands below to build from the source.

1. To build the package:

   ```bash
   ./gradlew clean build
   ```

2. To run the tests:

   ```bash
   ./gradlew clean test
   ```

3. To build the without the tests:

   ```bash
   ./gradlew clean build -x test
   ```

4. To run tests against different environments:

   ```bash
   ./gradlew clean test -Pgroups=<Comma separated groups/test cases>
   ```

5. To debug the package with a remote debugger:

   ```bash
   ./gradlew clean build -Pdebug=<port>
   ```

6. To debug with the Ballerina language:

   ```bash
   ./gradlew clean build -PbalJavaDebug=<port>
   ```

7. Publish the generated artifacts to the local Ballerina Central repository:

    ```bash
    ./gradlew clean build -PpublishToLocalCentral=true
    ```

8. Publish the generated artifacts to the Ballerina Central repository:

   ```bash
   ./gradlew clean build -PpublishToCentral=true
   ```

## Contribute to Ballerina

As an open-source project, Ballerina welcomes contributions from the community.

For more information, go to the [contribution guidelines](https://github.com/ballerina-platform/ballerina-lang/blob/master/CONTRIBUTING.md).

## Code of conduct

All the contributors are encouraged to read the [Ballerina Code of Conduct](https://ballerina.io/code-of-conduct).

## Useful links

* For more information go to the [`alfresco` package](https://central.ballerina.io/ballerinax/alfresco/latest).
* For example demonstrations of the usage, go to [Ballerina By Examples](https://ballerina.io/learn/by-example/).
* Chat live with us via our [Discord server](https://discord.gg/ballerinalang).
* Post all technical questions on Stack Overflow with the [#ballerina](https://stackoverflow.com/questions/tagged/ballerina) tag.
