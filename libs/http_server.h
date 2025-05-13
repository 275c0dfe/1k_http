#ifndef _HTTP_SERVER_H
#define _HTTP_SERVER_H
#include "sys/socket.h"
#include "sys/types.h"
#include "arpa/inet.h"
#include "stdio.h"
#include "unistd.h"
//#include "ext_types.h"

#include "response.h"
#include "request.h"


#define socket_status_open 1
#define socket_status_closed -1
#define socket_status_unknown 0

// Client structure when handling on server side
typedef struct clientForSvrStruct
{
    int socket;
    struct sockaddr_in addr;
    int status;
} clientContext;

clientContext *newClientContext()
{
    return (clientContext *)calloc(1, sizeof(struct clientForSvrStruct));
}

// Memory Management
#define addr_free 15

#define addr_void 0
#define addr_int 1
#define addr_str 2
#define addr_file_buffer 3
#define addr_clientContext 4
#define addr_resource 5
#define addr_httpServer 6
#define addr_sock_addr 7
#define addr_sock_addr_in 8
#define addr_bytes 9
#define addr_internalBuffer 10
#define addr_parseBuffer 11
#define addr_resp_buffer 12
#define addr_body 13
#define addr_l 14


char mem_man_type_arr[16][64] = {
    "addr_void",
    "addr_int",
    "addr_str",
    "addr_file_buffer",
    "addr_clientContext",
    "addr_resource",
    "addr_httpServer",
    "addr_sock_addr",
    "addr_sock_addr_in",
    "addr_bytes",
    "addr_internalBuffer",
    "addr_parseBuffer",
    "addr_resp_buffer",
    "addr_body",
    "NULL",
    "addr_free"};

#define management_block_size 1024 * 10 // ~5kb of addresses

void *used_addresses[management_block_size];
int used_address_type[management_block_size];
clientContext *used_address_context[management_block_size] = {NULL};
int uadd_length = 0;

int m_checkfree()
{

    for (int i = 0; i < uadd_length; i++)
    {
        if (used_address_type[i] == addr_free)
        {
            return i;
        }
    }
    return -1;
}

void m_add(void *addr, int type)
{

    int freed = m_checkfree();
    if (freed != -1)
    {
        used_addresses[freed] = (void *)addr;
        used_address_type[freed] = type;
        return;
    }

    if (uadd_length > management_block_size - 1)
    {
        printf("Memory Error, Cant add to management block\n");
        return;
    }

    used_addresses[uadd_length] = (void *)addr;
    used_address_type[uadd_length] = type;
    uadd_length++;
}

void printScanMemoryMan(int type_filter)
{
    int all = 0;
    if (type_filter == -1)
    {
        // All
        all = 1;
    }

    for (int i = 0; i < uadd_length; i++)
    {
        void *value = used_addresses[i];
        int type = used_address_type[i];
        if (type == type_filter || all)
        {
            printf("%d %x %d %s\n", i, used_addresses[i] , type , mem_man_type_arr[type]);
            if(used_address_context[i]){
                printf("Client context %x %d %d\n" , used_address_context[i] , used_address_context[i]->socket, used_address_context[i]->status);
            }
            if (type == addr_str)
            {
                printf("String Value: %s\n", (char *)value);
            }
            printf("\n");
        }
    }
}

void m_remove(void *addr)
{
    int index = -1;
    for (int i = 0; i < uadd_length; i++)
    {
        if (addr == used_addresses[i])
        {
            index = i;
            break;
        }
    }

    if (index == -1)
    {
        return;
    }
    used_addresses[index] = NULL;
    used_address_type[index] = addr_free;
    used_address_context[index] = NULL;
    return;
}

void m_defrag()
{
}

int m_getcount()
{
    int count = 0;
    for (int i = 0; i < uadd_length; i++)
    {
        void *value = used_addresses[i];
        int type = used_address_type[i];
        if (type != addr_free)
        {
            count++;
        }
    }
    return count;
}

