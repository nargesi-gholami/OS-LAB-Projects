#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"
#include "fs.h"

int
main(int argc, char *argv[])// change this
{
    
  if(argc != 2)
  {
    printf(2, "usage: get file sectors...\n");
    exit();
  }
  else
  {
    int fd = open(argv[1], O_CREATE | O_RDONLY);
    int addr[NDIRECT+1];
    get_file_sectors(fd, addr);
    printf(1, "sectors are: \n");
    for( int i = 0 ; i < NDIRECT+1 ; i++)
      printf(1, "%d ", addr[i]);
    printf(1, "\n");

    close(fd);
    exit();
  }
}