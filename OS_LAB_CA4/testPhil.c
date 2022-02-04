#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"
#include "fcntl.h"

void phil(int phil_id)
{
    double x = 0;
    for(int j = 0 ; j < 10 ; j++)
    {
        sem_acquire(5);
        sem_acquire(phil_id % 5);
        sem_acquire(phil_id - 1);

        // printf(1, "Philosopher %d is eating with %d and %d  \n", phil_id, phil_id % 5, phil_id - 1);        
        //eat
        for(int i = 0 ; i < 2000000000 ; i+= 1)
            x += 80.86;

        sem_release(phil_id % 5);
        sem_release(phil_id - 1);
        sem_release(5);

        // printf(1, "Philosopher %d is thinking and releasing %d and %d \n", phil_id, phil_id % 5, phil_id - 1);
        //think
        for(int i = 0 ; i < 200000 ; i++)
            x += 80.86;        
    }
    exit();
}

int main()
{
    sem_init(0, 1);
    sem_init(1, 1);
    sem_init(2, 1);
    sem_init(3, 1);
    sem_init(4, 1);
    sem_init(5, 4);

    for(int i = 0 ; i < 5 ; i++)
    {
        int id = fork();
        if(!id)
            phil(i+1);
    }
    exit();
}