int m_getIndex(void *addr){
    for(int i =0; i<uadd_length; i++){
        if(used_addresses[i] == addr){
            return i;
        }
    }
    return -1;
}

void *m_getMem(int type, int size){
    void *addr = calloc(1 , size);
    m_add(addr , type);
    return addr;
}

void *m_smem(clientContext* client,  int type, int size){
    void *addr = m_getMem(type , size);
    used_address_context[m_getIndex(addr)] = client;
    return addr;
}

void m_free(void * addr){
    free(addr);
    m_remove(addr);
}

#define Resource_TYPE_STATIC 0
#define Resource_TYPE_DYNAMIC 1
#define Resource_TYPE_FILE 2


typedef struct ResourceStruct
{
    int id;
    char path[500];
    char method[32];
    int type;
    char *local_path;
    char *static_content;
    headerData *headers;
    void (*dynamic)(clientContext *, reqData *);
} Resource;

Resource *newResource()
{
    Resource *resource = (Resource *)malloc(sizeof(struct ResourceStruct));
    m_add(resource , addr_resource);
    resource->id = -1;
    resource->type = Resource_TYPE_STATIC;
    resource->static_content = (char *)malloc(32);
    m_add(resource->static_content , addr_str);
    strcpy(resource->path, "/default");
    strcpy(resource->method, "all");
    strcpy(resource->static_content, "Empty Resource");
    resource->headers = NULL;
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
    m_add(ptr, addr_httpServer);
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
    m_add(server->addr , addr_sock_addr_in);
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
    cli->status = socket_status_open;
    server->clients_connected++;
    return cli;
}

void serverCloseConnectionHandler(httpServer *server, clientContext *client)
{
    if(client->status != socket_status_open){
        return;
    }
    close(client->socket);
    client->status = socket_status_closed;
    server->clients_connected--;
    return;
}

bool serverReadHttpRequest(httpServer *server, clientContext *client, char *buffer)
{
    char *InternalBuffer = calloc(60*1024, 1); // 60 kb max request size
    m_add(InternalBuffer , addr_internalBuffer);
    int bytes_recieved = recv(client->socket, InternalBuffer, 60*1024, 0);
    if (bytes_recieved == -1)
    {
        printf("Error During Reading Request\n");
        return False;
    }
    strcpy(buffer, InternalBuffer);
    free(InternalBuffer);
    m_remove(InternalBuffer);
    //printf("\n%s\n\n" , buffer);
    return True;
}

bool serverWriteHttpResponse(clientContext *client, char *buffer , long buffer_size)
{
    
    int sent = send(client->socket, buffer, buffer_size, 0);
    if (sent == -1)
    {
        printf("Error Sending Response\n");
        return False;
    }
    return True;
}

reqData *serverReadAndParseRequest(httpServer *server, clientContext *client)
{
    char *buffer = (char *)calloc(1024 * 60 +1 , 1);
    m_add(buffer , addr_parseBuffer);
    serverReadHttpRequest(server, client, buffer);

    reqData *req = newRequestData();
    req->headers = newHeaderData();
    int parsingStatus = deserializeHttpRequest(buffer, req);

    if (server->is_debug)
    {
        printf("Request(%s , %s , headers=%d , len=%d)\n", req->method, req->path, req->headers->length, strlen(buffer));
    }

    if (!parsingStatus)
    {
        free(buffer);
        m_remove(buffer);
        serverCloseConnectionHandler(server, client);
        return NULL;
    }

    free(buffer);
    m_remove(buffer);

    return req;
}

