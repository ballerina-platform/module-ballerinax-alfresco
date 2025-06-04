// Copyright (c) 2025, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/http;

// Mock Alfresco server
listener http:Listener mockAlfresco = new (9090);

service /alfresco/api/\-default\-/'public/alfresco/versions/'1 on mockAlfresco {
    // Mock createNode endpoint
    resource function post nodes/[string parentId]/children(http:Request request) returns NodeEntry|error {
        json payload = check request.getJsonPayload();
        if payload is () {
            return error("Invalid JSON payload in createNode");
        }
        NodeBodyCreate node = check payload.cloneWithType(NodeBodyCreate);

        return {
            "entry": {
                "id": "mock-node-id",
                "name": node.name,
                "nodeType": node.nodeType,
                "isFolder": false,
                "isFile": true,
                "modifiedAt": "2025-01-01T00:00:00.000Z",
                "modifiedByUser": {
                    "id": "admin",
                    "displayName": "Administrator"
                },
                "createdAt": "2025-01-01T00:00:00.000Z",
                "createdByUser": {
                    "id": "admin",
                    "displayName": "Administrator"
                }
            }
        };
    }

    // Mock updateNodeContent endpoint
    resource function put nodes/[string nodeId]/content(http:Request request) returns NodeEntry|http:NotFound {
        
        if nodeId == "invalid-node" {
            return {
                body: {
                    "error": {
                        "errorKey": "framework.exception.EntityNotFound",
                        "statusCode": 404,
                        "briefSummary": "The node could not be found",
                        "stackTrace": "For security reasons the stack trace is no longer displayed",
                        "descriptionURL": "https://api-explorer.alfresco.com"
                    }
                }
            };
        }

        return {
            "entry": {
                "id": nodeId,
                "name": "test.txt",
                "nodeType": "cm:content",
                "isFolder": false,
                "isFile": true,
                "modifiedAt": "2023-01-01T00:00:00.000Z",
                "modifiedByUser": {
                    "id": "admin",
                    "displayName": "Administrator"
                },
                "createdAt": "2023-01-01T00:00:00.000Z",
                "createdByUser": {
                    "id": "admin",
                    "displayName": "Administrator"
                }
            }
        };
    }

    // Mock getNodeContent endpoint
    resource function get nodes/[string nodeId]/content(http:Request request) returns byte[]|http:NotFound {
        if nodeId == "invalid-node" {
            return {
                body: {
                    "error": {
                        "errorKey": "framework.exception.EntityNotFound",
                        "statusCode": 404,
                        "briefSummary": "The node could not be found",
                        "stackTrace": "For security reasons the stack trace is no longer displayed",
                        "descriptionURL": "https://api-explorer.alfresco.com"
                    }
                }
            };
        }
        return TEST_CONTENT_BYTES;
    }
}
