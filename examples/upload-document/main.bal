// Copyright (c) 2025 WSO2 LLC. (http://www.wso2.com).
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

import ballerinax/alfresco;
import ballerina/io;

configurable string username = ?;
configurable string password = ?;
configurable string serviceUrl = ?;

alfresco:Client alfrescoClient = check new ({
    auth: {
        username,
        password
    }
}, serviceUrl);


public function main() returns error? {
    string nodeId = "-root-";
    string name = "hello.txt";
    string filePath = "resources/hello.txt";

    byte[] fileContent = check io:fileReadBytes(filePath);

    alfresco:NodeBodyCreate payload = {
        name: name,
        nodeType: "cm:content",
        aspectNames: ["cm:titled"],
        properties: {
            "cm:title": name
        }
    };

    alfresco:NodeEntry createdNode = check alfrescoClient->createNode(nodeId, payload);
    alfresco:NodeEntry alfrescoNodeEntryResult = check alfrescoClient->updateNodeContent(createdNode.entry.id, fileContent);

    io:println({
        id: alfrescoNodeEntryResult.entry.id,
        name: alfrescoNodeEntryResult.entry.name,
        createdByUser: {
            id: alfrescoNodeEntryResult.entry.createdByUser.id,
            displayName: alfrescoNodeEntryResult.entry.createdByUser.displayName
        }
    });
}
