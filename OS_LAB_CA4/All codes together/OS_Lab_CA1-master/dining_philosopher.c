#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"
#include "fcntl.h"


int main(int argc, char *argv[])
{
    printf(1,"hiiiiiiiiiiii\n");
    
    int phil_id = atoi(argv[1]);
    for(int j = 0 ; j < 10 ; j++)
    {
        sem_acquire(0);
        sem_acquire(phil_id);
        sem_acquire(phil_id % 5 - 1);

        int cal = 1;

        printf(1, "Philosopher %d is eating\n", phil_id);

        for(int i = 0 ; i < 20000 ; i++)
            cal *= 10*cal*phil_id;
        
        sem_release(phil_id);
        sem_release(phil_id % 5 - 1);
        sem_release(0);

        printf(1, "Philosopher %d is thinking\n", phil_id);
        for(int i = 0 ; i < 20000 ; i++)
            cal *= 10*phil_id;
    }

    exit();
}