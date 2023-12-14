#if !defined(_HTTP_1KLIB)
#define _HTTP_1KLIB
    //List of dependencies
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
    #include "libs/url.h"
    #include "libs/ext_types.h"
    #include "libs/request.h"
    #include "libs/response.h"
    #include "libs/http_client.h"
    #include "libs/http_server.h"

#endif // HTTP_1KLIB