import ballerinax/alfresco;
import ballerina/io;

configurable string username = ?;
configurable string password = ?;
configurable string serviceURL = ?;

alfresco:Client alfrescoClient = check new ({
    auth: {
        username,
        password
    }
}, serviceURL);


public function main() returns error? {
    byte[]|() fileContent = check alfrescoClient->getNodeContent("2efad685-c47e-44e4-bad6-85c47ea4e473");
    if fileContent is () {
        return error("No content found for nodeId");
    }

    alfresco:NodeEntry nodeResponse = check alfrescoClient->getNode("2efad685-c47e-44e4-bad6-85c47ea4e473");
    string fileName = nodeResponse.entry.name;

    check io:fileWriteBytes(fileName, fileContent);
    io:println(string `File "${fileName}" downloaded successfully.`);
}
