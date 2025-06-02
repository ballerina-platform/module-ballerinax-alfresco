import ballerinax/alfresco;
import ballerina/io;

configurable string username = ?;
configurable string password = ?;
configurable string serviceURL = ?;
configurable string nodeId = ?;

alfresco:Client alfrescoClient = check new ({
    auth: {
        username,
        password
    }
}, serviceURL);


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
