import ballerina/http;
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


public function main() returns byte[]|error? {
    http:Response response = new;
        
    byte[]|() fileContent = check alfrescoClient->getNodeContent(nodeId);
    if fileContent is () {
        return error("No content found for nodeId");
    }

    alfresco:NodeEntry nodeResponse = check alfrescoClient->getNode(nodeId);
    string fileName = nodeResponse.entry.name;

    response.setHeader("Content-Type", "application/pdf");
    response.setHeader("Content-Disposition", string `attachment; filename="${fileName}"`);
    response.setBinaryPayload(fileContent);

    return response;
}
