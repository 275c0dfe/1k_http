#include "sys/socket.h"
#include "sys/types.h"
#include "arpa/inet.h"
#include "netinet/in.h"
#include "netdb.h"
#include "ext_types.h"
#include "stdio.h"
#include "unistd.h"
#include "string.h"


#include "request.h"
#include "response.h"
#include "url.h"


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

resData *httpGetRequest(httpClient *client, headerData *headers)
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
        //printf("Error Receiving Data\r\n");
        dsize = clientRead(client , InBuffer);
    }
    resData *req = newResponseData();
    req->headers = newHeaderData();
    deserializeHttpResponse(InBuffer, req);

    //printf("%s\n", InBuffer);
    //printf("Data Recieved: %d Bytes\r\n", dsize);

    return req;
}
