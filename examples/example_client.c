#include "http_client.h"

int main(int argc , char **argv){
    httpClient *client = newHttpClient("http://example.com/");
    if(!clientConnect(client)){
        printf("Failed To Connect To Host\n");
        return 1;
    }

    resData *res = httpGetRequest(client , NULL); //If Headers Are Null Default Headers will be created
    if(res->status == STATUS_OK){
        printf("Request Successful\n%s\n" , res->body);
    }
    else{
        printf("Request Failed\nStatus Code: %d\n%s\n" , res->status , res->body);
    }
}