#include "sys/socket.h"
#include "sys/types.h"
#include "string.h"
#include "stdlib.h"
#include "netdb.h"
#include "unistd.h"
#include "netinet/in.h"
#include "arpa/inet.h"
#include "stdio.h"


//Made By Me
#include "url.h"
#include "ext_types.h"
#include "request.h"


#define STATUS_OK 200
#define STATUS_BAD_REQUEST 400
#define STATUS_NOT_FOUND 404
#define STATUS_SERVER_ERROR 500

#define Resource_TYPE_STATIC 0
#define Resource_TYPE_DYNAMIC 1
#define Resource_TYPE_FILE 2




//Response Parsing
typedef struct responseDataStruct
{
    int status;
    headerData *headers;
    char body[1024*12];
} resData;

resData *newResponseData()
{
    return (resData *)malloc(sizeof(struct responseDataStruct));
}

void serializeHttpResponse(char *response , resData *res){
    
    //Get Correct Text Code
    char textCode[32] = {'O' , 'K' , '\0'};
    if(res->status != STATUS_OK){
        if(res->status == STATUS_BAD_REQUEST){
            strcpy(textCode , "Bad Request");
        }
        if(res->status == STATUS_NOT_FOUND){
            strcpy(textCode , "Not Found");
        }
        if(res->status == STATUS_SERVER_ERROR){
            strcpy(textCode , "Internal Server Error");
        }
    }

    //Status Line
    char statusLine[128] = {0};
    sprintf(statusLine , "HTTP/1.0 %d %s\n" , res->status , textCode);
    strcat(response , statusLine);
    //Headers
    char *headers = (char*)malloc(1024 * 2);
    headersToText(res->headers , headers);
    strcat(response , headers);
    //Body
    strcat(response , "\n");
    strcat(response ,res->body);
    
    free(headers);
    return;
}

int deserializeHttpResponse(char *asciiData, resData *res)
{

    char InternalBuffer[1024 * 18] = {0};
    strcpy(InternalBuffer, asciiData);

    char headerLines[33][512] = {0};
    char body[1024 * 6] = {0};

    int index = 0;
    int sections = 0;
    char *token = strtok(InternalBuffer, "\n");
    while (token != NULL)
    {
        //printf("%d : %s\r\n", index, token);
        // for(int i =0; i<strlen(token); i++){
        //     printf("%d " , token[i]);
        // }
        // printf("\r\n");
        if (strcmp(token, "\r") == 0)
        {
            //printf("SECTION\r\n");
            sections += 1;
        }
        else
        {
            if (sections == 0)
            {
                // Headers And Res Code
                strcat(headerLines[index], token);
            }
            if (sections > 0)
            {
                // BODY
                strcat(body, token);
                strcat(body, "\r\n");
            }
        }
        index++;
        token = strtok(NULL, "\n");
    }
    //printf("Body: %s\r\n" , body);
    headersFromText(res->headers , headerLines);
    char line0[128] ={0};
    char txtCode[32] = {0};
    char NCodeTxt[16] = {0};
    
    strcpy(line0 , headerLines[0]);
    sscanf(line0 , "HTTP/1.0 %s %s"  , NCodeTxt , txtCode);

    

    res->status = atoi(NCodeTxt);
    strcpy(res->body , body);
    
    //printf("Status Code: %d\r\n" , req->status);
    //printf("Response Parsed\r\n");

    return 1;
}

//Http Client
//Todo: Add Post Method
//fields { char host[256] , sockaddr_in *hostAddr , int socket , UrlData *url }
typedef struct httpClientStruct
{
    char host[256];
    struct sockaddr_in *hostAddr;
    char ipAddr[64];
    int socket;
    UrlData *url;
} httpClient;

httpClient *newHttpClient(char *url)
{
    if (strcmp(url, "") == 0)
    {
        return NULL;
    }
    httpClient *client = (httpClient *)malloc(sizeof(struct httpClientStruct));
    client->socket = socket(AF_INET, SOCK_STREAM, 0);

    URL_INFO urlInfo = {0};
    split_url(&urlInfo, url);

    client->url = (UrlData *)malloc(sizeof(struct UrlDataStruct));
    strcpy(client->host, urlInfo.site);
    strcpy(client->url->host, urlInfo.site);
    strcpy(client->url->path, urlInfo.path);
    client->url->port = atoi(urlInfo.port);
    // printf("%s:%d%s\r\n" , client->host , client->url->port , client->url->path);

    return client;
}

