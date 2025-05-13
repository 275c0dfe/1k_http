#include "http.h"


//Dynamic resource function required steps
// Create Response Object
// send Response Object


void indexPage(clientContext *client , reqData *req){
    resData *res = makeHttpResponse("<html> <body> <h1>Home</h1><code>Hello World</code></body></html>" , 200 , client);
    headerAddValue(res->headers , "Connection" , "Close");
    headerAddValue(res->headers , "Server" , "Idk");
    serverSendResponse(client , res);
}

int main(int argc , char**argv){
    httpServer *server = newHttpServer();

    if(!server){
        printf("Unable to Create Socket\n");
        return 0;
    }
    
    //Define or Load Resources
    serverGet(server , "/" , Resource_TYPE_DYNAMIC , indexPage , NULL);
    serverGet(server , "/index" , Resource_TYPE_FILE , "index.html" , NULL);

    
    serverGet(server , "/static" , Resource_TYPE_STATIC , "Hello World" , NULL);
    serverAll(server , "/all" , Resource_TYPE_STATIC , "all Methods supported" , NULL);

    //Server Settings
    server->port = 8000;
    server->is_debug = True;

    if(!serverBind(server)){
        //printf("Bind Error\n");
        return 1;
    }
    if(!serverListen(server)){
        //printf("Listen Error\n");
        return 1;
    }

    serverDebug(server);

    //Basic Running Loop
    while(True){
        clientContext *client = acceptConnection(server);
        int hcode = serverHandleClient(server , client);
        if(!hcode){
            printf("Fatal Server Error Has Occured\n");
            printf("Handle Code: %d\n" , hcode);
            break;
        }
    }
    return 0;
}