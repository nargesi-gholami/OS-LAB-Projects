
_dining_philosopher:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "fs.h"
#include "fcntl.h"


int main(int argc, char *argv[])
{
   0:	f3 0f 1e fb          	endbr32 
   4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   8:	83 e4 f0             	and    $0xfffffff0,%esp
   b:	ff 71 fc             	pushl  -0x4(%ecx)
   e:	55                   	push   %ebp
   f:	89 e5                	mov    %esp,%ebp
  11:	57                   	push   %edi
  12:	56                   	push   %esi
    int phil_id = atoi(argv[1]);
    for(int j = 0 ; j < 10 ; j++)
    {
        sem_acquire(0);
        sem_acquire(phil_id);
        sem_acquire(phil_id % 5 - 1);
  13:	be 0a 00 00 00       	mov    $0xa,%esi
{
  18:	53                   	push   %ebx
  19:	51                   	push   %ecx
  1a:	83 ec 10             	sub    $0x10,%esp
  1d:	8b 59 04             	mov    0x4(%ecx),%ebx
    printf(1,"hiiiiiiiiiiii\n");
  20:	68 18 08 00 00       	push   $0x818
  25:	6a 01                	push   $0x1
  27:	e8 84 04 00 00       	call   4b0 <printf>
    int phil_id = atoi(argv[1]);
  2c:	58                   	pop    %eax
  2d:	ff 73 04             	pushl  0x4(%ebx)
  30:	e8 7b 02 00 00       	call   2b0 <atoi>
        sem_acquire(phil_id % 5 - 1);
  35:	ba 67 66 66 66       	mov    $0x66666667,%edx
  3a:	83 c4 10             	add    $0x10,%esp
    int phil_id = atoi(argv[1]);
  3d:	89 c3                	mov    %eax,%ebx
        sem_acquire(phil_id % 5 - 1);
  3f:	f7 ea                	imul   %edx
  41:	89 d8                	mov    %ebx,%eax
  43:	89 df                	mov    %ebx,%edi
  45:	c1 f8 1f             	sar    $0x1f,%eax
  48:	d1 fa                	sar    %edx
  4a:	29 c2                	sub    %eax,%edx
  4c:	8d 04 92             	lea    (%edx,%edx,4),%eax
  4f:	29 c7                	sub    %eax,%edi
  51:	83 ef 01             	sub    $0x1,%edi
  54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        sem_acquire(0);
  58:	83 ec 0c             	sub    $0xc,%esp
  5b:	6a 00                	push   $0x0
  5d:	e8 81 03 00 00       	call   3e3 <sem_acquire>
        sem_acquire(phil_id);
  62:	89 1c 24             	mov    %ebx,(%esp)
  65:	e8 79 03 00 00       	call   3e3 <sem_acquire>
        sem_acquire(phil_id % 5 - 1);
  6a:	89 3c 24             	mov    %edi,(%esp)
  6d:	e8 71 03 00 00       	call   3e3 <sem_acquire>

        int cal = 1;

        printf(1, "Philosopher %d is eating\n", phil_id);
  72:	83 c4 0c             	add    $0xc,%esp
  75:	53                   	push   %ebx
  76:	68 27 08 00 00       	push   $0x827
  7b:	6a 01                	push   $0x1
  7d:	e8 2e 04 00 00       	call   4b0 <printf>

        for(int i = 0 ; i < 20000 ; i++)
            cal *= 10*cal*phil_id;
        
        sem_release(phil_id);
  82:	89 1c 24             	mov    %ebx,(%esp)
  85:	e8 61 03 00 00       	call   3eb <sem_release>
        sem_release(phil_id % 5 - 1);
  8a:	89 3c 24             	mov    %edi,(%esp)
  8d:	e8 59 03 00 00       	call   3eb <sem_release>
        sem_release(0);
  92:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  99:	e8 4d 03 00 00       	call   3eb <sem_release>

        printf(1, "Philosopher %d is thinking\n", phil_id);
  9e:	83 c4 0c             	add    $0xc,%esp
  a1:	53                   	push   %ebx
  a2:	68 41 08 00 00       	push   $0x841
  a7:	6a 01                	push   $0x1
  a9:	e8 02 04 00 00       	call   4b0 <printf>
    for(int j = 0 ; j < 10 ; j++)
  ae:	83 c4 10             	add    $0x10,%esp
  b1:	83 ee 01             	sub    $0x1,%esi
  b4:	75 a2                	jne    58 <main+0x58>
        for(int i = 0 ; i < 20000 ; i++)
            cal *= 10*phil_id;
    }

    exit();
  b6:	e8 68 02 00 00       	call   323 <exit>
  bb:	66 90                	xchg   %ax,%ax
  bd:	66 90                	xchg   %ax,%ax
  bf:	90                   	nop

000000c0 <strcpy>:
  c0:	f3 0f 1e fb          	endbr32 
  c4:	55                   	push   %ebp
  c5:	31 c0                	xor    %eax,%eax
  c7:	89 e5                	mov    %esp,%ebp
  c9:	53                   	push   %ebx
  ca:	8b 4d 08             	mov    0x8(%ebp),%ecx
  cd:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  d0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  d4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  d7:	83 c0 01             	add    $0x1,%eax
  da:	84 d2                	test   %dl,%dl
  dc:	75 f2                	jne    d0 <strcpy+0x10>
  de:	89 c8                	mov    %ecx,%eax
  e0:	5b                   	pop    %ebx
  e1:	5d                   	pop    %ebp
  e2:	c3                   	ret    
  e3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000000f0 <strcmp>:
  f0:	f3 0f 1e fb          	endbr32 
  f4:	55                   	push   %ebp
  f5:	89 e5                	mov    %esp,%ebp
  f7:	53                   	push   %ebx
  f8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  fb:	8b 55 0c             	mov    0xc(%ebp),%edx
  fe:	0f b6 01             	movzbl (%ecx),%eax
 101:	0f b6 1a             	movzbl (%edx),%ebx
 104:	84 c0                	test   %al,%al
 106:	75 19                	jne    121 <strcmp+0x31>
 108:	eb 26                	jmp    130 <strcmp+0x40>
 10a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 110:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
 114:	83 c1 01             	add    $0x1,%ecx
 117:	83 c2 01             	add    $0x1,%edx
 11a:	0f b6 1a             	movzbl (%edx),%ebx
 11d:	84 c0                	test   %al,%al
 11f:	74 0f                	je     130 <strcmp+0x40>
 121:	38 d8                	cmp    %bl,%al
 123:	74 eb                	je     110 <strcmp+0x20>
 125:	29 d8                	sub    %ebx,%eax
 127:	5b                   	pop    %ebx
 128:	5d                   	pop    %ebp
 129:	c3                   	ret    
 12a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 130:	31 c0                	xor    %eax,%eax
 132:	29 d8                	sub    %ebx,%eax
 134:	5b                   	pop    %ebx
 135:	5d                   	pop    %ebp
 136:	c3                   	ret    
 137:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 13e:	66 90                	xchg   %ax,%ax

00000140 <strlen>:
 140:	f3 0f 1e fb          	endbr32 
 144:	55                   	push   %ebp
 145:	89 e5                	mov    %esp,%ebp
 147:	8b 55 08             	mov    0x8(%ebp),%edx
 14a:	80 3a 00             	cmpb   $0x0,(%edx)
 14d:	74 21                	je     170 <strlen+0x30>
 14f:	31 c0                	xor    %eax,%eax
 151:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 158:	83 c0 01             	add    $0x1,%eax
 15b:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 15f:	89 c1                	mov    %eax,%ecx
 161:	75 f5                	jne    158 <strlen+0x18>
 163:	89 c8                	mov    %ecx,%eax
 165:	5d                   	pop    %ebp
 166:	c3                   	ret    
 167:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 16e:	66 90                	xchg   %ax,%ax
 170:	31 c9                	xor    %ecx,%ecx
 172:	5d                   	pop    %ebp
 173:	89 c8                	mov    %ecx,%eax
 175:	c3                   	ret    
 176:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 17d:	8d 76 00             	lea    0x0(%esi),%esi

00000180 <memset>:
 180:	f3 0f 1e fb          	endbr32 
 184:	55                   	push   %ebp
 185:	89 e5                	mov    %esp,%ebp
 187:	57                   	push   %edi
 188:	8b 55 08             	mov    0x8(%ebp),%edx
 18b:	8b 4d 10             	mov    0x10(%ebp),%ecx
 18e:	8b 45 0c             	mov    0xc(%ebp),%eax
 191:	89 d7                	mov    %edx,%edi
 193:	fc                   	cld    
 194:	f3 aa                	rep stos %al,%es:(%edi)
 196:	89 d0                	mov    %edx,%eax
 198:	5f                   	pop    %edi
 199:	5d                   	pop    %ebp
 19a:	c3                   	ret    
 19b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 19f:	90                   	nop

000001a0 <strchr>:
 1a0:	f3 0f 1e fb          	endbr32 
 1a4:	55                   	push   %ebp
 1a5:	89 e5                	mov    %esp,%ebp
 1a7:	8b 45 08             	mov    0x8(%ebp),%eax
 1aa:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
 1ae:	0f b6 10             	movzbl (%eax),%edx
 1b1:	84 d2                	test   %dl,%dl
 1b3:	75 16                	jne    1cb <strchr+0x2b>
 1b5:	eb 21                	jmp    1d8 <strchr+0x38>
 1b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1be:	66 90                	xchg   %ax,%ax
 1c0:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 1c4:	83 c0 01             	add    $0x1,%eax
 1c7:	84 d2                	test   %dl,%dl
 1c9:	74 0d                	je     1d8 <strchr+0x38>
 1cb:	38 d1                	cmp    %dl,%cl
 1cd:	75 f1                	jne    1c0 <strchr+0x20>
 1cf:	5d                   	pop    %ebp
 1d0:	c3                   	ret    
 1d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1d8:	31 c0                	xor    %eax,%eax
 1da:	5d                   	pop    %ebp
 1db:	c3                   	ret    
 1dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000001e0 <gets>:
 1e0:	f3 0f 1e fb          	endbr32 
 1e4:	55                   	push   %ebp
 1e5:	89 e5                	mov    %esp,%ebp
 1e7:	57                   	push   %edi
 1e8:	56                   	push   %esi
 1e9:	31 f6                	xor    %esi,%esi
 1eb:	53                   	push   %ebx
 1ec:	89 f3                	mov    %esi,%ebx
 1ee:	83 ec 1c             	sub    $0x1c,%esp
 1f1:	8b 7d 08             	mov    0x8(%ebp),%edi
 1f4:	eb 33                	jmp    229 <gets+0x49>
 1f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1fd:	8d 76 00             	lea    0x0(%esi),%esi
 200:	83 ec 04             	sub    $0x4,%esp
 203:	8d 45 e7             	lea    -0x19(%ebp),%eax
 206:	6a 01                	push   $0x1
 208:	50                   	push   %eax
 209:	6a 00                	push   $0x0
 20b:	e8 2b 01 00 00       	call   33b <read>
 210:	83 c4 10             	add    $0x10,%esp
 213:	85 c0                	test   %eax,%eax
 215:	7e 1c                	jle    233 <gets+0x53>
 217:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 21b:	83 c7 01             	add    $0x1,%edi
 21e:	88 47 ff             	mov    %al,-0x1(%edi)
 221:	3c 0a                	cmp    $0xa,%al
 223:	74 23                	je     248 <gets+0x68>
 225:	3c 0d                	cmp    $0xd,%al
 227:	74 1f                	je     248 <gets+0x68>
 229:	83 c3 01             	add    $0x1,%ebx
 22c:	89 fe                	mov    %edi,%esi
 22e:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 231:	7c cd                	jl     200 <gets+0x20>
 233:	89 f3                	mov    %esi,%ebx
 235:	8b 45 08             	mov    0x8(%ebp),%eax
 238:	c6 03 00             	movb   $0x0,(%ebx)
 23b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 23e:	5b                   	pop    %ebx
 23f:	5e                   	pop    %esi
 240:	5f                   	pop    %edi
 241:	5d                   	pop    %ebp
 242:	c3                   	ret    
 243:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 247:	90                   	nop
 248:	8b 75 08             	mov    0x8(%ebp),%esi
 24b:	8b 45 08             	mov    0x8(%ebp),%eax
 24e:	01 de                	add    %ebx,%esi
 250:	89 f3                	mov    %esi,%ebx
 252:	c6 03 00             	movb   $0x0,(%ebx)
 255:	8d 65 f4             	lea    -0xc(%ebp),%esp
 258:	5b                   	pop    %ebx
 259:	5e                   	pop    %esi
 25a:	5f                   	pop    %edi
 25b:	5d                   	pop    %ebp
 25c:	c3                   	ret    
 25d:	8d 76 00             	lea    0x0(%esi),%esi

00000260 <stat>:
 260:	f3 0f 1e fb          	endbr32 
 264:	55                   	push   %ebp
 265:	89 e5                	mov    %esp,%ebp
 267:	56                   	push   %esi
 268:	53                   	push   %ebx
 269:	83 ec 08             	sub    $0x8,%esp
 26c:	6a 00                	push   $0x0
 26e:	ff 75 08             	pushl  0x8(%ebp)
 271:	e8 ed 00 00 00       	call   363 <open>
 276:	83 c4 10             	add    $0x10,%esp
 279:	85 c0                	test   %eax,%eax
 27b:	78 2b                	js     2a8 <stat+0x48>
 27d:	83 ec 08             	sub    $0x8,%esp
 280:	ff 75 0c             	pushl  0xc(%ebp)
 283:	89 c3                	mov    %eax,%ebx
 285:	50                   	push   %eax
 286:	e8 f0 00 00 00       	call   37b <fstat>
 28b:	89 1c 24             	mov    %ebx,(%esp)
 28e:	89 c6                	mov    %eax,%esi
 290:	e8 b6 00 00 00       	call   34b <close>
 295:	83 c4 10             	add    $0x10,%esp
 298:	8d 65 f8             	lea    -0x8(%ebp),%esp
 29b:	89 f0                	mov    %esi,%eax
 29d:	5b                   	pop    %ebx
 29e:	5e                   	pop    %esi
 29f:	5d                   	pop    %ebp
 2a0:	c3                   	ret    
 2a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2a8:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2ad:	eb e9                	jmp    298 <stat+0x38>
 2af:	90                   	nop

000002b0 <atoi>:
 2b0:	f3 0f 1e fb          	endbr32 
 2b4:	55                   	push   %ebp
 2b5:	89 e5                	mov    %esp,%ebp
 2b7:	53                   	push   %ebx
 2b8:	8b 55 08             	mov    0x8(%ebp),%edx
 2bb:	0f be 02             	movsbl (%edx),%eax
 2be:	8d 48 d0             	lea    -0x30(%eax),%ecx
 2c1:	80 f9 09             	cmp    $0x9,%cl
 2c4:	b9 00 00 00 00       	mov    $0x0,%ecx
 2c9:	77 1a                	ja     2e5 <atoi+0x35>
 2cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2cf:	90                   	nop
 2d0:	83 c2 01             	add    $0x1,%edx
 2d3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 2d6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
 2da:	0f be 02             	movsbl (%edx),%eax
 2dd:	8d 58 d0             	lea    -0x30(%eax),%ebx
 2e0:	80 fb 09             	cmp    $0x9,%bl
 2e3:	76 eb                	jbe    2d0 <atoi+0x20>
 2e5:	89 c8                	mov    %ecx,%eax
 2e7:	5b                   	pop    %ebx
 2e8:	5d                   	pop    %ebp
 2e9:	c3                   	ret    
 2ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000002f0 <memmove>:
 2f0:	f3 0f 1e fb          	endbr32 
 2f4:	55                   	push   %ebp
 2f5:	89 e5                	mov    %esp,%ebp
 2f7:	57                   	push   %edi
 2f8:	8b 45 10             	mov    0x10(%ebp),%eax
 2fb:	8b 55 08             	mov    0x8(%ebp),%edx
 2fe:	56                   	push   %esi
 2ff:	8b 75 0c             	mov    0xc(%ebp),%esi
 302:	85 c0                	test   %eax,%eax
 304:	7e 0f                	jle    315 <memmove+0x25>
 306:	01 d0                	add    %edx,%eax
 308:	89 d7                	mov    %edx,%edi
 30a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 310:	a4                   	movsb  %ds:(%esi),%es:(%edi)
 311:	39 f8                	cmp    %edi,%eax
 313:	75 fb                	jne    310 <memmove+0x20>
 315:	5e                   	pop    %esi
 316:	89 d0                	mov    %edx,%eax
 318:	5f                   	pop    %edi
 319:	5d                   	pop    %ebp
 31a:	c3                   	ret    

0000031b <fork>:
 31b:	b8 01 00 00 00       	mov    $0x1,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret    

00000323 <exit>:
 323:	b8 02 00 00 00       	mov    $0x2,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret    

0000032b <wait>:
 32b:	b8 03 00 00 00       	mov    $0x3,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret    

00000333 <pipe>:
 333:	b8 04 00 00 00       	mov    $0x4,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret    

0000033b <read>:
 33b:	b8 05 00 00 00       	mov    $0x5,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret    

00000343 <write>:
 343:	b8 10 00 00 00       	mov    $0x10,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret    

0000034b <close>:
 34b:	b8 15 00 00 00       	mov    $0x15,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret    

00000353 <kill>:
 353:	b8 06 00 00 00       	mov    $0x6,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret    

0000035b <exec>:
 35b:	b8 07 00 00 00       	mov    $0x7,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret    

00000363 <open>:
 363:	b8 0f 00 00 00       	mov    $0xf,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret    

0000036b <mknod>:
 36b:	b8 11 00 00 00       	mov    $0x11,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret    

00000373 <unlink>:
 373:	b8 12 00 00 00       	mov    $0x12,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret    

0000037b <fstat>:
 37b:	b8 08 00 00 00       	mov    $0x8,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret    

00000383 <link>:
 383:	b8 13 00 00 00       	mov    $0x13,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret    

0000038b <mkdir>:
 38b:	b8 14 00 00 00       	mov    $0x14,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret    

00000393 <chdir>:
 393:	b8 09 00 00 00       	mov    $0x9,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret    

0000039b <dup>:
 39b:	b8 0a 00 00 00       	mov    $0xa,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret    

000003a3 <getpid>:
 3a3:	b8 0b 00 00 00       	mov    $0xb,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret    

000003ab <sbrk>:
 3ab:	b8 0c 00 00 00       	mov    $0xc,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret    

000003b3 <sleep>:
 3b3:	b8 0d 00 00 00       	mov    $0xd,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret    

000003bb <uptime>:
 3bb:	b8 0e 00 00 00       	mov    $0xe,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret    

000003c3 <changeQueue>:
 3c3:	b8 16 00 00 00       	mov    $0x16,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret    

000003cb <printProcess>:
 3cb:	b8 17 00 00 00       	mov    $0x17,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret    

000003d3 <changeProcessMHRRN>:
 3d3:	b8 18 00 00 00       	mov    $0x18,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret    

000003db <changeSystemMHRRN>:
 3db:	b8 19 00 00 00       	mov    $0x19,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret    

000003e3 <sem_acquire>:
 3e3:	b8 1a 00 00 00       	mov    $0x1a,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret    

000003eb <sem_release>:
 3eb:	b8 1b 00 00 00       	mov    $0x1b,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret    

000003f3 <sem_init>:
 3f3:	b8 1c 00 00 00       	mov    $0x1c,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret    
 3fb:	66 90                	xchg   %ax,%ax
 3fd:	66 90                	xchg   %ax,%ax
 3ff:	90                   	nop

00000400 <printint>:
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	57                   	push   %edi
 404:	56                   	push   %esi
 405:	53                   	push   %ebx
 406:	83 ec 3c             	sub    $0x3c,%esp
 409:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
 40c:	89 d1                	mov    %edx,%ecx
 40e:	89 45 b8             	mov    %eax,-0x48(%ebp)
 411:	85 d2                	test   %edx,%edx
 413:	0f 89 7f 00 00 00    	jns    498 <printint+0x98>
 419:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 41d:	74 79                	je     498 <printint+0x98>
 41f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
 426:	f7 d9                	neg    %ecx
 428:	31 db                	xor    %ebx,%ebx
 42a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 42d:	8d 76 00             	lea    0x0(%esi),%esi
 430:	89 c8                	mov    %ecx,%eax
 432:	31 d2                	xor    %edx,%edx
 434:	89 cf                	mov    %ecx,%edi
 436:	f7 75 c4             	divl   -0x3c(%ebp)
 439:	0f b6 92 64 08 00 00 	movzbl 0x864(%edx),%edx
 440:	89 45 c0             	mov    %eax,-0x40(%ebp)
 443:	89 d8                	mov    %ebx,%eax
 445:	8d 5b 01             	lea    0x1(%ebx),%ebx
 448:	8b 4d c0             	mov    -0x40(%ebp),%ecx
 44b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
 44e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 451:	76 dd                	jbe    430 <printint+0x30>
 453:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 456:	85 c9                	test   %ecx,%ecx
 458:	74 0c                	je     466 <printint+0x66>
 45a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 45f:	89 d8                	mov    %ebx,%eax
 461:	ba 2d 00 00 00       	mov    $0x2d,%edx
 466:	8b 7d b8             	mov    -0x48(%ebp),%edi
 469:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 46d:	eb 07                	jmp    476 <printint+0x76>
 46f:	90                   	nop
 470:	0f b6 13             	movzbl (%ebx),%edx
 473:	83 eb 01             	sub    $0x1,%ebx
 476:	83 ec 04             	sub    $0x4,%esp
 479:	88 55 d7             	mov    %dl,-0x29(%ebp)
 47c:	6a 01                	push   $0x1
 47e:	56                   	push   %esi
 47f:	57                   	push   %edi
 480:	e8 be fe ff ff       	call   343 <write>
 485:	83 c4 10             	add    $0x10,%esp
 488:	39 de                	cmp    %ebx,%esi
 48a:	75 e4                	jne    470 <printint+0x70>
 48c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 48f:	5b                   	pop    %ebx
 490:	5e                   	pop    %esi
 491:	5f                   	pop    %edi
 492:	5d                   	pop    %ebp
 493:	c3                   	ret    
 494:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 498:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 49f:	eb 87                	jmp    428 <printint+0x28>
 4a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4af:	90                   	nop

000004b0 <printf>:
 4b0:	f3 0f 1e fb          	endbr32 
 4b4:	55                   	push   %ebp
 4b5:	89 e5                	mov    %esp,%ebp
 4b7:	57                   	push   %edi
 4b8:	56                   	push   %esi
 4b9:	53                   	push   %ebx
 4ba:	83 ec 2c             	sub    $0x2c,%esp
 4bd:	8b 75 0c             	mov    0xc(%ebp),%esi
 4c0:	0f b6 1e             	movzbl (%esi),%ebx
 4c3:	84 db                	test   %bl,%bl
 4c5:	0f 84 b4 00 00 00    	je     57f <printf+0xcf>
 4cb:	8d 45 10             	lea    0x10(%ebp),%eax
 4ce:	83 c6 01             	add    $0x1,%esi
 4d1:	8d 7d e7             	lea    -0x19(%ebp),%edi
 4d4:	31 d2                	xor    %edx,%edx
 4d6:	89 45 d0             	mov    %eax,-0x30(%ebp)
 4d9:	eb 33                	jmp    50e <printf+0x5e>
 4db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4df:	90                   	nop
 4e0:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 4e3:	ba 25 00 00 00       	mov    $0x25,%edx
 4e8:	83 f8 25             	cmp    $0x25,%eax
 4eb:	74 17                	je     504 <printf+0x54>
 4ed:	83 ec 04             	sub    $0x4,%esp
 4f0:	88 5d e7             	mov    %bl,-0x19(%ebp)
 4f3:	6a 01                	push   $0x1
 4f5:	57                   	push   %edi
 4f6:	ff 75 08             	pushl  0x8(%ebp)
 4f9:	e8 45 fe ff ff       	call   343 <write>
 4fe:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 501:	83 c4 10             	add    $0x10,%esp
 504:	0f b6 1e             	movzbl (%esi),%ebx
 507:	83 c6 01             	add    $0x1,%esi
 50a:	84 db                	test   %bl,%bl
 50c:	74 71                	je     57f <printf+0xcf>
 50e:	0f be cb             	movsbl %bl,%ecx
 511:	0f b6 c3             	movzbl %bl,%eax
 514:	85 d2                	test   %edx,%edx
 516:	74 c8                	je     4e0 <printf+0x30>
 518:	83 fa 25             	cmp    $0x25,%edx
 51b:	75 e7                	jne    504 <printf+0x54>
 51d:	83 f8 64             	cmp    $0x64,%eax
 520:	0f 84 9a 00 00 00    	je     5c0 <printf+0x110>
 526:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 52c:	83 f9 70             	cmp    $0x70,%ecx
 52f:	74 5f                	je     590 <printf+0xe0>
 531:	83 f8 73             	cmp    $0x73,%eax
 534:	0f 84 d6 00 00 00    	je     610 <printf+0x160>
 53a:	83 f8 63             	cmp    $0x63,%eax
 53d:	0f 84 8d 00 00 00    	je     5d0 <printf+0x120>
 543:	83 f8 25             	cmp    $0x25,%eax
 546:	0f 84 b4 00 00 00    	je     600 <printf+0x150>
 54c:	83 ec 04             	sub    $0x4,%esp
 54f:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 553:	6a 01                	push   $0x1
 555:	57                   	push   %edi
 556:	ff 75 08             	pushl  0x8(%ebp)
 559:	e8 e5 fd ff ff       	call   343 <write>
 55e:	88 5d e7             	mov    %bl,-0x19(%ebp)
 561:	83 c4 0c             	add    $0xc,%esp
 564:	6a 01                	push   $0x1
 566:	83 c6 01             	add    $0x1,%esi
 569:	57                   	push   %edi
 56a:	ff 75 08             	pushl  0x8(%ebp)
 56d:	e8 d1 fd ff ff       	call   343 <write>
 572:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 576:	83 c4 10             	add    $0x10,%esp
 579:	31 d2                	xor    %edx,%edx
 57b:	84 db                	test   %bl,%bl
 57d:	75 8f                	jne    50e <printf+0x5e>
 57f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 582:	5b                   	pop    %ebx
 583:	5e                   	pop    %esi
 584:	5f                   	pop    %edi
 585:	5d                   	pop    %ebp
 586:	c3                   	ret    
 587:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 58e:	66 90                	xchg   %ax,%ax
 590:	83 ec 0c             	sub    $0xc,%esp
 593:	b9 10 00 00 00       	mov    $0x10,%ecx
 598:	6a 00                	push   $0x0
 59a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 59d:	8b 45 08             	mov    0x8(%ebp),%eax
 5a0:	8b 13                	mov    (%ebx),%edx
 5a2:	e8 59 fe ff ff       	call   400 <printint>
 5a7:	89 d8                	mov    %ebx,%eax
 5a9:	83 c4 10             	add    $0x10,%esp
 5ac:	31 d2                	xor    %edx,%edx
 5ae:	83 c0 04             	add    $0x4,%eax
 5b1:	89 45 d0             	mov    %eax,-0x30(%ebp)
 5b4:	e9 4b ff ff ff       	jmp    504 <printf+0x54>
 5b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5c0:	83 ec 0c             	sub    $0xc,%esp
 5c3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 5c8:	6a 01                	push   $0x1
 5ca:	eb ce                	jmp    59a <printf+0xea>
 5cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5d0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 5d3:	83 ec 04             	sub    $0x4,%esp
 5d6:	8b 03                	mov    (%ebx),%eax
 5d8:	6a 01                	push   $0x1
 5da:	83 c3 04             	add    $0x4,%ebx
 5dd:	57                   	push   %edi
 5de:	ff 75 08             	pushl  0x8(%ebp)
 5e1:	88 45 e7             	mov    %al,-0x19(%ebp)
 5e4:	e8 5a fd ff ff       	call   343 <write>
 5e9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 5ec:	83 c4 10             	add    $0x10,%esp
 5ef:	31 d2                	xor    %edx,%edx
 5f1:	e9 0e ff ff ff       	jmp    504 <printf+0x54>
 5f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5fd:	8d 76 00             	lea    0x0(%esi),%esi
 600:	88 5d e7             	mov    %bl,-0x19(%ebp)
 603:	83 ec 04             	sub    $0x4,%esp
 606:	e9 59 ff ff ff       	jmp    564 <printf+0xb4>
 60b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 60f:	90                   	nop
 610:	8b 45 d0             	mov    -0x30(%ebp),%eax
 613:	8b 18                	mov    (%eax),%ebx
 615:	83 c0 04             	add    $0x4,%eax
 618:	89 45 d0             	mov    %eax,-0x30(%ebp)
 61b:	85 db                	test   %ebx,%ebx
 61d:	74 17                	je     636 <printf+0x186>
 61f:	0f b6 03             	movzbl (%ebx),%eax
 622:	31 d2                	xor    %edx,%edx
 624:	84 c0                	test   %al,%al
 626:	0f 84 d8 fe ff ff    	je     504 <printf+0x54>
 62c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 62f:	89 de                	mov    %ebx,%esi
 631:	8b 5d 08             	mov    0x8(%ebp),%ebx
 634:	eb 1a                	jmp    650 <printf+0x1a0>
 636:	bb 5d 08 00 00       	mov    $0x85d,%ebx
 63b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 63e:	b8 28 00 00 00       	mov    $0x28,%eax
 643:	89 de                	mov    %ebx,%esi
 645:	8b 5d 08             	mov    0x8(%ebp),%ebx
 648:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 64f:	90                   	nop
 650:	83 ec 04             	sub    $0x4,%esp
 653:	83 c6 01             	add    $0x1,%esi
 656:	88 45 e7             	mov    %al,-0x19(%ebp)
 659:	6a 01                	push   $0x1
 65b:	57                   	push   %edi
 65c:	53                   	push   %ebx
 65d:	e8 e1 fc ff ff       	call   343 <write>
 662:	0f b6 06             	movzbl (%esi),%eax
 665:	83 c4 10             	add    $0x10,%esp
 668:	84 c0                	test   %al,%al
 66a:	75 e4                	jne    650 <printf+0x1a0>
 66c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 66f:	31 d2                	xor    %edx,%edx
 671:	e9 8e fe ff ff       	jmp    504 <printf+0x54>
 676:	66 90                	xchg   %ax,%ax
 678:	66 90                	xchg   %ax,%ax
 67a:	66 90                	xchg   %ax,%ax
 67c:	66 90                	xchg   %ax,%ax
 67e:	66 90                	xchg   %ax,%ax

00000680 <free>:
 680:	f3 0f 1e fb          	endbr32 
 684:	55                   	push   %ebp
 685:	a1 1c 0b 00 00       	mov    0xb1c,%eax
 68a:	89 e5                	mov    %esp,%ebp
 68c:	57                   	push   %edi
 68d:	56                   	push   %esi
 68e:	53                   	push   %ebx
 68f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 692:	8b 10                	mov    (%eax),%edx
 694:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 697:	39 c8                	cmp    %ecx,%eax
 699:	73 15                	jae    6b0 <free+0x30>
 69b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 69f:	90                   	nop
 6a0:	39 d1                	cmp    %edx,%ecx
 6a2:	72 14                	jb     6b8 <free+0x38>
 6a4:	39 d0                	cmp    %edx,%eax
 6a6:	73 10                	jae    6b8 <free+0x38>
 6a8:	89 d0                	mov    %edx,%eax
 6aa:	8b 10                	mov    (%eax),%edx
 6ac:	39 c8                	cmp    %ecx,%eax
 6ae:	72 f0                	jb     6a0 <free+0x20>
 6b0:	39 d0                	cmp    %edx,%eax
 6b2:	72 f4                	jb     6a8 <free+0x28>
 6b4:	39 d1                	cmp    %edx,%ecx
 6b6:	73 f0                	jae    6a8 <free+0x28>
 6b8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6bb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6be:	39 fa                	cmp    %edi,%edx
 6c0:	74 1e                	je     6e0 <free+0x60>
 6c2:	89 53 f8             	mov    %edx,-0x8(%ebx)
 6c5:	8b 50 04             	mov    0x4(%eax),%edx
 6c8:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6cb:	39 f1                	cmp    %esi,%ecx
 6cd:	74 28                	je     6f7 <free+0x77>
 6cf:	89 08                	mov    %ecx,(%eax)
 6d1:	5b                   	pop    %ebx
 6d2:	a3 1c 0b 00 00       	mov    %eax,0xb1c
 6d7:	5e                   	pop    %esi
 6d8:	5f                   	pop    %edi
 6d9:	5d                   	pop    %ebp
 6da:	c3                   	ret    
 6db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6df:	90                   	nop
 6e0:	03 72 04             	add    0x4(%edx),%esi
 6e3:	89 73 fc             	mov    %esi,-0x4(%ebx)
 6e6:	8b 10                	mov    (%eax),%edx
 6e8:	8b 12                	mov    (%edx),%edx
 6ea:	89 53 f8             	mov    %edx,-0x8(%ebx)
 6ed:	8b 50 04             	mov    0x4(%eax),%edx
 6f0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6f3:	39 f1                	cmp    %esi,%ecx
 6f5:	75 d8                	jne    6cf <free+0x4f>
 6f7:	03 53 fc             	add    -0x4(%ebx),%edx
 6fa:	a3 1c 0b 00 00       	mov    %eax,0xb1c
 6ff:	89 50 04             	mov    %edx,0x4(%eax)
 702:	8b 53 f8             	mov    -0x8(%ebx),%edx
 705:	89 10                	mov    %edx,(%eax)
 707:	5b                   	pop    %ebx
 708:	5e                   	pop    %esi
 709:	5f                   	pop    %edi
 70a:	5d                   	pop    %ebp
 70b:	c3                   	ret    
 70c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000710 <malloc>:
 710:	f3 0f 1e fb          	endbr32 
 714:	55                   	push   %ebp
 715:	89 e5                	mov    %esp,%ebp
 717:	57                   	push   %edi
 718:	56                   	push   %esi
 719:	53                   	push   %ebx
 71a:	83 ec 1c             	sub    $0x1c,%esp
 71d:	8b 45 08             	mov    0x8(%ebp),%eax
 720:	8b 3d 1c 0b 00 00    	mov    0xb1c,%edi
 726:	8d 70 07             	lea    0x7(%eax),%esi
 729:	c1 ee 03             	shr    $0x3,%esi
 72c:	83 c6 01             	add    $0x1,%esi
 72f:	85 ff                	test   %edi,%edi
 731:	0f 84 a9 00 00 00    	je     7e0 <malloc+0xd0>
 737:	8b 07                	mov    (%edi),%eax
 739:	8b 48 04             	mov    0x4(%eax),%ecx
 73c:	39 f1                	cmp    %esi,%ecx
 73e:	73 6d                	jae    7ad <malloc+0x9d>
 740:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 746:	bb 00 10 00 00       	mov    $0x1000,%ebx
 74b:	0f 43 de             	cmovae %esi,%ebx
 74e:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 755:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 758:	eb 17                	jmp    771 <malloc+0x61>
 75a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 760:	8b 10                	mov    (%eax),%edx
 762:	8b 4a 04             	mov    0x4(%edx),%ecx
 765:	39 f1                	cmp    %esi,%ecx
 767:	73 4f                	jae    7b8 <malloc+0xa8>
 769:	8b 3d 1c 0b 00 00    	mov    0xb1c,%edi
 76f:	89 d0                	mov    %edx,%eax
 771:	39 c7                	cmp    %eax,%edi
 773:	75 eb                	jne    760 <malloc+0x50>
 775:	83 ec 0c             	sub    $0xc,%esp
 778:	ff 75 e4             	pushl  -0x1c(%ebp)
 77b:	e8 2b fc ff ff       	call   3ab <sbrk>
 780:	83 c4 10             	add    $0x10,%esp
 783:	83 f8 ff             	cmp    $0xffffffff,%eax
 786:	74 1b                	je     7a3 <malloc+0x93>
 788:	89 58 04             	mov    %ebx,0x4(%eax)
 78b:	83 ec 0c             	sub    $0xc,%esp
 78e:	83 c0 08             	add    $0x8,%eax
 791:	50                   	push   %eax
 792:	e8 e9 fe ff ff       	call   680 <free>
 797:	a1 1c 0b 00 00       	mov    0xb1c,%eax
 79c:	83 c4 10             	add    $0x10,%esp
 79f:	85 c0                	test   %eax,%eax
 7a1:	75 bd                	jne    760 <malloc+0x50>
 7a3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 7a6:	31 c0                	xor    %eax,%eax
 7a8:	5b                   	pop    %ebx
 7a9:	5e                   	pop    %esi
 7aa:	5f                   	pop    %edi
 7ab:	5d                   	pop    %ebp
 7ac:	c3                   	ret    
 7ad:	89 c2                	mov    %eax,%edx
 7af:	89 f8                	mov    %edi,%eax
 7b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7b8:	39 ce                	cmp    %ecx,%esi
 7ba:	74 54                	je     810 <malloc+0x100>
 7bc:	29 f1                	sub    %esi,%ecx
 7be:	89 4a 04             	mov    %ecx,0x4(%edx)
 7c1:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
 7c4:	89 72 04             	mov    %esi,0x4(%edx)
 7c7:	a3 1c 0b 00 00       	mov    %eax,0xb1c
 7cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 7cf:	8d 42 08             	lea    0x8(%edx),%eax
 7d2:	5b                   	pop    %ebx
 7d3:	5e                   	pop    %esi
 7d4:	5f                   	pop    %edi
 7d5:	5d                   	pop    %ebp
 7d6:	c3                   	ret    
 7d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7de:	66 90                	xchg   %ax,%ax
 7e0:	c7 05 1c 0b 00 00 20 	movl   $0xb20,0xb1c
 7e7:	0b 00 00 
 7ea:	bf 20 0b 00 00       	mov    $0xb20,%edi
 7ef:	c7 05 20 0b 00 00 20 	movl   $0xb20,0xb20
 7f6:	0b 00 00 
 7f9:	89 f8                	mov    %edi,%eax
 7fb:	c7 05 24 0b 00 00 00 	movl   $0x0,0xb24
 802:	00 00 00 
 805:	e9 36 ff ff ff       	jmp    740 <malloc+0x30>
 80a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 810:	8b 0a                	mov    (%edx),%ecx
 812:	89 08                	mov    %ecx,(%eax)
 814:	eb b1                	jmp    7c7 <malloc+0xb7>
