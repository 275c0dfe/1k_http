#include "string.h"
#include "ext_types.h"

//Request Parsing
typedef struct requestDataStruct{
    char path[500];
    char method[8];
    headerData *headers;
    char body[1024*12];
} reqData;

reqData *newRequestData(){
    reqData *req = (reqData*)malloc(sizeof(struct requestDataStruct));
    strcpy(req->path , "/");
    strcpy(req->method , "GET");
    return req;
}

int deserializeHttpRequest(char *asciiData , reqData *req){
    char lines[33][512] = {0};
    char body[1024*8] = {0};
    char InternalBuffer[1024 * 22] = {0};
    strcpy(InternalBuffer , asciiData);

    //Ripped Straight From parseHttpResponse
    int line_count = 0;
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
                strcat(lines[index], token);
                line_count++;
            }
            if (sections > 0)
            {
                //Parse Body
                strcat(body, token);
                strcat(body, "\r\n");
            }
        }
        index++;
        token = strtok(NULL, "\n");
    }
    /*
    for(int i =0;i<line_count;i++){
        char *line = lines[i];
        
        printf("%d : %s\n" , i , line);
    }*/
    char line0[512] = {0};
    strcpy(line0 , lines[0]);
    //printf("%s\n" , line0);
    
    headersFromText(req->headers , lines);
    
    //printf("Headers Parsed: %d\n" , req->headers->length);
    char path[500] = {0};
    char method[8] = {0};
    int subver = 1;

    sscanf(line0 , "%s %s HTTP/1.1" , method , path);
    
    if(strcmp(line0 , "") == 0){
        //printf("Empty Request\n");
        return 0;
    }

    char *hst = headerGetValue(req->headers, "Host");
    if(hst != NULL){
        //printf("Host: %s" , headerGetValue(req->headers , "Host"));
    }
    strcpy(req->path , path);
    strcpy(req->method , method);
    strcpy(req->body , body);

    
    return 1;

}