int clientConnect(httpClient *client)
{

    // Get Host List
    struct hostent *hostEntries = gethostbyname(client->host);
    if (client->hostAddr == NULL)
    {
        client->hostAddr = (struct sockaddr_in *)malloc(sizeof(struct sockaddr_in));
        // printf("Host Addr Is Null\n");
    }
    if (hostEntries == NULL)
    {
        // printf("No Host Entries\n");
        return 0;
    }

    char ipBuffer[64];
    struct in_addr *hst = (struct in_addr *)hostEntries->h_addr_list[0];
    strcpy(client->ipAddr, inet_ntoa(*hst));

    client->hostAddr->sin_addr = *hst;
    client->hostAddr->sin_family = AF_INET;
    client->hostAddr->sin_port = htons(client->url->port);
    int conStatus = connect(client->socket, (struct sockaddr *)client->hostAddr, sizeof(*client->hostAddr));
    if (conStatus != 0)
    {
        return 0;
    }

    return 1;
}

int clientRead(httpClient *client, char *buffer)
{

    if (client->socket)
    {
        char Buff[1024 * 10] = {0};
        // printf("In Client Read\r\n");
        int size_read = read(client->socket, Buff, 1024 * 1); // Read 10 KB
        // printf("%d\r\n" , size_read);
        strcpy(buffer, Buff);
        return size_read;
    }
    return -1;
}

int clientWrite(httpClient *client, char *buffer)
{
    if (client->socket)
    {
        send(client->socket, buffer, strlen(buffer), 0);
    }
}

resData *httpGetRequest(httpClient *client, char *data, headerData *headers)
{
    if (headers == NULL)
    {
        headers = newHeaderData();
        headerAddValue(headers, "Host", client->host);
        headerAddValue(headers, "accept", "text/html");
        headerAddValue(headers, "User-Agent", "0");
        headerAddValue(headers, "Connection", "close");
    }

    char *RequestData = (char *)malloc(1024 * 4);
    char *topLineBuff = (char *)malloc(316);

    sprintf(topLineBuff, "GET %s HTTP/1.0\r\n", client->url->path);
    strcat(RequestData, topLineBuff);

    char *headersStr = (char *)malloc(1024);
    headersToText(headers, headersStr);
    strcat(RequestData, headersStr);
    strcat(RequestData, "\r\n");

    // printf("\r\n%s\r\n" , RequestData);
    clientWrite(client, RequestData);

    // printf("\r\nSent Request\r\n");
    free(RequestData);
    free(topLineBuff);
    free(headersStr);

    // printf("Awaiting Server Reponse\r\n");

    char InBuffer[1024*10] = {0};
    int dsize = clientRead(client, InBuffer);
    if (dsize < 0)
    {
        // printf("Error Receiving Data\r\n");
    }
    resData *req = newResponseData();
    req->headers = newHeaderData();
    deserializeHttpResponse(InBuffer, req);


    // printf("Data Recieved: %d Bytes\r\n", dsize);

    return req;
}

//Structure for client when handling serverside
typedef struct clientForSvrStruct{
    int socket;
    struct sockaddr_in addr;
} clientContext ;

clientContext *newClientContext(){
    return (clientContext*)malloc(sizeof(struct clientForSvrStruct));
}

typedef struct ResourceStruct {
    int id;
    char path[500];
    char method[32];
    int type;
    char *local_path;
    char *static_content;
    void (*dynamic)(clientContext*, reqData*);
} Resource;

Resource *newResource(){
    Resource *resource =(Resource*)malloc(sizeof(struct ResourceStruct));
    resource->id = -1;
    resource->type = Resource_TYPE_STATIC;
    resource->static_content = (char*)malloc(32);
    strcpy(resource->path , "/default");
    strcpy(resource->method , "all");
    strcpy(resource->static_content , "Empty Resource");
    return resource;
}

//Http Server
//
typedef struct httpServerStruct{
    int socket;
    int port;
    char host[256];
    struct sockaddr_in *addr;
    int is_debug;
    int is_bound;
    int is_listening;
    int clients_connected; //Mainly For Multithreaded use 
    Resource *resources[64];
    int resource_count;

}httpServer;

httpServer *newHttpServer(){
    httpServer *ptr = (httpServer*)malloc(sizeof(struct httpServerStruct));
    ptr->port= 80;
    ptr->socket = socket(AF_INET ,  SOCK_STREAM , 0);
    if(ptr->socket == -1){
        printf("Error Creating Socket\n");
        return NULL;
    }

    return ptr;
}

