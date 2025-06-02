# Download a document

This example demonstrates how Alfresco REST API v1 can be utilized to retrieve a document stored in Alfresco.

## Prerequisites

### 1. Setup Alfresco account

Refer to the [Setup guide](https://central.ballerina.io/ballerinax/alfresco/latest#setup-guide) to set up your Alfresco
environment, if you do not have one.

### 2. Configuration

Update your Alfresco account-related configurations in the `Config.toml` file in the example root directory:

```toml
username="<username>"
password="<password>"
serviceURL="<serviceURL>"
nodeId="<nodeId>"
```

## Run the example

Execute the following command to run the example:

```ballerina
bal run
```