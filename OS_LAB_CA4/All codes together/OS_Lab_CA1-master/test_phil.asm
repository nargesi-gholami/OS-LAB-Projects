
_test_phil:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
    exit();
}


int main()
{
   0:	f3 0f 1e fb          	endbr32 
   4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   8:	83 e4 f0             	and    $0xfffffff0,%esp
   b:	ff 71 fc             	pushl  -0x4(%ecx)
   e:	55                   	push   %ebp
   f:	89 e5                	mov    %esp,%ebp
  11:	53                   	push   %ebx
  12:	51                   	push   %ecx
    sem_init(0, 4);
  13:	83 ec 08             	sub    $0x8,%esp
  16:	6a 04                	push   $0x4
  18:	6a 00                	push   $0x0
  1a:	e8 a4 04 00 00       	call   4c3 <sem_init>
    
    sem_init(1, 1);
  1f:	58                   	pop    %eax
  20:	5a                   	pop    %edx
  21:	6a 01                	push   $0x1
  23:	6a 01                	push   $0x1
  25:	e8 99 04 00 00       	call   4c3 <sem_init>
    sem_init(2, 1);
  2a:	59                   	pop    %ecx
  2b:	5b                   	pop    %ebx
  2c:	6a 01                	push   $0x1
  2e:	6a 02                	push   $0x2
  30:	e8 8e 04 00 00       	call   4c3 <sem_init>
    sem_init(3, 1);
  35:	58                   	pop    %eax
  36:	5a                   	pop    %edx
  37:	6a 01                	push   $0x1
  39:	6a 03                	push   $0x3
  3b:	e8 83 04 00 00       	call   4c3 <sem_init>
    sem_init(4, 1);
  40:	59                   	pop    %ecx
  41:	5b                   	pop    %ebx
  42:	6a 01                	push   $0x1
  44:	6a 04                	push   $0x4
    sem_init(5, 1);

    //char* numbers[5] = {"1", "2","3","4","5"} ;
    for(int i = 0 ; i < 5 ; i++)
  46:	31 db                	xor    %ebx,%ebx
    sem_init(4, 1);
  48:	e8 76 04 00 00       	call   4c3 <sem_init>
    sem_init(5, 1);
  4d:	58                   	pop    %eax
  4e:	5a                   	pop    %edx
  4f:	6a 01                	push   $0x1
  51:	6a 05                	push   $0x5
  53:	e8 6b 04 00 00       	call   4c3 <sem_init>
  58:	83 c4 10             	add    $0x10,%esp
    {
        if(!fork())
  5b:	e8 8b 03 00 00       	call   3eb <fork>
  60:	89 da                	mov    %ebx,%edx
  62:	83 c3 01             	add    $0x1,%ebx
  65:	85 c0                	test   %eax,%eax
  67:	74 22                	je     8b <main+0x8b>
            // exec(args[0], args);
            phil(i+1);
        }
        else
        {
            printf(1, "Philosopher %d entered\n", i);
  69:	83 ec 04             	sub    $0x4,%esp
  6c:	52                   	push   %edx
  6d:	68 50 09 00 00       	push   $0x950
  72:	6a 01                	push   $0x1
  74:	e8 07 05 00 00       	call   580 <printf>
    for(int i = 0 ; i < 5 ; i++)
  79:	83 c4 10             	add    $0x10,%esp
  7c:	83 fb 05             	cmp    $0x5,%ebx
  7f:	75 da                	jne    5b <main+0x5b>
        }
    }
    wait();
  81:	e8 75 03 00 00       	call   3fb <wait>
    
    exit();
  86:	e8 68 03 00 00       	call   3f3 <exit>
            phil(i+1);
  8b:	83 ec 0c             	sub    $0xc,%esp
  8e:	53                   	push   %ebx
  8f:	e8 0c 00 00 00       	call   a0 <phil>
  94:	66 90                	xchg   %ax,%ax
  96:	66 90                	xchg   %ax,%ax
  98:	66 90                	xchg   %ax,%ax
  9a:	66 90                	xchg   %ax,%ax
  9c:	66 90                	xchg   %ax,%ax
  9e:	66 90                	xchg   %ax,%ax

