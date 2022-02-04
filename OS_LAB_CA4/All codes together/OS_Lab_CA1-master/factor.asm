
_factor:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
}


int
main(int argc, char *argv[])
{
   0:	f3 0f 1e fb          	endbr32 
   4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   8:	83 e4 f0             	and    $0xfffffff0,%esp
  char charInt[] = "0123456789";
   b:	ba 38 39 00 00       	mov    $0x3938,%edx
{
  10:	ff 71 fc             	pushl  -0x4(%ecx)
  13:	55                   	push   %ebp
  14:	89 e5                	mov    %esp,%ebp
  16:	57                   	push   %edi
  17:	56                   	push   %esi
  18:	53                   	push   %ebx
  19:	51                   	push   %ecx
  1a:	83 ec 34             	sub    $0x34,%esp
  1d:	8b 01                	mov    (%ecx),%eax
  char charInt[] = "0123456789";
  1f:	c7 45 dd 30 31 32 33 	movl   $0x33323130,-0x23(%ebp)
  26:	c7 45 e1 34 35 36 37 	movl   $0x37363534,-0x1f(%ebp)
{
  2d:	89 45 d0             	mov    %eax,-0x30(%ebp)
  30:	8b 41 04             	mov    0x4(%ecx),%eax
  char charInt[] = "0123456789";
  33:	66 89 55 e5          	mov    %dx,-0x1b(%ebp)
  char* y = argv[1];
  37:	8b 40 04             	mov    0x4(%eax),%eax
  char charInt[] = "0123456789";
  3a:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
  int num = 0, mod = 1;
  for(int i = strlen(y)-1; i >= 0; i--){
  3e:	50                   	push   %eax
  char* y = argv[1];
  3f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  for(int i = strlen(y)-1; i >= 0; i--){
  42:	e8 a9 03 00 00       	call   3f0 <strlen>
  47:	83 c4 10             	add    $0x10,%esp
  4a:	83 e8 01             	sub    $0x1,%eax
  4d:	78 5f                	js     ae <main+0xae>
  4f:	89 c7                	mov    %eax,%edi
  int num = 0, mod = 1;
  51:	ba 01 00 00 00       	mov    $0x1,%edx
  56:	31 f6                	xor    %esi,%esi
  58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  5f:	90                   	nop
    for(int j = 0; j < 10; j++){
      if(y[i] == charInt[j]) {
  60:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  63:	b9 30 00 00 00       	mov    $0x30,%ecx
  68:	0f b6 1c 38          	movzbl (%eax,%edi,1),%ebx
    for(int j = 0; j < 10; j++){
  6c:	31 c0                	xor    %eax,%eax
  6e:	eb 05                	jmp    75 <main+0x75>
  70:	0f b6 4c 05 dd       	movzbl -0x23(%ebp,%eax,1),%ecx
      if(y[i] == charInt[j]) {
  75:	38 cb                	cmp    %cl,%bl
  77:	75 0c                	jne    85 <main+0x85>
        num += mod*j; 
  79:	89 d1                	mov    %edx,%ecx
        mod *= 10;
  7b:	8d 14 92             	lea    (%edx,%edx,4),%edx
        num += mod*j; 
  7e:	0f af c8             	imul   %eax,%ecx
        mod *= 10;
  81:	01 d2                	add    %edx,%edx
        num += mod*j; 
  83:	01 ce                	add    %ecx,%esi
    for(int j = 0; j < 10; j++){
  85:	83 c0 01             	add    $0x1,%eax
  88:	83 f8 0a             	cmp    $0xa,%eax
  8b:	75 e3                	jne    70 <main+0x70>
  for(int i = strlen(y)-1; i >= 0; i--){
  8d:	83 ef 01             	sub    $0x1,%edi
  90:	83 ff ff             	cmp    $0xffffffff,%edi
  93:	75 cb                	jne    60 <main+0x60>
      }
    }
  }
  
  if(argc < 2){
  95:	83 7d d0 01          	cmpl   $0x1,-0x30(%ebp)
  99:	7e 0e                	jle    a9 <main+0xa9>
    exit();
  }
  factor(num);
  9b:	83 ec 0c             	sub    $0xc,%esp
  9e:	56                   	push   %esi
  9f:	e8 ac 01 00 00       	call   250 <factor>
  exit();
  a4:	e8 2a 05 00 00       	call   5d3 <exit>
    exit();
  a9:	e8 25 05 00 00       	call   5d3 <exit>
  int num = 0, mod = 1;
  ae:	31 f6                	xor    %esi,%esi
  b0:	eb e3                	jmp    95 <main+0x95>
  b2:	66 90                	xchg   %ax,%ax
  b4:	66 90                	xchg   %ax,%ax
  b6:	66 90                	xchg   %ax,%ax
  b8:	66 90                	xchg   %ax,%ax
  ba:	66 90                	xchg   %ax,%ax
  bc:	66 90                	xchg   %ax,%ax
  be:	66 90                	xchg   %ax,%ax

000000c0 <convertToChar>:
int convertToChar(int buf[], int j, char rev_buf[]){
  c0:	f3 0f 1e fb          	endbr32 
  c4:	55                   	push   %ebp
  char charInt[] = "0123456789";
  c5:	b8 38 39 00 00       	mov    $0x3938,%eax
int convertToChar(int buf[], int j, char rev_buf[]){
  ca:	89 e5                	mov    %esp,%ebp
  cc:	57                   	push   %edi
  cd:	56                   	push   %esi
  ce:	53                   	push   %ebx
  cf:	81 ec 20 02 00 00    	sub    $0x220,%esp
  for(int i = 0; i < j; i++){
  d5:	8b 55 0c             	mov    0xc(%ebp),%edx
  char charInt[] = "0123456789";
  d8:	c7 85 e9 fd ff ff 30 	movl   $0x33323130,-0x217(%ebp)
  df:	31 32 33 
  e2:	c7 85 ed fd ff ff 34 	movl   $0x37363534,-0x213(%ebp)
  e9:	35 36 37 
  ec:	66 89 85 f1 fd ff ff 	mov    %ax,-0x20f(%ebp)
  f3:	c6 85 f3 fd ff ff 00 	movb   $0x0,-0x20d(%ebp)
  for(int i = 0; i < j; i++){
  fa:	85 d2                	test   %edx,%edx
  fc:	0f 8e 34 01 00 00    	jle    236 <convertToChar+0x176>
 102:	c7 85 d8 fd ff ff 00 	movl   $0x0,-0x228(%ebp)
 109:	00 00 00 
 10c:	8b 45 0c             	mov    0xc(%ebp),%eax
  int counter = 0;
 10f:	31 db                	xor    %ebx,%ebx
 111:	83 e8 01             	sub    $0x1,%eax
 114:	89 85 d4 fd ff ff    	mov    %eax,-0x22c(%ebp)
 11a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      while(buf[i] > 0){
 120:	8b 8d d8 fd ff ff    	mov    -0x228(%ebp),%ecx
 126:	8b 45 08             	mov    0x8(%ebp),%eax
 129:	8b 04 88             	mov    (%eax,%ecx,4),%eax
 12c:	8d 4b 01             	lea    0x1(%ebx),%ecx
 12f:	89 85 dc fd ff ff    	mov    %eax,-0x224(%ebp)
 135:	85 c0                	test   %eax,%eax
 137:	0f 8e 80 00 00 00    	jle    1bd <convertToChar+0xfd>
 13d:	8d 76 00             	lea    0x0(%esi),%esi
        int rem = buf[i]%10;
 140:	8b bd dc fd ff ff    	mov    -0x224(%ebp),%edi
 146:	b8 cd cc cc cc       	mov    $0xcccccccd,%eax
 14b:	f7 e7                	mul    %edi
 14d:	c1 ea 03             	shr    $0x3,%edx
 150:	8d 04 92             	lea    (%edx,%edx,4),%eax
 153:	89 d6                	mov    %edx,%esi
 155:	01 c0                	add    %eax,%eax
        buf[i] /= 10;
 157:	89 b5 dc fd ff ff    	mov    %esi,-0x224(%ebp)
        int rem = buf[i]%10;
 15d:	29 c7                	sub    %eax,%edi
        for(int k = 0; k < 10; k++){
 15f:	31 c0                	xor    %eax,%eax
        int rem = buf[i]%10;
 161:	89 fa                	mov    %edi,%edx
        for(int k = 0; k < 10; k++){
 163:	eb 0b                	jmp    170 <convertToChar+0xb0>
 165:	8d 76 00             	lea    0x0(%esi),%esi
 168:	83 c0 01             	add    $0x1,%eax
 16b:	83 f8 0a             	cmp    $0xa,%eax
 16e:	74 33                	je     1a3 <convertToChar+0xe3>
          if(rem == k)
 170:	8d 4b 01             	lea    0x1(%ebx),%ecx
 173:	89 8d e0 fd ff ff    	mov    %ecx,-0x220(%ebp)
 179:	39 c2                	cmp    %eax,%edx
 17b:	75 eb                	jne    168 <convertToChar+0xa8>
            charBuff[counter++] = charInt[k];
 17d:	0f b6 8c 15 e9 fd ff 	movzbl -0x217(%ebp,%edx,1),%ecx
 184:	ff 
 185:	8d 7b 02             	lea    0x2(%ebx),%edi
        for(int k = 0; k < 10; k++){
 188:	83 c0 01             	add    $0x1,%eax
            charBuff[counter++] = charInt[k];
 18b:	88 8c 1d f4 fd ff ff 	mov    %cl,-0x20c(%ebp,%ebx,1)
 192:	8b 9d e0 fd ff ff    	mov    -0x220(%ebp),%ebx
 198:	89 bd e0 fd ff ff    	mov    %edi,-0x220(%ebp)
        for(int k = 0; k < 10; k++){
 19e:	83 f8 0a             	cmp    $0xa,%eax
 1a1:	75 cd                	jne    170 <convertToChar+0xb0>
 1a3:	8b 8d e0 fd ff ff    	mov    -0x220(%ebp),%ecx
      while(buf[i] > 0){
 1a9:	85 f6                	test   %esi,%esi
 1ab:	75 93                	jne    140 <convertToChar+0x80>
 1ad:	8b 45 08             	mov    0x8(%ebp),%eax
 1b0:	8b b5 d8 fd ff ff    	mov    -0x228(%ebp),%esi
 1b6:	c7 04 b0 00 00 00 00 	movl   $0x0,(%eax,%esi,4)
      if(i != j-1)
 1bd:	8b bd d8 fd ff ff    	mov    -0x228(%ebp),%edi
 1c3:	89 c8                	mov    %ecx,%eax
 1c5:	39 bd d4 fd ff ff    	cmp    %edi,-0x22c(%ebp)
 1cb:	74 0d                	je     1da <convertToChar+0x11a>
        charBuff[counter++] = ' ';
 1cd:	c6 84 1d f4 fd ff ff 	movb   $0x20,-0x20c(%ebp,%ebx,1)
 1d4:	20 
 1d5:	83 c0 01             	add    $0x1,%eax
 1d8:	89 cb                	mov    %ecx,%ebx
  for(int i = 0; i < j; i++){
 1da:	83 85 d8 fd ff ff 01 	addl   $0x1,-0x228(%ebp)
 1e1:	8b 8d d8 fd ff ff    	mov    -0x228(%ebp),%ecx
 1e7:	39 4d 0c             	cmp    %ecx,0xc(%ebp)
 1ea:	0f 85 30 ff ff ff    	jne    120 <convertToChar+0x60>
  for(int i = counter-1; i >= 0; i--)
 1f0:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1f3:	01 d9                	add    %ebx,%ecx
 1f5:	89 8d e0 fd ff ff    	mov    %ecx,-0x220(%ebp)
 1fb:	85 db                	test   %ebx,%ebx
 1fd:	74 23                	je     222 <convertToChar+0x162>
 1ff:	8b 7d 10             	mov    0x10(%ebp),%edi
 202:	8d 8d f4 fd ff ff    	lea    -0x20c(%ebp),%ecx
 208:	8d b4 1d f3 fd ff ff 	lea    -0x20d(%ebp,%ebx,1),%esi
 20f:	90                   	nop
      rev_buf[counter-i-1] = charBuff[i];
 210:	0f b6 16             	movzbl (%esi),%edx
 213:	83 c7 01             	add    $0x1,%edi
 216:	88 57 ff             	mov    %dl,-0x1(%edi)
  for(int i = counter-1; i >= 0; i--)
 219:	89 f2                	mov    %esi,%edx
 21b:	83 ee 01             	sub    $0x1,%esi
 21e:	39 ca                	cmp    %ecx,%edx
 220:	75 ee                	jne    210 <convertToChar+0x150>
  rev_buf[counter++] = '\n';
 222:	8b 8d e0 fd ff ff    	mov    -0x220(%ebp),%ecx
 228:	c6 01 0a             	movb   $0xa,(%ecx)
}
 22b:	81 c4 20 02 00 00    	add    $0x220,%esp
 231:	5b                   	pop    %ebx
 232:	5e                   	pop    %esi
 233:	5f                   	pop    %edi
 234:	5d                   	pop    %ebp
 235:	c3                   	ret    
  for(int i = 0; i < j; i++){
 236:	8b 45 10             	mov    0x10(%ebp),%eax
 239:	89 85 e0 fd ff ff    	mov    %eax,-0x220(%ebp)
 23f:	b8 01 00 00 00       	mov    $0x1,%eax
 244:	eb dc                	jmp    222 <convertToChar+0x162>
 246:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 24d:	8d 76 00             	lea    0x0(%esi),%esi

00000250 <factor>:
void factor(int n){
 250:	f3 0f 1e fb          	endbr32 
 254:	55                   	push   %ebp
 255:	89 e5                	mov    %esp,%ebp
 257:	57                   	push   %edi
 258:	56                   	push   %esi
 259:	53                   	push   %ebx
 25a:	81 ec 24 0a 00 00    	sub    $0xa24,%esp
 260:	8b 5d 08             	mov    0x8(%ebp),%ebx
    int fd = open("factor_result.txt", O_CREATE|O_RDWR);
 263:	68 02 02 00 00       	push   $0x202
 268:	68 c8 0a 00 00       	push   $0xac8
 26d:	e8 a1 03 00 00       	call   613 <open>
    if(fd<0){
 272:	83 c4 10             	add    $0x10,%esp
    int fd = open("factor_result.txt", O_CREATE|O_RDWR);
 275:	89 c6                	mov    %eax,%esi
    if(fd<0){
 277:	85 c0                	test   %eax,%eax
 279:	0f 88 c1 00 00 00    	js     340 <factor+0xf0>
    if(read(fd, tBuf, 1)){
 27f:	83 ec 04             	sub    $0x4,%esp
 282:	8d 85 e6 f5 ff ff    	lea    -0xa1a(%ebp),%eax
 288:	6a 01                	push   $0x1
 28a:	50                   	push   %eax
 28b:	56                   	push   %esi
 28c:	e8 5a 03 00 00       	call   5eb <read>
 291:	83 c4 10             	add    $0x10,%esp
 294:	85 c0                	test   %eax,%eax
 296:	75 70                	jne    308 <factor+0xb8>
    for(int i=n;i>=1;i--)
 298:	85 db                	test   %ebx,%ebx
 29a:	0f 8e 93 00 00 00    	jle    333 <factor+0xe3>
 2a0:	89 d9                	mov    %ebx,%ecx
    int j = 0;
 2a2:	31 ff                	xor    %edi,%edi
 2a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if (n%i==0)
 2a8:	89 d8                	mov    %ebx,%eax
 2aa:	99                   	cltd   
 2ab:	f7 f9                	idiv   %ecx
 2ad:	85 d2                	test   %edx,%edx
 2af:	75 0a                	jne    2bb <factor+0x6b>
            intBuf[j++] = i;
 2b1:	89 8c bd e8 f7 ff ff 	mov    %ecx,-0x818(%ebp,%edi,4)
 2b8:	83 c7 01             	add    $0x1,%edi
    for(int i=n;i>=1;i--)
 2bb:	83 e9 01             	sub    $0x1,%ecx
 2be:	75 e8                	jne    2a8 <factor+0x58>
    int counter = convertToChar(intBuf, j, rev_buf);
 2c0:	83 ec 04             	sub    $0x4,%esp
 2c3:	8d 95 e8 f5 ff ff    	lea    -0xa18(%ebp),%edx
 2c9:	8d 85 e8 f7 ff ff    	lea    -0x818(%ebp),%eax
 2cf:	52                   	push   %edx
 2d0:	57                   	push   %edi
 2d1:	50                   	push   %eax
 2d2:	e8 e9 fd ff ff       	call   c0 <convertToChar>
    if(write(fd, rev_buf, counter) != counter) {
 2d7:	83 c4 0c             	add    $0xc,%esp
 2da:	8d 95 e8 f5 ff ff    	lea    -0xa18(%ebp),%edx
 2e0:	50                   	push   %eax
    int counter = convertToChar(intBuf, j, rev_buf);
 2e1:	89 c3                	mov    %eax,%ebx
    if(write(fd, rev_buf, counter) != counter) {
 2e3:	52                   	push   %edx
 2e4:	56                   	push   %esi
 2e5:	e8 09 03 00 00       	call   5f3 <write>
 2ea:	83 c4 10             	add    $0x10,%esp
 2ed:	39 d8                	cmp    %ebx,%eax
 2ef:	75 66                	jne    357 <factor+0x107>
    close(fd);
 2f1:	83 ec 0c             	sub    $0xc,%esp
 2f4:	56                   	push   %esi
 2f5:	e8 01 03 00 00       	call   5fb <close>
}
 2fa:	83 c4 10             	add    $0x10,%esp
 2fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
 300:	5b                   	pop    %ebx
 301:	5e                   	pop    %esi
 302:	5f                   	pop    %edi
 303:	5d                   	pop    %ebp
 304:	c3                   	ret    
 305:	8d 76 00             	lea    0x0(%esi),%esi
      unlink("factor_result.txt");
 308:	83 ec 0c             	sub    $0xc,%esp
 30b:	68 c8 0a 00 00       	push   $0xac8
 310:	e8 0e 03 00 00       	call   623 <unlink>
      fd = open("factor_result.txt", O_CREATE|O_RDWR);
 315:	5a                   	pop    %edx
 316:	59                   	pop    %ecx
 317:	68 02 02 00 00       	push   $0x202
 31c:	68 c8 0a 00 00       	push   $0xac8
 321:	e8 ed 02 00 00       	call   613 <open>
 326:	83 c4 10             	add    $0x10,%esp
 329:	89 c6                	mov    %eax,%esi
    for(int i=n;i>=1;i--)
 32b:	85 db                	test   %ebx,%ebx
 32d:	0f 8f 6d ff ff ff    	jg     2a0 <factor+0x50>
    int j = 0;
 333:	31 ff                	xor    %edi,%edi
 335:	eb 89                	jmp    2c0 <factor+0x70>
 337:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 33e:	66 90                	xchg   %ax,%ax
      printf(1, "File cannot be opened\n");
 340:	83 ec 08             	sub    $0x8,%esp
 343:	68 da 0a 00 00       	push   $0xada
 348:	6a 01                	push   $0x1
 34a:	e8 11 04 00 00       	call   760 <printf>
 34f:	83 c4 10             	add    $0x10,%esp
 352:	e9 28 ff ff ff       	jmp    27f <factor+0x2f>
      printf(1, "factor: write error\n");
 357:	50                   	push   %eax
 358:	50                   	push   %eax
 359:	68 f1 0a 00 00       	push   $0xaf1
 35e:	6a 01                	push   $0x1
 360:	e8 fb 03 00 00       	call   760 <printf>
      exit();
 365:	e8 69 02 00 00       	call   5d3 <exit>
 36a:	66 90                	xchg   %ax,%ax
 36c:	66 90                	xchg   %ax,%ax
 36e:	66 90                	xchg   %ax,%ax

00000370 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 370:	f3 0f 1e fb          	endbr32 
 374:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 375:	31 c0                	xor    %eax,%eax
{
 377:	89 e5                	mov    %esp,%ebp
 379:	53                   	push   %ebx
 37a:	8b 4d 08             	mov    0x8(%ebp),%ecx
 37d:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while((*s++ = *t++) != 0)
 380:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 384:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 387:	83 c0 01             	add    $0x1,%eax
 38a:	84 d2                	test   %dl,%dl
 38c:	75 f2                	jne    380 <strcpy+0x10>
    ;
  return os;
}
 38e:	89 c8                	mov    %ecx,%eax
 390:	5b                   	pop    %ebx
 391:	5d                   	pop    %ebp
 392:	c3                   	ret    
 393:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 39a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000003a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 3a0:	f3 0f 1e fb          	endbr32 
 3a4:	55                   	push   %ebp
 3a5:	89 e5                	mov    %esp,%ebp
 3a7:	53                   	push   %ebx
 3a8:	8b 4d 08             	mov    0x8(%ebp),%ecx
 3ab:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 3ae:	0f b6 01             	movzbl (%ecx),%eax
 3b1:	0f b6 1a             	movzbl (%edx),%ebx
 3b4:	84 c0                	test   %al,%al
 3b6:	75 19                	jne    3d1 <strcmp+0x31>
 3b8:	eb 26                	jmp    3e0 <strcmp+0x40>
 3ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3c0:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 3c4:	83 c1 01             	add    $0x1,%ecx
 3c7:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 3ca:	0f b6 1a             	movzbl (%edx),%ebx
 3cd:	84 c0                	test   %al,%al
 3cf:	74 0f                	je     3e0 <strcmp+0x40>
 3d1:	38 d8                	cmp    %bl,%al
 3d3:	74 eb                	je     3c0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 3d5:	29 d8                	sub    %ebx,%eax
}
 3d7:	5b                   	pop    %ebx
 3d8:	5d                   	pop    %ebp
 3d9:	c3                   	ret    
 3da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3e0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 3e2:	29 d8                	sub    %ebx,%eax
}
 3e4:	5b                   	pop    %ebx
 3e5:	5d                   	pop    %ebp
 3e6:	c3                   	ret    
 3e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 3ee:	66 90                	xchg   %ax,%ax

000003f0 <strlen>:

uint
strlen(const char *s)
{
 3f0:	f3 0f 1e fb          	endbr32 
 3f4:	55                   	push   %ebp
 3f5:	89 e5                	mov    %esp,%ebp
 3f7:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 3fa:	80 3a 00             	cmpb   $0x0,(%edx)
 3fd:	74 21                	je     420 <strlen+0x30>
 3ff:	31 c0                	xor    %eax,%eax
 401:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 408:	83 c0 01             	add    $0x1,%eax
 40b:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 40f:	89 c1                	mov    %eax,%ecx
 411:	75 f5                	jne    408 <strlen+0x18>
    ;
  return n;
}
 413:	89 c8                	mov    %ecx,%eax
 415:	5d                   	pop    %ebp
 416:	c3                   	ret    
 417:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 41e:	66 90                	xchg   %ax,%ax
  for(n = 0; s[n]; n++)
 420:	31 c9                	xor    %ecx,%ecx
}
 422:	5d                   	pop    %ebp
 423:	89 c8                	mov    %ecx,%eax
 425:	c3                   	ret    
 426:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 42d:	8d 76 00             	lea    0x0(%esi),%esi

00000430 <memset>:

void*
memset(void *dst, int c, uint n)
{
 430:	f3 0f 1e fb          	endbr32 
 434:	55                   	push   %ebp
 435:	89 e5                	mov    %esp,%ebp
 437:	57                   	push   %edi
 438:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 43b:	8b 4d 10             	mov    0x10(%ebp),%ecx
 43e:	8b 45 0c             	mov    0xc(%ebp),%eax
 441:	89 d7                	mov    %edx,%edi
 443:	fc                   	cld    
 444:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 446:	89 d0                	mov    %edx,%eax
 448:	5f                   	pop    %edi
 449:	5d                   	pop    %ebp
 44a:	c3                   	ret    
 44b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 44f:	90                   	nop

00000450 <strchr>:

char*
strchr(const char *s, char c)
{
 450:	f3 0f 1e fb          	endbr32 
 454:	55                   	push   %ebp
 455:	89 e5                	mov    %esp,%ebp
 457:	8b 45 08             	mov    0x8(%ebp),%eax
 45a:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 45e:	0f b6 10             	movzbl (%eax),%edx
 461:	84 d2                	test   %dl,%dl
 463:	75 16                	jne    47b <strchr+0x2b>
 465:	eb 21                	jmp    488 <strchr+0x38>
 467:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 46e:	66 90                	xchg   %ax,%ax
 470:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 474:	83 c0 01             	add    $0x1,%eax
 477:	84 d2                	test   %dl,%dl
 479:	74 0d                	je     488 <strchr+0x38>
    if(*s == c)
 47b:	38 d1                	cmp    %dl,%cl
 47d:	75 f1                	jne    470 <strchr+0x20>
      return (char*)s;
  return 0;
}
 47f:	5d                   	pop    %ebp
 480:	c3                   	ret    
 481:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 488:	31 c0                	xor    %eax,%eax
}
 48a:	5d                   	pop    %ebp
 48b:	c3                   	ret    
 48c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000490 <gets>:

char*
gets(char *buf, int max)
{
 490:	f3 0f 1e fb          	endbr32 
 494:	55                   	push   %ebp
 495:	89 e5                	mov    %esp,%ebp
 497:	57                   	push   %edi
 498:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 499:	31 f6                	xor    %esi,%esi
{
 49b:	53                   	push   %ebx
 49c:	89 f3                	mov    %esi,%ebx
 49e:	83 ec 1c             	sub    $0x1c,%esp
 4a1:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 4a4:	eb 33                	jmp    4d9 <gets+0x49>
 4a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4ad:	8d 76 00             	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 4b0:	83 ec 04             	sub    $0x4,%esp
 4b3:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4b6:	6a 01                	push   $0x1
 4b8:	50                   	push   %eax
 4b9:	6a 00                	push   $0x0
 4bb:	e8 2b 01 00 00       	call   5eb <read>
    if(cc < 1)
 4c0:	83 c4 10             	add    $0x10,%esp
 4c3:	85 c0                	test   %eax,%eax
 4c5:	7e 1c                	jle    4e3 <gets+0x53>
      break;
    buf[i++] = c;
 4c7:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 4cb:	83 c7 01             	add    $0x1,%edi
 4ce:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 4d1:	3c 0a                	cmp    $0xa,%al
 4d3:	74 23                	je     4f8 <gets+0x68>
 4d5:	3c 0d                	cmp    $0xd,%al
 4d7:	74 1f                	je     4f8 <gets+0x68>
  for(i=0; i+1 < max; ){
 4d9:	83 c3 01             	add    $0x1,%ebx
 4dc:	89 fe                	mov    %edi,%esi
 4de:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 4e1:	7c cd                	jl     4b0 <gets+0x20>
 4e3:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 4e5:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 4e8:	c6 03 00             	movb   $0x0,(%ebx)
}
 4eb:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4ee:	5b                   	pop    %ebx
 4ef:	5e                   	pop    %esi
 4f0:	5f                   	pop    %edi
 4f1:	5d                   	pop    %ebp
 4f2:	c3                   	ret    
 4f3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4f7:	90                   	nop
 4f8:	8b 75 08             	mov    0x8(%ebp),%esi
 4fb:	8b 45 08             	mov    0x8(%ebp),%eax
 4fe:	01 de                	add    %ebx,%esi
 500:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 502:	c6 03 00             	movb   $0x0,(%ebx)
}
 505:	8d 65 f4             	lea    -0xc(%ebp),%esp
 508:	5b                   	pop    %ebx
 509:	5e                   	pop    %esi
 50a:	5f                   	pop    %edi
 50b:	5d                   	pop    %ebp
 50c:	c3                   	ret    
 50d:	8d 76 00             	lea    0x0(%esi),%esi

00000510 <stat>:

int
stat(const char *n, struct stat *st)
{
 510:	f3 0f 1e fb          	endbr32 
 514:	55                   	push   %ebp
 515:	89 e5                	mov    %esp,%ebp
 517:	56                   	push   %esi
 518:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 519:	83 ec 08             	sub    $0x8,%esp
 51c:	6a 00                	push   $0x0
 51e:	ff 75 08             	pushl  0x8(%ebp)
 521:	e8 ed 00 00 00       	call   613 <open>
  if(fd < 0)
 526:	83 c4 10             	add    $0x10,%esp
 529:	85 c0                	test   %eax,%eax
 52b:	78 2b                	js     558 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 52d:	83 ec 08             	sub    $0x8,%esp
 530:	ff 75 0c             	pushl  0xc(%ebp)
 533:	89 c3                	mov    %eax,%ebx
 535:	50                   	push   %eax
 536:	e8 f0 00 00 00       	call   62b <fstat>
  close(fd);
 53b:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 53e:	89 c6                	mov    %eax,%esi
  close(fd);
 540:	e8 b6 00 00 00       	call   5fb <close>
  return r;
 545:	83 c4 10             	add    $0x10,%esp
}
 548:	8d 65 f8             	lea    -0x8(%ebp),%esp
 54b:	89 f0                	mov    %esi,%eax
 54d:	5b                   	pop    %ebx
 54e:	5e                   	pop    %esi
 54f:	5d                   	pop    %ebp
 550:	c3                   	ret    
 551:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 558:	be ff ff ff ff       	mov    $0xffffffff,%esi
 55d:	eb e9                	jmp    548 <stat+0x38>
 55f:	90                   	nop

00000560 <atoi>:

int
atoi(const char *s)
{
 560:	f3 0f 1e fb          	endbr32 
 564:	55                   	push   %ebp
 565:	89 e5                	mov    %esp,%ebp
 567:	53                   	push   %ebx
 568:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 56b:	0f be 02             	movsbl (%edx),%eax
 56e:	8d 48 d0             	lea    -0x30(%eax),%ecx
 571:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 574:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 579:	77 1a                	ja     595 <atoi+0x35>
 57b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 57f:	90                   	nop
    n = n*10 + *s++ - '0';
 580:	83 c2 01             	add    $0x1,%edx
 583:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 586:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 58a:	0f be 02             	movsbl (%edx),%eax
 58d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 590:	80 fb 09             	cmp    $0x9,%bl
 593:	76 eb                	jbe    580 <atoi+0x20>
  return n;
}
 595:	89 c8                	mov    %ecx,%eax
 597:	5b                   	pop    %ebx
 598:	5d                   	pop    %ebp
 599:	c3                   	ret    
 59a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000005a0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 5a0:	f3 0f 1e fb          	endbr32 
 5a4:	55                   	push   %ebp
 5a5:	89 e5                	mov    %esp,%ebp
 5a7:	57                   	push   %edi
 5a8:	8b 45 10             	mov    0x10(%ebp),%eax
 5ab:	8b 55 08             	mov    0x8(%ebp),%edx
 5ae:	56                   	push   %esi
 5af:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 5b2:	85 c0                	test   %eax,%eax
 5b4:	7e 0f                	jle    5c5 <memmove+0x25>
 5b6:	01 d0                	add    %edx,%eax
  dst = vdst;
 5b8:	89 d7                	mov    %edx,%edi
 5ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    *dst++ = *src++;
 5c0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 5c1:	39 f8                	cmp    %edi,%eax
 5c3:	75 fb                	jne    5c0 <memmove+0x20>
  return vdst;
}
 5c5:	5e                   	pop    %esi
 5c6:	89 d0                	mov    %edx,%eax
 5c8:	5f                   	pop    %edi
 5c9:	5d                   	pop    %ebp
 5ca:	c3                   	ret    

000005cb <fork>:
 5cb:	b8 01 00 00 00       	mov    $0x1,%eax
 5d0:	cd 40                	int    $0x40
 5d2:	c3                   	ret    

000005d3 <exit>:
 5d3:	b8 02 00 00 00       	mov    $0x2,%eax
 5d8:	cd 40                	int    $0x40
 5da:	c3                   	ret    

000005db <wait>:
 5db:	b8 03 00 00 00       	mov    $0x3,%eax
 5e0:	cd 40                	int    $0x40
 5e2:	c3                   	ret    

000005e3 <pipe>:
 5e3:	b8 04 00 00 00       	mov    $0x4,%eax
 5e8:	cd 40                	int    $0x40
 5ea:	c3                   	ret    

000005eb <read>:
 5eb:	b8 05 00 00 00       	mov    $0x5,%eax
 5f0:	cd 40                	int    $0x40
 5f2:	c3                   	ret    

000005f3 <write>:
 5f3:	b8 10 00 00 00       	mov    $0x10,%eax
 5f8:	cd 40                	int    $0x40
 5fa:	c3                   	ret    

000005fb <close>:
 5fb:	b8 15 00 00 00       	mov    $0x15,%eax
 600:	cd 40                	int    $0x40
 602:	c3                   	ret    

00000603 <kill>:
 603:	b8 06 00 00 00       	mov    $0x6,%eax
 608:	cd 40                	int    $0x40
 60a:	c3                   	ret    

0000060b <exec>:
 60b:	b8 07 00 00 00       	mov    $0x7,%eax
 610:	cd 40                	int    $0x40
 612:	c3                   	ret    

00000613 <open>:
 613:	b8 0f 00 00 00       	mov    $0xf,%eax
 618:	cd 40                	int    $0x40
 61a:	c3                   	ret    

0000061b <mknod>:
 61b:	b8 11 00 00 00       	mov    $0x11,%eax
 620:	cd 40                	int    $0x40
 622:	c3                   	ret    

00000623 <unlink>:
 623:	b8 12 00 00 00       	mov    $0x12,%eax
 628:	cd 40                	int    $0x40
 62a:	c3                   	ret    

0000062b <fstat>:
 62b:	b8 08 00 00 00       	mov    $0x8,%eax
 630:	cd 40                	int    $0x40
 632:	c3                   	ret    

00000633 <link>:
 633:	b8 13 00 00 00       	mov    $0x13,%eax
 638:	cd 40                	int    $0x40
 63a:	c3                   	ret    

0000063b <mkdir>:
 63b:	b8 14 00 00 00       	mov    $0x14,%eax
 640:	cd 40                	int    $0x40
 642:	c3                   	ret    

00000643 <chdir>:
 643:	b8 09 00 00 00       	mov    $0x9,%eax
 648:	cd 40                	int    $0x40
 64a:	c3                   	ret    

0000064b <dup>:
 64b:	b8 0a 00 00 00       	mov    $0xa,%eax
 650:	cd 40                	int    $0x40
 652:	c3                   	ret    

00000653 <getpid>:
 653:	b8 0b 00 00 00       	mov    $0xb,%eax
 658:	cd 40                	int    $0x40
 65a:	c3                   	ret    

0000065b <sbrk>:
 65b:	b8 0c 00 00 00       	mov    $0xc,%eax
 660:	cd 40                	int    $0x40
 662:	c3                   	ret    

00000663 <sleep>:
 663:	b8 0d 00 00 00       	mov    $0xd,%eax
 668:	cd 40                	int    $0x40
 66a:	c3                   	ret    

0000066b <uptime>:
 66b:	b8 0e 00 00 00       	mov    $0xe,%eax
 670:	cd 40                	int    $0x40
 672:	c3                   	ret    

00000673 <changeQueue>:
 673:	b8 16 00 00 00       	mov    $0x16,%eax
 678:	cd 40                	int    $0x40
 67a:	c3                   	ret    

0000067b <printProcess>:
 67b:	b8 17 00 00 00       	mov    $0x17,%eax
 680:	cd 40                	int    $0x40
 682:	c3                   	ret    

00000683 <changeProcessMHRRN>:
 683:	b8 18 00 00 00       	mov    $0x18,%eax
 688:	cd 40                	int    $0x40
 68a:	c3                   	ret    

0000068b <changeSystemMHRRN>:
 68b:	b8 19 00 00 00       	mov    $0x19,%eax
 690:	cd 40                	int    $0x40
 692:	c3                   	ret    

00000693 <sem_acquire>:
 693:	b8 1a 00 00 00       	mov    $0x1a,%eax
 698:	cd 40                	int    $0x40
 69a:	c3                   	ret    

0000069b <sem_release>:
 69b:	b8 1b 00 00 00       	mov    $0x1b,%eax
 6a0:	cd 40                	int    $0x40
 6a2:	c3                   	ret    

000006a3 <sem_init>:
 6a3:	b8 1c 00 00 00       	mov    $0x1c,%eax
 6a8:	cd 40                	int    $0x40
 6aa:	c3                   	ret    
 6ab:	66 90                	xchg   %ax,%ax
 6ad:	66 90                	xchg   %ax,%ax
 6af:	90                   	nop

000006b0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 6b0:	55                   	push   %ebp
 6b1:	89 e5                	mov    %esp,%ebp
 6b3:	57                   	push   %edi
 6b4:	56                   	push   %esi
 6b5:	53                   	push   %ebx
 6b6:	83 ec 3c             	sub    $0x3c,%esp
 6b9:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 6bc:	89 d1                	mov    %edx,%ecx
{
 6be:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 6c1:	85 d2                	test   %edx,%edx
 6c3:	0f 89 7f 00 00 00    	jns    748 <printint+0x98>
 6c9:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 6cd:	74 79                	je     748 <printint+0x98>
    neg = 1;
 6cf:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 6d6:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 6d8:	31 db                	xor    %ebx,%ebx
 6da:	8d 75 d7             	lea    -0x29(%ebp),%esi
 6dd:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 6e0:	89 c8                	mov    %ecx,%eax
 6e2:	31 d2                	xor    %edx,%edx
 6e4:	89 cf                	mov    %ecx,%edi
 6e6:	f7 75 c4             	divl   -0x3c(%ebp)
 6e9:	0f b6 92 10 0b 00 00 	movzbl 0xb10(%edx),%edx
 6f0:	89 45 c0             	mov    %eax,-0x40(%ebp)
 6f3:	89 d8                	mov    %ebx,%eax
 6f5:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 6f8:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 6fb:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 6fe:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 701:	76 dd                	jbe    6e0 <printint+0x30>
  if(neg)
 703:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 706:	85 c9                	test   %ecx,%ecx
 708:	74 0c                	je     716 <printint+0x66>
    buf[i++] = '-';
 70a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 70f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 711:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 716:	8b 7d b8             	mov    -0x48(%ebp),%edi
 719:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 71d:	eb 07                	jmp    726 <printint+0x76>
 71f:	90                   	nop
 720:	0f b6 13             	movzbl (%ebx),%edx
 723:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 726:	83 ec 04             	sub    $0x4,%esp
 729:	88 55 d7             	mov    %dl,-0x29(%ebp)
 72c:	6a 01                	push   $0x1
 72e:	56                   	push   %esi
 72f:	57                   	push   %edi
 730:	e8 be fe ff ff       	call   5f3 <write>
  while(--i >= 0)
 735:	83 c4 10             	add    $0x10,%esp
 738:	39 de                	cmp    %ebx,%esi
 73a:	75 e4                	jne    720 <printint+0x70>
    putc(fd, buf[i]);
}
 73c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 73f:	5b                   	pop    %ebx
 740:	5e                   	pop    %esi
 741:	5f                   	pop    %edi
 742:	5d                   	pop    %ebp
 743:	c3                   	ret    
 744:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 748:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 74f:	eb 87                	jmp    6d8 <printint+0x28>
 751:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 758:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 75f:	90                   	nop

00000760 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 760:	f3 0f 1e fb          	endbr32 
 764:	55                   	push   %ebp
 765:	89 e5                	mov    %esp,%ebp
 767:	57                   	push   %edi
 768:	56                   	push   %esi
 769:	53                   	push   %ebx
 76a:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 76d:	8b 75 0c             	mov    0xc(%ebp),%esi
 770:	0f b6 1e             	movzbl (%esi),%ebx
 773:	84 db                	test   %bl,%bl
 775:	0f 84 b4 00 00 00    	je     82f <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
 77b:	8d 45 10             	lea    0x10(%ebp),%eax
 77e:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 781:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 784:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 786:	89 45 d0             	mov    %eax,-0x30(%ebp)
 789:	eb 33                	jmp    7be <printf+0x5e>
 78b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 78f:	90                   	nop
 790:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 793:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 798:	83 f8 25             	cmp    $0x25,%eax
 79b:	74 17                	je     7b4 <printf+0x54>
  write(fd, &c, 1);
 79d:	83 ec 04             	sub    $0x4,%esp
 7a0:	88 5d e7             	mov    %bl,-0x19(%ebp)
 7a3:	6a 01                	push   $0x1
 7a5:	57                   	push   %edi
 7a6:	ff 75 08             	pushl  0x8(%ebp)
 7a9:	e8 45 fe ff ff       	call   5f3 <write>
 7ae:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 7b1:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 7b4:	0f b6 1e             	movzbl (%esi),%ebx
 7b7:	83 c6 01             	add    $0x1,%esi
 7ba:	84 db                	test   %bl,%bl
 7bc:	74 71                	je     82f <printf+0xcf>
    c = fmt[i] & 0xff;
 7be:	0f be cb             	movsbl %bl,%ecx
 7c1:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 7c4:	85 d2                	test   %edx,%edx
 7c6:	74 c8                	je     790 <printf+0x30>
      }
    } else if(state == '%'){
 7c8:	83 fa 25             	cmp    $0x25,%edx
 7cb:	75 e7                	jne    7b4 <printf+0x54>
      if(c == 'd'){
 7cd:	83 f8 64             	cmp    $0x64,%eax
 7d0:	0f 84 9a 00 00 00    	je     870 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 7d6:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 7dc:	83 f9 70             	cmp    $0x70,%ecx
 7df:	74 5f                	je     840 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 7e1:	83 f8 73             	cmp    $0x73,%eax
 7e4:	0f 84 d6 00 00 00    	je     8c0 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 7ea:	83 f8 63             	cmp    $0x63,%eax
 7ed:	0f 84 8d 00 00 00    	je     880 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 7f3:	83 f8 25             	cmp    $0x25,%eax
 7f6:	0f 84 b4 00 00 00    	je     8b0 <printf+0x150>
  write(fd, &c, 1);
 7fc:	83 ec 04             	sub    $0x4,%esp
 7ff:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 803:	6a 01                	push   $0x1
 805:	57                   	push   %edi
 806:	ff 75 08             	pushl  0x8(%ebp)
 809:	e8 e5 fd ff ff       	call   5f3 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 80e:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 811:	83 c4 0c             	add    $0xc,%esp
 814:	6a 01                	push   $0x1
 816:	83 c6 01             	add    $0x1,%esi
 819:	57                   	push   %edi
 81a:	ff 75 08             	pushl  0x8(%ebp)
 81d:	e8 d1 fd ff ff       	call   5f3 <write>
  for(i = 0; fmt[i]; i++){
 822:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 826:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 829:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 82b:	84 db                	test   %bl,%bl
 82d:	75 8f                	jne    7be <printf+0x5e>
    }
  }
}
 82f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 832:	5b                   	pop    %ebx
 833:	5e                   	pop    %esi
 834:	5f                   	pop    %edi
 835:	5d                   	pop    %ebp
 836:	c3                   	ret    
 837:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 83e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 840:	83 ec 0c             	sub    $0xc,%esp
 843:	b9 10 00 00 00       	mov    $0x10,%ecx
 848:	6a 00                	push   $0x0
 84a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 84d:	8b 45 08             	mov    0x8(%ebp),%eax
 850:	8b 13                	mov    (%ebx),%edx
 852:	e8 59 fe ff ff       	call   6b0 <printint>
        ap++;
 857:	89 d8                	mov    %ebx,%eax
 859:	83 c4 10             	add    $0x10,%esp
      state = 0;
 85c:	31 d2                	xor    %edx,%edx
        ap++;
 85e:	83 c0 04             	add    $0x4,%eax
 861:	89 45 d0             	mov    %eax,-0x30(%ebp)
 864:	e9 4b ff ff ff       	jmp    7b4 <printf+0x54>
 869:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 870:	83 ec 0c             	sub    $0xc,%esp
 873:	b9 0a 00 00 00       	mov    $0xa,%ecx
 878:	6a 01                	push   $0x1
 87a:	eb ce                	jmp    84a <printf+0xea>
 87c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 880:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 883:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 886:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 888:	6a 01                	push   $0x1
        ap++;
 88a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 88d:	57                   	push   %edi
 88e:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
 891:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 894:	e8 5a fd ff ff       	call   5f3 <write>
        ap++;
 899:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 89c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 89f:	31 d2                	xor    %edx,%edx
 8a1:	e9 0e ff ff ff       	jmp    7b4 <printf+0x54>
 8a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8ad:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 8b0:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 8b3:	83 ec 04             	sub    $0x4,%esp
 8b6:	e9 59 ff ff ff       	jmp    814 <printf+0xb4>
 8bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 8bf:	90                   	nop
        s = (char*)*ap;
 8c0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 8c3:	8b 18                	mov    (%eax),%ebx
        ap++;
 8c5:	83 c0 04             	add    $0x4,%eax
 8c8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 8cb:	85 db                	test   %ebx,%ebx
 8cd:	74 17                	je     8e6 <printf+0x186>
        while(*s != 0){
 8cf:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 8d2:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 8d4:	84 c0                	test   %al,%al
 8d6:	0f 84 d8 fe ff ff    	je     7b4 <printf+0x54>
 8dc:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 8df:	89 de                	mov    %ebx,%esi
 8e1:	8b 5d 08             	mov    0x8(%ebp),%ebx
 8e4:	eb 1a                	jmp    900 <printf+0x1a0>
          s = "(null)";
 8e6:	bb 06 0b 00 00       	mov    $0xb06,%ebx
        while(*s != 0){
 8eb:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 8ee:	b8 28 00 00 00       	mov    $0x28,%eax
 8f3:	89 de                	mov    %ebx,%esi
 8f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
 8f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8ff:	90                   	nop
  write(fd, &c, 1);
 900:	83 ec 04             	sub    $0x4,%esp
          s++;
 903:	83 c6 01             	add    $0x1,%esi
 906:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 909:	6a 01                	push   $0x1
 90b:	57                   	push   %edi
 90c:	53                   	push   %ebx
 90d:	e8 e1 fc ff ff       	call   5f3 <write>
        while(*s != 0){
 912:	0f b6 06             	movzbl (%esi),%eax
 915:	83 c4 10             	add    $0x10,%esp
 918:	84 c0                	test   %al,%al
 91a:	75 e4                	jne    900 <printf+0x1a0>
 91c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 91f:	31 d2                	xor    %edx,%edx
 921:	e9 8e fe ff ff       	jmp    7b4 <printf+0x54>
 926:	66 90                	xchg   %ax,%ax
 928:	66 90                	xchg   %ax,%ax
 92a:	66 90                	xchg   %ax,%ax
 92c:	66 90                	xchg   %ax,%ax
 92e:	66 90                	xchg   %ax,%ax

00000930 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 930:	f3 0f 1e fb          	endbr32 
 934:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 935:	a1 24 0e 00 00       	mov    0xe24,%eax
{
 93a:	89 e5                	mov    %esp,%ebp
 93c:	57                   	push   %edi
 93d:	56                   	push   %esi
 93e:	53                   	push   %ebx
 93f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 942:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 944:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 947:	39 c8                	cmp    %ecx,%eax
 949:	73 15                	jae    960 <free+0x30>
 94b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 94f:	90                   	nop
 950:	39 d1                	cmp    %edx,%ecx
 952:	72 14                	jb     968 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 954:	39 d0                	cmp    %edx,%eax
 956:	73 10                	jae    968 <free+0x38>
{
 958:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 95a:	8b 10                	mov    (%eax),%edx
 95c:	39 c8                	cmp    %ecx,%eax
 95e:	72 f0                	jb     950 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 960:	39 d0                	cmp    %edx,%eax
 962:	72 f4                	jb     958 <free+0x28>
 964:	39 d1                	cmp    %edx,%ecx
 966:	73 f0                	jae    958 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 968:	8b 73 fc             	mov    -0x4(%ebx),%esi
 96b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 96e:	39 fa                	cmp    %edi,%edx
 970:	74 1e                	je     990 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 972:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 975:	8b 50 04             	mov    0x4(%eax),%edx
 978:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 97b:	39 f1                	cmp    %esi,%ecx
 97d:	74 28                	je     9a7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 97f:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 981:	5b                   	pop    %ebx
  freep = p;
 982:	a3 24 0e 00 00       	mov    %eax,0xe24
}
 987:	5e                   	pop    %esi
 988:	5f                   	pop    %edi
 989:	5d                   	pop    %ebp
 98a:	c3                   	ret    
 98b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 98f:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 990:	03 72 04             	add    0x4(%edx),%esi
 993:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 996:	8b 10                	mov    (%eax),%edx
 998:	8b 12                	mov    (%edx),%edx
 99a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 99d:	8b 50 04             	mov    0x4(%eax),%edx
 9a0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 9a3:	39 f1                	cmp    %esi,%ecx
 9a5:	75 d8                	jne    97f <free+0x4f>
    p->s.size += bp->s.size;
 9a7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 9aa:	a3 24 0e 00 00       	mov    %eax,0xe24
    p->s.size += bp->s.size;
 9af:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 9b2:	8b 53 f8             	mov    -0x8(%ebx),%edx
 9b5:	89 10                	mov    %edx,(%eax)
}
 9b7:	5b                   	pop    %ebx
 9b8:	5e                   	pop    %esi
 9b9:	5f                   	pop    %edi
 9ba:	5d                   	pop    %ebp
 9bb:	c3                   	ret    
 9bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000009c0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 9c0:	f3 0f 1e fb          	endbr32 
 9c4:	55                   	push   %ebp
 9c5:	89 e5                	mov    %esp,%ebp
 9c7:	57                   	push   %edi
 9c8:	56                   	push   %esi
 9c9:	53                   	push   %ebx
 9ca:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9cd:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 9d0:	8b 3d 24 0e 00 00    	mov    0xe24,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9d6:	8d 70 07             	lea    0x7(%eax),%esi
 9d9:	c1 ee 03             	shr    $0x3,%esi
 9dc:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 9df:	85 ff                	test   %edi,%edi
 9e1:	0f 84 a9 00 00 00    	je     a90 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9e7:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
 9e9:	8b 48 04             	mov    0x4(%eax),%ecx
 9ec:	39 f1                	cmp    %esi,%ecx
 9ee:	73 6d                	jae    a5d <malloc+0x9d>
 9f0:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 9f6:	bb 00 10 00 00       	mov    $0x1000,%ebx
 9fb:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 9fe:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 a05:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 a08:	eb 17                	jmp    a21 <malloc+0x61>
 a0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a10:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 a12:	8b 4a 04             	mov    0x4(%edx),%ecx
 a15:	39 f1                	cmp    %esi,%ecx
 a17:	73 4f                	jae    a68 <malloc+0xa8>
 a19:	8b 3d 24 0e 00 00    	mov    0xe24,%edi
 a1f:	89 d0                	mov    %edx,%eax
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a21:	39 c7                	cmp    %eax,%edi
 a23:	75 eb                	jne    a10 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 a25:	83 ec 0c             	sub    $0xc,%esp
 a28:	ff 75 e4             	pushl  -0x1c(%ebp)
 a2b:	e8 2b fc ff ff       	call   65b <sbrk>
  if(p == (char*)-1)
 a30:	83 c4 10             	add    $0x10,%esp
 a33:	83 f8 ff             	cmp    $0xffffffff,%eax
 a36:	74 1b                	je     a53 <malloc+0x93>
  hp->s.size = nu;
 a38:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 a3b:	83 ec 0c             	sub    $0xc,%esp
 a3e:	83 c0 08             	add    $0x8,%eax
 a41:	50                   	push   %eax
 a42:	e8 e9 fe ff ff       	call   930 <free>
  return freep;
 a47:	a1 24 0e 00 00       	mov    0xe24,%eax
      if((p = morecore(nunits)) == 0)
 a4c:	83 c4 10             	add    $0x10,%esp
 a4f:	85 c0                	test   %eax,%eax
 a51:	75 bd                	jne    a10 <malloc+0x50>
        return 0;
  }
}
 a53:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 a56:	31 c0                	xor    %eax,%eax
}
 a58:	5b                   	pop    %ebx
 a59:	5e                   	pop    %esi
 a5a:	5f                   	pop    %edi
 a5b:	5d                   	pop    %ebp
 a5c:	c3                   	ret    
    if(p->s.size >= nunits){
 a5d:	89 c2                	mov    %eax,%edx
 a5f:	89 f8                	mov    %edi,%eax
 a61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 a68:	39 ce                	cmp    %ecx,%esi
 a6a:	74 54                	je     ac0 <malloc+0x100>
        p->s.size -= nunits;
 a6c:	29 f1                	sub    %esi,%ecx
 a6e:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 a71:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 a74:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
 a77:	a3 24 0e 00 00       	mov    %eax,0xe24
}
 a7c:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 a7f:	8d 42 08             	lea    0x8(%edx),%eax
}
 a82:	5b                   	pop    %ebx
 a83:	5e                   	pop    %esi
 a84:	5f                   	pop    %edi
 a85:	5d                   	pop    %ebp
 a86:	c3                   	ret    
 a87:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 a8e:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
 a90:	c7 05 24 0e 00 00 28 	movl   $0xe28,0xe24
 a97:	0e 00 00 
    base.s.size = 0;
 a9a:	bf 28 0e 00 00       	mov    $0xe28,%edi
    base.s.ptr = freep = prevp = &base;
 a9f:	c7 05 28 0e 00 00 28 	movl   $0xe28,0xe28
 aa6:	0e 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 aa9:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
 aab:	c7 05 2c 0e 00 00 00 	movl   $0x0,0xe2c
 ab2:	00 00 00 
    if(p->s.size >= nunits){
 ab5:	e9 36 ff ff ff       	jmp    9f0 <malloc+0x30>
 aba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 ac0:	8b 0a                	mov    (%edx),%ecx
 ac2:	89 08                	mov    %ecx,(%eax)
 ac4:	eb b1                	jmp    a77 <malloc+0xb7>
