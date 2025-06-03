_Author_: @SachinAkash01 \
_Created_: 29/05/2025 \
_Updated_: 29/05/2025 \
_Edition_: Swan Lake

# Sanitation for OpenAPI specification

This document records the sanitation done on top of the official OpenAPI specification from Alfresco. 
The OpenAPI specification is obtained from [Alfresco API Reference](https://api-explorer.alfresco.com/api-explorer/definitions/alfresco-core.yaml).
These changes are done in order to improve the overall usability, and as workarounds for some known language limitations.

1. Removed the Base URL because it used a relative path, and to enable users to connect to their specific Content Services instance, a unique absolute URL must be provided externally.

## OpenAPI cli command

The following command was used to generate the Ballerina client from the OpenAPI specification. The command should be executed from the repository root directory.

```bash
bal openapi -i docs/spec/openapi.yaml --mode client --license docs/license.txt --client-methods remote -o ballerina
```

The client was generated with `--client-methods remote` instead of the default resource methods to align with customer requirements and to simplify integration with Ballerina Integrator.

Note: The license year is hardcoded to 2025, change if necessary.
