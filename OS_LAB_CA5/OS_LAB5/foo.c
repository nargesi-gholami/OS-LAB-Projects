#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int main(int argc, char *argv[])
{
    int k = 0, n = 2, id, factor = 5;
    double x=0, z;
    x = 0;
    id = 0;
    //printf(1, "here!\n");
    while(k<n)
    {
        id = fork();
        if(id < 0)
            printf(1, "%d failed in fork!\n", getpid());
        else if(id > 0) {
            wait();
        }
        else
        {   // Child
            double end = 250000.0 * factor; 
            for(z=0;z<end;z+=0.001)
                x = x + 3.14*89.64; // Useless calculations to consume CPU time
            break;
        }
        k++;
    }
    exit();
}