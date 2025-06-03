## Overview

[Alfresco](https://www.hyland.com/en/solutions/products/alfresco-platform) is a modern, open-source content management platform that enables organizations to manage enterprise documents, digital assets, and records with efficiency and control. Known for its scalability and compliance-ready architecture, Alfresco provides powerful capabilities such as document storage, versioning, collaboration, workflow automation, and access control. It is widely used across industries to centralize content operations, streamline business processes, and support digital transformation initiatives.

The `ballerinax/alfresco` connector offers APIs to connect and interact with the [Alfresco endpoints](https://docs.alfresco.com/content-services/6.0/develop/rest-api-guide/), specifically based on the [Alfresco REST API Version 1](https://api-explorer.alfresco.com/api-explorer/). This connector allows Ballerina applications to perform core content operations such as uploading and downloading files, managing nodes and folders, setting metadata, and handling permissions. By using the Ballerina Alfresco Connector, developers can easily integrate content services into their workflows and build automation solutions that leverage the full capabilities of the Alfresco platform.

## Setup guide

Before using this connector in your Ballerina application, complete the following:

* Create an [Alfresco Account](https://www.alfresco.com/try-alfresco-acs).
* Once registered, you will receive an email with instructions to set up your Alfresco environment, including the default username and password. Use these credentials to access the Alfresco Content Services API.
* Note: This connector only supports Basic Authentication (username/password) and does not require or support bearer tokens.

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
configurable string serviceURL = ?;

alfresco:ConnectionConfig alfrescoConfig = {
    auth: {
        username,
        password
    }
};
alfresco:Client alfresco = check new (alfrescoConfig, serviceURL);
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
