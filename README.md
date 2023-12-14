# 1k_http
A HTTP server and client framework written in less than 1 thousand lines of c code. Designed to be very lightweight and highly extensible while still being very simple to use. 


# TODO
- Add cookie parsing.
- Add querystring parsing.
- testing for buffer overflows and memory leaks.



# Docs



## Server 
### Constants:

```c
#define Resource_TYPE_STATIC 0
#define Resource_TYPE_DYNAMIC 1
#define Resource_TYPE_FILE 2
```

- These constants define resource types, indicating whether a resource is static, dynamic, or a file.

### `clientForSvrStruct` Structure:

```c
typedef struct clientForSvrStruct
{
    int socket;
    struct sockaddr_in addr;
} clientContext;
```

- Represents a client when handling on the server side.
- `socket`: File descriptor for the client's socket.
- `addr`: Structure containing information about the client's socket address.

### `newClientContext` Function:

```c
clientContext *newClientContext()
{
    return (clientContext *)malloc(sizeof(struct clientForSvrStruct));
}
```

- Allocates memory for a new `clientContext` structure and returns a pointer to it.

### `ResourceStruct` Structure:

```c
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
```

- Represents an HTTP resource.
- `id`: Unique identifier for the resource.
- `path`: Path of the resource.
- `method`: HTTP method associated with the resource.
- `type`: Type of the resource (static, dynamic, or file).
- `local_path`: Path on the local system for file resources.
- `static_content`: Content for static resources.
- `headers`: Pointer to header data.
- `dynamic`: Function pointer for dynamic resources.

### `newResource` Function:

```c
Resource *newResource()
{
    // ...
}
```

- Allocates memory for a new `Resource` structure and initializes default values.

### `httpServerStruct` Structure:

```c
typedef struct httpServerStruct
{
    int socket;
    int port;
    char host[256];
    struct sockaddr_in *addr;
    int is_debug;
    int is_bound;
    int is_listening;
    int clients_connected;
    Resource *resources[64];
    int resource_count;
} httpServer;
```

- Represents an HTTP server.
- `socket`: File descriptor for the server's socket.
- `port`: Port number for the server.
- `host`: Hostname for the server.
- `addr`: Pointer to a structure containing server address information.
- `is_debug`: Flag indicating whether the server is in debug mode.
- `is_bound`: Flag indicating whether the server is bound to a socket.
- `is_listening`: Flag indicating whether the server is actively listening.
- `clients_connected`: Number of connected clients.
- `resources`: Array of pointers to `Resource` structures.
- `resource_count`: Number of resources in the array.

### `newHttpServer` Function:

```c
httpServer *newHttpServer()
{
    // ...
}
```

- Allocates memory for a new `httpServer` structure and initializes default values. Creates a socket for the server.

### `serverBind` Function:

```c
int serverBind(httpServer *server);
```

- Binds the server to a socket.
- Parameters:
  - `server`: Pointer to the `httpServer` structure.
- Returns `1` on success, `0` on failure.

### `serverListen` Function:

```c
int serverListen(httpServer *server);
```

- Listens for incoming connections on the server socket.
- Parameters:
  - `server`: Pointer to the `httpServer` structure.
- Returns `1` on success, `0` on failure.

### `acceptConnection` Function:

```c
clientContext *acceptConnection(httpServer *server);
```

- Accepts a new client connection.
- Parameters:
  - `server`: Pointer to the `httpServer` structure.
- Returns a pointer to a new `clientContext` on success, `NULL` on failure.

### `serverCloseConnectionHandler` Function:

```c
void serverCloseConnectionHandler(httpServer *server, clientContext *client);
```

- Closes the connection for a given client.
- Parameters:
  - `server`: Pointer to the `httpServer` structure.
  - `client`: Pointer to the `clientContext` structure.

### `serverReadHttpRequest` Function:

```c
bool serverReadHttpRequest(httpServer *server, clientContext *client, char *buffer);
```

- Reads an HTTP request from the client.
- Parameters:
  - `server`: Pointer to the `httpServer` structure.
  - `client`: Pointer to the `clientContext` structure.
  - `buffer`: Pointer to the buffer to store the request.
- Returns `True` on success, `False` on failure.

### `serverWriteHttpResponse` Function:

```c
bool serverWriteHttpResponse(clientContext *client, char *buffer, long buffer_size);
```

- Writes an HTTP response to the client.
- Parameters:
  - `client`: Pointer to the `clientContext` structure.
  - `buffer`: Pointer to the buffer containing the response.
  - `buffer_size`: Size of the buffer.
- Returns `True` on success, `False` on failure.

### `serverReadAndParseRequest` Function:

```c
reqData *serverReadAndParseRequest(httpServer *server, clientContext *client);
```

- Reads and parses an HTTP request from the client.
- Parameters:
  - `server`: Pointer to the `httpServer` structure.
  - `client`: Pointer to the `clientContext` structure.
- Returns a pointer to a `reqData` structure on success, `NULL` on failure.

### `serverSendResponse` Function:

```c
int serverSendResponse(clientContext *client, resData *res);
```

- Sends an HTTP response to the client.
- Parameters:
  - `client`: Pointer to the `clientContext` structure.
  - `res`: Pointer to the `resData` structure representing the response.
- Returns `True` on success, `False` on failure.

### `makeHttpResponse` Function:

```c
resData *makeHttpResponse(char *content, int status);
```

