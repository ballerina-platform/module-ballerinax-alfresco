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
