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
import ballerina/mime;

listener http:Listener mockListener = new (9090);

service /documents on mockListener {
    resource function post upload(http:Request request) returns json|error {
        mime:Entity[] bodyParts = check request.getBodyParts();
        string nodeId = "";
        string name = "";

        foreach mime:Entity part in bodyParts {
            if part.getContentId() == "nodeId" {
                nodeId = check part.getText();
            } else if part.getContentId() == "name" {
                name = check part.getText();
            }
        }

        return {
            "id": "mock-node-123",
            "name": name,
            "createdByUser": {
                "id": "admin",
                "displayName": "Administrator"
            }
        };
    }

    resource function get download(string nodeId) returns http:Response {
        http:Response response = new;
        if nodeId != "mock-node-123" {
            http:Response notFound = new;
            notFound.statusCode = 404;
            notFound.setPayload("Document not found");
            return notFound;
        }

        response.setHeader("Content-Type", "application/pdf");
        response.setHeader("Content-Disposition", "inline; filename=\"test-document.pdf\"");
        response.setPayload("Mock PDF content".toBytes());
        return response;
    }

    resource function get download/attachment(string nodeId) returns http:Response {
        http:Response response = new;
        if nodeId != "mock-node-123" {
            http:Response notFound = new;
            notFound.statusCode = 404;
            notFound.setPayload("Document not found");
            return notFound;
        }

        response.setHeader("Content-Type", "application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=\"test-document.pdf\"");
        response.setPayload("Mock PDF content".toBytes());
        return response;
    }
}
