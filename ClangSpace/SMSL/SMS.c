#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <malloc.h>
#define TRUE 1
#define FALSE 0
#define MAXCMD 16
#define MAXNAME 20
#define MAXSTU 12
#define CODELEN 8
#define MAXLEN  100
#define ERROR -1
#define OVER 1
#define DATABASE ".SMSdata"

typedef struct stunode
{
    char code[CODELEN + 1];
    char name[MAXNAME + 1];
    struct stunode *next;
} StuNode;

typedef struct
{
    StuNode *head;
    int count;
} StuList;

StuNode *createStuNode(void);
StuList *createStuList(void);
void insert(void);
void delete (void);
void update(void);
void show();
void help();
int save(StuList *stul);
StuList *getData();
StuNode *searchCode(char *code, StuList *stul);
void clearStuList(StuList *stul);
StuNode *checkData(char *data);

int main(void)
{
    while (TRUE)
    {
        char command[MAXCMD];
        printf("SMS> ");
        scanf("%s", command);
        if (strcmp(command, "quit") == 0)
        {
            printf("Bye!\n");
            return 0;
        }
        else if (strcmp(command, "help") == 0)
            help();
        else if (strcmp(command, "insert") == 0)
            insert();
        else if (strcmp(command, "delete") == 0)
            delete ();
        else if (strcmp(command, "update") == 0)
            update();
        else if (strcmp(command, "show") == 0)
            show();
        else
            printf("Illegal Input!");
    }
}

void help()
{
    FILE *file = fopen("README.txt", "r");
    char line[MAXLEN + 1];
    while(fgets(line, MAXLEN, file))
        printf("%s\n", line);
    fclose(file);
}

StuNode *createStuNode(void)
{
    StuNode *stun;
    stun = (StuNode *)malloc(sizeof(StuNode));
    if (stun == NULL)
        return NULL;
    memset(stun->code, 0, CODELEN + 1);
    memset(stun->name, 0, MAXNAME + 1);
    stun->next = NULL;
    return stun;
}

StuList *createStuList(void)
{
    StuList *stul;
    stul = (StuList *)malloc(sizeof(StuList));
    if (stul == NULL)
        return NULL;
    stul->count = 0;
    stul->head = createStuNode();
    if (stul->head == NULL)
        return NULL;
    return stul;
}

void insert(void)
{
    StuNode *stun, *t;
    char data[CODELEN + MAXNAME + 1];
    StuList *stul = getData();
    while (TRUE)
    {
        printf("SMS insert > ");
        scanf("%s", data);
        if (strcmp(data, ".") == 0)
        {
            if (save(stul) == ERROR)
            {
                printf("Can't save, please check the database.\n");
                continue;
            }
            printf("Return.\n");
            clearStuList(stul);
            return;
        }
        stun = checkData(data);
        if (stun == NULL)
            continue;
        t = searchCode(stun->code, stul);
        if (t != NULL)
        {
            printf("The code already exist and the log is %s,%s.\n", t->code, t->name);
            continue;
        }
        stun->next = stul->head->next;
        stul->head->next = stun;
        stul->count++;
    }
}

int save(StuList *stul)
{
    FILE *file = fopen(DATABASE, "w+");
    if (file == NULL)
        return ERROR;
    StuNode *p = stul->head->next;
    for (int i = 0; i < stul->count; i++)
    {
        fprintf(file, "%s,%s\n", p->code, p->name);
        p = p->next;
    }
    fclose(file);
    return OVER;
}

void delete ()
{
    StuList *stul = getData();
    StuNode *t, *stun = stul->head;
    char code[CODELEN];
    while (TRUE)
    {
        printf("SMS delete > ");
        scanf("%s", code);
        if (strcmp(code, ".") == 0)
        {
            if (save(stul) == ERROR)
            {
                printf("Can't save, please check the database.\n");
                continue;
            }
            printf("Return.\n");
            clearStuList(stul);
            return;
        }
        stun = searchCode(code, stul);
        if (stun != NULL)
        {
            t = stun->next;
            stun->next = t->next;
            printf("Deleted %s,%s.\n", t->code, t->name);
            free(t);
            stul->count--;
        }
        else
            printf("There's no %s.\n", code);
    }
}

