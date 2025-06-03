# Examples

The `ballerinax/alfresco` connector provides practical examples illustrating usage in various scenarios. Explore these [examples](https://github.com/ballerina-platform/module-ballerinax-alfresco/tree/main/examples), covering the following Alfresco use cases:

1. [Upload a Document](https://github.com/ballerina-platform/module-ballerinax-alfresco/tree/main/examples/upload-document) - Create a new file in Alfresco and upload content to it under a specific folder or path.
2. [Download a Document](https://github.com/ballerina-platform/module-ballerinax-alfresco/tree/main/examples/download-document) - Retrieve a document stored in Alfresco.

## Prerequisites

1. Retrieve username, password and service URL to authenticate the connector as described in [Setup guide](https://central.ballerina.io/ballerinax/alfresco/latest#setup-guide).
2. For each example, create a `Config.toml` file with the related configuration. Here's an example of how your `Config.toml` file should look:

```toml
username="<username>"
password="<password>"
serviceUrl="<serviceUrl>"
```

## Running an example

Execute the following commands to build an example from the source:

* To build an example:

    ```bash
    bal build
    ```

* To run an example:

    ```bash
    bal run
    ```

## Building the examples with the local module

**Warning**: Due to the absence of support for reading local repositories for single Ballerina files, the Bala of the module is manually written to the central repository as a workaround. Consequently, the bash script may modify your local Ballerina repositories.

Execute the following commands to build all the examples against the changes you have made to the module locally:

* To build all the examples:

    ```bash
    ./build.sh build
    ```

* To run all the examples:

    ```bash
    ./build.sh run
    ```