int serverBind(httpServer *server){
    
    if(server->is_bound + server->is_listening){
        printf("Server is listening or bound already\n");
        return 0;

    }
    if(server->port < 1){
        printf("Server Port is 0 or less\n");
        return 0;
    }

    server->addr = (struct sockaddr_in*)malloc(sizeof(struct sockaddr_in));
    server->addr->sin_family = AF_INET;
    server->addr->sin_port = htons(server->port);
    server->addr->sin_addr.s_addr = htonl(INADDR_ANY);
    
    if(bind(server->socket , (struct sockaddr*)server->addr , sizeof(struct sockaddr)) == -1) {
        printf("Error Binding Server\n");
        return 0;
    }
    server->is_bound = 1;
    return 1;
}

int serverListen(httpServer *server){

    if(!server->is_bound){
        printf("Server Tried to listen while not bound\n");
        return 0;
    }

    if(listen(server->socket , 6) == -1){
        printf("Error Listening\n");
        return 0;
    }
    server->is_listening = 1;
    return 1;
}

clientContext *acceptConnection(httpServer *server){
    clientContext* cli = newClientContext();
    int addrSz = sizeof(cli->addr);
    int sock = accept(server->socket ,(struct sockaddr*)&cli->addr , (socklen_t *) &addrSz);
    if(sock == -1){
        printf("Socket return is -1\n");
        return NULL;
    }

    cli->socket = sock;
    server->clients_connected++;
    return cli;
}

void serverCloseConnectionHandler(httpServer *server , clientContext *client){
    close(client->socket);
    server->clients_connected--;
    return;
}

bool serverReadHttpRequest(httpServer *server , clientContext *client, char *buffer){
    char InternalBuffer[1024*20] = {0}; //20 kb max request size 
    int bytes_recieved = recv(client->socket , InternalBuffer, sizeof(InternalBuffer), 0);
    if(bytes_recieved == -1){
        printf("Error During Reading Request\n");
        return False;
    }
    strcpy(buffer , InternalBuffer);
    return True;
}

bool serverWriteHttpResponse(clientContext *client, char *buffer){
    char InternalBuffer[1024*20] = {0}; //20 kb Response Buffer
    strcpy(InternalBuffer , buffer);
    int sent = send(client->socket , InternalBuffer , strlen(InternalBuffer) , 0);
    if(sent == -1){
        printf("Error Sending Response\n");
        return False;
    }
    return True;
}

reqData *serverReadAndParseRequest(httpServer *server , clientContext *client){
    char *buffer = (char *)malloc(1024*21); 
    serverReadHttpRequest(server , client , buffer);

    reqData *req = newRequestData();
    req->headers = newHeaderData();
    int parsingStatus = deserializeHttpRequest(buffer , req);
    
    if(server->is_debug){
        printf("Request(%s , %s , headers=%d)\n" , req->method , req->path , req->headers->length);
    }

    if(!parsingStatus){
        serverCloseConnectionHandler(server , client);
        return NULL;
    }
    
    free(buffer);

    return req;
}

int serverSendResponse(clientContext *client , resData * res){


    char *response =(char*)malloc(1024*18); //Heap Buffer Moment     
    serializeHttpResponse(response , res); 
    if(!serverWriteHttpResponse(client , response)){
        free(response);
        return False;
    }
    
    free(response);
    return True;
}

resData *makeHttpResponse(char * content , int status){
    resData *res = newResponseData();
    res->headers = newHeaderData();
    res->status = status;
    
    strcpy(res->body , content);
    return res;
}

void serverDebug(httpServer *server){
    if(!server->is_debug){
        return;
    }
    printf("Http server Listening on port %d\n" , server->port);
    printf("http://localhost:%d/\n", server->port);
    
}

void serverGet(httpServer * server , char *path , int type , void *resource_data){
    Resource *resource = newResource();
    resource->id = server->resource_count;
    strcpy(resource->method , "GET");
    strcpy(resource->path , path);
    resource->type = type;

    if(type == Resource_TYPE_STATIC){
        resource->static_content = (char*)malloc(strlen((char*)resource_data)+1);
        strcpy(resource->static_content , (char*)resource_data);
    }

    if(type == Resource_TYPE_DYNAMIC){
        resource->dynamic = (void(*)(clientContext* , reqData*))resource_data;
    }
    if(type == Resource_TYPE_FILE){
        resource->local_path = (char*)malloc(strlen((char*)resource_data)+1);
        strcpy(resource->local_path , (char*)resource_data);
    }
    server->resources[resource->id] = resource;
    server->resource_count++;
}

