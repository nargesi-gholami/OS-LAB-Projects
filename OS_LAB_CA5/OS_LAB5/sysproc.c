#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
  return fork();
}

int
sys_exit(void)
{
  exit();
  return 0;  // not reached
}

int
sys_wait(void)
{
  return wait();
}

int
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

int
sys_getpid(void)
{
  return myproc()->pid;
}

int
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

int
sys_sleep(void)
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}

int sys_printProcess(void) {
  return printProcess();
}

int sys_changeProcessMHRRN(void) {
  int pid, priority;
  if (argint(0, &pid) < 0) 
    return -1;
  if (argint(1, &priority) < 0) 
    return -1;
  return changeProcessMHRRN(pid, priority);
}

int sys_changeSystemMHRRN(void) {
  int priority;
  if (argint(0, &priority) < 0) 
    return -1;
  return changeSystemMHRRN(priority);
}


int sys_sem_init(void)
{
  int i, v;
  if (argint(0, &i) < 0) 
    return -1;
  if (argint(1, &v) < 0) 
    return -1;
  return sem_init(i, v);
}

int sys_sem_acquire(void)
{
  int i;
  if (argint(0, &i) < 0) 
    return -1;

  return sem_acquire(i);
}

int sys_sem_release(void)
{
  int i;
  if (argint(0, &i) < 0) 
    return -1;
  return sem_release(i);
}

int sys_mmap(void) 
{
  int addr = 0;
  int length;
  int prot, flag, fd, offset;
  argint(1, &length);
  argint(2, &prot);
  argint(3, &flag);
  argint(4, &fd);
  argint(5, &offset);

  int a = mmap(addr, length, prot, flag, fd, offset);
  return a;
}

int sys_get_free_pages_count(void)
{
  return get_free_pages_count();
}