int serverSendResponse(clientContext *client, resData *res)
{
    long body_length = strlen(res->body);
    if(headerGetValue(res->headers , "Content-Length")){
        long content_length = 0;
        char content_length_value[16] = {0};
        strcpy(content_length_value , headerGetValue(res->headers, "Content-Length"));
        sscanf(content_length_value , "%ld"  , &content_length);
        body_length = content_length;
    }
    char *response = (char *)calloc(1024 * 4 + body_length , 1); // Heap Buffer Moment
    m_add(response , addr_resp_buffer);
    long res_size = serializeHttpResponse(response, res);
    printf("->%ld\n" , res_size);
    if (!serverWriteHttpResponse(client, response , res_size+1))
    {
        free(response);
        m_remove(response);
        return False;
    }

    free(response);
    m_remove(response);
    return True;
}

resData *makeHttpResponse(char *content, int status, clientContext *client)
{
    resData *res = newResponseData();
    res->headers = newHeaderData();
    res->status = status;
    res->body = calloc(strlen(content)+1 , 1);
    m_add(res->body , addr_body);
    used_address_context[m_getIndex(res->body)] = client;
    strcpy(res->body, content);
    return res;
}

void serverFinishAndSendResponse(httpServer *server , clientContext *client , resData *res){
    headerAddValue(res->headers, "Connection", "Close");
    headerAddValue(res->headers, "Server", "chttp");
    serverSendResponse(client, res);
    free(res->body);
    m_remove(res->body);
    free(res);
    m_remove(res);
    serverCloseConnectionHandler(server, client);
    return;
}

void serverDebug(httpServer *server)
{
    server->is_debug = True;
}

void serverGet(httpServer *server, char *path, int type, void *resource_data , headerData *headers)
{
    Resource *resource = newResource();
    resource->id = server->resource_count;
    strcpy(resource->method, "GET");
    strcpy(resource->path, path);
    resource->type = type;

    if (type == Resource_TYPE_STATIC)
    {
        resource->static_content = (char *)malloc(strlen((char *)resource_data) + 1);
        m_add(resource->static_content , addr_str);
        strcpy(resource->static_content, (char *)resource_data);
    }

    if (type == Resource_TYPE_DYNAMIC)
    {
        resource->dynamic = (void (*)(clientContext *, reqData *))resource_data;
    }
    if (type == Resource_TYPE_FILE)
    {
        resource->local_path = (char *)malloc(strlen((char *)resource_data) + 1);
        m_add(resource->local_path , addr_str);
        strcpy(resource->local_path, (char *)resource_data);
    }
    if(headers != NULL){
        resource->headers = headers;
    }
    server->resources[resource->id] = resource;
    server->resource_count++;
}

void serverPost(httpServer *server, char *path, int type, void *resource_data , headerData *headers)
{
    Resource *resource = newResource();
    resource->id = server->resource_count;
    strcpy(resource->method, "POST");
    strcpy(resource->path, path);
    resource->type = type;

    if (type == Resource_TYPE_STATIC)
    {
        resource->static_content = (char *)malloc(strlen((char *)resource_data) + 1);
        m_add(resource->static_content , addr_str);
        strcpy(resource->static_content, (char *)resource_data);
    }

    if (type == Resource_TYPE_DYNAMIC)
    {
        resource->dynamic = (void (*)(clientContext *, reqData *))resource_data;
    }
    if (type == Resource_TYPE_FILE)
    {
        resource->local_path = (char *)malloc(strlen((char *)resource_data) + 1);
        m_add(resource->local_path , addr_str);
        strcpy(resource->local_path, (char *)resource_data);
    }
    if(headers != NULL){
        resource->headers = headers;
    }
    server->resources[resource->id] = resource;
    server->resource_count++;
}

void serverAll(httpServer *server, char *path, int type, void *resource_data , headerData *headers)
{
    Resource *resource = newResource();
    resource->id = server->resource_count;
    strcpy(resource->method, "all");
    strcpy(resource->path, path);
    resource->type = type;

    if (type == Resource_TYPE_STATIC)
    {
        resource->static_content = (char *)malloc(strlen((char *)resource_data) + 1);
        m_add(resource->static_content , addr_str);
        strcpy(resource->static_content, (char *)resource_data);
    }

    if (type == Resource_TYPE_DYNAMIC)
    {
        resource->dynamic = (void (*)(clientContext *, reqData *))resource_data;
    }
    if (type == Resource_TYPE_FILE)
    {
        resource->local_path = (char *)malloc(strlen((char *)resource_data) + 1);
        m_add(resource->local_path , addr_str);
        strcpy(resource->local_path, (char *)resource_data);
    }
    if(headers != NULL){
        resource->headers = headers;
    }
    server->resources[resource->id] = resource;
    server->resource_count++;
}

