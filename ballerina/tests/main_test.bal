import ballerina/test;
import ballerina/http;
import ballerina/mime;

@test:Config {}
function testUploadDocument() returns error? {
    http:Client testClient = check new ("http://localhost:9090/documents");

    mime:Entity filePart = new;
    mime:ContentDisposition fileDisposition = new;
    fileDisposition.name = "file";
    fileDisposition.fileName = "test.txt";
    filePart.setContentDisposition(fileDisposition);
    filePart.setBody("Test content".toBytes());

    mime:Entity nodeIdPart = new;
    nodeIdPart.setContentId("nodeId");
    nodeIdPart.setText("test-folder");

    mime:Entity namePart = new;
    namePart.setContentId("name");
    namePart.setText("test.txt");

    mime:Entity[] bodyParts = [filePart, nodeIdPart, namePart];

    http:Request request = new;
    request.setHeader("Content-Type", "multipart/form-data");
    request.setBodyParts(bodyParts);

    json|error response = check testClient->/upload.post(request);

    if response is json {
        test:assertEquals(response.id, "mock-node-123");
        test:assertEquals(response.name, "test.txt");
        test:assertEquals(response.createdByUser.id, "admin");
    } else {
        test:assertFail("Expected json response but got error");
    }
}

@test:Config {}
function testDownloadDocument() returns error? {
    http:Client testClient = check new ("http://localhost:9090/documents");

    http:Response|error response = testClient->/download.get(nodeId = "mock-node-123");

    if response is http:Response {
        byte[] content = check response.getBinaryPayload();
        test:assertEquals(string:fromBytes(content), "Mock PDF content");
    } else {
        test:assertFail("Expected http:Response but got error");
    }
}

@test:Config {}
function testDownloadDocumentNotFound() returns error? {
    http:Client testClient = check new ("http://localhost:9090/documents");

    http:Response|error response = testClient->/download.get(nodeId = "invalid-node");
    test:assertTrue(response is http:Response && response.statusCode == 404);
}

@test:Config {}
function testDownloadDocumentAsAttachment() returns error? {
    http:Client testClient = check new ("http://localhost:9090/documents");

    http:Response|error response = testClient->/download/attachment.get(nodeId = "mock-node-123");

    if response is http:Response {
        test:assertEquals(response.getHeader("Content-Type"), "application/pdf");
        string contentDisposition = check response.getHeader("Content-Disposition");
        test:assertTrue(contentDisposition.includes("attachment"));
        byte[] content = check response.getBinaryPayload();
        test:assertEquals(string:fromBytes(content), "Mock PDF content");
    } else {
        test:assertFail("Expected http:Response but got error");
    }
}

@test:Config {}
function testDownloadAttachmentNotFound() returns error? {
    http:Client testClient = check new ("http://localhost:9090/documents");

    http:Response|error response = testClient->/download/attachment.get(nodeId = "invalid-node");
    test:assertTrue(response is http:Response && response.statusCode == 404);
}
