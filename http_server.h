#include "sys/socket.h"
#include "sys/types.h"
#include "arpa/inet.h"
#include "stdio.h"
#include "unistd.h"

#include "request.h"
#include "response.h"

#define Resource_TYPE_STATIC 0
#define Resource_TYPE_DYNAMIC 1
#define Resource_TYPE_FILE 2

// Client structure when handling on server side
typedef struct clientForSvrStruct
{
    int socket;
    struct sockaddr_in addr;
} clientContext;

clientContext *newClientContext()
{
    return (clientContext *)malloc(sizeof(struct clientForSvrStruct));
}

typedef struct ResourceStruct
{
    int id;
    char path[500];
    char method[32];
    int type;
    char *local_path;
    char *static_content;
    void (*dynamic)(clientContext *, reqData *);
} Resource;

Resource *newResource()
{
    Resource *resource = (Resource *)malloc(sizeof(struct ResourceStruct));
    resource->id = -1;
    resource->type = Resource_TYPE_STATIC;
    resource->static_content = (char *)malloc(32);
    strcpy(resource->path, "/default");
    strcpy(resource->method, "all");
    strcpy(resource->static_content, "Empty Resource");
    return resource;
}

// Http Server
//
typedef struct httpServerStruct
{
    int socket;
    int port;
    char host[256];
    struct sockaddr_in *addr;
    int is_debug;
    int is_bound;
    int is_listening;
    int clients_connected; // Mainly For Multithreaded use
    Resource *resources[64];
    int resource_count;

} httpServer;

httpServer *newHttpServer()
{
    httpServer *ptr = (httpServer *)malloc(sizeof(struct httpServerStruct));
    ptr->port = 80;
    ptr->socket = socket(AF_INET, SOCK_STREAM, 0);
    if (ptr->socket == -1)
    {
        printf("Error Creating Socket\n");
        return NULL;
    }

    return ptr;
}

int serverBind(httpServer *server)
{

    if (server->is_bound + server->is_listening)
    {
        printf("Server is listening or bound already\n");
        return 0;
    }
    if (server->port < 1)
    {
        printf("Server Port is 0 or less\n");
        return 0;
    }

    server->addr = (struct sockaddr_in *)malloc(sizeof(struct sockaddr_in));
    server->addr->sin_family = AF_INET;
    server->addr->sin_port = htons(server->port);
    server->addr->sin_addr.s_addr = htonl(INADDR_ANY);

    if (bind(server->socket, (struct sockaddr *)server->addr, sizeof(struct sockaddr)) == -1)
    {
        printf("Error Binding Server\n");
        return 0;
    }
    server->is_bound = 1;
    return 1;
}

int serverListen(httpServer *server)
{

    if (!server->is_bound)
    {
        printf("Server Tried to listen while not bound\n");
        return 0;
    }

    if (listen(server->socket, 6) == -1)
    {
        printf("Error Listening\n");
        return 0;
    }
    server->is_listening = 1;
    if (server->is_debug)
    {
        printf("Http server Listening on port %d\n", server->port);
        printf("http://localhost:%d/\n", server->port);
    }
    return 1;
}

clientContext *acceptConnection(httpServer *server)
{
    clientContext *cli = newClientContext();
    int addrSz = sizeof(cli->addr);
    int sock = accept(server->socket, (struct sockaddr *)&cli->addr, (socklen_t *)&addrSz);
    if (sock == -1)
    {
        printf("Socket return is -1\n");
        return NULL;
    }

    cli->socket = sock;
    server->clients_connected++;
    return cli;
}

void serverCloseConnectionHandler(httpServer *server, clientContext *client)
{
    close(client->socket);
    server->clients_connected--;
    return;
}

bool serverReadHttpRequest(httpServer *server, clientContext *client, char *buffer)
{
    char InternalBuffer[1024 * 20] = {0}; // 20 kb max request size
    int bytes_recieved = recv(client->socket, InternalBuffer, sizeof(InternalBuffer), 0);
    if (bytes_recieved == -1)
    {
        printf("Error During Reading Request\n");
        return False;
    }
    strcpy(buffer, InternalBuffer);
    return True;
}

bool serverWriteHttpResponse(clientContext *client, char *buffer)
{
    char InternalBuffer[1024 * 20] = {0}; // 20 kb Response Buffer
    strcpy(InternalBuffer, buffer);
    int sent = send(client->socket, InternalBuffer, strlen(InternalBuffer), 0);
    if (sent == -1)
    {
        printf("Error Sending Response\n");
        return False;
    }
    return True;
}

reqData *serverReadAndParseRequest(httpServer *server, clientContext *client)
{
    char *buffer = (char *)malloc(1024 * 21);
    serverReadHttpRequest(server, client, buffer);

    reqData *req = newRequestData();
    req->headers = newHeaderData();
    int parsingStatus = deserializeHttpRequest(buffer, req);

    if (server->is_debug)
    {
        printf("Request(%s , %s , headers=%d)\n", req->method, req->path, req->headers->length);
    }

    if (!parsingStatus)
    {
        serverCloseConnectionHandler(server, client);
        return NULL;
    }

    free(buffer);

    return req;
}

int serverSendResponse(clientContext *client, resData *res)
{

    char *response = (char *)malloc(1024 * 18); // Heap Buffer Moment
    serializeHttpResponse(response, res);
    if (!serverWriteHttpResponse(client, response))
    {
        free(response);
        return False;
    }

    free(response);
    return True;
}

