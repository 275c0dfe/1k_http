#ifndef _Ext_type_h_
#define _Ext_type_h_

#include "string.h"
#include "stdlib.h"

#define bool int
#define True 1
#define False 0

#define STATUS_OK 200
#define STATUS_BAD_REQUEST 400
#define STATUS_NOT_FOUND 404
#define STATUS_SERVER_ERROR 500

// Slow Data Struct
typedef struct dictionaryDataStruct
{
    char keys[32][32];
    char values[32][64];
    int length;
} Dictionary;

Dictionary *newDictionary()
{
    return (Dictionary *)malloc(sizeof(struct dictionaryDataStruct));
}

void dictionaryAddValue(Dictionary *data, char *key, char *value)
{
    if (strlen(key) > 32)
    {
        // printf("Key Too BIG \n");
        return;
    }

    for (int i = 0; i < data->length; i++)
    {
        if (strcmp(data->keys[i], key) == 0)
        {
            // printf("Entry Already Exists\n");
            return;
        }
    }

    if (strlen(value) > 64)
    {
        // printf("Value Too Big\n");
        return;
    }
    strcpy(data->keys[data->length], key);
    strcpy(data->values[data->length], value);
    data->length++;
    // printf("\r\n%d\r\n" , data->length);
}

void dictionarySetValue(Dictionary *data, char *key, char *value)
{
    int entryIndex = -1;
    for (int i = 0; i < data->length; i++)
    {
        if (strcmp(data->keys[i], key) == 0)
        {
            entryIndex = i;
            break;
        }
    }
    strcpy(data->values[entryIndex], value);
}

char *dictionaryGetValue(Dictionary *data, char *key)
{
    int entryIndex = -1;
    for (int i = 0; i < data->length; i++)
    {
        if (strcmp(data->keys[i], key) == 0)
        {
            entryIndex = i;
            break;
        }
    }
    return data->values[entryIndex];
}

// Header Struct (Just a dictionary)
typedef struct headerDataStruct
{
    char keys[32][32];
    char values[32][128];
    int length;
} headerData;

headerData *newHeaderData()
{
    return (headerData *)malloc(sizeof(struct headerDataStruct));
}

void headerAddValue(headerData *data, char *key, char *value)
{
    if (strlen(key) > 32)
    {
        // printf("Key Too BIG \n");
        return;
    }

    for (int i = 0; i < data->length; i++)
    {
        if (strcmp(data->keys[i], key) == 0)
        {
            // printf("Entry Already Exists\n");
            return;
        }
    }

    if (strlen(value) > 64)
    {
        // printf("Value Too Big\n");
        return;
    }
    strcpy(data->keys[data->length], key);
    strcpy(data->values[data->length], value);
    data->length++;
    // printf("\r\n%d\r\n" , data->length);
}

void headerSetValue(headerData *data, char *key, char *value)
{
    int entryIndex = -1;
    for (int i = 0; i < data->length; i++)
    {
        if (strcmp(data->keys[i], key) == 0)
        {
            entryIndex = i;
            break;
        }
    }
    strcpy(data->values[entryIndex], value);
}

char *headerGetValue(headerData *data, char *key)
{
    int entryIndex = -1;
    for (int i = 0; i < data->length; i++)
    {
        if (strcmp(data->keys[i], key) == 0)
        {
            entryIndex = i;
            break;
        }
    }
    if (entryIndex == -1)
    {
        return NULL;
    }
    return data->values[entryIndex];
}

void headersToText(headerData *data, char *headerBuff)
{
    strcpy(headerBuff, "\0\0\0\0");
    for (int i = 0; i < data->length; i++)
    {
        char *key = data->keys[i];
        char *value = data->values[i];
        char buff[96] = {0};
        sprintf(buff, "%s: %s\r\n", key, value);
        strcat(headerBuff, buff);
    }
}

void headersFromText(headerData *data, char headerLines[33][512])
{
    for (int i = 1; i < 33; i++)
    {
        char *CurrentLine = headerLines[i];
        // printf("%d\r\n" , strlen(CurrentLine));
        if (strlen(CurrentLine) == 0)
        {
            break;
        }
        char *key = strtok(CurrentLine, ": ");
        char *val = strtok(NULL, ": ");
        // printf("Header: %s:%s\r\n" , key, val);
        headerAddValue(data, key, val);
    }
}

#endif