void serverRespondNotFound(httpServer *server, clientContext *client, reqData *req , void *info)
{
    char formatBuffer[256];
    sprintf(formatBuffer, "<html><head><title>Resource Not Found</title></head> <body><h1>Resource <span>\"%s\"</span> not found.</h1> <p>INFO:%s</p> </body></html>", req->path , info);
    resData *res = makeHttpResponse(formatBuffer, 404 , client);
    headerAddValue(res->headers, "Connection", "Close");
    headerAddValue(res->headers, "Server", "chttp");
    serverSendResponse(client, res);
    serverCloseConnectionHandler(server, client);
    free(res->body);
    m_remove(res->body);
    free(res);
    m_remove(res);
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
        serverRespondNotFound(server, client, req , "Resource Not Found");
        return;
    }

    if (resource->type == Resource_TYPE_STATIC)
    {
        resData *res = makeHttpResponse(resource->static_content, 200 , client);
        if(resource->headers != NULL){
            for(int i =0; i< resource->headers->length;i++){
                headerAddValue(res->headers , resource->headers->keys[i], resource->headers->values[i]);
            }
        }

        char contentLengthValue[16];
        sprintf(contentLengthValue,  "%d" , strlen(resource->static_content));
        headerAddValue(res->headers , "Content-Length" , contentLengthValue);

        serverFinishAndSendResponse(server , client , res);
        
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
        FILE *f = fopen(resource->local_path, "rb");
        if (!f)
        {
            serverRespondNotFound(server, client, req , "No File Handle");
            return;
        }
        
        fseek(f, 0, SEEK_END);
        long fsize = ftell(f);
        fseek(f, 0, SEEK_SET);

        
        
        char *file_buffer = malloc(fsize + 1);
        m_add(file_buffer , addr_file_buffer);
        fread(file_buffer, fsize, 1, f);
        fclose(f);
        file_buffer[fsize] = 0;
        
        resData *res = makeHttpResponse("", 200, client);
        free(res->body);
        m_remove(res->body);
        res->body = calloc(fsize+1 , 1);
        m_add(res->body , addr_body);
        used_address_context[m_getIndex(res->body)] = client;
        for(int i =0;i<fsize; i++){
            res->body[i] = file_buffer[i];
        }
        if(resource->headers != NULL){
            for(int i =0; i< resource->headers->length;i++){
                headerAddValue(res->headers , resource->headers->keys[i], resource->headers->values[i]);
            }
        }

        char contentLengthValue[16];
        sprintf(contentLengthValue,  "%ld" , fsize);
        headerAddValue(res->headers , "Content-Length" , contentLengthValue);
        serverFinishAndSendResponse(server , client , res);
        free(file_buffer);
        m_remove(file_buffer);
        return;
    }

    serverRespondNotFound(server, client, req , NULL);
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
    m_remove(req);
    return 1;
}

resData* redirect(char * path , clientContext *client){
    resData *res = makeHttpResponse("" , 302 , client);
    headerAddValue(res->headers , "location" , path);
    headerAddValue(res->headers , "Connection" , "Close");
    return res;
}

void collectGarbage(){
    //Crude garbage collector
    for(int i =0; i< uadd_length; i++){
        void * addr = used_addresses[i];
        clientContext *c = used_address_context[i];
        if(c){
            if(c->status == socket_status_closed){
                free(addr);
                m_remove(addr);
                //printf("Freed address: %x with context %x\n" , addr , c);
            }
        }
        
    }
}

#endif
