#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"
#include "fcntl.h"

int main(int argc, char *argv[])
{
    if(argc != 1) {
        printf(1, "Insufficient inputs!\n", sizeof("Insufficient inputs!\n"));
    }

    printProcess();    
    exit();
}