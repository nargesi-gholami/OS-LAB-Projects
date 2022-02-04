#include "types.h"
#include "stat.h"
#include "user.h"

int main(int argc, char *argv[])
{
	//int proc1;

	printf(1, "Main Process ID : %d\n", getpid());
	
	sleep(1);
	get_parent_id(getpid());
        sleep(1);
	
        exit();
}