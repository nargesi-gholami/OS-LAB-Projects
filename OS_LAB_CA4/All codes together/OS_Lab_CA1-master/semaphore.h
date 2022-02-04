#define MAXPROC 100

typedef struct
{
    int value;
    struct proc* list[MAXPROC];
    int last;
}semaphore;

