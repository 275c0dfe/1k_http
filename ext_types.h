#include "string.h"
#include "stdlib.h"
#define bool int
#define True 1
#define False 0

//Slow Data Struct
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