resData *makeHttpResponse(char *content, int status)
{
    resData *res = newResponseData();
    res->headers = newHeaderData();
    res->status = status;

    strcpy(res->body, content);
    return res;
}

void serverDebug(httpServer *server)
{
    server->is_debug = True;
}

void serverGet(httpServer *server, char *path, int type, void *resource_data)
{
    Resource *resource = newResource();
    resource->id = server->resource_count;
    strcpy(resource->method, "GET");
    strcpy(resource->path, path);
    resource->type = type;

    if (type == Resource_TYPE_STATIC)
    {
        resource->static_content = (char *)malloc(strlen((char *)resource_data) + 1);
        strcpy(resource->static_content, (char *)resource_data);
    }

    if (type == Resource_TYPE_DYNAMIC)
    {
        resource->dynamic = (void (*)(clientContext *, reqData *))resource_data;
    }
    if (type == Resource_TYPE_FILE)
    {
        resource->local_path = (char *)malloc(strlen((char *)resource_data) + 1);
        strcpy(resource->local_path, (char *)resource_data);
    }
    server->resources[resource->id] = resource;
    server->resource_count++;
}

void serverPost(httpServer *server, char *path, int type, void *resource_data)
{
    Resource *resource = newResource();
    resource->id = server->resource_count;
    strcpy(resource->method, "POST");
    strcpy(resource->path, path);
    resource->type = type;

    if (type == Resource_TYPE_STATIC)
    {
        resource->static_content = (char *)malloc(strlen((char *)resource_data) + 1);
        strcpy(resource->static_content, (char *)resource_data);
    }

    if (type == Resource_TYPE_DYNAMIC)
    {
        resource->dynamic = (void (*)(clientContext *, reqData *))resource_data;
    }
    if (type == Resource_TYPE_FILE)
    {
        resource->local_path = (char *)malloc(strlen((char *)resource_data) + 1);
        strcpy(resource->local_path, (char *)resource_data);
    }
    server->resources[resource->id] = resource;
    server->resource_count++;
}

void serverAll(httpServer *server, char *path, int type, void *resource_data)
{
    Resource *resource = newResource();
    resource->id = server->resource_count;
    strcpy(resource->method, "all");
    strcpy(resource->path, path);
    resource->type = type;

    if (type == Resource_TYPE_STATIC)
    {
        resource->static_content = (char *)malloc(strlen((char *)resource_data) + 1);
        strcpy(resource->static_content, (char *)resource_data);
    }

    if (type == Resource_TYPE_DYNAMIC)
    {
        resource->dynamic = (void (*)(clientContext *, reqData *))resource_data;
    }
    if (type == Resource_TYPE_FILE)
    {
        resource->local_path = (char *)malloc(strlen((char *)resource_data) + 1);
        strcpy(resource->local_path, (char *)resource_data);
    }
    server->resources[resource->id] = resource;
    server->resource_count++;
}

void serverRespondNotFound(httpServer *server, clientContext *client, reqData *req)
{
    char formatBuffer[256];
    sprintf(formatBuffer, "<html><head><title>Resource Not Found</title></head> <body><h1>Resource <span>\"%s\"</span> not found.</h1></body></html>", req->path);
    resData *res = makeHttpResponse(formatBuffer, 404);
    headerAddValue(res->headers, "Connection", "Close");
    headerAddValue(res->headers, "Server", "chttp");
    serverSendResponse(client, res);
    serverCloseConnectionHandler(server, client);
    free(res);
    return;
}

void serverHandleResource(httpServer *server, clientContext *client, reqData *req)
{
    Resource *resource = NULL;
    for (int i = 0; i < server->resource_count; i++)
    {
        resource = server->resources[i];
        if (strcmp(req->path, resource->path) == 0)
        {
            if (strcmp(req->method, resource->method) == 0)
            {
                break;
            }

            if (strcmp(resource->method, "all") == 0)
            {
                break;
            }
        }
        resource = NULL;
    }

    if (resource == NULL)
    {
        serverRespondNotFound(server, client, req);
        return;
    }

    if (resource->type == Resource_TYPE_STATIC)
    {
        resData *res = makeHttpResponse(resource->static_content, 200);
        headerAddValue(res->headers, "Connection", "Close");
        headerAddValue(res->headers, "Server", "chttp");
        serverSendResponse(client, res);
        free(res);
        serverCloseConnectionHandler(server, client);
        return;
    }

    if (resource->type == Resource_TYPE_DYNAMIC)
    {
        resource->dynamic(client, req);
        serverCloseConnectionHandler(server, client);
        return;
    }

    if (resource->type == Resource_TYPE_FILE)
    {
        FILE *f = fopen(resource->local_path, "r");
        if (!f)
        {
            serverRespondNotFound(server, client, req);
            return;
        }
        char *file_buffer = (char *)malloc(1024 * 12);
        int bytes_read = fread(file_buffer, (size_t)(1024 * 12), 1, f);
        if (bytes_read < 1)
        {
            serverRespondNotFound(server, client, req);
            return;
        }

        resData *res = makeHttpResponse(file_buffer, 200);
    }

    serverRespondNotFound(server, client, req);
    return;
}

int serverHandleClient(httpServer *server, clientContext *client)
{
    bool fatal_error = False;
    reqData *req = serverReadAndParseRequest(server, client);
    if (fatal_error)
    {
        serverCloseConnectionHandler(server, client);
        return 0;
    }

    if (req == NULL)
    {
        serverCloseConnectionHandler(server, client);
        return 1;
    }
    serverHandleResource(server, client, req);
    free(req);
    return 1;
}
