#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"
#include "fcntl.h"

int main(int argc, char *argv[])
{
    int fd = open("test.txt", O_CREATE|O_RDWR);
        
    int length = 10;
    char* text = (char*)mmap(0, length, PROT_READ, MAP_PRIVATE, fd, 0);
    text[0] = '1';
    text[1] = '2';

    exit();
}
