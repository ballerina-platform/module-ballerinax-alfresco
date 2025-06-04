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

import ballerina/test;
import ballerina/os;

configurable boolean isTestOnLiveServer = os:getEnv("IS_TEST_ON_LIVE_SERVER") == "true";

// Configurables
configurable string alfrescoUsername = isTestOnLiveServer ? os:getEnv("USERNAME") : "admin";
configurable string alfrescoPassword = isTestOnLiveServer ? os:getEnv("PASSWORD") : "admin";
configurable string alfrescoUrl = isTestOnLiveServer ? os:getEnv("SERVICE_URL") : "http://localhost:9090/alfresco/api/-default-/public/alfresco/versions/1";

// Common test data
final string TEST_NODE_ID = "test-node-id";
final string TEST_CONTENT = "Test content";
final byte[] TEST_CONTENT_BYTES = TEST_CONTENT.toBytes();

Client alfrescoClient = test:mock(Client);

@test:BeforeSuite
function initializeClientsForAlfrescoServer() returns error? {
    ConnectionConfig config = {
        auth: {
            username: alfrescoUsername,
            password: alfrescoPassword
        }
    };

    if (isTestOnLiveServer) {
        alfrescoClient = check new (config, alfrescoUrl);
    } else {
        alfrescoClient = check new (config, alfrescoUrl);
    }
}

@test:Config {
    groups: ["live_tests", "mock_tests"],
    enable: true
}
function testUpdateNodeContent() returns error? {
    NodeEntry response = check alfrescoClient->updateNodeContent(nodeId = TEST_NODE_ID, payload = TEST_CONTENT_BYTES);
    test:assertEquals(response.entry.id, TEST_NODE_ID, "UpdateNodeContent Failed: Node ID mismatch");
    test:assertEquals(response.entry.name, "test.txt", "UpdateNodeContent Failed: Name mismatch");
}

@test:Config {
    groups: ["live_tests", "mock_tests"],
    enable: true,
    dependsOn: [testUpdateNodeContent]
}
function testGetNodeContent() returns error? {
    byte[]? response = check alfrescoClient->getNodeContent(nodeId = TEST_NODE_ID);
    if response is byte[] {
        test:assertEquals(response, TEST_CONTENT_BYTES, "GetNodeContent Failed: Content mismatch");
    } else {
        test:assertFail("GetNodeContent Failed: No content returned");
    }
}

@test:Config {
    groups: ["mock_tests"],
    enable: true
}
function testUpdateNodeContentError() returns error? {
    string invalidNodeId = "invalid-node";
    NodeEntry|error response = alfrescoClient->updateNodeContent(nodeId = invalidNodeId, payload = TEST_CONTENT_BYTES);
    test:assertTrue(response is error, "UpdateNodeContent should fail for invalid node");
}

@test:Config {
    groups: ["mock_tests"],
    enable: true
}
function testGetNodeContentError() returns error? {
    string invalidNodeId = "invalid-node";
    byte[]|error? response = alfrescoClient->getNodeContent(nodeId = invalidNodeId);
    test:assertTrue(response is error, "GetNodeContent should fail for invalid node");
}