void serverPost(httpServer * server , char *path , int type , void *resource_data){
    Resource *resource = newResource();
    resource->id = server->resource_count;
    strcpy(resource->method , "POST");
    strcpy(resource->path , path);
    resource->type = type;

    if(type == Resource_TYPE_STATIC){
        resource->static_content = (char*)malloc(strlen((char*)resource_data)+1);
        strcpy(resource->static_content , (char*)resource_data);
    }

    if(type == Resource_TYPE_DYNAMIC){
        resource->dynamic = (void(*)(clientContext* , reqData*))resource_data;
    }
    if(type == Resource_TYPE_FILE){
        resource->local_path = (char*)malloc(strlen((char*)resource_data)+1);
        strcpy(resource->local_path , (char*)resource_data);
    }
    server->resources[resource->id] = resource;
    server->resource_count++;
}

void serverAll(httpServer * server , char *path , int type , void *resource_data){
    Resource *resource = newResource();
    resource->id = server->resource_count;
    strcpy(resource->method , "all");
    strcpy(resource->path , path);
    resource->type = type;

    if(type == Resource_TYPE_STATIC){
        resource->static_content = (char*)malloc(strlen((char*)resource_data)+1);
        strcpy(resource->static_content , (char*)resource_data);
    }

    if(type == Resource_TYPE_DYNAMIC){
        resource->dynamic = (void(*)(clientContext* , reqData*))resource_data;
    }
    if(type == Resource_TYPE_FILE){
        resource->local_path = (char*)malloc(strlen((char*)resource_data)+1);
        strcpy(resource->local_path , (char*)resource_data);
    }
    server->resources[resource->id] = resource;
    server->resource_count++;
}

void serverRespondNotFound(httpServer *server , clientContext *client , reqData*req){
    char formatBuffer[256];
    sprintf(formatBuffer , "<html><head><title>Resource Not Found</title></head> <body><h1>Resource <span>\"%s\"</span> not found.</h1></body></html>" , req->path);
    resData *res = makeHttpResponse(formatBuffer , 404);
    headerAddValue(res->headers , "Connection" , "Close");
    headerAddValue(res->headers , "Server" , "chttp");
    serverSendResponse(client , res);
    serverCloseConnectionHandler(server ,client);
    free(res);
    return;
}

void serverHandleResource(httpServer *server , clientContext *client , reqData *req){
    Resource *resource = NULL;
    for(int i =0; i<server->resource_count; i++){
        resource = server->resources[i];
        if(strcmp(req->path , resource->path) == 0){
            if(strcmp(req->method , resource->method) == 0){
                break;
            }

            if(strcmp(resource->method , "all") == 0){
                break;
            }

        }
        resource = NULL;
    }

    if(resource == NULL){
        serverRespondNotFound(server ,client , req);
        return;
    }

    if(resource->type == Resource_TYPE_STATIC){
        resData *res = makeHttpResponse(resource->static_content , 200);
        headerAddValue(res->headers , "Connection" , "Close");
        headerAddValue(res->headers , "Server" , "chttp");
        serverSendResponse(client , res);
        free(res);
        serverCloseConnectionHandler(server ,client);
        return;
    }

    if(resource->type == Resource_TYPE_DYNAMIC){
        resource->dynamic(client , req);
        serverCloseConnectionHandler(server ,client);
        return;
    }

    if(resource->type == Resource_TYPE_FILE){
        FILE *f = fopen(resource->local_path , "r");
        if(!f){
            serverRespondNotFound(server , client ,req);
            return;
        }
        char *file_buffer = (char *)malloc(1024*12);
        int bytes_read = fread(file_buffer , (size_t)(1024*12) , 1 , f);
        if(bytes_read < 1){
            serverRespondNotFound(server , client , req);
            return;
        }

        resData *res = makeHttpResponse(file_buffer , 200);

    }

    serverRespondNotFound(server , client , req);
    return;

}

int serverHandleClient(httpServer* server ,clientContext *client){
    bool fatal_error = False;
    reqData * req = serverReadAndParseRequest(server,client);
    if(fatal_error){
        serverCloseConnectionHandler(server , client);
        return 0;
    }

    if(req == NULL){
        serverCloseConnectionHandler(server , client);
        return 1;
    }
    serverHandleResource(server , client , req);
    free(req);
    return 1;
}