- Creates an HTTP response with the given content and status.
- Parameters:
  - `content`: Pointer to the content of the response.
  - `status`: HTTP status code.
- Returns a pointer to a `resData` structure representing the response.


### `serverFinishAndSendResponse` Function:

```c
void serverFinishAndSendResponse(httpServer *server, clientContext *client, resData *res);
```

- Finalizes the response by adding headers, sending it to the client, and then closing the connection.
- Parameters:
  - `server`: Pointer to the `httpServer` structure.
  - `client`: Pointer to the `clientContext` structure.
  - `res`: Pointer to the `resData` structure representing the response.
- Note: Frees the memory allocated for the response.

### `serverDebug` Function:

```c
void serverDebug(httpServer *server);
```

- Enables debug mode for the HTTP server.
- Parameters:
  - `server`: Pointer to the `httpServer` structure.

### Resource Registration Functions (`serverGet`, `serverPost`, `serverAll`):

```c
void serverGet(httpServer *server, char *path, int type, void *resource_data, headerData *headers);
void serverPost(httpServer *server, char *path, int type, void *resource_data, headerData *headers);
void serverAll(httpServer *server, char *path, int type, void *resource_data, headerData *headers);
```

- Registers a new resource with the HTTP server for GET, POST, or all HTTP methods.
- Parameters:
  - `server`: Pointer to the `httpServer` structure.
  - `path`: Path of the resource.
  - `type`: Type of the resource (static, dynamic, or file).
  - `resource_data`: Data associated with the resource (content, function pointer, or file path).
  - `headers`: Pointer to header data associated with the resource (optional).

### `serverRespondNotFound` Function:

```c
void serverRespondNotFound(httpServer *server, clientContext *client, reqData *req, void *info);
```

- Sends a 404 Not Found response to the client for a resource that was not found.
- Parameters:
  - `server`: Pointer to the `httpServer` structure.
  - `client`: Pointer to the `clientContext` structure.
  - `req`: Pointer to the `reqData` structure representing the request.
  - `info`: Additional information about the resource not found (optional).
- Note: Frees the memory allocated for the response.


### `serverHandleResource` Function:

```c
void serverHandleResource(httpServer *server, clientContext *client, reqData *req);
```

- Handles the requested resource based on the HTTP method and path.
- Parameters:
  - `server`: Pointer to the `httpServer` structure.
  - `client`: Pointer to the `clientContext` structure.
  - `req`: Pointer to the `reqData` structure representing the request.

### `serverHandleClient` Function:

```c
int serverHandleClient(httpServer *server, clientContext *client);
```

- Handles the entire client request, including reading and parsing the request, handling the resource, and closing the connection.
- Parameters:
  - `server`: Pointer to the `httpServer` structure.
  - `client`: Pointer to the `clientContext` structure.
- Returns `1` on success, `0` on fatal error.

### `redirect` Function:

```c
resData* redirect(char * path);
```

- Creates a redirection response with a given path.
- Parameters:
  - `path`: Path to which the client should be redirected.
- Returns a pointer to the `resData` structure representing the redirection response.

### Additional Notes:

- `serverHandleResource` iterates through registered resources to find a match based on the request's path and method.
- It handles static content, dynamic content, and file resources accordingly, generating appropriate HTTP responses.
- If no matching resource is found, it responds with a 404 Not Found error.

### Example Server Usage:

```c
#include "http.h"

// Dynamic resource function for the index page
void indexPage(clientContext *client, reqData *req) {
    // Create a response with HTML content
    resData *res = makeHttpResponse("<html><body><h1>Home</h1><code>Hello World</code></body></html>", 200);

    // Set additional headers
    headerAddValue(res->headers, "Connection", "Close");
    headerAddValue(res->headers, "Server", "Idk");

    // Send the response to the client and close the connection
    serverFinishAndSendResponse(server, client, res);
}

int main(int argc, char **argv) {
    // Create a new HTTP server instance
    httpServer *server = newHttpServer();

    // Check if the server was created successfully
    if (!server) {
        printf("Unable to Create Socket\n");
        return 0;
    }

    // Define or Load Resources
    // Define a dynamic resource at '/'
    serverGet(server, "/", Resource_TYPE_DYNAMIC, indexPage, NULL);

    // Define a file resource at '/index'
    serverGet(server, "/index", Resource_TYPE_FILE, "index.html", NULL);

    // Define a static resource at '/static'
    serverGet(server, "/static", Resource_TYPE_STATIC, "Hello World", NULL);

    // Define a static resource at '/all' responding to all HTTP methods
    serverAll(server, "/all", Resource_TYPE_STATIC, "all Methods supported", NULL);

    // Server Settings
    // Set the port to 8000
    server->port = 8000;
    // Enable debug mode
    server->is_debug = True;

    // Bind the server to the specified port
    if (!serverBind(server)) {
        printf("Bind Error\n");
        return 1;
    }

    // Start listening for incoming connections
    if (!serverListen(server)) {
        printf("Listen Error\n");
        return 1;
    }

    // Enable debug output
    serverDebug(server);

    // Basic Running Loop
    while (True) {
        // Accept a connection from a client
        clientContext *client = acceptConnection(server);

        // Handle the client request
        int handleCode = serverHandleClient(server, client);

        // Check for fatal errors during request handling
        if (!handleCode) {
            printf("Fatal Server Error Has Occurred\n");
            printf("Handle Code: %d\n", handleCode);
            break;
        }
    }

    return 0;
}
```

