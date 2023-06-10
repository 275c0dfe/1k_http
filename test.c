#include "http.h"


//Dynamic resource function required steps
// Create Response Object
// send Response Object


void indexPage(clientContext *client , reqData *req){
    resData *res = makeHttpResponse("<html> <body> <h1>Home</h1><code>Hello World</code></body></html>" , 200);
    sendResponse(client , res);
}


int handleRequest(httpServer* server ,clientContext *client){
    bool fatal_error = False;

    reqData * req = readAndParseRequest(server,client);    

    if(fatal_error){
        closeConnection(server , client);
        return 0;
    }

    if(req == NULL){
        closeConnection(server , client);
        return 1;
    }
    handleResource(server , client , req);
    free(req);
    return 1;
}

int main(int argc , char**argv){
    httpServer *server = newHttpServer();
    if(!server){
        printf("Unable to Create Socket\n");
        return 0;
    }
    
    //Define or Load Resources
    serverGet(server , "/" , Resource_TYPE_DYNAMIC , indexPage);
    serverGet(server , "/static" , Resource_TYPE_STATIC , "Hello World");
    serverAll(server , "/all" , Resource_TYPE_STATIC , "all Methods supported");

    server->port = 8000;
    if(!serverBind(server)){
        //printf("Bind Error\n");
        return 1;
    }
    if(!serverListen(server)){
        //printf("Listen Error\n");
        return 1;
    }
    
    
    debug(server);

    while(True){
        clientContext *client = acceptConnection(server);
        int hcode = handleRequest(server , client);
        if(!hcode){
            break;
        }
    }
    return 0;
}