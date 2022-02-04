#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"

#define O_RDONLY  0x000
#define O_WRONLY  0x001
#define O_RDWR    0x002
#define O_CREATE  0x200


int convertToChar(int buf[], int j, char rev_buf[]){
  char charInt[] = "0123456789";
  int counter = 0;
  char charBuff[512];
  for(int i = 0; i < j; i++){
      while(buf[i] > 0){
        int rem = buf[i]%10;
        buf[i] /= 10;
        for(int k = 0; k < 10; k++){
          if(rem == k)
            charBuff[counter++] = charInt[k];
        }
      }
      if(i != j-1)
        charBuff[counter++] = ' ';
  }
  
  for(int i = counter-1; i >= 0; i--)
      rev_buf[counter-i-1] = charBuff[i];

  rev_buf[counter++] = '\n';

  return counter;
}

void factor(int n){
    char tBuf[2];
    char rev_buf[512];
    int intBuf[512];
    int j = 0;
    int fd = open("factor_result.txt", O_CREATE|O_RDWR);

    if(fd<0){
      printf(1, "File cannot be opened\n");
    }

    if(read(fd, tBuf, 1)){
      unlink("factor_result.txt");
      fd = open("factor_result.txt", O_CREATE|O_RDWR);
    } 
    
    for(int i=n;i>=1;i--)
        if (n%i==0)
            intBuf[j++] = i;

    int counter = convertToChar(intBuf, j, rev_buf);
    
    if(write(fd, rev_buf, counter) != counter) {
      printf(1, "factor: write error\n");
      exit();
    }
    close(fd);
}


int
main(int argc, char *argv[])
{
  char charInt[] = "0123456789";
  char* y = argv[1];
  int num = 0, mod = 1;
  for(int i = strlen(y)-1; i >= 0; i--){
    for(int j = 0; j < 10; j++){
      if(y[i] == charInt[j]) {
        num += mod*j; 
        mod *= 10;
      }
    }
  }
  
  if(argc < 2){
    exit();
  }
  factor(num);
  exit();
}