void update()
{
    StuList *stul = getData();
    StuNode *stun, *t;
    char code[CODELEN+1];
    char newdata[CODELEN + 1 + MAXNAME + 1];
    while (TRUE)
    {
        printf("SMS update > ");
        scanf("%s", code);
        if(strcmp(code, ".") == 0)
        {
            if (save(stul) == ERROR)
            {
                printf("Can't save, please check the database.\n");
                continue;
            }
            printf("Return.\n");
            clearStuList(stul);
            return;
        }
        stun = searchCode(code, stul);
        if (stun != NULL)
        {
            printf("The log is %s,%s, please input the new log.\n", stun->next->code, stun->next->name);
            printf("new log > ");
            scanf("%s", newdata);
            t = checkData(newdata);
            t->next = stun->next->next;
            free(stun->next);
            stun->next = t;
        }
        else
            printf("There's no log of %s.\n", code);
    }
}

void clearStuList(StuList *stul)
{
    StuNode *t, *p;
    for (p = stul->head; p->next != NULL;)
    {
        t = p->next;
        p->next = t->next;
        free(t);
    }
    free(stul->head);
    free(stul);
}

void show()
{
    StuList *stul = getData();
    if (stul == NULL)
    {
        printf("Connot read the database.\n");
        return;
    }
    if (stul->count == 0)
    {
        printf("There's nothing.\n");
        return;
    }
    char code[CODELEN + 1];
    while (TRUE)
    {
        printf("SMS show > ");
        scanf("%s", code);
        if (strcmp(code, ".") == 0)
        {
            printf("Return.\n");
            break;
        }
        StuNode *stun = stul->head->next;
        if (strcmp(code, "*") == 0)
            for (int i = 0; i < stul->count; i++)
            {
                printf("%s, %s\n", stun->code, stun->name);
                stun = stun->next;
            }
        else
        {
            stun = searchCode(code, stul);
            if (stun != NULL)
                printf("Found %s,%s.\n", stun->next->code, stun->next->name);
            else
                printf("Nothing.\n");
        }
    }
    clearStuList(stul);
}

StuList *getData()
{
    StuList *stul = createStuList();
    if (stul == NULL)
        return NULL;
    StuNode *stun = stul->head;
    FILE *file = fopen(DATABASE, "a+");
    if (file == NULL)
        return NULL;
    if(fgetc(file) == EOF)
        return stul;
    fseek(file, 0, SEEK_SET);
    while (!feof(file))
    {
        stun->next = createStuNode();
        if (stun->next == NULL)
            return NULL;
        stun = stun->next;
        fread(stun->code, sizeof(char) * CODELEN, 1, file);
        fgetc(file);
        fscanf(file, "%s\n", stun->name);
        stul->count++;
    }
    fclose(file);
    return stul;
}

StuNode *checkData(char *data)
{
    StuNode *stun = createStuNode();
    int i = 0;
    for (; data[i] >= '0' && data[i] <= '9' && i < CODELEN; i++)
        stun->code[i] = data[i];
    if (i < CODELEN)
    {
        printf("Please check Input with code.\n");
        return NULL;
    }
    if (data[i] != ',')
    {
        printf("Please check Input with split ',' .\n");
        return NULL;
    }
    i++;
    for (; ((data[i] >= 'a' && data[i] <= 'z') || (data[i] >= 'A' && data[i] <= 'Z')) && i < CODELEN + 1 + MAXNAME; i++)
        stun->name[i - CODELEN - 1] = data[i];
    if (data[i] != '\0' && i < CODELEN + 1 + MAXNAME)
    {
        printf("Please check Input with name.\n");
        return NULL;
    }
    return stun;
}

StuNode *searchCode(char *code, StuList *stul)
{
    StuNode *stun = stul->head;
    for (int i = 0; i < stul->count; i++)
    {
        if (strcmp(stun->next->code, code) == 0)
            return stun;
        stun = stun->next;
    }
    return NULL;
}
