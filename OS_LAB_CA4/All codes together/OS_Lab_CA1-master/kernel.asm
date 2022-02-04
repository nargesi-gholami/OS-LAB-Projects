
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
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
8010001a:	0f 22 d8             	mov    %eax,%cr3
8010001d:	0f 20 c0             	mov    %cr0,%eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
80100025:	0f 22 c0             	mov    %eax,%cr0
80100028:	bc f0 c5 10 80       	mov    $0x8010c5f0,%esp
8010002d:	b8 20 34 10 80       	mov    $0x80103420,%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	f3 0f 1e fb          	endbr32 
80100044:	55                   	push   %ebp
80100045:	89 e5                	mov    %esp,%ebp
80100047:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100048:	bb 34 c6 10 80       	mov    $0x8010c634,%ebx
{
8010004d:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
80100050:	68 e0 7d 10 80       	push   $0x80107de0
80100055:	68 00 c6 10 80       	push   $0x8010c600
8010005a:	e8 c1 4e 00 00       	call   80104f20 <initlock>
  bcache.head.next = &bcache.head;
8010005f:	83 c4 10             	add    $0x10,%esp
80100062:	b8 fc 0c 11 80       	mov    $0x80110cfc,%eax
  bcache.head.prev = &bcache.head;
80100067:	c7 05 4c 0d 11 80 fc 	movl   $0x80110cfc,0x80110d4c
8010006e:	0c 11 80 
  bcache.head.next = &bcache.head;
80100071:	c7 05 50 0d 11 80 fc 	movl   $0x80110cfc,0x80110d50
80100078:	0c 11 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
8010007b:	eb 05                	jmp    80100082 <binit+0x42>
8010007d:	8d 76 00             	lea    0x0(%esi),%esi
80100080:	89 d3                	mov    %edx,%ebx
    b->next = bcache.head.next;
80100082:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100085:	83 ec 08             	sub    $0x8,%esp
80100088:	8d 43 0c             	lea    0xc(%ebx),%eax
    b->prev = &bcache.head;
8010008b:	c7 43 50 fc 0c 11 80 	movl   $0x80110cfc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 e7 7d 10 80       	push   $0x80107de7
80100097:	50                   	push   %eax
80100098:	e8 43 4d 00 00       	call   80104de0 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 50 0d 11 80       	mov    0x80110d50,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	8d 93 5c 02 00 00    	lea    0x25c(%ebx),%edx
801000a8:	83 c4 10             	add    $0x10,%esp
    bcache.head.next->prev = b;
801000ab:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
801000ae:	89 d8                	mov    %ebx,%eax
801000b0:	89 1d 50 0d 11 80    	mov    %ebx,0x80110d50
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	81 fb a0 0a 11 80    	cmp    $0x80110aa0,%ebx
801000bc:	75 c2                	jne    80100080 <binit+0x40>
  }
}
801000be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c1:	c9                   	leave  
801000c2:	c3                   	ret    
801000c3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	f3 0f 1e fb          	endbr32 
801000d4:	55                   	push   %ebp
801000d5:	89 e5                	mov    %esp,%ebp
801000d7:	57                   	push   %edi
801000d8:	56                   	push   %esi
801000d9:	53                   	push   %ebx
801000da:	83 ec 18             	sub    $0x18,%esp
801000dd:	8b 7d 08             	mov    0x8(%ebp),%edi
801000e0:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&bcache.lock);
801000e3:	68 00 c6 10 80       	push   $0x8010c600
801000e8:	e8 b3 4f 00 00       	call   801050a0 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000ed:	8b 1d 50 0d 11 80    	mov    0x80110d50,%ebx
801000f3:	83 c4 10             	add    $0x10,%esp
801000f6:	81 fb fc 0c 11 80    	cmp    $0x80110cfc,%ebx
801000fc:	75 0d                	jne    8010010b <bread+0x3b>
801000fe:	eb 20                	jmp    80100120 <bread+0x50>
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb fc 0c 11 80    	cmp    $0x80110cfc,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 7b 04             	cmp    0x4(%ebx),%edi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 73 08             	cmp    0x8(%ebx),%esi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010011f:	90                   	nop
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 4c 0d 11 80    	mov    0x80110d4c,%ebx
80100126:	81 fb fc 0c 11 80    	cmp    $0x80110cfc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 70                	jmp    801001a0 <bread+0xd0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb fc 0c 11 80    	cmp    $0x80110cfc,%ebx
80100139:	74 65                	je     801001a0 <bread+0xd0>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 7b 04             	mov    %edi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 73 08             	mov    %esi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 00 c6 10 80       	push   $0x8010c600
80100162:	e8 f9 4f 00 00       	call   80105160 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 ae 4c 00 00       	call   80104e20 <acquiresleep>
      return b;
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	74 0e                	je     80100188 <bread+0xb8>
    iderw(b);
  }
  return b;
}
8010017a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010017d:	89 d8                	mov    %ebx,%eax
8010017f:	5b                   	pop    %ebx
80100180:	5e                   	pop    %esi
80100181:	5f                   	pop    %edi
80100182:	5d                   	pop    %ebp
80100183:	c3                   	ret    
80100184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iderw(b);
80100188:	83 ec 0c             	sub    $0xc,%esp
8010018b:	53                   	push   %ebx
8010018c:	e8 cf 24 00 00       	call   80102660 <iderw>
80100191:	83 c4 10             	add    $0x10,%esp
}
80100194:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100197:	89 d8                	mov    %ebx,%eax
80100199:	5b                   	pop    %ebx
8010019a:	5e                   	pop    %esi
8010019b:	5f                   	pop    %edi
8010019c:	5d                   	pop    %ebp
8010019d:	c3                   	ret    
8010019e:	66 90                	xchg   %ax,%ax
  panic("bget: no buffers");
801001a0:	83 ec 0c             	sub    $0xc,%esp
801001a3:	68 ee 7d 10 80       	push   $0x80107dee
801001a8:	e8 e3 01 00 00       	call   80100390 <panic>
801001ad:	8d 76 00             	lea    0x0(%esi),%esi

801001b0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001b0:	f3 0f 1e fb          	endbr32 
801001b4:	55                   	push   %ebp
801001b5:	89 e5                	mov    %esp,%ebp
801001b7:	53                   	push   %ebx
801001b8:	83 ec 10             	sub    $0x10,%esp
801001bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001be:	8d 43 0c             	lea    0xc(%ebx),%eax
801001c1:	50                   	push   %eax
801001c2:	e8 f9 4c 00 00       	call   80104ec0 <holdingsleep>
801001c7:	83 c4 10             	add    $0x10,%esp
801001ca:	85 c0                	test   %eax,%eax
801001cc:	74 0f                	je     801001dd <bwrite+0x2d>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ce:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001d1:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001d4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001d7:	c9                   	leave  
  iderw(b);
801001d8:	e9 83 24 00 00       	jmp    80102660 <iderw>
    panic("bwrite");
801001dd:	83 ec 0c             	sub    $0xc,%esp
801001e0:	68 ff 7d 10 80       	push   $0x80107dff
801001e5:	e8 a6 01 00 00       	call   80100390 <panic>
801001ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801001f0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001f0:	f3 0f 1e fb          	endbr32 
801001f4:	55                   	push   %ebp
801001f5:	89 e5                	mov    %esp,%ebp
801001f7:	56                   	push   %esi
801001f8:	53                   	push   %ebx
801001f9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001fc:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ff:	83 ec 0c             	sub    $0xc,%esp
80100202:	56                   	push   %esi
80100203:	e8 b8 4c 00 00       	call   80104ec0 <holdingsleep>
80100208:	83 c4 10             	add    $0x10,%esp
8010020b:	85 c0                	test   %eax,%eax
8010020d:	74 66                	je     80100275 <brelse+0x85>
    panic("brelse");

  releasesleep(&b->lock);
8010020f:	83 ec 0c             	sub    $0xc,%esp
80100212:	56                   	push   %esi
80100213:	e8 68 4c 00 00       	call   80104e80 <releasesleep>

  acquire(&bcache.lock);
80100218:	c7 04 24 00 c6 10 80 	movl   $0x8010c600,(%esp)
8010021f:	e8 7c 4e 00 00       	call   801050a0 <acquire>
  b->refcnt--;
80100224:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100227:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
8010022a:	83 e8 01             	sub    $0x1,%eax
8010022d:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
80100230:	85 c0                	test   %eax,%eax
80100232:	75 2f                	jne    80100263 <brelse+0x73>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100234:	8b 43 54             	mov    0x54(%ebx),%eax
80100237:	8b 53 50             	mov    0x50(%ebx),%edx
8010023a:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
8010023d:	8b 43 50             	mov    0x50(%ebx),%eax
80100240:	8b 53 54             	mov    0x54(%ebx),%edx
80100243:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100246:	a1 50 0d 11 80       	mov    0x80110d50,%eax
    b->prev = &bcache.head;
8010024b:	c7 43 50 fc 0c 11 80 	movl   $0x80110cfc,0x50(%ebx)
    b->next = bcache.head.next;
80100252:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100255:	a1 50 0d 11 80       	mov    0x80110d50,%eax
8010025a:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
8010025d:	89 1d 50 0d 11 80    	mov    %ebx,0x80110d50
  }
  
  release(&bcache.lock);
80100263:	c7 45 08 00 c6 10 80 	movl   $0x8010c600,0x8(%ebp)
}
8010026a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010026d:	5b                   	pop    %ebx
8010026e:	5e                   	pop    %esi
8010026f:	5d                   	pop    %ebp
  release(&bcache.lock);
80100270:	e9 eb 4e 00 00       	jmp    80105160 <release>
    panic("brelse");
80100275:	83 ec 0c             	sub    $0xc,%esp
80100278:	68 06 7e 10 80       	push   $0x80107e06
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
801002a5:	e8 76 19 00 00       	call   80101c20 <iunlock>
  acquire(&cons.lock);
801002aa:	c7 04 24 40 b5 10 80 	movl   $0x8010b540,(%esp)
801002b1:	e8 ea 4d 00 00       	call   801050a0 <acquire>
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
801002c6:	a1 e0 0f 11 80       	mov    0x80110fe0,%eax
801002cb:	3b 05 e4 0f 11 80    	cmp    0x80110fe4,%eax
801002d1:	74 27                	je     801002fa <consoleread+0x6a>
801002d3:	eb 5b                	jmp    80100330 <consoleread+0xa0>
801002d5:	8d 76 00             	lea    0x0(%esi),%esi
      sleep(&input.r, &cons.lock);
801002d8:	83 ec 08             	sub    $0x8,%esp
801002db:	68 40 b5 10 80       	push   $0x8010b540
801002e0:	68 e0 0f 11 80       	push   $0x80110fe0
801002e5:	e8 36 45 00 00       	call   80104820 <sleep>
    while(input.r == input.w){
801002ea:	a1 e0 0f 11 80       	mov    0x80110fe0,%eax
801002ef:	83 c4 10             	add    $0x10,%esp
801002f2:	3b 05 e4 0f 11 80    	cmp    0x80110fe4,%eax
801002f8:	75 36                	jne    80100330 <consoleread+0xa0>
      if(myproc()->killed){
801002fa:	e8 a1 3a 00 00       	call   80103da0 <myproc>
801002ff:	8b 48 24             	mov    0x24(%eax),%ecx
80100302:	85 c9                	test   %ecx,%ecx
80100304:	74 d2                	je     801002d8 <consoleread+0x48>
        release(&cons.lock);
80100306:	83 ec 0c             	sub    $0xc,%esp
80100309:	68 40 b5 10 80       	push   $0x8010b540
8010030e:	e8 4d 4e 00 00       	call   80105160 <release>
        ilock(ip);
80100313:	5a                   	pop    %edx
80100314:	ff 75 08             	pushl  0x8(%ebp)
80100317:	e8 24 18 00 00       	call   80101b40 <ilock>
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
80100333:	89 15 e0 0f 11 80    	mov    %edx,0x80110fe0
80100339:	89 c2                	mov    %eax,%edx
8010033b:	83 e2 7f             	and    $0x7f,%edx
8010033e:	0f be 8a 60 0f 11 80 	movsbl -0x7feef0a0(%edx),%ecx
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
80100360:	68 40 b5 10 80       	push   $0x8010b540
80100365:	e8 f6 4d 00 00       	call   80105160 <release>
  ilock(ip);
8010036a:	58                   	pop    %eax
8010036b:	ff 75 08             	pushl  0x8(%ebp)
8010036e:	e8 cd 17 00 00       	call   80101b40 <ilock>
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
80100386:	a3 e0 0f 11 80       	mov    %eax,0x80110fe0
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
8010039d:	c7 05 74 b5 10 80 00 	movl   $0x0,0x8010b574
801003a4:	00 00 00 
  getcallerpcs(&s, pcs);
801003a7:	8d 5d d0             	lea    -0x30(%ebp),%ebx
801003aa:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
801003ad:	e8 ce 28 00 00       	call   80102c80 <lapicid>
801003b2:	83 ec 08             	sub    $0x8,%esp
801003b5:	50                   	push   %eax
801003b6:	68 0d 7e 10 80       	push   $0x80107e0d
801003bb:	e8 f0 02 00 00       	call   801006b0 <cprintf>
  cprintf(s);
801003c0:	58                   	pop    %eax
801003c1:	ff 75 08             	pushl  0x8(%ebp)
801003c4:	e8 e7 02 00 00       	call   801006b0 <cprintf>
  cprintf("\n");
801003c9:	c7 04 24 b3 88 10 80 	movl   $0x801088b3,(%esp)
801003d0:	e8 db 02 00 00       	call   801006b0 <cprintf>
  getcallerpcs(&s, pcs);
801003d5:	8d 45 08             	lea    0x8(%ebp),%eax
801003d8:	5a                   	pop    %edx
801003d9:	59                   	pop    %ecx
801003da:	53                   	push   %ebx
801003db:	50                   	push   %eax
801003dc:	e8 5f 4b 00 00       	call   80104f40 <getcallerpcs>
  for(i=0; i<10; i++)
801003e1:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003e4:	83 ec 08             	sub    $0x8,%esp
801003e7:	ff 33                	pushl  (%ebx)
801003e9:	83 c3 04             	add    $0x4,%ebx
801003ec:	68 21 7e 10 80       	push   $0x80107e21
801003f1:	e8 ba 02 00 00       	call   801006b0 <cprintf>
  for(i=0; i<10; i++)
801003f6:	83 c4 10             	add    $0x10,%esp
801003f9:	39 f3                	cmp    %esi,%ebx
801003fb:	75 e7                	jne    801003e4 <panic+0x54>
  panicked = 1; // freeze other CPU
801003fd:	c7 05 78 b5 10 80 01 	movl   $0x1,0x8010b578
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
8010042a:	e8 a1 65 00 00       	call   801069d0 <uartputc>
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
80100515:	e8 b6 64 00 00       	call   801069d0 <uartputc>
8010051a:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100521:	e8 aa 64 00 00       	call   801069d0 <uartputc>
80100526:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010052d:	e8 9e 64 00 00       	call   801069d0 <uartputc>
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
80100561:	e8 ea 4c 00 00       	call   80105250 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100566:	b8 80 07 00 00       	mov    $0x780,%eax
8010056b:	83 c4 0c             	add    $0xc,%esp
8010056e:	29 d8                	sub    %ebx,%eax
80100570:	01 c0                	add    %eax,%eax
80100572:	50                   	push   %eax
80100573:	6a 00                	push   $0x0
80100575:	56                   	push   %esi
80100576:	e8 35 4c 00 00       	call   801051b0 <memset>
8010057b:	88 5d e7             	mov    %bl,-0x19(%ebp)
8010057e:	83 c4 10             	add    $0x10,%esp
80100581:	e9 22 ff ff ff       	jmp    801004a8 <consputc.part.0+0x98>
    panic("pos under/overflow");
80100586:	83 ec 0c             	sub    $0xc,%esp
80100589:	68 25 7e 10 80       	push   $0x80107e25
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
801005c9:	0f b6 92 a8 7e 10 80 	movzbl -0x7fef8158(%edx),%edx
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
80100603:	8b 15 78 b5 10 80    	mov    0x8010b578,%edx
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
80100653:	e8 c8 15 00 00       	call   80101c20 <iunlock>
  acquire(&cons.lock);
80100658:	c7 04 24 40 b5 10 80 	movl   $0x8010b540,(%esp)
8010065f:	e8 3c 4a 00 00       	call   801050a0 <acquire>
  for(i = 0; i < n; i++)
80100664:	83 c4 10             	add    $0x10,%esp
80100667:	85 db                	test   %ebx,%ebx
80100669:	7e 24                	jle    8010068f <consolewrite+0x4f>
8010066b:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010066e:	8d 34 1f             	lea    (%edi,%ebx,1),%esi
  if(panicked){
80100671:	8b 15 78 b5 10 80    	mov    0x8010b578,%edx
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
80100692:	68 40 b5 10 80       	push   $0x8010b540
80100697:	e8 c4 4a 00 00       	call   80105160 <release>
  ilock(ip);
8010069c:	58                   	pop    %eax
8010069d:	ff 75 08             	pushl  0x8(%ebp)
801006a0:	e8 9b 14 00 00       	call   80101b40 <ilock>

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
801006bd:	a1 74 b5 10 80       	mov    0x8010b574,%eax
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
801006ec:	8b 0d 78 b5 10 80    	mov    0x8010b578,%ecx
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
8010077d:	bb 38 7e 10 80       	mov    $0x80107e38,%ebx
      for(; *s; s++)
80100782:	b8 28 00 00 00       	mov    $0x28,%eax
  if(panicked){
80100787:	8b 15 78 b5 10 80    	mov    0x8010b578,%edx
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
801007b8:	68 40 b5 10 80       	push   $0x8010b540
801007bd:	e8 de 48 00 00       	call   801050a0 <acquire>
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
801007e0:	8b 3d 78 b5 10 80    	mov    0x8010b578,%edi
801007e6:	85 ff                	test   %edi,%edi
801007e8:	0f 84 12 ff ff ff    	je     80100700 <cprintf+0x50>
801007ee:	fa                   	cli    
    for(;;)
801007ef:	eb fe                	jmp    801007ef <cprintf+0x13f>
801007f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(panicked){
801007f8:	8b 0d 78 b5 10 80    	mov    0x8010b578,%ecx
801007fe:	85 c9                	test   %ecx,%ecx
80100800:	74 06                	je     80100808 <cprintf+0x158>
80100802:	fa                   	cli    
    for(;;)
80100803:	eb fe                	jmp    80100803 <cprintf+0x153>
80100805:	8d 76 00             	lea    0x0(%esi),%esi
80100808:	b8 25 00 00 00       	mov    $0x25,%eax
8010080d:	e8 fe fb ff ff       	call   80100410 <consputc.part.0>
  if(panicked){
80100812:	8b 15 78 b5 10 80    	mov    0x8010b578,%edx
80100818:	85 d2                	test   %edx,%edx
8010081a:	74 2c                	je     80100848 <cprintf+0x198>
8010081c:	fa                   	cli    
    for(;;)
8010081d:	eb fe                	jmp    8010081d <cprintf+0x16d>
8010081f:	90                   	nop
    release(&cons.lock);
80100820:	83 ec 0c             	sub    $0xc,%esp
80100823:	68 40 b5 10 80       	push   $0x8010b540
80100828:	e8 33 49 00 00       	call   80105160 <release>
8010082d:	83 c4 10             	add    $0x10,%esp
}
80100830:	e9 ee fe ff ff       	jmp    80100723 <cprintf+0x73>
    panic("null fmt");
80100835:	83 ec 0c             	sub    $0xc,%esp
80100838:	68 3f 7e 10 80       	push   $0x80107e3f
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
801008d2:	68 40 b5 10 80       	push   $0x8010b540
{
801008d7:	89 45 9c             	mov    %eax,-0x64(%ebp)
  acquire(&cons.lock);
801008da:	e8 c1 47 00 00       	call   801050a0 <acquire>
  while((c = getc()) >= 0){
801008df:	83 c4 10             	add    $0x10,%esp
801008e2:	8b 45 9c             	mov    -0x64(%ebp),%eax
801008e5:	ff d0                	call   *%eax
801008e7:	89 c6                	mov    %eax,%esi
801008e9:	85 c0                	test   %eax,%eax
801008eb:	0f 88 6f 03 00 00    	js     80100c60 <consoleintr+0x3a0>
    switch(c){
801008f1:	83 fe 15             	cmp    $0x15,%esi
801008f4:	7f 1c                	jg     80100912 <consoleintr+0x52>
801008f6:	85 f6                	test   %esi,%esi
801008f8:	74 e8                	je     801008e2 <consoleintr+0x22>
801008fa:	83 fe 15             	cmp    $0x15,%esi
801008fd:	0f 87 e9 03 00 00    	ja     80100cec <consoleintr+0x42c>
80100903:	3e ff 24 b5 50 7e 10 	notrack jmp *-0x7fef81b0(,%esi,4)
8010090a:	80 
8010090b:	bb 01 00 00 00       	mov    $0x1,%ebx
80100910:	eb d0                	jmp    801008e2 <consoleintr+0x22>
80100912:	83 fe 7f             	cmp    $0x7f,%esi
80100915:	0f 84 d1 01 00 00    	je     80100aec <consoleintr+0x22c>
      if(c != 0 && input.e-input.r < INPUT_BUF){
8010091b:	a1 e8 0f 11 80       	mov    0x80110fe8,%eax
80100920:	89 c2                	mov    %eax,%edx
80100922:	2b 15 e0 0f 11 80    	sub    0x80110fe0,%edx
80100928:	83 fa 7f             	cmp    $0x7f,%edx
8010092b:	77 b5                	ja     801008e2 <consoleintr+0x22>
        if(ctrlA_pressed) {
8010092d:	8b 15 ec 0f 11 80    	mov    0x80110fec,%edx
80100933:	8d 78 01             	lea    0x1(%eax),%edi
80100936:	89 7d a0             	mov    %edi,-0x60(%ebp)
80100939:	8d 4a 01             	lea    0x1(%edx),%ecx
8010093c:	89 4d a4             	mov    %ecx,-0x5c(%ebp)
8010093f:	8b 0d 20 b5 10 80    	mov    0x8010b520,%ecx
80100945:	85 c9                	test   %ecx,%ecx
80100947:	0f 85 73 03 00 00    	jne    80100cc0 <consoleintr+0x400>
          input.buf[input.e++ % INPUT_BUF] = c;
8010094d:	89 3d e8 0f 11 80    	mov    %edi,0x80110fe8
80100953:	8b 15 78 b5 10 80    	mov    0x8010b578,%edx
80100959:	83 e0 7f             	and    $0x7f,%eax
          c = (c == '\r') ? '\n' : c;
8010095c:	83 fe 0d             	cmp    $0xd,%esi
8010095f:	0f 84 2d 04 00 00    	je     80100d92 <consoleintr+0x4d2>
          input.buf[input.e++ % INPUT_BUF] = c;
80100965:	89 f1                	mov    %esi,%ecx
80100967:	88 88 60 0f 11 80    	mov    %cl,-0x7feef0a0(%eax)
          input.pos++;
8010096d:	8b 45 a4             	mov    -0x5c(%ebp),%eax
80100970:	a3 ec 0f 11 80       	mov    %eax,0x80110fec
  if(panicked){
80100975:	85 d2                	test   %edx,%edx
80100977:	0f 85 51 04 00 00    	jne    80100dce <consoleintr+0x50e>
8010097d:	89 f0                	mov    %esi,%eax
8010097f:	e8 8c fa ff ff       	call   80100410 <consputc.part.0>
          if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100984:	83 fe 0a             	cmp    $0xa,%esi
80100987:	0f 84 22 04 00 00    	je     80100daf <consoleintr+0x4ef>
8010098d:	83 fe 04             	cmp    $0x4,%esi
80100990:	0f 84 19 04 00 00    	je     80100daf <consoleintr+0x4ef>
80100996:	a1 e0 0f 11 80       	mov    0x80110fe0,%eax
8010099b:	83 e8 80             	sub    $0xffffff80,%eax
8010099e:	39 05 e8 0f 11 80    	cmp    %eax,0x80110fe8
801009a4:	0f 85 38 ff ff ff    	jne    801008e2 <consoleintr+0x22>
801009aa:	e9 05 04 00 00       	jmp    80100db4 <consoleintr+0x4f4>
      while(input.e != input.w &&
801009af:	a1 e8 0f 11 80       	mov    0x80110fe8,%eax
801009b4:	39 05 e4 0f 11 80    	cmp    %eax,0x80110fe4
801009ba:	0f 84 22 ff ff ff    	je     801008e2 <consoleintr+0x22>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
801009c0:	83 e8 01             	sub    $0x1,%eax
801009c3:	89 c2                	mov    %eax,%edx
801009c5:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
801009c8:	80 ba 60 0f 11 80 0a 	cmpb   $0xa,-0x7feef0a0(%edx)
801009cf:	0f 84 0d ff ff ff    	je     801008e2 <consoleintr+0x22>
  if(panicked){
801009d5:	8b 3d 78 b5 10 80    	mov    0x8010b578,%edi
        input.e--;
801009db:	a3 e8 0f 11 80       	mov    %eax,0x80110fe8
  if(panicked){
801009e0:	85 ff                	test   %edi,%edi
801009e2:	0f 84 28 02 00 00    	je     80100c10 <consoleintr+0x350>
  asm volatile("cli");
801009e8:	fa                   	cli    
    for(;;)
801009e9:	eb fe                	jmp    801009e9 <consoleintr+0x129>
  if(panicked){
801009eb:	8b 0d 78 b5 10 80    	mov    0x8010b578,%ecx
801009f1:	85 c9                	test   %ecx,%ecx
801009f3:	0f 84 cf 01 00 00    	je     80100bc8 <consoleintr+0x308>
801009f9:	fa                   	cli    
    for(;;)
801009fa:	eb fe                	jmp    801009fa <consoleintr+0x13a>
        char lowerCase[] = "abcdefghijklmnopqrstuvwxyz"; 
801009fc:	b8 79 7a 00 00       	mov    $0x7a79,%eax
80100a01:	c7 45 b2 61 62 63 64 	movl   $0x64636261,-0x4e(%ebp)
80100a08:	66 89 45 ca          	mov    %ax,-0x36(%ebp)
        char upperCase[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
80100a0c:	b8 59 5a 00 00       	mov    $0x5a59,%eax
80100a11:	66 89 45 e5          	mov    %ax,-0x1b(%ebp)
        if(!ctrlA_pressed)
80100a15:	a1 20 b5 10 80       	mov    0x8010b520,%eax
        char lowerCase[] = "abcdefghijklmnopqrstuvwxyz"; 
80100a1a:	c7 45 b6 65 66 67 68 	movl   $0x68676665,-0x4a(%ebp)
80100a21:	c7 45 ba 69 6a 6b 6c 	movl   $0x6c6b6a69,-0x46(%ebp)
80100a28:	c7 45 be 6d 6e 6f 70 	movl   $0x706f6e6d,-0x42(%ebp)
80100a2f:	c7 45 c2 71 72 73 74 	movl   $0x74737271,-0x3e(%ebp)
80100a36:	c7 45 c6 75 76 77 78 	movl   $0x78777675,-0x3a(%ebp)
80100a3d:	c6 45 cc 00          	movb   $0x0,-0x34(%ebp)
        char upperCase[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
80100a41:	c7 45 cd 41 42 43 44 	movl   $0x44434241,-0x33(%ebp)
80100a48:	c7 45 d1 45 46 47 48 	movl   $0x48474645,-0x2f(%ebp)
80100a4f:	c7 45 d5 49 4a 4b 4c 	movl   $0x4c4b4a49,-0x2b(%ebp)
80100a56:	c7 45 d9 4d 4e 4f 50 	movl   $0x504f4e4d,-0x27(%ebp)
80100a5d:	c7 45 dd 51 52 53 54 	movl   $0x54535251,-0x23(%ebp)
80100a64:	c7 45 e1 55 56 57 58 	movl   $0x58575655,-0x1f(%ebp)
80100a6b:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
        if(!ctrlA_pressed)
80100a6f:	85 c0                	test   %eax,%eax
80100a71:	0f 84 6b fe ff ff    	je     801008e2 <consoleintr+0x22>
        for(uint i = input.e; i != input.pos; i++){
80100a77:	a1 ec 0f 11 80       	mov    0x80110fec,%eax
80100a7c:	8b 35 e8 0f 11 80    	mov    0x80110fe8,%esi
80100a82:	89 45 a4             	mov    %eax,-0x5c(%ebp)
80100a85:	39 c6                	cmp    %eax,%esi
80100a87:	0f 84 55 fe ff ff    	je     801008e2 <consoleintr+0x22>
80100a8d:	89 f7                	mov    %esi,%edi
          if(input.buf[i] == ' ' || input.buf[i] == '\n' || input.buf[i] == '\r') {
80100a8f:	0f b6 8f 60 0f 11 80 	movzbl -0x7feef0a0(%edi),%ecx
80100a96:	8d 41 f6             	lea    -0xa(%ecx),%eax
80100a99:	3c 16                	cmp    $0x16,%al
80100a9b:	77 0a                	ja     80100aa7 <consoleintr+0x1e7>
80100a9d:	ba 09 00 40 00       	mov    $0x400009,%edx
80100aa2:	0f a3 c2             	bt     %eax,%edx
80100aa5:	72 34                	jb     80100adb <consoleintr+0x21b>
80100aa7:	ba 61 00 00 00       	mov    $0x61,%edx
80100aac:	31 c0                	xor    %eax,%eax
80100aae:	eb 0c                	jmp    80100abc <consoleintr+0x1fc>
80100ab0:	0f b6 8f 60 0f 11 80 	movzbl -0x7feef0a0(%edi),%ecx
80100ab7:	0f b6 54 05 b2       	movzbl -0x4e(%ebp,%eax,1),%edx
              if(input.buf[i] == lowerCase[j]) {
80100abc:	38 d1                	cmp    %dl,%cl
80100abe:	75 0b                	jne    80100acb <consoleintr+0x20b>
               input.buf[i] = upperCase[j];
80100ac0:	0f b6 54 05 cd       	movzbl -0x33(%ebp,%eax,1),%edx
80100ac5:	88 97 60 0f 11 80    	mov    %dl,-0x7feef0a0(%edi)
            for(int j = 0; j < 26; j++) {
80100acb:	83 c0 01             	add    $0x1,%eax
80100ace:	83 f8 1a             	cmp    $0x1a,%eax
80100ad1:	75 dd                	jne    80100ab0 <consoleintr+0x1f0>
        for(uint i = input.e; i != input.pos; i++){
80100ad3:	83 c7 01             	add    $0x1,%edi
80100ad6:	3b 7d a4             	cmp    -0x5c(%ebp),%edi
80100ad9:	75 b4                	jne    80100a8f <consoleintr+0x1cf>
  if(panicked){
80100adb:	8b 3d 78 b5 10 80    	mov    0x8010b578,%edi
80100ae1:	85 ff                	test   %edi,%edi
80100ae3:	0f 84 a6 01 00 00    	je     80100c8f <consoleintr+0x3cf>
80100ae9:	fa                   	cli    
    for(;;)
80100aea:	eb fe                	jmp    80100aea <consoleintr+0x22a>
      if(input.e != input.w){
80100aec:	a1 e8 0f 11 80       	mov    0x80110fe8,%eax
80100af1:	3b 05 e4 0f 11 80    	cmp    0x80110fe4,%eax
80100af7:	0f 84 e5 fd ff ff    	je     801008e2 <consoleintr+0x22>
  if(panicked){
80100afd:	8b 35 78 b5 10 80    	mov    0x8010b578,%esi
        input.e--;
80100b03:	83 e8 01             	sub    $0x1,%eax
80100b06:	a3 e8 0f 11 80       	mov    %eax,0x80110fe8
  if(panicked){
80100b0b:	85 f6                	test   %esi,%esi
80100b0d:	0f 84 6d 01 00 00    	je     80100c80 <consoleintr+0x3c0>
80100b13:	fa                   	cli    
    for(;;)
80100b14:	eb fe                	jmp    80100b14 <consoleintr+0x254>
        while(input.e != input.w &&
80100b16:	a1 e4 0f 11 80       	mov    0x80110fe4,%eax
80100b1b:	8b 3d e8 0f 11 80    	mov    0x80110fe8,%edi
80100b21:	89 de                	mov    %ebx,%esi
        ctrlA_pressed = 1;
80100b23:	c7 05 20 b5 10 80 01 	movl   $0x1,0x8010b520
80100b2a:	00 00 00 
        while(input.e != input.w &&
80100b2d:	89 c1                	mov    %eax,%ecx
80100b2f:	89 45 a4             	mov    %eax,-0x5c(%ebp)
80100b32:	31 c0                	xor    %eax,%eax
80100b34:	39 cf                	cmp    %ecx,%edi
80100b36:	75 68                	jne    80100ba0 <consoleintr+0x2e0>
80100b38:	e9 a5 fd ff ff       	jmp    801008e2 <consoleintr+0x22>
80100b3d:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100b40:	b8 0e 00 00 00       	mov    $0xe,%eax
80100b45:	ba d4 03 00 00       	mov    $0x3d4,%edx
80100b4a:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100b4b:	bb d5 03 00 00       	mov    $0x3d5,%ebx
80100b50:	89 da                	mov    %ebx,%edx
80100b52:	ec                   	in     (%dx),%al
80100b53:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100b56:	ba d4 03 00 00       	mov    $0x3d4,%edx
80100b5b:	b8 0f 00 00 00       	mov    $0xf,%eax
  pos = inb(CRTPORT+1) << 8;
80100b60:	c1 e1 08             	shl    $0x8,%ecx
80100b63:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100b64:	89 da                	mov    %ebx,%edx
80100b66:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);    
80100b67:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100b6a:	ba d4 03 00 00       	mov    $0x3d4,%edx
80100b6f:	09 c1                	or     %eax,%ecx
80100b71:	b8 0f 00 00 00       	mov    $0xf,%eax
  pos--;
80100b76:	83 e9 01             	sub    $0x1,%ecx
80100b79:	ee                   	out    %al,(%dx)
80100b7a:	89 c8                	mov    %ecx,%eax
80100b7c:	89 da                	mov    %ebx,%edx
80100b7e:	ee                   	out    %al,(%dx)
80100b7f:	b8 0e 00 00 00       	mov    $0xe,%eax
80100b84:	ba d4 03 00 00       	mov    $0x3d4,%edx
80100b89:	ee                   	out    %al,(%dx)
  outb(CRTPORT+1, (unsigned char )((pos>>8)&0xFF));
80100b8a:	89 c8                	mov    %ecx,%eax
80100b8c:	89 da                	mov    %ebx,%edx
80100b8e:	c1 f8 08             	sar    $0x8,%eax
80100b91:	ee                   	out    %al,(%dx)
        while(input.e != input.w &&
80100b92:	b8 01 00 00 00       	mov    $0x1,%eax
80100b97:	3b 7d a4             	cmp    -0x5c(%ebp),%edi
80100b9a:	0f 84 90 00 00 00    	je     80100c30 <consoleintr+0x370>
80100ba0:	89 fa                	mov    %edi,%edx
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100ba2:	83 ef 01             	sub    $0x1,%edi
80100ba5:	89 f9                	mov    %edi,%ecx
80100ba7:	83 e1 7f             	and    $0x7f,%ecx
        while(input.e != input.w &&
80100baa:	80 b9 60 0f 11 80 0a 	cmpb   $0xa,-0x7feef0a0(%ecx)
80100bb1:	75 8d                	jne    80100b40 <consoleintr+0x280>
80100bb3:	89 f3                	mov    %esi,%ebx
80100bb5:	84 c0                	test   %al,%al
80100bb7:	0f 84 25 fd ff ff    	je     801008e2 <consoleintr+0x22>
80100bbd:	89 15 e8 0f 11 80    	mov    %edx,0x80110fe8
80100bc3:	e9 1a fd ff ff       	jmp    801008e2 <consoleintr+0x22>
      char last =  input.buf[(input.e-1)];
80100bc8:	a1 e8 0f 11 80       	mov    0x80110fe8,%eax
80100bcd:	0f b6 b8 5f 0f 11 80 	movzbl -0x7feef0a1(%eax),%edi
      char b_last = input.buf[(input.e-2)];
80100bd4:	0f b6 b0 5e 0f 11 80 	movzbl -0x7feef0a2(%eax),%esi
80100bdb:	b8 00 01 00 00       	mov    $0x100,%eax
80100be0:	e8 2b f8 ff ff       	call   80100410 <consputc.part.0>
  if(panicked){
80100be5:	8b 15 78 b5 10 80    	mov    0x8010b578,%edx
80100beb:	85 d2                	test   %edx,%edx
80100bed:	0f 85 06 fe ff ff    	jne    801009f9 <consoleintr+0x139>
80100bf3:	b8 00 01 00 00       	mov    $0x100,%eax
80100bf8:	e8 13 f8 ff ff       	call   80100410 <consputc.part.0>
80100bfd:	a1 78 b5 10 80       	mov    0x8010b578,%eax
80100c02:	85 c0                	test   %eax,%eax
80100c04:	74 37                	je     80100c3d <consoleintr+0x37d>
  asm volatile("cli");
80100c06:	fa                   	cli    
    for(;;)
80100c07:	eb fe                	jmp    80100c07 <consoleintr+0x347>
80100c09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100c10:	b8 00 01 00 00       	mov    $0x100,%eax
80100c15:	e8 f6 f7 ff ff       	call   80100410 <consputc.part.0>
      while(input.e != input.w &&
80100c1a:	a1 e8 0f 11 80       	mov    0x80110fe8,%eax
80100c1f:	3b 05 e4 0f 11 80    	cmp    0x80110fe4,%eax
80100c25:	0f 85 95 fd ff ff    	jne    801009c0 <consoleintr+0x100>
80100c2b:	e9 b2 fc ff ff       	jmp    801008e2 <consoleintr+0x22>
80100c30:	89 3d e8 0f 11 80    	mov    %edi,0x80110fe8
80100c36:	89 f3                	mov    %esi,%ebx
80100c38:	e9 a5 fc ff ff       	jmp    801008e2 <consoleintr+0x22>
      consputc(last);
80100c3d:	89 f8                	mov    %edi,%eax
80100c3f:	0f be c0             	movsbl %al,%eax
80100c42:	e8 c9 f7 ff ff       	call   80100410 <consputc.part.0>
  if(panicked){
80100c47:	a1 78 b5 10 80       	mov    0x8010b578,%eax
80100c4c:	85 c0                	test   %eax,%eax
80100c4e:	0f 84 90 01 00 00    	je     80100de4 <consoleintr+0x524>
80100c54:	fa                   	cli    
    for(;;)
80100c55:	eb fe                	jmp    80100c55 <consoleintr+0x395>
80100c57:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100c5e:	66 90                	xchg   %ax,%ax
  release(&cons.lock);
80100c60:	83 ec 0c             	sub    $0xc,%esp
80100c63:	68 40 b5 10 80       	push   $0x8010b540
80100c68:	e8 f3 44 00 00       	call   80105160 <release>
  if(doprocdump) {
80100c6d:	83 c4 10             	add    $0x10,%esp
80100c70:	85 db                	test   %ebx,%ebx
80100c72:	0f 85 60 01 00 00    	jne    80100dd8 <consoleintr+0x518>
}
80100c78:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100c7b:	5b                   	pop    %ebx
80100c7c:	5e                   	pop    %esi
80100c7d:	5f                   	pop    %edi
80100c7e:	5d                   	pop    %ebp
80100c7f:	c3                   	ret    
80100c80:	b8 00 01 00 00       	mov    $0x100,%eax
80100c85:	e8 86 f7 ff ff       	call   80100410 <consputc.part.0>
80100c8a:	e9 53 fc ff ff       	jmp    801008e2 <consoleintr+0x22>
          consputc(input.buf[i]);
80100c8f:	0f be 86 60 0f 11 80 	movsbl -0x7feef0a0(%esi),%eax
        for(uint i = input.e; i != input.pos; i++){
80100c96:	83 c6 01             	add    $0x1,%esi
80100c99:	e8 72 f7 ff ff       	call   80100410 <consputc.part.0>
80100c9e:	39 35 ec 0f 11 80    	cmp    %esi,0x80110fec
80100ca4:	0f 85 31 fe ff ff    	jne    80100adb <consoleintr+0x21b>
80100caa:	e9 33 fc ff ff       	jmp    801008e2 <consoleintr+0x22>
80100caf:	90                   	nop
            input.buf[i] = input.buf[i-1];
80100cb0:	0f b6 8a 5f 0f 11 80 	movzbl -0x7feef0a1(%edx),%ecx
80100cb7:	83 ea 01             	sub    $0x1,%edx
80100cba:	88 8a 61 0f 11 80    	mov    %cl,-0x7feef09f(%edx)
          for(uint i = input.pos; i != input.e; i--){
80100cc0:	39 d0                	cmp    %edx,%eax
80100cc2:	75 ec                	jne    80100cb0 <consoleintr+0x3f0>
          input.buf[input.e] = c;
80100cc4:	89 f1                	mov    %esi,%ecx
          input.e++;
80100cc6:	89 3d e8 0f 11 80    	mov    %edi,0x80110fe8
          input.buf[input.e] = c;
80100ccc:	88 88 60 0f 11 80    	mov    %cl,-0x7feef0a0(%eax)
          input.pos++;
80100cd2:	8b 4d a4             	mov    -0x5c(%ebp),%ecx
80100cd5:	89 0d ec 0f 11 80    	mov    %ecx,0x80110fec
          for(uint i = input.e-1; i != input.pos; i++){
80100cdb:	39 c8                	cmp    %ecx,%eax
80100cdd:	74 47                	je     80100d26 <consoleintr+0x466>
  if(panicked){
80100cdf:	8b 15 78 b5 10 80    	mov    0x8010b578,%edx
80100ce5:	85 d2                	test   %edx,%edx
80100ce7:	74 17                	je     80100d00 <consoleintr+0x440>
80100ce9:	fa                   	cli    
    for(;;)
80100cea:	eb fe                	jmp    80100cea <consoleintr+0x42a>
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100cec:	85 f6                	test   %esi,%esi
80100cee:	0f 84 ee fb ff ff    	je     801008e2 <consoleintr+0x22>
80100cf4:	e9 22 fc ff ff       	jmp    8010091b <consoleintr+0x5b>
80100cf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
            consputc(input.buf[i]);
80100d00:	0f be 80 60 0f 11 80 	movsbl -0x7feef0a0(%eax),%eax
80100d07:	e8 04 f7 ff ff       	call   80100410 <consputc.part.0>
          for(uint i = input.e-1; i != input.pos; i++){
80100d0c:	89 f8                	mov    %edi,%eax
80100d0e:	39 3d ec 0f 11 80    	cmp    %edi,0x80110fec
80100d14:	74 05                	je     80100d1b <consoleintr+0x45b>
80100d16:	83 c7 01             	add    $0x1,%edi
80100d19:	eb c4                	jmp    80100cdf <consoleintr+0x41f>
80100d1b:	a1 e8 0f 11 80       	mov    0x80110fe8,%eax
80100d20:	89 7d a4             	mov    %edi,-0x5c(%ebp)
80100d23:	89 45 a0             	mov    %eax,-0x60(%ebp)
          for(uint i = input.pos; i != input.e; i--){
80100d26:	8b 7d a0             	mov    -0x60(%ebp),%edi
80100d29:	39 7d a4             	cmp    %edi,-0x5c(%ebp)
80100d2c:	0f 84 b0 fb ff ff    	je     801008e2 <consoleintr+0x22>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100d32:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100d37:	89 de                	mov    %ebx,%esi
80100d39:	b8 0e 00 00 00       	mov    $0xe,%eax
80100d3e:	89 fa                	mov    %edi,%edx
80100d40:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100d41:	bb d5 03 00 00       	mov    $0x3d5,%ebx
80100d46:	89 da                	mov    %ebx,%edx
80100d48:	ec                   	in     (%dx),%al
80100d49:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100d4c:	89 fa                	mov    %edi,%edx
80100d4e:	b8 0f 00 00 00       	mov    $0xf,%eax
  pos = inb(CRTPORT+1) << 8;
80100d53:	c1 e1 08             	shl    $0x8,%ecx
80100d56:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100d57:	89 da                	mov    %ebx,%edx
80100d59:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);    
80100d5a:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100d5d:	89 fa                	mov    %edi,%edx
80100d5f:	09 c1                	or     %eax,%ecx
80100d61:	b8 0f 00 00 00       	mov    $0xf,%eax
  pos--;
80100d66:	83 e9 01             	sub    $0x1,%ecx
80100d69:	ee                   	out    %al,(%dx)
80100d6a:	89 c8                	mov    %ecx,%eax
80100d6c:	89 da                	mov    %ebx,%edx
80100d6e:	ee                   	out    %al,(%dx)
80100d6f:	b8 0e 00 00 00       	mov    $0xe,%eax
80100d74:	89 fa                	mov    %edi,%edx
80100d76:	ee                   	out    %al,(%dx)
  outb(CRTPORT+1, (unsigned char )((pos>>8)&0xFF));
80100d77:	89 c8                	mov    %ecx,%eax
80100d79:	89 da                	mov    %ebx,%edx
80100d7b:	c1 f8 08             	sar    $0x8,%eax
80100d7e:	ee                   	out    %al,(%dx)
          for(uint i = input.pos; i != input.e; i--){
80100d7f:	83 6d a4 01          	subl   $0x1,-0x5c(%ebp)
80100d83:	8b 45 a4             	mov    -0x5c(%ebp),%eax
80100d86:	3b 45 a0             	cmp    -0x60(%ebp),%eax
80100d89:	75 ae                	jne    80100d39 <consoleintr+0x479>
80100d8b:	89 f3                	mov    %esi,%ebx
80100d8d:	e9 50 fb ff ff       	jmp    801008e2 <consoleintr+0x22>
          input.buf[input.e++ % INPUT_BUF] = c;
80100d92:	c6 80 60 0f 11 80 0a 	movb   $0xa,-0x7feef0a0(%eax)
          input.pos++;
80100d99:	8b 45 a4             	mov    -0x5c(%ebp),%eax
80100d9c:	a3 ec 0f 11 80       	mov    %eax,0x80110fec
  if(panicked){
80100da1:	85 d2                	test   %edx,%edx
80100da3:	75 29                	jne    80100dce <consoleintr+0x50e>
80100da5:	b8 0a 00 00 00       	mov    $0xa,%eax
80100daa:	e8 61 f6 ff ff       	call   80100410 <consputc.part.0>
          if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100daf:	a1 e8 0f 11 80       	mov    0x80110fe8,%eax
            wakeup(&input.r);
80100db4:	83 ec 0c             	sub    $0xc,%esp
            input.w = input.e;
80100db7:	a3 e4 0f 11 80       	mov    %eax,0x80110fe4
            wakeup(&input.r);
80100dbc:	68 e0 0f 11 80       	push   $0x80110fe0
80100dc1:	e8 1a 3c 00 00       	call   801049e0 <wakeup>
80100dc6:	83 c4 10             	add    $0x10,%esp
80100dc9:	e9 14 fb ff ff       	jmp    801008e2 <consoleintr+0x22>
  asm volatile("cli");
80100dce:	fa                   	cli    
    for(;;)
80100dcf:	eb fe                	jmp    80100dcf <consoleintr+0x50f>
80100dd1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}
80100dd8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ddb:	5b                   	pop    %ebx
80100ddc:	5e                   	pop    %esi
80100ddd:	5f                   	pop    %edi
80100dde:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100ddf:	e9 fc 3c 00 00       	jmp    80104ae0 <procdump>
      consputc(b_last);
80100de4:	89 f0                	mov    %esi,%eax
80100de6:	0f be c0             	movsbl %al,%eax
80100de9:	e8 22 f6 ff ff       	call   80100410 <consputc.part.0>
80100dee:	e9 ef fa ff ff       	jmp    801008e2 <consoleintr+0x22>
80100df3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100dfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100e00 <consoleinit>:

void
consoleinit(void)
{
80100e00:	f3 0f 1e fb          	endbr32 
80100e04:	55                   	push   %ebp
80100e05:	89 e5                	mov    %esp,%ebp
80100e07:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100e0a:	68 48 7e 10 80       	push   $0x80107e48
80100e0f:	68 40 b5 10 80       	push   $0x8010b540
80100e14:	e8 07 41 00 00       	call   80104f20 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80100e19:	58                   	pop    %eax
80100e1a:	5a                   	pop    %edx
80100e1b:	6a 00                	push   $0x0
80100e1d:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
80100e1f:	c7 05 ac 19 11 80 40 	movl   $0x80100640,0x801119ac
80100e26:	06 10 80 
  devsw[CONSOLE].read = consoleread;
80100e29:	c7 05 a8 19 11 80 90 	movl   $0x80100290,0x801119a8
80100e30:	02 10 80 
  cons.locking = 1;
80100e33:	c7 05 74 b5 10 80 01 	movl   $0x1,0x8010b574
80100e3a:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80100e3d:	e8 ce 19 00 00       	call   80102810 <ioapicenable>
}
80100e42:	83 c4 10             	add    $0x10,%esp
80100e45:	c9                   	leave  
80100e46:	c3                   	ret    
80100e47:	66 90                	xchg   %ax,%ax
80100e49:	66 90                	xchg   %ax,%ax
80100e4b:	66 90                	xchg   %ax,%ax
80100e4d:	66 90                	xchg   %ax,%ax
80100e4f:	90                   	nop

80100e50 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100e50:	f3 0f 1e fb          	endbr32 
80100e54:	55                   	push   %ebp
80100e55:	89 e5                	mov    %esp,%ebp
80100e57:	57                   	push   %edi
80100e58:	56                   	push   %esi
80100e59:	53                   	push   %ebx
80100e5a:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100e60:	e8 3b 2f 00 00       	call   80103da0 <myproc>
80100e65:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
80100e6b:	e8 a0 22 00 00       	call   80103110 <begin_op>

  if((ip = namei(path)) == 0){
80100e70:	83 ec 0c             	sub    $0xc,%esp
80100e73:	ff 75 08             	pushl  0x8(%ebp)
80100e76:	e8 95 15 00 00       	call   80102410 <namei>
80100e7b:	83 c4 10             	add    $0x10,%esp
80100e7e:	85 c0                	test   %eax,%eax
80100e80:	0f 84 05 03 00 00    	je     8010118b <exec+0x33b>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100e86:	83 ec 0c             	sub    $0xc,%esp
80100e89:	89 c3                	mov    %eax,%ebx
80100e8b:	50                   	push   %eax
80100e8c:	e8 af 0c 00 00       	call   80101b40 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100e91:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100e97:	6a 34                	push   $0x34
80100e99:	6a 00                	push   $0x0
80100e9b:	50                   	push   %eax
80100e9c:	53                   	push   %ebx
80100e9d:	e8 9e 0f 00 00       	call   80101e40 <readi>
80100ea2:	83 c4 20             	add    $0x20,%esp
80100ea5:	83 f8 34             	cmp    $0x34,%eax
80100ea8:	74 26                	je     80100ed0 <exec+0x80>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100eaa:	83 ec 0c             	sub    $0xc,%esp
80100ead:	53                   	push   %ebx
80100eae:	e8 2d 0f 00 00       	call   80101de0 <iunlockput>
    end_op();
80100eb3:	e8 c8 22 00 00       	call   80103180 <end_op>
80100eb8:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100ebb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100ec0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ec3:	5b                   	pop    %ebx
80100ec4:	5e                   	pop    %esi
80100ec5:	5f                   	pop    %edi
80100ec6:	5d                   	pop    %ebp
80100ec7:	c3                   	ret    
80100ec8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100ecf:	90                   	nop
  if(elf.magic != ELF_MAGIC)
80100ed0:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100ed7:	45 4c 46 
80100eda:	75 ce                	jne    80100eaa <exec+0x5a>
  if((pgdir = setupkvm()) == 0)
80100edc:	e8 5f 6c 00 00       	call   80107b40 <setupkvm>
80100ee1:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100ee7:	85 c0                	test   %eax,%eax
80100ee9:	74 bf                	je     80100eaa <exec+0x5a>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100eeb:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100ef2:	00 
80100ef3:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100ef9:	0f 84 ab 02 00 00    	je     801011aa <exec+0x35a>
  sz = 0;
80100eff:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100f06:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100f09:	31 ff                	xor    %edi,%edi
80100f0b:	e9 86 00 00 00       	jmp    80100f96 <exec+0x146>
    if(ph.type != ELF_PROG_LOAD)
80100f10:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100f17:	75 6c                	jne    80100f85 <exec+0x135>
    if(ph.memsz < ph.filesz)
80100f19:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100f1f:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100f25:	0f 82 87 00 00 00    	jb     80100fb2 <exec+0x162>
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100f2b:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100f31:	72 7f                	jb     80100fb2 <exec+0x162>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100f33:	83 ec 04             	sub    $0x4,%esp
80100f36:	50                   	push   %eax
80100f37:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100f3d:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100f43:	e8 18 6a 00 00       	call   80107960 <allocuvm>
80100f48:	83 c4 10             	add    $0x10,%esp
80100f4b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100f51:	85 c0                	test   %eax,%eax
80100f53:	74 5d                	je     80100fb2 <exec+0x162>
    if(ph.vaddr % PGSIZE != 0)
80100f55:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100f5b:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100f60:	75 50                	jne    80100fb2 <exec+0x162>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100f62:	83 ec 0c             	sub    $0xc,%esp
80100f65:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100f6b:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100f71:	53                   	push   %ebx
80100f72:	50                   	push   %eax
80100f73:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100f79:	e8 12 69 00 00       	call   80107890 <loaduvm>
80100f7e:	83 c4 20             	add    $0x20,%esp
80100f81:	85 c0                	test   %eax,%eax
80100f83:	78 2d                	js     80100fb2 <exec+0x162>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100f85:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100f8c:	83 c7 01             	add    $0x1,%edi
80100f8f:	83 c6 20             	add    $0x20,%esi
80100f92:	39 f8                	cmp    %edi,%eax
80100f94:	7e 3a                	jle    80100fd0 <exec+0x180>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100f96:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100f9c:	6a 20                	push   $0x20
80100f9e:	56                   	push   %esi
80100f9f:	50                   	push   %eax
80100fa0:	53                   	push   %ebx
80100fa1:	e8 9a 0e 00 00       	call   80101e40 <readi>
80100fa6:	83 c4 10             	add    $0x10,%esp
80100fa9:	83 f8 20             	cmp    $0x20,%eax
80100fac:	0f 84 5e ff ff ff    	je     80100f10 <exec+0xc0>
    freevm(pgdir);
80100fb2:	83 ec 0c             	sub    $0xc,%esp
80100fb5:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100fbb:	e8 00 6b 00 00       	call   80107ac0 <freevm>
  if(ip){
80100fc0:	83 c4 10             	add    $0x10,%esp
80100fc3:	e9 e2 fe ff ff       	jmp    80100eaa <exec+0x5a>
80100fc8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100fcf:	90                   	nop
80100fd0:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
80100fd6:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
80100fdc:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80100fe2:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
80100fe8:	83 ec 0c             	sub    $0xc,%esp
80100feb:	53                   	push   %ebx
80100fec:	e8 ef 0d 00 00       	call   80101de0 <iunlockput>
  end_op();
80100ff1:	e8 8a 21 00 00       	call   80103180 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100ff6:	83 c4 0c             	add    $0xc,%esp
80100ff9:	56                   	push   %esi
80100ffa:	57                   	push   %edi
80100ffb:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80101001:	57                   	push   %edi
80101002:	e8 59 69 00 00       	call   80107960 <allocuvm>
80101007:	83 c4 10             	add    $0x10,%esp
8010100a:	89 c6                	mov    %eax,%esi
8010100c:	85 c0                	test   %eax,%eax
8010100e:	0f 84 94 00 00 00    	je     801010a8 <exec+0x258>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80101014:	83 ec 08             	sub    $0x8,%esp
80101017:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  for(argc = 0; argv[argc]; argc++) {
8010101d:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
8010101f:	50                   	push   %eax
80101020:	57                   	push   %edi
  for(argc = 0; argv[argc]; argc++) {
80101021:	31 ff                	xor    %edi,%edi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80101023:	e8 b8 6b 00 00       	call   80107be0 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80101028:	8b 45 0c             	mov    0xc(%ebp),%eax
8010102b:	83 c4 10             	add    $0x10,%esp
8010102e:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80101034:	8b 00                	mov    (%eax),%eax
80101036:	85 c0                	test   %eax,%eax
80101038:	0f 84 8b 00 00 00    	je     801010c9 <exec+0x279>
8010103e:	89 b5 f0 fe ff ff    	mov    %esi,-0x110(%ebp)
80101044:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
8010104a:	eb 23                	jmp    8010106f <exec+0x21f>
8010104c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101050:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80101053:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
8010105a:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
8010105d:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80101063:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80101066:	85 c0                	test   %eax,%eax
80101068:	74 59                	je     801010c3 <exec+0x273>
    if(argc >= MAXARG)
8010106a:	83 ff 20             	cmp    $0x20,%edi
8010106d:	74 39                	je     801010a8 <exec+0x258>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
8010106f:	83 ec 0c             	sub    $0xc,%esp
80101072:	50                   	push   %eax
80101073:	e8 38 43 00 00       	call   801053b0 <strlen>
80101078:	f7 d0                	not    %eax
8010107a:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
8010107c:	58                   	pop    %eax
8010107d:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80101080:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80101083:	ff 34 b8             	pushl  (%eax,%edi,4)
80101086:	e8 25 43 00 00       	call   801053b0 <strlen>
8010108b:	83 c0 01             	add    $0x1,%eax
8010108e:	50                   	push   %eax
8010108f:	8b 45 0c             	mov    0xc(%ebp),%eax
80101092:	ff 34 b8             	pushl  (%eax,%edi,4)
80101095:	53                   	push   %ebx
80101096:	56                   	push   %esi
80101097:	e8 a4 6c 00 00       	call   80107d40 <copyout>
8010109c:	83 c4 20             	add    $0x20,%esp
8010109f:	85 c0                	test   %eax,%eax
801010a1:	79 ad                	jns    80101050 <exec+0x200>
801010a3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801010a7:	90                   	nop
    freevm(pgdir);
801010a8:	83 ec 0c             	sub    $0xc,%esp
801010ab:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
801010b1:	e8 0a 6a 00 00       	call   80107ac0 <freevm>
801010b6:	83 c4 10             	add    $0x10,%esp
  return -1;
801010b9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801010be:	e9 fd fd ff ff       	jmp    80100ec0 <exec+0x70>
801010c3:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
801010c9:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
801010d0:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
801010d2:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
801010d9:	00 00 00 00 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
801010dd:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
801010df:	83 c0 0c             	add    $0xc,%eax
  ustack[1] = argc;
801010e2:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  sp -= (3+argc+1) * 4;
801010e8:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
801010ea:	50                   	push   %eax
801010eb:	52                   	push   %edx
801010ec:	53                   	push   %ebx
801010ed:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
  ustack[0] = 0xffffffff;  // fake return PC
801010f3:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
801010fa:	ff ff ff 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
801010fd:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80101103:	e8 38 6c 00 00       	call   80107d40 <copyout>
80101108:	83 c4 10             	add    $0x10,%esp
8010110b:	85 c0                	test   %eax,%eax
8010110d:	78 99                	js     801010a8 <exec+0x258>
  for(last=s=path; *s; s++)
8010110f:	8b 45 08             	mov    0x8(%ebp),%eax
80101112:	8b 55 08             	mov    0x8(%ebp),%edx
80101115:	0f b6 00             	movzbl (%eax),%eax
80101118:	84 c0                	test   %al,%al
8010111a:	74 13                	je     8010112f <exec+0x2df>
8010111c:	89 d1                	mov    %edx,%ecx
8010111e:	66 90                	xchg   %ax,%ax
    if(*s == '/')
80101120:	83 c1 01             	add    $0x1,%ecx
80101123:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
80101125:	0f b6 01             	movzbl (%ecx),%eax
    if(*s == '/')
80101128:	0f 44 d1             	cmove  %ecx,%edx
  for(last=s=path; *s; s++)
8010112b:	84 c0                	test   %al,%al
8010112d:	75 f1                	jne    80101120 <exec+0x2d0>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
8010112f:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
80101135:	83 ec 04             	sub    $0x4,%esp
80101138:	6a 10                	push   $0x10
8010113a:	89 f8                	mov    %edi,%eax
8010113c:	52                   	push   %edx
8010113d:	83 c0 6c             	add    $0x6c,%eax
80101140:	50                   	push   %eax
80101141:	e8 2a 42 00 00       	call   80105370 <safestrcpy>
  curproc->pgdir = pgdir;
80101146:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
  oldpgdir = curproc->pgdir;
8010114c:	89 f8                	mov    %edi,%eax
8010114e:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->sz = sz;
80101151:	89 30                	mov    %esi,(%eax)
  curproc->pgdir = pgdir;
80101153:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->tf->eip = elf.entry;  // main
80101156:	89 c1                	mov    %eax,%ecx
80101158:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
8010115e:	8b 40 18             	mov    0x18(%eax),%eax
80101161:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80101164:	8b 41 18             	mov    0x18(%ecx),%eax
80101167:	89 58 44             	mov    %ebx,0x44(%eax)
  curproc->qnum = 1;
8010116a:	c7 41 7c 01 00 00 00 	movl   $0x1,0x7c(%ecx)
  switchuvm(curproc);
80101171:	89 0c 24             	mov    %ecx,(%esp)
80101174:	e8 87 65 00 00       	call   80107700 <switchuvm>
  freevm(oldpgdir);
80101179:	89 3c 24             	mov    %edi,(%esp)
8010117c:	e8 3f 69 00 00       	call   80107ac0 <freevm>
  return 0;
80101181:	83 c4 10             	add    $0x10,%esp
80101184:	31 c0                	xor    %eax,%eax
80101186:	e9 35 fd ff ff       	jmp    80100ec0 <exec+0x70>
    end_op();
8010118b:	e8 f0 1f 00 00       	call   80103180 <end_op>
    cprintf("exec: fail\n");
80101190:	83 ec 0c             	sub    $0xc,%esp
80101193:	68 b9 7e 10 80       	push   $0x80107eb9
80101198:	e8 13 f5 ff ff       	call   801006b0 <cprintf>
    return -1;
8010119d:	83 c4 10             	add    $0x10,%esp
801011a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801011a5:	e9 16 fd ff ff       	jmp    80100ec0 <exec+0x70>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
801011aa:	31 ff                	xor    %edi,%edi
801011ac:	be 00 20 00 00       	mov    $0x2000,%esi
801011b1:	e9 32 fe ff ff       	jmp    80100fe8 <exec+0x198>
801011b6:	66 90                	xchg   %ax,%ax
801011b8:	66 90                	xchg   %ax,%ax
801011ba:	66 90                	xchg   %ax,%ax
801011bc:	66 90                	xchg   %ax,%ax
801011be:	66 90                	xchg   %ax,%ax

801011c0 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
801011c0:	f3 0f 1e fb          	endbr32 
801011c4:	55                   	push   %ebp
801011c5:	89 e5                	mov    %esp,%ebp
801011c7:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
801011ca:	68 c5 7e 10 80       	push   $0x80107ec5
801011cf:	68 00 10 11 80       	push   $0x80111000
801011d4:	e8 47 3d 00 00       	call   80104f20 <initlock>
}
801011d9:	83 c4 10             	add    $0x10,%esp
801011dc:	c9                   	leave  
801011dd:	c3                   	ret    
801011de:	66 90                	xchg   %ax,%ax

801011e0 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
801011e0:	f3 0f 1e fb          	endbr32 
801011e4:	55                   	push   %ebp
801011e5:	89 e5                	mov    %esp,%ebp
801011e7:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
801011e8:	bb 34 10 11 80       	mov    $0x80111034,%ebx
{
801011ed:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
801011f0:	68 00 10 11 80       	push   $0x80111000
801011f5:	e8 a6 3e 00 00       	call   801050a0 <acquire>
801011fa:	83 c4 10             	add    $0x10,%esp
801011fd:	eb 0c                	jmp    8010120b <filealloc+0x2b>
801011ff:	90                   	nop
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80101200:	83 c3 18             	add    $0x18,%ebx
80101203:	81 fb 94 19 11 80    	cmp    $0x80111994,%ebx
80101209:	74 25                	je     80101230 <filealloc+0x50>
    if(f->ref == 0){
8010120b:	8b 43 04             	mov    0x4(%ebx),%eax
8010120e:	85 c0                	test   %eax,%eax
80101210:	75 ee                	jne    80101200 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80101212:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80101215:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
8010121c:	68 00 10 11 80       	push   $0x80111000
80101221:	e8 3a 3f 00 00       	call   80105160 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80101226:	89 d8                	mov    %ebx,%eax
      return f;
80101228:	83 c4 10             	add    $0x10,%esp
}
8010122b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010122e:	c9                   	leave  
8010122f:	c3                   	ret    
  release(&ftable.lock);
80101230:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80101233:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80101235:	68 00 10 11 80       	push   $0x80111000
8010123a:	e8 21 3f 00 00       	call   80105160 <release>
}
8010123f:	89 d8                	mov    %ebx,%eax
  return 0;
80101241:	83 c4 10             	add    $0x10,%esp
}
80101244:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101247:	c9                   	leave  
80101248:	c3                   	ret    
80101249:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101250 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80101250:	f3 0f 1e fb          	endbr32 
80101254:	55                   	push   %ebp
80101255:	89 e5                	mov    %esp,%ebp
80101257:	53                   	push   %ebx
80101258:	83 ec 10             	sub    $0x10,%esp
8010125b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
8010125e:	68 00 10 11 80       	push   $0x80111000
80101263:	e8 38 3e 00 00       	call   801050a0 <acquire>
  if(f->ref < 1)
80101268:	8b 43 04             	mov    0x4(%ebx),%eax
8010126b:	83 c4 10             	add    $0x10,%esp
8010126e:	85 c0                	test   %eax,%eax
80101270:	7e 1a                	jle    8010128c <filedup+0x3c>
    panic("filedup");
  f->ref++;
80101272:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80101275:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80101278:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
8010127b:	68 00 10 11 80       	push   $0x80111000
80101280:	e8 db 3e 00 00       	call   80105160 <release>
  return f;
}
80101285:	89 d8                	mov    %ebx,%eax
80101287:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010128a:	c9                   	leave  
8010128b:	c3                   	ret    
    panic("filedup");
8010128c:	83 ec 0c             	sub    $0xc,%esp
8010128f:	68 cc 7e 10 80       	push   $0x80107ecc
80101294:	e8 f7 f0 ff ff       	call   80100390 <panic>
80101299:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801012a0 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
801012a0:	f3 0f 1e fb          	endbr32 
801012a4:	55                   	push   %ebp
801012a5:	89 e5                	mov    %esp,%ebp
801012a7:	57                   	push   %edi
801012a8:	56                   	push   %esi
801012a9:	53                   	push   %ebx
801012aa:	83 ec 28             	sub    $0x28,%esp
801012ad:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
801012b0:	68 00 10 11 80       	push   $0x80111000
801012b5:	e8 e6 3d 00 00       	call   801050a0 <acquire>
  if(f->ref < 1)
801012ba:	8b 53 04             	mov    0x4(%ebx),%edx
801012bd:	83 c4 10             	add    $0x10,%esp
801012c0:	85 d2                	test   %edx,%edx
801012c2:	0f 8e a1 00 00 00    	jle    80101369 <fileclose+0xc9>
    panic("fileclose");
  if(--f->ref > 0){
801012c8:	83 ea 01             	sub    $0x1,%edx
801012cb:	89 53 04             	mov    %edx,0x4(%ebx)
801012ce:	75 40                	jne    80101310 <fileclose+0x70>
    release(&ftable.lock);
    return;
  }
  ff = *f;
801012d0:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
801012d4:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
801012d7:	8b 3b                	mov    (%ebx),%edi
  f->type = FD_NONE;
801012d9:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
801012df:	8b 73 0c             	mov    0xc(%ebx),%esi
801012e2:	88 45 e7             	mov    %al,-0x19(%ebp)
801012e5:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
801012e8:	68 00 10 11 80       	push   $0x80111000
  ff = *f;
801012ed:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
801012f0:	e8 6b 3e 00 00       	call   80105160 <release>

  if(ff.type == FD_PIPE)
801012f5:	83 c4 10             	add    $0x10,%esp
801012f8:	83 ff 01             	cmp    $0x1,%edi
801012fb:	74 53                	je     80101350 <fileclose+0xb0>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
801012fd:	83 ff 02             	cmp    $0x2,%edi
80101300:	74 26                	je     80101328 <fileclose+0x88>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80101302:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101305:	5b                   	pop    %ebx
80101306:	5e                   	pop    %esi
80101307:	5f                   	pop    %edi
80101308:	5d                   	pop    %ebp
80101309:	c3                   	ret    
8010130a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&ftable.lock);
80101310:	c7 45 08 00 10 11 80 	movl   $0x80111000,0x8(%ebp)
}
80101317:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010131a:	5b                   	pop    %ebx
8010131b:	5e                   	pop    %esi
8010131c:	5f                   	pop    %edi
8010131d:	5d                   	pop    %ebp
    release(&ftable.lock);
8010131e:	e9 3d 3e 00 00       	jmp    80105160 <release>
80101323:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101327:	90                   	nop
    begin_op();
80101328:	e8 e3 1d 00 00       	call   80103110 <begin_op>
    iput(ff.ip);
8010132d:	83 ec 0c             	sub    $0xc,%esp
80101330:	ff 75 e0             	pushl  -0x20(%ebp)
80101333:	e8 38 09 00 00       	call   80101c70 <iput>
    end_op();
80101338:	83 c4 10             	add    $0x10,%esp
}
8010133b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010133e:	5b                   	pop    %ebx
8010133f:	5e                   	pop    %esi
80101340:	5f                   	pop    %edi
80101341:	5d                   	pop    %ebp
    end_op();
80101342:	e9 39 1e 00 00       	jmp    80103180 <end_op>
80101347:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010134e:	66 90                	xchg   %ax,%ax
    pipeclose(ff.pipe, ff.writable);
80101350:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80101354:	83 ec 08             	sub    $0x8,%esp
80101357:	53                   	push   %ebx
80101358:	56                   	push   %esi
80101359:	e8 82 25 00 00       	call   801038e0 <pipeclose>
8010135e:	83 c4 10             	add    $0x10,%esp
}
80101361:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101364:	5b                   	pop    %ebx
80101365:	5e                   	pop    %esi
80101366:	5f                   	pop    %edi
80101367:	5d                   	pop    %ebp
80101368:	c3                   	ret    
    panic("fileclose");
80101369:	83 ec 0c             	sub    $0xc,%esp
8010136c:	68 d4 7e 10 80       	push   $0x80107ed4
80101371:	e8 1a f0 ff ff       	call   80100390 <panic>
80101376:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010137d:	8d 76 00             	lea    0x0(%esi),%esi

80101380 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80101380:	f3 0f 1e fb          	endbr32 
80101384:	55                   	push   %ebp
80101385:	89 e5                	mov    %esp,%ebp
80101387:	53                   	push   %ebx
80101388:	83 ec 04             	sub    $0x4,%esp
8010138b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
8010138e:	83 3b 02             	cmpl   $0x2,(%ebx)
80101391:	75 2d                	jne    801013c0 <filestat+0x40>
    ilock(f->ip);
80101393:	83 ec 0c             	sub    $0xc,%esp
80101396:	ff 73 10             	pushl  0x10(%ebx)
80101399:	e8 a2 07 00 00       	call   80101b40 <ilock>
    stati(f->ip, st);
8010139e:	58                   	pop    %eax
8010139f:	5a                   	pop    %edx
801013a0:	ff 75 0c             	pushl  0xc(%ebp)
801013a3:	ff 73 10             	pushl  0x10(%ebx)
801013a6:	e8 65 0a 00 00       	call   80101e10 <stati>
    iunlock(f->ip);
801013ab:	59                   	pop    %ecx
801013ac:	ff 73 10             	pushl  0x10(%ebx)
801013af:	e8 6c 08 00 00       	call   80101c20 <iunlock>
    return 0;
  }
  return -1;
}
801013b4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
801013b7:	83 c4 10             	add    $0x10,%esp
801013ba:	31 c0                	xor    %eax,%eax
}
801013bc:	c9                   	leave  
801013bd:	c3                   	ret    
801013be:	66 90                	xchg   %ax,%ax
801013c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
801013c3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801013c8:	c9                   	leave  
801013c9:	c3                   	ret    
801013ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801013d0 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
801013d0:	f3 0f 1e fb          	endbr32 
801013d4:	55                   	push   %ebp
801013d5:	89 e5                	mov    %esp,%ebp
801013d7:	57                   	push   %edi
801013d8:	56                   	push   %esi
801013d9:	53                   	push   %ebx
801013da:	83 ec 0c             	sub    $0xc,%esp
801013dd:	8b 5d 08             	mov    0x8(%ebp),%ebx
801013e0:	8b 75 0c             	mov    0xc(%ebp),%esi
801013e3:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
801013e6:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
801013ea:	74 64                	je     80101450 <fileread+0x80>
    return -1;
  if(f->type == FD_PIPE)
801013ec:	8b 03                	mov    (%ebx),%eax
801013ee:	83 f8 01             	cmp    $0x1,%eax
801013f1:	74 45                	je     80101438 <fileread+0x68>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
801013f3:	83 f8 02             	cmp    $0x2,%eax
801013f6:	75 5f                	jne    80101457 <fileread+0x87>
    ilock(f->ip);
801013f8:	83 ec 0c             	sub    $0xc,%esp
801013fb:	ff 73 10             	pushl  0x10(%ebx)
801013fe:	e8 3d 07 00 00       	call   80101b40 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80101403:	57                   	push   %edi
80101404:	ff 73 14             	pushl  0x14(%ebx)
80101407:	56                   	push   %esi
80101408:	ff 73 10             	pushl  0x10(%ebx)
8010140b:	e8 30 0a 00 00       	call   80101e40 <readi>
80101410:	83 c4 20             	add    $0x20,%esp
80101413:	89 c6                	mov    %eax,%esi
80101415:	85 c0                	test   %eax,%eax
80101417:	7e 03                	jle    8010141c <fileread+0x4c>
      f->off += r;
80101419:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
8010141c:	83 ec 0c             	sub    $0xc,%esp
8010141f:	ff 73 10             	pushl  0x10(%ebx)
80101422:	e8 f9 07 00 00       	call   80101c20 <iunlock>
    return r;
80101427:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
8010142a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010142d:	89 f0                	mov    %esi,%eax
8010142f:	5b                   	pop    %ebx
80101430:	5e                   	pop    %esi
80101431:	5f                   	pop    %edi
80101432:	5d                   	pop    %ebp
80101433:	c3                   	ret    
80101434:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return piperead(f->pipe, addr, n);
80101438:	8b 43 0c             	mov    0xc(%ebx),%eax
8010143b:	89 45 08             	mov    %eax,0x8(%ebp)
}
8010143e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101441:	5b                   	pop    %ebx
80101442:	5e                   	pop    %esi
80101443:	5f                   	pop    %edi
80101444:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
80101445:	e9 36 26 00 00       	jmp    80103a80 <piperead>
8010144a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101450:	be ff ff ff ff       	mov    $0xffffffff,%esi
80101455:	eb d3                	jmp    8010142a <fileread+0x5a>
  panic("fileread");
80101457:	83 ec 0c             	sub    $0xc,%esp
8010145a:	68 de 7e 10 80       	push   $0x80107ede
8010145f:	e8 2c ef ff ff       	call   80100390 <panic>
80101464:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010146b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010146f:	90                   	nop

80101470 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101470:	f3 0f 1e fb          	endbr32 
80101474:	55                   	push   %ebp
80101475:	89 e5                	mov    %esp,%ebp
80101477:	57                   	push   %edi
80101478:	56                   	push   %esi
80101479:	53                   	push   %ebx
8010147a:	83 ec 1c             	sub    $0x1c,%esp
8010147d:	8b 45 0c             	mov    0xc(%ebp),%eax
80101480:	8b 75 08             	mov    0x8(%ebp),%esi
80101483:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101486:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
80101489:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
{
8010148d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
80101490:	0f 84 c1 00 00 00    	je     80101557 <filewrite+0xe7>
    return -1;
  if(f->type == FD_PIPE)
80101496:	8b 06                	mov    (%esi),%eax
80101498:	83 f8 01             	cmp    $0x1,%eax
8010149b:	0f 84 c3 00 00 00    	je     80101564 <filewrite+0xf4>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
801014a1:	83 f8 02             	cmp    $0x2,%eax
801014a4:	0f 85 cc 00 00 00    	jne    80101576 <filewrite+0x106>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
801014aa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
801014ad:	31 ff                	xor    %edi,%edi
    while(i < n){
801014af:	85 c0                	test   %eax,%eax
801014b1:	7f 34                	jg     801014e7 <filewrite+0x77>
801014b3:	e9 98 00 00 00       	jmp    80101550 <filewrite+0xe0>
801014b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801014bf:	90                   	nop
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
801014c0:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
801014c3:	83 ec 0c             	sub    $0xc,%esp
801014c6:	ff 76 10             	pushl  0x10(%esi)
        f->off += r;
801014c9:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
801014cc:	e8 4f 07 00 00       	call   80101c20 <iunlock>
      end_op();
801014d1:	e8 aa 1c 00 00       	call   80103180 <end_op>

      if(r < 0)
        break;
      if(r != n1)
801014d6:	8b 45 e0             	mov    -0x20(%ebp),%eax
801014d9:	83 c4 10             	add    $0x10,%esp
801014dc:	39 c3                	cmp    %eax,%ebx
801014de:	75 60                	jne    80101540 <filewrite+0xd0>
        panic("short filewrite");
      i += r;
801014e0:	01 df                	add    %ebx,%edi
    while(i < n){
801014e2:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801014e5:	7e 69                	jle    80101550 <filewrite+0xe0>
      int n1 = n - i;
801014e7:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801014ea:	b8 00 06 00 00       	mov    $0x600,%eax
801014ef:	29 fb                	sub    %edi,%ebx
      if(n1 > max)
801014f1:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
801014f7:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
801014fa:	e8 11 1c 00 00       	call   80103110 <begin_op>
      ilock(f->ip);
801014ff:	83 ec 0c             	sub    $0xc,%esp
80101502:	ff 76 10             	pushl  0x10(%esi)
80101505:	e8 36 06 00 00       	call   80101b40 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
8010150a:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010150d:	53                   	push   %ebx
8010150e:	ff 76 14             	pushl  0x14(%esi)
80101511:	01 f8                	add    %edi,%eax
80101513:	50                   	push   %eax
80101514:	ff 76 10             	pushl  0x10(%esi)
80101517:	e8 24 0a 00 00       	call   80101f40 <writei>
8010151c:	83 c4 20             	add    $0x20,%esp
8010151f:	85 c0                	test   %eax,%eax
80101521:	7f 9d                	jg     801014c0 <filewrite+0x50>
      iunlock(f->ip);
80101523:	83 ec 0c             	sub    $0xc,%esp
80101526:	ff 76 10             	pushl  0x10(%esi)
80101529:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010152c:	e8 ef 06 00 00       	call   80101c20 <iunlock>
      end_op();
80101531:	e8 4a 1c 00 00       	call   80103180 <end_op>
      if(r < 0)
80101536:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101539:	83 c4 10             	add    $0x10,%esp
8010153c:	85 c0                	test   %eax,%eax
8010153e:	75 17                	jne    80101557 <filewrite+0xe7>
        panic("short filewrite");
80101540:	83 ec 0c             	sub    $0xc,%esp
80101543:	68 e7 7e 10 80       	push   $0x80107ee7
80101548:	e8 43 ee ff ff       	call   80100390 <panic>
8010154d:	8d 76 00             	lea    0x0(%esi),%esi
    }
    return i == n ? n : -1;
80101550:	89 f8                	mov    %edi,%eax
80101552:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
80101555:	74 05                	je     8010155c <filewrite+0xec>
80101557:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  panic("filewrite");
}
8010155c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010155f:	5b                   	pop    %ebx
80101560:	5e                   	pop    %esi
80101561:	5f                   	pop    %edi
80101562:	5d                   	pop    %ebp
80101563:	c3                   	ret    
    return pipewrite(f->pipe, addr, n);
80101564:	8b 46 0c             	mov    0xc(%esi),%eax
80101567:	89 45 08             	mov    %eax,0x8(%ebp)
}
8010156a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010156d:	5b                   	pop    %ebx
8010156e:	5e                   	pop    %esi
8010156f:	5f                   	pop    %edi
80101570:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
80101571:	e9 0a 24 00 00       	jmp    80103980 <pipewrite>
  panic("filewrite");
80101576:	83 ec 0c             	sub    $0xc,%esp
80101579:	68 ed 7e 10 80       	push   $0x80107eed
8010157e:	e8 0d ee ff ff       	call   80100390 <panic>
80101583:	66 90                	xchg   %ax,%ax
80101585:	66 90                	xchg   %ax,%ax
80101587:	66 90                	xchg   %ax,%ax
80101589:	66 90                	xchg   %ax,%ax
8010158b:	66 90                	xchg   %ax,%ax
8010158d:	66 90                	xchg   %ax,%ax
8010158f:	90                   	nop

80101590 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101590:	55                   	push   %ebp
80101591:	89 c1                	mov    %eax,%ecx
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
80101593:	89 d0                	mov    %edx,%eax
80101595:	c1 e8 0c             	shr    $0xc,%eax
80101598:	03 05 18 1a 11 80    	add    0x80111a18,%eax
{
8010159e:	89 e5                	mov    %esp,%ebp
801015a0:	56                   	push   %esi
801015a1:	53                   	push   %ebx
801015a2:	89 d3                	mov    %edx,%ebx
  bp = bread(dev, BBLOCK(b, sb));
801015a4:	83 ec 08             	sub    $0x8,%esp
801015a7:	50                   	push   %eax
801015a8:	51                   	push   %ecx
801015a9:	e8 22 eb ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
801015ae:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
801015b0:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
801015b3:	ba 01 00 00 00       	mov    $0x1,%edx
801015b8:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
801015bb:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
801015c1:	83 c4 10             	add    $0x10,%esp
  m = 1 << (bi % 8);
801015c4:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
801015c6:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
801015cb:	85 d1                	test   %edx,%ecx
801015cd:	74 25                	je     801015f4 <bfree+0x64>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
801015cf:	f7 d2                	not    %edx
  log_write(bp);
801015d1:	83 ec 0c             	sub    $0xc,%esp
801015d4:	89 c6                	mov    %eax,%esi
  bp->data[bi/8] &= ~m;
801015d6:	21 ca                	and    %ecx,%edx
801015d8:	88 54 18 5c          	mov    %dl,0x5c(%eax,%ebx,1)
  log_write(bp);
801015dc:	50                   	push   %eax
801015dd:	e8 0e 1d 00 00       	call   801032f0 <log_write>
  brelse(bp);
801015e2:	89 34 24             	mov    %esi,(%esp)
801015e5:	e8 06 ec ff ff       	call   801001f0 <brelse>
}
801015ea:	83 c4 10             	add    $0x10,%esp
801015ed:	8d 65 f8             	lea    -0x8(%ebp),%esp
801015f0:	5b                   	pop    %ebx
801015f1:	5e                   	pop    %esi
801015f2:	5d                   	pop    %ebp
801015f3:	c3                   	ret    
    panic("freeing free block");
801015f4:	83 ec 0c             	sub    $0xc,%esp
801015f7:	68 f7 7e 10 80       	push   $0x80107ef7
801015fc:	e8 8f ed ff ff       	call   80100390 <panic>
80101601:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101608:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010160f:	90                   	nop

80101610 <balloc>:
{
80101610:	55                   	push   %ebp
80101611:	89 e5                	mov    %esp,%ebp
80101613:	57                   	push   %edi
80101614:	56                   	push   %esi
80101615:	53                   	push   %ebx
80101616:	83 ec 1c             	sub    $0x1c,%esp
  for(b = 0; b < sb.size; b += BPB){
80101619:	8b 0d 00 1a 11 80    	mov    0x80111a00,%ecx
{
8010161f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101622:	85 c9                	test   %ecx,%ecx
80101624:	0f 84 87 00 00 00    	je     801016b1 <balloc+0xa1>
8010162a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101631:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101634:	83 ec 08             	sub    $0x8,%esp
80101637:	89 f0                	mov    %esi,%eax
80101639:	c1 f8 0c             	sar    $0xc,%eax
8010163c:	03 05 18 1a 11 80    	add    0x80111a18,%eax
80101642:	50                   	push   %eax
80101643:	ff 75 d8             	pushl  -0x28(%ebp)
80101646:	e8 85 ea ff ff       	call   801000d0 <bread>
8010164b:	83 c4 10             	add    $0x10,%esp
8010164e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101651:	a1 00 1a 11 80       	mov    0x80111a00,%eax
80101656:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101659:	31 c0                	xor    %eax,%eax
8010165b:	eb 2f                	jmp    8010168c <balloc+0x7c>
8010165d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101660:	89 c1                	mov    %eax,%ecx
80101662:	bb 01 00 00 00       	mov    $0x1,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101667:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
8010166a:	83 e1 07             	and    $0x7,%ecx
8010166d:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010166f:	89 c1                	mov    %eax,%ecx
80101671:	c1 f9 03             	sar    $0x3,%ecx
80101674:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
80101679:	89 fa                	mov    %edi,%edx
8010167b:	85 df                	test   %ebx,%edi
8010167d:	74 41                	je     801016c0 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010167f:	83 c0 01             	add    $0x1,%eax
80101682:	83 c6 01             	add    $0x1,%esi
80101685:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010168a:	74 05                	je     80101691 <balloc+0x81>
8010168c:	39 75 e0             	cmp    %esi,-0x20(%ebp)
8010168f:	77 cf                	ja     80101660 <balloc+0x50>
    brelse(bp);
80101691:	83 ec 0c             	sub    $0xc,%esp
80101694:	ff 75 e4             	pushl  -0x1c(%ebp)
80101697:	e8 54 eb ff ff       	call   801001f0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
8010169c:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
801016a3:	83 c4 10             	add    $0x10,%esp
801016a6:	8b 45 dc             	mov    -0x24(%ebp),%eax
801016a9:	39 05 00 1a 11 80    	cmp    %eax,0x80111a00
801016af:	77 80                	ja     80101631 <balloc+0x21>
  panic("balloc: out of blocks");
801016b1:	83 ec 0c             	sub    $0xc,%esp
801016b4:	68 0a 7f 10 80       	push   $0x80107f0a
801016b9:	e8 d2 ec ff ff       	call   80100390 <panic>
801016be:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
801016c0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
801016c3:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
801016c6:	09 da                	or     %ebx,%edx
801016c8:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
801016cc:	57                   	push   %edi
801016cd:	e8 1e 1c 00 00       	call   801032f0 <log_write>
        brelse(bp);
801016d2:	89 3c 24             	mov    %edi,(%esp)
801016d5:	e8 16 eb ff ff       	call   801001f0 <brelse>
  bp = bread(dev, bno);
801016da:	58                   	pop    %eax
801016db:	5a                   	pop    %edx
801016dc:	56                   	push   %esi
801016dd:	ff 75 d8             	pushl  -0x28(%ebp)
801016e0:	e8 eb e9 ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
801016e5:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, bno);
801016e8:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801016ea:	8d 40 5c             	lea    0x5c(%eax),%eax
801016ed:	68 00 02 00 00       	push   $0x200
801016f2:	6a 00                	push   $0x0
801016f4:	50                   	push   %eax
801016f5:	e8 b6 3a 00 00       	call   801051b0 <memset>
  log_write(bp);
801016fa:	89 1c 24             	mov    %ebx,(%esp)
801016fd:	e8 ee 1b 00 00       	call   801032f0 <log_write>
  brelse(bp);
80101702:	89 1c 24             	mov    %ebx,(%esp)
80101705:	e8 e6 ea ff ff       	call   801001f0 <brelse>
}
8010170a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010170d:	89 f0                	mov    %esi,%eax
8010170f:	5b                   	pop    %ebx
80101710:	5e                   	pop    %esi
80101711:	5f                   	pop    %edi
80101712:	5d                   	pop    %ebp
80101713:	c3                   	ret    
80101714:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010171b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010171f:	90                   	nop

80101720 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101720:	55                   	push   %ebp
80101721:	89 e5                	mov    %esp,%ebp
80101723:	57                   	push   %edi
80101724:	89 c7                	mov    %eax,%edi
80101726:	56                   	push   %esi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101727:	31 f6                	xor    %esi,%esi
{
80101729:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010172a:	bb 54 1a 11 80       	mov    $0x80111a54,%ebx
{
8010172f:	83 ec 28             	sub    $0x28,%esp
80101732:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101735:	68 20 1a 11 80       	push   $0x80111a20
8010173a:	e8 61 39 00 00       	call   801050a0 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010173f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  acquire(&icache.lock);
80101742:	83 c4 10             	add    $0x10,%esp
80101745:	eb 1b                	jmp    80101762 <iget+0x42>
80101747:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010174e:	66 90                	xchg   %ax,%ax
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101750:	39 3b                	cmp    %edi,(%ebx)
80101752:	74 6c                	je     801017c0 <iget+0xa0>
80101754:	81 c3 90 00 00 00    	add    $0x90,%ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010175a:	81 fb 74 36 11 80    	cmp    $0x80113674,%ebx
80101760:	73 26                	jae    80101788 <iget+0x68>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101762:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101765:	85 c9                	test   %ecx,%ecx
80101767:	7f e7                	jg     80101750 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101769:	85 f6                	test   %esi,%esi
8010176b:	75 e7                	jne    80101754 <iget+0x34>
8010176d:	89 d8                	mov    %ebx,%eax
8010176f:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101775:	85 c9                	test   %ecx,%ecx
80101777:	75 6e                	jne    801017e7 <iget+0xc7>
80101779:	89 c6                	mov    %eax,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010177b:	81 fb 74 36 11 80    	cmp    $0x80113674,%ebx
80101781:	72 df                	jb     80101762 <iget+0x42>
80101783:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101787:	90                   	nop
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101788:	85 f6                	test   %esi,%esi
8010178a:	74 73                	je     801017ff <iget+0xdf>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
8010178c:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
8010178f:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101791:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
80101794:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
8010179b:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
801017a2:	68 20 1a 11 80       	push   $0x80111a20
801017a7:	e8 b4 39 00 00       	call   80105160 <release>

  return ip;
801017ac:	83 c4 10             	add    $0x10,%esp
}
801017af:	8d 65 f4             	lea    -0xc(%ebp),%esp
801017b2:	89 f0                	mov    %esi,%eax
801017b4:	5b                   	pop    %ebx
801017b5:	5e                   	pop    %esi
801017b6:	5f                   	pop    %edi
801017b7:	5d                   	pop    %ebp
801017b8:	c3                   	ret    
801017b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801017c0:	39 53 04             	cmp    %edx,0x4(%ebx)
801017c3:	75 8f                	jne    80101754 <iget+0x34>
      release(&icache.lock);
801017c5:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
801017c8:	83 c1 01             	add    $0x1,%ecx
      return ip;
801017cb:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
801017cd:	68 20 1a 11 80       	push   $0x80111a20
      ip->ref++;
801017d2:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
801017d5:	e8 86 39 00 00       	call   80105160 <release>
      return ip;
801017da:	83 c4 10             	add    $0x10,%esp
}
801017dd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801017e0:	89 f0                	mov    %esi,%eax
801017e2:	5b                   	pop    %ebx
801017e3:	5e                   	pop    %esi
801017e4:	5f                   	pop    %edi
801017e5:	5d                   	pop    %ebp
801017e6:	c3                   	ret    
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801017e7:	81 fb 74 36 11 80    	cmp    $0x80113674,%ebx
801017ed:	73 10                	jae    801017ff <iget+0xdf>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801017ef:	8b 4b 08             	mov    0x8(%ebx),%ecx
801017f2:	85 c9                	test   %ecx,%ecx
801017f4:	0f 8f 56 ff ff ff    	jg     80101750 <iget+0x30>
801017fa:	e9 6e ff ff ff       	jmp    8010176d <iget+0x4d>
    panic("iget: no inodes");
801017ff:	83 ec 0c             	sub    $0xc,%esp
80101802:	68 20 7f 10 80       	push   $0x80107f20
80101807:	e8 84 eb ff ff       	call   80100390 <panic>
8010180c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101810 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101810:	55                   	push   %ebp
80101811:	89 e5                	mov    %esp,%ebp
80101813:	57                   	push   %edi
80101814:	56                   	push   %esi
80101815:	89 c6                	mov    %eax,%esi
80101817:	53                   	push   %ebx
80101818:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010181b:	83 fa 0b             	cmp    $0xb,%edx
8010181e:	0f 86 84 00 00 00    	jbe    801018a8 <bmap+0x98>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80101824:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
80101827:	83 fb 7f             	cmp    $0x7f,%ebx
8010182a:	0f 87 98 00 00 00    	ja     801018c8 <bmap+0xb8>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101830:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101836:	8b 16                	mov    (%esi),%edx
80101838:	85 c0                	test   %eax,%eax
8010183a:	74 54                	je     80101890 <bmap+0x80>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
8010183c:	83 ec 08             	sub    $0x8,%esp
8010183f:	50                   	push   %eax
80101840:	52                   	push   %edx
80101841:	e8 8a e8 ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101846:	83 c4 10             	add    $0x10,%esp
80101849:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
    bp = bread(ip->dev, addr);
8010184d:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
8010184f:	8b 1a                	mov    (%edx),%ebx
80101851:	85 db                	test   %ebx,%ebx
80101853:	74 1b                	je     80101870 <bmap+0x60>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
80101855:	83 ec 0c             	sub    $0xc,%esp
80101858:	57                   	push   %edi
80101859:	e8 92 e9 ff ff       	call   801001f0 <brelse>
    return addr;
8010185e:	83 c4 10             	add    $0x10,%esp
  }

  panic("bmap: out of range");
}
80101861:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101864:	89 d8                	mov    %ebx,%eax
80101866:	5b                   	pop    %ebx
80101867:	5e                   	pop    %esi
80101868:	5f                   	pop    %edi
80101869:	5d                   	pop    %ebp
8010186a:	c3                   	ret    
8010186b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010186f:	90                   	nop
      a[bn] = addr = balloc(ip->dev);
80101870:	8b 06                	mov    (%esi),%eax
80101872:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101875:	e8 96 fd ff ff       	call   80101610 <balloc>
8010187a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
8010187d:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
80101880:	89 c3                	mov    %eax,%ebx
80101882:	89 02                	mov    %eax,(%edx)
      log_write(bp);
80101884:	57                   	push   %edi
80101885:	e8 66 1a 00 00       	call   801032f0 <log_write>
8010188a:	83 c4 10             	add    $0x10,%esp
8010188d:	eb c6                	jmp    80101855 <bmap+0x45>
8010188f:	90                   	nop
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101890:	89 d0                	mov    %edx,%eax
80101892:	e8 79 fd ff ff       	call   80101610 <balloc>
80101897:	8b 16                	mov    (%esi),%edx
80101899:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
8010189f:	eb 9b                	jmp    8010183c <bmap+0x2c>
801018a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if((addr = ip->addrs[bn]) == 0)
801018a8:	8d 3c 90             	lea    (%eax,%edx,4),%edi
801018ab:	8b 5f 5c             	mov    0x5c(%edi),%ebx
801018ae:	85 db                	test   %ebx,%ebx
801018b0:	75 af                	jne    80101861 <bmap+0x51>
      ip->addrs[bn] = addr = balloc(ip->dev);
801018b2:	8b 00                	mov    (%eax),%eax
801018b4:	e8 57 fd ff ff       	call   80101610 <balloc>
801018b9:	89 47 5c             	mov    %eax,0x5c(%edi)
801018bc:	89 c3                	mov    %eax,%ebx
}
801018be:	8d 65 f4             	lea    -0xc(%ebp),%esp
801018c1:	89 d8                	mov    %ebx,%eax
801018c3:	5b                   	pop    %ebx
801018c4:	5e                   	pop    %esi
801018c5:	5f                   	pop    %edi
801018c6:	5d                   	pop    %ebp
801018c7:	c3                   	ret    
  panic("bmap: out of range");
801018c8:	83 ec 0c             	sub    $0xc,%esp
801018cb:	68 30 7f 10 80       	push   $0x80107f30
801018d0:	e8 bb ea ff ff       	call   80100390 <panic>
801018d5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801018dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801018e0 <readsb>:
{
801018e0:	f3 0f 1e fb          	endbr32 
801018e4:	55                   	push   %ebp
801018e5:	89 e5                	mov    %esp,%ebp
801018e7:	56                   	push   %esi
801018e8:	53                   	push   %ebx
801018e9:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
801018ec:	83 ec 08             	sub    $0x8,%esp
801018ef:	6a 01                	push   $0x1
801018f1:	ff 75 08             	pushl  0x8(%ebp)
801018f4:	e8 d7 e7 ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
801018f9:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
801018fc:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801018fe:	8d 40 5c             	lea    0x5c(%eax),%eax
80101901:	6a 1c                	push   $0x1c
80101903:	50                   	push   %eax
80101904:	56                   	push   %esi
80101905:	e8 46 39 00 00       	call   80105250 <memmove>
  brelse(bp);
8010190a:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010190d:	83 c4 10             	add    $0x10,%esp
}
80101910:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101913:	5b                   	pop    %ebx
80101914:	5e                   	pop    %esi
80101915:	5d                   	pop    %ebp
  brelse(bp);
80101916:	e9 d5 e8 ff ff       	jmp    801001f0 <brelse>
8010191b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010191f:	90                   	nop

80101920 <iinit>:
{
80101920:	f3 0f 1e fb          	endbr32 
80101924:	55                   	push   %ebp
80101925:	89 e5                	mov    %esp,%ebp
80101927:	53                   	push   %ebx
80101928:	bb 60 1a 11 80       	mov    $0x80111a60,%ebx
8010192d:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
80101930:	68 43 7f 10 80       	push   $0x80107f43
80101935:	68 20 1a 11 80       	push   $0x80111a20
8010193a:	e8 e1 35 00 00       	call   80104f20 <initlock>
  for(i = 0; i < NINODE; i++) {
8010193f:	83 c4 10             	add    $0x10,%esp
80101942:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    initsleeplock(&icache.inode[i].lock, "inode");
80101948:	83 ec 08             	sub    $0x8,%esp
8010194b:	68 4a 7f 10 80       	push   $0x80107f4a
80101950:	53                   	push   %ebx
80101951:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101957:	e8 84 34 00 00       	call   80104de0 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
8010195c:	83 c4 10             	add    $0x10,%esp
8010195f:	81 fb 80 36 11 80    	cmp    $0x80113680,%ebx
80101965:	75 e1                	jne    80101948 <iinit+0x28>
  readsb(dev, &sb);
80101967:	83 ec 08             	sub    $0x8,%esp
8010196a:	68 00 1a 11 80       	push   $0x80111a00
8010196f:	ff 75 08             	pushl  0x8(%ebp)
80101972:	e8 69 ff ff ff       	call   801018e0 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
80101977:	ff 35 18 1a 11 80    	pushl  0x80111a18
8010197d:	ff 35 14 1a 11 80    	pushl  0x80111a14
80101983:	ff 35 10 1a 11 80    	pushl  0x80111a10
80101989:	ff 35 0c 1a 11 80    	pushl  0x80111a0c
8010198f:	ff 35 08 1a 11 80    	pushl  0x80111a08
80101995:	ff 35 04 1a 11 80    	pushl  0x80111a04
8010199b:	ff 35 00 1a 11 80    	pushl  0x80111a00
801019a1:	68 b0 7f 10 80       	push   $0x80107fb0
801019a6:	e8 05 ed ff ff       	call   801006b0 <cprintf>
}
801019ab:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801019ae:	83 c4 30             	add    $0x30,%esp
801019b1:	c9                   	leave  
801019b2:	c3                   	ret    
801019b3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801019ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801019c0 <ialloc>:
{
801019c0:	f3 0f 1e fb          	endbr32 
801019c4:	55                   	push   %ebp
801019c5:	89 e5                	mov    %esp,%ebp
801019c7:	57                   	push   %edi
801019c8:	56                   	push   %esi
801019c9:	53                   	push   %ebx
801019ca:	83 ec 1c             	sub    $0x1c,%esp
801019cd:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
801019d0:	83 3d 08 1a 11 80 01 	cmpl   $0x1,0x80111a08
{
801019d7:	8b 75 08             	mov    0x8(%ebp),%esi
801019da:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
801019dd:	0f 86 8d 00 00 00    	jbe    80101a70 <ialloc+0xb0>
801019e3:	bf 01 00 00 00       	mov    $0x1,%edi
801019e8:	eb 1d                	jmp    80101a07 <ialloc+0x47>
801019ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    brelse(bp);
801019f0:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
801019f3:	83 c7 01             	add    $0x1,%edi
    brelse(bp);
801019f6:	53                   	push   %ebx
801019f7:	e8 f4 e7 ff ff       	call   801001f0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
801019fc:	83 c4 10             	add    $0x10,%esp
801019ff:	3b 3d 08 1a 11 80    	cmp    0x80111a08,%edi
80101a05:	73 69                	jae    80101a70 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101a07:	89 f8                	mov    %edi,%eax
80101a09:	83 ec 08             	sub    $0x8,%esp
80101a0c:	c1 e8 03             	shr    $0x3,%eax
80101a0f:	03 05 14 1a 11 80    	add    0x80111a14,%eax
80101a15:	50                   	push   %eax
80101a16:	56                   	push   %esi
80101a17:	e8 b4 e6 ff ff       	call   801000d0 <bread>
    if(dip->type == 0){  // a free inode
80101a1c:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, IBLOCK(inum, sb));
80101a1f:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + inum%IPB;
80101a21:	89 f8                	mov    %edi,%eax
80101a23:	83 e0 07             	and    $0x7,%eax
80101a26:	c1 e0 06             	shl    $0x6,%eax
80101a29:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
80101a2d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101a31:	75 bd                	jne    801019f0 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101a33:	83 ec 04             	sub    $0x4,%esp
80101a36:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101a39:	6a 40                	push   $0x40
80101a3b:	6a 00                	push   $0x0
80101a3d:	51                   	push   %ecx
80101a3e:	e8 6d 37 00 00       	call   801051b0 <memset>
      dip->type = type;
80101a43:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101a47:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101a4a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
80101a4d:	89 1c 24             	mov    %ebx,(%esp)
80101a50:	e8 9b 18 00 00       	call   801032f0 <log_write>
      brelse(bp);
80101a55:	89 1c 24             	mov    %ebx,(%esp)
80101a58:	e8 93 e7 ff ff       	call   801001f0 <brelse>
      return iget(dev, inum);
80101a5d:	83 c4 10             	add    $0x10,%esp
}
80101a60:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
80101a63:	89 fa                	mov    %edi,%edx
}
80101a65:	5b                   	pop    %ebx
      return iget(dev, inum);
80101a66:	89 f0                	mov    %esi,%eax
}
80101a68:	5e                   	pop    %esi
80101a69:	5f                   	pop    %edi
80101a6a:	5d                   	pop    %ebp
      return iget(dev, inum);
80101a6b:	e9 b0 fc ff ff       	jmp    80101720 <iget>
  panic("ialloc: no inodes");
80101a70:	83 ec 0c             	sub    $0xc,%esp
80101a73:	68 50 7f 10 80       	push   $0x80107f50
80101a78:	e8 13 e9 ff ff       	call   80100390 <panic>
80101a7d:	8d 76 00             	lea    0x0(%esi),%esi

80101a80 <iupdate>:
{
80101a80:	f3 0f 1e fb          	endbr32 
80101a84:	55                   	push   %ebp
80101a85:	89 e5                	mov    %esp,%ebp
80101a87:	56                   	push   %esi
80101a88:	53                   	push   %ebx
80101a89:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101a8c:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101a8f:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101a92:	83 ec 08             	sub    $0x8,%esp
80101a95:	c1 e8 03             	shr    $0x3,%eax
80101a98:	03 05 14 1a 11 80    	add    0x80111a14,%eax
80101a9e:	50                   	push   %eax
80101a9f:	ff 73 a4             	pushl  -0x5c(%ebx)
80101aa2:	e8 29 e6 ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
80101aa7:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101aab:	83 c4 0c             	add    $0xc,%esp
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101aae:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101ab0:	8b 43 a8             	mov    -0x58(%ebx),%eax
80101ab3:	83 e0 07             	and    $0x7,%eax
80101ab6:	c1 e0 06             	shl    $0x6,%eax
80101ab9:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101abd:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
80101ac0:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101ac4:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101ac7:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101acb:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
80101acf:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
80101ad3:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101ad7:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101adb:	8b 53 fc             	mov    -0x4(%ebx),%edx
80101ade:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101ae1:	6a 34                	push   $0x34
80101ae3:	53                   	push   %ebx
80101ae4:	50                   	push   %eax
80101ae5:	e8 66 37 00 00       	call   80105250 <memmove>
  log_write(bp);
80101aea:	89 34 24             	mov    %esi,(%esp)
80101aed:	e8 fe 17 00 00       	call   801032f0 <log_write>
  brelse(bp);
80101af2:	89 75 08             	mov    %esi,0x8(%ebp)
80101af5:	83 c4 10             	add    $0x10,%esp
}
80101af8:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101afb:	5b                   	pop    %ebx
80101afc:	5e                   	pop    %esi
80101afd:	5d                   	pop    %ebp
  brelse(bp);
80101afe:	e9 ed e6 ff ff       	jmp    801001f0 <brelse>
80101b03:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101b0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101b10 <idup>:
{
80101b10:	f3 0f 1e fb          	endbr32 
80101b14:	55                   	push   %ebp
80101b15:	89 e5                	mov    %esp,%ebp
80101b17:	53                   	push   %ebx
80101b18:	83 ec 10             	sub    $0x10,%esp
80101b1b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
80101b1e:	68 20 1a 11 80       	push   $0x80111a20
80101b23:	e8 78 35 00 00       	call   801050a0 <acquire>
  ip->ref++;
80101b28:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101b2c:	c7 04 24 20 1a 11 80 	movl   $0x80111a20,(%esp)
80101b33:	e8 28 36 00 00       	call   80105160 <release>
}
80101b38:	89 d8                	mov    %ebx,%eax
80101b3a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101b3d:	c9                   	leave  
80101b3e:	c3                   	ret    
80101b3f:	90                   	nop

80101b40 <ilock>:
{
80101b40:	f3 0f 1e fb          	endbr32 
80101b44:	55                   	push   %ebp
80101b45:	89 e5                	mov    %esp,%ebp
80101b47:	56                   	push   %esi
80101b48:	53                   	push   %ebx
80101b49:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80101b4c:	85 db                	test   %ebx,%ebx
80101b4e:	0f 84 b3 00 00 00    	je     80101c07 <ilock+0xc7>
80101b54:	8b 53 08             	mov    0x8(%ebx),%edx
80101b57:	85 d2                	test   %edx,%edx
80101b59:	0f 8e a8 00 00 00    	jle    80101c07 <ilock+0xc7>
  acquiresleep(&ip->lock);
80101b5f:	83 ec 0c             	sub    $0xc,%esp
80101b62:	8d 43 0c             	lea    0xc(%ebx),%eax
80101b65:	50                   	push   %eax
80101b66:	e8 b5 32 00 00       	call   80104e20 <acquiresleep>
  if(ip->valid == 0){
80101b6b:	8b 43 4c             	mov    0x4c(%ebx),%eax
80101b6e:	83 c4 10             	add    $0x10,%esp
80101b71:	85 c0                	test   %eax,%eax
80101b73:	74 0b                	je     80101b80 <ilock+0x40>
}
80101b75:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101b78:	5b                   	pop    %ebx
80101b79:	5e                   	pop    %esi
80101b7a:	5d                   	pop    %ebp
80101b7b:	c3                   	ret    
80101b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101b80:	8b 43 04             	mov    0x4(%ebx),%eax
80101b83:	83 ec 08             	sub    $0x8,%esp
80101b86:	c1 e8 03             	shr    $0x3,%eax
80101b89:	03 05 14 1a 11 80    	add    0x80111a14,%eax
80101b8f:	50                   	push   %eax
80101b90:	ff 33                	pushl  (%ebx)
80101b92:	e8 39 e5 ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101b97:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101b9a:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101b9c:	8b 43 04             	mov    0x4(%ebx),%eax
80101b9f:	83 e0 07             	and    $0x7,%eax
80101ba2:	c1 e0 06             	shl    $0x6,%eax
80101ba5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101ba9:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101bac:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
80101baf:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101bb3:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101bb7:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
80101bbb:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
80101bbf:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101bc3:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101bc7:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
80101bcb:	8b 50 fc             	mov    -0x4(%eax),%edx
80101bce:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101bd1:	6a 34                	push   $0x34
80101bd3:	50                   	push   %eax
80101bd4:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101bd7:	50                   	push   %eax
80101bd8:	e8 73 36 00 00       	call   80105250 <memmove>
    brelse(bp);
80101bdd:	89 34 24             	mov    %esi,(%esp)
80101be0:	e8 0b e6 ff ff       	call   801001f0 <brelse>
    if(ip->type == 0)
80101be5:	83 c4 10             	add    $0x10,%esp
80101be8:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
80101bed:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101bf4:	0f 85 7b ff ff ff    	jne    80101b75 <ilock+0x35>
      panic("ilock: no type");
80101bfa:	83 ec 0c             	sub    $0xc,%esp
80101bfd:	68 68 7f 10 80       	push   $0x80107f68
80101c02:	e8 89 e7 ff ff       	call   80100390 <panic>
    panic("ilock");
80101c07:	83 ec 0c             	sub    $0xc,%esp
80101c0a:	68 62 7f 10 80       	push   $0x80107f62
80101c0f:	e8 7c e7 ff ff       	call   80100390 <panic>
80101c14:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101c1b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101c1f:	90                   	nop

80101c20 <iunlock>:
{
80101c20:	f3 0f 1e fb          	endbr32 
80101c24:	55                   	push   %ebp
80101c25:	89 e5                	mov    %esp,%ebp
80101c27:	56                   	push   %esi
80101c28:	53                   	push   %ebx
80101c29:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101c2c:	85 db                	test   %ebx,%ebx
80101c2e:	74 28                	je     80101c58 <iunlock+0x38>
80101c30:	83 ec 0c             	sub    $0xc,%esp
80101c33:	8d 73 0c             	lea    0xc(%ebx),%esi
80101c36:	56                   	push   %esi
80101c37:	e8 84 32 00 00       	call   80104ec0 <holdingsleep>
80101c3c:	83 c4 10             	add    $0x10,%esp
80101c3f:	85 c0                	test   %eax,%eax
80101c41:	74 15                	je     80101c58 <iunlock+0x38>
80101c43:	8b 43 08             	mov    0x8(%ebx),%eax
80101c46:	85 c0                	test   %eax,%eax
80101c48:	7e 0e                	jle    80101c58 <iunlock+0x38>
  releasesleep(&ip->lock);
80101c4a:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101c4d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101c50:	5b                   	pop    %ebx
80101c51:	5e                   	pop    %esi
80101c52:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
80101c53:	e9 28 32 00 00       	jmp    80104e80 <releasesleep>
    panic("iunlock");
80101c58:	83 ec 0c             	sub    $0xc,%esp
80101c5b:	68 77 7f 10 80       	push   $0x80107f77
80101c60:	e8 2b e7 ff ff       	call   80100390 <panic>
80101c65:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101c6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101c70 <iput>:
{
80101c70:	f3 0f 1e fb          	endbr32 
80101c74:	55                   	push   %ebp
80101c75:	89 e5                	mov    %esp,%ebp
80101c77:	57                   	push   %edi
80101c78:	56                   	push   %esi
80101c79:	53                   	push   %ebx
80101c7a:	83 ec 28             	sub    $0x28,%esp
80101c7d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
80101c80:	8d 7b 0c             	lea    0xc(%ebx),%edi
80101c83:	57                   	push   %edi
80101c84:	e8 97 31 00 00       	call   80104e20 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80101c89:	8b 53 4c             	mov    0x4c(%ebx),%edx
80101c8c:	83 c4 10             	add    $0x10,%esp
80101c8f:	85 d2                	test   %edx,%edx
80101c91:	74 07                	je     80101c9a <iput+0x2a>
80101c93:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101c98:	74 36                	je     80101cd0 <iput+0x60>
  releasesleep(&ip->lock);
80101c9a:	83 ec 0c             	sub    $0xc,%esp
80101c9d:	57                   	push   %edi
80101c9e:	e8 dd 31 00 00       	call   80104e80 <releasesleep>
  acquire(&icache.lock);
80101ca3:	c7 04 24 20 1a 11 80 	movl   $0x80111a20,(%esp)
80101caa:	e8 f1 33 00 00       	call   801050a0 <acquire>
  ip->ref--;
80101caf:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101cb3:	83 c4 10             	add    $0x10,%esp
80101cb6:	c7 45 08 20 1a 11 80 	movl   $0x80111a20,0x8(%ebp)
}
80101cbd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101cc0:	5b                   	pop    %ebx
80101cc1:	5e                   	pop    %esi
80101cc2:	5f                   	pop    %edi
80101cc3:	5d                   	pop    %ebp
  release(&icache.lock);
80101cc4:	e9 97 34 00 00       	jmp    80105160 <release>
80101cc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&icache.lock);
80101cd0:	83 ec 0c             	sub    $0xc,%esp
80101cd3:	68 20 1a 11 80       	push   $0x80111a20
80101cd8:	e8 c3 33 00 00       	call   801050a0 <acquire>
    int r = ip->ref;
80101cdd:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101ce0:	c7 04 24 20 1a 11 80 	movl   $0x80111a20,(%esp)
80101ce7:	e8 74 34 00 00       	call   80105160 <release>
    if(r == 1){
80101cec:	83 c4 10             	add    $0x10,%esp
80101cef:	83 fe 01             	cmp    $0x1,%esi
80101cf2:	75 a6                	jne    80101c9a <iput+0x2a>
80101cf4:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101cfa:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101cfd:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101d00:	89 cf                	mov    %ecx,%edi
80101d02:	eb 0b                	jmp    80101d0f <iput+0x9f>
80101d04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101d08:	83 c6 04             	add    $0x4,%esi
80101d0b:	39 fe                	cmp    %edi,%esi
80101d0d:	74 19                	je     80101d28 <iput+0xb8>
    if(ip->addrs[i]){
80101d0f:	8b 16                	mov    (%esi),%edx
80101d11:	85 d2                	test   %edx,%edx
80101d13:	74 f3                	je     80101d08 <iput+0x98>
      bfree(ip->dev, ip->addrs[i]);
80101d15:	8b 03                	mov    (%ebx),%eax
80101d17:	e8 74 f8 ff ff       	call   80101590 <bfree>
      ip->addrs[i] = 0;
80101d1c:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80101d22:	eb e4                	jmp    80101d08 <iput+0x98>
80101d24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101d28:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80101d2e:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101d31:	85 c0                	test   %eax,%eax
80101d33:	75 33                	jne    80101d68 <iput+0xf8>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
80101d35:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101d38:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80101d3f:	53                   	push   %ebx
80101d40:	e8 3b fd ff ff       	call   80101a80 <iupdate>
      ip->type = 0;
80101d45:	31 c0                	xor    %eax,%eax
80101d47:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80101d4b:	89 1c 24             	mov    %ebx,(%esp)
80101d4e:	e8 2d fd ff ff       	call   80101a80 <iupdate>
      ip->valid = 0;
80101d53:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101d5a:	83 c4 10             	add    $0x10,%esp
80101d5d:	e9 38 ff ff ff       	jmp    80101c9a <iput+0x2a>
80101d62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101d68:	83 ec 08             	sub    $0x8,%esp
80101d6b:	50                   	push   %eax
80101d6c:	ff 33                	pushl  (%ebx)
80101d6e:	e8 5d e3 ff ff       	call   801000d0 <bread>
80101d73:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101d76:	83 c4 10             	add    $0x10,%esp
80101d79:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101d7f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(j = 0; j < NINDIRECT; j++){
80101d82:	8d 70 5c             	lea    0x5c(%eax),%esi
80101d85:	89 cf                	mov    %ecx,%edi
80101d87:	eb 0e                	jmp    80101d97 <iput+0x127>
80101d89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101d90:	83 c6 04             	add    $0x4,%esi
80101d93:	39 f7                	cmp    %esi,%edi
80101d95:	74 19                	je     80101db0 <iput+0x140>
      if(a[j])
80101d97:	8b 16                	mov    (%esi),%edx
80101d99:	85 d2                	test   %edx,%edx
80101d9b:	74 f3                	je     80101d90 <iput+0x120>
        bfree(ip->dev, a[j]);
80101d9d:	8b 03                	mov    (%ebx),%eax
80101d9f:	e8 ec f7 ff ff       	call   80101590 <bfree>
80101da4:	eb ea                	jmp    80101d90 <iput+0x120>
80101da6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101dad:	8d 76 00             	lea    0x0(%esi),%esi
    brelse(bp);
80101db0:	83 ec 0c             	sub    $0xc,%esp
80101db3:	ff 75 e4             	pushl  -0x1c(%ebp)
80101db6:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101db9:	e8 32 e4 ff ff       	call   801001f0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101dbe:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101dc4:	8b 03                	mov    (%ebx),%eax
80101dc6:	e8 c5 f7 ff ff       	call   80101590 <bfree>
    ip->addrs[NDIRECT] = 0;
80101dcb:	83 c4 10             	add    $0x10,%esp
80101dce:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101dd5:	00 00 00 
80101dd8:	e9 58 ff ff ff       	jmp    80101d35 <iput+0xc5>
80101ddd:	8d 76 00             	lea    0x0(%esi),%esi

80101de0 <iunlockput>:
{
80101de0:	f3 0f 1e fb          	endbr32 
80101de4:	55                   	push   %ebp
80101de5:	89 e5                	mov    %esp,%ebp
80101de7:	53                   	push   %ebx
80101de8:	83 ec 10             	sub    $0x10,%esp
80101deb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
80101dee:	53                   	push   %ebx
80101def:	e8 2c fe ff ff       	call   80101c20 <iunlock>
  iput(ip);
80101df4:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101df7:	83 c4 10             	add    $0x10,%esp
}
80101dfa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101dfd:	c9                   	leave  
  iput(ip);
80101dfe:	e9 6d fe ff ff       	jmp    80101c70 <iput>
80101e03:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101e0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101e10 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101e10:	f3 0f 1e fb          	endbr32 
80101e14:	55                   	push   %ebp
80101e15:	89 e5                	mov    %esp,%ebp
80101e17:	8b 55 08             	mov    0x8(%ebp),%edx
80101e1a:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101e1d:	8b 0a                	mov    (%edx),%ecx
80101e1f:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101e22:	8b 4a 04             	mov    0x4(%edx),%ecx
80101e25:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101e28:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101e2c:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101e2f:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101e33:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101e37:	8b 52 58             	mov    0x58(%edx),%edx
80101e3a:	89 50 10             	mov    %edx,0x10(%eax)
}
80101e3d:	5d                   	pop    %ebp
80101e3e:	c3                   	ret    
80101e3f:	90                   	nop

80101e40 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101e40:	f3 0f 1e fb          	endbr32 
80101e44:	55                   	push   %ebp
80101e45:	89 e5                	mov    %esp,%ebp
80101e47:	57                   	push   %edi
80101e48:	56                   	push   %esi
80101e49:	53                   	push   %ebx
80101e4a:	83 ec 1c             	sub    $0x1c,%esp
80101e4d:	8b 7d 0c             	mov    0xc(%ebp),%edi
80101e50:	8b 45 08             	mov    0x8(%ebp),%eax
80101e53:	8b 75 10             	mov    0x10(%ebp),%esi
80101e56:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101e59:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101e5c:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101e61:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101e64:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80101e67:	0f 84 a3 00 00 00    	je     80101f10 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101e6d:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101e70:	8b 40 58             	mov    0x58(%eax),%eax
80101e73:	39 c6                	cmp    %eax,%esi
80101e75:	0f 87 b6 00 00 00    	ja     80101f31 <readi+0xf1>
80101e7b:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101e7e:	31 c9                	xor    %ecx,%ecx
80101e80:	89 da                	mov    %ebx,%edx
80101e82:	01 f2                	add    %esi,%edx
80101e84:	0f 92 c1             	setb   %cl
80101e87:	89 cf                	mov    %ecx,%edi
80101e89:	0f 82 a2 00 00 00    	jb     80101f31 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101e8f:	89 c1                	mov    %eax,%ecx
80101e91:	29 f1                	sub    %esi,%ecx
80101e93:	39 d0                	cmp    %edx,%eax
80101e95:	0f 43 cb             	cmovae %ebx,%ecx
80101e98:	89 4d e4             	mov    %ecx,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101e9b:	85 c9                	test   %ecx,%ecx
80101e9d:	74 63                	je     80101f02 <readi+0xc2>
80101e9f:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ea0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101ea3:	89 f2                	mov    %esi,%edx
80101ea5:	c1 ea 09             	shr    $0x9,%edx
80101ea8:	89 d8                	mov    %ebx,%eax
80101eaa:	e8 61 f9 ff ff       	call   80101810 <bmap>
80101eaf:	83 ec 08             	sub    $0x8,%esp
80101eb2:	50                   	push   %eax
80101eb3:	ff 33                	pushl  (%ebx)
80101eb5:	e8 16 e2 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101eba:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101ebd:	b9 00 02 00 00       	mov    $0x200,%ecx
80101ec2:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ec5:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101ec7:	89 f0                	mov    %esi,%eax
80101ec9:	25 ff 01 00 00       	and    $0x1ff,%eax
80101ece:	29 fb                	sub    %edi,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101ed0:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101ed3:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101ed5:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101ed9:	39 d9                	cmp    %ebx,%ecx
80101edb:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101ede:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101edf:	01 df                	add    %ebx,%edi
80101ee1:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101ee3:	50                   	push   %eax
80101ee4:	ff 75 e0             	pushl  -0x20(%ebp)
80101ee7:	e8 64 33 00 00       	call   80105250 <memmove>
    brelse(bp);
80101eec:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101eef:	89 14 24             	mov    %edx,(%esp)
80101ef2:	e8 f9 e2 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101ef7:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101efa:	83 c4 10             	add    $0x10,%esp
80101efd:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101f00:	77 9e                	ja     80101ea0 <readi+0x60>
  }
  return n;
80101f02:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101f05:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f08:	5b                   	pop    %ebx
80101f09:	5e                   	pop    %esi
80101f0a:	5f                   	pop    %edi
80101f0b:	5d                   	pop    %ebp
80101f0c:	c3                   	ret    
80101f0d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101f10:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101f14:	66 83 f8 09          	cmp    $0x9,%ax
80101f18:	77 17                	ja     80101f31 <readi+0xf1>
80101f1a:	8b 04 c5 a0 19 11 80 	mov    -0x7feee660(,%eax,8),%eax
80101f21:	85 c0                	test   %eax,%eax
80101f23:	74 0c                	je     80101f31 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101f25:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101f28:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f2b:	5b                   	pop    %ebx
80101f2c:	5e                   	pop    %esi
80101f2d:	5f                   	pop    %edi
80101f2e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101f2f:	ff e0                	jmp    *%eax
      return -1;
80101f31:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101f36:	eb cd                	jmp    80101f05 <readi+0xc5>
80101f38:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101f3f:	90                   	nop

80101f40 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101f40:	f3 0f 1e fb          	endbr32 
80101f44:	55                   	push   %ebp
80101f45:	89 e5                	mov    %esp,%ebp
80101f47:	57                   	push   %edi
80101f48:	56                   	push   %esi
80101f49:	53                   	push   %ebx
80101f4a:	83 ec 1c             	sub    $0x1c,%esp
80101f4d:	8b 45 08             	mov    0x8(%ebp),%eax
80101f50:	8b 75 0c             	mov    0xc(%ebp),%esi
80101f53:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101f56:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101f5b:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101f5e:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101f61:	8b 75 10             	mov    0x10(%ebp),%esi
80101f64:	89 7d e0             	mov    %edi,-0x20(%ebp)
  if(ip->type == T_DEV){
80101f67:	0f 84 b3 00 00 00    	je     80102020 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101f6d:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101f70:	39 70 58             	cmp    %esi,0x58(%eax)
80101f73:	0f 82 e3 00 00 00    	jb     8010205c <writei+0x11c>
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101f79:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101f7c:	89 f8                	mov    %edi,%eax
80101f7e:	01 f0                	add    %esi,%eax
80101f80:	0f 82 d6 00 00 00    	jb     8010205c <writei+0x11c>
80101f86:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101f8b:	0f 87 cb 00 00 00    	ja     8010205c <writei+0x11c>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101f91:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101f98:	85 ff                	test   %edi,%edi
80101f9a:	74 75                	je     80102011 <writei+0xd1>
80101f9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101fa0:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101fa3:	89 f2                	mov    %esi,%edx
80101fa5:	c1 ea 09             	shr    $0x9,%edx
80101fa8:	89 f8                	mov    %edi,%eax
80101faa:	e8 61 f8 ff ff       	call   80101810 <bmap>
80101faf:	83 ec 08             	sub    $0x8,%esp
80101fb2:	50                   	push   %eax
80101fb3:	ff 37                	pushl  (%edi)
80101fb5:	e8 16 e1 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101fba:	b9 00 02 00 00       	mov    $0x200,%ecx
80101fbf:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101fc2:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101fc5:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101fc7:	89 f0                	mov    %esi,%eax
80101fc9:	83 c4 0c             	add    $0xc,%esp
80101fcc:	25 ff 01 00 00       	and    $0x1ff,%eax
80101fd1:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101fd3:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101fd7:	39 d9                	cmp    %ebx,%ecx
80101fd9:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101fdc:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101fdd:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101fdf:	ff 75 dc             	pushl  -0x24(%ebp)
80101fe2:	50                   	push   %eax
80101fe3:	e8 68 32 00 00       	call   80105250 <memmove>
    log_write(bp);
80101fe8:	89 3c 24             	mov    %edi,(%esp)
80101feb:	e8 00 13 00 00       	call   801032f0 <log_write>
    brelse(bp);
80101ff0:	89 3c 24             	mov    %edi,(%esp)
80101ff3:	e8 f8 e1 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101ff8:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101ffb:	83 c4 10             	add    $0x10,%esp
80101ffe:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80102001:	01 5d dc             	add    %ebx,-0x24(%ebp)
80102004:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80102007:	77 97                	ja     80101fa0 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80102009:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010200c:	3b 70 58             	cmp    0x58(%eax),%esi
8010200f:	77 37                	ja     80102048 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80102011:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80102014:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102017:	5b                   	pop    %ebx
80102018:	5e                   	pop    %esi
80102019:	5f                   	pop    %edi
8010201a:	5d                   	pop    %ebp
8010201b:	c3                   	ret    
8010201c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80102020:	0f bf 40 52          	movswl 0x52(%eax),%eax
80102024:	66 83 f8 09          	cmp    $0x9,%ax
80102028:	77 32                	ja     8010205c <writei+0x11c>
8010202a:	8b 04 c5 a4 19 11 80 	mov    -0x7feee65c(,%eax,8),%eax
80102031:	85 c0                	test   %eax,%eax
80102033:	74 27                	je     8010205c <writei+0x11c>
    return devsw[ip->major].write(ip, src, n);
80102035:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80102038:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010203b:	5b                   	pop    %ebx
8010203c:	5e                   	pop    %esi
8010203d:	5f                   	pop    %edi
8010203e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
8010203f:	ff e0                	jmp    *%eax
80102041:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80102048:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
8010204b:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
8010204e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80102051:	50                   	push   %eax
80102052:	e8 29 fa ff ff       	call   80101a80 <iupdate>
80102057:	83 c4 10             	add    $0x10,%esp
8010205a:	eb b5                	jmp    80102011 <writei+0xd1>
      return -1;
8010205c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102061:	eb b1                	jmp    80102014 <writei+0xd4>
80102063:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010206a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102070 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80102070:	f3 0f 1e fb          	endbr32 
80102074:	55                   	push   %ebp
80102075:	89 e5                	mov    %esp,%ebp
80102077:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
8010207a:	6a 0e                	push   $0xe
8010207c:	ff 75 0c             	pushl  0xc(%ebp)
8010207f:	ff 75 08             	pushl  0x8(%ebp)
80102082:	e8 39 32 00 00       	call   801052c0 <strncmp>
}
80102087:	c9                   	leave  
80102088:	c3                   	ret    
80102089:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102090 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80102090:	f3 0f 1e fb          	endbr32 
80102094:	55                   	push   %ebp
80102095:	89 e5                	mov    %esp,%ebp
80102097:	57                   	push   %edi
80102098:	56                   	push   %esi
80102099:	53                   	push   %ebx
8010209a:	83 ec 1c             	sub    $0x1c,%esp
8010209d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
801020a0:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801020a5:	0f 85 89 00 00 00    	jne    80102134 <dirlookup+0xa4>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
801020ab:	8b 53 58             	mov    0x58(%ebx),%edx
801020ae:	31 ff                	xor    %edi,%edi
801020b0:	8d 75 d8             	lea    -0x28(%ebp),%esi
801020b3:	85 d2                	test   %edx,%edx
801020b5:	74 42                	je     801020f9 <dirlookup+0x69>
801020b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801020be:	66 90                	xchg   %ax,%ax
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801020c0:	6a 10                	push   $0x10
801020c2:	57                   	push   %edi
801020c3:	56                   	push   %esi
801020c4:	53                   	push   %ebx
801020c5:	e8 76 fd ff ff       	call   80101e40 <readi>
801020ca:	83 c4 10             	add    $0x10,%esp
801020cd:	83 f8 10             	cmp    $0x10,%eax
801020d0:	75 55                	jne    80102127 <dirlookup+0x97>
      panic("dirlookup read");
    if(de.inum == 0)
801020d2:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801020d7:	74 18                	je     801020f1 <dirlookup+0x61>
  return strncmp(s, t, DIRSIZ);
801020d9:	83 ec 04             	sub    $0x4,%esp
801020dc:	8d 45 da             	lea    -0x26(%ebp),%eax
801020df:	6a 0e                	push   $0xe
801020e1:	50                   	push   %eax
801020e2:	ff 75 0c             	pushl  0xc(%ebp)
801020e5:	e8 d6 31 00 00       	call   801052c0 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
801020ea:	83 c4 10             	add    $0x10,%esp
801020ed:	85 c0                	test   %eax,%eax
801020ef:	74 17                	je     80102108 <dirlookup+0x78>
  for(off = 0; off < dp->size; off += sizeof(de)){
801020f1:	83 c7 10             	add    $0x10,%edi
801020f4:	3b 7b 58             	cmp    0x58(%ebx),%edi
801020f7:	72 c7                	jb     801020c0 <dirlookup+0x30>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
801020f9:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801020fc:	31 c0                	xor    %eax,%eax
}
801020fe:	5b                   	pop    %ebx
801020ff:	5e                   	pop    %esi
80102100:	5f                   	pop    %edi
80102101:	5d                   	pop    %ebp
80102102:	c3                   	ret    
80102103:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102107:	90                   	nop
      if(poff)
80102108:	8b 45 10             	mov    0x10(%ebp),%eax
8010210b:	85 c0                	test   %eax,%eax
8010210d:	74 05                	je     80102114 <dirlookup+0x84>
        *poff = off;
8010210f:	8b 45 10             	mov    0x10(%ebp),%eax
80102112:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80102114:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80102118:	8b 03                	mov    (%ebx),%eax
8010211a:	e8 01 f6 ff ff       	call   80101720 <iget>
}
8010211f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102122:	5b                   	pop    %ebx
80102123:	5e                   	pop    %esi
80102124:	5f                   	pop    %edi
80102125:	5d                   	pop    %ebp
80102126:	c3                   	ret    
      panic("dirlookup read");
80102127:	83 ec 0c             	sub    $0xc,%esp
8010212a:	68 91 7f 10 80       	push   $0x80107f91
8010212f:	e8 5c e2 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
80102134:	83 ec 0c             	sub    $0xc,%esp
80102137:	68 7f 7f 10 80       	push   $0x80107f7f
8010213c:	e8 4f e2 ff ff       	call   80100390 <panic>
80102141:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102148:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010214f:	90                   	nop

80102150 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80102150:	55                   	push   %ebp
80102151:	89 e5                	mov    %esp,%ebp
80102153:	57                   	push   %edi
80102154:	56                   	push   %esi
80102155:	53                   	push   %ebx
80102156:	89 c3                	mov    %eax,%ebx
80102158:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
8010215b:	80 38 2f             	cmpb   $0x2f,(%eax)
{
8010215e:	89 55 e0             	mov    %edx,-0x20(%ebp)
80102161:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if(*path == '/')
80102164:	0f 84 86 01 00 00    	je     801022f0 <namex+0x1a0>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
8010216a:	e8 31 1c 00 00       	call   80103da0 <myproc>
  acquire(&icache.lock);
8010216f:	83 ec 0c             	sub    $0xc,%esp
80102172:	89 df                	mov    %ebx,%edi
    ip = idup(myproc()->cwd);
80102174:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80102177:	68 20 1a 11 80       	push   $0x80111a20
8010217c:	e8 1f 2f 00 00       	call   801050a0 <acquire>
  ip->ref++;
80102181:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80102185:	c7 04 24 20 1a 11 80 	movl   $0x80111a20,(%esp)
8010218c:	e8 cf 2f 00 00       	call   80105160 <release>
80102191:	83 c4 10             	add    $0x10,%esp
80102194:	eb 0d                	jmp    801021a3 <namex+0x53>
80102196:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010219d:	8d 76 00             	lea    0x0(%esi),%esi
    path++;
801021a0:	83 c7 01             	add    $0x1,%edi
  while(*path == '/')
801021a3:	0f b6 07             	movzbl (%edi),%eax
801021a6:	3c 2f                	cmp    $0x2f,%al
801021a8:	74 f6                	je     801021a0 <namex+0x50>
  if(*path == 0)
801021aa:	84 c0                	test   %al,%al
801021ac:	0f 84 ee 00 00 00    	je     801022a0 <namex+0x150>
  while(*path != '/' && *path != 0)
801021b2:	0f b6 07             	movzbl (%edi),%eax
801021b5:	84 c0                	test   %al,%al
801021b7:	0f 84 fb 00 00 00    	je     801022b8 <namex+0x168>
801021bd:	89 fb                	mov    %edi,%ebx
801021bf:	3c 2f                	cmp    $0x2f,%al
801021c1:	0f 84 f1 00 00 00    	je     801022b8 <namex+0x168>
801021c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801021ce:	66 90                	xchg   %ax,%ax
801021d0:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
    path++;
801021d4:	83 c3 01             	add    $0x1,%ebx
  while(*path != '/' && *path != 0)
801021d7:	3c 2f                	cmp    $0x2f,%al
801021d9:	74 04                	je     801021df <namex+0x8f>
801021db:	84 c0                	test   %al,%al
801021dd:	75 f1                	jne    801021d0 <namex+0x80>
  len = path - s;
801021df:	89 d8                	mov    %ebx,%eax
801021e1:	29 f8                	sub    %edi,%eax
  if(len >= DIRSIZ)
801021e3:	83 f8 0d             	cmp    $0xd,%eax
801021e6:	0f 8e 84 00 00 00    	jle    80102270 <namex+0x120>
    memmove(name, s, DIRSIZ);
801021ec:	83 ec 04             	sub    $0x4,%esp
801021ef:	6a 0e                	push   $0xe
801021f1:	57                   	push   %edi
    path++;
801021f2:	89 df                	mov    %ebx,%edi
    memmove(name, s, DIRSIZ);
801021f4:	ff 75 e4             	pushl  -0x1c(%ebp)
801021f7:	e8 54 30 00 00       	call   80105250 <memmove>
801021fc:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
801021ff:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80102202:	75 0c                	jne    80102210 <namex+0xc0>
80102204:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80102208:	83 c7 01             	add    $0x1,%edi
  while(*path == '/')
8010220b:	80 3f 2f             	cmpb   $0x2f,(%edi)
8010220e:	74 f8                	je     80102208 <namex+0xb8>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80102210:	83 ec 0c             	sub    $0xc,%esp
80102213:	56                   	push   %esi
80102214:	e8 27 f9 ff ff       	call   80101b40 <ilock>
    if(ip->type != T_DIR){
80102219:	83 c4 10             	add    $0x10,%esp
8010221c:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80102221:	0f 85 a1 00 00 00    	jne    801022c8 <namex+0x178>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80102227:	8b 55 e0             	mov    -0x20(%ebp),%edx
8010222a:	85 d2                	test   %edx,%edx
8010222c:	74 09                	je     80102237 <namex+0xe7>
8010222e:	80 3f 00             	cmpb   $0x0,(%edi)
80102231:	0f 84 d9 00 00 00    	je     80102310 <namex+0x1c0>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80102237:	83 ec 04             	sub    $0x4,%esp
8010223a:	6a 00                	push   $0x0
8010223c:	ff 75 e4             	pushl  -0x1c(%ebp)
8010223f:	56                   	push   %esi
80102240:	e8 4b fe ff ff       	call   80102090 <dirlookup>
80102245:	83 c4 10             	add    $0x10,%esp
80102248:	89 c3                	mov    %eax,%ebx
8010224a:	85 c0                	test   %eax,%eax
8010224c:	74 7a                	je     801022c8 <namex+0x178>
  iunlock(ip);
8010224e:	83 ec 0c             	sub    $0xc,%esp
80102251:	56                   	push   %esi
80102252:	e8 c9 f9 ff ff       	call   80101c20 <iunlock>
  iput(ip);
80102257:	89 34 24             	mov    %esi,(%esp)
8010225a:	89 de                	mov    %ebx,%esi
8010225c:	e8 0f fa ff ff       	call   80101c70 <iput>
80102261:	83 c4 10             	add    $0x10,%esp
80102264:	e9 3a ff ff ff       	jmp    801021a3 <namex+0x53>
80102269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102270:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80102273:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
80102276:	89 4d dc             	mov    %ecx,-0x24(%ebp)
    memmove(name, s, len);
80102279:	83 ec 04             	sub    $0x4,%esp
8010227c:	50                   	push   %eax
8010227d:	57                   	push   %edi
    name[len] = 0;
8010227e:	89 df                	mov    %ebx,%edi
    memmove(name, s, len);
80102280:	ff 75 e4             	pushl  -0x1c(%ebp)
80102283:	e8 c8 2f 00 00       	call   80105250 <memmove>
    name[len] = 0;
80102288:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010228b:	83 c4 10             	add    $0x10,%esp
8010228e:	c6 00 00             	movb   $0x0,(%eax)
80102291:	e9 69 ff ff ff       	jmp    801021ff <namex+0xaf>
80102296:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010229d:	8d 76 00             	lea    0x0(%esi),%esi
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
801022a0:	8b 45 e0             	mov    -0x20(%ebp),%eax
801022a3:	85 c0                	test   %eax,%eax
801022a5:	0f 85 85 00 00 00    	jne    80102330 <namex+0x1e0>
    iput(ip);
    return 0;
  }
  return ip;
}
801022ab:	8d 65 f4             	lea    -0xc(%ebp),%esp
801022ae:	89 f0                	mov    %esi,%eax
801022b0:	5b                   	pop    %ebx
801022b1:	5e                   	pop    %esi
801022b2:	5f                   	pop    %edi
801022b3:	5d                   	pop    %ebp
801022b4:	c3                   	ret    
801022b5:	8d 76 00             	lea    0x0(%esi),%esi
  while(*path != '/' && *path != 0)
801022b8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801022bb:	89 fb                	mov    %edi,%ebx
801022bd:	89 45 dc             	mov    %eax,-0x24(%ebp)
801022c0:	31 c0                	xor    %eax,%eax
801022c2:	eb b5                	jmp    80102279 <namex+0x129>
801022c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
801022c8:	83 ec 0c             	sub    $0xc,%esp
801022cb:	56                   	push   %esi
801022cc:	e8 4f f9 ff ff       	call   80101c20 <iunlock>
  iput(ip);
801022d1:	89 34 24             	mov    %esi,(%esp)
      return 0;
801022d4:	31 f6                	xor    %esi,%esi
  iput(ip);
801022d6:	e8 95 f9 ff ff       	call   80101c70 <iput>
      return 0;
801022db:	83 c4 10             	add    $0x10,%esp
}
801022de:	8d 65 f4             	lea    -0xc(%ebp),%esp
801022e1:	89 f0                	mov    %esi,%eax
801022e3:	5b                   	pop    %ebx
801022e4:	5e                   	pop    %esi
801022e5:	5f                   	pop    %edi
801022e6:	5d                   	pop    %ebp
801022e7:	c3                   	ret    
801022e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801022ef:	90                   	nop
    ip = iget(ROOTDEV, ROOTINO);
801022f0:	ba 01 00 00 00       	mov    $0x1,%edx
801022f5:	b8 01 00 00 00       	mov    $0x1,%eax
801022fa:	89 df                	mov    %ebx,%edi
801022fc:	e8 1f f4 ff ff       	call   80101720 <iget>
80102301:	89 c6                	mov    %eax,%esi
80102303:	e9 9b fe ff ff       	jmp    801021a3 <namex+0x53>
80102308:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010230f:	90                   	nop
      iunlock(ip);
80102310:	83 ec 0c             	sub    $0xc,%esp
80102313:	56                   	push   %esi
80102314:	e8 07 f9 ff ff       	call   80101c20 <iunlock>
      return ip;
80102319:	83 c4 10             	add    $0x10,%esp
}
8010231c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010231f:	89 f0                	mov    %esi,%eax
80102321:	5b                   	pop    %ebx
80102322:	5e                   	pop    %esi
80102323:	5f                   	pop    %edi
80102324:	5d                   	pop    %ebp
80102325:	c3                   	ret    
80102326:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010232d:	8d 76 00             	lea    0x0(%esi),%esi
    iput(ip);
80102330:	83 ec 0c             	sub    $0xc,%esp
80102333:	56                   	push   %esi
    return 0;
80102334:	31 f6                	xor    %esi,%esi
    iput(ip);
80102336:	e8 35 f9 ff ff       	call   80101c70 <iput>
    return 0;
8010233b:	83 c4 10             	add    $0x10,%esp
8010233e:	e9 68 ff ff ff       	jmp    801022ab <namex+0x15b>
80102343:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010234a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102350 <dirlink>:
{
80102350:	f3 0f 1e fb          	endbr32 
80102354:	55                   	push   %ebp
80102355:	89 e5                	mov    %esp,%ebp
80102357:	57                   	push   %edi
80102358:	56                   	push   %esi
80102359:	53                   	push   %ebx
8010235a:	83 ec 20             	sub    $0x20,%esp
8010235d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80102360:	6a 00                	push   $0x0
80102362:	ff 75 0c             	pushl  0xc(%ebp)
80102365:	53                   	push   %ebx
80102366:	e8 25 fd ff ff       	call   80102090 <dirlookup>
8010236b:	83 c4 10             	add    $0x10,%esp
8010236e:	85 c0                	test   %eax,%eax
80102370:	75 6b                	jne    801023dd <dirlink+0x8d>
  for(off = 0; off < dp->size; off += sizeof(de)){
80102372:	8b 7b 58             	mov    0x58(%ebx),%edi
80102375:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102378:	85 ff                	test   %edi,%edi
8010237a:	74 2d                	je     801023a9 <dirlink+0x59>
8010237c:	31 ff                	xor    %edi,%edi
8010237e:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102381:	eb 0d                	jmp    80102390 <dirlink+0x40>
80102383:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102387:	90                   	nop
80102388:	83 c7 10             	add    $0x10,%edi
8010238b:	3b 7b 58             	cmp    0x58(%ebx),%edi
8010238e:	73 19                	jae    801023a9 <dirlink+0x59>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102390:	6a 10                	push   $0x10
80102392:	57                   	push   %edi
80102393:	56                   	push   %esi
80102394:	53                   	push   %ebx
80102395:	e8 a6 fa ff ff       	call   80101e40 <readi>
8010239a:	83 c4 10             	add    $0x10,%esp
8010239d:	83 f8 10             	cmp    $0x10,%eax
801023a0:	75 4e                	jne    801023f0 <dirlink+0xa0>
    if(de.inum == 0)
801023a2:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801023a7:	75 df                	jne    80102388 <dirlink+0x38>
  strncpy(de.name, name, DIRSIZ);
801023a9:	83 ec 04             	sub    $0x4,%esp
801023ac:	8d 45 da             	lea    -0x26(%ebp),%eax
801023af:	6a 0e                	push   $0xe
801023b1:	ff 75 0c             	pushl  0xc(%ebp)
801023b4:	50                   	push   %eax
801023b5:	e8 56 2f 00 00       	call   80105310 <strncpy>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801023ba:	6a 10                	push   $0x10
  de.inum = inum;
801023bc:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801023bf:	57                   	push   %edi
801023c0:	56                   	push   %esi
801023c1:	53                   	push   %ebx
  de.inum = inum;
801023c2:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801023c6:	e8 75 fb ff ff       	call   80101f40 <writei>
801023cb:	83 c4 20             	add    $0x20,%esp
801023ce:	83 f8 10             	cmp    $0x10,%eax
801023d1:	75 2a                	jne    801023fd <dirlink+0xad>
  return 0;
801023d3:	31 c0                	xor    %eax,%eax
}
801023d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801023d8:	5b                   	pop    %ebx
801023d9:	5e                   	pop    %esi
801023da:	5f                   	pop    %edi
801023db:	5d                   	pop    %ebp
801023dc:	c3                   	ret    
    iput(ip);
801023dd:	83 ec 0c             	sub    $0xc,%esp
801023e0:	50                   	push   %eax
801023e1:	e8 8a f8 ff ff       	call   80101c70 <iput>
    return -1;
801023e6:	83 c4 10             	add    $0x10,%esp
801023e9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801023ee:	eb e5                	jmp    801023d5 <dirlink+0x85>
      panic("dirlink read");
801023f0:	83 ec 0c             	sub    $0xc,%esp
801023f3:	68 a0 7f 10 80       	push   $0x80107fa0
801023f8:	e8 93 df ff ff       	call   80100390 <panic>
    panic("dirlink");
801023fd:	83 ec 0c             	sub    $0xc,%esp
80102400:	68 9a 86 10 80       	push   $0x8010869a
80102405:	e8 86 df ff ff       	call   80100390 <panic>
8010240a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102410 <namei>:

struct inode*
namei(char *path)
{
80102410:	f3 0f 1e fb          	endbr32 
80102414:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102415:	31 d2                	xor    %edx,%edx
{
80102417:	89 e5                	mov    %esp,%ebp
80102419:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
8010241c:	8b 45 08             	mov    0x8(%ebp),%eax
8010241f:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80102422:	e8 29 fd ff ff       	call   80102150 <namex>
}
80102427:	c9                   	leave  
80102428:	c3                   	ret    
80102429:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102430 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102430:	f3 0f 1e fb          	endbr32 
80102434:	55                   	push   %ebp
  return namex(path, 1, name);
80102435:	ba 01 00 00 00       	mov    $0x1,%edx
{
8010243a:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
8010243c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010243f:	8b 45 08             	mov    0x8(%ebp),%eax
}
80102442:	5d                   	pop    %ebp
  return namex(path, 1, name);
80102443:	e9 08 fd ff ff       	jmp    80102150 <namex>
80102448:	66 90                	xchg   %ax,%ax
8010244a:	66 90                	xchg   %ax,%ax
8010244c:	66 90                	xchg   %ax,%ax
8010244e:	66 90                	xchg   %ax,%ax

80102450 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102450:	55                   	push   %ebp
80102451:	89 e5                	mov    %esp,%ebp
80102453:	57                   	push   %edi
80102454:	56                   	push   %esi
80102455:	53                   	push   %ebx
80102456:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80102459:	85 c0                	test   %eax,%eax
8010245b:	0f 84 b4 00 00 00    	je     80102515 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80102461:	8b 70 08             	mov    0x8(%eax),%esi
80102464:	89 c3                	mov    %eax,%ebx
80102466:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
8010246c:	0f 87 96 00 00 00    	ja     80102508 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102472:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102477:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010247e:	66 90                	xchg   %ax,%ax
80102480:	89 ca                	mov    %ecx,%edx
80102482:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102483:	83 e0 c0             	and    $0xffffffc0,%eax
80102486:	3c 40                	cmp    $0x40,%al
80102488:	75 f6                	jne    80102480 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010248a:	31 ff                	xor    %edi,%edi
8010248c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102491:	89 f8                	mov    %edi,%eax
80102493:	ee                   	out    %al,(%dx)
80102494:	b8 01 00 00 00       	mov    $0x1,%eax
80102499:	ba f2 01 00 00       	mov    $0x1f2,%edx
8010249e:	ee                   	out    %al,(%dx)
8010249f:	ba f3 01 00 00       	mov    $0x1f3,%edx
801024a4:	89 f0                	mov    %esi,%eax
801024a6:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
801024a7:	89 f0                	mov    %esi,%eax
801024a9:	ba f4 01 00 00       	mov    $0x1f4,%edx
801024ae:	c1 f8 08             	sar    $0x8,%eax
801024b1:	ee                   	out    %al,(%dx)
801024b2:	ba f5 01 00 00       	mov    $0x1f5,%edx
801024b7:	89 f8                	mov    %edi,%eax
801024b9:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
801024ba:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
801024be:	ba f6 01 00 00       	mov    $0x1f6,%edx
801024c3:	c1 e0 04             	shl    $0x4,%eax
801024c6:	83 e0 10             	and    $0x10,%eax
801024c9:	83 c8 e0             	or     $0xffffffe0,%eax
801024cc:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
801024cd:	f6 03 04             	testb  $0x4,(%ebx)
801024d0:	75 16                	jne    801024e8 <idestart+0x98>
801024d2:	b8 20 00 00 00       	mov    $0x20,%eax
801024d7:	89 ca                	mov    %ecx,%edx
801024d9:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
801024da:	8d 65 f4             	lea    -0xc(%ebp),%esp
801024dd:	5b                   	pop    %ebx
801024de:	5e                   	pop    %esi
801024df:	5f                   	pop    %edi
801024e0:	5d                   	pop    %ebp
801024e1:	c3                   	ret    
801024e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801024e8:	b8 30 00 00 00       	mov    $0x30,%eax
801024ed:	89 ca                	mov    %ecx,%edx
801024ef:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
801024f0:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
801024f5:	8d 73 5c             	lea    0x5c(%ebx),%esi
801024f8:	ba f0 01 00 00       	mov    $0x1f0,%edx
801024fd:	fc                   	cld    
801024fe:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102500:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102503:	5b                   	pop    %ebx
80102504:	5e                   	pop    %esi
80102505:	5f                   	pop    %edi
80102506:	5d                   	pop    %ebp
80102507:	c3                   	ret    
    panic("incorrect blockno");
80102508:	83 ec 0c             	sub    $0xc,%esp
8010250b:	68 0c 80 10 80       	push   $0x8010800c
80102510:	e8 7b de ff ff       	call   80100390 <panic>
    panic("idestart");
80102515:	83 ec 0c             	sub    $0xc,%esp
80102518:	68 03 80 10 80       	push   $0x80108003
8010251d:	e8 6e de ff ff       	call   80100390 <panic>
80102522:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102529:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102530 <ideinit>:
{
80102530:	f3 0f 1e fb          	endbr32 
80102534:	55                   	push   %ebp
80102535:	89 e5                	mov    %esp,%ebp
80102537:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
8010253a:	68 1e 80 10 80       	push   $0x8010801e
8010253f:	68 a0 b5 10 80       	push   $0x8010b5a0
80102544:	e8 d7 29 00 00       	call   80104f20 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102549:	58                   	pop    %eax
8010254a:	a1 40 3d 11 80       	mov    0x80113d40,%eax
8010254f:	5a                   	pop    %edx
80102550:	83 e8 01             	sub    $0x1,%eax
80102553:	50                   	push   %eax
80102554:	6a 0e                	push   $0xe
80102556:	e8 b5 02 00 00       	call   80102810 <ioapicenable>
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
8010255b:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010255e:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102563:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102567:	90                   	nop
80102568:	ec                   	in     (%dx),%al
80102569:	83 e0 c0             	and    $0xffffffc0,%eax
8010256c:	3c 40                	cmp    $0x40,%al
8010256e:	75 f8                	jne    80102568 <ideinit+0x38>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102570:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
80102575:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010257a:	ee                   	out    %al,(%dx)
8010257b:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102580:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102585:	eb 0e                	jmp    80102595 <ideinit+0x65>
80102587:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010258e:	66 90                	xchg   %ax,%ax
  for(i=0; i<1000; i++){
80102590:	83 e9 01             	sub    $0x1,%ecx
80102593:	74 0f                	je     801025a4 <ideinit+0x74>
80102595:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102596:	84 c0                	test   %al,%al
80102598:	74 f6                	je     80102590 <ideinit+0x60>
      havedisk1 = 1;
8010259a:	c7 05 80 b5 10 80 01 	movl   $0x1,0x8010b580
801025a1:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801025a4:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
801025a9:	ba f6 01 00 00       	mov    $0x1f6,%edx
801025ae:	ee                   	out    %al,(%dx)
}
801025af:	c9                   	leave  
801025b0:	c3                   	ret    
801025b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801025b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801025bf:	90                   	nop

801025c0 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
801025c0:	f3 0f 1e fb          	endbr32 
801025c4:	55                   	push   %ebp
801025c5:	89 e5                	mov    %esp,%ebp
801025c7:	57                   	push   %edi
801025c8:	56                   	push   %esi
801025c9:	53                   	push   %ebx
801025ca:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
801025cd:	68 a0 b5 10 80       	push   $0x8010b5a0
801025d2:	e8 c9 2a 00 00       	call   801050a0 <acquire>

  if((b = idequeue) == 0){
801025d7:	8b 1d 84 b5 10 80    	mov    0x8010b584,%ebx
801025dd:	83 c4 10             	add    $0x10,%esp
801025e0:	85 db                	test   %ebx,%ebx
801025e2:	74 5f                	je     80102643 <ideintr+0x83>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
801025e4:	8b 43 58             	mov    0x58(%ebx),%eax
801025e7:	a3 84 b5 10 80       	mov    %eax,0x8010b584

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801025ec:	8b 33                	mov    (%ebx),%esi
801025ee:	f7 c6 04 00 00 00    	test   $0x4,%esi
801025f4:	75 2b                	jne    80102621 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801025f6:	ba f7 01 00 00       	mov    $0x1f7,%edx
801025fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801025ff:	90                   	nop
80102600:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102601:	89 c1                	mov    %eax,%ecx
80102603:	83 e1 c0             	and    $0xffffffc0,%ecx
80102606:	80 f9 40             	cmp    $0x40,%cl
80102609:	75 f5                	jne    80102600 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010260b:	a8 21                	test   $0x21,%al
8010260d:	75 12                	jne    80102621 <ideintr+0x61>
    insl(0x1f0, b->data, BSIZE/4);
8010260f:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80102612:	b9 80 00 00 00       	mov    $0x80,%ecx
80102617:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010261c:	fc                   	cld    
8010261d:	f3 6d                	rep insl (%dx),%es:(%edi)
8010261f:	8b 33                	mov    (%ebx),%esi

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102621:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
80102624:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
80102627:	83 ce 02             	or     $0x2,%esi
8010262a:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
8010262c:	53                   	push   %ebx
8010262d:	e8 ae 23 00 00       	call   801049e0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102632:	a1 84 b5 10 80       	mov    0x8010b584,%eax
80102637:	83 c4 10             	add    $0x10,%esp
8010263a:	85 c0                	test   %eax,%eax
8010263c:	74 05                	je     80102643 <ideintr+0x83>
    idestart(idequeue);
8010263e:	e8 0d fe ff ff       	call   80102450 <idestart>
    release(&idelock);
80102643:	83 ec 0c             	sub    $0xc,%esp
80102646:	68 a0 b5 10 80       	push   $0x8010b5a0
8010264b:	e8 10 2b 00 00       	call   80105160 <release>

  release(&idelock);
}
80102650:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102653:	5b                   	pop    %ebx
80102654:	5e                   	pop    %esi
80102655:	5f                   	pop    %edi
80102656:	5d                   	pop    %ebp
80102657:	c3                   	ret    
80102658:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010265f:	90                   	nop

80102660 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102660:	f3 0f 1e fb          	endbr32 
80102664:	55                   	push   %ebp
80102665:	89 e5                	mov    %esp,%ebp
80102667:	53                   	push   %ebx
80102668:	83 ec 10             	sub    $0x10,%esp
8010266b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010266e:	8d 43 0c             	lea    0xc(%ebx),%eax
80102671:	50                   	push   %eax
80102672:	e8 49 28 00 00       	call   80104ec0 <holdingsleep>
80102677:	83 c4 10             	add    $0x10,%esp
8010267a:	85 c0                	test   %eax,%eax
8010267c:	0f 84 cf 00 00 00    	je     80102751 <iderw+0xf1>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
80102682:	8b 03                	mov    (%ebx),%eax
80102684:	83 e0 06             	and    $0x6,%eax
80102687:	83 f8 02             	cmp    $0x2,%eax
8010268a:	0f 84 b4 00 00 00    	je     80102744 <iderw+0xe4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
80102690:	8b 53 04             	mov    0x4(%ebx),%edx
80102693:	85 d2                	test   %edx,%edx
80102695:	74 0d                	je     801026a4 <iderw+0x44>
80102697:	a1 80 b5 10 80       	mov    0x8010b580,%eax
8010269c:	85 c0                	test   %eax,%eax
8010269e:	0f 84 93 00 00 00    	je     80102737 <iderw+0xd7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
801026a4:	83 ec 0c             	sub    $0xc,%esp
801026a7:	68 a0 b5 10 80       	push   $0x8010b5a0
801026ac:	e8 ef 29 00 00       	call   801050a0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801026b1:	a1 84 b5 10 80       	mov    0x8010b584,%eax
  b->qnext = 0;
801026b6:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801026bd:	83 c4 10             	add    $0x10,%esp
801026c0:	85 c0                	test   %eax,%eax
801026c2:	74 6c                	je     80102730 <iderw+0xd0>
801026c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801026c8:	89 c2                	mov    %eax,%edx
801026ca:	8b 40 58             	mov    0x58(%eax),%eax
801026cd:	85 c0                	test   %eax,%eax
801026cf:	75 f7                	jne    801026c8 <iderw+0x68>
801026d1:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
801026d4:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
801026d6:	39 1d 84 b5 10 80    	cmp    %ebx,0x8010b584
801026dc:	74 42                	je     80102720 <iderw+0xc0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801026de:	8b 03                	mov    (%ebx),%eax
801026e0:	83 e0 06             	and    $0x6,%eax
801026e3:	83 f8 02             	cmp    $0x2,%eax
801026e6:	74 23                	je     8010270b <iderw+0xab>
801026e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801026ef:	90                   	nop
    sleep(b, &idelock);
801026f0:	83 ec 08             	sub    $0x8,%esp
801026f3:	68 a0 b5 10 80       	push   $0x8010b5a0
801026f8:	53                   	push   %ebx
801026f9:	e8 22 21 00 00       	call   80104820 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801026fe:	8b 03                	mov    (%ebx),%eax
80102700:	83 c4 10             	add    $0x10,%esp
80102703:	83 e0 06             	and    $0x6,%eax
80102706:	83 f8 02             	cmp    $0x2,%eax
80102709:	75 e5                	jne    801026f0 <iderw+0x90>
  }


  release(&idelock);
8010270b:	c7 45 08 a0 b5 10 80 	movl   $0x8010b5a0,0x8(%ebp)
}
80102712:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102715:	c9                   	leave  
  release(&idelock);
80102716:	e9 45 2a 00 00       	jmp    80105160 <release>
8010271b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010271f:	90                   	nop
    idestart(b);
80102720:	89 d8                	mov    %ebx,%eax
80102722:	e8 29 fd ff ff       	call   80102450 <idestart>
80102727:	eb b5                	jmp    801026de <iderw+0x7e>
80102729:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102730:	ba 84 b5 10 80       	mov    $0x8010b584,%edx
80102735:	eb 9d                	jmp    801026d4 <iderw+0x74>
    panic("iderw: ide disk 1 not present");
80102737:	83 ec 0c             	sub    $0xc,%esp
8010273a:	68 4d 80 10 80       	push   $0x8010804d
8010273f:	e8 4c dc ff ff       	call   80100390 <panic>
    panic("iderw: nothing to do");
80102744:	83 ec 0c             	sub    $0xc,%esp
80102747:	68 38 80 10 80       	push   $0x80108038
8010274c:	e8 3f dc ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
80102751:	83 ec 0c             	sub    $0xc,%esp
80102754:	68 22 80 10 80       	push   $0x80108022
80102759:	e8 32 dc ff ff       	call   80100390 <panic>
8010275e:	66 90                	xchg   %ax,%ax

80102760 <ioapicinit>:
80102760:	f3 0f 1e fb          	endbr32 
80102764:	55                   	push   %ebp
80102765:	c7 05 74 36 11 80 00 	movl   $0xfec00000,0x80113674
8010276c:	00 c0 fe 
8010276f:	89 e5                	mov    %esp,%ebp
80102771:	56                   	push   %esi
80102772:	53                   	push   %ebx
80102773:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
8010277a:	00 00 00 
8010277d:	8b 15 74 36 11 80    	mov    0x80113674,%edx
80102783:	8b 72 10             	mov    0x10(%edx),%esi
80102786:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
8010278c:	8b 0d 74 36 11 80    	mov    0x80113674,%ecx
80102792:	0f b6 15 a0 37 11 80 	movzbl 0x801137a0,%edx
80102799:	c1 ee 10             	shr    $0x10,%esi
8010279c:	89 f0                	mov    %esi,%eax
8010279e:	0f b6 f0             	movzbl %al,%esi
801027a1:	8b 41 10             	mov    0x10(%ecx),%eax
801027a4:	c1 e8 18             	shr    $0x18,%eax
801027a7:	39 c2                	cmp    %eax,%edx
801027a9:	74 16                	je     801027c1 <ioapicinit+0x61>
801027ab:	83 ec 0c             	sub    $0xc,%esp
801027ae:	68 6c 80 10 80       	push   $0x8010806c
801027b3:	e8 f8 de ff ff       	call   801006b0 <cprintf>
801027b8:	8b 0d 74 36 11 80    	mov    0x80113674,%ecx
801027be:	83 c4 10             	add    $0x10,%esp
801027c1:	83 c6 21             	add    $0x21,%esi
801027c4:	ba 10 00 00 00       	mov    $0x10,%edx
801027c9:	b8 20 00 00 00       	mov    $0x20,%eax
801027ce:	66 90                	xchg   %ax,%ax
801027d0:	89 11                	mov    %edx,(%ecx)
801027d2:	89 c3                	mov    %eax,%ebx
801027d4:	8b 0d 74 36 11 80    	mov    0x80113674,%ecx
801027da:	83 c0 01             	add    $0x1,%eax
801027dd:	81 cb 00 00 01 00    	or     $0x10000,%ebx
801027e3:	89 59 10             	mov    %ebx,0x10(%ecx)
801027e6:	8d 5a 01             	lea    0x1(%edx),%ebx
801027e9:	83 c2 02             	add    $0x2,%edx
801027ec:	89 19                	mov    %ebx,(%ecx)
801027ee:	8b 0d 74 36 11 80    	mov    0x80113674,%ecx
801027f4:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
801027fb:	39 f0                	cmp    %esi,%eax
801027fd:	75 d1                	jne    801027d0 <ioapicinit+0x70>
801027ff:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102802:	5b                   	pop    %ebx
80102803:	5e                   	pop    %esi
80102804:	5d                   	pop    %ebp
80102805:	c3                   	ret    
80102806:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010280d:	8d 76 00             	lea    0x0(%esi),%esi

80102810 <ioapicenable>:
80102810:	f3 0f 1e fb          	endbr32 
80102814:	55                   	push   %ebp
80102815:	8b 0d 74 36 11 80    	mov    0x80113674,%ecx
8010281b:	89 e5                	mov    %esp,%ebp
8010281d:	8b 45 08             	mov    0x8(%ebp),%eax
80102820:	8d 50 20             	lea    0x20(%eax),%edx
80102823:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
80102827:	89 01                	mov    %eax,(%ecx)
80102829:	8b 0d 74 36 11 80    	mov    0x80113674,%ecx
8010282f:	83 c0 01             	add    $0x1,%eax
80102832:	89 51 10             	mov    %edx,0x10(%ecx)
80102835:	8b 55 0c             	mov    0xc(%ebp),%edx
80102838:	89 01                	mov    %eax,(%ecx)
8010283a:	a1 74 36 11 80       	mov    0x80113674,%eax
8010283f:	c1 e2 18             	shl    $0x18,%edx
80102842:	89 50 10             	mov    %edx,0x10(%eax)
80102845:	5d                   	pop    %ebp
80102846:	c3                   	ret    
80102847:	66 90                	xchg   %ax,%ax
80102849:	66 90                	xchg   %ax,%ax
8010284b:	66 90                	xchg   %ax,%ax
8010284d:	66 90                	xchg   %ax,%ax
8010284f:	90                   	nop

80102850 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102850:	f3 0f 1e fb          	endbr32 
80102854:	55                   	push   %ebp
80102855:	89 e5                	mov    %esp,%ebp
80102857:	53                   	push   %ebx
80102858:	83 ec 04             	sub    $0x4,%esp
8010285b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010285e:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102864:	75 7a                	jne    801028e0 <kfree+0x90>
80102866:	81 fb 88 73 11 80    	cmp    $0x80117388,%ebx
8010286c:	72 72                	jb     801028e0 <kfree+0x90>
8010286e:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102874:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102879:	77 65                	ja     801028e0 <kfree+0x90>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
8010287b:	83 ec 04             	sub    $0x4,%esp
8010287e:	68 00 10 00 00       	push   $0x1000
80102883:	6a 01                	push   $0x1
80102885:	53                   	push   %ebx
80102886:	e8 25 29 00 00       	call   801051b0 <memset>

  if(kmem.use_lock)
8010288b:	8b 15 b4 36 11 80    	mov    0x801136b4,%edx
80102891:	83 c4 10             	add    $0x10,%esp
80102894:	85 d2                	test   %edx,%edx
80102896:	75 20                	jne    801028b8 <kfree+0x68>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102898:	a1 b8 36 11 80       	mov    0x801136b8,%eax
8010289d:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010289f:	a1 b4 36 11 80       	mov    0x801136b4,%eax
  kmem.freelist = r;
801028a4:	89 1d b8 36 11 80    	mov    %ebx,0x801136b8
  if(kmem.use_lock)
801028aa:	85 c0                	test   %eax,%eax
801028ac:	75 22                	jne    801028d0 <kfree+0x80>
    release(&kmem.lock);
}
801028ae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801028b1:	c9                   	leave  
801028b2:	c3                   	ret    
801028b3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801028b7:	90                   	nop
    acquire(&kmem.lock);
801028b8:	83 ec 0c             	sub    $0xc,%esp
801028bb:	68 80 36 11 80       	push   $0x80113680
801028c0:	e8 db 27 00 00       	call   801050a0 <acquire>
801028c5:	83 c4 10             	add    $0x10,%esp
801028c8:	eb ce                	jmp    80102898 <kfree+0x48>
801028ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
801028d0:	c7 45 08 80 36 11 80 	movl   $0x80113680,0x8(%ebp)
}
801028d7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801028da:	c9                   	leave  
    release(&kmem.lock);
801028db:	e9 80 28 00 00       	jmp    80105160 <release>
    panic("kfree");
801028e0:	83 ec 0c             	sub    $0xc,%esp
801028e3:	68 9e 80 10 80       	push   $0x8010809e
801028e8:	e8 a3 da ff ff       	call   80100390 <panic>
801028ed:	8d 76 00             	lea    0x0(%esi),%esi

801028f0 <freerange>:
{
801028f0:	f3 0f 1e fb          	endbr32 
801028f4:	55                   	push   %ebp
801028f5:	89 e5                	mov    %esp,%ebp
801028f7:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
801028f8:	8b 45 08             	mov    0x8(%ebp),%eax
{
801028fb:	8b 75 0c             	mov    0xc(%ebp),%esi
801028fe:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801028ff:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102905:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010290b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102911:	39 de                	cmp    %ebx,%esi
80102913:	72 1f                	jb     80102934 <freerange+0x44>
80102915:	8d 76 00             	lea    0x0(%esi),%esi
    kfree(p);
80102918:	83 ec 0c             	sub    $0xc,%esp
8010291b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102921:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102927:	50                   	push   %eax
80102928:	e8 23 ff ff ff       	call   80102850 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010292d:	83 c4 10             	add    $0x10,%esp
80102930:	39 f3                	cmp    %esi,%ebx
80102932:	76 e4                	jbe    80102918 <freerange+0x28>
}
80102934:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102937:	5b                   	pop    %ebx
80102938:	5e                   	pop    %esi
80102939:	5d                   	pop    %ebp
8010293a:	c3                   	ret    
8010293b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010293f:	90                   	nop

80102940 <kinit1>:
{
80102940:	f3 0f 1e fb          	endbr32 
80102944:	55                   	push   %ebp
80102945:	89 e5                	mov    %esp,%ebp
80102947:	56                   	push   %esi
80102948:	53                   	push   %ebx
80102949:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
8010294c:	83 ec 08             	sub    $0x8,%esp
8010294f:	68 a4 80 10 80       	push   $0x801080a4
80102954:	68 80 36 11 80       	push   $0x80113680
80102959:	e8 c2 25 00 00       	call   80104f20 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010295e:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102961:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102964:	c7 05 b4 36 11 80 00 	movl   $0x0,0x801136b4
8010296b:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010296e:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102974:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010297a:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102980:	39 de                	cmp    %ebx,%esi
80102982:	72 20                	jb     801029a4 <kinit1+0x64>
80102984:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102988:	83 ec 0c             	sub    $0xc,%esp
8010298b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102991:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102997:	50                   	push   %eax
80102998:	e8 b3 fe ff ff       	call   80102850 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010299d:	83 c4 10             	add    $0x10,%esp
801029a0:	39 de                	cmp    %ebx,%esi
801029a2:	73 e4                	jae    80102988 <kinit1+0x48>
}
801029a4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801029a7:	5b                   	pop    %ebx
801029a8:	5e                   	pop    %esi
801029a9:	5d                   	pop    %ebp
801029aa:	c3                   	ret    
801029ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801029af:	90                   	nop

801029b0 <kinit2>:
{
801029b0:	f3 0f 1e fb          	endbr32 
801029b4:	55                   	push   %ebp
801029b5:	89 e5                	mov    %esp,%ebp
801029b7:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
801029b8:	8b 45 08             	mov    0x8(%ebp),%eax
{
801029bb:	8b 75 0c             	mov    0xc(%ebp),%esi
801029be:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801029bf:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801029c5:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801029cb:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801029d1:	39 de                	cmp    %ebx,%esi
801029d3:	72 1f                	jb     801029f4 <kinit2+0x44>
801029d5:	8d 76 00             	lea    0x0(%esi),%esi
    kfree(p);
801029d8:	83 ec 0c             	sub    $0xc,%esp
801029db:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801029e1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801029e7:	50                   	push   %eax
801029e8:	e8 63 fe ff ff       	call   80102850 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801029ed:	83 c4 10             	add    $0x10,%esp
801029f0:	39 de                	cmp    %ebx,%esi
801029f2:	73 e4                	jae    801029d8 <kinit2+0x28>
  kmem.use_lock = 1;
801029f4:	c7 05 b4 36 11 80 01 	movl   $0x1,0x801136b4
801029fb:	00 00 00 
}
801029fe:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102a01:	5b                   	pop    %ebx
80102a02:	5e                   	pop    %esi
80102a03:	5d                   	pop    %ebp
80102a04:	c3                   	ret    
80102a05:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102a0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102a10 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102a10:	f3 0f 1e fb          	endbr32 
  struct run *r;

  if(kmem.use_lock)
80102a14:	a1 b4 36 11 80       	mov    0x801136b4,%eax
80102a19:	85 c0                	test   %eax,%eax
80102a1b:	75 1b                	jne    80102a38 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102a1d:	a1 b8 36 11 80       	mov    0x801136b8,%eax
  if(r)
80102a22:	85 c0                	test   %eax,%eax
80102a24:	74 0a                	je     80102a30 <kalloc+0x20>
    kmem.freelist = r->next;
80102a26:	8b 10                	mov    (%eax),%edx
80102a28:	89 15 b8 36 11 80    	mov    %edx,0x801136b8
  if(kmem.use_lock)
80102a2e:	c3                   	ret    
80102a2f:	90                   	nop
    release(&kmem.lock);
  return (char*)r;
}
80102a30:	c3                   	ret    
80102a31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
80102a38:	55                   	push   %ebp
80102a39:	89 e5                	mov    %esp,%ebp
80102a3b:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
80102a3e:	68 80 36 11 80       	push   $0x80113680
80102a43:	e8 58 26 00 00       	call   801050a0 <acquire>
  r = kmem.freelist;
80102a48:	a1 b8 36 11 80       	mov    0x801136b8,%eax
  if(r)
80102a4d:	8b 15 b4 36 11 80    	mov    0x801136b4,%edx
80102a53:	83 c4 10             	add    $0x10,%esp
80102a56:	85 c0                	test   %eax,%eax
80102a58:	74 08                	je     80102a62 <kalloc+0x52>
    kmem.freelist = r->next;
80102a5a:	8b 08                	mov    (%eax),%ecx
80102a5c:	89 0d b8 36 11 80    	mov    %ecx,0x801136b8
  if(kmem.use_lock)
80102a62:	85 d2                	test   %edx,%edx
80102a64:	74 16                	je     80102a7c <kalloc+0x6c>
    release(&kmem.lock);
80102a66:	83 ec 0c             	sub    $0xc,%esp
80102a69:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102a6c:	68 80 36 11 80       	push   $0x80113680
80102a71:	e8 ea 26 00 00       	call   80105160 <release>
  return (char*)r;
80102a76:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
80102a79:	83 c4 10             	add    $0x10,%esp
}
80102a7c:	c9                   	leave  
80102a7d:	c3                   	ret    
80102a7e:	66 90                	xchg   %ax,%ax

80102a80 <kbdgetc>:
80102a80:	f3 0f 1e fb          	endbr32 
80102a84:	ba 64 00 00 00       	mov    $0x64,%edx
80102a89:	ec                   	in     (%dx),%al
80102a8a:	a8 01                	test   $0x1,%al
80102a8c:	0f 84 be 00 00 00    	je     80102b50 <kbdgetc+0xd0>
80102a92:	55                   	push   %ebp
80102a93:	ba 60 00 00 00       	mov    $0x60,%edx
80102a98:	89 e5                	mov    %esp,%ebp
80102a9a:	53                   	push   %ebx
80102a9b:	ec                   	in     (%dx),%al
80102a9c:	8b 1d d4 b5 10 80    	mov    0x8010b5d4,%ebx
80102aa2:	0f b6 d0             	movzbl %al,%edx
80102aa5:	3c e0                	cmp    $0xe0,%al
80102aa7:	74 57                	je     80102b00 <kbdgetc+0x80>
80102aa9:	89 d9                	mov    %ebx,%ecx
80102aab:	83 e1 40             	and    $0x40,%ecx
80102aae:	84 c0                	test   %al,%al
80102ab0:	78 5e                	js     80102b10 <kbdgetc+0x90>
80102ab2:	85 c9                	test   %ecx,%ecx
80102ab4:	74 09                	je     80102abf <kbdgetc+0x3f>
80102ab6:	83 c8 80             	or     $0xffffff80,%eax
80102ab9:	83 e3 bf             	and    $0xffffffbf,%ebx
80102abc:	0f b6 d0             	movzbl %al,%edx
80102abf:	0f b6 8a e0 81 10 80 	movzbl -0x7fef7e20(%edx),%ecx
80102ac6:	0f b6 82 e0 80 10 80 	movzbl -0x7fef7f20(%edx),%eax
80102acd:	09 d9                	or     %ebx,%ecx
80102acf:	31 c1                	xor    %eax,%ecx
80102ad1:	89 c8                	mov    %ecx,%eax
80102ad3:	89 0d d4 b5 10 80    	mov    %ecx,0x8010b5d4
80102ad9:	83 e0 03             	and    $0x3,%eax
80102adc:	83 e1 08             	and    $0x8,%ecx
80102adf:	8b 04 85 c0 80 10 80 	mov    -0x7fef7f40(,%eax,4),%eax
80102ae6:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
80102aea:	74 0b                	je     80102af7 <kbdgetc+0x77>
80102aec:	8d 50 9f             	lea    -0x61(%eax),%edx
80102aef:	83 fa 19             	cmp    $0x19,%edx
80102af2:	77 44                	ja     80102b38 <kbdgetc+0xb8>
80102af4:	83 e8 20             	sub    $0x20,%eax
80102af7:	5b                   	pop    %ebx
80102af8:	5d                   	pop    %ebp
80102af9:	c3                   	ret    
80102afa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102b00:	83 cb 40             	or     $0x40,%ebx
80102b03:	31 c0                	xor    %eax,%eax
80102b05:	89 1d d4 b5 10 80    	mov    %ebx,0x8010b5d4
80102b0b:	5b                   	pop    %ebx
80102b0c:	5d                   	pop    %ebp
80102b0d:	c3                   	ret    
80102b0e:	66 90                	xchg   %ax,%ax
80102b10:	83 e0 7f             	and    $0x7f,%eax
80102b13:	85 c9                	test   %ecx,%ecx
80102b15:	0f 44 d0             	cmove  %eax,%edx
80102b18:	31 c0                	xor    %eax,%eax
80102b1a:	0f b6 8a e0 81 10 80 	movzbl -0x7fef7e20(%edx),%ecx
80102b21:	83 c9 40             	or     $0x40,%ecx
80102b24:	0f b6 c9             	movzbl %cl,%ecx
80102b27:	f7 d1                	not    %ecx
80102b29:	21 d9                	and    %ebx,%ecx
80102b2b:	5b                   	pop    %ebx
80102b2c:	5d                   	pop    %ebp
80102b2d:	89 0d d4 b5 10 80    	mov    %ecx,0x8010b5d4
80102b33:	c3                   	ret    
80102b34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102b38:	8d 48 bf             	lea    -0x41(%eax),%ecx
80102b3b:	8d 50 20             	lea    0x20(%eax),%edx
80102b3e:	5b                   	pop    %ebx
80102b3f:	5d                   	pop    %ebp
80102b40:	83 f9 1a             	cmp    $0x1a,%ecx
80102b43:	0f 42 c2             	cmovb  %edx,%eax
80102b46:	c3                   	ret    
80102b47:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102b4e:	66 90                	xchg   %ax,%ax
80102b50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102b55:	c3                   	ret    
80102b56:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102b5d:	8d 76 00             	lea    0x0(%esi),%esi

80102b60 <kbdintr>:
80102b60:	f3 0f 1e fb          	endbr32 
80102b64:	55                   	push   %ebp
80102b65:	89 e5                	mov    %esp,%ebp
80102b67:	83 ec 14             	sub    $0x14,%esp
80102b6a:	68 80 2a 10 80       	push   $0x80102a80
80102b6f:	e8 4c dd ff ff       	call   801008c0 <consoleintr>
80102b74:	83 c4 10             	add    $0x10,%esp
80102b77:	c9                   	leave  
80102b78:	c3                   	ret    
80102b79:	66 90                	xchg   %ax,%ax
80102b7b:	66 90                	xchg   %ax,%ax
80102b7d:	66 90                	xchg   %ax,%ax
80102b7f:	90                   	nop

80102b80 <lapicinit>:
  lapic[ID];  // wait for write to finish, by reading
}

void
lapicinit(void)
{
80102b80:	f3 0f 1e fb          	endbr32 
  if(!lapic)
80102b84:	a1 bc 36 11 80       	mov    0x801136bc,%eax
80102b89:	85 c0                	test   %eax,%eax
80102b8b:	0f 84 c7 00 00 00    	je     80102c58 <lapicinit+0xd8>
  lapic[index] = value;
80102b91:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102b98:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102b9b:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102b9e:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102ba5:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102ba8:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102bab:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102bb2:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102bb5:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102bb8:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
80102bbf:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102bc2:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102bc5:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80102bcc:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102bcf:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102bd2:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102bd9:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102bdc:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102bdf:	8b 50 30             	mov    0x30(%eax),%edx
80102be2:	c1 ea 10             	shr    $0x10,%edx
80102be5:	81 e2 fc 00 00 00    	and    $0xfc,%edx
80102beb:	75 73                	jne    80102c60 <lapicinit+0xe0>
  lapic[index] = value;
80102bed:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102bf4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102bf7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102bfa:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102c01:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102c04:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102c07:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102c0e:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102c11:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102c14:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102c1b:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102c1e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102c21:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102c28:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102c2b:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102c2e:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102c35:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102c38:	8b 50 20             	mov    0x20(%eax),%edx
80102c3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102c3f:	90                   	nop
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102c40:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102c46:	80 e6 10             	and    $0x10,%dh
80102c49:	75 f5                	jne    80102c40 <lapicinit+0xc0>
  lapic[index] = value;
80102c4b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102c52:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102c55:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102c58:	c3                   	ret    
80102c59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
80102c60:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102c67:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102c6a:	8b 50 20             	mov    0x20(%eax),%edx
}
80102c6d:	e9 7b ff ff ff       	jmp    80102bed <lapicinit+0x6d>
80102c72:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102c79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102c80 <lapicid>:

int
lapicid(void)
{
80102c80:	f3 0f 1e fb          	endbr32 
  if (!lapic)
80102c84:	a1 bc 36 11 80       	mov    0x801136bc,%eax
80102c89:	85 c0                	test   %eax,%eax
80102c8b:	74 0b                	je     80102c98 <lapicid+0x18>
    return 0;
  return lapic[ID] >> 24;
80102c8d:	8b 40 20             	mov    0x20(%eax),%eax
80102c90:	c1 e8 18             	shr    $0x18,%eax
80102c93:	c3                   	ret    
80102c94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 0;
80102c98:	31 c0                	xor    %eax,%eax
}
80102c9a:	c3                   	ret    
80102c9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102c9f:	90                   	nop

80102ca0 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
80102ca0:	f3 0f 1e fb          	endbr32 
  if(lapic)
80102ca4:	a1 bc 36 11 80       	mov    0x801136bc,%eax
80102ca9:	85 c0                	test   %eax,%eax
80102cab:	74 0d                	je     80102cba <lapiceoi+0x1a>
  lapic[index] = value;
80102cad:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102cb4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102cb7:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102cba:	c3                   	ret    
80102cbb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102cbf:	90                   	nop

80102cc0 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102cc0:	f3 0f 1e fb          	endbr32 
}
80102cc4:	c3                   	ret    
80102cc5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102ccc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102cd0 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102cd0:	f3 0f 1e fb          	endbr32 
80102cd4:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102cd5:	b8 0f 00 00 00       	mov    $0xf,%eax
80102cda:	ba 70 00 00 00       	mov    $0x70,%edx
80102cdf:	89 e5                	mov    %esp,%ebp
80102ce1:	53                   	push   %ebx
80102ce2:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102ce5:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102ce8:	ee                   	out    %al,(%dx)
80102ce9:	b8 0a 00 00 00       	mov    $0xa,%eax
80102cee:	ba 71 00 00 00       	mov    $0x71,%edx
80102cf3:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102cf4:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102cf6:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102cf9:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
80102cff:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102d01:	c1 e9 0c             	shr    $0xc,%ecx
  lapicw(ICRHI, apicid<<24);
80102d04:	89 da                	mov    %ebx,%edx
  wrv[1] = addr >> 4;
80102d06:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
80102d09:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102d0c:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
80102d12:	a1 bc 36 11 80       	mov    0x801136bc,%eax
80102d17:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102d1d:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102d20:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102d27:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102d2a:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102d2d:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102d34:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102d37:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102d3a:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102d40:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102d43:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102d49:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102d4c:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102d52:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d55:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
    microdelay(200);
  }
}
80102d5b:	5b                   	pop    %ebx
  lapic[ID];  // wait for write to finish, by reading
80102d5c:	8b 40 20             	mov    0x20(%eax),%eax
}
80102d5f:	5d                   	pop    %ebp
80102d60:	c3                   	ret    
80102d61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102d68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102d6f:	90                   	nop

80102d70 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102d70:	f3 0f 1e fb          	endbr32 
80102d74:	55                   	push   %ebp
80102d75:	b8 0b 00 00 00       	mov    $0xb,%eax
80102d7a:	ba 70 00 00 00       	mov    $0x70,%edx
80102d7f:	89 e5                	mov    %esp,%ebp
80102d81:	57                   	push   %edi
80102d82:	56                   	push   %esi
80102d83:	53                   	push   %ebx
80102d84:	83 ec 4c             	sub    $0x4c,%esp
80102d87:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102d88:	ba 71 00 00 00       	mov    $0x71,%edx
80102d8d:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
80102d8e:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102d91:	bb 70 00 00 00       	mov    $0x70,%ebx
80102d96:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102d99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102da0:	31 c0                	xor    %eax,%eax
80102da2:	89 da                	mov    %ebx,%edx
80102da4:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102da5:	b9 71 00 00 00       	mov    $0x71,%ecx
80102daa:	89 ca                	mov    %ecx,%edx
80102dac:	ec                   	in     (%dx),%al
80102dad:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102db0:	89 da                	mov    %ebx,%edx
80102db2:	b8 02 00 00 00       	mov    $0x2,%eax
80102db7:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102db8:	89 ca                	mov    %ecx,%edx
80102dba:	ec                   	in     (%dx),%al
80102dbb:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102dbe:	89 da                	mov    %ebx,%edx
80102dc0:	b8 04 00 00 00       	mov    $0x4,%eax
80102dc5:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102dc6:	89 ca                	mov    %ecx,%edx
80102dc8:	ec                   	in     (%dx),%al
80102dc9:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102dcc:	89 da                	mov    %ebx,%edx
80102dce:	b8 07 00 00 00       	mov    $0x7,%eax
80102dd3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102dd4:	89 ca                	mov    %ecx,%edx
80102dd6:	ec                   	in     (%dx),%al
80102dd7:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102dda:	89 da                	mov    %ebx,%edx
80102ddc:	b8 08 00 00 00       	mov    $0x8,%eax
80102de1:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102de2:	89 ca                	mov    %ecx,%edx
80102de4:	ec                   	in     (%dx),%al
80102de5:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102de7:	89 da                	mov    %ebx,%edx
80102de9:	b8 09 00 00 00       	mov    $0x9,%eax
80102dee:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102def:	89 ca                	mov    %ecx,%edx
80102df1:	ec                   	in     (%dx),%al
80102df2:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102df4:	89 da                	mov    %ebx,%edx
80102df6:	b8 0a 00 00 00       	mov    $0xa,%eax
80102dfb:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102dfc:	89 ca                	mov    %ecx,%edx
80102dfe:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102dff:	84 c0                	test   %al,%al
80102e01:	78 9d                	js     80102da0 <cmostime+0x30>
  return inb(CMOS_RETURN);
80102e03:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80102e07:	89 fa                	mov    %edi,%edx
80102e09:	0f b6 fa             	movzbl %dl,%edi
80102e0c:	89 f2                	mov    %esi,%edx
80102e0e:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102e11:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102e15:	0f b6 f2             	movzbl %dl,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102e18:	89 da                	mov    %ebx,%edx
80102e1a:	89 7d c8             	mov    %edi,-0x38(%ebp)
80102e1d:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102e20:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80102e24:	89 75 cc             	mov    %esi,-0x34(%ebp)
80102e27:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102e2a:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102e2e:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102e31:	31 c0                	xor    %eax,%eax
80102e33:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102e34:	89 ca                	mov    %ecx,%edx
80102e36:	ec                   	in     (%dx),%al
80102e37:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102e3a:	89 da                	mov    %ebx,%edx
80102e3c:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102e3f:	b8 02 00 00 00       	mov    $0x2,%eax
80102e44:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102e45:	89 ca                	mov    %ecx,%edx
80102e47:	ec                   	in     (%dx),%al
80102e48:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102e4b:	89 da                	mov    %ebx,%edx
80102e4d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102e50:	b8 04 00 00 00       	mov    $0x4,%eax
80102e55:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102e56:	89 ca                	mov    %ecx,%edx
80102e58:	ec                   	in     (%dx),%al
80102e59:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102e5c:	89 da                	mov    %ebx,%edx
80102e5e:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102e61:	b8 07 00 00 00       	mov    $0x7,%eax
80102e66:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102e67:	89 ca                	mov    %ecx,%edx
80102e69:	ec                   	in     (%dx),%al
80102e6a:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102e6d:	89 da                	mov    %ebx,%edx
80102e6f:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102e72:	b8 08 00 00 00       	mov    $0x8,%eax
80102e77:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102e78:	89 ca                	mov    %ecx,%edx
80102e7a:	ec                   	in     (%dx),%al
80102e7b:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102e7e:	89 da                	mov    %ebx,%edx
80102e80:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102e83:	b8 09 00 00 00       	mov    $0x9,%eax
80102e88:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102e89:	89 ca                	mov    %ecx,%edx
80102e8b:	ec                   	in     (%dx),%al
80102e8c:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102e8f:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80102e92:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102e95:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102e98:	6a 18                	push   $0x18
80102e9a:	50                   	push   %eax
80102e9b:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102e9e:	50                   	push   %eax
80102e9f:	e8 5c 23 00 00       	call   80105200 <memcmp>
80102ea4:	83 c4 10             	add    $0x10,%esp
80102ea7:	85 c0                	test   %eax,%eax
80102ea9:	0f 85 f1 fe ff ff    	jne    80102da0 <cmostime+0x30>
      break;
  }

  // convert
  if(bcd) {
80102eaf:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
80102eb3:	75 78                	jne    80102f2d <cmostime+0x1bd>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102eb5:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102eb8:	89 c2                	mov    %eax,%edx
80102eba:	83 e0 0f             	and    $0xf,%eax
80102ebd:	c1 ea 04             	shr    $0x4,%edx
80102ec0:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102ec3:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102ec6:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102ec9:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102ecc:	89 c2                	mov    %eax,%edx
80102ece:	83 e0 0f             	and    $0xf,%eax
80102ed1:	c1 ea 04             	shr    $0x4,%edx
80102ed4:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102ed7:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102eda:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102edd:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102ee0:	89 c2                	mov    %eax,%edx
80102ee2:	83 e0 0f             	and    $0xf,%eax
80102ee5:	c1 ea 04             	shr    $0x4,%edx
80102ee8:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102eeb:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102eee:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102ef1:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102ef4:	89 c2                	mov    %eax,%edx
80102ef6:	83 e0 0f             	and    $0xf,%eax
80102ef9:	c1 ea 04             	shr    $0x4,%edx
80102efc:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102eff:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102f02:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102f05:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102f08:	89 c2                	mov    %eax,%edx
80102f0a:	83 e0 0f             	and    $0xf,%eax
80102f0d:	c1 ea 04             	shr    $0x4,%edx
80102f10:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102f13:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102f16:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102f19:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102f1c:	89 c2                	mov    %eax,%edx
80102f1e:	83 e0 0f             	and    $0xf,%eax
80102f21:	c1 ea 04             	shr    $0x4,%edx
80102f24:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102f27:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102f2a:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102f2d:	8b 75 08             	mov    0x8(%ebp),%esi
80102f30:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102f33:	89 06                	mov    %eax,(%esi)
80102f35:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102f38:	89 46 04             	mov    %eax,0x4(%esi)
80102f3b:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102f3e:	89 46 08             	mov    %eax,0x8(%esi)
80102f41:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102f44:	89 46 0c             	mov    %eax,0xc(%esi)
80102f47:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102f4a:	89 46 10             	mov    %eax,0x10(%esi)
80102f4d:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102f50:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102f53:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102f5a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102f5d:	5b                   	pop    %ebx
80102f5e:	5e                   	pop    %esi
80102f5f:	5f                   	pop    %edi
80102f60:	5d                   	pop    %ebp
80102f61:	c3                   	ret    
80102f62:	66 90                	xchg   %ax,%ax
80102f64:	66 90                	xchg   %ax,%ax
80102f66:	66 90                	xchg   %ax,%ax
80102f68:	66 90                	xchg   %ax,%ax
80102f6a:	66 90                	xchg   %ax,%ax
80102f6c:	66 90                	xchg   %ax,%ax
80102f6e:	66 90                	xchg   %ax,%ax

80102f70 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102f70:	8b 0d 08 37 11 80    	mov    0x80113708,%ecx
80102f76:	85 c9                	test   %ecx,%ecx
80102f78:	0f 8e 8a 00 00 00    	jle    80103008 <install_trans+0x98>
{
80102f7e:	55                   	push   %ebp
80102f7f:	89 e5                	mov    %esp,%ebp
80102f81:	57                   	push   %edi
  for (tail = 0; tail < log.lh.n; tail++) {
80102f82:	31 ff                	xor    %edi,%edi
{
80102f84:	56                   	push   %esi
80102f85:	53                   	push   %ebx
80102f86:	83 ec 0c             	sub    $0xc,%esp
80102f89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102f90:	a1 f4 36 11 80       	mov    0x801136f4,%eax
80102f95:	83 ec 08             	sub    $0x8,%esp
80102f98:	01 f8                	add    %edi,%eax
80102f9a:	83 c0 01             	add    $0x1,%eax
80102f9d:	50                   	push   %eax
80102f9e:	ff 35 04 37 11 80    	pushl  0x80113704
80102fa4:	e8 27 d1 ff ff       	call   801000d0 <bread>
80102fa9:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102fab:	58                   	pop    %eax
80102fac:	5a                   	pop    %edx
80102fad:	ff 34 bd 0c 37 11 80 	pushl  -0x7feec8f4(,%edi,4)
80102fb4:	ff 35 04 37 11 80    	pushl  0x80113704
  for (tail = 0; tail < log.lh.n; tail++) {
80102fba:	83 c7 01             	add    $0x1,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102fbd:	e8 0e d1 ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102fc2:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102fc5:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102fc7:	8d 46 5c             	lea    0x5c(%esi),%eax
80102fca:	68 00 02 00 00       	push   $0x200
80102fcf:	50                   	push   %eax
80102fd0:	8d 43 5c             	lea    0x5c(%ebx),%eax
80102fd3:	50                   	push   %eax
80102fd4:	e8 77 22 00 00       	call   80105250 <memmove>
    bwrite(dbuf);  // write dst to disk
80102fd9:	89 1c 24             	mov    %ebx,(%esp)
80102fdc:	e8 cf d1 ff ff       	call   801001b0 <bwrite>
    brelse(lbuf);
80102fe1:	89 34 24             	mov    %esi,(%esp)
80102fe4:	e8 07 d2 ff ff       	call   801001f0 <brelse>
    brelse(dbuf);
80102fe9:	89 1c 24             	mov    %ebx,(%esp)
80102fec:	e8 ff d1 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102ff1:	83 c4 10             	add    $0x10,%esp
80102ff4:	39 3d 08 37 11 80    	cmp    %edi,0x80113708
80102ffa:	7f 94                	jg     80102f90 <install_trans+0x20>
  }
}
80102ffc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102fff:	5b                   	pop    %ebx
80103000:	5e                   	pop    %esi
80103001:	5f                   	pop    %edi
80103002:	5d                   	pop    %ebp
80103003:	c3                   	ret    
80103004:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103008:	c3                   	ret    
80103009:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103010 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80103010:	55                   	push   %ebp
80103011:	89 e5                	mov    %esp,%ebp
80103013:	53                   	push   %ebx
80103014:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80103017:	ff 35 f4 36 11 80    	pushl  0x801136f4
8010301d:	ff 35 04 37 11 80    	pushl  0x80113704
80103023:	e8 a8 d0 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80103028:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
8010302b:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
8010302d:	a1 08 37 11 80       	mov    0x80113708,%eax
80103032:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
80103035:	85 c0                	test   %eax,%eax
80103037:	7e 19                	jle    80103052 <write_head+0x42>
80103039:	31 d2                	xor    %edx,%edx
8010303b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010303f:	90                   	nop
    hb->block[i] = log.lh.block[i];
80103040:	8b 0c 95 0c 37 11 80 	mov    -0x7feec8f4(,%edx,4),%ecx
80103047:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
8010304b:	83 c2 01             	add    $0x1,%edx
8010304e:	39 d0                	cmp    %edx,%eax
80103050:	75 ee                	jne    80103040 <write_head+0x30>
  }
  bwrite(buf);
80103052:	83 ec 0c             	sub    $0xc,%esp
80103055:	53                   	push   %ebx
80103056:	e8 55 d1 ff ff       	call   801001b0 <bwrite>
  brelse(buf);
8010305b:	89 1c 24             	mov    %ebx,(%esp)
8010305e:	e8 8d d1 ff ff       	call   801001f0 <brelse>
}
80103063:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103066:	83 c4 10             	add    $0x10,%esp
80103069:	c9                   	leave  
8010306a:	c3                   	ret    
8010306b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010306f:	90                   	nop

80103070 <initlog>:
{
80103070:	f3 0f 1e fb          	endbr32 
80103074:	55                   	push   %ebp
80103075:	89 e5                	mov    %esp,%ebp
80103077:	53                   	push   %ebx
80103078:	83 ec 2c             	sub    $0x2c,%esp
8010307b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
8010307e:	68 e0 82 10 80       	push   $0x801082e0
80103083:	68 c0 36 11 80       	push   $0x801136c0
80103088:	e8 93 1e 00 00       	call   80104f20 <initlock>
  readsb(dev, &sb);
8010308d:	58                   	pop    %eax
8010308e:	8d 45 dc             	lea    -0x24(%ebp),%eax
80103091:	5a                   	pop    %edx
80103092:	50                   	push   %eax
80103093:	53                   	push   %ebx
80103094:	e8 47 e8 ff ff       	call   801018e0 <readsb>
  log.start = sb.logstart;
80103099:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
8010309c:	59                   	pop    %ecx
  log.dev = dev;
8010309d:	89 1d 04 37 11 80    	mov    %ebx,0x80113704
  log.size = sb.nlog;
801030a3:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
801030a6:	a3 f4 36 11 80       	mov    %eax,0x801136f4
  log.size = sb.nlog;
801030ab:	89 15 f8 36 11 80    	mov    %edx,0x801136f8
  struct buf *buf = bread(log.dev, log.start);
801030b1:	5a                   	pop    %edx
801030b2:	50                   	push   %eax
801030b3:	53                   	push   %ebx
801030b4:	e8 17 d0 ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
801030b9:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
801030bc:	8b 48 5c             	mov    0x5c(%eax),%ecx
801030bf:	89 0d 08 37 11 80    	mov    %ecx,0x80113708
  for (i = 0; i < log.lh.n; i++) {
801030c5:	85 c9                	test   %ecx,%ecx
801030c7:	7e 19                	jle    801030e2 <initlog+0x72>
801030c9:	31 d2                	xor    %edx,%edx
801030cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801030cf:	90                   	nop
    log.lh.block[i] = lh->block[i];
801030d0:	8b 5c 90 60          	mov    0x60(%eax,%edx,4),%ebx
801030d4:	89 1c 95 0c 37 11 80 	mov    %ebx,-0x7feec8f4(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
801030db:	83 c2 01             	add    $0x1,%edx
801030de:	39 d1                	cmp    %edx,%ecx
801030e0:	75 ee                	jne    801030d0 <initlog+0x60>
  brelse(buf);
801030e2:	83 ec 0c             	sub    $0xc,%esp
801030e5:	50                   	push   %eax
801030e6:	e8 05 d1 ff ff       	call   801001f0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
801030eb:	e8 80 fe ff ff       	call   80102f70 <install_trans>
  log.lh.n = 0;
801030f0:	c7 05 08 37 11 80 00 	movl   $0x0,0x80113708
801030f7:	00 00 00 
  write_head(); // clear the log
801030fa:	e8 11 ff ff ff       	call   80103010 <write_head>
}
801030ff:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103102:	83 c4 10             	add    $0x10,%esp
80103105:	c9                   	leave  
80103106:	c3                   	ret    
80103107:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010310e:	66 90                	xchg   %ax,%ax

80103110 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80103110:	f3 0f 1e fb          	endbr32 
80103114:	55                   	push   %ebp
80103115:	89 e5                	mov    %esp,%ebp
80103117:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
8010311a:	68 c0 36 11 80       	push   $0x801136c0
8010311f:	e8 7c 1f 00 00       	call   801050a0 <acquire>
80103124:	83 c4 10             	add    $0x10,%esp
80103127:	eb 1c                	jmp    80103145 <begin_op+0x35>
80103129:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80103130:	83 ec 08             	sub    $0x8,%esp
80103133:	68 c0 36 11 80       	push   $0x801136c0
80103138:	68 c0 36 11 80       	push   $0x801136c0
8010313d:	e8 de 16 00 00       	call   80104820 <sleep>
80103142:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80103145:	a1 00 37 11 80       	mov    0x80113700,%eax
8010314a:	85 c0                	test   %eax,%eax
8010314c:	75 e2                	jne    80103130 <begin_op+0x20>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
8010314e:	a1 fc 36 11 80       	mov    0x801136fc,%eax
80103153:	8b 15 08 37 11 80    	mov    0x80113708,%edx
80103159:	83 c0 01             	add    $0x1,%eax
8010315c:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
8010315f:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80103162:	83 fa 1e             	cmp    $0x1e,%edx
80103165:	7f c9                	jg     80103130 <begin_op+0x20>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80103167:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
8010316a:	a3 fc 36 11 80       	mov    %eax,0x801136fc
      release(&log.lock);
8010316f:	68 c0 36 11 80       	push   $0x801136c0
80103174:	e8 e7 1f 00 00       	call   80105160 <release>
      break;
    }
  }
}
80103179:	83 c4 10             	add    $0x10,%esp
8010317c:	c9                   	leave  
8010317d:	c3                   	ret    
8010317e:	66 90                	xchg   %ax,%ax

80103180 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80103180:	f3 0f 1e fb          	endbr32 
80103184:	55                   	push   %ebp
80103185:	89 e5                	mov    %esp,%ebp
80103187:	57                   	push   %edi
80103188:	56                   	push   %esi
80103189:	53                   	push   %ebx
8010318a:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
8010318d:	68 c0 36 11 80       	push   $0x801136c0
80103192:	e8 09 1f 00 00       	call   801050a0 <acquire>
  log.outstanding -= 1;
80103197:	a1 fc 36 11 80       	mov    0x801136fc,%eax
  if(log.committing)
8010319c:	8b 35 00 37 11 80    	mov    0x80113700,%esi
801031a2:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
801031a5:	8d 58 ff             	lea    -0x1(%eax),%ebx
801031a8:	89 1d fc 36 11 80    	mov    %ebx,0x801136fc
  if(log.committing)
801031ae:	85 f6                	test   %esi,%esi
801031b0:	0f 85 1e 01 00 00    	jne    801032d4 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
801031b6:	85 db                	test   %ebx,%ebx
801031b8:	0f 85 f2 00 00 00    	jne    801032b0 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
801031be:	c7 05 00 37 11 80 01 	movl   $0x1,0x80113700
801031c5:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
801031c8:	83 ec 0c             	sub    $0xc,%esp
801031cb:	68 c0 36 11 80       	push   $0x801136c0
801031d0:	e8 8b 1f 00 00       	call   80105160 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
801031d5:	8b 0d 08 37 11 80    	mov    0x80113708,%ecx
801031db:	83 c4 10             	add    $0x10,%esp
801031de:	85 c9                	test   %ecx,%ecx
801031e0:	7f 3e                	jg     80103220 <end_op+0xa0>
    acquire(&log.lock);
801031e2:	83 ec 0c             	sub    $0xc,%esp
801031e5:	68 c0 36 11 80       	push   $0x801136c0
801031ea:	e8 b1 1e 00 00       	call   801050a0 <acquire>
    wakeup(&log);
801031ef:	c7 04 24 c0 36 11 80 	movl   $0x801136c0,(%esp)
    log.committing = 0;
801031f6:	c7 05 00 37 11 80 00 	movl   $0x0,0x80113700
801031fd:	00 00 00 
    wakeup(&log);
80103200:	e8 db 17 00 00       	call   801049e0 <wakeup>
    release(&log.lock);
80103205:	c7 04 24 c0 36 11 80 	movl   $0x801136c0,(%esp)
8010320c:	e8 4f 1f 00 00       	call   80105160 <release>
80103211:	83 c4 10             	add    $0x10,%esp
}
80103214:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103217:	5b                   	pop    %ebx
80103218:	5e                   	pop    %esi
80103219:	5f                   	pop    %edi
8010321a:	5d                   	pop    %ebp
8010321b:	c3                   	ret    
8010321c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80103220:	a1 f4 36 11 80       	mov    0x801136f4,%eax
80103225:	83 ec 08             	sub    $0x8,%esp
80103228:	01 d8                	add    %ebx,%eax
8010322a:	83 c0 01             	add    $0x1,%eax
8010322d:	50                   	push   %eax
8010322e:	ff 35 04 37 11 80    	pushl  0x80113704
80103234:	e8 97 ce ff ff       	call   801000d0 <bread>
80103239:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010323b:	58                   	pop    %eax
8010323c:	5a                   	pop    %edx
8010323d:	ff 34 9d 0c 37 11 80 	pushl  -0x7feec8f4(,%ebx,4)
80103244:	ff 35 04 37 11 80    	pushl  0x80113704
  for (tail = 0; tail < log.lh.n; tail++) {
8010324a:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010324d:	e8 7e ce ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80103252:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103255:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80103257:	8d 40 5c             	lea    0x5c(%eax),%eax
8010325a:	68 00 02 00 00       	push   $0x200
8010325f:	50                   	push   %eax
80103260:	8d 46 5c             	lea    0x5c(%esi),%eax
80103263:	50                   	push   %eax
80103264:	e8 e7 1f 00 00       	call   80105250 <memmove>
    bwrite(to);  // write the log
80103269:	89 34 24             	mov    %esi,(%esp)
8010326c:	e8 3f cf ff ff       	call   801001b0 <bwrite>
    brelse(from);
80103271:	89 3c 24             	mov    %edi,(%esp)
80103274:	e8 77 cf ff ff       	call   801001f0 <brelse>
    brelse(to);
80103279:	89 34 24             	mov    %esi,(%esp)
8010327c:	e8 6f cf ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80103281:	83 c4 10             	add    $0x10,%esp
80103284:	3b 1d 08 37 11 80    	cmp    0x80113708,%ebx
8010328a:	7c 94                	jl     80103220 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
8010328c:	e8 7f fd ff ff       	call   80103010 <write_head>
    install_trans(); // Now install writes to home locations
80103291:	e8 da fc ff ff       	call   80102f70 <install_trans>
    log.lh.n = 0;
80103296:	c7 05 08 37 11 80 00 	movl   $0x0,0x80113708
8010329d:	00 00 00 
    write_head();    // Erase the transaction from the log
801032a0:	e8 6b fd ff ff       	call   80103010 <write_head>
801032a5:	e9 38 ff ff ff       	jmp    801031e2 <end_op+0x62>
801032aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
801032b0:	83 ec 0c             	sub    $0xc,%esp
801032b3:	68 c0 36 11 80       	push   $0x801136c0
801032b8:	e8 23 17 00 00       	call   801049e0 <wakeup>
  release(&log.lock);
801032bd:	c7 04 24 c0 36 11 80 	movl   $0x801136c0,(%esp)
801032c4:	e8 97 1e 00 00       	call   80105160 <release>
801032c9:	83 c4 10             	add    $0x10,%esp
}
801032cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801032cf:	5b                   	pop    %ebx
801032d0:	5e                   	pop    %esi
801032d1:	5f                   	pop    %edi
801032d2:	5d                   	pop    %ebp
801032d3:	c3                   	ret    
    panic("log.committing");
801032d4:	83 ec 0c             	sub    $0xc,%esp
801032d7:	68 e4 82 10 80       	push   $0x801082e4
801032dc:	e8 af d0 ff ff       	call   80100390 <panic>
801032e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801032e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801032ef:	90                   	nop

801032f0 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
801032f0:	f3 0f 1e fb          	endbr32 
801032f4:	55                   	push   %ebp
801032f5:	89 e5                	mov    %esp,%ebp
801032f7:	53                   	push   %ebx
801032f8:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
801032fb:	8b 15 08 37 11 80    	mov    0x80113708,%edx
{
80103301:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103304:	83 fa 1d             	cmp    $0x1d,%edx
80103307:	0f 8f 91 00 00 00    	jg     8010339e <log_write+0xae>
8010330d:	a1 f8 36 11 80       	mov    0x801136f8,%eax
80103312:	83 e8 01             	sub    $0x1,%eax
80103315:	39 c2                	cmp    %eax,%edx
80103317:	0f 8d 81 00 00 00    	jge    8010339e <log_write+0xae>
    panic("too big a transaction");
  if (log.outstanding < 1)
8010331d:	a1 fc 36 11 80       	mov    0x801136fc,%eax
80103322:	85 c0                	test   %eax,%eax
80103324:	0f 8e 81 00 00 00    	jle    801033ab <log_write+0xbb>
    panic("log_write outside of trans");

  acquire(&log.lock);
8010332a:	83 ec 0c             	sub    $0xc,%esp
8010332d:	68 c0 36 11 80       	push   $0x801136c0
80103332:	e8 69 1d 00 00       	call   801050a0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80103337:	8b 15 08 37 11 80    	mov    0x80113708,%edx
8010333d:	83 c4 10             	add    $0x10,%esp
80103340:	85 d2                	test   %edx,%edx
80103342:	7e 4e                	jle    80103392 <log_write+0xa2>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103344:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
80103347:	31 c0                	xor    %eax,%eax
80103349:	eb 0c                	jmp    80103357 <log_write+0x67>
8010334b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010334f:	90                   	nop
80103350:	83 c0 01             	add    $0x1,%eax
80103353:	39 c2                	cmp    %eax,%edx
80103355:	74 29                	je     80103380 <log_write+0x90>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103357:	39 0c 85 0c 37 11 80 	cmp    %ecx,-0x7feec8f4(,%eax,4)
8010335e:	75 f0                	jne    80103350 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
80103360:	89 0c 85 0c 37 11 80 	mov    %ecx,-0x7feec8f4(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
80103367:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
8010336a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
8010336d:	c7 45 08 c0 36 11 80 	movl   $0x801136c0,0x8(%ebp)
}
80103374:	c9                   	leave  
  release(&log.lock);
80103375:	e9 e6 1d 00 00       	jmp    80105160 <release>
8010337a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80103380:	89 0c 95 0c 37 11 80 	mov    %ecx,-0x7feec8f4(,%edx,4)
    log.lh.n++;
80103387:	83 c2 01             	add    $0x1,%edx
8010338a:	89 15 08 37 11 80    	mov    %edx,0x80113708
80103390:	eb d5                	jmp    80103367 <log_write+0x77>
  log.lh.block[i] = b->blockno;
80103392:	8b 43 08             	mov    0x8(%ebx),%eax
80103395:	a3 0c 37 11 80       	mov    %eax,0x8011370c
  if (i == log.lh.n)
8010339a:	75 cb                	jne    80103367 <log_write+0x77>
8010339c:	eb e9                	jmp    80103387 <log_write+0x97>
    panic("too big a transaction");
8010339e:	83 ec 0c             	sub    $0xc,%esp
801033a1:	68 f3 82 10 80       	push   $0x801082f3
801033a6:	e8 e5 cf ff ff       	call   80100390 <panic>
    panic("log_write outside of trans");
801033ab:	83 ec 0c             	sub    $0xc,%esp
801033ae:	68 09 83 10 80       	push   $0x80108309
801033b3:	e8 d8 cf ff ff       	call   80100390 <panic>
801033b8:	66 90                	xchg   %ax,%ax
801033ba:	66 90                	xchg   %ax,%ax
801033bc:	66 90                	xchg   %ax,%ax
801033be:	66 90                	xchg   %ax,%ax

801033c0 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
801033c0:	55                   	push   %ebp
801033c1:	89 e5                	mov    %esp,%ebp
801033c3:	53                   	push   %ebx
801033c4:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
801033c7:	e8 b4 09 00 00       	call   80103d80 <cpuid>
801033cc:	89 c3                	mov    %eax,%ebx
801033ce:	e8 ad 09 00 00       	call   80103d80 <cpuid>
801033d3:	83 ec 04             	sub    $0x4,%esp
801033d6:	53                   	push   %ebx
801033d7:	50                   	push   %eax
801033d8:	68 24 83 10 80       	push   $0x80108324
801033dd:	e8 ce d2 ff ff       	call   801006b0 <cprintf>
  idtinit();       // load idt register
801033e2:	e8 29 32 00 00       	call   80106610 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
801033e7:	e8 24 09 00 00       	call   80103d10 <mycpu>
801033ec:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
801033ee:	b8 01 00 00 00       	mov    $0x1,%eax
801033f3:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
801033fa:	e8 01 11 00 00       	call   80104500 <scheduler>
801033ff:	90                   	nop

80103400 <mpenter>:
{
80103400:	f3 0f 1e fb          	endbr32 
80103404:	55                   	push   %ebp
80103405:	89 e5                	mov    %esp,%ebp
80103407:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
8010340a:	e8 d1 42 00 00       	call   801076e0 <switchkvm>
  seginit();
8010340f:	e8 3c 42 00 00       	call   80107650 <seginit>
  lapicinit();
80103414:	e8 67 f7 ff ff       	call   80102b80 <lapicinit>
  mpmain();
80103419:	e8 a2 ff ff ff       	call   801033c0 <mpmain>
8010341e:	66 90                	xchg   %ax,%ax

80103420 <main>:
{
80103420:	f3 0f 1e fb          	endbr32 
80103424:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103428:	83 e4 f0             	and    $0xfffffff0,%esp
8010342b:	ff 71 fc             	pushl  -0x4(%ecx)
8010342e:	55                   	push   %ebp
8010342f:	89 e5                	mov    %esp,%ebp
80103431:	53                   	push   %ebx
80103432:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80103433:	83 ec 08             	sub    $0x8,%esp
80103436:	68 00 00 40 80       	push   $0x80400000
8010343b:	68 88 73 11 80       	push   $0x80117388
80103440:	e8 fb f4 ff ff       	call   80102940 <kinit1>
  kvmalloc();      // kernel page table
80103445:	e8 76 47 00 00       	call   80107bc0 <kvmalloc>
  mpinit();        // detect other processors
8010344a:	e8 81 01 00 00       	call   801035d0 <mpinit>
  lapicinit();     // interrupt controller
8010344f:	e8 2c f7 ff ff       	call   80102b80 <lapicinit>
  seginit();       // segment descriptors
80103454:	e8 f7 41 00 00       	call   80107650 <seginit>
  picinit();       // disable pic
80103459:	e8 52 03 00 00       	call   801037b0 <picinit>
  ioapicinit();    // another interrupt controller
8010345e:	e8 fd f2 ff ff       	call   80102760 <ioapicinit>
  consoleinit();   // console hardware
80103463:	e8 98 d9 ff ff       	call   80100e00 <consoleinit>
  uartinit();      // serial port
80103468:	e8 a3 34 00 00       	call   80106910 <uartinit>
  pinit();         // process table
8010346d:	e8 7e 08 00 00       	call   80103cf0 <pinit>
  tvinit();        // trap vectors
80103472:	e8 19 31 00 00       	call   80106590 <tvinit>
  binit();         // buffer cache
80103477:	e8 c4 cb ff ff       	call   80100040 <binit>
  fileinit();      // file table
8010347c:	e8 3f dd ff ff       	call   801011c0 <fileinit>
  ideinit();       // disk 
80103481:	e8 aa f0 ff ff       	call   80102530 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103486:	83 c4 0c             	add    $0xc,%esp
80103489:	68 8a 00 00 00       	push   $0x8a
8010348e:	68 8c b4 10 80       	push   $0x8010b48c
80103493:	68 00 70 00 80       	push   $0x80007000
80103498:	e8 b3 1d 00 00       	call   80105250 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
8010349d:	83 c4 10             	add    $0x10,%esp
801034a0:	69 05 40 3d 11 80 b0 	imul   $0xb0,0x80113d40,%eax
801034a7:	00 00 00 
801034aa:	05 c0 37 11 80       	add    $0x801137c0,%eax
801034af:	3d c0 37 11 80       	cmp    $0x801137c0,%eax
801034b4:	76 7a                	jbe    80103530 <main+0x110>
801034b6:	bb c0 37 11 80       	mov    $0x801137c0,%ebx
801034bb:	eb 1c                	jmp    801034d9 <main+0xb9>
801034bd:	8d 76 00             	lea    0x0(%esi),%esi
801034c0:	69 05 40 3d 11 80 b0 	imul   $0xb0,0x80113d40,%eax
801034c7:	00 00 00 
801034ca:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
801034d0:	05 c0 37 11 80       	add    $0x801137c0,%eax
801034d5:	39 c3                	cmp    %eax,%ebx
801034d7:	73 57                	jae    80103530 <main+0x110>
    if(c == mycpu())  // We've started already.
801034d9:	e8 32 08 00 00       	call   80103d10 <mycpu>
801034de:	39 c3                	cmp    %eax,%ebx
801034e0:	74 de                	je     801034c0 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
801034e2:	e8 29 f5 ff ff       	call   80102a10 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
801034e7:	83 ec 08             	sub    $0x8,%esp
    *(void(**)(void))(code-8) = mpenter;
801034ea:	c7 05 f8 6f 00 80 00 	movl   $0x80103400,0x80006ff8
801034f1:	34 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
801034f4:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
801034fb:	a0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
801034fe:	05 00 10 00 00       	add    $0x1000,%eax
80103503:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
80103508:	0f b6 03             	movzbl (%ebx),%eax
8010350b:	68 00 70 00 00       	push   $0x7000
80103510:	50                   	push   %eax
80103511:	e8 ba f7 ff ff       	call   80102cd0 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103516:	83 c4 10             	add    $0x10,%esp
80103519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103520:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103526:	85 c0                	test   %eax,%eax
80103528:	74 f6                	je     80103520 <main+0x100>
8010352a:	eb 94                	jmp    801034c0 <main+0xa0>
8010352c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103530:	83 ec 08             	sub    $0x8,%esp
80103533:	68 00 00 00 8e       	push   $0x8e000000
80103538:	68 00 00 40 80       	push   $0x80400000
8010353d:	e8 6e f4 ff ff       	call   801029b0 <kinit2>
  userinit();      // first user process
80103542:	e8 b9 08 00 00       	call   80103e00 <userinit>
  mpmain();        // finish this processor's setup
80103547:	e8 74 fe ff ff       	call   801033c0 <mpmain>
8010354c:	66 90                	xchg   %ax,%ax
8010354e:	66 90                	xchg   %ax,%ax

80103550 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103550:	55                   	push   %ebp
80103551:	89 e5                	mov    %esp,%ebp
80103553:	57                   	push   %edi
80103554:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103555:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
8010355b:	53                   	push   %ebx
  e = addr+len;
8010355c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
8010355f:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80103562:	39 de                	cmp    %ebx,%esi
80103564:	72 10                	jb     80103576 <mpsearch1+0x26>
80103566:	eb 50                	jmp    801035b8 <mpsearch1+0x68>
80103568:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010356f:	90                   	nop
80103570:	89 fe                	mov    %edi,%esi
80103572:	39 fb                	cmp    %edi,%ebx
80103574:	76 42                	jbe    801035b8 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103576:	83 ec 04             	sub    $0x4,%esp
80103579:	8d 7e 10             	lea    0x10(%esi),%edi
8010357c:	6a 04                	push   $0x4
8010357e:	68 38 83 10 80       	push   $0x80108338
80103583:	56                   	push   %esi
80103584:	e8 77 1c 00 00       	call   80105200 <memcmp>
80103589:	83 c4 10             	add    $0x10,%esp
8010358c:	85 c0                	test   %eax,%eax
8010358e:	75 e0                	jne    80103570 <mpsearch1+0x20>
80103590:	89 f2                	mov    %esi,%edx
80103592:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103598:	0f b6 0a             	movzbl (%edx),%ecx
8010359b:	83 c2 01             	add    $0x1,%edx
8010359e:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
801035a0:	39 fa                	cmp    %edi,%edx
801035a2:	75 f4                	jne    80103598 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801035a4:	84 c0                	test   %al,%al
801035a6:	75 c8                	jne    80103570 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
801035a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801035ab:	89 f0                	mov    %esi,%eax
801035ad:	5b                   	pop    %ebx
801035ae:	5e                   	pop    %esi
801035af:	5f                   	pop    %edi
801035b0:	5d                   	pop    %ebp
801035b1:	c3                   	ret    
801035b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801035b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801035bb:	31 f6                	xor    %esi,%esi
}
801035bd:	5b                   	pop    %ebx
801035be:	89 f0                	mov    %esi,%eax
801035c0:	5e                   	pop    %esi
801035c1:	5f                   	pop    %edi
801035c2:	5d                   	pop    %ebp
801035c3:	c3                   	ret    
801035c4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801035cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801035cf:	90                   	nop

801035d0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
801035d0:	f3 0f 1e fb          	endbr32 
801035d4:	55                   	push   %ebp
801035d5:	89 e5                	mov    %esp,%ebp
801035d7:	57                   	push   %edi
801035d8:	56                   	push   %esi
801035d9:	53                   	push   %ebx
801035da:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
801035dd:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
801035e4:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
801035eb:	c1 e0 08             	shl    $0x8,%eax
801035ee:	09 d0                	or     %edx,%eax
801035f0:	c1 e0 04             	shl    $0x4,%eax
801035f3:	75 1b                	jne    80103610 <mpinit+0x40>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
801035f5:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
801035fc:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103603:	c1 e0 08             	shl    $0x8,%eax
80103606:	09 d0                	or     %edx,%eax
80103608:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
8010360b:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
80103610:	ba 00 04 00 00       	mov    $0x400,%edx
80103615:	e8 36 ff ff ff       	call   80103550 <mpsearch1>
8010361a:	89 c6                	mov    %eax,%esi
8010361c:	85 c0                	test   %eax,%eax
8010361e:	0f 84 4c 01 00 00    	je     80103770 <mpinit+0x1a0>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103624:	8b 5e 04             	mov    0x4(%esi),%ebx
80103627:	85 db                	test   %ebx,%ebx
80103629:	0f 84 61 01 00 00    	je     80103790 <mpinit+0x1c0>
  if(memcmp(conf, "PCMP", 4) != 0)
8010362f:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103632:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
  if(memcmp(conf, "PCMP", 4) != 0)
80103638:	6a 04                	push   $0x4
8010363a:	68 3d 83 10 80       	push   $0x8010833d
8010363f:	50                   	push   %eax
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103640:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103643:	e8 b8 1b 00 00       	call   80105200 <memcmp>
80103648:	83 c4 10             	add    $0x10,%esp
8010364b:	85 c0                	test   %eax,%eax
8010364d:	0f 85 3d 01 00 00    	jne    80103790 <mpinit+0x1c0>
  if(conf->version != 1 && conf->version != 4)
80103653:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
8010365a:	3c 01                	cmp    $0x1,%al
8010365c:	74 08                	je     80103666 <mpinit+0x96>
8010365e:	3c 04                	cmp    $0x4,%al
80103660:	0f 85 2a 01 00 00    	jne    80103790 <mpinit+0x1c0>
  if(sum((uchar*)conf, conf->length) != 0)
80103666:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
  for(i=0; i<len; i++)
8010366d:	66 85 d2             	test   %dx,%dx
80103670:	74 26                	je     80103698 <mpinit+0xc8>
80103672:	8d 3c 1a             	lea    (%edx,%ebx,1),%edi
80103675:	89 d8                	mov    %ebx,%eax
  sum = 0;
80103677:	31 d2                	xor    %edx,%edx
80103679:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
80103680:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
80103687:	83 c0 01             	add    $0x1,%eax
8010368a:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
8010368c:	39 f8                	cmp    %edi,%eax
8010368e:	75 f0                	jne    80103680 <mpinit+0xb0>
  if(sum((uchar*)conf, conf->length) != 0)
80103690:	84 d2                	test   %dl,%dl
80103692:	0f 85 f8 00 00 00    	jne    80103790 <mpinit+0x1c0>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103698:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
8010369e:	a3 bc 36 11 80       	mov    %eax,0x801136bc
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801036a3:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
801036a9:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
  ismp = 1;
801036b0:	bb 01 00 00 00       	mov    $0x1,%ebx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801036b5:	03 55 e4             	add    -0x1c(%ebp),%edx
801036b8:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801036bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801036bf:	90                   	nop
801036c0:	39 c2                	cmp    %eax,%edx
801036c2:	76 15                	jbe    801036d9 <mpinit+0x109>
    switch(*p){
801036c4:	0f b6 08             	movzbl (%eax),%ecx
801036c7:	80 f9 02             	cmp    $0x2,%cl
801036ca:	74 5c                	je     80103728 <mpinit+0x158>
801036cc:	77 42                	ja     80103710 <mpinit+0x140>
801036ce:	84 c9                	test   %cl,%cl
801036d0:	74 6e                	je     80103740 <mpinit+0x170>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
801036d2:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801036d5:	39 c2                	cmp    %eax,%edx
801036d7:	77 eb                	ja     801036c4 <mpinit+0xf4>
801036d9:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
801036dc:	85 db                	test   %ebx,%ebx
801036de:	0f 84 b9 00 00 00    	je     8010379d <mpinit+0x1cd>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
801036e4:	80 7e 0c 00          	cmpb   $0x0,0xc(%esi)
801036e8:	74 15                	je     801036ff <mpinit+0x12f>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801036ea:	b8 70 00 00 00       	mov    $0x70,%eax
801036ef:	ba 22 00 00 00       	mov    $0x22,%edx
801036f4:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801036f5:	ba 23 00 00 00       	mov    $0x23,%edx
801036fa:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
801036fb:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801036fe:	ee                   	out    %al,(%dx)
  }
}
801036ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103702:	5b                   	pop    %ebx
80103703:	5e                   	pop    %esi
80103704:	5f                   	pop    %edi
80103705:	5d                   	pop    %ebp
80103706:	c3                   	ret    
80103707:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010370e:	66 90                	xchg   %ax,%ax
    switch(*p){
80103710:	83 e9 03             	sub    $0x3,%ecx
80103713:	80 f9 01             	cmp    $0x1,%cl
80103716:	76 ba                	jbe    801036d2 <mpinit+0x102>
80103718:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
8010371f:	eb 9f                	jmp    801036c0 <mpinit+0xf0>
80103721:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
80103728:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
8010372c:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
8010372f:	88 0d a0 37 11 80    	mov    %cl,0x801137a0
      continue;
80103735:	eb 89                	jmp    801036c0 <mpinit+0xf0>
80103737:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010373e:	66 90                	xchg   %ax,%ax
      if(ncpu < NCPU) {
80103740:	8b 0d 40 3d 11 80    	mov    0x80113d40,%ecx
80103746:	83 f9 07             	cmp    $0x7,%ecx
80103749:	7f 19                	jg     80103764 <mpinit+0x194>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010374b:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
80103751:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
        ncpu++;
80103755:	83 c1 01             	add    $0x1,%ecx
80103758:	89 0d 40 3d 11 80    	mov    %ecx,0x80113d40
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010375e:	88 9f c0 37 11 80    	mov    %bl,-0x7feec840(%edi)
      p += sizeof(struct mpproc);
80103764:	83 c0 14             	add    $0x14,%eax
      continue;
80103767:	e9 54 ff ff ff       	jmp    801036c0 <mpinit+0xf0>
8010376c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return mpsearch1(0xF0000, 0x10000);
80103770:	ba 00 00 01 00       	mov    $0x10000,%edx
80103775:	b8 00 00 0f 00       	mov    $0xf0000,%eax
8010377a:	e8 d1 fd ff ff       	call   80103550 <mpsearch1>
8010377f:	89 c6                	mov    %eax,%esi
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103781:	85 c0                	test   %eax,%eax
80103783:	0f 85 9b fe ff ff    	jne    80103624 <mpinit+0x54>
80103789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    panic("Expect to run on an SMP");
80103790:	83 ec 0c             	sub    $0xc,%esp
80103793:	68 42 83 10 80       	push   $0x80108342
80103798:	e8 f3 cb ff ff       	call   80100390 <panic>
    panic("Didn't find a suitable machine");
8010379d:	83 ec 0c             	sub    $0xc,%esp
801037a0:	68 5c 83 10 80       	push   $0x8010835c
801037a5:	e8 e6 cb ff ff       	call   80100390 <panic>
801037aa:	66 90                	xchg   %ax,%ax
801037ac:	66 90                	xchg   %ax,%ax
801037ae:	66 90                	xchg   %ax,%ax

801037b0 <picinit>:
801037b0:	f3 0f 1e fb          	endbr32 
801037b4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801037b9:	ba 21 00 00 00       	mov    $0x21,%edx
801037be:	ee                   	out    %al,(%dx)
801037bf:	ba a1 00 00 00       	mov    $0xa1,%edx
801037c4:	ee                   	out    %al,(%dx)
801037c5:	c3                   	ret    
801037c6:	66 90                	xchg   %ax,%ax
801037c8:	66 90                	xchg   %ax,%ax
801037ca:	66 90                	xchg   %ax,%ax
801037cc:	66 90                	xchg   %ax,%ax
801037ce:	66 90                	xchg   %ax,%ax

801037d0 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
801037d0:	f3 0f 1e fb          	endbr32 
801037d4:	55                   	push   %ebp
801037d5:	89 e5                	mov    %esp,%ebp
801037d7:	57                   	push   %edi
801037d8:	56                   	push   %esi
801037d9:	53                   	push   %ebx
801037da:	83 ec 0c             	sub    $0xc,%esp
801037dd:	8b 5d 08             	mov    0x8(%ebp),%ebx
801037e0:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
801037e3:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801037e9:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
801037ef:	e8 ec d9 ff ff       	call   801011e0 <filealloc>
801037f4:	89 03                	mov    %eax,(%ebx)
801037f6:	85 c0                	test   %eax,%eax
801037f8:	0f 84 ac 00 00 00    	je     801038aa <pipealloc+0xda>
801037fe:	e8 dd d9 ff ff       	call   801011e0 <filealloc>
80103803:	89 06                	mov    %eax,(%esi)
80103805:	85 c0                	test   %eax,%eax
80103807:	0f 84 8b 00 00 00    	je     80103898 <pipealloc+0xc8>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
8010380d:	e8 fe f1 ff ff       	call   80102a10 <kalloc>
80103812:	89 c7                	mov    %eax,%edi
80103814:	85 c0                	test   %eax,%eax
80103816:	0f 84 b4 00 00 00    	je     801038d0 <pipealloc+0x100>
    goto bad;
  p->readopen = 1;
8010381c:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103823:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80103826:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
80103829:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103830:	00 00 00 
  p->nwrite = 0;
80103833:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
8010383a:	00 00 00 
  p->nread = 0;
8010383d:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103844:	00 00 00 
  initlock(&p->lock, "pipe");
80103847:	68 7b 83 10 80       	push   $0x8010837b
8010384c:	50                   	push   %eax
8010384d:	e8 ce 16 00 00       	call   80104f20 <initlock>
  (*f0)->type = FD_PIPE;
80103852:	8b 03                	mov    (%ebx),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103854:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80103857:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
8010385d:	8b 03                	mov    (%ebx),%eax
8010385f:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103863:	8b 03                	mov    (%ebx),%eax
80103865:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103869:	8b 03                	mov    (%ebx),%eax
8010386b:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
8010386e:	8b 06                	mov    (%esi),%eax
80103870:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103876:	8b 06                	mov    (%esi),%eax
80103878:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
8010387c:	8b 06                	mov    (%esi),%eax
8010387e:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103882:	8b 06                	mov    (%esi),%eax
80103884:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103887:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010388a:	31 c0                	xor    %eax,%eax
}
8010388c:	5b                   	pop    %ebx
8010388d:	5e                   	pop    %esi
8010388e:	5f                   	pop    %edi
8010388f:	5d                   	pop    %ebp
80103890:	c3                   	ret    
80103891:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(*f0)
80103898:	8b 03                	mov    (%ebx),%eax
8010389a:	85 c0                	test   %eax,%eax
8010389c:	74 1e                	je     801038bc <pipealloc+0xec>
    fileclose(*f0);
8010389e:	83 ec 0c             	sub    $0xc,%esp
801038a1:	50                   	push   %eax
801038a2:	e8 f9 d9 ff ff       	call   801012a0 <fileclose>
801038a7:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801038aa:	8b 06                	mov    (%esi),%eax
801038ac:	85 c0                	test   %eax,%eax
801038ae:	74 0c                	je     801038bc <pipealloc+0xec>
    fileclose(*f1);
801038b0:	83 ec 0c             	sub    $0xc,%esp
801038b3:	50                   	push   %eax
801038b4:	e8 e7 d9 ff ff       	call   801012a0 <fileclose>
801038b9:	83 c4 10             	add    $0x10,%esp
}
801038bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
801038bf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801038c4:	5b                   	pop    %ebx
801038c5:	5e                   	pop    %esi
801038c6:	5f                   	pop    %edi
801038c7:	5d                   	pop    %ebp
801038c8:	c3                   	ret    
801038c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(*f0)
801038d0:	8b 03                	mov    (%ebx),%eax
801038d2:	85 c0                	test   %eax,%eax
801038d4:	75 c8                	jne    8010389e <pipealloc+0xce>
801038d6:	eb d2                	jmp    801038aa <pipealloc+0xda>
801038d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801038df:	90                   	nop

801038e0 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
801038e0:	f3 0f 1e fb          	endbr32 
801038e4:	55                   	push   %ebp
801038e5:	89 e5                	mov    %esp,%ebp
801038e7:	56                   	push   %esi
801038e8:	53                   	push   %ebx
801038e9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801038ec:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
801038ef:	83 ec 0c             	sub    $0xc,%esp
801038f2:	53                   	push   %ebx
801038f3:	e8 a8 17 00 00       	call   801050a0 <acquire>
  if(writable){
801038f8:	83 c4 10             	add    $0x10,%esp
801038fb:	85 f6                	test   %esi,%esi
801038fd:	74 41                	je     80103940 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
801038ff:	83 ec 0c             	sub    $0xc,%esp
80103902:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
80103908:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010390f:	00 00 00 
    wakeup(&p->nread);
80103912:	50                   	push   %eax
80103913:	e8 c8 10 00 00       	call   801049e0 <wakeup>
80103918:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
8010391b:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
80103921:	85 d2                	test   %edx,%edx
80103923:	75 0a                	jne    8010392f <pipeclose+0x4f>
80103925:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
8010392b:	85 c0                	test   %eax,%eax
8010392d:	74 31                	je     80103960 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010392f:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80103932:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103935:	5b                   	pop    %ebx
80103936:	5e                   	pop    %esi
80103937:	5d                   	pop    %ebp
    release(&p->lock);
80103938:	e9 23 18 00 00       	jmp    80105160 <release>
8010393d:	8d 76 00             	lea    0x0(%esi),%esi
    wakeup(&p->nwrite);
80103940:	83 ec 0c             	sub    $0xc,%esp
80103943:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
80103949:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103950:	00 00 00 
    wakeup(&p->nwrite);
80103953:	50                   	push   %eax
80103954:	e8 87 10 00 00       	call   801049e0 <wakeup>
80103959:	83 c4 10             	add    $0x10,%esp
8010395c:	eb bd                	jmp    8010391b <pipeclose+0x3b>
8010395e:	66 90                	xchg   %ax,%ax
    release(&p->lock);
80103960:	83 ec 0c             	sub    $0xc,%esp
80103963:	53                   	push   %ebx
80103964:	e8 f7 17 00 00       	call   80105160 <release>
    kfree((char*)p);
80103969:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010396c:	83 c4 10             	add    $0x10,%esp
}
8010396f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103972:	5b                   	pop    %ebx
80103973:	5e                   	pop    %esi
80103974:	5d                   	pop    %ebp
    kfree((char*)p);
80103975:	e9 d6 ee ff ff       	jmp    80102850 <kfree>
8010397a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103980 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103980:	f3 0f 1e fb          	endbr32 
80103984:	55                   	push   %ebp
80103985:	89 e5                	mov    %esp,%ebp
80103987:	57                   	push   %edi
80103988:	56                   	push   %esi
80103989:	53                   	push   %ebx
8010398a:	83 ec 28             	sub    $0x28,%esp
8010398d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
80103990:	53                   	push   %ebx
80103991:	e8 0a 17 00 00       	call   801050a0 <acquire>
  for(i = 0; i < n; i++){
80103996:	8b 45 10             	mov    0x10(%ebp),%eax
80103999:	83 c4 10             	add    $0x10,%esp
8010399c:	85 c0                	test   %eax,%eax
8010399e:	0f 8e bc 00 00 00    	jle    80103a60 <pipewrite+0xe0>
801039a4:	8b 45 0c             	mov    0xc(%ebp),%eax
801039a7:	8b 8b 38 02 00 00    	mov    0x238(%ebx),%ecx
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801039ad:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
801039b3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801039b6:	03 45 10             	add    0x10(%ebp),%eax
801039b9:	89 45 e0             	mov    %eax,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801039bc:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801039c2:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801039c8:	89 ca                	mov    %ecx,%edx
801039ca:	05 00 02 00 00       	add    $0x200,%eax
801039cf:	39 c1                	cmp    %eax,%ecx
801039d1:	74 3b                	je     80103a0e <pipewrite+0x8e>
801039d3:	eb 63                	jmp    80103a38 <pipewrite+0xb8>
801039d5:	8d 76 00             	lea    0x0(%esi),%esi
      if(p->readopen == 0 || myproc()->killed){
801039d8:	e8 c3 03 00 00       	call   80103da0 <myproc>
801039dd:	8b 48 24             	mov    0x24(%eax),%ecx
801039e0:	85 c9                	test   %ecx,%ecx
801039e2:	75 34                	jne    80103a18 <pipewrite+0x98>
      wakeup(&p->nread);
801039e4:	83 ec 0c             	sub    $0xc,%esp
801039e7:	57                   	push   %edi
801039e8:	e8 f3 0f 00 00       	call   801049e0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801039ed:	58                   	pop    %eax
801039ee:	5a                   	pop    %edx
801039ef:	53                   	push   %ebx
801039f0:	56                   	push   %esi
801039f1:	e8 2a 0e 00 00       	call   80104820 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801039f6:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801039fc:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
80103a02:	83 c4 10             	add    $0x10,%esp
80103a05:	05 00 02 00 00       	add    $0x200,%eax
80103a0a:	39 c2                	cmp    %eax,%edx
80103a0c:	75 2a                	jne    80103a38 <pipewrite+0xb8>
      if(p->readopen == 0 || myproc()->killed){
80103a0e:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103a14:	85 c0                	test   %eax,%eax
80103a16:	75 c0                	jne    801039d8 <pipewrite+0x58>
        release(&p->lock);
80103a18:	83 ec 0c             	sub    $0xc,%esp
80103a1b:	53                   	push   %ebx
80103a1c:	e8 3f 17 00 00       	call   80105160 <release>
        return -1;
80103a21:	83 c4 10             	add    $0x10,%esp
80103a24:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103a29:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103a2c:	5b                   	pop    %ebx
80103a2d:	5e                   	pop    %esi
80103a2e:	5f                   	pop    %edi
80103a2f:	5d                   	pop    %ebp
80103a30:	c3                   	ret    
80103a31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103a38:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80103a3b:	8d 4a 01             	lea    0x1(%edx),%ecx
80103a3e:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80103a44:	89 8b 38 02 00 00    	mov    %ecx,0x238(%ebx)
80103a4a:	0f b6 06             	movzbl (%esi),%eax
80103a4d:	83 c6 01             	add    $0x1,%esi
80103a50:	89 75 e4             	mov    %esi,-0x1c(%ebp)
80103a53:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
80103a57:	3b 75 e0             	cmp    -0x20(%ebp),%esi
80103a5a:	0f 85 5c ff ff ff    	jne    801039bc <pipewrite+0x3c>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103a60:	83 ec 0c             	sub    $0xc,%esp
80103a63:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103a69:	50                   	push   %eax
80103a6a:	e8 71 0f 00 00       	call   801049e0 <wakeup>
  release(&p->lock);
80103a6f:	89 1c 24             	mov    %ebx,(%esp)
80103a72:	e8 e9 16 00 00       	call   80105160 <release>
  return n;
80103a77:	8b 45 10             	mov    0x10(%ebp),%eax
80103a7a:	83 c4 10             	add    $0x10,%esp
80103a7d:	eb aa                	jmp    80103a29 <pipewrite+0xa9>
80103a7f:	90                   	nop

80103a80 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103a80:	f3 0f 1e fb          	endbr32 
80103a84:	55                   	push   %ebp
80103a85:	89 e5                	mov    %esp,%ebp
80103a87:	57                   	push   %edi
80103a88:	56                   	push   %esi
80103a89:	53                   	push   %ebx
80103a8a:	83 ec 18             	sub    $0x18,%esp
80103a8d:	8b 75 08             	mov    0x8(%ebp),%esi
80103a90:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
80103a93:	56                   	push   %esi
80103a94:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
80103a9a:	e8 01 16 00 00       	call   801050a0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103a9f:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103aa5:	83 c4 10             	add    $0x10,%esp
80103aa8:	39 86 38 02 00 00    	cmp    %eax,0x238(%esi)
80103aae:	74 33                	je     80103ae3 <piperead+0x63>
80103ab0:	eb 3b                	jmp    80103aed <piperead+0x6d>
80103ab2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(myproc()->killed){
80103ab8:	e8 e3 02 00 00       	call   80103da0 <myproc>
80103abd:	8b 48 24             	mov    0x24(%eax),%ecx
80103ac0:	85 c9                	test   %ecx,%ecx
80103ac2:	0f 85 88 00 00 00    	jne    80103b50 <piperead+0xd0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103ac8:	83 ec 08             	sub    $0x8,%esp
80103acb:	56                   	push   %esi
80103acc:	53                   	push   %ebx
80103acd:	e8 4e 0d 00 00       	call   80104820 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103ad2:	8b 86 38 02 00 00    	mov    0x238(%esi),%eax
80103ad8:	83 c4 10             	add    $0x10,%esp
80103adb:	39 86 34 02 00 00    	cmp    %eax,0x234(%esi)
80103ae1:	75 0a                	jne    80103aed <piperead+0x6d>
80103ae3:	8b 86 40 02 00 00    	mov    0x240(%esi),%eax
80103ae9:	85 c0                	test   %eax,%eax
80103aeb:	75 cb                	jne    80103ab8 <piperead+0x38>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103aed:	8b 55 10             	mov    0x10(%ebp),%edx
80103af0:	31 db                	xor    %ebx,%ebx
80103af2:	85 d2                	test   %edx,%edx
80103af4:	7f 28                	jg     80103b1e <piperead+0x9e>
80103af6:	eb 34                	jmp    80103b2c <piperead+0xac>
80103af8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103aff:	90                   	nop
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103b00:	8d 48 01             	lea    0x1(%eax),%ecx
80103b03:	25 ff 01 00 00       	and    $0x1ff,%eax
80103b08:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
80103b0e:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80103b13:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103b16:	83 c3 01             	add    $0x1,%ebx
80103b19:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80103b1c:	74 0e                	je     80103b2c <piperead+0xac>
    if(p->nread == p->nwrite)
80103b1e:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103b24:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80103b2a:	75 d4                	jne    80103b00 <piperead+0x80>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80103b2c:	83 ec 0c             	sub    $0xc,%esp
80103b2f:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103b35:	50                   	push   %eax
80103b36:	e8 a5 0e 00 00       	call   801049e0 <wakeup>
  release(&p->lock);
80103b3b:	89 34 24             	mov    %esi,(%esp)
80103b3e:	e8 1d 16 00 00       	call   80105160 <release>
  return i;
80103b43:	83 c4 10             	add    $0x10,%esp
}
80103b46:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103b49:	89 d8                	mov    %ebx,%eax
80103b4b:	5b                   	pop    %ebx
80103b4c:	5e                   	pop    %esi
80103b4d:	5f                   	pop    %edi
80103b4e:	5d                   	pop    %ebp
80103b4f:	c3                   	ret    
      release(&p->lock);
80103b50:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103b53:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
80103b58:	56                   	push   %esi
80103b59:	e8 02 16 00 00       	call   80105160 <release>
      return -1;
80103b5e:	83 c4 10             	add    $0x10,%esp
}
80103b61:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103b64:	89 d8                	mov    %ebx,%eax
80103b66:	5b                   	pop    %ebx
80103b67:	5e                   	pop    %esi
80103b68:	5f                   	pop    %edi
80103b69:	5d                   	pop    %ebp
80103b6a:	c3                   	ret    
80103b6b:	66 90                	xchg   %ax,%ax
80103b6d:	66 90                	xchg   %ax,%ax
80103b6f:	90                   	nop

80103b70 <allocproc>:
int last_arrival = 0;
int delay = 0;

static struct proc*
allocproc(void)
{
80103b70:	55                   	push   %ebp
80103b71:	89 e5                	mov    %esp,%ebp
80103b73:	56                   	push   %esi
80103b74:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103b75:	bb 34 47 11 80       	mov    $0x80114734,%ebx
  acquire(&ptable.lock);
80103b7a:	83 ec 0c             	sub    $0xc,%esp
80103b7d:	68 00 47 11 80       	push   $0x80114700
80103b82:	e8 19 15 00 00       	call   801050a0 <acquire>
80103b87:	83 c4 10             	add    $0x10,%esp
80103b8a:	eb 16                	jmp    80103ba2 <allocproc+0x32>
80103b8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103b90:	81 c3 90 00 00 00    	add    $0x90,%ebx
80103b96:	81 fb 34 6b 11 80    	cmp    $0x80116b34,%ebx
80103b9c:	0f 84 c6 00 00 00    	je     80103c68 <allocproc+0xf8>
    if(p->state == UNUSED)
80103ba2:	8b 43 0c             	mov    0xc(%ebx),%eax
80103ba5:	85 c0                	test   %eax,%eax
80103ba7:	75 e7                	jne    80103b90 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103ba9:	a1 04 b0 10 80       	mov    0x8010b004,%eax
  acquire(&tickslock);
80103bae:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
80103bb1:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->qnum = 2;
80103bb8:	c7 43 7c 02 00 00 00 	movl   $0x2,0x7c(%ebx)
  p->pid = nextpid++;
80103bbf:	89 43 10             	mov    %eax,0x10(%ebx)
80103bc2:	8d 50 01             	lea    0x1(%eax),%edx
  acquire(&tickslock);
80103bc5:	68 40 6b 11 80       	push   $0x80116b40
  p->pid = nextpid++;
80103bca:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
  acquire(&tickslock);
80103bd0:	e8 cb 14 00 00       	call   801050a0 <acquire>
  ticks0 = ticks;
80103bd5:	8b 35 80 73 11 80    	mov    0x80117380,%esi
  release(&tickslock);
80103bdb:	c7 04 24 40 6b 11 80 	movl   $0x80116b40,(%esp)
80103be2:	e8 79 15 00 00       	call   80105160 <release>
  p->arrival_time = getTime();
  p->cycles = 1;
80103be7:	c7 83 84 00 00 00 01 	movl   $0x1,0x84(%ebx)
80103bee:	00 00 00 
  p->arrival_time = getTime();
80103bf1:	89 b3 80 00 00 00    	mov    %esi,0x80(%ebx)
  p->HRRN_priority = 0;
80103bf7:	c7 83 88 00 00 00 00 	movl   $0x0,0x88(%ebx)
80103bfe:	00 00 00 
  p->wait_cycles = 0;
80103c01:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80103c08:	00 00 00 

  release(&ptable.lock);
80103c0b:	c7 04 24 00 47 11 80 	movl   $0x80114700,(%esp)
80103c12:	e8 49 15 00 00       	call   80105160 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103c17:	e8 f4 ed ff ff       	call   80102a10 <kalloc>
80103c1c:	83 c4 10             	add    $0x10,%esp
80103c1f:	89 43 08             	mov    %eax,0x8(%ebx)
80103c22:	85 c0                	test   %eax,%eax
80103c24:	74 5d                	je     80103c83 <allocproc+0x113>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103c26:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103c2c:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
80103c2f:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103c34:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103c37:	c7 40 14 7f 65 10 80 	movl   $0x8010657f,0x14(%eax)
  p->context = (struct context*)sp;
80103c3e:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103c41:	6a 14                	push   $0x14
80103c43:	6a 00                	push   $0x0
80103c45:	50                   	push   %eax
80103c46:	e8 65 15 00 00       	call   801051b0 <memset>
  p->context->eip = (uint)forkret;
80103c4b:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
80103c4e:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103c51:	c7 40 10 a0 3c 10 80 	movl   $0x80103ca0,0x10(%eax)
}
80103c58:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103c5b:	89 d8                	mov    %ebx,%eax
80103c5d:	5b                   	pop    %ebx
80103c5e:	5e                   	pop    %esi
80103c5f:	5d                   	pop    %ebp
80103c60:	c3                   	ret    
80103c61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80103c68:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103c6b:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103c6d:	68 00 47 11 80       	push   $0x80114700
80103c72:	e8 e9 14 00 00       	call   80105160 <release>
  return 0;
80103c77:	83 c4 10             	add    $0x10,%esp
}
80103c7a:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103c7d:	89 d8                	mov    %ebx,%eax
80103c7f:	5b                   	pop    %ebx
80103c80:	5e                   	pop    %esi
80103c81:	5d                   	pop    %ebp
80103c82:	c3                   	ret    
    p->state = UNUSED;
80103c83:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
}
80103c8a:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return 0;
80103c8d:	31 db                	xor    %ebx,%ebx
}
80103c8f:	89 d8                	mov    %ebx,%eax
80103c91:	5b                   	pop    %ebx
80103c92:	5e                   	pop    %esi
80103c93:	5d                   	pop    %ebp
80103c94:	c3                   	ret    
80103c95:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103ca0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103ca0:	f3 0f 1e fb          	endbr32 
80103ca4:	55                   	push   %ebp
80103ca5:	89 e5                	mov    %esp,%ebp
80103ca7:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103caa:	68 00 47 11 80       	push   $0x80114700
80103caf:	e8 ac 14 00 00       	call   80105160 <release>

  if (first) {
80103cb4:	a1 00 b0 10 80       	mov    0x8010b000,%eax
80103cb9:	83 c4 10             	add    $0x10,%esp
80103cbc:	85 c0                	test   %eax,%eax
80103cbe:	75 08                	jne    80103cc8 <forkret+0x28>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
80103cc0:	c9                   	leave  
80103cc1:	c3                   	ret    
80103cc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    first = 0;
80103cc8:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
80103ccf:	00 00 00 
    iinit(ROOTDEV);
80103cd2:	83 ec 0c             	sub    $0xc,%esp
80103cd5:	6a 01                	push   $0x1
80103cd7:	e8 44 dc ff ff       	call   80101920 <iinit>
    initlog(ROOTDEV);
80103cdc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80103ce3:	e8 88 f3 ff ff       	call   80103070 <initlog>
}
80103ce8:	83 c4 10             	add    $0x10,%esp
80103ceb:	c9                   	leave  
80103cec:	c3                   	ret    
80103ced:	8d 76 00             	lea    0x0(%esi),%esi

80103cf0 <pinit>:
{
80103cf0:	f3 0f 1e fb          	endbr32 
80103cf4:	55                   	push   %ebp
80103cf5:	89 e5                	mov    %esp,%ebp
80103cf7:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103cfa:	68 80 83 10 80       	push   $0x80108380
80103cff:	68 00 47 11 80       	push   $0x80114700
80103d04:	e8 17 12 00 00       	call   80104f20 <initlock>
}
80103d09:	83 c4 10             	add    $0x10,%esp
80103d0c:	c9                   	leave  
80103d0d:	c3                   	ret    
80103d0e:	66 90                	xchg   %ax,%ax

80103d10 <mycpu>:
{
80103d10:	f3 0f 1e fb          	endbr32 
80103d14:	55                   	push   %ebp
80103d15:	89 e5                	mov    %esp,%ebp
80103d17:	56                   	push   %esi
80103d18:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103d19:	9c                   	pushf  
80103d1a:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103d1b:	f6 c4 02             	test   $0x2,%ah
80103d1e:	75 4a                	jne    80103d6a <mycpu+0x5a>
  apicid = lapicid();
80103d20:	e8 5b ef ff ff       	call   80102c80 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103d25:	8b 35 40 3d 11 80    	mov    0x80113d40,%esi
  apicid = lapicid();
80103d2b:	89 c3                	mov    %eax,%ebx
  for (i = 0; i < ncpu; ++i) {
80103d2d:	85 f6                	test   %esi,%esi
80103d2f:	7e 2c                	jle    80103d5d <mycpu+0x4d>
80103d31:	31 d2                	xor    %edx,%edx
80103d33:	eb 0a                	jmp    80103d3f <mycpu+0x2f>
80103d35:	8d 76 00             	lea    0x0(%esi),%esi
80103d38:	83 c2 01             	add    $0x1,%edx
80103d3b:	39 f2                	cmp    %esi,%edx
80103d3d:	74 1e                	je     80103d5d <mycpu+0x4d>
    if (cpus[i].apicid == apicid)
80103d3f:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
80103d45:	0f b6 81 c0 37 11 80 	movzbl -0x7feec840(%ecx),%eax
80103d4c:	39 d8                	cmp    %ebx,%eax
80103d4e:	75 e8                	jne    80103d38 <mycpu+0x28>
}
80103d50:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return &cpus[i];
80103d53:	8d 81 c0 37 11 80    	lea    -0x7feec840(%ecx),%eax
}
80103d59:	5b                   	pop    %ebx
80103d5a:	5e                   	pop    %esi
80103d5b:	5d                   	pop    %ebp
80103d5c:	c3                   	ret    
  panic("unknown apicid\n");
80103d5d:	83 ec 0c             	sub    $0xc,%esp
80103d60:	68 87 83 10 80       	push   $0x80108387
80103d65:	e8 26 c6 ff ff       	call   80100390 <panic>
    panic("mycpu called with interrupts enabled\n");
80103d6a:	83 ec 0c             	sub    $0xc,%esp
80103d6d:	68 a4 84 10 80       	push   $0x801084a4
80103d72:	e8 19 c6 ff ff       	call   80100390 <panic>
80103d77:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103d7e:	66 90                	xchg   %ax,%ax

80103d80 <cpuid>:
cpuid() {
80103d80:	f3 0f 1e fb          	endbr32 
80103d84:	55                   	push   %ebp
80103d85:	89 e5                	mov    %esp,%ebp
80103d87:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103d8a:	e8 81 ff ff ff       	call   80103d10 <mycpu>
}
80103d8f:	c9                   	leave  
  return mycpu()-cpus;
80103d90:	2d c0 37 11 80       	sub    $0x801137c0,%eax
80103d95:	c1 f8 04             	sar    $0x4,%eax
80103d98:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
80103d9e:	c3                   	ret    
80103d9f:	90                   	nop

80103da0 <myproc>:
myproc(void) {
80103da0:	f3 0f 1e fb          	endbr32 
80103da4:	55                   	push   %ebp
80103da5:	89 e5                	mov    %esp,%ebp
80103da7:	53                   	push   %ebx
80103da8:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103dab:	e8 f0 11 00 00       	call   80104fa0 <pushcli>
  c = mycpu();
80103db0:	e8 5b ff ff ff       	call   80103d10 <mycpu>
  p = c->proc;
80103db5:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103dbb:	e8 30 12 00 00       	call   80104ff0 <popcli>
}
80103dc0:	83 c4 04             	add    $0x4,%esp
80103dc3:	89 d8                	mov    %ebx,%eax
80103dc5:	5b                   	pop    %ebx
80103dc6:	5d                   	pop    %ebp
80103dc7:	c3                   	ret    
80103dc8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103dcf:	90                   	nop

80103dd0 <getTime>:
int getTime(void) {
80103dd0:	f3 0f 1e fb          	endbr32 
80103dd4:	55                   	push   %ebp
80103dd5:	89 e5                	mov    %esp,%ebp
80103dd7:	53                   	push   %ebx
80103dd8:	83 ec 10             	sub    $0x10,%esp
  acquire(&tickslock);
80103ddb:	68 40 6b 11 80       	push   $0x80116b40
80103de0:	e8 bb 12 00 00       	call   801050a0 <acquire>
  ticks0 = ticks;
80103de5:	8b 1d 80 73 11 80    	mov    0x80117380,%ebx
  release(&tickslock);
80103deb:	c7 04 24 40 6b 11 80 	movl   $0x80116b40,(%esp)
80103df2:	e8 69 13 00 00       	call   80105160 <release>
}
80103df7:	89 d8                	mov    %ebx,%eax
80103df9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103dfc:	c9                   	leave  
80103dfd:	c3                   	ret    
80103dfe:	66 90                	xchg   %ax,%ax

80103e00 <userinit>:
{
80103e00:	f3 0f 1e fb          	endbr32 
80103e04:	55                   	push   %ebp
80103e05:	89 e5                	mov    %esp,%ebp
80103e07:	53                   	push   %ebx
80103e08:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103e0b:	e8 60 fd ff ff       	call   80103b70 <allocproc>
80103e10:	89 c3                	mov    %eax,%ebx
  initproc = p;
80103e12:	a3 e0 b5 10 80       	mov    %eax,0x8010b5e0
  if((p->pgdir = setupkvm()) == 0)
80103e17:	e8 24 3d 00 00       	call   80107b40 <setupkvm>
80103e1c:	89 43 04             	mov    %eax,0x4(%ebx)
80103e1f:	85 c0                	test   %eax,%eax
80103e21:	0f 84 bd 00 00 00    	je     80103ee4 <userinit+0xe4>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103e27:	83 ec 04             	sub    $0x4,%esp
80103e2a:	68 2c 00 00 00       	push   $0x2c
80103e2f:	68 60 b4 10 80       	push   $0x8010b460
80103e34:	50                   	push   %eax
80103e35:	e8 d6 39 00 00       	call   80107810 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103e3a:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103e3d:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103e43:	6a 4c                	push   $0x4c
80103e45:	6a 00                	push   $0x0
80103e47:	ff 73 18             	pushl  0x18(%ebx)
80103e4a:	e8 61 13 00 00       	call   801051b0 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103e4f:	8b 43 18             	mov    0x18(%ebx),%eax
80103e52:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103e57:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103e5a:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103e5f:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103e63:	8b 43 18             	mov    0x18(%ebx),%eax
80103e66:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103e6a:	8b 43 18             	mov    0x18(%ebx),%eax
80103e6d:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103e71:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103e75:	8b 43 18             	mov    0x18(%ebx),%eax
80103e78:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103e7c:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103e80:	8b 43 18             	mov    0x18(%ebx),%eax
80103e83:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103e8a:	8b 43 18             	mov    0x18(%ebx),%eax
80103e8d:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103e94:	8b 43 18             	mov    0x18(%ebx),%eax
80103e97:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103e9e:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103ea1:	6a 10                	push   $0x10
80103ea3:	68 b0 83 10 80       	push   $0x801083b0
80103ea8:	50                   	push   %eax
80103ea9:	e8 c2 14 00 00       	call   80105370 <safestrcpy>
  p->cwd = namei("/");
80103eae:	c7 04 24 b9 83 10 80 	movl   $0x801083b9,(%esp)
80103eb5:	e8 56 e5 ff ff       	call   80102410 <namei>
80103eba:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103ebd:	c7 04 24 00 47 11 80 	movl   $0x80114700,(%esp)
80103ec4:	e8 d7 11 00 00       	call   801050a0 <acquire>
  p->state = RUNNABLE;
80103ec9:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103ed0:	c7 04 24 00 47 11 80 	movl   $0x80114700,(%esp)
80103ed7:	e8 84 12 00 00       	call   80105160 <release>
}
80103edc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103edf:	83 c4 10             	add    $0x10,%esp
80103ee2:	c9                   	leave  
80103ee3:	c3                   	ret    
    panic("userinit: out of memory?");
80103ee4:	83 ec 0c             	sub    $0xc,%esp
80103ee7:	68 97 83 10 80       	push   $0x80108397
80103eec:	e8 9f c4 ff ff       	call   80100390 <panic>
80103ef1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103ef8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103eff:	90                   	nop

80103f00 <growproc>:
{
80103f00:	f3 0f 1e fb          	endbr32 
80103f04:	55                   	push   %ebp
80103f05:	89 e5                	mov    %esp,%ebp
80103f07:	56                   	push   %esi
80103f08:	53                   	push   %ebx
80103f09:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103f0c:	e8 8f 10 00 00       	call   80104fa0 <pushcli>
  c = mycpu();
80103f11:	e8 fa fd ff ff       	call   80103d10 <mycpu>
  p = c->proc;
80103f16:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103f1c:	e8 cf 10 00 00       	call   80104ff0 <popcli>
  sz = curproc->sz;
80103f21:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103f23:	85 f6                	test   %esi,%esi
80103f25:	7f 19                	jg     80103f40 <growproc+0x40>
  } else if(n < 0){
80103f27:	75 37                	jne    80103f60 <growproc+0x60>
  switchuvm(curproc);
80103f29:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103f2c:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103f2e:	53                   	push   %ebx
80103f2f:	e8 cc 37 00 00       	call   80107700 <switchuvm>
  return 0;
80103f34:	83 c4 10             	add    $0x10,%esp
80103f37:	31 c0                	xor    %eax,%eax
}
80103f39:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103f3c:	5b                   	pop    %ebx
80103f3d:	5e                   	pop    %esi
80103f3e:	5d                   	pop    %ebp
80103f3f:	c3                   	ret    
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103f40:	83 ec 04             	sub    $0x4,%esp
80103f43:	01 c6                	add    %eax,%esi
80103f45:	56                   	push   %esi
80103f46:	50                   	push   %eax
80103f47:	ff 73 04             	pushl  0x4(%ebx)
80103f4a:	e8 11 3a 00 00       	call   80107960 <allocuvm>
80103f4f:	83 c4 10             	add    $0x10,%esp
80103f52:	85 c0                	test   %eax,%eax
80103f54:	75 d3                	jne    80103f29 <growproc+0x29>
      return -1;
80103f56:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103f5b:	eb dc                	jmp    80103f39 <growproc+0x39>
80103f5d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103f60:	83 ec 04             	sub    $0x4,%esp
80103f63:	01 c6                	add    %eax,%esi
80103f65:	56                   	push   %esi
80103f66:	50                   	push   %eax
80103f67:	ff 73 04             	pushl  0x4(%ebx)
80103f6a:	e8 21 3b 00 00       	call   80107a90 <deallocuvm>
80103f6f:	83 c4 10             	add    $0x10,%esp
80103f72:	85 c0                	test   %eax,%eax
80103f74:	75 b3                	jne    80103f29 <growproc+0x29>
80103f76:	eb de                	jmp    80103f56 <growproc+0x56>
80103f78:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103f7f:	90                   	nop

80103f80 <fork>:
{
80103f80:	f3 0f 1e fb          	endbr32 
80103f84:	55                   	push   %ebp
80103f85:	89 e5                	mov    %esp,%ebp
80103f87:	57                   	push   %edi
80103f88:	56                   	push   %esi
80103f89:	53                   	push   %ebx
80103f8a:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103f8d:	e8 0e 10 00 00       	call   80104fa0 <pushcli>
  c = mycpu();
80103f92:	e8 79 fd ff ff       	call   80103d10 <mycpu>
  p = c->proc;
80103f97:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103f9d:	e8 4e 10 00 00       	call   80104ff0 <popcli>
  if((np = allocproc()) == 0){
80103fa2:	e8 c9 fb ff ff       	call   80103b70 <allocproc>
80103fa7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103faa:	85 c0                	test   %eax,%eax
80103fac:	0f 84 bb 00 00 00    	je     8010406d <fork+0xed>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103fb2:	83 ec 08             	sub    $0x8,%esp
80103fb5:	ff 33                	pushl  (%ebx)
80103fb7:	89 c7                	mov    %eax,%edi
80103fb9:	ff 73 04             	pushl  0x4(%ebx)
80103fbc:	e8 4f 3c 00 00       	call   80107c10 <copyuvm>
80103fc1:	83 c4 10             	add    $0x10,%esp
80103fc4:	89 47 04             	mov    %eax,0x4(%edi)
80103fc7:	85 c0                	test   %eax,%eax
80103fc9:	0f 84 a5 00 00 00    	je     80104074 <fork+0xf4>
  np->sz = curproc->sz;
80103fcf:	8b 03                	mov    (%ebx),%eax
80103fd1:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103fd4:	89 01                	mov    %eax,(%ecx)
  *np->tf = *curproc->tf;
80103fd6:	8b 79 18             	mov    0x18(%ecx),%edi
  np->parent = curproc;
80103fd9:	89 c8                	mov    %ecx,%eax
80103fdb:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
80103fde:	b9 13 00 00 00       	mov    $0x13,%ecx
80103fe3:	8b 73 18             	mov    0x18(%ebx),%esi
80103fe6:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103fe8:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103fea:	8b 40 18             	mov    0x18(%eax),%eax
80103fed:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  for(i = 0; i < NOFILE; i++)
80103ff4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[i])
80103ff8:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103ffc:	85 c0                	test   %eax,%eax
80103ffe:	74 13                	je     80104013 <fork+0x93>
      np->ofile[i] = filedup(curproc->ofile[i]);
80104000:	83 ec 0c             	sub    $0xc,%esp
80104003:	50                   	push   %eax
80104004:	e8 47 d2 ff ff       	call   80101250 <filedup>
80104009:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010400c:	83 c4 10             	add    $0x10,%esp
8010400f:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80104013:	83 c6 01             	add    $0x1,%esi
80104016:	83 fe 10             	cmp    $0x10,%esi
80104019:	75 dd                	jne    80103ff8 <fork+0x78>
  np->cwd = idup(curproc->cwd);
8010401b:	83 ec 0c             	sub    $0xc,%esp
8010401e:	ff 73 68             	pushl  0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104021:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
80104024:	e8 e7 da ff ff       	call   80101b10 <idup>
80104029:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
8010402c:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
8010402f:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104032:	8d 47 6c             	lea    0x6c(%edi),%eax
80104035:	6a 10                	push   $0x10
80104037:	53                   	push   %ebx
80104038:	50                   	push   %eax
80104039:	e8 32 13 00 00       	call   80105370 <safestrcpy>
  pid = np->pid;
8010403e:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80104041:	c7 04 24 00 47 11 80 	movl   $0x80114700,(%esp)
80104048:	e8 53 10 00 00       	call   801050a0 <acquire>
  np->state = RUNNABLE;
8010404d:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80104054:	c7 04 24 00 47 11 80 	movl   $0x80114700,(%esp)
8010405b:	e8 00 11 00 00       	call   80105160 <release>
  return pid;
80104060:	83 c4 10             	add    $0x10,%esp
}
80104063:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104066:	89 d8                	mov    %ebx,%eax
80104068:	5b                   	pop    %ebx
80104069:	5e                   	pop    %esi
8010406a:	5f                   	pop    %edi
8010406b:	5d                   	pop    %ebp
8010406c:	c3                   	ret    
    return -1;
8010406d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80104072:	eb ef                	jmp    80104063 <fork+0xe3>
    kfree(np->kstack);
80104074:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80104077:	83 ec 0c             	sub    $0xc,%esp
8010407a:	ff 73 08             	pushl  0x8(%ebx)
8010407d:	e8 ce e7 ff ff       	call   80102850 <kfree>
    np->kstack = 0;
80104082:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    return -1;
80104089:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
8010408c:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80104093:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80104098:	eb c9                	jmp    80104063 <fork+0xe3>
8010409a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801040a0 <changeProcessMHRRN>:
int changeProcessMHRRN(int pid, int priority) {
801040a0:	f3 0f 1e fb          	endbr32 
801040a4:	55                   	push   %ebp
801040a5:	89 e5                	mov    %esp,%ebp
801040a7:	53                   	push   %ebx
801040a8:	83 ec 10             	sub    $0x10,%esp
801040ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
801040ae:	68 00 47 11 80       	push   $0x80114700
801040b3:	e8 e8 0f 00 00       	call   801050a0 <acquire>
801040b8:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801040bb:	b8 34 47 11 80       	mov    $0x80114734,%eax
801040c0:	eb 12                	jmp    801040d4 <changeProcessMHRRN+0x34>
801040c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801040c8:	05 90 00 00 00       	add    $0x90,%eax
801040cd:	3d 34 6b 11 80       	cmp    $0x80116b34,%eax
801040d2:	74 2c                	je     80104100 <changeProcessMHRRN+0x60>
    if(p->pid == pid){
801040d4:	39 58 10             	cmp    %ebx,0x10(%eax)
801040d7:	75 ef                	jne    801040c8 <changeProcessMHRRN+0x28>
      p->HRRN_priority = priority;
801040d9:	8b 55 0c             	mov    0xc(%ebp),%edx
      release(&ptable.lock);
801040dc:	83 ec 0c             	sub    $0xc,%esp
      p->HRRN_priority = priority;
801040df:	89 90 88 00 00 00    	mov    %edx,0x88(%eax)
      release(&ptable.lock);
801040e5:	68 00 47 11 80       	push   $0x80114700
801040ea:	e8 71 10 00 00       	call   80105160 <release>
}
801040ef:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
801040f2:	83 c4 10             	add    $0x10,%esp
801040f5:	31 c0                	xor    %eax,%eax
}
801040f7:	c9                   	leave  
801040f8:	c3                   	ret    
801040f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80104100:	83 ec 0c             	sub    $0xc,%esp
80104103:	68 00 47 11 80       	push   $0x80114700
80104108:	e8 53 10 00 00       	call   80105160 <release>
}
8010410d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80104110:	83 c4 10             	add    $0x10,%esp
80104113:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104118:	c9                   	leave  
80104119:	c3                   	ret    
8010411a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104120 <changeSystemMHRRN>:
int changeSystemMHRRN(int priority) {
80104120:	f3 0f 1e fb          	endbr32 
80104124:	55                   	push   %ebp
80104125:	89 e5                	mov    %esp,%ebp
80104127:	53                   	push   %ebx
80104128:	83 ec 10             	sub    $0x10,%esp
8010412b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010412e:	68 00 47 11 80       	push   $0x80114700
80104133:	e8 68 0f 00 00       	call   801050a0 <acquire>
80104138:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010413b:	b8 34 47 11 80       	mov    $0x80114734,%eax
    p->HRRN_priority = priority;
80104140:	89 98 88 00 00 00    	mov    %ebx,0x88(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104146:	05 90 00 00 00       	add    $0x90,%eax
8010414b:	3d 34 6b 11 80       	cmp    $0x80116b34,%eax
80104150:	75 ee                	jne    80104140 <changeSystemMHRRN+0x20>
  release(&ptable.lock);
80104152:	83 ec 0c             	sub    $0xc,%esp
80104155:	68 00 47 11 80       	push   $0x80114700
8010415a:	e8 01 10 00 00       	call   80105160 <release>
}
8010415f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104162:	31 c0                	xor    %eax,%eax
80104164:	c9                   	leave  
80104165:	c3                   	ret    
80104166:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010416d:	8d 76 00             	lea    0x0(%esi),%esi

80104170 <changeQueue>:
int changeQueue(int pid, int tqnum) {
80104170:	f3 0f 1e fb          	endbr32 
80104174:	55                   	push   %ebp
80104175:	89 e5                	mov    %esp,%ebp
80104177:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010417a:	8b 55 08             	mov    0x8(%ebp),%edx
  if (tqnum < 1 || tqnum > 3)
8010417d:	8d 41 ff             	lea    -0x1(%ecx),%eax
80104180:	83 f8 02             	cmp    $0x2,%eax
80104183:	77 2b                	ja     801041b0 <changeQueue+0x40>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104185:	b8 34 47 11 80       	mov    $0x80114734,%eax
8010418a:	eb 10                	jmp    8010419c <changeQueue+0x2c>
8010418c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104190:	05 90 00 00 00       	add    $0x90,%eax
80104195:	3d 34 6b 11 80       	cmp    $0x80116b34,%eax
8010419a:	74 14                	je     801041b0 <changeQueue+0x40>
    if(p->pid == pid){
8010419c:	39 50 10             	cmp    %edx,0x10(%eax)
8010419f:	75 ef                	jne    80104190 <changeQueue+0x20>
      p->qnum = tqnum;
801041a1:	89 48 7c             	mov    %ecx,0x7c(%eax)
      return 0;
801041a4:	31 c0                	xor    %eax,%eax
}
801041a6:	5d                   	pop    %ebp
801041a7:	c3                   	ret    
801041a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801041af:	90                   	nop
    return -1;
801041b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801041b5:	5d                   	pop    %ebp
801041b6:	c3                   	ret    
801041b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801041be:	66 90                	xchg   %ax,%ax

801041c0 <printProcess>:
int printProcess(void) {
801041c0:	f3 0f 1e fb          	endbr32 
801041c4:	55                   	push   %ebp
801041c5:	89 e5                	mov    %esp,%ebp
801041c7:	56                   	push   %esi
801041c8:	53                   	push   %ebx
801041c9:	bb a0 47 11 80       	mov    $0x801147a0,%ebx
  acquire(&ptable.lock);
801041ce:	83 ec 0c             	sub    $0xc,%esp
801041d1:	68 00 47 11 80       	push   $0x80114700
801041d6:	e8 c5 0e 00 00       	call   801050a0 <acquire>
  cprintf("name\tpid\tstate\t\tqueue\tcycles\tarrival time\tHRRN\tMHRRN\n");
801041db:	c7 04 24 cc 84 10 80 	movl   $0x801084cc,(%esp)
801041e2:	e8 c9 c4 ff ff       	call   801006b0 <cprintf>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041e7:	83 c4 10             	add    $0x10,%esp
801041ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(p->state == 0) continue;
801041f0:	8b 43 a0             	mov    -0x60(%ebx),%eax
801041f3:	85 c0                	test   %eax,%eax
801041f5:	0f 84 fa 00 00 00    	je     801042f5 <printProcess+0x135>
    cprintf("%s\t", p->name);
801041fb:	83 ec 08             	sub    $0x8,%esp
801041fe:	53                   	push   %ebx
801041ff:	68 bb 83 10 80       	push   $0x801083bb
80104204:	e8 a7 c4 ff ff       	call   801006b0 <cprintf>
    cprintf("%d\t", p->pid);
80104209:	59                   	pop    %ecx
8010420a:	5e                   	pop    %esi
8010420b:	ff 73 a4             	pushl  -0x5c(%ebx)
8010420e:	68 bf 83 10 80       	push   $0x801083bf
80104213:	e8 98 c4 ff ff       	call   801006b0 <cprintf>
    switch (p->state)
80104218:	83 c4 10             	add    $0x10,%esp
8010421b:	83 7b a0 05          	cmpl   $0x5,-0x60(%ebx)
8010421f:	77 27                	ja     80104248 <printProcess+0x88>
80104221:	8b 43 a0             	mov    -0x60(%ebx),%eax
80104224:	3e ff 24 85 5c 85 10 	notrack jmp *-0x7fef7aa4(,%eax,4)
8010422b:	80 
8010422c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        cprintf("%s\t\t", "RUNNING");
80104230:	83 ec 08             	sub    $0x8,%esp
80104233:	68 e8 83 10 80       	push   $0x801083e8
80104238:	68 ca 83 10 80       	push   $0x801083ca
8010423d:	e8 6e c4 ff ff       	call   801006b0 <cprintf>
        break;
80104242:	83 c4 10             	add    $0x10,%esp
80104245:	8d 76 00             	lea    0x0(%esi),%esi
    cprintf("%d\t", p->qnum);
80104248:	83 ec 08             	sub    $0x8,%esp
8010424b:	ff 73 10             	pushl  0x10(%ebx)
8010424e:	68 bf 83 10 80       	push   $0x801083bf
80104253:	e8 58 c4 ff ff       	call   801006b0 <cprintf>
    cprintf("%d\t", p->cycles);
80104258:	58                   	pop    %eax
80104259:	5a                   	pop    %edx
8010425a:	ff 73 18             	pushl  0x18(%ebx)
8010425d:	68 bf 83 10 80       	push   $0x801083bf
80104262:	e8 49 c4 ff ff       	call   801006b0 <cprintf>
    cprintf("%d\t\t", p->arrival_time);
80104267:	59                   	pop    %ecx
80104268:	5e                   	pop    %esi
80104269:	ff 73 14             	pushl  0x14(%ebx)
8010426c:	68 f7 83 10 80       	push   $0x801083f7
80104271:	e8 3a c4 ff ff       	call   801006b0 <cprintf>
  acquire(&tickslock);
80104276:	c7 04 24 40 6b 11 80 	movl   $0x80116b40,(%esp)
8010427d:	e8 1e 0e 00 00       	call   801050a0 <acquire>
  ticks0 = ticks;
80104282:	8b 35 80 73 11 80    	mov    0x80117380,%esi
  release(&tickslock);
80104288:	c7 04 24 40 6b 11 80 	movl   $0x80116b40,(%esp)
8010428f:	e8 cc 0e 00 00       	call   80105160 <release>
    cprintf("%d\t", ((getTime() - p->arrival_time + p->cycles)/(p->cycles)));
80104294:	8b 4b 18             	mov    0x18(%ebx),%ecx
80104297:	58                   	pop    %eax
80104298:	89 f0                	mov    %esi,%eax
8010429a:	2b 43 14             	sub    0x14(%ebx),%eax
8010429d:	5a                   	pop    %edx
8010429e:	01 c8                	add    %ecx,%eax
801042a0:	99                   	cltd   
801042a1:	f7 f9                	idiv   %ecx
801042a3:	50                   	push   %eax
801042a4:	68 bf 83 10 80       	push   $0x801083bf
801042a9:	e8 02 c4 ff ff       	call   801006b0 <cprintf>
  acquire(&tickslock);
801042ae:	c7 04 24 40 6b 11 80 	movl   $0x80116b40,(%esp)
801042b5:	e8 e6 0d 00 00       	call   801050a0 <acquire>
  ticks0 = ticks;
801042ba:	8b 35 80 73 11 80    	mov    0x80117380,%esi
  release(&tickslock);
801042c0:	c7 04 24 40 6b 11 80 	movl   $0x80116b40,(%esp)
801042c7:	e8 94 0e 00 00       	call   80105160 <release>
    cprintf("%d\t", (((getTime() - p->arrival_time + p->cycles)/(p->cycles))+p->HRRN_priority)/2);
801042cc:	8b 4b 18             	mov    0x18(%ebx),%ecx
801042cf:	58                   	pop    %eax
801042d0:	89 f0                	mov    %esi,%eax
801042d2:	2b 43 14             	sub    0x14(%ebx),%eax
801042d5:	5a                   	pop    %edx
801042d6:	01 c8                	add    %ecx,%eax
801042d8:	99                   	cltd   
801042d9:	f7 f9                	idiv   %ecx
801042db:	03 43 1c             	add    0x1c(%ebx),%eax
801042de:	89 c2                	mov    %eax,%edx
801042e0:	c1 ea 1f             	shr    $0x1f,%edx
801042e3:	01 d0                	add    %edx,%eax
801042e5:	d1 f8                	sar    %eax
801042e7:	50                   	push   %eax
801042e8:	68 bf 83 10 80       	push   $0x801083bf
801042ed:	e8 be c3 ff ff       	call   801006b0 <cprintf>
801042f2:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801042f5:	81 c3 90 00 00 00    	add    $0x90,%ebx
801042fb:	81 fb a0 6b 11 80    	cmp    $0x80116ba0,%ebx
80104301:	0f 85 e9 fe ff ff    	jne    801041f0 <printProcess+0x30>
  release(&ptable.lock);
80104307:	83 ec 0c             	sub    $0xc,%esp
8010430a:	68 00 47 11 80       	push   $0x80114700
8010430f:	e8 4c 0e 00 00       	call   80105160 <release>
}
80104314:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104317:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010431c:	5b                   	pop    %ebx
8010431d:	5e                   	pop    %esi
8010431e:	5d                   	pop    %ebp
8010431f:	c3                   	ret    
        cprintf("%s\t", "RUNNABLE");
80104320:	83 ec 08             	sub    $0x8,%esp
80104323:	68 df 83 10 80       	push   $0x801083df
80104328:	68 bb 83 10 80       	push   $0x801083bb
8010432d:	e8 7e c3 ff ff       	call   801006b0 <cprintf>
        break;
80104332:	83 c4 10             	add    $0x10,%esp
80104335:	e9 0e ff ff ff       	jmp    80104248 <printProcess+0x88>
8010433a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        cprintf("%s\t\t", "UNUSED");
80104340:	83 ec 08             	sub    $0x8,%esp
80104343:	68 c3 83 10 80       	push   $0x801083c3
80104348:	68 ca 83 10 80       	push   $0x801083ca
8010434d:	e8 5e c3 ff ff       	call   801006b0 <cprintf>
        break;
80104352:	83 c4 10             	add    $0x10,%esp
80104355:	e9 ee fe ff ff       	jmp    80104248 <printProcess+0x88>
8010435a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        cprintf("%s\t\t", "ZOMBIE");
80104360:	83 ec 08             	sub    $0x8,%esp
80104363:	68 f0 83 10 80       	push   $0x801083f0
80104368:	68 ca 83 10 80       	push   $0x801083ca
8010436d:	e8 3e c3 ff ff       	call   801006b0 <cprintf>
        break;
80104372:	83 c4 10             	add    $0x10,%esp
80104375:	e9 ce fe ff ff       	jmp    80104248 <printProcess+0x88>
8010437a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        cprintf("%s\t", "SLEEPING");
80104380:	83 ec 08             	sub    $0x8,%esp
80104383:	68 d6 83 10 80       	push   $0x801083d6
80104388:	68 bb 83 10 80       	push   $0x801083bb
8010438d:	e8 1e c3 ff ff       	call   801006b0 <cprintf>
        break;
80104392:	83 c4 10             	add    $0x10,%esp
80104395:	e9 ae fe ff ff       	jmp    80104248 <printProcess+0x88>
8010439a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        cprintf("%s\t\t", "EMBRYO");
801043a0:	83 ec 08             	sub    $0x8,%esp
801043a3:	68 cf 83 10 80       	push   $0x801083cf
801043a8:	68 ca 83 10 80       	push   $0x801083ca
801043ad:	e8 fe c2 ff ff       	call   801006b0 <cprintf>
        break;
801043b2:	83 c4 10             	add    $0x10,%esp
801043b5:	e9 8e fe ff ff       	jmp    80104248 <printProcess+0x88>
801043ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801043c0 <findProcess>:
struct proc* findProcess(int* flag) {
801043c0:	f3 0f 1e fb          	endbr32 
801043c4:	55                   	push   %ebp
801043c5:	89 e5                	mov    %esp,%ebp
801043c7:	57                   	push   %edi
801043c8:	56                   	push   %esi
801043c9:	53                   	push   %ebx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) 
801043ca:	bb 34 47 11 80       	mov    $0x80114734,%ebx
struct proc* findProcess(int* flag) {
801043cf:	83 ec 0c             	sub    $0xc,%esp
801043d2:	eb 12                	jmp    801043e6 <findProcess+0x26>
801043d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) 
801043d8:	81 c3 90 00 00 00    	add    $0x90,%ebx
801043de:	81 fb 34 6b 11 80    	cmp    $0x80116b34,%ebx
801043e4:	74 22                	je     80104408 <findProcess+0x48>
    if(p->state == RUNNABLE && p->qnum == 1) {
801043e6:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
801043ea:	75 ec                	jne    801043d8 <findProcess+0x18>
801043ec:	83 7b 7c 01          	cmpl   $0x1,0x7c(%ebx)
801043f0:	75 e6                	jne    801043d8 <findProcess+0x18>
    *flag = 1;
801043f2:	8b 45 08             	mov    0x8(%ebp),%eax
801043f5:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
}
801043fb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801043fe:	89 d8                	mov    %ebx,%eax
80104400:	5b                   	pop    %ebx
80104401:	5e                   	pop    %esi
80104402:	5f                   	pop    %edi
80104403:	5d                   	pop    %ebp
80104404:	c3                   	ret    
80104405:	8d 76 00             	lea    0x0(%esi),%esi
  int max_arrival_time = -1;
80104408:	be ff ff ff ff       	mov    $0xffffffff,%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010440d:	b8 34 47 11 80       	mov    $0x80114734,%eax
80104412:	eb 10                	jmp    80104424 <findProcess+0x64>
80104414:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104418:	05 90 00 00 00       	add    $0x90,%eax
8010441d:	3d 34 6b 11 80       	cmp    $0x80116b34,%eax
80104422:	74 2c                	je     80104450 <findProcess+0x90>
    if(p->state == RUNNABLE && p->qnum == 2) 
80104424:	83 78 0c 03          	cmpl   $0x3,0xc(%eax)
80104428:	75 ee                	jne    80104418 <findProcess+0x58>
8010442a:	83 78 7c 02          	cmpl   $0x2,0x7c(%eax)
8010442e:	75 e8                	jne    80104418 <findProcess+0x58>
      if(p->arrival_time > max_arrival_time) {
80104430:	8b 90 80 00 00 00    	mov    0x80(%eax),%edx
80104436:	39 f2                	cmp    %esi,%edx
80104438:	7e de                	jle    80104418 <findProcess+0x58>
8010443a:	89 c3                	mov    %eax,%ebx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010443c:	05 90 00 00 00       	add    $0x90,%eax
      if(p->arrival_time > max_arrival_time) {
80104441:	89 d6                	mov    %edx,%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104443:	3d 34 6b 11 80       	cmp    $0x80116b34,%eax
80104448:	75 da                	jne    80104424 <findProcess+0x64>
8010444a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(max_arrival_time != -1) {
80104450:	83 fe ff             	cmp    $0xffffffff,%esi
80104453:	75 9d                	jne    801043f2 <findProcess+0x32>
  acquire(&tickslock);
80104455:	83 ec 0c             	sub    $0xc,%esp
80104458:	68 40 6b 11 80       	push   $0x80116b40
8010445d:	e8 3e 0c 00 00       	call   801050a0 <acquire>
  release(&tickslock);
80104462:	c7 04 24 40 6b 11 80 	movl   $0x80116b40,(%esp)
  ticks0 = ticks;
80104469:	8b 3d 80 73 11 80    	mov    0x80117380,%edi
  release(&tickslock);
8010446f:	e8 ec 0c 00 00       	call   80105160 <release>
  return ticks0;
80104474:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104477:	b9 34 47 11 80       	mov    $0x80114734,%ecx
8010447c:	eb 10                	jmp    8010448e <findProcess+0xce>
8010447e:	66 90                	xchg   %ax,%ax
80104480:	81 c1 90 00 00 00    	add    $0x90,%ecx
80104486:	81 f9 34 6b 11 80    	cmp    $0x80116b34,%ecx
8010448c:	74 46                	je     801044d4 <findProcess+0x114>
    if(p->state == RUNNABLE && p->qnum == 3) {
8010448e:	83 79 0c 03          	cmpl   $0x3,0xc(%ecx)
80104492:	75 ec                	jne    80104480 <findProcess+0xc0>
80104494:	83 79 7c 03          	cmpl   $0x3,0x7c(%ecx)
80104498:	75 e6                	jne    80104480 <findProcess+0xc0>
      int MHRRN = (((curr_time - p->arrival_time + p->cycles)/(p->cycles))+p->HRRN_priority)/2;
8010449a:	89 f8                	mov    %edi,%eax
8010449c:	2b 81 80 00 00 00    	sub    0x80(%ecx),%eax
801044a2:	03 81 84 00 00 00    	add    0x84(%ecx),%eax
801044a8:	99                   	cltd   
801044a9:	f7 b9 84 00 00 00    	idivl  0x84(%ecx)
801044af:	03 81 88 00 00 00    	add    0x88(%ecx),%eax
801044b5:	89 c2                	mov    %eax,%edx
801044b7:	c1 e8 1f             	shr    $0x1f,%eax
801044ba:	01 d0                	add    %edx,%eax
801044bc:	d1 f8                	sar    %eax
      if(MHRRN > max_MHRRN) {
801044be:	39 f0                	cmp    %esi,%eax
801044c0:	7e be                	jle    80104480 <findProcess+0xc0>
801044c2:	89 cb                	mov    %ecx,%ebx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801044c4:	81 c1 90 00 00 00    	add    $0x90,%ecx
      if(MHRRN > max_MHRRN) {
801044ca:	89 c6                	mov    %eax,%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801044cc:	81 f9 34 6b 11 80    	cmp    $0x80116b34,%ecx
801044d2:	75 ba                	jne    8010448e <findProcess+0xce>
    *flag = 1;
801044d4:	8b 45 08             	mov    0x8(%ebp),%eax
  if(max_MHRRN != -1) {
801044d7:	83 fe ff             	cmp    $0xffffffff,%esi
801044da:	74 0b                	je     801044e7 <findProcess+0x127>
    *flag = 1;
801044dc:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
    return last_p;
801044e2:	e9 14 ff ff ff       	jmp    801043fb <findProcess+0x3b>
  *flag = 0;
801044e7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801044ed:	bb 34 6b 11 80       	mov    $0x80116b34,%ebx
  return p;
801044f2:	e9 04 ff ff ff       	jmp    801043fb <findProcess+0x3b>
801044f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801044fe:	66 90                	xchg   %ax,%ax

80104500 <scheduler>:
{
80104500:	f3 0f 1e fb          	endbr32 
80104504:	55                   	push   %ebp
80104505:	89 e5                	mov    %esp,%ebp
80104507:	57                   	push   %edi
80104508:	56                   	push   %esi
80104509:	8d 7d e4             	lea    -0x1c(%ebp),%edi
8010450c:	53                   	push   %ebx
8010450d:	83 ec 2c             	sub    $0x2c,%esp
  struct cpu *c = mycpu();
80104510:	e8 fb f7 ff ff       	call   80103d10 <mycpu>
  c->proc = 0;
80104515:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
8010451c:	00 00 00 
  struct cpu *c = mycpu();
8010451f:	89 c3                	mov    %eax,%ebx
  c->proc = 0;
80104521:	8d 40 04             	lea    0x4(%eax),%eax
80104524:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80104527:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010452e:	66 90                	xchg   %ax,%ax
  asm volatile("sti");
80104530:	fb                   	sti    
    acquire(&ptable.lock);
80104531:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104534:	be 34 47 11 80       	mov    $0x80114734,%esi
    acquire(&ptable.lock);
80104539:	68 00 47 11 80       	push   $0x80114700
8010453e:	e8 5d 0b 00 00       	call   801050a0 <acquire>
80104543:	83 c4 10             	add    $0x10,%esp
      if(p->state != RUNNABLE)
80104546:	83 7e 0c 03          	cmpl   $0x3,0xc(%esi)
8010454a:	75 57                	jne    801045a3 <scheduler+0xa3>
      p = findProcess(&flag);
8010454c:	83 ec 0c             	sub    $0xc,%esp
      int flag = 0;
8010454f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
      p = findProcess(&flag);
80104556:	57                   	push   %edi
80104557:	e8 64 fe ff ff       	call   801043c0 <findProcess>
      c->proc = p;
8010455c:	89 83 ac 00 00 00    	mov    %eax,0xac(%ebx)
      p = findProcess(&flag);
80104562:	89 c6                	mov    %eax,%esi
      switchuvm(p);
80104564:	89 04 24             	mov    %eax,(%esp)
80104567:	e8 94 31 00 00       	call   80107700 <switchuvm>
      p->cycles++;
8010456c:	83 86 84 00 00 00 01 	addl   $0x1,0x84(%esi)
      p->state = RUNNING;
80104573:	c7 46 0c 04 00 00 00 	movl   $0x4,0xc(%esi)
      p->wait_cycles = 0;
8010457a:	c7 86 8c 00 00 00 00 	movl   $0x0,0x8c(%esi)
80104581:	00 00 00 
      swtch(&(c->scheduler), p->context);
80104584:	58                   	pop    %eax
80104585:	5a                   	pop    %edx
80104586:	ff 76 1c             	pushl  0x1c(%esi)
80104589:	ff 75 d4             	pushl  -0x2c(%ebp)
8010458c:	e8 42 0e 00 00       	call   801053d3 <swtch>
      switchkvm();
80104591:	e8 4a 31 00 00       	call   801076e0 <switchkvm>
      c->proc = 0;
80104596:	83 c4 10             	add    $0x10,%esp
80104599:	c7 83 ac 00 00 00 00 	movl   $0x0,0xac(%ebx)
801045a0:	00 00 00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801045a3:	81 c6 90 00 00 00    	add    $0x90,%esi
801045a9:	81 fe 34 6b 11 80    	cmp    $0x80116b34,%esi
801045af:	72 95                	jb     80104546 <scheduler+0x46>
    release(&ptable.lock);
801045b1:	83 ec 0c             	sub    $0xc,%esp
801045b4:	68 00 47 11 80       	push   $0x80114700
801045b9:	e8 a2 0b 00 00       	call   80105160 <release>
    sti();
801045be:	83 c4 10             	add    $0x10,%esp
801045c1:	e9 6a ff ff ff       	jmp    80104530 <scheduler+0x30>
801045c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801045cd:	8d 76 00             	lea    0x0(%esi),%esi

801045d0 <sched>:
{
801045d0:	f3 0f 1e fb          	endbr32 
801045d4:	55                   	push   %ebp
801045d5:	89 e5                	mov    %esp,%ebp
801045d7:	56                   	push   %esi
801045d8:	53                   	push   %ebx
  pushcli();
801045d9:	e8 c2 09 00 00       	call   80104fa0 <pushcli>
  c = mycpu();
801045de:	e8 2d f7 ff ff       	call   80103d10 <mycpu>
  p = c->proc;
801045e3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801045e9:	e8 02 0a 00 00       	call   80104ff0 <popcli>
  if(!holding(&ptable.lock))
801045ee:	83 ec 0c             	sub    $0xc,%esp
801045f1:	68 00 47 11 80       	push   $0x80114700
801045f6:	e8 55 0a 00 00       	call   80105050 <holding>
801045fb:	83 c4 10             	add    $0x10,%esp
801045fe:	85 c0                	test   %eax,%eax
80104600:	74 4f                	je     80104651 <sched+0x81>
  if(mycpu()->ncli != 1)
80104602:	e8 09 f7 ff ff       	call   80103d10 <mycpu>
80104607:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
8010460e:	75 68                	jne    80104678 <sched+0xa8>
  if(p->state == RUNNING)
80104610:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80104614:	74 55                	je     8010466b <sched+0x9b>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104616:	9c                   	pushf  
80104617:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104618:	f6 c4 02             	test   $0x2,%ah
8010461b:	75 41                	jne    8010465e <sched+0x8e>
  intena = mycpu()->intena;
8010461d:	e8 ee f6 ff ff       	call   80103d10 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80104622:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80104625:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
8010462b:	e8 e0 f6 ff ff       	call   80103d10 <mycpu>
80104630:	83 ec 08             	sub    $0x8,%esp
80104633:	ff 70 04             	pushl  0x4(%eax)
80104636:	53                   	push   %ebx
80104637:	e8 97 0d 00 00       	call   801053d3 <swtch>
  mycpu()->intena = intena;
8010463c:	e8 cf f6 ff ff       	call   80103d10 <mycpu>
}
80104641:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80104644:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
8010464a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010464d:	5b                   	pop    %ebx
8010464e:	5e                   	pop    %esi
8010464f:	5d                   	pop    %ebp
80104650:	c3                   	ret    
    panic("sched ptable.lock");
80104651:	83 ec 0c             	sub    $0xc,%esp
80104654:	68 fc 83 10 80       	push   $0x801083fc
80104659:	e8 32 bd ff ff       	call   80100390 <panic>
    panic("sched interruptible");
8010465e:	83 ec 0c             	sub    $0xc,%esp
80104661:	68 28 84 10 80       	push   $0x80108428
80104666:	e8 25 bd ff ff       	call   80100390 <panic>
    panic("sched running");
8010466b:	83 ec 0c             	sub    $0xc,%esp
8010466e:	68 1a 84 10 80       	push   $0x8010841a
80104673:	e8 18 bd ff ff       	call   80100390 <panic>
    panic("sched locks");
80104678:	83 ec 0c             	sub    $0xc,%esp
8010467b:	68 0e 84 10 80       	push   $0x8010840e
80104680:	e8 0b bd ff ff       	call   80100390 <panic>
80104685:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010468c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104690 <exit>:
{
80104690:	f3 0f 1e fb          	endbr32 
80104694:	55                   	push   %ebp
80104695:	89 e5                	mov    %esp,%ebp
80104697:	57                   	push   %edi
80104698:	56                   	push   %esi
80104699:	53                   	push   %ebx
8010469a:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
8010469d:	e8 fe 08 00 00       	call   80104fa0 <pushcli>
  c = mycpu();
801046a2:	e8 69 f6 ff ff       	call   80103d10 <mycpu>
  p = c->proc;
801046a7:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801046ad:	e8 3e 09 00 00       	call   80104ff0 <popcli>
  if(curproc == initproc)
801046b2:	8d 5e 28             	lea    0x28(%esi),%ebx
801046b5:	8d 7e 68             	lea    0x68(%esi),%edi
801046b8:	39 35 e0 b5 10 80    	cmp    %esi,0x8010b5e0
801046be:	0f 84 fd 00 00 00    	je     801047c1 <exit+0x131>
801046c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd]){
801046c8:	8b 03                	mov    (%ebx),%eax
801046ca:	85 c0                	test   %eax,%eax
801046cc:	74 12                	je     801046e0 <exit+0x50>
      fileclose(curproc->ofile[fd]);
801046ce:	83 ec 0c             	sub    $0xc,%esp
801046d1:	50                   	push   %eax
801046d2:	e8 c9 cb ff ff       	call   801012a0 <fileclose>
      curproc->ofile[fd] = 0;
801046d7:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801046dd:	83 c4 10             	add    $0x10,%esp
  for(fd = 0; fd < NOFILE; fd++){
801046e0:	83 c3 04             	add    $0x4,%ebx
801046e3:	39 df                	cmp    %ebx,%edi
801046e5:	75 e1                	jne    801046c8 <exit+0x38>
  begin_op();
801046e7:	e8 24 ea ff ff       	call   80103110 <begin_op>
  iput(curproc->cwd);
801046ec:	83 ec 0c             	sub    $0xc,%esp
801046ef:	ff 76 68             	pushl  0x68(%esi)
801046f2:	e8 79 d5 ff ff       	call   80101c70 <iput>
  end_op();
801046f7:	e8 84 ea ff ff       	call   80103180 <end_op>
  curproc->cwd = 0;
801046fc:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
  acquire(&ptable.lock);
80104703:	c7 04 24 00 47 11 80 	movl   $0x80114700,(%esp)
8010470a:	e8 91 09 00 00       	call   801050a0 <acquire>
  wakeup1(curproc->parent);
8010470f:	8b 56 14             	mov    0x14(%esi),%edx
80104712:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104715:	b8 34 47 11 80       	mov    $0x80114734,%eax
8010471a:	eb 10                	jmp    8010472c <exit+0x9c>
8010471c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104720:	05 90 00 00 00       	add    $0x90,%eax
80104725:	3d 34 6b 11 80       	cmp    $0x80116b34,%eax
8010472a:	74 1e                	je     8010474a <exit+0xba>
    if(p->state == SLEEPING && p->chan == chan)
8010472c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104730:	75 ee                	jne    80104720 <exit+0x90>
80104732:	3b 50 20             	cmp    0x20(%eax),%edx
80104735:	75 e9                	jne    80104720 <exit+0x90>
      p->state = RUNNABLE;
80104737:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010473e:	05 90 00 00 00       	add    $0x90,%eax
80104743:	3d 34 6b 11 80       	cmp    $0x80116b34,%eax
80104748:	75 e2                	jne    8010472c <exit+0x9c>
      p->parent = initproc;
8010474a:	8b 0d e0 b5 10 80    	mov    0x8010b5e0,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104750:	ba 34 47 11 80       	mov    $0x80114734,%edx
80104755:	eb 17                	jmp    8010476e <exit+0xde>
80104757:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010475e:	66 90                	xchg   %ax,%ax
80104760:	81 c2 90 00 00 00    	add    $0x90,%edx
80104766:	81 fa 34 6b 11 80    	cmp    $0x80116b34,%edx
8010476c:	74 3a                	je     801047a8 <exit+0x118>
    if(p->parent == curproc){
8010476e:	39 72 14             	cmp    %esi,0x14(%edx)
80104771:	75 ed                	jne    80104760 <exit+0xd0>
      if(p->state == ZOMBIE)
80104773:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80104777:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
8010477a:	75 e4                	jne    80104760 <exit+0xd0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010477c:	b8 34 47 11 80       	mov    $0x80114734,%eax
80104781:	eb 11                	jmp    80104794 <exit+0x104>
80104783:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104787:	90                   	nop
80104788:	05 90 00 00 00       	add    $0x90,%eax
8010478d:	3d 34 6b 11 80       	cmp    $0x80116b34,%eax
80104792:	74 cc                	je     80104760 <exit+0xd0>
    if(p->state == SLEEPING && p->chan == chan)
80104794:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104798:	75 ee                	jne    80104788 <exit+0xf8>
8010479a:	3b 48 20             	cmp    0x20(%eax),%ecx
8010479d:	75 e9                	jne    80104788 <exit+0xf8>
      p->state = RUNNABLE;
8010479f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
801047a6:	eb e0                	jmp    80104788 <exit+0xf8>
  curproc->state = ZOMBIE;
801047a8:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
801047af:	e8 1c fe ff ff       	call   801045d0 <sched>
  panic("zombie exit");
801047b4:	83 ec 0c             	sub    $0xc,%esp
801047b7:	68 49 84 10 80       	push   $0x80108449
801047bc:	e8 cf bb ff ff       	call   80100390 <panic>
    panic("init exiting");
801047c1:	83 ec 0c             	sub    $0xc,%esp
801047c4:	68 3c 84 10 80       	push   $0x8010843c
801047c9:	e8 c2 bb ff ff       	call   80100390 <panic>
801047ce:	66 90                	xchg   %ax,%ax

801047d0 <yield>:
{
801047d0:	f3 0f 1e fb          	endbr32 
801047d4:	55                   	push   %ebp
801047d5:	89 e5                	mov    %esp,%ebp
801047d7:	53                   	push   %ebx
801047d8:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
801047db:	68 00 47 11 80       	push   $0x80114700
801047e0:	e8 bb 08 00 00       	call   801050a0 <acquire>
  pushcli();
801047e5:	e8 b6 07 00 00       	call   80104fa0 <pushcli>
  c = mycpu();
801047ea:	e8 21 f5 ff ff       	call   80103d10 <mycpu>
  p = c->proc;
801047ef:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801047f5:	e8 f6 07 00 00       	call   80104ff0 <popcli>
  myproc()->state = RUNNABLE;
801047fa:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80104801:	e8 ca fd ff ff       	call   801045d0 <sched>
  release(&ptable.lock);
80104806:	c7 04 24 00 47 11 80 	movl   $0x80114700,(%esp)
8010480d:	e8 4e 09 00 00       	call   80105160 <release>
}
80104812:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104815:	83 c4 10             	add    $0x10,%esp
80104818:	c9                   	leave  
80104819:	c3                   	ret    
8010481a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104820 <sleep>:
{
80104820:	f3 0f 1e fb          	endbr32 
80104824:	55                   	push   %ebp
80104825:	89 e5                	mov    %esp,%ebp
80104827:	57                   	push   %edi
80104828:	56                   	push   %esi
80104829:	53                   	push   %ebx
8010482a:	83 ec 0c             	sub    $0xc,%esp
8010482d:	8b 7d 08             	mov    0x8(%ebp),%edi
80104830:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
80104833:	e8 68 07 00 00       	call   80104fa0 <pushcli>
  c = mycpu();
80104838:	e8 d3 f4 ff ff       	call   80103d10 <mycpu>
  p = c->proc;
8010483d:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104843:	e8 a8 07 00 00       	call   80104ff0 <popcli>
  if(p == 0)
80104848:	85 db                	test   %ebx,%ebx
8010484a:	0f 84 83 00 00 00    	je     801048d3 <sleep+0xb3>
  if(lk == 0)
80104850:	85 f6                	test   %esi,%esi
80104852:	74 72                	je     801048c6 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104854:	81 fe 00 47 11 80    	cmp    $0x80114700,%esi
8010485a:	74 4c                	je     801048a8 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
8010485c:	83 ec 0c             	sub    $0xc,%esp
8010485f:	68 00 47 11 80       	push   $0x80114700
80104864:	e8 37 08 00 00       	call   801050a0 <acquire>
    release(lk);
80104869:	89 34 24             	mov    %esi,(%esp)
8010486c:	e8 ef 08 00 00       	call   80105160 <release>
  p->chan = chan;
80104871:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104874:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
8010487b:	e8 50 fd ff ff       	call   801045d0 <sched>
  p->chan = 0;
80104880:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80104887:	c7 04 24 00 47 11 80 	movl   $0x80114700,(%esp)
8010488e:	e8 cd 08 00 00       	call   80105160 <release>
    acquire(lk);
80104893:	89 75 08             	mov    %esi,0x8(%ebp)
80104896:	83 c4 10             	add    $0x10,%esp
}
80104899:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010489c:	5b                   	pop    %ebx
8010489d:	5e                   	pop    %esi
8010489e:	5f                   	pop    %edi
8010489f:	5d                   	pop    %ebp
    acquire(lk);
801048a0:	e9 fb 07 00 00       	jmp    801050a0 <acquire>
801048a5:	8d 76 00             	lea    0x0(%esi),%esi
  p->chan = chan;
801048a8:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801048ab:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801048b2:	e8 19 fd ff ff       	call   801045d0 <sched>
  p->chan = 0;
801048b7:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
801048be:	8d 65 f4             	lea    -0xc(%ebp),%esp
801048c1:	5b                   	pop    %ebx
801048c2:	5e                   	pop    %esi
801048c3:	5f                   	pop    %edi
801048c4:	5d                   	pop    %ebp
801048c5:	c3                   	ret    
    panic("sleep without lk");
801048c6:	83 ec 0c             	sub    $0xc,%esp
801048c9:	68 5b 84 10 80       	push   $0x8010845b
801048ce:	e8 bd ba ff ff       	call   80100390 <panic>
    panic("sleep");
801048d3:	83 ec 0c             	sub    $0xc,%esp
801048d6:	68 55 84 10 80       	push   $0x80108455
801048db:	e8 b0 ba ff ff       	call   80100390 <panic>

801048e0 <wait>:
{
801048e0:	f3 0f 1e fb          	endbr32 
801048e4:	55                   	push   %ebp
801048e5:	89 e5                	mov    %esp,%ebp
801048e7:	56                   	push   %esi
801048e8:	53                   	push   %ebx
  pushcli();
801048e9:	e8 b2 06 00 00       	call   80104fa0 <pushcli>
  c = mycpu();
801048ee:	e8 1d f4 ff ff       	call   80103d10 <mycpu>
  p = c->proc;
801048f3:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801048f9:	e8 f2 06 00 00       	call   80104ff0 <popcli>
  acquire(&ptable.lock);
801048fe:	83 ec 0c             	sub    $0xc,%esp
80104901:	68 00 47 11 80       	push   $0x80114700
80104906:	e8 95 07 00 00       	call   801050a0 <acquire>
8010490b:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
8010490e:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104910:	bb 34 47 11 80       	mov    $0x80114734,%ebx
80104915:	eb 17                	jmp    8010492e <wait+0x4e>
80104917:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010491e:	66 90                	xchg   %ax,%ax
80104920:	81 c3 90 00 00 00    	add    $0x90,%ebx
80104926:	81 fb 34 6b 11 80    	cmp    $0x80116b34,%ebx
8010492c:	74 1e                	je     8010494c <wait+0x6c>
      if(p->parent != curproc)
8010492e:	39 73 14             	cmp    %esi,0x14(%ebx)
80104931:	75 ed                	jne    80104920 <wait+0x40>
      if(p->state == ZOMBIE){
80104933:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80104937:	74 37                	je     80104970 <wait+0x90>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104939:	81 c3 90 00 00 00    	add    $0x90,%ebx
      havekids = 1;
8010493f:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104944:	81 fb 34 6b 11 80    	cmp    $0x80116b34,%ebx
8010494a:	75 e2                	jne    8010492e <wait+0x4e>
    if(!havekids || curproc->killed){
8010494c:	85 c0                	test   %eax,%eax
8010494e:	74 76                	je     801049c6 <wait+0xe6>
80104950:	8b 46 24             	mov    0x24(%esi),%eax
80104953:	85 c0                	test   %eax,%eax
80104955:	75 6f                	jne    801049c6 <wait+0xe6>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80104957:	83 ec 08             	sub    $0x8,%esp
8010495a:	68 00 47 11 80       	push   $0x80114700
8010495f:	56                   	push   %esi
80104960:	e8 bb fe ff ff       	call   80104820 <sleep>
    havekids = 0;
80104965:	83 c4 10             	add    $0x10,%esp
80104968:	eb a4                	jmp    8010490e <wait+0x2e>
8010496a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        kfree(p->kstack);
80104970:	83 ec 0c             	sub    $0xc,%esp
80104973:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
80104976:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104979:	e8 d2 de ff ff       	call   80102850 <kfree>
        freevm(p->pgdir);
8010497e:	5a                   	pop    %edx
8010497f:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
80104982:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104989:	e8 32 31 00 00       	call   80107ac0 <freevm>
        release(&ptable.lock);
8010498e:	c7 04 24 00 47 11 80 	movl   $0x80114700,(%esp)
        p->pid = 0;
80104995:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
8010499c:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
801049a3:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
801049a7:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
801049ae:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
801049b5:	e8 a6 07 00 00       	call   80105160 <release>
        return pid;
801049ba:	83 c4 10             	add    $0x10,%esp
}
801049bd:	8d 65 f8             	lea    -0x8(%ebp),%esp
801049c0:	89 f0                	mov    %esi,%eax
801049c2:	5b                   	pop    %ebx
801049c3:	5e                   	pop    %esi
801049c4:	5d                   	pop    %ebp
801049c5:	c3                   	ret    
      release(&ptable.lock);
801049c6:	83 ec 0c             	sub    $0xc,%esp
      return -1;
801049c9:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
801049ce:	68 00 47 11 80       	push   $0x80114700
801049d3:	e8 88 07 00 00       	call   80105160 <release>
      return -1;
801049d8:	83 c4 10             	add    $0x10,%esp
801049db:	eb e0                	jmp    801049bd <wait+0xdd>
801049dd:	8d 76 00             	lea    0x0(%esi),%esi

801049e0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
801049e0:	f3 0f 1e fb          	endbr32 
801049e4:	55                   	push   %ebp
801049e5:	89 e5                	mov    %esp,%ebp
801049e7:	53                   	push   %ebx
801049e8:	83 ec 10             	sub    $0x10,%esp
801049eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
801049ee:	68 00 47 11 80       	push   $0x80114700
801049f3:	e8 a8 06 00 00       	call   801050a0 <acquire>
801049f8:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801049fb:	b8 34 47 11 80       	mov    $0x80114734,%eax
80104a00:	eb 12                	jmp    80104a14 <wakeup+0x34>
80104a02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104a08:	05 90 00 00 00       	add    $0x90,%eax
80104a0d:	3d 34 6b 11 80       	cmp    $0x80116b34,%eax
80104a12:	74 1e                	je     80104a32 <wakeup+0x52>
    if(p->state == SLEEPING && p->chan == chan)
80104a14:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104a18:	75 ee                	jne    80104a08 <wakeup+0x28>
80104a1a:	3b 58 20             	cmp    0x20(%eax),%ebx
80104a1d:	75 e9                	jne    80104a08 <wakeup+0x28>
      p->state = RUNNABLE;
80104a1f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104a26:	05 90 00 00 00       	add    $0x90,%eax
80104a2b:	3d 34 6b 11 80       	cmp    $0x80116b34,%eax
80104a30:	75 e2                	jne    80104a14 <wakeup+0x34>
  wakeup1(chan);
  release(&ptable.lock);
80104a32:	c7 45 08 00 47 11 80 	movl   $0x80114700,0x8(%ebp)
}
80104a39:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a3c:	c9                   	leave  
  release(&ptable.lock);
80104a3d:	e9 1e 07 00 00       	jmp    80105160 <release>
80104a42:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104a50 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104a50:	f3 0f 1e fb          	endbr32 
80104a54:	55                   	push   %ebp
80104a55:	89 e5                	mov    %esp,%ebp
80104a57:	53                   	push   %ebx
80104a58:	83 ec 10             	sub    $0x10,%esp
80104a5b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
80104a5e:	68 00 47 11 80       	push   $0x80114700
80104a63:	e8 38 06 00 00       	call   801050a0 <acquire>
80104a68:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a6b:	b8 34 47 11 80       	mov    $0x80114734,%eax
80104a70:	eb 12                	jmp    80104a84 <kill+0x34>
80104a72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104a78:	05 90 00 00 00       	add    $0x90,%eax
80104a7d:	3d 34 6b 11 80       	cmp    $0x80116b34,%eax
80104a82:	74 34                	je     80104ab8 <kill+0x68>
    if(p->pid == pid){
80104a84:	39 58 10             	cmp    %ebx,0x10(%eax)
80104a87:	75 ef                	jne    80104a78 <kill+0x28>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104a89:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104a8d:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
80104a94:	75 07                	jne    80104a9d <kill+0x4d>
        p->state = RUNNABLE;
80104a96:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104a9d:	83 ec 0c             	sub    $0xc,%esp
80104aa0:	68 00 47 11 80       	push   $0x80114700
80104aa5:	e8 b6 06 00 00       	call   80105160 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
80104aaa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
80104aad:	83 c4 10             	add    $0x10,%esp
80104ab0:	31 c0                	xor    %eax,%eax
}
80104ab2:	c9                   	leave  
80104ab3:	c3                   	ret    
80104ab4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80104ab8:	83 ec 0c             	sub    $0xc,%esp
80104abb:	68 00 47 11 80       	push   $0x80114700
80104ac0:	e8 9b 06 00 00       	call   80105160 <release>
}
80104ac5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80104ac8:	83 c4 10             	add    $0x10,%esp
80104acb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104ad0:	c9                   	leave  
80104ad1:	c3                   	ret    
80104ad2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ad9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104ae0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104ae0:	f3 0f 1e fb          	endbr32 
80104ae4:	55                   	push   %ebp
80104ae5:	89 e5                	mov    %esp,%ebp
80104ae7:	57                   	push   %edi
80104ae8:	56                   	push   %esi
80104ae9:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104aec:	53                   	push   %ebx
80104aed:	bb a0 47 11 80       	mov    $0x801147a0,%ebx
80104af2:	83 ec 3c             	sub    $0x3c,%esp
80104af5:	eb 2b                	jmp    80104b22 <procdump+0x42>
80104af7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104afe:	66 90                	xchg   %ax,%ax
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104b00:	83 ec 0c             	sub    $0xc,%esp
80104b03:	68 b3 88 10 80       	push   $0x801088b3
80104b08:	e8 a3 bb ff ff       	call   801006b0 <cprintf>
80104b0d:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104b10:	81 c3 90 00 00 00    	add    $0x90,%ebx
80104b16:	81 fb a0 6b 11 80    	cmp    $0x80116ba0,%ebx
80104b1c:	0f 84 8e 00 00 00    	je     80104bb0 <procdump+0xd0>
    if(p->state == UNUSED)
80104b22:	8b 43 a0             	mov    -0x60(%ebx),%eax
80104b25:	85 c0                	test   %eax,%eax
80104b27:	74 e7                	je     80104b10 <procdump+0x30>
      state = "???";
80104b29:	ba 6c 84 10 80       	mov    $0x8010846c,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104b2e:	83 f8 05             	cmp    $0x5,%eax
80104b31:	77 11                	ja     80104b44 <procdump+0x64>
80104b33:	8b 14 85 74 85 10 80 	mov    -0x7fef7a8c(,%eax,4),%edx
      state = "???";
80104b3a:	b8 6c 84 10 80       	mov    $0x8010846c,%eax
80104b3f:	85 d2                	test   %edx,%edx
80104b41:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104b44:	53                   	push   %ebx
80104b45:	52                   	push   %edx
80104b46:	ff 73 a4             	pushl  -0x5c(%ebx)
80104b49:	68 70 84 10 80       	push   $0x80108470
80104b4e:	e8 5d bb ff ff       	call   801006b0 <cprintf>
    if(p->state == SLEEPING){
80104b53:	83 c4 10             	add    $0x10,%esp
80104b56:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
80104b5a:	75 a4                	jne    80104b00 <procdump+0x20>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104b5c:	83 ec 08             	sub    $0x8,%esp
80104b5f:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104b62:	8d 7d c0             	lea    -0x40(%ebp),%edi
80104b65:	50                   	push   %eax
80104b66:	8b 43 b0             	mov    -0x50(%ebx),%eax
80104b69:	8b 40 0c             	mov    0xc(%eax),%eax
80104b6c:	83 c0 08             	add    $0x8,%eax
80104b6f:	50                   	push   %eax
80104b70:	e8 cb 03 00 00       	call   80104f40 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
80104b75:	83 c4 10             	add    $0x10,%esp
80104b78:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b7f:	90                   	nop
80104b80:	8b 17                	mov    (%edi),%edx
80104b82:	85 d2                	test   %edx,%edx
80104b84:	0f 84 76 ff ff ff    	je     80104b00 <procdump+0x20>
        cprintf(" %p", pc[i]);
80104b8a:	83 ec 08             	sub    $0x8,%esp
80104b8d:	83 c7 04             	add    $0x4,%edi
80104b90:	52                   	push   %edx
80104b91:	68 21 7e 10 80       	push   $0x80107e21
80104b96:	e8 15 bb ff ff       	call   801006b0 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104b9b:	83 c4 10             	add    $0x10,%esp
80104b9e:	39 fe                	cmp    %edi,%esi
80104ba0:	75 de                	jne    80104b80 <procdump+0xa0>
80104ba2:	e9 59 ff ff ff       	jmp    80104b00 <procdump+0x20>
80104ba7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104bae:	66 90                	xchg   %ax,%ax
  }
}
80104bb0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104bb3:	5b                   	pop    %ebx
80104bb4:	5e                   	pop    %esi
80104bb5:	5f                   	pop    %edi
80104bb6:	5d                   	pop    %ebp
80104bb7:	c3                   	ret    
80104bb8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104bbf:	90                   	nop

80104bc0 <sem_sleep>:
}semaphore;

semaphore sems[6];

void sem_sleep(struct proc *p1)
{
80104bc0:	f3 0f 1e fb          	endbr32 
80104bc4:	55                   	push   %ebp
80104bc5:	89 e5                	mov    %esp,%ebp
80104bc7:	53                   	push   %ebx
80104bc8:	83 ec 10             	sub    $0x10,%esp
80104bcb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock); 
80104bce:	68 00 47 11 80       	push   $0x80114700
80104bd3:	e8 c8 04 00 00       	call   801050a0 <acquire>
  p1->state = SLEEPING;
80104bd8:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104bdf:	e8 ec f9 ff ff       	call   801045d0 <sched>
  release(&ptable.lock);
80104be4:	c7 45 08 00 47 11 80 	movl   $0x80114700,0x8(%ebp)
}
80104beb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&ptable.lock);
80104bee:	83 c4 10             	add    $0x10,%esp
}
80104bf1:	c9                   	leave  
  release(&ptable.lock);
80104bf2:	e9 69 05 00 00       	jmp    80105160 <release>
80104bf7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104bfe:	66 90                	xchg   %ax,%ax

80104c00 <sem_wakeup>:

void sem_wakeup(struct proc *p1)
{
80104c00:	f3 0f 1e fb          	endbr32 
80104c04:	55                   	push   %ebp
80104c05:	89 e5                	mov    %esp,%ebp
80104c07:	53                   	push   %ebx
80104c08:	83 ec 10             	sub    $0x10,%esp
80104c0b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
80104c0e:	68 00 47 11 80       	push   $0x80114700
80104c13:	e8 88 04 00 00       	call   801050a0 <acquire>
  p1->state = RUNNABLE;
80104c18:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80104c1f:	83 c4 10             	add    $0x10,%esp
}
80104c22:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&ptable.lock);
80104c25:	c7 45 08 00 47 11 80 	movl   $0x80114700,0x8(%ebp)
}
80104c2c:	c9                   	leave  
  release(&ptable.lock);
80104c2d:	e9 2e 05 00 00       	jmp    80105160 <release>
80104c32:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104c40 <sem_init>:

int sem_init(int i , int v)
{
80104c40:	f3 0f 1e fb          	endbr32 
80104c44:	55                   	push   %ebp
80104c45:	89 e5                	mov    %esp,%ebp
  sems[i].value = v;
80104c47:	69 45 08 98 01 00 00 	imul   $0x198,0x8(%ebp),%eax
80104c4e:	8b 55 0c             	mov    0xc(%ebp),%edx
  sems[i].last = 0;
  return 0;
}
80104c51:	5d                   	pop    %ebp
  sems[i].value = v;
80104c52:	89 90 60 3d 11 80    	mov    %edx,-0x7feec2a0(%eax)
  sems[i].last = 0;
80104c58:	c7 80 f4 3e 11 80 00 	movl   $0x0,-0x7feec10c(%eax)
80104c5f:	00 00 00 
}
80104c62:	31 c0                	xor    %eax,%eax
80104c64:	c3                   	ret    
80104c65:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104c70 <sem_acquire>:

int sem_acquire(int i)
{
80104c70:	f3 0f 1e fb          	endbr32 
80104c74:	55                   	push   %ebp
80104c75:	89 e5                	mov    %esp,%ebp
80104c77:	57                   	push   %edi
80104c78:	56                   	push   %esi
80104c79:	53                   	push   %ebx
80104c7a:	83 ec 1c             	sub    $0x1c,%esp
80104c7d:	8b 75 08             	mov    0x8(%ebp),%esi
  if(sems[i].value <= 0)
80104c80:	69 fe 98 01 00 00    	imul   $0x198,%esi,%edi
80104c86:	8b 9f 60 3d 11 80    	mov    -0x7feec2a0(%edi),%ebx
80104c8c:	85 db                	test   %ebx,%ebx
80104c8e:	7e 40                	jle    80104cd0 <sem_acquire+0x60>
    struct proc* p = myproc();
    sems[i].list[sems[i].last ++] = p;
    sem_sleep(p);
  }
  else
    sems[i].value--;
80104c90:	83 eb 01             	sub    $0x1,%ebx
80104c93:	89 9f 60 3d 11 80    	mov    %ebx,-0x7feec2a0(%edi)
  pushcli();
80104c99:	e8 02 03 00 00       	call   80104fa0 <pushcli>
  c = mycpu();
80104c9e:	e8 6d f0 ff ff       	call   80103d10 <mycpu>
  p = c->proc;
80104ca3:	8b b8 ac 00 00 00    	mov    0xac(%eax),%edi
  popcli();
80104ca9:	e8 42 03 00 00       	call   80104ff0 <popcli>

  cprintf("philosopher %d acquired %d with value %d\n", myproc()->pid-3 , i, sems[i].value );
80104cae:	53                   	push   %ebx
80104caf:	56                   	push   %esi
80104cb0:	8b 47 10             	mov    0x10(%edi),%eax
80104cb3:	83 e8 03             	sub    $0x3,%eax
80104cb6:	50                   	push   %eax
80104cb7:	68 04 85 10 80       	push   $0x80108504
80104cbc:	e8 ef b9 ff ff       	call   801006b0 <cprintf>

  return 0;
}
80104cc1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104cc4:	31 c0                	xor    %eax,%eax
80104cc6:	5b                   	pop    %ebx
80104cc7:	5e                   	pop    %esi
80104cc8:	5f                   	pop    %edi
80104cc9:	5d                   	pop    %ebp
80104cca:	c3                   	ret    
80104ccb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104ccf:	90                   	nop
80104cd0:	8d 97 60 3d 11 80    	lea    -0x7feec2a0(%edi),%edx
80104cd6:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  pushcli();
80104cd9:	e8 c2 02 00 00       	call   80104fa0 <pushcli>
  c = mycpu();
80104cde:	e8 2d f0 ff ff       	call   80103d10 <mycpu>
  p = c->proc;
80104ce3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104ce9:	e8 02 03 00 00       	call   80104ff0 <popcli>
    sems[i].list[sems[i].last ++] = p;
80104cee:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    sem_sleep(p);
80104cf1:	83 ec 0c             	sub    $0xc,%esp
    sems[i].list[sems[i].last ++] = p;
80104cf4:	8b 8a 94 01 00 00    	mov    0x194(%edx),%ecx
80104cfa:	8d 41 01             	lea    0x1(%ecx),%eax
80104cfd:	89 82 94 01 00 00    	mov    %eax,0x194(%edx)
80104d03:	6b c6 66             	imul   $0x66,%esi,%eax
    sem_sleep(p);
80104d06:	53                   	push   %ebx
    sems[i].list[sems[i].last ++] = p;
80104d07:	01 c8                	add    %ecx,%eax
80104d09:	89 1c 85 64 3d 11 80 	mov    %ebx,-0x7feec29c(,%eax,4)
    sem_sleep(p);
80104d10:	e8 ab fe ff ff       	call   80104bc0 <sem_sleep>
80104d15:	8b 9f 60 3d 11 80    	mov    -0x7feec2a0(%edi),%ebx
80104d1b:	83 c4 10             	add    $0x10,%esp
80104d1e:	e9 76 ff ff ff       	jmp    80104c99 <sem_acquire+0x29>
80104d23:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104d30 <sem_release>:

int sem_release(int i)
{
80104d30:	f3 0f 1e fb          	endbr32 
80104d34:	55                   	push   %ebp
80104d35:	89 e5                	mov    %esp,%ebp
80104d37:	57                   	push   %edi
80104d38:	56                   	push   %esi
80104d39:	53                   	push   %ebx
80104d3a:	83 ec 0c             	sub    $0xc,%esp
80104d3d:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(sems[i].last)
80104d40:	69 f7 98 01 00 00    	imul   $0x198,%edi,%esi
80104d46:	8b 86 f4 3e 11 80    	mov    -0x7feec10c(%esi),%eax
80104d4c:	85 c0                	test   %eax,%eax
80104d4e:	75 48                	jne    80104d98 <sem_release+0x68>
  {
    struct proc* p = sems[i].list[--sems[i].last];
    sem_wakeup(p);
  }
  else
    sems[i].value++;
80104d50:	8b 86 60 3d 11 80    	mov    -0x7feec2a0(%esi),%eax
80104d56:	8d 58 01             	lea    0x1(%eax),%ebx
80104d59:	89 9e 60 3d 11 80    	mov    %ebx,-0x7feec2a0(%esi)
  pushcli();
80104d5f:	e8 3c 02 00 00       	call   80104fa0 <pushcli>
  c = mycpu();
80104d64:	e8 a7 ef ff ff       	call   80103d10 <mycpu>
  p = c->proc;
80104d69:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104d6f:	e8 7c 02 00 00       	call   80104ff0 <popcli>
  
  cprintf("philosopher %d released %d with value %d\n",  myproc()->pid-3 ,i, sems[i].value );
80104d74:	53                   	push   %ebx
80104d75:	57                   	push   %edi
80104d76:	8b 46 10             	mov    0x10(%esi),%eax
80104d79:	83 e8 03             	sub    $0x3,%eax
80104d7c:	50                   	push   %eax
80104d7d:	68 30 85 10 80       	push   $0x80108530
80104d82:	e8 29 b9 ff ff       	call   801006b0 <cprintf>
  return 0;
}
80104d87:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104d8a:	31 c0                	xor    %eax,%eax
80104d8c:	5b                   	pop    %ebx
80104d8d:	5e                   	pop    %esi
80104d8e:	5f                   	pop    %edi
80104d8f:	5d                   	pop    %ebp
80104d90:	c3                   	ret    
80104d91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct proc* p = sems[i].list[--sems[i].last];
80104d98:	6b d7 66             	imul   $0x66,%edi,%edx
  acquire(&ptable.lock);
80104d9b:	83 ec 0c             	sub    $0xc,%esp
    struct proc* p = sems[i].list[--sems[i].last];
80104d9e:	83 e8 01             	sub    $0x1,%eax
  acquire(&ptable.lock);
80104da1:	68 00 47 11 80       	push   $0x80114700
    struct proc* p = sems[i].list[--sems[i].last];
80104da6:	89 86 f4 3e 11 80    	mov    %eax,-0x7feec10c(%esi)
80104dac:	01 d0                	add    %edx,%eax
80104dae:	8b 1c 85 64 3d 11 80 	mov    -0x7feec29c(,%eax,4),%ebx
  acquire(&ptable.lock);
80104db5:	e8 e6 02 00 00       	call   801050a0 <acquire>
  p1->state = RUNNABLE;
80104dba:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80104dc1:	c7 04 24 00 47 11 80 	movl   $0x80114700,(%esp)
80104dc8:	e8 93 03 00 00       	call   80105160 <release>
80104dcd:	8b 9e 60 3d 11 80    	mov    -0x7feec2a0(%esi),%ebx
}
80104dd3:	83 c4 10             	add    $0x10,%esp
80104dd6:	eb 87                	jmp    80104d5f <sem_release+0x2f>
80104dd8:	66 90                	xchg   %ax,%ax
80104dda:	66 90                	xchg   %ax,%ax
80104ddc:	66 90                	xchg   %ax,%ax
80104dde:	66 90                	xchg   %ax,%ax

80104de0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104de0:	f3 0f 1e fb          	endbr32 
80104de4:	55                   	push   %ebp
80104de5:	89 e5                	mov    %esp,%ebp
80104de7:	53                   	push   %ebx
80104de8:	83 ec 0c             	sub    $0xc,%esp
80104deb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
80104dee:	68 8c 85 10 80       	push   $0x8010858c
80104df3:	8d 43 04             	lea    0x4(%ebx),%eax
80104df6:	50                   	push   %eax
80104df7:	e8 24 01 00 00       	call   80104f20 <initlock>
  lk->name = name;
80104dfc:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
80104dff:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104e05:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104e08:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
80104e0f:	89 43 38             	mov    %eax,0x38(%ebx)
}
80104e12:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104e15:	c9                   	leave  
80104e16:	c3                   	ret    
80104e17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e1e:	66 90                	xchg   %ax,%ax

80104e20 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104e20:	f3 0f 1e fb          	endbr32 
80104e24:	55                   	push   %ebp
80104e25:	89 e5                	mov    %esp,%ebp
80104e27:	56                   	push   %esi
80104e28:	53                   	push   %ebx
80104e29:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104e2c:	8d 73 04             	lea    0x4(%ebx),%esi
80104e2f:	83 ec 0c             	sub    $0xc,%esp
80104e32:	56                   	push   %esi
80104e33:	e8 68 02 00 00       	call   801050a0 <acquire>
  while (lk->locked) {
80104e38:	8b 13                	mov    (%ebx),%edx
80104e3a:	83 c4 10             	add    $0x10,%esp
80104e3d:	85 d2                	test   %edx,%edx
80104e3f:	74 1a                	je     80104e5b <acquiresleep+0x3b>
80104e41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(lk, &lk->lk);
80104e48:	83 ec 08             	sub    $0x8,%esp
80104e4b:	56                   	push   %esi
80104e4c:	53                   	push   %ebx
80104e4d:	e8 ce f9 ff ff       	call   80104820 <sleep>
  while (lk->locked) {
80104e52:	8b 03                	mov    (%ebx),%eax
80104e54:	83 c4 10             	add    $0x10,%esp
80104e57:	85 c0                	test   %eax,%eax
80104e59:	75 ed                	jne    80104e48 <acquiresleep+0x28>
  }
  lk->locked = 1;
80104e5b:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104e61:	e8 3a ef ff ff       	call   80103da0 <myproc>
80104e66:	8b 40 10             	mov    0x10(%eax),%eax
80104e69:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104e6c:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104e6f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104e72:	5b                   	pop    %ebx
80104e73:	5e                   	pop    %esi
80104e74:	5d                   	pop    %ebp
  release(&lk->lk);
80104e75:	e9 e6 02 00 00       	jmp    80105160 <release>
80104e7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104e80 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104e80:	f3 0f 1e fb          	endbr32 
80104e84:	55                   	push   %ebp
80104e85:	89 e5                	mov    %esp,%ebp
80104e87:	56                   	push   %esi
80104e88:	53                   	push   %ebx
80104e89:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104e8c:	8d 73 04             	lea    0x4(%ebx),%esi
80104e8f:	83 ec 0c             	sub    $0xc,%esp
80104e92:	56                   	push   %esi
80104e93:	e8 08 02 00 00       	call   801050a0 <acquire>
  lk->locked = 0;
80104e98:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80104e9e:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104ea5:	89 1c 24             	mov    %ebx,(%esp)
80104ea8:	e8 33 fb ff ff       	call   801049e0 <wakeup>
  release(&lk->lk);
80104ead:	89 75 08             	mov    %esi,0x8(%ebp)
80104eb0:	83 c4 10             	add    $0x10,%esp
}
80104eb3:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104eb6:	5b                   	pop    %ebx
80104eb7:	5e                   	pop    %esi
80104eb8:	5d                   	pop    %ebp
  release(&lk->lk);
80104eb9:	e9 a2 02 00 00       	jmp    80105160 <release>
80104ebe:	66 90                	xchg   %ax,%ax

80104ec0 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104ec0:	f3 0f 1e fb          	endbr32 
80104ec4:	55                   	push   %ebp
80104ec5:	89 e5                	mov    %esp,%ebp
80104ec7:	57                   	push   %edi
80104ec8:	31 ff                	xor    %edi,%edi
80104eca:	56                   	push   %esi
80104ecb:	53                   	push   %ebx
80104ecc:	83 ec 18             	sub    $0x18,%esp
80104ecf:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
80104ed2:	8d 73 04             	lea    0x4(%ebx),%esi
80104ed5:	56                   	push   %esi
80104ed6:	e8 c5 01 00 00       	call   801050a0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104edb:	8b 03                	mov    (%ebx),%eax
80104edd:	83 c4 10             	add    $0x10,%esp
80104ee0:	85 c0                	test   %eax,%eax
80104ee2:	75 1c                	jne    80104f00 <holdingsleep+0x40>
  release(&lk->lk);
80104ee4:	83 ec 0c             	sub    $0xc,%esp
80104ee7:	56                   	push   %esi
80104ee8:	e8 73 02 00 00       	call   80105160 <release>
  return r;
}
80104eed:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104ef0:	89 f8                	mov    %edi,%eax
80104ef2:	5b                   	pop    %ebx
80104ef3:	5e                   	pop    %esi
80104ef4:	5f                   	pop    %edi
80104ef5:	5d                   	pop    %ebp
80104ef6:	c3                   	ret    
80104ef7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104efe:	66 90                	xchg   %ax,%ax
  r = lk->locked && (lk->pid == myproc()->pid);
80104f00:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104f03:	e8 98 ee ff ff       	call   80103da0 <myproc>
80104f08:	39 58 10             	cmp    %ebx,0x10(%eax)
80104f0b:	0f 94 c0             	sete   %al
80104f0e:	0f b6 c0             	movzbl %al,%eax
80104f11:	89 c7                	mov    %eax,%edi
80104f13:	eb cf                	jmp    80104ee4 <holdingsleep+0x24>
80104f15:	66 90                	xchg   %ax,%ax
80104f17:	66 90                	xchg   %ax,%ax
80104f19:	66 90                	xchg   %ax,%ax
80104f1b:	66 90                	xchg   %ax,%ax
80104f1d:	66 90                	xchg   %ax,%ax
80104f1f:	90                   	nop

80104f20 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104f20:	f3 0f 1e fb          	endbr32 
80104f24:	55                   	push   %ebp
80104f25:	89 e5                	mov    %esp,%ebp
80104f27:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104f2a:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104f2d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
80104f33:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104f36:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104f3d:	5d                   	pop    %ebp
80104f3e:	c3                   	ret    
80104f3f:	90                   	nop

80104f40 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104f40:	f3 0f 1e fb          	endbr32 
80104f44:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104f45:	31 d2                	xor    %edx,%edx
{
80104f47:	89 e5                	mov    %esp,%ebp
80104f49:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104f4a:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104f4d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
80104f50:	83 e8 08             	sub    $0x8,%eax
  for(i = 0; i < 10; i++){
80104f53:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104f57:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104f58:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104f5e:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104f64:	77 1a                	ja     80104f80 <getcallerpcs+0x40>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104f66:	8b 58 04             	mov    0x4(%eax),%ebx
80104f69:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104f6c:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104f6f:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104f71:	83 fa 0a             	cmp    $0xa,%edx
80104f74:	75 e2                	jne    80104f58 <getcallerpcs+0x18>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
80104f76:	5b                   	pop    %ebx
80104f77:	5d                   	pop    %ebp
80104f78:	c3                   	ret    
80104f79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(; i < 10; i++)
80104f80:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80104f83:	8d 51 28             	lea    0x28(%ecx),%edx
80104f86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f8d:	8d 76 00             	lea    0x0(%esi),%esi
    pcs[i] = 0;
80104f90:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104f96:	83 c0 04             	add    $0x4,%eax
80104f99:	39 d0                	cmp    %edx,%eax
80104f9b:	75 f3                	jne    80104f90 <getcallerpcs+0x50>
}
80104f9d:	5b                   	pop    %ebx
80104f9e:	5d                   	pop    %ebp
80104f9f:	c3                   	ret    

80104fa0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104fa0:	f3 0f 1e fb          	endbr32 
80104fa4:	55                   	push   %ebp
80104fa5:	89 e5                	mov    %esp,%ebp
80104fa7:	53                   	push   %ebx
80104fa8:	83 ec 04             	sub    $0x4,%esp
80104fab:	9c                   	pushf  
80104fac:	5b                   	pop    %ebx
  asm volatile("cli");
80104fad:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
80104fae:	e8 5d ed ff ff       	call   80103d10 <mycpu>
80104fb3:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104fb9:	85 c0                	test   %eax,%eax
80104fbb:	74 13                	je     80104fd0 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
80104fbd:	e8 4e ed ff ff       	call   80103d10 <mycpu>
80104fc2:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104fc9:	83 c4 04             	add    $0x4,%esp
80104fcc:	5b                   	pop    %ebx
80104fcd:	5d                   	pop    %ebp
80104fce:	c3                   	ret    
80104fcf:	90                   	nop
    mycpu()->intena = eflags & FL_IF;
80104fd0:	e8 3b ed ff ff       	call   80103d10 <mycpu>
80104fd5:	81 e3 00 02 00 00    	and    $0x200,%ebx
80104fdb:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80104fe1:	eb da                	jmp    80104fbd <pushcli+0x1d>
80104fe3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104fea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104ff0 <popcli>:

void
popcli(void)
{
80104ff0:	f3 0f 1e fb          	endbr32 
80104ff4:	55                   	push   %ebp
80104ff5:	89 e5                	mov    %esp,%ebp
80104ff7:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104ffa:	9c                   	pushf  
80104ffb:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104ffc:	f6 c4 02             	test   $0x2,%ah
80104fff:	75 31                	jne    80105032 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
80105001:	e8 0a ed ff ff       	call   80103d10 <mycpu>
80105006:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
8010500d:	78 30                	js     8010503f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
8010500f:	e8 fc ec ff ff       	call   80103d10 <mycpu>
80105014:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
8010501a:	85 d2                	test   %edx,%edx
8010501c:	74 02                	je     80105020 <popcli+0x30>
    sti();
}
8010501e:	c9                   	leave  
8010501f:	c3                   	ret    
  if(mycpu()->ncli == 0 && mycpu()->intena)
80105020:	e8 eb ec ff ff       	call   80103d10 <mycpu>
80105025:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010502b:	85 c0                	test   %eax,%eax
8010502d:	74 ef                	je     8010501e <popcli+0x2e>
  asm volatile("sti");
8010502f:	fb                   	sti    
}
80105030:	c9                   	leave  
80105031:	c3                   	ret    
    panic("popcli - interruptible");
80105032:	83 ec 0c             	sub    $0xc,%esp
80105035:	68 97 85 10 80       	push   $0x80108597
8010503a:	e8 51 b3 ff ff       	call   80100390 <panic>
    panic("popcli");
8010503f:	83 ec 0c             	sub    $0xc,%esp
80105042:	68 ae 85 10 80       	push   $0x801085ae
80105047:	e8 44 b3 ff ff       	call   80100390 <panic>
8010504c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105050 <holding>:
{
80105050:	f3 0f 1e fb          	endbr32 
80105054:	55                   	push   %ebp
80105055:	89 e5                	mov    %esp,%ebp
80105057:	56                   	push   %esi
80105058:	53                   	push   %ebx
80105059:	8b 75 08             	mov    0x8(%ebp),%esi
8010505c:	31 db                	xor    %ebx,%ebx
  pushcli();
8010505e:	e8 3d ff ff ff       	call   80104fa0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80105063:	8b 06                	mov    (%esi),%eax
80105065:	85 c0                	test   %eax,%eax
80105067:	75 0f                	jne    80105078 <holding+0x28>
  popcli();
80105069:	e8 82 ff ff ff       	call   80104ff0 <popcli>
}
8010506e:	89 d8                	mov    %ebx,%eax
80105070:	5b                   	pop    %ebx
80105071:	5e                   	pop    %esi
80105072:	5d                   	pop    %ebp
80105073:	c3                   	ret    
80105074:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  r = lock->locked && lock->cpu == mycpu();
80105078:	8b 5e 08             	mov    0x8(%esi),%ebx
8010507b:	e8 90 ec ff ff       	call   80103d10 <mycpu>
80105080:	39 c3                	cmp    %eax,%ebx
80105082:	0f 94 c3             	sete   %bl
  popcli();
80105085:	e8 66 ff ff ff       	call   80104ff0 <popcli>
  r = lock->locked && lock->cpu == mycpu();
8010508a:	0f b6 db             	movzbl %bl,%ebx
}
8010508d:	89 d8                	mov    %ebx,%eax
8010508f:	5b                   	pop    %ebx
80105090:	5e                   	pop    %esi
80105091:	5d                   	pop    %ebp
80105092:	c3                   	ret    
80105093:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010509a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801050a0 <acquire>:
{
801050a0:	f3 0f 1e fb          	endbr32 
801050a4:	55                   	push   %ebp
801050a5:	89 e5                	mov    %esp,%ebp
801050a7:	56                   	push   %esi
801050a8:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
801050a9:	e8 f2 fe ff ff       	call   80104fa0 <pushcli>
  if(holding(lk))
801050ae:	8b 5d 08             	mov    0x8(%ebp),%ebx
801050b1:	83 ec 0c             	sub    $0xc,%esp
801050b4:	53                   	push   %ebx
801050b5:	e8 96 ff ff ff       	call   80105050 <holding>
801050ba:	83 c4 10             	add    $0x10,%esp
801050bd:	85 c0                	test   %eax,%eax
801050bf:	0f 85 7f 00 00 00    	jne    80105144 <acquire+0xa4>
801050c5:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
801050c7:	ba 01 00 00 00       	mov    $0x1,%edx
801050cc:	eb 05                	jmp    801050d3 <acquire+0x33>
801050ce:	66 90                	xchg   %ax,%ax
801050d0:	8b 5d 08             	mov    0x8(%ebp),%ebx
801050d3:	89 d0                	mov    %edx,%eax
801050d5:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
801050d8:	85 c0                	test   %eax,%eax
801050da:	75 f4                	jne    801050d0 <acquire+0x30>
  __sync_synchronize();
801050dc:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
801050e1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801050e4:	e8 27 ec ff ff       	call   80103d10 <mycpu>
801050e9:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
801050ec:	89 e8                	mov    %ebp,%eax
801050ee:	66 90                	xchg   %ax,%ax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801050f0:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
801050f6:	81 fa fe ff ff 7f    	cmp    $0x7ffffffe,%edx
801050fc:	77 22                	ja     80105120 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
801050fe:	8b 50 04             	mov    0x4(%eax),%edx
80105101:	89 54 b3 0c          	mov    %edx,0xc(%ebx,%esi,4)
  for(i = 0; i < 10; i++){
80105105:	83 c6 01             	add    $0x1,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
80105108:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
8010510a:	83 fe 0a             	cmp    $0xa,%esi
8010510d:	75 e1                	jne    801050f0 <acquire+0x50>
}
8010510f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105112:	5b                   	pop    %ebx
80105113:	5e                   	pop    %esi
80105114:	5d                   	pop    %ebp
80105115:	c3                   	ret    
80105116:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010511d:	8d 76 00             	lea    0x0(%esi),%esi
  for(; i < 10; i++)
80105120:	8d 44 b3 0c          	lea    0xc(%ebx,%esi,4),%eax
80105124:	83 c3 34             	add    $0x34,%ebx
80105127:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010512e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80105130:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80105136:	83 c0 04             	add    $0x4,%eax
80105139:	39 d8                	cmp    %ebx,%eax
8010513b:	75 f3                	jne    80105130 <acquire+0x90>
}
8010513d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105140:	5b                   	pop    %ebx
80105141:	5e                   	pop    %esi
80105142:	5d                   	pop    %ebp
80105143:	c3                   	ret    
    panic("acquire");
80105144:	83 ec 0c             	sub    $0xc,%esp
80105147:	68 b5 85 10 80       	push   $0x801085b5
8010514c:	e8 3f b2 ff ff       	call   80100390 <panic>
80105151:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105158:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010515f:	90                   	nop

80105160 <release>:
{
80105160:	f3 0f 1e fb          	endbr32 
80105164:	55                   	push   %ebp
80105165:	89 e5                	mov    %esp,%ebp
80105167:	53                   	push   %ebx
80105168:	83 ec 10             	sub    $0x10,%esp
8010516b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
8010516e:	53                   	push   %ebx
8010516f:	e8 dc fe ff ff       	call   80105050 <holding>
80105174:	83 c4 10             	add    $0x10,%esp
80105177:	85 c0                	test   %eax,%eax
80105179:	74 22                	je     8010519d <release+0x3d>
  lk->pcs[0] = 0;
8010517b:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80105182:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80105189:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010518e:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80105194:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105197:	c9                   	leave  
  popcli();
80105198:	e9 53 fe ff ff       	jmp    80104ff0 <popcli>
    panic("release");
8010519d:	83 ec 0c             	sub    $0xc,%esp
801051a0:	68 bd 85 10 80       	push   $0x801085bd
801051a5:	e8 e6 b1 ff ff       	call   80100390 <panic>
801051aa:	66 90                	xchg   %ax,%ax
801051ac:	66 90                	xchg   %ax,%ax
801051ae:	66 90                	xchg   %ax,%ax

801051b0 <memset>:
801051b0:	f3 0f 1e fb          	endbr32 
801051b4:	55                   	push   %ebp
801051b5:	89 e5                	mov    %esp,%ebp
801051b7:	57                   	push   %edi
801051b8:	8b 55 08             	mov    0x8(%ebp),%edx
801051bb:	8b 4d 10             	mov    0x10(%ebp),%ecx
801051be:	53                   	push   %ebx
801051bf:	8b 45 0c             	mov    0xc(%ebp),%eax
801051c2:	89 d7                	mov    %edx,%edi
801051c4:	09 cf                	or     %ecx,%edi
801051c6:	83 e7 03             	and    $0x3,%edi
801051c9:	75 25                	jne    801051f0 <memset+0x40>
801051cb:	0f b6 f8             	movzbl %al,%edi
801051ce:	c1 e0 18             	shl    $0x18,%eax
801051d1:	89 fb                	mov    %edi,%ebx
801051d3:	c1 e9 02             	shr    $0x2,%ecx
801051d6:	c1 e3 10             	shl    $0x10,%ebx
801051d9:	09 d8                	or     %ebx,%eax
801051db:	09 f8                	or     %edi,%eax
801051dd:	c1 e7 08             	shl    $0x8,%edi
801051e0:	09 f8                	or     %edi,%eax
801051e2:	89 d7                	mov    %edx,%edi
801051e4:	fc                   	cld    
801051e5:	f3 ab                	rep stos %eax,%es:(%edi)
801051e7:	5b                   	pop    %ebx
801051e8:	89 d0                	mov    %edx,%eax
801051ea:	5f                   	pop    %edi
801051eb:	5d                   	pop    %ebp
801051ec:	c3                   	ret    
801051ed:	8d 76 00             	lea    0x0(%esi),%esi
801051f0:	89 d7                	mov    %edx,%edi
801051f2:	fc                   	cld    
801051f3:	f3 aa                	rep stos %al,%es:(%edi)
801051f5:	5b                   	pop    %ebx
801051f6:	89 d0                	mov    %edx,%eax
801051f8:	5f                   	pop    %edi
801051f9:	5d                   	pop    %ebp
801051fa:	c3                   	ret    
801051fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801051ff:	90                   	nop

80105200 <memcmp>:
80105200:	f3 0f 1e fb          	endbr32 
80105204:	55                   	push   %ebp
80105205:	89 e5                	mov    %esp,%ebp
80105207:	56                   	push   %esi
80105208:	8b 75 10             	mov    0x10(%ebp),%esi
8010520b:	8b 55 08             	mov    0x8(%ebp),%edx
8010520e:	53                   	push   %ebx
8010520f:	8b 45 0c             	mov    0xc(%ebp),%eax
80105212:	85 f6                	test   %esi,%esi
80105214:	74 2a                	je     80105240 <memcmp+0x40>
80105216:	01 c6                	add    %eax,%esi
80105218:	eb 10                	jmp    8010522a <memcmp+0x2a>
8010521a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105220:	83 c0 01             	add    $0x1,%eax
80105223:	83 c2 01             	add    $0x1,%edx
80105226:	39 f0                	cmp    %esi,%eax
80105228:	74 16                	je     80105240 <memcmp+0x40>
8010522a:	0f b6 0a             	movzbl (%edx),%ecx
8010522d:	0f b6 18             	movzbl (%eax),%ebx
80105230:	38 d9                	cmp    %bl,%cl
80105232:	74 ec                	je     80105220 <memcmp+0x20>
80105234:	0f b6 c1             	movzbl %cl,%eax
80105237:	29 d8                	sub    %ebx,%eax
80105239:	5b                   	pop    %ebx
8010523a:	5e                   	pop    %esi
8010523b:	5d                   	pop    %ebp
8010523c:	c3                   	ret    
8010523d:	8d 76 00             	lea    0x0(%esi),%esi
80105240:	5b                   	pop    %ebx
80105241:	31 c0                	xor    %eax,%eax
80105243:	5e                   	pop    %esi
80105244:	5d                   	pop    %ebp
80105245:	c3                   	ret    
80105246:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010524d:	8d 76 00             	lea    0x0(%esi),%esi

80105250 <memmove>:
80105250:	f3 0f 1e fb          	endbr32 
80105254:	55                   	push   %ebp
80105255:	89 e5                	mov    %esp,%ebp
80105257:	57                   	push   %edi
80105258:	8b 55 08             	mov    0x8(%ebp),%edx
8010525b:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010525e:	56                   	push   %esi
8010525f:	8b 75 0c             	mov    0xc(%ebp),%esi
80105262:	39 d6                	cmp    %edx,%esi
80105264:	73 2a                	jae    80105290 <memmove+0x40>
80105266:	8d 3c 0e             	lea    (%esi,%ecx,1),%edi
80105269:	39 fa                	cmp    %edi,%edx
8010526b:	73 23                	jae    80105290 <memmove+0x40>
8010526d:	8d 41 ff             	lea    -0x1(%ecx),%eax
80105270:	85 c9                	test   %ecx,%ecx
80105272:	74 13                	je     80105287 <memmove+0x37>
80105274:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105278:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
8010527c:	88 0c 02             	mov    %cl,(%edx,%eax,1)
8010527f:	83 e8 01             	sub    $0x1,%eax
80105282:	83 f8 ff             	cmp    $0xffffffff,%eax
80105285:	75 f1                	jne    80105278 <memmove+0x28>
80105287:	5e                   	pop    %esi
80105288:	89 d0                	mov    %edx,%eax
8010528a:	5f                   	pop    %edi
8010528b:	5d                   	pop    %ebp
8010528c:	c3                   	ret    
8010528d:	8d 76 00             	lea    0x0(%esi),%esi
80105290:	8d 04 0e             	lea    (%esi,%ecx,1),%eax
80105293:	89 d7                	mov    %edx,%edi
80105295:	85 c9                	test   %ecx,%ecx
80105297:	74 ee                	je     80105287 <memmove+0x37>
80105299:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801052a0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
801052a1:	39 f0                	cmp    %esi,%eax
801052a3:	75 fb                	jne    801052a0 <memmove+0x50>
801052a5:	5e                   	pop    %esi
801052a6:	89 d0                	mov    %edx,%eax
801052a8:	5f                   	pop    %edi
801052a9:	5d                   	pop    %ebp
801052aa:	c3                   	ret    
801052ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801052af:	90                   	nop

801052b0 <memcpy>:
801052b0:	f3 0f 1e fb          	endbr32 
801052b4:	eb 9a                	jmp    80105250 <memmove>
801052b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801052bd:	8d 76 00             	lea    0x0(%esi),%esi

801052c0 <strncmp>:
801052c0:	f3 0f 1e fb          	endbr32 
801052c4:	55                   	push   %ebp
801052c5:	89 e5                	mov    %esp,%ebp
801052c7:	56                   	push   %esi
801052c8:	8b 75 10             	mov    0x10(%ebp),%esi
801052cb:	8b 4d 08             	mov    0x8(%ebp),%ecx
801052ce:	53                   	push   %ebx
801052cf:	8b 45 0c             	mov    0xc(%ebp),%eax
801052d2:	85 f6                	test   %esi,%esi
801052d4:	74 32                	je     80105308 <strncmp+0x48>
801052d6:	01 c6                	add    %eax,%esi
801052d8:	eb 14                	jmp    801052ee <strncmp+0x2e>
801052da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801052e0:	38 da                	cmp    %bl,%dl
801052e2:	75 14                	jne    801052f8 <strncmp+0x38>
801052e4:	83 c0 01             	add    $0x1,%eax
801052e7:	83 c1 01             	add    $0x1,%ecx
801052ea:	39 f0                	cmp    %esi,%eax
801052ec:	74 1a                	je     80105308 <strncmp+0x48>
801052ee:	0f b6 11             	movzbl (%ecx),%edx
801052f1:	0f b6 18             	movzbl (%eax),%ebx
801052f4:	84 d2                	test   %dl,%dl
801052f6:	75 e8                	jne    801052e0 <strncmp+0x20>
801052f8:	0f b6 c2             	movzbl %dl,%eax
801052fb:	29 d8                	sub    %ebx,%eax
801052fd:	5b                   	pop    %ebx
801052fe:	5e                   	pop    %esi
801052ff:	5d                   	pop    %ebp
80105300:	c3                   	ret    
80105301:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105308:	5b                   	pop    %ebx
80105309:	31 c0                	xor    %eax,%eax
8010530b:	5e                   	pop    %esi
8010530c:	5d                   	pop    %ebp
8010530d:	c3                   	ret    
8010530e:	66 90                	xchg   %ax,%ax

80105310 <strncpy>:
80105310:	f3 0f 1e fb          	endbr32 
80105314:	55                   	push   %ebp
80105315:	89 e5                	mov    %esp,%ebp
80105317:	57                   	push   %edi
80105318:	56                   	push   %esi
80105319:	8b 75 08             	mov    0x8(%ebp),%esi
8010531c:	53                   	push   %ebx
8010531d:	8b 45 10             	mov    0x10(%ebp),%eax
80105320:	89 f2                	mov    %esi,%edx
80105322:	eb 1b                	jmp    8010533f <strncpy+0x2f>
80105324:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105328:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
8010532c:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010532f:	83 c2 01             	add    $0x1,%edx
80105332:	0f b6 7f ff          	movzbl -0x1(%edi),%edi
80105336:	89 f9                	mov    %edi,%ecx
80105338:	88 4a ff             	mov    %cl,-0x1(%edx)
8010533b:	84 c9                	test   %cl,%cl
8010533d:	74 09                	je     80105348 <strncpy+0x38>
8010533f:	89 c3                	mov    %eax,%ebx
80105341:	83 e8 01             	sub    $0x1,%eax
80105344:	85 db                	test   %ebx,%ebx
80105346:	7f e0                	jg     80105328 <strncpy+0x18>
80105348:	89 d1                	mov    %edx,%ecx
8010534a:	85 c0                	test   %eax,%eax
8010534c:	7e 15                	jle    80105363 <strncpy+0x53>
8010534e:	66 90                	xchg   %ax,%ax
80105350:	83 c1 01             	add    $0x1,%ecx
80105353:	c6 41 ff 00          	movb   $0x0,-0x1(%ecx)
80105357:	89 c8                	mov    %ecx,%eax
80105359:	f7 d0                	not    %eax
8010535b:	01 d0                	add    %edx,%eax
8010535d:	01 d8                	add    %ebx,%eax
8010535f:	85 c0                	test   %eax,%eax
80105361:	7f ed                	jg     80105350 <strncpy+0x40>
80105363:	5b                   	pop    %ebx
80105364:	89 f0                	mov    %esi,%eax
80105366:	5e                   	pop    %esi
80105367:	5f                   	pop    %edi
80105368:	5d                   	pop    %ebp
80105369:	c3                   	ret    
8010536a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105370 <safestrcpy>:
80105370:	f3 0f 1e fb          	endbr32 
80105374:	55                   	push   %ebp
80105375:	89 e5                	mov    %esp,%ebp
80105377:	56                   	push   %esi
80105378:	8b 55 10             	mov    0x10(%ebp),%edx
8010537b:	8b 75 08             	mov    0x8(%ebp),%esi
8010537e:	53                   	push   %ebx
8010537f:	8b 45 0c             	mov    0xc(%ebp),%eax
80105382:	85 d2                	test   %edx,%edx
80105384:	7e 21                	jle    801053a7 <safestrcpy+0x37>
80105386:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
8010538a:	89 f2                	mov    %esi,%edx
8010538c:	eb 12                	jmp    801053a0 <safestrcpy+0x30>
8010538e:	66 90                	xchg   %ax,%ax
80105390:	0f b6 08             	movzbl (%eax),%ecx
80105393:	83 c0 01             	add    $0x1,%eax
80105396:	83 c2 01             	add    $0x1,%edx
80105399:	88 4a ff             	mov    %cl,-0x1(%edx)
8010539c:	84 c9                	test   %cl,%cl
8010539e:	74 04                	je     801053a4 <safestrcpy+0x34>
801053a0:	39 d8                	cmp    %ebx,%eax
801053a2:	75 ec                	jne    80105390 <safestrcpy+0x20>
801053a4:	c6 02 00             	movb   $0x0,(%edx)
801053a7:	89 f0                	mov    %esi,%eax
801053a9:	5b                   	pop    %ebx
801053aa:	5e                   	pop    %esi
801053ab:	5d                   	pop    %ebp
801053ac:	c3                   	ret    
801053ad:	8d 76 00             	lea    0x0(%esi),%esi

801053b0 <strlen>:
801053b0:	f3 0f 1e fb          	endbr32 
801053b4:	55                   	push   %ebp
801053b5:	31 c0                	xor    %eax,%eax
801053b7:	89 e5                	mov    %esp,%ebp
801053b9:	8b 55 08             	mov    0x8(%ebp),%edx
801053bc:	80 3a 00             	cmpb   $0x0,(%edx)
801053bf:	74 10                	je     801053d1 <strlen+0x21>
801053c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801053c8:	83 c0 01             	add    $0x1,%eax
801053cb:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
801053cf:	75 f7                	jne    801053c8 <strlen+0x18>
801053d1:	5d                   	pop    %ebp
801053d2:	c3                   	ret    

801053d3 <swtch>:
801053d3:	8b 44 24 04          	mov    0x4(%esp),%eax
801053d7:	8b 54 24 08          	mov    0x8(%esp),%edx
801053db:	55                   	push   %ebp
801053dc:	53                   	push   %ebx
801053dd:	56                   	push   %esi
801053de:	57                   	push   %edi
801053df:	89 20                	mov    %esp,(%eax)
801053e1:	89 d4                	mov    %edx,%esp
801053e3:	5f                   	pop    %edi
801053e4:	5e                   	pop    %esi
801053e5:	5b                   	pop    %ebx
801053e6:	5d                   	pop    %ebp
801053e7:	c3                   	ret    
801053e8:	66 90                	xchg   %ax,%ax
801053ea:	66 90                	xchg   %ax,%ax
801053ec:	66 90                	xchg   %ax,%ax
801053ee:	66 90                	xchg   %ax,%ax

801053f0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
801053f0:	f3 0f 1e fb          	endbr32 
801053f4:	55                   	push   %ebp
801053f5:	89 e5                	mov    %esp,%ebp
801053f7:	53                   	push   %ebx
801053f8:	83 ec 04             	sub    $0x4,%esp
801053fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
801053fe:	e8 9d e9 ff ff       	call   80103da0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105403:	8b 00                	mov    (%eax),%eax
80105405:	39 d8                	cmp    %ebx,%eax
80105407:	76 17                	jbe    80105420 <fetchint+0x30>
80105409:	8d 53 04             	lea    0x4(%ebx),%edx
8010540c:	39 d0                	cmp    %edx,%eax
8010540e:	72 10                	jb     80105420 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80105410:	8b 45 0c             	mov    0xc(%ebp),%eax
80105413:	8b 13                	mov    (%ebx),%edx
80105415:	89 10                	mov    %edx,(%eax)
  return 0;
80105417:	31 c0                	xor    %eax,%eax
}
80105419:	83 c4 04             	add    $0x4,%esp
8010541c:	5b                   	pop    %ebx
8010541d:	5d                   	pop    %ebp
8010541e:	c3                   	ret    
8010541f:	90                   	nop
    return -1;
80105420:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105425:	eb f2                	jmp    80105419 <fetchint+0x29>
80105427:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010542e:	66 90                	xchg   %ax,%ax

80105430 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80105430:	f3 0f 1e fb          	endbr32 
80105434:	55                   	push   %ebp
80105435:	89 e5                	mov    %esp,%ebp
80105437:	53                   	push   %ebx
80105438:	83 ec 04             	sub    $0x4,%esp
8010543b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010543e:	e8 5d e9 ff ff       	call   80103da0 <myproc>

  if(addr >= curproc->sz)
80105443:	39 18                	cmp    %ebx,(%eax)
80105445:	76 31                	jbe    80105478 <fetchstr+0x48>
    return -1;
  *pp = (char*)addr;
80105447:	8b 55 0c             	mov    0xc(%ebp),%edx
8010544a:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
8010544c:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
8010544e:	39 d3                	cmp    %edx,%ebx
80105450:	73 26                	jae    80105478 <fetchstr+0x48>
80105452:	89 d8                	mov    %ebx,%eax
80105454:	eb 11                	jmp    80105467 <fetchstr+0x37>
80105456:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010545d:	8d 76 00             	lea    0x0(%esi),%esi
80105460:	83 c0 01             	add    $0x1,%eax
80105463:	39 c2                	cmp    %eax,%edx
80105465:	76 11                	jbe    80105478 <fetchstr+0x48>
    if(*s == 0)
80105467:	80 38 00             	cmpb   $0x0,(%eax)
8010546a:	75 f4                	jne    80105460 <fetchstr+0x30>
      return s - *pp;
  }
  return -1;
}
8010546c:	83 c4 04             	add    $0x4,%esp
      return s - *pp;
8010546f:	29 d8                	sub    %ebx,%eax
}
80105471:	5b                   	pop    %ebx
80105472:	5d                   	pop    %ebp
80105473:	c3                   	ret    
80105474:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105478:	83 c4 04             	add    $0x4,%esp
    return -1;
8010547b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105480:	5b                   	pop    %ebx
80105481:	5d                   	pop    %ebp
80105482:	c3                   	ret    
80105483:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010548a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105490 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80105490:	f3 0f 1e fb          	endbr32 
80105494:	55                   	push   %ebp
80105495:	89 e5                	mov    %esp,%ebp
80105497:	56                   	push   %esi
80105498:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105499:	e8 02 e9 ff ff       	call   80103da0 <myproc>
8010549e:	8b 55 08             	mov    0x8(%ebp),%edx
801054a1:	8b 40 18             	mov    0x18(%eax),%eax
801054a4:	8b 40 44             	mov    0x44(%eax),%eax
801054a7:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
801054aa:	e8 f1 e8 ff ff       	call   80103da0 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801054af:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
801054b2:	8b 00                	mov    (%eax),%eax
801054b4:	39 c6                	cmp    %eax,%esi
801054b6:	73 18                	jae    801054d0 <argint+0x40>
801054b8:	8d 53 08             	lea    0x8(%ebx),%edx
801054bb:	39 d0                	cmp    %edx,%eax
801054bd:	72 11                	jb     801054d0 <argint+0x40>
  *ip = *(int*)(addr);
801054bf:	8b 45 0c             	mov    0xc(%ebp),%eax
801054c2:	8b 53 04             	mov    0x4(%ebx),%edx
801054c5:	89 10                	mov    %edx,(%eax)
  return 0;
801054c7:	31 c0                	xor    %eax,%eax
}
801054c9:	5b                   	pop    %ebx
801054ca:	5e                   	pop    %esi
801054cb:	5d                   	pop    %ebp
801054cc:	c3                   	ret    
801054cd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801054d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801054d5:	eb f2                	jmp    801054c9 <argint+0x39>
801054d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801054de:	66 90                	xchg   %ax,%ax

801054e0 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
801054e0:	f3 0f 1e fb          	endbr32 
801054e4:	55                   	push   %ebp
801054e5:	89 e5                	mov    %esp,%ebp
801054e7:	56                   	push   %esi
801054e8:	53                   	push   %ebx
801054e9:	83 ec 10             	sub    $0x10,%esp
801054ec:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
801054ef:	e8 ac e8 ff ff       	call   80103da0 <myproc>
 
  if(argint(n, &i) < 0)
801054f4:	83 ec 08             	sub    $0x8,%esp
  struct proc *curproc = myproc();
801054f7:	89 c6                	mov    %eax,%esi
  if(argint(n, &i) < 0)
801054f9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801054fc:	50                   	push   %eax
801054fd:	ff 75 08             	pushl  0x8(%ebp)
80105500:	e8 8b ff ff ff       	call   80105490 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80105505:	83 c4 10             	add    $0x10,%esp
80105508:	85 c0                	test   %eax,%eax
8010550a:	78 24                	js     80105530 <argptr+0x50>
8010550c:	85 db                	test   %ebx,%ebx
8010550e:	78 20                	js     80105530 <argptr+0x50>
80105510:	8b 16                	mov    (%esi),%edx
80105512:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105515:	39 c2                	cmp    %eax,%edx
80105517:	76 17                	jbe    80105530 <argptr+0x50>
80105519:	01 c3                	add    %eax,%ebx
8010551b:	39 da                	cmp    %ebx,%edx
8010551d:	72 11                	jb     80105530 <argptr+0x50>
    return -1;
  *pp = (char*)i;
8010551f:	8b 55 0c             	mov    0xc(%ebp),%edx
80105522:	89 02                	mov    %eax,(%edx)
  return 0;
80105524:	31 c0                	xor    %eax,%eax
}
80105526:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105529:	5b                   	pop    %ebx
8010552a:	5e                   	pop    %esi
8010552b:	5d                   	pop    %ebp
8010552c:	c3                   	ret    
8010552d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105530:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105535:	eb ef                	jmp    80105526 <argptr+0x46>
80105537:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010553e:	66 90                	xchg   %ax,%ax

80105540 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105540:	f3 0f 1e fb          	endbr32 
80105544:	55                   	push   %ebp
80105545:	89 e5                	mov    %esp,%ebp
80105547:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
8010554a:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010554d:	50                   	push   %eax
8010554e:	ff 75 08             	pushl  0x8(%ebp)
80105551:	e8 3a ff ff ff       	call   80105490 <argint>
80105556:	83 c4 10             	add    $0x10,%esp
80105559:	85 c0                	test   %eax,%eax
8010555b:	78 13                	js     80105570 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
8010555d:	83 ec 08             	sub    $0x8,%esp
80105560:	ff 75 0c             	pushl  0xc(%ebp)
80105563:	ff 75 f4             	pushl  -0xc(%ebp)
80105566:	e8 c5 fe ff ff       	call   80105430 <fetchstr>
8010556b:	83 c4 10             	add    $0x10,%esp
}
8010556e:	c9                   	leave  
8010556f:	c3                   	ret    
80105570:	c9                   	leave  
    return -1;
80105571:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105576:	c3                   	ret    
80105577:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010557e:	66 90                	xchg   %ax,%ax

80105580 <syscall>:
[SYS_sem_init] sys_sem_init,
};

void
syscall(void)
{
80105580:	f3 0f 1e fb          	endbr32 
80105584:	55                   	push   %ebp
80105585:	89 e5                	mov    %esp,%ebp
80105587:	53                   	push   %ebx
80105588:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
8010558b:	e8 10 e8 ff ff       	call   80103da0 <myproc>
80105590:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80105592:	8b 40 18             	mov    0x18(%eax),%eax
80105595:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80105598:	8d 50 ff             	lea    -0x1(%eax),%edx
8010559b:	83 fa 1b             	cmp    $0x1b,%edx
8010559e:	77 20                	ja     801055c0 <syscall+0x40>
801055a0:	8b 14 85 00 86 10 80 	mov    -0x7fef7a00(,%eax,4),%edx
801055a7:	85 d2                	test   %edx,%edx
801055a9:	74 15                	je     801055c0 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
801055ab:	ff d2                	call   *%edx
801055ad:	89 c2                	mov    %eax,%edx
801055af:	8b 43 18             	mov    0x18(%ebx),%eax
801055b2:	89 50 1c             	mov    %edx,0x1c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
801055b5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801055b8:	c9                   	leave  
801055b9:	c3                   	ret    
801055ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cprintf("%d %s: unknown sys call %d\n",
801055c0:	50                   	push   %eax
            curproc->pid, curproc->name, num);
801055c1:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
801055c4:	50                   	push   %eax
801055c5:	ff 73 10             	pushl  0x10(%ebx)
801055c8:	68 c5 85 10 80       	push   $0x801085c5
801055cd:	e8 de b0 ff ff       	call   801006b0 <cprintf>
    curproc->tf->eax = -1;
801055d2:	8b 43 18             	mov    0x18(%ebx),%eax
801055d5:	83 c4 10             	add    $0x10,%esp
801055d8:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
801055df:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801055e2:	c9                   	leave  
801055e3:	c3                   	ret    
801055e4:	66 90                	xchg   %ax,%ax
801055e6:	66 90                	xchg   %ax,%ax
801055e8:	66 90                	xchg   %ax,%ax
801055ea:	66 90                	xchg   %ax,%ax
801055ec:	66 90                	xchg   %ax,%ax
801055ee:	66 90                	xchg   %ax,%ax

801055f0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
801055f0:	55                   	push   %ebp
801055f1:	89 e5                	mov    %esp,%ebp
801055f3:	57                   	push   %edi
801055f4:	56                   	push   %esi
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
801055f5:	8d 7d da             	lea    -0x26(%ebp),%edi
{
801055f8:	53                   	push   %ebx
801055f9:	83 ec 34             	sub    $0x34,%esp
801055fc:	89 4d d0             	mov    %ecx,-0x30(%ebp)
801055ff:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80105602:	57                   	push   %edi
80105603:	50                   	push   %eax
{
80105604:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80105607:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
8010560a:	e8 21 ce ff ff       	call   80102430 <nameiparent>
8010560f:	83 c4 10             	add    $0x10,%esp
80105612:	85 c0                	test   %eax,%eax
80105614:	0f 84 46 01 00 00    	je     80105760 <create+0x170>
    return 0;
  ilock(dp);
8010561a:	83 ec 0c             	sub    $0xc,%esp
8010561d:	89 c3                	mov    %eax,%ebx
8010561f:	50                   	push   %eax
80105620:	e8 1b c5 ff ff       	call   80101b40 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80105625:	83 c4 0c             	add    $0xc,%esp
80105628:	6a 00                	push   $0x0
8010562a:	57                   	push   %edi
8010562b:	53                   	push   %ebx
8010562c:	e8 5f ca ff ff       	call   80102090 <dirlookup>
80105631:	83 c4 10             	add    $0x10,%esp
80105634:	89 c6                	mov    %eax,%esi
80105636:	85 c0                	test   %eax,%eax
80105638:	74 56                	je     80105690 <create+0xa0>
    iunlockput(dp);
8010563a:	83 ec 0c             	sub    $0xc,%esp
8010563d:	53                   	push   %ebx
8010563e:	e8 9d c7 ff ff       	call   80101de0 <iunlockput>
    ilock(ip);
80105643:	89 34 24             	mov    %esi,(%esp)
80105646:	e8 f5 c4 ff ff       	call   80101b40 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
8010564b:	83 c4 10             	add    $0x10,%esp
8010564e:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80105653:	75 1b                	jne    80105670 <create+0x80>
80105655:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
8010565a:	75 14                	jne    80105670 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
8010565c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010565f:	89 f0                	mov    %esi,%eax
80105661:	5b                   	pop    %ebx
80105662:	5e                   	pop    %esi
80105663:	5f                   	pop    %edi
80105664:	5d                   	pop    %ebp
80105665:	c3                   	ret    
80105666:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010566d:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
80105670:	83 ec 0c             	sub    $0xc,%esp
80105673:	56                   	push   %esi
    return 0;
80105674:	31 f6                	xor    %esi,%esi
    iunlockput(ip);
80105676:	e8 65 c7 ff ff       	call   80101de0 <iunlockput>
    return 0;
8010567b:	83 c4 10             	add    $0x10,%esp
}
8010567e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105681:	89 f0                	mov    %esi,%eax
80105683:	5b                   	pop    %ebx
80105684:	5e                   	pop    %esi
80105685:	5f                   	pop    %edi
80105686:	5d                   	pop    %ebp
80105687:	c3                   	ret    
80105688:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010568f:	90                   	nop
  if((ip = ialloc(dp->dev, type)) == 0)
80105690:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80105694:	83 ec 08             	sub    $0x8,%esp
80105697:	50                   	push   %eax
80105698:	ff 33                	pushl  (%ebx)
8010569a:	e8 21 c3 ff ff       	call   801019c0 <ialloc>
8010569f:	83 c4 10             	add    $0x10,%esp
801056a2:	89 c6                	mov    %eax,%esi
801056a4:	85 c0                	test   %eax,%eax
801056a6:	0f 84 cd 00 00 00    	je     80105779 <create+0x189>
  ilock(ip);
801056ac:	83 ec 0c             	sub    $0xc,%esp
801056af:	50                   	push   %eax
801056b0:	e8 8b c4 ff ff       	call   80101b40 <ilock>
  ip->major = major;
801056b5:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
801056b9:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
801056bd:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
801056c1:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
801056c5:	b8 01 00 00 00       	mov    $0x1,%eax
801056ca:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
801056ce:	89 34 24             	mov    %esi,(%esp)
801056d1:	e8 aa c3 ff ff       	call   80101a80 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
801056d6:	83 c4 10             	add    $0x10,%esp
801056d9:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
801056de:	74 30                	je     80105710 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
801056e0:	83 ec 04             	sub    $0x4,%esp
801056e3:	ff 76 04             	pushl  0x4(%esi)
801056e6:	57                   	push   %edi
801056e7:	53                   	push   %ebx
801056e8:	e8 63 cc ff ff       	call   80102350 <dirlink>
801056ed:	83 c4 10             	add    $0x10,%esp
801056f0:	85 c0                	test   %eax,%eax
801056f2:	78 78                	js     8010576c <create+0x17c>
  iunlockput(dp);
801056f4:	83 ec 0c             	sub    $0xc,%esp
801056f7:	53                   	push   %ebx
801056f8:	e8 e3 c6 ff ff       	call   80101de0 <iunlockput>
  return ip;
801056fd:	83 c4 10             	add    $0x10,%esp
}
80105700:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105703:	89 f0                	mov    %esi,%eax
80105705:	5b                   	pop    %ebx
80105706:	5e                   	pop    %esi
80105707:	5f                   	pop    %edi
80105708:	5d                   	pop    %ebp
80105709:	c3                   	ret    
8010570a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
80105710:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
80105713:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80105718:	53                   	push   %ebx
80105719:	e8 62 c3 ff ff       	call   80101a80 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
8010571e:	83 c4 0c             	add    $0xc,%esp
80105721:	ff 76 04             	pushl  0x4(%esi)
80105724:	68 90 86 10 80       	push   $0x80108690
80105729:	56                   	push   %esi
8010572a:	e8 21 cc ff ff       	call   80102350 <dirlink>
8010572f:	83 c4 10             	add    $0x10,%esp
80105732:	85 c0                	test   %eax,%eax
80105734:	78 18                	js     8010574e <create+0x15e>
80105736:	83 ec 04             	sub    $0x4,%esp
80105739:	ff 73 04             	pushl  0x4(%ebx)
8010573c:	68 8f 86 10 80       	push   $0x8010868f
80105741:	56                   	push   %esi
80105742:	e8 09 cc ff ff       	call   80102350 <dirlink>
80105747:	83 c4 10             	add    $0x10,%esp
8010574a:	85 c0                	test   %eax,%eax
8010574c:	79 92                	jns    801056e0 <create+0xf0>
      panic("create dots");
8010574e:	83 ec 0c             	sub    $0xc,%esp
80105751:	68 83 86 10 80       	push   $0x80108683
80105756:	e8 35 ac ff ff       	call   80100390 <panic>
8010575b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010575f:	90                   	nop
}
80105760:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80105763:	31 f6                	xor    %esi,%esi
}
80105765:	5b                   	pop    %ebx
80105766:	89 f0                	mov    %esi,%eax
80105768:	5e                   	pop    %esi
80105769:	5f                   	pop    %edi
8010576a:	5d                   	pop    %ebp
8010576b:	c3                   	ret    
    panic("create: dirlink");
8010576c:	83 ec 0c             	sub    $0xc,%esp
8010576f:	68 92 86 10 80       	push   $0x80108692
80105774:	e8 17 ac ff ff       	call   80100390 <panic>
    panic("create: ialloc");
80105779:	83 ec 0c             	sub    $0xc,%esp
8010577c:	68 74 86 10 80       	push   $0x80108674
80105781:	e8 0a ac ff ff       	call   80100390 <panic>
80105786:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010578d:	8d 76 00             	lea    0x0(%esi),%esi

80105790 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80105790:	55                   	push   %ebp
80105791:	89 e5                	mov    %esp,%ebp
80105793:	56                   	push   %esi
80105794:	89 d6                	mov    %edx,%esi
80105796:	53                   	push   %ebx
80105797:	89 c3                	mov    %eax,%ebx
  if(argint(n, &fd) < 0)
80105799:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
8010579c:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010579f:	50                   	push   %eax
801057a0:	6a 00                	push   $0x0
801057a2:	e8 e9 fc ff ff       	call   80105490 <argint>
801057a7:	83 c4 10             	add    $0x10,%esp
801057aa:	85 c0                	test   %eax,%eax
801057ac:	78 2a                	js     801057d8 <argfd.constprop.0+0x48>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801057ae:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801057b2:	77 24                	ja     801057d8 <argfd.constprop.0+0x48>
801057b4:	e8 e7 e5 ff ff       	call   80103da0 <myproc>
801057b9:	8b 55 f4             	mov    -0xc(%ebp),%edx
801057bc:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
801057c0:	85 c0                	test   %eax,%eax
801057c2:	74 14                	je     801057d8 <argfd.constprop.0+0x48>
  if(pfd)
801057c4:	85 db                	test   %ebx,%ebx
801057c6:	74 02                	je     801057ca <argfd.constprop.0+0x3a>
    *pfd = fd;
801057c8:	89 13                	mov    %edx,(%ebx)
    *pf = f;
801057ca:	89 06                	mov    %eax,(%esi)
  return 0;
801057cc:	31 c0                	xor    %eax,%eax
}
801057ce:	8d 65 f8             	lea    -0x8(%ebp),%esp
801057d1:	5b                   	pop    %ebx
801057d2:	5e                   	pop    %esi
801057d3:	5d                   	pop    %ebp
801057d4:	c3                   	ret    
801057d5:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801057d8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057dd:	eb ef                	jmp    801057ce <argfd.constprop.0+0x3e>
801057df:	90                   	nop

801057e0 <sys_dup>:
{
801057e0:	f3 0f 1e fb          	endbr32 
801057e4:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
801057e5:	31 c0                	xor    %eax,%eax
{
801057e7:	89 e5                	mov    %esp,%ebp
801057e9:	56                   	push   %esi
801057ea:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
801057eb:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
801057ee:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
801057f1:	e8 9a ff ff ff       	call   80105790 <argfd.constprop.0>
801057f6:	85 c0                	test   %eax,%eax
801057f8:	78 1e                	js     80105818 <sys_dup+0x38>
  if((fd=fdalloc(f)) < 0)
801057fa:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
801057fd:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
801057ff:	e8 9c e5 ff ff       	call   80103da0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105804:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80105808:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
8010580c:	85 d2                	test   %edx,%edx
8010580e:	74 20                	je     80105830 <sys_dup+0x50>
  for(fd = 0; fd < NOFILE; fd++){
80105810:	83 c3 01             	add    $0x1,%ebx
80105813:	83 fb 10             	cmp    $0x10,%ebx
80105816:	75 f0                	jne    80105808 <sys_dup+0x28>
}
80105818:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
8010581b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80105820:	89 d8                	mov    %ebx,%eax
80105822:	5b                   	pop    %ebx
80105823:	5e                   	pop    %esi
80105824:	5d                   	pop    %ebp
80105825:	c3                   	ret    
80105826:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010582d:	8d 76 00             	lea    0x0(%esi),%esi
      curproc->ofile[fd] = f;
80105830:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80105834:	83 ec 0c             	sub    $0xc,%esp
80105837:	ff 75 f4             	pushl  -0xc(%ebp)
8010583a:	e8 11 ba ff ff       	call   80101250 <filedup>
  return fd;
8010583f:	83 c4 10             	add    $0x10,%esp
}
80105842:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105845:	89 d8                	mov    %ebx,%eax
80105847:	5b                   	pop    %ebx
80105848:	5e                   	pop    %esi
80105849:	5d                   	pop    %ebp
8010584a:	c3                   	ret    
8010584b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010584f:	90                   	nop

80105850 <sys_read>:
{
80105850:	f3 0f 1e fb          	endbr32 
80105854:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105855:	31 c0                	xor    %eax,%eax
{
80105857:	89 e5                	mov    %esp,%ebp
80105859:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
8010585c:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010585f:	e8 2c ff ff ff       	call   80105790 <argfd.constprop.0>
80105864:	85 c0                	test   %eax,%eax
80105866:	78 48                	js     801058b0 <sys_read+0x60>
80105868:	83 ec 08             	sub    $0x8,%esp
8010586b:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010586e:	50                   	push   %eax
8010586f:	6a 02                	push   $0x2
80105871:	e8 1a fc ff ff       	call   80105490 <argint>
80105876:	83 c4 10             	add    $0x10,%esp
80105879:	85 c0                	test   %eax,%eax
8010587b:	78 33                	js     801058b0 <sys_read+0x60>
8010587d:	83 ec 04             	sub    $0x4,%esp
80105880:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105883:	ff 75 f0             	pushl  -0x10(%ebp)
80105886:	50                   	push   %eax
80105887:	6a 01                	push   $0x1
80105889:	e8 52 fc ff ff       	call   801054e0 <argptr>
8010588e:	83 c4 10             	add    $0x10,%esp
80105891:	85 c0                	test   %eax,%eax
80105893:	78 1b                	js     801058b0 <sys_read+0x60>
  return fileread(f, p, n);
80105895:	83 ec 04             	sub    $0x4,%esp
80105898:	ff 75 f0             	pushl  -0x10(%ebp)
8010589b:	ff 75 f4             	pushl  -0xc(%ebp)
8010589e:	ff 75 ec             	pushl  -0x14(%ebp)
801058a1:	e8 2a bb ff ff       	call   801013d0 <fileread>
801058a6:	83 c4 10             	add    $0x10,%esp
}
801058a9:	c9                   	leave  
801058aa:	c3                   	ret    
801058ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801058af:	90                   	nop
801058b0:	c9                   	leave  
    return -1;
801058b1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801058b6:	c3                   	ret    
801058b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801058be:	66 90                	xchg   %ax,%ax

801058c0 <sys_write>:
{
801058c0:	f3 0f 1e fb          	endbr32 
801058c4:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801058c5:	31 c0                	xor    %eax,%eax
{
801058c7:	89 e5                	mov    %esp,%ebp
801058c9:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801058cc:	8d 55 ec             	lea    -0x14(%ebp),%edx
801058cf:	e8 bc fe ff ff       	call   80105790 <argfd.constprop.0>
801058d4:	85 c0                	test   %eax,%eax
801058d6:	78 48                	js     80105920 <sys_write+0x60>
801058d8:	83 ec 08             	sub    $0x8,%esp
801058db:	8d 45 f0             	lea    -0x10(%ebp),%eax
801058de:	50                   	push   %eax
801058df:	6a 02                	push   $0x2
801058e1:	e8 aa fb ff ff       	call   80105490 <argint>
801058e6:	83 c4 10             	add    $0x10,%esp
801058e9:	85 c0                	test   %eax,%eax
801058eb:	78 33                	js     80105920 <sys_write+0x60>
801058ed:	83 ec 04             	sub    $0x4,%esp
801058f0:	8d 45 f4             	lea    -0xc(%ebp),%eax
801058f3:	ff 75 f0             	pushl  -0x10(%ebp)
801058f6:	50                   	push   %eax
801058f7:	6a 01                	push   $0x1
801058f9:	e8 e2 fb ff ff       	call   801054e0 <argptr>
801058fe:	83 c4 10             	add    $0x10,%esp
80105901:	85 c0                	test   %eax,%eax
80105903:	78 1b                	js     80105920 <sys_write+0x60>
  return filewrite(f, p, n);
80105905:	83 ec 04             	sub    $0x4,%esp
80105908:	ff 75 f0             	pushl  -0x10(%ebp)
8010590b:	ff 75 f4             	pushl  -0xc(%ebp)
8010590e:	ff 75 ec             	pushl  -0x14(%ebp)
80105911:	e8 5a bb ff ff       	call   80101470 <filewrite>
80105916:	83 c4 10             	add    $0x10,%esp
}
80105919:	c9                   	leave  
8010591a:	c3                   	ret    
8010591b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010591f:	90                   	nop
80105920:	c9                   	leave  
    return -1;
80105921:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105926:	c3                   	ret    
80105927:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010592e:	66 90                	xchg   %ax,%ax

80105930 <sys_close>:
{
80105930:	f3 0f 1e fb          	endbr32 
80105934:	55                   	push   %ebp
80105935:	89 e5                	mov    %esp,%ebp
80105937:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, &fd, &f) < 0)
8010593a:	8d 55 f4             	lea    -0xc(%ebp),%edx
8010593d:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105940:	e8 4b fe ff ff       	call   80105790 <argfd.constprop.0>
80105945:	85 c0                	test   %eax,%eax
80105947:	78 27                	js     80105970 <sys_close+0x40>
  myproc()->ofile[fd] = 0;
80105949:	e8 52 e4 ff ff       	call   80103da0 <myproc>
8010594e:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
80105951:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80105954:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
8010595b:	00 
  fileclose(f);
8010595c:	ff 75 f4             	pushl  -0xc(%ebp)
8010595f:	e8 3c b9 ff ff       	call   801012a0 <fileclose>
  return 0;
80105964:	83 c4 10             	add    $0x10,%esp
80105967:	31 c0                	xor    %eax,%eax
}
80105969:	c9                   	leave  
8010596a:	c3                   	ret    
8010596b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010596f:	90                   	nop
80105970:	c9                   	leave  
    return -1;
80105971:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105976:	c3                   	ret    
80105977:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010597e:	66 90                	xchg   %ax,%ax

80105980 <sys_fstat>:
{
80105980:	f3 0f 1e fb          	endbr32 
80105984:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105985:	31 c0                	xor    %eax,%eax
{
80105987:	89 e5                	mov    %esp,%ebp
80105989:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
8010598c:	8d 55 f0             	lea    -0x10(%ebp),%edx
8010598f:	e8 fc fd ff ff       	call   80105790 <argfd.constprop.0>
80105994:	85 c0                	test   %eax,%eax
80105996:	78 30                	js     801059c8 <sys_fstat+0x48>
80105998:	83 ec 04             	sub    $0x4,%esp
8010599b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010599e:	6a 14                	push   $0x14
801059a0:	50                   	push   %eax
801059a1:	6a 01                	push   $0x1
801059a3:	e8 38 fb ff ff       	call   801054e0 <argptr>
801059a8:	83 c4 10             	add    $0x10,%esp
801059ab:	85 c0                	test   %eax,%eax
801059ad:	78 19                	js     801059c8 <sys_fstat+0x48>
  return filestat(f, st);
801059af:	83 ec 08             	sub    $0x8,%esp
801059b2:	ff 75 f4             	pushl  -0xc(%ebp)
801059b5:	ff 75 f0             	pushl  -0x10(%ebp)
801059b8:	e8 c3 b9 ff ff       	call   80101380 <filestat>
801059bd:	83 c4 10             	add    $0x10,%esp
}
801059c0:	c9                   	leave  
801059c1:	c3                   	ret    
801059c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801059c8:	c9                   	leave  
    return -1;
801059c9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801059ce:	c3                   	ret    
801059cf:	90                   	nop

801059d0 <sys_link>:
{
801059d0:	f3 0f 1e fb          	endbr32 
801059d4:	55                   	push   %ebp
801059d5:	89 e5                	mov    %esp,%ebp
801059d7:	57                   	push   %edi
801059d8:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801059d9:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
801059dc:	53                   	push   %ebx
801059dd:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801059e0:	50                   	push   %eax
801059e1:	6a 00                	push   $0x0
801059e3:	e8 58 fb ff ff       	call   80105540 <argstr>
801059e8:	83 c4 10             	add    $0x10,%esp
801059eb:	85 c0                	test   %eax,%eax
801059ed:	0f 88 ff 00 00 00    	js     80105af2 <sys_link+0x122>
801059f3:	83 ec 08             	sub    $0x8,%esp
801059f6:	8d 45 d0             	lea    -0x30(%ebp),%eax
801059f9:	50                   	push   %eax
801059fa:	6a 01                	push   $0x1
801059fc:	e8 3f fb ff ff       	call   80105540 <argstr>
80105a01:	83 c4 10             	add    $0x10,%esp
80105a04:	85 c0                	test   %eax,%eax
80105a06:	0f 88 e6 00 00 00    	js     80105af2 <sys_link+0x122>
  begin_op();
80105a0c:	e8 ff d6 ff ff       	call   80103110 <begin_op>
  if((ip = namei(old)) == 0){
80105a11:	83 ec 0c             	sub    $0xc,%esp
80105a14:	ff 75 d4             	pushl  -0x2c(%ebp)
80105a17:	e8 f4 c9 ff ff       	call   80102410 <namei>
80105a1c:	83 c4 10             	add    $0x10,%esp
80105a1f:	89 c3                	mov    %eax,%ebx
80105a21:	85 c0                	test   %eax,%eax
80105a23:	0f 84 e8 00 00 00    	je     80105b11 <sys_link+0x141>
  ilock(ip);
80105a29:	83 ec 0c             	sub    $0xc,%esp
80105a2c:	50                   	push   %eax
80105a2d:	e8 0e c1 ff ff       	call   80101b40 <ilock>
  if(ip->type == T_DIR){
80105a32:	83 c4 10             	add    $0x10,%esp
80105a35:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105a3a:	0f 84 b9 00 00 00    	je     80105af9 <sys_link+0x129>
  iupdate(ip);
80105a40:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
80105a43:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
80105a48:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80105a4b:	53                   	push   %ebx
80105a4c:	e8 2f c0 ff ff       	call   80101a80 <iupdate>
  iunlock(ip);
80105a51:	89 1c 24             	mov    %ebx,(%esp)
80105a54:	e8 c7 c1 ff ff       	call   80101c20 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105a59:	58                   	pop    %eax
80105a5a:	5a                   	pop    %edx
80105a5b:	57                   	push   %edi
80105a5c:	ff 75 d0             	pushl  -0x30(%ebp)
80105a5f:	e8 cc c9 ff ff       	call   80102430 <nameiparent>
80105a64:	83 c4 10             	add    $0x10,%esp
80105a67:	89 c6                	mov    %eax,%esi
80105a69:	85 c0                	test   %eax,%eax
80105a6b:	74 5f                	je     80105acc <sys_link+0xfc>
  ilock(dp);
80105a6d:	83 ec 0c             	sub    $0xc,%esp
80105a70:	50                   	push   %eax
80105a71:	e8 ca c0 ff ff       	call   80101b40 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105a76:	8b 03                	mov    (%ebx),%eax
80105a78:	83 c4 10             	add    $0x10,%esp
80105a7b:	39 06                	cmp    %eax,(%esi)
80105a7d:	75 41                	jne    80105ac0 <sys_link+0xf0>
80105a7f:	83 ec 04             	sub    $0x4,%esp
80105a82:	ff 73 04             	pushl  0x4(%ebx)
80105a85:	57                   	push   %edi
80105a86:	56                   	push   %esi
80105a87:	e8 c4 c8 ff ff       	call   80102350 <dirlink>
80105a8c:	83 c4 10             	add    $0x10,%esp
80105a8f:	85 c0                	test   %eax,%eax
80105a91:	78 2d                	js     80105ac0 <sys_link+0xf0>
  iunlockput(dp);
80105a93:	83 ec 0c             	sub    $0xc,%esp
80105a96:	56                   	push   %esi
80105a97:	e8 44 c3 ff ff       	call   80101de0 <iunlockput>
  iput(ip);
80105a9c:	89 1c 24             	mov    %ebx,(%esp)
80105a9f:	e8 cc c1 ff ff       	call   80101c70 <iput>
  end_op();
80105aa4:	e8 d7 d6 ff ff       	call   80103180 <end_op>
  return 0;
80105aa9:	83 c4 10             	add    $0x10,%esp
80105aac:	31 c0                	xor    %eax,%eax
}
80105aae:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105ab1:	5b                   	pop    %ebx
80105ab2:	5e                   	pop    %esi
80105ab3:	5f                   	pop    %edi
80105ab4:	5d                   	pop    %ebp
80105ab5:	c3                   	ret    
80105ab6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105abd:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(dp);
80105ac0:	83 ec 0c             	sub    $0xc,%esp
80105ac3:	56                   	push   %esi
80105ac4:	e8 17 c3 ff ff       	call   80101de0 <iunlockput>
    goto bad;
80105ac9:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80105acc:	83 ec 0c             	sub    $0xc,%esp
80105acf:	53                   	push   %ebx
80105ad0:	e8 6b c0 ff ff       	call   80101b40 <ilock>
  ip->nlink--;
80105ad5:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105ada:	89 1c 24             	mov    %ebx,(%esp)
80105add:	e8 9e bf ff ff       	call   80101a80 <iupdate>
  iunlockput(ip);
80105ae2:	89 1c 24             	mov    %ebx,(%esp)
80105ae5:	e8 f6 c2 ff ff       	call   80101de0 <iunlockput>
  end_op();
80105aea:	e8 91 d6 ff ff       	call   80103180 <end_op>
  return -1;
80105aef:	83 c4 10             	add    $0x10,%esp
80105af2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105af7:	eb b5                	jmp    80105aae <sys_link+0xde>
    iunlockput(ip);
80105af9:	83 ec 0c             	sub    $0xc,%esp
80105afc:	53                   	push   %ebx
80105afd:	e8 de c2 ff ff       	call   80101de0 <iunlockput>
    end_op();
80105b02:	e8 79 d6 ff ff       	call   80103180 <end_op>
    return -1;
80105b07:	83 c4 10             	add    $0x10,%esp
80105b0a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b0f:	eb 9d                	jmp    80105aae <sys_link+0xde>
    end_op();
80105b11:	e8 6a d6 ff ff       	call   80103180 <end_op>
    return -1;
80105b16:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b1b:	eb 91                	jmp    80105aae <sys_link+0xde>
80105b1d:	8d 76 00             	lea    0x0(%esi),%esi

80105b20 <sys_unlink>:
{
80105b20:	f3 0f 1e fb          	endbr32 
80105b24:	55                   	push   %ebp
80105b25:	89 e5                	mov    %esp,%ebp
80105b27:	57                   	push   %edi
80105b28:	56                   	push   %esi
  if(argstr(0, &path) < 0)
80105b29:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80105b2c:	53                   	push   %ebx
80105b2d:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
80105b30:	50                   	push   %eax
80105b31:	6a 00                	push   $0x0
80105b33:	e8 08 fa ff ff       	call   80105540 <argstr>
80105b38:	83 c4 10             	add    $0x10,%esp
80105b3b:	85 c0                	test   %eax,%eax
80105b3d:	0f 88 7d 01 00 00    	js     80105cc0 <sys_unlink+0x1a0>
  begin_op();
80105b43:	e8 c8 d5 ff ff       	call   80103110 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105b48:	8d 5d ca             	lea    -0x36(%ebp),%ebx
80105b4b:	83 ec 08             	sub    $0x8,%esp
80105b4e:	53                   	push   %ebx
80105b4f:	ff 75 c0             	pushl  -0x40(%ebp)
80105b52:	e8 d9 c8 ff ff       	call   80102430 <nameiparent>
80105b57:	83 c4 10             	add    $0x10,%esp
80105b5a:	89 c6                	mov    %eax,%esi
80105b5c:	85 c0                	test   %eax,%eax
80105b5e:	0f 84 66 01 00 00    	je     80105cca <sys_unlink+0x1aa>
  ilock(dp);
80105b64:	83 ec 0c             	sub    $0xc,%esp
80105b67:	50                   	push   %eax
80105b68:	e8 d3 bf ff ff       	call   80101b40 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105b6d:	58                   	pop    %eax
80105b6e:	5a                   	pop    %edx
80105b6f:	68 90 86 10 80       	push   $0x80108690
80105b74:	53                   	push   %ebx
80105b75:	e8 f6 c4 ff ff       	call   80102070 <namecmp>
80105b7a:	83 c4 10             	add    $0x10,%esp
80105b7d:	85 c0                	test   %eax,%eax
80105b7f:	0f 84 03 01 00 00    	je     80105c88 <sys_unlink+0x168>
80105b85:	83 ec 08             	sub    $0x8,%esp
80105b88:	68 8f 86 10 80       	push   $0x8010868f
80105b8d:	53                   	push   %ebx
80105b8e:	e8 dd c4 ff ff       	call   80102070 <namecmp>
80105b93:	83 c4 10             	add    $0x10,%esp
80105b96:	85 c0                	test   %eax,%eax
80105b98:	0f 84 ea 00 00 00    	je     80105c88 <sys_unlink+0x168>
  if((ip = dirlookup(dp, name, &off)) == 0)
80105b9e:	83 ec 04             	sub    $0x4,%esp
80105ba1:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105ba4:	50                   	push   %eax
80105ba5:	53                   	push   %ebx
80105ba6:	56                   	push   %esi
80105ba7:	e8 e4 c4 ff ff       	call   80102090 <dirlookup>
80105bac:	83 c4 10             	add    $0x10,%esp
80105baf:	89 c3                	mov    %eax,%ebx
80105bb1:	85 c0                	test   %eax,%eax
80105bb3:	0f 84 cf 00 00 00    	je     80105c88 <sys_unlink+0x168>
  ilock(ip);
80105bb9:	83 ec 0c             	sub    $0xc,%esp
80105bbc:	50                   	push   %eax
80105bbd:	e8 7e bf ff ff       	call   80101b40 <ilock>
  if(ip->nlink < 1)
80105bc2:	83 c4 10             	add    $0x10,%esp
80105bc5:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80105bca:	0f 8e 23 01 00 00    	jle    80105cf3 <sys_unlink+0x1d3>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105bd0:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105bd5:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105bd8:	74 66                	je     80105c40 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
80105bda:	83 ec 04             	sub    $0x4,%esp
80105bdd:	6a 10                	push   $0x10
80105bdf:	6a 00                	push   $0x0
80105be1:	57                   	push   %edi
80105be2:	e8 c9 f5 ff ff       	call   801051b0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105be7:	6a 10                	push   $0x10
80105be9:	ff 75 c4             	pushl  -0x3c(%ebp)
80105bec:	57                   	push   %edi
80105bed:	56                   	push   %esi
80105bee:	e8 4d c3 ff ff       	call   80101f40 <writei>
80105bf3:	83 c4 20             	add    $0x20,%esp
80105bf6:	83 f8 10             	cmp    $0x10,%eax
80105bf9:	0f 85 e7 00 00 00    	jne    80105ce6 <sys_unlink+0x1c6>
  if(ip->type == T_DIR){
80105bff:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105c04:	0f 84 96 00 00 00    	je     80105ca0 <sys_unlink+0x180>
  iunlockput(dp);
80105c0a:	83 ec 0c             	sub    $0xc,%esp
80105c0d:	56                   	push   %esi
80105c0e:	e8 cd c1 ff ff       	call   80101de0 <iunlockput>
  ip->nlink--;
80105c13:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105c18:	89 1c 24             	mov    %ebx,(%esp)
80105c1b:	e8 60 be ff ff       	call   80101a80 <iupdate>
  iunlockput(ip);
80105c20:	89 1c 24             	mov    %ebx,(%esp)
80105c23:	e8 b8 c1 ff ff       	call   80101de0 <iunlockput>
  end_op();
80105c28:	e8 53 d5 ff ff       	call   80103180 <end_op>
  return 0;
80105c2d:	83 c4 10             	add    $0x10,%esp
80105c30:	31 c0                	xor    %eax,%eax
}
80105c32:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c35:	5b                   	pop    %ebx
80105c36:	5e                   	pop    %esi
80105c37:	5f                   	pop    %edi
80105c38:	5d                   	pop    %ebp
80105c39:	c3                   	ret    
80105c3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105c40:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105c44:	76 94                	jbe    80105bda <sys_unlink+0xba>
80105c46:	ba 20 00 00 00       	mov    $0x20,%edx
80105c4b:	eb 0b                	jmp    80105c58 <sys_unlink+0x138>
80105c4d:	8d 76 00             	lea    0x0(%esi),%esi
80105c50:	83 c2 10             	add    $0x10,%edx
80105c53:	39 53 58             	cmp    %edx,0x58(%ebx)
80105c56:	76 82                	jbe    80105bda <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105c58:	6a 10                	push   $0x10
80105c5a:	52                   	push   %edx
80105c5b:	57                   	push   %edi
80105c5c:	53                   	push   %ebx
80105c5d:	89 55 b4             	mov    %edx,-0x4c(%ebp)
80105c60:	e8 db c1 ff ff       	call   80101e40 <readi>
80105c65:	83 c4 10             	add    $0x10,%esp
80105c68:	8b 55 b4             	mov    -0x4c(%ebp),%edx
80105c6b:	83 f8 10             	cmp    $0x10,%eax
80105c6e:	75 69                	jne    80105cd9 <sys_unlink+0x1b9>
    if(de.inum != 0)
80105c70:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105c75:	74 d9                	je     80105c50 <sys_unlink+0x130>
    iunlockput(ip);
80105c77:	83 ec 0c             	sub    $0xc,%esp
80105c7a:	53                   	push   %ebx
80105c7b:	e8 60 c1 ff ff       	call   80101de0 <iunlockput>
    goto bad;
80105c80:	83 c4 10             	add    $0x10,%esp
80105c83:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105c87:	90                   	nop
  iunlockput(dp);
80105c88:	83 ec 0c             	sub    $0xc,%esp
80105c8b:	56                   	push   %esi
80105c8c:	e8 4f c1 ff ff       	call   80101de0 <iunlockput>
  end_op();
80105c91:	e8 ea d4 ff ff       	call   80103180 <end_op>
  return -1;
80105c96:	83 c4 10             	add    $0x10,%esp
80105c99:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c9e:	eb 92                	jmp    80105c32 <sys_unlink+0x112>
    iupdate(dp);
80105ca0:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
80105ca3:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
80105ca8:	56                   	push   %esi
80105ca9:	e8 d2 bd ff ff       	call   80101a80 <iupdate>
80105cae:	83 c4 10             	add    $0x10,%esp
80105cb1:	e9 54 ff ff ff       	jmp    80105c0a <sys_unlink+0xea>
80105cb6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105cbd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105cc0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105cc5:	e9 68 ff ff ff       	jmp    80105c32 <sys_unlink+0x112>
    end_op();
80105cca:	e8 b1 d4 ff ff       	call   80103180 <end_op>
    return -1;
80105ccf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105cd4:	e9 59 ff ff ff       	jmp    80105c32 <sys_unlink+0x112>
      panic("isdirempty: readi");
80105cd9:	83 ec 0c             	sub    $0xc,%esp
80105cdc:	68 b4 86 10 80       	push   $0x801086b4
80105ce1:	e8 aa a6 ff ff       	call   80100390 <panic>
    panic("unlink: writei");
80105ce6:	83 ec 0c             	sub    $0xc,%esp
80105ce9:	68 c6 86 10 80       	push   $0x801086c6
80105cee:	e8 9d a6 ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
80105cf3:	83 ec 0c             	sub    $0xc,%esp
80105cf6:	68 a2 86 10 80       	push   $0x801086a2
80105cfb:	e8 90 a6 ff ff       	call   80100390 <panic>

80105d00 <sys_open>:

int
sys_open(void)
{
80105d00:	f3 0f 1e fb          	endbr32 
80105d04:	55                   	push   %ebp
80105d05:	89 e5                	mov    %esp,%ebp
80105d07:	57                   	push   %edi
80105d08:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105d09:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105d0c:	53                   	push   %ebx
80105d0d:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105d10:	50                   	push   %eax
80105d11:	6a 00                	push   $0x0
80105d13:	e8 28 f8 ff ff       	call   80105540 <argstr>
80105d18:	83 c4 10             	add    $0x10,%esp
80105d1b:	85 c0                	test   %eax,%eax
80105d1d:	0f 88 8a 00 00 00    	js     80105dad <sys_open+0xad>
80105d23:	83 ec 08             	sub    $0x8,%esp
80105d26:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105d29:	50                   	push   %eax
80105d2a:	6a 01                	push   $0x1
80105d2c:	e8 5f f7 ff ff       	call   80105490 <argint>
80105d31:	83 c4 10             	add    $0x10,%esp
80105d34:	85 c0                	test   %eax,%eax
80105d36:	78 75                	js     80105dad <sys_open+0xad>
    return -1;

  begin_op();
80105d38:	e8 d3 d3 ff ff       	call   80103110 <begin_op>

  if(omode & O_CREATE){
80105d3d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105d41:	75 75                	jne    80105db8 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105d43:	83 ec 0c             	sub    $0xc,%esp
80105d46:	ff 75 e0             	pushl  -0x20(%ebp)
80105d49:	e8 c2 c6 ff ff       	call   80102410 <namei>
80105d4e:	83 c4 10             	add    $0x10,%esp
80105d51:	89 c6                	mov    %eax,%esi
80105d53:	85 c0                	test   %eax,%eax
80105d55:	74 7e                	je     80105dd5 <sys_open+0xd5>
      end_op();
      return -1;
    }
    ilock(ip);
80105d57:	83 ec 0c             	sub    $0xc,%esp
80105d5a:	50                   	push   %eax
80105d5b:	e8 e0 bd ff ff       	call   80101b40 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105d60:	83 c4 10             	add    $0x10,%esp
80105d63:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105d68:	0f 84 c2 00 00 00    	je     80105e30 <sys_open+0x130>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105d6e:	e8 6d b4 ff ff       	call   801011e0 <filealloc>
80105d73:	89 c7                	mov    %eax,%edi
80105d75:	85 c0                	test   %eax,%eax
80105d77:	74 23                	je     80105d9c <sys_open+0x9c>
  struct proc *curproc = myproc();
80105d79:	e8 22 e0 ff ff       	call   80103da0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105d7e:	31 db                	xor    %ebx,%ebx
    if(curproc->ofile[fd] == 0){
80105d80:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105d84:	85 d2                	test   %edx,%edx
80105d86:	74 60                	je     80105de8 <sys_open+0xe8>
  for(fd = 0; fd < NOFILE; fd++){
80105d88:	83 c3 01             	add    $0x1,%ebx
80105d8b:	83 fb 10             	cmp    $0x10,%ebx
80105d8e:	75 f0                	jne    80105d80 <sys_open+0x80>
    if(f)
      fileclose(f);
80105d90:	83 ec 0c             	sub    $0xc,%esp
80105d93:	57                   	push   %edi
80105d94:	e8 07 b5 ff ff       	call   801012a0 <fileclose>
80105d99:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80105d9c:	83 ec 0c             	sub    $0xc,%esp
80105d9f:	56                   	push   %esi
80105da0:	e8 3b c0 ff ff       	call   80101de0 <iunlockput>
    end_op();
80105da5:	e8 d6 d3 ff ff       	call   80103180 <end_op>
    return -1;
80105daa:	83 c4 10             	add    $0x10,%esp
80105dad:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105db2:	eb 6d                	jmp    80105e21 <sys_open+0x121>
80105db4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
80105db8:	83 ec 0c             	sub    $0xc,%esp
80105dbb:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105dbe:	31 c9                	xor    %ecx,%ecx
80105dc0:	ba 02 00 00 00       	mov    $0x2,%edx
80105dc5:	6a 00                	push   $0x0
80105dc7:	e8 24 f8 ff ff       	call   801055f0 <create>
    if(ip == 0){
80105dcc:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
80105dcf:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80105dd1:	85 c0                	test   %eax,%eax
80105dd3:	75 99                	jne    80105d6e <sys_open+0x6e>
      end_op();
80105dd5:	e8 a6 d3 ff ff       	call   80103180 <end_op>
      return -1;
80105dda:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105ddf:	eb 40                	jmp    80105e21 <sys_open+0x121>
80105de1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
80105de8:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105deb:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
80105def:	56                   	push   %esi
80105df0:	e8 2b be ff ff       	call   80101c20 <iunlock>
  end_op();
80105df5:	e8 86 d3 ff ff       	call   80103180 <end_op>

  f->type = FD_INODE;
80105dfa:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105e00:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105e03:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105e06:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
80105e09:	89 d0                	mov    %edx,%eax
  f->off = 0;
80105e0b:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80105e12:	f7 d0                	not    %eax
80105e14:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105e17:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80105e1a:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105e1d:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80105e21:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105e24:	89 d8                	mov    %ebx,%eax
80105e26:	5b                   	pop    %ebx
80105e27:	5e                   	pop    %esi
80105e28:	5f                   	pop    %edi
80105e29:	5d                   	pop    %ebp
80105e2a:	c3                   	ret    
80105e2b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105e2f:	90                   	nop
    if(ip->type == T_DIR && omode != O_RDONLY){
80105e30:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105e33:	85 c9                	test   %ecx,%ecx
80105e35:	0f 84 33 ff ff ff    	je     80105d6e <sys_open+0x6e>
80105e3b:	e9 5c ff ff ff       	jmp    80105d9c <sys_open+0x9c>

80105e40 <sys_mkdir>:

int
sys_mkdir(void)
{
80105e40:	f3 0f 1e fb          	endbr32 
80105e44:	55                   	push   %ebp
80105e45:	89 e5                	mov    %esp,%ebp
80105e47:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105e4a:	e8 c1 d2 ff ff       	call   80103110 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80105e4f:	83 ec 08             	sub    $0x8,%esp
80105e52:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105e55:	50                   	push   %eax
80105e56:	6a 00                	push   $0x0
80105e58:	e8 e3 f6 ff ff       	call   80105540 <argstr>
80105e5d:	83 c4 10             	add    $0x10,%esp
80105e60:	85 c0                	test   %eax,%eax
80105e62:	78 34                	js     80105e98 <sys_mkdir+0x58>
80105e64:	83 ec 0c             	sub    $0xc,%esp
80105e67:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e6a:	31 c9                	xor    %ecx,%ecx
80105e6c:	ba 01 00 00 00       	mov    $0x1,%edx
80105e71:	6a 00                	push   $0x0
80105e73:	e8 78 f7 ff ff       	call   801055f0 <create>
80105e78:	83 c4 10             	add    $0x10,%esp
80105e7b:	85 c0                	test   %eax,%eax
80105e7d:	74 19                	je     80105e98 <sys_mkdir+0x58>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105e7f:	83 ec 0c             	sub    $0xc,%esp
80105e82:	50                   	push   %eax
80105e83:	e8 58 bf ff ff       	call   80101de0 <iunlockput>
  end_op();
80105e88:	e8 f3 d2 ff ff       	call   80103180 <end_op>
  return 0;
80105e8d:	83 c4 10             	add    $0x10,%esp
80105e90:	31 c0                	xor    %eax,%eax
}
80105e92:	c9                   	leave  
80105e93:	c3                   	ret    
80105e94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    end_op();
80105e98:	e8 e3 d2 ff ff       	call   80103180 <end_op>
    return -1;
80105e9d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105ea2:	c9                   	leave  
80105ea3:	c3                   	ret    
80105ea4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105eab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105eaf:	90                   	nop

80105eb0 <sys_mknod>:

int
sys_mknod(void)
{
80105eb0:	f3 0f 1e fb          	endbr32 
80105eb4:	55                   	push   %ebp
80105eb5:	89 e5                	mov    %esp,%ebp
80105eb7:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105eba:	e8 51 d2 ff ff       	call   80103110 <begin_op>
  if((argstr(0, &path)) < 0 ||
80105ebf:	83 ec 08             	sub    $0x8,%esp
80105ec2:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105ec5:	50                   	push   %eax
80105ec6:	6a 00                	push   $0x0
80105ec8:	e8 73 f6 ff ff       	call   80105540 <argstr>
80105ecd:	83 c4 10             	add    $0x10,%esp
80105ed0:	85 c0                	test   %eax,%eax
80105ed2:	78 64                	js     80105f38 <sys_mknod+0x88>
     argint(1, &major) < 0 ||
80105ed4:	83 ec 08             	sub    $0x8,%esp
80105ed7:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105eda:	50                   	push   %eax
80105edb:	6a 01                	push   $0x1
80105edd:	e8 ae f5 ff ff       	call   80105490 <argint>
  if((argstr(0, &path)) < 0 ||
80105ee2:	83 c4 10             	add    $0x10,%esp
80105ee5:	85 c0                	test   %eax,%eax
80105ee7:	78 4f                	js     80105f38 <sys_mknod+0x88>
     argint(2, &minor) < 0 ||
80105ee9:	83 ec 08             	sub    $0x8,%esp
80105eec:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105eef:	50                   	push   %eax
80105ef0:	6a 02                	push   $0x2
80105ef2:	e8 99 f5 ff ff       	call   80105490 <argint>
     argint(1, &major) < 0 ||
80105ef7:	83 c4 10             	add    $0x10,%esp
80105efa:	85 c0                	test   %eax,%eax
80105efc:	78 3a                	js     80105f38 <sys_mknod+0x88>
     (ip = create(path, T_DEV, major, minor)) == 0){
80105efe:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
80105f02:	83 ec 0c             	sub    $0xc,%esp
80105f05:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105f09:	ba 03 00 00 00       	mov    $0x3,%edx
80105f0e:	50                   	push   %eax
80105f0f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105f12:	e8 d9 f6 ff ff       	call   801055f0 <create>
     argint(2, &minor) < 0 ||
80105f17:	83 c4 10             	add    $0x10,%esp
80105f1a:	85 c0                	test   %eax,%eax
80105f1c:	74 1a                	je     80105f38 <sys_mknod+0x88>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105f1e:	83 ec 0c             	sub    $0xc,%esp
80105f21:	50                   	push   %eax
80105f22:	e8 b9 be ff ff       	call   80101de0 <iunlockput>
  end_op();
80105f27:	e8 54 d2 ff ff       	call   80103180 <end_op>
  return 0;
80105f2c:	83 c4 10             	add    $0x10,%esp
80105f2f:	31 c0                	xor    %eax,%eax
}
80105f31:	c9                   	leave  
80105f32:	c3                   	ret    
80105f33:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105f37:	90                   	nop
    end_op();
80105f38:	e8 43 d2 ff ff       	call   80103180 <end_op>
    return -1;
80105f3d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105f42:	c9                   	leave  
80105f43:	c3                   	ret    
80105f44:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105f4f:	90                   	nop

80105f50 <sys_chdir>:

int
sys_chdir(void)
{
80105f50:	f3 0f 1e fb          	endbr32 
80105f54:	55                   	push   %ebp
80105f55:	89 e5                	mov    %esp,%ebp
80105f57:	56                   	push   %esi
80105f58:	53                   	push   %ebx
80105f59:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105f5c:	e8 3f de ff ff       	call   80103da0 <myproc>
80105f61:	89 c6                	mov    %eax,%esi
  
  begin_op();
80105f63:	e8 a8 d1 ff ff       	call   80103110 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105f68:	83 ec 08             	sub    $0x8,%esp
80105f6b:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105f6e:	50                   	push   %eax
80105f6f:	6a 00                	push   $0x0
80105f71:	e8 ca f5 ff ff       	call   80105540 <argstr>
80105f76:	83 c4 10             	add    $0x10,%esp
80105f79:	85 c0                	test   %eax,%eax
80105f7b:	78 73                	js     80105ff0 <sys_chdir+0xa0>
80105f7d:	83 ec 0c             	sub    $0xc,%esp
80105f80:	ff 75 f4             	pushl  -0xc(%ebp)
80105f83:	e8 88 c4 ff ff       	call   80102410 <namei>
80105f88:	83 c4 10             	add    $0x10,%esp
80105f8b:	89 c3                	mov    %eax,%ebx
80105f8d:	85 c0                	test   %eax,%eax
80105f8f:	74 5f                	je     80105ff0 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
80105f91:	83 ec 0c             	sub    $0xc,%esp
80105f94:	50                   	push   %eax
80105f95:	e8 a6 bb ff ff       	call   80101b40 <ilock>
  if(ip->type != T_DIR){
80105f9a:	83 c4 10             	add    $0x10,%esp
80105f9d:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105fa2:	75 2c                	jne    80105fd0 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105fa4:	83 ec 0c             	sub    $0xc,%esp
80105fa7:	53                   	push   %ebx
80105fa8:	e8 73 bc ff ff       	call   80101c20 <iunlock>
  iput(curproc->cwd);
80105fad:	58                   	pop    %eax
80105fae:	ff 76 68             	pushl  0x68(%esi)
80105fb1:	e8 ba bc ff ff       	call   80101c70 <iput>
  end_op();
80105fb6:	e8 c5 d1 ff ff       	call   80103180 <end_op>
  curproc->cwd = ip;
80105fbb:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
80105fbe:	83 c4 10             	add    $0x10,%esp
80105fc1:	31 c0                	xor    %eax,%eax
}
80105fc3:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105fc6:	5b                   	pop    %ebx
80105fc7:	5e                   	pop    %esi
80105fc8:	5d                   	pop    %ebp
80105fc9:	c3                   	ret    
80105fca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(ip);
80105fd0:	83 ec 0c             	sub    $0xc,%esp
80105fd3:	53                   	push   %ebx
80105fd4:	e8 07 be ff ff       	call   80101de0 <iunlockput>
    end_op();
80105fd9:	e8 a2 d1 ff ff       	call   80103180 <end_op>
    return -1;
80105fde:	83 c4 10             	add    $0x10,%esp
80105fe1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105fe6:	eb db                	jmp    80105fc3 <sys_chdir+0x73>
80105fe8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105fef:	90                   	nop
    end_op();
80105ff0:	e8 8b d1 ff ff       	call   80103180 <end_op>
    return -1;
80105ff5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ffa:	eb c7                	jmp    80105fc3 <sys_chdir+0x73>
80105ffc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106000 <sys_exec>:

int
sys_exec(void)
{
80106000:	f3 0f 1e fb          	endbr32 
80106004:	55                   	push   %ebp
80106005:	89 e5                	mov    %esp,%ebp
80106007:	57                   	push   %edi
80106008:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80106009:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
8010600f:	53                   	push   %ebx
80106010:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80106016:	50                   	push   %eax
80106017:	6a 00                	push   $0x0
80106019:	e8 22 f5 ff ff       	call   80105540 <argstr>
8010601e:	83 c4 10             	add    $0x10,%esp
80106021:	85 c0                	test   %eax,%eax
80106023:	0f 88 8b 00 00 00    	js     801060b4 <sys_exec+0xb4>
80106029:	83 ec 08             	sub    $0x8,%esp
8010602c:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80106032:	50                   	push   %eax
80106033:	6a 01                	push   $0x1
80106035:	e8 56 f4 ff ff       	call   80105490 <argint>
8010603a:	83 c4 10             	add    $0x10,%esp
8010603d:	85 c0                	test   %eax,%eax
8010603f:	78 73                	js     801060b4 <sys_exec+0xb4>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80106041:	83 ec 04             	sub    $0x4,%esp
80106044:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
  for(i=0;; i++){
8010604a:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
8010604c:	68 80 00 00 00       	push   $0x80
80106051:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80106057:	6a 00                	push   $0x0
80106059:	50                   	push   %eax
8010605a:	e8 51 f1 ff ff       	call   801051b0 <memset>
8010605f:	83 c4 10             	add    $0x10,%esp
80106062:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80106068:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
8010606e:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80106075:	83 ec 08             	sub    $0x8,%esp
80106078:	57                   	push   %edi
80106079:	01 f0                	add    %esi,%eax
8010607b:	50                   	push   %eax
8010607c:	e8 6f f3 ff ff       	call   801053f0 <fetchint>
80106081:	83 c4 10             	add    $0x10,%esp
80106084:	85 c0                	test   %eax,%eax
80106086:	78 2c                	js     801060b4 <sys_exec+0xb4>
      return -1;
    if(uarg == 0){
80106088:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010608e:	85 c0                	test   %eax,%eax
80106090:	74 36                	je     801060c8 <sys_exec+0xc8>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80106092:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80106098:	83 ec 08             	sub    $0x8,%esp
8010609b:	8d 14 31             	lea    (%ecx,%esi,1),%edx
8010609e:	52                   	push   %edx
8010609f:	50                   	push   %eax
801060a0:	e8 8b f3 ff ff       	call   80105430 <fetchstr>
801060a5:	83 c4 10             	add    $0x10,%esp
801060a8:	85 c0                	test   %eax,%eax
801060aa:	78 08                	js     801060b4 <sys_exec+0xb4>
  for(i=0;; i++){
801060ac:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
801060af:	83 fb 20             	cmp    $0x20,%ebx
801060b2:	75 b4                	jne    80106068 <sys_exec+0x68>
      return -1;
  }
  return exec(path, argv);
}
801060b4:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
801060b7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801060bc:	5b                   	pop    %ebx
801060bd:	5e                   	pop    %esi
801060be:	5f                   	pop    %edi
801060bf:	5d                   	pop    %ebp
801060c0:	c3                   	ret    
801060c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
801060c8:	83 ec 08             	sub    $0x8,%esp
801060cb:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
      argv[i] = 0;
801060d1:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
801060d8:	00 00 00 00 
  return exec(path, argv);
801060dc:	50                   	push   %eax
801060dd:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
801060e3:	e8 68 ad ff ff       	call   80100e50 <exec>
801060e8:	83 c4 10             	add    $0x10,%esp
}
801060eb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801060ee:	5b                   	pop    %ebx
801060ef:	5e                   	pop    %esi
801060f0:	5f                   	pop    %edi
801060f1:	5d                   	pop    %ebp
801060f2:	c3                   	ret    
801060f3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801060fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106100 <sys_pipe>:

int
sys_pipe(void)
{
80106100:	f3 0f 1e fb          	endbr32 
80106104:	55                   	push   %ebp
80106105:	89 e5                	mov    %esp,%ebp
80106107:	57                   	push   %edi
80106108:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80106109:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
8010610c:	53                   	push   %ebx
8010610d:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80106110:	6a 08                	push   $0x8
80106112:	50                   	push   %eax
80106113:	6a 00                	push   $0x0
80106115:	e8 c6 f3 ff ff       	call   801054e0 <argptr>
8010611a:	83 c4 10             	add    $0x10,%esp
8010611d:	85 c0                	test   %eax,%eax
8010611f:	78 4e                	js     8010616f <sys_pipe+0x6f>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80106121:	83 ec 08             	sub    $0x8,%esp
80106124:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106127:	50                   	push   %eax
80106128:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010612b:	50                   	push   %eax
8010612c:	e8 9f d6 ff ff       	call   801037d0 <pipealloc>
80106131:	83 c4 10             	add    $0x10,%esp
80106134:	85 c0                	test   %eax,%eax
80106136:	78 37                	js     8010616f <sys_pipe+0x6f>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106138:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
8010613b:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
8010613d:	e8 5e dc ff ff       	call   80103da0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80106142:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[fd] == 0){
80106148:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
8010614c:	85 f6                	test   %esi,%esi
8010614e:	74 30                	je     80106180 <sys_pipe+0x80>
  for(fd = 0; fd < NOFILE; fd++){
80106150:	83 c3 01             	add    $0x1,%ebx
80106153:	83 fb 10             	cmp    $0x10,%ebx
80106156:	75 f0                	jne    80106148 <sys_pipe+0x48>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
80106158:	83 ec 0c             	sub    $0xc,%esp
8010615b:	ff 75 e0             	pushl  -0x20(%ebp)
8010615e:	e8 3d b1 ff ff       	call   801012a0 <fileclose>
    fileclose(wf);
80106163:	58                   	pop    %eax
80106164:	ff 75 e4             	pushl  -0x1c(%ebp)
80106167:	e8 34 b1 ff ff       	call   801012a0 <fileclose>
    return -1;
8010616c:	83 c4 10             	add    $0x10,%esp
8010616f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106174:	eb 5b                	jmp    801061d1 <sys_pipe+0xd1>
80106176:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010617d:	8d 76 00             	lea    0x0(%esi),%esi
      curproc->ofile[fd] = f;
80106180:	8d 73 08             	lea    0x8(%ebx),%esi
80106183:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106187:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
8010618a:	e8 11 dc ff ff       	call   80103da0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010618f:	31 d2                	xor    %edx,%edx
80106191:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80106198:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
8010619c:	85 c9                	test   %ecx,%ecx
8010619e:	74 20                	je     801061c0 <sys_pipe+0xc0>
  for(fd = 0; fd < NOFILE; fd++){
801061a0:	83 c2 01             	add    $0x1,%edx
801061a3:	83 fa 10             	cmp    $0x10,%edx
801061a6:	75 f0                	jne    80106198 <sys_pipe+0x98>
      myproc()->ofile[fd0] = 0;
801061a8:	e8 f3 db ff ff       	call   80103da0 <myproc>
801061ad:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
801061b4:	00 
801061b5:	eb a1                	jmp    80106158 <sys_pipe+0x58>
801061b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801061be:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
801061c0:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
  }
  fd[0] = fd0;
801061c4:	8b 45 dc             	mov    -0x24(%ebp),%eax
801061c7:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
801061c9:	8b 45 dc             	mov    -0x24(%ebp),%eax
801061cc:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
801061cf:	31 c0                	xor    %eax,%eax
}
801061d1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801061d4:	5b                   	pop    %ebx
801061d5:	5e                   	pop    %esi
801061d6:	5f                   	pop    %edi
801061d7:	5d                   	pop    %ebp
801061d8:	c3                   	ret    
801061d9:	66 90                	xchg   %ax,%ax
801061db:	66 90                	xchg   %ax,%ax
801061dd:	66 90                	xchg   %ax,%ax
801061df:	90                   	nop

801061e0 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
801061e0:	f3 0f 1e fb          	endbr32 
  return fork();
801061e4:	e9 97 dd ff ff       	jmp    80103f80 <fork>
801061e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801061f0 <sys_exit>:
}

int
sys_exit(void)
{
801061f0:	f3 0f 1e fb          	endbr32 
801061f4:	55                   	push   %ebp
801061f5:	89 e5                	mov    %esp,%ebp
801061f7:	83 ec 08             	sub    $0x8,%esp
  exit();
801061fa:	e8 91 e4 ff ff       	call   80104690 <exit>
  return 0;  // not reached
}
801061ff:	31 c0                	xor    %eax,%eax
80106201:	c9                   	leave  
80106202:	c3                   	ret    
80106203:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010620a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106210 <sys_wait>:

int
sys_wait(void)
{
80106210:	f3 0f 1e fb          	endbr32 
  return wait();
80106214:	e9 c7 e6 ff ff       	jmp    801048e0 <wait>
80106219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106220 <sys_kill>:
}

int
sys_kill(void)
{
80106220:	f3 0f 1e fb          	endbr32 
80106224:	55                   	push   %ebp
80106225:	89 e5                	mov    %esp,%ebp
80106227:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
8010622a:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010622d:	50                   	push   %eax
8010622e:	6a 00                	push   $0x0
80106230:	e8 5b f2 ff ff       	call   80105490 <argint>
80106235:	83 c4 10             	add    $0x10,%esp
80106238:	85 c0                	test   %eax,%eax
8010623a:	78 14                	js     80106250 <sys_kill+0x30>
    return -1;
  return kill(pid);
8010623c:	83 ec 0c             	sub    $0xc,%esp
8010623f:	ff 75 f4             	pushl  -0xc(%ebp)
80106242:	e8 09 e8 ff ff       	call   80104a50 <kill>
80106247:	83 c4 10             	add    $0x10,%esp
}
8010624a:	c9                   	leave  
8010624b:	c3                   	ret    
8010624c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106250:	c9                   	leave  
    return -1;
80106251:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106256:	c3                   	ret    
80106257:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010625e:	66 90                	xchg   %ax,%ax

80106260 <sys_getpid>:

int
sys_getpid(void)
{
80106260:	f3 0f 1e fb          	endbr32 
80106264:	55                   	push   %ebp
80106265:	89 e5                	mov    %esp,%ebp
80106267:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
8010626a:	e8 31 db ff ff       	call   80103da0 <myproc>
8010626f:	8b 40 10             	mov    0x10(%eax),%eax
}
80106272:	c9                   	leave  
80106273:	c3                   	ret    
80106274:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010627b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010627f:	90                   	nop

80106280 <sys_sbrk>:

int
sys_sbrk(void)
{
80106280:	f3 0f 1e fb          	endbr32 
80106284:	55                   	push   %ebp
80106285:	89 e5                	mov    %esp,%ebp
80106287:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80106288:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
8010628b:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010628e:	50                   	push   %eax
8010628f:	6a 00                	push   $0x0
80106291:	e8 fa f1 ff ff       	call   80105490 <argint>
80106296:	83 c4 10             	add    $0x10,%esp
80106299:	85 c0                	test   %eax,%eax
8010629b:	78 23                	js     801062c0 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
8010629d:	e8 fe da ff ff       	call   80103da0 <myproc>
  if(growproc(n) < 0)
801062a2:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
801062a5:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
801062a7:	ff 75 f4             	pushl  -0xc(%ebp)
801062aa:	e8 51 dc ff ff       	call   80103f00 <growproc>
801062af:	83 c4 10             	add    $0x10,%esp
801062b2:	85 c0                	test   %eax,%eax
801062b4:	78 0a                	js     801062c0 <sys_sbrk+0x40>
    return -1;
  return addr;
}
801062b6:	89 d8                	mov    %ebx,%eax
801062b8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801062bb:	c9                   	leave  
801062bc:	c3                   	ret    
801062bd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801062c0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801062c5:	eb ef                	jmp    801062b6 <sys_sbrk+0x36>
801062c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801062ce:	66 90                	xchg   %ax,%ax

801062d0 <sys_sleep>:

int
sys_sleep(void)
{
801062d0:	f3 0f 1e fb          	endbr32 
801062d4:	55                   	push   %ebp
801062d5:	89 e5                	mov    %esp,%ebp
801062d7:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
801062d8:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801062db:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
801062de:	50                   	push   %eax
801062df:	6a 00                	push   $0x0
801062e1:	e8 aa f1 ff ff       	call   80105490 <argint>
801062e6:	83 c4 10             	add    $0x10,%esp
801062e9:	85 c0                	test   %eax,%eax
801062eb:	0f 88 86 00 00 00    	js     80106377 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
801062f1:	83 ec 0c             	sub    $0xc,%esp
801062f4:	68 40 6b 11 80       	push   $0x80116b40
801062f9:	e8 a2 ed ff ff       	call   801050a0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801062fe:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
80106301:	8b 1d 80 73 11 80    	mov    0x80117380,%ebx
  while(ticks - ticks0 < n){
80106307:	83 c4 10             	add    $0x10,%esp
8010630a:	85 d2                	test   %edx,%edx
8010630c:	75 23                	jne    80106331 <sys_sleep+0x61>
8010630e:	eb 50                	jmp    80106360 <sys_sleep+0x90>
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80106310:	83 ec 08             	sub    $0x8,%esp
80106313:	68 40 6b 11 80       	push   $0x80116b40
80106318:	68 80 73 11 80       	push   $0x80117380
8010631d:	e8 fe e4 ff ff       	call   80104820 <sleep>
  while(ticks - ticks0 < n){
80106322:	a1 80 73 11 80       	mov    0x80117380,%eax
80106327:	83 c4 10             	add    $0x10,%esp
8010632a:	29 d8                	sub    %ebx,%eax
8010632c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010632f:	73 2f                	jae    80106360 <sys_sleep+0x90>
    if(myproc()->killed){
80106331:	e8 6a da ff ff       	call   80103da0 <myproc>
80106336:	8b 40 24             	mov    0x24(%eax),%eax
80106339:	85 c0                	test   %eax,%eax
8010633b:	74 d3                	je     80106310 <sys_sleep+0x40>
      release(&tickslock);
8010633d:	83 ec 0c             	sub    $0xc,%esp
80106340:	68 40 6b 11 80       	push   $0x80116b40
80106345:	e8 16 ee ff ff       	call   80105160 <release>
  }
  release(&tickslock);
  return 0;
}
8010634a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return -1;
8010634d:	83 c4 10             	add    $0x10,%esp
80106350:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106355:	c9                   	leave  
80106356:	c3                   	ret    
80106357:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010635e:	66 90                	xchg   %ax,%ax
  release(&tickslock);
80106360:	83 ec 0c             	sub    $0xc,%esp
80106363:	68 40 6b 11 80       	push   $0x80116b40
80106368:	e8 f3 ed ff ff       	call   80105160 <release>
  return 0;
8010636d:	83 c4 10             	add    $0x10,%esp
80106370:	31 c0                	xor    %eax,%eax
}
80106372:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106375:	c9                   	leave  
80106376:	c3                   	ret    
    return -1;
80106377:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010637c:	eb f4                	jmp    80106372 <sys_sleep+0xa2>
8010637e:	66 90                	xchg   %ax,%ax

80106380 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80106380:	f3 0f 1e fb          	endbr32 
80106384:	55                   	push   %ebp
80106385:	89 e5                	mov    %esp,%ebp
80106387:	53                   	push   %ebx
80106388:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
8010638b:	68 40 6b 11 80       	push   $0x80116b40
80106390:	e8 0b ed ff ff       	call   801050a0 <acquire>
  xticks = ticks;
80106395:	8b 1d 80 73 11 80    	mov    0x80117380,%ebx
  release(&tickslock);
8010639b:	c7 04 24 40 6b 11 80 	movl   $0x80116b40,(%esp)
801063a2:	e8 b9 ed ff ff       	call   80105160 <release>
  return xticks;
}
801063a7:	89 d8                	mov    %ebx,%eax
801063a9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801063ac:	c9                   	leave  
801063ad:	c3                   	ret    
801063ae:	66 90                	xchg   %ax,%ax

801063b0 <sys_changeQueue>:

int sys_changeQueue(void) {
801063b0:	f3 0f 1e fb          	endbr32 
801063b4:	55                   	push   %ebp
801063b5:	89 e5                	mov    %esp,%ebp
801063b7:	83 ec 20             	sub    $0x20,%esp
  int pid, queue;
  if (argint(0, &pid) < 0) 
801063ba:	8d 45 f0             	lea    -0x10(%ebp),%eax
801063bd:	50                   	push   %eax
801063be:	6a 00                	push   $0x0
801063c0:	e8 cb f0 ff ff       	call   80105490 <argint>
801063c5:	83 c4 10             	add    $0x10,%esp
801063c8:	85 c0                	test   %eax,%eax
801063ca:	78 2c                	js     801063f8 <sys_changeQueue+0x48>
    return -1;
  if (argint(1, &queue) < 0) 
801063cc:	83 ec 08             	sub    $0x8,%esp
801063cf:	8d 45 f4             	lea    -0xc(%ebp),%eax
801063d2:	50                   	push   %eax
801063d3:	6a 01                	push   $0x1
801063d5:	e8 b6 f0 ff ff       	call   80105490 <argint>
801063da:	83 c4 10             	add    $0x10,%esp
801063dd:	85 c0                	test   %eax,%eax
801063df:	78 17                	js     801063f8 <sys_changeQueue+0x48>
    return -1;
  return changeQueue(pid, queue);
801063e1:	83 ec 08             	sub    $0x8,%esp
801063e4:	ff 75 f4             	pushl  -0xc(%ebp)
801063e7:	ff 75 f0             	pushl  -0x10(%ebp)
801063ea:	e8 81 dd ff ff       	call   80104170 <changeQueue>
801063ef:	83 c4 10             	add    $0x10,%esp
}
801063f2:	c9                   	leave  
801063f3:	c3                   	ret    
801063f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801063f8:	c9                   	leave  
    return -1;
801063f9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801063fe:	c3                   	ret    
801063ff:	90                   	nop

80106400 <sys_printProcess>:

int sys_printProcess(void) {
80106400:	f3 0f 1e fb          	endbr32 
  return printProcess();
80106404:	e9 b7 dd ff ff       	jmp    801041c0 <printProcess>
80106409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106410 <sys_changeProcessMHRRN>:
}

int sys_changeProcessMHRRN(void) {
80106410:	f3 0f 1e fb          	endbr32 
80106414:	55                   	push   %ebp
80106415:	89 e5                	mov    %esp,%ebp
80106417:	83 ec 20             	sub    $0x20,%esp
  int pid, priority;
  if (argint(0, &pid) < 0) 
8010641a:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010641d:	50                   	push   %eax
8010641e:	6a 00                	push   $0x0
80106420:	e8 6b f0 ff ff       	call   80105490 <argint>
80106425:	83 c4 10             	add    $0x10,%esp
80106428:	85 c0                	test   %eax,%eax
8010642a:	78 2c                	js     80106458 <sys_changeProcessMHRRN+0x48>
    return -1;
  if (argint(1, &priority) < 0) 
8010642c:	83 ec 08             	sub    $0x8,%esp
8010642f:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106432:	50                   	push   %eax
80106433:	6a 01                	push   $0x1
80106435:	e8 56 f0 ff ff       	call   80105490 <argint>
8010643a:	83 c4 10             	add    $0x10,%esp
8010643d:	85 c0                	test   %eax,%eax
8010643f:	78 17                	js     80106458 <sys_changeProcessMHRRN+0x48>
    return -1;
  return changeProcessMHRRN(pid, priority);
80106441:	83 ec 08             	sub    $0x8,%esp
80106444:	ff 75 f4             	pushl  -0xc(%ebp)
80106447:	ff 75 f0             	pushl  -0x10(%ebp)
8010644a:	e8 51 dc ff ff       	call   801040a0 <changeProcessMHRRN>
8010644f:	83 c4 10             	add    $0x10,%esp
}
80106452:	c9                   	leave  
80106453:	c3                   	ret    
80106454:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106458:	c9                   	leave  
    return -1;
80106459:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010645e:	c3                   	ret    
8010645f:	90                   	nop

80106460 <sys_changeSystemMHRRN>:

int sys_changeSystemMHRRN(void) {
80106460:	f3 0f 1e fb          	endbr32 
80106464:	55                   	push   %ebp
80106465:	89 e5                	mov    %esp,%ebp
80106467:	83 ec 20             	sub    $0x20,%esp
  int priority;
  if (argint(0, &priority) < 0) 
8010646a:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010646d:	50                   	push   %eax
8010646e:	6a 00                	push   $0x0
80106470:	e8 1b f0 ff ff       	call   80105490 <argint>
80106475:	83 c4 10             	add    $0x10,%esp
80106478:	85 c0                	test   %eax,%eax
8010647a:	78 14                	js     80106490 <sys_changeSystemMHRRN+0x30>
    return -1;
  return changeSystemMHRRN(priority);
8010647c:	83 ec 0c             	sub    $0xc,%esp
8010647f:	ff 75 f4             	pushl  -0xc(%ebp)
80106482:	e8 99 dc ff ff       	call   80104120 <changeSystemMHRRN>
80106487:	83 c4 10             	add    $0x10,%esp
}
8010648a:	c9                   	leave  
8010648b:	c3                   	ret    
8010648c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106490:	c9                   	leave  
    return -1;
80106491:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106496:	c3                   	ret    
80106497:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010649e:	66 90                	xchg   %ax,%ax

801064a0 <sys_sem_init>:

int sys_sem_init(void)
{
801064a0:	f3 0f 1e fb          	endbr32 
801064a4:	55                   	push   %ebp
801064a5:	89 e5                	mov    %esp,%ebp
801064a7:	83 ec 20             	sub    $0x20,%esp
  int i, v;
  if (argint(0, &i) < 0) 
801064aa:	8d 45 f0             	lea    -0x10(%ebp),%eax
801064ad:	50                   	push   %eax
801064ae:	6a 00                	push   $0x0
801064b0:	e8 db ef ff ff       	call   80105490 <argint>
801064b5:	83 c4 10             	add    $0x10,%esp
801064b8:	85 c0                	test   %eax,%eax
801064ba:	78 2c                	js     801064e8 <sys_sem_init+0x48>
    return -1;
  if (argint(1, &v) < 0) 
801064bc:	83 ec 08             	sub    $0x8,%esp
801064bf:	8d 45 f4             	lea    -0xc(%ebp),%eax
801064c2:	50                   	push   %eax
801064c3:	6a 01                	push   $0x1
801064c5:	e8 c6 ef ff ff       	call   80105490 <argint>
801064ca:	83 c4 10             	add    $0x10,%esp
801064cd:	85 c0                	test   %eax,%eax
801064cf:	78 17                	js     801064e8 <sys_sem_init+0x48>
    return -1;
  return sem_init(i, v);
801064d1:	83 ec 08             	sub    $0x8,%esp
801064d4:	ff 75 f4             	pushl  -0xc(%ebp)
801064d7:	ff 75 f0             	pushl  -0x10(%ebp)
801064da:	e8 61 e7 ff ff       	call   80104c40 <sem_init>
801064df:	83 c4 10             	add    $0x10,%esp
}
801064e2:	c9                   	leave  
801064e3:	c3                   	ret    
801064e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801064e8:	c9                   	leave  
    return -1;
801064e9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801064ee:	c3                   	ret    
801064ef:	90                   	nop

801064f0 <sys_sem_acquire>:

int sys_sem_acquire(void)
{
801064f0:	f3 0f 1e fb          	endbr32 
801064f4:	55                   	push   %ebp
801064f5:	89 e5                	mov    %esp,%ebp
801064f7:	83 ec 20             	sub    $0x20,%esp
  int i;
  if (argint(0, &i) < 0) 
801064fa:	8d 45 f4             	lea    -0xc(%ebp),%eax
801064fd:	50                   	push   %eax
801064fe:	6a 00                	push   $0x0
80106500:	e8 8b ef ff ff       	call   80105490 <argint>
80106505:	83 c4 10             	add    $0x10,%esp
80106508:	85 c0                	test   %eax,%eax
8010650a:	78 14                	js     80106520 <sys_sem_acquire+0x30>
    return -1;

  return sem_acquire(i);
8010650c:	83 ec 0c             	sub    $0xc,%esp
8010650f:	ff 75 f4             	pushl  -0xc(%ebp)
80106512:	e8 59 e7 ff ff       	call   80104c70 <sem_acquire>
80106517:	83 c4 10             	add    $0x10,%esp
}
8010651a:	c9                   	leave  
8010651b:	c3                   	ret    
8010651c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106520:	c9                   	leave  
    return -1;
80106521:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106526:	c3                   	ret    
80106527:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010652e:	66 90                	xchg   %ax,%ax

80106530 <sys_sem_release>:

int sys_sem_release(void)
{
80106530:	f3 0f 1e fb          	endbr32 
80106534:	55                   	push   %ebp
80106535:	89 e5                	mov    %esp,%ebp
80106537:	83 ec 20             	sub    $0x20,%esp
  int i;
  if (argint(0, &i) < 0) 
8010653a:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010653d:	50                   	push   %eax
8010653e:	6a 00                	push   $0x0
80106540:	e8 4b ef ff ff       	call   80105490 <argint>
80106545:	83 c4 10             	add    $0x10,%esp
80106548:	85 c0                	test   %eax,%eax
8010654a:	78 14                	js     80106560 <sys_sem_release+0x30>
    return -1;
  return sem_release(i);
8010654c:	83 ec 0c             	sub    $0xc,%esp
8010654f:	ff 75 f4             	pushl  -0xc(%ebp)
80106552:	e8 d9 e7 ff ff       	call   80104d30 <sem_release>
80106557:	83 c4 10             	add    $0x10,%esp
}
8010655a:	c9                   	leave  
8010655b:	c3                   	ret    
8010655c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106560:	c9                   	leave  
    return -1;
80106561:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106566:	c3                   	ret    

80106567 <alltraps>:
80106567:	1e                   	push   %ds
80106568:	06                   	push   %es
80106569:	0f a0                	push   %fs
8010656b:	0f a8                	push   %gs
8010656d:	60                   	pusha  
8010656e:	66 b8 10 00          	mov    $0x10,%ax
80106572:	8e d8                	mov    %eax,%ds
80106574:	8e c0                	mov    %eax,%es
80106576:	54                   	push   %esp
80106577:	e8 c4 00 00 00       	call   80106640 <trap>
8010657c:	83 c4 04             	add    $0x4,%esp

8010657f <trapret>:
8010657f:	61                   	popa   
80106580:	0f a9                	pop    %gs
80106582:	0f a1                	pop    %fs
80106584:	07                   	pop    %es
80106585:	1f                   	pop    %ds
80106586:	83 c4 08             	add    $0x8,%esp
80106589:	cf                   	iret   
8010658a:	66 90                	xchg   %ax,%ax
8010658c:	66 90                	xchg   %ax,%ax
8010658e:	66 90                	xchg   %ax,%ax

80106590 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106590:	f3 0f 1e fb          	endbr32 
80106594:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80106595:	31 c0                	xor    %eax,%eax
{
80106597:	89 e5                	mov    %esp,%ebp
80106599:	83 ec 08             	sub    $0x8,%esp
8010659c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
801065a0:	8b 14 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%edx
801065a7:	c7 04 c5 82 6b 11 80 	movl   $0x8e000008,-0x7fee947e(,%eax,8)
801065ae:	08 00 00 8e 
801065b2:	66 89 14 c5 80 6b 11 	mov    %dx,-0x7fee9480(,%eax,8)
801065b9:	80 
801065ba:	c1 ea 10             	shr    $0x10,%edx
801065bd:	66 89 14 c5 86 6b 11 	mov    %dx,-0x7fee947a(,%eax,8)
801065c4:	80 
  for(i = 0; i < 256; i++)
801065c5:	83 c0 01             	add    $0x1,%eax
801065c8:	3d 00 01 00 00       	cmp    $0x100,%eax
801065cd:	75 d1                	jne    801065a0 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
801065cf:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801065d2:	a1 08 b1 10 80       	mov    0x8010b108,%eax
801065d7:	c7 05 82 6d 11 80 08 	movl   $0xef000008,0x80116d82
801065de:	00 00 ef 
  initlock(&tickslock, "time");
801065e1:	68 d5 86 10 80       	push   $0x801086d5
801065e6:	68 40 6b 11 80       	push   $0x80116b40
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801065eb:	66 a3 80 6d 11 80    	mov    %ax,0x80116d80
801065f1:	c1 e8 10             	shr    $0x10,%eax
801065f4:	66 a3 86 6d 11 80    	mov    %ax,0x80116d86
  initlock(&tickslock, "time");
801065fa:	e8 21 e9 ff ff       	call   80104f20 <initlock>
}
801065ff:	83 c4 10             	add    $0x10,%esp
80106602:	c9                   	leave  
80106603:	c3                   	ret    
80106604:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010660b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010660f:	90                   	nop

80106610 <idtinit>:

void
idtinit(void)
{
80106610:	f3 0f 1e fb          	endbr32 
80106614:	55                   	push   %ebp
  pd[0] = size-1;
80106615:	b8 ff 07 00 00       	mov    $0x7ff,%eax
8010661a:	89 e5                	mov    %esp,%ebp
8010661c:	83 ec 10             	sub    $0x10,%esp
8010661f:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80106623:	b8 80 6b 11 80       	mov    $0x80116b80,%eax
80106628:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
8010662c:	c1 e8 10             	shr    $0x10,%eax
8010662f:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80106633:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106636:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80106639:	c9                   	leave  
8010663a:	c3                   	ret    
8010663b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010663f:	90                   	nop

80106640 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80106640:	f3 0f 1e fb          	endbr32 
80106644:	55                   	push   %ebp
80106645:	89 e5                	mov    %esp,%ebp
80106647:	57                   	push   %edi
80106648:	56                   	push   %esi
80106649:	53                   	push   %ebx
8010664a:	83 ec 1c             	sub    $0x1c,%esp
8010664d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
80106650:	8b 43 30             	mov    0x30(%ebx),%eax
80106653:	83 f8 40             	cmp    $0x40,%eax
80106656:	0f 84 bc 01 00 00    	je     80106818 <trap+0x1d8>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
8010665c:	83 e8 20             	sub    $0x20,%eax
8010665f:	83 f8 1f             	cmp    $0x1f,%eax
80106662:	77 08                	ja     8010666c <trap+0x2c>
80106664:	3e ff 24 85 7c 87 10 	notrack jmp *-0x7fef7884(,%eax,4)
8010666b:	80 
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
8010666c:	e8 2f d7 ff ff       	call   80103da0 <myproc>
80106671:	8b 7b 38             	mov    0x38(%ebx),%edi
80106674:	85 c0                	test   %eax,%eax
80106676:	0f 84 eb 01 00 00    	je     80106867 <trap+0x227>
8010667c:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80106680:	0f 84 e1 01 00 00    	je     80106867 <trap+0x227>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80106686:	0f 20 d1             	mov    %cr2,%ecx
80106689:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010668c:	e8 ef d6 ff ff       	call   80103d80 <cpuid>
80106691:	8b 73 30             	mov    0x30(%ebx),%esi
80106694:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106697:	8b 43 34             	mov    0x34(%ebx),%eax
8010669a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
8010669d:	e8 fe d6 ff ff       	call   80103da0 <myproc>
801066a2:	89 45 e0             	mov    %eax,-0x20(%ebp)
801066a5:	e8 f6 d6 ff ff       	call   80103da0 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801066aa:	8b 4d d8             	mov    -0x28(%ebp),%ecx
801066ad:	8b 55 dc             	mov    -0x24(%ebp),%edx
801066b0:	51                   	push   %ecx
801066b1:	57                   	push   %edi
801066b2:	52                   	push   %edx
801066b3:	ff 75 e4             	pushl  -0x1c(%ebp)
801066b6:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
801066b7:	8b 75 e0             	mov    -0x20(%ebp),%esi
801066ba:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801066bd:	56                   	push   %esi
801066be:	ff 70 10             	pushl  0x10(%eax)
801066c1:	68 38 87 10 80       	push   $0x80108738
801066c6:	e8 e5 9f ff ff       	call   801006b0 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
801066cb:	83 c4 20             	add    $0x20,%esp
801066ce:	e8 cd d6 ff ff       	call   80103da0 <myproc>
801066d3:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801066da:	e8 c1 d6 ff ff       	call   80103da0 <myproc>
801066df:	85 c0                	test   %eax,%eax
801066e1:	74 1d                	je     80106700 <trap+0xc0>
801066e3:	e8 b8 d6 ff ff       	call   80103da0 <myproc>
801066e8:	8b 50 24             	mov    0x24(%eax),%edx
801066eb:	85 d2                	test   %edx,%edx
801066ed:	74 11                	je     80106700 <trap+0xc0>
801066ef:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
801066f3:	83 e0 03             	and    $0x3,%eax
801066f6:	66 83 f8 03          	cmp    $0x3,%ax
801066fa:	0f 84 50 01 00 00    	je     80106850 <trap+0x210>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80106700:	e8 9b d6 ff ff       	call   80103da0 <myproc>
80106705:	85 c0                	test   %eax,%eax
80106707:	74 0f                	je     80106718 <trap+0xd8>
80106709:	e8 92 d6 ff ff       	call   80103da0 <myproc>
8010670e:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80106712:	0f 84 e8 00 00 00    	je     80106800 <trap+0x1c0>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106718:	e8 83 d6 ff ff       	call   80103da0 <myproc>
8010671d:	85 c0                	test   %eax,%eax
8010671f:	74 1d                	je     8010673e <trap+0xfe>
80106721:	e8 7a d6 ff ff       	call   80103da0 <myproc>
80106726:	8b 40 24             	mov    0x24(%eax),%eax
80106729:	85 c0                	test   %eax,%eax
8010672b:	74 11                	je     8010673e <trap+0xfe>
8010672d:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80106731:	83 e0 03             	and    $0x3,%eax
80106734:	66 83 f8 03          	cmp    $0x3,%ax
80106738:	0f 84 03 01 00 00    	je     80106841 <trap+0x201>
    exit();
}
8010673e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106741:	5b                   	pop    %ebx
80106742:	5e                   	pop    %esi
80106743:	5f                   	pop    %edi
80106744:	5d                   	pop    %ebp
80106745:	c3                   	ret    
    ideintr();
80106746:	e8 75 be ff ff       	call   801025c0 <ideintr>
    lapiceoi();
8010674b:	e8 50 c5 ff ff       	call   80102ca0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106750:	e8 4b d6 ff ff       	call   80103da0 <myproc>
80106755:	85 c0                	test   %eax,%eax
80106757:	75 8a                	jne    801066e3 <trap+0xa3>
80106759:	eb a5                	jmp    80106700 <trap+0xc0>
    if(cpuid() == 0){
8010675b:	e8 20 d6 ff ff       	call   80103d80 <cpuid>
80106760:	85 c0                	test   %eax,%eax
80106762:	75 e7                	jne    8010674b <trap+0x10b>
      acquire(&tickslock);
80106764:	83 ec 0c             	sub    $0xc,%esp
80106767:	68 40 6b 11 80       	push   $0x80116b40
8010676c:	e8 2f e9 ff ff       	call   801050a0 <acquire>
      wakeup(&ticks);
80106771:	c7 04 24 80 73 11 80 	movl   $0x80117380,(%esp)
      ticks++;
80106778:	83 05 80 73 11 80 01 	addl   $0x1,0x80117380
      wakeup(&ticks);
8010677f:	e8 5c e2 ff ff       	call   801049e0 <wakeup>
      release(&tickslock);
80106784:	c7 04 24 40 6b 11 80 	movl   $0x80116b40,(%esp)
8010678b:	e8 d0 e9 ff ff       	call   80105160 <release>
80106790:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
80106793:	eb b6                	jmp    8010674b <trap+0x10b>
    kbdintr();
80106795:	e8 c6 c3 ff ff       	call   80102b60 <kbdintr>
    lapiceoi();
8010679a:	e8 01 c5 ff ff       	call   80102ca0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010679f:	e8 fc d5 ff ff       	call   80103da0 <myproc>
801067a4:	85 c0                	test   %eax,%eax
801067a6:	0f 85 37 ff ff ff    	jne    801066e3 <trap+0xa3>
801067ac:	e9 4f ff ff ff       	jmp    80106700 <trap+0xc0>
    uartintr();
801067b1:	e8 4a 02 00 00       	call   80106a00 <uartintr>
    lapiceoi();
801067b6:	e8 e5 c4 ff ff       	call   80102ca0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801067bb:	e8 e0 d5 ff ff       	call   80103da0 <myproc>
801067c0:	85 c0                	test   %eax,%eax
801067c2:	0f 85 1b ff ff ff    	jne    801066e3 <trap+0xa3>
801067c8:	e9 33 ff ff ff       	jmp    80106700 <trap+0xc0>
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801067cd:	8b 7b 38             	mov    0x38(%ebx),%edi
801067d0:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
801067d4:	e8 a7 d5 ff ff       	call   80103d80 <cpuid>
801067d9:	57                   	push   %edi
801067da:	56                   	push   %esi
801067db:	50                   	push   %eax
801067dc:	68 e0 86 10 80       	push   $0x801086e0
801067e1:	e8 ca 9e ff ff       	call   801006b0 <cprintf>
    lapiceoi();
801067e6:	e8 b5 c4 ff ff       	call   80102ca0 <lapiceoi>
    break;
801067eb:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801067ee:	e8 ad d5 ff ff       	call   80103da0 <myproc>
801067f3:	85 c0                	test   %eax,%eax
801067f5:	0f 85 e8 fe ff ff    	jne    801066e3 <trap+0xa3>
801067fb:	e9 00 ff ff ff       	jmp    80106700 <trap+0xc0>
  if(myproc() && myproc()->state == RUNNING &&
80106800:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80106804:	0f 85 0e ff ff ff    	jne    80106718 <trap+0xd8>
    yield();
8010680a:	e8 c1 df ff ff       	call   801047d0 <yield>
8010680f:	e9 04 ff ff ff       	jmp    80106718 <trap+0xd8>
80106814:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
80106818:	e8 83 d5 ff ff       	call   80103da0 <myproc>
8010681d:	8b 70 24             	mov    0x24(%eax),%esi
80106820:	85 f6                	test   %esi,%esi
80106822:	75 3c                	jne    80106860 <trap+0x220>
    myproc()->tf = tf;
80106824:	e8 77 d5 ff ff       	call   80103da0 <myproc>
80106829:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
8010682c:	e8 4f ed ff ff       	call   80105580 <syscall>
    if(myproc()->killed)
80106831:	e8 6a d5 ff ff       	call   80103da0 <myproc>
80106836:	8b 48 24             	mov    0x24(%eax),%ecx
80106839:	85 c9                	test   %ecx,%ecx
8010683b:	0f 84 fd fe ff ff    	je     8010673e <trap+0xfe>
}
80106841:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106844:	5b                   	pop    %ebx
80106845:	5e                   	pop    %esi
80106846:	5f                   	pop    %edi
80106847:	5d                   	pop    %ebp
      exit();
80106848:	e9 43 de ff ff       	jmp    80104690 <exit>
8010684d:	8d 76 00             	lea    0x0(%esi),%esi
    exit();
80106850:	e8 3b de ff ff       	call   80104690 <exit>
80106855:	e9 a6 fe ff ff       	jmp    80106700 <trap+0xc0>
8010685a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80106860:	e8 2b de ff ff       	call   80104690 <exit>
80106865:	eb bd                	jmp    80106824 <trap+0x1e4>
80106867:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
8010686a:	e8 11 d5 ff ff       	call   80103d80 <cpuid>
8010686f:	83 ec 0c             	sub    $0xc,%esp
80106872:	56                   	push   %esi
80106873:	57                   	push   %edi
80106874:	50                   	push   %eax
80106875:	ff 73 30             	pushl  0x30(%ebx)
80106878:	68 04 87 10 80       	push   $0x80108704
8010687d:	e8 2e 9e ff ff       	call   801006b0 <cprintf>
      panic("trap");
80106882:	83 c4 14             	add    $0x14,%esp
80106885:	68 da 86 10 80       	push   $0x801086da
8010688a:	e8 01 9b ff ff       	call   80100390 <panic>
8010688f:	90                   	nop

80106890 <uartgetc>:
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
80106890:	f3 0f 1e fb          	endbr32 
  if(!uart)
80106894:	a1 e4 b5 10 80       	mov    0x8010b5e4,%eax
80106899:	85 c0                	test   %eax,%eax
8010689b:	74 1b                	je     801068b8 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010689d:	ba fd 03 00 00       	mov    $0x3fd,%edx
801068a2:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
801068a3:	a8 01                	test   $0x1,%al
801068a5:	74 11                	je     801068b8 <uartgetc+0x28>
801068a7:	ba f8 03 00 00       	mov    $0x3f8,%edx
801068ac:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
801068ad:	0f b6 c0             	movzbl %al,%eax
801068b0:	c3                   	ret    
801068b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801068b8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801068bd:	c3                   	ret    
801068be:	66 90                	xchg   %ax,%ax

801068c0 <uartputc.part.0>:
uartputc(int c)
801068c0:	55                   	push   %ebp
801068c1:	89 e5                	mov    %esp,%ebp
801068c3:	57                   	push   %edi
801068c4:	89 c7                	mov    %eax,%edi
801068c6:	56                   	push   %esi
801068c7:	be fd 03 00 00       	mov    $0x3fd,%esi
801068cc:	53                   	push   %ebx
801068cd:	bb 80 00 00 00       	mov    $0x80,%ebx
801068d2:	83 ec 0c             	sub    $0xc,%esp
801068d5:	eb 1b                	jmp    801068f2 <uartputc.part.0+0x32>
801068d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801068de:	66 90                	xchg   %ax,%ax
    microdelay(10);
801068e0:	83 ec 0c             	sub    $0xc,%esp
801068e3:	6a 0a                	push   $0xa
801068e5:	e8 d6 c3 ff ff       	call   80102cc0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801068ea:	83 c4 10             	add    $0x10,%esp
801068ed:	83 eb 01             	sub    $0x1,%ebx
801068f0:	74 07                	je     801068f9 <uartputc.part.0+0x39>
801068f2:	89 f2                	mov    %esi,%edx
801068f4:	ec                   	in     (%dx),%al
801068f5:	a8 20                	test   $0x20,%al
801068f7:	74 e7                	je     801068e0 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801068f9:	ba f8 03 00 00       	mov    $0x3f8,%edx
801068fe:	89 f8                	mov    %edi,%eax
80106900:	ee                   	out    %al,(%dx)
}
80106901:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106904:	5b                   	pop    %ebx
80106905:	5e                   	pop    %esi
80106906:	5f                   	pop    %edi
80106907:	5d                   	pop    %ebp
80106908:	c3                   	ret    
80106909:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106910 <uartinit>:
{
80106910:	f3 0f 1e fb          	endbr32 
80106914:	55                   	push   %ebp
80106915:	31 c9                	xor    %ecx,%ecx
80106917:	89 c8                	mov    %ecx,%eax
80106919:	89 e5                	mov    %esp,%ebp
8010691b:	57                   	push   %edi
8010691c:	56                   	push   %esi
8010691d:	53                   	push   %ebx
8010691e:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80106923:	89 da                	mov    %ebx,%edx
80106925:	83 ec 0c             	sub    $0xc,%esp
80106928:	ee                   	out    %al,(%dx)
80106929:	bf fb 03 00 00       	mov    $0x3fb,%edi
8010692e:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80106933:	89 fa                	mov    %edi,%edx
80106935:	ee                   	out    %al,(%dx)
80106936:	b8 0c 00 00 00       	mov    $0xc,%eax
8010693b:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106940:	ee                   	out    %al,(%dx)
80106941:	be f9 03 00 00       	mov    $0x3f9,%esi
80106946:	89 c8                	mov    %ecx,%eax
80106948:	89 f2                	mov    %esi,%edx
8010694a:	ee                   	out    %al,(%dx)
8010694b:	b8 03 00 00 00       	mov    $0x3,%eax
80106950:	89 fa                	mov    %edi,%edx
80106952:	ee                   	out    %al,(%dx)
80106953:	ba fc 03 00 00       	mov    $0x3fc,%edx
80106958:	89 c8                	mov    %ecx,%eax
8010695a:	ee                   	out    %al,(%dx)
8010695b:	b8 01 00 00 00       	mov    $0x1,%eax
80106960:	89 f2                	mov    %esi,%edx
80106962:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106963:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106968:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80106969:	3c ff                	cmp    $0xff,%al
8010696b:	74 52                	je     801069bf <uartinit+0xaf>
  uart = 1;
8010696d:	c7 05 e4 b5 10 80 01 	movl   $0x1,0x8010b5e4
80106974:	00 00 00 
80106977:	89 da                	mov    %ebx,%edx
80106979:	ec                   	in     (%dx),%al
8010697a:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010697f:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80106980:	83 ec 08             	sub    $0x8,%esp
80106983:	be 76 00 00 00       	mov    $0x76,%esi
  for(p="xv6...\n"; *p; p++)
80106988:	bb fc 87 10 80       	mov    $0x801087fc,%ebx
  ioapicenable(IRQ_COM1, 0);
8010698d:	6a 00                	push   $0x0
8010698f:	6a 04                	push   $0x4
80106991:	e8 7a be ff ff       	call   80102810 <ioapicenable>
80106996:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80106999:	b8 78 00 00 00       	mov    $0x78,%eax
8010699e:	eb 04                	jmp    801069a4 <uartinit+0x94>
801069a0:	0f b6 73 01          	movzbl 0x1(%ebx),%esi
  if(!uart)
801069a4:	8b 15 e4 b5 10 80    	mov    0x8010b5e4,%edx
801069aa:	85 d2                	test   %edx,%edx
801069ac:	74 08                	je     801069b6 <uartinit+0xa6>
    uartputc(*p);
801069ae:	0f be c0             	movsbl %al,%eax
801069b1:	e8 0a ff ff ff       	call   801068c0 <uartputc.part.0>
  for(p="xv6...\n"; *p; p++)
801069b6:	89 f0                	mov    %esi,%eax
801069b8:	83 c3 01             	add    $0x1,%ebx
801069bb:	84 c0                	test   %al,%al
801069bd:	75 e1                	jne    801069a0 <uartinit+0x90>
}
801069bf:	8d 65 f4             	lea    -0xc(%ebp),%esp
801069c2:	5b                   	pop    %ebx
801069c3:	5e                   	pop    %esi
801069c4:	5f                   	pop    %edi
801069c5:	5d                   	pop    %ebp
801069c6:	c3                   	ret    
801069c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801069ce:	66 90                	xchg   %ax,%ax

801069d0 <uartputc>:
{
801069d0:	f3 0f 1e fb          	endbr32 
801069d4:	55                   	push   %ebp
  if(!uart)
801069d5:	8b 15 e4 b5 10 80    	mov    0x8010b5e4,%edx
{
801069db:	89 e5                	mov    %esp,%ebp
801069dd:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
801069e0:	85 d2                	test   %edx,%edx
801069e2:	74 0c                	je     801069f0 <uartputc+0x20>
}
801069e4:	5d                   	pop    %ebp
801069e5:	e9 d6 fe ff ff       	jmp    801068c0 <uartputc.part.0>
801069ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801069f0:	5d                   	pop    %ebp
801069f1:	c3                   	ret    
801069f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801069f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106a00 <uartintr>:

void
uartintr(void)
{
80106a00:	f3 0f 1e fb          	endbr32 
80106a04:	55                   	push   %ebp
80106a05:	89 e5                	mov    %esp,%ebp
80106a07:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80106a0a:	68 90 68 10 80       	push   $0x80106890
80106a0f:	e8 ac 9e ff ff       	call   801008c0 <consoleintr>
}
80106a14:	83 c4 10             	add    $0x10,%esp
80106a17:	c9                   	leave  
80106a18:	c3                   	ret    

80106a19 <vector0>:
80106a19:	6a 00                	push   $0x0
80106a1b:	6a 00                	push   $0x0
80106a1d:	e9 45 fb ff ff       	jmp    80106567 <alltraps>

80106a22 <vector1>:
80106a22:	6a 00                	push   $0x0
80106a24:	6a 01                	push   $0x1
80106a26:	e9 3c fb ff ff       	jmp    80106567 <alltraps>

80106a2b <vector2>:
80106a2b:	6a 00                	push   $0x0
80106a2d:	6a 02                	push   $0x2
80106a2f:	e9 33 fb ff ff       	jmp    80106567 <alltraps>

80106a34 <vector3>:
80106a34:	6a 00                	push   $0x0
80106a36:	6a 03                	push   $0x3
80106a38:	e9 2a fb ff ff       	jmp    80106567 <alltraps>

80106a3d <vector4>:
80106a3d:	6a 00                	push   $0x0
80106a3f:	6a 04                	push   $0x4
80106a41:	e9 21 fb ff ff       	jmp    80106567 <alltraps>

80106a46 <vector5>:
80106a46:	6a 00                	push   $0x0
80106a48:	6a 05                	push   $0x5
80106a4a:	e9 18 fb ff ff       	jmp    80106567 <alltraps>

80106a4f <vector6>:
80106a4f:	6a 00                	push   $0x0
80106a51:	6a 06                	push   $0x6
80106a53:	e9 0f fb ff ff       	jmp    80106567 <alltraps>

80106a58 <vector7>:
80106a58:	6a 00                	push   $0x0
80106a5a:	6a 07                	push   $0x7
80106a5c:	e9 06 fb ff ff       	jmp    80106567 <alltraps>

80106a61 <vector8>:
80106a61:	6a 08                	push   $0x8
80106a63:	e9 ff fa ff ff       	jmp    80106567 <alltraps>

80106a68 <vector9>:
80106a68:	6a 00                	push   $0x0
80106a6a:	6a 09                	push   $0x9
80106a6c:	e9 f6 fa ff ff       	jmp    80106567 <alltraps>

80106a71 <vector10>:
80106a71:	6a 0a                	push   $0xa
80106a73:	e9 ef fa ff ff       	jmp    80106567 <alltraps>

80106a78 <vector11>:
80106a78:	6a 0b                	push   $0xb
80106a7a:	e9 e8 fa ff ff       	jmp    80106567 <alltraps>

80106a7f <vector12>:
80106a7f:	6a 0c                	push   $0xc
80106a81:	e9 e1 fa ff ff       	jmp    80106567 <alltraps>

80106a86 <vector13>:
80106a86:	6a 0d                	push   $0xd
80106a88:	e9 da fa ff ff       	jmp    80106567 <alltraps>

80106a8d <vector14>:
80106a8d:	6a 0e                	push   $0xe
80106a8f:	e9 d3 fa ff ff       	jmp    80106567 <alltraps>

80106a94 <vector15>:
80106a94:	6a 00                	push   $0x0
80106a96:	6a 0f                	push   $0xf
80106a98:	e9 ca fa ff ff       	jmp    80106567 <alltraps>

80106a9d <vector16>:
80106a9d:	6a 00                	push   $0x0
80106a9f:	6a 10                	push   $0x10
80106aa1:	e9 c1 fa ff ff       	jmp    80106567 <alltraps>

80106aa6 <vector17>:
80106aa6:	6a 11                	push   $0x11
80106aa8:	e9 ba fa ff ff       	jmp    80106567 <alltraps>

80106aad <vector18>:
80106aad:	6a 00                	push   $0x0
80106aaf:	6a 12                	push   $0x12
80106ab1:	e9 b1 fa ff ff       	jmp    80106567 <alltraps>

80106ab6 <vector19>:
80106ab6:	6a 00                	push   $0x0
80106ab8:	6a 13                	push   $0x13
80106aba:	e9 a8 fa ff ff       	jmp    80106567 <alltraps>

80106abf <vector20>:
80106abf:	6a 00                	push   $0x0
80106ac1:	6a 14                	push   $0x14
80106ac3:	e9 9f fa ff ff       	jmp    80106567 <alltraps>

80106ac8 <vector21>:
80106ac8:	6a 00                	push   $0x0
80106aca:	6a 15                	push   $0x15
80106acc:	e9 96 fa ff ff       	jmp    80106567 <alltraps>

80106ad1 <vector22>:
80106ad1:	6a 00                	push   $0x0
80106ad3:	6a 16                	push   $0x16
80106ad5:	e9 8d fa ff ff       	jmp    80106567 <alltraps>

80106ada <vector23>:
80106ada:	6a 00                	push   $0x0
80106adc:	6a 17                	push   $0x17
80106ade:	e9 84 fa ff ff       	jmp    80106567 <alltraps>

80106ae3 <vector24>:
80106ae3:	6a 00                	push   $0x0
80106ae5:	6a 18                	push   $0x18
80106ae7:	e9 7b fa ff ff       	jmp    80106567 <alltraps>

80106aec <vector25>:
80106aec:	6a 00                	push   $0x0
80106aee:	6a 19                	push   $0x19
80106af0:	e9 72 fa ff ff       	jmp    80106567 <alltraps>

80106af5 <vector26>:
80106af5:	6a 00                	push   $0x0
80106af7:	6a 1a                	push   $0x1a
80106af9:	e9 69 fa ff ff       	jmp    80106567 <alltraps>

80106afe <vector27>:
80106afe:	6a 00                	push   $0x0
80106b00:	6a 1b                	push   $0x1b
80106b02:	e9 60 fa ff ff       	jmp    80106567 <alltraps>

80106b07 <vector28>:
80106b07:	6a 00                	push   $0x0
80106b09:	6a 1c                	push   $0x1c
80106b0b:	e9 57 fa ff ff       	jmp    80106567 <alltraps>

80106b10 <vector29>:
80106b10:	6a 00                	push   $0x0
80106b12:	6a 1d                	push   $0x1d
80106b14:	e9 4e fa ff ff       	jmp    80106567 <alltraps>

80106b19 <vector30>:
80106b19:	6a 00                	push   $0x0
80106b1b:	6a 1e                	push   $0x1e
80106b1d:	e9 45 fa ff ff       	jmp    80106567 <alltraps>

80106b22 <vector31>:
80106b22:	6a 00                	push   $0x0
80106b24:	6a 1f                	push   $0x1f
80106b26:	e9 3c fa ff ff       	jmp    80106567 <alltraps>

80106b2b <vector32>:
80106b2b:	6a 00                	push   $0x0
80106b2d:	6a 20                	push   $0x20
80106b2f:	e9 33 fa ff ff       	jmp    80106567 <alltraps>

80106b34 <vector33>:
80106b34:	6a 00                	push   $0x0
80106b36:	6a 21                	push   $0x21
80106b38:	e9 2a fa ff ff       	jmp    80106567 <alltraps>

80106b3d <vector34>:
80106b3d:	6a 00                	push   $0x0
80106b3f:	6a 22                	push   $0x22
80106b41:	e9 21 fa ff ff       	jmp    80106567 <alltraps>

80106b46 <vector35>:
80106b46:	6a 00                	push   $0x0
80106b48:	6a 23                	push   $0x23
80106b4a:	e9 18 fa ff ff       	jmp    80106567 <alltraps>

80106b4f <vector36>:
80106b4f:	6a 00                	push   $0x0
80106b51:	6a 24                	push   $0x24
80106b53:	e9 0f fa ff ff       	jmp    80106567 <alltraps>

80106b58 <vector37>:
80106b58:	6a 00                	push   $0x0
80106b5a:	6a 25                	push   $0x25
80106b5c:	e9 06 fa ff ff       	jmp    80106567 <alltraps>

80106b61 <vector38>:
80106b61:	6a 00                	push   $0x0
80106b63:	6a 26                	push   $0x26
80106b65:	e9 fd f9 ff ff       	jmp    80106567 <alltraps>

80106b6a <vector39>:
80106b6a:	6a 00                	push   $0x0
80106b6c:	6a 27                	push   $0x27
80106b6e:	e9 f4 f9 ff ff       	jmp    80106567 <alltraps>

80106b73 <vector40>:
80106b73:	6a 00                	push   $0x0
80106b75:	6a 28                	push   $0x28
80106b77:	e9 eb f9 ff ff       	jmp    80106567 <alltraps>

80106b7c <vector41>:
80106b7c:	6a 00                	push   $0x0
80106b7e:	6a 29                	push   $0x29
80106b80:	e9 e2 f9 ff ff       	jmp    80106567 <alltraps>

80106b85 <vector42>:
80106b85:	6a 00                	push   $0x0
80106b87:	6a 2a                	push   $0x2a
80106b89:	e9 d9 f9 ff ff       	jmp    80106567 <alltraps>

80106b8e <vector43>:
80106b8e:	6a 00                	push   $0x0
80106b90:	6a 2b                	push   $0x2b
80106b92:	e9 d0 f9 ff ff       	jmp    80106567 <alltraps>

80106b97 <vector44>:
80106b97:	6a 00                	push   $0x0
80106b99:	6a 2c                	push   $0x2c
80106b9b:	e9 c7 f9 ff ff       	jmp    80106567 <alltraps>

80106ba0 <vector45>:
80106ba0:	6a 00                	push   $0x0
80106ba2:	6a 2d                	push   $0x2d
80106ba4:	e9 be f9 ff ff       	jmp    80106567 <alltraps>

80106ba9 <vector46>:
80106ba9:	6a 00                	push   $0x0
80106bab:	6a 2e                	push   $0x2e
80106bad:	e9 b5 f9 ff ff       	jmp    80106567 <alltraps>

80106bb2 <vector47>:
80106bb2:	6a 00                	push   $0x0
80106bb4:	6a 2f                	push   $0x2f
80106bb6:	e9 ac f9 ff ff       	jmp    80106567 <alltraps>

80106bbb <vector48>:
80106bbb:	6a 00                	push   $0x0
80106bbd:	6a 30                	push   $0x30
80106bbf:	e9 a3 f9 ff ff       	jmp    80106567 <alltraps>

80106bc4 <vector49>:
80106bc4:	6a 00                	push   $0x0
80106bc6:	6a 31                	push   $0x31
80106bc8:	e9 9a f9 ff ff       	jmp    80106567 <alltraps>

80106bcd <vector50>:
80106bcd:	6a 00                	push   $0x0
80106bcf:	6a 32                	push   $0x32
80106bd1:	e9 91 f9 ff ff       	jmp    80106567 <alltraps>

80106bd6 <vector51>:
80106bd6:	6a 00                	push   $0x0
80106bd8:	6a 33                	push   $0x33
80106bda:	e9 88 f9 ff ff       	jmp    80106567 <alltraps>

80106bdf <vector52>:
80106bdf:	6a 00                	push   $0x0
80106be1:	6a 34                	push   $0x34
80106be3:	e9 7f f9 ff ff       	jmp    80106567 <alltraps>

80106be8 <vector53>:
80106be8:	6a 00                	push   $0x0
80106bea:	6a 35                	push   $0x35
80106bec:	e9 76 f9 ff ff       	jmp    80106567 <alltraps>

80106bf1 <vector54>:
80106bf1:	6a 00                	push   $0x0
80106bf3:	6a 36                	push   $0x36
80106bf5:	e9 6d f9 ff ff       	jmp    80106567 <alltraps>

80106bfa <vector55>:
80106bfa:	6a 00                	push   $0x0
80106bfc:	6a 37                	push   $0x37
80106bfe:	e9 64 f9 ff ff       	jmp    80106567 <alltraps>

80106c03 <vector56>:
80106c03:	6a 00                	push   $0x0
80106c05:	6a 38                	push   $0x38
80106c07:	e9 5b f9 ff ff       	jmp    80106567 <alltraps>

80106c0c <vector57>:
80106c0c:	6a 00                	push   $0x0
80106c0e:	6a 39                	push   $0x39
80106c10:	e9 52 f9 ff ff       	jmp    80106567 <alltraps>

80106c15 <vector58>:
80106c15:	6a 00                	push   $0x0
80106c17:	6a 3a                	push   $0x3a
80106c19:	e9 49 f9 ff ff       	jmp    80106567 <alltraps>

80106c1e <vector59>:
80106c1e:	6a 00                	push   $0x0
80106c20:	6a 3b                	push   $0x3b
80106c22:	e9 40 f9 ff ff       	jmp    80106567 <alltraps>

80106c27 <vector60>:
80106c27:	6a 00                	push   $0x0
80106c29:	6a 3c                	push   $0x3c
80106c2b:	e9 37 f9 ff ff       	jmp    80106567 <alltraps>

80106c30 <vector61>:
80106c30:	6a 00                	push   $0x0
80106c32:	6a 3d                	push   $0x3d
80106c34:	e9 2e f9 ff ff       	jmp    80106567 <alltraps>

80106c39 <vector62>:
80106c39:	6a 00                	push   $0x0
80106c3b:	6a 3e                	push   $0x3e
80106c3d:	e9 25 f9 ff ff       	jmp    80106567 <alltraps>

80106c42 <vector63>:
80106c42:	6a 00                	push   $0x0
80106c44:	6a 3f                	push   $0x3f
80106c46:	e9 1c f9 ff ff       	jmp    80106567 <alltraps>

80106c4b <vector64>:
80106c4b:	6a 00                	push   $0x0
80106c4d:	6a 40                	push   $0x40
80106c4f:	e9 13 f9 ff ff       	jmp    80106567 <alltraps>

80106c54 <vector65>:
80106c54:	6a 00                	push   $0x0
80106c56:	6a 41                	push   $0x41
80106c58:	e9 0a f9 ff ff       	jmp    80106567 <alltraps>

80106c5d <vector66>:
80106c5d:	6a 00                	push   $0x0
80106c5f:	6a 42                	push   $0x42
80106c61:	e9 01 f9 ff ff       	jmp    80106567 <alltraps>

80106c66 <vector67>:
80106c66:	6a 00                	push   $0x0
80106c68:	6a 43                	push   $0x43
80106c6a:	e9 f8 f8 ff ff       	jmp    80106567 <alltraps>

80106c6f <vector68>:
80106c6f:	6a 00                	push   $0x0
80106c71:	6a 44                	push   $0x44
80106c73:	e9 ef f8 ff ff       	jmp    80106567 <alltraps>

80106c78 <vector69>:
80106c78:	6a 00                	push   $0x0
80106c7a:	6a 45                	push   $0x45
80106c7c:	e9 e6 f8 ff ff       	jmp    80106567 <alltraps>

80106c81 <vector70>:
80106c81:	6a 00                	push   $0x0
80106c83:	6a 46                	push   $0x46
80106c85:	e9 dd f8 ff ff       	jmp    80106567 <alltraps>

80106c8a <vector71>:
80106c8a:	6a 00                	push   $0x0
80106c8c:	6a 47                	push   $0x47
80106c8e:	e9 d4 f8 ff ff       	jmp    80106567 <alltraps>

80106c93 <vector72>:
80106c93:	6a 00                	push   $0x0
80106c95:	6a 48                	push   $0x48
80106c97:	e9 cb f8 ff ff       	jmp    80106567 <alltraps>

80106c9c <vector73>:
80106c9c:	6a 00                	push   $0x0
80106c9e:	6a 49                	push   $0x49
80106ca0:	e9 c2 f8 ff ff       	jmp    80106567 <alltraps>

80106ca5 <vector74>:
80106ca5:	6a 00                	push   $0x0
80106ca7:	6a 4a                	push   $0x4a
80106ca9:	e9 b9 f8 ff ff       	jmp    80106567 <alltraps>

80106cae <vector75>:
80106cae:	6a 00                	push   $0x0
80106cb0:	6a 4b                	push   $0x4b
80106cb2:	e9 b0 f8 ff ff       	jmp    80106567 <alltraps>

80106cb7 <vector76>:
80106cb7:	6a 00                	push   $0x0
80106cb9:	6a 4c                	push   $0x4c
80106cbb:	e9 a7 f8 ff ff       	jmp    80106567 <alltraps>

80106cc0 <vector77>:
80106cc0:	6a 00                	push   $0x0
80106cc2:	6a 4d                	push   $0x4d
80106cc4:	e9 9e f8 ff ff       	jmp    80106567 <alltraps>

80106cc9 <vector78>:
80106cc9:	6a 00                	push   $0x0
80106ccb:	6a 4e                	push   $0x4e
80106ccd:	e9 95 f8 ff ff       	jmp    80106567 <alltraps>

80106cd2 <vector79>:
80106cd2:	6a 00                	push   $0x0
80106cd4:	6a 4f                	push   $0x4f
80106cd6:	e9 8c f8 ff ff       	jmp    80106567 <alltraps>

80106cdb <vector80>:
80106cdb:	6a 00                	push   $0x0
80106cdd:	6a 50                	push   $0x50
80106cdf:	e9 83 f8 ff ff       	jmp    80106567 <alltraps>

80106ce4 <vector81>:
80106ce4:	6a 00                	push   $0x0
80106ce6:	6a 51                	push   $0x51
80106ce8:	e9 7a f8 ff ff       	jmp    80106567 <alltraps>

80106ced <vector82>:
80106ced:	6a 00                	push   $0x0
80106cef:	6a 52                	push   $0x52
80106cf1:	e9 71 f8 ff ff       	jmp    80106567 <alltraps>

80106cf6 <vector83>:
80106cf6:	6a 00                	push   $0x0
80106cf8:	6a 53                	push   $0x53
80106cfa:	e9 68 f8 ff ff       	jmp    80106567 <alltraps>

80106cff <vector84>:
80106cff:	6a 00                	push   $0x0
80106d01:	6a 54                	push   $0x54
80106d03:	e9 5f f8 ff ff       	jmp    80106567 <alltraps>

80106d08 <vector85>:
80106d08:	6a 00                	push   $0x0
80106d0a:	6a 55                	push   $0x55
80106d0c:	e9 56 f8 ff ff       	jmp    80106567 <alltraps>

80106d11 <vector86>:
80106d11:	6a 00                	push   $0x0
80106d13:	6a 56                	push   $0x56
80106d15:	e9 4d f8 ff ff       	jmp    80106567 <alltraps>

80106d1a <vector87>:
80106d1a:	6a 00                	push   $0x0
80106d1c:	6a 57                	push   $0x57
80106d1e:	e9 44 f8 ff ff       	jmp    80106567 <alltraps>

80106d23 <vector88>:
80106d23:	6a 00                	push   $0x0
80106d25:	6a 58                	push   $0x58
80106d27:	e9 3b f8 ff ff       	jmp    80106567 <alltraps>

80106d2c <vector89>:
80106d2c:	6a 00                	push   $0x0
80106d2e:	6a 59                	push   $0x59
80106d30:	e9 32 f8 ff ff       	jmp    80106567 <alltraps>

80106d35 <vector90>:
80106d35:	6a 00                	push   $0x0
80106d37:	6a 5a                	push   $0x5a
80106d39:	e9 29 f8 ff ff       	jmp    80106567 <alltraps>

80106d3e <vector91>:
80106d3e:	6a 00                	push   $0x0
80106d40:	6a 5b                	push   $0x5b
80106d42:	e9 20 f8 ff ff       	jmp    80106567 <alltraps>

80106d47 <vector92>:
80106d47:	6a 00                	push   $0x0
80106d49:	6a 5c                	push   $0x5c
80106d4b:	e9 17 f8 ff ff       	jmp    80106567 <alltraps>

80106d50 <vector93>:
80106d50:	6a 00                	push   $0x0
80106d52:	6a 5d                	push   $0x5d
80106d54:	e9 0e f8 ff ff       	jmp    80106567 <alltraps>

80106d59 <vector94>:
80106d59:	6a 00                	push   $0x0
80106d5b:	6a 5e                	push   $0x5e
80106d5d:	e9 05 f8 ff ff       	jmp    80106567 <alltraps>

80106d62 <vector95>:
80106d62:	6a 00                	push   $0x0
80106d64:	6a 5f                	push   $0x5f
80106d66:	e9 fc f7 ff ff       	jmp    80106567 <alltraps>

80106d6b <vector96>:
80106d6b:	6a 00                	push   $0x0
80106d6d:	6a 60                	push   $0x60
80106d6f:	e9 f3 f7 ff ff       	jmp    80106567 <alltraps>

80106d74 <vector97>:
80106d74:	6a 00                	push   $0x0
80106d76:	6a 61                	push   $0x61
80106d78:	e9 ea f7 ff ff       	jmp    80106567 <alltraps>

80106d7d <vector98>:
80106d7d:	6a 00                	push   $0x0
80106d7f:	6a 62                	push   $0x62
80106d81:	e9 e1 f7 ff ff       	jmp    80106567 <alltraps>

80106d86 <vector99>:
80106d86:	6a 00                	push   $0x0
80106d88:	6a 63                	push   $0x63
80106d8a:	e9 d8 f7 ff ff       	jmp    80106567 <alltraps>

80106d8f <vector100>:
80106d8f:	6a 00                	push   $0x0
80106d91:	6a 64                	push   $0x64
80106d93:	e9 cf f7 ff ff       	jmp    80106567 <alltraps>

80106d98 <vector101>:
80106d98:	6a 00                	push   $0x0
80106d9a:	6a 65                	push   $0x65
80106d9c:	e9 c6 f7 ff ff       	jmp    80106567 <alltraps>

80106da1 <vector102>:
80106da1:	6a 00                	push   $0x0
80106da3:	6a 66                	push   $0x66
80106da5:	e9 bd f7 ff ff       	jmp    80106567 <alltraps>

80106daa <vector103>:
80106daa:	6a 00                	push   $0x0
80106dac:	6a 67                	push   $0x67
80106dae:	e9 b4 f7 ff ff       	jmp    80106567 <alltraps>

80106db3 <vector104>:
80106db3:	6a 00                	push   $0x0
80106db5:	6a 68                	push   $0x68
80106db7:	e9 ab f7 ff ff       	jmp    80106567 <alltraps>

80106dbc <vector105>:
80106dbc:	6a 00                	push   $0x0
80106dbe:	6a 69                	push   $0x69
80106dc0:	e9 a2 f7 ff ff       	jmp    80106567 <alltraps>

80106dc5 <vector106>:
80106dc5:	6a 00                	push   $0x0
80106dc7:	6a 6a                	push   $0x6a
80106dc9:	e9 99 f7 ff ff       	jmp    80106567 <alltraps>

80106dce <vector107>:
80106dce:	6a 00                	push   $0x0
80106dd0:	6a 6b                	push   $0x6b
80106dd2:	e9 90 f7 ff ff       	jmp    80106567 <alltraps>

80106dd7 <vector108>:
80106dd7:	6a 00                	push   $0x0
80106dd9:	6a 6c                	push   $0x6c
80106ddb:	e9 87 f7 ff ff       	jmp    80106567 <alltraps>

80106de0 <vector109>:
80106de0:	6a 00                	push   $0x0
80106de2:	6a 6d                	push   $0x6d
80106de4:	e9 7e f7 ff ff       	jmp    80106567 <alltraps>

80106de9 <vector110>:
80106de9:	6a 00                	push   $0x0
80106deb:	6a 6e                	push   $0x6e
80106ded:	e9 75 f7 ff ff       	jmp    80106567 <alltraps>

80106df2 <vector111>:
80106df2:	6a 00                	push   $0x0
80106df4:	6a 6f                	push   $0x6f
80106df6:	e9 6c f7 ff ff       	jmp    80106567 <alltraps>

80106dfb <vector112>:
80106dfb:	6a 00                	push   $0x0
80106dfd:	6a 70                	push   $0x70
80106dff:	e9 63 f7 ff ff       	jmp    80106567 <alltraps>

80106e04 <vector113>:
80106e04:	6a 00                	push   $0x0
80106e06:	6a 71                	push   $0x71
80106e08:	e9 5a f7 ff ff       	jmp    80106567 <alltraps>

80106e0d <vector114>:
80106e0d:	6a 00                	push   $0x0
80106e0f:	6a 72                	push   $0x72
80106e11:	e9 51 f7 ff ff       	jmp    80106567 <alltraps>

80106e16 <vector115>:
80106e16:	6a 00                	push   $0x0
80106e18:	6a 73                	push   $0x73
80106e1a:	e9 48 f7 ff ff       	jmp    80106567 <alltraps>

80106e1f <vector116>:
80106e1f:	6a 00                	push   $0x0
80106e21:	6a 74                	push   $0x74
80106e23:	e9 3f f7 ff ff       	jmp    80106567 <alltraps>

80106e28 <vector117>:
80106e28:	6a 00                	push   $0x0
80106e2a:	6a 75                	push   $0x75
80106e2c:	e9 36 f7 ff ff       	jmp    80106567 <alltraps>

80106e31 <vector118>:
80106e31:	6a 00                	push   $0x0
80106e33:	6a 76                	push   $0x76
80106e35:	e9 2d f7 ff ff       	jmp    80106567 <alltraps>

80106e3a <vector119>:
80106e3a:	6a 00                	push   $0x0
80106e3c:	6a 77                	push   $0x77
80106e3e:	e9 24 f7 ff ff       	jmp    80106567 <alltraps>

80106e43 <vector120>:
80106e43:	6a 00                	push   $0x0
80106e45:	6a 78                	push   $0x78
80106e47:	e9 1b f7 ff ff       	jmp    80106567 <alltraps>

80106e4c <vector121>:
80106e4c:	6a 00                	push   $0x0
80106e4e:	6a 79                	push   $0x79
80106e50:	e9 12 f7 ff ff       	jmp    80106567 <alltraps>

80106e55 <vector122>:
80106e55:	6a 00                	push   $0x0
80106e57:	6a 7a                	push   $0x7a
80106e59:	e9 09 f7 ff ff       	jmp    80106567 <alltraps>

80106e5e <vector123>:
80106e5e:	6a 00                	push   $0x0
80106e60:	6a 7b                	push   $0x7b
80106e62:	e9 00 f7 ff ff       	jmp    80106567 <alltraps>

80106e67 <vector124>:
80106e67:	6a 00                	push   $0x0
80106e69:	6a 7c                	push   $0x7c
80106e6b:	e9 f7 f6 ff ff       	jmp    80106567 <alltraps>

80106e70 <vector125>:
80106e70:	6a 00                	push   $0x0
80106e72:	6a 7d                	push   $0x7d
80106e74:	e9 ee f6 ff ff       	jmp    80106567 <alltraps>

80106e79 <vector126>:
80106e79:	6a 00                	push   $0x0
80106e7b:	6a 7e                	push   $0x7e
80106e7d:	e9 e5 f6 ff ff       	jmp    80106567 <alltraps>

80106e82 <vector127>:
80106e82:	6a 00                	push   $0x0
80106e84:	6a 7f                	push   $0x7f
80106e86:	e9 dc f6 ff ff       	jmp    80106567 <alltraps>

80106e8b <vector128>:
80106e8b:	6a 00                	push   $0x0
80106e8d:	68 80 00 00 00       	push   $0x80
80106e92:	e9 d0 f6 ff ff       	jmp    80106567 <alltraps>

80106e97 <vector129>:
80106e97:	6a 00                	push   $0x0
80106e99:	68 81 00 00 00       	push   $0x81
80106e9e:	e9 c4 f6 ff ff       	jmp    80106567 <alltraps>

80106ea3 <vector130>:
80106ea3:	6a 00                	push   $0x0
80106ea5:	68 82 00 00 00       	push   $0x82
80106eaa:	e9 b8 f6 ff ff       	jmp    80106567 <alltraps>

80106eaf <vector131>:
80106eaf:	6a 00                	push   $0x0
80106eb1:	68 83 00 00 00       	push   $0x83
80106eb6:	e9 ac f6 ff ff       	jmp    80106567 <alltraps>

80106ebb <vector132>:
80106ebb:	6a 00                	push   $0x0
80106ebd:	68 84 00 00 00       	push   $0x84
80106ec2:	e9 a0 f6 ff ff       	jmp    80106567 <alltraps>

80106ec7 <vector133>:
80106ec7:	6a 00                	push   $0x0
80106ec9:	68 85 00 00 00       	push   $0x85
80106ece:	e9 94 f6 ff ff       	jmp    80106567 <alltraps>

80106ed3 <vector134>:
80106ed3:	6a 00                	push   $0x0
80106ed5:	68 86 00 00 00       	push   $0x86
80106eda:	e9 88 f6 ff ff       	jmp    80106567 <alltraps>

80106edf <vector135>:
80106edf:	6a 00                	push   $0x0
80106ee1:	68 87 00 00 00       	push   $0x87
80106ee6:	e9 7c f6 ff ff       	jmp    80106567 <alltraps>

80106eeb <vector136>:
80106eeb:	6a 00                	push   $0x0
80106eed:	68 88 00 00 00       	push   $0x88
80106ef2:	e9 70 f6 ff ff       	jmp    80106567 <alltraps>

80106ef7 <vector137>:
80106ef7:	6a 00                	push   $0x0
80106ef9:	68 89 00 00 00       	push   $0x89
80106efe:	e9 64 f6 ff ff       	jmp    80106567 <alltraps>

80106f03 <vector138>:
80106f03:	6a 00                	push   $0x0
80106f05:	68 8a 00 00 00       	push   $0x8a
80106f0a:	e9 58 f6 ff ff       	jmp    80106567 <alltraps>

80106f0f <vector139>:
80106f0f:	6a 00                	push   $0x0
80106f11:	68 8b 00 00 00       	push   $0x8b
80106f16:	e9 4c f6 ff ff       	jmp    80106567 <alltraps>

80106f1b <vector140>:
80106f1b:	6a 00                	push   $0x0
80106f1d:	68 8c 00 00 00       	push   $0x8c
80106f22:	e9 40 f6 ff ff       	jmp    80106567 <alltraps>

80106f27 <vector141>:
80106f27:	6a 00                	push   $0x0
80106f29:	68 8d 00 00 00       	push   $0x8d
80106f2e:	e9 34 f6 ff ff       	jmp    80106567 <alltraps>

80106f33 <vector142>:
80106f33:	6a 00                	push   $0x0
80106f35:	68 8e 00 00 00       	push   $0x8e
80106f3a:	e9 28 f6 ff ff       	jmp    80106567 <alltraps>

80106f3f <vector143>:
80106f3f:	6a 00                	push   $0x0
80106f41:	68 8f 00 00 00       	push   $0x8f
80106f46:	e9 1c f6 ff ff       	jmp    80106567 <alltraps>

80106f4b <vector144>:
80106f4b:	6a 00                	push   $0x0
80106f4d:	68 90 00 00 00       	push   $0x90
80106f52:	e9 10 f6 ff ff       	jmp    80106567 <alltraps>

80106f57 <vector145>:
80106f57:	6a 00                	push   $0x0
80106f59:	68 91 00 00 00       	push   $0x91
80106f5e:	e9 04 f6 ff ff       	jmp    80106567 <alltraps>

80106f63 <vector146>:
80106f63:	6a 00                	push   $0x0
80106f65:	68 92 00 00 00       	push   $0x92
80106f6a:	e9 f8 f5 ff ff       	jmp    80106567 <alltraps>

80106f6f <vector147>:
80106f6f:	6a 00                	push   $0x0
80106f71:	68 93 00 00 00       	push   $0x93
80106f76:	e9 ec f5 ff ff       	jmp    80106567 <alltraps>

80106f7b <vector148>:
80106f7b:	6a 00                	push   $0x0
80106f7d:	68 94 00 00 00       	push   $0x94
80106f82:	e9 e0 f5 ff ff       	jmp    80106567 <alltraps>

80106f87 <vector149>:
80106f87:	6a 00                	push   $0x0
80106f89:	68 95 00 00 00       	push   $0x95
80106f8e:	e9 d4 f5 ff ff       	jmp    80106567 <alltraps>

80106f93 <vector150>:
80106f93:	6a 00                	push   $0x0
80106f95:	68 96 00 00 00       	push   $0x96
80106f9a:	e9 c8 f5 ff ff       	jmp    80106567 <alltraps>

80106f9f <vector151>:
80106f9f:	6a 00                	push   $0x0
80106fa1:	68 97 00 00 00       	push   $0x97
80106fa6:	e9 bc f5 ff ff       	jmp    80106567 <alltraps>

80106fab <vector152>:
80106fab:	6a 00                	push   $0x0
80106fad:	68 98 00 00 00       	push   $0x98
80106fb2:	e9 b0 f5 ff ff       	jmp    80106567 <alltraps>

80106fb7 <vector153>:
80106fb7:	6a 00                	push   $0x0
80106fb9:	68 99 00 00 00       	push   $0x99
80106fbe:	e9 a4 f5 ff ff       	jmp    80106567 <alltraps>

80106fc3 <vector154>:
80106fc3:	6a 00                	push   $0x0
80106fc5:	68 9a 00 00 00       	push   $0x9a
80106fca:	e9 98 f5 ff ff       	jmp    80106567 <alltraps>

80106fcf <vector155>:
80106fcf:	6a 00                	push   $0x0
80106fd1:	68 9b 00 00 00       	push   $0x9b
80106fd6:	e9 8c f5 ff ff       	jmp    80106567 <alltraps>

80106fdb <vector156>:
80106fdb:	6a 00                	push   $0x0
80106fdd:	68 9c 00 00 00       	push   $0x9c
80106fe2:	e9 80 f5 ff ff       	jmp    80106567 <alltraps>

80106fe7 <vector157>:
80106fe7:	6a 00                	push   $0x0
80106fe9:	68 9d 00 00 00       	push   $0x9d
80106fee:	e9 74 f5 ff ff       	jmp    80106567 <alltraps>

80106ff3 <vector158>:
80106ff3:	6a 00                	push   $0x0
80106ff5:	68 9e 00 00 00       	push   $0x9e
80106ffa:	e9 68 f5 ff ff       	jmp    80106567 <alltraps>

80106fff <vector159>:
80106fff:	6a 00                	push   $0x0
80107001:	68 9f 00 00 00       	push   $0x9f
80107006:	e9 5c f5 ff ff       	jmp    80106567 <alltraps>

8010700b <vector160>:
8010700b:	6a 00                	push   $0x0
8010700d:	68 a0 00 00 00       	push   $0xa0
80107012:	e9 50 f5 ff ff       	jmp    80106567 <alltraps>

80107017 <vector161>:
80107017:	6a 00                	push   $0x0
80107019:	68 a1 00 00 00       	push   $0xa1
8010701e:	e9 44 f5 ff ff       	jmp    80106567 <alltraps>

80107023 <vector162>:
80107023:	6a 00                	push   $0x0
80107025:	68 a2 00 00 00       	push   $0xa2
8010702a:	e9 38 f5 ff ff       	jmp    80106567 <alltraps>

8010702f <vector163>:
8010702f:	6a 00                	push   $0x0
80107031:	68 a3 00 00 00       	push   $0xa3
80107036:	e9 2c f5 ff ff       	jmp    80106567 <alltraps>

8010703b <vector164>:
8010703b:	6a 00                	push   $0x0
8010703d:	68 a4 00 00 00       	push   $0xa4
80107042:	e9 20 f5 ff ff       	jmp    80106567 <alltraps>

80107047 <vector165>:
80107047:	6a 00                	push   $0x0
80107049:	68 a5 00 00 00       	push   $0xa5
8010704e:	e9 14 f5 ff ff       	jmp    80106567 <alltraps>

80107053 <vector166>:
80107053:	6a 00                	push   $0x0
80107055:	68 a6 00 00 00       	push   $0xa6
8010705a:	e9 08 f5 ff ff       	jmp    80106567 <alltraps>

8010705f <vector167>:
8010705f:	6a 00                	push   $0x0
80107061:	68 a7 00 00 00       	push   $0xa7
80107066:	e9 fc f4 ff ff       	jmp    80106567 <alltraps>

8010706b <vector168>:
8010706b:	6a 00                	push   $0x0
8010706d:	68 a8 00 00 00       	push   $0xa8
80107072:	e9 f0 f4 ff ff       	jmp    80106567 <alltraps>

80107077 <vector169>:
80107077:	6a 00                	push   $0x0
80107079:	68 a9 00 00 00       	push   $0xa9
8010707e:	e9 e4 f4 ff ff       	jmp    80106567 <alltraps>

80107083 <vector170>:
80107083:	6a 00                	push   $0x0
80107085:	68 aa 00 00 00       	push   $0xaa
8010708a:	e9 d8 f4 ff ff       	jmp    80106567 <alltraps>

8010708f <vector171>:
8010708f:	6a 00                	push   $0x0
80107091:	68 ab 00 00 00       	push   $0xab
80107096:	e9 cc f4 ff ff       	jmp    80106567 <alltraps>

8010709b <vector172>:
8010709b:	6a 00                	push   $0x0
8010709d:	68 ac 00 00 00       	push   $0xac
801070a2:	e9 c0 f4 ff ff       	jmp    80106567 <alltraps>

801070a7 <vector173>:
801070a7:	6a 00                	push   $0x0
801070a9:	68 ad 00 00 00       	push   $0xad
801070ae:	e9 b4 f4 ff ff       	jmp    80106567 <alltraps>

801070b3 <vector174>:
801070b3:	6a 00                	push   $0x0
801070b5:	68 ae 00 00 00       	push   $0xae
801070ba:	e9 a8 f4 ff ff       	jmp    80106567 <alltraps>

801070bf <vector175>:
801070bf:	6a 00                	push   $0x0
801070c1:	68 af 00 00 00       	push   $0xaf
801070c6:	e9 9c f4 ff ff       	jmp    80106567 <alltraps>

801070cb <vector176>:
801070cb:	6a 00                	push   $0x0
801070cd:	68 b0 00 00 00       	push   $0xb0
801070d2:	e9 90 f4 ff ff       	jmp    80106567 <alltraps>

801070d7 <vector177>:
801070d7:	6a 00                	push   $0x0
801070d9:	68 b1 00 00 00       	push   $0xb1
801070de:	e9 84 f4 ff ff       	jmp    80106567 <alltraps>

801070e3 <vector178>:
801070e3:	6a 00                	push   $0x0
801070e5:	68 b2 00 00 00       	push   $0xb2
801070ea:	e9 78 f4 ff ff       	jmp    80106567 <alltraps>

801070ef <vector179>:
801070ef:	6a 00                	push   $0x0
801070f1:	68 b3 00 00 00       	push   $0xb3
801070f6:	e9 6c f4 ff ff       	jmp    80106567 <alltraps>

801070fb <vector180>:
801070fb:	6a 00                	push   $0x0
801070fd:	68 b4 00 00 00       	push   $0xb4
80107102:	e9 60 f4 ff ff       	jmp    80106567 <alltraps>

80107107 <vector181>:
80107107:	6a 00                	push   $0x0
80107109:	68 b5 00 00 00       	push   $0xb5
8010710e:	e9 54 f4 ff ff       	jmp    80106567 <alltraps>

80107113 <vector182>:
80107113:	6a 00                	push   $0x0
80107115:	68 b6 00 00 00       	push   $0xb6
8010711a:	e9 48 f4 ff ff       	jmp    80106567 <alltraps>

8010711f <vector183>:
8010711f:	6a 00                	push   $0x0
80107121:	68 b7 00 00 00       	push   $0xb7
80107126:	e9 3c f4 ff ff       	jmp    80106567 <alltraps>

8010712b <vector184>:
8010712b:	6a 00                	push   $0x0
8010712d:	68 b8 00 00 00       	push   $0xb8
80107132:	e9 30 f4 ff ff       	jmp    80106567 <alltraps>

80107137 <vector185>:
80107137:	6a 00                	push   $0x0
80107139:	68 b9 00 00 00       	push   $0xb9
8010713e:	e9 24 f4 ff ff       	jmp    80106567 <alltraps>

80107143 <vector186>:
80107143:	6a 00                	push   $0x0
80107145:	68 ba 00 00 00       	push   $0xba
8010714a:	e9 18 f4 ff ff       	jmp    80106567 <alltraps>

8010714f <vector187>:
8010714f:	6a 00                	push   $0x0
80107151:	68 bb 00 00 00       	push   $0xbb
80107156:	e9 0c f4 ff ff       	jmp    80106567 <alltraps>

8010715b <vector188>:
8010715b:	6a 00                	push   $0x0
8010715d:	68 bc 00 00 00       	push   $0xbc
80107162:	e9 00 f4 ff ff       	jmp    80106567 <alltraps>

80107167 <vector189>:
80107167:	6a 00                	push   $0x0
80107169:	68 bd 00 00 00       	push   $0xbd
8010716e:	e9 f4 f3 ff ff       	jmp    80106567 <alltraps>

80107173 <vector190>:
80107173:	6a 00                	push   $0x0
80107175:	68 be 00 00 00       	push   $0xbe
8010717a:	e9 e8 f3 ff ff       	jmp    80106567 <alltraps>

8010717f <vector191>:
8010717f:	6a 00                	push   $0x0
80107181:	68 bf 00 00 00       	push   $0xbf
80107186:	e9 dc f3 ff ff       	jmp    80106567 <alltraps>

8010718b <vector192>:
8010718b:	6a 00                	push   $0x0
8010718d:	68 c0 00 00 00       	push   $0xc0
80107192:	e9 d0 f3 ff ff       	jmp    80106567 <alltraps>

80107197 <vector193>:
80107197:	6a 00                	push   $0x0
80107199:	68 c1 00 00 00       	push   $0xc1
8010719e:	e9 c4 f3 ff ff       	jmp    80106567 <alltraps>

801071a3 <vector194>:
801071a3:	6a 00                	push   $0x0
801071a5:	68 c2 00 00 00       	push   $0xc2
801071aa:	e9 b8 f3 ff ff       	jmp    80106567 <alltraps>

801071af <vector195>:
801071af:	6a 00                	push   $0x0
801071b1:	68 c3 00 00 00       	push   $0xc3
801071b6:	e9 ac f3 ff ff       	jmp    80106567 <alltraps>

801071bb <vector196>:
801071bb:	6a 00                	push   $0x0
801071bd:	68 c4 00 00 00       	push   $0xc4
801071c2:	e9 a0 f3 ff ff       	jmp    80106567 <alltraps>

801071c7 <vector197>:
801071c7:	6a 00                	push   $0x0
801071c9:	68 c5 00 00 00       	push   $0xc5
801071ce:	e9 94 f3 ff ff       	jmp    80106567 <alltraps>

801071d3 <vector198>:
801071d3:	6a 00                	push   $0x0
801071d5:	68 c6 00 00 00       	push   $0xc6
801071da:	e9 88 f3 ff ff       	jmp    80106567 <alltraps>

801071df <vector199>:
801071df:	6a 00                	push   $0x0
801071e1:	68 c7 00 00 00       	push   $0xc7
801071e6:	e9 7c f3 ff ff       	jmp    80106567 <alltraps>

801071eb <vector200>:
801071eb:	6a 00                	push   $0x0
801071ed:	68 c8 00 00 00       	push   $0xc8
801071f2:	e9 70 f3 ff ff       	jmp    80106567 <alltraps>

801071f7 <vector201>:
801071f7:	6a 00                	push   $0x0
801071f9:	68 c9 00 00 00       	push   $0xc9
801071fe:	e9 64 f3 ff ff       	jmp    80106567 <alltraps>

80107203 <vector202>:
80107203:	6a 00                	push   $0x0
80107205:	68 ca 00 00 00       	push   $0xca
8010720a:	e9 58 f3 ff ff       	jmp    80106567 <alltraps>

8010720f <vector203>:
8010720f:	6a 00                	push   $0x0
80107211:	68 cb 00 00 00       	push   $0xcb
80107216:	e9 4c f3 ff ff       	jmp    80106567 <alltraps>

8010721b <vector204>:
8010721b:	6a 00                	push   $0x0
8010721d:	68 cc 00 00 00       	push   $0xcc
80107222:	e9 40 f3 ff ff       	jmp    80106567 <alltraps>

80107227 <vector205>:
80107227:	6a 00                	push   $0x0
80107229:	68 cd 00 00 00       	push   $0xcd
8010722e:	e9 34 f3 ff ff       	jmp    80106567 <alltraps>

80107233 <vector206>:
80107233:	6a 00                	push   $0x0
80107235:	68 ce 00 00 00       	push   $0xce
8010723a:	e9 28 f3 ff ff       	jmp    80106567 <alltraps>

8010723f <vector207>:
8010723f:	6a 00                	push   $0x0
80107241:	68 cf 00 00 00       	push   $0xcf
80107246:	e9 1c f3 ff ff       	jmp    80106567 <alltraps>

8010724b <vector208>:
8010724b:	6a 00                	push   $0x0
8010724d:	68 d0 00 00 00       	push   $0xd0
80107252:	e9 10 f3 ff ff       	jmp    80106567 <alltraps>

80107257 <vector209>:
80107257:	6a 00                	push   $0x0
80107259:	68 d1 00 00 00       	push   $0xd1
8010725e:	e9 04 f3 ff ff       	jmp    80106567 <alltraps>

80107263 <vector210>:
80107263:	6a 00                	push   $0x0
80107265:	68 d2 00 00 00       	push   $0xd2
8010726a:	e9 f8 f2 ff ff       	jmp    80106567 <alltraps>

8010726f <vector211>:
8010726f:	6a 00                	push   $0x0
80107271:	68 d3 00 00 00       	push   $0xd3
80107276:	e9 ec f2 ff ff       	jmp    80106567 <alltraps>

8010727b <vector212>:
8010727b:	6a 00                	push   $0x0
8010727d:	68 d4 00 00 00       	push   $0xd4
80107282:	e9 e0 f2 ff ff       	jmp    80106567 <alltraps>

80107287 <vector213>:
80107287:	6a 00                	push   $0x0
80107289:	68 d5 00 00 00       	push   $0xd5
8010728e:	e9 d4 f2 ff ff       	jmp    80106567 <alltraps>

80107293 <vector214>:
80107293:	6a 00                	push   $0x0
80107295:	68 d6 00 00 00       	push   $0xd6
8010729a:	e9 c8 f2 ff ff       	jmp    80106567 <alltraps>

8010729f <vector215>:
8010729f:	6a 00                	push   $0x0
801072a1:	68 d7 00 00 00       	push   $0xd7
801072a6:	e9 bc f2 ff ff       	jmp    80106567 <alltraps>

801072ab <vector216>:
801072ab:	6a 00                	push   $0x0
801072ad:	68 d8 00 00 00       	push   $0xd8
801072b2:	e9 b0 f2 ff ff       	jmp    80106567 <alltraps>

801072b7 <vector217>:
801072b7:	6a 00                	push   $0x0
801072b9:	68 d9 00 00 00       	push   $0xd9
801072be:	e9 a4 f2 ff ff       	jmp    80106567 <alltraps>

801072c3 <vector218>:
801072c3:	6a 00                	push   $0x0
801072c5:	68 da 00 00 00       	push   $0xda
801072ca:	e9 98 f2 ff ff       	jmp    80106567 <alltraps>

801072cf <vector219>:
801072cf:	6a 00                	push   $0x0
801072d1:	68 db 00 00 00       	push   $0xdb
801072d6:	e9 8c f2 ff ff       	jmp    80106567 <alltraps>

801072db <vector220>:
801072db:	6a 00                	push   $0x0
801072dd:	68 dc 00 00 00       	push   $0xdc
801072e2:	e9 80 f2 ff ff       	jmp    80106567 <alltraps>

801072e7 <vector221>:
801072e7:	6a 00                	push   $0x0
801072e9:	68 dd 00 00 00       	push   $0xdd
801072ee:	e9 74 f2 ff ff       	jmp    80106567 <alltraps>

801072f3 <vector222>:
801072f3:	6a 00                	push   $0x0
801072f5:	68 de 00 00 00       	push   $0xde
801072fa:	e9 68 f2 ff ff       	jmp    80106567 <alltraps>

801072ff <vector223>:
801072ff:	6a 00                	push   $0x0
80107301:	68 df 00 00 00       	push   $0xdf
80107306:	e9 5c f2 ff ff       	jmp    80106567 <alltraps>

8010730b <vector224>:
8010730b:	6a 00                	push   $0x0
8010730d:	68 e0 00 00 00       	push   $0xe0
80107312:	e9 50 f2 ff ff       	jmp    80106567 <alltraps>

80107317 <vector225>:
80107317:	6a 00                	push   $0x0
80107319:	68 e1 00 00 00       	push   $0xe1
8010731e:	e9 44 f2 ff ff       	jmp    80106567 <alltraps>

80107323 <vector226>:
80107323:	6a 00                	push   $0x0
80107325:	68 e2 00 00 00       	push   $0xe2
8010732a:	e9 38 f2 ff ff       	jmp    80106567 <alltraps>

8010732f <vector227>:
8010732f:	6a 00                	push   $0x0
80107331:	68 e3 00 00 00       	push   $0xe3
80107336:	e9 2c f2 ff ff       	jmp    80106567 <alltraps>

8010733b <vector228>:
8010733b:	6a 00                	push   $0x0
8010733d:	68 e4 00 00 00       	push   $0xe4
80107342:	e9 20 f2 ff ff       	jmp    80106567 <alltraps>

80107347 <vector229>:
80107347:	6a 00                	push   $0x0
80107349:	68 e5 00 00 00       	push   $0xe5
8010734e:	e9 14 f2 ff ff       	jmp    80106567 <alltraps>

80107353 <vector230>:
80107353:	6a 00                	push   $0x0
80107355:	68 e6 00 00 00       	push   $0xe6
8010735a:	e9 08 f2 ff ff       	jmp    80106567 <alltraps>

8010735f <vector231>:
8010735f:	6a 00                	push   $0x0
80107361:	68 e7 00 00 00       	push   $0xe7
80107366:	e9 fc f1 ff ff       	jmp    80106567 <alltraps>

8010736b <vector232>:
8010736b:	6a 00                	push   $0x0
8010736d:	68 e8 00 00 00       	push   $0xe8
80107372:	e9 f0 f1 ff ff       	jmp    80106567 <alltraps>

80107377 <vector233>:
80107377:	6a 00                	push   $0x0
80107379:	68 e9 00 00 00       	push   $0xe9
8010737e:	e9 e4 f1 ff ff       	jmp    80106567 <alltraps>

80107383 <vector234>:
80107383:	6a 00                	push   $0x0
80107385:	68 ea 00 00 00       	push   $0xea
8010738a:	e9 d8 f1 ff ff       	jmp    80106567 <alltraps>

8010738f <vector235>:
8010738f:	6a 00                	push   $0x0
80107391:	68 eb 00 00 00       	push   $0xeb
80107396:	e9 cc f1 ff ff       	jmp    80106567 <alltraps>

8010739b <vector236>:
8010739b:	6a 00                	push   $0x0
8010739d:	68 ec 00 00 00       	push   $0xec
801073a2:	e9 c0 f1 ff ff       	jmp    80106567 <alltraps>

801073a7 <vector237>:
801073a7:	6a 00                	push   $0x0
801073a9:	68 ed 00 00 00       	push   $0xed
801073ae:	e9 b4 f1 ff ff       	jmp    80106567 <alltraps>

801073b3 <vector238>:
801073b3:	6a 00                	push   $0x0
801073b5:	68 ee 00 00 00       	push   $0xee
801073ba:	e9 a8 f1 ff ff       	jmp    80106567 <alltraps>

801073bf <vector239>:
801073bf:	6a 00                	push   $0x0
801073c1:	68 ef 00 00 00       	push   $0xef
801073c6:	e9 9c f1 ff ff       	jmp    80106567 <alltraps>

801073cb <vector240>:
801073cb:	6a 00                	push   $0x0
801073cd:	68 f0 00 00 00       	push   $0xf0
801073d2:	e9 90 f1 ff ff       	jmp    80106567 <alltraps>

801073d7 <vector241>:
801073d7:	6a 00                	push   $0x0
801073d9:	68 f1 00 00 00       	push   $0xf1
801073de:	e9 84 f1 ff ff       	jmp    80106567 <alltraps>

801073e3 <vector242>:
801073e3:	6a 00                	push   $0x0
801073e5:	68 f2 00 00 00       	push   $0xf2
801073ea:	e9 78 f1 ff ff       	jmp    80106567 <alltraps>

801073ef <vector243>:
801073ef:	6a 00                	push   $0x0
801073f1:	68 f3 00 00 00       	push   $0xf3
801073f6:	e9 6c f1 ff ff       	jmp    80106567 <alltraps>

801073fb <vector244>:
801073fb:	6a 00                	push   $0x0
801073fd:	68 f4 00 00 00       	push   $0xf4
80107402:	e9 60 f1 ff ff       	jmp    80106567 <alltraps>

80107407 <vector245>:
80107407:	6a 00                	push   $0x0
80107409:	68 f5 00 00 00       	push   $0xf5
8010740e:	e9 54 f1 ff ff       	jmp    80106567 <alltraps>

80107413 <vector246>:
80107413:	6a 00                	push   $0x0
80107415:	68 f6 00 00 00       	push   $0xf6
8010741a:	e9 48 f1 ff ff       	jmp    80106567 <alltraps>

8010741f <vector247>:
8010741f:	6a 00                	push   $0x0
80107421:	68 f7 00 00 00       	push   $0xf7
80107426:	e9 3c f1 ff ff       	jmp    80106567 <alltraps>

8010742b <vector248>:
8010742b:	6a 00                	push   $0x0
8010742d:	68 f8 00 00 00       	push   $0xf8
80107432:	e9 30 f1 ff ff       	jmp    80106567 <alltraps>

80107437 <vector249>:
80107437:	6a 00                	push   $0x0
80107439:	68 f9 00 00 00       	push   $0xf9
8010743e:	e9 24 f1 ff ff       	jmp    80106567 <alltraps>

80107443 <vector250>:
80107443:	6a 00                	push   $0x0
80107445:	68 fa 00 00 00       	push   $0xfa
8010744a:	e9 18 f1 ff ff       	jmp    80106567 <alltraps>

8010744f <vector251>:
8010744f:	6a 00                	push   $0x0
80107451:	68 fb 00 00 00       	push   $0xfb
80107456:	e9 0c f1 ff ff       	jmp    80106567 <alltraps>

8010745b <vector252>:
8010745b:	6a 00                	push   $0x0
8010745d:	68 fc 00 00 00       	push   $0xfc
80107462:	e9 00 f1 ff ff       	jmp    80106567 <alltraps>

80107467 <vector253>:
80107467:	6a 00                	push   $0x0
80107469:	68 fd 00 00 00       	push   $0xfd
8010746e:	e9 f4 f0 ff ff       	jmp    80106567 <alltraps>

80107473 <vector254>:
80107473:	6a 00                	push   $0x0
80107475:	68 fe 00 00 00       	push   $0xfe
8010747a:	e9 e8 f0 ff ff       	jmp    80106567 <alltraps>

8010747f <vector255>:
8010747f:	6a 00                	push   $0x0
80107481:	68 ff 00 00 00       	push   $0xff
80107486:	e9 dc f0 ff ff       	jmp    80106567 <alltraps>
8010748b:	66 90                	xchg   %ax,%ax
8010748d:	66 90                	xchg   %ax,%ax
8010748f:	90                   	nop

80107490 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107490:	55                   	push   %ebp
80107491:	89 e5                	mov    %esp,%ebp
80107493:	57                   	push   %edi
80107494:	56                   	push   %esi
80107495:	89 d6                	mov    %edx,%esi
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80107497:	c1 ea 16             	shr    $0x16,%edx
{
8010749a:	53                   	push   %ebx
  pde = &pgdir[PDX(va)];
8010749b:	8d 3c 90             	lea    (%eax,%edx,4),%edi
{
8010749e:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
801074a1:	8b 1f                	mov    (%edi),%ebx
801074a3:	f6 c3 01             	test   $0x1,%bl
801074a6:	74 28                	je     801074d0 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801074a8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
801074ae:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
801074b4:	89 f0                	mov    %esi,%eax
}
801074b6:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
801074b9:	c1 e8 0a             	shr    $0xa,%eax
801074bc:	25 fc 0f 00 00       	and    $0xffc,%eax
801074c1:	01 d8                	add    %ebx,%eax
}
801074c3:	5b                   	pop    %ebx
801074c4:	5e                   	pop    %esi
801074c5:	5f                   	pop    %edi
801074c6:	5d                   	pop    %ebp
801074c7:	c3                   	ret    
801074c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801074cf:	90                   	nop
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
801074d0:	85 c9                	test   %ecx,%ecx
801074d2:	74 2c                	je     80107500 <walkpgdir+0x70>
801074d4:	e8 37 b5 ff ff       	call   80102a10 <kalloc>
801074d9:	89 c3                	mov    %eax,%ebx
801074db:	85 c0                	test   %eax,%eax
801074dd:	74 21                	je     80107500 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
801074df:	83 ec 04             	sub    $0x4,%esp
801074e2:	68 00 10 00 00       	push   $0x1000
801074e7:	6a 00                	push   $0x0
801074e9:	50                   	push   %eax
801074ea:	e8 c1 dc ff ff       	call   801051b0 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
801074ef:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801074f5:	83 c4 10             	add    $0x10,%esp
801074f8:	83 c8 07             	or     $0x7,%eax
801074fb:	89 07                	mov    %eax,(%edi)
801074fd:	eb b5                	jmp    801074b4 <walkpgdir+0x24>
801074ff:	90                   	nop
}
80107500:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
80107503:	31 c0                	xor    %eax,%eax
}
80107505:	5b                   	pop    %ebx
80107506:	5e                   	pop    %esi
80107507:	5f                   	pop    %edi
80107508:	5d                   	pop    %ebp
80107509:	c3                   	ret    
8010750a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107510 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80107510:	55                   	push   %ebp
80107511:	89 e5                	mov    %esp,%ebp
80107513:	57                   	push   %edi
80107514:	89 c7                	mov    %eax,%edi
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107516:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
{
8010751a:	56                   	push   %esi
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
8010751b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  a = (char*)PGROUNDDOWN((uint)va);
80107520:	89 d6                	mov    %edx,%esi
{
80107522:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
80107523:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
{
80107529:	83 ec 1c             	sub    $0x1c,%esp
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
8010752c:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010752f:	8b 45 08             	mov    0x8(%ebp),%eax
80107532:	29 f0                	sub    %esi,%eax
80107534:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107537:	eb 1f                	jmp    80107558 <mappages+0x48>
80107539:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
80107540:	f6 00 01             	testb  $0x1,(%eax)
80107543:	75 45                	jne    8010758a <mappages+0x7a>
      panic("remap");
    *pte = pa | perm | PTE_P;
80107545:	0b 5d 0c             	or     0xc(%ebp),%ebx
80107548:	83 cb 01             	or     $0x1,%ebx
8010754b:	89 18                	mov    %ebx,(%eax)
    if(a == last)
8010754d:	3b 75 e0             	cmp    -0x20(%ebp),%esi
80107550:	74 2e                	je     80107580 <mappages+0x70>
      break;
    a += PGSIZE;
80107552:	81 c6 00 10 00 00    	add    $0x1000,%esi
  for(;;){
80107558:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
8010755b:	b9 01 00 00 00       	mov    $0x1,%ecx
80107560:	89 f2                	mov    %esi,%edx
80107562:	8d 1c 06             	lea    (%esi,%eax,1),%ebx
80107565:	89 f8                	mov    %edi,%eax
80107567:	e8 24 ff ff ff       	call   80107490 <walkpgdir>
8010756c:	85 c0                	test   %eax,%eax
8010756e:	75 d0                	jne    80107540 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
80107570:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107573:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107578:	5b                   	pop    %ebx
80107579:	5e                   	pop    %esi
8010757a:	5f                   	pop    %edi
8010757b:	5d                   	pop    %ebp
8010757c:	c3                   	ret    
8010757d:	8d 76 00             	lea    0x0(%esi),%esi
80107580:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107583:	31 c0                	xor    %eax,%eax
}
80107585:	5b                   	pop    %ebx
80107586:	5e                   	pop    %esi
80107587:	5f                   	pop    %edi
80107588:	5d                   	pop    %ebp
80107589:	c3                   	ret    
      panic("remap");
8010758a:	83 ec 0c             	sub    $0xc,%esp
8010758d:	68 04 88 10 80       	push   $0x80108804
80107592:	e8 f9 8d ff ff       	call   80100390 <panic>
80107597:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010759e:	66 90                	xchg   %ax,%ax

801075a0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801075a0:	55                   	push   %ebp
801075a1:	89 e5                	mov    %esp,%ebp
801075a3:	57                   	push   %edi
801075a4:	56                   	push   %esi
801075a5:	89 c6                	mov    %eax,%esi
801075a7:	53                   	push   %ebx
801075a8:	89 d3                	mov    %edx,%ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
801075aa:	8d 91 ff 0f 00 00    	lea    0xfff(%ecx),%edx
801075b0:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801075b6:	83 ec 1c             	sub    $0x1c,%esp
801075b9:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
801075bc:	39 da                	cmp    %ebx,%edx
801075be:	73 5b                	jae    8010761b <deallocuvm.part.0+0x7b>
801075c0:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801075c3:	89 d7                	mov    %edx,%edi
801075c5:	eb 14                	jmp    801075db <deallocuvm.part.0+0x3b>
801075c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801075ce:	66 90                	xchg   %ax,%ax
801075d0:	81 c7 00 10 00 00    	add    $0x1000,%edi
801075d6:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801075d9:	76 40                	jbe    8010761b <deallocuvm.part.0+0x7b>
    pte = walkpgdir(pgdir, (char*)a, 0);
801075db:	31 c9                	xor    %ecx,%ecx
801075dd:	89 fa                	mov    %edi,%edx
801075df:	89 f0                	mov    %esi,%eax
801075e1:	e8 aa fe ff ff       	call   80107490 <walkpgdir>
801075e6:	89 c3                	mov    %eax,%ebx
    if(!pte)
801075e8:	85 c0                	test   %eax,%eax
801075ea:	74 44                	je     80107630 <deallocuvm.part.0+0x90>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
801075ec:	8b 00                	mov    (%eax),%eax
801075ee:	a8 01                	test   $0x1,%al
801075f0:	74 de                	je     801075d0 <deallocuvm.part.0+0x30>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
801075f2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801075f7:	74 47                	je     80107640 <deallocuvm.part.0+0xa0>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
801075f9:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
801075fc:	05 00 00 00 80       	add    $0x80000000,%eax
80107601:	81 c7 00 10 00 00    	add    $0x1000,%edi
      kfree(v);
80107607:	50                   	push   %eax
80107608:	e8 43 b2 ff ff       	call   80102850 <kfree>
      *pte = 0;
8010760d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80107613:	83 c4 10             	add    $0x10,%esp
  for(; a  < oldsz; a += PGSIZE){
80107616:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80107619:	77 c0                	ja     801075db <deallocuvm.part.0+0x3b>
    }
  }
  return newsz;
}
8010761b:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010761e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107621:	5b                   	pop    %ebx
80107622:	5e                   	pop    %esi
80107623:	5f                   	pop    %edi
80107624:	5d                   	pop    %ebp
80107625:	c3                   	ret    
80107626:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010762d:	8d 76 00             	lea    0x0(%esi),%esi
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80107630:	89 fa                	mov    %edi,%edx
80107632:	81 e2 00 00 c0 ff    	and    $0xffc00000,%edx
80107638:	8d ba 00 00 40 00    	lea    0x400000(%edx),%edi
8010763e:	eb 96                	jmp    801075d6 <deallocuvm.part.0+0x36>
        panic("kfree");
80107640:	83 ec 0c             	sub    $0xc,%esp
80107643:	68 9e 80 10 80       	push   $0x8010809e
80107648:	e8 43 8d ff ff       	call   80100390 <panic>
8010764d:	8d 76 00             	lea    0x0(%esi),%esi

80107650 <seginit>:
{
80107650:	f3 0f 1e fb          	endbr32 
80107654:	55                   	push   %ebp
80107655:	89 e5                	mov    %esp,%ebp
80107657:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
8010765a:	e8 21 c7 ff ff       	call   80103d80 <cpuid>
  pd[0] = size-1;
8010765f:	ba 2f 00 00 00       	mov    $0x2f,%edx
80107664:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
8010766a:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010766e:	c7 80 38 38 11 80 ff 	movl   $0xffff,-0x7feec7c8(%eax)
80107675:	ff 00 00 
80107678:	c7 80 3c 38 11 80 00 	movl   $0xcf9a00,-0x7feec7c4(%eax)
8010767f:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80107682:	c7 80 40 38 11 80 ff 	movl   $0xffff,-0x7feec7c0(%eax)
80107689:	ff 00 00 
8010768c:	c7 80 44 38 11 80 00 	movl   $0xcf9200,-0x7feec7bc(%eax)
80107693:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107696:	c7 80 48 38 11 80 ff 	movl   $0xffff,-0x7feec7b8(%eax)
8010769d:	ff 00 00 
801076a0:	c7 80 4c 38 11 80 00 	movl   $0xcffa00,-0x7feec7b4(%eax)
801076a7:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801076aa:	c7 80 50 38 11 80 ff 	movl   $0xffff,-0x7feec7b0(%eax)
801076b1:	ff 00 00 
801076b4:	c7 80 54 38 11 80 00 	movl   $0xcff200,-0x7feec7ac(%eax)
801076bb:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
801076be:	05 30 38 11 80       	add    $0x80113830,%eax
  pd[1] = (uint)p;
801076c3:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
801076c7:	c1 e8 10             	shr    $0x10,%eax
801076ca:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
801076ce:	8d 45 f2             	lea    -0xe(%ebp),%eax
801076d1:	0f 01 10             	lgdtl  (%eax)
}
801076d4:	c9                   	leave  
801076d5:	c3                   	ret    
801076d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801076dd:	8d 76 00             	lea    0x0(%esi),%esi

801076e0 <switchkvm>:
{
801076e0:	f3 0f 1e fb          	endbr32 
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801076e4:	a1 84 73 11 80       	mov    0x80117384,%eax
801076e9:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
801076ee:	0f 22 d8             	mov    %eax,%cr3
}
801076f1:	c3                   	ret    
801076f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801076f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107700 <switchuvm>:
{
80107700:	f3 0f 1e fb          	endbr32 
80107704:	55                   	push   %ebp
80107705:	89 e5                	mov    %esp,%ebp
80107707:	57                   	push   %edi
80107708:	56                   	push   %esi
80107709:	53                   	push   %ebx
8010770a:	83 ec 1c             	sub    $0x1c,%esp
8010770d:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80107710:	85 f6                	test   %esi,%esi
80107712:	0f 84 cb 00 00 00    	je     801077e3 <switchuvm+0xe3>
  if(p->kstack == 0)
80107718:	8b 46 08             	mov    0x8(%esi),%eax
8010771b:	85 c0                	test   %eax,%eax
8010771d:	0f 84 da 00 00 00    	je     801077fd <switchuvm+0xfd>
  if(p->pgdir == 0)
80107723:	8b 46 04             	mov    0x4(%esi),%eax
80107726:	85 c0                	test   %eax,%eax
80107728:	0f 84 c2 00 00 00    	je     801077f0 <switchuvm+0xf0>
  pushcli();
8010772e:	e8 6d d8 ff ff       	call   80104fa0 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80107733:	e8 d8 c5 ff ff       	call   80103d10 <mycpu>
80107738:	89 c3                	mov    %eax,%ebx
8010773a:	e8 d1 c5 ff ff       	call   80103d10 <mycpu>
8010773f:	89 c7                	mov    %eax,%edi
80107741:	e8 ca c5 ff ff       	call   80103d10 <mycpu>
80107746:	83 c7 08             	add    $0x8,%edi
80107749:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010774c:	e8 bf c5 ff ff       	call   80103d10 <mycpu>
80107751:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107754:	ba 67 00 00 00       	mov    $0x67,%edx
80107759:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80107760:	83 c0 08             	add    $0x8,%eax
80107763:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
8010776a:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010776f:	83 c1 08             	add    $0x8,%ecx
80107772:	c1 e8 18             	shr    $0x18,%eax
80107775:	c1 e9 10             	shr    $0x10,%ecx
80107778:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
8010777e:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80107784:	b9 99 40 00 00       	mov    $0x4099,%ecx
80107789:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80107790:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
80107795:	e8 76 c5 ff ff       	call   80103d10 <mycpu>
8010779a:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
801077a1:	e8 6a c5 ff ff       	call   80103d10 <mycpu>
801077a6:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
801077aa:	8b 5e 08             	mov    0x8(%esi),%ebx
801077ad:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801077b3:	e8 58 c5 ff ff       	call   80103d10 <mycpu>
801077b8:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801077bb:	e8 50 c5 ff ff       	call   80103d10 <mycpu>
801077c0:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
801077c4:	b8 28 00 00 00       	mov    $0x28,%eax
801077c9:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
801077cc:	8b 46 04             	mov    0x4(%esi),%eax
801077cf:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
801077d4:	0f 22 d8             	mov    %eax,%cr3
}
801077d7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801077da:	5b                   	pop    %ebx
801077db:	5e                   	pop    %esi
801077dc:	5f                   	pop    %edi
801077dd:	5d                   	pop    %ebp
  popcli();
801077de:	e9 0d d8 ff ff       	jmp    80104ff0 <popcli>
    panic("switchuvm: no process");
801077e3:	83 ec 0c             	sub    $0xc,%esp
801077e6:	68 0a 88 10 80       	push   $0x8010880a
801077eb:	e8 a0 8b ff ff       	call   80100390 <panic>
    panic("switchuvm: no pgdir");
801077f0:	83 ec 0c             	sub    $0xc,%esp
801077f3:	68 35 88 10 80       	push   $0x80108835
801077f8:	e8 93 8b ff ff       	call   80100390 <panic>
    panic("switchuvm: no kstack");
801077fd:	83 ec 0c             	sub    $0xc,%esp
80107800:	68 20 88 10 80       	push   $0x80108820
80107805:	e8 86 8b ff ff       	call   80100390 <panic>
8010780a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107810 <inituvm>:
{
80107810:	f3 0f 1e fb          	endbr32 
80107814:	55                   	push   %ebp
80107815:	89 e5                	mov    %esp,%ebp
80107817:	57                   	push   %edi
80107818:	56                   	push   %esi
80107819:	53                   	push   %ebx
8010781a:	83 ec 1c             	sub    $0x1c,%esp
8010781d:	8b 45 0c             	mov    0xc(%ebp),%eax
80107820:	8b 75 10             	mov    0x10(%ebp),%esi
80107823:	8b 7d 08             	mov    0x8(%ebp),%edi
80107826:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80107829:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
8010782f:	77 4b                	ja     8010787c <inituvm+0x6c>
  mem = kalloc();
80107831:	e8 da b1 ff ff       	call   80102a10 <kalloc>
  memset(mem, 0, PGSIZE);
80107836:	83 ec 04             	sub    $0x4,%esp
80107839:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
8010783e:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80107840:	6a 00                	push   $0x0
80107842:	50                   	push   %eax
80107843:	e8 68 d9 ff ff       	call   801051b0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107848:	58                   	pop    %eax
80107849:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010784f:	5a                   	pop    %edx
80107850:	6a 06                	push   $0x6
80107852:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107857:	31 d2                	xor    %edx,%edx
80107859:	50                   	push   %eax
8010785a:	89 f8                	mov    %edi,%eax
8010785c:	e8 af fc ff ff       	call   80107510 <mappages>
  memmove(mem, init, sz);
80107861:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107864:	89 75 10             	mov    %esi,0x10(%ebp)
80107867:	83 c4 10             	add    $0x10,%esp
8010786a:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010786d:	89 45 0c             	mov    %eax,0xc(%ebp)
}
80107870:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107873:	5b                   	pop    %ebx
80107874:	5e                   	pop    %esi
80107875:	5f                   	pop    %edi
80107876:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80107877:	e9 d4 d9 ff ff       	jmp    80105250 <memmove>
    panic("inituvm: more than a page");
8010787c:	83 ec 0c             	sub    $0xc,%esp
8010787f:	68 49 88 10 80       	push   $0x80108849
80107884:	e8 07 8b ff ff       	call   80100390 <panic>
80107889:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107890 <loaduvm>:
{
80107890:	f3 0f 1e fb          	endbr32 
80107894:	55                   	push   %ebp
80107895:	89 e5                	mov    %esp,%ebp
80107897:	57                   	push   %edi
80107898:	56                   	push   %esi
80107899:	53                   	push   %ebx
8010789a:	83 ec 1c             	sub    $0x1c,%esp
8010789d:	8b 45 0c             	mov    0xc(%ebp),%eax
801078a0:	8b 75 18             	mov    0x18(%ebp),%esi
  if((uint) addr % PGSIZE != 0)
801078a3:	a9 ff 0f 00 00       	test   $0xfff,%eax
801078a8:	0f 85 99 00 00 00    	jne    80107947 <loaduvm+0xb7>
  for(i = 0; i < sz; i += PGSIZE){
801078ae:	01 f0                	add    %esi,%eax
801078b0:	89 f3                	mov    %esi,%ebx
801078b2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
801078b5:	8b 45 14             	mov    0x14(%ebp),%eax
801078b8:	01 f0                	add    %esi,%eax
801078ba:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
801078bd:	85 f6                	test   %esi,%esi
801078bf:	75 15                	jne    801078d6 <loaduvm+0x46>
801078c1:	eb 6d                	jmp    80107930 <loaduvm+0xa0>
801078c3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801078c7:	90                   	nop
801078c8:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
801078ce:	89 f0                	mov    %esi,%eax
801078d0:	29 d8                	sub    %ebx,%eax
801078d2:	39 c6                	cmp    %eax,%esi
801078d4:	76 5a                	jbe    80107930 <loaduvm+0xa0>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
801078d6:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801078d9:	8b 45 08             	mov    0x8(%ebp),%eax
801078dc:	31 c9                	xor    %ecx,%ecx
801078de:	29 da                	sub    %ebx,%edx
801078e0:	e8 ab fb ff ff       	call   80107490 <walkpgdir>
801078e5:	85 c0                	test   %eax,%eax
801078e7:	74 51                	je     8010793a <loaduvm+0xaa>
    pa = PTE_ADDR(*pte);
801078e9:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
801078eb:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    if(sz - i < PGSIZE)
801078ee:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
801078f3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
801078f8:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
801078fe:	0f 46 fb             	cmovbe %ebx,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107901:	29 d9                	sub    %ebx,%ecx
80107903:	05 00 00 00 80       	add    $0x80000000,%eax
80107908:	57                   	push   %edi
80107909:	51                   	push   %ecx
8010790a:	50                   	push   %eax
8010790b:	ff 75 10             	pushl  0x10(%ebp)
8010790e:	e8 2d a5 ff ff       	call   80101e40 <readi>
80107913:	83 c4 10             	add    $0x10,%esp
80107916:	39 f8                	cmp    %edi,%eax
80107918:	74 ae                	je     801078c8 <loaduvm+0x38>
}
8010791a:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010791d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107922:	5b                   	pop    %ebx
80107923:	5e                   	pop    %esi
80107924:	5f                   	pop    %edi
80107925:	5d                   	pop    %ebp
80107926:	c3                   	ret    
80107927:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010792e:	66 90                	xchg   %ax,%ax
80107930:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107933:	31 c0                	xor    %eax,%eax
}
80107935:	5b                   	pop    %ebx
80107936:	5e                   	pop    %esi
80107937:	5f                   	pop    %edi
80107938:	5d                   	pop    %ebp
80107939:	c3                   	ret    
      panic("loaduvm: address should exist");
8010793a:	83 ec 0c             	sub    $0xc,%esp
8010793d:	68 63 88 10 80       	push   $0x80108863
80107942:	e8 49 8a ff ff       	call   80100390 <panic>
    panic("loaduvm: addr must be page aligned");
80107947:	83 ec 0c             	sub    $0xc,%esp
8010794a:	68 04 89 10 80       	push   $0x80108904
8010794f:	e8 3c 8a ff ff       	call   80100390 <panic>
80107954:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010795b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010795f:	90                   	nop

80107960 <allocuvm>:
{
80107960:	f3 0f 1e fb          	endbr32 
80107964:	55                   	push   %ebp
80107965:	89 e5                	mov    %esp,%ebp
80107967:	57                   	push   %edi
80107968:	56                   	push   %esi
80107969:	53                   	push   %ebx
8010796a:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
8010796d:	8b 45 10             	mov    0x10(%ebp),%eax
{
80107970:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(newsz >= KERNBASE)
80107973:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107976:	85 c0                	test   %eax,%eax
80107978:	0f 88 b2 00 00 00    	js     80107a30 <allocuvm+0xd0>
  if(newsz < oldsz)
8010797e:	3b 45 0c             	cmp    0xc(%ebp),%eax
    return oldsz;
80107981:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(newsz < oldsz)
80107984:	0f 82 96 00 00 00    	jb     80107a20 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
8010798a:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
80107990:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  for(; a < newsz; a += PGSIZE){
80107996:	39 75 10             	cmp    %esi,0x10(%ebp)
80107999:	77 40                	ja     801079db <allocuvm+0x7b>
8010799b:	e9 83 00 00 00       	jmp    80107a23 <allocuvm+0xc3>
    memset(mem, 0, PGSIZE);
801079a0:	83 ec 04             	sub    $0x4,%esp
801079a3:	68 00 10 00 00       	push   $0x1000
801079a8:	6a 00                	push   $0x0
801079aa:	50                   	push   %eax
801079ab:	e8 00 d8 ff ff       	call   801051b0 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
801079b0:	58                   	pop    %eax
801079b1:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801079b7:	5a                   	pop    %edx
801079b8:	6a 06                	push   $0x6
801079ba:	b9 00 10 00 00       	mov    $0x1000,%ecx
801079bf:	89 f2                	mov    %esi,%edx
801079c1:	50                   	push   %eax
801079c2:	89 f8                	mov    %edi,%eax
801079c4:	e8 47 fb ff ff       	call   80107510 <mappages>
801079c9:	83 c4 10             	add    $0x10,%esp
801079cc:	85 c0                	test   %eax,%eax
801079ce:	78 78                	js     80107a48 <allocuvm+0xe8>
  for(; a < newsz; a += PGSIZE){
801079d0:	81 c6 00 10 00 00    	add    $0x1000,%esi
801079d6:	39 75 10             	cmp    %esi,0x10(%ebp)
801079d9:	76 48                	jbe    80107a23 <allocuvm+0xc3>
    mem = kalloc();
801079db:	e8 30 b0 ff ff       	call   80102a10 <kalloc>
801079e0:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
801079e2:	85 c0                	test   %eax,%eax
801079e4:	75 ba                	jne    801079a0 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
801079e6:	83 ec 0c             	sub    $0xc,%esp
801079e9:	68 81 88 10 80       	push   $0x80108881
801079ee:	e8 bd 8c ff ff       	call   801006b0 <cprintf>
  if(newsz >= oldsz)
801079f3:	8b 45 0c             	mov    0xc(%ebp),%eax
801079f6:	83 c4 10             	add    $0x10,%esp
801079f9:	39 45 10             	cmp    %eax,0x10(%ebp)
801079fc:	74 32                	je     80107a30 <allocuvm+0xd0>
801079fe:	8b 55 10             	mov    0x10(%ebp),%edx
80107a01:	89 c1                	mov    %eax,%ecx
80107a03:	89 f8                	mov    %edi,%eax
80107a05:	e8 96 fb ff ff       	call   801075a0 <deallocuvm.part.0>
      return 0;
80107a0a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80107a11:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107a14:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107a17:	5b                   	pop    %ebx
80107a18:	5e                   	pop    %esi
80107a19:	5f                   	pop    %edi
80107a1a:	5d                   	pop    %ebp
80107a1b:	c3                   	ret    
80107a1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
80107a20:	89 45 e4             	mov    %eax,-0x1c(%ebp)
}
80107a23:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107a26:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107a29:	5b                   	pop    %ebx
80107a2a:	5e                   	pop    %esi
80107a2b:	5f                   	pop    %edi
80107a2c:	5d                   	pop    %ebp
80107a2d:	c3                   	ret    
80107a2e:	66 90                	xchg   %ax,%ax
    return 0;
80107a30:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80107a37:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107a3a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107a3d:	5b                   	pop    %ebx
80107a3e:	5e                   	pop    %esi
80107a3f:	5f                   	pop    %edi
80107a40:	5d                   	pop    %ebp
80107a41:	c3                   	ret    
80107a42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80107a48:	83 ec 0c             	sub    $0xc,%esp
80107a4b:	68 99 88 10 80       	push   $0x80108899
80107a50:	e8 5b 8c ff ff       	call   801006b0 <cprintf>
  if(newsz >= oldsz)
80107a55:	8b 45 0c             	mov    0xc(%ebp),%eax
80107a58:	83 c4 10             	add    $0x10,%esp
80107a5b:	39 45 10             	cmp    %eax,0x10(%ebp)
80107a5e:	74 0c                	je     80107a6c <allocuvm+0x10c>
80107a60:	8b 55 10             	mov    0x10(%ebp),%edx
80107a63:	89 c1                	mov    %eax,%ecx
80107a65:	89 f8                	mov    %edi,%eax
80107a67:	e8 34 fb ff ff       	call   801075a0 <deallocuvm.part.0>
      kfree(mem);
80107a6c:	83 ec 0c             	sub    $0xc,%esp
80107a6f:	53                   	push   %ebx
80107a70:	e8 db ad ff ff       	call   80102850 <kfree>
      return 0;
80107a75:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80107a7c:	83 c4 10             	add    $0x10,%esp
}
80107a7f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107a82:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107a85:	5b                   	pop    %ebx
80107a86:	5e                   	pop    %esi
80107a87:	5f                   	pop    %edi
80107a88:	5d                   	pop    %ebp
80107a89:	c3                   	ret    
80107a8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107a90 <deallocuvm>:
{
80107a90:	f3 0f 1e fb          	endbr32 
80107a94:	55                   	push   %ebp
80107a95:	89 e5                	mov    %esp,%ebp
80107a97:	8b 55 0c             	mov    0xc(%ebp),%edx
80107a9a:	8b 4d 10             	mov    0x10(%ebp),%ecx
80107a9d:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
80107aa0:	39 d1                	cmp    %edx,%ecx
80107aa2:	73 0c                	jae    80107ab0 <deallocuvm+0x20>
}
80107aa4:	5d                   	pop    %ebp
80107aa5:	e9 f6 fa ff ff       	jmp    801075a0 <deallocuvm.part.0>
80107aaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107ab0:	89 d0                	mov    %edx,%eax
80107ab2:	5d                   	pop    %ebp
80107ab3:	c3                   	ret    
80107ab4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107abb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107abf:	90                   	nop

80107ac0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107ac0:	f3 0f 1e fb          	endbr32 
80107ac4:	55                   	push   %ebp
80107ac5:	89 e5                	mov    %esp,%ebp
80107ac7:	57                   	push   %edi
80107ac8:	56                   	push   %esi
80107ac9:	53                   	push   %ebx
80107aca:	83 ec 0c             	sub    $0xc,%esp
80107acd:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80107ad0:	85 f6                	test   %esi,%esi
80107ad2:	74 55                	je     80107b29 <freevm+0x69>
  if(newsz >= oldsz)
80107ad4:	31 c9                	xor    %ecx,%ecx
80107ad6:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107adb:	89 f0                	mov    %esi,%eax
80107add:	89 f3                	mov    %esi,%ebx
80107adf:	e8 bc fa ff ff       	call   801075a0 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107ae4:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107aea:	eb 0b                	jmp    80107af7 <freevm+0x37>
80107aec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107af0:	83 c3 04             	add    $0x4,%ebx
80107af3:	39 df                	cmp    %ebx,%edi
80107af5:	74 23                	je     80107b1a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80107af7:	8b 03                	mov    (%ebx),%eax
80107af9:	a8 01                	test   $0x1,%al
80107afb:	74 f3                	je     80107af0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107afd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80107b02:	83 ec 0c             	sub    $0xc,%esp
80107b05:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107b08:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80107b0d:	50                   	push   %eax
80107b0e:	e8 3d ad ff ff       	call   80102850 <kfree>
80107b13:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107b16:	39 df                	cmp    %ebx,%edi
80107b18:	75 dd                	jne    80107af7 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
80107b1a:	89 75 08             	mov    %esi,0x8(%ebp)
}
80107b1d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107b20:	5b                   	pop    %ebx
80107b21:	5e                   	pop    %esi
80107b22:	5f                   	pop    %edi
80107b23:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107b24:	e9 27 ad ff ff       	jmp    80102850 <kfree>
    panic("freevm: no pgdir");
80107b29:	83 ec 0c             	sub    $0xc,%esp
80107b2c:	68 b5 88 10 80       	push   $0x801088b5
80107b31:	e8 5a 88 ff ff       	call   80100390 <panic>
80107b36:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107b3d:	8d 76 00             	lea    0x0(%esi),%esi

80107b40 <setupkvm>:
{
80107b40:	f3 0f 1e fb          	endbr32 
80107b44:	55                   	push   %ebp
80107b45:	89 e5                	mov    %esp,%ebp
80107b47:	56                   	push   %esi
80107b48:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80107b49:	e8 c2 ae ff ff       	call   80102a10 <kalloc>
80107b4e:	89 c6                	mov    %eax,%esi
80107b50:	85 c0                	test   %eax,%eax
80107b52:	74 42                	je     80107b96 <setupkvm+0x56>
  memset(pgdir, 0, PGSIZE);
80107b54:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107b57:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  memset(pgdir, 0, PGSIZE);
80107b5c:	68 00 10 00 00       	push   $0x1000
80107b61:	6a 00                	push   $0x0
80107b63:	50                   	push   %eax
80107b64:	e8 47 d6 ff ff       	call   801051b0 <memset>
80107b69:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80107b6c:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80107b6f:	83 ec 08             	sub    $0x8,%esp
80107b72:	8b 4b 08             	mov    0x8(%ebx),%ecx
80107b75:	ff 73 0c             	pushl  0xc(%ebx)
80107b78:	8b 13                	mov    (%ebx),%edx
80107b7a:	50                   	push   %eax
80107b7b:	29 c1                	sub    %eax,%ecx
80107b7d:	89 f0                	mov    %esi,%eax
80107b7f:	e8 8c f9 ff ff       	call   80107510 <mappages>
80107b84:	83 c4 10             	add    $0x10,%esp
80107b87:	85 c0                	test   %eax,%eax
80107b89:	78 15                	js     80107ba0 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107b8b:	83 c3 10             	add    $0x10,%ebx
80107b8e:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
80107b94:	75 d6                	jne    80107b6c <setupkvm+0x2c>
}
80107b96:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107b99:	89 f0                	mov    %esi,%eax
80107b9b:	5b                   	pop    %ebx
80107b9c:	5e                   	pop    %esi
80107b9d:	5d                   	pop    %ebp
80107b9e:	c3                   	ret    
80107b9f:	90                   	nop
      freevm(pgdir);
80107ba0:	83 ec 0c             	sub    $0xc,%esp
80107ba3:	56                   	push   %esi
      return 0;
80107ba4:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80107ba6:	e8 15 ff ff ff       	call   80107ac0 <freevm>
      return 0;
80107bab:	83 c4 10             	add    $0x10,%esp
}
80107bae:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107bb1:	89 f0                	mov    %esi,%eax
80107bb3:	5b                   	pop    %ebx
80107bb4:	5e                   	pop    %esi
80107bb5:	5d                   	pop    %ebp
80107bb6:	c3                   	ret    
80107bb7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107bbe:	66 90                	xchg   %ax,%ax

80107bc0 <kvmalloc>:
{
80107bc0:	f3 0f 1e fb          	endbr32 
80107bc4:	55                   	push   %ebp
80107bc5:	89 e5                	mov    %esp,%ebp
80107bc7:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107bca:	e8 71 ff ff ff       	call   80107b40 <setupkvm>
80107bcf:	a3 84 73 11 80       	mov    %eax,0x80117384
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107bd4:	05 00 00 00 80       	add    $0x80000000,%eax
80107bd9:	0f 22 d8             	mov    %eax,%cr3
}
80107bdc:	c9                   	leave  
80107bdd:	c3                   	ret    
80107bde:	66 90                	xchg   %ax,%ax

80107be0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107be0:	f3 0f 1e fb          	endbr32 
80107be4:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107be5:	31 c9                	xor    %ecx,%ecx
{
80107be7:	89 e5                	mov    %esp,%ebp
80107be9:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107bec:	8b 55 0c             	mov    0xc(%ebp),%edx
80107bef:	8b 45 08             	mov    0x8(%ebp),%eax
80107bf2:	e8 99 f8 ff ff       	call   80107490 <walkpgdir>
  if(pte == 0)
80107bf7:	85 c0                	test   %eax,%eax
80107bf9:	74 05                	je     80107c00 <clearpteu+0x20>
    panic("clearpteu");
  *pte &= ~PTE_U;
80107bfb:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80107bfe:	c9                   	leave  
80107bff:	c3                   	ret    
    panic("clearpteu");
80107c00:	83 ec 0c             	sub    $0xc,%esp
80107c03:	68 c6 88 10 80       	push   $0x801088c6
80107c08:	e8 83 87 ff ff       	call   80100390 <panic>
80107c0d:	8d 76 00             	lea    0x0(%esi),%esi

80107c10 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107c10:	f3 0f 1e fb          	endbr32 
80107c14:	55                   	push   %ebp
80107c15:	89 e5                	mov    %esp,%ebp
80107c17:	57                   	push   %edi
80107c18:	56                   	push   %esi
80107c19:	53                   	push   %ebx
80107c1a:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107c1d:	e8 1e ff ff ff       	call   80107b40 <setupkvm>
80107c22:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107c25:	85 c0                	test   %eax,%eax
80107c27:	0f 84 9b 00 00 00    	je     80107cc8 <copyuvm+0xb8>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107c2d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107c30:	85 c9                	test   %ecx,%ecx
80107c32:	0f 84 90 00 00 00    	je     80107cc8 <copyuvm+0xb8>
80107c38:	31 f6                	xor    %esi,%esi
80107c3a:	eb 46                	jmp    80107c82 <copyuvm+0x72>
80107c3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107c40:	83 ec 04             	sub    $0x4,%esp
80107c43:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107c49:	68 00 10 00 00       	push   $0x1000
80107c4e:	57                   	push   %edi
80107c4f:	50                   	push   %eax
80107c50:	e8 fb d5 ff ff       	call   80105250 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80107c55:	58                   	pop    %eax
80107c56:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107c5c:	5a                   	pop    %edx
80107c5d:	ff 75 e4             	pushl  -0x1c(%ebp)
80107c60:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107c65:	89 f2                	mov    %esi,%edx
80107c67:	50                   	push   %eax
80107c68:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107c6b:	e8 a0 f8 ff ff       	call   80107510 <mappages>
80107c70:	83 c4 10             	add    $0x10,%esp
80107c73:	85 c0                	test   %eax,%eax
80107c75:	78 61                	js     80107cd8 <copyuvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
80107c77:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107c7d:	39 75 0c             	cmp    %esi,0xc(%ebp)
80107c80:	76 46                	jbe    80107cc8 <copyuvm+0xb8>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107c82:	8b 45 08             	mov    0x8(%ebp),%eax
80107c85:	31 c9                	xor    %ecx,%ecx
80107c87:	89 f2                	mov    %esi,%edx
80107c89:	e8 02 f8 ff ff       	call   80107490 <walkpgdir>
80107c8e:	85 c0                	test   %eax,%eax
80107c90:	74 61                	je     80107cf3 <copyuvm+0xe3>
    if(!(*pte & PTE_P))
80107c92:	8b 00                	mov    (%eax),%eax
80107c94:	a8 01                	test   $0x1,%al
80107c96:	74 4e                	je     80107ce6 <copyuvm+0xd6>
    pa = PTE_ADDR(*pte);
80107c98:	89 c7                	mov    %eax,%edi
    flags = PTE_FLAGS(*pte);
80107c9a:	25 ff 0f 00 00       	and    $0xfff,%eax
80107c9f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    pa = PTE_ADDR(*pte);
80107ca2:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
80107ca8:	e8 63 ad ff ff       	call   80102a10 <kalloc>
80107cad:	89 c3                	mov    %eax,%ebx
80107caf:	85 c0                	test   %eax,%eax
80107cb1:	75 8d                	jne    80107c40 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
80107cb3:	83 ec 0c             	sub    $0xc,%esp
80107cb6:	ff 75 e0             	pushl  -0x20(%ebp)
80107cb9:	e8 02 fe ff ff       	call   80107ac0 <freevm>
  return 0;
80107cbe:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
80107cc5:	83 c4 10             	add    $0x10,%esp
}
80107cc8:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107ccb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107cce:	5b                   	pop    %ebx
80107ccf:	5e                   	pop    %esi
80107cd0:	5f                   	pop    %edi
80107cd1:	5d                   	pop    %ebp
80107cd2:	c3                   	ret    
80107cd3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107cd7:	90                   	nop
      kfree(mem);
80107cd8:	83 ec 0c             	sub    $0xc,%esp
80107cdb:	53                   	push   %ebx
80107cdc:	e8 6f ab ff ff       	call   80102850 <kfree>
      goto bad;
80107ce1:	83 c4 10             	add    $0x10,%esp
80107ce4:	eb cd                	jmp    80107cb3 <copyuvm+0xa3>
      panic("copyuvm: page not present");
80107ce6:	83 ec 0c             	sub    $0xc,%esp
80107ce9:	68 ea 88 10 80       	push   $0x801088ea
80107cee:	e8 9d 86 ff ff       	call   80100390 <panic>
      panic("copyuvm: pte should exist");
80107cf3:	83 ec 0c             	sub    $0xc,%esp
80107cf6:	68 d0 88 10 80       	push   $0x801088d0
80107cfb:	e8 90 86 ff ff       	call   80100390 <panic>

80107d00 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107d00:	f3 0f 1e fb          	endbr32 
80107d04:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107d05:	31 c9                	xor    %ecx,%ecx
{
80107d07:	89 e5                	mov    %esp,%ebp
80107d09:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107d0c:	8b 55 0c             	mov    0xc(%ebp),%edx
80107d0f:	8b 45 08             	mov    0x8(%ebp),%eax
80107d12:	e8 79 f7 ff ff       	call   80107490 <walkpgdir>
  if((*pte & PTE_P) == 0)
80107d17:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107d19:	c9                   	leave  
  if((*pte & PTE_U) == 0)
80107d1a:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107d1c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
80107d21:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107d24:	05 00 00 00 80       	add    $0x80000000,%eax
80107d29:	83 fa 05             	cmp    $0x5,%edx
80107d2c:	ba 00 00 00 00       	mov    $0x0,%edx
80107d31:	0f 45 c2             	cmovne %edx,%eax
}
80107d34:	c3                   	ret    
80107d35:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107d3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107d40 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107d40:	f3 0f 1e fb          	endbr32 
80107d44:	55                   	push   %ebp
80107d45:	89 e5                	mov    %esp,%ebp
80107d47:	57                   	push   %edi
80107d48:	56                   	push   %esi
80107d49:	53                   	push   %ebx
80107d4a:	83 ec 0c             	sub    $0xc,%esp
80107d4d:	8b 75 14             	mov    0x14(%ebp),%esi
80107d50:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107d53:	85 f6                	test   %esi,%esi
80107d55:	75 3c                	jne    80107d93 <copyout+0x53>
80107d57:	eb 67                	jmp    80107dc0 <copyout+0x80>
80107d59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80107d60:	8b 55 0c             	mov    0xc(%ebp),%edx
80107d63:	89 fb                	mov    %edi,%ebx
80107d65:	29 d3                	sub    %edx,%ebx
80107d67:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if(n > len)
80107d6d:	39 f3                	cmp    %esi,%ebx
80107d6f:	0f 47 de             	cmova  %esi,%ebx
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107d72:	29 fa                	sub    %edi,%edx
80107d74:	83 ec 04             	sub    $0x4,%esp
80107d77:	01 c2                	add    %eax,%edx
80107d79:	53                   	push   %ebx
80107d7a:	ff 75 10             	pushl  0x10(%ebp)
80107d7d:	52                   	push   %edx
80107d7e:	e8 cd d4 ff ff       	call   80105250 <memmove>
    len -= n;
    buf += n;
80107d83:	01 5d 10             	add    %ebx,0x10(%ebp)
    va = va0 + PGSIZE;
80107d86:	8d 97 00 10 00 00    	lea    0x1000(%edi),%edx
  while(len > 0){
80107d8c:	83 c4 10             	add    $0x10,%esp
80107d8f:	29 de                	sub    %ebx,%esi
80107d91:	74 2d                	je     80107dc0 <copyout+0x80>
    va0 = (uint)PGROUNDDOWN(va);
80107d93:	89 d7                	mov    %edx,%edi
    pa0 = uva2ka(pgdir, (char*)va0);
80107d95:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
80107d98:	89 55 0c             	mov    %edx,0xc(%ebp)
80107d9b:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    pa0 = uva2ka(pgdir, (char*)va0);
80107da1:	57                   	push   %edi
80107da2:	ff 75 08             	pushl  0x8(%ebp)
80107da5:	e8 56 ff ff ff       	call   80107d00 <uva2ka>
    if(pa0 == 0)
80107daa:	83 c4 10             	add    $0x10,%esp
80107dad:	85 c0                	test   %eax,%eax
80107daf:	75 af                	jne    80107d60 <copyout+0x20>
  }
  return 0;
}
80107db1:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107db4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107db9:	5b                   	pop    %ebx
80107dba:	5e                   	pop    %esi
80107dbb:	5f                   	pop    %edi
80107dbc:	5d                   	pop    %ebp
80107dbd:	c3                   	ret    
80107dbe:	66 90                	xchg   %ax,%ax
80107dc0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107dc3:	31 c0                	xor    %eax,%eax
}
80107dc5:	5b                   	pop    %ebx
80107dc6:	5e                   	pop    %esi
80107dc7:	5f                   	pop    %edi
80107dc8:	5d                   	pop    %ebp
80107dc9:	c3                   	ret    
