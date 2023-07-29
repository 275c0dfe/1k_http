#include "string.h"
#include "ext_types.h"

// Response Parsing
typedef struct responseDataStruct
{
    int status;
    headerData *headers;
    char *body;
} resData;

resData *newResponseData()
{
    resData *res = (resData *)malloc(sizeof(struct responseDataStruct));
    res->body = calloc(30*1024, 1);
    return res;
}

long serializeHttpResponse(char *response, resData *res)
{

    // Get Correct Text Code
    char textCode[32] = {'O', 'K', '\0'};
    if (res->status != STATUS_OK)
    {
        if (res->status == STATUS_BAD_REQUEST)
        {
            strcpy(textCode, "Bad Request");
        }
        if (res->status == STATUS_NOT_FOUND)
        {
            strcpy(textCode, "Not Found");
        }
        if (res->status == STATUS_SERVER_ERROR)
        {
            strcpy(textCode, "Internal Server Error");
        }
    }

    // Status Line
    char statusLine[128] = {0};
    sprintf(statusLine, "HTTP/1.0 %d %s\n", res->status, textCode);
    strcat(response, statusLine);
    // Headers
    char *headers = (char *)malloc(1024 * 2);
    headersToText(res->headers, headers);
    strcat(response, headers);
    // Body
    strcat(response, "\r\n");
    if(headerGetValue(res->headers , "Content-Length")){
        long content_length = 0;
        char content_length_value[16] = {0};
        strcpy(content_length_value , headerGetValue(res->headers, "Content-Length"));
        sscanf(content_length_value , "%ld"  , &content_length);
        int base = strlen(response);
        for(int i=0; i<content_length;i++){
            response[base + i] = res->body[i];
        }
        response[base+content_length+1] = 0;
        free(headers);
        return base + content_length;
    }
    else{
        strcat(response, res->body);
    }
    free(headers);
    return strlen(response);
}

int deserializeHttpResponse(char *asciiData, resData *res)
{
    char *InternalBuffer = calloc(strlen(asciiData+1) , 1);
    strcpy(InternalBuffer, asciiData);

    char headerLines[33][512] = {0};
    char body[1024 * 6] = {0};

    int index = 0;
    int sections = 0;
    char *token = strtok(InternalBuffer, "\n");
    while (token != NULL)
    {
        // printf("%d : %s\r\n", index, token);
        //  for(int i =0; i<strlen(token); i++){
        //      printf("%d " , token[i]);
        //  }
        //  printf("\r\n");
        if (strcmp(token, "\r") == 0)
        {
            // printf("SECTION\r\n");
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
    // printf("Body: %s\r\n" , body);
    headersFromText(res->headers, headerLines);
    char line0[128] = {0};
    char txtCode[32] = {0};
    char NCodeTxt[16] = {0};

    strcpy(line0, headerLines[0]);
    sscanf(line0, "HTTP/1.0 %s %s", NCodeTxt, txtCode);

    res->status = atoi(NCodeTxt);
    strcpy(res->body, body);

    // printf("Status Code: %d\r\n" , req->status);
    // printf("Response Parsed\r\n");

    return 1;
}
