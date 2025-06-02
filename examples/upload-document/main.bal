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
