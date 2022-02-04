
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:
8010000c:	0f 20 e0             	mov    %cr4,%eax
8010000f:	83 c8 10             	or     $0x10,%eax
80100012:	0f 22 e0             	mov    %eax,%cr4
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
8010001a:	0f 22 d8             	mov    %eax,%cr3
8010001d:	0f 20 c0             	mov    %cr0,%eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
80100025:	0f 22 c0             	mov    %eax,%cr0
80100028:	bc e0 b5 10 80       	mov    $0x8010b5e0,%esp
8010002d:	b8 f0 33 10 80       	mov    $0x801033f0,%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
80100040:	f3 0f 1e fb          	endbr32 
80100044:	55                   	push   %ebp
80100045:	89 e5                	mov    %esp,%ebp
80100047:	53                   	push   %ebx
80100048:	bb 14 b6 10 80       	mov    $0x8010b614,%ebx
8010004d:	83 ec 0c             	sub    $0xc,%esp
80100050:	68 a0 74 10 80       	push   $0x801074a0
80100055:	68 e0 b5 10 80       	push   $0x8010b5e0
8010005a:	e8 31 47 00 00       	call   80104790 <initlock>
8010005f:	83 c4 10             	add    $0x10,%esp
80100062:	b8 dc fc 10 80       	mov    $0x8010fcdc,%eax
80100067:	c7 05 2c fd 10 80 dc 	movl   $0x8010fcdc,0x8010fd2c
8010006e:	fc 10 80 
80100071:	c7 05 30 fd 10 80 dc 	movl   $0x8010fcdc,0x8010fd30
80100078:	fc 10 80 
8010007b:	eb 05                	jmp    80100082 <binit+0x42>
8010007d:	8d 76 00             	lea    0x0(%esi),%esi
80100080:	89 d3                	mov    %edx,%ebx
80100082:	89 43 54             	mov    %eax,0x54(%ebx)
80100085:	83 ec 08             	sub    $0x8,%esp
80100088:	8d 43 0c             	lea    0xc(%ebx),%eax
8010008b:	c7 43 50 dc fc 10 80 	movl   $0x8010fcdc,0x50(%ebx)
80100092:	68 a7 74 10 80       	push   $0x801074a7
80100097:	50                   	push   %eax
80100098:	e8 b3 45 00 00       	call   80104650 <initsleeplock>
8010009d:	a1 30 fd 10 80       	mov    0x8010fd30,%eax
801000a2:	8d 93 5c 02 00 00    	lea    0x25c(%ebx),%edx
801000a8:	83 c4 10             	add    $0x10,%esp
801000ab:	89 58 50             	mov    %ebx,0x50(%eax)
801000ae:	89 d8                	mov    %ebx,%eax
801000b0:	89 1d 30 fd 10 80    	mov    %ebx,0x8010fd30
801000b6:	81 fb 80 fa 10 80    	cmp    $0x8010fa80,%ebx
801000bc:	75 c2                	jne    80100080 <binit+0x40>
801000be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c1:	c9                   	leave  
801000c2:	c3                   	ret    
801000c3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801000d0 <bread>:
801000d0:	f3 0f 1e fb          	endbr32 
801000d4:	55                   	push   %ebp
801000d5:	89 e5                	mov    %esp,%ebp
801000d7:	57                   	push   %edi
801000d8:	56                   	push   %esi
801000d9:	53                   	push   %ebx
801000da:	83 ec 18             	sub    $0x18,%esp
801000dd:	8b 7d 08             	mov    0x8(%ebp),%edi
801000e0:	8b 75 0c             	mov    0xc(%ebp),%esi
801000e3:	68 e0 b5 10 80       	push   $0x8010b5e0
801000e8:	e8 23 48 00 00       	call   80104910 <acquire>
801000ed:	8b 1d 30 fd 10 80    	mov    0x8010fd30,%ebx
801000f3:	83 c4 10             	add    $0x10,%esp
801000f6:	81 fb dc fc 10 80    	cmp    $0x8010fcdc,%ebx
801000fc:	75 0d                	jne    8010010b <bread+0x3b>
801000fe:	eb 20                	jmp    80100120 <bread+0x50>
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb dc fc 10 80    	cmp    $0x8010fcdc,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
8010010b:	3b 7b 04             	cmp    0x4(%ebx),%edi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 73 08             	cmp    0x8(%ebx),%esi
80100113:	75 eb                	jne    80100100 <bread+0x30>
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010011f:	90                   	nop
80100120:	8b 1d 2c fd 10 80    	mov    0x8010fd2c,%ebx
80100126:	81 fb dc fc 10 80    	cmp    $0x8010fcdc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 70                	jmp    801001a0 <bread+0xd0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb dc fc 10 80    	cmp    $0x8010fcdc,%ebx
80100139:	74 65                	je     801001a0 <bread+0xd0>
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
80100147:	89 7b 04             	mov    %edi,0x4(%ebx)
8010014a:	89 73 08             	mov    %esi,0x8(%ebx)
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 e0 b5 10 80       	push   $0x8010b5e0
80100162:	e8 69 48 00 00       	call   801049d0 <release>
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 1e 45 00 00       	call   80104690 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	74 0e                	je     80100188 <bread+0xb8>
8010017a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010017d:	89 d8                	mov    %ebx,%eax
8010017f:	5b                   	pop    %ebx
80100180:	5e                   	pop    %esi
80100181:	5f                   	pop    %edi
80100182:	5d                   	pop    %ebp
80100183:	c3                   	ret    
80100184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100188:	83 ec 0c             	sub    $0xc,%esp
8010018b:	53                   	push   %ebx
8010018c:	e8 9f 24 00 00       	call   80102630 <iderw>
80100191:	83 c4 10             	add    $0x10,%esp
80100194:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100197:	89 d8                	mov    %ebx,%eax
80100199:	5b                   	pop    %ebx
8010019a:	5e                   	pop    %esi
8010019b:	5f                   	pop    %edi
8010019c:	5d                   	pop    %ebp
8010019d:	c3                   	ret    
8010019e:	66 90                	xchg   %ax,%ax
801001a0:	83 ec 0c             	sub    $0xc,%esp
801001a3:	68 ae 74 10 80       	push   $0x801074ae
801001a8:	e8 e3 01 00 00       	call   80100390 <panic>
801001ad:	8d 76 00             	lea    0x0(%esi),%esi

801001b0 <bwrite>:
801001b0:	f3 0f 1e fb          	endbr32 
801001b4:	55                   	push   %ebp
801001b5:	89 e5                	mov    %esp,%ebp
801001b7:	53                   	push   %ebx
801001b8:	83 ec 10             	sub    $0x10,%esp
801001bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
801001be:	8d 43 0c             	lea    0xc(%ebx),%eax
801001c1:	50                   	push   %eax
801001c2:	e8 69 45 00 00       	call   80104730 <holdingsleep>
801001c7:	83 c4 10             	add    $0x10,%esp
801001ca:	85 c0                	test   %eax,%eax
801001cc:	74 0f                	je     801001dd <bwrite+0x2d>
801001ce:	83 0b 04             	orl    $0x4,(%ebx)
801001d1:	89 5d 08             	mov    %ebx,0x8(%ebp)
801001d4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001d7:	c9                   	leave  
801001d8:	e9 53 24 00 00       	jmp    80102630 <iderw>
801001dd:	83 ec 0c             	sub    $0xc,%esp
801001e0:	68 bf 74 10 80       	push   $0x801074bf
801001e5:	e8 a6 01 00 00       	call   80100390 <panic>
801001ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801001f0 <brelse>:
801001f0:	f3 0f 1e fb          	endbr32 
801001f4:	55                   	push   %ebp
801001f5:	89 e5                	mov    %esp,%ebp
801001f7:	56                   	push   %esi
801001f8:	53                   	push   %ebx
801001f9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801001fc:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ff:	83 ec 0c             	sub    $0xc,%esp
80100202:	56                   	push   %esi
80100203:	e8 28 45 00 00       	call   80104730 <holdingsleep>
80100208:	83 c4 10             	add    $0x10,%esp
8010020b:	85 c0                	test   %eax,%eax
8010020d:	74 66                	je     80100275 <brelse+0x85>
8010020f:	83 ec 0c             	sub    $0xc,%esp
80100212:	56                   	push   %esi
80100213:	e8 d8 44 00 00       	call   801046f0 <releasesleep>
80100218:	c7 04 24 e0 b5 10 80 	movl   $0x8010b5e0,(%esp)
8010021f:	e8 ec 46 00 00       	call   80104910 <acquire>
80100224:	8b 43 4c             	mov    0x4c(%ebx),%eax
80100227:	83 c4 10             	add    $0x10,%esp
8010022a:	83 e8 01             	sub    $0x1,%eax
8010022d:	89 43 4c             	mov    %eax,0x4c(%ebx)
80100230:	85 c0                	test   %eax,%eax
80100232:	75 2f                	jne    80100263 <brelse+0x73>
80100234:	8b 43 54             	mov    0x54(%ebx),%eax
80100237:	8b 53 50             	mov    0x50(%ebx),%edx
8010023a:	89 50 50             	mov    %edx,0x50(%eax)
8010023d:	8b 43 50             	mov    0x50(%ebx),%eax
80100240:	8b 53 54             	mov    0x54(%ebx),%edx
80100243:	89 50 54             	mov    %edx,0x54(%eax)
80100246:	a1 30 fd 10 80       	mov    0x8010fd30,%eax
8010024b:	c7 43 50 dc fc 10 80 	movl   $0x8010fcdc,0x50(%ebx)
80100252:	89 43 54             	mov    %eax,0x54(%ebx)
80100255:	a1 30 fd 10 80       	mov    0x8010fd30,%eax
8010025a:	89 58 50             	mov    %ebx,0x50(%eax)
8010025d:	89 1d 30 fd 10 80    	mov    %ebx,0x8010fd30
80100263:	c7 45 08 e0 b5 10 80 	movl   $0x8010b5e0,0x8(%ebp)
8010026a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010026d:	5b                   	pop    %ebx
8010026e:	5e                   	pop    %esi
8010026f:	5d                   	pop    %ebp
80100270:	e9 5b 47 00 00       	jmp    801049d0 <release>
80100275:	83 ec 0c             	sub    $0xc,%esp
80100278:	68 c6 74 10 80       	push   $0x801074c6
8010027d:	e8 0e 01 00 00       	call   80100390 <panic>
80100282:	66 90                	xchg   %ax,%ax
80100284:	66 90                	xchg   %ax,%ax
80100286:	66 90                	xchg   %ax,%ax
80100288:	66 90                	xchg   %ax,%ax
8010028a:	66 90                	xchg   %ax,%ax
8010028c:	66 90                	xchg   %ax,%ax
8010028e:	66 90                	xchg   %ax,%ax

80100290 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100290:	f3 0f 1e fb          	endbr32 
80100294:	55                   	push   %ebp
80100295:	89 e5                	mov    %esp,%ebp
80100297:	57                   	push   %edi
80100298:	56                   	push   %esi
80100299:	53                   	push   %ebx
8010029a:	83 ec 18             	sub    $0x18,%esp
  uint target;
  int c;

  iunlock(ip);
8010029d:	ff 75 08             	pushl  0x8(%ebp)
{
801002a0:	8b 5d 10             	mov    0x10(%ebp),%ebx
  target = n;
801002a3:	89 de                	mov    %ebx,%esi
  iunlock(ip);
801002a5:	e8 46 19 00 00       	call   80101bf0 <iunlock>
  acquire(&cons.lock);
801002aa:	c7 04 24 40 a5 10 80 	movl   $0x8010a540,(%esp)
801002b1:	e8 5a 46 00 00       	call   80104910 <acquire>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
801002b6:	8b 7d 0c             	mov    0xc(%ebp),%edi
  while(n > 0){
801002b9:	83 c4 10             	add    $0x10,%esp
    *dst++ = c;
801002bc:	01 df                	add    %ebx,%edi
  while(n > 0){
801002be:	85 db                	test   %ebx,%ebx
801002c0:	0f 8e 97 00 00 00    	jle    8010035d <consoleread+0xcd>
    while(input.r == input.w){
801002c6:	a1 c0 ff 10 80       	mov    0x8010ffc0,%eax
801002cb:	3b 05 c4 ff 10 80    	cmp    0x8010ffc4,%eax
801002d1:	74 27                	je     801002fa <consoleread+0x6a>
801002d3:	eb 5b                	jmp    80100330 <consoleread+0xa0>
801002d5:	8d 76 00             	lea    0x0(%esi),%esi
      sleep(&input.r, &cons.lock);
801002d8:	83 ec 08             	sub    $0x8,%esp
801002db:	68 40 a5 10 80       	push   $0x8010a540
801002e0:	68 c0 ff 10 80       	push   $0x8010ffc0
801002e5:	e8 e6 3f 00 00       	call   801042d0 <sleep>
    while(input.r == input.w){
801002ea:	a1 c0 ff 10 80       	mov    0x8010ffc0,%eax
801002ef:	83 c4 10             	add    $0x10,%esp
801002f2:	3b 05 c4 ff 10 80    	cmp    0x8010ffc4,%eax
801002f8:	75 36                	jne    80100330 <consoleread+0xa0>
      if(myproc()->killed){
801002fa:	e8 11 3a 00 00       	call   80103d10 <myproc>
801002ff:	8b 48 24             	mov    0x24(%eax),%ecx
80100302:	85 c9                	test   %ecx,%ecx
80100304:	74 d2                	je     801002d8 <consoleread+0x48>
        release(&cons.lock);
80100306:	83 ec 0c             	sub    $0xc,%esp
80100309:	68 40 a5 10 80       	push   $0x8010a540
8010030e:	e8 bd 46 00 00       	call   801049d0 <release>
        ilock(ip);
80100313:	5a                   	pop    %edx
80100314:	ff 75 08             	pushl  0x8(%ebp)
80100317:	e8 f4 17 00 00       	call   80101b10 <ilock>
        return -1;
8010031c:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
8010031f:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
80100322:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100327:	5b                   	pop    %ebx
80100328:	5e                   	pop    %esi
80100329:	5f                   	pop    %edi
8010032a:	5d                   	pop    %ebp
8010032b:	c3                   	ret    
8010032c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100330:	8d 50 01             	lea    0x1(%eax),%edx
80100333:	89 15 c0 ff 10 80    	mov    %edx,0x8010ffc0
80100339:	89 c2                	mov    %eax,%edx
8010033b:	83 e2 7f             	and    $0x7f,%edx
8010033e:	0f be 8a 40 ff 10 80 	movsbl -0x7fef00c0(%edx),%ecx
    if(c == C('D')){  // EOF
80100345:	80 f9 04             	cmp    $0x4,%cl
80100348:	74 38                	je     80100382 <consoleread+0xf2>
    *dst++ = c;
8010034a:	89 d8                	mov    %ebx,%eax
    --n;
8010034c:	83 eb 01             	sub    $0x1,%ebx
    *dst++ = c;
8010034f:	f7 d8                	neg    %eax
80100351:	88 0c 07             	mov    %cl,(%edi,%eax,1)
    if(c == '\n')
80100354:	83 f9 0a             	cmp    $0xa,%ecx
80100357:	0f 85 61 ff ff ff    	jne    801002be <consoleread+0x2e>
  release(&cons.lock);
8010035d:	83 ec 0c             	sub    $0xc,%esp
80100360:	68 40 a5 10 80       	push   $0x8010a540
80100365:	e8 66 46 00 00       	call   801049d0 <release>
  ilock(ip);
8010036a:	58                   	pop    %eax
8010036b:	ff 75 08             	pushl  0x8(%ebp)
8010036e:	e8 9d 17 00 00       	call   80101b10 <ilock>
  return target - n;
80100373:	89 f0                	mov    %esi,%eax
80100375:	83 c4 10             	add    $0x10,%esp
}
80100378:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return target - n;
8010037b:	29 d8                	sub    %ebx,%eax
}
8010037d:	5b                   	pop    %ebx
8010037e:	5e                   	pop    %esi
8010037f:	5f                   	pop    %edi
80100380:	5d                   	pop    %ebp
80100381:	c3                   	ret    
      if(n < target){
80100382:	39 f3                	cmp    %esi,%ebx
80100384:	73 d7                	jae    8010035d <consoleread+0xcd>
        input.r--;
80100386:	a3 c0 ff 10 80       	mov    %eax,0x8010ffc0
8010038b:	eb d0                	jmp    8010035d <consoleread+0xcd>
8010038d:	8d 76 00             	lea    0x0(%esi),%esi

80100390 <panic>:
{
80100390:	f3 0f 1e fb          	endbr32 
80100394:	55                   	push   %ebp
80100395:	89 e5                	mov    %esp,%ebp
80100397:	56                   	push   %esi
80100398:	53                   	push   %ebx
80100399:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
8010039c:	fa                   	cli    
  cons.locking = 0;
8010039d:	c7 05 74 a5 10 80 00 	movl   $0x0,0x8010a574
801003a4:	00 00 00 
  getcallerpcs(&s, pcs);
801003a7:	8d 5d d0             	lea    -0x30(%ebp),%ebx
801003aa:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
801003ad:	e8 9e 28 00 00       	call   80102c50 <lapicid>
801003b2:	83 ec 08             	sub    $0x8,%esp
801003b5:	50                   	push   %eax
801003b6:	68 cd 74 10 80       	push   $0x801074cd
801003bb:	e8 f0 02 00 00       	call   801006b0 <cprintf>
  cprintf(s);
801003c0:	58                   	pop    %eax
801003c1:	ff 75 08             	pushl  0x8(%ebp)
801003c4:	e8 e7 02 00 00       	call   801006b0 <cprintf>
  cprintf("\n");
801003c9:	c7 04 24 57 7e 10 80 	movl   $0x80107e57,(%esp)
801003d0:	e8 db 02 00 00       	call   801006b0 <cprintf>
  getcallerpcs(&s, pcs);
801003d5:	8d 45 08             	lea    0x8(%ebp),%eax
801003d8:	5a                   	pop    %edx
801003d9:	59                   	pop    %ecx
801003da:	53                   	push   %ebx
801003db:	50                   	push   %eax
801003dc:	e8 cf 43 00 00       	call   801047b0 <getcallerpcs>
  for(i=0; i<10; i++)
801003e1:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003e4:	83 ec 08             	sub    $0x8,%esp
801003e7:	ff 33                	pushl  (%ebx)
801003e9:	83 c3 04             	add    $0x4,%ebx
801003ec:	68 e1 74 10 80       	push   $0x801074e1
801003f1:	e8 ba 02 00 00       	call   801006b0 <cprintf>
  for(i=0; i<10; i++)
801003f6:	83 c4 10             	add    $0x10,%esp
801003f9:	39 f3                	cmp    %esi,%ebx
801003fb:	75 e7                	jne    801003e4 <panic+0x54>
  panicked = 1; // freeze other CPU
801003fd:	c7 05 78 a5 10 80 01 	movl   $0x1,0x8010a578
80100404:	00 00 00 
  for(;;)
80100407:	eb fe                	jmp    80100407 <panic+0x77>
80100409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100410 <consputc.part.0>:
consputc(int c)
80100410:	55                   	push   %ebp
80100411:	89 e5                	mov    %esp,%ebp
80100413:	57                   	push   %edi
80100414:	56                   	push   %esi
80100415:	53                   	push   %ebx
80100416:	89 c3                	mov    %eax,%ebx
80100418:	83 ec 1c             	sub    $0x1c,%esp
  if(c == BACKSPACE){
8010041b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100420:	0f 84 ea 00 00 00    	je     80100510 <consputc.part.0+0x100>
    uartputc(c);
80100426:	83 ec 0c             	sub    $0xc,%esp
80100429:	50                   	push   %eax
8010042a:	e8 61 5c 00 00       	call   80106090 <uartputc>
8010042f:	83 c4 10             	add    $0x10,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100432:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100437:	b8 0e 00 00 00       	mov    $0xe,%eax
8010043c:	89 fa                	mov    %edi,%edx
8010043e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010043f:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100444:	89 ca                	mov    %ecx,%edx
80100446:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100447:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010044a:	89 fa                	mov    %edi,%edx
8010044c:	c1 e0 08             	shl    $0x8,%eax
8010044f:	89 c6                	mov    %eax,%esi
80100451:	b8 0f 00 00 00       	mov    $0xf,%eax
80100456:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100457:	89 ca                	mov    %ecx,%edx
80100459:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
8010045a:	0f b6 c0             	movzbl %al,%eax
8010045d:	09 f0                	or     %esi,%eax
  if(c == '\n')
8010045f:	83 fb 0a             	cmp    $0xa,%ebx
80100462:	0f 84 90 00 00 00    	je     801004f8 <consputc.part.0+0xe8>
  else if(c == BACKSPACE){
80100468:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
8010046e:	74 70                	je     801004e0 <consputc.part.0+0xd0>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100470:	0f b6 db             	movzbl %bl,%ebx
80100473:	8d 70 01             	lea    0x1(%eax),%esi
80100476:	80 cf 07             	or     $0x7,%bh
80100479:	66 89 9c 00 00 80 0b 	mov    %bx,-0x7ff48000(%eax,%eax,1)
80100480:	80 
  if(pos < 0 || pos > 25*80)
80100481:	81 fe d0 07 00 00    	cmp    $0x7d0,%esi
80100487:	0f 8f f9 00 00 00    	jg     80100586 <consputc.part.0+0x176>
  if((pos/80) >= 24){  // Scroll up.
8010048d:	81 fe 7f 07 00 00    	cmp    $0x77f,%esi
80100493:	0f 8f a7 00 00 00    	jg     80100540 <consputc.part.0+0x130>
80100499:	89 f0                	mov    %esi,%eax
8010049b:	8d b4 36 00 80 0b 80 	lea    -0x7ff48000(%esi,%esi,1),%esi
801004a2:	88 45 e7             	mov    %al,-0x19(%ebp)
801004a5:	0f b6 fc             	movzbl %ah,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801004a8:	bb d4 03 00 00       	mov    $0x3d4,%ebx
801004ad:	b8 0e 00 00 00       	mov    $0xe,%eax
801004b2:	89 da                	mov    %ebx,%edx
801004b4:	ee                   	out    %al,(%dx)
801004b5:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
801004ba:	89 f8                	mov    %edi,%eax
801004bc:	89 ca                	mov    %ecx,%edx
801004be:	ee                   	out    %al,(%dx)
801004bf:	b8 0f 00 00 00       	mov    $0xf,%eax
801004c4:	89 da                	mov    %ebx,%edx
801004c6:	ee                   	out    %al,(%dx)
801004c7:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
801004cb:	89 ca                	mov    %ecx,%edx
801004cd:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004ce:	b8 20 07 00 00       	mov    $0x720,%eax
801004d3:	66 89 06             	mov    %ax,(%esi)
}
801004d6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004d9:	5b                   	pop    %ebx
801004da:	5e                   	pop    %esi
801004db:	5f                   	pop    %edi
801004dc:	5d                   	pop    %ebp
801004dd:	c3                   	ret    
801004de:	66 90                	xchg   %ax,%ax
    if(pos > 0) --pos;
801004e0:	8d 70 ff             	lea    -0x1(%eax),%esi
801004e3:	85 c0                	test   %eax,%eax
801004e5:	75 9a                	jne    80100481 <consputc.part.0+0x71>
801004e7:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
801004eb:	be 00 80 0b 80       	mov    $0x800b8000,%esi
801004f0:	31 ff                	xor    %edi,%edi
801004f2:	eb b4                	jmp    801004a8 <consputc.part.0+0x98>
801004f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pos += 80 - pos%80;
801004f8:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
801004fd:	f7 e2                	mul    %edx
801004ff:	c1 ea 06             	shr    $0x6,%edx
80100502:	8d 04 92             	lea    (%edx,%edx,4),%eax
80100505:	c1 e0 04             	shl    $0x4,%eax
80100508:	8d 70 50             	lea    0x50(%eax),%esi
8010050b:	e9 71 ff ff ff       	jmp    80100481 <consputc.part.0+0x71>
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100510:	83 ec 0c             	sub    $0xc,%esp
80100513:	6a 08                	push   $0x8
80100515:	e8 76 5b 00 00       	call   80106090 <uartputc>
8010051a:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100521:	e8 6a 5b 00 00       	call   80106090 <uartputc>
80100526:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010052d:	e8 5e 5b 00 00       	call   80106090 <uartputc>
80100532:	83 c4 10             	add    $0x10,%esp
80100535:	e9 f8 fe ff ff       	jmp    80100432 <consputc.part.0+0x22>
8010053a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100540:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
80100543:	8d 5e b0             	lea    -0x50(%esi),%ebx
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100546:	8d b4 36 60 7f 0b 80 	lea    -0x7ff480a0(%esi,%esi,1),%esi
8010054d:	bf 07 00 00 00       	mov    $0x7,%edi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100552:	68 60 0e 00 00       	push   $0xe60
80100557:	68 a0 80 0b 80       	push   $0x800b80a0
8010055c:	68 00 80 0b 80       	push   $0x800b8000
80100561:	e8 5a 45 00 00       	call   80104ac0 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100566:	b8 80 07 00 00       	mov    $0x780,%eax
8010056b:	83 c4 0c             	add    $0xc,%esp
8010056e:	29 d8                	sub    %ebx,%eax
80100570:	01 c0                	add    %eax,%eax
80100572:	50                   	push   %eax
80100573:	6a 00                	push   $0x0
80100575:	56                   	push   %esi
80100576:	e8 a5 44 00 00       	call   80104a20 <memset>
8010057b:	88 5d e7             	mov    %bl,-0x19(%ebp)
8010057e:	83 c4 10             	add    $0x10,%esp
80100581:	e9 22 ff ff ff       	jmp    801004a8 <consputc.part.0+0x98>
    panic("pos under/overflow");
80100586:	83 ec 0c             	sub    $0xc,%esp
80100589:	68 e5 74 10 80       	push   $0x801074e5
8010058e:	e8 fd fd ff ff       	call   80100390 <panic>
80100593:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010059a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801005a0 <printint>:
{
801005a0:	55                   	push   %ebp
801005a1:	89 e5                	mov    %esp,%ebp
801005a3:	57                   	push   %edi
801005a4:	56                   	push   %esi
801005a5:	53                   	push   %ebx
801005a6:	83 ec 2c             	sub    $0x2c,%esp
801005a9:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  if(sign && (sign = xx < 0))
801005ac:	85 c9                	test   %ecx,%ecx
801005ae:	74 04                	je     801005b4 <printint+0x14>
801005b0:	85 c0                	test   %eax,%eax
801005b2:	78 6d                	js     80100621 <printint+0x81>
    x = xx;
801005b4:	89 c1                	mov    %eax,%ecx
801005b6:	31 f6                	xor    %esi,%esi
  i = 0;
801005b8:	89 75 cc             	mov    %esi,-0x34(%ebp)
801005bb:	31 db                	xor    %ebx,%ebx
801005bd:	8d 7d d7             	lea    -0x29(%ebp),%edi
    buf[i++] = digits[x % base];
801005c0:	89 c8                	mov    %ecx,%eax
801005c2:	31 d2                	xor    %edx,%edx
801005c4:	89 ce                	mov    %ecx,%esi
801005c6:	f7 75 d4             	divl   -0x2c(%ebp)
801005c9:	0f b6 92 68 75 10 80 	movzbl -0x7fef8a98(%edx),%edx
801005d0:	89 45 d0             	mov    %eax,-0x30(%ebp)
801005d3:	89 d8                	mov    %ebx,%eax
801005d5:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
801005d8:	8b 4d d0             	mov    -0x30(%ebp),%ecx
801005db:	89 75 d0             	mov    %esi,-0x30(%ebp)
    buf[i++] = digits[x % base];
801005de:	88 14 1f             	mov    %dl,(%edi,%ebx,1)
  }while((x /= base) != 0);
801005e1:	8b 75 d4             	mov    -0x2c(%ebp),%esi
801005e4:	39 75 d0             	cmp    %esi,-0x30(%ebp)
801005e7:	73 d7                	jae    801005c0 <printint+0x20>
801005e9:	8b 75 cc             	mov    -0x34(%ebp),%esi
  if(sign)
801005ec:	85 f6                	test   %esi,%esi
801005ee:	74 0c                	je     801005fc <printint+0x5c>
    buf[i++] = '-';
801005f0:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
801005f5:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
801005f7:	ba 2d 00 00 00       	mov    $0x2d,%edx
  while(--i >= 0)
801005fc:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
80100600:	0f be c2             	movsbl %dl,%eax
  if(panicked){
80100603:	8b 15 78 a5 10 80    	mov    0x8010a578,%edx
80100609:	85 d2                	test   %edx,%edx
8010060b:	74 03                	je     80100610 <printint+0x70>
  asm volatile("cli");
8010060d:	fa                   	cli    
    for(;;)
8010060e:	eb fe                	jmp    8010060e <printint+0x6e>
80100610:	e8 fb fd ff ff       	call   80100410 <consputc.part.0>
  while(--i >= 0)
80100615:	39 fb                	cmp    %edi,%ebx
80100617:	74 10                	je     80100629 <printint+0x89>
80100619:	0f be 03             	movsbl (%ebx),%eax
8010061c:	83 eb 01             	sub    $0x1,%ebx
8010061f:	eb e2                	jmp    80100603 <printint+0x63>
    x = -xx;
80100621:	f7 d8                	neg    %eax
80100623:	89 ce                	mov    %ecx,%esi
80100625:	89 c1                	mov    %eax,%ecx
80100627:	eb 8f                	jmp    801005b8 <printint+0x18>
}
80100629:	83 c4 2c             	add    $0x2c,%esp
8010062c:	5b                   	pop    %ebx
8010062d:	5e                   	pop    %esi
8010062e:	5f                   	pop    %edi
8010062f:	5d                   	pop    %ebp
80100630:	c3                   	ret    
80100631:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100638:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010063f:	90                   	nop

80100640 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100640:	f3 0f 1e fb          	endbr32 
80100644:	55                   	push   %ebp
80100645:	89 e5                	mov    %esp,%ebp
80100647:	57                   	push   %edi
80100648:	56                   	push   %esi
80100649:	53                   	push   %ebx
8010064a:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
8010064d:	ff 75 08             	pushl  0x8(%ebp)
{
80100650:	8b 5d 10             	mov    0x10(%ebp),%ebx
  iunlock(ip);
80100653:	e8 98 15 00 00       	call   80101bf0 <iunlock>
  acquire(&cons.lock);
80100658:	c7 04 24 40 a5 10 80 	movl   $0x8010a540,(%esp)
8010065f:	e8 ac 42 00 00       	call   80104910 <acquire>
  for(i = 0; i < n; i++)
80100664:	83 c4 10             	add    $0x10,%esp
80100667:	85 db                	test   %ebx,%ebx
80100669:	7e 24                	jle    8010068f <consolewrite+0x4f>
8010066b:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010066e:	8d 34 1f             	lea    (%edi,%ebx,1),%esi
  if(panicked){
80100671:	8b 15 78 a5 10 80    	mov    0x8010a578,%edx
80100677:	85 d2                	test   %edx,%edx
80100679:	74 05                	je     80100680 <consolewrite+0x40>
8010067b:	fa                   	cli    
    for(;;)
8010067c:	eb fe                	jmp    8010067c <consolewrite+0x3c>
8010067e:	66 90                	xchg   %ax,%ax
    consputc(buf[i] & 0xff);
80100680:	0f b6 07             	movzbl (%edi),%eax
80100683:	83 c7 01             	add    $0x1,%edi
80100686:	e8 85 fd ff ff       	call   80100410 <consputc.part.0>
  for(i = 0; i < n; i++)
8010068b:	39 fe                	cmp    %edi,%esi
8010068d:	75 e2                	jne    80100671 <consolewrite+0x31>
  release(&cons.lock);
8010068f:	83 ec 0c             	sub    $0xc,%esp
80100692:	68 40 a5 10 80       	push   $0x8010a540
80100697:	e8 34 43 00 00       	call   801049d0 <release>
  ilock(ip);
8010069c:	58                   	pop    %eax
8010069d:	ff 75 08             	pushl  0x8(%ebp)
801006a0:	e8 6b 14 00 00       	call   80101b10 <ilock>

  return n;
}
801006a5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801006a8:	89 d8                	mov    %ebx,%eax
801006aa:	5b                   	pop    %ebx
801006ab:	5e                   	pop    %esi
801006ac:	5f                   	pop    %edi
801006ad:	5d                   	pop    %ebp
801006ae:	c3                   	ret    
801006af:	90                   	nop

801006b0 <cprintf>:
{
801006b0:	f3 0f 1e fb          	endbr32 
801006b4:	55                   	push   %ebp
801006b5:	89 e5                	mov    %esp,%ebp
801006b7:	57                   	push   %edi
801006b8:	56                   	push   %esi
801006b9:	53                   	push   %ebx
801006ba:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
801006bd:	a1 74 a5 10 80       	mov    0x8010a574,%eax
801006c2:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(locking)
801006c5:	85 c0                	test   %eax,%eax
801006c7:	0f 85 e8 00 00 00    	jne    801007b5 <cprintf+0x105>
  if (fmt == 0)
801006cd:	8b 45 08             	mov    0x8(%ebp),%eax
801006d0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801006d3:	85 c0                	test   %eax,%eax
801006d5:	0f 84 5a 01 00 00    	je     80100835 <cprintf+0x185>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006db:	0f b6 00             	movzbl (%eax),%eax
801006de:	85 c0                	test   %eax,%eax
801006e0:	74 36                	je     80100718 <cprintf+0x68>
  argp = (uint*)(void*)(&fmt + 1);
801006e2:	8d 5d 0c             	lea    0xc(%ebp),%ebx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006e5:	31 f6                	xor    %esi,%esi
    if(c != '%'){
801006e7:	83 f8 25             	cmp    $0x25,%eax
801006ea:	74 44                	je     80100730 <cprintf+0x80>
  if(panicked){
801006ec:	8b 0d 78 a5 10 80    	mov    0x8010a578,%ecx
801006f2:	85 c9                	test   %ecx,%ecx
801006f4:	74 0f                	je     80100705 <cprintf+0x55>
801006f6:	fa                   	cli    
    for(;;)
801006f7:	eb fe                	jmp    801006f7 <cprintf+0x47>
801006f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100700:	b8 25 00 00 00       	mov    $0x25,%eax
80100705:	e8 06 fd ff ff       	call   80100410 <consputc.part.0>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010070a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010070d:	83 c6 01             	add    $0x1,%esi
80100710:	0f b6 04 30          	movzbl (%eax,%esi,1),%eax
80100714:	85 c0                	test   %eax,%eax
80100716:	75 cf                	jne    801006e7 <cprintf+0x37>
  if(locking)
80100718:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010071b:	85 c0                	test   %eax,%eax
8010071d:	0f 85 fd 00 00 00    	jne    80100820 <cprintf+0x170>
}
80100723:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100726:	5b                   	pop    %ebx
80100727:	5e                   	pop    %esi
80100728:	5f                   	pop    %edi
80100729:	5d                   	pop    %ebp
8010072a:	c3                   	ret    
8010072b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010072f:	90                   	nop
    c = fmt[++i] & 0xff;
80100730:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100733:	83 c6 01             	add    $0x1,%esi
80100736:	0f b6 3c 30          	movzbl (%eax,%esi,1),%edi
    if(c == 0)
8010073a:	85 ff                	test   %edi,%edi
8010073c:	74 da                	je     80100718 <cprintf+0x68>
    switch(c){
8010073e:	83 ff 70             	cmp    $0x70,%edi
80100741:	74 5a                	je     8010079d <cprintf+0xed>
80100743:	7f 2a                	jg     8010076f <cprintf+0xbf>
80100745:	83 ff 25             	cmp    $0x25,%edi
80100748:	0f 84 92 00 00 00    	je     801007e0 <cprintf+0x130>
8010074e:	83 ff 64             	cmp    $0x64,%edi
80100751:	0f 85 a1 00 00 00    	jne    801007f8 <cprintf+0x148>
      printint(*argp++, 10, 1);
80100757:	8b 03                	mov    (%ebx),%eax
80100759:	8d 7b 04             	lea    0x4(%ebx),%edi
8010075c:	b9 01 00 00 00       	mov    $0x1,%ecx
80100761:	ba 0a 00 00 00       	mov    $0xa,%edx
80100766:	89 fb                	mov    %edi,%ebx
80100768:	e8 33 fe ff ff       	call   801005a0 <printint>
      break;
8010076d:	eb 9b                	jmp    8010070a <cprintf+0x5a>
    switch(c){
8010076f:	83 ff 73             	cmp    $0x73,%edi
80100772:	75 24                	jne    80100798 <cprintf+0xe8>
      if((s = (char*)*argp++) == 0)
80100774:	8d 7b 04             	lea    0x4(%ebx),%edi
80100777:	8b 1b                	mov    (%ebx),%ebx
80100779:	85 db                	test   %ebx,%ebx
8010077b:	75 55                	jne    801007d2 <cprintf+0x122>
        s = "(null)";
8010077d:	bb f8 74 10 80       	mov    $0x801074f8,%ebx
      for(; *s; s++)
80100782:	b8 28 00 00 00       	mov    $0x28,%eax
  if(panicked){
80100787:	8b 15 78 a5 10 80    	mov    0x8010a578,%edx
8010078d:	85 d2                	test   %edx,%edx
8010078f:	74 39                	je     801007ca <cprintf+0x11a>
80100791:	fa                   	cli    
    for(;;)
80100792:	eb fe                	jmp    80100792 <cprintf+0xe2>
80100794:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
80100798:	83 ff 78             	cmp    $0x78,%edi
8010079b:	75 5b                	jne    801007f8 <cprintf+0x148>
      printint(*argp++, 16, 0);
8010079d:	8b 03                	mov    (%ebx),%eax
8010079f:	8d 7b 04             	lea    0x4(%ebx),%edi
801007a2:	31 c9                	xor    %ecx,%ecx
801007a4:	ba 10 00 00 00       	mov    $0x10,%edx
801007a9:	89 fb                	mov    %edi,%ebx
801007ab:	e8 f0 fd ff ff       	call   801005a0 <printint>
      break;
801007b0:	e9 55 ff ff ff       	jmp    8010070a <cprintf+0x5a>
    acquire(&cons.lock);
801007b5:	83 ec 0c             	sub    $0xc,%esp
801007b8:	68 40 a5 10 80       	push   $0x8010a540
801007bd:	e8 4e 41 00 00       	call   80104910 <acquire>
801007c2:	83 c4 10             	add    $0x10,%esp
801007c5:	e9 03 ff ff ff       	jmp    801006cd <cprintf+0x1d>
801007ca:	e8 41 fc ff ff       	call   80100410 <consputc.part.0>
      for(; *s; s++)
801007cf:	83 c3 01             	add    $0x1,%ebx
801007d2:	0f be 03             	movsbl (%ebx),%eax
801007d5:	84 c0                	test   %al,%al
801007d7:	75 ae                	jne    80100787 <cprintf+0xd7>
      if((s = (char*)*argp++) == 0)
801007d9:	89 fb                	mov    %edi,%ebx
801007db:	e9 2a ff ff ff       	jmp    8010070a <cprintf+0x5a>
  if(panicked){
801007e0:	8b 3d 78 a5 10 80    	mov    0x8010a578,%edi
801007e6:	85 ff                	test   %edi,%edi
801007e8:	0f 84 12 ff ff ff    	je     80100700 <cprintf+0x50>
801007ee:	fa                   	cli    
    for(;;)
801007ef:	eb fe                	jmp    801007ef <cprintf+0x13f>
801007f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(panicked){
801007f8:	8b 0d 78 a5 10 80    	mov    0x8010a578,%ecx
801007fe:	85 c9                	test   %ecx,%ecx
80100800:	74 06                	je     80100808 <cprintf+0x158>
80100802:	fa                   	cli    
    for(;;)
80100803:	eb fe                	jmp    80100803 <cprintf+0x153>
80100805:	8d 76 00             	lea    0x0(%esi),%esi
80100808:	b8 25 00 00 00       	mov    $0x25,%eax
8010080d:	e8 fe fb ff ff       	call   80100410 <consputc.part.0>
  if(panicked){
80100812:	8b 15 78 a5 10 80    	mov    0x8010a578,%edx
80100818:	85 d2                	test   %edx,%edx
8010081a:	74 2c                	je     80100848 <cprintf+0x198>
8010081c:	fa                   	cli    
    for(;;)
8010081d:	eb fe                	jmp    8010081d <cprintf+0x16d>
8010081f:	90                   	nop
    release(&cons.lock);
80100820:	83 ec 0c             	sub    $0xc,%esp
80100823:	68 40 a5 10 80       	push   $0x8010a540
80100828:	e8 a3 41 00 00       	call   801049d0 <release>
8010082d:	83 c4 10             	add    $0x10,%esp
}
80100830:	e9 ee fe ff ff       	jmp    80100723 <cprintf+0x73>
    panic("null fmt");
80100835:	83 ec 0c             	sub    $0xc,%esp
80100838:	68 ff 74 10 80       	push   $0x801074ff
8010083d:	e8 4e fb ff ff       	call   80100390 <panic>
80100842:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100848:	89 f8                	mov    %edi,%eax
8010084a:	e8 c1 fb ff ff       	call   80100410 <consputc.part.0>
8010084f:	e9 b6 fe ff ff       	jmp    8010070a <cprintf+0x5a>
80100854:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010085b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010085f:	90                   	nop

80100860 <vga_move_back_cursor>:
void vga_move_back_cursor(){
80100860:	f3 0f 1e fb          	endbr32 
80100864:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100865:	b8 0e 00 00 00       	mov    $0xe,%eax
8010086a:	89 e5                	mov    %esp,%ebp
8010086c:	57                   	push   %edi
8010086d:	56                   	push   %esi
8010086e:	be d4 03 00 00       	mov    $0x3d4,%esi
80100873:	53                   	push   %ebx
80100874:	89 f2                	mov    %esi,%edx
80100876:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100877:	bb d5 03 00 00       	mov    $0x3d5,%ebx
8010087c:	89 da                	mov    %ebx,%edx
8010087e:	ec                   	in     (%dx),%al
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010087f:	bf 0f 00 00 00       	mov    $0xf,%edi
  pos = inb(CRTPORT+1) << 8;
80100884:	0f b6 c8             	movzbl %al,%ecx
80100887:	89 f2                	mov    %esi,%edx
80100889:	c1 e1 08             	shl    $0x8,%ecx
8010088c:	89 f8                	mov    %edi,%eax
8010088e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010088f:	89 da                	mov    %ebx,%edx
80100891:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);    
80100892:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100895:	89 f2                	mov    %esi,%edx
80100897:	09 c1                	or     %eax,%ecx
80100899:	89 f8                	mov    %edi,%eax
  pos--;
8010089b:	83 e9 01             	sub    $0x1,%ecx
8010089e:	ee                   	out    %al,(%dx)
8010089f:	89 c8                	mov    %ecx,%eax
801008a1:	89 da                	mov    %ebx,%edx
801008a3:	ee                   	out    %al,(%dx)
801008a4:	b8 0e 00 00 00       	mov    $0xe,%eax
801008a9:	89 f2                	mov    %esi,%edx
801008ab:	ee                   	out    %al,(%dx)
  outb(CRTPORT+1, (unsigned char )((pos>>8)&0xFF));
801008ac:	89 c8                	mov    %ecx,%eax
801008ae:	89 da                	mov    %ebx,%edx
801008b0:	c1 f8 08             	sar    $0x8,%eax
801008b3:	ee                   	out    %al,(%dx)
}
801008b4:	5b                   	pop    %ebx
801008b5:	5e                   	pop    %esi
801008b6:	5f                   	pop    %edi
801008b7:	5d                   	pop    %ebp
801008b8:	c3                   	ret    
801008b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801008c0 <consoleintr>:
{
801008c0:	f3 0f 1e fb          	endbr32 
801008c4:	55                   	push   %ebp
801008c5:	89 e5                	mov    %esp,%ebp
801008c7:	57                   	push   %edi
801008c8:	56                   	push   %esi
801008c9:	53                   	push   %ebx
  int c, doprocdump = 0;
801008ca:	31 db                	xor    %ebx,%ebx
{
801008cc:	83 ec 68             	sub    $0x68,%esp
801008cf:	8b 45 08             	mov    0x8(%ebp),%eax
  acquire(&cons.lock);
801008d2:	68 40 a5 10 80       	push   $0x8010a540
{
801008d7:	89 45 9c             	mov    %eax,-0x64(%ebp)
  acquire(&cons.lock);
801008da:	e8 31 40 00 00       	call   80104910 <acquire>
  while((c = getc()) >= 0){
801008df:	83 c4 10             	add    $0x10,%esp
801008e2:	8b 45 9c             	mov    -0x64(%ebp),%eax
801008e5:	ff d0                	call   *%eax
801008e7:	89 c6                	mov    %eax,%esi
801008e9:	85 c0                	test   %eax,%eax
801008eb:	0f 88 ed 03 00 00    	js     80100cde <consoleintr+0x41e>
    switch(c){
801008f1:	83 fe 15             	cmp    $0x15,%esi
801008f4:	7f 5a                	jg     80100950 <consoleintr+0x90>
801008f6:	85 f6                	test   %esi,%esi
801008f8:	74 e8                	je     801008e2 <consoleintr+0x22>
801008fa:	83 fe 15             	cmp    $0x15,%esi
801008fd:	0f 87 b6 03 00 00    	ja     80100cb9 <consoleintr+0x3f9>
80100903:	3e ff 24 b5 10 75 10 	notrack jmp *-0x7fef8af0(,%esi,4)
8010090a:	80 
8010090b:	bb 01 00 00 00       	mov    $0x1,%ebx
80100910:	eb d0                	jmp    801008e2 <consoleintr+0x22>
80100912:	b8 00 01 00 00       	mov    $0x100,%eax
80100917:	e8 f4 fa ff ff       	call   80100410 <consputc.part.0>
      while(input.e != input.w &&
8010091c:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
80100921:	3b 05 c4 ff 10 80    	cmp    0x8010ffc4,%eax
80100927:	74 b9                	je     801008e2 <consoleintr+0x22>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100929:	83 e8 01             	sub    $0x1,%eax
8010092c:	89 c2                	mov    %eax,%edx
8010092e:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100931:	80 ba 40 ff 10 80 0a 	cmpb   $0xa,-0x7fef00c0(%edx)
80100938:	74 a8                	je     801008e2 <consoleintr+0x22>
  if(panicked){
8010093a:	8b 15 78 a5 10 80    	mov    0x8010a578,%edx
        input.e--;
80100940:	a3 c8 ff 10 80       	mov    %eax,0x8010ffc8
  if(panicked){
80100945:	85 d2                	test   %edx,%edx
80100947:	74 c9                	je     80100912 <consoleintr+0x52>
  asm volatile("cli");
80100949:	fa                   	cli    
    for(;;)
8010094a:	eb fe                	jmp    8010094a <consoleintr+0x8a>
8010094c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    switch(c){
80100950:	83 fe 7f             	cmp    $0x7f,%esi
80100953:	0f 84 d2 01 00 00    	je     80100b2b <consoleintr+0x26b>
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100959:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
8010095e:	89 c2                	mov    %eax,%edx
80100960:	2b 15 c0 ff 10 80    	sub    0x8010ffc0,%edx
80100966:	83 fa 7f             	cmp    $0x7f,%edx
80100969:	0f 87 73 ff ff ff    	ja     801008e2 <consoleintr+0x22>
        if(ctrlA_pressed) {
8010096f:	8b 15 cc ff 10 80    	mov    0x8010ffcc,%edx
80100975:	8d 78 01             	lea    0x1(%eax),%edi
80100978:	89 7d a0             	mov    %edi,-0x60(%ebp)
8010097b:	8d 4a 01             	lea    0x1(%edx),%ecx
8010097e:	89 4d a4             	mov    %ecx,-0x5c(%ebp)
80100981:	8b 0d 20 a5 10 80    	mov    0x8010a520,%ecx
80100987:	85 c9                	test   %ecx,%ecx
80100989:	0f 85 be 02 00 00    	jne    80100c4d <consoleintr+0x38d>
          input.buf[input.e++ % INPUT_BUF] = c;
8010098f:	89 3d c8 ff 10 80    	mov    %edi,0x8010ffc8
80100995:	8b 15 78 a5 10 80    	mov    0x8010a578,%edx
8010099b:	83 e0 7f             	and    $0x7f,%eax
          c = (c == '\r') ? '\n' : c;
8010099e:	83 fe 0d             	cmp    $0xd,%esi
801009a1:	0f 84 ec 03 00 00    	je     80100d93 <consoleintr+0x4d3>
          input.buf[input.e++ % INPUT_BUF] = c;
801009a7:	89 f1                	mov    %esi,%ecx
801009a9:	88 88 40 ff 10 80    	mov    %cl,-0x7fef00c0(%eax)
          input.pos++;
801009af:	8b 45 a4             	mov    -0x5c(%ebp),%eax
801009b2:	a3 cc ff 10 80       	mov    %eax,0x8010ffcc
  if(panicked){
801009b7:	85 d2                	test   %edx,%edx
801009b9:	0f 85 1c 04 00 00    	jne    80100ddb <consoleintr+0x51b>
801009bf:	89 f0                	mov    %esi,%eax
801009c1:	e8 4a fa ff ff       	call   80100410 <consputc.part.0>
          if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801009c6:	83 fe 0a             	cmp    $0xa,%esi
801009c9:	0f 84 e1 03 00 00    	je     80100db0 <consoleintr+0x4f0>
801009cf:	83 fe 04             	cmp    $0x4,%esi
801009d2:	0f 84 d8 03 00 00    	je     80100db0 <consoleintr+0x4f0>
801009d8:	a1 c0 ff 10 80       	mov    0x8010ffc0,%eax
801009dd:	83 e8 80             	sub    $0xffffff80,%eax
801009e0:	39 05 c8 ff 10 80    	cmp    %eax,0x8010ffc8
801009e6:	0f 85 f6 fe ff ff    	jne    801008e2 <consoleintr+0x22>
801009ec:	e9 c4 03 00 00       	jmp    80100db5 <consoleintr+0x4f5>
      char last =  input.buf[(input.e-1)];
801009f1:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
      char b_last = input.buf[(input.e-2)];
801009f6:	be 03 00 00 00       	mov    $0x3,%esi
801009fb:	0f b6 88 3e ff 10 80 	movzbl -0x7fef00c2(%eax),%ecx
      char last =  input.buf[(input.e-1)];
80100a02:	0f b6 b8 3f ff 10 80 	movzbl -0x7fef00c1(%eax),%edi
      char b_last = input.buf[(input.e-2)];
80100a09:	88 4d a4             	mov    %cl,-0x5c(%ebp)
        input.e--;
80100a0c:	83 e8 01             	sub    $0x1,%eax
80100a0f:	a3 c8 ff 10 80       	mov    %eax,0x8010ffc8
  if(panicked){
80100a14:	a1 78 a5 10 80       	mov    0x8010a578,%eax
80100a19:	85 c0                	test   %eax,%eax
80100a1b:	0f 85 07 02 00 00    	jne    80100c28 <consoleintr+0x368>
80100a21:	b8 00 01 00 00       	mov    $0x100,%eax
80100a26:	e8 e5 f9 ff ff       	call   80100410 <consputc.part.0>
      for(int i = 0; i < 3; i+=1){
80100a2b:	83 ee 01             	sub    $0x1,%esi
80100a2e:	0f 85 6c 02 00 00    	jne    80100ca0 <consoleintr+0x3e0>
  if(panicked){
80100a34:	a1 78 a5 10 80       	mov    0x8010a578,%eax
80100a39:	85 c0                	test   %eax,%eax
80100a3b:	0f 84 47 02 00 00    	je     80100c88 <consoleintr+0x3c8>
80100a41:	fa                   	cli    
    for(;;)
80100a42:	eb fe                	jmp    80100a42 <consoleintr+0x182>
        for(uint i = input.e; i != input.pos; i++){
80100a44:	8b 0d c8 ff 10 80    	mov    0x8010ffc8,%ecx
80100a4a:	8b 35 cc ff 10 80    	mov    0x8010ffcc,%esi
        char lowerCase[] = "abcdefghijklmnopqrstuvwxyz"; 
80100a50:	c6 45 cc 00          	movb   $0x0,-0x34(%ebp)
80100a54:	bf 79 7a 00 00       	mov    $0x7a79,%edi
        char upperCase[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
80100a59:	b8 59 5a 00 00       	mov    $0x5a59,%eax
        char lowerCase[] = "abcdefghijklmnopqrstuvwxyz"; 
80100a5e:	66 89 7d ca          	mov    %di,-0x36(%ebp)
80100a62:	89 df                	mov    %ebx,%edi
80100a64:	c7 45 b2 61 62 63 64 	movl   $0x64636261,-0x4e(%ebp)
80100a6b:	c7 45 b6 65 66 67 68 	movl   $0x68676665,-0x4a(%ebp)
80100a72:	c7 45 ba 69 6a 6b 6c 	movl   $0x6c6b6a69,-0x46(%ebp)
80100a79:	c7 45 be 6d 6e 6f 70 	movl   $0x706f6e6d,-0x42(%ebp)
80100a80:	c7 45 c2 71 72 73 74 	movl   $0x74737271,-0x3e(%ebp)
80100a87:	c7 45 c6 75 76 77 78 	movl   $0x78777675,-0x3a(%ebp)
        char upperCase[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
80100a8e:	c7 45 cd 41 42 43 44 	movl   $0x44434241,-0x33(%ebp)
80100a95:	c7 45 d1 45 46 47 48 	movl   $0x48474645,-0x2f(%ebp)
80100a9c:	c7 45 d5 49 4a 4b 4c 	movl   $0x4c4b4a49,-0x2b(%ebp)
80100aa3:	c7 45 d9 4d 4e 4f 50 	movl   $0x504f4e4d,-0x27(%ebp)
80100aaa:	c7 45 dd 51 52 53 54 	movl   $0x54535251,-0x23(%ebp)
80100ab1:	c7 45 e1 55 56 57 58 	movl   $0x58575655,-0x1f(%ebp)
80100ab8:	66 89 45 e5          	mov    %ax,-0x1b(%ebp)
80100abc:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
        for(uint i = input.e; i != input.pos; i++){
80100ac0:	39 f1                	cmp    %esi,%ecx
80100ac2:	74 48                	je     80100b0c <consoleintr+0x24c>
          if(input.buf[i] == ' ' || input.buf[i] == '\n') {
80100ac4:	0f b6 91 40 ff 10 80 	movzbl -0x7fef00c0(%ecx),%edx
80100acb:	80 fa 20             	cmp    $0x20,%dl
80100ace:	74 3a                	je     80100b0a <consoleintr+0x24a>
80100ad0:	80 fa 0a             	cmp    $0xa,%dl
80100ad3:	74 35                	je     80100b0a <consoleintr+0x24a>
80100ad5:	bb 61 00 00 00       	mov    $0x61,%ebx
            for(int j = 0; j < 26; j++) {
80100ada:	31 c0                	xor    %eax,%eax
80100adc:	eb 0e                	jmp    80100aec <consoleintr+0x22c>
80100ade:	66 90                	xchg   %ax,%ax
80100ae0:	0f b6 91 40 ff 10 80 	movzbl -0x7fef00c0(%ecx),%edx
80100ae7:	0f b6 5c 05 b2       	movzbl -0x4e(%ebp,%eax,1),%ebx
              if(input.buf[i] == lowerCase[j]) {
80100aec:	38 da                	cmp    %bl,%dl
80100aee:	75 0b                	jne    80100afb <consoleintr+0x23b>
               input.buf[i] = upperCase[j];
80100af0:	0f b6 54 05 cd       	movzbl -0x33(%ebp,%eax,1),%edx
80100af5:	88 91 40 ff 10 80    	mov    %dl,-0x7fef00c0(%ecx)
            for(int j = 0; j < 26; j++) {
80100afb:	83 c0 01             	add    $0x1,%eax
80100afe:	83 f8 1a             	cmp    $0x1a,%eax
80100b01:	75 dd                	jne    80100ae0 <consoleintr+0x220>
        for(uint i = input.e; i != input.pos; i++){
80100b03:	83 c1 01             	add    $0x1,%ecx
80100b06:	39 f1                	cmp    %esi,%ecx
80100b08:	75 ba                	jne    80100ac4 <consoleintr+0x204>
80100b0a:	89 fb                	mov    %edi,%ebx
        for(uint i = input.w; i != input.pos; i++){
80100b0c:	8b 3d c4 ff 10 80    	mov    0x8010ffc4,%edi
80100b12:	39 f7                	cmp    %esi,%edi
80100b14:	0f 84 c8 fd ff ff    	je     801008e2 <consoleintr+0x22>
  if(panicked){
80100b1a:	8b 35 78 a5 10 80    	mov    0x8010a578,%esi
80100b20:	85 f6                	test   %esi,%esi
80100b22:	0f 84 dc 00 00 00    	je     80100c04 <consoleintr+0x344>
80100b28:	fa                   	cli    
    for(;;)
80100b29:	eb fe                	jmp    80100b29 <consoleintr+0x269>
      if(input.e != input.w){
80100b2b:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
80100b30:	3b 05 c4 ff 10 80    	cmp    0x8010ffc4,%eax
80100b36:	0f 84 a6 fd ff ff    	je     801008e2 <consoleintr+0x22>
        input.e--;
80100b3c:	83 e8 01             	sub    $0x1,%eax
80100b3f:	a3 c8 ff 10 80       	mov    %eax,0x8010ffc8
  if(panicked){
80100b44:	a1 78 a5 10 80       	mov    0x8010a578,%eax
80100b49:	85 c0                	test   %eax,%eax
80100b4b:	0f 84 59 01 00 00    	je     80100caa <consoleintr+0x3ea>
80100b51:	fa                   	cli    
    for(;;)
80100b52:	eb fe                	jmp    80100b52 <consoleintr+0x292>
        while(input.e != input.w &&
80100b54:	a1 c4 ff 10 80       	mov    0x8010ffc4,%eax
80100b59:	8b 3d c8 ff 10 80    	mov    0x8010ffc8,%edi
80100b5f:	89 de                	mov    %ebx,%esi
        ctrlA_pressed = 1;
80100b61:	c7 05 20 a5 10 80 01 	movl   $0x1,0x8010a520
80100b68:	00 00 00 
        while(input.e != input.w &&
80100b6b:	89 c1                	mov    %eax,%ecx
80100b6d:	89 45 a4             	mov    %eax,-0x5c(%ebp)
80100b70:	31 c0                	xor    %eax,%eax
80100b72:	39 f9                	cmp    %edi,%ecx
80100b74:	75 66                	jne    80100bdc <consoleintr+0x31c>
80100b76:	e9 67 fd ff ff       	jmp    801008e2 <consoleintr+0x22>
80100b7b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100b7f:	90                   	nop
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100b80:	b8 0e 00 00 00       	mov    $0xe,%eax
80100b85:	ba d4 03 00 00       	mov    $0x3d4,%edx
80100b8a:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100b8b:	bb d5 03 00 00       	mov    $0x3d5,%ebx
80100b90:	89 da                	mov    %ebx,%edx
80100b92:	ec                   	in     (%dx),%al
80100b93:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100b96:	ba d4 03 00 00       	mov    $0x3d4,%edx
80100b9b:	b8 0f 00 00 00       	mov    $0xf,%eax
  pos = inb(CRTPORT+1) << 8;
80100ba0:	c1 e1 08             	shl    $0x8,%ecx
80100ba3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100ba4:	89 da                	mov    %ebx,%edx
80100ba6:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);    
80100ba7:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100baa:	ba d4 03 00 00       	mov    $0x3d4,%edx
80100baf:	09 c1                	or     %eax,%ecx
80100bb1:	b8 0f 00 00 00       	mov    $0xf,%eax
  pos--;
80100bb6:	83 e9 01             	sub    $0x1,%ecx
80100bb9:	ee                   	out    %al,(%dx)
80100bba:	89 c8                	mov    %ecx,%eax
80100bbc:	89 da                	mov    %ebx,%edx
80100bbe:	ee                   	out    %al,(%dx)
80100bbf:	b8 0e 00 00 00       	mov    $0xe,%eax
80100bc4:	ba d4 03 00 00       	mov    $0x3d4,%edx
80100bc9:	ee                   	out    %al,(%dx)
  outb(CRTPORT+1, (unsigned char )((pos>>8)&0xFF));
80100bca:	89 c8                	mov    %ecx,%eax
80100bcc:	89 da                	mov    %ebx,%edx
80100bce:	c1 f8 08             	sar    $0x8,%eax
80100bd1:	ee                   	out    %al,(%dx)
        while(input.e != input.w &&
80100bd2:	b8 01 00 00 00       	mov    $0x1,%eax
80100bd7:	3b 7d a4             	cmp    -0x5c(%ebp),%edi
80100bda:	74 54                	je     80100c30 <consoleintr+0x370>
80100bdc:	89 fa                	mov    %edi,%edx
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100bde:	83 ef 01             	sub    $0x1,%edi
80100be1:	89 f9                	mov    %edi,%ecx
80100be3:	83 e1 7f             	and    $0x7f,%ecx
        while(input.e != input.w &&
80100be6:	80 b9 40 ff 10 80 0a 	cmpb   $0xa,-0x7fef00c0(%ecx)
80100bed:	75 91                	jne    80100b80 <consoleintr+0x2c0>
80100bef:	89 f3                	mov    %esi,%ebx
80100bf1:	84 c0                	test   %al,%al
80100bf3:	0f 84 e9 fc ff ff    	je     801008e2 <consoleintr+0x22>
80100bf9:	89 15 c8 ff 10 80    	mov    %edx,0x8010ffc8
80100bff:	e9 de fc ff ff       	jmp    801008e2 <consoleintr+0x22>
          consputc(input.buf[i]);
80100c04:	0f be 87 40 ff 10 80 	movsbl -0x7fef00c0(%edi),%eax
        for(uint i = input.w; i != input.pos; i++){
80100c0b:	83 c7 01             	add    $0x1,%edi
80100c0e:	e8 fd f7 ff ff       	call   80100410 <consputc.part.0>
80100c13:	39 3d cc ff 10 80    	cmp    %edi,0x8010ffcc
80100c19:	0f 85 fb fe ff ff    	jne    80100b1a <consoleintr+0x25a>
80100c1f:	e9 be fc ff ff       	jmp    801008e2 <consoleintr+0x22>
80100c24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  asm volatile("cli");
80100c28:	fa                   	cli    
    for(;;)
80100c29:	eb fe                	jmp    80100c29 <consoleintr+0x369>
80100c2b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100c2f:	90                   	nop
80100c30:	89 3d c8 ff 10 80    	mov    %edi,0x8010ffc8
80100c36:	89 f3                	mov    %esi,%ebx
80100c38:	e9 a5 fc ff ff       	jmp    801008e2 <consoleintr+0x22>
            input.buf[i] = input.buf[i-1];
80100c3d:	0f b6 8a 3f ff 10 80 	movzbl -0x7fef00c1(%edx),%ecx
80100c44:	83 ea 01             	sub    $0x1,%edx
80100c47:	88 8a 41 ff 10 80    	mov    %cl,-0x7fef00bf(%edx)
          for(uint i = input.pos; i != input.e; i--){
80100c4d:	39 d0                	cmp    %edx,%eax
80100c4f:	75 ec                	jne    80100c3d <consoleintr+0x37d>
          input.buf[input.e] = c;
80100c51:	89 f1                	mov    %esi,%ecx
          input.e++;
80100c53:	89 3d c8 ff 10 80    	mov    %edi,0x8010ffc8
          input.buf[input.e] = c;
80100c59:	88 88 40 ff 10 80    	mov    %cl,-0x7fef00c0(%eax)
          input.pos++;
80100c5f:	8b 4d a4             	mov    -0x5c(%ebp),%ecx
80100c62:	89 0d cc ff 10 80    	mov    %ecx,0x8010ffcc
          for(uint i = input.e-1; i != input.pos; i++){
80100c68:	39 c8                	cmp    %ecx,%eax
80100c6a:	0f 84 b7 00 00 00    	je     80100d27 <consoleintr+0x467>
  if(panicked){
80100c70:	8b 15 78 a5 10 80    	mov    0x8010a578,%edx
80100c76:	85 d2                	test   %edx,%edx
80100c78:	0f 84 80 00 00 00    	je     80100cfe <consoleintr+0x43e>
80100c7e:	fa                   	cli    
    for(;;)
80100c7f:	eb fe                	jmp    80100c7f <consoleintr+0x3bf>
80100c81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      consputc(last);
80100c88:	89 f8                	mov    %edi,%eax
80100c8a:	0f be c0             	movsbl %al,%eax
80100c8d:	e8 7e f7 ff ff       	call   80100410 <consputc.part.0>
  if(panicked){
80100c92:	a1 78 a5 10 80       	mov    0x8010a578,%eax
80100c97:	85 c0                	test   %eax,%eax
80100c99:	74 35                	je     80100cd0 <consoleintr+0x410>
80100c9b:	fa                   	cli    
    for(;;)
80100c9c:	eb fe                	jmp    80100c9c <consoleintr+0x3dc>
80100c9e:	66 90                	xchg   %ax,%ax
80100ca0:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
80100ca5:	e9 62 fd ff ff       	jmp    80100a0c <consoleintr+0x14c>
80100caa:	b8 00 01 00 00       	mov    $0x100,%eax
80100caf:	e8 5c f7 ff ff       	call   80100410 <consputc.part.0>
80100cb4:	e9 29 fc ff ff       	jmp    801008e2 <consoleintr+0x22>
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100cb9:	85 f6                	test   %esi,%esi
80100cbb:	0f 84 21 fc ff ff    	je     801008e2 <consoleintr+0x22>
80100cc1:	e9 93 fc ff ff       	jmp    80100959 <consoleintr+0x99>
80100cc6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100ccd:	8d 76 00             	lea    0x0(%esi),%esi
      consputc(b_last);
80100cd0:	0f be 45 a4          	movsbl -0x5c(%ebp),%eax
80100cd4:	e8 37 f7 ff ff       	call   80100410 <consputc.part.0>
80100cd9:	e9 04 fc ff ff       	jmp    801008e2 <consoleintr+0x22>
  release(&cons.lock);
80100cde:	83 ec 0c             	sub    $0xc,%esp
80100ce1:	68 40 a5 10 80       	push   $0x8010a540
80100ce6:	e8 e5 3c 00 00       	call   801049d0 <release>
  if(doprocdump) {
80100ceb:	83 c4 10             	add    $0x10,%esp
80100cee:	85 db                	test   %ebx,%ebx
80100cf0:	0f 85 d9 00 00 00    	jne    80100dcf <consoleintr+0x50f>
}
80100cf6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100cf9:	5b                   	pop    %ebx
80100cfa:	5e                   	pop    %esi
80100cfb:	5f                   	pop    %edi
80100cfc:	5d                   	pop    %ebp
80100cfd:	c3                   	ret    
            consputc(input.buf[i]);
80100cfe:	0f be 80 40 ff 10 80 	movsbl -0x7fef00c0(%eax),%eax
80100d05:	e8 06 f7 ff ff       	call   80100410 <consputc.part.0>
          for(uint i = input.e-1; i != input.pos; i++){
80100d0a:	89 f8                	mov    %edi,%eax
80100d0c:	39 3d cc ff 10 80    	cmp    %edi,0x8010ffcc
80100d12:	74 08                	je     80100d1c <consoleintr+0x45c>
80100d14:	83 c7 01             	add    $0x1,%edi
80100d17:	e9 54 ff ff ff       	jmp    80100c70 <consoleintr+0x3b0>
80100d1c:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
80100d21:	89 7d a4             	mov    %edi,-0x5c(%ebp)
80100d24:	89 45 a0             	mov    %eax,-0x60(%ebp)
          for(uint i = input.pos; i != input.e; i--){
80100d27:	8b 7d a0             	mov    -0x60(%ebp),%edi
80100d2a:	39 7d a4             	cmp    %edi,-0x5c(%ebp)
80100d2d:	0f 84 af fb ff ff    	je     801008e2 <consoleintr+0x22>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100d33:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100d38:	89 de                	mov    %ebx,%esi
80100d3a:	b8 0e 00 00 00       	mov    $0xe,%eax
80100d3f:	89 fa                	mov    %edi,%edx
80100d41:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100d42:	bb d5 03 00 00       	mov    $0x3d5,%ebx
80100d47:	89 da                	mov    %ebx,%edx
80100d49:	ec                   	in     (%dx),%al
80100d4a:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100d4d:	89 fa                	mov    %edi,%edx
80100d4f:	b8 0f 00 00 00       	mov    $0xf,%eax
  pos = inb(CRTPORT+1) << 8;
80100d54:	c1 e1 08             	shl    $0x8,%ecx
80100d57:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100d58:	89 da                	mov    %ebx,%edx
80100d5a:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);    
80100d5b:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100d5e:	89 fa                	mov    %edi,%edx
80100d60:	09 c1                	or     %eax,%ecx
80100d62:	b8 0f 00 00 00       	mov    $0xf,%eax
  pos--;
80100d67:	83 e9 01             	sub    $0x1,%ecx
80100d6a:	ee                   	out    %al,(%dx)
80100d6b:	89 c8                	mov    %ecx,%eax
80100d6d:	89 da                	mov    %ebx,%edx
80100d6f:	ee                   	out    %al,(%dx)
80100d70:	b8 0e 00 00 00       	mov    $0xe,%eax
80100d75:	89 fa                	mov    %edi,%edx
80100d77:	ee                   	out    %al,(%dx)
  outb(CRTPORT+1, (unsigned char )((pos>>8)&0xFF));
80100d78:	89 c8                	mov    %ecx,%eax
80100d7a:	89 da                	mov    %ebx,%edx
80100d7c:	c1 f8 08             	sar    $0x8,%eax
80100d7f:	ee                   	out    %al,(%dx)
          for(uint i = input.pos; i != input.e; i--){
80100d80:	83 6d a4 01          	subl   $0x1,-0x5c(%ebp)
80100d84:	8b 45 a4             	mov    -0x5c(%ebp),%eax
80100d87:	3b 45 a0             	cmp    -0x60(%ebp),%eax
80100d8a:	75 ae                	jne    80100d3a <consoleintr+0x47a>
80100d8c:	89 f3                	mov    %esi,%ebx
80100d8e:	e9 4f fb ff ff       	jmp    801008e2 <consoleintr+0x22>
          input.buf[input.e++ % INPUT_BUF] = c;
80100d93:	c6 80 40 ff 10 80 0a 	movb   $0xa,-0x7fef00c0(%eax)
          input.pos++;
80100d9a:	8b 45 a4             	mov    -0x5c(%ebp),%eax
80100d9d:	a3 cc ff 10 80       	mov    %eax,0x8010ffcc
  if(panicked){
80100da2:	85 d2                	test   %edx,%edx
80100da4:	75 35                	jne    80100ddb <consoleintr+0x51b>
80100da6:	b8 0a 00 00 00       	mov    $0xa,%eax
80100dab:	e8 60 f6 ff ff       	call   80100410 <consputc.part.0>
          if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100db0:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
            wakeup(&input.r);
80100db5:	83 ec 0c             	sub    $0xc,%esp
            input.w = input.e;
80100db8:	a3 c4 ff 10 80       	mov    %eax,0x8010ffc4
            wakeup(&input.r);
80100dbd:	68 c0 ff 10 80       	push   $0x8010ffc0
80100dc2:	e8 c9 36 00 00       	call   80104490 <wakeup>
80100dc7:	83 c4 10             	add    $0x10,%esp
80100dca:	e9 13 fb ff ff       	jmp    801008e2 <consoleintr+0x22>
}
80100dcf:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100dd2:	5b                   	pop    %ebx
80100dd3:	5e                   	pop    %esi
80100dd4:	5f                   	pop    %edi
80100dd5:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100dd6:	e9 a5 37 00 00       	jmp    80104580 <procdump>
  asm volatile("cli");
80100ddb:	fa                   	cli    
    for(;;)
80100ddc:	eb fe                	jmp    80100ddc <consoleintr+0x51c>
80100dde:	66 90                	xchg   %ax,%ax

80100de0 <consoleinit>:

void
consoleinit(void)
{
80100de0:	f3 0f 1e fb          	endbr32 
80100de4:	55                   	push   %ebp
80100de5:	89 e5                	mov    %esp,%ebp
80100de7:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100dea:	68 08 75 10 80       	push   $0x80107508
80100def:	68 40 a5 10 80       	push   $0x8010a540
80100df4:	e8 97 39 00 00       	call   80104790 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80100df9:	58                   	pop    %eax
80100dfa:	5a                   	pop    %edx
80100dfb:	6a 00                	push   $0x0
80100dfd:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
80100dff:	c7 05 8c 09 11 80 40 	movl   $0x80100640,0x8011098c
80100e06:	06 10 80 
  devsw[CONSOLE].read = consoleread;
80100e09:	c7 05 88 09 11 80 90 	movl   $0x80100290,0x80110988
80100e10:	02 10 80 
  cons.locking = 1;
80100e13:	c7 05 74 a5 10 80 01 	movl   $0x1,0x8010a574
80100e1a:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80100e1d:	e8 be 19 00 00       	call   801027e0 <ioapicenable>
}
80100e22:	83 c4 10             	add    $0x10,%esp
80100e25:	c9                   	leave  
80100e26:	c3                   	ret    
80100e27:	66 90                	xchg   %ax,%ax
80100e29:	66 90                	xchg   %ax,%ax
80100e2b:	66 90                	xchg   %ax,%ax
80100e2d:	66 90                	xchg   %ax,%ax
80100e2f:	90                   	nop

80100e30 <exec>:
80100e30:	f3 0f 1e fb          	endbr32 
80100e34:	55                   	push   %ebp
80100e35:	89 e5                	mov    %esp,%ebp
80100e37:	57                   	push   %edi
80100e38:	56                   	push   %esi
80100e39:	53                   	push   %ebx
80100e3a:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
80100e40:	e8 cb 2e 00 00       	call   80103d10 <myproc>
80100e45:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100e4b:	e8 90 22 00 00       	call   801030e0 <begin_op>
80100e50:	83 ec 0c             	sub    $0xc,%esp
80100e53:	ff 75 08             	pushl  0x8(%ebp)
80100e56:	e8 85 15 00 00       	call   801023e0 <namei>
80100e5b:	83 c4 10             	add    $0x10,%esp
80100e5e:	85 c0                	test   %eax,%eax
80100e60:	0f 84 fe 02 00 00    	je     80101164 <exec+0x334>
80100e66:	83 ec 0c             	sub    $0xc,%esp
80100e69:	89 c3                	mov    %eax,%ebx
80100e6b:	50                   	push   %eax
80100e6c:	e8 9f 0c 00 00       	call   80101b10 <ilock>
80100e71:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100e77:	6a 34                	push   $0x34
80100e79:	6a 00                	push   $0x0
80100e7b:	50                   	push   %eax
80100e7c:	53                   	push   %ebx
80100e7d:	e8 8e 0f 00 00       	call   80101e10 <readi>
80100e82:	83 c4 20             	add    $0x20,%esp
80100e85:	83 f8 34             	cmp    $0x34,%eax
80100e88:	74 26                	je     80100eb0 <exec+0x80>
80100e8a:	83 ec 0c             	sub    $0xc,%esp
80100e8d:	53                   	push   %ebx
80100e8e:	e8 1d 0f 00 00       	call   80101db0 <iunlockput>
80100e93:	e8 b8 22 00 00       	call   80103150 <end_op>
80100e98:	83 c4 10             	add    $0x10,%esp
80100e9b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100ea0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ea3:	5b                   	pop    %ebx
80100ea4:	5e                   	pop    %esi
80100ea5:	5f                   	pop    %edi
80100ea6:	5d                   	pop    %ebp
80100ea7:	c3                   	ret    
80100ea8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100eaf:	90                   	nop
80100eb0:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100eb7:	45 4c 46 
80100eba:	75 ce                	jne    80100e8a <exec+0x5a>
80100ebc:	e8 3f 63 00 00       	call   80107200 <setupkvm>
80100ec1:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100ec7:	85 c0                	test   %eax,%eax
80100ec9:	74 bf                	je     80100e8a <exec+0x5a>
80100ecb:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100ed2:	00 
80100ed3:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100ed9:	0f 84 a4 02 00 00    	je     80101183 <exec+0x353>
80100edf:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100ee6:	00 00 00 
80100ee9:	31 ff                	xor    %edi,%edi
80100eeb:	e9 86 00 00 00       	jmp    80100f76 <exec+0x146>
80100ef0:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100ef7:	75 6c                	jne    80100f65 <exec+0x135>
80100ef9:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100eff:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100f05:	0f 82 87 00 00 00    	jb     80100f92 <exec+0x162>
80100f0b:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100f11:	72 7f                	jb     80100f92 <exec+0x162>
80100f13:	83 ec 04             	sub    $0x4,%esp
80100f16:	50                   	push   %eax
80100f17:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100f1d:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100f23:	e8 f8 60 00 00       	call   80107020 <allocuvm>
80100f28:	83 c4 10             	add    $0x10,%esp
80100f2b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100f31:	85 c0                	test   %eax,%eax
80100f33:	74 5d                	je     80100f92 <exec+0x162>
80100f35:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100f3b:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100f40:	75 50                	jne    80100f92 <exec+0x162>
80100f42:	83 ec 0c             	sub    $0xc,%esp
80100f45:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100f4b:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100f51:	53                   	push   %ebx
80100f52:	50                   	push   %eax
80100f53:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100f59:	e8 f2 5f 00 00       	call   80106f50 <loaduvm>
80100f5e:	83 c4 20             	add    $0x20,%esp
80100f61:	85 c0                	test   %eax,%eax
80100f63:	78 2d                	js     80100f92 <exec+0x162>
80100f65:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100f6c:	83 c7 01             	add    $0x1,%edi
80100f6f:	83 c6 20             	add    $0x20,%esi
80100f72:	39 f8                	cmp    %edi,%eax
80100f74:	7e 3a                	jle    80100fb0 <exec+0x180>
80100f76:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100f7c:	6a 20                	push   $0x20
80100f7e:	56                   	push   %esi
80100f7f:	50                   	push   %eax
80100f80:	53                   	push   %ebx
80100f81:	e8 8a 0e 00 00       	call   80101e10 <readi>
80100f86:	83 c4 10             	add    $0x10,%esp
80100f89:	83 f8 20             	cmp    $0x20,%eax
80100f8c:	0f 84 5e ff ff ff    	je     80100ef0 <exec+0xc0>
80100f92:	83 ec 0c             	sub    $0xc,%esp
80100f95:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100f9b:	e8 e0 61 00 00       	call   80107180 <freevm>
80100fa0:	83 c4 10             	add    $0x10,%esp
80100fa3:	e9 e2 fe ff ff       	jmp    80100e8a <exec+0x5a>
80100fa8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100faf:	90                   	nop
80100fb0:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
80100fb6:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
80100fbc:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80100fc2:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
80100fc8:	83 ec 0c             	sub    $0xc,%esp
80100fcb:	53                   	push   %ebx
80100fcc:	e8 df 0d 00 00       	call   80101db0 <iunlockput>
80100fd1:	e8 7a 21 00 00       	call   80103150 <end_op>
80100fd6:	83 c4 0c             	add    $0xc,%esp
80100fd9:	56                   	push   %esi
80100fda:	57                   	push   %edi
80100fdb:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100fe1:	57                   	push   %edi
80100fe2:	e8 39 60 00 00       	call   80107020 <allocuvm>
80100fe7:	83 c4 10             	add    $0x10,%esp
80100fea:	89 c6                	mov    %eax,%esi
80100fec:	85 c0                	test   %eax,%eax
80100fee:	0f 84 94 00 00 00    	je     80101088 <exec+0x258>
80100ff4:	83 ec 08             	sub    $0x8,%esp
80100ff7:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100ffd:	89 f3                	mov    %esi,%ebx
80100fff:	50                   	push   %eax
80101000:	57                   	push   %edi
80101001:	31 ff                	xor    %edi,%edi
80101003:	e8 98 62 00 00       	call   801072a0 <clearpteu>
80101008:	8b 45 0c             	mov    0xc(%ebp),%eax
8010100b:	83 c4 10             	add    $0x10,%esp
8010100e:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80101014:	8b 00                	mov    (%eax),%eax
80101016:	85 c0                	test   %eax,%eax
80101018:	0f 84 8b 00 00 00    	je     801010a9 <exec+0x279>
8010101e:	89 b5 f0 fe ff ff    	mov    %esi,-0x110(%ebp)
80101024:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
8010102a:	eb 23                	jmp    8010104f <exec+0x21f>
8010102c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101030:	8b 45 0c             	mov    0xc(%ebp),%eax
80101033:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
8010103a:	83 c7 01             	add    $0x1,%edi
8010103d:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80101043:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80101046:	85 c0                	test   %eax,%eax
80101048:	74 59                	je     801010a3 <exec+0x273>
8010104a:	83 ff 20             	cmp    $0x20,%edi
8010104d:	74 39                	je     80101088 <exec+0x258>
8010104f:	83 ec 0c             	sub    $0xc,%esp
80101052:	50                   	push   %eax
80101053:	e8 c8 3b 00 00       	call   80104c20 <strlen>
80101058:	f7 d0                	not    %eax
8010105a:	01 c3                	add    %eax,%ebx
8010105c:	58                   	pop    %eax
8010105d:	8b 45 0c             	mov    0xc(%ebp),%eax
80101060:	83 e3 fc             	and    $0xfffffffc,%ebx
80101063:	ff 34 b8             	pushl  (%eax,%edi,4)
80101066:	e8 b5 3b 00 00       	call   80104c20 <strlen>
8010106b:	83 c0 01             	add    $0x1,%eax
8010106e:	50                   	push   %eax
8010106f:	8b 45 0c             	mov    0xc(%ebp),%eax
80101072:	ff 34 b8             	pushl  (%eax,%edi,4)
80101075:	53                   	push   %ebx
80101076:	56                   	push   %esi
80101077:	e8 84 63 00 00       	call   80107400 <copyout>
8010107c:	83 c4 20             	add    $0x20,%esp
8010107f:	85 c0                	test   %eax,%eax
80101081:	79 ad                	jns    80101030 <exec+0x200>
80101083:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101087:	90                   	nop
80101088:	83 ec 0c             	sub    $0xc,%esp
8010108b:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80101091:	e8 ea 60 00 00       	call   80107180 <freevm>
80101096:	83 c4 10             	add    $0x10,%esp
80101099:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010109e:	e9 fd fd ff ff       	jmp    80100ea0 <exec+0x70>
801010a3:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
801010a9:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
801010b0:	89 d9                	mov    %ebx,%ecx
801010b2:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
801010b9:	00 00 00 00 
801010bd:	29 c1                	sub    %eax,%ecx
801010bf:	83 c0 0c             	add    $0xc,%eax
801010c2:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
801010c8:	29 c3                	sub    %eax,%ebx
801010ca:	50                   	push   %eax
801010cb:	52                   	push   %edx
801010cc:	53                   	push   %ebx
801010cd:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
801010d3:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
801010da:	ff ff ff 
801010dd:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
801010e3:	e8 18 63 00 00       	call   80107400 <copyout>
801010e8:	83 c4 10             	add    $0x10,%esp
801010eb:	85 c0                	test   %eax,%eax
801010ed:	78 99                	js     80101088 <exec+0x258>
801010ef:	8b 45 08             	mov    0x8(%ebp),%eax
801010f2:	8b 55 08             	mov    0x8(%ebp),%edx
801010f5:	0f b6 00             	movzbl (%eax),%eax
801010f8:	84 c0                	test   %al,%al
801010fa:	74 13                	je     8010110f <exec+0x2df>
801010fc:	89 d1                	mov    %edx,%ecx
801010fe:	66 90                	xchg   %ax,%ax
80101100:	83 c1 01             	add    $0x1,%ecx
80101103:	3c 2f                	cmp    $0x2f,%al
80101105:	0f b6 01             	movzbl (%ecx),%eax
80101108:	0f 44 d1             	cmove  %ecx,%edx
8010110b:	84 c0                	test   %al,%al
8010110d:	75 f1                	jne    80101100 <exec+0x2d0>
8010110f:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
80101115:	83 ec 04             	sub    $0x4,%esp
80101118:	6a 10                	push   $0x10
8010111a:	89 f8                	mov    %edi,%eax
8010111c:	52                   	push   %edx
8010111d:	83 c0 6c             	add    $0x6c,%eax
80101120:	50                   	push   %eax
80101121:	e8 ba 3a 00 00       	call   80104be0 <safestrcpy>
80101126:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
8010112c:	89 f8                	mov    %edi,%eax
8010112e:	8b 7f 04             	mov    0x4(%edi),%edi
80101131:	89 30                	mov    %esi,(%eax)
80101133:	89 48 04             	mov    %ecx,0x4(%eax)
80101136:	89 c1                	mov    %eax,%ecx
80101138:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
8010113e:	8b 40 18             	mov    0x18(%eax),%eax
80101141:	89 50 38             	mov    %edx,0x38(%eax)
80101144:	8b 41 18             	mov    0x18(%ecx),%eax
80101147:	89 58 44             	mov    %ebx,0x44(%eax)
8010114a:	89 0c 24             	mov    %ecx,(%esp)
8010114d:	e8 6e 5c 00 00       	call   80106dc0 <switchuvm>
80101152:	89 3c 24             	mov    %edi,(%esp)
80101155:	e8 26 60 00 00       	call   80107180 <freevm>
8010115a:	83 c4 10             	add    $0x10,%esp
8010115d:	31 c0                	xor    %eax,%eax
8010115f:	e9 3c fd ff ff       	jmp    80100ea0 <exec+0x70>
80101164:	e8 e7 1f 00 00       	call   80103150 <end_op>
80101169:	83 ec 0c             	sub    $0xc,%esp
8010116c:	68 79 75 10 80       	push   $0x80107579
80101171:	e8 3a f5 ff ff       	call   801006b0 <cprintf>
80101176:	83 c4 10             	add    $0x10,%esp
80101179:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010117e:	e9 1d fd ff ff       	jmp    80100ea0 <exec+0x70>
80101183:	31 ff                	xor    %edi,%edi
80101185:	be 00 20 00 00       	mov    $0x2000,%esi
8010118a:	e9 39 fe ff ff       	jmp    80100fc8 <exec+0x198>
8010118f:	90                   	nop

80101190 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80101190:	f3 0f 1e fb          	endbr32 
80101194:	55                   	push   %ebp
80101195:	89 e5                	mov    %esp,%ebp
80101197:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
8010119a:	68 85 75 10 80       	push   $0x80107585
8010119f:	68 e0 ff 10 80       	push   $0x8010ffe0
801011a4:	e8 e7 35 00 00       	call   80104790 <initlock>
}
801011a9:	83 c4 10             	add    $0x10,%esp
801011ac:	c9                   	leave  
801011ad:	c3                   	ret    
801011ae:	66 90                	xchg   %ax,%ax

801011b0 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
801011b0:	f3 0f 1e fb          	endbr32 
801011b4:	55                   	push   %ebp
801011b5:	89 e5                	mov    %esp,%ebp
801011b7:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
801011b8:	bb 14 00 11 80       	mov    $0x80110014,%ebx
{
801011bd:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
801011c0:	68 e0 ff 10 80       	push   $0x8010ffe0
801011c5:	e8 46 37 00 00       	call   80104910 <acquire>
801011ca:	83 c4 10             	add    $0x10,%esp
801011cd:	eb 0c                	jmp    801011db <filealloc+0x2b>
801011cf:	90                   	nop
  for(f = ftable.file; f < ftable.file + NFILE; f++){
801011d0:	83 c3 18             	add    $0x18,%ebx
801011d3:	81 fb 74 09 11 80    	cmp    $0x80110974,%ebx
801011d9:	74 25                	je     80101200 <filealloc+0x50>
    if(f->ref == 0){
801011db:	8b 43 04             	mov    0x4(%ebx),%eax
801011de:	85 c0                	test   %eax,%eax
801011e0:	75 ee                	jne    801011d0 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
801011e2:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
801011e5:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
801011ec:	68 e0 ff 10 80       	push   $0x8010ffe0
801011f1:	e8 da 37 00 00       	call   801049d0 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
801011f6:	89 d8                	mov    %ebx,%eax
      return f;
801011f8:	83 c4 10             	add    $0x10,%esp
}
801011fb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801011fe:	c9                   	leave  
801011ff:	c3                   	ret    
  release(&ftable.lock);
80101200:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80101203:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80101205:	68 e0 ff 10 80       	push   $0x8010ffe0
8010120a:	e8 c1 37 00 00       	call   801049d0 <release>
}
8010120f:	89 d8                	mov    %ebx,%eax
  return 0;
80101211:	83 c4 10             	add    $0x10,%esp
}
80101214:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101217:	c9                   	leave  
80101218:	c3                   	ret    
80101219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101220 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80101220:	f3 0f 1e fb          	endbr32 
80101224:	55                   	push   %ebp
80101225:	89 e5                	mov    %esp,%ebp
80101227:	53                   	push   %ebx
80101228:	83 ec 10             	sub    $0x10,%esp
8010122b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
8010122e:	68 e0 ff 10 80       	push   $0x8010ffe0
80101233:	e8 d8 36 00 00       	call   80104910 <acquire>
  if(f->ref < 1)
80101238:	8b 43 04             	mov    0x4(%ebx),%eax
8010123b:	83 c4 10             	add    $0x10,%esp
8010123e:	85 c0                	test   %eax,%eax
80101240:	7e 1a                	jle    8010125c <filedup+0x3c>
    panic("filedup");
  f->ref++;
80101242:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80101245:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80101248:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
8010124b:	68 e0 ff 10 80       	push   $0x8010ffe0
80101250:	e8 7b 37 00 00       	call   801049d0 <release>
  return f;
}
80101255:	89 d8                	mov    %ebx,%eax
80101257:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010125a:	c9                   	leave  
8010125b:	c3                   	ret    
    panic("filedup");
8010125c:	83 ec 0c             	sub    $0xc,%esp
8010125f:	68 8c 75 10 80       	push   $0x8010758c
80101264:	e8 27 f1 ff ff       	call   80100390 <panic>
80101269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101270 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80101270:	f3 0f 1e fb          	endbr32 
80101274:	55                   	push   %ebp
80101275:	89 e5                	mov    %esp,%ebp
80101277:	57                   	push   %edi
80101278:	56                   	push   %esi
80101279:	53                   	push   %ebx
8010127a:	83 ec 28             	sub    $0x28,%esp
8010127d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80101280:	68 e0 ff 10 80       	push   $0x8010ffe0
80101285:	e8 86 36 00 00       	call   80104910 <acquire>
  if(f->ref < 1)
8010128a:	8b 53 04             	mov    0x4(%ebx),%edx
8010128d:	83 c4 10             	add    $0x10,%esp
80101290:	85 d2                	test   %edx,%edx
80101292:	0f 8e a1 00 00 00    	jle    80101339 <fileclose+0xc9>
    panic("fileclose");
  if(--f->ref > 0){
80101298:	83 ea 01             	sub    $0x1,%edx
8010129b:	89 53 04             	mov    %edx,0x4(%ebx)
8010129e:	75 40                	jne    801012e0 <fileclose+0x70>
    release(&ftable.lock);
    return;
  }
  ff = *f;
801012a0:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
801012a4:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
801012a7:	8b 3b                	mov    (%ebx),%edi
  f->type = FD_NONE;
801012a9:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
801012af:	8b 73 0c             	mov    0xc(%ebx),%esi
801012b2:	88 45 e7             	mov    %al,-0x19(%ebp)
801012b5:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
801012b8:	68 e0 ff 10 80       	push   $0x8010ffe0
  ff = *f;
801012bd:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
801012c0:	e8 0b 37 00 00       	call   801049d0 <release>

  if(ff.type == FD_PIPE)
801012c5:	83 c4 10             	add    $0x10,%esp
801012c8:	83 ff 01             	cmp    $0x1,%edi
801012cb:	74 53                	je     80101320 <fileclose+0xb0>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
801012cd:	83 ff 02             	cmp    $0x2,%edi
801012d0:	74 26                	je     801012f8 <fileclose+0x88>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
801012d2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012d5:	5b                   	pop    %ebx
801012d6:	5e                   	pop    %esi
801012d7:	5f                   	pop    %edi
801012d8:	5d                   	pop    %ebp
801012d9:	c3                   	ret    
801012da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&ftable.lock);
801012e0:	c7 45 08 e0 ff 10 80 	movl   $0x8010ffe0,0x8(%ebp)
}
801012e7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012ea:	5b                   	pop    %ebx
801012eb:	5e                   	pop    %esi
801012ec:	5f                   	pop    %edi
801012ed:	5d                   	pop    %ebp
    release(&ftable.lock);
801012ee:	e9 dd 36 00 00       	jmp    801049d0 <release>
801012f3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801012f7:	90                   	nop
    begin_op();
801012f8:	e8 e3 1d 00 00       	call   801030e0 <begin_op>
    iput(ff.ip);
801012fd:	83 ec 0c             	sub    $0xc,%esp
80101300:	ff 75 e0             	pushl  -0x20(%ebp)
80101303:	e8 38 09 00 00       	call   80101c40 <iput>
    end_op();
80101308:	83 c4 10             	add    $0x10,%esp
}
8010130b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010130e:	5b                   	pop    %ebx
8010130f:	5e                   	pop    %esi
80101310:	5f                   	pop    %edi
80101311:	5d                   	pop    %ebp
    end_op();
80101312:	e9 39 1e 00 00       	jmp    80103150 <end_op>
80101317:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010131e:	66 90                	xchg   %ax,%ax
    pipeclose(ff.pipe, ff.writable);
80101320:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80101324:	83 ec 08             	sub    $0x8,%esp
80101327:	53                   	push   %ebx
80101328:	56                   	push   %esi
80101329:	e8 82 25 00 00       	call   801038b0 <pipeclose>
8010132e:	83 c4 10             	add    $0x10,%esp
}
80101331:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101334:	5b                   	pop    %ebx
80101335:	5e                   	pop    %esi
80101336:	5f                   	pop    %edi
80101337:	5d                   	pop    %ebp
80101338:	c3                   	ret    
    panic("fileclose");
80101339:	83 ec 0c             	sub    $0xc,%esp
8010133c:	68 94 75 10 80       	push   $0x80107594
80101341:	e8 4a f0 ff ff       	call   80100390 <panic>
80101346:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010134d:	8d 76 00             	lea    0x0(%esi),%esi

80101350 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80101350:	f3 0f 1e fb          	endbr32 
80101354:	55                   	push   %ebp
80101355:	89 e5                	mov    %esp,%ebp
80101357:	53                   	push   %ebx
80101358:	83 ec 04             	sub    $0x4,%esp
8010135b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
8010135e:	83 3b 02             	cmpl   $0x2,(%ebx)
80101361:	75 2d                	jne    80101390 <filestat+0x40>
    ilock(f->ip);
80101363:	83 ec 0c             	sub    $0xc,%esp
80101366:	ff 73 10             	pushl  0x10(%ebx)
80101369:	e8 a2 07 00 00       	call   80101b10 <ilock>
    stati(f->ip, st);
8010136e:	58                   	pop    %eax
8010136f:	5a                   	pop    %edx
80101370:	ff 75 0c             	pushl  0xc(%ebp)
80101373:	ff 73 10             	pushl  0x10(%ebx)
80101376:	e8 65 0a 00 00       	call   80101de0 <stati>
    iunlock(f->ip);
8010137b:	59                   	pop    %ecx
8010137c:	ff 73 10             	pushl  0x10(%ebx)
8010137f:	e8 6c 08 00 00       	call   80101bf0 <iunlock>
    return 0;
  }
  return -1;
}
80101384:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
80101387:	83 c4 10             	add    $0x10,%esp
8010138a:	31 c0                	xor    %eax,%eax
}
8010138c:	c9                   	leave  
8010138d:	c3                   	ret    
8010138e:	66 90                	xchg   %ax,%ax
80101390:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80101393:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101398:	c9                   	leave  
80101399:	c3                   	ret    
8010139a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801013a0 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
801013a0:	f3 0f 1e fb          	endbr32 
801013a4:	55                   	push   %ebp
801013a5:	89 e5                	mov    %esp,%ebp
801013a7:	57                   	push   %edi
801013a8:	56                   	push   %esi
801013a9:	53                   	push   %ebx
801013aa:	83 ec 0c             	sub    $0xc,%esp
801013ad:	8b 5d 08             	mov    0x8(%ebp),%ebx
801013b0:	8b 75 0c             	mov    0xc(%ebp),%esi
801013b3:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
801013b6:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
801013ba:	74 64                	je     80101420 <fileread+0x80>
    return -1;
  if(f->type == FD_PIPE)
801013bc:	8b 03                	mov    (%ebx),%eax
801013be:	83 f8 01             	cmp    $0x1,%eax
801013c1:	74 45                	je     80101408 <fileread+0x68>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
801013c3:	83 f8 02             	cmp    $0x2,%eax
801013c6:	75 5f                	jne    80101427 <fileread+0x87>
    ilock(f->ip);
801013c8:	83 ec 0c             	sub    $0xc,%esp
801013cb:	ff 73 10             	pushl  0x10(%ebx)
801013ce:	e8 3d 07 00 00       	call   80101b10 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
801013d3:	57                   	push   %edi
801013d4:	ff 73 14             	pushl  0x14(%ebx)
801013d7:	56                   	push   %esi
801013d8:	ff 73 10             	pushl  0x10(%ebx)
801013db:	e8 30 0a 00 00       	call   80101e10 <readi>
801013e0:	83 c4 20             	add    $0x20,%esp
801013e3:	89 c6                	mov    %eax,%esi
801013e5:	85 c0                	test   %eax,%eax
801013e7:	7e 03                	jle    801013ec <fileread+0x4c>
      f->off += r;
801013e9:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
801013ec:	83 ec 0c             	sub    $0xc,%esp
801013ef:	ff 73 10             	pushl  0x10(%ebx)
801013f2:	e8 f9 07 00 00       	call   80101bf0 <iunlock>
    return r;
801013f7:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
801013fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013fd:	89 f0                	mov    %esi,%eax
801013ff:	5b                   	pop    %ebx
80101400:	5e                   	pop    %esi
80101401:	5f                   	pop    %edi
80101402:	5d                   	pop    %ebp
80101403:	c3                   	ret    
80101404:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return piperead(f->pipe, addr, n);
80101408:	8b 43 0c             	mov    0xc(%ebx),%eax
8010140b:	89 45 08             	mov    %eax,0x8(%ebp)
}
8010140e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101411:	5b                   	pop    %ebx
80101412:	5e                   	pop    %esi
80101413:	5f                   	pop    %edi
80101414:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
80101415:	e9 36 26 00 00       	jmp    80103a50 <piperead>
8010141a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101420:	be ff ff ff ff       	mov    $0xffffffff,%esi
80101425:	eb d3                	jmp    801013fa <fileread+0x5a>
  panic("fileread");
80101427:	83 ec 0c             	sub    $0xc,%esp
8010142a:	68 9e 75 10 80       	push   $0x8010759e
8010142f:	e8 5c ef ff ff       	call   80100390 <panic>
80101434:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010143b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010143f:	90                   	nop

80101440 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101440:	f3 0f 1e fb          	endbr32 
80101444:	55                   	push   %ebp
80101445:	89 e5                	mov    %esp,%ebp
80101447:	57                   	push   %edi
80101448:	56                   	push   %esi
80101449:	53                   	push   %ebx
8010144a:	83 ec 1c             	sub    $0x1c,%esp
8010144d:	8b 45 0c             	mov    0xc(%ebp),%eax
80101450:	8b 75 08             	mov    0x8(%ebp),%esi
80101453:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101456:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
80101459:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
{
8010145d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
80101460:	0f 84 c1 00 00 00    	je     80101527 <filewrite+0xe7>
    return -1;
  if(f->type == FD_PIPE)
80101466:	8b 06                	mov    (%esi),%eax
80101468:	83 f8 01             	cmp    $0x1,%eax
8010146b:	0f 84 c3 00 00 00    	je     80101534 <filewrite+0xf4>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
80101471:	83 f8 02             	cmp    $0x2,%eax
80101474:	0f 85 cc 00 00 00    	jne    80101546 <filewrite+0x106>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
8010147a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
8010147d:	31 ff                	xor    %edi,%edi
    while(i < n){
8010147f:	85 c0                	test   %eax,%eax
80101481:	7f 34                	jg     801014b7 <filewrite+0x77>
80101483:	e9 98 00 00 00       	jmp    80101520 <filewrite+0xe0>
80101488:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010148f:	90                   	nop
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101490:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
80101493:	83 ec 0c             	sub    $0xc,%esp
80101496:	ff 76 10             	pushl  0x10(%esi)
        f->off += r;
80101499:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
8010149c:	e8 4f 07 00 00       	call   80101bf0 <iunlock>
      end_op();
801014a1:	e8 aa 1c 00 00       	call   80103150 <end_op>

      if(r < 0)
        break;
      if(r != n1)
801014a6:	8b 45 e0             	mov    -0x20(%ebp),%eax
801014a9:	83 c4 10             	add    $0x10,%esp
801014ac:	39 c3                	cmp    %eax,%ebx
801014ae:	75 60                	jne    80101510 <filewrite+0xd0>
        panic("short filewrite");
      i += r;
801014b0:	01 df                	add    %ebx,%edi
    while(i < n){
801014b2:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801014b5:	7e 69                	jle    80101520 <filewrite+0xe0>
      int n1 = n - i;
801014b7:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801014ba:	b8 00 06 00 00       	mov    $0x600,%eax
801014bf:	29 fb                	sub    %edi,%ebx
      if(n1 > max)
801014c1:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
801014c7:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
801014ca:	e8 11 1c 00 00       	call   801030e0 <begin_op>
      ilock(f->ip);
801014cf:	83 ec 0c             	sub    $0xc,%esp
801014d2:	ff 76 10             	pushl  0x10(%esi)
801014d5:	e8 36 06 00 00       	call   80101b10 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
801014da:	8b 45 dc             	mov    -0x24(%ebp),%eax
801014dd:	53                   	push   %ebx
801014de:	ff 76 14             	pushl  0x14(%esi)
801014e1:	01 f8                	add    %edi,%eax
801014e3:	50                   	push   %eax
801014e4:	ff 76 10             	pushl  0x10(%esi)
801014e7:	e8 24 0a 00 00       	call   80101f10 <writei>
801014ec:	83 c4 20             	add    $0x20,%esp
801014ef:	85 c0                	test   %eax,%eax
801014f1:	7f 9d                	jg     80101490 <filewrite+0x50>
      iunlock(f->ip);
801014f3:	83 ec 0c             	sub    $0xc,%esp
801014f6:	ff 76 10             	pushl  0x10(%esi)
801014f9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801014fc:	e8 ef 06 00 00       	call   80101bf0 <iunlock>
      end_op();
80101501:	e8 4a 1c 00 00       	call   80103150 <end_op>
      if(r < 0)
80101506:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101509:	83 c4 10             	add    $0x10,%esp
8010150c:	85 c0                	test   %eax,%eax
8010150e:	75 17                	jne    80101527 <filewrite+0xe7>
        panic("short filewrite");
80101510:	83 ec 0c             	sub    $0xc,%esp
80101513:	68 a7 75 10 80       	push   $0x801075a7
80101518:	e8 73 ee ff ff       	call   80100390 <panic>
8010151d:	8d 76 00             	lea    0x0(%esi),%esi
    }
    return i == n ? n : -1;
80101520:	89 f8                	mov    %edi,%eax
80101522:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
80101525:	74 05                	je     8010152c <filewrite+0xec>
80101527:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  panic("filewrite");
}
8010152c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010152f:	5b                   	pop    %ebx
80101530:	5e                   	pop    %esi
80101531:	5f                   	pop    %edi
80101532:	5d                   	pop    %ebp
80101533:	c3                   	ret    
    return pipewrite(f->pipe, addr, n);
80101534:	8b 46 0c             	mov    0xc(%esi),%eax
80101537:	89 45 08             	mov    %eax,0x8(%ebp)
}
8010153a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010153d:	5b                   	pop    %ebx
8010153e:	5e                   	pop    %esi
8010153f:	5f                   	pop    %edi
80101540:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
80101541:	e9 0a 24 00 00       	jmp    80103950 <pipewrite>
  panic("filewrite");
80101546:	83 ec 0c             	sub    $0xc,%esp
80101549:	68 ad 75 10 80       	push   $0x801075ad
8010154e:	e8 3d ee ff ff       	call   80100390 <panic>
80101553:	66 90                	xchg   %ax,%ax
80101555:	66 90                	xchg   %ax,%ax
80101557:	66 90                	xchg   %ax,%ax
80101559:	66 90                	xchg   %ax,%ax
8010155b:	66 90                	xchg   %ax,%ax
8010155d:	66 90                	xchg   %ax,%ax
8010155f:	90                   	nop

80101560 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101560:	55                   	push   %ebp
80101561:	89 c1                	mov    %eax,%ecx
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
80101563:	89 d0                	mov    %edx,%eax
80101565:	c1 e8 0c             	shr    $0xc,%eax
80101568:	03 05 f8 09 11 80    	add    0x801109f8,%eax
{
8010156e:	89 e5                	mov    %esp,%ebp
80101570:	56                   	push   %esi
80101571:	53                   	push   %ebx
80101572:	89 d3                	mov    %edx,%ebx
  bp = bread(dev, BBLOCK(b, sb));
80101574:	83 ec 08             	sub    $0x8,%esp
80101577:	50                   	push   %eax
80101578:	51                   	push   %ecx
80101579:	e8 52 eb ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
8010157e:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
80101580:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
80101583:	ba 01 00 00 00       	mov    $0x1,%edx
80101588:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
8010158b:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
80101591:	83 c4 10             	add    $0x10,%esp
  m = 1 << (bi % 8);
80101594:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
80101596:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
8010159b:	85 d1                	test   %edx,%ecx
8010159d:	74 25                	je     801015c4 <bfree+0x64>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
8010159f:	f7 d2                	not    %edx
  log_write(bp);
801015a1:	83 ec 0c             	sub    $0xc,%esp
801015a4:	89 c6                	mov    %eax,%esi
  bp->data[bi/8] &= ~m;
801015a6:	21 ca                	and    %ecx,%edx
801015a8:	88 54 18 5c          	mov    %dl,0x5c(%eax,%ebx,1)
  log_write(bp);
801015ac:	50                   	push   %eax
801015ad:	e8 0e 1d 00 00       	call   801032c0 <log_write>
  brelse(bp);
801015b2:	89 34 24             	mov    %esi,(%esp)
801015b5:	e8 36 ec ff ff       	call   801001f0 <brelse>
}
801015ba:	83 c4 10             	add    $0x10,%esp
801015bd:	8d 65 f8             	lea    -0x8(%ebp),%esp
801015c0:	5b                   	pop    %ebx
801015c1:	5e                   	pop    %esi
801015c2:	5d                   	pop    %ebp
801015c3:	c3                   	ret    
    panic("freeing free block");
801015c4:	83 ec 0c             	sub    $0xc,%esp
801015c7:	68 b7 75 10 80       	push   $0x801075b7
801015cc:	e8 bf ed ff ff       	call   80100390 <panic>
801015d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801015d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801015df:	90                   	nop

801015e0 <balloc>:
{
801015e0:	55                   	push   %ebp
801015e1:	89 e5                	mov    %esp,%ebp
801015e3:	57                   	push   %edi
801015e4:	56                   	push   %esi
801015e5:	53                   	push   %ebx
801015e6:	83 ec 1c             	sub    $0x1c,%esp
  for(b = 0; b < sb.size; b += BPB){
801015e9:	8b 0d e0 09 11 80    	mov    0x801109e0,%ecx
{
801015ef:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
801015f2:	85 c9                	test   %ecx,%ecx
801015f4:	0f 84 87 00 00 00    	je     80101681 <balloc+0xa1>
801015fa:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101601:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101604:	83 ec 08             	sub    $0x8,%esp
80101607:	89 f0                	mov    %esi,%eax
80101609:	c1 f8 0c             	sar    $0xc,%eax
8010160c:	03 05 f8 09 11 80    	add    0x801109f8,%eax
80101612:	50                   	push   %eax
80101613:	ff 75 d8             	pushl  -0x28(%ebp)
80101616:	e8 b5 ea ff ff       	call   801000d0 <bread>
8010161b:	83 c4 10             	add    $0x10,%esp
8010161e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101621:	a1 e0 09 11 80       	mov    0x801109e0,%eax
80101626:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101629:	31 c0                	xor    %eax,%eax
8010162b:	eb 2f                	jmp    8010165c <balloc+0x7c>
8010162d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101630:	89 c1                	mov    %eax,%ecx
80101632:	bb 01 00 00 00       	mov    $0x1,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101637:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
8010163a:	83 e1 07             	and    $0x7,%ecx
8010163d:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010163f:	89 c1                	mov    %eax,%ecx
80101641:	c1 f9 03             	sar    $0x3,%ecx
80101644:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
80101649:	89 fa                	mov    %edi,%edx
8010164b:	85 df                	test   %ebx,%edi
8010164d:	74 41                	je     80101690 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010164f:	83 c0 01             	add    $0x1,%eax
80101652:	83 c6 01             	add    $0x1,%esi
80101655:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010165a:	74 05                	je     80101661 <balloc+0x81>
8010165c:	39 75 e0             	cmp    %esi,-0x20(%ebp)
8010165f:	77 cf                	ja     80101630 <balloc+0x50>
    brelse(bp);
80101661:	83 ec 0c             	sub    $0xc,%esp
80101664:	ff 75 e4             	pushl  -0x1c(%ebp)
80101667:	e8 84 eb ff ff       	call   801001f0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
8010166c:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101673:	83 c4 10             	add    $0x10,%esp
80101676:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101679:	39 05 e0 09 11 80    	cmp    %eax,0x801109e0
8010167f:	77 80                	ja     80101601 <balloc+0x21>
  panic("balloc: out of blocks");
80101681:	83 ec 0c             	sub    $0xc,%esp
80101684:	68 ca 75 10 80       	push   $0x801075ca
80101689:	e8 02 ed ff ff       	call   80100390 <panic>
8010168e:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
80101690:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101693:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
80101696:	09 da                	or     %ebx,%edx
80101698:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
8010169c:	57                   	push   %edi
8010169d:	e8 1e 1c 00 00       	call   801032c0 <log_write>
        brelse(bp);
801016a2:	89 3c 24             	mov    %edi,(%esp)
801016a5:	e8 46 eb ff ff       	call   801001f0 <brelse>
  bp = bread(dev, bno);
801016aa:	58                   	pop    %eax
801016ab:	5a                   	pop    %edx
801016ac:	56                   	push   %esi
801016ad:	ff 75 d8             	pushl  -0x28(%ebp)
801016b0:	e8 1b ea ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
801016b5:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, bno);
801016b8:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801016ba:	8d 40 5c             	lea    0x5c(%eax),%eax
801016bd:	68 00 02 00 00       	push   $0x200
801016c2:	6a 00                	push   $0x0
801016c4:	50                   	push   %eax
801016c5:	e8 56 33 00 00       	call   80104a20 <memset>
  log_write(bp);
801016ca:	89 1c 24             	mov    %ebx,(%esp)
801016cd:	e8 ee 1b 00 00       	call   801032c0 <log_write>
  brelse(bp);
801016d2:	89 1c 24             	mov    %ebx,(%esp)
801016d5:	e8 16 eb ff ff       	call   801001f0 <brelse>
}
801016da:	8d 65 f4             	lea    -0xc(%ebp),%esp
801016dd:	89 f0                	mov    %esi,%eax
801016df:	5b                   	pop    %ebx
801016e0:	5e                   	pop    %esi
801016e1:	5f                   	pop    %edi
801016e2:	5d                   	pop    %ebp
801016e3:	c3                   	ret    
801016e4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801016eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801016ef:	90                   	nop

801016f0 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801016f0:	55                   	push   %ebp
801016f1:	89 e5                	mov    %esp,%ebp
801016f3:	57                   	push   %edi
801016f4:	89 c7                	mov    %eax,%edi
801016f6:	56                   	push   %esi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
801016f7:	31 f6                	xor    %esi,%esi
{
801016f9:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801016fa:	bb 34 0a 11 80       	mov    $0x80110a34,%ebx
{
801016ff:	83 ec 28             	sub    $0x28,%esp
80101702:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101705:	68 00 0a 11 80       	push   $0x80110a00
8010170a:	e8 01 32 00 00       	call   80104910 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010170f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  acquire(&icache.lock);
80101712:	83 c4 10             	add    $0x10,%esp
80101715:	eb 1b                	jmp    80101732 <iget+0x42>
80101717:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010171e:	66 90                	xchg   %ax,%ax
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101720:	39 3b                	cmp    %edi,(%ebx)
80101722:	74 6c                	je     80101790 <iget+0xa0>
80101724:	81 c3 90 00 00 00    	add    $0x90,%ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010172a:	81 fb 54 26 11 80    	cmp    $0x80112654,%ebx
80101730:	73 26                	jae    80101758 <iget+0x68>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101732:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101735:	85 c9                	test   %ecx,%ecx
80101737:	7f e7                	jg     80101720 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101739:	85 f6                	test   %esi,%esi
8010173b:	75 e7                	jne    80101724 <iget+0x34>
8010173d:	89 d8                	mov    %ebx,%eax
8010173f:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101745:	85 c9                	test   %ecx,%ecx
80101747:	75 6e                	jne    801017b7 <iget+0xc7>
80101749:	89 c6                	mov    %eax,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010174b:	81 fb 54 26 11 80    	cmp    $0x80112654,%ebx
80101751:	72 df                	jb     80101732 <iget+0x42>
80101753:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101757:	90                   	nop
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101758:	85 f6                	test   %esi,%esi
8010175a:	74 73                	je     801017cf <iget+0xdf>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
8010175c:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
8010175f:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101761:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
80101764:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
8010176b:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
80101772:	68 00 0a 11 80       	push   $0x80110a00
80101777:	e8 54 32 00 00       	call   801049d0 <release>

  return ip;
8010177c:	83 c4 10             	add    $0x10,%esp
}
8010177f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101782:	89 f0                	mov    %esi,%eax
80101784:	5b                   	pop    %ebx
80101785:	5e                   	pop    %esi
80101786:	5f                   	pop    %edi
80101787:	5d                   	pop    %ebp
80101788:	c3                   	ret    
80101789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101790:	39 53 04             	cmp    %edx,0x4(%ebx)
80101793:	75 8f                	jne    80101724 <iget+0x34>
      release(&icache.lock);
80101795:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
80101798:	83 c1 01             	add    $0x1,%ecx
      return ip;
8010179b:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
8010179d:	68 00 0a 11 80       	push   $0x80110a00
      ip->ref++;
801017a2:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
801017a5:	e8 26 32 00 00       	call   801049d0 <release>
      return ip;
801017aa:	83 c4 10             	add    $0x10,%esp
}
801017ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
801017b0:	89 f0                	mov    %esi,%eax
801017b2:	5b                   	pop    %ebx
801017b3:	5e                   	pop    %esi
801017b4:	5f                   	pop    %edi
801017b5:	5d                   	pop    %ebp
801017b6:	c3                   	ret    
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801017b7:	81 fb 54 26 11 80    	cmp    $0x80112654,%ebx
801017bd:	73 10                	jae    801017cf <iget+0xdf>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801017bf:	8b 4b 08             	mov    0x8(%ebx),%ecx
801017c2:	85 c9                	test   %ecx,%ecx
801017c4:	0f 8f 56 ff ff ff    	jg     80101720 <iget+0x30>
801017ca:	e9 6e ff ff ff       	jmp    8010173d <iget+0x4d>
    panic("iget: no inodes");
801017cf:	83 ec 0c             	sub    $0xc,%esp
801017d2:	68 e0 75 10 80       	push   $0x801075e0
801017d7:	e8 b4 eb ff ff       	call   80100390 <panic>
801017dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801017e0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801017e0:	55                   	push   %ebp
801017e1:	89 e5                	mov    %esp,%ebp
801017e3:	57                   	push   %edi
801017e4:	56                   	push   %esi
801017e5:	89 c6                	mov    %eax,%esi
801017e7:	53                   	push   %ebx
801017e8:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801017eb:	83 fa 0b             	cmp    $0xb,%edx
801017ee:	0f 86 84 00 00 00    	jbe    80101878 <bmap+0x98>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
801017f4:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
801017f7:	83 fb 7f             	cmp    $0x7f,%ebx
801017fa:	0f 87 98 00 00 00    	ja     80101898 <bmap+0xb8>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101800:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101806:	8b 16                	mov    (%esi),%edx
80101808:	85 c0                	test   %eax,%eax
8010180a:	74 54                	je     80101860 <bmap+0x80>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
8010180c:	83 ec 08             	sub    $0x8,%esp
8010180f:	50                   	push   %eax
80101810:	52                   	push   %edx
80101811:	e8 ba e8 ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101816:	83 c4 10             	add    $0x10,%esp
80101819:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
    bp = bread(ip->dev, addr);
8010181d:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
8010181f:	8b 1a                	mov    (%edx),%ebx
80101821:	85 db                	test   %ebx,%ebx
80101823:	74 1b                	je     80101840 <bmap+0x60>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
80101825:	83 ec 0c             	sub    $0xc,%esp
80101828:	57                   	push   %edi
80101829:	e8 c2 e9 ff ff       	call   801001f0 <brelse>
    return addr;
8010182e:	83 c4 10             	add    $0x10,%esp
  }

  panic("bmap: out of range");
}
80101831:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101834:	89 d8                	mov    %ebx,%eax
80101836:	5b                   	pop    %ebx
80101837:	5e                   	pop    %esi
80101838:	5f                   	pop    %edi
80101839:	5d                   	pop    %ebp
8010183a:	c3                   	ret    
8010183b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010183f:	90                   	nop
      a[bn] = addr = balloc(ip->dev);
80101840:	8b 06                	mov    (%esi),%eax
80101842:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101845:	e8 96 fd ff ff       	call   801015e0 <balloc>
8010184a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
8010184d:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
80101850:	89 c3                	mov    %eax,%ebx
80101852:	89 02                	mov    %eax,(%edx)
      log_write(bp);
80101854:	57                   	push   %edi
80101855:	e8 66 1a 00 00       	call   801032c0 <log_write>
8010185a:	83 c4 10             	add    $0x10,%esp
8010185d:	eb c6                	jmp    80101825 <bmap+0x45>
8010185f:	90                   	nop
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101860:	89 d0                	mov    %edx,%eax
80101862:	e8 79 fd ff ff       	call   801015e0 <balloc>
80101867:	8b 16                	mov    (%esi),%edx
80101869:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
8010186f:	eb 9b                	jmp    8010180c <bmap+0x2c>
80101871:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if((addr = ip->addrs[bn]) == 0)
80101878:	8d 3c 90             	lea    (%eax,%edx,4),%edi
8010187b:	8b 5f 5c             	mov    0x5c(%edi),%ebx
8010187e:	85 db                	test   %ebx,%ebx
80101880:	75 af                	jne    80101831 <bmap+0x51>
      ip->addrs[bn] = addr = balloc(ip->dev);
80101882:	8b 00                	mov    (%eax),%eax
80101884:	e8 57 fd ff ff       	call   801015e0 <balloc>
80101889:	89 47 5c             	mov    %eax,0x5c(%edi)
8010188c:	89 c3                	mov    %eax,%ebx
}
8010188e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101891:	89 d8                	mov    %ebx,%eax
80101893:	5b                   	pop    %ebx
80101894:	5e                   	pop    %esi
80101895:	5f                   	pop    %edi
80101896:	5d                   	pop    %ebp
80101897:	c3                   	ret    
  panic("bmap: out of range");
80101898:	83 ec 0c             	sub    $0xc,%esp
8010189b:	68 f0 75 10 80       	push   $0x801075f0
801018a0:	e8 eb ea ff ff       	call   80100390 <panic>
801018a5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801018ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801018b0 <readsb>:
{
801018b0:	f3 0f 1e fb          	endbr32 
801018b4:	55                   	push   %ebp
801018b5:	89 e5                	mov    %esp,%ebp
801018b7:	56                   	push   %esi
801018b8:	53                   	push   %ebx
801018b9:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
801018bc:	83 ec 08             	sub    $0x8,%esp
801018bf:	6a 01                	push   $0x1
801018c1:	ff 75 08             	pushl  0x8(%ebp)
801018c4:	e8 07 e8 ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
801018c9:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
801018cc:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801018ce:	8d 40 5c             	lea    0x5c(%eax),%eax
801018d1:	6a 1c                	push   $0x1c
801018d3:	50                   	push   %eax
801018d4:	56                   	push   %esi
801018d5:	e8 e6 31 00 00       	call   80104ac0 <memmove>
  brelse(bp);
801018da:	89 5d 08             	mov    %ebx,0x8(%ebp)
801018dd:	83 c4 10             	add    $0x10,%esp
}
801018e0:	8d 65 f8             	lea    -0x8(%ebp),%esp
801018e3:	5b                   	pop    %ebx
801018e4:	5e                   	pop    %esi
801018e5:	5d                   	pop    %ebp
  brelse(bp);
801018e6:	e9 05 e9 ff ff       	jmp    801001f0 <brelse>
801018eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801018ef:	90                   	nop

801018f0 <iinit>:
{
801018f0:	f3 0f 1e fb          	endbr32 
801018f4:	55                   	push   %ebp
801018f5:	89 e5                	mov    %esp,%ebp
801018f7:	53                   	push   %ebx
801018f8:	bb 40 0a 11 80       	mov    $0x80110a40,%ebx
801018fd:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
80101900:	68 03 76 10 80       	push   $0x80107603
80101905:	68 00 0a 11 80       	push   $0x80110a00
8010190a:	e8 81 2e 00 00       	call   80104790 <initlock>
  for(i = 0; i < NINODE; i++) {
8010190f:	83 c4 10             	add    $0x10,%esp
80101912:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    initsleeplock(&icache.inode[i].lock, "inode");
80101918:	83 ec 08             	sub    $0x8,%esp
8010191b:	68 0a 76 10 80       	push   $0x8010760a
80101920:	53                   	push   %ebx
80101921:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101927:	e8 24 2d 00 00       	call   80104650 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
8010192c:	83 c4 10             	add    $0x10,%esp
8010192f:	81 fb 60 26 11 80    	cmp    $0x80112660,%ebx
80101935:	75 e1                	jne    80101918 <iinit+0x28>
  readsb(dev, &sb);
80101937:	83 ec 08             	sub    $0x8,%esp
8010193a:	68 e0 09 11 80       	push   $0x801109e0
8010193f:	ff 75 08             	pushl  0x8(%ebp)
80101942:	e8 69 ff ff ff       	call   801018b0 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
80101947:	ff 35 f8 09 11 80    	pushl  0x801109f8
8010194d:	ff 35 f4 09 11 80    	pushl  0x801109f4
80101953:	ff 35 f0 09 11 80    	pushl  0x801109f0
80101959:	ff 35 ec 09 11 80    	pushl  0x801109ec
8010195f:	ff 35 e8 09 11 80    	pushl  0x801109e8
80101965:	ff 35 e4 09 11 80    	pushl  0x801109e4
8010196b:	ff 35 e0 09 11 80    	pushl  0x801109e0
80101971:	68 70 76 10 80       	push   $0x80107670
80101976:	e8 35 ed ff ff       	call   801006b0 <cprintf>
}
8010197b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010197e:	83 c4 30             	add    $0x30,%esp
80101981:	c9                   	leave  
80101982:	c3                   	ret    
80101983:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010198a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101990 <ialloc>:
{
80101990:	f3 0f 1e fb          	endbr32 
80101994:	55                   	push   %ebp
80101995:	89 e5                	mov    %esp,%ebp
80101997:	57                   	push   %edi
80101998:	56                   	push   %esi
80101999:	53                   	push   %ebx
8010199a:	83 ec 1c             	sub    $0x1c,%esp
8010199d:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
801019a0:	83 3d e8 09 11 80 01 	cmpl   $0x1,0x801109e8
{
801019a7:	8b 75 08             	mov    0x8(%ebp),%esi
801019aa:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
801019ad:	0f 86 8d 00 00 00    	jbe    80101a40 <ialloc+0xb0>
801019b3:	bf 01 00 00 00       	mov    $0x1,%edi
801019b8:	eb 1d                	jmp    801019d7 <ialloc+0x47>
801019ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    brelse(bp);
801019c0:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
801019c3:	83 c7 01             	add    $0x1,%edi
    brelse(bp);
801019c6:	53                   	push   %ebx
801019c7:	e8 24 e8 ff ff       	call   801001f0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
801019cc:	83 c4 10             	add    $0x10,%esp
801019cf:	3b 3d e8 09 11 80    	cmp    0x801109e8,%edi
801019d5:	73 69                	jae    80101a40 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
801019d7:	89 f8                	mov    %edi,%eax
801019d9:	83 ec 08             	sub    $0x8,%esp
801019dc:	c1 e8 03             	shr    $0x3,%eax
801019df:	03 05 f4 09 11 80    	add    0x801109f4,%eax
801019e5:	50                   	push   %eax
801019e6:	56                   	push   %esi
801019e7:	e8 e4 e6 ff ff       	call   801000d0 <bread>
    if(dip->type == 0){  // a free inode
801019ec:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, IBLOCK(inum, sb));
801019ef:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + inum%IPB;
801019f1:	89 f8                	mov    %edi,%eax
801019f3:	83 e0 07             	and    $0x7,%eax
801019f6:	c1 e0 06             	shl    $0x6,%eax
801019f9:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
801019fd:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101a01:	75 bd                	jne    801019c0 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101a03:	83 ec 04             	sub    $0x4,%esp
80101a06:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101a09:	6a 40                	push   $0x40
80101a0b:	6a 00                	push   $0x0
80101a0d:	51                   	push   %ecx
80101a0e:	e8 0d 30 00 00       	call   80104a20 <memset>
      dip->type = type;
80101a13:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101a17:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101a1a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
80101a1d:	89 1c 24             	mov    %ebx,(%esp)
80101a20:	e8 9b 18 00 00       	call   801032c0 <log_write>
      brelse(bp);
80101a25:	89 1c 24             	mov    %ebx,(%esp)
80101a28:	e8 c3 e7 ff ff       	call   801001f0 <brelse>
      return iget(dev, inum);
80101a2d:	83 c4 10             	add    $0x10,%esp
}
80101a30:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
80101a33:	89 fa                	mov    %edi,%edx
}
80101a35:	5b                   	pop    %ebx
      return iget(dev, inum);
80101a36:	89 f0                	mov    %esi,%eax
}
80101a38:	5e                   	pop    %esi
80101a39:	5f                   	pop    %edi
80101a3a:	5d                   	pop    %ebp
      return iget(dev, inum);
80101a3b:	e9 b0 fc ff ff       	jmp    801016f0 <iget>
  panic("ialloc: no inodes");
80101a40:	83 ec 0c             	sub    $0xc,%esp
80101a43:	68 10 76 10 80       	push   $0x80107610
80101a48:	e8 43 e9 ff ff       	call   80100390 <panic>
80101a4d:	8d 76 00             	lea    0x0(%esi),%esi

80101a50 <iupdate>:
{
80101a50:	f3 0f 1e fb          	endbr32 
80101a54:	55                   	push   %ebp
80101a55:	89 e5                	mov    %esp,%ebp
80101a57:	56                   	push   %esi
80101a58:	53                   	push   %ebx
80101a59:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101a5c:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101a5f:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101a62:	83 ec 08             	sub    $0x8,%esp
80101a65:	c1 e8 03             	shr    $0x3,%eax
80101a68:	03 05 f4 09 11 80    	add    0x801109f4,%eax
80101a6e:	50                   	push   %eax
80101a6f:	ff 73 a4             	pushl  -0x5c(%ebx)
80101a72:	e8 59 e6 ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
80101a77:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101a7b:	83 c4 0c             	add    $0xc,%esp
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101a7e:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101a80:	8b 43 a8             	mov    -0x58(%ebx),%eax
80101a83:	83 e0 07             	and    $0x7,%eax
80101a86:	c1 e0 06             	shl    $0x6,%eax
80101a89:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101a8d:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
80101a90:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101a94:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101a97:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101a9b:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
80101a9f:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
80101aa3:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101aa7:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101aab:	8b 53 fc             	mov    -0x4(%ebx),%edx
80101aae:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101ab1:	6a 34                	push   $0x34
80101ab3:	53                   	push   %ebx
80101ab4:	50                   	push   %eax
80101ab5:	e8 06 30 00 00       	call   80104ac0 <memmove>
  log_write(bp);
80101aba:	89 34 24             	mov    %esi,(%esp)
80101abd:	e8 fe 17 00 00       	call   801032c0 <log_write>
  brelse(bp);
80101ac2:	89 75 08             	mov    %esi,0x8(%ebp)
80101ac5:	83 c4 10             	add    $0x10,%esp
}
80101ac8:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101acb:	5b                   	pop    %ebx
80101acc:	5e                   	pop    %esi
80101acd:	5d                   	pop    %ebp
  brelse(bp);
80101ace:	e9 1d e7 ff ff       	jmp    801001f0 <brelse>
80101ad3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101ada:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101ae0 <idup>:
{
80101ae0:	f3 0f 1e fb          	endbr32 
80101ae4:	55                   	push   %ebp
80101ae5:	89 e5                	mov    %esp,%ebp
80101ae7:	53                   	push   %ebx
80101ae8:	83 ec 10             	sub    $0x10,%esp
80101aeb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
80101aee:	68 00 0a 11 80       	push   $0x80110a00
80101af3:	e8 18 2e 00 00       	call   80104910 <acquire>
  ip->ref++;
80101af8:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101afc:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
80101b03:	e8 c8 2e 00 00       	call   801049d0 <release>
}
80101b08:	89 d8                	mov    %ebx,%eax
80101b0a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101b0d:	c9                   	leave  
80101b0e:	c3                   	ret    
80101b0f:	90                   	nop

80101b10 <ilock>:
{
80101b10:	f3 0f 1e fb          	endbr32 
80101b14:	55                   	push   %ebp
80101b15:	89 e5                	mov    %esp,%ebp
80101b17:	56                   	push   %esi
80101b18:	53                   	push   %ebx
80101b19:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80101b1c:	85 db                	test   %ebx,%ebx
80101b1e:	0f 84 b3 00 00 00    	je     80101bd7 <ilock+0xc7>
80101b24:	8b 53 08             	mov    0x8(%ebx),%edx
80101b27:	85 d2                	test   %edx,%edx
80101b29:	0f 8e a8 00 00 00    	jle    80101bd7 <ilock+0xc7>
  acquiresleep(&ip->lock);
80101b2f:	83 ec 0c             	sub    $0xc,%esp
80101b32:	8d 43 0c             	lea    0xc(%ebx),%eax
80101b35:	50                   	push   %eax
80101b36:	e8 55 2b 00 00       	call   80104690 <acquiresleep>
  if(ip->valid == 0){
80101b3b:	8b 43 4c             	mov    0x4c(%ebx),%eax
80101b3e:	83 c4 10             	add    $0x10,%esp
80101b41:	85 c0                	test   %eax,%eax
80101b43:	74 0b                	je     80101b50 <ilock+0x40>
}
80101b45:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101b48:	5b                   	pop    %ebx
80101b49:	5e                   	pop    %esi
80101b4a:	5d                   	pop    %ebp
80101b4b:	c3                   	ret    
80101b4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101b50:	8b 43 04             	mov    0x4(%ebx),%eax
80101b53:	83 ec 08             	sub    $0x8,%esp
80101b56:	c1 e8 03             	shr    $0x3,%eax
80101b59:	03 05 f4 09 11 80    	add    0x801109f4,%eax
80101b5f:	50                   	push   %eax
80101b60:	ff 33                	pushl  (%ebx)
80101b62:	e8 69 e5 ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101b67:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101b6a:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101b6c:	8b 43 04             	mov    0x4(%ebx),%eax
80101b6f:	83 e0 07             	and    $0x7,%eax
80101b72:	c1 e0 06             	shl    $0x6,%eax
80101b75:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101b79:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101b7c:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
80101b7f:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101b83:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101b87:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
80101b8b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
80101b8f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101b93:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101b97:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
80101b9b:	8b 50 fc             	mov    -0x4(%eax),%edx
80101b9e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101ba1:	6a 34                	push   $0x34
80101ba3:	50                   	push   %eax
80101ba4:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101ba7:	50                   	push   %eax
80101ba8:	e8 13 2f 00 00       	call   80104ac0 <memmove>
    brelse(bp);
80101bad:	89 34 24             	mov    %esi,(%esp)
80101bb0:	e8 3b e6 ff ff       	call   801001f0 <brelse>
    if(ip->type == 0)
80101bb5:	83 c4 10             	add    $0x10,%esp
80101bb8:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
80101bbd:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101bc4:	0f 85 7b ff ff ff    	jne    80101b45 <ilock+0x35>
      panic("ilock: no type");
80101bca:	83 ec 0c             	sub    $0xc,%esp
80101bcd:	68 28 76 10 80       	push   $0x80107628
80101bd2:	e8 b9 e7 ff ff       	call   80100390 <panic>
    panic("ilock");
80101bd7:	83 ec 0c             	sub    $0xc,%esp
80101bda:	68 22 76 10 80       	push   $0x80107622
80101bdf:	e8 ac e7 ff ff       	call   80100390 <panic>
80101be4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101beb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101bef:	90                   	nop

80101bf0 <iunlock>:
{
80101bf0:	f3 0f 1e fb          	endbr32 
80101bf4:	55                   	push   %ebp
80101bf5:	89 e5                	mov    %esp,%ebp
80101bf7:	56                   	push   %esi
80101bf8:	53                   	push   %ebx
80101bf9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101bfc:	85 db                	test   %ebx,%ebx
80101bfe:	74 28                	je     80101c28 <iunlock+0x38>
80101c00:	83 ec 0c             	sub    $0xc,%esp
80101c03:	8d 73 0c             	lea    0xc(%ebx),%esi
80101c06:	56                   	push   %esi
80101c07:	e8 24 2b 00 00       	call   80104730 <holdingsleep>
80101c0c:	83 c4 10             	add    $0x10,%esp
80101c0f:	85 c0                	test   %eax,%eax
80101c11:	74 15                	je     80101c28 <iunlock+0x38>
80101c13:	8b 43 08             	mov    0x8(%ebx),%eax
80101c16:	85 c0                	test   %eax,%eax
80101c18:	7e 0e                	jle    80101c28 <iunlock+0x38>
  releasesleep(&ip->lock);
80101c1a:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101c1d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101c20:	5b                   	pop    %ebx
80101c21:	5e                   	pop    %esi
80101c22:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
80101c23:	e9 c8 2a 00 00       	jmp    801046f0 <releasesleep>
    panic("iunlock");
80101c28:	83 ec 0c             	sub    $0xc,%esp
80101c2b:	68 37 76 10 80       	push   $0x80107637
80101c30:	e8 5b e7 ff ff       	call   80100390 <panic>
80101c35:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101c3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101c40 <iput>:
{
80101c40:	f3 0f 1e fb          	endbr32 
80101c44:	55                   	push   %ebp
80101c45:	89 e5                	mov    %esp,%ebp
80101c47:	57                   	push   %edi
80101c48:	56                   	push   %esi
80101c49:	53                   	push   %ebx
80101c4a:	83 ec 28             	sub    $0x28,%esp
80101c4d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
80101c50:	8d 7b 0c             	lea    0xc(%ebx),%edi
80101c53:	57                   	push   %edi
80101c54:	e8 37 2a 00 00       	call   80104690 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80101c59:	8b 53 4c             	mov    0x4c(%ebx),%edx
80101c5c:	83 c4 10             	add    $0x10,%esp
80101c5f:	85 d2                	test   %edx,%edx
80101c61:	74 07                	je     80101c6a <iput+0x2a>
80101c63:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101c68:	74 36                	je     80101ca0 <iput+0x60>
  releasesleep(&ip->lock);
80101c6a:	83 ec 0c             	sub    $0xc,%esp
80101c6d:	57                   	push   %edi
80101c6e:	e8 7d 2a 00 00       	call   801046f0 <releasesleep>
  acquire(&icache.lock);
80101c73:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
80101c7a:	e8 91 2c 00 00       	call   80104910 <acquire>
  ip->ref--;
80101c7f:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101c83:	83 c4 10             	add    $0x10,%esp
80101c86:	c7 45 08 00 0a 11 80 	movl   $0x80110a00,0x8(%ebp)
}
80101c8d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c90:	5b                   	pop    %ebx
80101c91:	5e                   	pop    %esi
80101c92:	5f                   	pop    %edi
80101c93:	5d                   	pop    %ebp
  release(&icache.lock);
80101c94:	e9 37 2d 00 00       	jmp    801049d0 <release>
80101c99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&icache.lock);
80101ca0:	83 ec 0c             	sub    $0xc,%esp
80101ca3:	68 00 0a 11 80       	push   $0x80110a00
80101ca8:	e8 63 2c 00 00       	call   80104910 <acquire>
    int r = ip->ref;
80101cad:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101cb0:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
80101cb7:	e8 14 2d 00 00       	call   801049d0 <release>
    if(r == 1){
80101cbc:	83 c4 10             	add    $0x10,%esp
80101cbf:	83 fe 01             	cmp    $0x1,%esi
80101cc2:	75 a6                	jne    80101c6a <iput+0x2a>
80101cc4:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101cca:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101ccd:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101cd0:	89 cf                	mov    %ecx,%edi
80101cd2:	eb 0b                	jmp    80101cdf <iput+0x9f>
80101cd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101cd8:	83 c6 04             	add    $0x4,%esi
80101cdb:	39 fe                	cmp    %edi,%esi
80101cdd:	74 19                	je     80101cf8 <iput+0xb8>
    if(ip->addrs[i]){
80101cdf:	8b 16                	mov    (%esi),%edx
80101ce1:	85 d2                	test   %edx,%edx
80101ce3:	74 f3                	je     80101cd8 <iput+0x98>
      bfree(ip->dev, ip->addrs[i]);
80101ce5:	8b 03                	mov    (%ebx),%eax
80101ce7:	e8 74 f8 ff ff       	call   80101560 <bfree>
      ip->addrs[i] = 0;
80101cec:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80101cf2:	eb e4                	jmp    80101cd8 <iput+0x98>
80101cf4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101cf8:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80101cfe:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101d01:	85 c0                	test   %eax,%eax
80101d03:	75 33                	jne    80101d38 <iput+0xf8>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
80101d05:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101d08:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80101d0f:	53                   	push   %ebx
80101d10:	e8 3b fd ff ff       	call   80101a50 <iupdate>
      ip->type = 0;
80101d15:	31 c0                	xor    %eax,%eax
80101d17:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80101d1b:	89 1c 24             	mov    %ebx,(%esp)
80101d1e:	e8 2d fd ff ff       	call   80101a50 <iupdate>
      ip->valid = 0;
80101d23:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101d2a:	83 c4 10             	add    $0x10,%esp
80101d2d:	e9 38 ff ff ff       	jmp    80101c6a <iput+0x2a>
80101d32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101d38:	83 ec 08             	sub    $0x8,%esp
80101d3b:	50                   	push   %eax
80101d3c:	ff 33                	pushl  (%ebx)
80101d3e:	e8 8d e3 ff ff       	call   801000d0 <bread>
80101d43:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101d46:	83 c4 10             	add    $0x10,%esp
80101d49:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101d4f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(j = 0; j < NINDIRECT; j++){
80101d52:	8d 70 5c             	lea    0x5c(%eax),%esi
80101d55:	89 cf                	mov    %ecx,%edi
80101d57:	eb 0e                	jmp    80101d67 <iput+0x127>
80101d59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101d60:	83 c6 04             	add    $0x4,%esi
80101d63:	39 f7                	cmp    %esi,%edi
80101d65:	74 19                	je     80101d80 <iput+0x140>
      if(a[j])
80101d67:	8b 16                	mov    (%esi),%edx
80101d69:	85 d2                	test   %edx,%edx
80101d6b:	74 f3                	je     80101d60 <iput+0x120>
        bfree(ip->dev, a[j]);
80101d6d:	8b 03                	mov    (%ebx),%eax
80101d6f:	e8 ec f7 ff ff       	call   80101560 <bfree>
80101d74:	eb ea                	jmp    80101d60 <iput+0x120>
80101d76:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101d7d:	8d 76 00             	lea    0x0(%esi),%esi
    brelse(bp);
80101d80:	83 ec 0c             	sub    $0xc,%esp
80101d83:	ff 75 e4             	pushl  -0x1c(%ebp)
80101d86:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101d89:	e8 62 e4 ff ff       	call   801001f0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101d8e:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101d94:	8b 03                	mov    (%ebx),%eax
80101d96:	e8 c5 f7 ff ff       	call   80101560 <bfree>
    ip->addrs[NDIRECT] = 0;
80101d9b:	83 c4 10             	add    $0x10,%esp
80101d9e:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101da5:	00 00 00 
80101da8:	e9 58 ff ff ff       	jmp    80101d05 <iput+0xc5>
80101dad:	8d 76 00             	lea    0x0(%esi),%esi

80101db0 <iunlockput>:
{
80101db0:	f3 0f 1e fb          	endbr32 
80101db4:	55                   	push   %ebp
80101db5:	89 e5                	mov    %esp,%ebp
80101db7:	53                   	push   %ebx
80101db8:	83 ec 10             	sub    $0x10,%esp
80101dbb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
80101dbe:	53                   	push   %ebx
80101dbf:	e8 2c fe ff ff       	call   80101bf0 <iunlock>
  iput(ip);
80101dc4:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101dc7:	83 c4 10             	add    $0x10,%esp
}
80101dca:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101dcd:	c9                   	leave  
  iput(ip);
80101dce:	e9 6d fe ff ff       	jmp    80101c40 <iput>
80101dd3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101dda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101de0 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101de0:	f3 0f 1e fb          	endbr32 
80101de4:	55                   	push   %ebp
80101de5:	89 e5                	mov    %esp,%ebp
80101de7:	8b 55 08             	mov    0x8(%ebp),%edx
80101dea:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101ded:	8b 0a                	mov    (%edx),%ecx
80101def:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101df2:	8b 4a 04             	mov    0x4(%edx),%ecx
80101df5:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101df8:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101dfc:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101dff:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101e03:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101e07:	8b 52 58             	mov    0x58(%edx),%edx
80101e0a:	89 50 10             	mov    %edx,0x10(%eax)
}
80101e0d:	5d                   	pop    %ebp
80101e0e:	c3                   	ret    
80101e0f:	90                   	nop

80101e10 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101e10:	f3 0f 1e fb          	endbr32 
80101e14:	55                   	push   %ebp
80101e15:	89 e5                	mov    %esp,%ebp
80101e17:	57                   	push   %edi
80101e18:	56                   	push   %esi
80101e19:	53                   	push   %ebx
80101e1a:	83 ec 1c             	sub    $0x1c,%esp
80101e1d:	8b 7d 0c             	mov    0xc(%ebp),%edi
80101e20:	8b 45 08             	mov    0x8(%ebp),%eax
80101e23:	8b 75 10             	mov    0x10(%ebp),%esi
80101e26:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101e29:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101e2c:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101e31:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101e34:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80101e37:	0f 84 a3 00 00 00    	je     80101ee0 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101e3d:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101e40:	8b 40 58             	mov    0x58(%eax),%eax
80101e43:	39 c6                	cmp    %eax,%esi
80101e45:	0f 87 b6 00 00 00    	ja     80101f01 <readi+0xf1>
80101e4b:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101e4e:	31 c9                	xor    %ecx,%ecx
80101e50:	89 da                	mov    %ebx,%edx
80101e52:	01 f2                	add    %esi,%edx
80101e54:	0f 92 c1             	setb   %cl
80101e57:	89 cf                	mov    %ecx,%edi
80101e59:	0f 82 a2 00 00 00    	jb     80101f01 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101e5f:	89 c1                	mov    %eax,%ecx
80101e61:	29 f1                	sub    %esi,%ecx
80101e63:	39 d0                	cmp    %edx,%eax
80101e65:	0f 43 cb             	cmovae %ebx,%ecx
80101e68:	89 4d e4             	mov    %ecx,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101e6b:	85 c9                	test   %ecx,%ecx
80101e6d:	74 63                	je     80101ed2 <readi+0xc2>
80101e6f:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101e70:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101e73:	89 f2                	mov    %esi,%edx
80101e75:	c1 ea 09             	shr    $0x9,%edx
80101e78:	89 d8                	mov    %ebx,%eax
80101e7a:	e8 61 f9 ff ff       	call   801017e0 <bmap>
80101e7f:	83 ec 08             	sub    $0x8,%esp
80101e82:	50                   	push   %eax
80101e83:	ff 33                	pushl  (%ebx)
80101e85:	e8 46 e2 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101e8a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101e8d:	b9 00 02 00 00       	mov    $0x200,%ecx
80101e92:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101e95:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101e97:	89 f0                	mov    %esi,%eax
80101e99:	25 ff 01 00 00       	and    $0x1ff,%eax
80101e9e:	29 fb                	sub    %edi,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101ea0:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101ea3:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101ea5:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101ea9:	39 d9                	cmp    %ebx,%ecx
80101eab:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101eae:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101eaf:	01 df                	add    %ebx,%edi
80101eb1:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101eb3:	50                   	push   %eax
80101eb4:	ff 75 e0             	pushl  -0x20(%ebp)
80101eb7:	e8 04 2c 00 00       	call   80104ac0 <memmove>
    brelse(bp);
80101ebc:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101ebf:	89 14 24             	mov    %edx,(%esp)
80101ec2:	e8 29 e3 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101ec7:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101eca:	83 c4 10             	add    $0x10,%esp
80101ecd:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101ed0:	77 9e                	ja     80101e70 <readi+0x60>
  }
  return n;
80101ed2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101ed5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ed8:	5b                   	pop    %ebx
80101ed9:	5e                   	pop    %esi
80101eda:	5f                   	pop    %edi
80101edb:	5d                   	pop    %ebp
80101edc:	c3                   	ret    
80101edd:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101ee0:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101ee4:	66 83 f8 09          	cmp    $0x9,%ax
80101ee8:	77 17                	ja     80101f01 <readi+0xf1>
80101eea:	8b 04 c5 80 09 11 80 	mov    -0x7feef680(,%eax,8),%eax
80101ef1:	85 c0                	test   %eax,%eax
80101ef3:	74 0c                	je     80101f01 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101ef5:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101ef8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101efb:	5b                   	pop    %ebx
80101efc:	5e                   	pop    %esi
80101efd:	5f                   	pop    %edi
80101efe:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101eff:	ff e0                	jmp    *%eax
      return -1;
80101f01:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101f06:	eb cd                	jmp    80101ed5 <readi+0xc5>
80101f08:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101f0f:	90                   	nop

80101f10 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101f10:	f3 0f 1e fb          	endbr32 
80101f14:	55                   	push   %ebp
80101f15:	89 e5                	mov    %esp,%ebp
80101f17:	57                   	push   %edi
80101f18:	56                   	push   %esi
80101f19:	53                   	push   %ebx
80101f1a:	83 ec 1c             	sub    $0x1c,%esp
80101f1d:	8b 45 08             	mov    0x8(%ebp),%eax
80101f20:	8b 75 0c             	mov    0xc(%ebp),%esi
80101f23:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101f26:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101f2b:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101f2e:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101f31:	8b 75 10             	mov    0x10(%ebp),%esi
80101f34:	89 7d e0             	mov    %edi,-0x20(%ebp)
  if(ip->type == T_DEV){
80101f37:	0f 84 b3 00 00 00    	je     80101ff0 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101f3d:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101f40:	39 70 58             	cmp    %esi,0x58(%eax)
80101f43:	0f 82 e3 00 00 00    	jb     8010202c <writei+0x11c>
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101f49:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101f4c:	89 f8                	mov    %edi,%eax
80101f4e:	01 f0                	add    %esi,%eax
80101f50:	0f 82 d6 00 00 00    	jb     8010202c <writei+0x11c>
80101f56:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101f5b:	0f 87 cb 00 00 00    	ja     8010202c <writei+0x11c>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101f61:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101f68:	85 ff                	test   %edi,%edi
80101f6a:	74 75                	je     80101fe1 <writei+0xd1>
80101f6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101f70:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101f73:	89 f2                	mov    %esi,%edx
80101f75:	c1 ea 09             	shr    $0x9,%edx
80101f78:	89 f8                	mov    %edi,%eax
80101f7a:	e8 61 f8 ff ff       	call   801017e0 <bmap>
80101f7f:	83 ec 08             	sub    $0x8,%esp
80101f82:	50                   	push   %eax
80101f83:	ff 37                	pushl  (%edi)
80101f85:	e8 46 e1 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101f8a:	b9 00 02 00 00       	mov    $0x200,%ecx
80101f8f:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101f92:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101f95:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101f97:	89 f0                	mov    %esi,%eax
80101f99:	83 c4 0c             	add    $0xc,%esp
80101f9c:	25 ff 01 00 00       	and    $0x1ff,%eax
80101fa1:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101fa3:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101fa7:	39 d9                	cmp    %ebx,%ecx
80101fa9:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101fac:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101fad:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101faf:	ff 75 dc             	pushl  -0x24(%ebp)
80101fb2:	50                   	push   %eax
80101fb3:	e8 08 2b 00 00       	call   80104ac0 <memmove>
    log_write(bp);
80101fb8:	89 3c 24             	mov    %edi,(%esp)
80101fbb:	e8 00 13 00 00       	call   801032c0 <log_write>
    brelse(bp);
80101fc0:	89 3c 24             	mov    %edi,(%esp)
80101fc3:	e8 28 e2 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101fc8:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101fcb:	83 c4 10             	add    $0x10,%esp
80101fce:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101fd1:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101fd4:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101fd7:	77 97                	ja     80101f70 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101fd9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101fdc:	3b 70 58             	cmp    0x58(%eax),%esi
80101fdf:	77 37                	ja     80102018 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101fe1:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101fe4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fe7:	5b                   	pop    %ebx
80101fe8:	5e                   	pop    %esi
80101fe9:	5f                   	pop    %edi
80101fea:	5d                   	pop    %ebp
80101feb:	c3                   	ret    
80101fec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101ff0:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101ff4:	66 83 f8 09          	cmp    $0x9,%ax
80101ff8:	77 32                	ja     8010202c <writei+0x11c>
80101ffa:	8b 04 c5 84 09 11 80 	mov    -0x7feef67c(,%eax,8),%eax
80102001:	85 c0                	test   %eax,%eax
80102003:	74 27                	je     8010202c <writei+0x11c>
    return devsw[ip->major].write(ip, src, n);
80102005:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80102008:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010200b:	5b                   	pop    %ebx
8010200c:	5e                   	pop    %esi
8010200d:	5f                   	pop    %edi
8010200e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
8010200f:	ff e0                	jmp    *%eax
80102011:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80102018:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
8010201b:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
8010201e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80102021:	50                   	push   %eax
80102022:	e8 29 fa ff ff       	call   80101a50 <iupdate>
80102027:	83 c4 10             	add    $0x10,%esp
8010202a:	eb b5                	jmp    80101fe1 <writei+0xd1>
      return -1;
8010202c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102031:	eb b1                	jmp    80101fe4 <writei+0xd4>
80102033:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010203a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102040 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80102040:	f3 0f 1e fb          	endbr32 
80102044:	55                   	push   %ebp
80102045:	89 e5                	mov    %esp,%ebp
80102047:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
8010204a:	6a 0e                	push   $0xe
8010204c:	ff 75 0c             	pushl  0xc(%ebp)
8010204f:	ff 75 08             	pushl  0x8(%ebp)
80102052:	e8 d9 2a 00 00       	call   80104b30 <strncmp>
}
80102057:	c9                   	leave  
80102058:	c3                   	ret    
80102059:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102060 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80102060:	f3 0f 1e fb          	endbr32 
80102064:	55                   	push   %ebp
80102065:	89 e5                	mov    %esp,%ebp
80102067:	57                   	push   %edi
80102068:	56                   	push   %esi
80102069:	53                   	push   %ebx
8010206a:	83 ec 1c             	sub    $0x1c,%esp
8010206d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80102070:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80102075:	0f 85 89 00 00 00    	jne    80102104 <dirlookup+0xa4>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
8010207b:	8b 53 58             	mov    0x58(%ebx),%edx
8010207e:	31 ff                	xor    %edi,%edi
80102080:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102083:	85 d2                	test   %edx,%edx
80102085:	74 42                	je     801020c9 <dirlookup+0x69>
80102087:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010208e:	66 90                	xchg   %ax,%ax
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102090:	6a 10                	push   $0x10
80102092:	57                   	push   %edi
80102093:	56                   	push   %esi
80102094:	53                   	push   %ebx
80102095:	e8 76 fd ff ff       	call   80101e10 <readi>
8010209a:	83 c4 10             	add    $0x10,%esp
8010209d:	83 f8 10             	cmp    $0x10,%eax
801020a0:	75 55                	jne    801020f7 <dirlookup+0x97>
      panic("dirlookup read");
    if(de.inum == 0)
801020a2:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801020a7:	74 18                	je     801020c1 <dirlookup+0x61>
  return strncmp(s, t, DIRSIZ);
801020a9:	83 ec 04             	sub    $0x4,%esp
801020ac:	8d 45 da             	lea    -0x26(%ebp),%eax
801020af:	6a 0e                	push   $0xe
801020b1:	50                   	push   %eax
801020b2:	ff 75 0c             	pushl  0xc(%ebp)
801020b5:	e8 76 2a 00 00       	call   80104b30 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
801020ba:	83 c4 10             	add    $0x10,%esp
801020bd:	85 c0                	test   %eax,%eax
801020bf:	74 17                	je     801020d8 <dirlookup+0x78>
  for(off = 0; off < dp->size; off += sizeof(de)){
801020c1:	83 c7 10             	add    $0x10,%edi
801020c4:	3b 7b 58             	cmp    0x58(%ebx),%edi
801020c7:	72 c7                	jb     80102090 <dirlookup+0x30>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
801020c9:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801020cc:	31 c0                	xor    %eax,%eax
}
801020ce:	5b                   	pop    %ebx
801020cf:	5e                   	pop    %esi
801020d0:	5f                   	pop    %edi
801020d1:	5d                   	pop    %ebp
801020d2:	c3                   	ret    
801020d3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801020d7:	90                   	nop
      if(poff)
801020d8:	8b 45 10             	mov    0x10(%ebp),%eax
801020db:	85 c0                	test   %eax,%eax
801020dd:	74 05                	je     801020e4 <dirlookup+0x84>
        *poff = off;
801020df:	8b 45 10             	mov    0x10(%ebp),%eax
801020e2:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
801020e4:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
801020e8:	8b 03                	mov    (%ebx),%eax
801020ea:	e8 01 f6 ff ff       	call   801016f0 <iget>
}
801020ef:	8d 65 f4             	lea    -0xc(%ebp),%esp
801020f2:	5b                   	pop    %ebx
801020f3:	5e                   	pop    %esi
801020f4:	5f                   	pop    %edi
801020f5:	5d                   	pop    %ebp
801020f6:	c3                   	ret    
      panic("dirlookup read");
801020f7:	83 ec 0c             	sub    $0xc,%esp
801020fa:	68 51 76 10 80       	push   $0x80107651
801020ff:	e8 8c e2 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
80102104:	83 ec 0c             	sub    $0xc,%esp
80102107:	68 3f 76 10 80       	push   $0x8010763f
8010210c:	e8 7f e2 ff ff       	call   80100390 <panic>
80102111:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102118:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010211f:	90                   	nop

80102120 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80102120:	55                   	push   %ebp
80102121:	89 e5                	mov    %esp,%ebp
80102123:	57                   	push   %edi
80102124:	56                   	push   %esi
80102125:	53                   	push   %ebx
80102126:	89 c3                	mov    %eax,%ebx
80102128:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
8010212b:	80 38 2f             	cmpb   $0x2f,(%eax)
{
8010212e:	89 55 e0             	mov    %edx,-0x20(%ebp)
80102131:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if(*path == '/')
80102134:	0f 84 86 01 00 00    	je     801022c0 <namex+0x1a0>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
8010213a:	e8 d1 1b 00 00       	call   80103d10 <myproc>
  acquire(&icache.lock);
8010213f:	83 ec 0c             	sub    $0xc,%esp
80102142:	89 df                	mov    %ebx,%edi
    ip = idup(myproc()->cwd);
80102144:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80102147:	68 00 0a 11 80       	push   $0x80110a00
8010214c:	e8 bf 27 00 00       	call   80104910 <acquire>
  ip->ref++;
80102151:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80102155:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
8010215c:	e8 6f 28 00 00       	call   801049d0 <release>
80102161:	83 c4 10             	add    $0x10,%esp
80102164:	eb 0d                	jmp    80102173 <namex+0x53>
80102166:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010216d:	8d 76 00             	lea    0x0(%esi),%esi
    path++;
80102170:	83 c7 01             	add    $0x1,%edi
  while(*path == '/')
80102173:	0f b6 07             	movzbl (%edi),%eax
80102176:	3c 2f                	cmp    $0x2f,%al
80102178:	74 f6                	je     80102170 <namex+0x50>
  if(*path == 0)
8010217a:	84 c0                	test   %al,%al
8010217c:	0f 84 ee 00 00 00    	je     80102270 <namex+0x150>
  while(*path != '/' && *path != 0)
80102182:	0f b6 07             	movzbl (%edi),%eax
80102185:	84 c0                	test   %al,%al
80102187:	0f 84 fb 00 00 00    	je     80102288 <namex+0x168>
8010218d:	89 fb                	mov    %edi,%ebx
8010218f:	3c 2f                	cmp    $0x2f,%al
80102191:	0f 84 f1 00 00 00    	je     80102288 <namex+0x168>
80102197:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010219e:	66 90                	xchg   %ax,%ax
801021a0:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
    path++;
801021a4:	83 c3 01             	add    $0x1,%ebx
  while(*path != '/' && *path != 0)
801021a7:	3c 2f                	cmp    $0x2f,%al
801021a9:	74 04                	je     801021af <namex+0x8f>
801021ab:	84 c0                	test   %al,%al
801021ad:	75 f1                	jne    801021a0 <namex+0x80>
  len = path - s;
801021af:	89 d8                	mov    %ebx,%eax
801021b1:	29 f8                	sub    %edi,%eax
  if(len >= DIRSIZ)
801021b3:	83 f8 0d             	cmp    $0xd,%eax
801021b6:	0f 8e 84 00 00 00    	jle    80102240 <namex+0x120>
    memmove(name, s, DIRSIZ);
801021bc:	83 ec 04             	sub    $0x4,%esp
801021bf:	6a 0e                	push   $0xe
801021c1:	57                   	push   %edi
    path++;
801021c2:	89 df                	mov    %ebx,%edi
    memmove(name, s, DIRSIZ);
801021c4:	ff 75 e4             	pushl  -0x1c(%ebp)
801021c7:	e8 f4 28 00 00       	call   80104ac0 <memmove>
801021cc:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
801021cf:	80 3b 2f             	cmpb   $0x2f,(%ebx)
801021d2:	75 0c                	jne    801021e0 <namex+0xc0>
801021d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
801021d8:	83 c7 01             	add    $0x1,%edi
  while(*path == '/')
801021db:	80 3f 2f             	cmpb   $0x2f,(%edi)
801021de:	74 f8                	je     801021d8 <namex+0xb8>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
801021e0:	83 ec 0c             	sub    $0xc,%esp
801021e3:	56                   	push   %esi
801021e4:	e8 27 f9 ff ff       	call   80101b10 <ilock>
    if(ip->type != T_DIR){
801021e9:	83 c4 10             	add    $0x10,%esp
801021ec:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801021f1:	0f 85 a1 00 00 00    	jne    80102298 <namex+0x178>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
801021f7:	8b 55 e0             	mov    -0x20(%ebp),%edx
801021fa:	85 d2                	test   %edx,%edx
801021fc:	74 09                	je     80102207 <namex+0xe7>
801021fe:	80 3f 00             	cmpb   $0x0,(%edi)
80102201:	0f 84 d9 00 00 00    	je     801022e0 <namex+0x1c0>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80102207:	83 ec 04             	sub    $0x4,%esp
8010220a:	6a 00                	push   $0x0
8010220c:	ff 75 e4             	pushl  -0x1c(%ebp)
8010220f:	56                   	push   %esi
80102210:	e8 4b fe ff ff       	call   80102060 <dirlookup>
80102215:	83 c4 10             	add    $0x10,%esp
80102218:	89 c3                	mov    %eax,%ebx
8010221a:	85 c0                	test   %eax,%eax
8010221c:	74 7a                	je     80102298 <namex+0x178>
  iunlock(ip);
8010221e:	83 ec 0c             	sub    $0xc,%esp
80102221:	56                   	push   %esi
80102222:	e8 c9 f9 ff ff       	call   80101bf0 <iunlock>
  iput(ip);
80102227:	89 34 24             	mov    %esi,(%esp)
8010222a:	89 de                	mov    %ebx,%esi
8010222c:	e8 0f fa ff ff       	call   80101c40 <iput>
80102231:	83 c4 10             	add    $0x10,%esp
80102234:	e9 3a ff ff ff       	jmp    80102173 <namex+0x53>
80102239:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102240:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80102243:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
80102246:	89 4d dc             	mov    %ecx,-0x24(%ebp)
    memmove(name, s, len);
80102249:	83 ec 04             	sub    $0x4,%esp
8010224c:	50                   	push   %eax
8010224d:	57                   	push   %edi
    name[len] = 0;
8010224e:	89 df                	mov    %ebx,%edi
    memmove(name, s, len);
80102250:	ff 75 e4             	pushl  -0x1c(%ebp)
80102253:	e8 68 28 00 00       	call   80104ac0 <memmove>
    name[len] = 0;
80102258:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010225b:	83 c4 10             	add    $0x10,%esp
8010225e:	c6 00 00             	movb   $0x0,(%eax)
80102261:	e9 69 ff ff ff       	jmp    801021cf <namex+0xaf>
80102266:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010226d:	8d 76 00             	lea    0x0(%esi),%esi
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80102270:	8b 45 e0             	mov    -0x20(%ebp),%eax
80102273:	85 c0                	test   %eax,%eax
80102275:	0f 85 85 00 00 00    	jne    80102300 <namex+0x1e0>
    iput(ip);
    return 0;
  }
  return ip;
}
8010227b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010227e:	89 f0                	mov    %esi,%eax
80102280:	5b                   	pop    %ebx
80102281:	5e                   	pop    %esi
80102282:	5f                   	pop    %edi
80102283:	5d                   	pop    %ebp
80102284:	c3                   	ret    
80102285:	8d 76 00             	lea    0x0(%esi),%esi
  while(*path != '/' && *path != 0)
80102288:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010228b:	89 fb                	mov    %edi,%ebx
8010228d:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102290:	31 c0                	xor    %eax,%eax
80102292:	eb b5                	jmp    80102249 <namex+0x129>
80102294:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
80102298:	83 ec 0c             	sub    $0xc,%esp
8010229b:	56                   	push   %esi
8010229c:	e8 4f f9 ff ff       	call   80101bf0 <iunlock>
  iput(ip);
801022a1:	89 34 24             	mov    %esi,(%esp)
      return 0;
801022a4:	31 f6                	xor    %esi,%esi
  iput(ip);
801022a6:	e8 95 f9 ff ff       	call   80101c40 <iput>
      return 0;
801022ab:	83 c4 10             	add    $0x10,%esp
}
801022ae:	8d 65 f4             	lea    -0xc(%ebp),%esp
801022b1:	89 f0                	mov    %esi,%eax
801022b3:	5b                   	pop    %ebx
801022b4:	5e                   	pop    %esi
801022b5:	5f                   	pop    %edi
801022b6:	5d                   	pop    %ebp
801022b7:	c3                   	ret    
801022b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801022bf:	90                   	nop
    ip = iget(ROOTDEV, ROOTINO);
801022c0:	ba 01 00 00 00       	mov    $0x1,%edx
801022c5:	b8 01 00 00 00       	mov    $0x1,%eax
801022ca:	89 df                	mov    %ebx,%edi
801022cc:	e8 1f f4 ff ff       	call   801016f0 <iget>
801022d1:	89 c6                	mov    %eax,%esi
801022d3:	e9 9b fe ff ff       	jmp    80102173 <namex+0x53>
801022d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801022df:	90                   	nop
      iunlock(ip);
801022e0:	83 ec 0c             	sub    $0xc,%esp
801022e3:	56                   	push   %esi
801022e4:	e8 07 f9 ff ff       	call   80101bf0 <iunlock>
      return ip;
801022e9:	83 c4 10             	add    $0x10,%esp
}
801022ec:	8d 65 f4             	lea    -0xc(%ebp),%esp
801022ef:	89 f0                	mov    %esi,%eax
801022f1:	5b                   	pop    %ebx
801022f2:	5e                   	pop    %esi
801022f3:	5f                   	pop    %edi
801022f4:	5d                   	pop    %ebp
801022f5:	c3                   	ret    
801022f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801022fd:	8d 76 00             	lea    0x0(%esi),%esi
    iput(ip);
80102300:	83 ec 0c             	sub    $0xc,%esp
80102303:	56                   	push   %esi
    return 0;
80102304:	31 f6                	xor    %esi,%esi
    iput(ip);
80102306:	e8 35 f9 ff ff       	call   80101c40 <iput>
    return 0;
8010230b:	83 c4 10             	add    $0x10,%esp
8010230e:	e9 68 ff ff ff       	jmp    8010227b <namex+0x15b>
80102313:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010231a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102320 <dirlink>:
{
80102320:	f3 0f 1e fb          	endbr32 
80102324:	55                   	push   %ebp
80102325:	89 e5                	mov    %esp,%ebp
80102327:	57                   	push   %edi
80102328:	56                   	push   %esi
80102329:	53                   	push   %ebx
8010232a:	83 ec 20             	sub    $0x20,%esp
8010232d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80102330:	6a 00                	push   $0x0
80102332:	ff 75 0c             	pushl  0xc(%ebp)
80102335:	53                   	push   %ebx
80102336:	e8 25 fd ff ff       	call   80102060 <dirlookup>
8010233b:	83 c4 10             	add    $0x10,%esp
8010233e:	85 c0                	test   %eax,%eax
80102340:	75 6b                	jne    801023ad <dirlink+0x8d>
  for(off = 0; off < dp->size; off += sizeof(de)){
80102342:	8b 7b 58             	mov    0x58(%ebx),%edi
80102345:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102348:	85 ff                	test   %edi,%edi
8010234a:	74 2d                	je     80102379 <dirlink+0x59>
8010234c:	31 ff                	xor    %edi,%edi
8010234e:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102351:	eb 0d                	jmp    80102360 <dirlink+0x40>
80102353:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102357:	90                   	nop
80102358:	83 c7 10             	add    $0x10,%edi
8010235b:	3b 7b 58             	cmp    0x58(%ebx),%edi
8010235e:	73 19                	jae    80102379 <dirlink+0x59>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102360:	6a 10                	push   $0x10
80102362:	57                   	push   %edi
80102363:	56                   	push   %esi
80102364:	53                   	push   %ebx
80102365:	e8 a6 fa ff ff       	call   80101e10 <readi>
8010236a:	83 c4 10             	add    $0x10,%esp
8010236d:	83 f8 10             	cmp    $0x10,%eax
80102370:	75 4e                	jne    801023c0 <dirlink+0xa0>
    if(de.inum == 0)
80102372:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80102377:	75 df                	jne    80102358 <dirlink+0x38>
  strncpy(de.name, name, DIRSIZ);
80102379:	83 ec 04             	sub    $0x4,%esp
8010237c:	8d 45 da             	lea    -0x26(%ebp),%eax
8010237f:	6a 0e                	push   $0xe
80102381:	ff 75 0c             	pushl  0xc(%ebp)
80102384:	50                   	push   %eax
80102385:	e8 f6 27 00 00       	call   80104b80 <strncpy>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010238a:	6a 10                	push   $0x10
  de.inum = inum;
8010238c:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010238f:	57                   	push   %edi
80102390:	56                   	push   %esi
80102391:	53                   	push   %ebx
  de.inum = inum;
80102392:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102396:	e8 75 fb ff ff       	call   80101f10 <writei>
8010239b:	83 c4 20             	add    $0x20,%esp
8010239e:	83 f8 10             	cmp    $0x10,%eax
801023a1:	75 2a                	jne    801023cd <dirlink+0xad>
  return 0;
801023a3:	31 c0                	xor    %eax,%eax
}
801023a5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801023a8:	5b                   	pop    %ebx
801023a9:	5e                   	pop    %esi
801023aa:	5f                   	pop    %edi
801023ab:	5d                   	pop    %ebp
801023ac:	c3                   	ret    
    iput(ip);
801023ad:	83 ec 0c             	sub    $0xc,%esp
801023b0:	50                   	push   %eax
801023b1:	e8 8a f8 ff ff       	call   80101c40 <iput>
    return -1;
801023b6:	83 c4 10             	add    $0x10,%esp
801023b9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801023be:	eb e5                	jmp    801023a5 <dirlink+0x85>
      panic("dirlink read");
801023c0:	83 ec 0c             	sub    $0xc,%esp
801023c3:	68 60 76 10 80       	push   $0x80107660
801023c8:	e8 c3 df ff ff       	call   80100390 <panic>
    panic("dirlink");
801023cd:	83 ec 0c             	sub    $0xc,%esp
801023d0:	68 3e 7c 10 80       	push   $0x80107c3e
801023d5:	e8 b6 df ff ff       	call   80100390 <panic>
801023da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801023e0 <namei>:

struct inode*
namei(char *path)
{
801023e0:	f3 0f 1e fb          	endbr32 
801023e4:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
801023e5:	31 d2                	xor    %edx,%edx
{
801023e7:	89 e5                	mov    %esp,%ebp
801023e9:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
801023ec:	8b 45 08             	mov    0x8(%ebp),%eax
801023ef:	8d 4d ea             	lea    -0x16(%ebp),%ecx
801023f2:	e8 29 fd ff ff       	call   80102120 <namex>
}
801023f7:	c9                   	leave  
801023f8:	c3                   	ret    
801023f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102400 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102400:	f3 0f 1e fb          	endbr32 
80102404:	55                   	push   %ebp
  return namex(path, 1, name);
80102405:	ba 01 00 00 00       	mov    $0x1,%edx
{
8010240a:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
8010240c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010240f:	8b 45 08             	mov    0x8(%ebp),%eax
}
80102412:	5d                   	pop    %ebp
  return namex(path, 1, name);
80102413:	e9 08 fd ff ff       	jmp    80102120 <namex>
80102418:	66 90                	xchg   %ax,%ax
8010241a:	66 90                	xchg   %ax,%ax
8010241c:	66 90                	xchg   %ax,%ax
8010241e:	66 90                	xchg   %ax,%ax

80102420 <idestart>:
80102420:	55                   	push   %ebp
80102421:	89 e5                	mov    %esp,%ebp
80102423:	57                   	push   %edi
80102424:	56                   	push   %esi
80102425:	53                   	push   %ebx
80102426:	83 ec 0c             	sub    $0xc,%esp
80102429:	85 c0                	test   %eax,%eax
8010242b:	0f 84 b4 00 00 00    	je     801024e5 <idestart+0xc5>
80102431:	8b 70 08             	mov    0x8(%eax),%esi
80102434:	89 c3                	mov    %eax,%ebx
80102436:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
8010243c:	0f 87 96 00 00 00    	ja     801024d8 <idestart+0xb8>
80102442:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102447:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010244e:	66 90                	xchg   %ax,%ax
80102450:	89 ca                	mov    %ecx,%edx
80102452:	ec                   	in     (%dx),%al
80102453:	83 e0 c0             	and    $0xffffffc0,%eax
80102456:	3c 40                	cmp    $0x40,%al
80102458:	75 f6                	jne    80102450 <idestart+0x30>
8010245a:	31 ff                	xor    %edi,%edi
8010245c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102461:	89 f8                	mov    %edi,%eax
80102463:	ee                   	out    %al,(%dx)
80102464:	b8 01 00 00 00       	mov    $0x1,%eax
80102469:	ba f2 01 00 00       	mov    $0x1f2,%edx
8010246e:	ee                   	out    %al,(%dx)
8010246f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80102474:	89 f0                	mov    %esi,%eax
80102476:	ee                   	out    %al,(%dx)
80102477:	89 f0                	mov    %esi,%eax
80102479:	ba f4 01 00 00       	mov    $0x1f4,%edx
8010247e:	c1 f8 08             	sar    $0x8,%eax
80102481:	ee                   	out    %al,(%dx)
80102482:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102487:	89 f8                	mov    %edi,%eax
80102489:	ee                   	out    %al,(%dx)
8010248a:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
8010248e:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102493:	c1 e0 04             	shl    $0x4,%eax
80102496:	83 e0 10             	and    $0x10,%eax
80102499:	83 c8 e0             	or     $0xffffffe0,%eax
8010249c:	ee                   	out    %al,(%dx)
8010249d:	f6 03 04             	testb  $0x4,(%ebx)
801024a0:	75 16                	jne    801024b8 <idestart+0x98>
801024a2:	b8 20 00 00 00       	mov    $0x20,%eax
801024a7:	89 ca                	mov    %ecx,%edx
801024a9:	ee                   	out    %al,(%dx)
801024aa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801024ad:	5b                   	pop    %ebx
801024ae:	5e                   	pop    %esi
801024af:	5f                   	pop    %edi
801024b0:	5d                   	pop    %ebp
801024b1:	c3                   	ret    
801024b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801024b8:	b8 30 00 00 00       	mov    $0x30,%eax
801024bd:	89 ca                	mov    %ecx,%edx
801024bf:	ee                   	out    %al,(%dx)
801024c0:	b9 80 00 00 00       	mov    $0x80,%ecx
801024c5:	8d 73 5c             	lea    0x5c(%ebx),%esi
801024c8:	ba f0 01 00 00       	mov    $0x1f0,%edx
801024cd:	fc                   	cld    
801024ce:	f3 6f                	rep outsl %ds:(%esi),(%dx)
801024d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801024d3:	5b                   	pop    %ebx
801024d4:	5e                   	pop    %esi
801024d5:	5f                   	pop    %edi
801024d6:	5d                   	pop    %ebp
801024d7:	c3                   	ret    
801024d8:	83 ec 0c             	sub    $0xc,%esp
801024db:	68 cc 76 10 80       	push   $0x801076cc
801024e0:	e8 ab de ff ff       	call   80100390 <panic>
801024e5:	83 ec 0c             	sub    $0xc,%esp
801024e8:	68 c3 76 10 80       	push   $0x801076c3
801024ed:	e8 9e de ff ff       	call   80100390 <panic>
801024f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801024f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102500 <ideinit>:
80102500:	f3 0f 1e fb          	endbr32 
80102504:	55                   	push   %ebp
80102505:	89 e5                	mov    %esp,%ebp
80102507:	83 ec 10             	sub    $0x10,%esp
8010250a:	68 de 76 10 80       	push   $0x801076de
8010250f:	68 a0 a5 10 80       	push   $0x8010a5a0
80102514:	e8 77 22 00 00       	call   80104790 <initlock>
80102519:	58                   	pop    %eax
8010251a:	a1 20 2d 11 80       	mov    0x80112d20,%eax
8010251f:	5a                   	pop    %edx
80102520:	83 e8 01             	sub    $0x1,%eax
80102523:	50                   	push   %eax
80102524:	6a 0e                	push   $0xe
80102526:	e8 b5 02 00 00       	call   801027e0 <ioapicenable>
8010252b:	83 c4 10             	add    $0x10,%esp
8010252e:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102533:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102537:	90                   	nop
80102538:	ec                   	in     (%dx),%al
80102539:	83 e0 c0             	and    $0xffffffc0,%eax
8010253c:	3c 40                	cmp    $0x40,%al
8010253e:	75 f8                	jne    80102538 <ideinit+0x38>
80102540:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
80102545:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010254a:	ee                   	out    %al,(%dx)
8010254b:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
80102550:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102555:	eb 0e                	jmp    80102565 <ideinit+0x65>
80102557:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010255e:	66 90                	xchg   %ax,%ax
80102560:	83 e9 01             	sub    $0x1,%ecx
80102563:	74 0f                	je     80102574 <ideinit+0x74>
80102565:	ec                   	in     (%dx),%al
80102566:	84 c0                	test   %al,%al
80102568:	74 f6                	je     80102560 <ideinit+0x60>
8010256a:	c7 05 80 a5 10 80 01 	movl   $0x1,0x8010a580
80102571:	00 00 00 
80102574:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102579:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010257e:	ee                   	out    %al,(%dx)
8010257f:	c9                   	leave  
80102580:	c3                   	ret    
80102581:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102588:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010258f:	90                   	nop

80102590 <ideintr>:
80102590:	f3 0f 1e fb          	endbr32 
80102594:	55                   	push   %ebp
80102595:	89 e5                	mov    %esp,%ebp
80102597:	57                   	push   %edi
80102598:	56                   	push   %esi
80102599:	53                   	push   %ebx
8010259a:	83 ec 18             	sub    $0x18,%esp
8010259d:	68 a0 a5 10 80       	push   $0x8010a5a0
801025a2:	e8 69 23 00 00       	call   80104910 <acquire>
801025a7:	8b 1d 84 a5 10 80    	mov    0x8010a584,%ebx
801025ad:	83 c4 10             	add    $0x10,%esp
801025b0:	85 db                	test   %ebx,%ebx
801025b2:	74 5f                	je     80102613 <ideintr+0x83>
801025b4:	8b 43 58             	mov    0x58(%ebx),%eax
801025b7:	a3 84 a5 10 80       	mov    %eax,0x8010a584
801025bc:	8b 33                	mov    (%ebx),%esi
801025be:	f7 c6 04 00 00 00    	test   $0x4,%esi
801025c4:	75 2b                	jne    801025f1 <ideintr+0x61>
801025c6:	ba f7 01 00 00       	mov    $0x1f7,%edx
801025cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801025cf:	90                   	nop
801025d0:	ec                   	in     (%dx),%al
801025d1:	89 c1                	mov    %eax,%ecx
801025d3:	83 e1 c0             	and    $0xffffffc0,%ecx
801025d6:	80 f9 40             	cmp    $0x40,%cl
801025d9:	75 f5                	jne    801025d0 <ideintr+0x40>
801025db:	a8 21                	test   $0x21,%al
801025dd:	75 12                	jne    801025f1 <ideintr+0x61>
801025df:	8d 7b 5c             	lea    0x5c(%ebx),%edi
801025e2:	b9 80 00 00 00       	mov    $0x80,%ecx
801025e7:	ba f0 01 00 00       	mov    $0x1f0,%edx
801025ec:	fc                   	cld    
801025ed:	f3 6d                	rep insl (%dx),%es:(%edi)
801025ef:	8b 33                	mov    (%ebx),%esi
801025f1:	83 e6 fb             	and    $0xfffffffb,%esi
801025f4:	83 ec 0c             	sub    $0xc,%esp
801025f7:	83 ce 02             	or     $0x2,%esi
801025fa:	89 33                	mov    %esi,(%ebx)
801025fc:	53                   	push   %ebx
801025fd:	e8 8e 1e 00 00       	call   80104490 <wakeup>
80102602:	a1 84 a5 10 80       	mov    0x8010a584,%eax
80102607:	83 c4 10             	add    $0x10,%esp
8010260a:	85 c0                	test   %eax,%eax
8010260c:	74 05                	je     80102613 <ideintr+0x83>
8010260e:	e8 0d fe ff ff       	call   80102420 <idestart>
80102613:	83 ec 0c             	sub    $0xc,%esp
80102616:	68 a0 a5 10 80       	push   $0x8010a5a0
8010261b:	e8 b0 23 00 00       	call   801049d0 <release>
80102620:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102623:	5b                   	pop    %ebx
80102624:	5e                   	pop    %esi
80102625:	5f                   	pop    %edi
80102626:	5d                   	pop    %ebp
80102627:	c3                   	ret    
80102628:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010262f:	90                   	nop

80102630 <iderw>:
80102630:	f3 0f 1e fb          	endbr32 
80102634:	55                   	push   %ebp
80102635:	89 e5                	mov    %esp,%ebp
80102637:	53                   	push   %ebx
80102638:	83 ec 10             	sub    $0x10,%esp
8010263b:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010263e:	8d 43 0c             	lea    0xc(%ebx),%eax
80102641:	50                   	push   %eax
80102642:	e8 e9 20 00 00       	call   80104730 <holdingsleep>
80102647:	83 c4 10             	add    $0x10,%esp
8010264a:	85 c0                	test   %eax,%eax
8010264c:	0f 84 cf 00 00 00    	je     80102721 <iderw+0xf1>
80102652:	8b 03                	mov    (%ebx),%eax
80102654:	83 e0 06             	and    $0x6,%eax
80102657:	83 f8 02             	cmp    $0x2,%eax
8010265a:	0f 84 b4 00 00 00    	je     80102714 <iderw+0xe4>
80102660:	8b 53 04             	mov    0x4(%ebx),%edx
80102663:	85 d2                	test   %edx,%edx
80102665:	74 0d                	je     80102674 <iderw+0x44>
80102667:	a1 80 a5 10 80       	mov    0x8010a580,%eax
8010266c:	85 c0                	test   %eax,%eax
8010266e:	0f 84 93 00 00 00    	je     80102707 <iderw+0xd7>
80102674:	83 ec 0c             	sub    $0xc,%esp
80102677:	68 a0 a5 10 80       	push   $0x8010a5a0
8010267c:	e8 8f 22 00 00       	call   80104910 <acquire>
80102681:	a1 84 a5 10 80       	mov    0x8010a584,%eax
80102686:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
8010268d:	83 c4 10             	add    $0x10,%esp
80102690:	85 c0                	test   %eax,%eax
80102692:	74 6c                	je     80102700 <iderw+0xd0>
80102694:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102698:	89 c2                	mov    %eax,%edx
8010269a:	8b 40 58             	mov    0x58(%eax),%eax
8010269d:	85 c0                	test   %eax,%eax
8010269f:	75 f7                	jne    80102698 <iderw+0x68>
801026a1:	83 c2 58             	add    $0x58,%edx
801026a4:	89 1a                	mov    %ebx,(%edx)
801026a6:	39 1d 84 a5 10 80    	cmp    %ebx,0x8010a584
801026ac:	74 42                	je     801026f0 <iderw+0xc0>
801026ae:	8b 03                	mov    (%ebx),%eax
801026b0:	83 e0 06             	and    $0x6,%eax
801026b3:	83 f8 02             	cmp    $0x2,%eax
801026b6:	74 23                	je     801026db <iderw+0xab>
801026b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801026bf:	90                   	nop
801026c0:	83 ec 08             	sub    $0x8,%esp
801026c3:	68 a0 a5 10 80       	push   $0x8010a5a0
801026c8:	53                   	push   %ebx
801026c9:	e8 02 1c 00 00       	call   801042d0 <sleep>
801026ce:	8b 03                	mov    (%ebx),%eax
801026d0:	83 c4 10             	add    $0x10,%esp
801026d3:	83 e0 06             	and    $0x6,%eax
801026d6:	83 f8 02             	cmp    $0x2,%eax
801026d9:	75 e5                	jne    801026c0 <iderw+0x90>
801026db:	c7 45 08 a0 a5 10 80 	movl   $0x8010a5a0,0x8(%ebp)
801026e2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801026e5:	c9                   	leave  
801026e6:	e9 e5 22 00 00       	jmp    801049d0 <release>
801026eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801026ef:	90                   	nop
801026f0:	89 d8                	mov    %ebx,%eax
801026f2:	e8 29 fd ff ff       	call   80102420 <idestart>
801026f7:	eb b5                	jmp    801026ae <iderw+0x7e>
801026f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102700:	ba 84 a5 10 80       	mov    $0x8010a584,%edx
80102705:	eb 9d                	jmp    801026a4 <iderw+0x74>
80102707:	83 ec 0c             	sub    $0xc,%esp
8010270a:	68 0d 77 10 80       	push   $0x8010770d
8010270f:	e8 7c dc ff ff       	call   80100390 <panic>
80102714:	83 ec 0c             	sub    $0xc,%esp
80102717:	68 f8 76 10 80       	push   $0x801076f8
8010271c:	e8 6f dc ff ff       	call   80100390 <panic>
80102721:	83 ec 0c             	sub    $0xc,%esp
80102724:	68 e2 76 10 80       	push   $0x801076e2
80102729:	e8 62 dc ff ff       	call   80100390 <panic>
8010272e:	66 90                	xchg   %ax,%ax

80102730 <ioapicinit>:
80102730:	f3 0f 1e fb          	endbr32 
80102734:	55                   	push   %ebp
80102735:	c7 05 54 26 11 80 00 	movl   $0xfec00000,0x80112654
8010273c:	00 c0 fe 
8010273f:	89 e5                	mov    %esp,%ebp
80102741:	56                   	push   %esi
80102742:	53                   	push   %ebx
80102743:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
8010274a:	00 00 00 
8010274d:	8b 15 54 26 11 80    	mov    0x80112654,%edx
80102753:	8b 72 10             	mov    0x10(%edx),%esi
80102756:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
8010275c:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
80102762:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx
80102769:	c1 ee 10             	shr    $0x10,%esi
8010276c:	89 f0                	mov    %esi,%eax
8010276e:	0f b6 f0             	movzbl %al,%esi
80102771:	8b 41 10             	mov    0x10(%ecx),%eax
80102774:	c1 e8 18             	shr    $0x18,%eax
80102777:	39 c2                	cmp    %eax,%edx
80102779:	74 16                	je     80102791 <ioapicinit+0x61>
8010277b:	83 ec 0c             	sub    $0xc,%esp
8010277e:	68 2c 77 10 80       	push   $0x8010772c
80102783:	e8 28 df ff ff       	call   801006b0 <cprintf>
80102788:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
8010278e:	83 c4 10             	add    $0x10,%esp
80102791:	83 c6 21             	add    $0x21,%esi
80102794:	ba 10 00 00 00       	mov    $0x10,%edx
80102799:	b8 20 00 00 00       	mov    $0x20,%eax
8010279e:	66 90                	xchg   %ax,%ax
801027a0:	89 11                	mov    %edx,(%ecx)
801027a2:	89 c3                	mov    %eax,%ebx
801027a4:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
801027aa:	83 c0 01             	add    $0x1,%eax
801027ad:	81 cb 00 00 01 00    	or     $0x10000,%ebx
801027b3:	89 59 10             	mov    %ebx,0x10(%ecx)
801027b6:	8d 5a 01             	lea    0x1(%edx),%ebx
801027b9:	83 c2 02             	add    $0x2,%edx
801027bc:	89 19                	mov    %ebx,(%ecx)
801027be:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
801027c4:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
801027cb:	39 f0                	cmp    %esi,%eax
801027cd:	75 d1                	jne    801027a0 <ioapicinit+0x70>
801027cf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801027d2:	5b                   	pop    %ebx
801027d3:	5e                   	pop    %esi
801027d4:	5d                   	pop    %ebp
801027d5:	c3                   	ret    
801027d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801027dd:	8d 76 00             	lea    0x0(%esi),%esi

801027e0 <ioapicenable>:
801027e0:	f3 0f 1e fb          	endbr32 
801027e4:	55                   	push   %ebp
801027e5:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
801027eb:	89 e5                	mov    %esp,%ebp
801027ed:	8b 45 08             	mov    0x8(%ebp),%eax
801027f0:	8d 50 20             	lea    0x20(%eax),%edx
801027f3:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
801027f7:	89 01                	mov    %eax,(%ecx)
801027f9:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
801027ff:	83 c0 01             	add    $0x1,%eax
80102802:	89 51 10             	mov    %edx,0x10(%ecx)
80102805:	8b 55 0c             	mov    0xc(%ebp),%edx
80102808:	89 01                	mov    %eax,(%ecx)
8010280a:	a1 54 26 11 80       	mov    0x80112654,%eax
8010280f:	c1 e2 18             	shl    $0x18,%edx
80102812:	89 50 10             	mov    %edx,0x10(%eax)
80102815:	5d                   	pop    %ebp
80102816:	c3                   	ret    
80102817:	66 90                	xchg   %ax,%ax
80102819:	66 90                	xchg   %ax,%ax
8010281b:	66 90                	xchg   %ax,%ax
8010281d:	66 90                	xchg   %ax,%ax
8010281f:	90                   	nop

80102820 <kfree>:
80102820:	f3 0f 1e fb          	endbr32 
80102824:	55                   	push   %ebp
80102825:	89 e5                	mov    %esp,%ebp
80102827:	53                   	push   %ebx
80102828:	83 ec 04             	sub    $0x4,%esp
8010282b:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010282e:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102834:	75 7a                	jne    801028b0 <kfree+0x90>
80102836:	81 fb c8 54 11 80    	cmp    $0x801154c8,%ebx
8010283c:	72 72                	jb     801028b0 <kfree+0x90>
8010283e:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102844:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102849:	77 65                	ja     801028b0 <kfree+0x90>
8010284b:	83 ec 04             	sub    $0x4,%esp
8010284e:	68 00 10 00 00       	push   $0x1000
80102853:	6a 01                	push   $0x1
80102855:	53                   	push   %ebx
80102856:	e8 c5 21 00 00       	call   80104a20 <memset>
8010285b:	8b 15 94 26 11 80    	mov    0x80112694,%edx
80102861:	83 c4 10             	add    $0x10,%esp
80102864:	85 d2                	test   %edx,%edx
80102866:	75 20                	jne    80102888 <kfree+0x68>
80102868:	a1 98 26 11 80       	mov    0x80112698,%eax
8010286d:	89 03                	mov    %eax,(%ebx)
8010286f:	a1 94 26 11 80       	mov    0x80112694,%eax
80102874:	89 1d 98 26 11 80    	mov    %ebx,0x80112698
8010287a:	85 c0                	test   %eax,%eax
8010287c:	75 22                	jne    801028a0 <kfree+0x80>
8010287e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102881:	c9                   	leave  
80102882:	c3                   	ret    
80102883:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102887:	90                   	nop
80102888:	83 ec 0c             	sub    $0xc,%esp
8010288b:	68 60 26 11 80       	push   $0x80112660
80102890:	e8 7b 20 00 00       	call   80104910 <acquire>
80102895:	83 c4 10             	add    $0x10,%esp
80102898:	eb ce                	jmp    80102868 <kfree+0x48>
8010289a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801028a0:	c7 45 08 60 26 11 80 	movl   $0x80112660,0x8(%ebp)
801028a7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801028aa:	c9                   	leave  
801028ab:	e9 20 21 00 00       	jmp    801049d0 <release>
801028b0:	83 ec 0c             	sub    $0xc,%esp
801028b3:	68 5e 77 10 80       	push   $0x8010775e
801028b8:	e8 d3 da ff ff       	call   80100390 <panic>
801028bd:	8d 76 00             	lea    0x0(%esi),%esi

801028c0 <freerange>:
801028c0:	f3 0f 1e fb          	endbr32 
801028c4:	55                   	push   %ebp
801028c5:	89 e5                	mov    %esp,%ebp
801028c7:	56                   	push   %esi
801028c8:	8b 45 08             	mov    0x8(%ebp),%eax
801028cb:	8b 75 0c             	mov    0xc(%ebp),%esi
801028ce:	53                   	push   %ebx
801028cf:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801028d5:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
801028db:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801028e1:	39 de                	cmp    %ebx,%esi
801028e3:	72 1f                	jb     80102904 <freerange+0x44>
801028e5:	8d 76 00             	lea    0x0(%esi),%esi
801028e8:	83 ec 0c             	sub    $0xc,%esp
801028eb:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801028f1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801028f7:	50                   	push   %eax
801028f8:	e8 23 ff ff ff       	call   80102820 <kfree>
801028fd:	83 c4 10             	add    $0x10,%esp
80102900:	39 f3                	cmp    %esi,%ebx
80102902:	76 e4                	jbe    801028e8 <freerange+0x28>
80102904:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102907:	5b                   	pop    %ebx
80102908:	5e                   	pop    %esi
80102909:	5d                   	pop    %ebp
8010290a:	c3                   	ret    
8010290b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010290f:	90                   	nop

80102910 <kinit1>:
80102910:	f3 0f 1e fb          	endbr32 
80102914:	55                   	push   %ebp
80102915:	89 e5                	mov    %esp,%ebp
80102917:	56                   	push   %esi
80102918:	53                   	push   %ebx
80102919:	8b 75 0c             	mov    0xc(%ebp),%esi
8010291c:	83 ec 08             	sub    $0x8,%esp
8010291f:	68 64 77 10 80       	push   $0x80107764
80102924:	68 60 26 11 80       	push   $0x80112660
80102929:	e8 62 1e 00 00       	call   80104790 <initlock>
8010292e:	8b 45 08             	mov    0x8(%ebp),%eax
80102931:	83 c4 10             	add    $0x10,%esp
80102934:	c7 05 94 26 11 80 00 	movl   $0x0,0x80112694
8010293b:	00 00 00 
8010293e:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102944:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
8010294a:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102950:	39 de                	cmp    %ebx,%esi
80102952:	72 20                	jb     80102974 <kinit1+0x64>
80102954:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102958:	83 ec 0c             	sub    $0xc,%esp
8010295b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102961:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102967:	50                   	push   %eax
80102968:	e8 b3 fe ff ff       	call   80102820 <kfree>
8010296d:	83 c4 10             	add    $0x10,%esp
80102970:	39 de                	cmp    %ebx,%esi
80102972:	73 e4                	jae    80102958 <kinit1+0x48>
80102974:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102977:	5b                   	pop    %ebx
80102978:	5e                   	pop    %esi
80102979:	5d                   	pop    %ebp
8010297a:	c3                   	ret    
8010297b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010297f:	90                   	nop

80102980 <kinit2>:
80102980:	f3 0f 1e fb          	endbr32 
80102984:	55                   	push   %ebp
80102985:	89 e5                	mov    %esp,%ebp
80102987:	56                   	push   %esi
80102988:	8b 45 08             	mov    0x8(%ebp),%eax
8010298b:	8b 75 0c             	mov    0xc(%ebp),%esi
8010298e:	53                   	push   %ebx
8010298f:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102995:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
8010299b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801029a1:	39 de                	cmp    %ebx,%esi
801029a3:	72 1f                	jb     801029c4 <kinit2+0x44>
801029a5:	8d 76 00             	lea    0x0(%esi),%esi
801029a8:	83 ec 0c             	sub    $0xc,%esp
801029ab:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801029b1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801029b7:	50                   	push   %eax
801029b8:	e8 63 fe ff ff       	call   80102820 <kfree>
801029bd:	83 c4 10             	add    $0x10,%esp
801029c0:	39 de                	cmp    %ebx,%esi
801029c2:	73 e4                	jae    801029a8 <kinit2+0x28>
801029c4:	c7 05 94 26 11 80 01 	movl   $0x1,0x80112694
801029cb:	00 00 00 
801029ce:	8d 65 f8             	lea    -0x8(%ebp),%esp
801029d1:	5b                   	pop    %ebx
801029d2:	5e                   	pop    %esi
801029d3:	5d                   	pop    %ebp
801029d4:	c3                   	ret    
801029d5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801029dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801029e0 <kalloc>:
801029e0:	f3 0f 1e fb          	endbr32 
801029e4:	a1 94 26 11 80       	mov    0x80112694,%eax
801029e9:	85 c0                	test   %eax,%eax
801029eb:	75 1b                	jne    80102a08 <kalloc+0x28>
801029ed:	a1 98 26 11 80       	mov    0x80112698,%eax
801029f2:	85 c0                	test   %eax,%eax
801029f4:	74 0a                	je     80102a00 <kalloc+0x20>
801029f6:	8b 10                	mov    (%eax),%edx
801029f8:	89 15 98 26 11 80    	mov    %edx,0x80112698
801029fe:	c3                   	ret    
801029ff:	90                   	nop
80102a00:	c3                   	ret    
80102a01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102a08:	55                   	push   %ebp
80102a09:	89 e5                	mov    %esp,%ebp
80102a0b:	83 ec 24             	sub    $0x24,%esp
80102a0e:	68 60 26 11 80       	push   $0x80112660
80102a13:	e8 f8 1e 00 00       	call   80104910 <acquire>
80102a18:	a1 98 26 11 80       	mov    0x80112698,%eax
80102a1d:	8b 15 94 26 11 80    	mov    0x80112694,%edx
80102a23:	83 c4 10             	add    $0x10,%esp
80102a26:	85 c0                	test   %eax,%eax
80102a28:	74 08                	je     80102a32 <kalloc+0x52>
80102a2a:	8b 08                	mov    (%eax),%ecx
80102a2c:	89 0d 98 26 11 80    	mov    %ecx,0x80112698
80102a32:	85 d2                	test   %edx,%edx
80102a34:	74 16                	je     80102a4c <kalloc+0x6c>
80102a36:	83 ec 0c             	sub    $0xc,%esp
80102a39:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102a3c:	68 60 26 11 80       	push   $0x80112660
80102a41:	e8 8a 1f 00 00       	call   801049d0 <release>
80102a46:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102a49:	83 c4 10             	add    $0x10,%esp
80102a4c:	c9                   	leave  
80102a4d:	c3                   	ret    
80102a4e:	66 90                	xchg   %ax,%ax

80102a50 <kbdgetc>:
80102a50:	f3 0f 1e fb          	endbr32 
80102a54:	ba 64 00 00 00       	mov    $0x64,%edx
80102a59:	ec                   	in     (%dx),%al
80102a5a:	a8 01                	test   $0x1,%al
80102a5c:	0f 84 be 00 00 00    	je     80102b20 <kbdgetc+0xd0>
80102a62:	55                   	push   %ebp
80102a63:	ba 60 00 00 00       	mov    $0x60,%edx
80102a68:	89 e5                	mov    %esp,%ebp
80102a6a:	53                   	push   %ebx
80102a6b:	ec                   	in     (%dx),%al
80102a6c:	8b 1d d4 a5 10 80    	mov    0x8010a5d4,%ebx
80102a72:	0f b6 d0             	movzbl %al,%edx
80102a75:	3c e0                	cmp    $0xe0,%al
80102a77:	74 57                	je     80102ad0 <kbdgetc+0x80>
80102a79:	89 d9                	mov    %ebx,%ecx
80102a7b:	83 e1 40             	and    $0x40,%ecx
80102a7e:	84 c0                	test   %al,%al
80102a80:	78 5e                	js     80102ae0 <kbdgetc+0x90>
80102a82:	85 c9                	test   %ecx,%ecx
80102a84:	74 09                	je     80102a8f <kbdgetc+0x3f>
80102a86:	83 c8 80             	or     $0xffffff80,%eax
80102a89:	83 e3 bf             	and    $0xffffffbf,%ebx
80102a8c:	0f b6 d0             	movzbl %al,%edx
80102a8f:	0f b6 8a a0 78 10 80 	movzbl -0x7fef8760(%edx),%ecx
80102a96:	0f b6 82 a0 77 10 80 	movzbl -0x7fef8860(%edx),%eax
80102a9d:	09 d9                	or     %ebx,%ecx
80102a9f:	31 c1                	xor    %eax,%ecx
80102aa1:	89 c8                	mov    %ecx,%eax
80102aa3:	89 0d d4 a5 10 80    	mov    %ecx,0x8010a5d4
80102aa9:	83 e0 03             	and    $0x3,%eax
80102aac:	83 e1 08             	and    $0x8,%ecx
80102aaf:	8b 04 85 80 77 10 80 	mov    -0x7fef8880(,%eax,4),%eax
80102ab6:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
80102aba:	74 0b                	je     80102ac7 <kbdgetc+0x77>
80102abc:	8d 50 9f             	lea    -0x61(%eax),%edx
80102abf:	83 fa 19             	cmp    $0x19,%edx
80102ac2:	77 44                	ja     80102b08 <kbdgetc+0xb8>
80102ac4:	83 e8 20             	sub    $0x20,%eax
80102ac7:	5b                   	pop    %ebx
80102ac8:	5d                   	pop    %ebp
80102ac9:	c3                   	ret    
80102aca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102ad0:	83 cb 40             	or     $0x40,%ebx
80102ad3:	31 c0                	xor    %eax,%eax
80102ad5:	89 1d d4 a5 10 80    	mov    %ebx,0x8010a5d4
80102adb:	5b                   	pop    %ebx
80102adc:	5d                   	pop    %ebp
80102add:	c3                   	ret    
80102ade:	66 90                	xchg   %ax,%ax
80102ae0:	83 e0 7f             	and    $0x7f,%eax
80102ae3:	85 c9                	test   %ecx,%ecx
80102ae5:	0f 44 d0             	cmove  %eax,%edx
80102ae8:	31 c0                	xor    %eax,%eax
80102aea:	0f b6 8a a0 78 10 80 	movzbl -0x7fef8760(%edx),%ecx
80102af1:	83 c9 40             	or     $0x40,%ecx
80102af4:	0f b6 c9             	movzbl %cl,%ecx
80102af7:	f7 d1                	not    %ecx
80102af9:	21 d9                	and    %ebx,%ecx
80102afb:	5b                   	pop    %ebx
80102afc:	5d                   	pop    %ebp
80102afd:	89 0d d4 a5 10 80    	mov    %ecx,0x8010a5d4
80102b03:	c3                   	ret    
80102b04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102b08:	8d 48 bf             	lea    -0x41(%eax),%ecx
80102b0b:	8d 50 20             	lea    0x20(%eax),%edx
80102b0e:	5b                   	pop    %ebx
80102b0f:	5d                   	pop    %ebp
80102b10:	83 f9 1a             	cmp    $0x1a,%ecx
80102b13:	0f 42 c2             	cmovb  %edx,%eax
80102b16:	c3                   	ret    
80102b17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102b1e:	66 90                	xchg   %ax,%ax
80102b20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102b25:	c3                   	ret    
80102b26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102b2d:	8d 76 00             	lea    0x0(%esi),%esi

80102b30 <kbdintr>:
80102b30:	f3 0f 1e fb          	endbr32 
80102b34:	55                   	push   %ebp
80102b35:	89 e5                	mov    %esp,%ebp
80102b37:	83 ec 14             	sub    $0x14,%esp
80102b3a:	68 50 2a 10 80       	push   $0x80102a50
80102b3f:	e8 7c dd ff ff       	call   801008c0 <consoleintr>
80102b44:	83 c4 10             	add    $0x10,%esp
80102b47:	c9                   	leave  
80102b48:	c3                   	ret    
80102b49:	66 90                	xchg   %ax,%ax
80102b4b:	66 90                	xchg   %ax,%ax
80102b4d:	66 90                	xchg   %ax,%ax
80102b4f:	90                   	nop

80102b50 <lapicinit>:
80102b50:	f3 0f 1e fb          	endbr32 
80102b54:	a1 9c 26 11 80       	mov    0x8011269c,%eax
80102b59:	85 c0                	test   %eax,%eax
80102b5b:	0f 84 c7 00 00 00    	je     80102c28 <lapicinit+0xd8>
80102b61:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102b68:	01 00 00 
80102b6b:	8b 50 20             	mov    0x20(%eax),%edx
80102b6e:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102b75:	00 00 00 
80102b78:	8b 50 20             	mov    0x20(%eax),%edx
80102b7b:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102b82:	00 02 00 
80102b85:	8b 50 20             	mov    0x20(%eax),%edx
80102b88:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
80102b8f:	96 98 00 
80102b92:	8b 50 20             	mov    0x20(%eax),%edx
80102b95:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80102b9c:	00 01 00 
80102b9f:	8b 50 20             	mov    0x20(%eax),%edx
80102ba2:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102ba9:	00 01 00 
80102bac:	8b 50 20             	mov    0x20(%eax),%edx
80102baf:	8b 50 30             	mov    0x30(%eax),%edx
80102bb2:	c1 ea 10             	shr    $0x10,%edx
80102bb5:	81 e2 fc 00 00 00    	and    $0xfc,%edx
80102bbb:	75 73                	jne    80102c30 <lapicinit+0xe0>
80102bbd:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102bc4:	00 00 00 
80102bc7:	8b 50 20             	mov    0x20(%eax),%edx
80102bca:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102bd1:	00 00 00 
80102bd4:	8b 50 20             	mov    0x20(%eax),%edx
80102bd7:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102bde:	00 00 00 
80102be1:	8b 50 20             	mov    0x20(%eax),%edx
80102be4:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102beb:	00 00 00 
80102bee:	8b 50 20             	mov    0x20(%eax),%edx
80102bf1:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102bf8:	00 00 00 
80102bfb:	8b 50 20             	mov    0x20(%eax),%edx
80102bfe:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102c05:	85 08 00 
80102c08:	8b 50 20             	mov    0x20(%eax),%edx
80102c0b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102c0f:	90                   	nop
80102c10:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102c16:	80 e6 10             	and    $0x10,%dh
80102c19:	75 f5                	jne    80102c10 <lapicinit+0xc0>
80102c1b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102c22:	00 00 00 
80102c25:	8b 40 20             	mov    0x20(%eax),%eax
80102c28:	c3                   	ret    
80102c29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102c30:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102c37:	00 01 00 
80102c3a:	8b 50 20             	mov    0x20(%eax),%edx
80102c3d:	e9 7b ff ff ff       	jmp    80102bbd <lapicinit+0x6d>
80102c42:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102c49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102c50 <lapicid>:
80102c50:	f3 0f 1e fb          	endbr32 
80102c54:	a1 9c 26 11 80       	mov    0x8011269c,%eax
80102c59:	85 c0                	test   %eax,%eax
80102c5b:	74 0b                	je     80102c68 <lapicid+0x18>
80102c5d:	8b 40 20             	mov    0x20(%eax),%eax
80102c60:	c1 e8 18             	shr    $0x18,%eax
80102c63:	c3                   	ret    
80102c64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102c68:	31 c0                	xor    %eax,%eax
80102c6a:	c3                   	ret    
80102c6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102c6f:	90                   	nop

80102c70 <lapiceoi>:
80102c70:	f3 0f 1e fb          	endbr32 
80102c74:	a1 9c 26 11 80       	mov    0x8011269c,%eax
80102c79:	85 c0                	test   %eax,%eax
80102c7b:	74 0d                	je     80102c8a <lapiceoi+0x1a>
80102c7d:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102c84:	00 00 00 
80102c87:	8b 40 20             	mov    0x20(%eax),%eax
80102c8a:	c3                   	ret    
80102c8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102c8f:	90                   	nop

80102c90 <microdelay>:
80102c90:	f3 0f 1e fb          	endbr32 
80102c94:	c3                   	ret    
80102c95:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102ca0 <lapicstartap>:
80102ca0:	f3 0f 1e fb          	endbr32 
80102ca4:	55                   	push   %ebp
80102ca5:	b8 0f 00 00 00       	mov    $0xf,%eax
80102caa:	ba 70 00 00 00       	mov    $0x70,%edx
80102caf:	89 e5                	mov    %esp,%ebp
80102cb1:	53                   	push   %ebx
80102cb2:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102cb5:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102cb8:	ee                   	out    %al,(%dx)
80102cb9:	b8 0a 00 00 00       	mov    $0xa,%eax
80102cbe:	ba 71 00 00 00       	mov    $0x71,%edx
80102cc3:	ee                   	out    %al,(%dx)
80102cc4:	31 c0                	xor    %eax,%eax
80102cc6:	c1 e3 18             	shl    $0x18,%ebx
80102cc9:	66 a3 67 04 00 80    	mov    %ax,0x80000467
80102ccf:	89 c8                	mov    %ecx,%eax
80102cd1:	c1 e9 0c             	shr    $0xc,%ecx
80102cd4:	89 da                	mov    %ebx,%edx
80102cd6:	c1 e8 04             	shr    $0x4,%eax
80102cd9:	80 cd 06             	or     $0x6,%ch
80102cdc:	66 a3 69 04 00 80    	mov    %ax,0x80000469
80102ce2:	a1 9c 26 11 80       	mov    0x8011269c,%eax
80102ce7:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
80102ced:	8b 58 20             	mov    0x20(%eax),%ebx
80102cf0:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102cf7:	c5 00 00 
80102cfa:	8b 58 20             	mov    0x20(%eax),%ebx
80102cfd:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102d04:	85 00 00 
80102d07:	8b 58 20             	mov    0x20(%eax),%ebx
80102d0a:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
80102d10:	8b 58 20             	mov    0x20(%eax),%ebx
80102d13:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
80102d19:	8b 58 20             	mov    0x20(%eax),%ebx
80102d1c:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
80102d22:	8b 50 20             	mov    0x20(%eax),%edx
80102d25:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
80102d2b:	5b                   	pop    %ebx
80102d2c:	8b 40 20             	mov    0x20(%eax),%eax
80102d2f:	5d                   	pop    %ebp
80102d30:	c3                   	ret    
80102d31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102d38:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102d3f:	90                   	nop

80102d40 <cmostime>:
80102d40:	f3 0f 1e fb          	endbr32 
80102d44:	55                   	push   %ebp
80102d45:	b8 0b 00 00 00       	mov    $0xb,%eax
80102d4a:	ba 70 00 00 00       	mov    $0x70,%edx
80102d4f:	89 e5                	mov    %esp,%ebp
80102d51:	57                   	push   %edi
80102d52:	56                   	push   %esi
80102d53:	53                   	push   %ebx
80102d54:	83 ec 4c             	sub    $0x4c,%esp
80102d57:	ee                   	out    %al,(%dx)
80102d58:	ba 71 00 00 00       	mov    $0x71,%edx
80102d5d:	ec                   	in     (%dx),%al
80102d5e:	83 e0 04             	and    $0x4,%eax
80102d61:	bb 70 00 00 00       	mov    $0x70,%ebx
80102d66:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102d69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102d70:	31 c0                	xor    %eax,%eax
80102d72:	89 da                	mov    %ebx,%edx
80102d74:	ee                   	out    %al,(%dx)
80102d75:	b9 71 00 00 00       	mov    $0x71,%ecx
80102d7a:	89 ca                	mov    %ecx,%edx
80102d7c:	ec                   	in     (%dx),%al
80102d7d:	88 45 b7             	mov    %al,-0x49(%ebp)
80102d80:	89 da                	mov    %ebx,%edx
80102d82:	b8 02 00 00 00       	mov    $0x2,%eax
80102d87:	ee                   	out    %al,(%dx)
80102d88:	89 ca                	mov    %ecx,%edx
80102d8a:	ec                   	in     (%dx),%al
80102d8b:	88 45 b6             	mov    %al,-0x4a(%ebp)
80102d8e:	89 da                	mov    %ebx,%edx
80102d90:	b8 04 00 00 00       	mov    $0x4,%eax
80102d95:	ee                   	out    %al,(%dx)
80102d96:	89 ca                	mov    %ecx,%edx
80102d98:	ec                   	in     (%dx),%al
80102d99:	88 45 b5             	mov    %al,-0x4b(%ebp)
80102d9c:	89 da                	mov    %ebx,%edx
80102d9e:	b8 07 00 00 00       	mov    $0x7,%eax
80102da3:	ee                   	out    %al,(%dx)
80102da4:	89 ca                	mov    %ecx,%edx
80102da6:	ec                   	in     (%dx),%al
80102da7:	88 45 b4             	mov    %al,-0x4c(%ebp)
80102daa:	89 da                	mov    %ebx,%edx
80102dac:	b8 08 00 00 00       	mov    $0x8,%eax
80102db1:	ee                   	out    %al,(%dx)
80102db2:	89 ca                	mov    %ecx,%edx
80102db4:	ec                   	in     (%dx),%al
80102db5:	89 c7                	mov    %eax,%edi
80102db7:	89 da                	mov    %ebx,%edx
80102db9:	b8 09 00 00 00       	mov    $0x9,%eax
80102dbe:	ee                   	out    %al,(%dx)
80102dbf:	89 ca                	mov    %ecx,%edx
80102dc1:	ec                   	in     (%dx),%al
80102dc2:	89 c6                	mov    %eax,%esi
80102dc4:	89 da                	mov    %ebx,%edx
80102dc6:	b8 0a 00 00 00       	mov    $0xa,%eax
80102dcb:	ee                   	out    %al,(%dx)
80102dcc:	89 ca                	mov    %ecx,%edx
80102dce:	ec                   	in     (%dx),%al
80102dcf:	84 c0                	test   %al,%al
80102dd1:	78 9d                	js     80102d70 <cmostime+0x30>
80102dd3:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80102dd7:	89 fa                	mov    %edi,%edx
80102dd9:	0f b6 fa             	movzbl %dl,%edi
80102ddc:	89 f2                	mov    %esi,%edx
80102dde:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102de1:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102de5:	0f b6 f2             	movzbl %dl,%esi
80102de8:	89 da                	mov    %ebx,%edx
80102dea:	89 7d c8             	mov    %edi,-0x38(%ebp)
80102ded:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102df0:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80102df4:	89 75 cc             	mov    %esi,-0x34(%ebp)
80102df7:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102dfa:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102dfe:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102e01:	31 c0                	xor    %eax,%eax
80102e03:	ee                   	out    %al,(%dx)
80102e04:	89 ca                	mov    %ecx,%edx
80102e06:	ec                   	in     (%dx),%al
80102e07:	0f b6 c0             	movzbl %al,%eax
80102e0a:	89 da                	mov    %ebx,%edx
80102e0c:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102e0f:	b8 02 00 00 00       	mov    $0x2,%eax
80102e14:	ee                   	out    %al,(%dx)
80102e15:	89 ca                	mov    %ecx,%edx
80102e17:	ec                   	in     (%dx),%al
80102e18:	0f b6 c0             	movzbl %al,%eax
80102e1b:	89 da                	mov    %ebx,%edx
80102e1d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102e20:	b8 04 00 00 00       	mov    $0x4,%eax
80102e25:	ee                   	out    %al,(%dx)
80102e26:	89 ca                	mov    %ecx,%edx
80102e28:	ec                   	in     (%dx),%al
80102e29:	0f b6 c0             	movzbl %al,%eax
80102e2c:	89 da                	mov    %ebx,%edx
80102e2e:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102e31:	b8 07 00 00 00       	mov    $0x7,%eax
80102e36:	ee                   	out    %al,(%dx)
80102e37:	89 ca                	mov    %ecx,%edx
80102e39:	ec                   	in     (%dx),%al
80102e3a:	0f b6 c0             	movzbl %al,%eax
80102e3d:	89 da                	mov    %ebx,%edx
80102e3f:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102e42:	b8 08 00 00 00       	mov    $0x8,%eax
80102e47:	ee                   	out    %al,(%dx)
80102e48:	89 ca                	mov    %ecx,%edx
80102e4a:	ec                   	in     (%dx),%al
80102e4b:	0f b6 c0             	movzbl %al,%eax
80102e4e:	89 da                	mov    %ebx,%edx
80102e50:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102e53:	b8 09 00 00 00       	mov    $0x9,%eax
80102e58:	ee                   	out    %al,(%dx)
80102e59:	89 ca                	mov    %ecx,%edx
80102e5b:	ec                   	in     (%dx),%al
80102e5c:	0f b6 c0             	movzbl %al,%eax
80102e5f:	83 ec 04             	sub    $0x4,%esp
80102e62:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80102e65:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102e68:	6a 18                	push   $0x18
80102e6a:	50                   	push   %eax
80102e6b:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102e6e:	50                   	push   %eax
80102e6f:	e8 fc 1b 00 00       	call   80104a70 <memcmp>
80102e74:	83 c4 10             	add    $0x10,%esp
80102e77:	85 c0                	test   %eax,%eax
80102e79:	0f 85 f1 fe ff ff    	jne    80102d70 <cmostime+0x30>
80102e7f:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
80102e83:	75 78                	jne    80102efd <cmostime+0x1bd>
80102e85:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102e88:	89 c2                	mov    %eax,%edx
80102e8a:	83 e0 0f             	and    $0xf,%eax
80102e8d:	c1 ea 04             	shr    $0x4,%edx
80102e90:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102e93:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102e96:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102e99:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102e9c:	89 c2                	mov    %eax,%edx
80102e9e:	83 e0 0f             	and    $0xf,%eax
80102ea1:	c1 ea 04             	shr    $0x4,%edx
80102ea4:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102ea7:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102eaa:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102ead:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102eb0:	89 c2                	mov    %eax,%edx
80102eb2:	83 e0 0f             	and    $0xf,%eax
80102eb5:	c1 ea 04             	shr    $0x4,%edx
80102eb8:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102ebb:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102ebe:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102ec1:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102ec4:	89 c2                	mov    %eax,%edx
80102ec6:	83 e0 0f             	and    $0xf,%eax
80102ec9:	c1 ea 04             	shr    $0x4,%edx
80102ecc:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102ecf:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102ed2:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102ed5:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102ed8:	89 c2                	mov    %eax,%edx
80102eda:	83 e0 0f             	and    $0xf,%eax
80102edd:	c1 ea 04             	shr    $0x4,%edx
80102ee0:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102ee3:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102ee6:	89 45 c8             	mov    %eax,-0x38(%ebp)
80102ee9:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102eec:	89 c2                	mov    %eax,%edx
80102eee:	83 e0 0f             	and    $0xf,%eax
80102ef1:	c1 ea 04             	shr    $0x4,%edx
80102ef4:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102ef7:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102efa:	89 45 cc             	mov    %eax,-0x34(%ebp)
80102efd:	8b 75 08             	mov    0x8(%ebp),%esi
80102f00:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102f03:	89 06                	mov    %eax,(%esi)
80102f05:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102f08:	89 46 04             	mov    %eax,0x4(%esi)
80102f0b:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102f0e:	89 46 08             	mov    %eax,0x8(%esi)
80102f11:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102f14:	89 46 0c             	mov    %eax,0xc(%esi)
80102f17:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102f1a:	89 46 10             	mov    %eax,0x10(%esi)
80102f1d:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102f20:	89 46 14             	mov    %eax,0x14(%esi)
80102f23:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
80102f2a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102f2d:	5b                   	pop    %ebx
80102f2e:	5e                   	pop    %esi
80102f2f:	5f                   	pop    %edi
80102f30:	5d                   	pop    %ebp
80102f31:	c3                   	ret    
80102f32:	66 90                	xchg   %ax,%ax
80102f34:	66 90                	xchg   %ax,%ax
80102f36:	66 90                	xchg   %ax,%ax
80102f38:	66 90                	xchg   %ax,%ax
80102f3a:	66 90                	xchg   %ax,%ax
80102f3c:	66 90                	xchg   %ax,%ax
80102f3e:	66 90                	xchg   %ax,%ax

80102f40 <install_trans>:
80102f40:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80102f46:	85 c9                	test   %ecx,%ecx
80102f48:	0f 8e 8a 00 00 00    	jle    80102fd8 <install_trans+0x98>
80102f4e:	55                   	push   %ebp
80102f4f:	89 e5                	mov    %esp,%ebp
80102f51:	57                   	push   %edi
80102f52:	31 ff                	xor    %edi,%edi
80102f54:	56                   	push   %esi
80102f55:	53                   	push   %ebx
80102f56:	83 ec 0c             	sub    $0xc,%esp
80102f59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102f60:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102f65:	83 ec 08             	sub    $0x8,%esp
80102f68:	01 f8                	add    %edi,%eax
80102f6a:	83 c0 01             	add    $0x1,%eax
80102f6d:	50                   	push   %eax
80102f6e:	ff 35 e4 26 11 80    	pushl  0x801126e4
80102f74:	e8 57 d1 ff ff       	call   801000d0 <bread>
80102f79:	89 c6                	mov    %eax,%esi
80102f7b:	58                   	pop    %eax
80102f7c:	5a                   	pop    %edx
80102f7d:	ff 34 bd ec 26 11 80 	pushl  -0x7feed914(,%edi,4)
80102f84:	ff 35 e4 26 11 80    	pushl  0x801126e4
80102f8a:	83 c7 01             	add    $0x1,%edi
80102f8d:	e8 3e d1 ff ff       	call   801000d0 <bread>
80102f92:	83 c4 0c             	add    $0xc,%esp
80102f95:	89 c3                	mov    %eax,%ebx
80102f97:	8d 46 5c             	lea    0x5c(%esi),%eax
80102f9a:	68 00 02 00 00       	push   $0x200
80102f9f:	50                   	push   %eax
80102fa0:	8d 43 5c             	lea    0x5c(%ebx),%eax
80102fa3:	50                   	push   %eax
80102fa4:	e8 17 1b 00 00       	call   80104ac0 <memmove>
80102fa9:	89 1c 24             	mov    %ebx,(%esp)
80102fac:	e8 ff d1 ff ff       	call   801001b0 <bwrite>
80102fb1:	89 34 24             	mov    %esi,(%esp)
80102fb4:	e8 37 d2 ff ff       	call   801001f0 <brelse>
80102fb9:	89 1c 24             	mov    %ebx,(%esp)
80102fbc:	e8 2f d2 ff ff       	call   801001f0 <brelse>
80102fc1:	83 c4 10             	add    $0x10,%esp
80102fc4:	39 3d e8 26 11 80    	cmp    %edi,0x801126e8
80102fca:	7f 94                	jg     80102f60 <install_trans+0x20>
80102fcc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102fcf:	5b                   	pop    %ebx
80102fd0:	5e                   	pop    %esi
80102fd1:	5f                   	pop    %edi
80102fd2:	5d                   	pop    %ebp
80102fd3:	c3                   	ret    
80102fd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102fd8:	c3                   	ret    
80102fd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102fe0 <write_head>:
80102fe0:	55                   	push   %ebp
80102fe1:	89 e5                	mov    %esp,%ebp
80102fe3:	53                   	push   %ebx
80102fe4:	83 ec 0c             	sub    $0xc,%esp
80102fe7:	ff 35 d4 26 11 80    	pushl  0x801126d4
80102fed:	ff 35 e4 26 11 80    	pushl  0x801126e4
80102ff3:	e8 d8 d0 ff ff       	call   801000d0 <bread>
80102ff8:	83 c4 10             	add    $0x10,%esp
80102ffb:	89 c3                	mov    %eax,%ebx
80102ffd:	a1 e8 26 11 80       	mov    0x801126e8,%eax
80103002:	89 43 5c             	mov    %eax,0x5c(%ebx)
80103005:	85 c0                	test   %eax,%eax
80103007:	7e 19                	jle    80103022 <write_head+0x42>
80103009:	31 d2                	xor    %edx,%edx
8010300b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010300f:	90                   	nop
80103010:	8b 0c 95 ec 26 11 80 	mov    -0x7feed914(,%edx,4),%ecx
80103017:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
8010301b:	83 c2 01             	add    $0x1,%edx
8010301e:	39 d0                	cmp    %edx,%eax
80103020:	75 ee                	jne    80103010 <write_head+0x30>
80103022:	83 ec 0c             	sub    $0xc,%esp
80103025:	53                   	push   %ebx
80103026:	e8 85 d1 ff ff       	call   801001b0 <bwrite>
8010302b:	89 1c 24             	mov    %ebx,(%esp)
8010302e:	e8 bd d1 ff ff       	call   801001f0 <brelse>
80103033:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103036:	83 c4 10             	add    $0x10,%esp
80103039:	c9                   	leave  
8010303a:	c3                   	ret    
8010303b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010303f:	90                   	nop

80103040 <initlog>:
80103040:	f3 0f 1e fb          	endbr32 
80103044:	55                   	push   %ebp
80103045:	89 e5                	mov    %esp,%ebp
80103047:	53                   	push   %ebx
80103048:	83 ec 2c             	sub    $0x2c,%esp
8010304b:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010304e:	68 a0 79 10 80       	push   $0x801079a0
80103053:	68 a0 26 11 80       	push   $0x801126a0
80103058:	e8 33 17 00 00       	call   80104790 <initlock>
8010305d:	58                   	pop    %eax
8010305e:	8d 45 dc             	lea    -0x24(%ebp),%eax
80103061:	5a                   	pop    %edx
80103062:	50                   	push   %eax
80103063:	53                   	push   %ebx
80103064:	e8 47 e8 ff ff       	call   801018b0 <readsb>
80103069:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010306c:	59                   	pop    %ecx
8010306d:	89 1d e4 26 11 80    	mov    %ebx,0x801126e4
80103073:	8b 55 e8             	mov    -0x18(%ebp),%edx
80103076:	a3 d4 26 11 80       	mov    %eax,0x801126d4
8010307b:	89 15 d8 26 11 80    	mov    %edx,0x801126d8
80103081:	5a                   	pop    %edx
80103082:	50                   	push   %eax
80103083:	53                   	push   %ebx
80103084:	e8 47 d0 ff ff       	call   801000d0 <bread>
80103089:	83 c4 10             	add    $0x10,%esp
8010308c:	8b 48 5c             	mov    0x5c(%eax),%ecx
8010308f:	89 0d e8 26 11 80    	mov    %ecx,0x801126e8
80103095:	85 c9                	test   %ecx,%ecx
80103097:	7e 19                	jle    801030b2 <initlog+0x72>
80103099:	31 d2                	xor    %edx,%edx
8010309b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010309f:	90                   	nop
801030a0:	8b 5c 90 60          	mov    0x60(%eax,%edx,4),%ebx
801030a4:	89 1c 95 ec 26 11 80 	mov    %ebx,-0x7feed914(,%edx,4)
801030ab:	83 c2 01             	add    $0x1,%edx
801030ae:	39 d1                	cmp    %edx,%ecx
801030b0:	75 ee                	jne    801030a0 <initlog+0x60>
801030b2:	83 ec 0c             	sub    $0xc,%esp
801030b5:	50                   	push   %eax
801030b6:	e8 35 d1 ff ff       	call   801001f0 <brelse>
801030bb:	e8 80 fe ff ff       	call   80102f40 <install_trans>
801030c0:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
801030c7:	00 00 00 
801030ca:	e8 11 ff ff ff       	call   80102fe0 <write_head>
801030cf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801030d2:	83 c4 10             	add    $0x10,%esp
801030d5:	c9                   	leave  
801030d6:	c3                   	ret    
801030d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801030de:	66 90                	xchg   %ax,%ax

801030e0 <begin_op>:
801030e0:	f3 0f 1e fb          	endbr32 
801030e4:	55                   	push   %ebp
801030e5:	89 e5                	mov    %esp,%ebp
801030e7:	83 ec 14             	sub    $0x14,%esp
801030ea:	68 a0 26 11 80       	push   $0x801126a0
801030ef:	e8 1c 18 00 00       	call   80104910 <acquire>
801030f4:	83 c4 10             	add    $0x10,%esp
801030f7:	eb 1c                	jmp    80103115 <begin_op+0x35>
801030f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103100:	83 ec 08             	sub    $0x8,%esp
80103103:	68 a0 26 11 80       	push   $0x801126a0
80103108:	68 a0 26 11 80       	push   $0x801126a0
8010310d:	e8 be 11 00 00       	call   801042d0 <sleep>
80103112:	83 c4 10             	add    $0x10,%esp
80103115:	a1 e0 26 11 80       	mov    0x801126e0,%eax
8010311a:	85 c0                	test   %eax,%eax
8010311c:	75 e2                	jne    80103100 <begin_op+0x20>
8010311e:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80103123:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
80103129:	83 c0 01             	add    $0x1,%eax
8010312c:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
8010312f:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80103132:	83 fa 1e             	cmp    $0x1e,%edx
80103135:	7f c9                	jg     80103100 <begin_op+0x20>
80103137:	83 ec 0c             	sub    $0xc,%esp
8010313a:	a3 dc 26 11 80       	mov    %eax,0x801126dc
8010313f:	68 a0 26 11 80       	push   $0x801126a0
80103144:	e8 87 18 00 00       	call   801049d0 <release>
80103149:	83 c4 10             	add    $0x10,%esp
8010314c:	c9                   	leave  
8010314d:	c3                   	ret    
8010314e:	66 90                	xchg   %ax,%ax

80103150 <end_op>:
80103150:	f3 0f 1e fb          	endbr32 
80103154:	55                   	push   %ebp
80103155:	89 e5                	mov    %esp,%ebp
80103157:	57                   	push   %edi
80103158:	56                   	push   %esi
80103159:	53                   	push   %ebx
8010315a:	83 ec 18             	sub    $0x18,%esp
8010315d:	68 a0 26 11 80       	push   $0x801126a0
80103162:	e8 a9 17 00 00       	call   80104910 <acquire>
80103167:	a1 dc 26 11 80       	mov    0x801126dc,%eax
8010316c:	8b 35 e0 26 11 80    	mov    0x801126e0,%esi
80103172:	83 c4 10             	add    $0x10,%esp
80103175:	8d 58 ff             	lea    -0x1(%eax),%ebx
80103178:	89 1d dc 26 11 80    	mov    %ebx,0x801126dc
8010317e:	85 f6                	test   %esi,%esi
80103180:	0f 85 1e 01 00 00    	jne    801032a4 <end_op+0x154>
80103186:	85 db                	test   %ebx,%ebx
80103188:	0f 85 f2 00 00 00    	jne    80103280 <end_op+0x130>
8010318e:	c7 05 e0 26 11 80 01 	movl   $0x1,0x801126e0
80103195:	00 00 00 
80103198:	83 ec 0c             	sub    $0xc,%esp
8010319b:	68 a0 26 11 80       	push   $0x801126a0
801031a0:	e8 2b 18 00 00       	call   801049d0 <release>
801031a5:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
801031ab:	83 c4 10             	add    $0x10,%esp
801031ae:	85 c9                	test   %ecx,%ecx
801031b0:	7f 3e                	jg     801031f0 <end_op+0xa0>
801031b2:	83 ec 0c             	sub    $0xc,%esp
801031b5:	68 a0 26 11 80       	push   $0x801126a0
801031ba:	e8 51 17 00 00       	call   80104910 <acquire>
801031bf:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
801031c6:	c7 05 e0 26 11 80 00 	movl   $0x0,0x801126e0
801031cd:	00 00 00 
801031d0:	e8 bb 12 00 00       	call   80104490 <wakeup>
801031d5:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
801031dc:	e8 ef 17 00 00       	call   801049d0 <release>
801031e1:	83 c4 10             	add    $0x10,%esp
801031e4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801031e7:	5b                   	pop    %ebx
801031e8:	5e                   	pop    %esi
801031e9:	5f                   	pop    %edi
801031ea:	5d                   	pop    %ebp
801031eb:	c3                   	ret    
801031ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801031f0:	a1 d4 26 11 80       	mov    0x801126d4,%eax
801031f5:	83 ec 08             	sub    $0x8,%esp
801031f8:	01 d8                	add    %ebx,%eax
801031fa:	83 c0 01             	add    $0x1,%eax
801031fd:	50                   	push   %eax
801031fe:	ff 35 e4 26 11 80    	pushl  0x801126e4
80103204:	e8 c7 ce ff ff       	call   801000d0 <bread>
80103209:	89 c6                	mov    %eax,%esi
8010320b:	58                   	pop    %eax
8010320c:	5a                   	pop    %edx
8010320d:	ff 34 9d ec 26 11 80 	pushl  -0x7feed914(,%ebx,4)
80103214:	ff 35 e4 26 11 80    	pushl  0x801126e4
8010321a:	83 c3 01             	add    $0x1,%ebx
8010321d:	e8 ae ce ff ff       	call   801000d0 <bread>
80103222:	83 c4 0c             	add    $0xc,%esp
80103225:	89 c7                	mov    %eax,%edi
80103227:	8d 40 5c             	lea    0x5c(%eax),%eax
8010322a:	68 00 02 00 00       	push   $0x200
8010322f:	50                   	push   %eax
80103230:	8d 46 5c             	lea    0x5c(%esi),%eax
80103233:	50                   	push   %eax
80103234:	e8 87 18 00 00       	call   80104ac0 <memmove>
80103239:	89 34 24             	mov    %esi,(%esp)
8010323c:	e8 6f cf ff ff       	call   801001b0 <bwrite>
80103241:	89 3c 24             	mov    %edi,(%esp)
80103244:	e8 a7 cf ff ff       	call   801001f0 <brelse>
80103249:	89 34 24             	mov    %esi,(%esp)
8010324c:	e8 9f cf ff ff       	call   801001f0 <brelse>
80103251:	83 c4 10             	add    $0x10,%esp
80103254:	3b 1d e8 26 11 80    	cmp    0x801126e8,%ebx
8010325a:	7c 94                	jl     801031f0 <end_op+0xa0>
8010325c:	e8 7f fd ff ff       	call   80102fe0 <write_head>
80103261:	e8 da fc ff ff       	call   80102f40 <install_trans>
80103266:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
8010326d:	00 00 00 
80103270:	e8 6b fd ff ff       	call   80102fe0 <write_head>
80103275:	e9 38 ff ff ff       	jmp    801031b2 <end_op+0x62>
8010327a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103280:	83 ec 0c             	sub    $0xc,%esp
80103283:	68 a0 26 11 80       	push   $0x801126a0
80103288:	e8 03 12 00 00       	call   80104490 <wakeup>
8010328d:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80103294:	e8 37 17 00 00       	call   801049d0 <release>
80103299:	83 c4 10             	add    $0x10,%esp
8010329c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010329f:	5b                   	pop    %ebx
801032a0:	5e                   	pop    %esi
801032a1:	5f                   	pop    %edi
801032a2:	5d                   	pop    %ebp
801032a3:	c3                   	ret    
801032a4:	83 ec 0c             	sub    $0xc,%esp
801032a7:	68 a4 79 10 80       	push   $0x801079a4
801032ac:	e8 df d0 ff ff       	call   80100390 <panic>
801032b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801032b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801032bf:	90                   	nop

801032c0 <log_write>:
801032c0:	f3 0f 1e fb          	endbr32 
801032c4:	55                   	push   %ebp
801032c5:	89 e5                	mov    %esp,%ebp
801032c7:	53                   	push   %ebx
801032c8:	83 ec 04             	sub    $0x4,%esp
801032cb:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
801032d1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801032d4:	83 fa 1d             	cmp    $0x1d,%edx
801032d7:	0f 8f 91 00 00 00    	jg     8010336e <log_write+0xae>
801032dd:	a1 d8 26 11 80       	mov    0x801126d8,%eax
801032e2:	83 e8 01             	sub    $0x1,%eax
801032e5:	39 c2                	cmp    %eax,%edx
801032e7:	0f 8d 81 00 00 00    	jge    8010336e <log_write+0xae>
801032ed:	a1 dc 26 11 80       	mov    0x801126dc,%eax
801032f2:	85 c0                	test   %eax,%eax
801032f4:	0f 8e 81 00 00 00    	jle    8010337b <log_write+0xbb>
801032fa:	83 ec 0c             	sub    $0xc,%esp
801032fd:	68 a0 26 11 80       	push   $0x801126a0
80103302:	e8 09 16 00 00       	call   80104910 <acquire>
80103307:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
8010330d:	83 c4 10             	add    $0x10,%esp
80103310:	85 d2                	test   %edx,%edx
80103312:	7e 4e                	jle    80103362 <log_write+0xa2>
80103314:	8b 4b 08             	mov    0x8(%ebx),%ecx
80103317:	31 c0                	xor    %eax,%eax
80103319:	eb 0c                	jmp    80103327 <log_write+0x67>
8010331b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010331f:	90                   	nop
80103320:	83 c0 01             	add    $0x1,%eax
80103323:	39 c2                	cmp    %eax,%edx
80103325:	74 29                	je     80103350 <log_write+0x90>
80103327:	39 0c 85 ec 26 11 80 	cmp    %ecx,-0x7feed914(,%eax,4)
8010332e:	75 f0                	jne    80103320 <log_write+0x60>
80103330:	89 0c 85 ec 26 11 80 	mov    %ecx,-0x7feed914(,%eax,4)
80103337:	83 0b 04             	orl    $0x4,(%ebx)
8010333a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010333d:	c7 45 08 a0 26 11 80 	movl   $0x801126a0,0x8(%ebp)
80103344:	c9                   	leave  
80103345:	e9 86 16 00 00       	jmp    801049d0 <release>
8010334a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103350:	89 0c 95 ec 26 11 80 	mov    %ecx,-0x7feed914(,%edx,4)
80103357:	83 c2 01             	add    $0x1,%edx
8010335a:	89 15 e8 26 11 80    	mov    %edx,0x801126e8
80103360:	eb d5                	jmp    80103337 <log_write+0x77>
80103362:	8b 43 08             	mov    0x8(%ebx),%eax
80103365:	a3 ec 26 11 80       	mov    %eax,0x801126ec
8010336a:	75 cb                	jne    80103337 <log_write+0x77>
8010336c:	eb e9                	jmp    80103357 <log_write+0x97>
8010336e:	83 ec 0c             	sub    $0xc,%esp
80103371:	68 b3 79 10 80       	push   $0x801079b3
80103376:	e8 15 d0 ff ff       	call   80100390 <panic>
8010337b:	83 ec 0c             	sub    $0xc,%esp
8010337e:	68 c9 79 10 80       	push   $0x801079c9
80103383:	e8 08 d0 ff ff       	call   80100390 <panic>
80103388:	66 90                	xchg   %ax,%ax
8010338a:	66 90                	xchg   %ax,%ax
8010338c:	66 90                	xchg   %ax,%ax
8010338e:	66 90                	xchg   %ax,%ax

80103390 <mpmain>:
80103390:	55                   	push   %ebp
80103391:	89 e5                	mov    %esp,%ebp
80103393:	53                   	push   %ebx
80103394:	83 ec 04             	sub    $0x4,%esp
80103397:	e8 54 09 00 00       	call   80103cf0 <cpuid>
8010339c:	89 c3                	mov    %eax,%ebx
8010339e:	e8 4d 09 00 00       	call   80103cf0 <cpuid>
801033a3:	83 ec 04             	sub    $0x4,%esp
801033a6:	53                   	push   %ebx
801033a7:	50                   	push   %eax
801033a8:	68 e4 79 10 80       	push   $0x801079e4
801033ad:	e8 fe d2 ff ff       	call   801006b0 <cprintf>
801033b2:	e8 19 29 00 00       	call   80105cd0 <idtinit>
801033b7:	e8 c4 08 00 00       	call   80103c80 <mycpu>
801033bc:	89 c2                	mov    %eax,%edx
801033be:	b8 01 00 00 00       	mov    $0x1,%eax
801033c3:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
801033ca:	e8 11 0c 00 00       	call   80103fe0 <scheduler>
801033cf:	90                   	nop

801033d0 <mpenter>:
801033d0:	f3 0f 1e fb          	endbr32 
801033d4:	55                   	push   %ebp
801033d5:	89 e5                	mov    %esp,%ebp
801033d7:	83 ec 08             	sub    $0x8,%esp
801033da:	e8 c1 39 00 00       	call   80106da0 <switchkvm>
801033df:	e8 2c 39 00 00       	call   80106d10 <seginit>
801033e4:	e8 67 f7 ff ff       	call   80102b50 <lapicinit>
801033e9:	e8 a2 ff ff ff       	call   80103390 <mpmain>
801033ee:	66 90                	xchg   %ax,%ax

801033f0 <main>:
801033f0:	f3 0f 1e fb          	endbr32 
801033f4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
801033f8:	83 e4 f0             	and    $0xfffffff0,%esp
801033fb:	ff 71 fc             	pushl  -0x4(%ecx)
801033fe:	55                   	push   %ebp
801033ff:	89 e5                	mov    %esp,%ebp
80103401:	53                   	push   %ebx
80103402:	51                   	push   %ecx
80103403:	83 ec 08             	sub    $0x8,%esp
80103406:	68 00 00 40 80       	push   $0x80400000
8010340b:	68 c8 54 11 80       	push   $0x801154c8
80103410:	e8 fb f4 ff ff       	call   80102910 <kinit1>
80103415:	e8 66 3e 00 00       	call   80107280 <kvmalloc>
8010341a:	e8 81 01 00 00       	call   801035a0 <mpinit>
8010341f:	e8 2c f7 ff ff       	call   80102b50 <lapicinit>
80103424:	e8 e7 38 00 00       	call   80106d10 <seginit>
80103429:	e8 52 03 00 00       	call   80103780 <picinit>
8010342e:	e8 fd f2 ff ff       	call   80102730 <ioapicinit>
80103433:	e8 a8 d9 ff ff       	call   80100de0 <consoleinit>
80103438:	e8 93 2b 00 00       	call   80105fd0 <uartinit>
8010343d:	e8 1e 08 00 00       	call   80103c60 <pinit>
80103442:	e8 09 28 00 00       	call   80105c50 <tvinit>
80103447:	e8 f4 cb ff ff       	call   80100040 <binit>
8010344c:	e8 3f dd ff ff       	call   80101190 <fileinit>
80103451:	e8 aa f0 ff ff       	call   80102500 <ideinit>
80103456:	83 c4 0c             	add    $0xc,%esp
80103459:	68 8a 00 00 00       	push   $0x8a
8010345e:	68 8c a4 10 80       	push   $0x8010a48c
80103463:	68 00 70 00 80       	push   $0x80007000
80103468:	e8 53 16 00 00       	call   80104ac0 <memmove>
8010346d:	83 c4 10             	add    $0x10,%esp
80103470:	69 05 20 2d 11 80 b0 	imul   $0xb0,0x80112d20,%eax
80103477:	00 00 00 
8010347a:	05 a0 27 11 80       	add    $0x801127a0,%eax
8010347f:	3d a0 27 11 80       	cmp    $0x801127a0,%eax
80103484:	76 7a                	jbe    80103500 <main+0x110>
80103486:	bb a0 27 11 80       	mov    $0x801127a0,%ebx
8010348b:	eb 1c                	jmp    801034a9 <main+0xb9>
8010348d:	8d 76 00             	lea    0x0(%esi),%esi
80103490:	69 05 20 2d 11 80 b0 	imul   $0xb0,0x80112d20,%eax
80103497:	00 00 00 
8010349a:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
801034a0:	05 a0 27 11 80       	add    $0x801127a0,%eax
801034a5:	39 c3                	cmp    %eax,%ebx
801034a7:	73 57                	jae    80103500 <main+0x110>
801034a9:	e8 d2 07 00 00       	call   80103c80 <mycpu>
801034ae:	39 c3                	cmp    %eax,%ebx
801034b0:	74 de                	je     80103490 <main+0xa0>
801034b2:	e8 29 f5 ff ff       	call   801029e0 <kalloc>
801034b7:	83 ec 08             	sub    $0x8,%esp
801034ba:	c7 05 f8 6f 00 80 d0 	movl   $0x801033d0,0x80006ff8
801034c1:	33 10 80 
801034c4:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
801034cb:	90 10 00 
801034ce:	05 00 10 00 00       	add    $0x1000,%eax
801034d3:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
801034d8:	0f b6 03             	movzbl (%ebx),%eax
801034db:	68 00 70 00 00       	push   $0x7000
801034e0:	50                   	push   %eax
801034e1:	e8 ba f7 ff ff       	call   80102ca0 <lapicstartap>
801034e6:	83 c4 10             	add    $0x10,%esp
801034e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801034f0:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
801034f6:	85 c0                	test   %eax,%eax
801034f8:	74 f6                	je     801034f0 <main+0x100>
801034fa:	eb 94                	jmp    80103490 <main+0xa0>
801034fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103500:	83 ec 08             	sub    $0x8,%esp
80103503:	68 00 00 00 8e       	push   $0x8e000000
80103508:	68 00 00 40 80       	push   $0x80400000
8010350d:	e8 6e f4 ff ff       	call   80102980 <kinit2>
80103512:	e8 29 08 00 00       	call   80103d40 <userinit>
80103517:	e8 74 fe ff ff       	call   80103390 <mpmain>
8010351c:	66 90                	xchg   %ax,%ax
8010351e:	66 90                	xchg   %ax,%ax

80103520 <mpsearch1>:
80103520:	55                   	push   %ebp
80103521:	89 e5                	mov    %esp,%ebp
80103523:	57                   	push   %edi
80103524:	56                   	push   %esi
80103525:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
8010352b:	53                   	push   %ebx
8010352c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
8010352f:	83 ec 0c             	sub    $0xc,%esp
80103532:	39 de                	cmp    %ebx,%esi
80103534:	72 10                	jb     80103546 <mpsearch1+0x26>
80103536:	eb 50                	jmp    80103588 <mpsearch1+0x68>
80103538:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010353f:	90                   	nop
80103540:	89 fe                	mov    %edi,%esi
80103542:	39 fb                	cmp    %edi,%ebx
80103544:	76 42                	jbe    80103588 <mpsearch1+0x68>
80103546:	83 ec 04             	sub    $0x4,%esp
80103549:	8d 7e 10             	lea    0x10(%esi),%edi
8010354c:	6a 04                	push   $0x4
8010354e:	68 f8 79 10 80       	push   $0x801079f8
80103553:	56                   	push   %esi
80103554:	e8 17 15 00 00       	call   80104a70 <memcmp>
80103559:	83 c4 10             	add    $0x10,%esp
8010355c:	85 c0                	test   %eax,%eax
8010355e:	75 e0                	jne    80103540 <mpsearch1+0x20>
80103560:	89 f2                	mov    %esi,%edx
80103562:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103568:	0f b6 0a             	movzbl (%edx),%ecx
8010356b:	83 c2 01             	add    $0x1,%edx
8010356e:	01 c8                	add    %ecx,%eax
80103570:	39 fa                	cmp    %edi,%edx
80103572:	75 f4                	jne    80103568 <mpsearch1+0x48>
80103574:	84 c0                	test   %al,%al
80103576:	75 c8                	jne    80103540 <mpsearch1+0x20>
80103578:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010357b:	89 f0                	mov    %esi,%eax
8010357d:	5b                   	pop    %ebx
8010357e:	5e                   	pop    %esi
8010357f:	5f                   	pop    %edi
80103580:	5d                   	pop    %ebp
80103581:	c3                   	ret    
80103582:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103588:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010358b:	31 f6                	xor    %esi,%esi
8010358d:	5b                   	pop    %ebx
8010358e:	89 f0                	mov    %esi,%eax
80103590:	5e                   	pop    %esi
80103591:	5f                   	pop    %edi
80103592:	5d                   	pop    %ebp
80103593:	c3                   	ret    
80103594:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010359b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010359f:	90                   	nop

801035a0 <mpinit>:
801035a0:	f3 0f 1e fb          	endbr32 
801035a4:	55                   	push   %ebp
801035a5:	89 e5                	mov    %esp,%ebp
801035a7:	57                   	push   %edi
801035a8:	56                   	push   %esi
801035a9:	53                   	push   %ebx
801035aa:	83 ec 1c             	sub    $0x1c,%esp
801035ad:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
801035b4:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
801035bb:	c1 e0 08             	shl    $0x8,%eax
801035be:	09 d0                	or     %edx,%eax
801035c0:	c1 e0 04             	shl    $0x4,%eax
801035c3:	75 1b                	jne    801035e0 <mpinit+0x40>
801035c5:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
801035cc:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
801035d3:	c1 e0 08             	shl    $0x8,%eax
801035d6:	09 d0                	or     %edx,%eax
801035d8:	c1 e0 0a             	shl    $0xa,%eax
801035db:	2d 00 04 00 00       	sub    $0x400,%eax
801035e0:	ba 00 04 00 00       	mov    $0x400,%edx
801035e5:	e8 36 ff ff ff       	call   80103520 <mpsearch1>
801035ea:	89 c6                	mov    %eax,%esi
801035ec:	85 c0                	test   %eax,%eax
801035ee:	0f 84 4c 01 00 00    	je     80103740 <mpinit+0x1a0>
801035f4:	8b 5e 04             	mov    0x4(%esi),%ebx
801035f7:	85 db                	test   %ebx,%ebx
801035f9:	0f 84 61 01 00 00    	je     80103760 <mpinit+0x1c0>
801035ff:	83 ec 04             	sub    $0x4,%esp
80103602:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80103608:	6a 04                	push   $0x4
8010360a:	68 fd 79 10 80       	push   $0x801079fd
8010360f:	50                   	push   %eax
80103610:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103613:	e8 58 14 00 00       	call   80104a70 <memcmp>
80103618:	83 c4 10             	add    $0x10,%esp
8010361b:	85 c0                	test   %eax,%eax
8010361d:	0f 85 3d 01 00 00    	jne    80103760 <mpinit+0x1c0>
80103623:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
8010362a:	3c 01                	cmp    $0x1,%al
8010362c:	74 08                	je     80103636 <mpinit+0x96>
8010362e:	3c 04                	cmp    $0x4,%al
80103630:	0f 85 2a 01 00 00    	jne    80103760 <mpinit+0x1c0>
80103636:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
8010363d:	66 85 d2             	test   %dx,%dx
80103640:	74 26                	je     80103668 <mpinit+0xc8>
80103642:	8d 3c 1a             	lea    (%edx,%ebx,1),%edi
80103645:	89 d8                	mov    %ebx,%eax
80103647:	31 d2                	xor    %edx,%edx
80103649:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103650:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
80103657:	83 c0 01             	add    $0x1,%eax
8010365a:	01 ca                	add    %ecx,%edx
8010365c:	39 f8                	cmp    %edi,%eax
8010365e:	75 f0                	jne    80103650 <mpinit+0xb0>
80103660:	84 d2                	test   %dl,%dl
80103662:	0f 85 f8 00 00 00    	jne    80103760 <mpinit+0x1c0>
80103668:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
8010366e:	a3 9c 26 11 80       	mov    %eax,0x8011269c
80103673:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
80103679:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
80103680:	bb 01 00 00 00       	mov    $0x1,%ebx
80103685:	03 55 e4             	add    -0x1c(%ebp),%edx
80103688:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
8010368b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010368f:	90                   	nop
80103690:	39 c2                	cmp    %eax,%edx
80103692:	76 15                	jbe    801036a9 <mpinit+0x109>
80103694:	0f b6 08             	movzbl (%eax),%ecx
80103697:	80 f9 02             	cmp    $0x2,%cl
8010369a:	74 5c                	je     801036f8 <mpinit+0x158>
8010369c:	77 42                	ja     801036e0 <mpinit+0x140>
8010369e:	84 c9                	test   %cl,%cl
801036a0:	74 6e                	je     80103710 <mpinit+0x170>
801036a2:	83 c0 08             	add    $0x8,%eax
801036a5:	39 c2                	cmp    %eax,%edx
801036a7:	77 eb                	ja     80103694 <mpinit+0xf4>
801036a9:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801036ac:	85 db                	test   %ebx,%ebx
801036ae:	0f 84 b9 00 00 00    	je     8010376d <mpinit+0x1cd>
801036b4:	80 7e 0c 00          	cmpb   $0x0,0xc(%esi)
801036b8:	74 15                	je     801036cf <mpinit+0x12f>
801036ba:	b8 70 00 00 00       	mov    $0x70,%eax
801036bf:	ba 22 00 00 00       	mov    $0x22,%edx
801036c4:	ee                   	out    %al,(%dx)
801036c5:	ba 23 00 00 00       	mov    $0x23,%edx
801036ca:	ec                   	in     (%dx),%al
801036cb:	83 c8 01             	or     $0x1,%eax
801036ce:	ee                   	out    %al,(%dx)
801036cf:	8d 65 f4             	lea    -0xc(%ebp),%esp
801036d2:	5b                   	pop    %ebx
801036d3:	5e                   	pop    %esi
801036d4:	5f                   	pop    %edi
801036d5:	5d                   	pop    %ebp
801036d6:	c3                   	ret    
801036d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801036de:	66 90                	xchg   %ax,%ax
801036e0:	83 e9 03             	sub    $0x3,%ecx
801036e3:	80 f9 01             	cmp    $0x1,%cl
801036e6:	76 ba                	jbe    801036a2 <mpinit+0x102>
801036e8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
801036ef:	eb 9f                	jmp    80103690 <mpinit+0xf0>
801036f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801036f8:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
801036fc:	83 c0 08             	add    $0x8,%eax
801036ff:	88 0d 80 27 11 80    	mov    %cl,0x80112780
80103705:	eb 89                	jmp    80103690 <mpinit+0xf0>
80103707:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010370e:	66 90                	xchg   %ax,%ax
80103710:	8b 0d 20 2d 11 80    	mov    0x80112d20,%ecx
80103716:	83 f9 07             	cmp    $0x7,%ecx
80103719:	7f 19                	jg     80103734 <mpinit+0x194>
8010371b:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
80103721:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
80103725:	83 c1 01             	add    $0x1,%ecx
80103728:	89 0d 20 2d 11 80    	mov    %ecx,0x80112d20
8010372e:	88 9f a0 27 11 80    	mov    %bl,-0x7feed860(%edi)
80103734:	83 c0 14             	add    $0x14,%eax
80103737:	e9 54 ff ff ff       	jmp    80103690 <mpinit+0xf0>
8010373c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103740:	ba 00 00 01 00       	mov    $0x10000,%edx
80103745:	b8 00 00 0f 00       	mov    $0xf0000,%eax
8010374a:	e8 d1 fd ff ff       	call   80103520 <mpsearch1>
8010374f:	89 c6                	mov    %eax,%esi
80103751:	85 c0                	test   %eax,%eax
80103753:	0f 85 9b fe ff ff    	jne    801035f4 <mpinit+0x54>
80103759:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103760:	83 ec 0c             	sub    $0xc,%esp
80103763:	68 02 7a 10 80       	push   $0x80107a02
80103768:	e8 23 cc ff ff       	call   80100390 <panic>
8010376d:	83 ec 0c             	sub    $0xc,%esp
80103770:	68 1c 7a 10 80       	push   $0x80107a1c
80103775:	e8 16 cc ff ff       	call   80100390 <panic>
8010377a:	66 90                	xchg   %ax,%ax
8010377c:	66 90                	xchg   %ax,%ax
8010377e:	66 90                	xchg   %ax,%ax

80103780 <picinit>:
80103780:	f3 0f 1e fb          	endbr32 
80103784:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103789:	ba 21 00 00 00       	mov    $0x21,%edx
8010378e:	ee                   	out    %al,(%dx)
8010378f:	ba a1 00 00 00       	mov    $0xa1,%edx
80103794:	ee                   	out    %al,(%dx)
80103795:	c3                   	ret    
80103796:	66 90                	xchg   %ax,%ax
80103798:	66 90                	xchg   %ax,%ax
8010379a:	66 90                	xchg   %ax,%ax
8010379c:	66 90                	xchg   %ax,%ax
8010379e:	66 90                	xchg   %ax,%ax

801037a0 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
801037a0:	f3 0f 1e fb          	endbr32 
801037a4:	55                   	push   %ebp
801037a5:	89 e5                	mov    %esp,%ebp
801037a7:	57                   	push   %edi
801037a8:	56                   	push   %esi
801037a9:	53                   	push   %ebx
801037aa:	83 ec 0c             	sub    $0xc,%esp
801037ad:	8b 5d 08             	mov    0x8(%ebp),%ebx
801037b0:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
801037b3:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801037b9:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
801037bf:	e8 ec d9 ff ff       	call   801011b0 <filealloc>
801037c4:	89 03                	mov    %eax,(%ebx)
801037c6:	85 c0                	test   %eax,%eax
801037c8:	0f 84 ac 00 00 00    	je     8010387a <pipealloc+0xda>
801037ce:	e8 dd d9 ff ff       	call   801011b0 <filealloc>
801037d3:	89 06                	mov    %eax,(%esi)
801037d5:	85 c0                	test   %eax,%eax
801037d7:	0f 84 8b 00 00 00    	je     80103868 <pipealloc+0xc8>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
801037dd:	e8 fe f1 ff ff       	call   801029e0 <kalloc>
801037e2:	89 c7                	mov    %eax,%edi
801037e4:	85 c0                	test   %eax,%eax
801037e6:	0f 84 b4 00 00 00    	je     801038a0 <pipealloc+0x100>
    goto bad;
  p->readopen = 1;
801037ec:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801037f3:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
801037f6:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
801037f9:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103800:	00 00 00 
  p->nwrite = 0;
80103803:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
8010380a:	00 00 00 
  p->nread = 0;
8010380d:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103814:	00 00 00 
  initlock(&p->lock, "pipe");
80103817:	68 3b 7a 10 80       	push   $0x80107a3b
8010381c:	50                   	push   %eax
8010381d:	e8 6e 0f 00 00       	call   80104790 <initlock>
  (*f0)->type = FD_PIPE;
80103822:	8b 03                	mov    (%ebx),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103824:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80103827:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
8010382d:	8b 03                	mov    (%ebx),%eax
8010382f:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103833:	8b 03                	mov    (%ebx),%eax
80103835:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103839:	8b 03                	mov    (%ebx),%eax
8010383b:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
8010383e:	8b 06                	mov    (%esi),%eax
80103840:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103846:	8b 06                	mov    (%esi),%eax
80103848:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
8010384c:	8b 06                	mov    (%esi),%eax
8010384e:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103852:	8b 06                	mov    (%esi),%eax
80103854:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103857:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010385a:	31 c0                	xor    %eax,%eax
}
8010385c:	5b                   	pop    %ebx
8010385d:	5e                   	pop    %esi
8010385e:	5f                   	pop    %edi
8010385f:	5d                   	pop    %ebp
80103860:	c3                   	ret    
80103861:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(*f0)
80103868:	8b 03                	mov    (%ebx),%eax
8010386a:	85 c0                	test   %eax,%eax
8010386c:	74 1e                	je     8010388c <pipealloc+0xec>
    fileclose(*f0);
8010386e:	83 ec 0c             	sub    $0xc,%esp
80103871:	50                   	push   %eax
80103872:	e8 f9 d9 ff ff       	call   80101270 <fileclose>
80103877:	83 c4 10             	add    $0x10,%esp
  if(*f1)
8010387a:	8b 06                	mov    (%esi),%eax
8010387c:	85 c0                	test   %eax,%eax
8010387e:	74 0c                	je     8010388c <pipealloc+0xec>
    fileclose(*f1);
80103880:	83 ec 0c             	sub    $0xc,%esp
80103883:	50                   	push   %eax
80103884:	e8 e7 d9 ff ff       	call   80101270 <fileclose>
80103889:	83 c4 10             	add    $0x10,%esp
}
8010388c:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
8010388f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103894:	5b                   	pop    %ebx
80103895:	5e                   	pop    %esi
80103896:	5f                   	pop    %edi
80103897:	5d                   	pop    %ebp
80103898:	c3                   	ret    
80103899:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(*f0)
801038a0:	8b 03                	mov    (%ebx),%eax
801038a2:	85 c0                	test   %eax,%eax
801038a4:	75 c8                	jne    8010386e <pipealloc+0xce>
801038a6:	eb d2                	jmp    8010387a <pipealloc+0xda>
801038a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801038af:	90                   	nop

801038b0 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
801038b0:	f3 0f 1e fb          	endbr32 
801038b4:	55                   	push   %ebp
801038b5:	89 e5                	mov    %esp,%ebp
801038b7:	56                   	push   %esi
801038b8:	53                   	push   %ebx
801038b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801038bc:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
801038bf:	83 ec 0c             	sub    $0xc,%esp
801038c2:	53                   	push   %ebx
801038c3:	e8 48 10 00 00       	call   80104910 <acquire>
  if(writable){
801038c8:	83 c4 10             	add    $0x10,%esp
801038cb:	85 f6                	test   %esi,%esi
801038cd:	74 41                	je     80103910 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
801038cf:	83 ec 0c             	sub    $0xc,%esp
801038d2:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
801038d8:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
801038df:	00 00 00 
    wakeup(&p->nread);
801038e2:	50                   	push   %eax
801038e3:	e8 a8 0b 00 00       	call   80104490 <wakeup>
801038e8:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
801038eb:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
801038f1:	85 d2                	test   %edx,%edx
801038f3:	75 0a                	jne    801038ff <pipeclose+0x4f>
801038f5:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
801038fb:	85 c0                	test   %eax,%eax
801038fd:	74 31                	je     80103930 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
801038ff:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80103902:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103905:	5b                   	pop    %ebx
80103906:	5e                   	pop    %esi
80103907:	5d                   	pop    %ebp
    release(&p->lock);
80103908:	e9 c3 10 00 00       	jmp    801049d0 <release>
8010390d:	8d 76 00             	lea    0x0(%esi),%esi
    wakeup(&p->nwrite);
80103910:	83 ec 0c             	sub    $0xc,%esp
80103913:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
80103919:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103920:	00 00 00 
    wakeup(&p->nwrite);
80103923:	50                   	push   %eax
80103924:	e8 67 0b 00 00       	call   80104490 <wakeup>
80103929:	83 c4 10             	add    $0x10,%esp
8010392c:	eb bd                	jmp    801038eb <pipeclose+0x3b>
8010392e:	66 90                	xchg   %ax,%ax
    release(&p->lock);
80103930:	83 ec 0c             	sub    $0xc,%esp
80103933:	53                   	push   %ebx
80103934:	e8 97 10 00 00       	call   801049d0 <release>
    kfree((char*)p);
80103939:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010393c:	83 c4 10             	add    $0x10,%esp
}
8010393f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103942:	5b                   	pop    %ebx
80103943:	5e                   	pop    %esi
80103944:	5d                   	pop    %ebp
    kfree((char*)p);
80103945:	e9 d6 ee ff ff       	jmp    80102820 <kfree>
8010394a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103950 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103950:	f3 0f 1e fb          	endbr32 
80103954:	55                   	push   %ebp
80103955:	89 e5                	mov    %esp,%ebp
80103957:	57                   	push   %edi
80103958:	56                   	push   %esi
80103959:	53                   	push   %ebx
8010395a:	83 ec 28             	sub    $0x28,%esp
8010395d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
80103960:	53                   	push   %ebx
80103961:	e8 aa 0f 00 00       	call   80104910 <acquire>
  for(i = 0; i < n; i++){
80103966:	8b 45 10             	mov    0x10(%ebp),%eax
80103969:	83 c4 10             	add    $0x10,%esp
8010396c:	85 c0                	test   %eax,%eax
8010396e:	0f 8e bc 00 00 00    	jle    80103a30 <pipewrite+0xe0>
80103974:	8b 45 0c             	mov    0xc(%ebp),%eax
80103977:	8b 8b 38 02 00 00    	mov    0x238(%ebx),%ecx
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
8010397d:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
80103983:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103986:	03 45 10             	add    0x10(%ebp),%eax
80103989:	89 45 e0             	mov    %eax,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010398c:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103992:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103998:	89 ca                	mov    %ecx,%edx
8010399a:	05 00 02 00 00       	add    $0x200,%eax
8010399f:	39 c1                	cmp    %eax,%ecx
801039a1:	74 3b                	je     801039de <pipewrite+0x8e>
801039a3:	eb 63                	jmp    80103a08 <pipewrite+0xb8>
801039a5:	8d 76 00             	lea    0x0(%esi),%esi
      if(p->readopen == 0 || myproc()->killed){
801039a8:	e8 63 03 00 00       	call   80103d10 <myproc>
801039ad:	8b 48 24             	mov    0x24(%eax),%ecx
801039b0:	85 c9                	test   %ecx,%ecx
801039b2:	75 34                	jne    801039e8 <pipewrite+0x98>
      wakeup(&p->nread);
801039b4:	83 ec 0c             	sub    $0xc,%esp
801039b7:	57                   	push   %edi
801039b8:	e8 d3 0a 00 00       	call   80104490 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801039bd:	58                   	pop    %eax
801039be:	5a                   	pop    %edx
801039bf:	53                   	push   %ebx
801039c0:	56                   	push   %esi
801039c1:	e8 0a 09 00 00       	call   801042d0 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801039c6:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801039cc:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
801039d2:	83 c4 10             	add    $0x10,%esp
801039d5:	05 00 02 00 00       	add    $0x200,%eax
801039da:	39 c2                	cmp    %eax,%edx
801039dc:	75 2a                	jne    80103a08 <pipewrite+0xb8>
      if(p->readopen == 0 || myproc()->killed){
801039de:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
801039e4:	85 c0                	test   %eax,%eax
801039e6:	75 c0                	jne    801039a8 <pipewrite+0x58>
        release(&p->lock);
801039e8:	83 ec 0c             	sub    $0xc,%esp
801039eb:	53                   	push   %ebx
801039ec:	e8 df 0f 00 00       	call   801049d0 <release>
        return -1;
801039f1:	83 c4 10             	add    $0x10,%esp
801039f4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
801039f9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801039fc:	5b                   	pop    %ebx
801039fd:	5e                   	pop    %esi
801039fe:	5f                   	pop    %edi
801039ff:	5d                   	pop    %ebp
80103a00:	c3                   	ret    
80103a01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103a08:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80103a0b:	8d 4a 01             	lea    0x1(%edx),%ecx
80103a0e:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80103a14:	89 8b 38 02 00 00    	mov    %ecx,0x238(%ebx)
80103a1a:	0f b6 06             	movzbl (%esi),%eax
80103a1d:	83 c6 01             	add    $0x1,%esi
80103a20:	89 75 e4             	mov    %esi,-0x1c(%ebp)
80103a23:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
80103a27:	3b 75 e0             	cmp    -0x20(%ebp),%esi
80103a2a:	0f 85 5c ff ff ff    	jne    8010398c <pipewrite+0x3c>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103a30:	83 ec 0c             	sub    $0xc,%esp
80103a33:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103a39:	50                   	push   %eax
80103a3a:	e8 51 0a 00 00       	call   80104490 <wakeup>
  release(&p->lock);
80103a3f:	89 1c 24             	mov    %ebx,(%esp)
80103a42:	e8 89 0f 00 00       	call   801049d0 <release>
  return n;
80103a47:	8b 45 10             	mov    0x10(%ebp),%eax
80103a4a:	83 c4 10             	add    $0x10,%esp
80103a4d:	eb aa                	jmp    801039f9 <pipewrite+0xa9>
80103a4f:	90                   	nop

80103a50 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103a50:	f3 0f 1e fb          	endbr32 
80103a54:	55                   	push   %ebp
80103a55:	89 e5                	mov    %esp,%ebp
80103a57:	57                   	push   %edi
80103a58:	56                   	push   %esi
80103a59:	53                   	push   %ebx
80103a5a:	83 ec 18             	sub    $0x18,%esp
80103a5d:	8b 75 08             	mov    0x8(%ebp),%esi
80103a60:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
80103a63:	56                   	push   %esi
80103a64:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
80103a6a:	e8 a1 0e 00 00       	call   80104910 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103a6f:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103a75:	83 c4 10             	add    $0x10,%esp
80103a78:	39 86 38 02 00 00    	cmp    %eax,0x238(%esi)
80103a7e:	74 33                	je     80103ab3 <piperead+0x63>
80103a80:	eb 3b                	jmp    80103abd <piperead+0x6d>
80103a82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(myproc()->killed){
80103a88:	e8 83 02 00 00       	call   80103d10 <myproc>
80103a8d:	8b 48 24             	mov    0x24(%eax),%ecx
80103a90:	85 c9                	test   %ecx,%ecx
80103a92:	0f 85 88 00 00 00    	jne    80103b20 <piperead+0xd0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103a98:	83 ec 08             	sub    $0x8,%esp
80103a9b:	56                   	push   %esi
80103a9c:	53                   	push   %ebx
80103a9d:	e8 2e 08 00 00       	call   801042d0 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103aa2:	8b 86 38 02 00 00    	mov    0x238(%esi),%eax
80103aa8:	83 c4 10             	add    $0x10,%esp
80103aab:	39 86 34 02 00 00    	cmp    %eax,0x234(%esi)
80103ab1:	75 0a                	jne    80103abd <piperead+0x6d>
80103ab3:	8b 86 40 02 00 00    	mov    0x240(%esi),%eax
80103ab9:	85 c0                	test   %eax,%eax
80103abb:	75 cb                	jne    80103a88 <piperead+0x38>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103abd:	8b 55 10             	mov    0x10(%ebp),%edx
80103ac0:	31 db                	xor    %ebx,%ebx
80103ac2:	85 d2                	test   %edx,%edx
80103ac4:	7f 28                	jg     80103aee <piperead+0x9e>
80103ac6:	eb 34                	jmp    80103afc <piperead+0xac>
80103ac8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103acf:	90                   	nop
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103ad0:	8d 48 01             	lea    0x1(%eax),%ecx
80103ad3:	25 ff 01 00 00       	and    $0x1ff,%eax
80103ad8:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
80103ade:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80103ae3:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103ae6:	83 c3 01             	add    $0x1,%ebx
80103ae9:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80103aec:	74 0e                	je     80103afc <piperead+0xac>
    if(p->nread == p->nwrite)
80103aee:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103af4:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80103afa:	75 d4                	jne    80103ad0 <piperead+0x80>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80103afc:	83 ec 0c             	sub    $0xc,%esp
80103aff:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103b05:	50                   	push   %eax
80103b06:	e8 85 09 00 00       	call   80104490 <wakeup>
  release(&p->lock);
80103b0b:	89 34 24             	mov    %esi,(%esp)
80103b0e:	e8 bd 0e 00 00       	call   801049d0 <release>
  return i;
80103b13:	83 c4 10             	add    $0x10,%esp
}
80103b16:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103b19:	89 d8                	mov    %ebx,%eax
80103b1b:	5b                   	pop    %ebx
80103b1c:	5e                   	pop    %esi
80103b1d:	5f                   	pop    %edi
80103b1e:	5d                   	pop    %ebp
80103b1f:	c3                   	ret    
      release(&p->lock);
80103b20:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103b23:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
80103b28:	56                   	push   %esi
80103b29:	e8 a2 0e 00 00       	call   801049d0 <release>
      return -1;
80103b2e:	83 c4 10             	add    $0x10,%esp
}
80103b31:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103b34:	89 d8                	mov    %ebx,%eax
80103b36:	5b                   	pop    %ebx
80103b37:	5e                   	pop    %esi
80103b38:	5f                   	pop    %edi
80103b39:	5d                   	pop    %ebp
80103b3a:	c3                   	ret    
80103b3b:	66 90                	xchg   %ax,%ax
80103b3d:	66 90                	xchg   %ax,%ax
80103b3f:	90                   	nop

80103b40 <allocproc>:
80103b40:	55                   	push   %ebp
80103b41:	89 e5                	mov    %esp,%ebp
80103b43:	53                   	push   %ebx
80103b44:	bb 74 2d 11 80       	mov    $0x80112d74,%ebx
80103b49:	83 ec 10             	sub    $0x10,%esp
80103b4c:	68 40 2d 11 80       	push   $0x80112d40
80103b51:	e8 ba 0d 00 00       	call   80104910 <acquire>
80103b56:	83 c4 10             	add    $0x10,%esp
80103b59:	eb 10                	jmp    80103b6b <allocproc+0x2b>
80103b5b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103b5f:	90                   	nop
80103b60:	83 c3 7c             	add    $0x7c,%ebx
80103b63:	81 fb 74 4c 11 80    	cmp    $0x80114c74,%ebx
80103b69:	74 75                	je     80103be0 <allocproc+0xa0>
80103b6b:	8b 43 0c             	mov    0xc(%ebx),%eax
80103b6e:	85 c0                	test   %eax,%eax
80103b70:	75 ee                	jne    80103b60 <allocproc+0x20>
80103b72:	a1 04 a0 10 80       	mov    0x8010a004,%eax
80103b77:	83 ec 0c             	sub    $0xc,%esp
80103b7a:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
80103b81:	89 43 10             	mov    %eax,0x10(%ebx)
80103b84:	8d 50 01             	lea    0x1(%eax),%edx
80103b87:	68 40 2d 11 80       	push   $0x80112d40
80103b8c:	89 15 04 a0 10 80    	mov    %edx,0x8010a004
80103b92:	e8 39 0e 00 00       	call   801049d0 <release>
80103b97:	e8 44 ee ff ff       	call   801029e0 <kalloc>
80103b9c:	83 c4 10             	add    $0x10,%esp
80103b9f:	89 43 08             	mov    %eax,0x8(%ebx)
80103ba2:	85 c0                	test   %eax,%eax
80103ba4:	74 53                	je     80103bf9 <allocproc+0xb9>
80103ba6:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
80103bac:	83 ec 04             	sub    $0x4,%esp
80103baf:	05 9c 0f 00 00       	add    $0xf9c,%eax
80103bb4:	89 53 18             	mov    %edx,0x18(%ebx)
80103bb7:	c7 40 14 36 5c 10 80 	movl   $0x80105c36,0x14(%eax)
80103bbe:	89 43 1c             	mov    %eax,0x1c(%ebx)
80103bc1:	6a 14                	push   $0x14
80103bc3:	6a 00                	push   $0x0
80103bc5:	50                   	push   %eax
80103bc6:	e8 55 0e 00 00       	call   80104a20 <memset>
80103bcb:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103bce:	83 c4 10             	add    $0x10,%esp
80103bd1:	c7 40 10 10 3c 10 80 	movl   $0x80103c10,0x10(%eax)
80103bd8:	89 d8                	mov    %ebx,%eax
80103bda:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103bdd:	c9                   	leave  
80103bde:	c3                   	ret    
80103bdf:	90                   	nop
80103be0:	83 ec 0c             	sub    $0xc,%esp
80103be3:	31 db                	xor    %ebx,%ebx
80103be5:	68 40 2d 11 80       	push   $0x80112d40
80103bea:	e8 e1 0d 00 00       	call   801049d0 <release>
80103bef:	89 d8                	mov    %ebx,%eax
80103bf1:	83 c4 10             	add    $0x10,%esp
80103bf4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103bf7:	c9                   	leave  
80103bf8:	c3                   	ret    
80103bf9:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
80103c00:	31 db                	xor    %ebx,%ebx
80103c02:	89 d8                	mov    %ebx,%eax
80103c04:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103c07:	c9                   	leave  
80103c08:	c3                   	ret    
80103c09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103c10 <forkret>:
80103c10:	f3 0f 1e fb          	endbr32 
80103c14:	55                   	push   %ebp
80103c15:	89 e5                	mov    %esp,%ebp
80103c17:	83 ec 14             	sub    $0x14,%esp
80103c1a:	68 40 2d 11 80       	push   $0x80112d40
80103c1f:	e8 ac 0d 00 00       	call   801049d0 <release>
80103c24:	a1 00 a0 10 80       	mov    0x8010a000,%eax
80103c29:	83 c4 10             	add    $0x10,%esp
80103c2c:	85 c0                	test   %eax,%eax
80103c2e:	75 08                	jne    80103c38 <forkret+0x28>
80103c30:	c9                   	leave  
80103c31:	c3                   	ret    
80103c32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103c38:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
80103c3f:	00 00 00 
80103c42:	83 ec 0c             	sub    $0xc,%esp
80103c45:	6a 01                	push   $0x1
80103c47:	e8 a4 dc ff ff       	call   801018f0 <iinit>
80103c4c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80103c53:	e8 e8 f3 ff ff       	call   80103040 <initlog>
80103c58:	83 c4 10             	add    $0x10,%esp
80103c5b:	c9                   	leave  
80103c5c:	c3                   	ret    
80103c5d:	8d 76 00             	lea    0x0(%esi),%esi

80103c60 <pinit>:
80103c60:	f3 0f 1e fb          	endbr32 
80103c64:	55                   	push   %ebp
80103c65:	89 e5                	mov    %esp,%ebp
80103c67:	83 ec 10             	sub    $0x10,%esp
80103c6a:	68 40 7a 10 80       	push   $0x80107a40
80103c6f:	68 40 2d 11 80       	push   $0x80112d40
80103c74:	e8 17 0b 00 00       	call   80104790 <initlock>
80103c79:	83 c4 10             	add    $0x10,%esp
80103c7c:	c9                   	leave  
80103c7d:	c3                   	ret    
80103c7e:	66 90                	xchg   %ax,%ax

80103c80 <mycpu>:
80103c80:	f3 0f 1e fb          	endbr32 
80103c84:	55                   	push   %ebp
80103c85:	89 e5                	mov    %esp,%ebp
80103c87:	56                   	push   %esi
80103c88:	53                   	push   %ebx
80103c89:	9c                   	pushf  
80103c8a:	58                   	pop    %eax
80103c8b:	f6 c4 02             	test   $0x2,%ah
80103c8e:	75 4a                	jne    80103cda <mycpu+0x5a>
80103c90:	e8 bb ef ff ff       	call   80102c50 <lapicid>
80103c95:	8b 35 20 2d 11 80    	mov    0x80112d20,%esi
80103c9b:	89 c3                	mov    %eax,%ebx
80103c9d:	85 f6                	test   %esi,%esi
80103c9f:	7e 2c                	jle    80103ccd <mycpu+0x4d>
80103ca1:	31 d2                	xor    %edx,%edx
80103ca3:	eb 0a                	jmp    80103caf <mycpu+0x2f>
80103ca5:	8d 76 00             	lea    0x0(%esi),%esi
80103ca8:	83 c2 01             	add    $0x1,%edx
80103cab:	39 f2                	cmp    %esi,%edx
80103cad:	74 1e                	je     80103ccd <mycpu+0x4d>
80103caf:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
80103cb5:	0f b6 81 a0 27 11 80 	movzbl -0x7feed860(%ecx),%eax
80103cbc:	39 d8                	cmp    %ebx,%eax
80103cbe:	75 e8                	jne    80103ca8 <mycpu+0x28>
80103cc0:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103cc3:	8d 81 a0 27 11 80    	lea    -0x7feed860(%ecx),%eax
80103cc9:	5b                   	pop    %ebx
80103cca:	5e                   	pop    %esi
80103ccb:	5d                   	pop    %ebp
80103ccc:	c3                   	ret    
80103ccd:	83 ec 0c             	sub    $0xc,%esp
80103cd0:	68 47 7a 10 80       	push   $0x80107a47
80103cd5:	e8 b6 c6 ff ff       	call   80100390 <panic>
80103cda:	83 ec 0c             	sub    $0xc,%esp
80103cdd:	68 24 7b 10 80       	push   $0x80107b24
80103ce2:	e8 a9 c6 ff ff       	call   80100390 <panic>
80103ce7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103cee:	66 90                	xchg   %ax,%ax

80103cf0 <cpuid>:
80103cf0:	f3 0f 1e fb          	endbr32 
80103cf4:	55                   	push   %ebp
80103cf5:	89 e5                	mov    %esp,%ebp
80103cf7:	83 ec 08             	sub    $0x8,%esp
80103cfa:	e8 81 ff ff ff       	call   80103c80 <mycpu>
80103cff:	c9                   	leave  
80103d00:	2d a0 27 11 80       	sub    $0x801127a0,%eax
80103d05:	c1 f8 04             	sar    $0x4,%eax
80103d08:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
80103d0e:	c3                   	ret    
80103d0f:	90                   	nop

80103d10 <myproc>:
80103d10:	f3 0f 1e fb          	endbr32 
80103d14:	55                   	push   %ebp
80103d15:	89 e5                	mov    %esp,%ebp
80103d17:	53                   	push   %ebx
80103d18:	83 ec 04             	sub    $0x4,%esp
80103d1b:	e8 f0 0a 00 00       	call   80104810 <pushcli>
80103d20:	e8 5b ff ff ff       	call   80103c80 <mycpu>
80103d25:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
80103d2b:	e8 30 0b 00 00       	call   80104860 <popcli>
80103d30:	83 c4 04             	add    $0x4,%esp
80103d33:	89 d8                	mov    %ebx,%eax
80103d35:	5b                   	pop    %ebx
80103d36:	5d                   	pop    %ebp
80103d37:	c3                   	ret    
80103d38:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103d3f:	90                   	nop

80103d40 <userinit>:
80103d40:	f3 0f 1e fb          	endbr32 
80103d44:	55                   	push   %ebp
80103d45:	89 e5                	mov    %esp,%ebp
80103d47:	53                   	push   %ebx
80103d48:	83 ec 04             	sub    $0x4,%esp
80103d4b:	e8 f0 fd ff ff       	call   80103b40 <allocproc>
80103d50:	89 c3                	mov    %eax,%ebx
80103d52:	a3 d8 a5 10 80       	mov    %eax,0x8010a5d8
80103d57:	e8 a4 34 00 00       	call   80107200 <setupkvm>
80103d5c:	89 43 04             	mov    %eax,0x4(%ebx)
80103d5f:	85 c0                	test   %eax,%eax
80103d61:	0f 84 bd 00 00 00    	je     80103e24 <userinit+0xe4>
80103d67:	83 ec 04             	sub    $0x4,%esp
80103d6a:	68 2c 00 00 00       	push   $0x2c
80103d6f:	68 60 a4 10 80       	push   $0x8010a460
80103d74:	50                   	push   %eax
80103d75:	e8 56 31 00 00       	call   80106ed0 <inituvm>
80103d7a:	83 c4 0c             	add    $0xc,%esp
80103d7d:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
80103d83:	6a 4c                	push   $0x4c
80103d85:	6a 00                	push   $0x0
80103d87:	ff 73 18             	pushl  0x18(%ebx)
80103d8a:	e8 91 0c 00 00       	call   80104a20 <memset>
80103d8f:	8b 43 18             	mov    0x18(%ebx),%eax
80103d92:	ba 1b 00 00 00       	mov    $0x1b,%edx
80103d97:	83 c4 0c             	add    $0xc,%esp
80103d9a:	b9 23 00 00 00       	mov    $0x23,%ecx
80103d9f:	66 89 50 3c          	mov    %dx,0x3c(%eax)
80103da3:	8b 43 18             	mov    0x18(%ebx),%eax
80103da6:	66 89 48 2c          	mov    %cx,0x2c(%eax)
80103daa:	8b 43 18             	mov    0x18(%ebx),%eax
80103dad:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103db1:	66 89 50 28          	mov    %dx,0x28(%eax)
80103db5:	8b 43 18             	mov    0x18(%ebx),%eax
80103db8:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103dbc:	66 89 50 48          	mov    %dx,0x48(%eax)
80103dc0:	8b 43 18             	mov    0x18(%ebx),%eax
80103dc3:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
80103dca:	8b 43 18             	mov    0x18(%ebx),%eax
80103dcd:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
80103dd4:	8b 43 18             	mov    0x18(%ebx),%eax
80103dd7:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
80103dde:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103de1:	6a 10                	push   $0x10
80103de3:	68 70 7a 10 80       	push   $0x80107a70
80103de8:	50                   	push   %eax
80103de9:	e8 f2 0d 00 00       	call   80104be0 <safestrcpy>
80103dee:	c7 04 24 79 7a 10 80 	movl   $0x80107a79,(%esp)
80103df5:	e8 e6 e5 ff ff       	call   801023e0 <namei>
80103dfa:	89 43 68             	mov    %eax,0x68(%ebx)
80103dfd:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103e04:	e8 07 0b 00 00       	call   80104910 <acquire>
80103e09:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
80103e10:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103e17:	e8 b4 0b 00 00       	call   801049d0 <release>
80103e1c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103e1f:	83 c4 10             	add    $0x10,%esp
80103e22:	c9                   	leave  
80103e23:	c3                   	ret    
80103e24:	83 ec 0c             	sub    $0xc,%esp
80103e27:	68 57 7a 10 80       	push   $0x80107a57
80103e2c:	e8 5f c5 ff ff       	call   80100390 <panic>
80103e31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e38:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e3f:	90                   	nop

80103e40 <growproc>:
80103e40:	f3 0f 1e fb          	endbr32 
80103e44:	55                   	push   %ebp
80103e45:	89 e5                	mov    %esp,%ebp
80103e47:	56                   	push   %esi
80103e48:	53                   	push   %ebx
80103e49:	8b 75 08             	mov    0x8(%ebp),%esi
80103e4c:	e8 bf 09 00 00       	call   80104810 <pushcli>
80103e51:	e8 2a fe ff ff       	call   80103c80 <mycpu>
80103e56:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
80103e5c:	e8 ff 09 00 00       	call   80104860 <popcli>
80103e61:	8b 03                	mov    (%ebx),%eax
80103e63:	85 f6                	test   %esi,%esi
80103e65:	7f 19                	jg     80103e80 <growproc+0x40>
80103e67:	75 37                	jne    80103ea0 <growproc+0x60>
80103e69:	83 ec 0c             	sub    $0xc,%esp
80103e6c:	89 03                	mov    %eax,(%ebx)
80103e6e:	53                   	push   %ebx
80103e6f:	e8 4c 2f 00 00       	call   80106dc0 <switchuvm>
80103e74:	83 c4 10             	add    $0x10,%esp
80103e77:	31 c0                	xor    %eax,%eax
80103e79:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103e7c:	5b                   	pop    %ebx
80103e7d:	5e                   	pop    %esi
80103e7e:	5d                   	pop    %ebp
80103e7f:	c3                   	ret    
80103e80:	83 ec 04             	sub    $0x4,%esp
80103e83:	01 c6                	add    %eax,%esi
80103e85:	56                   	push   %esi
80103e86:	50                   	push   %eax
80103e87:	ff 73 04             	pushl  0x4(%ebx)
80103e8a:	e8 91 31 00 00       	call   80107020 <allocuvm>
80103e8f:	83 c4 10             	add    $0x10,%esp
80103e92:	85 c0                	test   %eax,%eax
80103e94:	75 d3                	jne    80103e69 <growproc+0x29>
80103e96:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103e9b:	eb dc                	jmp    80103e79 <growproc+0x39>
80103e9d:	8d 76 00             	lea    0x0(%esi),%esi
80103ea0:	83 ec 04             	sub    $0x4,%esp
80103ea3:	01 c6                	add    %eax,%esi
80103ea5:	56                   	push   %esi
80103ea6:	50                   	push   %eax
80103ea7:	ff 73 04             	pushl  0x4(%ebx)
80103eaa:	e8 a1 32 00 00       	call   80107150 <deallocuvm>
80103eaf:	83 c4 10             	add    $0x10,%esp
80103eb2:	85 c0                	test   %eax,%eax
80103eb4:	75 b3                	jne    80103e69 <growproc+0x29>
80103eb6:	eb de                	jmp    80103e96 <growproc+0x56>
80103eb8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103ebf:	90                   	nop

80103ec0 <fork>:
80103ec0:	f3 0f 1e fb          	endbr32 
80103ec4:	55                   	push   %ebp
80103ec5:	89 e5                	mov    %esp,%ebp
80103ec7:	57                   	push   %edi
80103ec8:	56                   	push   %esi
80103ec9:	53                   	push   %ebx
80103eca:	83 ec 1c             	sub    $0x1c,%esp
80103ecd:	e8 3e 09 00 00       	call   80104810 <pushcli>
80103ed2:	e8 a9 fd ff ff       	call   80103c80 <mycpu>
80103ed7:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
80103edd:	e8 7e 09 00 00       	call   80104860 <popcli>
80103ee2:	e8 59 fc ff ff       	call   80103b40 <allocproc>
80103ee7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103eea:	85 c0                	test   %eax,%eax
80103eec:	0f 84 bb 00 00 00    	je     80103fad <fork+0xed>
80103ef2:	83 ec 08             	sub    $0x8,%esp
80103ef5:	ff 33                	pushl  (%ebx)
80103ef7:	89 c7                	mov    %eax,%edi
80103ef9:	ff 73 04             	pushl  0x4(%ebx)
80103efc:	e8 cf 33 00 00       	call   801072d0 <copyuvm>
80103f01:	83 c4 10             	add    $0x10,%esp
80103f04:	89 47 04             	mov    %eax,0x4(%edi)
80103f07:	85 c0                	test   %eax,%eax
80103f09:	0f 84 a5 00 00 00    	je     80103fb4 <fork+0xf4>
80103f0f:	8b 03                	mov    (%ebx),%eax
80103f11:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103f14:	89 01                	mov    %eax,(%ecx)
80103f16:	8b 79 18             	mov    0x18(%ecx),%edi
80103f19:	89 c8                	mov    %ecx,%eax
80103f1b:	89 59 14             	mov    %ebx,0x14(%ecx)
80103f1e:	b9 13 00 00 00       	mov    $0x13,%ecx
80103f23:	8b 73 18             	mov    0x18(%ebx),%esi
80103f26:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
80103f28:	31 f6                	xor    %esi,%esi
80103f2a:	8b 40 18             	mov    0x18(%eax),%eax
80103f2d:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
80103f34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103f38:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103f3c:	85 c0                	test   %eax,%eax
80103f3e:	74 13                	je     80103f53 <fork+0x93>
80103f40:	83 ec 0c             	sub    $0xc,%esp
80103f43:	50                   	push   %eax
80103f44:	e8 d7 d2 ff ff       	call   80101220 <filedup>
80103f49:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103f4c:	83 c4 10             	add    $0x10,%esp
80103f4f:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
80103f53:	83 c6 01             	add    $0x1,%esi
80103f56:	83 fe 10             	cmp    $0x10,%esi
80103f59:	75 dd                	jne    80103f38 <fork+0x78>
80103f5b:	83 ec 0c             	sub    $0xc,%esp
80103f5e:	ff 73 68             	pushl  0x68(%ebx)
80103f61:	83 c3 6c             	add    $0x6c,%ebx
80103f64:	e8 77 db ff ff       	call   80101ae0 <idup>
80103f69:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103f6c:	83 c4 0c             	add    $0xc,%esp
80103f6f:	89 47 68             	mov    %eax,0x68(%edi)
80103f72:	8d 47 6c             	lea    0x6c(%edi),%eax
80103f75:	6a 10                	push   $0x10
80103f77:	53                   	push   %ebx
80103f78:	50                   	push   %eax
80103f79:	e8 62 0c 00 00       	call   80104be0 <safestrcpy>
80103f7e:	8b 5f 10             	mov    0x10(%edi),%ebx
80103f81:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103f88:	e8 83 09 00 00       	call   80104910 <acquire>
80103f8d:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
80103f94:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103f9b:	e8 30 0a 00 00       	call   801049d0 <release>
80103fa0:	83 c4 10             	add    $0x10,%esp
80103fa3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103fa6:	89 d8                	mov    %ebx,%eax
80103fa8:	5b                   	pop    %ebx
80103fa9:	5e                   	pop    %esi
80103faa:	5f                   	pop    %edi
80103fab:	5d                   	pop    %ebp
80103fac:	c3                   	ret    
80103fad:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103fb2:	eb ef                	jmp    80103fa3 <fork+0xe3>
80103fb4:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103fb7:	83 ec 0c             	sub    $0xc,%esp
80103fba:	ff 73 08             	pushl  0x8(%ebx)
80103fbd:	e8 5e e8 ff ff       	call   80102820 <kfree>
80103fc2:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
80103fc9:	83 c4 10             	add    $0x10,%esp
80103fcc:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
80103fd3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103fd8:	eb c9                	jmp    80103fa3 <fork+0xe3>
80103fda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103fe0 <scheduler>:
80103fe0:	f3 0f 1e fb          	endbr32 
80103fe4:	55                   	push   %ebp
80103fe5:	89 e5                	mov    %esp,%ebp
80103fe7:	57                   	push   %edi
80103fe8:	56                   	push   %esi
80103fe9:	53                   	push   %ebx
80103fea:	83 ec 0c             	sub    $0xc,%esp
80103fed:	e8 8e fc ff ff       	call   80103c80 <mycpu>
80103ff2:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103ff9:	00 00 00 
80103ffc:	89 c6                	mov    %eax,%esi
80103ffe:	8d 78 04             	lea    0x4(%eax),%edi
80104001:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104008:	fb                   	sti    
80104009:	83 ec 0c             	sub    $0xc,%esp
8010400c:	bb 74 2d 11 80       	mov    $0x80112d74,%ebx
80104011:	68 40 2d 11 80       	push   $0x80112d40
80104016:	e8 f5 08 00 00       	call   80104910 <acquire>
8010401b:	83 c4 10             	add    $0x10,%esp
8010401e:	66 90                	xchg   %ax,%ax
80104020:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80104024:	75 33                	jne    80104059 <scheduler+0x79>
80104026:	83 ec 0c             	sub    $0xc,%esp
80104029:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
8010402f:	53                   	push   %ebx
80104030:	e8 8b 2d 00 00       	call   80106dc0 <switchuvm>
80104035:	58                   	pop    %eax
80104036:	5a                   	pop    %edx
80104037:	ff 73 1c             	pushl  0x1c(%ebx)
8010403a:	57                   	push   %edi
8010403b:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
80104042:	e8 fc 0b 00 00       	call   80104c43 <swtch>
80104047:	e8 54 2d 00 00       	call   80106da0 <switchkvm>
8010404c:	83 c4 10             	add    $0x10,%esp
8010404f:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80104056:	00 00 00 
80104059:	83 c3 7c             	add    $0x7c,%ebx
8010405c:	81 fb 74 4c 11 80    	cmp    $0x80114c74,%ebx
80104062:	75 bc                	jne    80104020 <scheduler+0x40>
80104064:	83 ec 0c             	sub    $0xc,%esp
80104067:	68 40 2d 11 80       	push   $0x80112d40
8010406c:	e8 5f 09 00 00       	call   801049d0 <release>
80104071:	83 c4 10             	add    $0x10,%esp
80104074:	eb 92                	jmp    80104008 <scheduler+0x28>
80104076:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010407d:	8d 76 00             	lea    0x0(%esi),%esi

80104080 <sched>:
80104080:	f3 0f 1e fb          	endbr32 
80104084:	55                   	push   %ebp
80104085:	89 e5                	mov    %esp,%ebp
80104087:	56                   	push   %esi
80104088:	53                   	push   %ebx
80104089:	e8 82 07 00 00       	call   80104810 <pushcli>
8010408e:	e8 ed fb ff ff       	call   80103c80 <mycpu>
80104093:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
80104099:	e8 c2 07 00 00       	call   80104860 <popcli>
8010409e:	83 ec 0c             	sub    $0xc,%esp
801040a1:	68 40 2d 11 80       	push   $0x80112d40
801040a6:	e8 15 08 00 00       	call   801048c0 <holding>
801040ab:	83 c4 10             	add    $0x10,%esp
801040ae:	85 c0                	test   %eax,%eax
801040b0:	74 4f                	je     80104101 <sched+0x81>
801040b2:	e8 c9 fb ff ff       	call   80103c80 <mycpu>
801040b7:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
801040be:	75 68                	jne    80104128 <sched+0xa8>
801040c0:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
801040c4:	74 55                	je     8010411b <sched+0x9b>
801040c6:	9c                   	pushf  
801040c7:	58                   	pop    %eax
801040c8:	f6 c4 02             	test   $0x2,%ah
801040cb:	75 41                	jne    8010410e <sched+0x8e>
801040cd:	e8 ae fb ff ff       	call   80103c80 <mycpu>
801040d2:	83 c3 1c             	add    $0x1c,%ebx
801040d5:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
801040db:	e8 a0 fb ff ff       	call   80103c80 <mycpu>
801040e0:	83 ec 08             	sub    $0x8,%esp
801040e3:	ff 70 04             	pushl  0x4(%eax)
801040e6:	53                   	push   %ebx
801040e7:	e8 57 0b 00 00       	call   80104c43 <swtch>
801040ec:	e8 8f fb ff ff       	call   80103c80 <mycpu>
801040f1:	83 c4 10             	add    $0x10,%esp
801040f4:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
801040fa:	8d 65 f8             	lea    -0x8(%ebp),%esp
801040fd:	5b                   	pop    %ebx
801040fe:	5e                   	pop    %esi
801040ff:	5d                   	pop    %ebp
80104100:	c3                   	ret    
80104101:	83 ec 0c             	sub    $0xc,%esp
80104104:	68 7b 7a 10 80       	push   $0x80107a7b
80104109:	e8 82 c2 ff ff       	call   80100390 <panic>
8010410e:	83 ec 0c             	sub    $0xc,%esp
80104111:	68 a7 7a 10 80       	push   $0x80107aa7
80104116:	e8 75 c2 ff ff       	call   80100390 <panic>
8010411b:	83 ec 0c             	sub    $0xc,%esp
8010411e:	68 99 7a 10 80       	push   $0x80107a99
80104123:	e8 68 c2 ff ff       	call   80100390 <panic>
80104128:	83 ec 0c             	sub    $0xc,%esp
8010412b:	68 8d 7a 10 80       	push   $0x80107a8d
80104130:	e8 5b c2 ff ff       	call   80100390 <panic>
80104135:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010413c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104140 <exit>:
80104140:	f3 0f 1e fb          	endbr32 
80104144:	55                   	push   %ebp
80104145:	89 e5                	mov    %esp,%ebp
80104147:	57                   	push   %edi
80104148:	56                   	push   %esi
80104149:	53                   	push   %ebx
8010414a:	83 ec 0c             	sub    $0xc,%esp
8010414d:	e8 be 06 00 00       	call   80104810 <pushcli>
80104152:	e8 29 fb ff ff       	call   80103c80 <mycpu>
80104157:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
8010415d:	e8 fe 06 00 00       	call   80104860 <popcli>
80104162:	8d 5e 28             	lea    0x28(%esi),%ebx
80104165:	8d 7e 68             	lea    0x68(%esi),%edi
80104168:	39 35 d8 a5 10 80    	cmp    %esi,0x8010a5d8
8010416e:	0f 84 f3 00 00 00    	je     80104267 <exit+0x127>
80104174:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104178:	8b 03                	mov    (%ebx),%eax
8010417a:	85 c0                	test   %eax,%eax
8010417c:	74 12                	je     80104190 <exit+0x50>
8010417e:	83 ec 0c             	sub    $0xc,%esp
80104181:	50                   	push   %eax
80104182:	e8 e9 d0 ff ff       	call   80101270 <fileclose>
80104187:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
8010418d:	83 c4 10             	add    $0x10,%esp
80104190:	83 c3 04             	add    $0x4,%ebx
80104193:	39 df                	cmp    %ebx,%edi
80104195:	75 e1                	jne    80104178 <exit+0x38>
80104197:	e8 44 ef ff ff       	call   801030e0 <begin_op>
8010419c:	83 ec 0c             	sub    $0xc,%esp
8010419f:	ff 76 68             	pushl  0x68(%esi)
801041a2:	e8 99 da ff ff       	call   80101c40 <iput>
801041a7:	e8 a4 ef ff ff       	call   80103150 <end_op>
801041ac:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
801041b3:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
801041ba:	e8 51 07 00 00       	call   80104910 <acquire>
801041bf:	8b 56 14             	mov    0x14(%esi),%edx
801041c2:	83 c4 10             	add    $0x10,%esp
801041c5:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
801041ca:	eb 0e                	jmp    801041da <exit+0x9a>
801041cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801041d0:	83 c0 7c             	add    $0x7c,%eax
801041d3:	3d 74 4c 11 80       	cmp    $0x80114c74,%eax
801041d8:	74 1c                	je     801041f6 <exit+0xb6>
801041da:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801041de:	75 f0                	jne    801041d0 <exit+0x90>
801041e0:	3b 50 20             	cmp    0x20(%eax),%edx
801041e3:	75 eb                	jne    801041d0 <exit+0x90>
801041e5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
801041ec:	83 c0 7c             	add    $0x7c,%eax
801041ef:	3d 74 4c 11 80       	cmp    $0x80114c74,%eax
801041f4:	75 e4                	jne    801041da <exit+0x9a>
801041f6:	8b 0d d8 a5 10 80    	mov    0x8010a5d8,%ecx
801041fc:	ba 74 2d 11 80       	mov    $0x80112d74,%edx
80104201:	eb 10                	jmp    80104213 <exit+0xd3>
80104203:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104207:	90                   	nop
80104208:	83 c2 7c             	add    $0x7c,%edx
8010420b:	81 fa 74 4c 11 80    	cmp    $0x80114c74,%edx
80104211:	74 3b                	je     8010424e <exit+0x10e>
80104213:	39 72 14             	cmp    %esi,0x14(%edx)
80104216:	75 f0                	jne    80104208 <exit+0xc8>
80104218:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
8010421c:	89 4a 14             	mov    %ecx,0x14(%edx)
8010421f:	75 e7                	jne    80104208 <exit+0xc8>
80104221:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
80104226:	eb 12                	jmp    8010423a <exit+0xfa>
80104228:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010422f:	90                   	nop
80104230:	83 c0 7c             	add    $0x7c,%eax
80104233:	3d 74 4c 11 80       	cmp    $0x80114c74,%eax
80104238:	74 ce                	je     80104208 <exit+0xc8>
8010423a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010423e:	75 f0                	jne    80104230 <exit+0xf0>
80104240:	3b 48 20             	cmp    0x20(%eax),%ecx
80104243:	75 eb                	jne    80104230 <exit+0xf0>
80104245:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
8010424c:	eb e2                	jmp    80104230 <exit+0xf0>
8010424e:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
80104255:	e8 26 fe ff ff       	call   80104080 <sched>
8010425a:	83 ec 0c             	sub    $0xc,%esp
8010425d:	68 c8 7a 10 80       	push   $0x80107ac8
80104262:	e8 29 c1 ff ff       	call   80100390 <panic>
80104267:	83 ec 0c             	sub    $0xc,%esp
8010426a:	68 bb 7a 10 80       	push   $0x80107abb
8010426f:	e8 1c c1 ff ff       	call   80100390 <panic>
80104274:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010427b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010427f:	90                   	nop

80104280 <yield>:
80104280:	f3 0f 1e fb          	endbr32 
80104284:	55                   	push   %ebp
80104285:	89 e5                	mov    %esp,%ebp
80104287:	53                   	push   %ebx
80104288:	83 ec 10             	sub    $0x10,%esp
8010428b:	68 40 2d 11 80       	push   $0x80112d40
80104290:	e8 7b 06 00 00       	call   80104910 <acquire>
80104295:	e8 76 05 00 00       	call   80104810 <pushcli>
8010429a:	e8 e1 f9 ff ff       	call   80103c80 <mycpu>
8010429f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
801042a5:	e8 b6 05 00 00       	call   80104860 <popcli>
801042aa:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
801042b1:	e8 ca fd ff ff       	call   80104080 <sched>
801042b6:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
801042bd:	e8 0e 07 00 00       	call   801049d0 <release>
801042c2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801042c5:	83 c4 10             	add    $0x10,%esp
801042c8:	c9                   	leave  
801042c9:	c3                   	ret    
801042ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801042d0 <sleep>:
801042d0:	f3 0f 1e fb          	endbr32 
801042d4:	55                   	push   %ebp
801042d5:	89 e5                	mov    %esp,%ebp
801042d7:	57                   	push   %edi
801042d8:	56                   	push   %esi
801042d9:	53                   	push   %ebx
801042da:	83 ec 0c             	sub    $0xc,%esp
801042dd:	8b 7d 08             	mov    0x8(%ebp),%edi
801042e0:	8b 75 0c             	mov    0xc(%ebp),%esi
801042e3:	e8 28 05 00 00       	call   80104810 <pushcli>
801042e8:	e8 93 f9 ff ff       	call   80103c80 <mycpu>
801042ed:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
801042f3:	e8 68 05 00 00       	call   80104860 <popcli>
801042f8:	85 db                	test   %ebx,%ebx
801042fa:	0f 84 83 00 00 00    	je     80104383 <sleep+0xb3>
80104300:	85 f6                	test   %esi,%esi
80104302:	74 72                	je     80104376 <sleep+0xa6>
80104304:	81 fe 40 2d 11 80    	cmp    $0x80112d40,%esi
8010430a:	74 4c                	je     80104358 <sleep+0x88>
8010430c:	83 ec 0c             	sub    $0xc,%esp
8010430f:	68 40 2d 11 80       	push   $0x80112d40
80104314:	e8 f7 05 00 00       	call   80104910 <acquire>
80104319:	89 34 24             	mov    %esi,(%esp)
8010431c:	e8 af 06 00 00       	call   801049d0 <release>
80104321:	89 7b 20             	mov    %edi,0x20(%ebx)
80104324:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
8010432b:	e8 50 fd ff ff       	call   80104080 <sched>
80104330:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
80104337:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
8010433e:	e8 8d 06 00 00       	call   801049d0 <release>
80104343:	89 75 08             	mov    %esi,0x8(%ebp)
80104346:	83 c4 10             	add    $0x10,%esp
80104349:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010434c:	5b                   	pop    %ebx
8010434d:	5e                   	pop    %esi
8010434e:	5f                   	pop    %edi
8010434f:	5d                   	pop    %ebp
80104350:	e9 bb 05 00 00       	jmp    80104910 <acquire>
80104355:	8d 76 00             	lea    0x0(%esi),%esi
80104358:	89 7b 20             	mov    %edi,0x20(%ebx)
8010435b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
80104362:	e8 19 fd ff ff       	call   80104080 <sched>
80104367:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
8010436e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104371:	5b                   	pop    %ebx
80104372:	5e                   	pop    %esi
80104373:	5f                   	pop    %edi
80104374:	5d                   	pop    %ebp
80104375:	c3                   	ret    
80104376:	83 ec 0c             	sub    $0xc,%esp
80104379:	68 da 7a 10 80       	push   $0x80107ada
8010437e:	e8 0d c0 ff ff       	call   80100390 <panic>
80104383:	83 ec 0c             	sub    $0xc,%esp
80104386:	68 d4 7a 10 80       	push   $0x80107ad4
8010438b:	e8 00 c0 ff ff       	call   80100390 <panic>

80104390 <wait>:
80104390:	f3 0f 1e fb          	endbr32 
80104394:	55                   	push   %ebp
80104395:	89 e5                	mov    %esp,%ebp
80104397:	56                   	push   %esi
80104398:	53                   	push   %ebx
80104399:	e8 72 04 00 00       	call   80104810 <pushcli>
8010439e:	e8 dd f8 ff ff       	call   80103c80 <mycpu>
801043a3:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
801043a9:	e8 b2 04 00 00       	call   80104860 <popcli>
801043ae:	83 ec 0c             	sub    $0xc,%esp
801043b1:	68 40 2d 11 80       	push   $0x80112d40
801043b6:	e8 55 05 00 00       	call   80104910 <acquire>
801043bb:	83 c4 10             	add    $0x10,%esp
801043be:	31 c0                	xor    %eax,%eax
801043c0:	bb 74 2d 11 80       	mov    $0x80112d74,%ebx
801043c5:	eb 14                	jmp    801043db <wait+0x4b>
801043c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801043ce:	66 90                	xchg   %ax,%ax
801043d0:	83 c3 7c             	add    $0x7c,%ebx
801043d3:	81 fb 74 4c 11 80    	cmp    $0x80114c74,%ebx
801043d9:	74 1b                	je     801043f6 <wait+0x66>
801043db:	39 73 14             	cmp    %esi,0x14(%ebx)
801043de:	75 f0                	jne    801043d0 <wait+0x40>
801043e0:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
801043e4:	74 32                	je     80104418 <wait+0x88>
801043e6:	83 c3 7c             	add    $0x7c,%ebx
801043e9:	b8 01 00 00 00       	mov    $0x1,%eax
801043ee:	81 fb 74 4c 11 80    	cmp    $0x80114c74,%ebx
801043f4:	75 e5                	jne    801043db <wait+0x4b>
801043f6:	85 c0                	test   %eax,%eax
801043f8:	74 74                	je     8010446e <wait+0xde>
801043fa:	8b 46 24             	mov    0x24(%esi),%eax
801043fd:	85 c0                	test   %eax,%eax
801043ff:	75 6d                	jne    8010446e <wait+0xde>
80104401:	83 ec 08             	sub    $0x8,%esp
80104404:	68 40 2d 11 80       	push   $0x80112d40
80104409:	56                   	push   %esi
8010440a:	e8 c1 fe ff ff       	call   801042d0 <sleep>
8010440f:	83 c4 10             	add    $0x10,%esp
80104412:	eb aa                	jmp    801043be <wait+0x2e>
80104414:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104418:	83 ec 0c             	sub    $0xc,%esp
8010441b:	ff 73 08             	pushl  0x8(%ebx)
8010441e:	8b 73 10             	mov    0x10(%ebx),%esi
80104421:	e8 fa e3 ff ff       	call   80102820 <kfree>
80104426:	5a                   	pop    %edx
80104427:	ff 73 04             	pushl  0x4(%ebx)
8010442a:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
80104431:	e8 4a 2d 00 00       	call   80107180 <freevm>
80104436:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
8010443d:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
80104444:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
8010444b:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
8010444f:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
80104456:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
8010445d:	e8 6e 05 00 00       	call   801049d0 <release>
80104462:	83 c4 10             	add    $0x10,%esp
80104465:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104468:	89 f0                	mov    %esi,%eax
8010446a:	5b                   	pop    %ebx
8010446b:	5e                   	pop    %esi
8010446c:	5d                   	pop    %ebp
8010446d:	c3                   	ret    
8010446e:	83 ec 0c             	sub    $0xc,%esp
80104471:	be ff ff ff ff       	mov    $0xffffffff,%esi
80104476:	68 40 2d 11 80       	push   $0x80112d40
8010447b:	e8 50 05 00 00       	call   801049d0 <release>
80104480:	83 c4 10             	add    $0x10,%esp
80104483:	eb e0                	jmp    80104465 <wait+0xd5>
80104485:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010448c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104490 <wakeup>:
80104490:	f3 0f 1e fb          	endbr32 
80104494:	55                   	push   %ebp
80104495:	89 e5                	mov    %esp,%ebp
80104497:	53                   	push   %ebx
80104498:	83 ec 10             	sub    $0x10,%esp
8010449b:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010449e:	68 40 2d 11 80       	push   $0x80112d40
801044a3:	e8 68 04 00 00       	call   80104910 <acquire>
801044a8:	83 c4 10             	add    $0x10,%esp
801044ab:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
801044b0:	eb 10                	jmp    801044c2 <wakeup+0x32>
801044b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801044b8:	83 c0 7c             	add    $0x7c,%eax
801044bb:	3d 74 4c 11 80       	cmp    $0x80114c74,%eax
801044c0:	74 1c                	je     801044de <wakeup+0x4e>
801044c2:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801044c6:	75 f0                	jne    801044b8 <wakeup+0x28>
801044c8:	3b 58 20             	cmp    0x20(%eax),%ebx
801044cb:	75 eb                	jne    801044b8 <wakeup+0x28>
801044cd:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
801044d4:	83 c0 7c             	add    $0x7c,%eax
801044d7:	3d 74 4c 11 80       	cmp    $0x80114c74,%eax
801044dc:	75 e4                	jne    801044c2 <wakeup+0x32>
801044de:	c7 45 08 40 2d 11 80 	movl   $0x80112d40,0x8(%ebp)
801044e5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801044e8:	c9                   	leave  
801044e9:	e9 e2 04 00 00       	jmp    801049d0 <release>
801044ee:	66 90                	xchg   %ax,%ax

801044f0 <kill>:
801044f0:	f3 0f 1e fb          	endbr32 
801044f4:	55                   	push   %ebp
801044f5:	89 e5                	mov    %esp,%ebp
801044f7:	53                   	push   %ebx
801044f8:	83 ec 10             	sub    $0x10,%esp
801044fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
801044fe:	68 40 2d 11 80       	push   $0x80112d40
80104503:	e8 08 04 00 00       	call   80104910 <acquire>
80104508:	83 c4 10             	add    $0x10,%esp
8010450b:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
80104510:	eb 10                	jmp    80104522 <kill+0x32>
80104512:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104518:	83 c0 7c             	add    $0x7c,%eax
8010451b:	3d 74 4c 11 80       	cmp    $0x80114c74,%eax
80104520:	74 36                	je     80104558 <kill+0x68>
80104522:	39 58 10             	cmp    %ebx,0x10(%eax)
80104525:	75 f1                	jne    80104518 <kill+0x28>
80104527:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010452b:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80104532:	75 07                	jne    8010453b <kill+0x4b>
80104534:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
8010453b:	83 ec 0c             	sub    $0xc,%esp
8010453e:	68 40 2d 11 80       	push   $0x80112d40
80104543:	e8 88 04 00 00       	call   801049d0 <release>
80104548:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010454b:	83 c4 10             	add    $0x10,%esp
8010454e:	31 c0                	xor    %eax,%eax
80104550:	c9                   	leave  
80104551:	c3                   	ret    
80104552:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104558:	83 ec 0c             	sub    $0xc,%esp
8010455b:	68 40 2d 11 80       	push   $0x80112d40
80104560:	e8 6b 04 00 00       	call   801049d0 <release>
80104565:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104568:	83 c4 10             	add    $0x10,%esp
8010456b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104570:	c9                   	leave  
80104571:	c3                   	ret    
80104572:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104579:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104580 <procdump>:
80104580:	f3 0f 1e fb          	endbr32 
80104584:	55                   	push   %ebp
80104585:	89 e5                	mov    %esp,%ebp
80104587:	57                   	push   %edi
80104588:	56                   	push   %esi
80104589:	8d 75 e8             	lea    -0x18(%ebp),%esi
8010458c:	53                   	push   %ebx
8010458d:	bb e0 2d 11 80       	mov    $0x80112de0,%ebx
80104592:	83 ec 3c             	sub    $0x3c,%esp
80104595:	eb 28                	jmp    801045bf <procdump+0x3f>
80104597:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010459e:	66 90                	xchg   %ax,%ax
801045a0:	83 ec 0c             	sub    $0xc,%esp
801045a3:	68 57 7e 10 80       	push   $0x80107e57
801045a8:	e8 03 c1 ff ff       	call   801006b0 <cprintf>
801045ad:	83 c4 10             	add    $0x10,%esp
801045b0:	83 c3 7c             	add    $0x7c,%ebx
801045b3:	81 fb e0 4c 11 80    	cmp    $0x80114ce0,%ebx
801045b9:	0f 84 81 00 00 00    	je     80104640 <procdump+0xc0>
801045bf:	8b 43 a0             	mov    -0x60(%ebx),%eax
801045c2:	85 c0                	test   %eax,%eax
801045c4:	74 ea                	je     801045b0 <procdump+0x30>
801045c6:	ba eb 7a 10 80       	mov    $0x80107aeb,%edx
801045cb:	83 f8 05             	cmp    $0x5,%eax
801045ce:	77 11                	ja     801045e1 <procdump+0x61>
801045d0:	8b 14 85 4c 7b 10 80 	mov    -0x7fef84b4(,%eax,4),%edx
801045d7:	b8 eb 7a 10 80       	mov    $0x80107aeb,%eax
801045dc:	85 d2                	test   %edx,%edx
801045de:	0f 44 d0             	cmove  %eax,%edx
801045e1:	53                   	push   %ebx
801045e2:	52                   	push   %edx
801045e3:	ff 73 a4             	pushl  -0x5c(%ebx)
801045e6:	68 ef 7a 10 80       	push   $0x80107aef
801045eb:	e8 c0 c0 ff ff       	call   801006b0 <cprintf>
801045f0:	83 c4 10             	add    $0x10,%esp
801045f3:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
801045f7:	75 a7                	jne    801045a0 <procdump+0x20>
801045f9:	83 ec 08             	sub    $0x8,%esp
801045fc:	8d 45 c0             	lea    -0x40(%ebp),%eax
801045ff:	8d 7d c0             	lea    -0x40(%ebp),%edi
80104602:	50                   	push   %eax
80104603:	8b 43 b0             	mov    -0x50(%ebx),%eax
80104606:	8b 40 0c             	mov    0xc(%eax),%eax
80104609:	83 c0 08             	add    $0x8,%eax
8010460c:	50                   	push   %eax
8010460d:	e8 9e 01 00 00       	call   801047b0 <getcallerpcs>
80104612:	83 c4 10             	add    $0x10,%esp
80104615:	8d 76 00             	lea    0x0(%esi),%esi
80104618:	8b 17                	mov    (%edi),%edx
8010461a:	85 d2                	test   %edx,%edx
8010461c:	74 82                	je     801045a0 <procdump+0x20>
8010461e:	83 ec 08             	sub    $0x8,%esp
80104621:	83 c7 04             	add    $0x4,%edi
80104624:	52                   	push   %edx
80104625:	68 e1 74 10 80       	push   $0x801074e1
8010462a:	e8 81 c0 ff ff       	call   801006b0 <cprintf>
8010462f:	83 c4 10             	add    $0x10,%esp
80104632:	39 fe                	cmp    %edi,%esi
80104634:	75 e2                	jne    80104618 <procdump+0x98>
80104636:	e9 65 ff ff ff       	jmp    801045a0 <procdump+0x20>
8010463b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010463f:	90                   	nop
80104640:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104643:	5b                   	pop    %ebx
80104644:	5e                   	pop    %esi
80104645:	5f                   	pop    %edi
80104646:	5d                   	pop    %ebp
80104647:	c3                   	ret    
80104648:	66 90                	xchg   %ax,%ax
8010464a:	66 90                	xchg   %ax,%ax
8010464c:	66 90                	xchg   %ax,%ax
8010464e:	66 90                	xchg   %ax,%ax

80104650 <initsleeplock>:
80104650:	f3 0f 1e fb          	endbr32 
80104654:	55                   	push   %ebp
80104655:	89 e5                	mov    %esp,%ebp
80104657:	53                   	push   %ebx
80104658:	83 ec 0c             	sub    $0xc,%esp
8010465b:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010465e:	68 64 7b 10 80       	push   $0x80107b64
80104663:	8d 43 04             	lea    0x4(%ebx),%eax
80104666:	50                   	push   %eax
80104667:	e8 24 01 00 00       	call   80104790 <initlock>
8010466c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010466f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80104675:	83 c4 10             	add    $0x10,%esp
80104678:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
8010467f:	89 43 38             	mov    %eax,0x38(%ebx)
80104682:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104685:	c9                   	leave  
80104686:	c3                   	ret    
80104687:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010468e:	66 90                	xchg   %ax,%ax

80104690 <acquiresleep>:
80104690:	f3 0f 1e fb          	endbr32 
80104694:	55                   	push   %ebp
80104695:	89 e5                	mov    %esp,%ebp
80104697:	56                   	push   %esi
80104698:	53                   	push   %ebx
80104699:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010469c:	8d 73 04             	lea    0x4(%ebx),%esi
8010469f:	83 ec 0c             	sub    $0xc,%esp
801046a2:	56                   	push   %esi
801046a3:	e8 68 02 00 00       	call   80104910 <acquire>
801046a8:	8b 13                	mov    (%ebx),%edx
801046aa:	83 c4 10             	add    $0x10,%esp
801046ad:	85 d2                	test   %edx,%edx
801046af:	74 1a                	je     801046cb <acquiresleep+0x3b>
801046b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046b8:	83 ec 08             	sub    $0x8,%esp
801046bb:	56                   	push   %esi
801046bc:	53                   	push   %ebx
801046bd:	e8 0e fc ff ff       	call   801042d0 <sleep>
801046c2:	8b 03                	mov    (%ebx),%eax
801046c4:	83 c4 10             	add    $0x10,%esp
801046c7:	85 c0                	test   %eax,%eax
801046c9:	75 ed                	jne    801046b8 <acquiresleep+0x28>
801046cb:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
801046d1:	e8 3a f6 ff ff       	call   80103d10 <myproc>
801046d6:	8b 40 10             	mov    0x10(%eax),%eax
801046d9:	89 43 3c             	mov    %eax,0x3c(%ebx)
801046dc:	89 75 08             	mov    %esi,0x8(%ebp)
801046df:	8d 65 f8             	lea    -0x8(%ebp),%esp
801046e2:	5b                   	pop    %ebx
801046e3:	5e                   	pop    %esi
801046e4:	5d                   	pop    %ebp
801046e5:	e9 e6 02 00 00       	jmp    801049d0 <release>
801046ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801046f0 <releasesleep>:
801046f0:	f3 0f 1e fb          	endbr32 
801046f4:	55                   	push   %ebp
801046f5:	89 e5                	mov    %esp,%ebp
801046f7:	56                   	push   %esi
801046f8:	53                   	push   %ebx
801046f9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801046fc:	8d 73 04             	lea    0x4(%ebx),%esi
801046ff:	83 ec 0c             	sub    $0xc,%esp
80104702:	56                   	push   %esi
80104703:	e8 08 02 00 00       	call   80104910 <acquire>
80104708:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
8010470e:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
80104715:	89 1c 24             	mov    %ebx,(%esp)
80104718:	e8 73 fd ff ff       	call   80104490 <wakeup>
8010471d:	89 75 08             	mov    %esi,0x8(%ebp)
80104720:	83 c4 10             	add    $0x10,%esp
80104723:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104726:	5b                   	pop    %ebx
80104727:	5e                   	pop    %esi
80104728:	5d                   	pop    %ebp
80104729:	e9 a2 02 00 00       	jmp    801049d0 <release>
8010472e:	66 90                	xchg   %ax,%ax

80104730 <holdingsleep>:
80104730:	f3 0f 1e fb          	endbr32 
80104734:	55                   	push   %ebp
80104735:	89 e5                	mov    %esp,%ebp
80104737:	57                   	push   %edi
80104738:	31 ff                	xor    %edi,%edi
8010473a:	56                   	push   %esi
8010473b:	53                   	push   %ebx
8010473c:	83 ec 18             	sub    $0x18,%esp
8010473f:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104742:	8d 73 04             	lea    0x4(%ebx),%esi
80104745:	56                   	push   %esi
80104746:	e8 c5 01 00 00       	call   80104910 <acquire>
8010474b:	8b 03                	mov    (%ebx),%eax
8010474d:	83 c4 10             	add    $0x10,%esp
80104750:	85 c0                	test   %eax,%eax
80104752:	75 1c                	jne    80104770 <holdingsleep+0x40>
80104754:	83 ec 0c             	sub    $0xc,%esp
80104757:	56                   	push   %esi
80104758:	e8 73 02 00 00       	call   801049d0 <release>
8010475d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104760:	89 f8                	mov    %edi,%eax
80104762:	5b                   	pop    %ebx
80104763:	5e                   	pop    %esi
80104764:	5f                   	pop    %edi
80104765:	5d                   	pop    %ebp
80104766:	c3                   	ret    
80104767:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010476e:	66 90                	xchg   %ax,%ax
80104770:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104773:	e8 98 f5 ff ff       	call   80103d10 <myproc>
80104778:	39 58 10             	cmp    %ebx,0x10(%eax)
8010477b:	0f 94 c0             	sete   %al
8010477e:	0f b6 c0             	movzbl %al,%eax
80104781:	89 c7                	mov    %eax,%edi
80104783:	eb cf                	jmp    80104754 <holdingsleep+0x24>
80104785:	66 90                	xchg   %ax,%ax
80104787:	66 90                	xchg   %ax,%ax
80104789:	66 90                	xchg   %ax,%ax
8010478b:	66 90                	xchg   %ax,%ax
8010478d:	66 90                	xchg   %ax,%ax
8010478f:	90                   	nop

80104790 <initlock>:
80104790:	f3 0f 1e fb          	endbr32 
80104794:	55                   	push   %ebp
80104795:	89 e5                	mov    %esp,%ebp
80104797:	8b 45 08             	mov    0x8(%ebp),%eax
8010479a:	8b 55 0c             	mov    0xc(%ebp),%edx
8010479d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801047a3:	89 50 04             	mov    %edx,0x4(%eax)
801047a6:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
801047ad:	5d                   	pop    %ebp
801047ae:	c3                   	ret    
801047af:	90                   	nop

801047b0 <getcallerpcs>:
801047b0:	f3 0f 1e fb          	endbr32 
801047b4:	55                   	push   %ebp
801047b5:	31 d2                	xor    %edx,%edx
801047b7:	89 e5                	mov    %esp,%ebp
801047b9:	53                   	push   %ebx
801047ba:	8b 45 08             	mov    0x8(%ebp),%eax
801047bd:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801047c0:	83 e8 08             	sub    $0x8,%eax
801047c3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801047c7:	90                   	nop
801047c8:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
801047ce:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801047d4:	77 1a                	ja     801047f0 <getcallerpcs+0x40>
801047d6:	8b 58 04             	mov    0x4(%eax),%ebx
801047d9:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
801047dc:	83 c2 01             	add    $0x1,%edx
801047df:	8b 00                	mov    (%eax),%eax
801047e1:	83 fa 0a             	cmp    $0xa,%edx
801047e4:	75 e2                	jne    801047c8 <getcallerpcs+0x18>
801047e6:	5b                   	pop    %ebx
801047e7:	5d                   	pop    %ebp
801047e8:	c3                   	ret    
801047e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047f0:	8d 04 91             	lea    (%ecx,%edx,4),%eax
801047f3:	8d 51 28             	lea    0x28(%ecx),%edx
801047f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047fd:	8d 76 00             	lea    0x0(%esi),%esi
80104800:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104806:	83 c0 04             	add    $0x4,%eax
80104809:	39 d0                	cmp    %edx,%eax
8010480b:	75 f3                	jne    80104800 <getcallerpcs+0x50>
8010480d:	5b                   	pop    %ebx
8010480e:	5d                   	pop    %ebp
8010480f:	c3                   	ret    

80104810 <pushcli>:
80104810:	f3 0f 1e fb          	endbr32 
80104814:	55                   	push   %ebp
80104815:	89 e5                	mov    %esp,%ebp
80104817:	53                   	push   %ebx
80104818:	83 ec 04             	sub    $0x4,%esp
8010481b:	9c                   	pushf  
8010481c:	5b                   	pop    %ebx
8010481d:	fa                   	cli    
8010481e:	e8 5d f4 ff ff       	call   80103c80 <mycpu>
80104823:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104829:	85 c0                	test   %eax,%eax
8010482b:	74 13                	je     80104840 <pushcli+0x30>
8010482d:	e8 4e f4 ff ff       	call   80103c80 <mycpu>
80104832:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
80104839:	83 c4 04             	add    $0x4,%esp
8010483c:	5b                   	pop    %ebx
8010483d:	5d                   	pop    %ebp
8010483e:	c3                   	ret    
8010483f:	90                   	nop
80104840:	e8 3b f4 ff ff       	call   80103c80 <mycpu>
80104845:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010484b:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80104851:	eb da                	jmp    8010482d <pushcli+0x1d>
80104853:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010485a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104860 <popcli>:
80104860:	f3 0f 1e fb          	endbr32 
80104864:	55                   	push   %ebp
80104865:	89 e5                	mov    %esp,%ebp
80104867:	83 ec 08             	sub    $0x8,%esp
8010486a:	9c                   	pushf  
8010486b:	58                   	pop    %eax
8010486c:	f6 c4 02             	test   $0x2,%ah
8010486f:	75 31                	jne    801048a2 <popcli+0x42>
80104871:	e8 0a f4 ff ff       	call   80103c80 <mycpu>
80104876:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
8010487d:	78 30                	js     801048af <popcli+0x4f>
8010487f:	e8 fc f3 ff ff       	call   80103c80 <mycpu>
80104884:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
8010488a:	85 d2                	test   %edx,%edx
8010488c:	74 02                	je     80104890 <popcli+0x30>
8010488e:	c9                   	leave  
8010488f:	c3                   	ret    
80104890:	e8 eb f3 ff ff       	call   80103c80 <mycpu>
80104895:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010489b:	85 c0                	test   %eax,%eax
8010489d:	74 ef                	je     8010488e <popcli+0x2e>
8010489f:	fb                   	sti    
801048a0:	c9                   	leave  
801048a1:	c3                   	ret    
801048a2:	83 ec 0c             	sub    $0xc,%esp
801048a5:	68 6f 7b 10 80       	push   $0x80107b6f
801048aa:	e8 e1 ba ff ff       	call   80100390 <panic>
801048af:	83 ec 0c             	sub    $0xc,%esp
801048b2:	68 86 7b 10 80       	push   $0x80107b86
801048b7:	e8 d4 ba ff ff       	call   80100390 <panic>
801048bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801048c0 <holding>:
801048c0:	f3 0f 1e fb          	endbr32 
801048c4:	55                   	push   %ebp
801048c5:	89 e5                	mov    %esp,%ebp
801048c7:	56                   	push   %esi
801048c8:	53                   	push   %ebx
801048c9:	8b 75 08             	mov    0x8(%ebp),%esi
801048cc:	31 db                	xor    %ebx,%ebx
801048ce:	e8 3d ff ff ff       	call   80104810 <pushcli>
801048d3:	8b 06                	mov    (%esi),%eax
801048d5:	85 c0                	test   %eax,%eax
801048d7:	75 0f                	jne    801048e8 <holding+0x28>
801048d9:	e8 82 ff ff ff       	call   80104860 <popcli>
801048de:	89 d8                	mov    %ebx,%eax
801048e0:	5b                   	pop    %ebx
801048e1:	5e                   	pop    %esi
801048e2:	5d                   	pop    %ebp
801048e3:	c3                   	ret    
801048e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801048e8:	8b 5e 08             	mov    0x8(%esi),%ebx
801048eb:	e8 90 f3 ff ff       	call   80103c80 <mycpu>
801048f0:	39 c3                	cmp    %eax,%ebx
801048f2:	0f 94 c3             	sete   %bl
801048f5:	e8 66 ff ff ff       	call   80104860 <popcli>
801048fa:	0f b6 db             	movzbl %bl,%ebx
801048fd:	89 d8                	mov    %ebx,%eax
801048ff:	5b                   	pop    %ebx
80104900:	5e                   	pop    %esi
80104901:	5d                   	pop    %ebp
80104902:	c3                   	ret    
80104903:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010490a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104910 <acquire>:
80104910:	f3 0f 1e fb          	endbr32 
80104914:	55                   	push   %ebp
80104915:	89 e5                	mov    %esp,%ebp
80104917:	56                   	push   %esi
80104918:	53                   	push   %ebx
80104919:	e8 f2 fe ff ff       	call   80104810 <pushcli>
8010491e:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104921:	83 ec 0c             	sub    $0xc,%esp
80104924:	53                   	push   %ebx
80104925:	e8 96 ff ff ff       	call   801048c0 <holding>
8010492a:	83 c4 10             	add    $0x10,%esp
8010492d:	85 c0                	test   %eax,%eax
8010492f:	0f 85 7f 00 00 00    	jne    801049b4 <acquire+0xa4>
80104935:	89 c6                	mov    %eax,%esi
80104937:	ba 01 00 00 00       	mov    $0x1,%edx
8010493c:	eb 05                	jmp    80104943 <acquire+0x33>
8010493e:	66 90                	xchg   %ax,%ax
80104940:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104943:	89 d0                	mov    %edx,%eax
80104945:	f0 87 03             	lock xchg %eax,(%ebx)
80104948:	85 c0                	test   %eax,%eax
8010494a:	75 f4                	jne    80104940 <acquire+0x30>
8010494c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
80104951:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104954:	e8 27 f3 ff ff       	call   80103c80 <mycpu>
80104959:	89 43 08             	mov    %eax,0x8(%ebx)
8010495c:	89 e8                	mov    %ebp,%eax
8010495e:	66 90                	xchg   %ax,%ax
80104960:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
80104966:	81 fa fe ff ff 7f    	cmp    $0x7ffffffe,%edx
8010496c:	77 22                	ja     80104990 <acquire+0x80>
8010496e:	8b 50 04             	mov    0x4(%eax),%edx
80104971:	89 54 b3 0c          	mov    %edx,0xc(%ebx,%esi,4)
80104975:	83 c6 01             	add    $0x1,%esi
80104978:	8b 00                	mov    (%eax),%eax
8010497a:	83 fe 0a             	cmp    $0xa,%esi
8010497d:	75 e1                	jne    80104960 <acquire+0x50>
8010497f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104982:	5b                   	pop    %ebx
80104983:	5e                   	pop    %esi
80104984:	5d                   	pop    %ebp
80104985:	c3                   	ret    
80104986:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010498d:	8d 76 00             	lea    0x0(%esi),%esi
80104990:	8d 44 b3 0c          	lea    0xc(%ebx,%esi,4),%eax
80104994:	83 c3 34             	add    $0x34,%ebx
80104997:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010499e:	66 90                	xchg   %ax,%ax
801049a0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801049a6:	83 c0 04             	add    $0x4,%eax
801049a9:	39 d8                	cmp    %ebx,%eax
801049ab:	75 f3                	jne    801049a0 <acquire+0x90>
801049ad:	8d 65 f8             	lea    -0x8(%ebp),%esp
801049b0:	5b                   	pop    %ebx
801049b1:	5e                   	pop    %esi
801049b2:	5d                   	pop    %ebp
801049b3:	c3                   	ret    
801049b4:	83 ec 0c             	sub    $0xc,%esp
801049b7:	68 8d 7b 10 80       	push   $0x80107b8d
801049bc:	e8 cf b9 ff ff       	call   80100390 <panic>
801049c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801049c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801049cf:	90                   	nop

801049d0 <release>:
801049d0:	f3 0f 1e fb          	endbr32 
801049d4:	55                   	push   %ebp
801049d5:	89 e5                	mov    %esp,%ebp
801049d7:	53                   	push   %ebx
801049d8:	83 ec 10             	sub    $0x10,%esp
801049db:	8b 5d 08             	mov    0x8(%ebp),%ebx
801049de:	53                   	push   %ebx
801049df:	e8 dc fe ff ff       	call   801048c0 <holding>
801049e4:	83 c4 10             	add    $0x10,%esp
801049e7:	85 c0                	test   %eax,%eax
801049e9:	74 22                	je     80104a0d <release+0x3d>
801049eb:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
801049f2:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
801049f9:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
801049fe:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80104a04:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a07:	c9                   	leave  
80104a08:	e9 53 fe ff ff       	jmp    80104860 <popcli>
80104a0d:	83 ec 0c             	sub    $0xc,%esp
80104a10:	68 95 7b 10 80       	push   $0x80107b95
80104a15:	e8 76 b9 ff ff       	call   80100390 <panic>
80104a1a:	66 90                	xchg   %ax,%ax
80104a1c:	66 90                	xchg   %ax,%ax
80104a1e:	66 90                	xchg   %ax,%ax

80104a20 <memset>:
80104a20:	f3 0f 1e fb          	endbr32 
80104a24:	55                   	push   %ebp
80104a25:	89 e5                	mov    %esp,%ebp
80104a27:	57                   	push   %edi
80104a28:	8b 55 08             	mov    0x8(%ebp),%edx
80104a2b:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104a2e:	53                   	push   %ebx
80104a2f:	8b 45 0c             	mov    0xc(%ebp),%eax
80104a32:	89 d7                	mov    %edx,%edi
80104a34:	09 cf                	or     %ecx,%edi
80104a36:	83 e7 03             	and    $0x3,%edi
80104a39:	75 25                	jne    80104a60 <memset+0x40>
80104a3b:	0f b6 f8             	movzbl %al,%edi
80104a3e:	c1 e0 18             	shl    $0x18,%eax
80104a41:	89 fb                	mov    %edi,%ebx
80104a43:	c1 e9 02             	shr    $0x2,%ecx
80104a46:	c1 e3 10             	shl    $0x10,%ebx
80104a49:	09 d8                	or     %ebx,%eax
80104a4b:	09 f8                	or     %edi,%eax
80104a4d:	c1 e7 08             	shl    $0x8,%edi
80104a50:	09 f8                	or     %edi,%eax
80104a52:	89 d7                	mov    %edx,%edi
80104a54:	fc                   	cld    
80104a55:	f3 ab                	rep stos %eax,%es:(%edi)
80104a57:	5b                   	pop    %ebx
80104a58:	89 d0                	mov    %edx,%eax
80104a5a:	5f                   	pop    %edi
80104a5b:	5d                   	pop    %ebp
80104a5c:	c3                   	ret    
80104a5d:	8d 76 00             	lea    0x0(%esi),%esi
80104a60:	89 d7                	mov    %edx,%edi
80104a62:	fc                   	cld    
80104a63:	f3 aa                	rep stos %al,%es:(%edi)
80104a65:	5b                   	pop    %ebx
80104a66:	89 d0                	mov    %edx,%eax
80104a68:	5f                   	pop    %edi
80104a69:	5d                   	pop    %ebp
80104a6a:	c3                   	ret    
80104a6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104a6f:	90                   	nop

80104a70 <memcmp>:
80104a70:	f3 0f 1e fb          	endbr32 
80104a74:	55                   	push   %ebp
80104a75:	89 e5                	mov    %esp,%ebp
80104a77:	56                   	push   %esi
80104a78:	8b 75 10             	mov    0x10(%ebp),%esi
80104a7b:	8b 55 08             	mov    0x8(%ebp),%edx
80104a7e:	53                   	push   %ebx
80104a7f:	8b 45 0c             	mov    0xc(%ebp),%eax
80104a82:	85 f6                	test   %esi,%esi
80104a84:	74 2a                	je     80104ab0 <memcmp+0x40>
80104a86:	01 c6                	add    %eax,%esi
80104a88:	eb 10                	jmp    80104a9a <memcmp+0x2a>
80104a8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104a90:	83 c0 01             	add    $0x1,%eax
80104a93:	83 c2 01             	add    $0x1,%edx
80104a96:	39 f0                	cmp    %esi,%eax
80104a98:	74 16                	je     80104ab0 <memcmp+0x40>
80104a9a:	0f b6 0a             	movzbl (%edx),%ecx
80104a9d:	0f b6 18             	movzbl (%eax),%ebx
80104aa0:	38 d9                	cmp    %bl,%cl
80104aa2:	74 ec                	je     80104a90 <memcmp+0x20>
80104aa4:	0f b6 c1             	movzbl %cl,%eax
80104aa7:	29 d8                	sub    %ebx,%eax
80104aa9:	5b                   	pop    %ebx
80104aaa:	5e                   	pop    %esi
80104aab:	5d                   	pop    %ebp
80104aac:	c3                   	ret    
80104aad:	8d 76 00             	lea    0x0(%esi),%esi
80104ab0:	5b                   	pop    %ebx
80104ab1:	31 c0                	xor    %eax,%eax
80104ab3:	5e                   	pop    %esi
80104ab4:	5d                   	pop    %ebp
80104ab5:	c3                   	ret    
80104ab6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104abd:	8d 76 00             	lea    0x0(%esi),%esi

80104ac0 <memmove>:
80104ac0:	f3 0f 1e fb          	endbr32 
80104ac4:	55                   	push   %ebp
80104ac5:	89 e5                	mov    %esp,%ebp
80104ac7:	57                   	push   %edi
80104ac8:	8b 55 08             	mov    0x8(%ebp),%edx
80104acb:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104ace:	56                   	push   %esi
80104acf:	8b 75 0c             	mov    0xc(%ebp),%esi
80104ad2:	39 d6                	cmp    %edx,%esi
80104ad4:	73 2a                	jae    80104b00 <memmove+0x40>
80104ad6:	8d 3c 0e             	lea    (%esi,%ecx,1),%edi
80104ad9:	39 fa                	cmp    %edi,%edx
80104adb:	73 23                	jae    80104b00 <memmove+0x40>
80104add:	8d 41 ff             	lea    -0x1(%ecx),%eax
80104ae0:	85 c9                	test   %ecx,%ecx
80104ae2:	74 13                	je     80104af7 <memmove+0x37>
80104ae4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104ae8:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104aec:	88 0c 02             	mov    %cl,(%edx,%eax,1)
80104aef:	83 e8 01             	sub    $0x1,%eax
80104af2:	83 f8 ff             	cmp    $0xffffffff,%eax
80104af5:	75 f1                	jne    80104ae8 <memmove+0x28>
80104af7:	5e                   	pop    %esi
80104af8:	89 d0                	mov    %edx,%eax
80104afa:	5f                   	pop    %edi
80104afb:	5d                   	pop    %ebp
80104afc:	c3                   	ret    
80104afd:	8d 76 00             	lea    0x0(%esi),%esi
80104b00:	8d 04 0e             	lea    (%esi,%ecx,1),%eax
80104b03:	89 d7                	mov    %edx,%edi
80104b05:	85 c9                	test   %ecx,%ecx
80104b07:	74 ee                	je     80104af7 <memmove+0x37>
80104b09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b10:	a4                   	movsb  %ds:(%esi),%es:(%edi)
80104b11:	39 f0                	cmp    %esi,%eax
80104b13:	75 fb                	jne    80104b10 <memmove+0x50>
80104b15:	5e                   	pop    %esi
80104b16:	89 d0                	mov    %edx,%eax
80104b18:	5f                   	pop    %edi
80104b19:	5d                   	pop    %ebp
80104b1a:	c3                   	ret    
80104b1b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104b1f:	90                   	nop

80104b20 <memcpy>:
80104b20:	f3 0f 1e fb          	endbr32 
80104b24:	eb 9a                	jmp    80104ac0 <memmove>
80104b26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b2d:	8d 76 00             	lea    0x0(%esi),%esi

80104b30 <strncmp>:
80104b30:	f3 0f 1e fb          	endbr32 
80104b34:	55                   	push   %ebp
80104b35:	89 e5                	mov    %esp,%ebp
80104b37:	56                   	push   %esi
80104b38:	8b 75 10             	mov    0x10(%ebp),%esi
80104b3b:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104b3e:	53                   	push   %ebx
80104b3f:	8b 45 0c             	mov    0xc(%ebp),%eax
80104b42:	85 f6                	test   %esi,%esi
80104b44:	74 32                	je     80104b78 <strncmp+0x48>
80104b46:	01 c6                	add    %eax,%esi
80104b48:	eb 14                	jmp    80104b5e <strncmp+0x2e>
80104b4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104b50:	38 da                	cmp    %bl,%dl
80104b52:	75 14                	jne    80104b68 <strncmp+0x38>
80104b54:	83 c0 01             	add    $0x1,%eax
80104b57:	83 c1 01             	add    $0x1,%ecx
80104b5a:	39 f0                	cmp    %esi,%eax
80104b5c:	74 1a                	je     80104b78 <strncmp+0x48>
80104b5e:	0f b6 11             	movzbl (%ecx),%edx
80104b61:	0f b6 18             	movzbl (%eax),%ebx
80104b64:	84 d2                	test   %dl,%dl
80104b66:	75 e8                	jne    80104b50 <strncmp+0x20>
80104b68:	0f b6 c2             	movzbl %dl,%eax
80104b6b:	29 d8                	sub    %ebx,%eax
80104b6d:	5b                   	pop    %ebx
80104b6e:	5e                   	pop    %esi
80104b6f:	5d                   	pop    %ebp
80104b70:	c3                   	ret    
80104b71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b78:	5b                   	pop    %ebx
80104b79:	31 c0                	xor    %eax,%eax
80104b7b:	5e                   	pop    %esi
80104b7c:	5d                   	pop    %ebp
80104b7d:	c3                   	ret    
80104b7e:	66 90                	xchg   %ax,%ax

80104b80 <strncpy>:
80104b80:	f3 0f 1e fb          	endbr32 
80104b84:	55                   	push   %ebp
80104b85:	89 e5                	mov    %esp,%ebp
80104b87:	57                   	push   %edi
80104b88:	56                   	push   %esi
80104b89:	8b 75 08             	mov    0x8(%ebp),%esi
80104b8c:	53                   	push   %ebx
80104b8d:	8b 45 10             	mov    0x10(%ebp),%eax
80104b90:	89 f2                	mov    %esi,%edx
80104b92:	eb 1b                	jmp    80104baf <strncpy+0x2f>
80104b94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104b98:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80104b9c:	8b 7d 0c             	mov    0xc(%ebp),%edi
80104b9f:	83 c2 01             	add    $0x1,%edx
80104ba2:	0f b6 7f ff          	movzbl -0x1(%edi),%edi
80104ba6:	89 f9                	mov    %edi,%ecx
80104ba8:	88 4a ff             	mov    %cl,-0x1(%edx)
80104bab:	84 c9                	test   %cl,%cl
80104bad:	74 09                	je     80104bb8 <strncpy+0x38>
80104baf:	89 c3                	mov    %eax,%ebx
80104bb1:	83 e8 01             	sub    $0x1,%eax
80104bb4:	85 db                	test   %ebx,%ebx
80104bb6:	7f e0                	jg     80104b98 <strncpy+0x18>
80104bb8:	89 d1                	mov    %edx,%ecx
80104bba:	85 c0                	test   %eax,%eax
80104bbc:	7e 15                	jle    80104bd3 <strncpy+0x53>
80104bbe:	66 90                	xchg   %ax,%ax
80104bc0:	83 c1 01             	add    $0x1,%ecx
80104bc3:	c6 41 ff 00          	movb   $0x0,-0x1(%ecx)
80104bc7:	89 c8                	mov    %ecx,%eax
80104bc9:	f7 d0                	not    %eax
80104bcb:	01 d0                	add    %edx,%eax
80104bcd:	01 d8                	add    %ebx,%eax
80104bcf:	85 c0                	test   %eax,%eax
80104bd1:	7f ed                	jg     80104bc0 <strncpy+0x40>
80104bd3:	5b                   	pop    %ebx
80104bd4:	89 f0                	mov    %esi,%eax
80104bd6:	5e                   	pop    %esi
80104bd7:	5f                   	pop    %edi
80104bd8:	5d                   	pop    %ebp
80104bd9:	c3                   	ret    
80104bda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104be0 <safestrcpy>:
80104be0:	f3 0f 1e fb          	endbr32 
80104be4:	55                   	push   %ebp
80104be5:	89 e5                	mov    %esp,%ebp
80104be7:	56                   	push   %esi
80104be8:	8b 55 10             	mov    0x10(%ebp),%edx
80104beb:	8b 75 08             	mov    0x8(%ebp),%esi
80104bee:	53                   	push   %ebx
80104bef:	8b 45 0c             	mov    0xc(%ebp),%eax
80104bf2:	85 d2                	test   %edx,%edx
80104bf4:	7e 21                	jle    80104c17 <safestrcpy+0x37>
80104bf6:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
80104bfa:	89 f2                	mov    %esi,%edx
80104bfc:	eb 12                	jmp    80104c10 <safestrcpy+0x30>
80104bfe:	66 90                	xchg   %ax,%ax
80104c00:	0f b6 08             	movzbl (%eax),%ecx
80104c03:	83 c0 01             	add    $0x1,%eax
80104c06:	83 c2 01             	add    $0x1,%edx
80104c09:	88 4a ff             	mov    %cl,-0x1(%edx)
80104c0c:	84 c9                	test   %cl,%cl
80104c0e:	74 04                	je     80104c14 <safestrcpy+0x34>
80104c10:	39 d8                	cmp    %ebx,%eax
80104c12:	75 ec                	jne    80104c00 <safestrcpy+0x20>
80104c14:	c6 02 00             	movb   $0x0,(%edx)
80104c17:	89 f0                	mov    %esi,%eax
80104c19:	5b                   	pop    %ebx
80104c1a:	5e                   	pop    %esi
80104c1b:	5d                   	pop    %ebp
80104c1c:	c3                   	ret    
80104c1d:	8d 76 00             	lea    0x0(%esi),%esi

80104c20 <strlen>:
80104c20:	f3 0f 1e fb          	endbr32 
80104c24:	55                   	push   %ebp
80104c25:	31 c0                	xor    %eax,%eax
80104c27:	89 e5                	mov    %esp,%ebp
80104c29:	8b 55 08             	mov    0x8(%ebp),%edx
80104c2c:	80 3a 00             	cmpb   $0x0,(%edx)
80104c2f:	74 10                	je     80104c41 <strlen+0x21>
80104c31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c38:	83 c0 01             	add    $0x1,%eax
80104c3b:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104c3f:	75 f7                	jne    80104c38 <strlen+0x18>
80104c41:	5d                   	pop    %ebp
80104c42:	c3                   	ret    

80104c43 <swtch>:
80104c43:	8b 44 24 04          	mov    0x4(%esp),%eax
80104c47:	8b 54 24 08          	mov    0x8(%esp),%edx
80104c4b:	55                   	push   %ebp
80104c4c:	53                   	push   %ebx
80104c4d:	56                   	push   %esi
80104c4e:	57                   	push   %edi
80104c4f:	89 20                	mov    %esp,(%eax)
80104c51:	89 d4                	mov    %edx,%esp
80104c53:	5f                   	pop    %edi
80104c54:	5e                   	pop    %esi
80104c55:	5b                   	pop    %ebx
80104c56:	5d                   	pop    %ebp
80104c57:	c3                   	ret    
80104c58:	66 90                	xchg   %ax,%ax
80104c5a:	66 90                	xchg   %ax,%ax
80104c5c:	66 90                	xchg   %ax,%ax
80104c5e:	66 90                	xchg   %ax,%ax

80104c60 <fetchint>:
80104c60:	f3 0f 1e fb          	endbr32 
80104c64:	55                   	push   %ebp
80104c65:	89 e5                	mov    %esp,%ebp
80104c67:	53                   	push   %ebx
80104c68:	83 ec 04             	sub    $0x4,%esp
80104c6b:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104c6e:	e8 9d f0 ff ff       	call   80103d10 <myproc>
80104c73:	8b 00                	mov    (%eax),%eax
80104c75:	39 d8                	cmp    %ebx,%eax
80104c77:	76 17                	jbe    80104c90 <fetchint+0x30>
80104c79:	8d 53 04             	lea    0x4(%ebx),%edx
80104c7c:	39 d0                	cmp    %edx,%eax
80104c7e:	72 10                	jb     80104c90 <fetchint+0x30>
80104c80:	8b 45 0c             	mov    0xc(%ebp),%eax
80104c83:	8b 13                	mov    (%ebx),%edx
80104c85:	89 10                	mov    %edx,(%eax)
80104c87:	31 c0                	xor    %eax,%eax
80104c89:	83 c4 04             	add    $0x4,%esp
80104c8c:	5b                   	pop    %ebx
80104c8d:	5d                   	pop    %ebp
80104c8e:	c3                   	ret    
80104c8f:	90                   	nop
80104c90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104c95:	eb f2                	jmp    80104c89 <fetchint+0x29>
80104c97:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c9e:	66 90                	xchg   %ax,%ax

80104ca0 <fetchstr>:
80104ca0:	f3 0f 1e fb          	endbr32 
80104ca4:	55                   	push   %ebp
80104ca5:	89 e5                	mov    %esp,%ebp
80104ca7:	53                   	push   %ebx
80104ca8:	83 ec 04             	sub    $0x4,%esp
80104cab:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104cae:	e8 5d f0 ff ff       	call   80103d10 <myproc>
80104cb3:	39 18                	cmp    %ebx,(%eax)
80104cb5:	76 31                	jbe    80104ce8 <fetchstr+0x48>
80104cb7:	8b 55 0c             	mov    0xc(%ebp),%edx
80104cba:	89 1a                	mov    %ebx,(%edx)
80104cbc:	8b 10                	mov    (%eax),%edx
80104cbe:	39 d3                	cmp    %edx,%ebx
80104cc0:	73 26                	jae    80104ce8 <fetchstr+0x48>
80104cc2:	89 d8                	mov    %ebx,%eax
80104cc4:	eb 11                	jmp    80104cd7 <fetchstr+0x37>
80104cc6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ccd:	8d 76 00             	lea    0x0(%esi),%esi
80104cd0:	83 c0 01             	add    $0x1,%eax
80104cd3:	39 c2                	cmp    %eax,%edx
80104cd5:	76 11                	jbe    80104ce8 <fetchstr+0x48>
80104cd7:	80 38 00             	cmpb   $0x0,(%eax)
80104cda:	75 f4                	jne    80104cd0 <fetchstr+0x30>
80104cdc:	83 c4 04             	add    $0x4,%esp
80104cdf:	29 d8                	sub    %ebx,%eax
80104ce1:	5b                   	pop    %ebx
80104ce2:	5d                   	pop    %ebp
80104ce3:	c3                   	ret    
80104ce4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104ce8:	83 c4 04             	add    $0x4,%esp
80104ceb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104cf0:	5b                   	pop    %ebx
80104cf1:	5d                   	pop    %ebp
80104cf2:	c3                   	ret    
80104cf3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104cfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104d00 <argint>:
80104d00:	f3 0f 1e fb          	endbr32 
80104d04:	55                   	push   %ebp
80104d05:	89 e5                	mov    %esp,%ebp
80104d07:	56                   	push   %esi
80104d08:	53                   	push   %ebx
80104d09:	e8 02 f0 ff ff       	call   80103d10 <myproc>
80104d0e:	8b 55 08             	mov    0x8(%ebp),%edx
80104d11:	8b 40 18             	mov    0x18(%eax),%eax
80104d14:	8b 40 44             	mov    0x44(%eax),%eax
80104d17:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
80104d1a:	e8 f1 ef ff ff       	call   80103d10 <myproc>
80104d1f:	8d 73 04             	lea    0x4(%ebx),%esi
80104d22:	8b 00                	mov    (%eax),%eax
80104d24:	39 c6                	cmp    %eax,%esi
80104d26:	73 18                	jae    80104d40 <argint+0x40>
80104d28:	8d 53 08             	lea    0x8(%ebx),%edx
80104d2b:	39 d0                	cmp    %edx,%eax
80104d2d:	72 11                	jb     80104d40 <argint+0x40>
80104d2f:	8b 45 0c             	mov    0xc(%ebp),%eax
80104d32:	8b 53 04             	mov    0x4(%ebx),%edx
80104d35:	89 10                	mov    %edx,(%eax)
80104d37:	31 c0                	xor    %eax,%eax
80104d39:	5b                   	pop    %ebx
80104d3a:	5e                   	pop    %esi
80104d3b:	5d                   	pop    %ebp
80104d3c:	c3                   	ret    
80104d3d:	8d 76 00             	lea    0x0(%esi),%esi
80104d40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104d45:	eb f2                	jmp    80104d39 <argint+0x39>
80104d47:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d4e:	66 90                	xchg   %ax,%ax

80104d50 <argptr>:
80104d50:	f3 0f 1e fb          	endbr32 
80104d54:	55                   	push   %ebp
80104d55:	89 e5                	mov    %esp,%ebp
80104d57:	56                   	push   %esi
80104d58:	53                   	push   %ebx
80104d59:	83 ec 10             	sub    $0x10,%esp
80104d5c:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104d5f:	e8 ac ef ff ff       	call   80103d10 <myproc>
80104d64:	83 ec 08             	sub    $0x8,%esp
80104d67:	89 c6                	mov    %eax,%esi
80104d69:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104d6c:	50                   	push   %eax
80104d6d:	ff 75 08             	pushl  0x8(%ebp)
80104d70:	e8 8b ff ff ff       	call   80104d00 <argint>
80104d75:	83 c4 10             	add    $0x10,%esp
80104d78:	85 c0                	test   %eax,%eax
80104d7a:	78 24                	js     80104da0 <argptr+0x50>
80104d7c:	85 db                	test   %ebx,%ebx
80104d7e:	78 20                	js     80104da0 <argptr+0x50>
80104d80:	8b 16                	mov    (%esi),%edx
80104d82:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d85:	39 c2                	cmp    %eax,%edx
80104d87:	76 17                	jbe    80104da0 <argptr+0x50>
80104d89:	01 c3                	add    %eax,%ebx
80104d8b:	39 da                	cmp    %ebx,%edx
80104d8d:	72 11                	jb     80104da0 <argptr+0x50>
80104d8f:	8b 55 0c             	mov    0xc(%ebp),%edx
80104d92:	89 02                	mov    %eax,(%edx)
80104d94:	31 c0                	xor    %eax,%eax
80104d96:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104d99:	5b                   	pop    %ebx
80104d9a:	5e                   	pop    %esi
80104d9b:	5d                   	pop    %ebp
80104d9c:	c3                   	ret    
80104d9d:	8d 76 00             	lea    0x0(%esi),%esi
80104da0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104da5:	eb ef                	jmp    80104d96 <argptr+0x46>
80104da7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104dae:	66 90                	xchg   %ax,%ax

80104db0 <argstr>:
80104db0:	f3 0f 1e fb          	endbr32 
80104db4:	55                   	push   %ebp
80104db5:	89 e5                	mov    %esp,%ebp
80104db7:	83 ec 20             	sub    $0x20,%esp
80104dba:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104dbd:	50                   	push   %eax
80104dbe:	ff 75 08             	pushl  0x8(%ebp)
80104dc1:	e8 3a ff ff ff       	call   80104d00 <argint>
80104dc6:	83 c4 10             	add    $0x10,%esp
80104dc9:	85 c0                	test   %eax,%eax
80104dcb:	78 13                	js     80104de0 <argstr+0x30>
80104dcd:	83 ec 08             	sub    $0x8,%esp
80104dd0:	ff 75 0c             	pushl  0xc(%ebp)
80104dd3:	ff 75 f4             	pushl  -0xc(%ebp)
80104dd6:	e8 c5 fe ff ff       	call   80104ca0 <fetchstr>
80104ddb:	83 c4 10             	add    $0x10,%esp
80104dde:	c9                   	leave  
80104ddf:	c3                   	ret    
80104de0:	c9                   	leave  
80104de1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104de6:	c3                   	ret    
80104de7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104dee:	66 90                	xchg   %ax,%ax

80104df0 <syscall>:
80104df0:	f3 0f 1e fb          	endbr32 
80104df4:	55                   	push   %ebp
80104df5:	89 e5                	mov    %esp,%ebp
80104df7:	53                   	push   %ebx
80104df8:	83 ec 04             	sub    $0x4,%esp
80104dfb:	e8 10 ef ff ff       	call   80103d10 <myproc>
80104e00:	89 c3                	mov    %eax,%ebx
80104e02:	8b 40 18             	mov    0x18(%eax),%eax
80104e05:	8b 40 1c             	mov    0x1c(%eax),%eax
80104e08:	8d 50 ff             	lea    -0x1(%eax),%edx
80104e0b:	83 fa 14             	cmp    $0x14,%edx
80104e0e:	77 20                	ja     80104e30 <syscall+0x40>
80104e10:	8b 14 85 c0 7b 10 80 	mov    -0x7fef8440(,%eax,4),%edx
80104e17:	85 d2                	test   %edx,%edx
80104e19:	74 15                	je     80104e30 <syscall+0x40>
80104e1b:	ff d2                	call   *%edx
80104e1d:	89 c2                	mov    %eax,%edx
80104e1f:	8b 43 18             	mov    0x18(%ebx),%eax
80104e22:	89 50 1c             	mov    %edx,0x1c(%eax)
80104e25:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104e28:	c9                   	leave  
80104e29:	c3                   	ret    
80104e2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104e30:	50                   	push   %eax
80104e31:	8d 43 6c             	lea    0x6c(%ebx),%eax
80104e34:	50                   	push   %eax
80104e35:	ff 73 10             	pushl  0x10(%ebx)
80104e38:	68 9d 7b 10 80       	push   $0x80107b9d
80104e3d:	e8 6e b8 ff ff       	call   801006b0 <cprintf>
80104e42:	8b 43 18             	mov    0x18(%ebx),%eax
80104e45:	83 c4 10             	add    $0x10,%esp
80104e48:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
80104e4f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104e52:	c9                   	leave  
80104e53:	c3                   	ret    
80104e54:	66 90                	xchg   %ax,%ax
80104e56:	66 90                	xchg   %ax,%ax
80104e58:	66 90                	xchg   %ax,%ax
80104e5a:	66 90                	xchg   %ax,%ax
80104e5c:	66 90                	xchg   %ax,%ax
80104e5e:	66 90                	xchg   %ax,%ax

80104e60 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104e60:	55                   	push   %ebp
80104e61:	89 e5                	mov    %esp,%ebp
80104e63:	57                   	push   %edi
80104e64:	56                   	push   %esi
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104e65:	8d 7d da             	lea    -0x26(%ebp),%edi
{
80104e68:	53                   	push   %ebx
80104e69:	83 ec 34             	sub    $0x34,%esp
80104e6c:	89 4d d0             	mov    %ecx,-0x30(%ebp)
80104e6f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80104e72:	57                   	push   %edi
80104e73:	50                   	push   %eax
{
80104e74:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80104e77:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80104e7a:	e8 81 d5 ff ff       	call   80102400 <nameiparent>
80104e7f:	83 c4 10             	add    $0x10,%esp
80104e82:	85 c0                	test   %eax,%eax
80104e84:	0f 84 46 01 00 00    	je     80104fd0 <create+0x170>
    return 0;
  ilock(dp);
80104e8a:	83 ec 0c             	sub    $0xc,%esp
80104e8d:	89 c3                	mov    %eax,%ebx
80104e8f:	50                   	push   %eax
80104e90:	e8 7b cc ff ff       	call   80101b10 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80104e95:	83 c4 0c             	add    $0xc,%esp
80104e98:	6a 00                	push   $0x0
80104e9a:	57                   	push   %edi
80104e9b:	53                   	push   %ebx
80104e9c:	e8 bf d1 ff ff       	call   80102060 <dirlookup>
80104ea1:	83 c4 10             	add    $0x10,%esp
80104ea4:	89 c6                	mov    %eax,%esi
80104ea6:	85 c0                	test   %eax,%eax
80104ea8:	74 56                	je     80104f00 <create+0xa0>
    iunlockput(dp);
80104eaa:	83 ec 0c             	sub    $0xc,%esp
80104ead:	53                   	push   %ebx
80104eae:	e8 fd ce ff ff       	call   80101db0 <iunlockput>
    ilock(ip);
80104eb3:	89 34 24             	mov    %esi,(%esp)
80104eb6:	e8 55 cc ff ff       	call   80101b10 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104ebb:	83 c4 10             	add    $0x10,%esp
80104ebe:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80104ec3:	75 1b                	jne    80104ee0 <create+0x80>
80104ec5:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
80104eca:	75 14                	jne    80104ee0 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104ecc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104ecf:	89 f0                	mov    %esi,%eax
80104ed1:	5b                   	pop    %ebx
80104ed2:	5e                   	pop    %esi
80104ed3:	5f                   	pop    %edi
80104ed4:	5d                   	pop    %ebp
80104ed5:	c3                   	ret    
80104ed6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104edd:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
80104ee0:	83 ec 0c             	sub    $0xc,%esp
80104ee3:	56                   	push   %esi
    return 0;
80104ee4:	31 f6                	xor    %esi,%esi
    iunlockput(ip);
80104ee6:	e8 c5 ce ff ff       	call   80101db0 <iunlockput>
    return 0;
80104eeb:	83 c4 10             	add    $0x10,%esp
}
80104eee:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104ef1:	89 f0                	mov    %esi,%eax
80104ef3:	5b                   	pop    %ebx
80104ef4:	5e                   	pop    %esi
80104ef5:	5f                   	pop    %edi
80104ef6:	5d                   	pop    %ebp
80104ef7:	c3                   	ret    
80104ef8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104eff:	90                   	nop
  if((ip = ialloc(dp->dev, type)) == 0)
80104f00:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80104f04:	83 ec 08             	sub    $0x8,%esp
80104f07:	50                   	push   %eax
80104f08:	ff 33                	pushl  (%ebx)
80104f0a:	e8 81 ca ff ff       	call   80101990 <ialloc>
80104f0f:	83 c4 10             	add    $0x10,%esp
80104f12:	89 c6                	mov    %eax,%esi
80104f14:	85 c0                	test   %eax,%eax
80104f16:	0f 84 cd 00 00 00    	je     80104fe9 <create+0x189>
  ilock(ip);
80104f1c:	83 ec 0c             	sub    $0xc,%esp
80104f1f:	50                   	push   %eax
80104f20:	e8 eb cb ff ff       	call   80101b10 <ilock>
  ip->major = major;
80104f25:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80104f29:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
80104f2d:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80104f31:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
80104f35:	b8 01 00 00 00       	mov    $0x1,%eax
80104f3a:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
80104f3e:	89 34 24             	mov    %esi,(%esp)
80104f41:	e8 0a cb ff ff       	call   80101a50 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104f46:	83 c4 10             	add    $0x10,%esp
80104f49:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80104f4e:	74 30                	je     80104f80 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80104f50:	83 ec 04             	sub    $0x4,%esp
80104f53:	ff 76 04             	pushl  0x4(%esi)
80104f56:	57                   	push   %edi
80104f57:	53                   	push   %ebx
80104f58:	e8 c3 d3 ff ff       	call   80102320 <dirlink>
80104f5d:	83 c4 10             	add    $0x10,%esp
80104f60:	85 c0                	test   %eax,%eax
80104f62:	78 78                	js     80104fdc <create+0x17c>
  iunlockput(dp);
80104f64:	83 ec 0c             	sub    $0xc,%esp
80104f67:	53                   	push   %ebx
80104f68:	e8 43 ce ff ff       	call   80101db0 <iunlockput>
  return ip;
80104f6d:	83 c4 10             	add    $0x10,%esp
}
80104f70:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104f73:	89 f0                	mov    %esi,%eax
80104f75:	5b                   	pop    %ebx
80104f76:	5e                   	pop    %esi
80104f77:	5f                   	pop    %edi
80104f78:	5d                   	pop    %ebp
80104f79:	c3                   	ret    
80104f7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
80104f80:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
80104f83:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80104f88:	53                   	push   %ebx
80104f89:	e8 c2 ca ff ff       	call   80101a50 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104f8e:	83 c4 0c             	add    $0xc,%esp
80104f91:	ff 76 04             	pushl  0x4(%esi)
80104f94:	68 34 7c 10 80       	push   $0x80107c34
80104f99:	56                   	push   %esi
80104f9a:	e8 81 d3 ff ff       	call   80102320 <dirlink>
80104f9f:	83 c4 10             	add    $0x10,%esp
80104fa2:	85 c0                	test   %eax,%eax
80104fa4:	78 18                	js     80104fbe <create+0x15e>
80104fa6:	83 ec 04             	sub    $0x4,%esp
80104fa9:	ff 73 04             	pushl  0x4(%ebx)
80104fac:	68 33 7c 10 80       	push   $0x80107c33
80104fb1:	56                   	push   %esi
80104fb2:	e8 69 d3 ff ff       	call   80102320 <dirlink>
80104fb7:	83 c4 10             	add    $0x10,%esp
80104fba:	85 c0                	test   %eax,%eax
80104fbc:	79 92                	jns    80104f50 <create+0xf0>
      panic("create dots");
80104fbe:	83 ec 0c             	sub    $0xc,%esp
80104fc1:	68 27 7c 10 80       	push   $0x80107c27
80104fc6:	e8 c5 b3 ff ff       	call   80100390 <panic>
80104fcb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104fcf:	90                   	nop
}
80104fd0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80104fd3:	31 f6                	xor    %esi,%esi
}
80104fd5:	5b                   	pop    %ebx
80104fd6:	89 f0                	mov    %esi,%eax
80104fd8:	5e                   	pop    %esi
80104fd9:	5f                   	pop    %edi
80104fda:	5d                   	pop    %ebp
80104fdb:	c3                   	ret    
    panic("create: dirlink");
80104fdc:	83 ec 0c             	sub    $0xc,%esp
80104fdf:	68 36 7c 10 80       	push   $0x80107c36
80104fe4:	e8 a7 b3 ff ff       	call   80100390 <panic>
    panic("create: ialloc");
80104fe9:	83 ec 0c             	sub    $0xc,%esp
80104fec:	68 18 7c 10 80       	push   $0x80107c18
80104ff1:	e8 9a b3 ff ff       	call   80100390 <panic>
80104ff6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ffd:	8d 76 00             	lea    0x0(%esi),%esi

80105000 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80105000:	55                   	push   %ebp
80105001:	89 e5                	mov    %esp,%ebp
80105003:	56                   	push   %esi
80105004:	89 d6                	mov    %edx,%esi
80105006:	53                   	push   %ebx
80105007:	89 c3                	mov    %eax,%ebx
  if(argint(n, &fd) < 0)
80105009:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
8010500c:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010500f:	50                   	push   %eax
80105010:	6a 00                	push   $0x0
80105012:	e8 e9 fc ff ff       	call   80104d00 <argint>
80105017:	83 c4 10             	add    $0x10,%esp
8010501a:	85 c0                	test   %eax,%eax
8010501c:	78 2a                	js     80105048 <argfd.constprop.0+0x48>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010501e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105022:	77 24                	ja     80105048 <argfd.constprop.0+0x48>
80105024:	e8 e7 ec ff ff       	call   80103d10 <myproc>
80105029:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010502c:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80105030:	85 c0                	test   %eax,%eax
80105032:	74 14                	je     80105048 <argfd.constprop.0+0x48>
  if(pfd)
80105034:	85 db                	test   %ebx,%ebx
80105036:	74 02                	je     8010503a <argfd.constprop.0+0x3a>
    *pfd = fd;
80105038:	89 13                	mov    %edx,(%ebx)
    *pf = f;
8010503a:	89 06                	mov    %eax,(%esi)
  return 0;
8010503c:	31 c0                	xor    %eax,%eax
}
8010503e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105041:	5b                   	pop    %ebx
80105042:	5e                   	pop    %esi
80105043:	5d                   	pop    %ebp
80105044:	c3                   	ret    
80105045:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105048:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010504d:	eb ef                	jmp    8010503e <argfd.constprop.0+0x3e>
8010504f:	90                   	nop

80105050 <sys_dup>:
{
80105050:	f3 0f 1e fb          	endbr32 
80105054:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
80105055:	31 c0                	xor    %eax,%eax
{
80105057:	89 e5                	mov    %esp,%ebp
80105059:	56                   	push   %esi
8010505a:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
8010505b:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
8010505e:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
80105061:	e8 9a ff ff ff       	call   80105000 <argfd.constprop.0>
80105066:	85 c0                	test   %eax,%eax
80105068:	78 1e                	js     80105088 <sys_dup+0x38>
  if((fd=fdalloc(f)) < 0)
8010506a:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
8010506d:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
8010506f:	e8 9c ec ff ff       	call   80103d10 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105074:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80105078:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
8010507c:	85 d2                	test   %edx,%edx
8010507e:	74 20                	je     801050a0 <sys_dup+0x50>
  for(fd = 0; fd < NOFILE; fd++){
80105080:	83 c3 01             	add    $0x1,%ebx
80105083:	83 fb 10             	cmp    $0x10,%ebx
80105086:	75 f0                	jne    80105078 <sys_dup+0x28>
}
80105088:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
8010508b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80105090:	89 d8                	mov    %ebx,%eax
80105092:	5b                   	pop    %ebx
80105093:	5e                   	pop    %esi
80105094:	5d                   	pop    %ebp
80105095:	c3                   	ret    
80105096:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010509d:	8d 76 00             	lea    0x0(%esi),%esi
      curproc->ofile[fd] = f;
801050a0:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
801050a4:	83 ec 0c             	sub    $0xc,%esp
801050a7:	ff 75 f4             	pushl  -0xc(%ebp)
801050aa:	e8 71 c1 ff ff       	call   80101220 <filedup>
  return fd;
801050af:	83 c4 10             	add    $0x10,%esp
}
801050b2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801050b5:	89 d8                	mov    %ebx,%eax
801050b7:	5b                   	pop    %ebx
801050b8:	5e                   	pop    %esi
801050b9:	5d                   	pop    %ebp
801050ba:	c3                   	ret    
801050bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801050bf:	90                   	nop

801050c0 <sys_read>:
{
801050c0:	f3 0f 1e fb          	endbr32 
801050c4:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801050c5:	31 c0                	xor    %eax,%eax
{
801050c7:	89 e5                	mov    %esp,%ebp
801050c9:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801050cc:	8d 55 ec             	lea    -0x14(%ebp),%edx
801050cf:	e8 2c ff ff ff       	call   80105000 <argfd.constprop.0>
801050d4:	85 c0                	test   %eax,%eax
801050d6:	78 48                	js     80105120 <sys_read+0x60>
801050d8:	83 ec 08             	sub    $0x8,%esp
801050db:	8d 45 f0             	lea    -0x10(%ebp),%eax
801050de:	50                   	push   %eax
801050df:	6a 02                	push   $0x2
801050e1:	e8 1a fc ff ff       	call   80104d00 <argint>
801050e6:	83 c4 10             	add    $0x10,%esp
801050e9:	85 c0                	test   %eax,%eax
801050eb:	78 33                	js     80105120 <sys_read+0x60>
801050ed:	83 ec 04             	sub    $0x4,%esp
801050f0:	8d 45 f4             	lea    -0xc(%ebp),%eax
801050f3:	ff 75 f0             	pushl  -0x10(%ebp)
801050f6:	50                   	push   %eax
801050f7:	6a 01                	push   $0x1
801050f9:	e8 52 fc ff ff       	call   80104d50 <argptr>
801050fe:	83 c4 10             	add    $0x10,%esp
80105101:	85 c0                	test   %eax,%eax
80105103:	78 1b                	js     80105120 <sys_read+0x60>
  return fileread(f, p, n);
80105105:	83 ec 04             	sub    $0x4,%esp
80105108:	ff 75 f0             	pushl  -0x10(%ebp)
8010510b:	ff 75 f4             	pushl  -0xc(%ebp)
8010510e:	ff 75 ec             	pushl  -0x14(%ebp)
80105111:	e8 8a c2 ff ff       	call   801013a0 <fileread>
80105116:	83 c4 10             	add    $0x10,%esp
}
80105119:	c9                   	leave  
8010511a:	c3                   	ret    
8010511b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010511f:	90                   	nop
80105120:	c9                   	leave  
    return -1;
80105121:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105126:	c3                   	ret    
80105127:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010512e:	66 90                	xchg   %ax,%ax

80105130 <sys_write>:
{
80105130:	f3 0f 1e fb          	endbr32 
80105134:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105135:	31 c0                	xor    %eax,%eax
{
80105137:	89 e5                	mov    %esp,%ebp
80105139:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
8010513c:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010513f:	e8 bc fe ff ff       	call   80105000 <argfd.constprop.0>
80105144:	85 c0                	test   %eax,%eax
80105146:	78 48                	js     80105190 <sys_write+0x60>
80105148:	83 ec 08             	sub    $0x8,%esp
8010514b:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010514e:	50                   	push   %eax
8010514f:	6a 02                	push   $0x2
80105151:	e8 aa fb ff ff       	call   80104d00 <argint>
80105156:	83 c4 10             	add    $0x10,%esp
80105159:	85 c0                	test   %eax,%eax
8010515b:	78 33                	js     80105190 <sys_write+0x60>
8010515d:	83 ec 04             	sub    $0x4,%esp
80105160:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105163:	ff 75 f0             	pushl  -0x10(%ebp)
80105166:	50                   	push   %eax
80105167:	6a 01                	push   $0x1
80105169:	e8 e2 fb ff ff       	call   80104d50 <argptr>
8010516e:	83 c4 10             	add    $0x10,%esp
80105171:	85 c0                	test   %eax,%eax
80105173:	78 1b                	js     80105190 <sys_write+0x60>
  return filewrite(f, p, n);
80105175:	83 ec 04             	sub    $0x4,%esp
80105178:	ff 75 f0             	pushl  -0x10(%ebp)
8010517b:	ff 75 f4             	pushl  -0xc(%ebp)
8010517e:	ff 75 ec             	pushl  -0x14(%ebp)
80105181:	e8 ba c2 ff ff       	call   80101440 <filewrite>
80105186:	83 c4 10             	add    $0x10,%esp
}
80105189:	c9                   	leave  
8010518a:	c3                   	ret    
8010518b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010518f:	90                   	nop
80105190:	c9                   	leave  
    return -1;
80105191:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105196:	c3                   	ret    
80105197:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010519e:	66 90                	xchg   %ax,%ax

801051a0 <sys_close>:
{
801051a0:	f3 0f 1e fb          	endbr32 
801051a4:	55                   	push   %ebp
801051a5:	89 e5                	mov    %esp,%ebp
801051a7:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, &fd, &f) < 0)
801051aa:	8d 55 f4             	lea    -0xc(%ebp),%edx
801051ad:	8d 45 f0             	lea    -0x10(%ebp),%eax
801051b0:	e8 4b fe ff ff       	call   80105000 <argfd.constprop.0>
801051b5:	85 c0                	test   %eax,%eax
801051b7:	78 27                	js     801051e0 <sys_close+0x40>
  myproc()->ofile[fd] = 0;
801051b9:	e8 52 eb ff ff       	call   80103d10 <myproc>
801051be:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
801051c1:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
801051c4:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
801051cb:	00 
  fileclose(f);
801051cc:	ff 75 f4             	pushl  -0xc(%ebp)
801051cf:	e8 9c c0 ff ff       	call   80101270 <fileclose>
  return 0;
801051d4:	83 c4 10             	add    $0x10,%esp
801051d7:	31 c0                	xor    %eax,%eax
}
801051d9:	c9                   	leave  
801051da:	c3                   	ret    
801051db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801051df:	90                   	nop
801051e0:	c9                   	leave  
    return -1;
801051e1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801051e6:	c3                   	ret    
801051e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801051ee:	66 90                	xchg   %ax,%ax

801051f0 <sys_fstat>:
{
801051f0:	f3 0f 1e fb          	endbr32 
801051f4:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801051f5:	31 c0                	xor    %eax,%eax
{
801051f7:	89 e5                	mov    %esp,%ebp
801051f9:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801051fc:	8d 55 f0             	lea    -0x10(%ebp),%edx
801051ff:	e8 fc fd ff ff       	call   80105000 <argfd.constprop.0>
80105204:	85 c0                	test   %eax,%eax
80105206:	78 30                	js     80105238 <sys_fstat+0x48>
80105208:	83 ec 04             	sub    $0x4,%esp
8010520b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010520e:	6a 14                	push   $0x14
80105210:	50                   	push   %eax
80105211:	6a 01                	push   $0x1
80105213:	e8 38 fb ff ff       	call   80104d50 <argptr>
80105218:	83 c4 10             	add    $0x10,%esp
8010521b:	85 c0                	test   %eax,%eax
8010521d:	78 19                	js     80105238 <sys_fstat+0x48>
  return filestat(f, st);
8010521f:	83 ec 08             	sub    $0x8,%esp
80105222:	ff 75 f4             	pushl  -0xc(%ebp)
80105225:	ff 75 f0             	pushl  -0x10(%ebp)
80105228:	e8 23 c1 ff ff       	call   80101350 <filestat>
8010522d:	83 c4 10             	add    $0x10,%esp
}
80105230:	c9                   	leave  
80105231:	c3                   	ret    
80105232:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105238:	c9                   	leave  
    return -1;
80105239:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010523e:	c3                   	ret    
8010523f:	90                   	nop

80105240 <sys_link>:
{
80105240:	f3 0f 1e fb          	endbr32 
80105244:	55                   	push   %ebp
80105245:	89 e5                	mov    %esp,%ebp
80105247:	57                   	push   %edi
80105248:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105249:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
8010524c:	53                   	push   %ebx
8010524d:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105250:	50                   	push   %eax
80105251:	6a 00                	push   $0x0
80105253:	e8 58 fb ff ff       	call   80104db0 <argstr>
80105258:	83 c4 10             	add    $0x10,%esp
8010525b:	85 c0                	test   %eax,%eax
8010525d:	0f 88 ff 00 00 00    	js     80105362 <sys_link+0x122>
80105263:	83 ec 08             	sub    $0x8,%esp
80105266:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105269:	50                   	push   %eax
8010526a:	6a 01                	push   $0x1
8010526c:	e8 3f fb ff ff       	call   80104db0 <argstr>
80105271:	83 c4 10             	add    $0x10,%esp
80105274:	85 c0                	test   %eax,%eax
80105276:	0f 88 e6 00 00 00    	js     80105362 <sys_link+0x122>
  begin_op();
8010527c:	e8 5f de ff ff       	call   801030e0 <begin_op>
  if((ip = namei(old)) == 0){
80105281:	83 ec 0c             	sub    $0xc,%esp
80105284:	ff 75 d4             	pushl  -0x2c(%ebp)
80105287:	e8 54 d1 ff ff       	call   801023e0 <namei>
8010528c:	83 c4 10             	add    $0x10,%esp
8010528f:	89 c3                	mov    %eax,%ebx
80105291:	85 c0                	test   %eax,%eax
80105293:	0f 84 e8 00 00 00    	je     80105381 <sys_link+0x141>
  ilock(ip);
80105299:	83 ec 0c             	sub    $0xc,%esp
8010529c:	50                   	push   %eax
8010529d:	e8 6e c8 ff ff       	call   80101b10 <ilock>
  if(ip->type == T_DIR){
801052a2:	83 c4 10             	add    $0x10,%esp
801052a5:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801052aa:	0f 84 b9 00 00 00    	je     80105369 <sys_link+0x129>
  iupdate(ip);
801052b0:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
801052b3:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
801052b8:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
801052bb:	53                   	push   %ebx
801052bc:	e8 8f c7 ff ff       	call   80101a50 <iupdate>
  iunlock(ip);
801052c1:	89 1c 24             	mov    %ebx,(%esp)
801052c4:	e8 27 c9 ff ff       	call   80101bf0 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
801052c9:	58                   	pop    %eax
801052ca:	5a                   	pop    %edx
801052cb:	57                   	push   %edi
801052cc:	ff 75 d0             	pushl  -0x30(%ebp)
801052cf:	e8 2c d1 ff ff       	call   80102400 <nameiparent>
801052d4:	83 c4 10             	add    $0x10,%esp
801052d7:	89 c6                	mov    %eax,%esi
801052d9:	85 c0                	test   %eax,%eax
801052db:	74 5f                	je     8010533c <sys_link+0xfc>
  ilock(dp);
801052dd:	83 ec 0c             	sub    $0xc,%esp
801052e0:	50                   	push   %eax
801052e1:	e8 2a c8 ff ff       	call   80101b10 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
801052e6:	8b 03                	mov    (%ebx),%eax
801052e8:	83 c4 10             	add    $0x10,%esp
801052eb:	39 06                	cmp    %eax,(%esi)
801052ed:	75 41                	jne    80105330 <sys_link+0xf0>
801052ef:	83 ec 04             	sub    $0x4,%esp
801052f2:	ff 73 04             	pushl  0x4(%ebx)
801052f5:	57                   	push   %edi
801052f6:	56                   	push   %esi
801052f7:	e8 24 d0 ff ff       	call   80102320 <dirlink>
801052fc:	83 c4 10             	add    $0x10,%esp
801052ff:	85 c0                	test   %eax,%eax
80105301:	78 2d                	js     80105330 <sys_link+0xf0>
  iunlockput(dp);
80105303:	83 ec 0c             	sub    $0xc,%esp
80105306:	56                   	push   %esi
80105307:	e8 a4 ca ff ff       	call   80101db0 <iunlockput>
  iput(ip);
8010530c:	89 1c 24             	mov    %ebx,(%esp)
8010530f:	e8 2c c9 ff ff       	call   80101c40 <iput>
  end_op();
80105314:	e8 37 de ff ff       	call   80103150 <end_op>
  return 0;
80105319:	83 c4 10             	add    $0x10,%esp
8010531c:	31 c0                	xor    %eax,%eax
}
8010531e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105321:	5b                   	pop    %ebx
80105322:	5e                   	pop    %esi
80105323:	5f                   	pop    %edi
80105324:	5d                   	pop    %ebp
80105325:	c3                   	ret    
80105326:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010532d:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(dp);
80105330:	83 ec 0c             	sub    $0xc,%esp
80105333:	56                   	push   %esi
80105334:	e8 77 ca ff ff       	call   80101db0 <iunlockput>
    goto bad;
80105339:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
8010533c:	83 ec 0c             	sub    $0xc,%esp
8010533f:	53                   	push   %ebx
80105340:	e8 cb c7 ff ff       	call   80101b10 <ilock>
  ip->nlink--;
80105345:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
8010534a:	89 1c 24             	mov    %ebx,(%esp)
8010534d:	e8 fe c6 ff ff       	call   80101a50 <iupdate>
  iunlockput(ip);
80105352:	89 1c 24             	mov    %ebx,(%esp)
80105355:	e8 56 ca ff ff       	call   80101db0 <iunlockput>
  end_op();
8010535a:	e8 f1 dd ff ff       	call   80103150 <end_op>
  return -1;
8010535f:	83 c4 10             	add    $0x10,%esp
80105362:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105367:	eb b5                	jmp    8010531e <sys_link+0xde>
    iunlockput(ip);
80105369:	83 ec 0c             	sub    $0xc,%esp
8010536c:	53                   	push   %ebx
8010536d:	e8 3e ca ff ff       	call   80101db0 <iunlockput>
    end_op();
80105372:	e8 d9 dd ff ff       	call   80103150 <end_op>
    return -1;
80105377:	83 c4 10             	add    $0x10,%esp
8010537a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010537f:	eb 9d                	jmp    8010531e <sys_link+0xde>
    end_op();
80105381:	e8 ca dd ff ff       	call   80103150 <end_op>
    return -1;
80105386:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010538b:	eb 91                	jmp    8010531e <sys_link+0xde>
8010538d:	8d 76 00             	lea    0x0(%esi),%esi

80105390 <sys_unlink>:
{
80105390:	f3 0f 1e fb          	endbr32 
80105394:	55                   	push   %ebp
80105395:	89 e5                	mov    %esp,%ebp
80105397:	57                   	push   %edi
80105398:	56                   	push   %esi
  if(argstr(0, &path) < 0)
80105399:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
8010539c:	53                   	push   %ebx
8010539d:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
801053a0:	50                   	push   %eax
801053a1:	6a 00                	push   $0x0
801053a3:	e8 08 fa ff ff       	call   80104db0 <argstr>
801053a8:	83 c4 10             	add    $0x10,%esp
801053ab:	85 c0                	test   %eax,%eax
801053ad:	0f 88 7d 01 00 00    	js     80105530 <sys_unlink+0x1a0>
  begin_op();
801053b3:	e8 28 dd ff ff       	call   801030e0 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
801053b8:	8d 5d ca             	lea    -0x36(%ebp),%ebx
801053bb:	83 ec 08             	sub    $0x8,%esp
801053be:	53                   	push   %ebx
801053bf:	ff 75 c0             	pushl  -0x40(%ebp)
801053c2:	e8 39 d0 ff ff       	call   80102400 <nameiparent>
801053c7:	83 c4 10             	add    $0x10,%esp
801053ca:	89 c6                	mov    %eax,%esi
801053cc:	85 c0                	test   %eax,%eax
801053ce:	0f 84 66 01 00 00    	je     8010553a <sys_unlink+0x1aa>
  ilock(dp);
801053d4:	83 ec 0c             	sub    $0xc,%esp
801053d7:	50                   	push   %eax
801053d8:	e8 33 c7 ff ff       	call   80101b10 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
801053dd:	58                   	pop    %eax
801053de:	5a                   	pop    %edx
801053df:	68 34 7c 10 80       	push   $0x80107c34
801053e4:	53                   	push   %ebx
801053e5:	e8 56 cc ff ff       	call   80102040 <namecmp>
801053ea:	83 c4 10             	add    $0x10,%esp
801053ed:	85 c0                	test   %eax,%eax
801053ef:	0f 84 03 01 00 00    	je     801054f8 <sys_unlink+0x168>
801053f5:	83 ec 08             	sub    $0x8,%esp
801053f8:	68 33 7c 10 80       	push   $0x80107c33
801053fd:	53                   	push   %ebx
801053fe:	e8 3d cc ff ff       	call   80102040 <namecmp>
80105403:	83 c4 10             	add    $0x10,%esp
80105406:	85 c0                	test   %eax,%eax
80105408:	0f 84 ea 00 00 00    	je     801054f8 <sys_unlink+0x168>
  if((ip = dirlookup(dp, name, &off)) == 0)
8010540e:	83 ec 04             	sub    $0x4,%esp
80105411:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105414:	50                   	push   %eax
80105415:	53                   	push   %ebx
80105416:	56                   	push   %esi
80105417:	e8 44 cc ff ff       	call   80102060 <dirlookup>
8010541c:	83 c4 10             	add    $0x10,%esp
8010541f:	89 c3                	mov    %eax,%ebx
80105421:	85 c0                	test   %eax,%eax
80105423:	0f 84 cf 00 00 00    	je     801054f8 <sys_unlink+0x168>
  ilock(ip);
80105429:	83 ec 0c             	sub    $0xc,%esp
8010542c:	50                   	push   %eax
8010542d:	e8 de c6 ff ff       	call   80101b10 <ilock>
  if(ip->nlink < 1)
80105432:	83 c4 10             	add    $0x10,%esp
80105435:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
8010543a:	0f 8e 23 01 00 00    	jle    80105563 <sys_unlink+0x1d3>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105440:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105445:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105448:	74 66                	je     801054b0 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
8010544a:	83 ec 04             	sub    $0x4,%esp
8010544d:	6a 10                	push   $0x10
8010544f:	6a 00                	push   $0x0
80105451:	57                   	push   %edi
80105452:	e8 c9 f5 ff ff       	call   80104a20 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105457:	6a 10                	push   $0x10
80105459:	ff 75 c4             	pushl  -0x3c(%ebp)
8010545c:	57                   	push   %edi
8010545d:	56                   	push   %esi
8010545e:	e8 ad ca ff ff       	call   80101f10 <writei>
80105463:	83 c4 20             	add    $0x20,%esp
80105466:	83 f8 10             	cmp    $0x10,%eax
80105469:	0f 85 e7 00 00 00    	jne    80105556 <sys_unlink+0x1c6>
  if(ip->type == T_DIR){
8010546f:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105474:	0f 84 96 00 00 00    	je     80105510 <sys_unlink+0x180>
  iunlockput(dp);
8010547a:	83 ec 0c             	sub    $0xc,%esp
8010547d:	56                   	push   %esi
8010547e:	e8 2d c9 ff ff       	call   80101db0 <iunlockput>
  ip->nlink--;
80105483:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105488:	89 1c 24             	mov    %ebx,(%esp)
8010548b:	e8 c0 c5 ff ff       	call   80101a50 <iupdate>
  iunlockput(ip);
80105490:	89 1c 24             	mov    %ebx,(%esp)
80105493:	e8 18 c9 ff ff       	call   80101db0 <iunlockput>
  end_op();
80105498:	e8 b3 dc ff ff       	call   80103150 <end_op>
  return 0;
8010549d:	83 c4 10             	add    $0x10,%esp
801054a0:	31 c0                	xor    %eax,%eax
}
801054a2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801054a5:	5b                   	pop    %ebx
801054a6:	5e                   	pop    %esi
801054a7:	5f                   	pop    %edi
801054a8:	5d                   	pop    %ebp
801054a9:	c3                   	ret    
801054aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801054b0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
801054b4:	76 94                	jbe    8010544a <sys_unlink+0xba>
801054b6:	ba 20 00 00 00       	mov    $0x20,%edx
801054bb:	eb 0b                	jmp    801054c8 <sys_unlink+0x138>
801054bd:	8d 76 00             	lea    0x0(%esi),%esi
801054c0:	83 c2 10             	add    $0x10,%edx
801054c3:	39 53 58             	cmp    %edx,0x58(%ebx)
801054c6:	76 82                	jbe    8010544a <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801054c8:	6a 10                	push   $0x10
801054ca:	52                   	push   %edx
801054cb:	57                   	push   %edi
801054cc:	53                   	push   %ebx
801054cd:	89 55 b4             	mov    %edx,-0x4c(%ebp)
801054d0:	e8 3b c9 ff ff       	call   80101e10 <readi>
801054d5:	83 c4 10             	add    $0x10,%esp
801054d8:	8b 55 b4             	mov    -0x4c(%ebp),%edx
801054db:	83 f8 10             	cmp    $0x10,%eax
801054de:	75 69                	jne    80105549 <sys_unlink+0x1b9>
    if(de.inum != 0)
801054e0:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801054e5:	74 d9                	je     801054c0 <sys_unlink+0x130>
    iunlockput(ip);
801054e7:	83 ec 0c             	sub    $0xc,%esp
801054ea:	53                   	push   %ebx
801054eb:	e8 c0 c8 ff ff       	call   80101db0 <iunlockput>
    goto bad;
801054f0:	83 c4 10             	add    $0x10,%esp
801054f3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801054f7:	90                   	nop
  iunlockput(dp);
801054f8:	83 ec 0c             	sub    $0xc,%esp
801054fb:	56                   	push   %esi
801054fc:	e8 af c8 ff ff       	call   80101db0 <iunlockput>
  end_op();
80105501:	e8 4a dc ff ff       	call   80103150 <end_op>
  return -1;
80105506:	83 c4 10             	add    $0x10,%esp
80105509:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010550e:	eb 92                	jmp    801054a2 <sys_unlink+0x112>
    iupdate(dp);
80105510:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
80105513:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
80105518:	56                   	push   %esi
80105519:	e8 32 c5 ff ff       	call   80101a50 <iupdate>
8010551e:	83 c4 10             	add    $0x10,%esp
80105521:	e9 54 ff ff ff       	jmp    8010547a <sys_unlink+0xea>
80105526:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010552d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105530:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105535:	e9 68 ff ff ff       	jmp    801054a2 <sys_unlink+0x112>
    end_op();
8010553a:	e8 11 dc ff ff       	call   80103150 <end_op>
    return -1;
8010553f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105544:	e9 59 ff ff ff       	jmp    801054a2 <sys_unlink+0x112>
      panic("isdirempty: readi");
80105549:	83 ec 0c             	sub    $0xc,%esp
8010554c:	68 58 7c 10 80       	push   $0x80107c58
80105551:	e8 3a ae ff ff       	call   80100390 <panic>
    panic("unlink: writei");
80105556:	83 ec 0c             	sub    $0xc,%esp
80105559:	68 6a 7c 10 80       	push   $0x80107c6a
8010555e:	e8 2d ae ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
80105563:	83 ec 0c             	sub    $0xc,%esp
80105566:	68 46 7c 10 80       	push   $0x80107c46
8010556b:	e8 20 ae ff ff       	call   80100390 <panic>

80105570 <sys_open>:

int
sys_open(void)
{
80105570:	f3 0f 1e fb          	endbr32 
80105574:	55                   	push   %ebp
80105575:	89 e5                	mov    %esp,%ebp
80105577:	57                   	push   %edi
80105578:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105579:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
8010557c:	53                   	push   %ebx
8010557d:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105580:	50                   	push   %eax
80105581:	6a 00                	push   $0x0
80105583:	e8 28 f8 ff ff       	call   80104db0 <argstr>
80105588:	83 c4 10             	add    $0x10,%esp
8010558b:	85 c0                	test   %eax,%eax
8010558d:	0f 88 8a 00 00 00    	js     8010561d <sys_open+0xad>
80105593:	83 ec 08             	sub    $0x8,%esp
80105596:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105599:	50                   	push   %eax
8010559a:	6a 01                	push   $0x1
8010559c:	e8 5f f7 ff ff       	call   80104d00 <argint>
801055a1:	83 c4 10             	add    $0x10,%esp
801055a4:	85 c0                	test   %eax,%eax
801055a6:	78 75                	js     8010561d <sys_open+0xad>
    return -1;

  begin_op();
801055a8:	e8 33 db ff ff       	call   801030e0 <begin_op>

  if(omode & O_CREATE){
801055ad:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
801055b1:	75 75                	jne    80105628 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
801055b3:	83 ec 0c             	sub    $0xc,%esp
801055b6:	ff 75 e0             	pushl  -0x20(%ebp)
801055b9:	e8 22 ce ff ff       	call   801023e0 <namei>
801055be:	83 c4 10             	add    $0x10,%esp
801055c1:	89 c6                	mov    %eax,%esi
801055c3:	85 c0                	test   %eax,%eax
801055c5:	74 7e                	je     80105645 <sys_open+0xd5>
      end_op();
      return -1;
    }
    ilock(ip);
801055c7:	83 ec 0c             	sub    $0xc,%esp
801055ca:	50                   	push   %eax
801055cb:	e8 40 c5 ff ff       	call   80101b10 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
801055d0:	83 c4 10             	add    $0x10,%esp
801055d3:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801055d8:	0f 84 c2 00 00 00    	je     801056a0 <sys_open+0x130>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801055de:	e8 cd bb ff ff       	call   801011b0 <filealloc>
801055e3:	89 c7                	mov    %eax,%edi
801055e5:	85 c0                	test   %eax,%eax
801055e7:	74 23                	je     8010560c <sys_open+0x9c>
  struct proc *curproc = myproc();
801055e9:	e8 22 e7 ff ff       	call   80103d10 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801055ee:	31 db                	xor    %ebx,%ebx
    if(curproc->ofile[fd] == 0){
801055f0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801055f4:	85 d2                	test   %edx,%edx
801055f6:	74 60                	je     80105658 <sys_open+0xe8>
  for(fd = 0; fd < NOFILE; fd++){
801055f8:	83 c3 01             	add    $0x1,%ebx
801055fb:	83 fb 10             	cmp    $0x10,%ebx
801055fe:	75 f0                	jne    801055f0 <sys_open+0x80>
    if(f)
      fileclose(f);
80105600:	83 ec 0c             	sub    $0xc,%esp
80105603:	57                   	push   %edi
80105604:	e8 67 bc ff ff       	call   80101270 <fileclose>
80105609:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
8010560c:	83 ec 0c             	sub    $0xc,%esp
8010560f:	56                   	push   %esi
80105610:	e8 9b c7 ff ff       	call   80101db0 <iunlockput>
    end_op();
80105615:	e8 36 db ff ff       	call   80103150 <end_op>
    return -1;
8010561a:	83 c4 10             	add    $0x10,%esp
8010561d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105622:	eb 6d                	jmp    80105691 <sys_open+0x121>
80105624:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
80105628:	83 ec 0c             	sub    $0xc,%esp
8010562b:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010562e:	31 c9                	xor    %ecx,%ecx
80105630:	ba 02 00 00 00       	mov    $0x2,%edx
80105635:	6a 00                	push   $0x0
80105637:	e8 24 f8 ff ff       	call   80104e60 <create>
    if(ip == 0){
8010563c:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
8010563f:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80105641:	85 c0                	test   %eax,%eax
80105643:	75 99                	jne    801055de <sys_open+0x6e>
      end_op();
80105645:	e8 06 db ff ff       	call   80103150 <end_op>
      return -1;
8010564a:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
8010564f:	eb 40                	jmp    80105691 <sys_open+0x121>
80105651:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
80105658:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
8010565b:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
8010565f:	56                   	push   %esi
80105660:	e8 8b c5 ff ff       	call   80101bf0 <iunlock>
  end_op();
80105665:	e8 e6 da ff ff       	call   80103150 <end_op>

  f->type = FD_INODE;
8010566a:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105670:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105673:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105676:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
80105679:	89 d0                	mov    %edx,%eax
  f->off = 0;
8010567b:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80105682:	f7 d0                	not    %eax
80105684:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105687:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
8010568a:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010568d:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80105691:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105694:	89 d8                	mov    %ebx,%eax
80105696:	5b                   	pop    %ebx
80105697:	5e                   	pop    %esi
80105698:	5f                   	pop    %edi
80105699:	5d                   	pop    %ebp
8010569a:	c3                   	ret    
8010569b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010569f:	90                   	nop
    if(ip->type == T_DIR && omode != O_RDONLY){
801056a0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801056a3:	85 c9                	test   %ecx,%ecx
801056a5:	0f 84 33 ff ff ff    	je     801055de <sys_open+0x6e>
801056ab:	e9 5c ff ff ff       	jmp    8010560c <sys_open+0x9c>

801056b0 <sys_mkdir>:

int
sys_mkdir(void)
{
801056b0:	f3 0f 1e fb          	endbr32 
801056b4:	55                   	push   %ebp
801056b5:	89 e5                	mov    %esp,%ebp
801056b7:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
801056ba:	e8 21 da ff ff       	call   801030e0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801056bf:	83 ec 08             	sub    $0x8,%esp
801056c2:	8d 45 f4             	lea    -0xc(%ebp),%eax
801056c5:	50                   	push   %eax
801056c6:	6a 00                	push   $0x0
801056c8:	e8 e3 f6 ff ff       	call   80104db0 <argstr>
801056cd:	83 c4 10             	add    $0x10,%esp
801056d0:	85 c0                	test   %eax,%eax
801056d2:	78 34                	js     80105708 <sys_mkdir+0x58>
801056d4:	83 ec 0c             	sub    $0xc,%esp
801056d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801056da:	31 c9                	xor    %ecx,%ecx
801056dc:	ba 01 00 00 00       	mov    $0x1,%edx
801056e1:	6a 00                	push   $0x0
801056e3:	e8 78 f7 ff ff       	call   80104e60 <create>
801056e8:	83 c4 10             	add    $0x10,%esp
801056eb:	85 c0                	test   %eax,%eax
801056ed:	74 19                	je     80105708 <sys_mkdir+0x58>
    end_op();
    return -1;
  }
  iunlockput(ip);
801056ef:	83 ec 0c             	sub    $0xc,%esp
801056f2:	50                   	push   %eax
801056f3:	e8 b8 c6 ff ff       	call   80101db0 <iunlockput>
  end_op();
801056f8:	e8 53 da ff ff       	call   80103150 <end_op>
  return 0;
801056fd:	83 c4 10             	add    $0x10,%esp
80105700:	31 c0                	xor    %eax,%eax
}
80105702:	c9                   	leave  
80105703:	c3                   	ret    
80105704:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    end_op();
80105708:	e8 43 da ff ff       	call   80103150 <end_op>
    return -1;
8010570d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105712:	c9                   	leave  
80105713:	c3                   	ret    
80105714:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010571b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010571f:	90                   	nop

80105720 <sys_mknod>:

int
sys_mknod(void)
{
80105720:	f3 0f 1e fb          	endbr32 
80105724:	55                   	push   %ebp
80105725:	89 e5                	mov    %esp,%ebp
80105727:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
8010572a:	e8 b1 d9 ff ff       	call   801030e0 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010572f:	83 ec 08             	sub    $0x8,%esp
80105732:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105735:	50                   	push   %eax
80105736:	6a 00                	push   $0x0
80105738:	e8 73 f6 ff ff       	call   80104db0 <argstr>
8010573d:	83 c4 10             	add    $0x10,%esp
80105740:	85 c0                	test   %eax,%eax
80105742:	78 64                	js     801057a8 <sys_mknod+0x88>
     argint(1, &major) < 0 ||
80105744:	83 ec 08             	sub    $0x8,%esp
80105747:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010574a:	50                   	push   %eax
8010574b:	6a 01                	push   $0x1
8010574d:	e8 ae f5 ff ff       	call   80104d00 <argint>
  if((argstr(0, &path)) < 0 ||
80105752:	83 c4 10             	add    $0x10,%esp
80105755:	85 c0                	test   %eax,%eax
80105757:	78 4f                	js     801057a8 <sys_mknod+0x88>
     argint(2, &minor) < 0 ||
80105759:	83 ec 08             	sub    $0x8,%esp
8010575c:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010575f:	50                   	push   %eax
80105760:	6a 02                	push   $0x2
80105762:	e8 99 f5 ff ff       	call   80104d00 <argint>
     argint(1, &major) < 0 ||
80105767:	83 c4 10             	add    $0x10,%esp
8010576a:	85 c0                	test   %eax,%eax
8010576c:	78 3a                	js     801057a8 <sys_mknod+0x88>
     (ip = create(path, T_DEV, major, minor)) == 0){
8010576e:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
80105772:	83 ec 0c             	sub    $0xc,%esp
80105775:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105779:	ba 03 00 00 00       	mov    $0x3,%edx
8010577e:	50                   	push   %eax
8010577f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105782:	e8 d9 f6 ff ff       	call   80104e60 <create>
     argint(2, &minor) < 0 ||
80105787:	83 c4 10             	add    $0x10,%esp
8010578a:	85 c0                	test   %eax,%eax
8010578c:	74 1a                	je     801057a8 <sys_mknod+0x88>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010578e:	83 ec 0c             	sub    $0xc,%esp
80105791:	50                   	push   %eax
80105792:	e8 19 c6 ff ff       	call   80101db0 <iunlockput>
  end_op();
80105797:	e8 b4 d9 ff ff       	call   80103150 <end_op>
  return 0;
8010579c:	83 c4 10             	add    $0x10,%esp
8010579f:	31 c0                	xor    %eax,%eax
}
801057a1:	c9                   	leave  
801057a2:	c3                   	ret    
801057a3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801057a7:	90                   	nop
    end_op();
801057a8:	e8 a3 d9 ff ff       	call   80103150 <end_op>
    return -1;
801057ad:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801057b2:	c9                   	leave  
801057b3:	c3                   	ret    
801057b4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801057bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801057bf:	90                   	nop

801057c0 <sys_chdir>:

int
sys_chdir(void)
{
801057c0:	f3 0f 1e fb          	endbr32 
801057c4:	55                   	push   %ebp
801057c5:	89 e5                	mov    %esp,%ebp
801057c7:	56                   	push   %esi
801057c8:	53                   	push   %ebx
801057c9:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
801057cc:	e8 3f e5 ff ff       	call   80103d10 <myproc>
801057d1:	89 c6                	mov    %eax,%esi
  
  begin_op();
801057d3:	e8 08 d9 ff ff       	call   801030e0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
801057d8:	83 ec 08             	sub    $0x8,%esp
801057db:	8d 45 f4             	lea    -0xc(%ebp),%eax
801057de:	50                   	push   %eax
801057df:	6a 00                	push   $0x0
801057e1:	e8 ca f5 ff ff       	call   80104db0 <argstr>
801057e6:	83 c4 10             	add    $0x10,%esp
801057e9:	85 c0                	test   %eax,%eax
801057eb:	78 73                	js     80105860 <sys_chdir+0xa0>
801057ed:	83 ec 0c             	sub    $0xc,%esp
801057f0:	ff 75 f4             	pushl  -0xc(%ebp)
801057f3:	e8 e8 cb ff ff       	call   801023e0 <namei>
801057f8:	83 c4 10             	add    $0x10,%esp
801057fb:	89 c3                	mov    %eax,%ebx
801057fd:	85 c0                	test   %eax,%eax
801057ff:	74 5f                	je     80105860 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
80105801:	83 ec 0c             	sub    $0xc,%esp
80105804:	50                   	push   %eax
80105805:	e8 06 c3 ff ff       	call   80101b10 <ilock>
  if(ip->type != T_DIR){
8010580a:	83 c4 10             	add    $0x10,%esp
8010580d:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105812:	75 2c                	jne    80105840 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105814:	83 ec 0c             	sub    $0xc,%esp
80105817:	53                   	push   %ebx
80105818:	e8 d3 c3 ff ff       	call   80101bf0 <iunlock>
  iput(curproc->cwd);
8010581d:	58                   	pop    %eax
8010581e:	ff 76 68             	pushl  0x68(%esi)
80105821:	e8 1a c4 ff ff       	call   80101c40 <iput>
  end_op();
80105826:	e8 25 d9 ff ff       	call   80103150 <end_op>
  curproc->cwd = ip;
8010582b:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
8010582e:	83 c4 10             	add    $0x10,%esp
80105831:	31 c0                	xor    %eax,%eax
}
80105833:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105836:	5b                   	pop    %ebx
80105837:	5e                   	pop    %esi
80105838:	5d                   	pop    %ebp
80105839:	c3                   	ret    
8010583a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(ip);
80105840:	83 ec 0c             	sub    $0xc,%esp
80105843:	53                   	push   %ebx
80105844:	e8 67 c5 ff ff       	call   80101db0 <iunlockput>
    end_op();
80105849:	e8 02 d9 ff ff       	call   80103150 <end_op>
    return -1;
8010584e:	83 c4 10             	add    $0x10,%esp
80105851:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105856:	eb db                	jmp    80105833 <sys_chdir+0x73>
80105858:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010585f:	90                   	nop
    end_op();
80105860:	e8 eb d8 ff ff       	call   80103150 <end_op>
    return -1;
80105865:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010586a:	eb c7                	jmp    80105833 <sys_chdir+0x73>
8010586c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105870 <sys_exec>:

int
sys_exec(void)
{
80105870:	f3 0f 1e fb          	endbr32 
80105874:	55                   	push   %ebp
80105875:	89 e5                	mov    %esp,%ebp
80105877:	57                   	push   %edi
80105878:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105879:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
8010587f:	53                   	push   %ebx
80105880:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105886:	50                   	push   %eax
80105887:	6a 00                	push   $0x0
80105889:	e8 22 f5 ff ff       	call   80104db0 <argstr>
8010588e:	83 c4 10             	add    $0x10,%esp
80105891:	85 c0                	test   %eax,%eax
80105893:	0f 88 8b 00 00 00    	js     80105924 <sys_exec+0xb4>
80105899:	83 ec 08             	sub    $0x8,%esp
8010589c:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
801058a2:	50                   	push   %eax
801058a3:	6a 01                	push   $0x1
801058a5:	e8 56 f4 ff ff       	call   80104d00 <argint>
801058aa:	83 c4 10             	add    $0x10,%esp
801058ad:	85 c0                	test   %eax,%eax
801058af:	78 73                	js     80105924 <sys_exec+0xb4>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
801058b1:	83 ec 04             	sub    $0x4,%esp
801058b4:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
  for(i=0;; i++){
801058ba:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
801058bc:	68 80 00 00 00       	push   $0x80
801058c1:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
801058c7:	6a 00                	push   $0x0
801058c9:	50                   	push   %eax
801058ca:	e8 51 f1 ff ff       	call   80104a20 <memset>
801058cf:	83 c4 10             	add    $0x10,%esp
801058d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801058d8:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
801058de:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
801058e5:	83 ec 08             	sub    $0x8,%esp
801058e8:	57                   	push   %edi
801058e9:	01 f0                	add    %esi,%eax
801058eb:	50                   	push   %eax
801058ec:	e8 6f f3 ff ff       	call   80104c60 <fetchint>
801058f1:	83 c4 10             	add    $0x10,%esp
801058f4:	85 c0                	test   %eax,%eax
801058f6:	78 2c                	js     80105924 <sys_exec+0xb4>
      return -1;
    if(uarg == 0){
801058f8:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801058fe:	85 c0                	test   %eax,%eax
80105900:	74 36                	je     80105938 <sys_exec+0xc8>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105902:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80105908:	83 ec 08             	sub    $0x8,%esp
8010590b:	8d 14 31             	lea    (%ecx,%esi,1),%edx
8010590e:	52                   	push   %edx
8010590f:	50                   	push   %eax
80105910:	e8 8b f3 ff ff       	call   80104ca0 <fetchstr>
80105915:	83 c4 10             	add    $0x10,%esp
80105918:	85 c0                	test   %eax,%eax
8010591a:	78 08                	js     80105924 <sys_exec+0xb4>
  for(i=0;; i++){
8010591c:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
8010591f:	83 fb 20             	cmp    $0x20,%ebx
80105922:	75 b4                	jne    801058d8 <sys_exec+0x68>
      return -1;
  }
  return exec(path, argv);
}
80105924:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
80105927:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010592c:	5b                   	pop    %ebx
8010592d:	5e                   	pop    %esi
8010592e:	5f                   	pop    %edi
8010592f:	5d                   	pop    %ebp
80105930:	c3                   	ret    
80105931:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
80105938:	83 ec 08             	sub    $0x8,%esp
8010593b:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
      argv[i] = 0;
80105941:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105948:	00 00 00 00 
  return exec(path, argv);
8010594c:	50                   	push   %eax
8010594d:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
80105953:	e8 d8 b4 ff ff       	call   80100e30 <exec>
80105958:	83 c4 10             	add    $0x10,%esp
}
8010595b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010595e:	5b                   	pop    %ebx
8010595f:	5e                   	pop    %esi
80105960:	5f                   	pop    %edi
80105961:	5d                   	pop    %ebp
80105962:	c3                   	ret    
80105963:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010596a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105970 <sys_pipe>:

int
sys_pipe(void)
{
80105970:	f3 0f 1e fb          	endbr32 
80105974:	55                   	push   %ebp
80105975:	89 e5                	mov    %esp,%ebp
80105977:	57                   	push   %edi
80105978:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105979:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
8010597c:	53                   	push   %ebx
8010597d:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105980:	6a 08                	push   $0x8
80105982:	50                   	push   %eax
80105983:	6a 00                	push   $0x0
80105985:	e8 c6 f3 ff ff       	call   80104d50 <argptr>
8010598a:	83 c4 10             	add    $0x10,%esp
8010598d:	85 c0                	test   %eax,%eax
8010598f:	78 4e                	js     801059df <sys_pipe+0x6f>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105991:	83 ec 08             	sub    $0x8,%esp
80105994:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105997:	50                   	push   %eax
80105998:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010599b:	50                   	push   %eax
8010599c:	e8 ff dd ff ff       	call   801037a0 <pipealloc>
801059a1:	83 c4 10             	add    $0x10,%esp
801059a4:	85 c0                	test   %eax,%eax
801059a6:	78 37                	js     801059df <sys_pipe+0x6f>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801059a8:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
801059ab:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
801059ad:	e8 5e e3 ff ff       	call   80103d10 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801059b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[fd] == 0){
801059b8:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
801059bc:	85 f6                	test   %esi,%esi
801059be:	74 30                	je     801059f0 <sys_pipe+0x80>
  for(fd = 0; fd < NOFILE; fd++){
801059c0:	83 c3 01             	add    $0x1,%ebx
801059c3:	83 fb 10             	cmp    $0x10,%ebx
801059c6:	75 f0                	jne    801059b8 <sys_pipe+0x48>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
801059c8:	83 ec 0c             	sub    $0xc,%esp
801059cb:	ff 75 e0             	pushl  -0x20(%ebp)
801059ce:	e8 9d b8 ff ff       	call   80101270 <fileclose>
    fileclose(wf);
801059d3:	58                   	pop    %eax
801059d4:	ff 75 e4             	pushl  -0x1c(%ebp)
801059d7:	e8 94 b8 ff ff       	call   80101270 <fileclose>
    return -1;
801059dc:	83 c4 10             	add    $0x10,%esp
801059df:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801059e4:	eb 5b                	jmp    80105a41 <sys_pipe+0xd1>
801059e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801059ed:	8d 76 00             	lea    0x0(%esi),%esi
      curproc->ofile[fd] = f;
801059f0:	8d 73 08             	lea    0x8(%ebx),%esi
801059f3:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801059f7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
801059fa:	e8 11 e3 ff ff       	call   80103d10 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801059ff:	31 d2                	xor    %edx,%edx
80105a01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80105a08:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80105a0c:	85 c9                	test   %ecx,%ecx
80105a0e:	74 20                	je     80105a30 <sys_pipe+0xc0>
  for(fd = 0; fd < NOFILE; fd++){
80105a10:	83 c2 01             	add    $0x1,%edx
80105a13:	83 fa 10             	cmp    $0x10,%edx
80105a16:	75 f0                	jne    80105a08 <sys_pipe+0x98>
      myproc()->ofile[fd0] = 0;
80105a18:	e8 f3 e2 ff ff       	call   80103d10 <myproc>
80105a1d:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105a24:	00 
80105a25:	eb a1                	jmp    801059c8 <sys_pipe+0x58>
80105a27:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a2e:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
80105a30:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
  }
  fd[0] = fd0;
80105a34:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105a37:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105a39:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105a3c:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80105a3f:	31 c0                	xor    %eax,%eax
}
80105a41:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105a44:	5b                   	pop    %ebx
80105a45:	5e                   	pop    %esi
80105a46:	5f                   	pop    %edi
80105a47:	5d                   	pop    %ebp
80105a48:	c3                   	ret    
80105a49:	66 90                	xchg   %ax,%ax
80105a4b:	66 90                	xchg   %ax,%ax
80105a4d:	66 90                	xchg   %ax,%ax
80105a4f:	90                   	nop

80105a50 <sys_fork>:
80105a50:	f3 0f 1e fb          	endbr32 
80105a54:	e9 67 e4 ff ff       	jmp    80103ec0 <fork>
80105a59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105a60 <sys_exit>:
80105a60:	f3 0f 1e fb          	endbr32 
80105a64:	55                   	push   %ebp
80105a65:	89 e5                	mov    %esp,%ebp
80105a67:	83 ec 08             	sub    $0x8,%esp
80105a6a:	e8 d1 e6 ff ff       	call   80104140 <exit>
80105a6f:	31 c0                	xor    %eax,%eax
80105a71:	c9                   	leave  
80105a72:	c3                   	ret    
80105a73:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105a80 <sys_wait>:
80105a80:	f3 0f 1e fb          	endbr32 
80105a84:	e9 07 e9 ff ff       	jmp    80104390 <wait>
80105a89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105a90 <sys_kill>:
80105a90:	f3 0f 1e fb          	endbr32 
80105a94:	55                   	push   %ebp
80105a95:	89 e5                	mov    %esp,%ebp
80105a97:	83 ec 20             	sub    $0x20,%esp
80105a9a:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a9d:	50                   	push   %eax
80105a9e:	6a 00                	push   $0x0
80105aa0:	e8 5b f2 ff ff       	call   80104d00 <argint>
80105aa5:	83 c4 10             	add    $0x10,%esp
80105aa8:	85 c0                	test   %eax,%eax
80105aaa:	78 14                	js     80105ac0 <sys_kill+0x30>
80105aac:	83 ec 0c             	sub    $0xc,%esp
80105aaf:	ff 75 f4             	pushl  -0xc(%ebp)
80105ab2:	e8 39 ea ff ff       	call   801044f0 <kill>
80105ab7:	83 c4 10             	add    $0x10,%esp
80105aba:	c9                   	leave  
80105abb:	c3                   	ret    
80105abc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105ac0:	c9                   	leave  
80105ac1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ac6:	c3                   	ret    
80105ac7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105ace:	66 90                	xchg   %ax,%ax

80105ad0 <sys_getpid>:
80105ad0:	f3 0f 1e fb          	endbr32 
80105ad4:	55                   	push   %ebp
80105ad5:	89 e5                	mov    %esp,%ebp
80105ad7:	83 ec 08             	sub    $0x8,%esp
80105ada:	e8 31 e2 ff ff       	call   80103d10 <myproc>
80105adf:	8b 40 10             	mov    0x10(%eax),%eax
80105ae2:	c9                   	leave  
80105ae3:	c3                   	ret    
80105ae4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105aeb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105aef:	90                   	nop

80105af0 <sys_sbrk>:
80105af0:	f3 0f 1e fb          	endbr32 
80105af4:	55                   	push   %ebp
80105af5:	89 e5                	mov    %esp,%ebp
80105af7:	53                   	push   %ebx
80105af8:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105afb:	83 ec 1c             	sub    $0x1c,%esp
80105afe:	50                   	push   %eax
80105aff:	6a 00                	push   $0x0
80105b01:	e8 fa f1 ff ff       	call   80104d00 <argint>
80105b06:	83 c4 10             	add    $0x10,%esp
80105b09:	85 c0                	test   %eax,%eax
80105b0b:	78 23                	js     80105b30 <sys_sbrk+0x40>
80105b0d:	e8 fe e1 ff ff       	call   80103d10 <myproc>
80105b12:	83 ec 0c             	sub    $0xc,%esp
80105b15:	8b 18                	mov    (%eax),%ebx
80105b17:	ff 75 f4             	pushl  -0xc(%ebp)
80105b1a:	e8 21 e3 ff ff       	call   80103e40 <growproc>
80105b1f:	83 c4 10             	add    $0x10,%esp
80105b22:	85 c0                	test   %eax,%eax
80105b24:	78 0a                	js     80105b30 <sys_sbrk+0x40>
80105b26:	89 d8                	mov    %ebx,%eax
80105b28:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105b2b:	c9                   	leave  
80105b2c:	c3                   	ret    
80105b2d:	8d 76 00             	lea    0x0(%esi),%esi
80105b30:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105b35:	eb ef                	jmp    80105b26 <sys_sbrk+0x36>
80105b37:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105b3e:	66 90                	xchg   %ax,%ax

80105b40 <sys_sleep>:
80105b40:	f3 0f 1e fb          	endbr32 
80105b44:	55                   	push   %ebp
80105b45:	89 e5                	mov    %esp,%ebp
80105b47:	53                   	push   %ebx
80105b48:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105b4b:	83 ec 1c             	sub    $0x1c,%esp
80105b4e:	50                   	push   %eax
80105b4f:	6a 00                	push   $0x0
80105b51:	e8 aa f1 ff ff       	call   80104d00 <argint>
80105b56:	83 c4 10             	add    $0x10,%esp
80105b59:	85 c0                	test   %eax,%eax
80105b5b:	0f 88 86 00 00 00    	js     80105be7 <sys_sleep+0xa7>
80105b61:	83 ec 0c             	sub    $0xc,%esp
80105b64:	68 80 4c 11 80       	push   $0x80114c80
80105b69:	e8 a2 ed ff ff       	call   80104910 <acquire>
80105b6e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105b71:	8b 1d c0 54 11 80    	mov    0x801154c0,%ebx
80105b77:	83 c4 10             	add    $0x10,%esp
80105b7a:	85 d2                	test   %edx,%edx
80105b7c:	75 23                	jne    80105ba1 <sys_sleep+0x61>
80105b7e:	eb 50                	jmp    80105bd0 <sys_sleep+0x90>
80105b80:	83 ec 08             	sub    $0x8,%esp
80105b83:	68 80 4c 11 80       	push   $0x80114c80
80105b88:	68 c0 54 11 80       	push   $0x801154c0
80105b8d:	e8 3e e7 ff ff       	call   801042d0 <sleep>
80105b92:	a1 c0 54 11 80       	mov    0x801154c0,%eax
80105b97:	83 c4 10             	add    $0x10,%esp
80105b9a:	29 d8                	sub    %ebx,%eax
80105b9c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80105b9f:	73 2f                	jae    80105bd0 <sys_sleep+0x90>
80105ba1:	e8 6a e1 ff ff       	call   80103d10 <myproc>
80105ba6:	8b 40 24             	mov    0x24(%eax),%eax
80105ba9:	85 c0                	test   %eax,%eax
80105bab:	74 d3                	je     80105b80 <sys_sleep+0x40>
80105bad:	83 ec 0c             	sub    $0xc,%esp
80105bb0:	68 80 4c 11 80       	push   $0x80114c80
80105bb5:	e8 16 ee ff ff       	call   801049d0 <release>
80105bba:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105bbd:	83 c4 10             	add    $0x10,%esp
80105bc0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105bc5:	c9                   	leave  
80105bc6:	c3                   	ret    
80105bc7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105bce:	66 90                	xchg   %ax,%ax
80105bd0:	83 ec 0c             	sub    $0xc,%esp
80105bd3:	68 80 4c 11 80       	push   $0x80114c80
80105bd8:	e8 f3 ed ff ff       	call   801049d0 <release>
80105bdd:	83 c4 10             	add    $0x10,%esp
80105be0:	31 c0                	xor    %eax,%eax
80105be2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105be5:	c9                   	leave  
80105be6:	c3                   	ret    
80105be7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105bec:	eb f4                	jmp    80105be2 <sys_sleep+0xa2>
80105bee:	66 90                	xchg   %ax,%ax

80105bf0 <sys_uptime>:
80105bf0:	f3 0f 1e fb          	endbr32 
80105bf4:	55                   	push   %ebp
80105bf5:	89 e5                	mov    %esp,%ebp
80105bf7:	53                   	push   %ebx
80105bf8:	83 ec 10             	sub    $0x10,%esp
80105bfb:	68 80 4c 11 80       	push   $0x80114c80
80105c00:	e8 0b ed ff ff       	call   80104910 <acquire>
80105c05:	8b 1d c0 54 11 80    	mov    0x801154c0,%ebx
80105c0b:	c7 04 24 80 4c 11 80 	movl   $0x80114c80,(%esp)
80105c12:	e8 b9 ed ff ff       	call   801049d0 <release>
80105c17:	89 d8                	mov    %ebx,%eax
80105c19:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105c1c:	c9                   	leave  
80105c1d:	c3                   	ret    

80105c1e <alltraps>:
80105c1e:	1e                   	push   %ds
80105c1f:	06                   	push   %es
80105c20:	0f a0                	push   %fs
80105c22:	0f a8                	push   %gs
80105c24:	60                   	pusha  
80105c25:	66 b8 10 00          	mov    $0x10,%ax
80105c29:	8e d8                	mov    %eax,%ds
80105c2b:	8e c0                	mov    %eax,%es
80105c2d:	54                   	push   %esp
80105c2e:	e8 cd 00 00 00       	call   80105d00 <trap>
80105c33:	83 c4 04             	add    $0x4,%esp

80105c36 <trapret>:
80105c36:	61                   	popa   
80105c37:	0f a9                	pop    %gs
80105c39:	0f a1                	pop    %fs
80105c3b:	07                   	pop    %es
80105c3c:	1f                   	pop    %ds
80105c3d:	83 c4 08             	add    $0x8,%esp
80105c40:	cf                   	iret   
80105c41:	66 90                	xchg   %ax,%ax
80105c43:	66 90                	xchg   %ax,%ax
80105c45:	66 90                	xchg   %ax,%ax
80105c47:	66 90                	xchg   %ax,%ax
80105c49:	66 90                	xchg   %ax,%ax
80105c4b:	66 90                	xchg   %ax,%ax
80105c4d:	66 90                	xchg   %ax,%ax
80105c4f:	90                   	nop

80105c50 <tvinit>:
80105c50:	f3 0f 1e fb          	endbr32 
80105c54:	55                   	push   %ebp
80105c55:	31 c0                	xor    %eax,%eax
80105c57:	89 e5                	mov    %esp,%ebp
80105c59:	83 ec 08             	sub    $0x8,%esp
80105c5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105c60:	8b 14 85 08 a0 10 80 	mov    -0x7fef5ff8(,%eax,4),%edx
80105c67:	c7 04 c5 c2 4c 11 80 	movl   $0x8e000008,-0x7feeb33e(,%eax,8)
80105c6e:	08 00 00 8e 
80105c72:	66 89 14 c5 c0 4c 11 	mov    %dx,-0x7feeb340(,%eax,8)
80105c79:	80 
80105c7a:	c1 ea 10             	shr    $0x10,%edx
80105c7d:	66 89 14 c5 c6 4c 11 	mov    %dx,-0x7feeb33a(,%eax,8)
80105c84:	80 
80105c85:	83 c0 01             	add    $0x1,%eax
80105c88:	3d 00 01 00 00       	cmp    $0x100,%eax
80105c8d:	75 d1                	jne    80105c60 <tvinit+0x10>
80105c8f:	83 ec 08             	sub    $0x8,%esp
80105c92:	a1 08 a1 10 80       	mov    0x8010a108,%eax
80105c97:	c7 05 c2 4e 11 80 08 	movl   $0xef000008,0x80114ec2
80105c9e:	00 00 ef 
80105ca1:	68 79 7c 10 80       	push   $0x80107c79
80105ca6:	68 80 4c 11 80       	push   $0x80114c80
80105cab:	66 a3 c0 4e 11 80    	mov    %ax,0x80114ec0
80105cb1:	c1 e8 10             	shr    $0x10,%eax
80105cb4:	66 a3 c6 4e 11 80    	mov    %ax,0x80114ec6
80105cba:	e8 d1 ea ff ff       	call   80104790 <initlock>
80105cbf:	83 c4 10             	add    $0x10,%esp
80105cc2:	c9                   	leave  
80105cc3:	c3                   	ret    
80105cc4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105ccb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105ccf:	90                   	nop

80105cd0 <idtinit>:
80105cd0:	f3 0f 1e fb          	endbr32 
80105cd4:	55                   	push   %ebp
80105cd5:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105cda:	89 e5                	mov    %esp,%ebp
80105cdc:	83 ec 10             	sub    $0x10,%esp
80105cdf:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
80105ce3:	b8 c0 4c 11 80       	mov    $0x80114cc0,%eax
80105ce8:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
80105cec:	c1 e8 10             	shr    $0x10,%eax
80105cef:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
80105cf3:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105cf6:	0f 01 18             	lidtl  (%eax)
80105cf9:	c9                   	leave  
80105cfa:	c3                   	ret    
80105cfb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105cff:	90                   	nop

80105d00 <trap>:
80105d00:	f3 0f 1e fb          	endbr32 
80105d04:	55                   	push   %ebp
80105d05:	89 e5                	mov    %esp,%ebp
80105d07:	57                   	push   %edi
80105d08:	56                   	push   %esi
80105d09:	53                   	push   %ebx
80105d0a:	83 ec 1c             	sub    $0x1c,%esp
80105d0d:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105d10:	8b 43 30             	mov    0x30(%ebx),%eax
80105d13:	83 f8 40             	cmp    $0x40,%eax
80105d16:	0f 84 bc 01 00 00    	je     80105ed8 <trap+0x1d8>
80105d1c:	83 e8 20             	sub    $0x20,%eax
80105d1f:	83 f8 1f             	cmp    $0x1f,%eax
80105d22:	77 08                	ja     80105d2c <trap+0x2c>
80105d24:	3e ff 24 85 20 7d 10 	notrack jmp *-0x7fef82e0(,%eax,4)
80105d2b:	80 
80105d2c:	e8 df df ff ff       	call   80103d10 <myproc>
80105d31:	8b 7b 38             	mov    0x38(%ebx),%edi
80105d34:	85 c0                	test   %eax,%eax
80105d36:	0f 84 eb 01 00 00    	je     80105f27 <trap+0x227>
80105d3c:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80105d40:	0f 84 e1 01 00 00    	je     80105f27 <trap+0x227>
80105d46:	0f 20 d1             	mov    %cr2,%ecx
80105d49:	89 4d d8             	mov    %ecx,-0x28(%ebp)
80105d4c:	e8 9f df ff ff       	call   80103cf0 <cpuid>
80105d51:	8b 73 30             	mov    0x30(%ebx),%esi
80105d54:	89 45 dc             	mov    %eax,-0x24(%ebp)
80105d57:	8b 43 34             	mov    0x34(%ebx),%eax
80105d5a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80105d5d:	e8 ae df ff ff       	call   80103d10 <myproc>
80105d62:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105d65:	e8 a6 df ff ff       	call   80103d10 <myproc>
80105d6a:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105d6d:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105d70:	51                   	push   %ecx
80105d71:	57                   	push   %edi
80105d72:	52                   	push   %edx
80105d73:	ff 75 e4             	pushl  -0x1c(%ebp)
80105d76:	56                   	push   %esi
80105d77:	8b 75 e0             	mov    -0x20(%ebp),%esi
80105d7a:	83 c6 6c             	add    $0x6c,%esi
80105d7d:	56                   	push   %esi
80105d7e:	ff 70 10             	pushl  0x10(%eax)
80105d81:	68 dc 7c 10 80       	push   $0x80107cdc
80105d86:	e8 25 a9 ff ff       	call   801006b0 <cprintf>
80105d8b:	83 c4 20             	add    $0x20,%esp
80105d8e:	e8 7d df ff ff       	call   80103d10 <myproc>
80105d93:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80105d9a:	e8 71 df ff ff       	call   80103d10 <myproc>
80105d9f:	85 c0                	test   %eax,%eax
80105da1:	74 1d                	je     80105dc0 <trap+0xc0>
80105da3:	e8 68 df ff ff       	call   80103d10 <myproc>
80105da8:	8b 50 24             	mov    0x24(%eax),%edx
80105dab:	85 d2                	test   %edx,%edx
80105dad:	74 11                	je     80105dc0 <trap+0xc0>
80105daf:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105db3:	83 e0 03             	and    $0x3,%eax
80105db6:	66 83 f8 03          	cmp    $0x3,%ax
80105dba:	0f 84 50 01 00 00    	je     80105f10 <trap+0x210>
80105dc0:	e8 4b df ff ff       	call   80103d10 <myproc>
80105dc5:	85 c0                	test   %eax,%eax
80105dc7:	74 0f                	je     80105dd8 <trap+0xd8>
80105dc9:	e8 42 df ff ff       	call   80103d10 <myproc>
80105dce:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105dd2:	0f 84 e8 00 00 00    	je     80105ec0 <trap+0x1c0>
80105dd8:	e8 33 df ff ff       	call   80103d10 <myproc>
80105ddd:	85 c0                	test   %eax,%eax
80105ddf:	74 1d                	je     80105dfe <trap+0xfe>
80105de1:	e8 2a df ff ff       	call   80103d10 <myproc>
80105de6:	8b 40 24             	mov    0x24(%eax),%eax
80105de9:	85 c0                	test   %eax,%eax
80105deb:	74 11                	je     80105dfe <trap+0xfe>
80105ded:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105df1:	83 e0 03             	and    $0x3,%eax
80105df4:	66 83 f8 03          	cmp    $0x3,%ax
80105df8:	0f 84 03 01 00 00    	je     80105f01 <trap+0x201>
80105dfe:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105e01:	5b                   	pop    %ebx
80105e02:	5e                   	pop    %esi
80105e03:	5f                   	pop    %edi
80105e04:	5d                   	pop    %ebp
80105e05:	c3                   	ret    
80105e06:	e8 85 c7 ff ff       	call   80102590 <ideintr>
80105e0b:	e8 60 ce ff ff       	call   80102c70 <lapiceoi>
80105e10:	e8 fb de ff ff       	call   80103d10 <myproc>
80105e15:	85 c0                	test   %eax,%eax
80105e17:	75 8a                	jne    80105da3 <trap+0xa3>
80105e19:	eb a5                	jmp    80105dc0 <trap+0xc0>
80105e1b:	e8 d0 de ff ff       	call   80103cf0 <cpuid>
80105e20:	85 c0                	test   %eax,%eax
80105e22:	75 e7                	jne    80105e0b <trap+0x10b>
80105e24:	83 ec 0c             	sub    $0xc,%esp
80105e27:	68 80 4c 11 80       	push   $0x80114c80
80105e2c:	e8 df ea ff ff       	call   80104910 <acquire>
80105e31:	c7 04 24 c0 54 11 80 	movl   $0x801154c0,(%esp)
80105e38:	83 05 c0 54 11 80 01 	addl   $0x1,0x801154c0
80105e3f:	e8 4c e6 ff ff       	call   80104490 <wakeup>
80105e44:	c7 04 24 80 4c 11 80 	movl   $0x80114c80,(%esp)
80105e4b:	e8 80 eb ff ff       	call   801049d0 <release>
80105e50:	83 c4 10             	add    $0x10,%esp
80105e53:	eb b6                	jmp    80105e0b <trap+0x10b>
80105e55:	e8 d6 cc ff ff       	call   80102b30 <kbdintr>
80105e5a:	e8 11 ce ff ff       	call   80102c70 <lapiceoi>
80105e5f:	e8 ac de ff ff       	call   80103d10 <myproc>
80105e64:	85 c0                	test   %eax,%eax
80105e66:	0f 85 37 ff ff ff    	jne    80105da3 <trap+0xa3>
80105e6c:	e9 4f ff ff ff       	jmp    80105dc0 <trap+0xc0>
80105e71:	e8 4a 02 00 00       	call   801060c0 <uartintr>
80105e76:	e8 f5 cd ff ff       	call   80102c70 <lapiceoi>
80105e7b:	e8 90 de ff ff       	call   80103d10 <myproc>
80105e80:	85 c0                	test   %eax,%eax
80105e82:	0f 85 1b ff ff ff    	jne    80105da3 <trap+0xa3>
80105e88:	e9 33 ff ff ff       	jmp    80105dc0 <trap+0xc0>
80105e8d:	8b 7b 38             	mov    0x38(%ebx),%edi
80105e90:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80105e94:	e8 57 de ff ff       	call   80103cf0 <cpuid>
80105e99:	57                   	push   %edi
80105e9a:	56                   	push   %esi
80105e9b:	50                   	push   %eax
80105e9c:	68 84 7c 10 80       	push   $0x80107c84
80105ea1:	e8 0a a8 ff ff       	call   801006b0 <cprintf>
80105ea6:	e8 c5 cd ff ff       	call   80102c70 <lapiceoi>
80105eab:	83 c4 10             	add    $0x10,%esp
80105eae:	e8 5d de ff ff       	call   80103d10 <myproc>
80105eb3:	85 c0                	test   %eax,%eax
80105eb5:	0f 85 e8 fe ff ff    	jne    80105da3 <trap+0xa3>
80105ebb:	e9 00 ff ff ff       	jmp    80105dc0 <trap+0xc0>
80105ec0:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80105ec4:	0f 85 0e ff ff ff    	jne    80105dd8 <trap+0xd8>
80105eca:	e8 b1 e3 ff ff       	call   80104280 <yield>
80105ecf:	e9 04 ff ff ff       	jmp    80105dd8 <trap+0xd8>
80105ed4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105ed8:	e8 33 de ff ff       	call   80103d10 <myproc>
80105edd:	8b 70 24             	mov    0x24(%eax),%esi
80105ee0:	85 f6                	test   %esi,%esi
80105ee2:	75 3c                	jne    80105f20 <trap+0x220>
80105ee4:	e8 27 de ff ff       	call   80103d10 <myproc>
80105ee9:	89 58 18             	mov    %ebx,0x18(%eax)
80105eec:	e8 ff ee ff ff       	call   80104df0 <syscall>
80105ef1:	e8 1a de ff ff       	call   80103d10 <myproc>
80105ef6:	8b 48 24             	mov    0x24(%eax),%ecx
80105ef9:	85 c9                	test   %ecx,%ecx
80105efb:	0f 84 fd fe ff ff    	je     80105dfe <trap+0xfe>
80105f01:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105f04:	5b                   	pop    %ebx
80105f05:	5e                   	pop    %esi
80105f06:	5f                   	pop    %edi
80105f07:	5d                   	pop    %ebp
80105f08:	e9 33 e2 ff ff       	jmp    80104140 <exit>
80105f0d:	8d 76 00             	lea    0x0(%esi),%esi
80105f10:	e8 2b e2 ff ff       	call   80104140 <exit>
80105f15:	e9 a6 fe ff ff       	jmp    80105dc0 <trap+0xc0>
80105f1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105f20:	e8 1b e2 ff ff       	call   80104140 <exit>
80105f25:	eb bd                	jmp    80105ee4 <trap+0x1e4>
80105f27:	0f 20 d6             	mov    %cr2,%esi
80105f2a:	e8 c1 dd ff ff       	call   80103cf0 <cpuid>
80105f2f:	83 ec 0c             	sub    $0xc,%esp
80105f32:	56                   	push   %esi
80105f33:	57                   	push   %edi
80105f34:	50                   	push   %eax
80105f35:	ff 73 30             	pushl  0x30(%ebx)
80105f38:	68 a8 7c 10 80       	push   $0x80107ca8
80105f3d:	e8 6e a7 ff ff       	call   801006b0 <cprintf>
80105f42:	83 c4 14             	add    $0x14,%esp
80105f45:	68 7e 7c 10 80       	push   $0x80107c7e
80105f4a:	e8 41 a4 ff ff       	call   80100390 <panic>
80105f4f:	90                   	nop

80105f50 <uartgetc>:
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
80105f50:	f3 0f 1e fb          	endbr32 
  if(!uart)
80105f54:	a1 dc a5 10 80       	mov    0x8010a5dc,%eax
80105f59:	85 c0                	test   %eax,%eax
80105f5b:	74 1b                	je     80105f78 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105f5d:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105f62:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105f63:	a8 01                	test   $0x1,%al
80105f65:	74 11                	je     80105f78 <uartgetc+0x28>
80105f67:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105f6c:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105f6d:	0f b6 c0             	movzbl %al,%eax
80105f70:	c3                   	ret    
80105f71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105f78:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105f7d:	c3                   	ret    
80105f7e:	66 90                	xchg   %ax,%ax

80105f80 <uartputc.part.0>:
uartputc(int c)
80105f80:	55                   	push   %ebp
80105f81:	89 e5                	mov    %esp,%ebp
80105f83:	57                   	push   %edi
80105f84:	89 c7                	mov    %eax,%edi
80105f86:	56                   	push   %esi
80105f87:	be fd 03 00 00       	mov    $0x3fd,%esi
80105f8c:	53                   	push   %ebx
80105f8d:	bb 80 00 00 00       	mov    $0x80,%ebx
80105f92:	83 ec 0c             	sub    $0xc,%esp
80105f95:	eb 1b                	jmp    80105fb2 <uartputc.part.0+0x32>
80105f97:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f9e:	66 90                	xchg   %ax,%ax
    microdelay(10);
80105fa0:	83 ec 0c             	sub    $0xc,%esp
80105fa3:	6a 0a                	push   $0xa
80105fa5:	e8 e6 cc ff ff       	call   80102c90 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105faa:	83 c4 10             	add    $0x10,%esp
80105fad:	83 eb 01             	sub    $0x1,%ebx
80105fb0:	74 07                	je     80105fb9 <uartputc.part.0+0x39>
80105fb2:	89 f2                	mov    %esi,%edx
80105fb4:	ec                   	in     (%dx),%al
80105fb5:	a8 20                	test   $0x20,%al
80105fb7:	74 e7                	je     80105fa0 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105fb9:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105fbe:	89 f8                	mov    %edi,%eax
80105fc0:	ee                   	out    %al,(%dx)
}
80105fc1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105fc4:	5b                   	pop    %ebx
80105fc5:	5e                   	pop    %esi
80105fc6:	5f                   	pop    %edi
80105fc7:	5d                   	pop    %ebp
80105fc8:	c3                   	ret    
80105fc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105fd0 <uartinit>:
{
80105fd0:	f3 0f 1e fb          	endbr32 
80105fd4:	55                   	push   %ebp
80105fd5:	31 c9                	xor    %ecx,%ecx
80105fd7:	89 c8                	mov    %ecx,%eax
80105fd9:	89 e5                	mov    %esp,%ebp
80105fdb:	57                   	push   %edi
80105fdc:	56                   	push   %esi
80105fdd:	53                   	push   %ebx
80105fde:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80105fe3:	89 da                	mov    %ebx,%edx
80105fe5:	83 ec 0c             	sub    $0xc,%esp
80105fe8:	ee                   	out    %al,(%dx)
80105fe9:	bf fb 03 00 00       	mov    $0x3fb,%edi
80105fee:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105ff3:	89 fa                	mov    %edi,%edx
80105ff5:	ee                   	out    %al,(%dx)
80105ff6:	b8 0c 00 00 00       	mov    $0xc,%eax
80105ffb:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106000:	ee                   	out    %al,(%dx)
80106001:	be f9 03 00 00       	mov    $0x3f9,%esi
80106006:	89 c8                	mov    %ecx,%eax
80106008:	89 f2                	mov    %esi,%edx
8010600a:	ee                   	out    %al,(%dx)
8010600b:	b8 03 00 00 00       	mov    $0x3,%eax
80106010:	89 fa                	mov    %edi,%edx
80106012:	ee                   	out    %al,(%dx)
80106013:	ba fc 03 00 00       	mov    $0x3fc,%edx
80106018:	89 c8                	mov    %ecx,%eax
8010601a:	ee                   	out    %al,(%dx)
8010601b:	b8 01 00 00 00       	mov    $0x1,%eax
80106020:	89 f2                	mov    %esi,%edx
80106022:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106023:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106028:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80106029:	3c ff                	cmp    $0xff,%al
8010602b:	74 52                	je     8010607f <uartinit+0xaf>
  uart = 1;
8010602d:	c7 05 dc a5 10 80 01 	movl   $0x1,0x8010a5dc
80106034:	00 00 00 
80106037:	89 da                	mov    %ebx,%edx
80106039:	ec                   	in     (%dx),%al
8010603a:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010603f:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80106040:	83 ec 08             	sub    $0x8,%esp
80106043:	be 76 00 00 00       	mov    $0x76,%esi
  for(p="xv6...\n"; *p; p++)
80106048:	bb a0 7d 10 80       	mov    $0x80107da0,%ebx
  ioapicenable(IRQ_COM1, 0);
8010604d:	6a 00                	push   $0x0
8010604f:	6a 04                	push   $0x4
80106051:	e8 8a c7 ff ff       	call   801027e0 <ioapicenable>
80106056:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80106059:	b8 78 00 00 00       	mov    $0x78,%eax
8010605e:	eb 04                	jmp    80106064 <uartinit+0x94>
80106060:	0f b6 73 01          	movzbl 0x1(%ebx),%esi
  if(!uart)
80106064:	8b 15 dc a5 10 80    	mov    0x8010a5dc,%edx
8010606a:	85 d2                	test   %edx,%edx
8010606c:	74 08                	je     80106076 <uartinit+0xa6>
    uartputc(*p);
8010606e:	0f be c0             	movsbl %al,%eax
80106071:	e8 0a ff ff ff       	call   80105f80 <uartputc.part.0>
  for(p="xv6...\n"; *p; p++)
80106076:	89 f0                	mov    %esi,%eax
80106078:	83 c3 01             	add    $0x1,%ebx
8010607b:	84 c0                	test   %al,%al
8010607d:	75 e1                	jne    80106060 <uartinit+0x90>
}
8010607f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106082:	5b                   	pop    %ebx
80106083:	5e                   	pop    %esi
80106084:	5f                   	pop    %edi
80106085:	5d                   	pop    %ebp
80106086:	c3                   	ret    
80106087:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010608e:	66 90                	xchg   %ax,%ax

80106090 <uartputc>:
{
80106090:	f3 0f 1e fb          	endbr32 
80106094:	55                   	push   %ebp
  if(!uart)
80106095:	8b 15 dc a5 10 80    	mov    0x8010a5dc,%edx
{
8010609b:	89 e5                	mov    %esp,%ebp
8010609d:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
801060a0:	85 d2                	test   %edx,%edx
801060a2:	74 0c                	je     801060b0 <uartputc+0x20>
}
801060a4:	5d                   	pop    %ebp
801060a5:	e9 d6 fe ff ff       	jmp    80105f80 <uartputc.part.0>
801060aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801060b0:	5d                   	pop    %ebp
801060b1:	c3                   	ret    
801060b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801060b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801060c0 <uartintr>:

void
uartintr(void)
{
801060c0:	f3 0f 1e fb          	endbr32 
801060c4:	55                   	push   %ebp
801060c5:	89 e5                	mov    %esp,%ebp
801060c7:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
801060ca:	68 50 5f 10 80       	push   $0x80105f50
801060cf:	e8 ec a7 ff ff       	call   801008c0 <consoleintr>
}
801060d4:	83 c4 10             	add    $0x10,%esp
801060d7:	c9                   	leave  
801060d8:	c3                   	ret    

801060d9 <vector0>:
801060d9:	6a 00                	push   $0x0
801060db:	6a 00                	push   $0x0
801060dd:	e9 3c fb ff ff       	jmp    80105c1e <alltraps>

801060e2 <vector1>:
801060e2:	6a 00                	push   $0x0
801060e4:	6a 01                	push   $0x1
801060e6:	e9 33 fb ff ff       	jmp    80105c1e <alltraps>

801060eb <vector2>:
801060eb:	6a 00                	push   $0x0
801060ed:	6a 02                	push   $0x2
801060ef:	e9 2a fb ff ff       	jmp    80105c1e <alltraps>

801060f4 <vector3>:
801060f4:	6a 00                	push   $0x0
801060f6:	6a 03                	push   $0x3
801060f8:	e9 21 fb ff ff       	jmp    80105c1e <alltraps>

801060fd <vector4>:
801060fd:	6a 00                	push   $0x0
801060ff:	6a 04                	push   $0x4
80106101:	e9 18 fb ff ff       	jmp    80105c1e <alltraps>

80106106 <vector5>:
80106106:	6a 00                	push   $0x0
80106108:	6a 05                	push   $0x5
8010610a:	e9 0f fb ff ff       	jmp    80105c1e <alltraps>

8010610f <vector6>:
8010610f:	6a 00                	push   $0x0
80106111:	6a 06                	push   $0x6
80106113:	e9 06 fb ff ff       	jmp    80105c1e <alltraps>

80106118 <vector7>:
80106118:	6a 00                	push   $0x0
8010611a:	6a 07                	push   $0x7
8010611c:	e9 fd fa ff ff       	jmp    80105c1e <alltraps>

80106121 <vector8>:
80106121:	6a 08                	push   $0x8
80106123:	e9 f6 fa ff ff       	jmp    80105c1e <alltraps>

80106128 <vector9>:
80106128:	6a 00                	push   $0x0
8010612a:	6a 09                	push   $0x9
8010612c:	e9 ed fa ff ff       	jmp    80105c1e <alltraps>

80106131 <vector10>:
80106131:	6a 0a                	push   $0xa
80106133:	e9 e6 fa ff ff       	jmp    80105c1e <alltraps>

80106138 <vector11>:
80106138:	6a 0b                	push   $0xb
8010613a:	e9 df fa ff ff       	jmp    80105c1e <alltraps>

8010613f <vector12>:
8010613f:	6a 0c                	push   $0xc
80106141:	e9 d8 fa ff ff       	jmp    80105c1e <alltraps>

80106146 <vector13>:
80106146:	6a 0d                	push   $0xd
80106148:	e9 d1 fa ff ff       	jmp    80105c1e <alltraps>

8010614d <vector14>:
8010614d:	6a 0e                	push   $0xe
8010614f:	e9 ca fa ff ff       	jmp    80105c1e <alltraps>

80106154 <vector15>:
80106154:	6a 00                	push   $0x0
80106156:	6a 0f                	push   $0xf
80106158:	e9 c1 fa ff ff       	jmp    80105c1e <alltraps>

8010615d <vector16>:
8010615d:	6a 00                	push   $0x0
8010615f:	6a 10                	push   $0x10
80106161:	e9 b8 fa ff ff       	jmp    80105c1e <alltraps>

80106166 <vector17>:
80106166:	6a 11                	push   $0x11
80106168:	e9 b1 fa ff ff       	jmp    80105c1e <alltraps>

8010616d <vector18>:
8010616d:	6a 00                	push   $0x0
8010616f:	6a 12                	push   $0x12
80106171:	e9 a8 fa ff ff       	jmp    80105c1e <alltraps>

80106176 <vector19>:
80106176:	6a 00                	push   $0x0
80106178:	6a 13                	push   $0x13
8010617a:	e9 9f fa ff ff       	jmp    80105c1e <alltraps>

8010617f <vector20>:
8010617f:	6a 00                	push   $0x0
80106181:	6a 14                	push   $0x14
80106183:	e9 96 fa ff ff       	jmp    80105c1e <alltraps>

80106188 <vector21>:
80106188:	6a 00                	push   $0x0
8010618a:	6a 15                	push   $0x15
8010618c:	e9 8d fa ff ff       	jmp    80105c1e <alltraps>

80106191 <vector22>:
80106191:	6a 00                	push   $0x0
80106193:	6a 16                	push   $0x16
80106195:	e9 84 fa ff ff       	jmp    80105c1e <alltraps>

8010619a <vector23>:
8010619a:	6a 00                	push   $0x0
8010619c:	6a 17                	push   $0x17
8010619e:	e9 7b fa ff ff       	jmp    80105c1e <alltraps>

801061a3 <vector24>:
801061a3:	6a 00                	push   $0x0
801061a5:	6a 18                	push   $0x18
801061a7:	e9 72 fa ff ff       	jmp    80105c1e <alltraps>

801061ac <vector25>:
801061ac:	6a 00                	push   $0x0
801061ae:	6a 19                	push   $0x19
801061b0:	e9 69 fa ff ff       	jmp    80105c1e <alltraps>

801061b5 <vector26>:
801061b5:	6a 00                	push   $0x0
801061b7:	6a 1a                	push   $0x1a
801061b9:	e9 60 fa ff ff       	jmp    80105c1e <alltraps>

801061be <vector27>:
801061be:	6a 00                	push   $0x0
801061c0:	6a 1b                	push   $0x1b
801061c2:	e9 57 fa ff ff       	jmp    80105c1e <alltraps>

801061c7 <vector28>:
801061c7:	6a 00                	push   $0x0
801061c9:	6a 1c                	push   $0x1c
801061cb:	e9 4e fa ff ff       	jmp    80105c1e <alltraps>

801061d0 <vector29>:
801061d0:	6a 00                	push   $0x0
801061d2:	6a 1d                	push   $0x1d
801061d4:	e9 45 fa ff ff       	jmp    80105c1e <alltraps>

801061d9 <vector30>:
801061d9:	6a 00                	push   $0x0
801061db:	6a 1e                	push   $0x1e
801061dd:	e9 3c fa ff ff       	jmp    80105c1e <alltraps>

801061e2 <vector31>:
801061e2:	6a 00                	push   $0x0
801061e4:	6a 1f                	push   $0x1f
801061e6:	e9 33 fa ff ff       	jmp    80105c1e <alltraps>

801061eb <vector32>:
801061eb:	6a 00                	push   $0x0
801061ed:	6a 20                	push   $0x20
801061ef:	e9 2a fa ff ff       	jmp    80105c1e <alltraps>

801061f4 <vector33>:
801061f4:	6a 00                	push   $0x0
801061f6:	6a 21                	push   $0x21
801061f8:	e9 21 fa ff ff       	jmp    80105c1e <alltraps>

801061fd <vector34>:
801061fd:	6a 00                	push   $0x0
801061ff:	6a 22                	push   $0x22
80106201:	e9 18 fa ff ff       	jmp    80105c1e <alltraps>

80106206 <vector35>:
80106206:	6a 00                	push   $0x0
80106208:	6a 23                	push   $0x23
8010620a:	e9 0f fa ff ff       	jmp    80105c1e <alltraps>

8010620f <vector36>:
8010620f:	6a 00                	push   $0x0
80106211:	6a 24                	push   $0x24
80106213:	e9 06 fa ff ff       	jmp    80105c1e <alltraps>

80106218 <vector37>:
80106218:	6a 00                	push   $0x0
8010621a:	6a 25                	push   $0x25
8010621c:	e9 fd f9 ff ff       	jmp    80105c1e <alltraps>

80106221 <vector38>:
80106221:	6a 00                	push   $0x0
80106223:	6a 26                	push   $0x26
80106225:	e9 f4 f9 ff ff       	jmp    80105c1e <alltraps>

8010622a <vector39>:
8010622a:	6a 00                	push   $0x0
8010622c:	6a 27                	push   $0x27
8010622e:	e9 eb f9 ff ff       	jmp    80105c1e <alltraps>

80106233 <vector40>:
80106233:	6a 00                	push   $0x0
80106235:	6a 28                	push   $0x28
80106237:	e9 e2 f9 ff ff       	jmp    80105c1e <alltraps>

8010623c <vector41>:
8010623c:	6a 00                	push   $0x0
8010623e:	6a 29                	push   $0x29
80106240:	e9 d9 f9 ff ff       	jmp    80105c1e <alltraps>

80106245 <vector42>:
80106245:	6a 00                	push   $0x0
80106247:	6a 2a                	push   $0x2a
80106249:	e9 d0 f9 ff ff       	jmp    80105c1e <alltraps>

8010624e <vector43>:
8010624e:	6a 00                	push   $0x0
80106250:	6a 2b                	push   $0x2b
80106252:	e9 c7 f9 ff ff       	jmp    80105c1e <alltraps>

80106257 <vector44>:
80106257:	6a 00                	push   $0x0
80106259:	6a 2c                	push   $0x2c
8010625b:	e9 be f9 ff ff       	jmp    80105c1e <alltraps>

80106260 <vector45>:
80106260:	6a 00                	push   $0x0
80106262:	6a 2d                	push   $0x2d
80106264:	e9 b5 f9 ff ff       	jmp    80105c1e <alltraps>

80106269 <vector46>:
80106269:	6a 00                	push   $0x0
8010626b:	6a 2e                	push   $0x2e
8010626d:	e9 ac f9 ff ff       	jmp    80105c1e <alltraps>

80106272 <vector47>:
80106272:	6a 00                	push   $0x0
80106274:	6a 2f                	push   $0x2f
80106276:	e9 a3 f9 ff ff       	jmp    80105c1e <alltraps>

8010627b <vector48>:
8010627b:	6a 00                	push   $0x0
8010627d:	6a 30                	push   $0x30
8010627f:	e9 9a f9 ff ff       	jmp    80105c1e <alltraps>

80106284 <vector49>:
80106284:	6a 00                	push   $0x0
80106286:	6a 31                	push   $0x31
80106288:	e9 91 f9 ff ff       	jmp    80105c1e <alltraps>

8010628d <vector50>:
8010628d:	6a 00                	push   $0x0
8010628f:	6a 32                	push   $0x32
80106291:	e9 88 f9 ff ff       	jmp    80105c1e <alltraps>

80106296 <vector51>:
80106296:	6a 00                	push   $0x0
80106298:	6a 33                	push   $0x33
8010629a:	e9 7f f9 ff ff       	jmp    80105c1e <alltraps>

8010629f <vector52>:
8010629f:	6a 00                	push   $0x0
801062a1:	6a 34                	push   $0x34
801062a3:	e9 76 f9 ff ff       	jmp    80105c1e <alltraps>

801062a8 <vector53>:
801062a8:	6a 00                	push   $0x0
801062aa:	6a 35                	push   $0x35
801062ac:	e9 6d f9 ff ff       	jmp    80105c1e <alltraps>

801062b1 <vector54>:
801062b1:	6a 00                	push   $0x0
801062b3:	6a 36                	push   $0x36
801062b5:	e9 64 f9 ff ff       	jmp    80105c1e <alltraps>

801062ba <vector55>:
801062ba:	6a 00                	push   $0x0
801062bc:	6a 37                	push   $0x37
801062be:	e9 5b f9 ff ff       	jmp    80105c1e <alltraps>

801062c3 <vector56>:
801062c3:	6a 00                	push   $0x0
801062c5:	6a 38                	push   $0x38
801062c7:	e9 52 f9 ff ff       	jmp    80105c1e <alltraps>

801062cc <vector57>:
801062cc:	6a 00                	push   $0x0
801062ce:	6a 39                	push   $0x39
801062d0:	e9 49 f9 ff ff       	jmp    80105c1e <alltraps>

801062d5 <vector58>:
801062d5:	6a 00                	push   $0x0
801062d7:	6a 3a                	push   $0x3a
801062d9:	e9 40 f9 ff ff       	jmp    80105c1e <alltraps>

801062de <vector59>:
801062de:	6a 00                	push   $0x0
801062e0:	6a 3b                	push   $0x3b
801062e2:	e9 37 f9 ff ff       	jmp    80105c1e <alltraps>

801062e7 <vector60>:
801062e7:	6a 00                	push   $0x0
801062e9:	6a 3c                	push   $0x3c
801062eb:	e9 2e f9 ff ff       	jmp    80105c1e <alltraps>

801062f0 <vector61>:
801062f0:	6a 00                	push   $0x0
801062f2:	6a 3d                	push   $0x3d
801062f4:	e9 25 f9 ff ff       	jmp    80105c1e <alltraps>

801062f9 <vector62>:
801062f9:	6a 00                	push   $0x0
801062fb:	6a 3e                	push   $0x3e
801062fd:	e9 1c f9 ff ff       	jmp    80105c1e <alltraps>

80106302 <vector63>:
80106302:	6a 00                	push   $0x0
80106304:	6a 3f                	push   $0x3f
80106306:	e9 13 f9 ff ff       	jmp    80105c1e <alltraps>

8010630b <vector64>:
8010630b:	6a 00                	push   $0x0
8010630d:	6a 40                	push   $0x40
8010630f:	e9 0a f9 ff ff       	jmp    80105c1e <alltraps>

80106314 <vector65>:
80106314:	6a 00                	push   $0x0
80106316:	6a 41                	push   $0x41
80106318:	e9 01 f9 ff ff       	jmp    80105c1e <alltraps>

8010631d <vector66>:
8010631d:	6a 00                	push   $0x0
8010631f:	6a 42                	push   $0x42
80106321:	e9 f8 f8 ff ff       	jmp    80105c1e <alltraps>

80106326 <vector67>:
80106326:	6a 00                	push   $0x0
80106328:	6a 43                	push   $0x43
8010632a:	e9 ef f8 ff ff       	jmp    80105c1e <alltraps>

8010632f <vector68>:
8010632f:	6a 00                	push   $0x0
80106331:	6a 44                	push   $0x44
80106333:	e9 e6 f8 ff ff       	jmp    80105c1e <alltraps>

80106338 <vector69>:
80106338:	6a 00                	push   $0x0
8010633a:	6a 45                	push   $0x45
8010633c:	e9 dd f8 ff ff       	jmp    80105c1e <alltraps>

80106341 <vector70>:
80106341:	6a 00                	push   $0x0
80106343:	6a 46                	push   $0x46
80106345:	e9 d4 f8 ff ff       	jmp    80105c1e <alltraps>

8010634a <vector71>:
8010634a:	6a 00                	push   $0x0
8010634c:	6a 47                	push   $0x47
8010634e:	e9 cb f8 ff ff       	jmp    80105c1e <alltraps>

80106353 <vector72>:
80106353:	6a 00                	push   $0x0
80106355:	6a 48                	push   $0x48
80106357:	e9 c2 f8 ff ff       	jmp    80105c1e <alltraps>

8010635c <vector73>:
8010635c:	6a 00                	push   $0x0
8010635e:	6a 49                	push   $0x49
80106360:	e9 b9 f8 ff ff       	jmp    80105c1e <alltraps>

80106365 <vector74>:
80106365:	6a 00                	push   $0x0
80106367:	6a 4a                	push   $0x4a
80106369:	e9 b0 f8 ff ff       	jmp    80105c1e <alltraps>

8010636e <vector75>:
8010636e:	6a 00                	push   $0x0
80106370:	6a 4b                	push   $0x4b
80106372:	e9 a7 f8 ff ff       	jmp    80105c1e <alltraps>

80106377 <vector76>:
80106377:	6a 00                	push   $0x0
80106379:	6a 4c                	push   $0x4c
8010637b:	e9 9e f8 ff ff       	jmp    80105c1e <alltraps>

80106380 <vector77>:
80106380:	6a 00                	push   $0x0
80106382:	6a 4d                	push   $0x4d
80106384:	e9 95 f8 ff ff       	jmp    80105c1e <alltraps>

80106389 <vector78>:
80106389:	6a 00                	push   $0x0
8010638b:	6a 4e                	push   $0x4e
8010638d:	e9 8c f8 ff ff       	jmp    80105c1e <alltraps>

80106392 <vector79>:
80106392:	6a 00                	push   $0x0
80106394:	6a 4f                	push   $0x4f
80106396:	e9 83 f8 ff ff       	jmp    80105c1e <alltraps>

8010639b <vector80>:
8010639b:	6a 00                	push   $0x0
8010639d:	6a 50                	push   $0x50
8010639f:	e9 7a f8 ff ff       	jmp    80105c1e <alltraps>

801063a4 <vector81>:
801063a4:	6a 00                	push   $0x0
801063a6:	6a 51                	push   $0x51
801063a8:	e9 71 f8 ff ff       	jmp    80105c1e <alltraps>

801063ad <vector82>:
801063ad:	6a 00                	push   $0x0
801063af:	6a 52                	push   $0x52
801063b1:	e9 68 f8 ff ff       	jmp    80105c1e <alltraps>

801063b6 <vector83>:
801063b6:	6a 00                	push   $0x0
801063b8:	6a 53                	push   $0x53
801063ba:	e9 5f f8 ff ff       	jmp    80105c1e <alltraps>

801063bf <vector84>:
801063bf:	6a 00                	push   $0x0
801063c1:	6a 54                	push   $0x54
801063c3:	e9 56 f8 ff ff       	jmp    80105c1e <alltraps>

801063c8 <vector85>:
801063c8:	6a 00                	push   $0x0
801063ca:	6a 55                	push   $0x55
801063cc:	e9 4d f8 ff ff       	jmp    80105c1e <alltraps>

801063d1 <vector86>:
801063d1:	6a 00                	push   $0x0
801063d3:	6a 56                	push   $0x56
801063d5:	e9 44 f8 ff ff       	jmp    80105c1e <alltraps>

801063da <vector87>:
801063da:	6a 00                	push   $0x0
801063dc:	6a 57                	push   $0x57
801063de:	e9 3b f8 ff ff       	jmp    80105c1e <alltraps>

801063e3 <vector88>:
801063e3:	6a 00                	push   $0x0
801063e5:	6a 58                	push   $0x58
801063e7:	e9 32 f8 ff ff       	jmp    80105c1e <alltraps>

801063ec <vector89>:
801063ec:	6a 00                	push   $0x0
801063ee:	6a 59                	push   $0x59
801063f0:	e9 29 f8 ff ff       	jmp    80105c1e <alltraps>

801063f5 <vector90>:
801063f5:	6a 00                	push   $0x0
801063f7:	6a 5a                	push   $0x5a
801063f9:	e9 20 f8 ff ff       	jmp    80105c1e <alltraps>

801063fe <vector91>:
801063fe:	6a 00                	push   $0x0
80106400:	6a 5b                	push   $0x5b
80106402:	e9 17 f8 ff ff       	jmp    80105c1e <alltraps>

80106407 <vector92>:
80106407:	6a 00                	push   $0x0
80106409:	6a 5c                	push   $0x5c
8010640b:	e9 0e f8 ff ff       	jmp    80105c1e <alltraps>

80106410 <vector93>:
80106410:	6a 00                	push   $0x0
80106412:	6a 5d                	push   $0x5d
80106414:	e9 05 f8 ff ff       	jmp    80105c1e <alltraps>

80106419 <vector94>:
80106419:	6a 00                	push   $0x0
8010641b:	6a 5e                	push   $0x5e
8010641d:	e9 fc f7 ff ff       	jmp    80105c1e <alltraps>

80106422 <vector95>:
80106422:	6a 00                	push   $0x0
80106424:	6a 5f                	push   $0x5f
80106426:	e9 f3 f7 ff ff       	jmp    80105c1e <alltraps>

8010642b <vector96>:
8010642b:	6a 00                	push   $0x0
8010642d:	6a 60                	push   $0x60
8010642f:	e9 ea f7 ff ff       	jmp    80105c1e <alltraps>

80106434 <vector97>:
80106434:	6a 00                	push   $0x0
80106436:	6a 61                	push   $0x61
80106438:	e9 e1 f7 ff ff       	jmp    80105c1e <alltraps>

8010643d <vector98>:
8010643d:	6a 00                	push   $0x0
8010643f:	6a 62                	push   $0x62
80106441:	e9 d8 f7 ff ff       	jmp    80105c1e <alltraps>

80106446 <vector99>:
80106446:	6a 00                	push   $0x0
80106448:	6a 63                	push   $0x63
8010644a:	e9 cf f7 ff ff       	jmp    80105c1e <alltraps>

8010644f <vector100>:
8010644f:	6a 00                	push   $0x0
80106451:	6a 64                	push   $0x64
80106453:	e9 c6 f7 ff ff       	jmp    80105c1e <alltraps>

80106458 <vector101>:
80106458:	6a 00                	push   $0x0
8010645a:	6a 65                	push   $0x65
8010645c:	e9 bd f7 ff ff       	jmp    80105c1e <alltraps>

80106461 <vector102>:
80106461:	6a 00                	push   $0x0
80106463:	6a 66                	push   $0x66
80106465:	e9 b4 f7 ff ff       	jmp    80105c1e <alltraps>

8010646a <vector103>:
8010646a:	6a 00                	push   $0x0
8010646c:	6a 67                	push   $0x67
8010646e:	e9 ab f7 ff ff       	jmp    80105c1e <alltraps>

80106473 <vector104>:
80106473:	6a 00                	push   $0x0
80106475:	6a 68                	push   $0x68
80106477:	e9 a2 f7 ff ff       	jmp    80105c1e <alltraps>

8010647c <vector105>:
8010647c:	6a 00                	push   $0x0
8010647e:	6a 69                	push   $0x69
80106480:	e9 99 f7 ff ff       	jmp    80105c1e <alltraps>

80106485 <vector106>:
80106485:	6a 00                	push   $0x0
80106487:	6a 6a                	push   $0x6a
80106489:	e9 90 f7 ff ff       	jmp    80105c1e <alltraps>

8010648e <vector107>:
8010648e:	6a 00                	push   $0x0
80106490:	6a 6b                	push   $0x6b
80106492:	e9 87 f7 ff ff       	jmp    80105c1e <alltraps>

80106497 <vector108>:
80106497:	6a 00                	push   $0x0
80106499:	6a 6c                	push   $0x6c
8010649b:	e9 7e f7 ff ff       	jmp    80105c1e <alltraps>

801064a0 <vector109>:
801064a0:	6a 00                	push   $0x0
801064a2:	6a 6d                	push   $0x6d
801064a4:	e9 75 f7 ff ff       	jmp    80105c1e <alltraps>

801064a9 <vector110>:
801064a9:	6a 00                	push   $0x0
801064ab:	6a 6e                	push   $0x6e
801064ad:	e9 6c f7 ff ff       	jmp    80105c1e <alltraps>

801064b2 <vector111>:
801064b2:	6a 00                	push   $0x0
801064b4:	6a 6f                	push   $0x6f
801064b6:	e9 63 f7 ff ff       	jmp    80105c1e <alltraps>

801064bb <vector112>:
801064bb:	6a 00                	push   $0x0
801064bd:	6a 70                	push   $0x70
801064bf:	e9 5a f7 ff ff       	jmp    80105c1e <alltraps>

801064c4 <vector113>:
801064c4:	6a 00                	push   $0x0
801064c6:	6a 71                	push   $0x71
801064c8:	e9 51 f7 ff ff       	jmp    80105c1e <alltraps>

801064cd <vector114>:
801064cd:	6a 00                	push   $0x0
801064cf:	6a 72                	push   $0x72
801064d1:	e9 48 f7 ff ff       	jmp    80105c1e <alltraps>

801064d6 <vector115>:
801064d6:	6a 00                	push   $0x0
801064d8:	6a 73                	push   $0x73
801064da:	e9 3f f7 ff ff       	jmp    80105c1e <alltraps>

801064df <vector116>:
801064df:	6a 00                	push   $0x0
801064e1:	6a 74                	push   $0x74
801064e3:	e9 36 f7 ff ff       	jmp    80105c1e <alltraps>

801064e8 <vector117>:
801064e8:	6a 00                	push   $0x0
801064ea:	6a 75                	push   $0x75
801064ec:	e9 2d f7 ff ff       	jmp    80105c1e <alltraps>

801064f1 <vector118>:
801064f1:	6a 00                	push   $0x0
801064f3:	6a 76                	push   $0x76
801064f5:	e9 24 f7 ff ff       	jmp    80105c1e <alltraps>

801064fa <vector119>:
801064fa:	6a 00                	push   $0x0
801064fc:	6a 77                	push   $0x77
801064fe:	e9 1b f7 ff ff       	jmp    80105c1e <alltraps>

80106503 <vector120>:
80106503:	6a 00                	push   $0x0
80106505:	6a 78                	push   $0x78
80106507:	e9 12 f7 ff ff       	jmp    80105c1e <alltraps>

8010650c <vector121>:
8010650c:	6a 00                	push   $0x0
8010650e:	6a 79                	push   $0x79
80106510:	e9 09 f7 ff ff       	jmp    80105c1e <alltraps>

80106515 <vector122>:
80106515:	6a 00                	push   $0x0
80106517:	6a 7a                	push   $0x7a
80106519:	e9 00 f7 ff ff       	jmp    80105c1e <alltraps>

8010651e <vector123>:
8010651e:	6a 00                	push   $0x0
80106520:	6a 7b                	push   $0x7b
80106522:	e9 f7 f6 ff ff       	jmp    80105c1e <alltraps>

80106527 <vector124>:
80106527:	6a 00                	push   $0x0
80106529:	6a 7c                	push   $0x7c
8010652b:	e9 ee f6 ff ff       	jmp    80105c1e <alltraps>

80106530 <vector125>:
80106530:	6a 00                	push   $0x0
80106532:	6a 7d                	push   $0x7d
80106534:	e9 e5 f6 ff ff       	jmp    80105c1e <alltraps>

80106539 <vector126>:
80106539:	6a 00                	push   $0x0
8010653b:	6a 7e                	push   $0x7e
8010653d:	e9 dc f6 ff ff       	jmp    80105c1e <alltraps>

80106542 <vector127>:
80106542:	6a 00                	push   $0x0
80106544:	6a 7f                	push   $0x7f
80106546:	e9 d3 f6 ff ff       	jmp    80105c1e <alltraps>

8010654b <vector128>:
8010654b:	6a 00                	push   $0x0
8010654d:	68 80 00 00 00       	push   $0x80
80106552:	e9 c7 f6 ff ff       	jmp    80105c1e <alltraps>

80106557 <vector129>:
80106557:	6a 00                	push   $0x0
80106559:	68 81 00 00 00       	push   $0x81
8010655e:	e9 bb f6 ff ff       	jmp    80105c1e <alltraps>

80106563 <vector130>:
80106563:	6a 00                	push   $0x0
80106565:	68 82 00 00 00       	push   $0x82
8010656a:	e9 af f6 ff ff       	jmp    80105c1e <alltraps>

8010656f <vector131>:
8010656f:	6a 00                	push   $0x0
80106571:	68 83 00 00 00       	push   $0x83
80106576:	e9 a3 f6 ff ff       	jmp    80105c1e <alltraps>

8010657b <vector132>:
8010657b:	6a 00                	push   $0x0
8010657d:	68 84 00 00 00       	push   $0x84
80106582:	e9 97 f6 ff ff       	jmp    80105c1e <alltraps>

80106587 <vector133>:
80106587:	6a 00                	push   $0x0
80106589:	68 85 00 00 00       	push   $0x85
8010658e:	e9 8b f6 ff ff       	jmp    80105c1e <alltraps>

80106593 <vector134>:
80106593:	6a 00                	push   $0x0
80106595:	68 86 00 00 00       	push   $0x86
8010659a:	e9 7f f6 ff ff       	jmp    80105c1e <alltraps>

8010659f <vector135>:
8010659f:	6a 00                	push   $0x0
801065a1:	68 87 00 00 00       	push   $0x87
801065a6:	e9 73 f6 ff ff       	jmp    80105c1e <alltraps>

801065ab <vector136>:
801065ab:	6a 00                	push   $0x0
801065ad:	68 88 00 00 00       	push   $0x88
801065b2:	e9 67 f6 ff ff       	jmp    80105c1e <alltraps>

801065b7 <vector137>:
801065b7:	6a 00                	push   $0x0
801065b9:	68 89 00 00 00       	push   $0x89
801065be:	e9 5b f6 ff ff       	jmp    80105c1e <alltraps>

801065c3 <vector138>:
801065c3:	6a 00                	push   $0x0
801065c5:	68 8a 00 00 00       	push   $0x8a
801065ca:	e9 4f f6 ff ff       	jmp    80105c1e <alltraps>

801065cf <vector139>:
801065cf:	6a 00                	push   $0x0
801065d1:	68 8b 00 00 00       	push   $0x8b
801065d6:	e9 43 f6 ff ff       	jmp    80105c1e <alltraps>

801065db <vector140>:
801065db:	6a 00                	push   $0x0
801065dd:	68 8c 00 00 00       	push   $0x8c
801065e2:	e9 37 f6 ff ff       	jmp    80105c1e <alltraps>

801065e7 <vector141>:
801065e7:	6a 00                	push   $0x0
801065e9:	68 8d 00 00 00       	push   $0x8d
801065ee:	e9 2b f6 ff ff       	jmp    80105c1e <alltraps>

801065f3 <vector142>:
801065f3:	6a 00                	push   $0x0
801065f5:	68 8e 00 00 00       	push   $0x8e
801065fa:	e9 1f f6 ff ff       	jmp    80105c1e <alltraps>

801065ff <vector143>:
801065ff:	6a 00                	push   $0x0
80106601:	68 8f 00 00 00       	push   $0x8f
80106606:	e9 13 f6 ff ff       	jmp    80105c1e <alltraps>

8010660b <vector144>:
8010660b:	6a 00                	push   $0x0
8010660d:	68 90 00 00 00       	push   $0x90
80106612:	e9 07 f6 ff ff       	jmp    80105c1e <alltraps>

80106617 <vector145>:
80106617:	6a 00                	push   $0x0
80106619:	68 91 00 00 00       	push   $0x91
8010661e:	e9 fb f5 ff ff       	jmp    80105c1e <alltraps>

80106623 <vector146>:
80106623:	6a 00                	push   $0x0
80106625:	68 92 00 00 00       	push   $0x92
8010662a:	e9 ef f5 ff ff       	jmp    80105c1e <alltraps>

8010662f <vector147>:
8010662f:	6a 00                	push   $0x0
80106631:	68 93 00 00 00       	push   $0x93
80106636:	e9 e3 f5 ff ff       	jmp    80105c1e <alltraps>

8010663b <vector148>:
8010663b:	6a 00                	push   $0x0
8010663d:	68 94 00 00 00       	push   $0x94
80106642:	e9 d7 f5 ff ff       	jmp    80105c1e <alltraps>

80106647 <vector149>:
80106647:	6a 00                	push   $0x0
80106649:	68 95 00 00 00       	push   $0x95
8010664e:	e9 cb f5 ff ff       	jmp    80105c1e <alltraps>

80106653 <vector150>:
80106653:	6a 00                	push   $0x0
80106655:	68 96 00 00 00       	push   $0x96
8010665a:	e9 bf f5 ff ff       	jmp    80105c1e <alltraps>

8010665f <vector151>:
8010665f:	6a 00                	push   $0x0
80106661:	68 97 00 00 00       	push   $0x97
80106666:	e9 b3 f5 ff ff       	jmp    80105c1e <alltraps>

8010666b <vector152>:
8010666b:	6a 00                	push   $0x0
8010666d:	68 98 00 00 00       	push   $0x98
80106672:	e9 a7 f5 ff ff       	jmp    80105c1e <alltraps>

80106677 <vector153>:
80106677:	6a 00                	push   $0x0
80106679:	68 99 00 00 00       	push   $0x99
8010667e:	e9 9b f5 ff ff       	jmp    80105c1e <alltraps>

80106683 <vector154>:
80106683:	6a 00                	push   $0x0
80106685:	68 9a 00 00 00       	push   $0x9a
8010668a:	e9 8f f5 ff ff       	jmp    80105c1e <alltraps>

8010668f <vector155>:
8010668f:	6a 00                	push   $0x0
80106691:	68 9b 00 00 00       	push   $0x9b
80106696:	e9 83 f5 ff ff       	jmp    80105c1e <alltraps>

8010669b <vector156>:
8010669b:	6a 00                	push   $0x0
8010669d:	68 9c 00 00 00       	push   $0x9c
801066a2:	e9 77 f5 ff ff       	jmp    80105c1e <alltraps>

801066a7 <vector157>:
801066a7:	6a 00                	push   $0x0
801066a9:	68 9d 00 00 00       	push   $0x9d
801066ae:	e9 6b f5 ff ff       	jmp    80105c1e <alltraps>

801066b3 <vector158>:
801066b3:	6a 00                	push   $0x0
801066b5:	68 9e 00 00 00       	push   $0x9e
801066ba:	e9 5f f5 ff ff       	jmp    80105c1e <alltraps>

801066bf <vector159>:
801066bf:	6a 00                	push   $0x0
801066c1:	68 9f 00 00 00       	push   $0x9f
801066c6:	e9 53 f5 ff ff       	jmp    80105c1e <alltraps>

801066cb <vector160>:
801066cb:	6a 00                	push   $0x0
801066cd:	68 a0 00 00 00       	push   $0xa0
801066d2:	e9 47 f5 ff ff       	jmp    80105c1e <alltraps>

801066d7 <vector161>:
801066d7:	6a 00                	push   $0x0
801066d9:	68 a1 00 00 00       	push   $0xa1
801066de:	e9 3b f5 ff ff       	jmp    80105c1e <alltraps>

801066e3 <vector162>:
801066e3:	6a 00                	push   $0x0
801066e5:	68 a2 00 00 00       	push   $0xa2
801066ea:	e9 2f f5 ff ff       	jmp    80105c1e <alltraps>

801066ef <vector163>:
801066ef:	6a 00                	push   $0x0
801066f1:	68 a3 00 00 00       	push   $0xa3
801066f6:	e9 23 f5 ff ff       	jmp    80105c1e <alltraps>

801066fb <vector164>:
801066fb:	6a 00                	push   $0x0
801066fd:	68 a4 00 00 00       	push   $0xa4
80106702:	e9 17 f5 ff ff       	jmp    80105c1e <alltraps>

80106707 <vector165>:
80106707:	6a 00                	push   $0x0
80106709:	68 a5 00 00 00       	push   $0xa5
8010670e:	e9 0b f5 ff ff       	jmp    80105c1e <alltraps>

80106713 <vector166>:
80106713:	6a 00                	push   $0x0
80106715:	68 a6 00 00 00       	push   $0xa6
8010671a:	e9 ff f4 ff ff       	jmp    80105c1e <alltraps>

8010671f <vector167>:
8010671f:	6a 00                	push   $0x0
80106721:	68 a7 00 00 00       	push   $0xa7
80106726:	e9 f3 f4 ff ff       	jmp    80105c1e <alltraps>

8010672b <vector168>:
8010672b:	6a 00                	push   $0x0
8010672d:	68 a8 00 00 00       	push   $0xa8
80106732:	e9 e7 f4 ff ff       	jmp    80105c1e <alltraps>

80106737 <vector169>:
80106737:	6a 00                	push   $0x0
80106739:	68 a9 00 00 00       	push   $0xa9
8010673e:	e9 db f4 ff ff       	jmp    80105c1e <alltraps>

80106743 <vector170>:
80106743:	6a 00                	push   $0x0
80106745:	68 aa 00 00 00       	push   $0xaa
8010674a:	e9 cf f4 ff ff       	jmp    80105c1e <alltraps>

8010674f <vector171>:
8010674f:	6a 00                	push   $0x0
80106751:	68 ab 00 00 00       	push   $0xab
80106756:	e9 c3 f4 ff ff       	jmp    80105c1e <alltraps>

8010675b <vector172>:
8010675b:	6a 00                	push   $0x0
8010675d:	68 ac 00 00 00       	push   $0xac
80106762:	e9 b7 f4 ff ff       	jmp    80105c1e <alltraps>

80106767 <vector173>:
80106767:	6a 00                	push   $0x0
80106769:	68 ad 00 00 00       	push   $0xad
8010676e:	e9 ab f4 ff ff       	jmp    80105c1e <alltraps>

80106773 <vector174>:
80106773:	6a 00                	push   $0x0
80106775:	68 ae 00 00 00       	push   $0xae
8010677a:	e9 9f f4 ff ff       	jmp    80105c1e <alltraps>

8010677f <vector175>:
8010677f:	6a 00                	push   $0x0
80106781:	68 af 00 00 00       	push   $0xaf
80106786:	e9 93 f4 ff ff       	jmp    80105c1e <alltraps>

8010678b <vector176>:
8010678b:	6a 00                	push   $0x0
8010678d:	68 b0 00 00 00       	push   $0xb0
80106792:	e9 87 f4 ff ff       	jmp    80105c1e <alltraps>

80106797 <vector177>:
80106797:	6a 00                	push   $0x0
80106799:	68 b1 00 00 00       	push   $0xb1
8010679e:	e9 7b f4 ff ff       	jmp    80105c1e <alltraps>

801067a3 <vector178>:
801067a3:	6a 00                	push   $0x0
801067a5:	68 b2 00 00 00       	push   $0xb2
801067aa:	e9 6f f4 ff ff       	jmp    80105c1e <alltraps>

801067af <vector179>:
801067af:	6a 00                	push   $0x0
801067b1:	68 b3 00 00 00       	push   $0xb3
801067b6:	e9 63 f4 ff ff       	jmp    80105c1e <alltraps>

801067bb <vector180>:
801067bb:	6a 00                	push   $0x0
801067bd:	68 b4 00 00 00       	push   $0xb4
801067c2:	e9 57 f4 ff ff       	jmp    80105c1e <alltraps>

801067c7 <vector181>:
801067c7:	6a 00                	push   $0x0
801067c9:	68 b5 00 00 00       	push   $0xb5
801067ce:	e9 4b f4 ff ff       	jmp    80105c1e <alltraps>

801067d3 <vector182>:
801067d3:	6a 00                	push   $0x0
801067d5:	68 b6 00 00 00       	push   $0xb6
801067da:	e9 3f f4 ff ff       	jmp    80105c1e <alltraps>

801067df <vector183>:
801067df:	6a 00                	push   $0x0
801067e1:	68 b7 00 00 00       	push   $0xb7
801067e6:	e9 33 f4 ff ff       	jmp    80105c1e <alltraps>

801067eb <vector184>:
801067eb:	6a 00                	push   $0x0
801067ed:	68 b8 00 00 00       	push   $0xb8
801067f2:	e9 27 f4 ff ff       	jmp    80105c1e <alltraps>

801067f7 <vector185>:
801067f7:	6a 00                	push   $0x0
801067f9:	68 b9 00 00 00       	push   $0xb9
801067fe:	e9 1b f4 ff ff       	jmp    80105c1e <alltraps>

80106803 <vector186>:
80106803:	6a 00                	push   $0x0
80106805:	68 ba 00 00 00       	push   $0xba
8010680a:	e9 0f f4 ff ff       	jmp    80105c1e <alltraps>

8010680f <vector187>:
8010680f:	6a 00                	push   $0x0
80106811:	68 bb 00 00 00       	push   $0xbb
80106816:	e9 03 f4 ff ff       	jmp    80105c1e <alltraps>

8010681b <vector188>:
8010681b:	6a 00                	push   $0x0
8010681d:	68 bc 00 00 00       	push   $0xbc
80106822:	e9 f7 f3 ff ff       	jmp    80105c1e <alltraps>

80106827 <vector189>:
80106827:	6a 00                	push   $0x0
80106829:	68 bd 00 00 00       	push   $0xbd
8010682e:	e9 eb f3 ff ff       	jmp    80105c1e <alltraps>

80106833 <vector190>:
80106833:	6a 00                	push   $0x0
80106835:	68 be 00 00 00       	push   $0xbe
8010683a:	e9 df f3 ff ff       	jmp    80105c1e <alltraps>

8010683f <vector191>:
8010683f:	6a 00                	push   $0x0
80106841:	68 bf 00 00 00       	push   $0xbf
80106846:	e9 d3 f3 ff ff       	jmp    80105c1e <alltraps>

8010684b <vector192>:
8010684b:	6a 00                	push   $0x0
8010684d:	68 c0 00 00 00       	push   $0xc0
80106852:	e9 c7 f3 ff ff       	jmp    80105c1e <alltraps>

80106857 <vector193>:
80106857:	6a 00                	push   $0x0
80106859:	68 c1 00 00 00       	push   $0xc1
8010685e:	e9 bb f3 ff ff       	jmp    80105c1e <alltraps>

80106863 <vector194>:
80106863:	6a 00                	push   $0x0
80106865:	68 c2 00 00 00       	push   $0xc2
8010686a:	e9 af f3 ff ff       	jmp    80105c1e <alltraps>

8010686f <vector195>:
8010686f:	6a 00                	push   $0x0
80106871:	68 c3 00 00 00       	push   $0xc3
80106876:	e9 a3 f3 ff ff       	jmp    80105c1e <alltraps>

8010687b <vector196>:
8010687b:	6a 00                	push   $0x0
8010687d:	68 c4 00 00 00       	push   $0xc4
80106882:	e9 97 f3 ff ff       	jmp    80105c1e <alltraps>

80106887 <vector197>:
80106887:	6a 00                	push   $0x0
80106889:	68 c5 00 00 00       	push   $0xc5
8010688e:	e9 8b f3 ff ff       	jmp    80105c1e <alltraps>

80106893 <vector198>:
80106893:	6a 00                	push   $0x0
80106895:	68 c6 00 00 00       	push   $0xc6
8010689a:	e9 7f f3 ff ff       	jmp    80105c1e <alltraps>

8010689f <vector199>:
8010689f:	6a 00                	push   $0x0
801068a1:	68 c7 00 00 00       	push   $0xc7
801068a6:	e9 73 f3 ff ff       	jmp    80105c1e <alltraps>

801068ab <vector200>:
801068ab:	6a 00                	push   $0x0
801068ad:	68 c8 00 00 00       	push   $0xc8
801068b2:	e9 67 f3 ff ff       	jmp    80105c1e <alltraps>

801068b7 <vector201>:
801068b7:	6a 00                	push   $0x0
801068b9:	68 c9 00 00 00       	push   $0xc9
801068be:	e9 5b f3 ff ff       	jmp    80105c1e <alltraps>

801068c3 <vector202>:
801068c3:	6a 00                	push   $0x0
801068c5:	68 ca 00 00 00       	push   $0xca
801068ca:	e9 4f f3 ff ff       	jmp    80105c1e <alltraps>

801068cf <vector203>:
801068cf:	6a 00                	push   $0x0
801068d1:	68 cb 00 00 00       	push   $0xcb
801068d6:	e9 43 f3 ff ff       	jmp    80105c1e <alltraps>

801068db <vector204>:
801068db:	6a 00                	push   $0x0
801068dd:	68 cc 00 00 00       	push   $0xcc
801068e2:	e9 37 f3 ff ff       	jmp    80105c1e <alltraps>

801068e7 <vector205>:
801068e7:	6a 00                	push   $0x0
801068e9:	68 cd 00 00 00       	push   $0xcd
801068ee:	e9 2b f3 ff ff       	jmp    80105c1e <alltraps>

801068f3 <vector206>:
801068f3:	6a 00                	push   $0x0
801068f5:	68 ce 00 00 00       	push   $0xce
801068fa:	e9 1f f3 ff ff       	jmp    80105c1e <alltraps>

801068ff <vector207>:
801068ff:	6a 00                	push   $0x0
80106901:	68 cf 00 00 00       	push   $0xcf
80106906:	e9 13 f3 ff ff       	jmp    80105c1e <alltraps>

8010690b <vector208>:
8010690b:	6a 00                	push   $0x0
8010690d:	68 d0 00 00 00       	push   $0xd0
80106912:	e9 07 f3 ff ff       	jmp    80105c1e <alltraps>

80106917 <vector209>:
80106917:	6a 00                	push   $0x0
80106919:	68 d1 00 00 00       	push   $0xd1
8010691e:	e9 fb f2 ff ff       	jmp    80105c1e <alltraps>

80106923 <vector210>:
80106923:	6a 00                	push   $0x0
80106925:	68 d2 00 00 00       	push   $0xd2
8010692a:	e9 ef f2 ff ff       	jmp    80105c1e <alltraps>

8010692f <vector211>:
8010692f:	6a 00                	push   $0x0
80106931:	68 d3 00 00 00       	push   $0xd3
80106936:	e9 e3 f2 ff ff       	jmp    80105c1e <alltraps>

8010693b <vector212>:
8010693b:	6a 00                	push   $0x0
8010693d:	68 d4 00 00 00       	push   $0xd4
80106942:	e9 d7 f2 ff ff       	jmp    80105c1e <alltraps>

80106947 <vector213>:
80106947:	6a 00                	push   $0x0
80106949:	68 d5 00 00 00       	push   $0xd5
8010694e:	e9 cb f2 ff ff       	jmp    80105c1e <alltraps>

80106953 <vector214>:
80106953:	6a 00                	push   $0x0
80106955:	68 d6 00 00 00       	push   $0xd6
8010695a:	e9 bf f2 ff ff       	jmp    80105c1e <alltraps>

8010695f <vector215>:
8010695f:	6a 00                	push   $0x0
80106961:	68 d7 00 00 00       	push   $0xd7
80106966:	e9 b3 f2 ff ff       	jmp    80105c1e <alltraps>

8010696b <vector216>:
8010696b:	6a 00                	push   $0x0
8010696d:	68 d8 00 00 00       	push   $0xd8
80106972:	e9 a7 f2 ff ff       	jmp    80105c1e <alltraps>

80106977 <vector217>:
80106977:	6a 00                	push   $0x0
80106979:	68 d9 00 00 00       	push   $0xd9
8010697e:	e9 9b f2 ff ff       	jmp    80105c1e <alltraps>

80106983 <vector218>:
80106983:	6a 00                	push   $0x0
80106985:	68 da 00 00 00       	push   $0xda
8010698a:	e9 8f f2 ff ff       	jmp    80105c1e <alltraps>

8010698f <vector219>:
8010698f:	6a 00                	push   $0x0
80106991:	68 db 00 00 00       	push   $0xdb
80106996:	e9 83 f2 ff ff       	jmp    80105c1e <alltraps>

8010699b <vector220>:
8010699b:	6a 00                	push   $0x0
8010699d:	68 dc 00 00 00       	push   $0xdc
801069a2:	e9 77 f2 ff ff       	jmp    80105c1e <alltraps>

801069a7 <vector221>:
801069a7:	6a 00                	push   $0x0
801069a9:	68 dd 00 00 00       	push   $0xdd
801069ae:	e9 6b f2 ff ff       	jmp    80105c1e <alltraps>

801069b3 <vector222>:
801069b3:	6a 00                	push   $0x0
801069b5:	68 de 00 00 00       	push   $0xde
801069ba:	e9 5f f2 ff ff       	jmp    80105c1e <alltraps>

801069bf <vector223>:
801069bf:	6a 00                	push   $0x0
801069c1:	68 df 00 00 00       	push   $0xdf
801069c6:	e9 53 f2 ff ff       	jmp    80105c1e <alltraps>

801069cb <vector224>:
801069cb:	6a 00                	push   $0x0
801069cd:	68 e0 00 00 00       	push   $0xe0
801069d2:	e9 47 f2 ff ff       	jmp    80105c1e <alltraps>

801069d7 <vector225>:
801069d7:	6a 00                	push   $0x0
801069d9:	68 e1 00 00 00       	push   $0xe1
801069de:	e9 3b f2 ff ff       	jmp    80105c1e <alltraps>

801069e3 <vector226>:
801069e3:	6a 00                	push   $0x0
801069e5:	68 e2 00 00 00       	push   $0xe2
801069ea:	e9 2f f2 ff ff       	jmp    80105c1e <alltraps>

801069ef <vector227>:
801069ef:	6a 00                	push   $0x0
801069f1:	68 e3 00 00 00       	push   $0xe3
801069f6:	e9 23 f2 ff ff       	jmp    80105c1e <alltraps>

801069fb <vector228>:
801069fb:	6a 00                	push   $0x0
801069fd:	68 e4 00 00 00       	push   $0xe4
80106a02:	e9 17 f2 ff ff       	jmp    80105c1e <alltraps>

80106a07 <vector229>:
80106a07:	6a 00                	push   $0x0
80106a09:	68 e5 00 00 00       	push   $0xe5
80106a0e:	e9 0b f2 ff ff       	jmp    80105c1e <alltraps>

80106a13 <vector230>:
80106a13:	6a 00                	push   $0x0
80106a15:	68 e6 00 00 00       	push   $0xe6
80106a1a:	e9 ff f1 ff ff       	jmp    80105c1e <alltraps>

80106a1f <vector231>:
80106a1f:	6a 00                	push   $0x0
80106a21:	68 e7 00 00 00       	push   $0xe7
80106a26:	e9 f3 f1 ff ff       	jmp    80105c1e <alltraps>

80106a2b <vector232>:
80106a2b:	6a 00                	push   $0x0
80106a2d:	68 e8 00 00 00       	push   $0xe8
80106a32:	e9 e7 f1 ff ff       	jmp    80105c1e <alltraps>

80106a37 <vector233>:
80106a37:	6a 00                	push   $0x0
80106a39:	68 e9 00 00 00       	push   $0xe9
80106a3e:	e9 db f1 ff ff       	jmp    80105c1e <alltraps>

80106a43 <vector234>:
80106a43:	6a 00                	push   $0x0
80106a45:	68 ea 00 00 00       	push   $0xea
80106a4a:	e9 cf f1 ff ff       	jmp    80105c1e <alltraps>

80106a4f <vector235>:
80106a4f:	6a 00                	push   $0x0
80106a51:	68 eb 00 00 00       	push   $0xeb
80106a56:	e9 c3 f1 ff ff       	jmp    80105c1e <alltraps>

80106a5b <vector236>:
80106a5b:	6a 00                	push   $0x0
80106a5d:	68 ec 00 00 00       	push   $0xec
80106a62:	e9 b7 f1 ff ff       	jmp    80105c1e <alltraps>

80106a67 <vector237>:
80106a67:	6a 00                	push   $0x0
80106a69:	68 ed 00 00 00       	push   $0xed
80106a6e:	e9 ab f1 ff ff       	jmp    80105c1e <alltraps>

80106a73 <vector238>:
80106a73:	6a 00                	push   $0x0
80106a75:	68 ee 00 00 00       	push   $0xee
80106a7a:	e9 9f f1 ff ff       	jmp    80105c1e <alltraps>

80106a7f <vector239>:
80106a7f:	6a 00                	push   $0x0
80106a81:	68 ef 00 00 00       	push   $0xef
80106a86:	e9 93 f1 ff ff       	jmp    80105c1e <alltraps>

80106a8b <vector240>:
80106a8b:	6a 00                	push   $0x0
80106a8d:	68 f0 00 00 00       	push   $0xf0
80106a92:	e9 87 f1 ff ff       	jmp    80105c1e <alltraps>

80106a97 <vector241>:
80106a97:	6a 00                	push   $0x0
80106a99:	68 f1 00 00 00       	push   $0xf1
80106a9e:	e9 7b f1 ff ff       	jmp    80105c1e <alltraps>

80106aa3 <vector242>:
80106aa3:	6a 00                	push   $0x0
80106aa5:	68 f2 00 00 00       	push   $0xf2
80106aaa:	e9 6f f1 ff ff       	jmp    80105c1e <alltraps>

80106aaf <vector243>:
80106aaf:	6a 00                	push   $0x0
80106ab1:	68 f3 00 00 00       	push   $0xf3
80106ab6:	e9 63 f1 ff ff       	jmp    80105c1e <alltraps>

80106abb <vector244>:
80106abb:	6a 00                	push   $0x0
80106abd:	68 f4 00 00 00       	push   $0xf4
80106ac2:	e9 57 f1 ff ff       	jmp    80105c1e <alltraps>

80106ac7 <vector245>:
80106ac7:	6a 00                	push   $0x0
80106ac9:	68 f5 00 00 00       	push   $0xf5
80106ace:	e9 4b f1 ff ff       	jmp    80105c1e <alltraps>

80106ad3 <vector246>:
80106ad3:	6a 00                	push   $0x0
80106ad5:	68 f6 00 00 00       	push   $0xf6
80106ada:	e9 3f f1 ff ff       	jmp    80105c1e <alltraps>

80106adf <vector247>:
80106adf:	6a 00                	push   $0x0
80106ae1:	68 f7 00 00 00       	push   $0xf7
80106ae6:	e9 33 f1 ff ff       	jmp    80105c1e <alltraps>

80106aeb <vector248>:
80106aeb:	6a 00                	push   $0x0
80106aed:	68 f8 00 00 00       	push   $0xf8
80106af2:	e9 27 f1 ff ff       	jmp    80105c1e <alltraps>

80106af7 <vector249>:
80106af7:	6a 00                	push   $0x0
80106af9:	68 f9 00 00 00       	push   $0xf9
80106afe:	e9 1b f1 ff ff       	jmp    80105c1e <alltraps>

80106b03 <vector250>:
80106b03:	6a 00                	push   $0x0
80106b05:	68 fa 00 00 00       	push   $0xfa
80106b0a:	e9 0f f1 ff ff       	jmp    80105c1e <alltraps>

80106b0f <vector251>:
80106b0f:	6a 00                	push   $0x0
80106b11:	68 fb 00 00 00       	push   $0xfb
80106b16:	e9 03 f1 ff ff       	jmp    80105c1e <alltraps>

80106b1b <vector252>:
80106b1b:	6a 00                	push   $0x0
80106b1d:	68 fc 00 00 00       	push   $0xfc
80106b22:	e9 f7 f0 ff ff       	jmp    80105c1e <alltraps>

80106b27 <vector253>:
80106b27:	6a 00                	push   $0x0
80106b29:	68 fd 00 00 00       	push   $0xfd
80106b2e:	e9 eb f0 ff ff       	jmp    80105c1e <alltraps>

80106b33 <vector254>:
80106b33:	6a 00                	push   $0x0
80106b35:	68 fe 00 00 00       	push   $0xfe
80106b3a:	e9 df f0 ff ff       	jmp    80105c1e <alltraps>

80106b3f <vector255>:
80106b3f:	6a 00                	push   $0x0
80106b41:	68 ff 00 00 00       	push   $0xff
80106b46:	e9 d3 f0 ff ff       	jmp    80105c1e <alltraps>
80106b4b:	66 90                	xchg   %ax,%ax
80106b4d:	66 90                	xchg   %ax,%ax
80106b4f:	90                   	nop

80106b50 <walkpgdir>:
80106b50:	55                   	push   %ebp
80106b51:	89 e5                	mov    %esp,%ebp
80106b53:	57                   	push   %edi
80106b54:	56                   	push   %esi
80106b55:	89 d6                	mov    %edx,%esi
80106b57:	c1 ea 16             	shr    $0x16,%edx
80106b5a:	53                   	push   %ebx
80106b5b:	8d 3c 90             	lea    (%eax,%edx,4),%edi
80106b5e:	83 ec 0c             	sub    $0xc,%esp
80106b61:	8b 1f                	mov    (%edi),%ebx
80106b63:	f6 c3 01             	test   $0x1,%bl
80106b66:	74 28                	je     80106b90 <walkpgdir+0x40>
80106b68:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80106b6e:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
80106b74:	89 f0                	mov    %esi,%eax
80106b76:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106b79:	c1 e8 0a             	shr    $0xa,%eax
80106b7c:	25 fc 0f 00 00       	and    $0xffc,%eax
80106b81:	01 d8                	add    %ebx,%eax
80106b83:	5b                   	pop    %ebx
80106b84:	5e                   	pop    %esi
80106b85:	5f                   	pop    %edi
80106b86:	5d                   	pop    %ebp
80106b87:	c3                   	ret    
80106b88:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106b8f:	90                   	nop
80106b90:	85 c9                	test   %ecx,%ecx
80106b92:	74 2c                	je     80106bc0 <walkpgdir+0x70>
80106b94:	e8 47 be ff ff       	call   801029e0 <kalloc>
80106b99:	89 c3                	mov    %eax,%ebx
80106b9b:	85 c0                	test   %eax,%eax
80106b9d:	74 21                	je     80106bc0 <walkpgdir+0x70>
80106b9f:	83 ec 04             	sub    $0x4,%esp
80106ba2:	68 00 10 00 00       	push   $0x1000
80106ba7:	6a 00                	push   $0x0
80106ba9:	50                   	push   %eax
80106baa:	e8 71 de ff ff       	call   80104a20 <memset>
80106baf:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106bb5:	83 c4 10             	add    $0x10,%esp
80106bb8:	83 c8 07             	or     $0x7,%eax
80106bbb:	89 07                	mov    %eax,(%edi)
80106bbd:	eb b5                	jmp    80106b74 <walkpgdir+0x24>
80106bbf:	90                   	nop
80106bc0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106bc3:	31 c0                	xor    %eax,%eax
80106bc5:	5b                   	pop    %ebx
80106bc6:	5e                   	pop    %esi
80106bc7:	5f                   	pop    %edi
80106bc8:	5d                   	pop    %ebp
80106bc9:	c3                   	ret    
80106bca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106bd0 <mappages>:
80106bd0:	55                   	push   %ebp
80106bd1:	89 e5                	mov    %esp,%ebp
80106bd3:	57                   	push   %edi
80106bd4:	89 c7                	mov    %eax,%edi
80106bd6:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106bda:	56                   	push   %esi
80106bdb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106be0:	89 d6                	mov    %edx,%esi
80106be2:	53                   	push   %ebx
80106be3:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
80106be9:	83 ec 1c             	sub    $0x1c,%esp
80106bec:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106bef:	8b 45 08             	mov    0x8(%ebp),%eax
80106bf2:	29 f0                	sub    %esi,%eax
80106bf4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106bf7:	eb 1f                	jmp    80106c18 <mappages+0x48>
80106bf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106c00:	f6 00 01             	testb  $0x1,(%eax)
80106c03:	75 45                	jne    80106c4a <mappages+0x7a>
80106c05:	0b 5d 0c             	or     0xc(%ebp),%ebx
80106c08:	83 cb 01             	or     $0x1,%ebx
80106c0b:	89 18                	mov    %ebx,(%eax)
80106c0d:	3b 75 e0             	cmp    -0x20(%ebp),%esi
80106c10:	74 2e                	je     80106c40 <mappages+0x70>
80106c12:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106c18:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106c1b:	b9 01 00 00 00       	mov    $0x1,%ecx
80106c20:	89 f2                	mov    %esi,%edx
80106c22:	8d 1c 06             	lea    (%esi,%eax,1),%ebx
80106c25:	89 f8                	mov    %edi,%eax
80106c27:	e8 24 ff ff ff       	call   80106b50 <walkpgdir>
80106c2c:	85 c0                	test   %eax,%eax
80106c2e:	75 d0                	jne    80106c00 <mappages+0x30>
80106c30:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106c33:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106c38:	5b                   	pop    %ebx
80106c39:	5e                   	pop    %esi
80106c3a:	5f                   	pop    %edi
80106c3b:	5d                   	pop    %ebp
80106c3c:	c3                   	ret    
80106c3d:	8d 76 00             	lea    0x0(%esi),%esi
80106c40:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106c43:	31 c0                	xor    %eax,%eax
80106c45:	5b                   	pop    %ebx
80106c46:	5e                   	pop    %esi
80106c47:	5f                   	pop    %edi
80106c48:	5d                   	pop    %ebp
80106c49:	c3                   	ret    
80106c4a:	83 ec 0c             	sub    $0xc,%esp
80106c4d:	68 a8 7d 10 80       	push   $0x80107da8
80106c52:	e8 39 97 ff ff       	call   80100390 <panic>
80106c57:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106c5e:	66 90                	xchg   %ax,%ax

80106c60 <deallocuvm.part.0>:
80106c60:	55                   	push   %ebp
80106c61:	89 e5                	mov    %esp,%ebp
80106c63:	57                   	push   %edi
80106c64:	56                   	push   %esi
80106c65:	89 c6                	mov    %eax,%esi
80106c67:	53                   	push   %ebx
80106c68:	89 d3                	mov    %edx,%ebx
80106c6a:	8d 91 ff 0f 00 00    	lea    0xfff(%ecx),%edx
80106c70:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106c76:	83 ec 1c             	sub    $0x1c,%esp
80106c79:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80106c7c:	39 da                	cmp    %ebx,%edx
80106c7e:	73 5b                	jae    80106cdb <deallocuvm.part.0+0x7b>
80106c80:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80106c83:	89 d7                	mov    %edx,%edi
80106c85:	eb 14                	jmp    80106c9b <deallocuvm.part.0+0x3b>
80106c87:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106c8e:	66 90                	xchg   %ax,%ax
80106c90:	81 c7 00 10 00 00    	add    $0x1000,%edi
80106c96:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80106c99:	76 40                	jbe    80106cdb <deallocuvm.part.0+0x7b>
80106c9b:	31 c9                	xor    %ecx,%ecx
80106c9d:	89 fa                	mov    %edi,%edx
80106c9f:	89 f0                	mov    %esi,%eax
80106ca1:	e8 aa fe ff ff       	call   80106b50 <walkpgdir>
80106ca6:	89 c3                	mov    %eax,%ebx
80106ca8:	85 c0                	test   %eax,%eax
80106caa:	74 44                	je     80106cf0 <deallocuvm.part.0+0x90>
80106cac:	8b 00                	mov    (%eax),%eax
80106cae:	a8 01                	test   $0x1,%al
80106cb0:	74 de                	je     80106c90 <deallocuvm.part.0+0x30>
80106cb2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106cb7:	74 47                	je     80106d00 <deallocuvm.part.0+0xa0>
80106cb9:	83 ec 0c             	sub    $0xc,%esp
80106cbc:	05 00 00 00 80       	add    $0x80000000,%eax
80106cc1:	81 c7 00 10 00 00    	add    $0x1000,%edi
80106cc7:	50                   	push   %eax
80106cc8:	e8 53 bb ff ff       	call   80102820 <kfree>
80106ccd:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80106cd3:	83 c4 10             	add    $0x10,%esp
80106cd6:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80106cd9:	77 c0                	ja     80106c9b <deallocuvm.part.0+0x3b>
80106cdb:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106cde:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106ce1:	5b                   	pop    %ebx
80106ce2:	5e                   	pop    %esi
80106ce3:	5f                   	pop    %edi
80106ce4:	5d                   	pop    %ebp
80106ce5:	c3                   	ret    
80106ce6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106ced:	8d 76 00             	lea    0x0(%esi),%esi
80106cf0:	89 fa                	mov    %edi,%edx
80106cf2:	81 e2 00 00 c0 ff    	and    $0xffc00000,%edx
80106cf8:	8d ba 00 00 40 00    	lea    0x400000(%edx),%edi
80106cfe:	eb 96                	jmp    80106c96 <deallocuvm.part.0+0x36>
80106d00:	83 ec 0c             	sub    $0xc,%esp
80106d03:	68 5e 77 10 80       	push   $0x8010775e
80106d08:	e8 83 96 ff ff       	call   80100390 <panic>
80106d0d:	8d 76 00             	lea    0x0(%esi),%esi

80106d10 <seginit>:
80106d10:	f3 0f 1e fb          	endbr32 
80106d14:	55                   	push   %ebp
80106d15:	89 e5                	mov    %esp,%ebp
80106d17:	83 ec 18             	sub    $0x18,%esp
80106d1a:	e8 d1 cf ff ff       	call   80103cf0 <cpuid>
80106d1f:	ba 2f 00 00 00       	mov    $0x2f,%edx
80106d24:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80106d2a:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
80106d2e:	c7 80 18 28 11 80 ff 	movl   $0xffff,-0x7feed7e8(%eax)
80106d35:	ff 00 00 
80106d38:	c7 80 1c 28 11 80 00 	movl   $0xcf9a00,-0x7feed7e4(%eax)
80106d3f:	9a cf 00 
80106d42:	c7 80 20 28 11 80 ff 	movl   $0xffff,-0x7feed7e0(%eax)
80106d49:	ff 00 00 
80106d4c:	c7 80 24 28 11 80 00 	movl   $0xcf9200,-0x7feed7dc(%eax)
80106d53:	92 cf 00 
80106d56:	c7 80 28 28 11 80 ff 	movl   $0xffff,-0x7feed7d8(%eax)
80106d5d:	ff 00 00 
80106d60:	c7 80 2c 28 11 80 00 	movl   $0xcffa00,-0x7feed7d4(%eax)
80106d67:	fa cf 00 
80106d6a:	c7 80 30 28 11 80 ff 	movl   $0xffff,-0x7feed7d0(%eax)
80106d71:	ff 00 00 
80106d74:	c7 80 34 28 11 80 00 	movl   $0xcff200,-0x7feed7cc(%eax)
80106d7b:	f2 cf 00 
80106d7e:	05 10 28 11 80       	add    $0x80112810,%eax
80106d83:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
80106d87:	c1 e8 10             	shr    $0x10,%eax
80106d8a:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
80106d8e:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106d91:	0f 01 10             	lgdtl  (%eax)
80106d94:	c9                   	leave  
80106d95:	c3                   	ret    
80106d96:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106d9d:	8d 76 00             	lea    0x0(%esi),%esi

80106da0 <switchkvm>:
80106da0:	f3 0f 1e fb          	endbr32 
80106da4:	a1 c4 54 11 80       	mov    0x801154c4,%eax
80106da9:	05 00 00 00 80       	add    $0x80000000,%eax
80106dae:	0f 22 d8             	mov    %eax,%cr3
80106db1:	c3                   	ret    
80106db2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106db9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106dc0 <switchuvm>:
80106dc0:	f3 0f 1e fb          	endbr32 
80106dc4:	55                   	push   %ebp
80106dc5:	89 e5                	mov    %esp,%ebp
80106dc7:	57                   	push   %edi
80106dc8:	56                   	push   %esi
80106dc9:	53                   	push   %ebx
80106dca:	83 ec 1c             	sub    $0x1c,%esp
80106dcd:	8b 75 08             	mov    0x8(%ebp),%esi
80106dd0:	85 f6                	test   %esi,%esi
80106dd2:	0f 84 cb 00 00 00    	je     80106ea3 <switchuvm+0xe3>
80106dd8:	8b 46 08             	mov    0x8(%esi),%eax
80106ddb:	85 c0                	test   %eax,%eax
80106ddd:	0f 84 da 00 00 00    	je     80106ebd <switchuvm+0xfd>
80106de3:	8b 46 04             	mov    0x4(%esi),%eax
80106de6:	85 c0                	test   %eax,%eax
80106de8:	0f 84 c2 00 00 00    	je     80106eb0 <switchuvm+0xf0>
80106dee:	e8 1d da ff ff       	call   80104810 <pushcli>
80106df3:	e8 88 ce ff ff       	call   80103c80 <mycpu>
80106df8:	89 c3                	mov    %eax,%ebx
80106dfa:	e8 81 ce ff ff       	call   80103c80 <mycpu>
80106dff:	89 c7                	mov    %eax,%edi
80106e01:	e8 7a ce ff ff       	call   80103c80 <mycpu>
80106e06:	83 c7 08             	add    $0x8,%edi
80106e09:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106e0c:	e8 6f ce ff ff       	call   80103c80 <mycpu>
80106e11:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106e14:	ba 67 00 00 00       	mov    $0x67,%edx
80106e19:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80106e20:	83 c0 08             	add    $0x8,%eax
80106e23:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
80106e2a:	bf ff ff ff ff       	mov    $0xffffffff,%edi
80106e2f:	83 c1 08             	add    $0x8,%ecx
80106e32:	c1 e8 18             	shr    $0x18,%eax
80106e35:	c1 e9 10             	shr    $0x10,%ecx
80106e38:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
80106e3e:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80106e44:	b9 99 40 00 00       	mov    $0x4099,%ecx
80106e49:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
80106e50:	bb 10 00 00 00       	mov    $0x10,%ebx
80106e55:	e8 26 ce ff ff       	call   80103c80 <mycpu>
80106e5a:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
80106e61:	e8 1a ce ff ff       	call   80103c80 <mycpu>
80106e66:	66 89 58 10          	mov    %bx,0x10(%eax)
80106e6a:	8b 5e 08             	mov    0x8(%esi),%ebx
80106e6d:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106e73:	e8 08 ce ff ff       	call   80103c80 <mycpu>
80106e78:	89 58 0c             	mov    %ebx,0xc(%eax)
80106e7b:	e8 00 ce ff ff       	call   80103c80 <mycpu>
80106e80:	66 89 78 6e          	mov    %di,0x6e(%eax)
80106e84:	b8 28 00 00 00       	mov    $0x28,%eax
80106e89:	0f 00 d8             	ltr    %ax
80106e8c:	8b 46 04             	mov    0x4(%esi),%eax
80106e8f:	05 00 00 00 80       	add    $0x80000000,%eax
80106e94:	0f 22 d8             	mov    %eax,%cr3
80106e97:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e9a:	5b                   	pop    %ebx
80106e9b:	5e                   	pop    %esi
80106e9c:	5f                   	pop    %edi
80106e9d:	5d                   	pop    %ebp
80106e9e:	e9 bd d9 ff ff       	jmp    80104860 <popcli>
80106ea3:	83 ec 0c             	sub    $0xc,%esp
80106ea6:	68 ae 7d 10 80       	push   $0x80107dae
80106eab:	e8 e0 94 ff ff       	call   80100390 <panic>
80106eb0:	83 ec 0c             	sub    $0xc,%esp
80106eb3:	68 d9 7d 10 80       	push   $0x80107dd9
80106eb8:	e8 d3 94 ff ff       	call   80100390 <panic>
80106ebd:	83 ec 0c             	sub    $0xc,%esp
80106ec0:	68 c4 7d 10 80       	push   $0x80107dc4
80106ec5:	e8 c6 94 ff ff       	call   80100390 <panic>
80106eca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106ed0 <inituvm>:
80106ed0:	f3 0f 1e fb          	endbr32 
80106ed4:	55                   	push   %ebp
80106ed5:	89 e5                	mov    %esp,%ebp
80106ed7:	57                   	push   %edi
80106ed8:	56                   	push   %esi
80106ed9:	53                   	push   %ebx
80106eda:	83 ec 1c             	sub    $0x1c,%esp
80106edd:	8b 45 0c             	mov    0xc(%ebp),%eax
80106ee0:	8b 75 10             	mov    0x10(%ebp),%esi
80106ee3:	8b 7d 08             	mov    0x8(%ebp),%edi
80106ee6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106ee9:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106eef:	77 4b                	ja     80106f3c <inituvm+0x6c>
80106ef1:	e8 ea ba ff ff       	call   801029e0 <kalloc>
80106ef6:	83 ec 04             	sub    $0x4,%esp
80106ef9:	68 00 10 00 00       	push   $0x1000
80106efe:	89 c3                	mov    %eax,%ebx
80106f00:	6a 00                	push   $0x0
80106f02:	50                   	push   %eax
80106f03:	e8 18 db ff ff       	call   80104a20 <memset>
80106f08:	58                   	pop    %eax
80106f09:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106f0f:	5a                   	pop    %edx
80106f10:	6a 06                	push   $0x6
80106f12:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106f17:	31 d2                	xor    %edx,%edx
80106f19:	50                   	push   %eax
80106f1a:	89 f8                	mov    %edi,%eax
80106f1c:	e8 af fc ff ff       	call   80106bd0 <mappages>
80106f21:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106f24:	89 75 10             	mov    %esi,0x10(%ebp)
80106f27:	83 c4 10             	add    $0x10,%esp
80106f2a:	89 5d 08             	mov    %ebx,0x8(%ebp)
80106f2d:	89 45 0c             	mov    %eax,0xc(%ebp)
80106f30:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106f33:	5b                   	pop    %ebx
80106f34:	5e                   	pop    %esi
80106f35:	5f                   	pop    %edi
80106f36:	5d                   	pop    %ebp
80106f37:	e9 84 db ff ff       	jmp    80104ac0 <memmove>
80106f3c:	83 ec 0c             	sub    $0xc,%esp
80106f3f:	68 ed 7d 10 80       	push   $0x80107ded
80106f44:	e8 47 94 ff ff       	call   80100390 <panic>
80106f49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106f50 <loaduvm>:
80106f50:	f3 0f 1e fb          	endbr32 
80106f54:	55                   	push   %ebp
80106f55:	89 e5                	mov    %esp,%ebp
80106f57:	57                   	push   %edi
80106f58:	56                   	push   %esi
80106f59:	53                   	push   %ebx
80106f5a:	83 ec 1c             	sub    $0x1c,%esp
80106f5d:	8b 45 0c             	mov    0xc(%ebp),%eax
80106f60:	8b 75 18             	mov    0x18(%ebp),%esi
80106f63:	a9 ff 0f 00 00       	test   $0xfff,%eax
80106f68:	0f 85 99 00 00 00    	jne    80107007 <loaduvm+0xb7>
80106f6e:	01 f0                	add    %esi,%eax
80106f70:	89 f3                	mov    %esi,%ebx
80106f72:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106f75:	8b 45 14             	mov    0x14(%ebp),%eax
80106f78:	01 f0                	add    %esi,%eax
80106f7a:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106f7d:	85 f6                	test   %esi,%esi
80106f7f:	75 15                	jne    80106f96 <loaduvm+0x46>
80106f81:	eb 6d                	jmp    80106ff0 <loaduvm+0xa0>
80106f83:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106f87:	90                   	nop
80106f88:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
80106f8e:	89 f0                	mov    %esi,%eax
80106f90:	29 d8                	sub    %ebx,%eax
80106f92:	39 c6                	cmp    %eax,%esi
80106f94:	76 5a                	jbe    80106ff0 <loaduvm+0xa0>
80106f96:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80106f99:	8b 45 08             	mov    0x8(%ebp),%eax
80106f9c:	31 c9                	xor    %ecx,%ecx
80106f9e:	29 da                	sub    %ebx,%edx
80106fa0:	e8 ab fb ff ff       	call   80106b50 <walkpgdir>
80106fa5:	85 c0                	test   %eax,%eax
80106fa7:	74 51                	je     80106ffa <loaduvm+0xaa>
80106fa9:	8b 00                	mov    (%eax),%eax
80106fab:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80106fae:	bf 00 10 00 00       	mov    $0x1000,%edi
80106fb3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106fb8:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
80106fbe:	0f 46 fb             	cmovbe %ebx,%edi
80106fc1:	29 d9                	sub    %ebx,%ecx
80106fc3:	05 00 00 00 80       	add    $0x80000000,%eax
80106fc8:	57                   	push   %edi
80106fc9:	51                   	push   %ecx
80106fca:	50                   	push   %eax
80106fcb:	ff 75 10             	pushl  0x10(%ebp)
80106fce:	e8 3d ae ff ff       	call   80101e10 <readi>
80106fd3:	83 c4 10             	add    $0x10,%esp
80106fd6:	39 f8                	cmp    %edi,%eax
80106fd8:	74 ae                	je     80106f88 <loaduvm+0x38>
80106fda:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106fdd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106fe2:	5b                   	pop    %ebx
80106fe3:	5e                   	pop    %esi
80106fe4:	5f                   	pop    %edi
80106fe5:	5d                   	pop    %ebp
80106fe6:	c3                   	ret    
80106fe7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106fee:	66 90                	xchg   %ax,%ax
80106ff0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106ff3:	31 c0                	xor    %eax,%eax
80106ff5:	5b                   	pop    %ebx
80106ff6:	5e                   	pop    %esi
80106ff7:	5f                   	pop    %edi
80106ff8:	5d                   	pop    %ebp
80106ff9:	c3                   	ret    
80106ffa:	83 ec 0c             	sub    $0xc,%esp
80106ffd:	68 07 7e 10 80       	push   $0x80107e07
80107002:	e8 89 93 ff ff       	call   80100390 <panic>
80107007:	83 ec 0c             	sub    $0xc,%esp
8010700a:	68 a8 7e 10 80       	push   $0x80107ea8
8010700f:	e8 7c 93 ff ff       	call   80100390 <panic>
80107014:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010701b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010701f:	90                   	nop

80107020 <allocuvm>:
80107020:	f3 0f 1e fb          	endbr32 
80107024:	55                   	push   %ebp
80107025:	89 e5                	mov    %esp,%ebp
80107027:	57                   	push   %edi
80107028:	56                   	push   %esi
80107029:	53                   	push   %ebx
8010702a:	83 ec 1c             	sub    $0x1c,%esp
8010702d:	8b 45 10             	mov    0x10(%ebp),%eax
80107030:	8b 7d 08             	mov    0x8(%ebp),%edi
80107033:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107036:	85 c0                	test   %eax,%eax
80107038:	0f 88 b2 00 00 00    	js     801070f0 <allocuvm+0xd0>
8010703e:	3b 45 0c             	cmp    0xc(%ebp),%eax
80107041:	8b 45 0c             	mov    0xc(%ebp),%eax
80107044:	0f 82 96 00 00 00    	jb     801070e0 <allocuvm+0xc0>
8010704a:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
80107050:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
80107056:	39 75 10             	cmp    %esi,0x10(%ebp)
80107059:	77 40                	ja     8010709b <allocuvm+0x7b>
8010705b:	e9 83 00 00 00       	jmp    801070e3 <allocuvm+0xc3>
80107060:	83 ec 04             	sub    $0x4,%esp
80107063:	68 00 10 00 00       	push   $0x1000
80107068:	6a 00                	push   $0x0
8010706a:	50                   	push   %eax
8010706b:	e8 b0 d9 ff ff       	call   80104a20 <memset>
80107070:	58                   	pop    %eax
80107071:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107077:	5a                   	pop    %edx
80107078:	6a 06                	push   $0x6
8010707a:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010707f:	89 f2                	mov    %esi,%edx
80107081:	50                   	push   %eax
80107082:	89 f8                	mov    %edi,%eax
80107084:	e8 47 fb ff ff       	call   80106bd0 <mappages>
80107089:	83 c4 10             	add    $0x10,%esp
8010708c:	85 c0                	test   %eax,%eax
8010708e:	78 78                	js     80107108 <allocuvm+0xe8>
80107090:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107096:	39 75 10             	cmp    %esi,0x10(%ebp)
80107099:	76 48                	jbe    801070e3 <allocuvm+0xc3>
8010709b:	e8 40 b9 ff ff       	call   801029e0 <kalloc>
801070a0:	89 c3                	mov    %eax,%ebx
801070a2:	85 c0                	test   %eax,%eax
801070a4:	75 ba                	jne    80107060 <allocuvm+0x40>
801070a6:	83 ec 0c             	sub    $0xc,%esp
801070a9:	68 25 7e 10 80       	push   $0x80107e25
801070ae:	e8 fd 95 ff ff       	call   801006b0 <cprintf>
801070b3:	8b 45 0c             	mov    0xc(%ebp),%eax
801070b6:	83 c4 10             	add    $0x10,%esp
801070b9:	39 45 10             	cmp    %eax,0x10(%ebp)
801070bc:	74 32                	je     801070f0 <allocuvm+0xd0>
801070be:	8b 55 10             	mov    0x10(%ebp),%edx
801070c1:	89 c1                	mov    %eax,%ecx
801070c3:	89 f8                	mov    %edi,%eax
801070c5:	e8 96 fb ff ff       	call   80106c60 <deallocuvm.part.0>
801070ca:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
801070d1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801070d4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801070d7:	5b                   	pop    %ebx
801070d8:	5e                   	pop    %esi
801070d9:	5f                   	pop    %edi
801070da:	5d                   	pop    %ebp
801070db:	c3                   	ret    
801070dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801070e0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801070e3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801070e6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801070e9:	5b                   	pop    %ebx
801070ea:	5e                   	pop    %esi
801070eb:	5f                   	pop    %edi
801070ec:	5d                   	pop    %ebp
801070ed:	c3                   	ret    
801070ee:	66 90                	xchg   %ax,%ax
801070f0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
801070f7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801070fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801070fd:	5b                   	pop    %ebx
801070fe:	5e                   	pop    %esi
801070ff:	5f                   	pop    %edi
80107100:	5d                   	pop    %ebp
80107101:	c3                   	ret    
80107102:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107108:	83 ec 0c             	sub    $0xc,%esp
8010710b:	68 3d 7e 10 80       	push   $0x80107e3d
80107110:	e8 9b 95 ff ff       	call   801006b0 <cprintf>
80107115:	8b 45 0c             	mov    0xc(%ebp),%eax
80107118:	83 c4 10             	add    $0x10,%esp
8010711b:	39 45 10             	cmp    %eax,0x10(%ebp)
8010711e:	74 0c                	je     8010712c <allocuvm+0x10c>
80107120:	8b 55 10             	mov    0x10(%ebp),%edx
80107123:	89 c1                	mov    %eax,%ecx
80107125:	89 f8                	mov    %edi,%eax
80107127:	e8 34 fb ff ff       	call   80106c60 <deallocuvm.part.0>
8010712c:	83 ec 0c             	sub    $0xc,%esp
8010712f:	53                   	push   %ebx
80107130:	e8 eb b6 ff ff       	call   80102820 <kfree>
80107135:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
8010713c:	83 c4 10             	add    $0x10,%esp
8010713f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107142:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107145:	5b                   	pop    %ebx
80107146:	5e                   	pop    %esi
80107147:	5f                   	pop    %edi
80107148:	5d                   	pop    %ebp
80107149:	c3                   	ret    
8010714a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107150 <deallocuvm>:
80107150:	f3 0f 1e fb          	endbr32 
80107154:	55                   	push   %ebp
80107155:	89 e5                	mov    %esp,%ebp
80107157:	8b 55 0c             	mov    0xc(%ebp),%edx
8010715a:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010715d:	8b 45 08             	mov    0x8(%ebp),%eax
80107160:	39 d1                	cmp    %edx,%ecx
80107162:	73 0c                	jae    80107170 <deallocuvm+0x20>
80107164:	5d                   	pop    %ebp
80107165:	e9 f6 fa ff ff       	jmp    80106c60 <deallocuvm.part.0>
8010716a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107170:	89 d0                	mov    %edx,%eax
80107172:	5d                   	pop    %ebp
80107173:	c3                   	ret    
80107174:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010717b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010717f:	90                   	nop

80107180 <freevm>:
80107180:	f3 0f 1e fb          	endbr32 
80107184:	55                   	push   %ebp
80107185:	89 e5                	mov    %esp,%ebp
80107187:	57                   	push   %edi
80107188:	56                   	push   %esi
80107189:	53                   	push   %ebx
8010718a:	83 ec 0c             	sub    $0xc,%esp
8010718d:	8b 75 08             	mov    0x8(%ebp),%esi
80107190:	85 f6                	test   %esi,%esi
80107192:	74 55                	je     801071e9 <freevm+0x69>
80107194:	31 c9                	xor    %ecx,%ecx
80107196:	ba 00 00 00 80       	mov    $0x80000000,%edx
8010719b:	89 f0                	mov    %esi,%eax
8010719d:	89 f3                	mov    %esi,%ebx
8010719f:	e8 bc fa ff ff       	call   80106c60 <deallocuvm.part.0>
801071a4:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
801071aa:	eb 0b                	jmp    801071b7 <freevm+0x37>
801071ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801071b0:	83 c3 04             	add    $0x4,%ebx
801071b3:	39 df                	cmp    %ebx,%edi
801071b5:	74 23                	je     801071da <freevm+0x5a>
801071b7:	8b 03                	mov    (%ebx),%eax
801071b9:	a8 01                	test   $0x1,%al
801071bb:	74 f3                	je     801071b0 <freevm+0x30>
801071bd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801071c2:	83 ec 0c             	sub    $0xc,%esp
801071c5:	83 c3 04             	add    $0x4,%ebx
801071c8:	05 00 00 00 80       	add    $0x80000000,%eax
801071cd:	50                   	push   %eax
801071ce:	e8 4d b6 ff ff       	call   80102820 <kfree>
801071d3:	83 c4 10             	add    $0x10,%esp
801071d6:	39 df                	cmp    %ebx,%edi
801071d8:	75 dd                	jne    801071b7 <freevm+0x37>
801071da:	89 75 08             	mov    %esi,0x8(%ebp)
801071dd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801071e0:	5b                   	pop    %ebx
801071e1:	5e                   	pop    %esi
801071e2:	5f                   	pop    %edi
801071e3:	5d                   	pop    %ebp
801071e4:	e9 37 b6 ff ff       	jmp    80102820 <kfree>
801071e9:	83 ec 0c             	sub    $0xc,%esp
801071ec:	68 59 7e 10 80       	push   $0x80107e59
801071f1:	e8 9a 91 ff ff       	call   80100390 <panic>
801071f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801071fd:	8d 76 00             	lea    0x0(%esi),%esi

80107200 <setupkvm>:
80107200:	f3 0f 1e fb          	endbr32 
80107204:	55                   	push   %ebp
80107205:	89 e5                	mov    %esp,%ebp
80107207:	56                   	push   %esi
80107208:	53                   	push   %ebx
80107209:	e8 d2 b7 ff ff       	call   801029e0 <kalloc>
8010720e:	89 c6                	mov    %eax,%esi
80107210:	85 c0                	test   %eax,%eax
80107212:	74 42                	je     80107256 <setupkvm+0x56>
80107214:	83 ec 04             	sub    $0x4,%esp
80107217:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
8010721c:	68 00 10 00 00       	push   $0x1000
80107221:	6a 00                	push   $0x0
80107223:	50                   	push   %eax
80107224:	e8 f7 d7 ff ff       	call   80104a20 <memset>
80107229:	83 c4 10             	add    $0x10,%esp
8010722c:	8b 43 04             	mov    0x4(%ebx),%eax
8010722f:	83 ec 08             	sub    $0x8,%esp
80107232:	8b 4b 08             	mov    0x8(%ebx),%ecx
80107235:	ff 73 0c             	pushl  0xc(%ebx)
80107238:	8b 13                	mov    (%ebx),%edx
8010723a:	50                   	push   %eax
8010723b:	29 c1                	sub    %eax,%ecx
8010723d:	89 f0                	mov    %esi,%eax
8010723f:	e8 8c f9 ff ff       	call   80106bd0 <mappages>
80107244:	83 c4 10             	add    $0x10,%esp
80107247:	85 c0                	test   %eax,%eax
80107249:	78 15                	js     80107260 <setupkvm+0x60>
8010724b:	83 c3 10             	add    $0x10,%ebx
8010724e:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80107254:	75 d6                	jne    8010722c <setupkvm+0x2c>
80107256:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107259:	89 f0                	mov    %esi,%eax
8010725b:	5b                   	pop    %ebx
8010725c:	5e                   	pop    %esi
8010725d:	5d                   	pop    %ebp
8010725e:	c3                   	ret    
8010725f:	90                   	nop
80107260:	83 ec 0c             	sub    $0xc,%esp
80107263:	56                   	push   %esi
80107264:	31 f6                	xor    %esi,%esi
80107266:	e8 15 ff ff ff       	call   80107180 <freevm>
8010726b:	83 c4 10             	add    $0x10,%esp
8010726e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107271:	89 f0                	mov    %esi,%eax
80107273:	5b                   	pop    %ebx
80107274:	5e                   	pop    %esi
80107275:	5d                   	pop    %ebp
80107276:	c3                   	ret    
80107277:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010727e:	66 90                	xchg   %ax,%ax

80107280 <kvmalloc>:
80107280:	f3 0f 1e fb          	endbr32 
80107284:	55                   	push   %ebp
80107285:	89 e5                	mov    %esp,%ebp
80107287:	83 ec 08             	sub    $0x8,%esp
8010728a:	e8 71 ff ff ff       	call   80107200 <setupkvm>
8010728f:	a3 c4 54 11 80       	mov    %eax,0x801154c4
80107294:	05 00 00 00 80       	add    $0x80000000,%eax
80107299:	0f 22 d8             	mov    %eax,%cr3
8010729c:	c9                   	leave  
8010729d:	c3                   	ret    
8010729e:	66 90                	xchg   %ax,%ax

801072a0 <clearpteu>:
801072a0:	f3 0f 1e fb          	endbr32 
801072a4:	55                   	push   %ebp
801072a5:	31 c9                	xor    %ecx,%ecx
801072a7:	89 e5                	mov    %esp,%ebp
801072a9:	83 ec 08             	sub    $0x8,%esp
801072ac:	8b 55 0c             	mov    0xc(%ebp),%edx
801072af:	8b 45 08             	mov    0x8(%ebp),%eax
801072b2:	e8 99 f8 ff ff       	call   80106b50 <walkpgdir>
801072b7:	85 c0                	test   %eax,%eax
801072b9:	74 05                	je     801072c0 <clearpteu+0x20>
801072bb:	83 20 fb             	andl   $0xfffffffb,(%eax)
801072be:	c9                   	leave  
801072bf:	c3                   	ret    
801072c0:	83 ec 0c             	sub    $0xc,%esp
801072c3:	68 6a 7e 10 80       	push   $0x80107e6a
801072c8:	e8 c3 90 ff ff       	call   80100390 <panic>
801072cd:	8d 76 00             	lea    0x0(%esi),%esi

801072d0 <copyuvm>:
801072d0:	f3 0f 1e fb          	endbr32 
801072d4:	55                   	push   %ebp
801072d5:	89 e5                	mov    %esp,%ebp
801072d7:	57                   	push   %edi
801072d8:	56                   	push   %esi
801072d9:	53                   	push   %ebx
801072da:	83 ec 1c             	sub    $0x1c,%esp
801072dd:	e8 1e ff ff ff       	call   80107200 <setupkvm>
801072e2:	89 45 e0             	mov    %eax,-0x20(%ebp)
801072e5:	85 c0                	test   %eax,%eax
801072e7:	0f 84 9b 00 00 00    	je     80107388 <copyuvm+0xb8>
801072ed:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801072f0:	85 c9                	test   %ecx,%ecx
801072f2:	0f 84 90 00 00 00    	je     80107388 <copyuvm+0xb8>
801072f8:	31 f6                	xor    %esi,%esi
801072fa:	eb 46                	jmp    80107342 <copyuvm+0x72>
801072fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107300:	83 ec 04             	sub    $0x4,%esp
80107303:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107309:	68 00 10 00 00       	push   $0x1000
8010730e:	57                   	push   %edi
8010730f:	50                   	push   %eax
80107310:	e8 ab d7 ff ff       	call   80104ac0 <memmove>
80107315:	58                   	pop    %eax
80107316:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010731c:	5a                   	pop    %edx
8010731d:	ff 75 e4             	pushl  -0x1c(%ebp)
80107320:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107325:	89 f2                	mov    %esi,%edx
80107327:	50                   	push   %eax
80107328:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010732b:	e8 a0 f8 ff ff       	call   80106bd0 <mappages>
80107330:	83 c4 10             	add    $0x10,%esp
80107333:	85 c0                	test   %eax,%eax
80107335:	78 61                	js     80107398 <copyuvm+0xc8>
80107337:	81 c6 00 10 00 00    	add    $0x1000,%esi
8010733d:	39 75 0c             	cmp    %esi,0xc(%ebp)
80107340:	76 46                	jbe    80107388 <copyuvm+0xb8>
80107342:	8b 45 08             	mov    0x8(%ebp),%eax
80107345:	31 c9                	xor    %ecx,%ecx
80107347:	89 f2                	mov    %esi,%edx
80107349:	e8 02 f8 ff ff       	call   80106b50 <walkpgdir>
8010734e:	85 c0                	test   %eax,%eax
80107350:	74 61                	je     801073b3 <copyuvm+0xe3>
80107352:	8b 00                	mov    (%eax),%eax
80107354:	a8 01                	test   $0x1,%al
80107356:	74 4e                	je     801073a6 <copyuvm+0xd6>
80107358:	89 c7                	mov    %eax,%edi
8010735a:	25 ff 0f 00 00       	and    $0xfff,%eax
8010735f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107362:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80107368:	e8 73 b6 ff ff       	call   801029e0 <kalloc>
8010736d:	89 c3                	mov    %eax,%ebx
8010736f:	85 c0                	test   %eax,%eax
80107371:	75 8d                	jne    80107300 <copyuvm+0x30>
80107373:	83 ec 0c             	sub    $0xc,%esp
80107376:	ff 75 e0             	pushl  -0x20(%ebp)
80107379:	e8 02 fe ff ff       	call   80107180 <freevm>
8010737e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
80107385:	83 c4 10             	add    $0x10,%esp
80107388:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010738b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010738e:	5b                   	pop    %ebx
8010738f:	5e                   	pop    %esi
80107390:	5f                   	pop    %edi
80107391:	5d                   	pop    %ebp
80107392:	c3                   	ret    
80107393:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107397:	90                   	nop
80107398:	83 ec 0c             	sub    $0xc,%esp
8010739b:	53                   	push   %ebx
8010739c:	e8 7f b4 ff ff       	call   80102820 <kfree>
801073a1:	83 c4 10             	add    $0x10,%esp
801073a4:	eb cd                	jmp    80107373 <copyuvm+0xa3>
801073a6:	83 ec 0c             	sub    $0xc,%esp
801073a9:	68 8e 7e 10 80       	push   $0x80107e8e
801073ae:	e8 dd 8f ff ff       	call   80100390 <panic>
801073b3:	83 ec 0c             	sub    $0xc,%esp
801073b6:	68 74 7e 10 80       	push   $0x80107e74
801073bb:	e8 d0 8f ff ff       	call   80100390 <panic>

801073c0 <uva2ka>:
801073c0:	f3 0f 1e fb          	endbr32 
801073c4:	55                   	push   %ebp
801073c5:	31 c9                	xor    %ecx,%ecx
801073c7:	89 e5                	mov    %esp,%ebp
801073c9:	83 ec 08             	sub    $0x8,%esp
801073cc:	8b 55 0c             	mov    0xc(%ebp),%edx
801073cf:	8b 45 08             	mov    0x8(%ebp),%eax
801073d2:	e8 79 f7 ff ff       	call   80106b50 <walkpgdir>
801073d7:	8b 00                	mov    (%eax),%eax
801073d9:	c9                   	leave  
801073da:	89 c2                	mov    %eax,%edx
801073dc:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801073e1:	83 e2 05             	and    $0x5,%edx
801073e4:	05 00 00 00 80       	add    $0x80000000,%eax
801073e9:	83 fa 05             	cmp    $0x5,%edx
801073ec:	ba 00 00 00 00       	mov    $0x0,%edx
801073f1:	0f 45 c2             	cmovne %edx,%eax
801073f4:	c3                   	ret    
801073f5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801073fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107400 <copyout>:
80107400:	f3 0f 1e fb          	endbr32 
80107404:	55                   	push   %ebp
80107405:	89 e5                	mov    %esp,%ebp
80107407:	57                   	push   %edi
80107408:	56                   	push   %esi
80107409:	53                   	push   %ebx
8010740a:	83 ec 0c             	sub    $0xc,%esp
8010740d:	8b 75 14             	mov    0x14(%ebp),%esi
80107410:	8b 55 0c             	mov    0xc(%ebp),%edx
80107413:	85 f6                	test   %esi,%esi
80107415:	75 3c                	jne    80107453 <copyout+0x53>
80107417:	eb 67                	jmp    80107480 <copyout+0x80>
80107419:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107420:	8b 55 0c             	mov    0xc(%ebp),%edx
80107423:	89 fb                	mov    %edi,%ebx
80107425:	29 d3                	sub    %edx,%ebx
80107427:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010742d:	39 f3                	cmp    %esi,%ebx
8010742f:	0f 47 de             	cmova  %esi,%ebx
80107432:	29 fa                	sub    %edi,%edx
80107434:	83 ec 04             	sub    $0x4,%esp
80107437:	01 c2                	add    %eax,%edx
80107439:	53                   	push   %ebx
8010743a:	ff 75 10             	pushl  0x10(%ebp)
8010743d:	52                   	push   %edx
8010743e:	e8 7d d6 ff ff       	call   80104ac0 <memmove>
80107443:	01 5d 10             	add    %ebx,0x10(%ebp)
80107446:	8d 97 00 10 00 00    	lea    0x1000(%edi),%edx
8010744c:	83 c4 10             	add    $0x10,%esp
8010744f:	29 de                	sub    %ebx,%esi
80107451:	74 2d                	je     80107480 <copyout+0x80>
80107453:	89 d7                	mov    %edx,%edi
80107455:	83 ec 08             	sub    $0x8,%esp
80107458:	89 55 0c             	mov    %edx,0xc(%ebp)
8010745b:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80107461:	57                   	push   %edi
80107462:	ff 75 08             	pushl  0x8(%ebp)
80107465:	e8 56 ff ff ff       	call   801073c0 <uva2ka>
8010746a:	83 c4 10             	add    $0x10,%esp
8010746d:	85 c0                	test   %eax,%eax
8010746f:	75 af                	jne    80107420 <copyout+0x20>
80107471:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107474:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107479:	5b                   	pop    %ebx
8010747a:	5e                   	pop    %esi
8010747b:	5f                   	pop    %edi
8010747c:	5d                   	pop    %ebp
8010747d:	c3                   	ret    
8010747e:	66 90                	xchg   %ax,%ax
80107480:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107483:	31 c0                	xor    %eax,%eax
80107485:	5b                   	pop    %ebx
80107486:	5e                   	pop    %esi
80107487:	5f                   	pop    %edi
80107488:	5d                   	pop    %ebp
80107489:	c3                   	ret    
