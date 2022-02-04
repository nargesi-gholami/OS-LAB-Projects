#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"
#include "fcntl.h"

int main(int argc, char *argv[])
{
    printf(1, "The number of free pages is: %d\n",get_free_pages_count());
    
    exit();
}