000000a0 <phil>:
{
  a0:	f3 0f 1e fb          	endbr32 
  a4:	55                   	push   %ebp
  a5:	89 e5                	mov    %esp,%ebp
  a7:	57                   	push   %edi
  a8:	56                   	push   %esi
        sem_acquire(phil_id % 5 - 1);
  a9:	be 0a 00 00 00       	mov    $0xa,%esi
{
  ae:	53                   	push   %ebx
  af:	83 ec 14             	sub    $0x14,%esp
  b2:	8b 5d 08             	mov    0x8(%ebp),%ebx
    printf(1,"hiiiiiiiiiiii\n");
  b5:	68 e8 08 00 00       	push   $0x8e8
  ba:	6a 01                	push   $0x1
        sem_acquire(phil_id % 5 - 1);
  bc:	89 df                	mov    %ebx,%edi
    printf(1,"hiiiiiiiiiiii\n");
  be:	e8 bd 04 00 00       	call   580 <printf>
        sem_acquire(phil_id % 5 - 1);
  c3:	89 d8                	mov    %ebx,%eax
  c5:	ba 67 66 66 66       	mov    $0x66666667,%edx
  ca:	83 c4 10             	add    $0x10,%esp
  cd:	f7 ea                	imul   %edx
  cf:	89 d8                	mov    %ebx,%eax
  d1:	c1 f8 1f             	sar    $0x1f,%eax
  d4:	d1 fa                	sar    %edx
  d6:	29 c2                	sub    %eax,%edx
  d8:	8d 04 92             	lea    (%edx,%edx,4),%eax
  db:	29 c7                	sub    %eax,%edi
  dd:	83 ef 01             	sub    $0x1,%edi
        printf(1,"in for\n");
  e0:	83 ec 08             	sub    $0x8,%esp
  e3:	68 f7 08 00 00       	push   $0x8f7
  e8:	6a 01                	push   $0x1
  ea:	e8 91 04 00 00       	call   580 <printf>
        sem_acquire(0);
  ef:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  f6:	e8 b8 03 00 00       	call   4b3 <sem_acquire>
        printf(1,"sem ac0\n");
  fb:	58                   	pop    %eax
  fc:	5a                   	pop    %edx
  fd:	68 ff 08 00 00       	push   $0x8ff
 102:	6a 01                	push   $0x1
 104:	e8 77 04 00 00       	call   580 <printf>
        sem_acquire(phil_id);
 109:	89 1c 24             	mov    %ebx,(%esp)
 10c:	e8 a2 03 00 00       	call   4b3 <sem_acquire>
        printf(1,"sem ac1\n");
 111:	59                   	pop    %ecx
 112:	58                   	pop    %eax
 113:	68 08 09 00 00       	push   $0x908
 118:	6a 01                	push   $0x1
 11a:	e8 61 04 00 00       	call   580 <printf>
        sem_acquire(phil_id % 5 - 1);
 11f:	89 3c 24             	mov    %edi,(%esp)
 122:	e8 8c 03 00 00       	call   4b3 <sem_acquire>
        printf(1,"sem ac2\n");
 127:	58                   	pop    %eax
 128:	5a                   	pop    %edx
 129:	68 11 09 00 00       	push   $0x911
 12e:	6a 01                	push   $0x1
 130:	e8 4b 04 00 00       	call   580 <printf>
        printf(1, "Philosopher %d is eating\n", phil_id);
 135:	83 c4 0c             	add    $0xc,%esp
 138:	53                   	push   %ebx
 139:	68 1a 09 00 00       	push   $0x91a
 13e:	6a 01                	push   $0x1
 140:	e8 3b 04 00 00       	call   580 <printf>
        sem_release(phil_id);
 145:	89 1c 24             	mov    %ebx,(%esp)
 148:	e8 6e 03 00 00       	call   4bb <sem_release>
        sem_release(phil_id % 5 - 1);
 14d:	89 3c 24             	mov    %edi,(%esp)
 150:	e8 66 03 00 00       	call   4bb <sem_release>
        sem_release(0);
 155:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 15c:	e8 5a 03 00 00       	call   4bb <sem_release>
        printf(1, "Philosopher %d is thinking\n", phil_id);
 161:	83 c4 0c             	add    $0xc,%esp
 164:	53                   	push   %ebx
 165:	68 34 09 00 00       	push   $0x934
 16a:	6a 01                	push   $0x1
 16c:	e8 0f 04 00 00       	call   580 <printf>
    for(int j = 0 ; j < 10 ; j++)
 171:	83 c4 10             	add    $0x10,%esp
 174:	83 ee 01             	sub    $0x1,%esi
 177:	0f 85 63 ff ff ff    	jne    e0 <phil+0x40>
    exit();
 17d:	e8 71 02 00 00       	call   3f3 <exit>
 182:	66 90                	xchg   %ax,%ax
 184:	66 90                	xchg   %ax,%ax
 186:	66 90                	xchg   %ax,%ax
 188:	66 90                	xchg   %ax,%ax
 18a:	66 90                	xchg   %ax,%ax
 18c:	66 90                	xchg   %ax,%ax
 18e:	66 90                	xchg   %ax,%ax

00000190 <strcpy>:
 190:	f3 0f 1e fb          	endbr32 
 194:	55                   	push   %ebp
 195:	31 c0                	xor    %eax,%eax
 197:	89 e5                	mov    %esp,%ebp
 199:	53                   	push   %ebx
 19a:	8b 4d 08             	mov    0x8(%ebp),%ecx
 19d:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 1a0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 1a4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 1a7:	83 c0 01             	add    $0x1,%eax
 1aa:	84 d2                	test   %dl,%dl
 1ac:	75 f2                	jne    1a0 <strcpy+0x10>
 1ae:	89 c8                	mov    %ecx,%eax
 1b0:	5b                   	pop    %ebx
 1b1:	5d                   	pop    %ebp
 1b2:	c3                   	ret    
 1b3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000001c0 <strcmp>:
 1c0:	f3 0f 1e fb          	endbr32 
 1c4:	55                   	push   %ebp
 1c5:	89 e5                	mov    %esp,%ebp
 1c7:	53                   	push   %ebx
 1c8:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1cb:	8b 55 0c             	mov    0xc(%ebp),%edx
 1ce:	0f b6 01             	movzbl (%ecx),%eax
 1d1:	0f b6 1a             	movzbl (%edx),%ebx
 1d4:	84 c0                	test   %al,%al
 1d6:	75 19                	jne    1f1 <strcmp+0x31>
 1d8:	eb 26                	jmp    200 <strcmp+0x40>
 1da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1e0:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
 1e4:	83 c1 01             	add    $0x1,%ecx
 1e7:	83 c2 01             	add    $0x1,%edx
 1ea:	0f b6 1a             	movzbl (%edx),%ebx
 1ed:	84 c0                	test   %al,%al
 1ef:	74 0f                	je     200 <strcmp+0x40>
 1f1:	38 d8                	cmp    %bl,%al
 1f3:	74 eb                	je     1e0 <strcmp+0x20>
 1f5:	29 d8                	sub    %ebx,%eax
 1f7:	5b                   	pop    %ebx
 1f8:	5d                   	pop    %ebp
 1f9:	c3                   	ret    
 1fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 200:	31 c0                	xor    %eax,%eax
 202:	29 d8                	sub    %ebx,%eax
 204:	5b                   	pop    %ebx
 205:	5d                   	pop    %ebp
 206:	c3                   	ret    
 207:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 20e:	66 90                	xchg   %ax,%ax

00000210 <strlen>:
 210:	f3 0f 1e fb          	endbr32 
 214:	55                   	push   %ebp
 215:	89 e5                	mov    %esp,%ebp
 217:	8b 55 08             	mov    0x8(%ebp),%edx
 21a:	80 3a 00             	cmpb   $0x0,(%edx)
 21d:	74 21                	je     240 <strlen+0x30>
 21f:	31 c0                	xor    %eax,%eax
 221:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 228:	83 c0 01             	add    $0x1,%eax
 22b:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 22f:	89 c1                	mov    %eax,%ecx
 231:	75 f5                	jne    228 <strlen+0x18>
 233:	89 c8                	mov    %ecx,%eax
 235:	5d                   	pop    %ebp
 236:	c3                   	ret    
 237:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 23e:	66 90                	xchg   %ax,%ax
 240:	31 c9                	xor    %ecx,%ecx
 242:	5d                   	pop    %ebp
 243:	89 c8                	mov    %ecx,%eax
 245:	c3                   	ret    
 246:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 24d:	8d 76 00             	lea    0x0(%esi),%esi

00000250 <memset>:
 250:	f3 0f 1e fb          	endbr32 
 254:	55                   	push   %ebp
 255:	89 e5                	mov    %esp,%ebp
 257:	57                   	push   %edi
 258:	8b 55 08             	mov    0x8(%ebp),%edx
 25b:	8b 4d 10             	mov    0x10(%ebp),%ecx
 25e:	8b 45 0c             	mov    0xc(%ebp),%eax
 261:	89 d7                	mov    %edx,%edi
 263:	fc                   	cld    
 264:	f3 aa                	rep stos %al,%es:(%edi)
 266:	89 d0                	mov    %edx,%eax
 268:	5f                   	pop    %edi
 269:	5d                   	pop    %ebp
 26a:	c3                   	ret    
 26b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 26f:	90                   	nop

00000270 <strchr>:
 270:	f3 0f 1e fb          	endbr32 
 274:	55                   	push   %ebp
 275:	89 e5                	mov    %esp,%ebp
 277:	8b 45 08             	mov    0x8(%ebp),%eax
 27a:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
 27e:	0f b6 10             	movzbl (%eax),%edx
 281:	84 d2                	test   %dl,%dl
 283:	75 16                	jne    29b <strchr+0x2b>
 285:	eb 21                	jmp    2a8 <strchr+0x38>
 287:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 28e:	66 90                	xchg   %ax,%ax
 290:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 294:	83 c0 01             	add    $0x1,%eax
 297:	84 d2                	test   %dl,%dl
 299:	74 0d                	je     2a8 <strchr+0x38>
 29b:	38 d1                	cmp    %dl,%cl
 29d:	75 f1                	jne    290 <strchr+0x20>
 29f:	5d                   	pop    %ebp
 2a0:	c3                   	ret    
 2a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2a8:	31 c0                	xor    %eax,%eax
 2aa:	5d                   	pop    %ebp
 2ab:	c3                   	ret    
 2ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000002b0 <gets>:
 2b0:	f3 0f 1e fb          	endbr32 
 2b4:	55                   	push   %ebp
 2b5:	89 e5                	mov    %esp,%ebp
 2b7:	57                   	push   %edi
 2b8:	56                   	push   %esi
 2b9:	31 f6                	xor    %esi,%esi
 2bb:	53                   	push   %ebx
 2bc:	89 f3                	mov    %esi,%ebx
 2be:	83 ec 1c             	sub    $0x1c,%esp
 2c1:	8b 7d 08             	mov    0x8(%ebp),%edi
 2c4:	eb 33                	jmp    2f9 <gets+0x49>
 2c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2cd:	8d 76 00             	lea    0x0(%esi),%esi
 2d0:	83 ec 04             	sub    $0x4,%esp
 2d3:	8d 45 e7             	lea    -0x19(%ebp),%eax
 2d6:	6a 01                	push   $0x1
 2d8:	50                   	push   %eax
 2d9:	6a 00                	push   $0x0
 2db:	e8 2b 01 00 00       	call   40b <read>
 2e0:	83 c4 10             	add    $0x10,%esp
 2e3:	85 c0                	test   %eax,%eax
 2e5:	7e 1c                	jle    303 <gets+0x53>
 2e7:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 2eb:	83 c7 01             	add    $0x1,%edi
 2ee:	88 47 ff             	mov    %al,-0x1(%edi)
 2f1:	3c 0a                	cmp    $0xa,%al
 2f3:	74 23                	je     318 <gets+0x68>
 2f5:	3c 0d                	cmp    $0xd,%al
 2f7:	74 1f                	je     318 <gets+0x68>
 2f9:	83 c3 01             	add    $0x1,%ebx
 2fc:	89 fe                	mov    %edi,%esi
 2fe:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 301:	7c cd                	jl     2d0 <gets+0x20>
 303:	89 f3                	mov    %esi,%ebx
 305:	8b 45 08             	mov    0x8(%ebp),%eax
 308:	c6 03 00             	movb   $0x0,(%ebx)
 30b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 30e:	5b                   	pop    %ebx
 30f:	5e                   	pop    %esi
 310:	5f                   	pop    %edi
 311:	5d                   	pop    %ebp
 312:	c3                   	ret    
 313:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 317:	90                   	nop
 318:	8b 75 08             	mov    0x8(%ebp),%esi
 31b:	8b 45 08             	mov    0x8(%ebp),%eax
 31e:	01 de                	add    %ebx,%esi
 320:	89 f3                	mov    %esi,%ebx
 322:	c6 03 00             	movb   $0x0,(%ebx)
 325:	8d 65 f4             	lea    -0xc(%ebp),%esp
 328:	5b                   	pop    %ebx
 329:	5e                   	pop    %esi
 32a:	5f                   	pop    %edi
 32b:	5d                   	pop    %ebp
 32c:	c3                   	ret    
 32d:	8d 76 00             	lea    0x0(%esi),%esi

00000330 <stat>:
 330:	f3 0f 1e fb          	endbr32 
 334:	55                   	push   %ebp
 335:	89 e5                	mov    %esp,%ebp
 337:	56                   	push   %esi
 338:	53                   	push   %ebx
 339:	83 ec 08             	sub    $0x8,%esp
 33c:	6a 00                	push   $0x0
 33e:	ff 75 08             	pushl  0x8(%ebp)
 341:	e8 ed 00 00 00       	call   433 <open>
 346:	83 c4 10             	add    $0x10,%esp
 349:	85 c0                	test   %eax,%eax
 34b:	78 2b                	js     378 <stat+0x48>
 34d:	83 ec 08             	sub    $0x8,%esp
 350:	ff 75 0c             	pushl  0xc(%ebp)
 353:	89 c3                	mov    %eax,%ebx
 355:	50                   	push   %eax
 356:	e8 f0 00 00 00       	call   44b <fstat>
 35b:	89 1c 24             	mov    %ebx,(%esp)
 35e:	89 c6                	mov    %eax,%esi
 360:	e8 b6 00 00 00       	call   41b <close>
 365:	83 c4 10             	add    $0x10,%esp
 368:	8d 65 f8             	lea    -0x8(%ebp),%esp
 36b:	89 f0                	mov    %esi,%eax
 36d:	5b                   	pop    %ebx
 36e:	5e                   	pop    %esi
 36f:	5d                   	pop    %ebp
 370:	c3                   	ret    
 371:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 378:	be ff ff ff ff       	mov    $0xffffffff,%esi
 37d:	eb e9                	jmp    368 <stat+0x38>
 37f:	90                   	nop

00000380 <atoi>:
 380:	f3 0f 1e fb          	endbr32 
 384:	55                   	push   %ebp
 385:	89 e5                	mov    %esp,%ebp
 387:	53                   	push   %ebx
 388:	8b 55 08             	mov    0x8(%ebp),%edx
 38b:	0f be 02             	movsbl (%edx),%eax
 38e:	8d 48 d0             	lea    -0x30(%eax),%ecx
 391:	80 f9 09             	cmp    $0x9,%cl
 394:	b9 00 00 00 00       	mov    $0x0,%ecx
 399:	77 1a                	ja     3b5 <atoi+0x35>
 39b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 39f:	90                   	nop
 3a0:	83 c2 01             	add    $0x1,%edx
 3a3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 3a6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
 3aa:	0f be 02             	movsbl (%edx),%eax
 3ad:	8d 58 d0             	lea    -0x30(%eax),%ebx
 3b0:	80 fb 09             	cmp    $0x9,%bl
 3b3:	76 eb                	jbe    3a0 <atoi+0x20>
 3b5:	89 c8                	mov    %ecx,%eax
 3b7:	5b                   	pop    %ebx
 3b8:	5d                   	pop    %ebp
 3b9:	c3                   	ret    
 3ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000003c0 <memmove>:
 3c0:	f3 0f 1e fb          	endbr32 
 3c4:	55                   	push   %ebp
 3c5:	89 e5                	mov    %esp,%ebp
 3c7:	57                   	push   %edi
 3c8:	8b 45 10             	mov    0x10(%ebp),%eax
 3cb:	8b 55 08             	mov    0x8(%ebp),%edx
 3ce:	56                   	push   %esi
 3cf:	8b 75 0c             	mov    0xc(%ebp),%esi
 3d2:	85 c0                	test   %eax,%eax
 3d4:	7e 0f                	jle    3e5 <memmove+0x25>
 3d6:	01 d0                	add    %edx,%eax
 3d8:	89 d7                	mov    %edx,%edi
 3da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3e0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
 3e1:	39 f8                	cmp    %edi,%eax
 3e3:	75 fb                	jne    3e0 <memmove+0x20>
 3e5:	5e                   	pop    %esi
 3e6:	89 d0                	mov    %edx,%eax
 3e8:	5f                   	pop    %edi
 3e9:	5d                   	pop    %ebp
 3ea:	c3                   	ret    

000003eb <fork>:
 3eb:	b8 01 00 00 00       	mov    $0x1,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret    

000003f3 <exit>:
 3f3:	b8 02 00 00 00       	mov    $0x2,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret    

000003fb <wait>:
 3fb:	b8 03 00 00 00       	mov    $0x3,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret    

00000403 <pipe>:
 403:	b8 04 00 00 00       	mov    $0x4,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret    

0000040b <read>:
 40b:	b8 05 00 00 00       	mov    $0x5,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret    

00000413 <write>:
 413:	b8 10 00 00 00       	mov    $0x10,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret    

0000041b <close>:
 41b:	b8 15 00 00 00       	mov    $0x15,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret    

00000423 <kill>:
 423:	b8 06 00 00 00       	mov    $0x6,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret    

0000042b <exec>:
 42b:	b8 07 00 00 00       	mov    $0x7,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret    

00000433 <open>:
 433:	b8 0f 00 00 00       	mov    $0xf,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret    

0000043b <mknod>:
 43b:	b8 11 00 00 00       	mov    $0x11,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret    

00000443 <unlink>:
 443:	b8 12 00 00 00       	mov    $0x12,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret    

0000044b <fstat>:
 44b:	b8 08 00 00 00       	mov    $0x8,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret    

00000453 <link>:
 453:	b8 13 00 00 00       	mov    $0x13,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret    

0000045b <mkdir>:
 45b:	b8 14 00 00 00       	mov    $0x14,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret    

00000463 <chdir>:
 463:	b8 09 00 00 00       	mov    $0x9,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret    

0000046b <dup>:
 46b:	b8 0a 00 00 00       	mov    $0xa,%eax
 470:	cd 40                	int    $0x40
 472:	c3                   	ret    

00000473 <getpid>:
 473:	b8 0b 00 00 00       	mov    $0xb,%eax
 478:	cd 40                	int    $0x40
 47a:	c3                   	ret    

0000047b <sbrk>:
 47b:	b8 0c 00 00 00       	mov    $0xc,%eax
 480:	cd 40                	int    $0x40
 482:	c3                   	ret    

00000483 <sleep>:
 483:	b8 0d 00 00 00       	mov    $0xd,%eax
 488:	cd 40                	int    $0x40
 48a:	c3                   	ret    

0000048b <uptime>:
 48b:	b8 0e 00 00 00       	mov    $0xe,%eax
 490:	cd 40                	int    $0x40
 492:	c3                   	ret    

00000493 <changeQueue>:
 493:	b8 16 00 00 00       	mov    $0x16,%eax
 498:	cd 40                	int    $0x40
 49a:	c3                   	ret    

0000049b <printProcess>:
 49b:	b8 17 00 00 00       	mov    $0x17,%eax
 4a0:	cd 40                	int    $0x40
 4a2:	c3                   	ret    

000004a3 <changeProcessMHRRN>:
 4a3:	b8 18 00 00 00       	mov    $0x18,%eax
 4a8:	cd 40                	int    $0x40
 4aa:	c3                   	ret    

000004ab <changeSystemMHRRN>:
 4ab:	b8 19 00 00 00       	mov    $0x19,%eax
 4b0:	cd 40                	int    $0x40
 4b2:	c3                   	ret    

000004b3 <sem_acquire>:
 4b3:	b8 1a 00 00 00       	mov    $0x1a,%eax
 4b8:	cd 40                	int    $0x40
 4ba:	c3                   	ret    

000004bb <sem_release>:
 4bb:	b8 1b 00 00 00       	mov    $0x1b,%eax
 4c0:	cd 40                	int    $0x40
 4c2:	c3                   	ret    

000004c3 <sem_init>:
 4c3:	b8 1c 00 00 00       	mov    $0x1c,%eax
 4c8:	cd 40                	int    $0x40
 4ca:	c3                   	ret    
 4cb:	66 90                	xchg   %ax,%ax
 4cd:	66 90                	xchg   %ax,%ax
 4cf:	90                   	nop

000004d0 <printint>:
 4d0:	55                   	push   %ebp
 4d1:	89 e5                	mov    %esp,%ebp
 4d3:	57                   	push   %edi
 4d4:	56                   	push   %esi
 4d5:	53                   	push   %ebx
 4d6:	83 ec 3c             	sub    $0x3c,%esp
 4d9:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
 4dc:	89 d1                	mov    %edx,%ecx
 4de:	89 45 b8             	mov    %eax,-0x48(%ebp)
 4e1:	85 d2                	test   %edx,%edx
 4e3:	0f 89 7f 00 00 00    	jns    568 <printint+0x98>
 4e9:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 4ed:	74 79                	je     568 <printint+0x98>
 4ef:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
 4f6:	f7 d9                	neg    %ecx
 4f8:	31 db                	xor    %ebx,%ebx
 4fa:	8d 75 d7             	lea    -0x29(%ebp),%esi
 4fd:	8d 76 00             	lea    0x0(%esi),%esi
 500:	89 c8                	mov    %ecx,%eax
 502:	31 d2                	xor    %edx,%edx
 504:	89 cf                	mov    %ecx,%edi
 506:	f7 75 c4             	divl   -0x3c(%ebp)
 509:	0f b6 92 70 09 00 00 	movzbl 0x970(%edx),%edx
 510:	89 45 c0             	mov    %eax,-0x40(%ebp)
 513:	89 d8                	mov    %ebx,%eax
 515:	8d 5b 01             	lea    0x1(%ebx),%ebx
 518:	8b 4d c0             	mov    -0x40(%ebp),%ecx
 51b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
 51e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 521:	76 dd                	jbe    500 <printint+0x30>
 523:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 526:	85 c9                	test   %ecx,%ecx
 528:	74 0c                	je     536 <printint+0x66>
 52a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 52f:	89 d8                	mov    %ebx,%eax
 531:	ba 2d 00 00 00       	mov    $0x2d,%edx
 536:	8b 7d b8             	mov    -0x48(%ebp),%edi
 539:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 53d:	eb 07                	jmp    546 <printint+0x76>
 53f:	90                   	nop
 540:	0f b6 13             	movzbl (%ebx),%edx
 543:	83 eb 01             	sub    $0x1,%ebx
 546:	83 ec 04             	sub    $0x4,%esp
 549:	88 55 d7             	mov    %dl,-0x29(%ebp)
 54c:	6a 01                	push   $0x1
 54e:	56                   	push   %esi
 54f:	57                   	push   %edi
 550:	e8 be fe ff ff       	call   413 <write>
 555:	83 c4 10             	add    $0x10,%esp
 558:	39 de                	cmp    %ebx,%esi
 55a:	75 e4                	jne    540 <printint+0x70>
 55c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 55f:	5b                   	pop    %ebx
 560:	5e                   	pop    %esi
 561:	5f                   	pop    %edi
 562:	5d                   	pop    %ebp
 563:	c3                   	ret    
 564:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 568:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 56f:	eb 87                	jmp    4f8 <printint+0x28>
 571:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 578:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 57f:	90                   	nop

00000580 <printf>:
 580:	f3 0f 1e fb          	endbr32 
 584:	55                   	push   %ebp
 585:	89 e5                	mov    %esp,%ebp
 587:	57                   	push   %edi
 588:	56                   	push   %esi
 589:	53                   	push   %ebx
 58a:	83 ec 2c             	sub    $0x2c,%esp
 58d:	8b 75 0c             	mov    0xc(%ebp),%esi
 590:	0f b6 1e             	movzbl (%esi),%ebx
 593:	84 db                	test   %bl,%bl
 595:	0f 84 b4 00 00 00    	je     64f <printf+0xcf>
 59b:	8d 45 10             	lea    0x10(%ebp),%eax
 59e:	83 c6 01             	add    $0x1,%esi
 5a1:	8d 7d e7             	lea    -0x19(%ebp),%edi
 5a4:	31 d2                	xor    %edx,%edx
 5a6:	89 45 d0             	mov    %eax,-0x30(%ebp)
 5a9:	eb 33                	jmp    5de <printf+0x5e>
 5ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5af:	90                   	nop
 5b0:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 5b3:	ba 25 00 00 00       	mov    $0x25,%edx
 5b8:	83 f8 25             	cmp    $0x25,%eax
 5bb:	74 17                	je     5d4 <printf+0x54>
 5bd:	83 ec 04             	sub    $0x4,%esp
 5c0:	88 5d e7             	mov    %bl,-0x19(%ebp)
 5c3:	6a 01                	push   $0x1
 5c5:	57                   	push   %edi
 5c6:	ff 75 08             	pushl  0x8(%ebp)
 5c9:	e8 45 fe ff ff       	call   413 <write>
 5ce:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 5d1:	83 c4 10             	add    $0x10,%esp
 5d4:	0f b6 1e             	movzbl (%esi),%ebx
 5d7:	83 c6 01             	add    $0x1,%esi
 5da:	84 db                	test   %bl,%bl
 5dc:	74 71                	je     64f <printf+0xcf>
 5de:	0f be cb             	movsbl %bl,%ecx
 5e1:	0f b6 c3             	movzbl %bl,%eax
 5e4:	85 d2                	test   %edx,%edx
 5e6:	74 c8                	je     5b0 <printf+0x30>
 5e8:	83 fa 25             	cmp    $0x25,%edx
 5eb:	75 e7                	jne    5d4 <printf+0x54>
 5ed:	83 f8 64             	cmp    $0x64,%eax
 5f0:	0f 84 9a 00 00 00    	je     690 <printf+0x110>
 5f6:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 5fc:	83 f9 70             	cmp    $0x70,%ecx
 5ff:	74 5f                	je     660 <printf+0xe0>
 601:	83 f8 73             	cmp    $0x73,%eax
 604:	0f 84 d6 00 00 00    	je     6e0 <printf+0x160>
 60a:	83 f8 63             	cmp    $0x63,%eax
 60d:	0f 84 8d 00 00 00    	je     6a0 <printf+0x120>
 613:	83 f8 25             	cmp    $0x25,%eax
 616:	0f 84 b4 00 00 00    	je     6d0 <printf+0x150>
 61c:	83 ec 04             	sub    $0x4,%esp
 61f:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 623:	6a 01                	push   $0x1
 625:	57                   	push   %edi
 626:	ff 75 08             	pushl  0x8(%ebp)
 629:	e8 e5 fd ff ff       	call   413 <write>
 62e:	88 5d e7             	mov    %bl,-0x19(%ebp)
 631:	83 c4 0c             	add    $0xc,%esp
 634:	6a 01                	push   $0x1
 636:	83 c6 01             	add    $0x1,%esi
 639:	57                   	push   %edi
 63a:	ff 75 08             	pushl  0x8(%ebp)
 63d:	e8 d1 fd ff ff       	call   413 <write>
 642:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 646:	83 c4 10             	add    $0x10,%esp
 649:	31 d2                	xor    %edx,%edx
 64b:	84 db                	test   %bl,%bl
 64d:	75 8f                	jne    5de <printf+0x5e>
 64f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 652:	5b                   	pop    %ebx
 653:	5e                   	pop    %esi
 654:	5f                   	pop    %edi
 655:	5d                   	pop    %ebp
 656:	c3                   	ret    
 657:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 65e:	66 90                	xchg   %ax,%ax
 660:	83 ec 0c             	sub    $0xc,%esp
 663:	b9 10 00 00 00       	mov    $0x10,%ecx
 668:	6a 00                	push   $0x0
 66a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 66d:	8b 45 08             	mov    0x8(%ebp),%eax
 670:	8b 13                	mov    (%ebx),%edx
 672:	e8 59 fe ff ff       	call   4d0 <printint>
 677:	89 d8                	mov    %ebx,%eax
 679:	83 c4 10             	add    $0x10,%esp
 67c:	31 d2                	xor    %edx,%edx
 67e:	83 c0 04             	add    $0x4,%eax
 681:	89 45 d0             	mov    %eax,-0x30(%ebp)
 684:	e9 4b ff ff ff       	jmp    5d4 <printf+0x54>
 689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 690:	83 ec 0c             	sub    $0xc,%esp
 693:	b9 0a 00 00 00       	mov    $0xa,%ecx
 698:	6a 01                	push   $0x1
 69a:	eb ce                	jmp    66a <printf+0xea>
 69c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6a0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 6a3:	83 ec 04             	sub    $0x4,%esp
 6a6:	8b 03                	mov    (%ebx),%eax
 6a8:	6a 01                	push   $0x1
 6aa:	83 c3 04             	add    $0x4,%ebx
 6ad:	57                   	push   %edi
 6ae:	ff 75 08             	pushl  0x8(%ebp)
 6b1:	88 45 e7             	mov    %al,-0x19(%ebp)
 6b4:	e8 5a fd ff ff       	call   413 <write>
 6b9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 6bc:	83 c4 10             	add    $0x10,%esp
 6bf:	31 d2                	xor    %edx,%edx
 6c1:	e9 0e ff ff ff       	jmp    5d4 <printf+0x54>
 6c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6cd:	8d 76 00             	lea    0x0(%esi),%esi
 6d0:	88 5d e7             	mov    %bl,-0x19(%ebp)
 6d3:	83 ec 04             	sub    $0x4,%esp
 6d6:	e9 59 ff ff ff       	jmp    634 <printf+0xb4>
 6db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6df:	90                   	nop
 6e0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 6e3:	8b 18                	mov    (%eax),%ebx
 6e5:	83 c0 04             	add    $0x4,%eax
 6e8:	89 45 d0             	mov    %eax,-0x30(%ebp)
 6eb:	85 db                	test   %ebx,%ebx
 6ed:	74 17                	je     706 <printf+0x186>
 6ef:	0f b6 03             	movzbl (%ebx),%eax
 6f2:	31 d2                	xor    %edx,%edx
 6f4:	84 c0                	test   %al,%al
 6f6:	0f 84 d8 fe ff ff    	je     5d4 <printf+0x54>
 6fc:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 6ff:	89 de                	mov    %ebx,%esi
 701:	8b 5d 08             	mov    0x8(%ebp),%ebx
 704:	eb 1a                	jmp    720 <printf+0x1a0>
 706:	bb 68 09 00 00       	mov    $0x968,%ebx
 70b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 70e:	b8 28 00 00 00       	mov    $0x28,%eax
 713:	89 de                	mov    %ebx,%esi
 715:	8b 5d 08             	mov    0x8(%ebp),%ebx
 718:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 71f:	90                   	nop
 720:	83 ec 04             	sub    $0x4,%esp
 723:	83 c6 01             	add    $0x1,%esi
 726:	88 45 e7             	mov    %al,-0x19(%ebp)
 729:	6a 01                	push   $0x1
 72b:	57                   	push   %edi
 72c:	53                   	push   %ebx
 72d:	e8 e1 fc ff ff       	call   413 <write>
 732:	0f b6 06             	movzbl (%esi),%eax
 735:	83 c4 10             	add    $0x10,%esp
 738:	84 c0                	test   %al,%al
 73a:	75 e4                	jne    720 <printf+0x1a0>
 73c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 73f:	31 d2                	xor    %edx,%edx
 741:	e9 8e fe ff ff       	jmp    5d4 <printf+0x54>
 746:	66 90                	xchg   %ax,%ax
 748:	66 90                	xchg   %ax,%ax
 74a:	66 90                	xchg   %ax,%ax
 74c:	66 90                	xchg   %ax,%ax
 74e:	66 90                	xchg   %ax,%ax

00000750 <free>:
 750:	f3 0f 1e fb          	endbr32 
 754:	55                   	push   %ebp
 755:	a1 40 0c 00 00       	mov    0xc40,%eax
 75a:	89 e5                	mov    %esp,%ebp
 75c:	57                   	push   %edi
 75d:	56                   	push   %esi
 75e:	53                   	push   %ebx
 75f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 762:	8b 10                	mov    (%eax),%edx
 764:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 767:	39 c8                	cmp    %ecx,%eax
 769:	73 15                	jae    780 <free+0x30>
 76b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 76f:	90                   	nop
 770:	39 d1                	cmp    %edx,%ecx
 772:	72 14                	jb     788 <free+0x38>
 774:	39 d0                	cmp    %edx,%eax
 776:	73 10                	jae    788 <free+0x38>
 778:	89 d0                	mov    %edx,%eax
 77a:	8b 10                	mov    (%eax),%edx
 77c:	39 c8                	cmp    %ecx,%eax
 77e:	72 f0                	jb     770 <free+0x20>
 780:	39 d0                	cmp    %edx,%eax
 782:	72 f4                	jb     778 <free+0x28>
 784:	39 d1                	cmp    %edx,%ecx
 786:	73 f0                	jae    778 <free+0x28>
 788:	8b 73 fc             	mov    -0x4(%ebx),%esi
 78b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 78e:	39 fa                	cmp    %edi,%edx
 790:	74 1e                	je     7b0 <free+0x60>
 792:	89 53 f8             	mov    %edx,-0x8(%ebx)
 795:	8b 50 04             	mov    0x4(%eax),%edx
 798:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 79b:	39 f1                	cmp    %esi,%ecx
 79d:	74 28                	je     7c7 <free+0x77>
 79f:	89 08                	mov    %ecx,(%eax)
 7a1:	5b                   	pop    %ebx
 7a2:	a3 40 0c 00 00       	mov    %eax,0xc40
 7a7:	5e                   	pop    %esi
 7a8:	5f                   	pop    %edi
 7a9:	5d                   	pop    %ebp
 7aa:	c3                   	ret    
 7ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 7af:	90                   	nop
 7b0:	03 72 04             	add    0x4(%edx),%esi
 7b3:	89 73 fc             	mov    %esi,-0x4(%ebx)
 7b6:	8b 10                	mov    (%eax),%edx
 7b8:	8b 12                	mov    (%edx),%edx
 7ba:	89 53 f8             	mov    %edx,-0x8(%ebx)
 7bd:	8b 50 04             	mov    0x4(%eax),%edx
 7c0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7c3:	39 f1                	cmp    %esi,%ecx
 7c5:	75 d8                	jne    79f <free+0x4f>
 7c7:	03 53 fc             	add    -0x4(%ebx),%edx
 7ca:	a3 40 0c 00 00       	mov    %eax,0xc40
 7cf:	89 50 04             	mov    %edx,0x4(%eax)
 7d2:	8b 53 f8             	mov    -0x8(%ebx),%edx
 7d5:	89 10                	mov    %edx,(%eax)
 7d7:	5b                   	pop    %ebx
 7d8:	5e                   	pop    %esi
 7d9:	5f                   	pop    %edi
 7da:	5d                   	pop    %ebp
 7db:	c3                   	ret    
 7dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000007e0 <malloc>:
 7e0:	f3 0f 1e fb          	endbr32 
 7e4:	55                   	push   %ebp
 7e5:	89 e5                	mov    %esp,%ebp
 7e7:	57                   	push   %edi
 7e8:	56                   	push   %esi
 7e9:	53                   	push   %ebx
 7ea:	83 ec 1c             	sub    $0x1c,%esp
 7ed:	8b 45 08             	mov    0x8(%ebp),%eax
 7f0:	8b 3d 40 0c 00 00    	mov    0xc40,%edi
 7f6:	8d 70 07             	lea    0x7(%eax),%esi
 7f9:	c1 ee 03             	shr    $0x3,%esi
 7fc:	83 c6 01             	add    $0x1,%esi
 7ff:	85 ff                	test   %edi,%edi
 801:	0f 84 a9 00 00 00    	je     8b0 <malloc+0xd0>
 807:	8b 07                	mov    (%edi),%eax
 809:	8b 48 04             	mov    0x4(%eax),%ecx
 80c:	39 f1                	cmp    %esi,%ecx
 80e:	73 6d                	jae    87d <malloc+0x9d>
 810:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 816:	bb 00 10 00 00       	mov    $0x1000,%ebx
 81b:	0f 43 de             	cmovae %esi,%ebx
 81e:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 825:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 828:	eb 17                	jmp    841 <malloc+0x61>
 82a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 830:	8b 10                	mov    (%eax),%edx
 832:	8b 4a 04             	mov    0x4(%edx),%ecx
 835:	39 f1                	cmp    %esi,%ecx
 837:	73 4f                	jae    888 <malloc+0xa8>
 839:	8b 3d 40 0c 00 00    	mov    0xc40,%edi
 83f:	89 d0                	mov    %edx,%eax
 841:	39 c7                	cmp    %eax,%edi
 843:	75 eb                	jne    830 <malloc+0x50>
 845:	83 ec 0c             	sub    $0xc,%esp
 848:	ff 75 e4             	pushl  -0x1c(%ebp)
 84b:	e8 2b fc ff ff       	call   47b <sbrk>
 850:	83 c4 10             	add    $0x10,%esp
 853:	83 f8 ff             	cmp    $0xffffffff,%eax
 856:	74 1b                	je     873 <malloc+0x93>
 858:	89 58 04             	mov    %ebx,0x4(%eax)
 85b:	83 ec 0c             	sub    $0xc,%esp
 85e:	83 c0 08             	add    $0x8,%eax
 861:	50                   	push   %eax
 862:	e8 e9 fe ff ff       	call   750 <free>
 867:	a1 40 0c 00 00       	mov    0xc40,%eax
 86c:	83 c4 10             	add    $0x10,%esp
 86f:	85 c0                	test   %eax,%eax
 871:	75 bd                	jne    830 <malloc+0x50>
 873:	8d 65 f4             	lea    -0xc(%ebp),%esp
 876:	31 c0                	xor    %eax,%eax
 878:	5b                   	pop    %ebx
 879:	5e                   	pop    %esi
 87a:	5f                   	pop    %edi
 87b:	5d                   	pop    %ebp
 87c:	c3                   	ret    
 87d:	89 c2                	mov    %eax,%edx
 87f:	89 f8                	mov    %edi,%eax
 881:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 888:	39 ce                	cmp    %ecx,%esi
 88a:	74 54                	je     8e0 <malloc+0x100>
 88c:	29 f1                	sub    %esi,%ecx
 88e:	89 4a 04             	mov    %ecx,0x4(%edx)
 891:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
 894:	89 72 04             	mov    %esi,0x4(%edx)
 897:	a3 40 0c 00 00       	mov    %eax,0xc40
 89c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 89f:	8d 42 08             	lea    0x8(%edx),%eax
 8a2:	5b                   	pop    %ebx
 8a3:	5e                   	pop    %esi
 8a4:	5f                   	pop    %edi
 8a5:	5d                   	pop    %ebp
 8a6:	c3                   	ret    
 8a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 8ae:	66 90                	xchg   %ax,%ax
 8b0:	c7 05 40 0c 00 00 44 	movl   $0xc44,0xc40
 8b7:	0c 00 00 
 8ba:	bf 44 0c 00 00       	mov    $0xc44,%edi
 8bf:	c7 05 44 0c 00 00 44 	movl   $0xc44,0xc44
 8c6:	0c 00 00 
 8c9:	89 f8                	mov    %edi,%eax
 8cb:	c7 05 48 0c 00 00 00 	movl   $0x0,0xc48
 8d2:	00 00 00 
 8d5:	e9 36 ff ff ff       	jmp    810 <malloc+0x30>
 8da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 8e0:	8b 0a                	mov    (%edx),%ecx
 8e2:	89 08                	mov    %ecx,(%eax)
 8e4:	eb b1                	jmp    897 <malloc+0xb7>
