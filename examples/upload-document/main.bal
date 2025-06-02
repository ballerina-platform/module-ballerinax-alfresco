import ballerina/http;
import ballerinax/alfresco;
import ballerina/mime;
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


public function main() returns CustomNodeEntry|error? {
    mime:Entity[] bodyParts = check request.getBodyParts();
    mime:Entity filePart = bodyParts[0];
    byte[] fileContent = check filePart.getByteArray();

    string nodeId = "";
    string name = "";
    foreach mime:Entity part in bodyParts {
        mime:ContentDisposition disposition = part.getContentDisposition();
        if disposition is mime:ContentDisposition {
            if disposition.name == "nodeId" {
                nodeId = check part.getText();
            } else if disposition.name == "name" {
                name = check part.getText();
            }
        }
    }

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

    return {
        id: alfrescoNodeEntryResult.entry.id,
        name: alfrescoNodeEntryResult.entry.name,
        createdByUser: {
            id: alfrescoNodeEntryResult.entry.createdByUser.id,
            displayName: alfrescoNodeEntryResult.entry.createdByUser.displayName
        }
    };
}
