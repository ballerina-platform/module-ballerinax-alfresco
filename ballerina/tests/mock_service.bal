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
import ballerina/test;

// Mock Alfresco server
listener http:Listener mockAlfresco = new (9090);

service /alfresco/api/\-default\-/'public/alfresco/versions/'1  on mockAlfresco {
    // Mock updateNodeContent endpoint
    resource function put nodes/[string nodeId]/content(http:Request request) returns http:Response {
        http:Response response = new;

        if nodeId == "invalid-node" {
            response.statusCode = 404;
            json errorPayload = {
                "error": {
                    "errorKey": "framework.exception.EntityNotFound",
                    "statusCode": 404,
                    "briefSummary": "The node could not be found",
                    "stackTrace": "For security reasons the stack trace is no longer displayed",
                    "descriptionURL": "https://api-explorer.alfresco.com"
                }
            };
            response.setJsonPayload(errorPayload);
            return response;
        }

        json successPayload = {
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
        response.setJsonPayload(successPayload);
        return response;
    }

    // Mock getNodeContent endpoint
    resource function get nodes/[string nodeId]/content(http:Request request) returns http:Response {
        http:Response response = new;

        if nodeId == "invalid-node" {
            response.statusCode = 404;
            json errorPayload = {
                "error": {
                    "errorKey": "framework.exception.EntityNotFound",
                    "statusCode": 404,
                    "briefSummary": "The node could not be found",
                    "stackTrace": "For security reasons the stack trace is no longer displayed",
                    "descriptionURL": "https://api-explorer.alfresco.com"
                }
            };
            response.setJsonPayload(errorPayload);
            return response;
        }

        response.setBinaryPayload(TEST_CONTENT_BYTES);
        return response;
    }
}

@test:BeforeSuite
function startMockServer() returns error? {
    check mockAlfresco.'start();
}

@test:AfterSuite
function stopMockServer() returns error? {
    check mockAlfresco.gracefulStop();
}
