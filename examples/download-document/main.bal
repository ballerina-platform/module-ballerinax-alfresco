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
configurable string nodeId = ?;

alfresco:Client alfrescoClient = check new ({
    auth: {
        username,
        password
    }
}, serviceUrl);


public function main() returns error? {
    byte[]|() fileContent = check alfrescoClient->getNodeContent(nodeId);
    if fileContent is () {
        return error("No content found for nodeId");
    }

    alfresco:NodeEntry nodeResponse = check alfrescoClient->getNode(nodeId);
    string fileName = nodeResponse.entry.name;

    check io:fileWriteBytes(fileName, fileContent);
    io:println(string `File "${fileName}" downloaded successfully.`);
}
