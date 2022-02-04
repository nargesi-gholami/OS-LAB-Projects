
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
8010002d:	b8 40 34 10 80       	mov    $0x80103440,%eax
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
80100050:	68 40 7f 10 80       	push   $0x80107f40
80100055:	68 00 c6 10 80       	push   $0x8010c600
8010005a:	e8 a1 4e 00 00       	call   80104f00 <initlock>
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
80100092:	68 47 7f 10 80       	push   $0x80107f47
80100097:	50                   	push   %eax
80100098:	e8 23 4d 00 00       	call   80104dc0 <initsleeplock>
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
801000e8:	e8 93 4f 00 00       	call   80105080 <acquire>
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
80100162:	e8 d9 4f 00 00       	call   80105140 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 8e 4c 00 00       	call   80104e00 <acquiresleep>
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
801001a3:	68 4e 7f 10 80       	push   $0x80107f4e
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
801001c2:	e8 d9 4c 00 00       	call   80104ea0 <holdingsleep>
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
801001e0:	68 5f 7f 10 80       	push   $0x80107f5f
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
80100203:	e8 98 4c 00 00       	call   80104ea0 <holdingsleep>
80100208:	83 c4 10             	add    $0x10,%esp
8010020b:	85 c0                	test   %eax,%eax
8010020d:	74 66                	je     80100275 <brelse+0x85>
    panic("brelse");

  releasesleep(&b->lock);
8010020f:	83 ec 0c             	sub    $0xc,%esp
80100212:	56                   	push   %esi
80100213:	e8 48 4c 00 00       	call   80104e60 <releasesleep>

  acquire(&bcache.lock);
80100218:	c7 04 24 00 c6 10 80 	movl   $0x8010c600,(%esp)
8010021f:	e8 5c 4e 00 00       	call   80105080 <acquire>
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
80100270:	e9 cb 4e 00 00       	jmp    80105140 <release>
    panic("brelse");
80100275:	83 ec 0c             	sub    $0xc,%esp
80100278:	68 66 7f 10 80       	push   $0x80107f66
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
801002b1:	e8 ca 4d 00 00       	call   80105080 <acquire>
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
801002e5:	e8 a6 46 00 00       	call   80104990 <sleep>
    while(input.r == input.w){
801002ea:	a1 e0 0f 11 80       	mov    0x80110fe0,%eax
801002ef:	83 c4 10             	add    $0x10,%esp
801002f2:	3b 05 e4 0f 11 80    	cmp    0x80110fe4,%eax
801002f8:	75 36                	jne    80100330 <consoleread+0xa0>
      if(myproc()->killed){
801002fa:	e8 c1 3a 00 00       	call   80103dc0 <myproc>
801002ff:	8b 48 24             	mov    0x24(%eax),%ecx
80100302:	85 c9                	test   %ecx,%ecx
80100304:	74 d2                	je     801002d8 <consoleread+0x48>
        release(&cons.lock);
80100306:	83 ec 0c             	sub    $0xc,%esp
80100309:	68 40 b5 10 80       	push   $0x8010b540
8010030e:	e8 2d 4e 00 00       	call   80105140 <release>
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
80100365:	e8 d6 4d 00 00       	call   80105140 <release>
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
801003ad:	e8 ee 28 00 00       	call   80102ca0 <lapicid>
801003b2:	83 ec 08             	sub    $0x8,%esp
801003b5:	50                   	push   %eax
801003b6:	68 6d 7f 10 80       	push   $0x80107f6d
801003bb:	e8 f0 02 00 00       	call   801006b0 <cprintf>
  cprintf(s);
801003c0:	58                   	pop    %eax
801003c1:	ff 75 08             	pushl  0x8(%ebp)
801003c4:	e8 e7 02 00 00       	call   801006b0 <cprintf>
  cprintf("\n");
801003c9:	c7 04 24 2f 8a 10 80 	movl   $0x80108a2f,(%esp)
801003d0:	e8 db 02 00 00       	call   801006b0 <cprintf>
  getcallerpcs(&s, pcs);
801003d5:	8d 45 08             	lea    0x8(%ebp),%eax
801003d8:	5a                   	pop    %edx
801003d9:	59                   	pop    %ecx
801003da:	53                   	push   %ebx
801003db:	50                   	push   %eax
801003dc:	e8 3f 4b 00 00       	call   80104f20 <getcallerpcs>
  for(i=0; i<10; i++)
801003e1:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003e4:	83 ec 08             	sub    $0x8,%esp
801003e7:	ff 33                	pushl  (%ebx)
801003e9:	83 c3 04             	add    $0x4,%ebx
801003ec:	68 81 7f 10 80       	push   $0x80107f81
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
8010042a:	e8 e1 66 00 00       	call   80106b10 <uartputc>
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
80100515:	e8 f6 65 00 00       	call   80106b10 <uartputc>
8010051a:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100521:	e8 ea 65 00 00       	call   80106b10 <uartputc>
80100526:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010052d:	e8 de 65 00 00       	call   80106b10 <uartputc>
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
80100561:	e8 ca 4c 00 00       	call   80105230 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100566:	b8 80 07 00 00       	mov    $0x780,%eax
8010056b:	83 c4 0c             	add    $0xc,%esp
8010056e:	29 d8                	sub    %ebx,%eax
80100570:	01 c0                	add    %eax,%eax
80100572:	50                   	push   %eax
80100573:	6a 00                	push   $0x0
80100575:	56                   	push   %esi
80100576:	e8 15 4c 00 00       	call   80105190 <memset>
8010057b:	88 5d e7             	mov    %bl,-0x19(%ebp)
8010057e:	83 c4 10             	add    $0x10,%esp
80100581:	e9 22 ff ff ff       	jmp    801004a8 <consputc.part.0+0x98>
    panic("pos under/overflow");
80100586:	83 ec 0c             	sub    $0xc,%esp
80100589:	68 85 7f 10 80       	push   $0x80107f85
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
801005c9:	0f b6 92 08 80 10 80 	movzbl -0x7fef7ff8(%edx),%edx
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
8010065f:	e8 1c 4a 00 00       	call   80105080 <acquire>
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
80100697:	e8 a4 4a 00 00       	call   80105140 <release>
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
8010077d:	bb 98 7f 10 80       	mov    $0x80107f98,%ebx
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
801007bd:	e8 be 48 00 00       	call   80105080 <acquire>
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
80100828:	e8 13 49 00 00       	call   80105140 <release>
8010082d:	83 c4 10             	add    $0x10,%esp
}
80100830:	e9 ee fe ff ff       	jmp    80100723 <cprintf+0x73>
    panic("null fmt");
80100835:	83 ec 0c             	sub    $0xc,%esp
80100838:	68 9f 7f 10 80       	push   $0x80107f9f
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
801008da:	e8 a1 47 00 00       	call   80105080 <acquire>
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
80100903:	3e ff 24 b5 b0 7f 10 	notrack jmp *-0x7fef8050(,%esi,4)
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
80100c68:	e8 d3 44 00 00       	call   80105140 <release>
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
80100dc1:	e8 8a 3d 00 00       	call   80104b50 <wakeup>
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
80100ddf:	e9 6c 3e 00 00       	jmp    80104c50 <procdump>
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
80100e0a:	68 a8 7f 10 80       	push   $0x80107fa8
80100e0f:	68 40 b5 10 80       	push   $0x8010b540
80100e14:	e8 e7 40 00 00       	call   80104f00 <initlock>

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
80100e60:	e8 5b 2f 00 00       	call   80103dc0 <myproc>
80100e65:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
80100e6b:	e8 c0 22 00 00       	call   80103130 <begin_op>

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
80100eb3:	e8 e8 22 00 00       	call   801031a0 <end_op>
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
80100edc:	e8 af 6d 00 00       	call   80107c90 <setupkvm>
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
80100f43:	e8 58 6b 00 00       	call   80107aa0 <allocuvm>
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
80100f79:	e8 52 6a 00 00       	call   801079d0 <loaduvm>
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
80100fbb:	e8 50 6c 00 00       	call   80107c10 <freevm>
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
80100ff1:	e8 aa 21 00 00       	call   801031a0 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100ff6:	83 c4 0c             	add    $0xc,%esp
80100ff9:	56                   	push   %esi
80100ffa:	57                   	push   %edi
80100ffb:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80101001:	57                   	push   %edi
80101002:	e8 99 6a 00 00       	call   80107aa0 <allocuvm>
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
80101023:	e8 08 6d 00 00       	call   80107d30 <clearpteu>
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
80101073:	e8 18 43 00 00       	call   80105390 <strlen>
80101078:	f7 d0                	not    %eax
8010107a:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
8010107c:	58                   	pop    %eax
8010107d:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80101080:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80101083:	ff 34 b8             	pushl  (%eax,%edi,4)
80101086:	e8 05 43 00 00       	call   80105390 <strlen>
8010108b:	83 c0 01             	add    $0x1,%eax
8010108e:	50                   	push   %eax
8010108f:	8b 45 0c             	mov    0xc(%ebp),%eax
80101092:	ff 34 b8             	pushl  (%eax,%edi,4)
80101095:	53                   	push   %ebx
80101096:	56                   	push   %esi
80101097:	e8 04 6e 00 00       	call   80107ea0 <copyout>
8010109c:	83 c4 20             	add    $0x20,%esp
8010109f:	85 c0                	test   %eax,%eax
801010a1:	79 ad                	jns    80101050 <exec+0x200>
801010a3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801010a7:	90                   	nop
    freevm(pgdir);
801010a8:	83 ec 0c             	sub    $0xc,%esp
801010ab:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
801010b1:	e8 5a 6b 00 00       	call   80107c10 <freevm>
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
80101103:	e8 98 6d 00 00       	call   80107ea0 <copyout>
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
80101141:	e8 0a 42 00 00       	call   80105350 <safestrcpy>
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
80101174:	e8 c7 66 00 00       	call   80107840 <switchuvm>
  freevm(oldpgdir);
80101179:	89 3c 24             	mov    %edi,(%esp)
8010117c:	e8 8f 6a 00 00       	call   80107c10 <freevm>
  return 0;
80101181:	83 c4 10             	add    $0x10,%esp
80101184:	31 c0                	xor    %eax,%eax
80101186:	e9 35 fd ff ff       	jmp    80100ec0 <exec+0x70>
    end_op();
8010118b:	e8 10 20 00 00       	call   801031a0 <end_op>
    cprintf("exec: fail\n");
80101190:	83 ec 0c             	sub    $0xc,%esp
80101193:	68 19 80 10 80       	push   $0x80108019
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
801011ca:	68 25 80 10 80       	push   $0x80108025
801011cf:	68 00 10 11 80       	push   $0x80111000
801011d4:	e8 27 3d 00 00       	call   80104f00 <initlock>
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
801011f5:	e8 86 3e 00 00       	call   80105080 <acquire>
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
80101221:	e8 1a 3f 00 00       	call   80105140 <release>
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
8010123a:	e8 01 3f 00 00       	call   80105140 <release>
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
80101263:	e8 18 3e 00 00       	call   80105080 <acquire>
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
80101280:	e8 bb 3e 00 00       	call   80105140 <release>
  return f;
}
80101285:	89 d8                	mov    %ebx,%eax
80101287:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010128a:	c9                   	leave  
8010128b:	c3                   	ret    
    panic("filedup");
8010128c:	83 ec 0c             	sub    $0xc,%esp
8010128f:	68 2c 80 10 80       	push   $0x8010802c
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
801012b5:	e8 c6 3d 00 00       	call   80105080 <acquire>
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
801012f0:	e8 4b 3e 00 00       	call   80105140 <release>

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
8010131e:	e9 1d 3e 00 00       	jmp    80105140 <release>
80101323:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101327:	90                   	nop
    begin_op();
80101328:	e8 03 1e 00 00       	call   80103130 <begin_op>
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
80101342:	e9 59 1e 00 00       	jmp    801031a0 <end_op>
80101347:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010134e:	66 90                	xchg   %ax,%ax
    pipeclose(ff.pipe, ff.writable);
80101350:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80101354:	83 ec 08             	sub    $0x8,%esp
80101357:	53                   	push   %ebx
80101358:	56                   	push   %esi
80101359:	e8 a2 25 00 00       	call   80103900 <pipeclose>
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
8010136c:	68 34 80 10 80       	push   $0x80108034
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
80101445:	e9 56 26 00 00       	jmp    80103aa0 <piperead>
8010144a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101450:	be ff ff ff ff       	mov    $0xffffffff,%esi
80101455:	eb d3                	jmp    8010142a <fileread+0x5a>
  panic("fileread");
80101457:	83 ec 0c             	sub    $0xc,%esp
8010145a:	68 3e 80 10 80       	push   $0x8010803e
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
801014d1:	e8 ca 1c 00 00       	call   801031a0 <end_op>

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
801014fa:	e8 31 1c 00 00       	call   80103130 <begin_op>
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
80101531:	e8 6a 1c 00 00       	call   801031a0 <end_op>
      if(r < 0)
80101536:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101539:	83 c4 10             	add    $0x10,%esp
8010153c:	85 c0                	test   %eax,%eax
8010153e:	75 17                	jne    80101557 <filewrite+0xe7>
        panic("short filewrite");
80101540:	83 ec 0c             	sub    $0xc,%esp
80101543:	68 47 80 10 80       	push   $0x80108047
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
80101571:	e9 2a 24 00 00       	jmp    801039a0 <pipewrite>
  panic("filewrite");
80101576:	83 ec 0c             	sub    $0xc,%esp
80101579:	68 4d 80 10 80       	push   $0x8010804d
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
801015dd:	e8 2e 1d 00 00       	call   80103310 <log_write>
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
801015f7:	68 57 80 10 80       	push   $0x80108057
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
801016b4:	68 6a 80 10 80       	push   $0x8010806a
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
801016cd:	e8 3e 1c 00 00       	call   80103310 <log_write>
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
801016f5:	e8 96 3a 00 00       	call   80105190 <memset>
  log_write(bp);
801016fa:	89 1c 24             	mov    %ebx,(%esp)
801016fd:	e8 0e 1c 00 00       	call   80103310 <log_write>
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
8010173a:	e8 41 39 00 00       	call   80105080 <acquire>
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
801017a7:	e8 94 39 00 00       	call   80105140 <release>

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
801017d5:	e8 66 39 00 00       	call   80105140 <release>
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
80101802:	68 80 80 10 80       	push   $0x80108080
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
80101885:	e8 86 1a 00 00       	call   80103310 <log_write>
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
801018cb:	68 90 80 10 80       	push   $0x80108090
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
80101905:	e8 26 39 00 00       	call   80105230 <memmove>
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
80101930:	68 a3 80 10 80       	push   $0x801080a3
80101935:	68 20 1a 11 80       	push   $0x80111a20
8010193a:	e8 c1 35 00 00       	call   80104f00 <initlock>
  for(i = 0; i < NINODE; i++) {
8010193f:	83 c4 10             	add    $0x10,%esp
80101942:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    initsleeplock(&icache.inode[i].lock, "inode");
80101948:	83 ec 08             	sub    $0x8,%esp
8010194b:	68 aa 80 10 80       	push   $0x801080aa
80101950:	53                   	push   %ebx
80101951:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101957:	e8 64 34 00 00       	call   80104dc0 <initsleeplock>
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
801019a1:	68 10 81 10 80       	push   $0x80108110
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
80101a3e:	e8 4d 37 00 00       	call   80105190 <memset>
      dip->type = type;
80101a43:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101a47:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101a4a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
80101a4d:	89 1c 24             	mov    %ebx,(%esp)
80101a50:	e8 bb 18 00 00       	call   80103310 <log_write>
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
80101a73:	68 b0 80 10 80       	push   $0x801080b0
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
80101ae5:	e8 46 37 00 00       	call   80105230 <memmove>
  log_write(bp);
80101aea:	89 34 24             	mov    %esi,(%esp)
80101aed:	e8 1e 18 00 00       	call   80103310 <log_write>
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
80101b23:	e8 58 35 00 00       	call   80105080 <acquire>
  ip->ref++;
80101b28:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101b2c:	c7 04 24 20 1a 11 80 	movl   $0x80111a20,(%esp)
80101b33:	e8 08 36 00 00       	call   80105140 <release>
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
80101b66:	e8 95 32 00 00       	call   80104e00 <acquiresleep>
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
80101bd8:	e8 53 36 00 00       	call   80105230 <memmove>
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
80101bfd:	68 c8 80 10 80       	push   $0x801080c8
80101c02:	e8 89 e7 ff ff       	call   80100390 <panic>
    panic("ilock");
80101c07:	83 ec 0c             	sub    $0xc,%esp
80101c0a:	68 c2 80 10 80       	push   $0x801080c2
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
80101c37:	e8 64 32 00 00       	call   80104ea0 <holdingsleep>
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
80101c53:	e9 08 32 00 00       	jmp    80104e60 <releasesleep>
    panic("iunlock");
80101c58:	83 ec 0c             	sub    $0xc,%esp
80101c5b:	68 d7 80 10 80       	push   $0x801080d7
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
80101c84:	e8 77 31 00 00       	call   80104e00 <acquiresleep>
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
80101c9e:	e8 bd 31 00 00       	call   80104e60 <releasesleep>
  acquire(&icache.lock);
80101ca3:	c7 04 24 20 1a 11 80 	movl   $0x80111a20,(%esp)
80101caa:	e8 d1 33 00 00       	call   80105080 <acquire>
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
80101cc4:	e9 77 34 00 00       	jmp    80105140 <release>
80101cc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&icache.lock);
80101cd0:	83 ec 0c             	sub    $0xc,%esp
80101cd3:	68 20 1a 11 80       	push   $0x80111a20
80101cd8:	e8 a3 33 00 00       	call   80105080 <acquire>
    int r = ip->ref;
80101cdd:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101ce0:	c7 04 24 20 1a 11 80 	movl   $0x80111a20,(%esp)
80101ce7:	e8 54 34 00 00       	call   80105140 <release>
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
80101ee7:	e8 44 33 00 00       	call   80105230 <memmove>
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
80101fe3:	e8 48 32 00 00       	call   80105230 <memmove>
    log_write(bp);
80101fe8:	89 3c 24             	mov    %edi,(%esp)
80101feb:	e8 20 13 00 00       	call   80103310 <log_write>
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
80102082:	e8 19 32 00 00       	call   801052a0 <strncmp>
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
801020e5:	e8 b6 31 00 00       	call   801052a0 <strncmp>
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
8010212a:	68 f1 80 10 80       	push   $0x801080f1
8010212f:	e8 5c e2 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
80102134:	83 ec 0c             	sub    $0xc,%esp
80102137:	68 df 80 10 80       	push   $0x801080df
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
8010216a:	e8 51 1c 00 00       	call   80103dc0 <myproc>
  acquire(&icache.lock);
8010216f:	83 ec 0c             	sub    $0xc,%esp
80102172:	89 df                	mov    %ebx,%edi
    ip = idup(myproc()->cwd);
80102174:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80102177:	68 20 1a 11 80       	push   $0x80111a20
8010217c:	e8 ff 2e 00 00       	call   80105080 <acquire>
  ip->ref++;
80102181:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80102185:	c7 04 24 20 1a 11 80 	movl   $0x80111a20,(%esp)
8010218c:	e8 af 2f 00 00       	call   80105140 <release>
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
801021f7:	e8 34 30 00 00       	call   80105230 <memmove>
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
80102283:	e8 a8 2f 00 00       	call   80105230 <memmove>
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
801023b5:	e8 36 2f 00 00       	call   801052f0 <strncpy>
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
801023f3:	68 00 81 10 80       	push   $0x80108100
801023f8:	e8 93 df ff ff       	call   80100390 <panic>
    panic("dirlink");
801023fd:	83 ec 0c             	sub    $0xc,%esp
80102400:	68 9e 87 10 80       	push   $0x8010879e
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
8010250b:	68 6c 81 10 80       	push   $0x8010816c
80102510:	e8 7b de ff ff       	call   80100390 <panic>
    panic("idestart");
80102515:	83 ec 0c             	sub    $0xc,%esp
80102518:	68 63 81 10 80       	push   $0x80108163
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
8010253a:	68 7e 81 10 80       	push   $0x8010817e
8010253f:	68 a0 b5 10 80       	push   $0x8010b5a0
80102544:	e8 b7 29 00 00       	call   80104f00 <initlock>
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
801025d2:	e8 a9 2a 00 00       	call   80105080 <acquire>

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
8010262d:	e8 1e 25 00 00       	call   80104b50 <wakeup>

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
8010264b:	e8 f0 2a 00 00       	call   80105140 <release>

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
80102672:	e8 29 28 00 00       	call   80104ea0 <holdingsleep>
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
801026ac:	e8 cf 29 00 00       	call   80105080 <acquire>

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
801026f9:	e8 92 22 00 00       	call   80104990 <sleep>
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
80102716:	e9 25 2a 00 00       	jmp    80105140 <release>
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
8010273a:	68 ad 81 10 80       	push   $0x801081ad
8010273f:	e8 4c dc ff ff       	call   80100390 <panic>
    panic("iderw: nothing to do");
80102744:	83 ec 0c             	sub    $0xc,%esp
80102747:	68 98 81 10 80       	push   $0x80108198
8010274c:	e8 3f dc ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
80102751:	83 ec 0c             	sub    $0xc,%esp
80102754:	68 82 81 10 80       	push   $0x80108182
80102759:	e8 32 dc ff ff       	call   80100390 <panic>
8010275e:	66 90                	xchg   %ax,%ax

80102760 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102760:	f3 0f 1e fb          	endbr32 
80102764:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102765:	c7 05 74 36 11 80 00 	movl   $0xfec00000,0x80113674
8010276c:	00 c0 fe 
{
8010276f:	89 e5                	mov    %esp,%ebp
80102771:	56                   	push   %esi
80102772:	53                   	push   %ebx
  ioapic->reg = reg;
80102773:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
8010277a:	00 00 00 
  return ioapic->data;
8010277d:	8b 15 74 36 11 80    	mov    0x80113674,%edx
80102783:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
80102786:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
8010278c:	8b 0d 74 36 11 80    	mov    0x80113674,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
80102792:	0f b6 15 a0 37 11 80 	movzbl 0x801137a0,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102799:	c1 ee 10             	shr    $0x10,%esi
8010279c:	89 f0                	mov    %esi,%eax
8010279e:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
801027a1:	8b 41 10             	mov    0x10(%ecx),%eax
  id = ioapicread(REG_ID) >> 24;
801027a4:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
801027a7:	39 c2                	cmp    %eax,%edx
801027a9:	74 16                	je     801027c1 <ioapicinit+0x61>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
801027ab:	83 ec 0c             	sub    $0xc,%esp
801027ae:	68 cc 81 10 80       	push   $0x801081cc
801027b3:	e8 f8 de ff ff       	call   801006b0 <cprintf>
801027b8:	8b 0d 74 36 11 80    	mov    0x80113674,%ecx
801027be:	83 c4 10             	add    $0x10,%esp
801027c1:	83 c6 21             	add    $0x21,%esi
{
801027c4:	ba 10 00 00 00       	mov    $0x10,%edx
801027c9:	b8 20 00 00 00       	mov    $0x20,%eax
801027ce:	66 90                	xchg   %ax,%ax
  ioapic->reg = reg;
801027d0:	89 11                	mov    %edx,(%ecx)

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
801027d2:	89 c3                	mov    %eax,%ebx
  ioapic->data = data;
801027d4:	8b 0d 74 36 11 80    	mov    0x80113674,%ecx
801027da:	83 c0 01             	add    $0x1,%eax
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
801027dd:	81 cb 00 00 01 00    	or     $0x10000,%ebx
  ioapic->data = data;
801027e3:	89 59 10             	mov    %ebx,0x10(%ecx)
  ioapic->reg = reg;
801027e6:	8d 5a 01             	lea    0x1(%edx),%ebx
801027e9:	83 c2 02             	add    $0x2,%edx
801027ec:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
801027ee:	8b 0d 74 36 11 80    	mov    0x80113674,%ecx
801027f4:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
801027fb:	39 f0                	cmp    %esi,%eax
801027fd:	75 d1                	jne    801027d0 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
801027ff:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102802:	5b                   	pop    %ebx
80102803:	5e                   	pop    %esi
80102804:	5d                   	pop    %ebp
80102805:	c3                   	ret    
80102806:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010280d:	8d 76 00             	lea    0x0(%esi),%esi

80102810 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102810:	f3 0f 1e fb          	endbr32 
80102814:	55                   	push   %ebp
  ioapic->reg = reg;
80102815:	8b 0d 74 36 11 80    	mov    0x80113674,%ecx
{
8010281b:	89 e5                	mov    %esp,%ebp
8010281d:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
80102820:	8d 50 20             	lea    0x20(%eax),%edx
80102823:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
80102827:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102829:	8b 0d 74 36 11 80    	mov    0x80113674,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010282f:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
80102832:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102835:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80102838:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
8010283a:	a1 74 36 11 80       	mov    0x80113674,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010283f:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
80102842:	89 50 10             	mov    %edx,0x10(%eax)
}
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
80102866:	81 fb 08 9b 11 80    	cmp    $0x80119b08,%ebx
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
80102886:	e8 05 29 00 00       	call   80105190 <memset>

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
801028c0:	e8 bb 27 00 00       	call   80105080 <acquire>
801028c5:	83 c4 10             	add    $0x10,%esp
801028c8:	eb ce                	jmp    80102898 <kfree+0x48>
801028ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
801028d0:	c7 45 08 80 36 11 80 	movl   $0x80113680,0x8(%ebp)
}
801028d7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801028da:	c9                   	leave  
    release(&kmem.lock);
801028db:	e9 60 28 00 00       	jmp    80105140 <release>
    panic("kfree");
801028e0:	83 ec 0c             	sub    $0xc,%esp
801028e3:	68 fe 81 10 80       	push   $0x801081fe
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
8010294f:	68 04 82 10 80       	push   $0x80108204
80102954:	68 80 36 11 80       	push   $0x80113680
80102959:	e8 a2 25 00 00       	call   80104f00 <initlock>
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
80102a43:	e8 38 26 00 00       	call   80105080 <acquire>
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
80102a71:	e8 ca 26 00 00       	call   80105140 <release>
  return (char*)r;
80102a76:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
80102a79:	83 c4 10             	add    $0x10,%esp
}
80102a7c:	c9                   	leave  
80102a7d:	c3                   	ret    
80102a7e:	66 90                	xchg   %ax,%ax

80102a80 <get_free_pages_count2>:

int get_free_pages_count2() {
80102a80:	f3 0f 1e fb          	endbr32 
  struct run *r;
  int num_of_free = 0;
  r = kmem.freelist;
80102a84:	a1 b8 36 11 80       	mov    0x801136b8,%eax
  int num_of_free = 0;
80102a89:	31 d2                	xor    %edx,%edx
  while(r) {
80102a8b:	85 c0                	test   %eax,%eax
80102a8d:	74 0a                	je     80102a99 <get_free_pages_count2+0x19>
80102a8f:	90                   	nop
    r = r->next;
80102a90:	8b 00                	mov    (%eax),%eax
    num_of_free++;
80102a92:	83 c2 01             	add    $0x1,%edx
  while(r) {
80102a95:	85 c0                	test   %eax,%eax
80102a97:	75 f7                	jne    80102a90 <get_free_pages_count2+0x10>
  }
  return num_of_free;
}
80102a99:	89 d0                	mov    %edx,%eax
80102a9b:	c3                   	ret    
80102a9c:	66 90                	xchg   %ax,%ax
80102a9e:	66 90                	xchg   %ax,%ax

80102aa0 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
80102aa0:	f3 0f 1e fb          	endbr32 
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102aa4:	ba 64 00 00 00       	mov    $0x64,%edx
80102aa9:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102aaa:	a8 01                	test   $0x1,%al
80102aac:	0f 84 be 00 00 00    	je     80102b70 <kbdgetc+0xd0>
{
80102ab2:	55                   	push   %ebp
80102ab3:	ba 60 00 00 00       	mov    $0x60,%edx
80102ab8:	89 e5                	mov    %esp,%ebp
80102aba:	53                   	push   %ebx
80102abb:	ec                   	in     (%dx),%al
  return data;
80102abc:	8b 1d d4 b5 10 80    	mov    0x8010b5d4,%ebx
    return -1;
  data = inb(KBDATAP);
80102ac2:	0f b6 d0             	movzbl %al,%edx

  if(data == 0xE0){
80102ac5:	3c e0                	cmp    $0xe0,%al
80102ac7:	74 57                	je     80102b20 <kbdgetc+0x80>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102ac9:	89 d9                	mov    %ebx,%ecx
80102acb:	83 e1 40             	and    $0x40,%ecx
80102ace:	84 c0                	test   %al,%al
80102ad0:	78 5e                	js     80102b30 <kbdgetc+0x90>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102ad2:	85 c9                	test   %ecx,%ecx
80102ad4:	74 09                	je     80102adf <kbdgetc+0x3f>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102ad6:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102ad9:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
80102adc:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
80102adf:	0f b6 8a 40 83 10 80 	movzbl -0x7fef7cc0(%edx),%ecx
  shift ^= togglecode[data];
80102ae6:	0f b6 82 40 82 10 80 	movzbl -0x7fef7dc0(%edx),%eax
  shift |= shiftcode[data];
80102aed:	09 d9                	or     %ebx,%ecx
  shift ^= togglecode[data];
80102aef:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102af1:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
80102af3:	89 0d d4 b5 10 80    	mov    %ecx,0x8010b5d4
  c = charcode[shift & (CTL | SHIFT)][data];
80102af9:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102afc:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102aff:	8b 04 85 20 82 10 80 	mov    -0x7fef7de0(,%eax,4),%eax
80102b06:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
80102b0a:	74 0b                	je     80102b17 <kbdgetc+0x77>
    if('a' <= c && c <= 'z')
80102b0c:	8d 50 9f             	lea    -0x61(%eax),%edx
80102b0f:	83 fa 19             	cmp    $0x19,%edx
80102b12:	77 44                	ja     80102b58 <kbdgetc+0xb8>
      c += 'A' - 'a';
80102b14:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102b17:	5b                   	pop    %ebx
80102b18:	5d                   	pop    %ebp
80102b19:	c3                   	ret    
80102b1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    shift |= E0ESC;
80102b20:	83 cb 40             	or     $0x40,%ebx
    return 0;
80102b23:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
80102b25:	89 1d d4 b5 10 80    	mov    %ebx,0x8010b5d4
}
80102b2b:	5b                   	pop    %ebx
80102b2c:	5d                   	pop    %ebp
80102b2d:	c3                   	ret    
80102b2e:	66 90                	xchg   %ax,%ax
    data = (shift & E0ESC ? data : data & 0x7F);
80102b30:	83 e0 7f             	and    $0x7f,%eax
80102b33:	85 c9                	test   %ecx,%ecx
80102b35:	0f 44 d0             	cmove  %eax,%edx
    return 0;
80102b38:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
80102b3a:	0f b6 8a 40 83 10 80 	movzbl -0x7fef7cc0(%edx),%ecx
80102b41:	83 c9 40             	or     $0x40,%ecx
80102b44:	0f b6 c9             	movzbl %cl,%ecx
80102b47:	f7 d1                	not    %ecx
80102b49:	21 d9                	and    %ebx,%ecx
}
80102b4b:	5b                   	pop    %ebx
80102b4c:	5d                   	pop    %ebp
    shift &= ~(shiftcode[data] | E0ESC);
80102b4d:	89 0d d4 b5 10 80    	mov    %ecx,0x8010b5d4
}
80102b53:	c3                   	ret    
80102b54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
80102b58:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
80102b5b:	8d 50 20             	lea    0x20(%eax),%edx
}
80102b5e:	5b                   	pop    %ebx
80102b5f:	5d                   	pop    %ebp
      c += 'a' - 'A';
80102b60:	83 f9 1a             	cmp    $0x1a,%ecx
80102b63:	0f 42 c2             	cmovb  %edx,%eax
}
80102b66:	c3                   	ret    
80102b67:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102b6e:	66 90                	xchg   %ax,%ax
    return -1;
80102b70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102b75:	c3                   	ret    
80102b76:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102b7d:	8d 76 00             	lea    0x0(%esi),%esi

80102b80 <kbdintr>:

void
kbdintr(void)
{
80102b80:	f3 0f 1e fb          	endbr32 
80102b84:	55                   	push   %ebp
80102b85:	89 e5                	mov    %esp,%ebp
80102b87:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102b8a:	68 a0 2a 10 80       	push   $0x80102aa0
80102b8f:	e8 2c dd ff ff       	call   801008c0 <consoleintr>
}
80102b94:	83 c4 10             	add    $0x10,%esp
80102b97:	c9                   	leave  
80102b98:	c3                   	ret    
80102b99:	66 90                	xchg   %ax,%ax
80102b9b:	66 90                	xchg   %ax,%ax
80102b9d:	66 90                	xchg   %ax,%ax
80102b9f:	90                   	nop

80102ba0 <lapicinit>:
  lapic[ID];  // wait for write to finish, by reading
}

void
lapicinit(void)
{
80102ba0:	f3 0f 1e fb          	endbr32 
  if(!lapic)
80102ba4:	a1 bc 36 11 80       	mov    0x801136bc,%eax
80102ba9:	85 c0                	test   %eax,%eax
80102bab:	0f 84 c7 00 00 00    	je     80102c78 <lapicinit+0xd8>
  lapic[index] = value;
80102bb1:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102bb8:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102bbb:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102bbe:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102bc5:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102bc8:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102bcb:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102bd2:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102bd5:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102bd8:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
80102bdf:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102be2:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102be5:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80102bec:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102bef:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102bf2:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102bf9:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102bfc:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102bff:	8b 50 30             	mov    0x30(%eax),%edx
80102c02:	c1 ea 10             	shr    $0x10,%edx
80102c05:	81 e2 fc 00 00 00    	and    $0xfc,%edx
80102c0b:	75 73                	jne    80102c80 <lapicinit+0xe0>
  lapic[index] = value;
80102c0d:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102c14:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102c17:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102c1a:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102c21:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102c24:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102c27:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102c2e:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102c31:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102c34:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102c3b:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102c3e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102c41:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102c48:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102c4b:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102c4e:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102c55:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102c58:	8b 50 20             	mov    0x20(%eax),%edx
80102c5b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102c5f:	90                   	nop
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102c60:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102c66:	80 e6 10             	and    $0x10,%dh
80102c69:	75 f5                	jne    80102c60 <lapicinit+0xc0>
  lapic[index] = value;
80102c6b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102c72:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102c75:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102c78:	c3                   	ret    
80102c79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
80102c80:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102c87:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102c8a:	8b 50 20             	mov    0x20(%eax),%edx
}
80102c8d:	e9 7b ff ff ff       	jmp    80102c0d <lapicinit+0x6d>
80102c92:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102c99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102ca0 <lapicid>:

int
lapicid(void)
{
80102ca0:	f3 0f 1e fb          	endbr32 
  if (!lapic)
80102ca4:	a1 bc 36 11 80       	mov    0x801136bc,%eax
80102ca9:	85 c0                	test   %eax,%eax
80102cab:	74 0b                	je     80102cb8 <lapicid+0x18>
    return 0;
  return lapic[ID] >> 24;
80102cad:	8b 40 20             	mov    0x20(%eax),%eax
80102cb0:	c1 e8 18             	shr    $0x18,%eax
80102cb3:	c3                   	ret    
80102cb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 0;
80102cb8:	31 c0                	xor    %eax,%eax
}
80102cba:	c3                   	ret    
80102cbb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102cbf:	90                   	nop

80102cc0 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
80102cc0:	f3 0f 1e fb          	endbr32 
  if(lapic)
80102cc4:	a1 bc 36 11 80       	mov    0x801136bc,%eax
80102cc9:	85 c0                	test   %eax,%eax
80102ccb:	74 0d                	je     80102cda <lapiceoi+0x1a>
  lapic[index] = value;
80102ccd:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102cd4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102cd7:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102cda:	c3                   	ret    
80102cdb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102cdf:	90                   	nop

80102ce0 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102ce0:	f3 0f 1e fb          	endbr32 
}
80102ce4:	c3                   	ret    
80102ce5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102cec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102cf0 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102cf0:	f3 0f 1e fb          	endbr32 
80102cf4:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102cf5:	b8 0f 00 00 00       	mov    $0xf,%eax
80102cfa:	ba 70 00 00 00       	mov    $0x70,%edx
80102cff:	89 e5                	mov    %esp,%ebp
80102d01:	53                   	push   %ebx
80102d02:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102d05:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102d08:	ee                   	out    %al,(%dx)
80102d09:	b8 0a 00 00 00       	mov    $0xa,%eax
80102d0e:	ba 71 00 00 00       	mov    $0x71,%edx
80102d13:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102d14:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102d16:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102d19:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
80102d1f:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102d21:	c1 e9 0c             	shr    $0xc,%ecx
  lapicw(ICRHI, apicid<<24);
80102d24:	89 da                	mov    %ebx,%edx
  wrv[1] = addr >> 4;
80102d26:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
80102d29:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102d2c:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
80102d32:	a1 bc 36 11 80       	mov    0x801136bc,%eax
80102d37:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102d3d:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102d40:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102d47:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102d4a:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102d4d:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102d54:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102d57:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102d5a:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102d60:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102d63:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102d69:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102d6c:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102d72:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d75:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
    microdelay(200);
  }
}
80102d7b:	5b                   	pop    %ebx
  lapic[ID];  // wait for write to finish, by reading
80102d7c:	8b 40 20             	mov    0x20(%eax),%eax
}
80102d7f:	5d                   	pop    %ebp
80102d80:	c3                   	ret    
80102d81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102d88:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102d8f:	90                   	nop

80102d90 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102d90:	f3 0f 1e fb          	endbr32 
80102d94:	55                   	push   %ebp
80102d95:	b8 0b 00 00 00       	mov    $0xb,%eax
80102d9a:	ba 70 00 00 00       	mov    $0x70,%edx
80102d9f:	89 e5                	mov    %esp,%ebp
80102da1:	57                   	push   %edi
80102da2:	56                   	push   %esi
80102da3:	53                   	push   %ebx
80102da4:	83 ec 4c             	sub    $0x4c,%esp
80102da7:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102da8:	ba 71 00 00 00       	mov    $0x71,%edx
80102dad:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
80102dae:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102db1:	bb 70 00 00 00       	mov    $0x70,%ebx
80102db6:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102db9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102dc0:	31 c0                	xor    %eax,%eax
80102dc2:	89 da                	mov    %ebx,%edx
80102dc4:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102dc5:	b9 71 00 00 00       	mov    $0x71,%ecx
80102dca:	89 ca                	mov    %ecx,%edx
80102dcc:	ec                   	in     (%dx),%al
80102dcd:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102dd0:	89 da                	mov    %ebx,%edx
80102dd2:	b8 02 00 00 00       	mov    $0x2,%eax
80102dd7:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102dd8:	89 ca                	mov    %ecx,%edx
80102dda:	ec                   	in     (%dx),%al
80102ddb:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102dde:	89 da                	mov    %ebx,%edx
80102de0:	b8 04 00 00 00       	mov    $0x4,%eax
80102de5:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102de6:	89 ca                	mov    %ecx,%edx
80102de8:	ec                   	in     (%dx),%al
80102de9:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102dec:	89 da                	mov    %ebx,%edx
80102dee:	b8 07 00 00 00       	mov    $0x7,%eax
80102df3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102df4:	89 ca                	mov    %ecx,%edx
80102df6:	ec                   	in     (%dx),%al
80102df7:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102dfa:	89 da                	mov    %ebx,%edx
80102dfc:	b8 08 00 00 00       	mov    $0x8,%eax
80102e01:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102e02:	89 ca                	mov    %ecx,%edx
80102e04:	ec                   	in     (%dx),%al
80102e05:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102e07:	89 da                	mov    %ebx,%edx
80102e09:	b8 09 00 00 00       	mov    $0x9,%eax
80102e0e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102e0f:	89 ca                	mov    %ecx,%edx
80102e11:	ec                   	in     (%dx),%al
80102e12:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102e14:	89 da                	mov    %ebx,%edx
80102e16:	b8 0a 00 00 00       	mov    $0xa,%eax
80102e1b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102e1c:	89 ca                	mov    %ecx,%edx
80102e1e:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102e1f:	84 c0                	test   %al,%al
80102e21:	78 9d                	js     80102dc0 <cmostime+0x30>
  return inb(CMOS_RETURN);
80102e23:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80102e27:	89 fa                	mov    %edi,%edx
80102e29:	0f b6 fa             	movzbl %dl,%edi
80102e2c:	89 f2                	mov    %esi,%edx
80102e2e:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102e31:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102e35:	0f b6 f2             	movzbl %dl,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102e38:	89 da                	mov    %ebx,%edx
80102e3a:	89 7d c8             	mov    %edi,-0x38(%ebp)
80102e3d:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102e40:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80102e44:	89 75 cc             	mov    %esi,-0x34(%ebp)
80102e47:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102e4a:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102e4e:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102e51:	31 c0                	xor    %eax,%eax
80102e53:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102e54:	89 ca                	mov    %ecx,%edx
80102e56:	ec                   	in     (%dx),%al
80102e57:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102e5a:	89 da                	mov    %ebx,%edx
80102e5c:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102e5f:	b8 02 00 00 00       	mov    $0x2,%eax
80102e64:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102e65:	89 ca                	mov    %ecx,%edx
80102e67:	ec                   	in     (%dx),%al
80102e68:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102e6b:	89 da                	mov    %ebx,%edx
80102e6d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102e70:	b8 04 00 00 00       	mov    $0x4,%eax
80102e75:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102e76:	89 ca                	mov    %ecx,%edx
80102e78:	ec                   	in     (%dx),%al
80102e79:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102e7c:	89 da                	mov    %ebx,%edx
80102e7e:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102e81:	b8 07 00 00 00       	mov    $0x7,%eax
80102e86:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102e87:	89 ca                	mov    %ecx,%edx
80102e89:	ec                   	in     (%dx),%al
80102e8a:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102e8d:	89 da                	mov    %ebx,%edx
80102e8f:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102e92:	b8 08 00 00 00       	mov    $0x8,%eax
80102e97:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102e98:	89 ca                	mov    %ecx,%edx
80102e9a:	ec                   	in     (%dx),%al
80102e9b:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102e9e:	89 da                	mov    %ebx,%edx
80102ea0:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102ea3:	b8 09 00 00 00       	mov    $0x9,%eax
80102ea8:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ea9:	89 ca                	mov    %ecx,%edx
80102eab:	ec                   	in     (%dx),%al
80102eac:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102eaf:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80102eb2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102eb5:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102eb8:	6a 18                	push   $0x18
80102eba:	50                   	push   %eax
80102ebb:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102ebe:	50                   	push   %eax
80102ebf:	e8 1c 23 00 00       	call   801051e0 <memcmp>
80102ec4:	83 c4 10             	add    $0x10,%esp
80102ec7:	85 c0                	test   %eax,%eax
80102ec9:	0f 85 f1 fe ff ff    	jne    80102dc0 <cmostime+0x30>
      break;
  }

  // convert
  if(bcd) {
80102ecf:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
80102ed3:	75 78                	jne    80102f4d <cmostime+0x1bd>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102ed5:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102ed8:	89 c2                	mov    %eax,%edx
80102eda:	83 e0 0f             	and    $0xf,%eax
80102edd:	c1 ea 04             	shr    $0x4,%edx
80102ee0:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102ee3:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102ee6:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102ee9:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102eec:	89 c2                	mov    %eax,%edx
80102eee:	83 e0 0f             	and    $0xf,%eax
80102ef1:	c1 ea 04             	shr    $0x4,%edx
80102ef4:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102ef7:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102efa:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102efd:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102f00:	89 c2                	mov    %eax,%edx
80102f02:	83 e0 0f             	and    $0xf,%eax
80102f05:	c1 ea 04             	shr    $0x4,%edx
80102f08:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102f0b:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102f0e:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102f11:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102f14:	89 c2                	mov    %eax,%edx
80102f16:	83 e0 0f             	and    $0xf,%eax
80102f19:	c1 ea 04             	shr    $0x4,%edx
80102f1c:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102f1f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102f22:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102f25:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102f28:	89 c2                	mov    %eax,%edx
80102f2a:	83 e0 0f             	and    $0xf,%eax
80102f2d:	c1 ea 04             	shr    $0x4,%edx
80102f30:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102f33:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102f36:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102f39:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102f3c:	89 c2                	mov    %eax,%edx
80102f3e:	83 e0 0f             	and    $0xf,%eax
80102f41:	c1 ea 04             	shr    $0x4,%edx
80102f44:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102f47:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102f4a:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102f4d:	8b 75 08             	mov    0x8(%ebp),%esi
80102f50:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102f53:	89 06                	mov    %eax,(%esi)
80102f55:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102f58:	89 46 04             	mov    %eax,0x4(%esi)
80102f5b:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102f5e:	89 46 08             	mov    %eax,0x8(%esi)
80102f61:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102f64:	89 46 0c             	mov    %eax,0xc(%esi)
80102f67:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102f6a:	89 46 10             	mov    %eax,0x10(%esi)
80102f6d:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102f70:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102f73:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102f7a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102f7d:	5b                   	pop    %ebx
80102f7e:	5e                   	pop    %esi
80102f7f:	5f                   	pop    %edi
80102f80:	5d                   	pop    %ebp
80102f81:	c3                   	ret    
80102f82:	66 90                	xchg   %ax,%ax
80102f84:	66 90                	xchg   %ax,%ax
80102f86:	66 90                	xchg   %ax,%ax
80102f88:	66 90                	xchg   %ax,%ax
80102f8a:	66 90                	xchg   %ax,%ax
80102f8c:	66 90                	xchg   %ax,%ax
80102f8e:	66 90                	xchg   %ax,%ax

80102f90 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102f90:	8b 0d 08 37 11 80    	mov    0x80113708,%ecx
80102f96:	85 c9                	test   %ecx,%ecx
80102f98:	0f 8e 8a 00 00 00    	jle    80103028 <install_trans+0x98>
{
80102f9e:	55                   	push   %ebp
80102f9f:	89 e5                	mov    %esp,%ebp
80102fa1:	57                   	push   %edi
  for (tail = 0; tail < log.lh.n; tail++) {
80102fa2:	31 ff                	xor    %edi,%edi
{
80102fa4:	56                   	push   %esi
80102fa5:	53                   	push   %ebx
80102fa6:	83 ec 0c             	sub    $0xc,%esp
80102fa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102fb0:	a1 f4 36 11 80       	mov    0x801136f4,%eax
80102fb5:	83 ec 08             	sub    $0x8,%esp
80102fb8:	01 f8                	add    %edi,%eax
80102fba:	83 c0 01             	add    $0x1,%eax
80102fbd:	50                   	push   %eax
80102fbe:	ff 35 04 37 11 80    	pushl  0x80113704
80102fc4:	e8 07 d1 ff ff       	call   801000d0 <bread>
80102fc9:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102fcb:	58                   	pop    %eax
80102fcc:	5a                   	pop    %edx
80102fcd:	ff 34 bd 0c 37 11 80 	pushl  -0x7feec8f4(,%edi,4)
80102fd4:	ff 35 04 37 11 80    	pushl  0x80113704
  for (tail = 0; tail < log.lh.n; tail++) {
80102fda:	83 c7 01             	add    $0x1,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102fdd:	e8 ee d0 ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102fe2:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102fe5:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102fe7:	8d 46 5c             	lea    0x5c(%esi),%eax
80102fea:	68 00 02 00 00       	push   $0x200
80102fef:	50                   	push   %eax
80102ff0:	8d 43 5c             	lea    0x5c(%ebx),%eax
80102ff3:	50                   	push   %eax
80102ff4:	e8 37 22 00 00       	call   80105230 <memmove>
    bwrite(dbuf);  // write dst to disk
80102ff9:	89 1c 24             	mov    %ebx,(%esp)
80102ffc:	e8 af d1 ff ff       	call   801001b0 <bwrite>
    brelse(lbuf);
80103001:	89 34 24             	mov    %esi,(%esp)
80103004:	e8 e7 d1 ff ff       	call   801001f0 <brelse>
    brelse(dbuf);
80103009:	89 1c 24             	mov    %ebx,(%esp)
8010300c:	e8 df d1 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80103011:	83 c4 10             	add    $0x10,%esp
80103014:	39 3d 08 37 11 80    	cmp    %edi,0x80113708
8010301a:	7f 94                	jg     80102fb0 <install_trans+0x20>
  }
}
8010301c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010301f:	5b                   	pop    %ebx
80103020:	5e                   	pop    %esi
80103021:	5f                   	pop    %edi
80103022:	5d                   	pop    %ebp
80103023:	c3                   	ret    
80103024:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103028:	c3                   	ret    
80103029:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103030 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80103030:	55                   	push   %ebp
80103031:	89 e5                	mov    %esp,%ebp
80103033:	53                   	push   %ebx
80103034:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80103037:	ff 35 f4 36 11 80    	pushl  0x801136f4
8010303d:	ff 35 04 37 11 80    	pushl  0x80113704
80103043:	e8 88 d0 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80103048:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
8010304b:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
8010304d:	a1 08 37 11 80       	mov    0x80113708,%eax
80103052:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
80103055:	85 c0                	test   %eax,%eax
80103057:	7e 19                	jle    80103072 <write_head+0x42>
80103059:	31 d2                	xor    %edx,%edx
8010305b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010305f:	90                   	nop
    hb->block[i] = log.lh.block[i];
80103060:	8b 0c 95 0c 37 11 80 	mov    -0x7feec8f4(,%edx,4),%ecx
80103067:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
8010306b:	83 c2 01             	add    $0x1,%edx
8010306e:	39 d0                	cmp    %edx,%eax
80103070:	75 ee                	jne    80103060 <write_head+0x30>
  }
  bwrite(buf);
80103072:	83 ec 0c             	sub    $0xc,%esp
80103075:	53                   	push   %ebx
80103076:	e8 35 d1 ff ff       	call   801001b0 <bwrite>
  brelse(buf);
8010307b:	89 1c 24             	mov    %ebx,(%esp)
8010307e:	e8 6d d1 ff ff       	call   801001f0 <brelse>
}
80103083:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103086:	83 c4 10             	add    $0x10,%esp
80103089:	c9                   	leave  
8010308a:	c3                   	ret    
8010308b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010308f:	90                   	nop

80103090 <initlog>:
{
80103090:	f3 0f 1e fb          	endbr32 
80103094:	55                   	push   %ebp
80103095:	89 e5                	mov    %esp,%ebp
80103097:	53                   	push   %ebx
80103098:	83 ec 2c             	sub    $0x2c,%esp
8010309b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
8010309e:	68 40 84 10 80       	push   $0x80108440
801030a3:	68 c0 36 11 80       	push   $0x801136c0
801030a8:	e8 53 1e 00 00       	call   80104f00 <initlock>
  readsb(dev, &sb);
801030ad:	58                   	pop    %eax
801030ae:	8d 45 dc             	lea    -0x24(%ebp),%eax
801030b1:	5a                   	pop    %edx
801030b2:	50                   	push   %eax
801030b3:	53                   	push   %ebx
801030b4:	e8 27 e8 ff ff       	call   801018e0 <readsb>
  log.start = sb.logstart;
801030b9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
801030bc:	59                   	pop    %ecx
  log.dev = dev;
801030bd:	89 1d 04 37 11 80    	mov    %ebx,0x80113704
  log.size = sb.nlog;
801030c3:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
801030c6:	a3 f4 36 11 80       	mov    %eax,0x801136f4
  log.size = sb.nlog;
801030cb:	89 15 f8 36 11 80    	mov    %edx,0x801136f8
  struct buf *buf = bread(log.dev, log.start);
801030d1:	5a                   	pop    %edx
801030d2:	50                   	push   %eax
801030d3:	53                   	push   %ebx
801030d4:	e8 f7 cf ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
801030d9:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
801030dc:	8b 48 5c             	mov    0x5c(%eax),%ecx
801030df:	89 0d 08 37 11 80    	mov    %ecx,0x80113708
  for (i = 0; i < log.lh.n; i++) {
801030e5:	85 c9                	test   %ecx,%ecx
801030e7:	7e 19                	jle    80103102 <initlog+0x72>
801030e9:	31 d2                	xor    %edx,%edx
801030eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801030ef:	90                   	nop
    log.lh.block[i] = lh->block[i];
801030f0:	8b 5c 90 60          	mov    0x60(%eax,%edx,4),%ebx
801030f4:	89 1c 95 0c 37 11 80 	mov    %ebx,-0x7feec8f4(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
801030fb:	83 c2 01             	add    $0x1,%edx
801030fe:	39 d1                	cmp    %edx,%ecx
80103100:	75 ee                	jne    801030f0 <initlog+0x60>
  brelse(buf);
80103102:	83 ec 0c             	sub    $0xc,%esp
80103105:	50                   	push   %eax
80103106:	e8 e5 d0 ff ff       	call   801001f0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
8010310b:	e8 80 fe ff ff       	call   80102f90 <install_trans>
  log.lh.n = 0;
80103110:	c7 05 08 37 11 80 00 	movl   $0x0,0x80113708
80103117:	00 00 00 
  write_head(); // clear the log
8010311a:	e8 11 ff ff ff       	call   80103030 <write_head>
}
8010311f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103122:	83 c4 10             	add    $0x10,%esp
80103125:	c9                   	leave  
80103126:	c3                   	ret    
80103127:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010312e:	66 90                	xchg   %ax,%ax

80103130 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80103130:	f3 0f 1e fb          	endbr32 
80103134:	55                   	push   %ebp
80103135:	89 e5                	mov    %esp,%ebp
80103137:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
8010313a:	68 c0 36 11 80       	push   $0x801136c0
8010313f:	e8 3c 1f 00 00       	call   80105080 <acquire>
80103144:	83 c4 10             	add    $0x10,%esp
80103147:	eb 1c                	jmp    80103165 <begin_op+0x35>
80103149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80103150:	83 ec 08             	sub    $0x8,%esp
80103153:	68 c0 36 11 80       	push   $0x801136c0
80103158:	68 c0 36 11 80       	push   $0x801136c0
8010315d:	e8 2e 18 00 00       	call   80104990 <sleep>
80103162:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80103165:	a1 00 37 11 80       	mov    0x80113700,%eax
8010316a:	85 c0                	test   %eax,%eax
8010316c:	75 e2                	jne    80103150 <begin_op+0x20>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
8010316e:	a1 fc 36 11 80       	mov    0x801136fc,%eax
80103173:	8b 15 08 37 11 80    	mov    0x80113708,%edx
80103179:	83 c0 01             	add    $0x1,%eax
8010317c:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
8010317f:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80103182:	83 fa 1e             	cmp    $0x1e,%edx
80103185:	7f c9                	jg     80103150 <begin_op+0x20>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80103187:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
8010318a:	a3 fc 36 11 80       	mov    %eax,0x801136fc
      release(&log.lock);
8010318f:	68 c0 36 11 80       	push   $0x801136c0
80103194:	e8 a7 1f 00 00       	call   80105140 <release>
      break;
    }
  }
}
80103199:	83 c4 10             	add    $0x10,%esp
8010319c:	c9                   	leave  
8010319d:	c3                   	ret    
8010319e:	66 90                	xchg   %ax,%ax

801031a0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
801031a0:	f3 0f 1e fb          	endbr32 
801031a4:	55                   	push   %ebp
801031a5:	89 e5                	mov    %esp,%ebp
801031a7:	57                   	push   %edi
801031a8:	56                   	push   %esi
801031a9:	53                   	push   %ebx
801031aa:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
801031ad:	68 c0 36 11 80       	push   $0x801136c0
801031b2:	e8 c9 1e 00 00       	call   80105080 <acquire>
  log.outstanding -= 1;
801031b7:	a1 fc 36 11 80       	mov    0x801136fc,%eax
  if(log.committing)
801031bc:	8b 35 00 37 11 80    	mov    0x80113700,%esi
801031c2:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
801031c5:	8d 58 ff             	lea    -0x1(%eax),%ebx
801031c8:	89 1d fc 36 11 80    	mov    %ebx,0x801136fc
  if(log.committing)
801031ce:	85 f6                	test   %esi,%esi
801031d0:	0f 85 1e 01 00 00    	jne    801032f4 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
801031d6:	85 db                	test   %ebx,%ebx
801031d8:	0f 85 f2 00 00 00    	jne    801032d0 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
801031de:	c7 05 00 37 11 80 01 	movl   $0x1,0x80113700
801031e5:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
801031e8:	83 ec 0c             	sub    $0xc,%esp
801031eb:	68 c0 36 11 80       	push   $0x801136c0
801031f0:	e8 4b 1f 00 00       	call   80105140 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
801031f5:	8b 0d 08 37 11 80    	mov    0x80113708,%ecx
801031fb:	83 c4 10             	add    $0x10,%esp
801031fe:	85 c9                	test   %ecx,%ecx
80103200:	7f 3e                	jg     80103240 <end_op+0xa0>
    acquire(&log.lock);
80103202:	83 ec 0c             	sub    $0xc,%esp
80103205:	68 c0 36 11 80       	push   $0x801136c0
8010320a:	e8 71 1e 00 00       	call   80105080 <acquire>
    wakeup(&log);
8010320f:	c7 04 24 c0 36 11 80 	movl   $0x801136c0,(%esp)
    log.committing = 0;
80103216:	c7 05 00 37 11 80 00 	movl   $0x0,0x80113700
8010321d:	00 00 00 
    wakeup(&log);
80103220:	e8 2b 19 00 00       	call   80104b50 <wakeup>
    release(&log.lock);
80103225:	c7 04 24 c0 36 11 80 	movl   $0x801136c0,(%esp)
8010322c:	e8 0f 1f 00 00       	call   80105140 <release>
80103231:	83 c4 10             	add    $0x10,%esp
}
80103234:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103237:	5b                   	pop    %ebx
80103238:	5e                   	pop    %esi
80103239:	5f                   	pop    %edi
8010323a:	5d                   	pop    %ebp
8010323b:	c3                   	ret    
8010323c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80103240:	a1 f4 36 11 80       	mov    0x801136f4,%eax
80103245:	83 ec 08             	sub    $0x8,%esp
80103248:	01 d8                	add    %ebx,%eax
8010324a:	83 c0 01             	add    $0x1,%eax
8010324d:	50                   	push   %eax
8010324e:	ff 35 04 37 11 80    	pushl  0x80113704
80103254:	e8 77 ce ff ff       	call   801000d0 <bread>
80103259:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010325b:	58                   	pop    %eax
8010325c:	5a                   	pop    %edx
8010325d:	ff 34 9d 0c 37 11 80 	pushl  -0x7feec8f4(,%ebx,4)
80103264:	ff 35 04 37 11 80    	pushl  0x80113704
  for (tail = 0; tail < log.lh.n; tail++) {
8010326a:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010326d:	e8 5e ce ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80103272:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103275:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80103277:	8d 40 5c             	lea    0x5c(%eax),%eax
8010327a:	68 00 02 00 00       	push   $0x200
8010327f:	50                   	push   %eax
80103280:	8d 46 5c             	lea    0x5c(%esi),%eax
80103283:	50                   	push   %eax
80103284:	e8 a7 1f 00 00       	call   80105230 <memmove>
    bwrite(to);  // write the log
80103289:	89 34 24             	mov    %esi,(%esp)
8010328c:	e8 1f cf ff ff       	call   801001b0 <bwrite>
    brelse(from);
80103291:	89 3c 24             	mov    %edi,(%esp)
80103294:	e8 57 cf ff ff       	call   801001f0 <brelse>
    brelse(to);
80103299:	89 34 24             	mov    %esi,(%esp)
8010329c:	e8 4f cf ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
801032a1:	83 c4 10             	add    $0x10,%esp
801032a4:	3b 1d 08 37 11 80    	cmp    0x80113708,%ebx
801032aa:	7c 94                	jl     80103240 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
801032ac:	e8 7f fd ff ff       	call   80103030 <write_head>
    install_trans(); // Now install writes to home locations
801032b1:	e8 da fc ff ff       	call   80102f90 <install_trans>
    log.lh.n = 0;
801032b6:	c7 05 08 37 11 80 00 	movl   $0x0,0x80113708
801032bd:	00 00 00 
    write_head();    // Erase the transaction from the log
801032c0:	e8 6b fd ff ff       	call   80103030 <write_head>
801032c5:	e9 38 ff ff ff       	jmp    80103202 <end_op+0x62>
801032ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
801032d0:	83 ec 0c             	sub    $0xc,%esp
801032d3:	68 c0 36 11 80       	push   $0x801136c0
801032d8:	e8 73 18 00 00       	call   80104b50 <wakeup>
  release(&log.lock);
801032dd:	c7 04 24 c0 36 11 80 	movl   $0x801136c0,(%esp)
801032e4:	e8 57 1e 00 00       	call   80105140 <release>
801032e9:	83 c4 10             	add    $0x10,%esp
}
801032ec:	8d 65 f4             	lea    -0xc(%ebp),%esp
801032ef:	5b                   	pop    %ebx
801032f0:	5e                   	pop    %esi
801032f1:	5f                   	pop    %edi
801032f2:	5d                   	pop    %ebp
801032f3:	c3                   	ret    
    panic("log.committing");
801032f4:	83 ec 0c             	sub    $0xc,%esp
801032f7:	68 44 84 10 80       	push   $0x80108444
801032fc:	e8 8f d0 ff ff       	call   80100390 <panic>
80103301:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103308:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010330f:	90                   	nop

80103310 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80103310:	f3 0f 1e fb          	endbr32 
80103314:	55                   	push   %ebp
80103315:	89 e5                	mov    %esp,%ebp
80103317:	53                   	push   %ebx
80103318:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
8010331b:	8b 15 08 37 11 80    	mov    0x80113708,%edx
{
80103321:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103324:	83 fa 1d             	cmp    $0x1d,%edx
80103327:	0f 8f 91 00 00 00    	jg     801033be <log_write+0xae>
8010332d:	a1 f8 36 11 80       	mov    0x801136f8,%eax
80103332:	83 e8 01             	sub    $0x1,%eax
80103335:	39 c2                	cmp    %eax,%edx
80103337:	0f 8d 81 00 00 00    	jge    801033be <log_write+0xae>
    panic("too big a transaction");
  if (log.outstanding < 1)
8010333d:	a1 fc 36 11 80       	mov    0x801136fc,%eax
80103342:	85 c0                	test   %eax,%eax
80103344:	0f 8e 81 00 00 00    	jle    801033cb <log_write+0xbb>
    panic("log_write outside of trans");

  acquire(&log.lock);
8010334a:	83 ec 0c             	sub    $0xc,%esp
8010334d:	68 c0 36 11 80       	push   $0x801136c0
80103352:	e8 29 1d 00 00       	call   80105080 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80103357:	8b 15 08 37 11 80    	mov    0x80113708,%edx
8010335d:	83 c4 10             	add    $0x10,%esp
80103360:	85 d2                	test   %edx,%edx
80103362:	7e 4e                	jle    801033b2 <log_write+0xa2>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103364:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
80103367:	31 c0                	xor    %eax,%eax
80103369:	eb 0c                	jmp    80103377 <log_write+0x67>
8010336b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010336f:	90                   	nop
80103370:	83 c0 01             	add    $0x1,%eax
80103373:	39 c2                	cmp    %eax,%edx
80103375:	74 29                	je     801033a0 <log_write+0x90>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103377:	39 0c 85 0c 37 11 80 	cmp    %ecx,-0x7feec8f4(,%eax,4)
8010337e:	75 f0                	jne    80103370 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
80103380:	89 0c 85 0c 37 11 80 	mov    %ecx,-0x7feec8f4(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
80103387:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
8010338a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
8010338d:	c7 45 08 c0 36 11 80 	movl   $0x801136c0,0x8(%ebp)
}
80103394:	c9                   	leave  
  release(&log.lock);
80103395:	e9 a6 1d 00 00       	jmp    80105140 <release>
8010339a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
801033a0:	89 0c 95 0c 37 11 80 	mov    %ecx,-0x7feec8f4(,%edx,4)
    log.lh.n++;
801033a7:	83 c2 01             	add    $0x1,%edx
801033aa:	89 15 08 37 11 80    	mov    %edx,0x80113708
801033b0:	eb d5                	jmp    80103387 <log_write+0x77>
  log.lh.block[i] = b->blockno;
801033b2:	8b 43 08             	mov    0x8(%ebx),%eax
801033b5:	a3 0c 37 11 80       	mov    %eax,0x8011370c
  if (i == log.lh.n)
801033ba:	75 cb                	jne    80103387 <log_write+0x77>
801033bc:	eb e9                	jmp    801033a7 <log_write+0x97>
    panic("too big a transaction");
801033be:	83 ec 0c             	sub    $0xc,%esp
801033c1:	68 53 84 10 80       	push   $0x80108453
801033c6:	e8 c5 cf ff ff       	call   80100390 <panic>
    panic("log_write outside of trans");
801033cb:	83 ec 0c             	sub    $0xc,%esp
801033ce:	68 69 84 10 80       	push   $0x80108469
801033d3:	e8 b8 cf ff ff       	call   80100390 <panic>
801033d8:	66 90                	xchg   %ax,%ax
801033da:	66 90                	xchg   %ax,%ax
801033dc:	66 90                	xchg   %ax,%ax
801033de:	66 90                	xchg   %ax,%ax

801033e0 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
801033e0:	55                   	push   %ebp
801033e1:	89 e5                	mov    %esp,%ebp
801033e3:	53                   	push   %ebx
801033e4:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
801033e7:	e8 b4 09 00 00       	call   80103da0 <cpuid>
801033ec:	89 c3                	mov    %eax,%ebx
801033ee:	e8 ad 09 00 00       	call   80103da0 <cpuid>
801033f3:	83 ec 04             	sub    $0x4,%esp
801033f6:	53                   	push   %ebx
801033f7:	50                   	push   %eax
801033f8:	68 84 84 10 80       	push   $0x80108484
801033fd:	e8 ae d2 ff ff       	call   801006b0 <cprintf>
  idtinit();       // load idt register
80103402:	e8 19 32 00 00       	call   80106620 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80103407:	e8 24 09 00 00       	call   80103d30 <mycpu>
8010340c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
8010340e:	b8 01 00 00 00       	mov    $0x1,%eax
80103413:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
8010341a:	e8 b1 10 00 00       	call   801044d0 <scheduler>
8010341f:	90                   	nop

80103420 <mpenter>:
{
80103420:	f3 0f 1e fb          	endbr32 
80103424:	55                   	push   %ebp
80103425:	89 e5                	mov    %esp,%ebp
80103427:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
8010342a:	e8 f1 43 00 00       	call   80107820 <switchkvm>
  seginit();
8010342f:	e8 cc 42 00 00       	call   80107700 <seginit>
  lapicinit();
80103434:	e8 67 f7 ff ff       	call   80102ba0 <lapicinit>
  mpmain();
80103439:	e8 a2 ff ff ff       	call   801033e0 <mpmain>
8010343e:	66 90                	xchg   %ax,%ax

80103440 <main>:
{
80103440:	f3 0f 1e fb          	endbr32 
80103444:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103448:	83 e4 f0             	and    $0xfffffff0,%esp
8010344b:	ff 71 fc             	pushl  -0x4(%ecx)
8010344e:	55                   	push   %ebp
8010344f:	89 e5                	mov    %esp,%ebp
80103451:	53                   	push   %ebx
80103452:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80103453:	83 ec 08             	sub    $0x8,%esp
80103456:	68 00 00 40 80       	push   $0x80400000
8010345b:	68 08 9b 11 80       	push   $0x80119b08
80103460:	e8 db f4 ff ff       	call   80102940 <kinit1>
  kvmalloc();      // kernel page table
80103465:	e8 a6 48 00 00       	call   80107d10 <kvmalloc>
  mpinit();        // detect other processors
8010346a:	e8 81 01 00 00       	call   801035f0 <mpinit>
  lapicinit();     // interrupt controller
8010346f:	e8 2c f7 ff ff       	call   80102ba0 <lapicinit>
  seginit();       // segment descriptors
80103474:	e8 87 42 00 00       	call   80107700 <seginit>
  picinit();       // disable pic
80103479:	e8 52 03 00 00       	call   801037d0 <picinit>
  ioapicinit();    // another interrupt controller
8010347e:	e8 dd f2 ff ff       	call   80102760 <ioapicinit>
  consoleinit();   // console hardware
80103483:	e8 78 d9 ff ff       	call   80100e00 <consoleinit>
  uartinit();      // serial port
80103488:	e8 c3 35 00 00       	call   80106a50 <uartinit>
  pinit();         // process table
8010348d:	e8 7e 08 00 00       	call   80103d10 <pinit>
  tvinit();        // trap vectors
80103492:	e8 09 31 00 00       	call   801065a0 <tvinit>
  binit();         // buffer cache
80103497:	e8 a4 cb ff ff       	call   80100040 <binit>
  fileinit();      // file table
8010349c:	e8 1f dd ff ff       	call   801011c0 <fileinit>
  ideinit();       // disk 
801034a1:	e8 8a f0 ff ff       	call   80102530 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
801034a6:	83 c4 0c             	add    $0xc,%esp
801034a9:	68 8a 00 00 00       	push   $0x8a
801034ae:	68 8c b4 10 80       	push   $0x8010b48c
801034b3:	68 00 70 00 80       	push   $0x80007000
801034b8:	e8 73 1d 00 00       	call   80105230 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
801034bd:	83 c4 10             	add    $0x10,%esp
801034c0:	69 05 40 3d 11 80 b0 	imul   $0xb0,0x80113d40,%eax
801034c7:	00 00 00 
801034ca:	05 c0 37 11 80       	add    $0x801137c0,%eax
801034cf:	3d c0 37 11 80       	cmp    $0x801137c0,%eax
801034d4:	76 7a                	jbe    80103550 <main+0x110>
801034d6:	bb c0 37 11 80       	mov    $0x801137c0,%ebx
801034db:	eb 1c                	jmp    801034f9 <main+0xb9>
801034dd:	8d 76 00             	lea    0x0(%esi),%esi
801034e0:	69 05 40 3d 11 80 b0 	imul   $0xb0,0x80113d40,%eax
801034e7:	00 00 00 
801034ea:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
801034f0:	05 c0 37 11 80       	add    $0x801137c0,%eax
801034f5:	39 c3                	cmp    %eax,%ebx
801034f7:	73 57                	jae    80103550 <main+0x110>
    if(c == mycpu())  // We've started already.
801034f9:	e8 32 08 00 00       	call   80103d30 <mycpu>
801034fe:	39 c3                	cmp    %eax,%ebx
80103500:	74 de                	je     801034e0 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103502:	e8 09 f5 ff ff       	call   80102a10 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80103507:	83 ec 08             	sub    $0x8,%esp
    *(void(**)(void))(code-8) = mpenter;
8010350a:	c7 05 f8 6f 00 80 20 	movl   $0x80103420,0x80006ff8
80103511:	34 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103514:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
8010351b:	a0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
8010351e:	05 00 10 00 00       	add    $0x1000,%eax
80103523:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
80103528:	0f b6 03             	movzbl (%ebx),%eax
8010352b:	68 00 70 00 00       	push   $0x7000
80103530:	50                   	push   %eax
80103531:	e8 ba f7 ff ff       	call   80102cf0 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103536:	83 c4 10             	add    $0x10,%esp
80103539:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103540:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103546:	85 c0                	test   %eax,%eax
80103548:	74 f6                	je     80103540 <main+0x100>
8010354a:	eb 94                	jmp    801034e0 <main+0xa0>
8010354c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103550:	83 ec 08             	sub    $0x8,%esp
80103553:	68 00 00 00 8e       	push   $0x8e000000
80103558:	68 00 00 40 80       	push   $0x80400000
8010355d:	e8 4e f4 ff ff       	call   801029b0 <kinit2>
  userinit();      // first user process
80103562:	e8 b9 08 00 00       	call   80103e20 <userinit>
  mpmain();        // finish this processor's setup
80103567:	e8 74 fe ff ff       	call   801033e0 <mpmain>
8010356c:	66 90                	xchg   %ax,%ax
8010356e:	66 90                	xchg   %ax,%ax

80103570 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103570:	55                   	push   %ebp
80103571:	89 e5                	mov    %esp,%ebp
80103573:	57                   	push   %edi
80103574:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103575:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
8010357b:	53                   	push   %ebx
  e = addr+len;
8010357c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
8010357f:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80103582:	39 de                	cmp    %ebx,%esi
80103584:	72 10                	jb     80103596 <mpsearch1+0x26>
80103586:	eb 50                	jmp    801035d8 <mpsearch1+0x68>
80103588:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010358f:	90                   	nop
80103590:	89 fe                	mov    %edi,%esi
80103592:	39 fb                	cmp    %edi,%ebx
80103594:	76 42                	jbe    801035d8 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103596:	83 ec 04             	sub    $0x4,%esp
80103599:	8d 7e 10             	lea    0x10(%esi),%edi
8010359c:	6a 04                	push   $0x4
8010359e:	68 98 84 10 80       	push   $0x80108498
801035a3:	56                   	push   %esi
801035a4:	e8 37 1c 00 00       	call   801051e0 <memcmp>
801035a9:	83 c4 10             	add    $0x10,%esp
801035ac:	85 c0                	test   %eax,%eax
801035ae:	75 e0                	jne    80103590 <mpsearch1+0x20>
801035b0:	89 f2                	mov    %esi,%edx
801035b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
801035b8:	0f b6 0a             	movzbl (%edx),%ecx
801035bb:	83 c2 01             	add    $0x1,%edx
801035be:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
801035c0:	39 fa                	cmp    %edi,%edx
801035c2:	75 f4                	jne    801035b8 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801035c4:	84 c0                	test   %al,%al
801035c6:	75 c8                	jne    80103590 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
801035c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801035cb:	89 f0                	mov    %esi,%eax
801035cd:	5b                   	pop    %ebx
801035ce:	5e                   	pop    %esi
801035cf:	5f                   	pop    %edi
801035d0:	5d                   	pop    %ebp
801035d1:	c3                   	ret    
801035d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801035d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801035db:	31 f6                	xor    %esi,%esi
}
801035dd:	5b                   	pop    %ebx
801035de:	89 f0                	mov    %esi,%eax
801035e0:	5e                   	pop    %esi
801035e1:	5f                   	pop    %edi
801035e2:	5d                   	pop    %ebp
801035e3:	c3                   	ret    
801035e4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801035eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801035ef:	90                   	nop

801035f0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
801035f0:	f3 0f 1e fb          	endbr32 
801035f4:	55                   	push   %ebp
801035f5:	89 e5                	mov    %esp,%ebp
801035f7:	57                   	push   %edi
801035f8:	56                   	push   %esi
801035f9:	53                   	push   %ebx
801035fa:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
801035fd:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103604:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
8010360b:	c1 e0 08             	shl    $0x8,%eax
8010360e:	09 d0                	or     %edx,%eax
80103610:	c1 e0 04             	shl    $0x4,%eax
80103613:	75 1b                	jne    80103630 <mpinit+0x40>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103615:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010361c:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103623:	c1 e0 08             	shl    $0x8,%eax
80103626:	09 d0                	or     %edx,%eax
80103628:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
8010362b:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
80103630:	ba 00 04 00 00       	mov    $0x400,%edx
80103635:	e8 36 ff ff ff       	call   80103570 <mpsearch1>
8010363a:	89 c6                	mov    %eax,%esi
8010363c:	85 c0                	test   %eax,%eax
8010363e:	0f 84 4c 01 00 00    	je     80103790 <mpinit+0x1a0>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103644:	8b 5e 04             	mov    0x4(%esi),%ebx
80103647:	85 db                	test   %ebx,%ebx
80103649:	0f 84 61 01 00 00    	je     801037b0 <mpinit+0x1c0>
  if(memcmp(conf, "PCMP", 4) != 0)
8010364f:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103652:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
  if(memcmp(conf, "PCMP", 4) != 0)
80103658:	6a 04                	push   $0x4
8010365a:	68 9d 84 10 80       	push   $0x8010849d
8010365f:	50                   	push   %eax
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103660:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103663:	e8 78 1b 00 00       	call   801051e0 <memcmp>
80103668:	83 c4 10             	add    $0x10,%esp
8010366b:	85 c0                	test   %eax,%eax
8010366d:	0f 85 3d 01 00 00    	jne    801037b0 <mpinit+0x1c0>
  if(conf->version != 1 && conf->version != 4)
80103673:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
8010367a:	3c 01                	cmp    $0x1,%al
8010367c:	74 08                	je     80103686 <mpinit+0x96>
8010367e:	3c 04                	cmp    $0x4,%al
80103680:	0f 85 2a 01 00 00    	jne    801037b0 <mpinit+0x1c0>
  if(sum((uchar*)conf, conf->length) != 0)
80103686:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
  for(i=0; i<len; i++)
8010368d:	66 85 d2             	test   %dx,%dx
80103690:	74 26                	je     801036b8 <mpinit+0xc8>
80103692:	8d 3c 1a             	lea    (%edx,%ebx,1),%edi
80103695:	89 d8                	mov    %ebx,%eax
  sum = 0;
80103697:	31 d2                	xor    %edx,%edx
80103699:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
801036a0:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
801036a7:	83 c0 01             	add    $0x1,%eax
801036aa:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
801036ac:	39 f8                	cmp    %edi,%eax
801036ae:	75 f0                	jne    801036a0 <mpinit+0xb0>
  if(sum((uchar*)conf, conf->length) != 0)
801036b0:	84 d2                	test   %dl,%dl
801036b2:	0f 85 f8 00 00 00    	jne    801037b0 <mpinit+0x1c0>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
801036b8:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
801036be:	a3 bc 36 11 80       	mov    %eax,0x801136bc
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801036c3:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
801036c9:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
  ismp = 1;
801036d0:	bb 01 00 00 00       	mov    $0x1,%ebx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801036d5:	03 55 e4             	add    -0x1c(%ebp),%edx
801036d8:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801036db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801036df:	90                   	nop
801036e0:	39 c2                	cmp    %eax,%edx
801036e2:	76 15                	jbe    801036f9 <mpinit+0x109>
    switch(*p){
801036e4:	0f b6 08             	movzbl (%eax),%ecx
801036e7:	80 f9 02             	cmp    $0x2,%cl
801036ea:	74 5c                	je     80103748 <mpinit+0x158>
801036ec:	77 42                	ja     80103730 <mpinit+0x140>
801036ee:	84 c9                	test   %cl,%cl
801036f0:	74 6e                	je     80103760 <mpinit+0x170>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
801036f2:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801036f5:	39 c2                	cmp    %eax,%edx
801036f7:	77 eb                	ja     801036e4 <mpinit+0xf4>
801036f9:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
801036fc:	85 db                	test   %ebx,%ebx
801036fe:	0f 84 b9 00 00 00    	je     801037bd <mpinit+0x1cd>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
80103704:	80 7e 0c 00          	cmpb   $0x0,0xc(%esi)
80103708:	74 15                	je     8010371f <mpinit+0x12f>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010370a:	b8 70 00 00 00       	mov    $0x70,%eax
8010370f:	ba 22 00 00 00       	mov    $0x22,%edx
80103714:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103715:	ba 23 00 00 00       	mov    $0x23,%edx
8010371a:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
8010371b:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010371e:	ee                   	out    %al,(%dx)
  }
}
8010371f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103722:	5b                   	pop    %ebx
80103723:	5e                   	pop    %esi
80103724:	5f                   	pop    %edi
80103725:	5d                   	pop    %ebp
80103726:	c3                   	ret    
80103727:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010372e:	66 90                	xchg   %ax,%ax
    switch(*p){
80103730:	83 e9 03             	sub    $0x3,%ecx
80103733:	80 f9 01             	cmp    $0x1,%cl
80103736:	76 ba                	jbe    801036f2 <mpinit+0x102>
80103738:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
8010373f:	eb 9f                	jmp    801036e0 <mpinit+0xf0>
80103741:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
80103748:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
8010374c:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
8010374f:	88 0d a0 37 11 80    	mov    %cl,0x801137a0
      continue;
80103755:	eb 89                	jmp    801036e0 <mpinit+0xf0>
80103757:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010375e:	66 90                	xchg   %ax,%ax
      if(ncpu < NCPU) {
80103760:	8b 0d 40 3d 11 80    	mov    0x80113d40,%ecx
80103766:	83 f9 07             	cmp    $0x7,%ecx
80103769:	7f 19                	jg     80103784 <mpinit+0x194>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010376b:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
80103771:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
        ncpu++;
80103775:	83 c1 01             	add    $0x1,%ecx
80103778:	89 0d 40 3d 11 80    	mov    %ecx,0x80113d40
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010377e:	88 9f c0 37 11 80    	mov    %bl,-0x7feec840(%edi)
      p += sizeof(struct mpproc);
80103784:	83 c0 14             	add    $0x14,%eax
      continue;
80103787:	e9 54 ff ff ff       	jmp    801036e0 <mpinit+0xf0>
8010378c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return mpsearch1(0xF0000, 0x10000);
80103790:	ba 00 00 01 00       	mov    $0x10000,%edx
80103795:	b8 00 00 0f 00       	mov    $0xf0000,%eax
8010379a:	e8 d1 fd ff ff       	call   80103570 <mpsearch1>
8010379f:	89 c6                	mov    %eax,%esi
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801037a1:	85 c0                	test   %eax,%eax
801037a3:	0f 85 9b fe ff ff    	jne    80103644 <mpinit+0x54>
801037a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    panic("Expect to run on an SMP");
801037b0:	83 ec 0c             	sub    $0xc,%esp
801037b3:	68 a2 84 10 80       	push   $0x801084a2
801037b8:	e8 d3 cb ff ff       	call   80100390 <panic>
    panic("Didn't find a suitable machine");
801037bd:	83 ec 0c             	sub    $0xc,%esp
801037c0:	68 bc 84 10 80       	push   $0x801084bc
801037c5:	e8 c6 cb ff ff       	call   80100390 <panic>
801037ca:	66 90                	xchg   %ax,%ax
801037cc:	66 90                	xchg   %ax,%ax
801037ce:	66 90                	xchg   %ax,%ax

801037d0 <picinit>:
801037d0:	f3 0f 1e fb          	endbr32 
801037d4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801037d9:	ba 21 00 00 00       	mov    $0x21,%edx
801037de:	ee                   	out    %al,(%dx)
801037df:	ba a1 00 00 00       	mov    $0xa1,%edx
801037e4:	ee                   	out    %al,(%dx)
801037e5:	c3                   	ret    
801037e6:	66 90                	xchg   %ax,%ax
801037e8:	66 90                	xchg   %ax,%ax
801037ea:	66 90                	xchg   %ax,%ax
801037ec:	66 90                	xchg   %ax,%ax
801037ee:	66 90                	xchg   %ax,%ax

801037f0 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
801037f0:	f3 0f 1e fb          	endbr32 
801037f4:	55                   	push   %ebp
801037f5:	89 e5                	mov    %esp,%ebp
801037f7:	57                   	push   %edi
801037f8:	56                   	push   %esi
801037f9:	53                   	push   %ebx
801037fa:	83 ec 0c             	sub    $0xc,%esp
801037fd:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103800:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
80103803:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103809:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010380f:	e8 cc d9 ff ff       	call   801011e0 <filealloc>
80103814:	89 03                	mov    %eax,(%ebx)
80103816:	85 c0                	test   %eax,%eax
80103818:	0f 84 ac 00 00 00    	je     801038ca <pipealloc+0xda>
8010381e:	e8 bd d9 ff ff       	call   801011e0 <filealloc>
80103823:	89 06                	mov    %eax,(%esi)
80103825:	85 c0                	test   %eax,%eax
80103827:	0f 84 8b 00 00 00    	je     801038b8 <pipealloc+0xc8>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
8010382d:	e8 de f1 ff ff       	call   80102a10 <kalloc>
80103832:	89 c7                	mov    %eax,%edi
80103834:	85 c0                	test   %eax,%eax
80103836:	0f 84 b4 00 00 00    	je     801038f0 <pipealloc+0x100>
    goto bad;
  p->readopen = 1;
8010383c:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103843:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80103846:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
80103849:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103850:	00 00 00 
  p->nwrite = 0;
80103853:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
8010385a:	00 00 00 
  p->nread = 0;
8010385d:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103864:	00 00 00 
  initlock(&p->lock, "pipe");
80103867:	68 db 84 10 80       	push   $0x801084db
8010386c:	50                   	push   %eax
8010386d:	e8 8e 16 00 00       	call   80104f00 <initlock>
  (*f0)->type = FD_PIPE;
80103872:	8b 03                	mov    (%ebx),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103874:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80103877:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
8010387d:	8b 03                	mov    (%ebx),%eax
8010387f:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103883:	8b 03                	mov    (%ebx),%eax
80103885:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103889:	8b 03                	mov    (%ebx),%eax
8010388b:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
8010388e:	8b 06                	mov    (%esi),%eax
80103890:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103896:	8b 06                	mov    (%esi),%eax
80103898:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
8010389c:	8b 06                	mov    (%esi),%eax
8010389e:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
801038a2:	8b 06                	mov    (%esi),%eax
801038a4:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
801038a7:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801038aa:	31 c0                	xor    %eax,%eax
}
801038ac:	5b                   	pop    %ebx
801038ad:	5e                   	pop    %esi
801038ae:	5f                   	pop    %edi
801038af:	5d                   	pop    %ebp
801038b0:	c3                   	ret    
801038b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(*f0)
801038b8:	8b 03                	mov    (%ebx),%eax
801038ba:	85 c0                	test   %eax,%eax
801038bc:	74 1e                	je     801038dc <pipealloc+0xec>
    fileclose(*f0);
801038be:	83 ec 0c             	sub    $0xc,%esp
801038c1:	50                   	push   %eax
801038c2:	e8 d9 d9 ff ff       	call   801012a0 <fileclose>
801038c7:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801038ca:	8b 06                	mov    (%esi),%eax
801038cc:	85 c0                	test   %eax,%eax
801038ce:	74 0c                	je     801038dc <pipealloc+0xec>
    fileclose(*f1);
801038d0:	83 ec 0c             	sub    $0xc,%esp
801038d3:	50                   	push   %eax
801038d4:	e8 c7 d9 ff ff       	call   801012a0 <fileclose>
801038d9:	83 c4 10             	add    $0x10,%esp
}
801038dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
801038df:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801038e4:	5b                   	pop    %ebx
801038e5:	5e                   	pop    %esi
801038e6:	5f                   	pop    %edi
801038e7:	5d                   	pop    %ebp
801038e8:	c3                   	ret    
801038e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(*f0)
801038f0:	8b 03                	mov    (%ebx),%eax
801038f2:	85 c0                	test   %eax,%eax
801038f4:	75 c8                	jne    801038be <pipealloc+0xce>
801038f6:	eb d2                	jmp    801038ca <pipealloc+0xda>
801038f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801038ff:	90                   	nop

80103900 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103900:	f3 0f 1e fb          	endbr32 
80103904:	55                   	push   %ebp
80103905:	89 e5                	mov    %esp,%ebp
80103907:	56                   	push   %esi
80103908:	53                   	push   %ebx
80103909:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010390c:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010390f:	83 ec 0c             	sub    $0xc,%esp
80103912:	53                   	push   %ebx
80103913:	e8 68 17 00 00       	call   80105080 <acquire>
  if(writable){
80103918:	83 c4 10             	add    $0x10,%esp
8010391b:	85 f6                	test   %esi,%esi
8010391d:	74 41                	je     80103960 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
8010391f:	83 ec 0c             	sub    $0xc,%esp
80103922:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
80103928:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010392f:	00 00 00 
    wakeup(&p->nread);
80103932:	50                   	push   %eax
80103933:	e8 18 12 00 00       	call   80104b50 <wakeup>
80103938:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
8010393b:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
80103941:	85 d2                	test   %edx,%edx
80103943:	75 0a                	jne    8010394f <pipeclose+0x4f>
80103945:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
8010394b:	85 c0                	test   %eax,%eax
8010394d:	74 31                	je     80103980 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010394f:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80103952:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103955:	5b                   	pop    %ebx
80103956:	5e                   	pop    %esi
80103957:	5d                   	pop    %ebp
    release(&p->lock);
80103958:	e9 e3 17 00 00       	jmp    80105140 <release>
8010395d:	8d 76 00             	lea    0x0(%esi),%esi
    wakeup(&p->nwrite);
80103960:	83 ec 0c             	sub    $0xc,%esp
80103963:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
80103969:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103970:	00 00 00 
    wakeup(&p->nwrite);
80103973:	50                   	push   %eax
80103974:	e8 d7 11 00 00       	call   80104b50 <wakeup>
80103979:	83 c4 10             	add    $0x10,%esp
8010397c:	eb bd                	jmp    8010393b <pipeclose+0x3b>
8010397e:	66 90                	xchg   %ax,%ax
    release(&p->lock);
80103980:	83 ec 0c             	sub    $0xc,%esp
80103983:	53                   	push   %ebx
80103984:	e8 b7 17 00 00       	call   80105140 <release>
    kfree((char*)p);
80103989:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010398c:	83 c4 10             	add    $0x10,%esp
}
8010398f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103992:	5b                   	pop    %ebx
80103993:	5e                   	pop    %esi
80103994:	5d                   	pop    %ebp
    kfree((char*)p);
80103995:	e9 b6 ee ff ff       	jmp    80102850 <kfree>
8010399a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801039a0 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801039a0:	f3 0f 1e fb          	endbr32 
801039a4:	55                   	push   %ebp
801039a5:	89 e5                	mov    %esp,%ebp
801039a7:	57                   	push   %edi
801039a8:	56                   	push   %esi
801039a9:	53                   	push   %ebx
801039aa:	83 ec 28             	sub    $0x28,%esp
801039ad:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
801039b0:	53                   	push   %ebx
801039b1:	e8 ca 16 00 00       	call   80105080 <acquire>
  for(i = 0; i < n; i++){
801039b6:	8b 45 10             	mov    0x10(%ebp),%eax
801039b9:	83 c4 10             	add    $0x10,%esp
801039bc:	85 c0                	test   %eax,%eax
801039be:	0f 8e bc 00 00 00    	jle    80103a80 <pipewrite+0xe0>
801039c4:	8b 45 0c             	mov    0xc(%ebp),%eax
801039c7:	8b 8b 38 02 00 00    	mov    0x238(%ebx),%ecx
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801039cd:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
801039d3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801039d6:	03 45 10             	add    0x10(%ebp),%eax
801039d9:	89 45 e0             	mov    %eax,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801039dc:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801039e2:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801039e8:	89 ca                	mov    %ecx,%edx
801039ea:	05 00 02 00 00       	add    $0x200,%eax
801039ef:	39 c1                	cmp    %eax,%ecx
801039f1:	74 3b                	je     80103a2e <pipewrite+0x8e>
801039f3:	eb 63                	jmp    80103a58 <pipewrite+0xb8>
801039f5:	8d 76 00             	lea    0x0(%esi),%esi
      if(p->readopen == 0 || myproc()->killed){
801039f8:	e8 c3 03 00 00       	call   80103dc0 <myproc>
801039fd:	8b 48 24             	mov    0x24(%eax),%ecx
80103a00:	85 c9                	test   %ecx,%ecx
80103a02:	75 34                	jne    80103a38 <pipewrite+0x98>
      wakeup(&p->nread);
80103a04:	83 ec 0c             	sub    $0xc,%esp
80103a07:	57                   	push   %edi
80103a08:	e8 43 11 00 00       	call   80104b50 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103a0d:	58                   	pop    %eax
80103a0e:	5a                   	pop    %edx
80103a0f:	53                   	push   %ebx
80103a10:	56                   	push   %esi
80103a11:	e8 7a 0f 00 00       	call   80104990 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103a16:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103a1c:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
80103a22:	83 c4 10             	add    $0x10,%esp
80103a25:	05 00 02 00 00       	add    $0x200,%eax
80103a2a:	39 c2                	cmp    %eax,%edx
80103a2c:	75 2a                	jne    80103a58 <pipewrite+0xb8>
      if(p->readopen == 0 || myproc()->killed){
80103a2e:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103a34:	85 c0                	test   %eax,%eax
80103a36:	75 c0                	jne    801039f8 <pipewrite+0x58>
        release(&p->lock);
80103a38:	83 ec 0c             	sub    $0xc,%esp
80103a3b:	53                   	push   %ebx
80103a3c:	e8 ff 16 00 00       	call   80105140 <release>
        return -1;
80103a41:	83 c4 10             	add    $0x10,%esp
80103a44:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103a49:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103a4c:	5b                   	pop    %ebx
80103a4d:	5e                   	pop    %esi
80103a4e:	5f                   	pop    %edi
80103a4f:	5d                   	pop    %ebp
80103a50:	c3                   	ret    
80103a51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103a58:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80103a5b:	8d 4a 01             	lea    0x1(%edx),%ecx
80103a5e:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80103a64:	89 8b 38 02 00 00    	mov    %ecx,0x238(%ebx)
80103a6a:	0f b6 06             	movzbl (%esi),%eax
80103a6d:	83 c6 01             	add    $0x1,%esi
80103a70:	89 75 e4             	mov    %esi,-0x1c(%ebp)
80103a73:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
80103a77:	3b 75 e0             	cmp    -0x20(%ebp),%esi
80103a7a:	0f 85 5c ff ff ff    	jne    801039dc <pipewrite+0x3c>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103a80:	83 ec 0c             	sub    $0xc,%esp
80103a83:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103a89:	50                   	push   %eax
80103a8a:	e8 c1 10 00 00       	call   80104b50 <wakeup>
  release(&p->lock);
80103a8f:	89 1c 24             	mov    %ebx,(%esp)
80103a92:	e8 a9 16 00 00       	call   80105140 <release>
  return n;
80103a97:	8b 45 10             	mov    0x10(%ebp),%eax
80103a9a:	83 c4 10             	add    $0x10,%esp
80103a9d:	eb aa                	jmp    80103a49 <pipewrite+0xa9>
80103a9f:	90                   	nop

80103aa0 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103aa0:	f3 0f 1e fb          	endbr32 
80103aa4:	55                   	push   %ebp
80103aa5:	89 e5                	mov    %esp,%ebp
80103aa7:	57                   	push   %edi
80103aa8:	56                   	push   %esi
80103aa9:	53                   	push   %ebx
80103aaa:	83 ec 18             	sub    $0x18,%esp
80103aad:	8b 75 08             	mov    0x8(%ebp),%esi
80103ab0:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
80103ab3:	56                   	push   %esi
80103ab4:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
80103aba:	e8 c1 15 00 00       	call   80105080 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103abf:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103ac5:	83 c4 10             	add    $0x10,%esp
80103ac8:	39 86 38 02 00 00    	cmp    %eax,0x238(%esi)
80103ace:	74 33                	je     80103b03 <piperead+0x63>
80103ad0:	eb 3b                	jmp    80103b0d <piperead+0x6d>
80103ad2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(myproc()->killed){
80103ad8:	e8 e3 02 00 00       	call   80103dc0 <myproc>
80103add:	8b 48 24             	mov    0x24(%eax),%ecx
80103ae0:	85 c9                	test   %ecx,%ecx
80103ae2:	0f 85 88 00 00 00    	jne    80103b70 <piperead+0xd0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103ae8:	83 ec 08             	sub    $0x8,%esp
80103aeb:	56                   	push   %esi
80103aec:	53                   	push   %ebx
80103aed:	e8 9e 0e 00 00       	call   80104990 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103af2:	8b 86 38 02 00 00    	mov    0x238(%esi),%eax
80103af8:	83 c4 10             	add    $0x10,%esp
80103afb:	39 86 34 02 00 00    	cmp    %eax,0x234(%esi)
80103b01:	75 0a                	jne    80103b0d <piperead+0x6d>
80103b03:	8b 86 40 02 00 00    	mov    0x240(%esi),%eax
80103b09:	85 c0                	test   %eax,%eax
80103b0b:	75 cb                	jne    80103ad8 <piperead+0x38>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103b0d:	8b 55 10             	mov    0x10(%ebp),%edx
80103b10:	31 db                	xor    %ebx,%ebx
80103b12:	85 d2                	test   %edx,%edx
80103b14:	7f 28                	jg     80103b3e <piperead+0x9e>
80103b16:	eb 34                	jmp    80103b4c <piperead+0xac>
80103b18:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103b1f:	90                   	nop
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103b20:	8d 48 01             	lea    0x1(%eax),%ecx
80103b23:	25 ff 01 00 00       	and    $0x1ff,%eax
80103b28:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
80103b2e:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80103b33:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103b36:	83 c3 01             	add    $0x1,%ebx
80103b39:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80103b3c:	74 0e                	je     80103b4c <piperead+0xac>
    if(p->nread == p->nwrite)
80103b3e:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103b44:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80103b4a:	75 d4                	jne    80103b20 <piperead+0x80>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80103b4c:	83 ec 0c             	sub    $0xc,%esp
80103b4f:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103b55:	50                   	push   %eax
80103b56:	e8 f5 0f 00 00       	call   80104b50 <wakeup>
  release(&p->lock);
80103b5b:	89 34 24             	mov    %esi,(%esp)
80103b5e:	e8 dd 15 00 00       	call   80105140 <release>
  return i;
80103b63:	83 c4 10             	add    $0x10,%esp
}
80103b66:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103b69:	89 d8                	mov    %ebx,%eax
80103b6b:	5b                   	pop    %ebx
80103b6c:	5e                   	pop    %esi
80103b6d:	5f                   	pop    %edi
80103b6e:	5d                   	pop    %ebp
80103b6f:	c3                   	ret    
      release(&p->lock);
80103b70:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103b73:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
80103b78:	56                   	push   %esi
80103b79:	e8 c2 15 00 00       	call   80105140 <release>
      return -1;
80103b7e:	83 c4 10             	add    $0x10,%esp
}
80103b81:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103b84:	89 d8                	mov    %ebx,%eax
80103b86:	5b                   	pop    %ebx
80103b87:	5e                   	pop    %esi
80103b88:	5f                   	pop    %edi
80103b89:	5d                   	pop    %ebp
80103b8a:	c3                   	ret    
80103b8b:	66 90                	xchg   %ax,%ax
80103b8d:	66 90                	xchg   %ax,%ax
80103b8f:	90                   	nop

80103b90 <allocproc>:
int last_arrival = 0;
int delay = 0;

static struct proc*
allocproc(void)
{
80103b90:	55                   	push   %ebp
80103b91:	89 e5                	mov    %esp,%ebp
80103b93:	56                   	push   %esi
80103b94:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103b95:	bb b4 3d 11 80       	mov    $0x80113db4,%ebx
  acquire(&ptable.lock);
80103b9a:	83 ec 0c             	sub    $0xc,%esp
80103b9d:	68 80 3d 11 80       	push   $0x80113d80
80103ba2:	e8 d9 14 00 00       	call   80105080 <acquire>
80103ba7:	83 c4 10             	add    $0x10,%esp
80103baa:	eb 16                	jmp    80103bc2 <allocproc+0x32>
80103bac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103bb0:	81 c3 54 01 00 00    	add    $0x154,%ebx
80103bb6:	81 fb b4 92 11 80    	cmp    $0x801192b4,%ebx
80103bbc:	0f 84 ce 00 00 00    	je     80103c90 <allocproc+0x100>
    if(p->state == UNUSED)
80103bc2:	8b 43 0c             	mov    0xc(%ebx),%eax
80103bc5:	85 c0                	test   %eax,%eax
80103bc7:	75 e7                	jne    80103bb0 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103bc9:	a1 08 b0 10 80       	mov    0x8010b008,%eax
  acquire(&tickslock);
80103bce:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
80103bd1:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->qnum = 2;
80103bd8:	c7 43 7c 02 00 00 00 	movl   $0x2,0x7c(%ebx)
  p->pid = nextpid++;
80103bdf:	89 43 10             	mov    %eax,0x10(%ebx)
80103be2:	8d 50 01             	lea    0x1(%eax),%edx
  acquire(&tickslock);
80103be5:	68 c0 92 11 80       	push   $0x801192c0
  p->pid = nextpid++;
80103bea:	89 15 08 b0 10 80    	mov    %edx,0x8010b008
  acquire(&tickslock);
80103bf0:	e8 8b 14 00 00       	call   80105080 <acquire>
  ticks0 = ticks;
80103bf5:	8b 35 00 9b 11 80    	mov    0x80119b00,%esi
  release(&tickslock);
80103bfb:	c7 04 24 c0 92 11 80 	movl   $0x801192c0,(%esp)
80103c02:	e8 39 15 00 00       	call   80105140 <release>
  p->arrival_time = getTime();
  p->cycles = 1;
80103c07:	c7 83 84 00 00 00 01 	movl   $0x1,0x84(%ebx)
80103c0e:	00 00 00 
  p->arrival_time = getTime();
80103c11:	89 b3 80 00 00 00    	mov    %esi,0x80(%ebx)
  p->HRRN_priority = 0;
80103c17:	c7 83 88 00 00 00 00 	movl   $0x0,0x88(%ebx)
80103c1e:	00 00 00 
  p->wait_cycles = 0;
80103c21:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80103c28:	00 00 00 
  p->fileNum = 0;
80103c2b:	c7 83 90 00 00 00 00 	movl   $0x0,0x90(%ebx)
80103c32:	00 00 00 

  release(&ptable.lock);
80103c35:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80103c3c:	e8 ff 14 00 00       	call   80105140 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103c41:	e8 ca ed ff ff       	call   80102a10 <kalloc>
80103c46:	83 c4 10             	add    $0x10,%esp
80103c49:	89 43 08             	mov    %eax,0x8(%ebx)
80103c4c:	85 c0                	test   %eax,%eax
80103c4e:	74 5b                	je     80103cab <allocproc+0x11b>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103c50:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103c56:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
80103c59:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103c5e:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103c61:	c7 40 14 91 65 10 80 	movl   $0x80106591,0x14(%eax)
  p->context = (struct context*)sp;
80103c68:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103c6b:	6a 14                	push   $0x14
80103c6d:	6a 00                	push   $0x0
80103c6f:	50                   	push   %eax
80103c70:	e8 1b 15 00 00       	call   80105190 <memset>
  p->context->eip = (uint)forkret;
80103c75:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
80103c78:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103c7b:	c7 40 10 c0 3c 10 80 	movl   $0x80103cc0,0x10(%eax)
}
80103c82:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103c85:	89 d8                	mov    %ebx,%eax
80103c87:	5b                   	pop    %ebx
80103c88:	5e                   	pop    %esi
80103c89:	5d                   	pop    %ebp
80103c8a:	c3                   	ret    
80103c8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103c8f:	90                   	nop
  release(&ptable.lock);
80103c90:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103c93:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103c95:	68 80 3d 11 80       	push   $0x80113d80
80103c9a:	e8 a1 14 00 00       	call   80105140 <release>
  return 0;
80103c9f:	83 c4 10             	add    $0x10,%esp
}
80103ca2:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103ca5:	89 d8                	mov    %ebx,%eax
80103ca7:	5b                   	pop    %ebx
80103ca8:	5e                   	pop    %esi
80103ca9:	5d                   	pop    %ebp
80103caa:	c3                   	ret    
    p->state = UNUSED;
80103cab:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
}
80103cb2:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return 0;
80103cb5:	31 db                	xor    %ebx,%ebx
}
80103cb7:	89 d8                	mov    %ebx,%eax
80103cb9:	5b                   	pop    %ebx
80103cba:	5e                   	pop    %esi
80103cbb:	5d                   	pop    %ebp
80103cbc:	c3                   	ret    
80103cbd:	8d 76 00             	lea    0x0(%esi),%esi

80103cc0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103cc0:	f3 0f 1e fb          	endbr32 
80103cc4:	55                   	push   %ebp
80103cc5:	89 e5                	mov    %esp,%ebp
80103cc7:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103cca:	68 80 3d 11 80       	push   $0x80113d80
80103ccf:	e8 6c 14 00 00       	call   80105140 <release>

  if (first) {
80103cd4:	a1 00 b0 10 80       	mov    0x8010b000,%eax
80103cd9:	83 c4 10             	add    $0x10,%esp
80103cdc:	85 c0                	test   %eax,%eax
80103cde:	75 08                	jne    80103ce8 <forkret+0x28>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
80103ce0:	c9                   	leave  
80103ce1:	c3                   	ret    
80103ce2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    first = 0;
80103ce8:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
80103cef:	00 00 00 
    iinit(ROOTDEV);
80103cf2:	83 ec 0c             	sub    $0xc,%esp
80103cf5:	6a 01                	push   $0x1
80103cf7:	e8 24 dc ff ff       	call   80101920 <iinit>
    initlog(ROOTDEV);
80103cfc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80103d03:	e8 88 f3 ff ff       	call   80103090 <initlog>
}
80103d08:	83 c4 10             	add    $0x10,%esp
80103d0b:	c9                   	leave  
80103d0c:	c3                   	ret    
80103d0d:	8d 76 00             	lea    0x0(%esi),%esi

80103d10 <pinit>:
{
80103d10:	f3 0f 1e fb          	endbr32 
80103d14:	55                   	push   %ebp
80103d15:	89 e5                	mov    %esp,%ebp
80103d17:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103d1a:	68 e0 84 10 80       	push   $0x801084e0
80103d1f:	68 80 3d 11 80       	push   $0x80113d80
80103d24:	e8 d7 11 00 00       	call   80104f00 <initlock>
}
80103d29:	83 c4 10             	add    $0x10,%esp
80103d2c:	c9                   	leave  
80103d2d:	c3                   	ret    
80103d2e:	66 90                	xchg   %ax,%ax

80103d30 <mycpu>:
{
80103d30:	f3 0f 1e fb          	endbr32 
80103d34:	55                   	push   %ebp
80103d35:	89 e5                	mov    %esp,%ebp
80103d37:	56                   	push   %esi
80103d38:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103d39:	9c                   	pushf  
80103d3a:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103d3b:	f6 c4 02             	test   $0x2,%ah
80103d3e:	75 4a                	jne    80103d8a <mycpu+0x5a>
  apicid = lapicid();
80103d40:	e8 5b ef ff ff       	call   80102ca0 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103d45:	8b 35 40 3d 11 80    	mov    0x80113d40,%esi
  apicid = lapicid();
80103d4b:	89 c3                	mov    %eax,%ebx
  for (i = 0; i < ncpu; ++i) {
80103d4d:	85 f6                	test   %esi,%esi
80103d4f:	7e 2c                	jle    80103d7d <mycpu+0x4d>
80103d51:	31 d2                	xor    %edx,%edx
80103d53:	eb 0a                	jmp    80103d5f <mycpu+0x2f>
80103d55:	8d 76 00             	lea    0x0(%esi),%esi
80103d58:	83 c2 01             	add    $0x1,%edx
80103d5b:	39 f2                	cmp    %esi,%edx
80103d5d:	74 1e                	je     80103d7d <mycpu+0x4d>
    if (cpus[i].apicid == apicid)
80103d5f:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
80103d65:	0f b6 81 c0 37 11 80 	movzbl -0x7feec840(%ecx),%eax
80103d6c:	39 d8                	cmp    %ebx,%eax
80103d6e:	75 e8                	jne    80103d58 <mycpu+0x28>
}
80103d70:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return &cpus[i];
80103d73:	8d 81 c0 37 11 80    	lea    -0x7feec840(%ecx),%eax
}
80103d79:	5b                   	pop    %ebx
80103d7a:	5e                   	pop    %esi
80103d7b:	5d                   	pop    %ebp
80103d7c:	c3                   	ret    
  panic("unknown apicid\n");
80103d7d:	83 ec 0c             	sub    $0xc,%esp
80103d80:	68 e7 84 10 80       	push   $0x801084e7
80103d85:	e8 06 c6 ff ff       	call   80100390 <panic>
    panic("mycpu called with interrupts enabled\n");
80103d8a:	83 ec 0c             	sub    $0xc,%esp
80103d8d:	68 04 86 10 80       	push   $0x80108604
80103d92:	e8 f9 c5 ff ff       	call   80100390 <panic>
80103d97:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103d9e:	66 90                	xchg   %ax,%ax

80103da0 <cpuid>:
cpuid() {
80103da0:	f3 0f 1e fb          	endbr32 
80103da4:	55                   	push   %ebp
80103da5:	89 e5                	mov    %esp,%ebp
80103da7:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103daa:	e8 81 ff ff ff       	call   80103d30 <mycpu>
}
80103daf:	c9                   	leave  
  return mycpu()-cpus;
80103db0:	2d c0 37 11 80       	sub    $0x801137c0,%eax
80103db5:	c1 f8 04             	sar    $0x4,%eax
80103db8:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
80103dbe:	c3                   	ret    
80103dbf:	90                   	nop

80103dc0 <myproc>:
myproc(void) {
80103dc0:	f3 0f 1e fb          	endbr32 
80103dc4:	55                   	push   %ebp
80103dc5:	89 e5                	mov    %esp,%ebp
80103dc7:	53                   	push   %ebx
80103dc8:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103dcb:	e8 b0 11 00 00       	call   80104f80 <pushcli>
  c = mycpu();
80103dd0:	e8 5b ff ff ff       	call   80103d30 <mycpu>
  p = c->proc;
80103dd5:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103ddb:	e8 f0 11 00 00       	call   80104fd0 <popcli>
}
80103de0:	83 c4 04             	add    $0x4,%esp
80103de3:	89 d8                	mov    %ebx,%eax
80103de5:	5b                   	pop    %ebx
80103de6:	5d                   	pop    %ebp
80103de7:	c3                   	ret    
80103de8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103def:	90                   	nop

80103df0 <getTime>:
int getTime(void) {
80103df0:	f3 0f 1e fb          	endbr32 
80103df4:	55                   	push   %ebp
80103df5:	89 e5                	mov    %esp,%ebp
80103df7:	53                   	push   %ebx
80103df8:	83 ec 10             	sub    $0x10,%esp
  acquire(&tickslock);
80103dfb:	68 c0 92 11 80       	push   $0x801192c0
80103e00:	e8 7b 12 00 00       	call   80105080 <acquire>
  ticks0 = ticks;
80103e05:	8b 1d 00 9b 11 80    	mov    0x80119b00,%ebx
  release(&tickslock);
80103e0b:	c7 04 24 c0 92 11 80 	movl   $0x801192c0,(%esp)
80103e12:	e8 29 13 00 00       	call   80105140 <release>
}
80103e17:	89 d8                	mov    %ebx,%eax
80103e19:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103e1c:	c9                   	leave  
80103e1d:	c3                   	ret    
80103e1e:	66 90                	xchg   %ax,%ax

80103e20 <userinit>:
{
80103e20:	f3 0f 1e fb          	endbr32 
80103e24:	55                   	push   %ebp
80103e25:	89 e5                	mov    %esp,%ebp
80103e27:	53                   	push   %ebx
80103e28:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103e2b:	e8 60 fd ff ff       	call   80103b90 <allocproc>
80103e30:	89 c3                	mov    %eax,%ebx
  initproc = p;
80103e32:	a3 e0 b5 10 80       	mov    %eax,0x8010b5e0
  if((p->pgdir = setupkvm()) == 0)
80103e37:	e8 54 3e 00 00       	call   80107c90 <setupkvm>
80103e3c:	89 43 04             	mov    %eax,0x4(%ebx)
80103e3f:	85 c0                	test   %eax,%eax
80103e41:	0f 84 bd 00 00 00    	je     80103f04 <userinit+0xe4>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103e47:	83 ec 04             	sub    $0x4,%esp
80103e4a:	68 2c 00 00 00       	push   $0x2c
80103e4f:	68 60 b4 10 80       	push   $0x8010b460
80103e54:	50                   	push   %eax
80103e55:	e8 f6 3a 00 00       	call   80107950 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103e5a:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103e5d:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103e63:	6a 4c                	push   $0x4c
80103e65:	6a 00                	push   $0x0
80103e67:	ff 73 18             	pushl  0x18(%ebx)
80103e6a:	e8 21 13 00 00       	call   80105190 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103e6f:	8b 43 18             	mov    0x18(%ebx),%eax
80103e72:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103e77:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103e7a:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103e7f:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103e83:	8b 43 18             	mov    0x18(%ebx),%eax
80103e86:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103e8a:	8b 43 18             	mov    0x18(%ebx),%eax
80103e8d:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103e91:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103e95:	8b 43 18             	mov    0x18(%ebx),%eax
80103e98:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103e9c:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103ea0:	8b 43 18             	mov    0x18(%ebx),%eax
80103ea3:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103eaa:	8b 43 18             	mov    0x18(%ebx),%eax
80103ead:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103eb4:	8b 43 18             	mov    0x18(%ebx),%eax
80103eb7:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103ebe:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103ec1:	6a 10                	push   $0x10
80103ec3:	68 10 85 10 80       	push   $0x80108510
80103ec8:	50                   	push   %eax
80103ec9:	e8 82 14 00 00       	call   80105350 <safestrcpy>
  p->cwd = namei("/");
80103ece:	c7 04 24 19 85 10 80 	movl   $0x80108519,(%esp)
80103ed5:	e8 36 e5 ff ff       	call   80102410 <namei>
80103eda:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103edd:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80103ee4:	e8 97 11 00 00       	call   80105080 <acquire>
  p->state = RUNNABLE;
80103ee9:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103ef0:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80103ef7:	e8 44 12 00 00       	call   80105140 <release>
}
80103efc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103eff:	83 c4 10             	add    $0x10,%esp
80103f02:	c9                   	leave  
80103f03:	c3                   	ret    
    panic("userinit: out of memory?");
80103f04:	83 ec 0c             	sub    $0xc,%esp
80103f07:	68 f7 84 10 80       	push   $0x801084f7
80103f0c:	e8 7f c4 ff ff       	call   80100390 <panic>
80103f11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103f18:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103f1f:	90                   	nop

80103f20 <growproc>:
{
80103f20:	f3 0f 1e fb          	endbr32 
80103f24:	55                   	push   %ebp
80103f25:	89 e5                	mov    %esp,%ebp
80103f27:	56                   	push   %esi
80103f28:	53                   	push   %ebx
80103f29:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103f2c:	e8 4f 10 00 00       	call   80104f80 <pushcli>
  c = mycpu();
80103f31:	e8 fa fd ff ff       	call   80103d30 <mycpu>
  p = c->proc;
80103f36:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103f3c:	e8 8f 10 00 00       	call   80104fd0 <popcli>
  sz = curproc->sz;
80103f41:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103f43:	85 f6                	test   %esi,%esi
80103f45:	7f 19                	jg     80103f60 <growproc+0x40>
  } else if(n < 0){
80103f47:	75 37                	jne    80103f80 <growproc+0x60>
  switchuvm(curproc);
80103f49:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103f4c:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103f4e:	53                   	push   %ebx
80103f4f:	e8 ec 38 00 00       	call   80107840 <switchuvm>
  return 0;
80103f54:	83 c4 10             	add    $0x10,%esp
80103f57:	31 c0                	xor    %eax,%eax
}
80103f59:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103f5c:	5b                   	pop    %ebx
80103f5d:	5e                   	pop    %esi
80103f5e:	5d                   	pop    %ebp
80103f5f:	c3                   	ret    
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103f60:	83 ec 04             	sub    $0x4,%esp
80103f63:	01 c6                	add    %eax,%esi
80103f65:	56                   	push   %esi
80103f66:	50                   	push   %eax
80103f67:	ff 73 04             	pushl  0x4(%ebx)
80103f6a:	e8 31 3b 00 00       	call   80107aa0 <allocuvm>
80103f6f:	83 c4 10             	add    $0x10,%esp
80103f72:	85 c0                	test   %eax,%eax
80103f74:	75 d3                	jne    80103f49 <growproc+0x29>
      return -1;
80103f76:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103f7b:	eb dc                	jmp    80103f59 <growproc+0x39>
80103f7d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103f80:	83 ec 04             	sub    $0x4,%esp
80103f83:	01 c6                	add    %eax,%esi
80103f85:	56                   	push   %esi
80103f86:	50                   	push   %eax
80103f87:	ff 73 04             	pushl  0x4(%ebx)
80103f8a:	e8 51 3c 00 00       	call   80107be0 <deallocuvm>
80103f8f:	83 c4 10             	add    $0x10,%esp
80103f92:	85 c0                	test   %eax,%eax
80103f94:	75 b3                	jne    80103f49 <growproc+0x29>
80103f96:	eb de                	jmp    80103f76 <growproc+0x56>
80103f98:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103f9f:	90                   	nop

80103fa0 <fork>:
{
80103fa0:	f3 0f 1e fb          	endbr32 
80103fa4:	55                   	push   %ebp
80103fa5:	89 e5                	mov    %esp,%ebp
80103fa7:	57                   	push   %edi
80103fa8:	56                   	push   %esi
80103fa9:	53                   	push   %ebx
80103faa:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103fad:	e8 ce 0f 00 00       	call   80104f80 <pushcli>
  c = mycpu();
80103fb2:	e8 79 fd ff ff       	call   80103d30 <mycpu>
  p = c->proc;
80103fb7:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103fbd:	e8 0e 10 00 00       	call   80104fd0 <popcli>
  if((np = allocproc()) == 0){
80103fc2:	e8 c9 fb ff ff       	call   80103b90 <allocproc>
80103fc7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103fca:	85 c0                	test   %eax,%eax
80103fcc:	0f 84 bb 00 00 00    	je     8010408d <fork+0xed>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103fd2:	83 ec 08             	sub    $0x8,%esp
80103fd5:	ff 33                	pushl  (%ebx)
80103fd7:	89 c7                	mov    %eax,%edi
80103fd9:	ff 73 04             	pushl  0x4(%ebx)
80103fdc:	e8 7f 3d 00 00       	call   80107d60 <copyuvm>
80103fe1:	83 c4 10             	add    $0x10,%esp
80103fe4:	89 47 04             	mov    %eax,0x4(%edi)
80103fe7:	85 c0                	test   %eax,%eax
80103fe9:	0f 84 a5 00 00 00    	je     80104094 <fork+0xf4>
  np->sz = curproc->sz;
80103fef:	8b 03                	mov    (%ebx),%eax
80103ff1:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103ff4:	89 01                	mov    %eax,(%ecx)
  *np->tf = *curproc->tf;
80103ff6:	8b 79 18             	mov    0x18(%ecx),%edi
  np->parent = curproc;
80103ff9:	89 c8                	mov    %ecx,%eax
80103ffb:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
80103ffe:	b9 13 00 00 00       	mov    $0x13,%ecx
80104003:	8b 73 18             	mov    0x18(%ebx),%esi
80104006:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80104008:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
8010400a:	8b 40 18             	mov    0x18(%eax),%eax
8010400d:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  for(i = 0; i < NOFILE; i++)
80104014:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[i])
80104018:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
8010401c:	85 c0                	test   %eax,%eax
8010401e:	74 13                	je     80104033 <fork+0x93>
      np->ofile[i] = filedup(curproc->ofile[i]);
80104020:	83 ec 0c             	sub    $0xc,%esp
80104023:	50                   	push   %eax
80104024:	e8 27 d2 ff ff       	call   80101250 <filedup>
80104029:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010402c:	83 c4 10             	add    $0x10,%esp
8010402f:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80104033:	83 c6 01             	add    $0x1,%esi
80104036:	83 fe 10             	cmp    $0x10,%esi
80104039:	75 dd                	jne    80104018 <fork+0x78>
  np->cwd = idup(curproc->cwd);
8010403b:	83 ec 0c             	sub    $0xc,%esp
8010403e:	ff 73 68             	pushl  0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104041:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
80104044:	e8 c7 da ff ff       	call   80101b10 <idup>
80104049:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
8010404c:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
8010404f:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104052:	8d 47 6c             	lea    0x6c(%edi),%eax
80104055:	6a 10                	push   $0x10
80104057:	53                   	push   %ebx
80104058:	50                   	push   %eax
80104059:	e8 f2 12 00 00       	call   80105350 <safestrcpy>
  pid = np->pid;
8010405e:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80104061:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80104068:	e8 13 10 00 00       	call   80105080 <acquire>
  np->state = RUNNABLE;
8010406d:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80104074:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
8010407b:	e8 c0 10 00 00       	call   80105140 <release>
  return pid;
80104080:	83 c4 10             	add    $0x10,%esp
}
80104083:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104086:	89 d8                	mov    %ebx,%eax
80104088:	5b                   	pop    %ebx
80104089:	5e                   	pop    %esi
8010408a:	5f                   	pop    %edi
8010408b:	5d                   	pop    %ebp
8010408c:	c3                   	ret    
    return -1;
8010408d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80104092:	eb ef                	jmp    80104083 <fork+0xe3>
    kfree(np->kstack);
80104094:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80104097:	83 ec 0c             	sub    $0xc,%esp
8010409a:	ff 73 08             	pushl  0x8(%ebx)
8010409d:	e8 ae e7 ff ff       	call   80102850 <kfree>
    np->kstack = 0;
801040a2:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    return -1;
801040a9:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
801040ac:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
801040b3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801040b8:	eb c9                	jmp    80104083 <fork+0xe3>
801040ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801040c0 <changeProcessMHRRN>:
int changeProcessMHRRN(int pid, int priority) {
801040c0:	f3 0f 1e fb          	endbr32 
801040c4:	55                   	push   %ebp
801040c5:	89 e5                	mov    %esp,%ebp
801040c7:	53                   	push   %ebx
801040c8:	83 ec 10             	sub    $0x10,%esp
801040cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
801040ce:	68 80 3d 11 80       	push   $0x80113d80
801040d3:	e8 a8 0f 00 00       	call   80105080 <acquire>
801040d8:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801040db:	b8 b4 3d 11 80       	mov    $0x80113db4,%eax
801040e0:	eb 12                	jmp    801040f4 <changeProcessMHRRN+0x34>
801040e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801040e8:	05 54 01 00 00       	add    $0x154,%eax
801040ed:	3d b4 92 11 80       	cmp    $0x801192b4,%eax
801040f2:	74 2c                	je     80104120 <changeProcessMHRRN+0x60>
    if(p->pid == pid){
801040f4:	39 58 10             	cmp    %ebx,0x10(%eax)
801040f7:	75 ef                	jne    801040e8 <changeProcessMHRRN+0x28>
      p->HRRN_priority = priority;
801040f9:	8b 55 0c             	mov    0xc(%ebp),%edx
      release(&ptable.lock);
801040fc:	83 ec 0c             	sub    $0xc,%esp
      p->HRRN_priority = priority;
801040ff:	89 90 88 00 00 00    	mov    %edx,0x88(%eax)
      release(&ptable.lock);
80104105:	68 80 3d 11 80       	push   $0x80113d80
8010410a:	e8 31 10 00 00       	call   80105140 <release>
}
8010410f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
80104112:	83 c4 10             	add    $0x10,%esp
80104115:	31 c0                	xor    %eax,%eax
}
80104117:	c9                   	leave  
80104118:	c3                   	ret    
80104119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80104120:	83 ec 0c             	sub    $0xc,%esp
80104123:	68 80 3d 11 80       	push   $0x80113d80
80104128:	e8 13 10 00 00       	call   80105140 <release>
}
8010412d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80104130:	83 c4 10             	add    $0x10,%esp
80104133:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104138:	c9                   	leave  
80104139:	c3                   	ret    
8010413a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104140 <changeSystemMHRRN>:
int changeSystemMHRRN(int priority) {
80104140:	f3 0f 1e fb          	endbr32 
80104144:	55                   	push   %ebp
80104145:	89 e5                	mov    %esp,%ebp
80104147:	53                   	push   %ebx
80104148:	83 ec 10             	sub    $0x10,%esp
8010414b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010414e:	68 80 3d 11 80       	push   $0x80113d80
80104153:	e8 28 0f 00 00       	call   80105080 <acquire>
80104158:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010415b:	b8 b4 3d 11 80       	mov    $0x80113db4,%eax
    p->HRRN_priority = priority;
80104160:	89 98 88 00 00 00    	mov    %ebx,0x88(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104166:	05 54 01 00 00       	add    $0x154,%eax
8010416b:	3d b4 92 11 80       	cmp    $0x801192b4,%eax
80104170:	75 ee                	jne    80104160 <changeSystemMHRRN+0x20>
  release(&ptable.lock);
80104172:	83 ec 0c             	sub    $0xc,%esp
80104175:	68 80 3d 11 80       	push   $0x80113d80
8010417a:	e8 c1 0f 00 00       	call   80105140 <release>
}
8010417f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104182:	31 c0                	xor    %eax,%eax
80104184:	c9                   	leave  
80104185:	c3                   	ret    
80104186:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010418d:	8d 76 00             	lea    0x0(%esi),%esi

80104190 <printProcess>:
int printProcess(void) {
80104190:	f3 0f 1e fb          	endbr32 
80104194:	55                   	push   %ebp
80104195:	89 e5                	mov    %esp,%ebp
80104197:	56                   	push   %esi
80104198:	53                   	push   %ebx
80104199:	bb 20 3e 11 80       	mov    $0x80113e20,%ebx
  acquire(&ptable.lock);
8010419e:	83 ec 0c             	sub    $0xc,%esp
801041a1:	68 80 3d 11 80       	push   $0x80113d80
801041a6:	e8 d5 0e 00 00       	call   80105080 <acquire>
  cprintf("name\tpid\tstate\t\tqueue\tcycles\tarrival time\tHRRN\tMHRRN\n");
801041ab:	c7 04 24 2c 86 10 80 	movl   $0x8010862c,(%esp)
801041b2:	e8 f9 c4 ff ff       	call   801006b0 <cprintf>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041b7:	83 c4 10             	add    $0x10,%esp
801041ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(p->state == 0) continue;
801041c0:	8b 43 a0             	mov    -0x60(%ebx),%eax
801041c3:	85 c0                	test   %eax,%eax
801041c5:	0f 84 fa 00 00 00    	je     801042c5 <printProcess+0x135>
    cprintf("%s\t", p->name);
801041cb:	83 ec 08             	sub    $0x8,%esp
801041ce:	53                   	push   %ebx
801041cf:	68 1b 85 10 80       	push   $0x8010851b
801041d4:	e8 d7 c4 ff ff       	call   801006b0 <cprintf>
    cprintf("%d\t", p->pid);
801041d9:	59                   	pop    %ecx
801041da:	5e                   	pop    %esi
801041db:	ff 73 a4             	pushl  -0x5c(%ebx)
801041de:	68 1f 85 10 80       	push   $0x8010851f
801041e3:	e8 c8 c4 ff ff       	call   801006b0 <cprintf>
    switch (p->state)
801041e8:	83 c4 10             	add    $0x10,%esp
801041eb:	83 7b a0 05          	cmpl   $0x5,-0x60(%ebx)
801041ef:	77 27                	ja     80104218 <printProcess+0x88>
801041f1:	8b 43 a0             	mov    -0x60(%ebx),%eax
801041f4:	3e ff 24 85 64 86 10 	notrack jmp *-0x7fef799c(,%eax,4)
801041fb:	80 
801041fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        cprintf("%s\t\t", "RUNNING");
80104200:	83 ec 08             	sub    $0x8,%esp
80104203:	68 48 85 10 80       	push   $0x80108548
80104208:	68 2a 85 10 80       	push   $0x8010852a
8010420d:	e8 9e c4 ff ff       	call   801006b0 <cprintf>
        break;
80104212:	83 c4 10             	add    $0x10,%esp
80104215:	8d 76 00             	lea    0x0(%esi),%esi
    cprintf("%d\t", p->qnum);
80104218:	83 ec 08             	sub    $0x8,%esp
8010421b:	ff 73 10             	pushl  0x10(%ebx)
8010421e:	68 1f 85 10 80       	push   $0x8010851f
80104223:	e8 88 c4 ff ff       	call   801006b0 <cprintf>
    cprintf("%d\t", p->cycles);
80104228:	58                   	pop    %eax
80104229:	5a                   	pop    %edx
8010422a:	ff 73 18             	pushl  0x18(%ebx)
8010422d:	68 1f 85 10 80       	push   $0x8010851f
80104232:	e8 79 c4 ff ff       	call   801006b0 <cprintf>
    cprintf("%d\t\t", p->arrival_time);
80104237:	59                   	pop    %ecx
80104238:	5e                   	pop    %esi
80104239:	ff 73 14             	pushl  0x14(%ebx)
8010423c:	68 57 85 10 80       	push   $0x80108557
80104241:	e8 6a c4 ff ff       	call   801006b0 <cprintf>
  acquire(&tickslock);
80104246:	c7 04 24 c0 92 11 80 	movl   $0x801192c0,(%esp)
8010424d:	e8 2e 0e 00 00       	call   80105080 <acquire>
  ticks0 = ticks;
80104252:	8b 35 00 9b 11 80    	mov    0x80119b00,%esi
  release(&tickslock);
80104258:	c7 04 24 c0 92 11 80 	movl   $0x801192c0,(%esp)
8010425f:	e8 dc 0e 00 00       	call   80105140 <release>
    cprintf("%d\t", ((getTime() - p->arrival_time + p->cycles)/(p->cycles)));
80104264:	8b 4b 18             	mov    0x18(%ebx),%ecx
80104267:	58                   	pop    %eax
80104268:	89 f0                	mov    %esi,%eax
8010426a:	2b 43 14             	sub    0x14(%ebx),%eax
8010426d:	5a                   	pop    %edx
8010426e:	01 c8                	add    %ecx,%eax
80104270:	99                   	cltd   
80104271:	f7 f9                	idiv   %ecx
80104273:	50                   	push   %eax
80104274:	68 1f 85 10 80       	push   $0x8010851f
80104279:	e8 32 c4 ff ff       	call   801006b0 <cprintf>
  acquire(&tickslock);
8010427e:	c7 04 24 c0 92 11 80 	movl   $0x801192c0,(%esp)
80104285:	e8 f6 0d 00 00       	call   80105080 <acquire>
  ticks0 = ticks;
8010428a:	8b 35 00 9b 11 80    	mov    0x80119b00,%esi
  release(&tickslock);
80104290:	c7 04 24 c0 92 11 80 	movl   $0x801192c0,(%esp)
80104297:	e8 a4 0e 00 00       	call   80105140 <release>
    cprintf("%d\t", (((getTime() - p->arrival_time + p->cycles)/(p->cycles))+p->HRRN_priority)/2);
8010429c:	8b 4b 18             	mov    0x18(%ebx),%ecx
8010429f:	58                   	pop    %eax
801042a0:	89 f0                	mov    %esi,%eax
801042a2:	2b 43 14             	sub    0x14(%ebx),%eax
801042a5:	5a                   	pop    %edx
801042a6:	01 c8                	add    %ecx,%eax
801042a8:	99                   	cltd   
801042a9:	f7 f9                	idiv   %ecx
801042ab:	03 43 1c             	add    0x1c(%ebx),%eax
801042ae:	89 c2                	mov    %eax,%edx
801042b0:	c1 ea 1f             	shr    $0x1f,%edx
801042b3:	01 d0                	add    %edx,%eax
801042b5:	d1 f8                	sar    %eax
801042b7:	50                   	push   %eax
801042b8:	68 1f 85 10 80       	push   $0x8010851f
801042bd:	e8 ee c3 ff ff       	call   801006b0 <cprintf>
801042c2:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801042c5:	81 c3 54 01 00 00    	add    $0x154,%ebx
801042cb:	81 fb 20 93 11 80    	cmp    $0x80119320,%ebx
801042d1:	0f 85 e9 fe ff ff    	jne    801041c0 <printProcess+0x30>
  release(&ptable.lock);
801042d7:	83 ec 0c             	sub    $0xc,%esp
801042da:	68 80 3d 11 80       	push   $0x80113d80
801042df:	e8 5c 0e 00 00       	call   80105140 <release>
}
801042e4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801042e7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801042ec:	5b                   	pop    %ebx
801042ed:	5e                   	pop    %esi
801042ee:	5d                   	pop    %ebp
801042ef:	c3                   	ret    
        cprintf("%s\t", "RUNNABLE");
801042f0:	83 ec 08             	sub    $0x8,%esp
801042f3:	68 3f 85 10 80       	push   $0x8010853f
801042f8:	68 1b 85 10 80       	push   $0x8010851b
801042fd:	e8 ae c3 ff ff       	call   801006b0 <cprintf>
        break;
80104302:	83 c4 10             	add    $0x10,%esp
80104305:	e9 0e ff ff ff       	jmp    80104218 <printProcess+0x88>
8010430a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        cprintf("%s\t\t", "UNUSED");
80104310:	83 ec 08             	sub    $0x8,%esp
80104313:	68 23 85 10 80       	push   $0x80108523
80104318:	68 2a 85 10 80       	push   $0x8010852a
8010431d:	e8 8e c3 ff ff       	call   801006b0 <cprintf>
        break;
80104322:	83 c4 10             	add    $0x10,%esp
80104325:	e9 ee fe ff ff       	jmp    80104218 <printProcess+0x88>
8010432a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        cprintf("%s\t\t", "ZOMBIE");
80104330:	83 ec 08             	sub    $0x8,%esp
80104333:	68 50 85 10 80       	push   $0x80108550
80104338:	68 2a 85 10 80       	push   $0x8010852a
8010433d:	e8 6e c3 ff ff       	call   801006b0 <cprintf>
        break;
80104342:	83 c4 10             	add    $0x10,%esp
80104345:	e9 ce fe ff ff       	jmp    80104218 <printProcess+0x88>
8010434a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        cprintf("%s\t", "SLEEPING");
80104350:	83 ec 08             	sub    $0x8,%esp
80104353:	68 36 85 10 80       	push   $0x80108536
80104358:	68 1b 85 10 80       	push   $0x8010851b
8010435d:	e8 4e c3 ff ff       	call   801006b0 <cprintf>
        break;
80104362:	83 c4 10             	add    $0x10,%esp
80104365:	e9 ae fe ff ff       	jmp    80104218 <printProcess+0x88>
8010436a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        cprintf("%s\t\t", "EMBRYO");
80104370:	83 ec 08             	sub    $0x8,%esp
80104373:	68 2f 85 10 80       	push   $0x8010852f
80104378:	68 2a 85 10 80       	push   $0x8010852a
8010437d:	e8 2e c3 ff ff       	call   801006b0 <cprintf>
        break;
80104382:	83 c4 10             	add    $0x10,%esp
80104385:	e9 8e fe ff ff       	jmp    80104218 <printProcess+0x88>
8010438a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104390 <findProcess>:
struct proc* findProcess(int* flag) {
80104390:	f3 0f 1e fb          	endbr32 
80104394:	55                   	push   %ebp
80104395:	89 e5                	mov    %esp,%ebp
80104397:	57                   	push   %edi
80104398:	56                   	push   %esi
80104399:	53                   	push   %ebx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) 
8010439a:	bb b4 3d 11 80       	mov    $0x80113db4,%ebx
struct proc* findProcess(int* flag) {
8010439f:	83 ec 0c             	sub    $0xc,%esp
801043a2:	eb 12                	jmp    801043b6 <findProcess+0x26>
801043a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) 
801043a8:	81 c3 54 01 00 00    	add    $0x154,%ebx
801043ae:	81 fb b4 92 11 80    	cmp    $0x801192b4,%ebx
801043b4:	74 22                	je     801043d8 <findProcess+0x48>
    if(p->state == RUNNABLE && p->qnum == 1) {
801043b6:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
801043ba:	75 ec                	jne    801043a8 <findProcess+0x18>
801043bc:	83 7b 7c 01          	cmpl   $0x1,0x7c(%ebx)
801043c0:	75 e6                	jne    801043a8 <findProcess+0x18>
    *flag = 1;
801043c2:	8b 45 08             	mov    0x8(%ebp),%eax
801043c5:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
}
801043cb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801043ce:	89 d8                	mov    %ebx,%eax
801043d0:	5b                   	pop    %ebx
801043d1:	5e                   	pop    %esi
801043d2:	5f                   	pop    %edi
801043d3:	5d                   	pop    %ebp
801043d4:	c3                   	ret    
801043d5:	8d 76 00             	lea    0x0(%esi),%esi
  int max_arrival_time = -1;
801043d8:	be ff ff ff ff       	mov    $0xffffffff,%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801043dd:	b8 b4 3d 11 80       	mov    $0x80113db4,%eax
801043e2:	eb 10                	jmp    801043f4 <findProcess+0x64>
801043e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801043e8:	05 54 01 00 00       	add    $0x154,%eax
801043ed:	3d b4 92 11 80       	cmp    $0x801192b4,%eax
801043f2:	74 2c                	je     80104420 <findProcess+0x90>
    if(p->state == RUNNABLE && p->qnum == 2) 
801043f4:	83 78 0c 03          	cmpl   $0x3,0xc(%eax)
801043f8:	75 ee                	jne    801043e8 <findProcess+0x58>
801043fa:	83 78 7c 02          	cmpl   $0x2,0x7c(%eax)
801043fe:	75 e8                	jne    801043e8 <findProcess+0x58>
      if(p->arrival_time > max_arrival_time) {
80104400:	8b 90 80 00 00 00    	mov    0x80(%eax),%edx
80104406:	39 f2                	cmp    %esi,%edx
80104408:	7e de                	jle    801043e8 <findProcess+0x58>
8010440a:	89 c3                	mov    %eax,%ebx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010440c:	05 54 01 00 00       	add    $0x154,%eax
      if(p->arrival_time > max_arrival_time) {
80104411:	89 d6                	mov    %edx,%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104413:	3d b4 92 11 80       	cmp    $0x801192b4,%eax
80104418:	75 da                	jne    801043f4 <findProcess+0x64>
8010441a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(max_arrival_time != -1) {
80104420:	83 fe ff             	cmp    $0xffffffff,%esi
80104423:	75 9d                	jne    801043c2 <findProcess+0x32>
  acquire(&tickslock);
80104425:	83 ec 0c             	sub    $0xc,%esp
80104428:	68 c0 92 11 80       	push   $0x801192c0
8010442d:	e8 4e 0c 00 00       	call   80105080 <acquire>
  release(&tickslock);
80104432:	c7 04 24 c0 92 11 80 	movl   $0x801192c0,(%esp)
  ticks0 = ticks;
80104439:	8b 3d 00 9b 11 80    	mov    0x80119b00,%edi
  release(&tickslock);
8010443f:	e8 fc 0c 00 00       	call   80105140 <release>
  return ticks0;
80104444:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104447:	b9 b4 3d 11 80       	mov    $0x80113db4,%ecx
8010444c:	eb 10                	jmp    8010445e <findProcess+0xce>
8010444e:	66 90                	xchg   %ax,%ax
80104450:	81 c1 54 01 00 00    	add    $0x154,%ecx
80104456:	81 f9 b4 92 11 80    	cmp    $0x801192b4,%ecx
8010445c:	74 46                	je     801044a4 <findProcess+0x114>
    if(p->state == RUNNABLE && p->qnum == 3) {
8010445e:	83 79 0c 03          	cmpl   $0x3,0xc(%ecx)
80104462:	75 ec                	jne    80104450 <findProcess+0xc0>
80104464:	83 79 7c 03          	cmpl   $0x3,0x7c(%ecx)
80104468:	75 e6                	jne    80104450 <findProcess+0xc0>
      int MHRRN = (((curr_time - p->arrival_time + p->cycles)/(p->cycles))+p->HRRN_priority)/2;
8010446a:	89 f8                	mov    %edi,%eax
8010446c:	2b 81 80 00 00 00    	sub    0x80(%ecx),%eax
80104472:	03 81 84 00 00 00    	add    0x84(%ecx),%eax
80104478:	99                   	cltd   
80104479:	f7 b9 84 00 00 00    	idivl  0x84(%ecx)
8010447f:	03 81 88 00 00 00    	add    0x88(%ecx),%eax
80104485:	89 c2                	mov    %eax,%edx
80104487:	c1 e8 1f             	shr    $0x1f,%eax
8010448a:	01 d0                	add    %edx,%eax
8010448c:	d1 f8                	sar    %eax
      if(MHRRN > max_MHRRN) {
8010448e:	39 f0                	cmp    %esi,%eax
80104490:	7e be                	jle    80104450 <findProcess+0xc0>
80104492:	89 cb                	mov    %ecx,%ebx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104494:	81 c1 54 01 00 00    	add    $0x154,%ecx
      if(MHRRN > max_MHRRN) {
8010449a:	89 c6                	mov    %eax,%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010449c:	81 f9 b4 92 11 80    	cmp    $0x801192b4,%ecx
801044a2:	75 ba                	jne    8010445e <findProcess+0xce>
    *flag = 1;
801044a4:	8b 45 08             	mov    0x8(%ebp),%eax
  if(max_MHRRN != -1) {
801044a7:	83 fe ff             	cmp    $0xffffffff,%esi
801044aa:	74 0b                	je     801044b7 <findProcess+0x127>
    *flag = 1;
801044ac:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
    return last_p;
801044b2:	e9 14 ff ff ff       	jmp    801043cb <findProcess+0x3b>
  *flag = 0;
801044b7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801044bd:	bb b4 92 11 80       	mov    $0x801192b4,%ebx
  return p;
801044c2:	e9 04 ff ff ff       	jmp    801043cb <findProcess+0x3b>
801044c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801044ce:	66 90                	xchg   %ax,%ax

801044d0 <scheduler>:
{
801044d0:	f3 0f 1e fb          	endbr32 
801044d4:	55                   	push   %ebp
801044d5:	89 e5                	mov    %esp,%ebp
801044d7:	57                   	push   %edi
801044d8:	56                   	push   %esi
801044d9:	8d 7d e4             	lea    -0x1c(%ebp),%edi
801044dc:	53                   	push   %ebx
801044dd:	83 ec 2c             	sub    $0x2c,%esp
  struct cpu *c = mycpu();
801044e0:	e8 4b f8 ff ff       	call   80103d30 <mycpu>
  c->proc = 0;
801044e5:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
801044ec:	00 00 00 
  struct cpu *c = mycpu();
801044ef:	89 c3                	mov    %eax,%ebx
  c->proc = 0;
801044f1:	8d 40 04             	lea    0x4(%eax),%eax
801044f4:	89 45 d4             	mov    %eax,-0x2c(%ebp)
801044f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801044fe:	66 90                	xchg   %ax,%ax
  asm volatile("sti");
80104500:	fb                   	sti    
    acquire(&ptable.lock);
80104501:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104504:	be b4 3d 11 80       	mov    $0x80113db4,%esi
    acquire(&ptable.lock);
80104509:	68 80 3d 11 80       	push   $0x80113d80
8010450e:	e8 6d 0b 00 00       	call   80105080 <acquire>
80104513:	83 c4 10             	add    $0x10,%esp
      if(p->state != RUNNABLE)
80104516:	83 7e 0c 03          	cmpl   $0x3,0xc(%esi)
8010451a:	75 57                	jne    80104573 <scheduler+0xa3>
      p = findProcess(&flag);
8010451c:	83 ec 0c             	sub    $0xc,%esp
      int flag = 0;
8010451f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
      p = findProcess(&flag);
80104526:	57                   	push   %edi
80104527:	e8 64 fe ff ff       	call   80104390 <findProcess>
      c->proc = p;
8010452c:	89 83 ac 00 00 00    	mov    %eax,0xac(%ebx)
      p = findProcess(&flag);
80104532:	89 c6                	mov    %eax,%esi
      switchuvm(p);
80104534:	89 04 24             	mov    %eax,(%esp)
80104537:	e8 04 33 00 00       	call   80107840 <switchuvm>
      p->cycles++;
8010453c:	83 86 84 00 00 00 01 	addl   $0x1,0x84(%esi)
      p->state = RUNNING;
80104543:	c7 46 0c 04 00 00 00 	movl   $0x4,0xc(%esi)
      p->wait_cycles = 0;
8010454a:	c7 86 8c 00 00 00 00 	movl   $0x0,0x8c(%esi)
80104551:	00 00 00 
      swtch(&(c->scheduler), p->context);
80104554:	58                   	pop    %eax
80104555:	5a                   	pop    %edx
80104556:	ff 76 1c             	pushl  0x1c(%esi)
80104559:	ff 75 d4             	pushl  -0x2c(%ebp)
8010455c:	e8 52 0e 00 00       	call   801053b3 <swtch>
      switchkvm();
80104561:	e8 ba 32 00 00       	call   80107820 <switchkvm>
      c->proc = 0;
80104566:	83 c4 10             	add    $0x10,%esp
80104569:	c7 83 ac 00 00 00 00 	movl   $0x0,0xac(%ebx)
80104570:	00 00 00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104573:	81 c6 54 01 00 00    	add    $0x154,%esi
80104579:	81 fe b4 92 11 80    	cmp    $0x801192b4,%esi
8010457f:	72 95                	jb     80104516 <scheduler+0x46>
    release(&ptable.lock);
80104581:	83 ec 0c             	sub    $0xc,%esp
80104584:	68 80 3d 11 80       	push   $0x80113d80
80104589:	e8 b2 0b 00 00       	call   80105140 <release>
    sti();
8010458e:	83 c4 10             	add    $0x10,%esp
80104591:	e9 6a ff ff ff       	jmp    80104500 <scheduler+0x30>
80104596:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010459d:	8d 76 00             	lea    0x0(%esi),%esi

801045a0 <sched>:
{
801045a0:	f3 0f 1e fb          	endbr32 
801045a4:	55                   	push   %ebp
801045a5:	89 e5                	mov    %esp,%ebp
801045a7:	56                   	push   %esi
801045a8:	53                   	push   %ebx
  pushcli();
801045a9:	e8 d2 09 00 00       	call   80104f80 <pushcli>
  c = mycpu();
801045ae:	e8 7d f7 ff ff       	call   80103d30 <mycpu>
  p = c->proc;
801045b3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801045b9:	e8 12 0a 00 00       	call   80104fd0 <popcli>
  if(!holding(&ptable.lock))
801045be:	83 ec 0c             	sub    $0xc,%esp
801045c1:	68 80 3d 11 80       	push   $0x80113d80
801045c6:	e8 65 0a 00 00       	call   80105030 <holding>
801045cb:	83 c4 10             	add    $0x10,%esp
801045ce:	85 c0                	test   %eax,%eax
801045d0:	74 4f                	je     80104621 <sched+0x81>
  if(mycpu()->ncli != 1)
801045d2:	e8 59 f7 ff ff       	call   80103d30 <mycpu>
801045d7:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
801045de:	75 68                	jne    80104648 <sched+0xa8>
  if(p->state == RUNNING)
801045e0:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
801045e4:	74 55                	je     8010463b <sched+0x9b>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801045e6:	9c                   	pushf  
801045e7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801045e8:	f6 c4 02             	test   $0x2,%ah
801045eb:	75 41                	jne    8010462e <sched+0x8e>
  intena = mycpu()->intena;
801045ed:	e8 3e f7 ff ff       	call   80103d30 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
801045f2:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
801045f5:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
801045fb:	e8 30 f7 ff ff       	call   80103d30 <mycpu>
80104600:	83 ec 08             	sub    $0x8,%esp
80104603:	ff 70 04             	pushl  0x4(%eax)
80104606:	53                   	push   %ebx
80104607:	e8 a7 0d 00 00       	call   801053b3 <swtch>
  mycpu()->intena = intena;
8010460c:	e8 1f f7 ff ff       	call   80103d30 <mycpu>
}
80104611:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80104614:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
8010461a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010461d:	5b                   	pop    %ebx
8010461e:	5e                   	pop    %esi
8010461f:	5d                   	pop    %ebp
80104620:	c3                   	ret    
    panic("sched ptable.lock");
80104621:	83 ec 0c             	sub    $0xc,%esp
80104624:	68 5c 85 10 80       	push   $0x8010855c
80104629:	e8 62 bd ff ff       	call   80100390 <panic>
    panic("sched interruptible");
8010462e:	83 ec 0c             	sub    $0xc,%esp
80104631:	68 88 85 10 80       	push   $0x80108588
80104636:	e8 55 bd ff ff       	call   80100390 <panic>
    panic("sched running");
8010463b:	83 ec 0c             	sub    $0xc,%esp
8010463e:	68 7a 85 10 80       	push   $0x8010857a
80104643:	e8 48 bd ff ff       	call   80100390 <panic>
    panic("sched locks");
80104648:	83 ec 0c             	sub    $0xc,%esp
8010464b:	68 6e 85 10 80       	push   $0x8010856e
80104650:	e8 3b bd ff ff       	call   80100390 <panic>
80104655:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010465c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104660 <exit>:
{
80104660:	f3 0f 1e fb          	endbr32 
80104664:	55                   	push   %ebp
80104665:	89 e5                	mov    %esp,%ebp
80104667:	57                   	push   %edi
80104668:	56                   	push   %esi
80104669:	53                   	push   %ebx
8010466a:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
8010466d:	e8 0e 09 00 00       	call   80104f80 <pushcli>
  c = mycpu();
80104672:	e8 b9 f6 ff ff       	call   80103d30 <mycpu>
  p = c->proc;
80104677:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
8010467d:	e8 4e 09 00 00       	call   80104fd0 <popcli>
  if(curproc == initproc)
80104682:	8d 5e 28             	lea    0x28(%esi),%ebx
80104685:	8d 7e 68             	lea    0x68(%esi),%edi
80104688:	39 35 e0 b5 10 80    	cmp    %esi,0x8010b5e0
8010468e:	0f 84 fd 00 00 00    	je     80104791 <exit+0x131>
80104694:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd]){
80104698:	8b 03                	mov    (%ebx),%eax
8010469a:	85 c0                	test   %eax,%eax
8010469c:	74 12                	je     801046b0 <exit+0x50>
      fileclose(curproc->ofile[fd]);
8010469e:	83 ec 0c             	sub    $0xc,%esp
801046a1:	50                   	push   %eax
801046a2:	e8 f9 cb ff ff       	call   801012a0 <fileclose>
      curproc->ofile[fd] = 0;
801046a7:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801046ad:	83 c4 10             	add    $0x10,%esp
  for(fd = 0; fd < NOFILE; fd++){
801046b0:	83 c3 04             	add    $0x4,%ebx
801046b3:	39 df                	cmp    %ebx,%edi
801046b5:	75 e1                	jne    80104698 <exit+0x38>
  begin_op();
801046b7:	e8 74 ea ff ff       	call   80103130 <begin_op>
  iput(curproc->cwd);
801046bc:	83 ec 0c             	sub    $0xc,%esp
801046bf:	ff 76 68             	pushl  0x68(%esi)
801046c2:	e8 a9 d5 ff ff       	call   80101c70 <iput>
  end_op();
801046c7:	e8 d4 ea ff ff       	call   801031a0 <end_op>
  curproc->cwd = 0;
801046cc:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
  acquire(&ptable.lock);
801046d3:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
801046da:	e8 a1 09 00 00       	call   80105080 <acquire>
  wakeup1(curproc->parent);
801046df:	8b 56 14             	mov    0x14(%esi),%edx
801046e2:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801046e5:	b8 b4 3d 11 80       	mov    $0x80113db4,%eax
801046ea:	eb 10                	jmp    801046fc <exit+0x9c>
801046ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801046f0:	05 54 01 00 00       	add    $0x154,%eax
801046f5:	3d b4 92 11 80       	cmp    $0x801192b4,%eax
801046fa:	74 1e                	je     8010471a <exit+0xba>
    if(p->state == SLEEPING && p->chan == chan)
801046fc:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104700:	75 ee                	jne    801046f0 <exit+0x90>
80104702:	3b 50 20             	cmp    0x20(%eax),%edx
80104705:	75 e9                	jne    801046f0 <exit+0x90>
      p->state = RUNNABLE;
80104707:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010470e:	05 54 01 00 00       	add    $0x154,%eax
80104713:	3d b4 92 11 80       	cmp    $0x801192b4,%eax
80104718:	75 e2                	jne    801046fc <exit+0x9c>
      p->parent = initproc;
8010471a:	8b 0d e0 b5 10 80    	mov    0x8010b5e0,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104720:	ba b4 3d 11 80       	mov    $0x80113db4,%edx
80104725:	eb 17                	jmp    8010473e <exit+0xde>
80104727:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010472e:	66 90                	xchg   %ax,%ax
80104730:	81 c2 54 01 00 00    	add    $0x154,%edx
80104736:	81 fa b4 92 11 80    	cmp    $0x801192b4,%edx
8010473c:	74 3a                	je     80104778 <exit+0x118>
    if(p->parent == curproc){
8010473e:	39 72 14             	cmp    %esi,0x14(%edx)
80104741:	75 ed                	jne    80104730 <exit+0xd0>
      if(p->state == ZOMBIE)
80104743:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80104747:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
8010474a:	75 e4                	jne    80104730 <exit+0xd0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010474c:	b8 b4 3d 11 80       	mov    $0x80113db4,%eax
80104751:	eb 11                	jmp    80104764 <exit+0x104>
80104753:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104757:	90                   	nop
80104758:	05 54 01 00 00       	add    $0x154,%eax
8010475d:	3d b4 92 11 80       	cmp    $0x801192b4,%eax
80104762:	74 cc                	je     80104730 <exit+0xd0>
    if(p->state == SLEEPING && p->chan == chan)
80104764:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104768:	75 ee                	jne    80104758 <exit+0xf8>
8010476a:	3b 48 20             	cmp    0x20(%eax),%ecx
8010476d:	75 e9                	jne    80104758 <exit+0xf8>
      p->state = RUNNABLE;
8010476f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80104776:	eb e0                	jmp    80104758 <exit+0xf8>
  curproc->state = ZOMBIE;
80104778:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
8010477f:	e8 1c fe ff ff       	call   801045a0 <sched>
  panic("zombie exit");
80104784:	83 ec 0c             	sub    $0xc,%esp
80104787:	68 a9 85 10 80       	push   $0x801085a9
8010478c:	e8 ff bb ff ff       	call   80100390 <panic>
    panic("init exiting");
80104791:	83 ec 0c             	sub    $0xc,%esp
80104794:	68 9c 85 10 80       	push   $0x8010859c
80104799:	e8 f2 bb ff ff       	call   80100390 <panic>
8010479e:	66 90                	xchg   %ax,%ax

801047a0 <yield>:
{
801047a0:	f3 0f 1e fb          	endbr32 
801047a4:	55                   	push   %ebp
801047a5:	89 e5                	mov    %esp,%ebp
801047a7:	53                   	push   %ebx
801047a8:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
801047ab:	68 80 3d 11 80       	push   $0x80113d80
801047b0:	e8 cb 08 00 00       	call   80105080 <acquire>
  pushcli();
801047b5:	e8 c6 07 00 00       	call   80104f80 <pushcli>
  c = mycpu();
801047ba:	e8 71 f5 ff ff       	call   80103d30 <mycpu>
  p = c->proc;
801047bf:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801047c5:	e8 06 08 00 00       	call   80104fd0 <popcli>
  myproc()->state = RUNNABLE;
801047ca:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
801047d1:	e8 ca fd ff ff       	call   801045a0 <sched>
  release(&ptable.lock);
801047d6:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
801047dd:	e8 5e 09 00 00       	call   80105140 <release>
}
801047e2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801047e5:	83 c4 10             	add    $0x10,%esp
801047e8:	c9                   	leave  
801047e9:	c3                   	ret    
801047ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801047f0 <sem_sleep>:
{
801047f0:	f3 0f 1e fb          	endbr32 
801047f4:	55                   	push   %ebp
801047f5:	89 e5                	mov    %esp,%ebp
801047f7:	53                   	push   %ebx
801047f8:	83 ec 10             	sub    $0x10,%esp
801047fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock); 
801047fe:	68 80 3d 11 80       	push   $0x80113d80
80104803:	e8 78 08 00 00       	call   80105080 <acquire>
  p1->state = SLEEPING;
80104808:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
8010480f:	e8 8c fd ff ff       	call   801045a0 <sched>
  release(&ptable.lock);
80104814:	c7 45 08 80 3d 11 80 	movl   $0x80113d80,0x8(%ebp)
}
8010481b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&ptable.lock);
8010481e:	83 c4 10             	add    $0x10,%esp
}
80104821:	c9                   	leave  
  release(&ptable.lock);
80104822:	e9 19 09 00 00       	jmp    80105140 <release>
80104827:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010482e:	66 90                	xchg   %ax,%ax

80104830 <sem_wakeup>:
{
80104830:	f3 0f 1e fb          	endbr32 
80104834:	55                   	push   %ebp
80104835:	89 e5                	mov    %esp,%ebp
80104837:	53                   	push   %ebx
80104838:	83 ec 10             	sub    $0x10,%esp
8010483b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010483e:	68 80 3d 11 80       	push   $0x80113d80
80104843:	e8 38 08 00 00       	call   80105080 <acquire>
  p1->state = RUNNABLE;
80104848:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
8010484f:	83 c4 10             	add    $0x10,%esp
}
80104852:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&ptable.lock);
80104855:	c7 45 08 80 3d 11 80 	movl   $0x80113d80,0x8(%ebp)
}
8010485c:	c9                   	leave  
  release(&ptable.lock);
8010485d:	e9 de 08 00 00       	jmp    80105140 <release>
80104862:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104869:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104870 <sem_init>:
{
80104870:	f3 0f 1e fb          	endbr32 
80104874:	55                   	push   %ebp
80104875:	89 e5                	mov    %esp,%ebp
80104877:	8b 45 08             	mov    0x8(%ebp),%eax
  sems[i]->value = v;
8010487a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010487d:	8b 14 85 60 3d 11 80 	mov    -0x7feec2a0(,%eax,4),%edx
80104884:	89 0a                	mov    %ecx,(%edx)
  sems[i]->last = 0;
80104886:	8b 04 85 60 3d 11 80 	mov    -0x7feec2a0(,%eax,4),%eax
8010488d:	c7 80 94 01 00 00 00 	movl   $0x0,0x194(%eax)
80104894:	00 00 00 
}
80104897:	31 c0                	xor    %eax,%eax
80104899:	5d                   	pop    %ebp
8010489a:	c3                   	ret    
8010489b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010489f:	90                   	nop

801048a0 <sem_acquire>:
{
801048a0:	f3 0f 1e fb          	endbr32 
801048a4:	55                   	push   %ebp
801048a5:	89 e5                	mov    %esp,%ebp
801048a7:	56                   	push   %esi
801048a8:	53                   	push   %ebx
801048a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  sems[i]->value--;
801048ac:	8b 04 9d 60 3d 11 80 	mov    -0x7feec2a0(,%ebx,4),%eax
801048b3:	83 28 01             	subl   $0x1,(%eax)
  if(sems[i]->value < 0)
801048b6:	8b 04 9d 60 3d 11 80 	mov    -0x7feec2a0(,%ebx,4),%eax
801048bd:	8b 00                	mov    (%eax),%eax
801048bf:	85 c0                	test   %eax,%eax
801048c1:	78 0d                	js     801048d0 <sem_acquire+0x30>
}
801048c3:	8d 65 f8             	lea    -0x8(%ebp),%esp
801048c6:	31 c0                	xor    %eax,%eax
801048c8:	5b                   	pop    %ebx
801048c9:	5e                   	pop    %esi
801048ca:	5d                   	pop    %ebp
801048cb:	c3                   	ret    
801048cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  pushcli();
801048d0:	e8 ab 06 00 00       	call   80104f80 <pushcli>
  c = mycpu();
801048d5:	e8 56 f4 ff ff       	call   80103d30 <mycpu>
  p = c->proc;
801048da:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801048e0:	e8 eb 06 00 00       	call   80104fd0 <popcli>
    sems[i]->list[sems[i]->last ++] = p;
801048e5:	8b 04 9d 60 3d 11 80 	mov    -0x7feec2a0(,%ebx,4),%eax
    sem_sleep(p);
801048ec:	83 ec 0c             	sub    $0xc,%esp
    sems[i]->list[sems[i]->last ++] = p;
801048ef:	8b 90 94 01 00 00    	mov    0x194(%eax),%edx
801048f5:	8d 4a 01             	lea    0x1(%edx),%ecx
801048f8:	89 88 94 01 00 00    	mov    %ecx,0x194(%eax)
801048fe:	89 74 90 04          	mov    %esi,0x4(%eax,%edx,4)
    sem_sleep(p);
80104902:	56                   	push   %esi
80104903:	e8 e8 fe ff ff       	call   801047f0 <sem_sleep>
80104908:	83 c4 10             	add    $0x10,%esp
}
8010490b:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010490e:	31 c0                	xor    %eax,%eax
80104910:	5b                   	pop    %ebx
80104911:	5e                   	pop    %esi
80104912:	5d                   	pop    %ebp
80104913:	c3                   	ret    
80104914:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010491b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010491f:	90                   	nop

80104920 <sem_release>:
{
80104920:	f3 0f 1e fb          	endbr32 
80104924:	55                   	push   %ebp
80104925:	89 e5                	mov    %esp,%ebp
80104927:	53                   	push   %ebx
80104928:	83 ec 04             	sub    $0x4,%esp
8010492b:	8b 45 08             	mov    0x8(%ebp),%eax
  sems[i]->value++;
8010492e:	8b 14 85 60 3d 11 80 	mov    -0x7feec2a0(,%eax,4),%edx
80104935:	83 02 01             	addl   $0x1,(%edx)
  if(sems[i]->value <= 0)
80104938:	8b 04 85 60 3d 11 80 	mov    -0x7feec2a0(,%eax,4),%eax
8010493f:	8b 10                	mov    (%eax),%edx
80104941:	85 d2                	test   %edx,%edx
80104943:	7e 0b                	jle    80104950 <sem_release+0x30>
}
80104945:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104948:	31 c0                	xor    %eax,%eax
8010494a:	c9                   	leave  
8010494b:	c3                   	ret    
8010494c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    struct proc* p = sems[i]->list[sems[i]->last --];
80104950:	8b 90 94 01 00 00    	mov    0x194(%eax),%edx
  acquire(&ptable.lock);
80104956:	83 ec 0c             	sub    $0xc,%esp
    struct proc* p = sems[i]->list[sems[i]->last --];
80104959:	8d 4a ff             	lea    -0x1(%edx),%ecx
8010495c:	89 88 94 01 00 00    	mov    %ecx,0x194(%eax)
80104962:	8b 5c 90 04          	mov    0x4(%eax,%edx,4),%ebx
  acquire(&ptable.lock);
80104966:	68 80 3d 11 80       	push   $0x80113d80
8010496b:	e8 10 07 00 00       	call   80105080 <acquire>
  p1->state = RUNNABLE;
80104970:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80104977:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
8010497e:	e8 bd 07 00 00       	call   80105140 <release>
}
80104983:	8b 5d fc             	mov    -0x4(%ebp),%ebx
}
80104986:	83 c4 10             	add    $0x10,%esp
}
80104989:	31 c0                	xor    %eax,%eax
8010498b:	c9                   	leave  
8010498c:	c3                   	ret    
8010498d:	8d 76 00             	lea    0x0(%esi),%esi

80104990 <sleep>:
{
80104990:	f3 0f 1e fb          	endbr32 
80104994:	55                   	push   %ebp
80104995:	89 e5                	mov    %esp,%ebp
80104997:	57                   	push   %edi
80104998:	56                   	push   %esi
80104999:	53                   	push   %ebx
8010499a:	83 ec 0c             	sub    $0xc,%esp
8010499d:	8b 7d 08             	mov    0x8(%ebp),%edi
801049a0:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
801049a3:	e8 d8 05 00 00       	call   80104f80 <pushcli>
  c = mycpu();
801049a8:	e8 83 f3 ff ff       	call   80103d30 <mycpu>
  p = c->proc;
801049ad:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801049b3:	e8 18 06 00 00       	call   80104fd0 <popcli>
  if(p == 0)
801049b8:	85 db                	test   %ebx,%ebx
801049ba:	0f 84 83 00 00 00    	je     80104a43 <sleep+0xb3>
  if(lk == 0)
801049c0:	85 f6                	test   %esi,%esi
801049c2:	74 72                	je     80104a36 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
801049c4:	81 fe 80 3d 11 80    	cmp    $0x80113d80,%esi
801049ca:	74 4c                	je     80104a18 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
801049cc:	83 ec 0c             	sub    $0xc,%esp
801049cf:	68 80 3d 11 80       	push   $0x80113d80
801049d4:	e8 a7 06 00 00       	call   80105080 <acquire>
    release(lk);
801049d9:	89 34 24             	mov    %esi,(%esp)
801049dc:	e8 5f 07 00 00       	call   80105140 <release>
  p->chan = chan;
801049e1:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801049e4:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801049eb:	e8 b0 fb ff ff       	call   801045a0 <sched>
  p->chan = 0;
801049f0:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
801049f7:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
801049fe:	e8 3d 07 00 00       	call   80105140 <release>
    acquire(lk);
80104a03:	89 75 08             	mov    %esi,0x8(%ebp)
80104a06:	83 c4 10             	add    $0x10,%esp
}
80104a09:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104a0c:	5b                   	pop    %ebx
80104a0d:	5e                   	pop    %esi
80104a0e:	5f                   	pop    %edi
80104a0f:	5d                   	pop    %ebp
    acquire(lk);
80104a10:	e9 6b 06 00 00       	jmp    80105080 <acquire>
80104a15:	8d 76 00             	lea    0x0(%esi),%esi
  p->chan = chan;
80104a18:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104a1b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104a22:	e8 79 fb ff ff       	call   801045a0 <sched>
  p->chan = 0;
80104a27:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80104a2e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104a31:	5b                   	pop    %ebx
80104a32:	5e                   	pop    %esi
80104a33:	5f                   	pop    %edi
80104a34:	5d                   	pop    %ebp
80104a35:	c3                   	ret    
    panic("sleep without lk");
80104a36:	83 ec 0c             	sub    $0xc,%esp
80104a39:	68 bb 85 10 80       	push   $0x801085bb
80104a3e:	e8 4d b9 ff ff       	call   80100390 <panic>
    panic("sleep");
80104a43:	83 ec 0c             	sub    $0xc,%esp
80104a46:	68 b5 85 10 80       	push   $0x801085b5
80104a4b:	e8 40 b9 ff ff       	call   80100390 <panic>

80104a50 <wait>:
{
80104a50:	f3 0f 1e fb          	endbr32 
80104a54:	55                   	push   %ebp
80104a55:	89 e5                	mov    %esp,%ebp
80104a57:	56                   	push   %esi
80104a58:	53                   	push   %ebx
  pushcli();
80104a59:	e8 22 05 00 00       	call   80104f80 <pushcli>
  c = mycpu();
80104a5e:	e8 cd f2 ff ff       	call   80103d30 <mycpu>
  p = c->proc;
80104a63:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104a69:	e8 62 05 00 00       	call   80104fd0 <popcli>
  acquire(&ptable.lock);
80104a6e:	83 ec 0c             	sub    $0xc,%esp
80104a71:	68 80 3d 11 80       	push   $0x80113d80
80104a76:	e8 05 06 00 00       	call   80105080 <acquire>
80104a7b:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80104a7e:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a80:	bb b4 3d 11 80       	mov    $0x80113db4,%ebx
80104a85:	eb 17                	jmp    80104a9e <wait+0x4e>
80104a87:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a8e:	66 90                	xchg   %ax,%ax
80104a90:	81 c3 54 01 00 00    	add    $0x154,%ebx
80104a96:	81 fb b4 92 11 80    	cmp    $0x801192b4,%ebx
80104a9c:	74 1e                	je     80104abc <wait+0x6c>
      if(p->parent != curproc)
80104a9e:	39 73 14             	cmp    %esi,0x14(%ebx)
80104aa1:	75 ed                	jne    80104a90 <wait+0x40>
      if(p->state == ZOMBIE){
80104aa3:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80104aa7:	74 37                	je     80104ae0 <wait+0x90>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104aa9:	81 c3 54 01 00 00    	add    $0x154,%ebx
      havekids = 1;
80104aaf:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104ab4:	81 fb b4 92 11 80    	cmp    $0x801192b4,%ebx
80104aba:	75 e2                	jne    80104a9e <wait+0x4e>
    if(!havekids || curproc->killed){
80104abc:	85 c0                	test   %eax,%eax
80104abe:	74 76                	je     80104b36 <wait+0xe6>
80104ac0:	8b 46 24             	mov    0x24(%esi),%eax
80104ac3:	85 c0                	test   %eax,%eax
80104ac5:	75 6f                	jne    80104b36 <wait+0xe6>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80104ac7:	83 ec 08             	sub    $0x8,%esp
80104aca:	68 80 3d 11 80       	push   $0x80113d80
80104acf:	56                   	push   %esi
80104ad0:	e8 bb fe ff ff       	call   80104990 <sleep>
    havekids = 0;
80104ad5:	83 c4 10             	add    $0x10,%esp
80104ad8:	eb a4                	jmp    80104a7e <wait+0x2e>
80104ada:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        kfree(p->kstack);
80104ae0:	83 ec 0c             	sub    $0xc,%esp
80104ae3:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
80104ae6:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104ae9:	e8 62 dd ff ff       	call   80102850 <kfree>
        freevm(p->pgdir);
80104aee:	5a                   	pop    %edx
80104aef:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
80104af2:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104af9:	e8 12 31 00 00       	call   80107c10 <freevm>
        release(&ptable.lock);
80104afe:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
        p->pid = 0;
80104b05:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104b0c:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80104b13:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80104b17:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80104b1e:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80104b25:	e8 16 06 00 00       	call   80105140 <release>
        return pid;
80104b2a:	83 c4 10             	add    $0x10,%esp
}
80104b2d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104b30:	89 f0                	mov    %esi,%eax
80104b32:	5b                   	pop    %ebx
80104b33:	5e                   	pop    %esi
80104b34:	5d                   	pop    %ebp
80104b35:	c3                   	ret    
      release(&ptable.lock);
80104b36:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104b39:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80104b3e:	68 80 3d 11 80       	push   $0x80113d80
80104b43:	e8 f8 05 00 00       	call   80105140 <release>
      return -1;
80104b48:	83 c4 10             	add    $0x10,%esp
80104b4b:	eb e0                	jmp    80104b2d <wait+0xdd>
80104b4d:	8d 76 00             	lea    0x0(%esi),%esi

80104b50 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104b50:	f3 0f 1e fb          	endbr32 
80104b54:	55                   	push   %ebp
80104b55:	89 e5                	mov    %esp,%ebp
80104b57:	53                   	push   %ebx
80104b58:	83 ec 10             	sub    $0x10,%esp
80104b5b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
80104b5e:	68 80 3d 11 80       	push   $0x80113d80
80104b63:	e8 18 05 00 00       	call   80105080 <acquire>
80104b68:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104b6b:	b8 b4 3d 11 80       	mov    $0x80113db4,%eax
80104b70:	eb 12                	jmp    80104b84 <wakeup+0x34>
80104b72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104b78:	05 54 01 00 00       	add    $0x154,%eax
80104b7d:	3d b4 92 11 80       	cmp    $0x801192b4,%eax
80104b82:	74 1e                	je     80104ba2 <wakeup+0x52>
    if(p->state == SLEEPING && p->chan == chan)
80104b84:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104b88:	75 ee                	jne    80104b78 <wakeup+0x28>
80104b8a:	3b 58 20             	cmp    0x20(%eax),%ebx
80104b8d:	75 e9                	jne    80104b78 <wakeup+0x28>
      p->state = RUNNABLE;
80104b8f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104b96:	05 54 01 00 00       	add    $0x154,%eax
80104b9b:	3d b4 92 11 80       	cmp    $0x801192b4,%eax
80104ba0:	75 e2                	jne    80104b84 <wakeup+0x34>
  wakeup1(chan);
  release(&ptable.lock);
80104ba2:	c7 45 08 80 3d 11 80 	movl   $0x80113d80,0x8(%ebp)
}
80104ba9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104bac:	c9                   	leave  
  release(&ptable.lock);
80104bad:	e9 8e 05 00 00       	jmp    80105140 <release>
80104bb2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104bb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104bc0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104bc0:	f3 0f 1e fb          	endbr32 
80104bc4:	55                   	push   %ebp
80104bc5:	89 e5                	mov    %esp,%ebp
80104bc7:	53                   	push   %ebx
80104bc8:	83 ec 10             	sub    $0x10,%esp
80104bcb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
80104bce:	68 80 3d 11 80       	push   $0x80113d80
80104bd3:	e8 a8 04 00 00       	call   80105080 <acquire>
80104bd8:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104bdb:	b8 b4 3d 11 80       	mov    $0x80113db4,%eax
80104be0:	eb 12                	jmp    80104bf4 <kill+0x34>
80104be2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104be8:	05 54 01 00 00       	add    $0x154,%eax
80104bed:	3d b4 92 11 80       	cmp    $0x801192b4,%eax
80104bf2:	74 34                	je     80104c28 <kill+0x68>
    if(p->pid == pid){
80104bf4:	39 58 10             	cmp    %ebx,0x10(%eax)
80104bf7:	75 ef                	jne    80104be8 <kill+0x28>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104bf9:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104bfd:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
80104c04:	75 07                	jne    80104c0d <kill+0x4d>
        p->state = RUNNABLE;
80104c06:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104c0d:	83 ec 0c             	sub    $0xc,%esp
80104c10:	68 80 3d 11 80       	push   $0x80113d80
80104c15:	e8 26 05 00 00       	call   80105140 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
80104c1a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
80104c1d:	83 c4 10             	add    $0x10,%esp
80104c20:	31 c0                	xor    %eax,%eax
}
80104c22:	c9                   	leave  
80104c23:	c3                   	ret    
80104c24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80104c28:	83 ec 0c             	sub    $0xc,%esp
80104c2b:	68 80 3d 11 80       	push   $0x80113d80
80104c30:	e8 0b 05 00 00       	call   80105140 <release>
}
80104c35:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80104c38:	83 c4 10             	add    $0x10,%esp
80104c3b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104c40:	c9                   	leave  
80104c41:	c3                   	ret    
80104c42:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104c50 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104c50:	f3 0f 1e fb          	endbr32 
80104c54:	55                   	push   %ebp
80104c55:	89 e5                	mov    %esp,%ebp
80104c57:	57                   	push   %edi
80104c58:	56                   	push   %esi
80104c59:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104c5c:	53                   	push   %ebx
80104c5d:	bb 20 3e 11 80       	mov    $0x80113e20,%ebx
80104c62:	83 ec 3c             	sub    $0x3c,%esp
80104c65:	eb 2b                	jmp    80104c92 <procdump+0x42>
80104c67:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c6e:	66 90                	xchg   %ax,%ax
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104c70:	83 ec 0c             	sub    $0xc,%esp
80104c73:	68 2f 8a 10 80       	push   $0x80108a2f
80104c78:	e8 33 ba ff ff       	call   801006b0 <cprintf>
80104c7d:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104c80:	81 c3 54 01 00 00    	add    $0x154,%ebx
80104c86:	81 fb 20 93 11 80    	cmp    $0x80119320,%ebx
80104c8c:	0f 84 8e 00 00 00    	je     80104d20 <procdump+0xd0>
    if(p->state == UNUSED)
80104c92:	8b 43 a0             	mov    -0x60(%ebx),%eax
80104c95:	85 c0                	test   %eax,%eax
80104c97:	74 e7                	je     80104c80 <procdump+0x30>
      state = "???";
80104c99:	ba cc 85 10 80       	mov    $0x801085cc,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104c9e:	83 f8 05             	cmp    $0x5,%eax
80104ca1:	77 11                	ja     80104cb4 <procdump+0x64>
80104ca3:	8b 14 85 7c 86 10 80 	mov    -0x7fef7984(,%eax,4),%edx
      state = "???";
80104caa:	b8 cc 85 10 80       	mov    $0x801085cc,%eax
80104caf:	85 d2                	test   %edx,%edx
80104cb1:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104cb4:	53                   	push   %ebx
80104cb5:	52                   	push   %edx
80104cb6:	ff 73 a4             	pushl  -0x5c(%ebx)
80104cb9:	68 d0 85 10 80       	push   $0x801085d0
80104cbe:	e8 ed b9 ff ff       	call   801006b0 <cprintf>
    if(p->state == SLEEPING){
80104cc3:	83 c4 10             	add    $0x10,%esp
80104cc6:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
80104cca:	75 a4                	jne    80104c70 <procdump+0x20>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104ccc:	83 ec 08             	sub    $0x8,%esp
80104ccf:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104cd2:	8d 7d c0             	lea    -0x40(%ebp),%edi
80104cd5:	50                   	push   %eax
80104cd6:	8b 43 b0             	mov    -0x50(%ebx),%eax
80104cd9:	8b 40 0c             	mov    0xc(%eax),%eax
80104cdc:	83 c0 08             	add    $0x8,%eax
80104cdf:	50                   	push   %eax
80104ce0:	e8 3b 02 00 00       	call   80104f20 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
80104ce5:	83 c4 10             	add    $0x10,%esp
80104ce8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104cef:	90                   	nop
80104cf0:	8b 17                	mov    (%edi),%edx
80104cf2:	85 d2                	test   %edx,%edx
80104cf4:	0f 84 76 ff ff ff    	je     80104c70 <procdump+0x20>
        cprintf(" %p", pc[i]);
80104cfa:	83 ec 08             	sub    $0x8,%esp
80104cfd:	83 c7 04             	add    $0x4,%edi
80104d00:	52                   	push   %edx
80104d01:	68 81 7f 10 80       	push   $0x80107f81
80104d06:	e8 a5 b9 ff ff       	call   801006b0 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104d0b:	83 c4 10             	add    $0x10,%esp
80104d0e:	39 fe                	cmp    %edi,%esi
80104d10:	75 de                	jne    80104cf0 <procdump+0xa0>
80104d12:	e9 59 ff ff ff       	jmp    80104c70 <procdump+0x20>
80104d17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d1e:	66 90                	xchg   %ax,%ax
  }
}
80104d20:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104d23:	5b                   	pop    %ebx
80104d24:	5e                   	pop    %esi
80104d25:	5f                   	pop    %edi
80104d26:	5d                   	pop    %ebp
80104d27:	c3                   	ret    
80104d28:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d2f:	90                   	nop

80104d30 <mmap>:

int lastAdrr = 0x40000000;

int mmap(int addr, int lenght, int prot, int flag, int fd, int offset) {
80104d30:	f3 0f 1e fb          	endbr32 
80104d34:	55                   	push   %ebp
80104d35:	89 e5                	mov    %esp,%ebp
80104d37:	53                   	push   %ebx
80104d38:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80104d3b:	e8 40 02 00 00       	call   80104f80 <pushcli>
  c = mycpu();
80104d40:	e8 eb ef ff ff       	call   80103d30 <mycpu>
  p = c->proc;
80104d45:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104d4b:	e8 80 02 00 00       	call   80104fd0 <popcli>

  struct proc* p = myproc();
  struct mappedFile mmapStruct;
  mmapStruct.length = lenght;
  mmapStruct.fd = fd;
  lastAdrr = PGROUNDUP(lastAdrr+1);
80104d50:	a1 04 b0 10 80       	mov    0x8010b004,%eax
  mmapStruct.start_addr = (addr+lastAdrr);
  mmapStruct.flag = flag;
  mmapStruct.prot = prot;
  p->files[p->fileNum++] = mmapStruct;
80104d55:	8b 93 90 00 00 00    	mov    0x90(%ebx),%edx
  lastAdrr = PGROUNDUP(lastAdrr+1);
80104d5b:	05 00 10 00 00       	add    $0x1000,%eax
  p->files[p->fileNum++] = mmapStruct;
80104d60:	8d 4a 01             	lea    0x1(%edx),%ecx
  lastAdrr = PGROUNDUP(lastAdrr+1);
80104d63:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  p->files[p->fileNum++] = mmapStruct;
80104d68:	8d 14 52             	lea    (%edx,%edx,2),%edx
80104d6b:	89 8b 90 00 00 00    	mov    %ecx,0x90(%ebx)
  mmapStruct.start_addr = (addr+lastAdrr);
80104d71:	8b 4d 08             	mov    0x8(%ebp),%ecx
  p->files[p->fileNum++] = mmapStruct;
80104d74:	8d 94 d3 94 00 00 00 	lea    0x94(%ebx,%edx,8),%edx
  lastAdrr = PGROUNDUP(lastAdrr+1);
80104d7b:	a3 04 b0 10 80       	mov    %eax,0x8010b004
  mmapStruct.start_addr = (addr+lastAdrr);
80104d80:	01 c1                	add    %eax,%ecx
  p->files[p->fileNum++] = mmapStruct;
80104d82:	c7 42 08 00 00 00 00 	movl   $0x0,0x8(%edx)
  mmapStruct.start_addr = (addr+lastAdrr);
80104d89:	89 0a                	mov    %ecx,(%edx)
  p->files[p->fileNum++] = mmapStruct;
80104d8b:	8b 4d 18             	mov    0x18(%ebp),%ecx
80104d8e:	89 4a 04             	mov    %ecx,0x4(%edx)
80104d91:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104d94:	89 4a 0c             	mov    %ecx,0xc(%edx)
80104d97:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104d9a:	89 4a 10             	mov    %ecx,0x10(%edx)
80104d9d:	8b 4d 14             	mov    0x14(%ebp),%ecx
80104da0:	89 4a 14             	mov    %ecx,0x14(%edx)

  return lastAdrr;  
}
80104da3:	83 c4 04             	add    $0x4,%esp
80104da6:	5b                   	pop    %ebx
80104da7:	5d                   	pop    %ebp
80104da8:	c3                   	ret    
80104da9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104db0 <get_free_pages_count>:

int get_free_pages_count(void) 
{
80104db0:	f3 0f 1e fb          	endbr32 
  return get_free_pages_count2();
80104db4:	e9 c7 dc ff ff       	jmp    80102a80 <get_free_pages_count2>
80104db9:	66 90                	xchg   %ax,%ax
80104dbb:	66 90                	xchg   %ax,%ax
80104dbd:	66 90                	xchg   %ax,%ax
80104dbf:	90                   	nop

80104dc0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104dc0:	f3 0f 1e fb          	endbr32 
80104dc4:	55                   	push   %ebp
80104dc5:	89 e5                	mov    %esp,%ebp
80104dc7:	53                   	push   %ebx
80104dc8:	83 ec 0c             	sub    $0xc,%esp
80104dcb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
80104dce:	68 94 86 10 80       	push   $0x80108694
80104dd3:	8d 43 04             	lea    0x4(%ebx),%eax
80104dd6:	50                   	push   %eax
80104dd7:	e8 24 01 00 00       	call   80104f00 <initlock>
  lk->name = name;
80104ddc:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
80104ddf:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104de5:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104de8:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
80104def:	89 43 38             	mov    %eax,0x38(%ebx)
}
80104df2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104df5:	c9                   	leave  
80104df6:	c3                   	ret    
80104df7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104dfe:	66 90                	xchg   %ax,%ax

80104e00 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104e00:	f3 0f 1e fb          	endbr32 
80104e04:	55                   	push   %ebp
80104e05:	89 e5                	mov    %esp,%ebp
80104e07:	56                   	push   %esi
80104e08:	53                   	push   %ebx
80104e09:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104e0c:	8d 73 04             	lea    0x4(%ebx),%esi
80104e0f:	83 ec 0c             	sub    $0xc,%esp
80104e12:	56                   	push   %esi
80104e13:	e8 68 02 00 00       	call   80105080 <acquire>
  while (lk->locked) {
80104e18:	8b 13                	mov    (%ebx),%edx
80104e1a:	83 c4 10             	add    $0x10,%esp
80104e1d:	85 d2                	test   %edx,%edx
80104e1f:	74 1a                	je     80104e3b <acquiresleep+0x3b>
80104e21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(lk, &lk->lk);
80104e28:	83 ec 08             	sub    $0x8,%esp
80104e2b:	56                   	push   %esi
80104e2c:	53                   	push   %ebx
80104e2d:	e8 5e fb ff ff       	call   80104990 <sleep>
  while (lk->locked) {
80104e32:	8b 03                	mov    (%ebx),%eax
80104e34:	83 c4 10             	add    $0x10,%esp
80104e37:	85 c0                	test   %eax,%eax
80104e39:	75 ed                	jne    80104e28 <acquiresleep+0x28>
  }
  lk->locked = 1;
80104e3b:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104e41:	e8 7a ef ff ff       	call   80103dc0 <myproc>
80104e46:	8b 40 10             	mov    0x10(%eax),%eax
80104e49:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104e4c:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104e4f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104e52:	5b                   	pop    %ebx
80104e53:	5e                   	pop    %esi
80104e54:	5d                   	pop    %ebp
  release(&lk->lk);
80104e55:	e9 e6 02 00 00       	jmp    80105140 <release>
80104e5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104e60 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104e60:	f3 0f 1e fb          	endbr32 
80104e64:	55                   	push   %ebp
80104e65:	89 e5                	mov    %esp,%ebp
80104e67:	56                   	push   %esi
80104e68:	53                   	push   %ebx
80104e69:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104e6c:	8d 73 04             	lea    0x4(%ebx),%esi
80104e6f:	83 ec 0c             	sub    $0xc,%esp
80104e72:	56                   	push   %esi
80104e73:	e8 08 02 00 00       	call   80105080 <acquire>
  lk->locked = 0;
80104e78:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80104e7e:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104e85:	89 1c 24             	mov    %ebx,(%esp)
80104e88:	e8 c3 fc ff ff       	call   80104b50 <wakeup>
  release(&lk->lk);
80104e8d:	89 75 08             	mov    %esi,0x8(%ebp)
80104e90:	83 c4 10             	add    $0x10,%esp
}
80104e93:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104e96:	5b                   	pop    %ebx
80104e97:	5e                   	pop    %esi
80104e98:	5d                   	pop    %ebp
  release(&lk->lk);
80104e99:	e9 a2 02 00 00       	jmp    80105140 <release>
80104e9e:	66 90                	xchg   %ax,%ax

80104ea0 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104ea0:	f3 0f 1e fb          	endbr32 
80104ea4:	55                   	push   %ebp
80104ea5:	89 e5                	mov    %esp,%ebp
80104ea7:	57                   	push   %edi
80104ea8:	31 ff                	xor    %edi,%edi
80104eaa:	56                   	push   %esi
80104eab:	53                   	push   %ebx
80104eac:	83 ec 18             	sub    $0x18,%esp
80104eaf:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
80104eb2:	8d 73 04             	lea    0x4(%ebx),%esi
80104eb5:	56                   	push   %esi
80104eb6:	e8 c5 01 00 00       	call   80105080 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104ebb:	8b 03                	mov    (%ebx),%eax
80104ebd:	83 c4 10             	add    $0x10,%esp
80104ec0:	85 c0                	test   %eax,%eax
80104ec2:	75 1c                	jne    80104ee0 <holdingsleep+0x40>
  release(&lk->lk);
80104ec4:	83 ec 0c             	sub    $0xc,%esp
80104ec7:	56                   	push   %esi
80104ec8:	e8 73 02 00 00       	call   80105140 <release>
  return r;
}
80104ecd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104ed0:	89 f8                	mov    %edi,%eax
80104ed2:	5b                   	pop    %ebx
80104ed3:	5e                   	pop    %esi
80104ed4:	5f                   	pop    %edi
80104ed5:	5d                   	pop    %ebp
80104ed6:	c3                   	ret    
80104ed7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ede:	66 90                	xchg   %ax,%ax
  r = lk->locked && (lk->pid == myproc()->pid);
80104ee0:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104ee3:	e8 d8 ee ff ff       	call   80103dc0 <myproc>
80104ee8:	39 58 10             	cmp    %ebx,0x10(%eax)
80104eeb:	0f 94 c0             	sete   %al
80104eee:	0f b6 c0             	movzbl %al,%eax
80104ef1:	89 c7                	mov    %eax,%edi
80104ef3:	eb cf                	jmp    80104ec4 <holdingsleep+0x24>
80104ef5:	66 90                	xchg   %ax,%ax
80104ef7:	66 90                	xchg   %ax,%ax
80104ef9:	66 90                	xchg   %ax,%ax
80104efb:	66 90                	xchg   %ax,%ax
80104efd:	66 90                	xchg   %ax,%ax
80104eff:	90                   	nop

80104f00 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104f00:	f3 0f 1e fb          	endbr32 
80104f04:	55                   	push   %ebp
80104f05:	89 e5                	mov    %esp,%ebp
80104f07:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104f0a:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104f0d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
80104f13:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104f16:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104f1d:	5d                   	pop    %ebp
80104f1e:	c3                   	ret    
80104f1f:	90                   	nop

80104f20 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104f20:	f3 0f 1e fb          	endbr32 
80104f24:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104f25:	31 d2                	xor    %edx,%edx
{
80104f27:	89 e5                	mov    %esp,%ebp
80104f29:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104f2a:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104f2d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
80104f30:	83 e8 08             	sub    $0x8,%eax
  for(i = 0; i < 10; i++){
80104f33:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104f37:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104f38:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104f3e:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104f44:	77 1a                	ja     80104f60 <getcallerpcs+0x40>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104f46:	8b 58 04             	mov    0x4(%eax),%ebx
80104f49:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104f4c:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104f4f:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104f51:	83 fa 0a             	cmp    $0xa,%edx
80104f54:	75 e2                	jne    80104f38 <getcallerpcs+0x18>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
80104f56:	5b                   	pop    %ebx
80104f57:	5d                   	pop    %ebp
80104f58:	c3                   	ret    
80104f59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(; i < 10; i++)
80104f60:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80104f63:	8d 51 28             	lea    0x28(%ecx),%edx
80104f66:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f6d:	8d 76 00             	lea    0x0(%esi),%esi
    pcs[i] = 0;
80104f70:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104f76:	83 c0 04             	add    $0x4,%eax
80104f79:	39 d0                	cmp    %edx,%eax
80104f7b:	75 f3                	jne    80104f70 <getcallerpcs+0x50>
}
80104f7d:	5b                   	pop    %ebx
80104f7e:	5d                   	pop    %ebp
80104f7f:	c3                   	ret    

80104f80 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104f80:	f3 0f 1e fb          	endbr32 
80104f84:	55                   	push   %ebp
80104f85:	89 e5                	mov    %esp,%ebp
80104f87:	53                   	push   %ebx
80104f88:	83 ec 04             	sub    $0x4,%esp
80104f8b:	9c                   	pushf  
80104f8c:	5b                   	pop    %ebx
  asm volatile("cli");
80104f8d:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
80104f8e:	e8 9d ed ff ff       	call   80103d30 <mycpu>
80104f93:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104f99:	85 c0                	test   %eax,%eax
80104f9b:	74 13                	je     80104fb0 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
80104f9d:	e8 8e ed ff ff       	call   80103d30 <mycpu>
80104fa2:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104fa9:	83 c4 04             	add    $0x4,%esp
80104fac:	5b                   	pop    %ebx
80104fad:	5d                   	pop    %ebp
80104fae:	c3                   	ret    
80104faf:	90                   	nop
    mycpu()->intena = eflags & FL_IF;
80104fb0:	e8 7b ed ff ff       	call   80103d30 <mycpu>
80104fb5:	81 e3 00 02 00 00    	and    $0x200,%ebx
80104fbb:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80104fc1:	eb da                	jmp    80104f9d <pushcli+0x1d>
80104fc3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104fca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104fd0 <popcli>:

void
popcli(void)
{
80104fd0:	f3 0f 1e fb          	endbr32 
80104fd4:	55                   	push   %ebp
80104fd5:	89 e5                	mov    %esp,%ebp
80104fd7:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104fda:	9c                   	pushf  
80104fdb:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104fdc:	f6 c4 02             	test   $0x2,%ah
80104fdf:	75 31                	jne    80105012 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
80104fe1:	e8 4a ed ff ff       	call   80103d30 <mycpu>
80104fe6:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104fed:	78 30                	js     8010501f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104fef:	e8 3c ed ff ff       	call   80103d30 <mycpu>
80104ff4:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104ffa:	85 d2                	test   %edx,%edx
80104ffc:	74 02                	je     80105000 <popcli+0x30>
    sti();
}
80104ffe:	c9                   	leave  
80104fff:	c3                   	ret    
  if(mycpu()->ncli == 0 && mycpu()->intena)
80105000:	e8 2b ed ff ff       	call   80103d30 <mycpu>
80105005:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010500b:	85 c0                	test   %eax,%eax
8010500d:	74 ef                	je     80104ffe <popcli+0x2e>
  asm volatile("sti");
8010500f:	fb                   	sti    
}
80105010:	c9                   	leave  
80105011:	c3                   	ret    
    panic("popcli - interruptible");
80105012:	83 ec 0c             	sub    $0xc,%esp
80105015:	68 9f 86 10 80       	push   $0x8010869f
8010501a:	e8 71 b3 ff ff       	call   80100390 <panic>
    panic("popcli");
8010501f:	83 ec 0c             	sub    $0xc,%esp
80105022:	68 b6 86 10 80       	push   $0x801086b6
80105027:	e8 64 b3 ff ff       	call   80100390 <panic>
8010502c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105030 <holding>:
{
80105030:	f3 0f 1e fb          	endbr32 
80105034:	55                   	push   %ebp
80105035:	89 e5                	mov    %esp,%ebp
80105037:	56                   	push   %esi
80105038:	53                   	push   %ebx
80105039:	8b 75 08             	mov    0x8(%ebp),%esi
8010503c:	31 db                	xor    %ebx,%ebx
  pushcli();
8010503e:	e8 3d ff ff ff       	call   80104f80 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80105043:	8b 06                	mov    (%esi),%eax
80105045:	85 c0                	test   %eax,%eax
80105047:	75 0f                	jne    80105058 <holding+0x28>
  popcli();
80105049:	e8 82 ff ff ff       	call   80104fd0 <popcli>
}
8010504e:	89 d8                	mov    %ebx,%eax
80105050:	5b                   	pop    %ebx
80105051:	5e                   	pop    %esi
80105052:	5d                   	pop    %ebp
80105053:	c3                   	ret    
80105054:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  r = lock->locked && lock->cpu == mycpu();
80105058:	8b 5e 08             	mov    0x8(%esi),%ebx
8010505b:	e8 d0 ec ff ff       	call   80103d30 <mycpu>
80105060:	39 c3                	cmp    %eax,%ebx
80105062:	0f 94 c3             	sete   %bl
  popcli();
80105065:	e8 66 ff ff ff       	call   80104fd0 <popcli>
  r = lock->locked && lock->cpu == mycpu();
8010506a:	0f b6 db             	movzbl %bl,%ebx
}
8010506d:	89 d8                	mov    %ebx,%eax
8010506f:	5b                   	pop    %ebx
80105070:	5e                   	pop    %esi
80105071:	5d                   	pop    %ebp
80105072:	c3                   	ret    
80105073:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010507a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105080 <acquire>:
{
80105080:	f3 0f 1e fb          	endbr32 
80105084:	55                   	push   %ebp
80105085:	89 e5                	mov    %esp,%ebp
80105087:	56                   	push   %esi
80105088:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
80105089:	e8 f2 fe ff ff       	call   80104f80 <pushcli>
  if(holding(lk))
8010508e:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105091:	83 ec 0c             	sub    $0xc,%esp
80105094:	53                   	push   %ebx
80105095:	e8 96 ff ff ff       	call   80105030 <holding>
8010509a:	83 c4 10             	add    $0x10,%esp
8010509d:	85 c0                	test   %eax,%eax
8010509f:	0f 85 7f 00 00 00    	jne    80105124 <acquire+0xa4>
801050a5:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
801050a7:	ba 01 00 00 00       	mov    $0x1,%edx
801050ac:	eb 05                	jmp    801050b3 <acquire+0x33>
801050ae:	66 90                	xchg   %ax,%ax
801050b0:	8b 5d 08             	mov    0x8(%ebp),%ebx
801050b3:	89 d0                	mov    %edx,%eax
801050b5:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
801050b8:	85 c0                	test   %eax,%eax
801050ba:	75 f4                	jne    801050b0 <acquire+0x30>
  __sync_synchronize();
801050bc:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
801050c1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801050c4:	e8 67 ec ff ff       	call   80103d30 <mycpu>
801050c9:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
801050cc:	89 e8                	mov    %ebp,%eax
801050ce:	66 90                	xchg   %ax,%ax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801050d0:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
801050d6:	81 fa fe ff ff 7f    	cmp    $0x7ffffffe,%edx
801050dc:	77 22                	ja     80105100 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
801050de:	8b 50 04             	mov    0x4(%eax),%edx
801050e1:	89 54 b3 0c          	mov    %edx,0xc(%ebx,%esi,4)
  for(i = 0; i < 10; i++){
801050e5:	83 c6 01             	add    $0x1,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
801050e8:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
801050ea:	83 fe 0a             	cmp    $0xa,%esi
801050ed:	75 e1                	jne    801050d0 <acquire+0x50>
}
801050ef:	8d 65 f8             	lea    -0x8(%ebp),%esp
801050f2:	5b                   	pop    %ebx
801050f3:	5e                   	pop    %esi
801050f4:	5d                   	pop    %ebp
801050f5:	c3                   	ret    
801050f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801050fd:	8d 76 00             	lea    0x0(%esi),%esi
  for(; i < 10; i++)
80105100:	8d 44 b3 0c          	lea    0xc(%ebx,%esi,4),%eax
80105104:	83 c3 34             	add    $0x34,%ebx
80105107:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010510e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80105110:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80105116:	83 c0 04             	add    $0x4,%eax
80105119:	39 d8                	cmp    %ebx,%eax
8010511b:	75 f3                	jne    80105110 <acquire+0x90>
}
8010511d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105120:	5b                   	pop    %ebx
80105121:	5e                   	pop    %esi
80105122:	5d                   	pop    %ebp
80105123:	c3                   	ret    
    panic("acquire");
80105124:	83 ec 0c             	sub    $0xc,%esp
80105127:	68 bd 86 10 80       	push   $0x801086bd
8010512c:	e8 5f b2 ff ff       	call   80100390 <panic>
80105131:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105138:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010513f:	90                   	nop

80105140 <release>:
{
80105140:	f3 0f 1e fb          	endbr32 
80105144:	55                   	push   %ebp
80105145:	89 e5                	mov    %esp,%ebp
80105147:	53                   	push   %ebx
80105148:	83 ec 10             	sub    $0x10,%esp
8010514b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
8010514e:	53                   	push   %ebx
8010514f:	e8 dc fe ff ff       	call   80105030 <holding>
80105154:	83 c4 10             	add    $0x10,%esp
80105157:	85 c0                	test   %eax,%eax
80105159:	74 22                	je     8010517d <release+0x3d>
  lk->pcs[0] = 0;
8010515b:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80105162:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80105169:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010516e:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80105174:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105177:	c9                   	leave  
  popcli();
80105178:	e9 53 fe ff ff       	jmp    80104fd0 <popcli>
    panic("release");
8010517d:	83 ec 0c             	sub    $0xc,%esp
80105180:	68 c5 86 10 80       	push   $0x801086c5
80105185:	e8 06 b2 ff ff       	call   80100390 <panic>
8010518a:	66 90                	xchg   %ax,%ax
8010518c:	66 90                	xchg   %ax,%ax
8010518e:	66 90                	xchg   %ax,%ax

80105190 <memset>:
80105190:	f3 0f 1e fb          	endbr32 
80105194:	55                   	push   %ebp
80105195:	89 e5                	mov    %esp,%ebp
80105197:	57                   	push   %edi
80105198:	8b 55 08             	mov    0x8(%ebp),%edx
8010519b:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010519e:	53                   	push   %ebx
8010519f:	8b 45 0c             	mov    0xc(%ebp),%eax
801051a2:	89 d7                	mov    %edx,%edi
801051a4:	09 cf                	or     %ecx,%edi
801051a6:	83 e7 03             	and    $0x3,%edi
801051a9:	75 25                	jne    801051d0 <memset+0x40>
801051ab:	0f b6 f8             	movzbl %al,%edi
801051ae:	c1 e0 18             	shl    $0x18,%eax
801051b1:	89 fb                	mov    %edi,%ebx
801051b3:	c1 e9 02             	shr    $0x2,%ecx
801051b6:	c1 e3 10             	shl    $0x10,%ebx
801051b9:	09 d8                	or     %ebx,%eax
801051bb:	09 f8                	or     %edi,%eax
801051bd:	c1 e7 08             	shl    $0x8,%edi
801051c0:	09 f8                	or     %edi,%eax
801051c2:	89 d7                	mov    %edx,%edi
801051c4:	fc                   	cld    
801051c5:	f3 ab                	rep stos %eax,%es:(%edi)
801051c7:	5b                   	pop    %ebx
801051c8:	89 d0                	mov    %edx,%eax
801051ca:	5f                   	pop    %edi
801051cb:	5d                   	pop    %ebp
801051cc:	c3                   	ret    
801051cd:	8d 76 00             	lea    0x0(%esi),%esi
801051d0:	89 d7                	mov    %edx,%edi
801051d2:	fc                   	cld    
801051d3:	f3 aa                	rep stos %al,%es:(%edi)
801051d5:	5b                   	pop    %ebx
801051d6:	89 d0                	mov    %edx,%eax
801051d8:	5f                   	pop    %edi
801051d9:	5d                   	pop    %ebp
801051da:	c3                   	ret    
801051db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801051df:	90                   	nop

801051e0 <memcmp>:
801051e0:	f3 0f 1e fb          	endbr32 
801051e4:	55                   	push   %ebp
801051e5:	89 e5                	mov    %esp,%ebp
801051e7:	56                   	push   %esi
801051e8:	8b 75 10             	mov    0x10(%ebp),%esi
801051eb:	8b 55 08             	mov    0x8(%ebp),%edx
801051ee:	53                   	push   %ebx
801051ef:	8b 45 0c             	mov    0xc(%ebp),%eax
801051f2:	85 f6                	test   %esi,%esi
801051f4:	74 2a                	je     80105220 <memcmp+0x40>
801051f6:	01 c6                	add    %eax,%esi
801051f8:	eb 10                	jmp    8010520a <memcmp+0x2a>
801051fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105200:	83 c0 01             	add    $0x1,%eax
80105203:	83 c2 01             	add    $0x1,%edx
80105206:	39 f0                	cmp    %esi,%eax
80105208:	74 16                	je     80105220 <memcmp+0x40>
8010520a:	0f b6 0a             	movzbl (%edx),%ecx
8010520d:	0f b6 18             	movzbl (%eax),%ebx
80105210:	38 d9                	cmp    %bl,%cl
80105212:	74 ec                	je     80105200 <memcmp+0x20>
80105214:	0f b6 c1             	movzbl %cl,%eax
80105217:	29 d8                	sub    %ebx,%eax
80105219:	5b                   	pop    %ebx
8010521a:	5e                   	pop    %esi
8010521b:	5d                   	pop    %ebp
8010521c:	c3                   	ret    
8010521d:	8d 76 00             	lea    0x0(%esi),%esi
80105220:	5b                   	pop    %ebx
80105221:	31 c0                	xor    %eax,%eax
80105223:	5e                   	pop    %esi
80105224:	5d                   	pop    %ebp
80105225:	c3                   	ret    
80105226:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010522d:	8d 76 00             	lea    0x0(%esi),%esi

80105230 <memmove>:
80105230:	f3 0f 1e fb          	endbr32 
80105234:	55                   	push   %ebp
80105235:	89 e5                	mov    %esp,%ebp
80105237:	57                   	push   %edi
80105238:	8b 55 08             	mov    0x8(%ebp),%edx
8010523b:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010523e:	56                   	push   %esi
8010523f:	8b 75 0c             	mov    0xc(%ebp),%esi
80105242:	39 d6                	cmp    %edx,%esi
80105244:	73 2a                	jae    80105270 <memmove+0x40>
80105246:	8d 3c 0e             	lea    (%esi,%ecx,1),%edi
80105249:	39 fa                	cmp    %edi,%edx
8010524b:	73 23                	jae    80105270 <memmove+0x40>
8010524d:	8d 41 ff             	lea    -0x1(%ecx),%eax
80105250:	85 c9                	test   %ecx,%ecx
80105252:	74 13                	je     80105267 <memmove+0x37>
80105254:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105258:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
8010525c:	88 0c 02             	mov    %cl,(%edx,%eax,1)
8010525f:	83 e8 01             	sub    $0x1,%eax
80105262:	83 f8 ff             	cmp    $0xffffffff,%eax
80105265:	75 f1                	jne    80105258 <memmove+0x28>
80105267:	5e                   	pop    %esi
80105268:	89 d0                	mov    %edx,%eax
8010526a:	5f                   	pop    %edi
8010526b:	5d                   	pop    %ebp
8010526c:	c3                   	ret    
8010526d:	8d 76 00             	lea    0x0(%esi),%esi
80105270:	8d 04 0e             	lea    (%esi,%ecx,1),%eax
80105273:	89 d7                	mov    %edx,%edi
80105275:	85 c9                	test   %ecx,%ecx
80105277:	74 ee                	je     80105267 <memmove+0x37>
80105279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105280:	a4                   	movsb  %ds:(%esi),%es:(%edi)
80105281:	39 f0                	cmp    %esi,%eax
80105283:	75 fb                	jne    80105280 <memmove+0x50>
80105285:	5e                   	pop    %esi
80105286:	89 d0                	mov    %edx,%eax
80105288:	5f                   	pop    %edi
80105289:	5d                   	pop    %ebp
8010528a:	c3                   	ret    
8010528b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010528f:	90                   	nop

80105290 <memcpy>:
80105290:	f3 0f 1e fb          	endbr32 
80105294:	eb 9a                	jmp    80105230 <memmove>
80105296:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010529d:	8d 76 00             	lea    0x0(%esi),%esi

801052a0 <strncmp>:
801052a0:	f3 0f 1e fb          	endbr32 
801052a4:	55                   	push   %ebp
801052a5:	89 e5                	mov    %esp,%ebp
801052a7:	56                   	push   %esi
801052a8:	8b 75 10             	mov    0x10(%ebp),%esi
801052ab:	8b 4d 08             	mov    0x8(%ebp),%ecx
801052ae:	53                   	push   %ebx
801052af:	8b 45 0c             	mov    0xc(%ebp),%eax
801052b2:	85 f6                	test   %esi,%esi
801052b4:	74 32                	je     801052e8 <strncmp+0x48>
801052b6:	01 c6                	add    %eax,%esi
801052b8:	eb 14                	jmp    801052ce <strncmp+0x2e>
801052ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801052c0:	38 da                	cmp    %bl,%dl
801052c2:	75 14                	jne    801052d8 <strncmp+0x38>
801052c4:	83 c0 01             	add    $0x1,%eax
801052c7:	83 c1 01             	add    $0x1,%ecx
801052ca:	39 f0                	cmp    %esi,%eax
801052cc:	74 1a                	je     801052e8 <strncmp+0x48>
801052ce:	0f b6 11             	movzbl (%ecx),%edx
801052d1:	0f b6 18             	movzbl (%eax),%ebx
801052d4:	84 d2                	test   %dl,%dl
801052d6:	75 e8                	jne    801052c0 <strncmp+0x20>
801052d8:	0f b6 c2             	movzbl %dl,%eax
801052db:	29 d8                	sub    %ebx,%eax
801052dd:	5b                   	pop    %ebx
801052de:	5e                   	pop    %esi
801052df:	5d                   	pop    %ebp
801052e0:	c3                   	ret    
801052e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801052e8:	5b                   	pop    %ebx
801052e9:	31 c0                	xor    %eax,%eax
801052eb:	5e                   	pop    %esi
801052ec:	5d                   	pop    %ebp
801052ed:	c3                   	ret    
801052ee:	66 90                	xchg   %ax,%ax

801052f0 <strncpy>:
801052f0:	f3 0f 1e fb          	endbr32 
801052f4:	55                   	push   %ebp
801052f5:	89 e5                	mov    %esp,%ebp
801052f7:	57                   	push   %edi
801052f8:	56                   	push   %esi
801052f9:	8b 75 08             	mov    0x8(%ebp),%esi
801052fc:	53                   	push   %ebx
801052fd:	8b 45 10             	mov    0x10(%ebp),%eax
80105300:	89 f2                	mov    %esi,%edx
80105302:	eb 1b                	jmp    8010531f <strncpy+0x2f>
80105304:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105308:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
8010530c:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010530f:	83 c2 01             	add    $0x1,%edx
80105312:	0f b6 7f ff          	movzbl -0x1(%edi),%edi
80105316:	89 f9                	mov    %edi,%ecx
80105318:	88 4a ff             	mov    %cl,-0x1(%edx)
8010531b:	84 c9                	test   %cl,%cl
8010531d:	74 09                	je     80105328 <strncpy+0x38>
8010531f:	89 c3                	mov    %eax,%ebx
80105321:	83 e8 01             	sub    $0x1,%eax
80105324:	85 db                	test   %ebx,%ebx
80105326:	7f e0                	jg     80105308 <strncpy+0x18>
80105328:	89 d1                	mov    %edx,%ecx
8010532a:	85 c0                	test   %eax,%eax
8010532c:	7e 15                	jle    80105343 <strncpy+0x53>
8010532e:	66 90                	xchg   %ax,%ax
80105330:	83 c1 01             	add    $0x1,%ecx
80105333:	c6 41 ff 00          	movb   $0x0,-0x1(%ecx)
80105337:	89 c8                	mov    %ecx,%eax
80105339:	f7 d0                	not    %eax
8010533b:	01 d0                	add    %edx,%eax
8010533d:	01 d8                	add    %ebx,%eax
8010533f:	85 c0                	test   %eax,%eax
80105341:	7f ed                	jg     80105330 <strncpy+0x40>
80105343:	5b                   	pop    %ebx
80105344:	89 f0                	mov    %esi,%eax
80105346:	5e                   	pop    %esi
80105347:	5f                   	pop    %edi
80105348:	5d                   	pop    %ebp
80105349:	c3                   	ret    
8010534a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105350 <safestrcpy>:
80105350:	f3 0f 1e fb          	endbr32 
80105354:	55                   	push   %ebp
80105355:	89 e5                	mov    %esp,%ebp
80105357:	56                   	push   %esi
80105358:	8b 55 10             	mov    0x10(%ebp),%edx
8010535b:	8b 75 08             	mov    0x8(%ebp),%esi
8010535e:	53                   	push   %ebx
8010535f:	8b 45 0c             	mov    0xc(%ebp),%eax
80105362:	85 d2                	test   %edx,%edx
80105364:	7e 21                	jle    80105387 <safestrcpy+0x37>
80105366:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
8010536a:	89 f2                	mov    %esi,%edx
8010536c:	eb 12                	jmp    80105380 <safestrcpy+0x30>
8010536e:	66 90                	xchg   %ax,%ax
80105370:	0f b6 08             	movzbl (%eax),%ecx
80105373:	83 c0 01             	add    $0x1,%eax
80105376:	83 c2 01             	add    $0x1,%edx
80105379:	88 4a ff             	mov    %cl,-0x1(%edx)
8010537c:	84 c9                	test   %cl,%cl
8010537e:	74 04                	je     80105384 <safestrcpy+0x34>
80105380:	39 d8                	cmp    %ebx,%eax
80105382:	75 ec                	jne    80105370 <safestrcpy+0x20>
80105384:	c6 02 00             	movb   $0x0,(%edx)
80105387:	89 f0                	mov    %esi,%eax
80105389:	5b                   	pop    %ebx
8010538a:	5e                   	pop    %esi
8010538b:	5d                   	pop    %ebp
8010538c:	c3                   	ret    
8010538d:	8d 76 00             	lea    0x0(%esi),%esi

80105390 <strlen>:
80105390:	f3 0f 1e fb          	endbr32 
80105394:	55                   	push   %ebp
80105395:	31 c0                	xor    %eax,%eax
80105397:	89 e5                	mov    %esp,%ebp
80105399:	8b 55 08             	mov    0x8(%ebp),%edx
8010539c:	80 3a 00             	cmpb   $0x0,(%edx)
8010539f:	74 10                	je     801053b1 <strlen+0x21>
801053a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801053a8:	83 c0 01             	add    $0x1,%eax
801053ab:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
801053af:	75 f7                	jne    801053a8 <strlen+0x18>
801053b1:	5d                   	pop    %ebp
801053b2:	c3                   	ret    

801053b3 <swtch>:
801053b3:	8b 44 24 04          	mov    0x4(%esp),%eax
801053b7:	8b 54 24 08          	mov    0x8(%esp),%edx
801053bb:	55                   	push   %ebp
801053bc:	53                   	push   %ebx
801053bd:	56                   	push   %esi
801053be:	57                   	push   %edi
801053bf:	89 20                	mov    %esp,(%eax)
801053c1:	89 d4                	mov    %edx,%esp
801053c3:	5f                   	pop    %edi
801053c4:	5e                   	pop    %esi
801053c5:	5b                   	pop    %ebx
801053c6:	5d                   	pop    %ebp
801053c7:	c3                   	ret    
801053c8:	66 90                	xchg   %ax,%ax
801053ca:	66 90                	xchg   %ax,%ax
801053cc:	66 90                	xchg   %ax,%ax
801053ce:	66 90                	xchg   %ax,%ax

801053d0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
801053d0:	f3 0f 1e fb          	endbr32 
801053d4:	55                   	push   %ebp
801053d5:	89 e5                	mov    %esp,%ebp
801053d7:	53                   	push   %ebx
801053d8:	83 ec 04             	sub    $0x4,%esp
801053db:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
801053de:	e8 dd e9 ff ff       	call   80103dc0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
801053e3:	8b 00                	mov    (%eax),%eax
801053e5:	39 d8                	cmp    %ebx,%eax
801053e7:	76 17                	jbe    80105400 <fetchint+0x30>
801053e9:	8d 53 04             	lea    0x4(%ebx),%edx
801053ec:	39 d0                	cmp    %edx,%eax
801053ee:	72 10                	jb     80105400 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
801053f0:	8b 45 0c             	mov    0xc(%ebp),%eax
801053f3:	8b 13                	mov    (%ebx),%edx
801053f5:	89 10                	mov    %edx,(%eax)
  return 0;
801053f7:	31 c0                	xor    %eax,%eax
}
801053f9:	83 c4 04             	add    $0x4,%esp
801053fc:	5b                   	pop    %ebx
801053fd:	5d                   	pop    %ebp
801053fe:	c3                   	ret    
801053ff:	90                   	nop
    return -1;
80105400:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105405:	eb f2                	jmp    801053f9 <fetchint+0x29>
80105407:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010540e:	66 90                	xchg   %ax,%ax

80105410 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80105410:	f3 0f 1e fb          	endbr32 
80105414:	55                   	push   %ebp
80105415:	89 e5                	mov    %esp,%ebp
80105417:	53                   	push   %ebx
80105418:	83 ec 04             	sub    $0x4,%esp
8010541b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010541e:	e8 9d e9 ff ff       	call   80103dc0 <myproc>

  if(addr >= curproc->sz)
80105423:	39 18                	cmp    %ebx,(%eax)
80105425:	76 31                	jbe    80105458 <fetchstr+0x48>
    return -1;
  *pp = (char*)addr;
80105427:	8b 55 0c             	mov    0xc(%ebp),%edx
8010542a:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
8010542c:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
8010542e:	39 d3                	cmp    %edx,%ebx
80105430:	73 26                	jae    80105458 <fetchstr+0x48>
80105432:	89 d8                	mov    %ebx,%eax
80105434:	eb 11                	jmp    80105447 <fetchstr+0x37>
80105436:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010543d:	8d 76 00             	lea    0x0(%esi),%esi
80105440:	83 c0 01             	add    $0x1,%eax
80105443:	39 c2                	cmp    %eax,%edx
80105445:	76 11                	jbe    80105458 <fetchstr+0x48>
    if(*s == 0)
80105447:	80 38 00             	cmpb   $0x0,(%eax)
8010544a:	75 f4                	jne    80105440 <fetchstr+0x30>
      return s - *pp;
  }
  return -1;
}
8010544c:	83 c4 04             	add    $0x4,%esp
      return s - *pp;
8010544f:	29 d8                	sub    %ebx,%eax
}
80105451:	5b                   	pop    %ebx
80105452:	5d                   	pop    %ebp
80105453:	c3                   	ret    
80105454:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105458:	83 c4 04             	add    $0x4,%esp
    return -1;
8010545b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105460:	5b                   	pop    %ebx
80105461:	5d                   	pop    %ebp
80105462:	c3                   	ret    
80105463:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010546a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105470 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80105470:	f3 0f 1e fb          	endbr32 
80105474:	55                   	push   %ebp
80105475:	89 e5                	mov    %esp,%ebp
80105477:	56                   	push   %esi
80105478:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105479:	e8 42 e9 ff ff       	call   80103dc0 <myproc>
8010547e:	8b 55 08             	mov    0x8(%ebp),%edx
80105481:	8b 40 18             	mov    0x18(%eax),%eax
80105484:	8b 40 44             	mov    0x44(%eax),%eax
80105487:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
8010548a:	e8 31 e9 ff ff       	call   80103dc0 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010548f:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105492:	8b 00                	mov    (%eax),%eax
80105494:	39 c6                	cmp    %eax,%esi
80105496:	73 18                	jae    801054b0 <argint+0x40>
80105498:	8d 53 08             	lea    0x8(%ebx),%edx
8010549b:	39 d0                	cmp    %edx,%eax
8010549d:	72 11                	jb     801054b0 <argint+0x40>
  *ip = *(int*)(addr);
8010549f:	8b 45 0c             	mov    0xc(%ebp),%eax
801054a2:	8b 53 04             	mov    0x4(%ebx),%edx
801054a5:	89 10                	mov    %edx,(%eax)
  return 0;
801054a7:	31 c0                	xor    %eax,%eax
}
801054a9:	5b                   	pop    %ebx
801054aa:	5e                   	pop    %esi
801054ab:	5d                   	pop    %ebp
801054ac:	c3                   	ret    
801054ad:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801054b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801054b5:	eb f2                	jmp    801054a9 <argint+0x39>
801054b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801054be:	66 90                	xchg   %ax,%ax

801054c0 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
801054c0:	f3 0f 1e fb          	endbr32 
801054c4:	55                   	push   %ebp
801054c5:	89 e5                	mov    %esp,%ebp
801054c7:	56                   	push   %esi
801054c8:	53                   	push   %ebx
801054c9:	83 ec 10             	sub    $0x10,%esp
801054cc:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
801054cf:	e8 ec e8 ff ff       	call   80103dc0 <myproc>
 
  if(argint(n, &i) < 0)
801054d4:	83 ec 08             	sub    $0x8,%esp
  struct proc *curproc = myproc();
801054d7:	89 c6                	mov    %eax,%esi
  if(argint(n, &i) < 0)
801054d9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801054dc:	50                   	push   %eax
801054dd:	ff 75 08             	pushl  0x8(%ebp)
801054e0:	e8 8b ff ff ff       	call   80105470 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
801054e5:	83 c4 10             	add    $0x10,%esp
801054e8:	85 c0                	test   %eax,%eax
801054ea:	78 24                	js     80105510 <argptr+0x50>
801054ec:	85 db                	test   %ebx,%ebx
801054ee:	78 20                	js     80105510 <argptr+0x50>
801054f0:	8b 16                	mov    (%esi),%edx
801054f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801054f5:	39 c2                	cmp    %eax,%edx
801054f7:	76 17                	jbe    80105510 <argptr+0x50>
801054f9:	01 c3                	add    %eax,%ebx
801054fb:	39 da                	cmp    %ebx,%edx
801054fd:	72 11                	jb     80105510 <argptr+0x50>
    return -1;
  *pp = (char*)i;
801054ff:	8b 55 0c             	mov    0xc(%ebp),%edx
80105502:	89 02                	mov    %eax,(%edx)
  return 0;
80105504:	31 c0                	xor    %eax,%eax
}
80105506:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105509:	5b                   	pop    %ebx
8010550a:	5e                   	pop    %esi
8010550b:	5d                   	pop    %ebp
8010550c:	c3                   	ret    
8010550d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105510:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105515:	eb ef                	jmp    80105506 <argptr+0x46>
80105517:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010551e:	66 90                	xchg   %ax,%ax

80105520 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105520:	f3 0f 1e fb          	endbr32 
80105524:	55                   	push   %ebp
80105525:	89 e5                	mov    %esp,%ebp
80105527:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
8010552a:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010552d:	50                   	push   %eax
8010552e:	ff 75 08             	pushl  0x8(%ebp)
80105531:	e8 3a ff ff ff       	call   80105470 <argint>
80105536:	83 c4 10             	add    $0x10,%esp
80105539:	85 c0                	test   %eax,%eax
8010553b:	78 13                	js     80105550 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
8010553d:	83 ec 08             	sub    $0x8,%esp
80105540:	ff 75 0c             	pushl  0xc(%ebp)
80105543:	ff 75 f4             	pushl  -0xc(%ebp)
80105546:	e8 c5 fe ff ff       	call   80105410 <fetchstr>
8010554b:	83 c4 10             	add    $0x10,%esp
}
8010554e:	c9                   	leave  
8010554f:	c3                   	ret    
80105550:	c9                   	leave  
    return -1;
80105551:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105556:	c3                   	ret    
80105557:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010555e:	66 90                	xchg   %ax,%ax

80105560 <syscall>:
[SYS_get_free_pages_count] sys_get_free_pages_count,
};

void
syscall(void)
{
80105560:	f3 0f 1e fb          	endbr32 
80105564:	55                   	push   %ebp
80105565:	89 e5                	mov    %esp,%ebp
80105567:	53                   	push   %ebx
80105568:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
8010556b:	e8 50 e8 ff ff       	call   80103dc0 <myproc>
80105570:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80105572:	8b 40 18             	mov    0x18(%eax),%eax
80105575:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80105578:	8d 50 ff             	lea    -0x1(%eax),%edx
8010557b:	83 fa 1c             	cmp    $0x1c,%edx
8010557e:	77 20                	ja     801055a0 <syscall+0x40>
80105580:	8b 14 85 00 87 10 80 	mov    -0x7fef7900(,%eax,4),%edx
80105587:	85 d2                	test   %edx,%edx
80105589:	74 15                	je     801055a0 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
8010558b:	ff d2                	call   *%edx
8010558d:	89 c2                	mov    %eax,%edx
8010558f:	8b 43 18             	mov    0x18(%ebx),%eax
80105592:	89 50 1c             	mov    %edx,0x1c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80105595:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105598:	c9                   	leave  
80105599:	c3                   	ret    
8010559a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cprintf("%d %s: unknown sys call %d\n",
801055a0:	50                   	push   %eax
            curproc->pid, curproc->name, num);
801055a1:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
801055a4:	50                   	push   %eax
801055a5:	ff 73 10             	pushl  0x10(%ebx)
801055a8:	68 cd 86 10 80       	push   $0x801086cd
801055ad:	e8 fe b0 ff ff       	call   801006b0 <cprintf>
    curproc->tf->eax = -1;
801055b2:	8b 43 18             	mov    0x18(%ebx),%eax
801055b5:	83 c4 10             	add    $0x10,%esp
801055b8:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
801055bf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801055c2:	c9                   	leave  
801055c3:	c3                   	ret    
801055c4:	66 90                	xchg   %ax,%ax
801055c6:	66 90                	xchg   %ax,%ax
801055c8:	66 90                	xchg   %ax,%ax
801055ca:	66 90                	xchg   %ax,%ax
801055cc:	66 90                	xchg   %ax,%ax
801055ce:	66 90                	xchg   %ax,%ax

801055d0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
801055d0:	55                   	push   %ebp
801055d1:	89 e5                	mov    %esp,%ebp
801055d3:	57                   	push   %edi
801055d4:	56                   	push   %esi
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
801055d5:	8d 7d da             	lea    -0x26(%ebp),%edi
{
801055d8:	53                   	push   %ebx
801055d9:	83 ec 34             	sub    $0x34,%esp
801055dc:	89 4d d0             	mov    %ecx,-0x30(%ebp)
801055df:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
801055e2:	57                   	push   %edi
801055e3:	50                   	push   %eax
{
801055e4:	89 55 d4             	mov    %edx,-0x2c(%ebp)
801055e7:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
801055ea:	e8 41 ce ff ff       	call   80102430 <nameiparent>
801055ef:	83 c4 10             	add    $0x10,%esp
801055f2:	85 c0                	test   %eax,%eax
801055f4:	0f 84 46 01 00 00    	je     80105740 <create+0x170>
    return 0;
  ilock(dp);
801055fa:	83 ec 0c             	sub    $0xc,%esp
801055fd:	89 c3                	mov    %eax,%ebx
801055ff:	50                   	push   %eax
80105600:	e8 3b c5 ff ff       	call   80101b40 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80105605:	83 c4 0c             	add    $0xc,%esp
80105608:	6a 00                	push   $0x0
8010560a:	57                   	push   %edi
8010560b:	53                   	push   %ebx
8010560c:	e8 7f ca ff ff       	call   80102090 <dirlookup>
80105611:	83 c4 10             	add    $0x10,%esp
80105614:	89 c6                	mov    %eax,%esi
80105616:	85 c0                	test   %eax,%eax
80105618:	74 56                	je     80105670 <create+0xa0>
    iunlockput(dp);
8010561a:	83 ec 0c             	sub    $0xc,%esp
8010561d:	53                   	push   %ebx
8010561e:	e8 bd c7 ff ff       	call   80101de0 <iunlockput>
    ilock(ip);
80105623:	89 34 24             	mov    %esi,(%esp)
80105626:	e8 15 c5 ff ff       	call   80101b40 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
8010562b:	83 c4 10             	add    $0x10,%esp
8010562e:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80105633:	75 1b                	jne    80105650 <create+0x80>
80105635:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
8010563a:	75 14                	jne    80105650 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
8010563c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010563f:	89 f0                	mov    %esi,%eax
80105641:	5b                   	pop    %ebx
80105642:	5e                   	pop    %esi
80105643:	5f                   	pop    %edi
80105644:	5d                   	pop    %ebp
80105645:	c3                   	ret    
80105646:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010564d:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
80105650:	83 ec 0c             	sub    $0xc,%esp
80105653:	56                   	push   %esi
    return 0;
80105654:	31 f6                	xor    %esi,%esi
    iunlockput(ip);
80105656:	e8 85 c7 ff ff       	call   80101de0 <iunlockput>
    return 0;
8010565b:	83 c4 10             	add    $0x10,%esp
}
8010565e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105661:	89 f0                	mov    %esi,%eax
80105663:	5b                   	pop    %ebx
80105664:	5e                   	pop    %esi
80105665:	5f                   	pop    %edi
80105666:	5d                   	pop    %ebp
80105667:	c3                   	ret    
80105668:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010566f:	90                   	nop
  if((ip = ialloc(dp->dev, type)) == 0)
80105670:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80105674:	83 ec 08             	sub    $0x8,%esp
80105677:	50                   	push   %eax
80105678:	ff 33                	pushl  (%ebx)
8010567a:	e8 41 c3 ff ff       	call   801019c0 <ialloc>
8010567f:	83 c4 10             	add    $0x10,%esp
80105682:	89 c6                	mov    %eax,%esi
80105684:	85 c0                	test   %eax,%eax
80105686:	0f 84 cd 00 00 00    	je     80105759 <create+0x189>
  ilock(ip);
8010568c:	83 ec 0c             	sub    $0xc,%esp
8010568f:	50                   	push   %eax
80105690:	e8 ab c4 ff ff       	call   80101b40 <ilock>
  ip->major = major;
80105695:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80105699:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
8010569d:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
801056a1:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
801056a5:	b8 01 00 00 00       	mov    $0x1,%eax
801056aa:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
801056ae:	89 34 24             	mov    %esi,(%esp)
801056b1:	e8 ca c3 ff ff       	call   80101a80 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
801056b6:	83 c4 10             	add    $0x10,%esp
801056b9:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
801056be:	74 30                	je     801056f0 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
801056c0:	83 ec 04             	sub    $0x4,%esp
801056c3:	ff 76 04             	pushl  0x4(%esi)
801056c6:	57                   	push   %edi
801056c7:	53                   	push   %ebx
801056c8:	e8 83 cc ff ff       	call   80102350 <dirlink>
801056cd:	83 c4 10             	add    $0x10,%esp
801056d0:	85 c0                	test   %eax,%eax
801056d2:	78 78                	js     8010574c <create+0x17c>
  iunlockput(dp);
801056d4:	83 ec 0c             	sub    $0xc,%esp
801056d7:	53                   	push   %ebx
801056d8:	e8 03 c7 ff ff       	call   80101de0 <iunlockput>
  return ip;
801056dd:	83 c4 10             	add    $0x10,%esp
}
801056e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801056e3:	89 f0                	mov    %esi,%eax
801056e5:	5b                   	pop    %ebx
801056e6:	5e                   	pop    %esi
801056e7:	5f                   	pop    %edi
801056e8:	5d                   	pop    %ebp
801056e9:	c3                   	ret    
801056ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
801056f0:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
801056f3:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
801056f8:	53                   	push   %ebx
801056f9:	e8 82 c3 ff ff       	call   80101a80 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
801056fe:	83 c4 0c             	add    $0xc,%esp
80105701:	ff 76 04             	pushl  0x4(%esi)
80105704:	68 94 87 10 80       	push   $0x80108794
80105709:	56                   	push   %esi
8010570a:	e8 41 cc ff ff       	call   80102350 <dirlink>
8010570f:	83 c4 10             	add    $0x10,%esp
80105712:	85 c0                	test   %eax,%eax
80105714:	78 18                	js     8010572e <create+0x15e>
80105716:	83 ec 04             	sub    $0x4,%esp
80105719:	ff 73 04             	pushl  0x4(%ebx)
8010571c:	68 93 87 10 80       	push   $0x80108793
80105721:	56                   	push   %esi
80105722:	e8 29 cc ff ff       	call   80102350 <dirlink>
80105727:	83 c4 10             	add    $0x10,%esp
8010572a:	85 c0                	test   %eax,%eax
8010572c:	79 92                	jns    801056c0 <create+0xf0>
      panic("create dots");
8010572e:	83 ec 0c             	sub    $0xc,%esp
80105731:	68 87 87 10 80       	push   $0x80108787
80105736:	e8 55 ac ff ff       	call   80100390 <panic>
8010573b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010573f:	90                   	nop
}
80105740:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80105743:	31 f6                	xor    %esi,%esi
}
80105745:	5b                   	pop    %ebx
80105746:	89 f0                	mov    %esi,%eax
80105748:	5e                   	pop    %esi
80105749:	5f                   	pop    %edi
8010574a:	5d                   	pop    %ebp
8010574b:	c3                   	ret    
    panic("create: dirlink");
8010574c:	83 ec 0c             	sub    $0xc,%esp
8010574f:	68 96 87 10 80       	push   $0x80108796
80105754:	e8 37 ac ff ff       	call   80100390 <panic>
    panic("create: ialloc");
80105759:	83 ec 0c             	sub    $0xc,%esp
8010575c:	68 78 87 10 80       	push   $0x80108778
80105761:	e8 2a ac ff ff       	call   80100390 <panic>
80105766:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010576d:	8d 76 00             	lea    0x0(%esi),%esi

80105770 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80105770:	55                   	push   %ebp
80105771:	89 e5                	mov    %esp,%ebp
80105773:	56                   	push   %esi
80105774:	89 d6                	mov    %edx,%esi
80105776:	53                   	push   %ebx
80105777:	89 c3                	mov    %eax,%ebx
  if(argint(n, &fd) < 0)
80105779:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
8010577c:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010577f:	50                   	push   %eax
80105780:	6a 00                	push   $0x0
80105782:	e8 e9 fc ff ff       	call   80105470 <argint>
80105787:	83 c4 10             	add    $0x10,%esp
8010578a:	85 c0                	test   %eax,%eax
8010578c:	78 2a                	js     801057b8 <argfd.constprop.0+0x48>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010578e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105792:	77 24                	ja     801057b8 <argfd.constprop.0+0x48>
80105794:	e8 27 e6 ff ff       	call   80103dc0 <myproc>
80105799:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010579c:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
801057a0:	85 c0                	test   %eax,%eax
801057a2:	74 14                	je     801057b8 <argfd.constprop.0+0x48>
  if(pfd)
801057a4:	85 db                	test   %ebx,%ebx
801057a6:	74 02                	je     801057aa <argfd.constprop.0+0x3a>
    *pfd = fd;
801057a8:	89 13                	mov    %edx,(%ebx)
    *pf = f;
801057aa:	89 06                	mov    %eax,(%esi)
  return 0;
801057ac:	31 c0                	xor    %eax,%eax
}
801057ae:	8d 65 f8             	lea    -0x8(%ebp),%esp
801057b1:	5b                   	pop    %ebx
801057b2:	5e                   	pop    %esi
801057b3:	5d                   	pop    %ebp
801057b4:	c3                   	ret    
801057b5:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801057b8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057bd:	eb ef                	jmp    801057ae <argfd.constprop.0+0x3e>
801057bf:	90                   	nop

801057c0 <sys_dup>:
{
801057c0:	f3 0f 1e fb          	endbr32 
801057c4:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
801057c5:	31 c0                	xor    %eax,%eax
{
801057c7:	89 e5                	mov    %esp,%ebp
801057c9:	56                   	push   %esi
801057ca:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
801057cb:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
801057ce:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
801057d1:	e8 9a ff ff ff       	call   80105770 <argfd.constprop.0>
801057d6:	85 c0                	test   %eax,%eax
801057d8:	78 1e                	js     801057f8 <sys_dup+0x38>
  if((fd=fdalloc(f)) < 0)
801057da:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
801057dd:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
801057df:	e8 dc e5 ff ff       	call   80103dc0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801057e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
801057e8:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801057ec:	85 d2                	test   %edx,%edx
801057ee:	74 20                	je     80105810 <sys_dup+0x50>
  for(fd = 0; fd < NOFILE; fd++){
801057f0:	83 c3 01             	add    $0x1,%ebx
801057f3:	83 fb 10             	cmp    $0x10,%ebx
801057f6:	75 f0                	jne    801057e8 <sys_dup+0x28>
}
801057f8:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
801057fb:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80105800:	89 d8                	mov    %ebx,%eax
80105802:	5b                   	pop    %ebx
80105803:	5e                   	pop    %esi
80105804:	5d                   	pop    %ebp
80105805:	c3                   	ret    
80105806:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010580d:	8d 76 00             	lea    0x0(%esi),%esi
      curproc->ofile[fd] = f;
80105810:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80105814:	83 ec 0c             	sub    $0xc,%esp
80105817:	ff 75 f4             	pushl  -0xc(%ebp)
8010581a:	e8 31 ba ff ff       	call   80101250 <filedup>
  return fd;
8010581f:	83 c4 10             	add    $0x10,%esp
}
80105822:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105825:	89 d8                	mov    %ebx,%eax
80105827:	5b                   	pop    %ebx
80105828:	5e                   	pop    %esi
80105829:	5d                   	pop    %ebp
8010582a:	c3                   	ret    
8010582b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010582f:	90                   	nop

80105830 <sys_read>:
{
80105830:	f3 0f 1e fb          	endbr32 
80105834:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105835:	31 c0                	xor    %eax,%eax
{
80105837:	89 e5                	mov    %esp,%ebp
80105839:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
8010583c:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010583f:	e8 2c ff ff ff       	call   80105770 <argfd.constprop.0>
80105844:	85 c0                	test   %eax,%eax
80105846:	78 48                	js     80105890 <sys_read+0x60>
80105848:	83 ec 08             	sub    $0x8,%esp
8010584b:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010584e:	50                   	push   %eax
8010584f:	6a 02                	push   $0x2
80105851:	e8 1a fc ff ff       	call   80105470 <argint>
80105856:	83 c4 10             	add    $0x10,%esp
80105859:	85 c0                	test   %eax,%eax
8010585b:	78 33                	js     80105890 <sys_read+0x60>
8010585d:	83 ec 04             	sub    $0x4,%esp
80105860:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105863:	ff 75 f0             	pushl  -0x10(%ebp)
80105866:	50                   	push   %eax
80105867:	6a 01                	push   $0x1
80105869:	e8 52 fc ff ff       	call   801054c0 <argptr>
8010586e:	83 c4 10             	add    $0x10,%esp
80105871:	85 c0                	test   %eax,%eax
80105873:	78 1b                	js     80105890 <sys_read+0x60>
  return fileread(f, p, n);
80105875:	83 ec 04             	sub    $0x4,%esp
80105878:	ff 75 f0             	pushl  -0x10(%ebp)
8010587b:	ff 75 f4             	pushl  -0xc(%ebp)
8010587e:	ff 75 ec             	pushl  -0x14(%ebp)
80105881:	e8 4a bb ff ff       	call   801013d0 <fileread>
80105886:	83 c4 10             	add    $0x10,%esp
}
80105889:	c9                   	leave  
8010588a:	c3                   	ret    
8010588b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010588f:	90                   	nop
80105890:	c9                   	leave  
    return -1;
80105891:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105896:	c3                   	ret    
80105897:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010589e:	66 90                	xchg   %ax,%ax

801058a0 <sys_write>:
{
801058a0:	f3 0f 1e fb          	endbr32 
801058a4:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801058a5:	31 c0                	xor    %eax,%eax
{
801058a7:	89 e5                	mov    %esp,%ebp
801058a9:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801058ac:	8d 55 ec             	lea    -0x14(%ebp),%edx
801058af:	e8 bc fe ff ff       	call   80105770 <argfd.constprop.0>
801058b4:	85 c0                	test   %eax,%eax
801058b6:	78 48                	js     80105900 <sys_write+0x60>
801058b8:	83 ec 08             	sub    $0x8,%esp
801058bb:	8d 45 f0             	lea    -0x10(%ebp),%eax
801058be:	50                   	push   %eax
801058bf:	6a 02                	push   $0x2
801058c1:	e8 aa fb ff ff       	call   80105470 <argint>
801058c6:	83 c4 10             	add    $0x10,%esp
801058c9:	85 c0                	test   %eax,%eax
801058cb:	78 33                	js     80105900 <sys_write+0x60>
801058cd:	83 ec 04             	sub    $0x4,%esp
801058d0:	8d 45 f4             	lea    -0xc(%ebp),%eax
801058d3:	ff 75 f0             	pushl  -0x10(%ebp)
801058d6:	50                   	push   %eax
801058d7:	6a 01                	push   $0x1
801058d9:	e8 e2 fb ff ff       	call   801054c0 <argptr>
801058de:	83 c4 10             	add    $0x10,%esp
801058e1:	85 c0                	test   %eax,%eax
801058e3:	78 1b                	js     80105900 <sys_write+0x60>
  return filewrite(f, p, n);
801058e5:	83 ec 04             	sub    $0x4,%esp
801058e8:	ff 75 f0             	pushl  -0x10(%ebp)
801058eb:	ff 75 f4             	pushl  -0xc(%ebp)
801058ee:	ff 75 ec             	pushl  -0x14(%ebp)
801058f1:	e8 7a bb ff ff       	call   80101470 <filewrite>
801058f6:	83 c4 10             	add    $0x10,%esp
}
801058f9:	c9                   	leave  
801058fa:	c3                   	ret    
801058fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801058ff:	90                   	nop
80105900:	c9                   	leave  
    return -1;
80105901:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105906:	c3                   	ret    
80105907:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010590e:	66 90                	xchg   %ax,%ax

80105910 <sys_close>:
{
80105910:	f3 0f 1e fb          	endbr32 
80105914:	55                   	push   %ebp
80105915:	89 e5                	mov    %esp,%ebp
80105917:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, &fd, &f) < 0)
8010591a:	8d 55 f4             	lea    -0xc(%ebp),%edx
8010591d:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105920:	e8 4b fe ff ff       	call   80105770 <argfd.constprop.0>
80105925:	85 c0                	test   %eax,%eax
80105927:	78 27                	js     80105950 <sys_close+0x40>
  myproc()->ofile[fd] = 0;
80105929:	e8 92 e4 ff ff       	call   80103dc0 <myproc>
8010592e:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
80105931:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80105934:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
8010593b:	00 
  fileclose(f);
8010593c:	ff 75 f4             	pushl  -0xc(%ebp)
8010593f:	e8 5c b9 ff ff       	call   801012a0 <fileclose>
  return 0;
80105944:	83 c4 10             	add    $0x10,%esp
80105947:	31 c0                	xor    %eax,%eax
}
80105949:	c9                   	leave  
8010594a:	c3                   	ret    
8010594b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010594f:	90                   	nop
80105950:	c9                   	leave  
    return -1;
80105951:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105956:	c3                   	ret    
80105957:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010595e:	66 90                	xchg   %ax,%ax

80105960 <sys_fstat>:
{
80105960:	f3 0f 1e fb          	endbr32 
80105964:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105965:	31 c0                	xor    %eax,%eax
{
80105967:	89 e5                	mov    %esp,%ebp
80105969:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
8010596c:	8d 55 f0             	lea    -0x10(%ebp),%edx
8010596f:	e8 fc fd ff ff       	call   80105770 <argfd.constprop.0>
80105974:	85 c0                	test   %eax,%eax
80105976:	78 30                	js     801059a8 <sys_fstat+0x48>
80105978:	83 ec 04             	sub    $0x4,%esp
8010597b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010597e:	6a 14                	push   $0x14
80105980:	50                   	push   %eax
80105981:	6a 01                	push   $0x1
80105983:	e8 38 fb ff ff       	call   801054c0 <argptr>
80105988:	83 c4 10             	add    $0x10,%esp
8010598b:	85 c0                	test   %eax,%eax
8010598d:	78 19                	js     801059a8 <sys_fstat+0x48>
  return filestat(f, st);
8010598f:	83 ec 08             	sub    $0x8,%esp
80105992:	ff 75 f4             	pushl  -0xc(%ebp)
80105995:	ff 75 f0             	pushl  -0x10(%ebp)
80105998:	e8 e3 b9 ff ff       	call   80101380 <filestat>
8010599d:	83 c4 10             	add    $0x10,%esp
}
801059a0:	c9                   	leave  
801059a1:	c3                   	ret    
801059a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801059a8:	c9                   	leave  
    return -1;
801059a9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801059ae:	c3                   	ret    
801059af:	90                   	nop

801059b0 <sys_link>:
{
801059b0:	f3 0f 1e fb          	endbr32 
801059b4:	55                   	push   %ebp
801059b5:	89 e5                	mov    %esp,%ebp
801059b7:	57                   	push   %edi
801059b8:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801059b9:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
801059bc:	53                   	push   %ebx
801059bd:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801059c0:	50                   	push   %eax
801059c1:	6a 00                	push   $0x0
801059c3:	e8 58 fb ff ff       	call   80105520 <argstr>
801059c8:	83 c4 10             	add    $0x10,%esp
801059cb:	85 c0                	test   %eax,%eax
801059cd:	0f 88 ff 00 00 00    	js     80105ad2 <sys_link+0x122>
801059d3:	83 ec 08             	sub    $0x8,%esp
801059d6:	8d 45 d0             	lea    -0x30(%ebp),%eax
801059d9:	50                   	push   %eax
801059da:	6a 01                	push   $0x1
801059dc:	e8 3f fb ff ff       	call   80105520 <argstr>
801059e1:	83 c4 10             	add    $0x10,%esp
801059e4:	85 c0                	test   %eax,%eax
801059e6:	0f 88 e6 00 00 00    	js     80105ad2 <sys_link+0x122>
  begin_op();
801059ec:	e8 3f d7 ff ff       	call   80103130 <begin_op>
  if((ip = namei(old)) == 0){
801059f1:	83 ec 0c             	sub    $0xc,%esp
801059f4:	ff 75 d4             	pushl  -0x2c(%ebp)
801059f7:	e8 14 ca ff ff       	call   80102410 <namei>
801059fc:	83 c4 10             	add    $0x10,%esp
801059ff:	89 c3                	mov    %eax,%ebx
80105a01:	85 c0                	test   %eax,%eax
80105a03:	0f 84 e8 00 00 00    	je     80105af1 <sys_link+0x141>
  ilock(ip);
80105a09:	83 ec 0c             	sub    $0xc,%esp
80105a0c:	50                   	push   %eax
80105a0d:	e8 2e c1 ff ff       	call   80101b40 <ilock>
  if(ip->type == T_DIR){
80105a12:	83 c4 10             	add    $0x10,%esp
80105a15:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105a1a:	0f 84 b9 00 00 00    	je     80105ad9 <sys_link+0x129>
  iupdate(ip);
80105a20:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
80105a23:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
80105a28:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80105a2b:	53                   	push   %ebx
80105a2c:	e8 4f c0 ff ff       	call   80101a80 <iupdate>
  iunlock(ip);
80105a31:	89 1c 24             	mov    %ebx,(%esp)
80105a34:	e8 e7 c1 ff ff       	call   80101c20 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105a39:	58                   	pop    %eax
80105a3a:	5a                   	pop    %edx
80105a3b:	57                   	push   %edi
80105a3c:	ff 75 d0             	pushl  -0x30(%ebp)
80105a3f:	e8 ec c9 ff ff       	call   80102430 <nameiparent>
80105a44:	83 c4 10             	add    $0x10,%esp
80105a47:	89 c6                	mov    %eax,%esi
80105a49:	85 c0                	test   %eax,%eax
80105a4b:	74 5f                	je     80105aac <sys_link+0xfc>
  ilock(dp);
80105a4d:	83 ec 0c             	sub    $0xc,%esp
80105a50:	50                   	push   %eax
80105a51:	e8 ea c0 ff ff       	call   80101b40 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105a56:	8b 03                	mov    (%ebx),%eax
80105a58:	83 c4 10             	add    $0x10,%esp
80105a5b:	39 06                	cmp    %eax,(%esi)
80105a5d:	75 41                	jne    80105aa0 <sys_link+0xf0>
80105a5f:	83 ec 04             	sub    $0x4,%esp
80105a62:	ff 73 04             	pushl  0x4(%ebx)
80105a65:	57                   	push   %edi
80105a66:	56                   	push   %esi
80105a67:	e8 e4 c8 ff ff       	call   80102350 <dirlink>
80105a6c:	83 c4 10             	add    $0x10,%esp
80105a6f:	85 c0                	test   %eax,%eax
80105a71:	78 2d                	js     80105aa0 <sys_link+0xf0>
  iunlockput(dp);
80105a73:	83 ec 0c             	sub    $0xc,%esp
80105a76:	56                   	push   %esi
80105a77:	e8 64 c3 ff ff       	call   80101de0 <iunlockput>
  iput(ip);
80105a7c:	89 1c 24             	mov    %ebx,(%esp)
80105a7f:	e8 ec c1 ff ff       	call   80101c70 <iput>
  end_op();
80105a84:	e8 17 d7 ff ff       	call   801031a0 <end_op>
  return 0;
80105a89:	83 c4 10             	add    $0x10,%esp
80105a8c:	31 c0                	xor    %eax,%eax
}
80105a8e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105a91:	5b                   	pop    %ebx
80105a92:	5e                   	pop    %esi
80105a93:	5f                   	pop    %edi
80105a94:	5d                   	pop    %ebp
80105a95:	c3                   	ret    
80105a96:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a9d:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(dp);
80105aa0:	83 ec 0c             	sub    $0xc,%esp
80105aa3:	56                   	push   %esi
80105aa4:	e8 37 c3 ff ff       	call   80101de0 <iunlockput>
    goto bad;
80105aa9:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80105aac:	83 ec 0c             	sub    $0xc,%esp
80105aaf:	53                   	push   %ebx
80105ab0:	e8 8b c0 ff ff       	call   80101b40 <ilock>
  ip->nlink--;
80105ab5:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105aba:	89 1c 24             	mov    %ebx,(%esp)
80105abd:	e8 be bf ff ff       	call   80101a80 <iupdate>
  iunlockput(ip);
80105ac2:	89 1c 24             	mov    %ebx,(%esp)
80105ac5:	e8 16 c3 ff ff       	call   80101de0 <iunlockput>
  end_op();
80105aca:	e8 d1 d6 ff ff       	call   801031a0 <end_op>
  return -1;
80105acf:	83 c4 10             	add    $0x10,%esp
80105ad2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ad7:	eb b5                	jmp    80105a8e <sys_link+0xde>
    iunlockput(ip);
80105ad9:	83 ec 0c             	sub    $0xc,%esp
80105adc:	53                   	push   %ebx
80105add:	e8 fe c2 ff ff       	call   80101de0 <iunlockput>
    end_op();
80105ae2:	e8 b9 d6 ff ff       	call   801031a0 <end_op>
    return -1;
80105ae7:	83 c4 10             	add    $0x10,%esp
80105aea:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105aef:	eb 9d                	jmp    80105a8e <sys_link+0xde>
    end_op();
80105af1:	e8 aa d6 ff ff       	call   801031a0 <end_op>
    return -1;
80105af6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105afb:	eb 91                	jmp    80105a8e <sys_link+0xde>
80105afd:	8d 76 00             	lea    0x0(%esi),%esi

80105b00 <sys_unlink>:
{
80105b00:	f3 0f 1e fb          	endbr32 
80105b04:	55                   	push   %ebp
80105b05:	89 e5                	mov    %esp,%ebp
80105b07:	57                   	push   %edi
80105b08:	56                   	push   %esi
  if(argstr(0, &path) < 0)
80105b09:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80105b0c:	53                   	push   %ebx
80105b0d:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
80105b10:	50                   	push   %eax
80105b11:	6a 00                	push   $0x0
80105b13:	e8 08 fa ff ff       	call   80105520 <argstr>
80105b18:	83 c4 10             	add    $0x10,%esp
80105b1b:	85 c0                	test   %eax,%eax
80105b1d:	0f 88 7d 01 00 00    	js     80105ca0 <sys_unlink+0x1a0>
  begin_op();
80105b23:	e8 08 d6 ff ff       	call   80103130 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105b28:	8d 5d ca             	lea    -0x36(%ebp),%ebx
80105b2b:	83 ec 08             	sub    $0x8,%esp
80105b2e:	53                   	push   %ebx
80105b2f:	ff 75 c0             	pushl  -0x40(%ebp)
80105b32:	e8 f9 c8 ff ff       	call   80102430 <nameiparent>
80105b37:	83 c4 10             	add    $0x10,%esp
80105b3a:	89 c6                	mov    %eax,%esi
80105b3c:	85 c0                	test   %eax,%eax
80105b3e:	0f 84 66 01 00 00    	je     80105caa <sys_unlink+0x1aa>
  ilock(dp);
80105b44:	83 ec 0c             	sub    $0xc,%esp
80105b47:	50                   	push   %eax
80105b48:	e8 f3 bf ff ff       	call   80101b40 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105b4d:	58                   	pop    %eax
80105b4e:	5a                   	pop    %edx
80105b4f:	68 94 87 10 80       	push   $0x80108794
80105b54:	53                   	push   %ebx
80105b55:	e8 16 c5 ff ff       	call   80102070 <namecmp>
80105b5a:	83 c4 10             	add    $0x10,%esp
80105b5d:	85 c0                	test   %eax,%eax
80105b5f:	0f 84 03 01 00 00    	je     80105c68 <sys_unlink+0x168>
80105b65:	83 ec 08             	sub    $0x8,%esp
80105b68:	68 93 87 10 80       	push   $0x80108793
80105b6d:	53                   	push   %ebx
80105b6e:	e8 fd c4 ff ff       	call   80102070 <namecmp>
80105b73:	83 c4 10             	add    $0x10,%esp
80105b76:	85 c0                	test   %eax,%eax
80105b78:	0f 84 ea 00 00 00    	je     80105c68 <sys_unlink+0x168>
  if((ip = dirlookup(dp, name, &off)) == 0)
80105b7e:	83 ec 04             	sub    $0x4,%esp
80105b81:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105b84:	50                   	push   %eax
80105b85:	53                   	push   %ebx
80105b86:	56                   	push   %esi
80105b87:	e8 04 c5 ff ff       	call   80102090 <dirlookup>
80105b8c:	83 c4 10             	add    $0x10,%esp
80105b8f:	89 c3                	mov    %eax,%ebx
80105b91:	85 c0                	test   %eax,%eax
80105b93:	0f 84 cf 00 00 00    	je     80105c68 <sys_unlink+0x168>
  ilock(ip);
80105b99:	83 ec 0c             	sub    $0xc,%esp
80105b9c:	50                   	push   %eax
80105b9d:	e8 9e bf ff ff       	call   80101b40 <ilock>
  if(ip->nlink < 1)
80105ba2:	83 c4 10             	add    $0x10,%esp
80105ba5:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80105baa:	0f 8e 23 01 00 00    	jle    80105cd3 <sys_unlink+0x1d3>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105bb0:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105bb5:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105bb8:	74 66                	je     80105c20 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
80105bba:	83 ec 04             	sub    $0x4,%esp
80105bbd:	6a 10                	push   $0x10
80105bbf:	6a 00                	push   $0x0
80105bc1:	57                   	push   %edi
80105bc2:	e8 c9 f5 ff ff       	call   80105190 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105bc7:	6a 10                	push   $0x10
80105bc9:	ff 75 c4             	pushl  -0x3c(%ebp)
80105bcc:	57                   	push   %edi
80105bcd:	56                   	push   %esi
80105bce:	e8 6d c3 ff ff       	call   80101f40 <writei>
80105bd3:	83 c4 20             	add    $0x20,%esp
80105bd6:	83 f8 10             	cmp    $0x10,%eax
80105bd9:	0f 85 e7 00 00 00    	jne    80105cc6 <sys_unlink+0x1c6>
  if(ip->type == T_DIR){
80105bdf:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105be4:	0f 84 96 00 00 00    	je     80105c80 <sys_unlink+0x180>
  iunlockput(dp);
80105bea:	83 ec 0c             	sub    $0xc,%esp
80105bed:	56                   	push   %esi
80105bee:	e8 ed c1 ff ff       	call   80101de0 <iunlockput>
  ip->nlink--;
80105bf3:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105bf8:	89 1c 24             	mov    %ebx,(%esp)
80105bfb:	e8 80 be ff ff       	call   80101a80 <iupdate>
  iunlockput(ip);
80105c00:	89 1c 24             	mov    %ebx,(%esp)
80105c03:	e8 d8 c1 ff ff       	call   80101de0 <iunlockput>
  end_op();
80105c08:	e8 93 d5 ff ff       	call   801031a0 <end_op>
  return 0;
80105c0d:	83 c4 10             	add    $0x10,%esp
80105c10:	31 c0                	xor    %eax,%eax
}
80105c12:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c15:	5b                   	pop    %ebx
80105c16:	5e                   	pop    %esi
80105c17:	5f                   	pop    %edi
80105c18:	5d                   	pop    %ebp
80105c19:	c3                   	ret    
80105c1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105c20:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105c24:	76 94                	jbe    80105bba <sys_unlink+0xba>
80105c26:	ba 20 00 00 00       	mov    $0x20,%edx
80105c2b:	eb 0b                	jmp    80105c38 <sys_unlink+0x138>
80105c2d:	8d 76 00             	lea    0x0(%esi),%esi
80105c30:	83 c2 10             	add    $0x10,%edx
80105c33:	39 53 58             	cmp    %edx,0x58(%ebx)
80105c36:	76 82                	jbe    80105bba <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105c38:	6a 10                	push   $0x10
80105c3a:	52                   	push   %edx
80105c3b:	57                   	push   %edi
80105c3c:	53                   	push   %ebx
80105c3d:	89 55 b4             	mov    %edx,-0x4c(%ebp)
80105c40:	e8 fb c1 ff ff       	call   80101e40 <readi>
80105c45:	83 c4 10             	add    $0x10,%esp
80105c48:	8b 55 b4             	mov    -0x4c(%ebp),%edx
80105c4b:	83 f8 10             	cmp    $0x10,%eax
80105c4e:	75 69                	jne    80105cb9 <sys_unlink+0x1b9>
    if(de.inum != 0)
80105c50:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105c55:	74 d9                	je     80105c30 <sys_unlink+0x130>
    iunlockput(ip);
80105c57:	83 ec 0c             	sub    $0xc,%esp
80105c5a:	53                   	push   %ebx
80105c5b:	e8 80 c1 ff ff       	call   80101de0 <iunlockput>
    goto bad;
80105c60:	83 c4 10             	add    $0x10,%esp
80105c63:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105c67:	90                   	nop
  iunlockput(dp);
80105c68:	83 ec 0c             	sub    $0xc,%esp
80105c6b:	56                   	push   %esi
80105c6c:	e8 6f c1 ff ff       	call   80101de0 <iunlockput>
  end_op();
80105c71:	e8 2a d5 ff ff       	call   801031a0 <end_op>
  return -1;
80105c76:	83 c4 10             	add    $0x10,%esp
80105c79:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c7e:	eb 92                	jmp    80105c12 <sys_unlink+0x112>
    iupdate(dp);
80105c80:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
80105c83:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
80105c88:	56                   	push   %esi
80105c89:	e8 f2 bd ff ff       	call   80101a80 <iupdate>
80105c8e:	83 c4 10             	add    $0x10,%esp
80105c91:	e9 54 ff ff ff       	jmp    80105bea <sys_unlink+0xea>
80105c96:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c9d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105ca0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ca5:	e9 68 ff ff ff       	jmp    80105c12 <sys_unlink+0x112>
    end_op();
80105caa:	e8 f1 d4 ff ff       	call   801031a0 <end_op>
    return -1;
80105caf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105cb4:	e9 59 ff ff ff       	jmp    80105c12 <sys_unlink+0x112>
      panic("isdirempty: readi");
80105cb9:	83 ec 0c             	sub    $0xc,%esp
80105cbc:	68 b8 87 10 80       	push   $0x801087b8
80105cc1:	e8 ca a6 ff ff       	call   80100390 <panic>
    panic("unlink: writei");
80105cc6:	83 ec 0c             	sub    $0xc,%esp
80105cc9:	68 ca 87 10 80       	push   $0x801087ca
80105cce:	e8 bd a6 ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
80105cd3:	83 ec 0c             	sub    $0xc,%esp
80105cd6:	68 a6 87 10 80       	push   $0x801087a6
80105cdb:	e8 b0 a6 ff ff       	call   80100390 <panic>

80105ce0 <sys_open>:

int
sys_open(void)
{
80105ce0:	f3 0f 1e fb          	endbr32 
80105ce4:	55                   	push   %ebp
80105ce5:	89 e5                	mov    %esp,%ebp
80105ce7:	57                   	push   %edi
80105ce8:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105ce9:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105cec:	53                   	push   %ebx
80105ced:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105cf0:	50                   	push   %eax
80105cf1:	6a 00                	push   $0x0
80105cf3:	e8 28 f8 ff ff       	call   80105520 <argstr>
80105cf8:	83 c4 10             	add    $0x10,%esp
80105cfb:	85 c0                	test   %eax,%eax
80105cfd:	0f 88 8a 00 00 00    	js     80105d8d <sys_open+0xad>
80105d03:	83 ec 08             	sub    $0x8,%esp
80105d06:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105d09:	50                   	push   %eax
80105d0a:	6a 01                	push   $0x1
80105d0c:	e8 5f f7 ff ff       	call   80105470 <argint>
80105d11:	83 c4 10             	add    $0x10,%esp
80105d14:	85 c0                	test   %eax,%eax
80105d16:	78 75                	js     80105d8d <sys_open+0xad>
    return -1;

  begin_op();
80105d18:	e8 13 d4 ff ff       	call   80103130 <begin_op>

  if(omode & O_CREATE){
80105d1d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105d21:	75 75                	jne    80105d98 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105d23:	83 ec 0c             	sub    $0xc,%esp
80105d26:	ff 75 e0             	pushl  -0x20(%ebp)
80105d29:	e8 e2 c6 ff ff       	call   80102410 <namei>
80105d2e:	83 c4 10             	add    $0x10,%esp
80105d31:	89 c6                	mov    %eax,%esi
80105d33:	85 c0                	test   %eax,%eax
80105d35:	74 7e                	je     80105db5 <sys_open+0xd5>
      end_op();
      return -1;
    }
    ilock(ip);
80105d37:	83 ec 0c             	sub    $0xc,%esp
80105d3a:	50                   	push   %eax
80105d3b:	e8 00 be ff ff       	call   80101b40 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105d40:	83 c4 10             	add    $0x10,%esp
80105d43:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105d48:	0f 84 c2 00 00 00    	je     80105e10 <sys_open+0x130>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105d4e:	e8 8d b4 ff ff       	call   801011e0 <filealloc>
80105d53:	89 c7                	mov    %eax,%edi
80105d55:	85 c0                	test   %eax,%eax
80105d57:	74 23                	je     80105d7c <sys_open+0x9c>
  struct proc *curproc = myproc();
80105d59:	e8 62 e0 ff ff       	call   80103dc0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105d5e:	31 db                	xor    %ebx,%ebx
    if(curproc->ofile[fd] == 0){
80105d60:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105d64:	85 d2                	test   %edx,%edx
80105d66:	74 60                	je     80105dc8 <sys_open+0xe8>
  for(fd = 0; fd < NOFILE; fd++){
80105d68:	83 c3 01             	add    $0x1,%ebx
80105d6b:	83 fb 10             	cmp    $0x10,%ebx
80105d6e:	75 f0                	jne    80105d60 <sys_open+0x80>
    if(f)
      fileclose(f);
80105d70:	83 ec 0c             	sub    $0xc,%esp
80105d73:	57                   	push   %edi
80105d74:	e8 27 b5 ff ff       	call   801012a0 <fileclose>
80105d79:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80105d7c:	83 ec 0c             	sub    $0xc,%esp
80105d7f:	56                   	push   %esi
80105d80:	e8 5b c0 ff ff       	call   80101de0 <iunlockput>
    end_op();
80105d85:	e8 16 d4 ff ff       	call   801031a0 <end_op>
    return -1;
80105d8a:	83 c4 10             	add    $0x10,%esp
80105d8d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105d92:	eb 6d                	jmp    80105e01 <sys_open+0x121>
80105d94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
80105d98:	83 ec 0c             	sub    $0xc,%esp
80105d9b:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105d9e:	31 c9                	xor    %ecx,%ecx
80105da0:	ba 02 00 00 00       	mov    $0x2,%edx
80105da5:	6a 00                	push   $0x0
80105da7:	e8 24 f8 ff ff       	call   801055d0 <create>
    if(ip == 0){
80105dac:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
80105daf:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80105db1:	85 c0                	test   %eax,%eax
80105db3:	75 99                	jne    80105d4e <sys_open+0x6e>
      end_op();
80105db5:	e8 e6 d3 ff ff       	call   801031a0 <end_op>
      return -1;
80105dba:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105dbf:	eb 40                	jmp    80105e01 <sys_open+0x121>
80105dc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
80105dc8:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105dcb:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
80105dcf:	56                   	push   %esi
80105dd0:	e8 4b be ff ff       	call   80101c20 <iunlock>
  end_op();
80105dd5:	e8 c6 d3 ff ff       	call   801031a0 <end_op>


  f->type = FD_INODE;
80105dda:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105de0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105de3:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105de6:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
80105de9:	89 d0                	mov    %edx,%eax
  f->off = 0;
80105deb:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80105df2:	f7 d0                	not    %eax
80105df4:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105df7:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80105dfa:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105dfd:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80105e01:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105e04:	89 d8                	mov    %ebx,%eax
80105e06:	5b                   	pop    %ebx
80105e07:	5e                   	pop    %esi
80105e08:	5f                   	pop    %edi
80105e09:	5d                   	pop    %ebp
80105e0a:	c3                   	ret    
80105e0b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105e0f:	90                   	nop
    if(ip->type == T_DIR && omode != O_RDONLY){
80105e10:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105e13:	85 c9                	test   %ecx,%ecx
80105e15:	0f 84 33 ff ff ff    	je     80105d4e <sys_open+0x6e>
80105e1b:	e9 5c ff ff ff       	jmp    80105d7c <sys_open+0x9c>

80105e20 <sys_mkdir>:

int
sys_mkdir(void)
{
80105e20:	f3 0f 1e fb          	endbr32 
80105e24:	55                   	push   %ebp
80105e25:	89 e5                	mov    %esp,%ebp
80105e27:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105e2a:	e8 01 d3 ff ff       	call   80103130 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80105e2f:	83 ec 08             	sub    $0x8,%esp
80105e32:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105e35:	50                   	push   %eax
80105e36:	6a 00                	push   $0x0
80105e38:	e8 e3 f6 ff ff       	call   80105520 <argstr>
80105e3d:	83 c4 10             	add    $0x10,%esp
80105e40:	85 c0                	test   %eax,%eax
80105e42:	78 34                	js     80105e78 <sys_mkdir+0x58>
80105e44:	83 ec 0c             	sub    $0xc,%esp
80105e47:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e4a:	31 c9                	xor    %ecx,%ecx
80105e4c:	ba 01 00 00 00       	mov    $0x1,%edx
80105e51:	6a 00                	push   $0x0
80105e53:	e8 78 f7 ff ff       	call   801055d0 <create>
80105e58:	83 c4 10             	add    $0x10,%esp
80105e5b:	85 c0                	test   %eax,%eax
80105e5d:	74 19                	je     80105e78 <sys_mkdir+0x58>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105e5f:	83 ec 0c             	sub    $0xc,%esp
80105e62:	50                   	push   %eax
80105e63:	e8 78 bf ff ff       	call   80101de0 <iunlockput>
  end_op();
80105e68:	e8 33 d3 ff ff       	call   801031a0 <end_op>
  return 0;
80105e6d:	83 c4 10             	add    $0x10,%esp
80105e70:	31 c0                	xor    %eax,%eax
}
80105e72:	c9                   	leave  
80105e73:	c3                   	ret    
80105e74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    end_op();
80105e78:	e8 23 d3 ff ff       	call   801031a0 <end_op>
    return -1;
80105e7d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105e82:	c9                   	leave  
80105e83:	c3                   	ret    
80105e84:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105e8f:	90                   	nop

80105e90 <sys_mknod>:

int
sys_mknod(void)
{
80105e90:	f3 0f 1e fb          	endbr32 
80105e94:	55                   	push   %ebp
80105e95:	89 e5                	mov    %esp,%ebp
80105e97:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105e9a:	e8 91 d2 ff ff       	call   80103130 <begin_op>
  if((argstr(0, &path)) < 0 ||
80105e9f:	83 ec 08             	sub    $0x8,%esp
80105ea2:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105ea5:	50                   	push   %eax
80105ea6:	6a 00                	push   $0x0
80105ea8:	e8 73 f6 ff ff       	call   80105520 <argstr>
80105ead:	83 c4 10             	add    $0x10,%esp
80105eb0:	85 c0                	test   %eax,%eax
80105eb2:	78 64                	js     80105f18 <sys_mknod+0x88>
     argint(1, &major) < 0 ||
80105eb4:	83 ec 08             	sub    $0x8,%esp
80105eb7:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105eba:	50                   	push   %eax
80105ebb:	6a 01                	push   $0x1
80105ebd:	e8 ae f5 ff ff       	call   80105470 <argint>
  if((argstr(0, &path)) < 0 ||
80105ec2:	83 c4 10             	add    $0x10,%esp
80105ec5:	85 c0                	test   %eax,%eax
80105ec7:	78 4f                	js     80105f18 <sys_mknod+0x88>
     argint(2, &minor) < 0 ||
80105ec9:	83 ec 08             	sub    $0x8,%esp
80105ecc:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105ecf:	50                   	push   %eax
80105ed0:	6a 02                	push   $0x2
80105ed2:	e8 99 f5 ff ff       	call   80105470 <argint>
     argint(1, &major) < 0 ||
80105ed7:	83 c4 10             	add    $0x10,%esp
80105eda:	85 c0                	test   %eax,%eax
80105edc:	78 3a                	js     80105f18 <sys_mknod+0x88>
     (ip = create(path, T_DEV, major, minor)) == 0){
80105ede:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
80105ee2:	83 ec 0c             	sub    $0xc,%esp
80105ee5:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105ee9:	ba 03 00 00 00       	mov    $0x3,%edx
80105eee:	50                   	push   %eax
80105eef:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105ef2:	e8 d9 f6 ff ff       	call   801055d0 <create>
     argint(2, &minor) < 0 ||
80105ef7:	83 c4 10             	add    $0x10,%esp
80105efa:	85 c0                	test   %eax,%eax
80105efc:	74 1a                	je     80105f18 <sys_mknod+0x88>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105efe:	83 ec 0c             	sub    $0xc,%esp
80105f01:	50                   	push   %eax
80105f02:	e8 d9 be ff ff       	call   80101de0 <iunlockput>
  end_op();
80105f07:	e8 94 d2 ff ff       	call   801031a0 <end_op>
  return 0;
80105f0c:	83 c4 10             	add    $0x10,%esp
80105f0f:	31 c0                	xor    %eax,%eax
}
80105f11:	c9                   	leave  
80105f12:	c3                   	ret    
80105f13:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105f17:	90                   	nop
    end_op();
80105f18:	e8 83 d2 ff ff       	call   801031a0 <end_op>
    return -1;
80105f1d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105f22:	c9                   	leave  
80105f23:	c3                   	ret    
80105f24:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f2b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105f2f:	90                   	nop

80105f30 <sys_chdir>:

int
sys_chdir(void)
{
80105f30:	f3 0f 1e fb          	endbr32 
80105f34:	55                   	push   %ebp
80105f35:	89 e5                	mov    %esp,%ebp
80105f37:	56                   	push   %esi
80105f38:	53                   	push   %ebx
80105f39:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105f3c:	e8 7f de ff ff       	call   80103dc0 <myproc>
80105f41:	89 c6                	mov    %eax,%esi
  
  begin_op();
80105f43:	e8 e8 d1 ff ff       	call   80103130 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105f48:	83 ec 08             	sub    $0x8,%esp
80105f4b:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105f4e:	50                   	push   %eax
80105f4f:	6a 00                	push   $0x0
80105f51:	e8 ca f5 ff ff       	call   80105520 <argstr>
80105f56:	83 c4 10             	add    $0x10,%esp
80105f59:	85 c0                	test   %eax,%eax
80105f5b:	78 73                	js     80105fd0 <sys_chdir+0xa0>
80105f5d:	83 ec 0c             	sub    $0xc,%esp
80105f60:	ff 75 f4             	pushl  -0xc(%ebp)
80105f63:	e8 a8 c4 ff ff       	call   80102410 <namei>
80105f68:	83 c4 10             	add    $0x10,%esp
80105f6b:	89 c3                	mov    %eax,%ebx
80105f6d:	85 c0                	test   %eax,%eax
80105f6f:	74 5f                	je     80105fd0 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
80105f71:	83 ec 0c             	sub    $0xc,%esp
80105f74:	50                   	push   %eax
80105f75:	e8 c6 bb ff ff       	call   80101b40 <ilock>
  if(ip->type != T_DIR){
80105f7a:	83 c4 10             	add    $0x10,%esp
80105f7d:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105f82:	75 2c                	jne    80105fb0 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105f84:	83 ec 0c             	sub    $0xc,%esp
80105f87:	53                   	push   %ebx
80105f88:	e8 93 bc ff ff       	call   80101c20 <iunlock>
  iput(curproc->cwd);
80105f8d:	58                   	pop    %eax
80105f8e:	ff 76 68             	pushl  0x68(%esi)
80105f91:	e8 da bc ff ff       	call   80101c70 <iput>
  end_op();
80105f96:	e8 05 d2 ff ff       	call   801031a0 <end_op>
  curproc->cwd = ip;
80105f9b:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
80105f9e:	83 c4 10             	add    $0x10,%esp
80105fa1:	31 c0                	xor    %eax,%eax
}
80105fa3:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105fa6:	5b                   	pop    %ebx
80105fa7:	5e                   	pop    %esi
80105fa8:	5d                   	pop    %ebp
80105fa9:	c3                   	ret    
80105faa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(ip);
80105fb0:	83 ec 0c             	sub    $0xc,%esp
80105fb3:	53                   	push   %ebx
80105fb4:	e8 27 be ff ff       	call   80101de0 <iunlockput>
    end_op();
80105fb9:	e8 e2 d1 ff ff       	call   801031a0 <end_op>
    return -1;
80105fbe:	83 c4 10             	add    $0x10,%esp
80105fc1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105fc6:	eb db                	jmp    80105fa3 <sys_chdir+0x73>
80105fc8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105fcf:	90                   	nop
    end_op();
80105fd0:	e8 cb d1 ff ff       	call   801031a0 <end_op>
    return -1;
80105fd5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105fda:	eb c7                	jmp    80105fa3 <sys_chdir+0x73>
80105fdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105fe0 <sys_exec>:

int
sys_exec(void)
{
80105fe0:	f3 0f 1e fb          	endbr32 
80105fe4:	55                   	push   %ebp
80105fe5:	89 e5                	mov    %esp,%ebp
80105fe7:	57                   	push   %edi
80105fe8:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105fe9:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
80105fef:	53                   	push   %ebx
80105ff0:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105ff6:	50                   	push   %eax
80105ff7:	6a 00                	push   $0x0
80105ff9:	e8 22 f5 ff ff       	call   80105520 <argstr>
80105ffe:	83 c4 10             	add    $0x10,%esp
80106001:	85 c0                	test   %eax,%eax
80106003:	0f 88 8b 00 00 00    	js     80106094 <sys_exec+0xb4>
80106009:	83 ec 08             	sub    $0x8,%esp
8010600c:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80106012:	50                   	push   %eax
80106013:	6a 01                	push   $0x1
80106015:	e8 56 f4 ff ff       	call   80105470 <argint>
8010601a:	83 c4 10             	add    $0x10,%esp
8010601d:	85 c0                	test   %eax,%eax
8010601f:	78 73                	js     80106094 <sys_exec+0xb4>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80106021:	83 ec 04             	sub    $0x4,%esp
80106024:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
  for(i=0;; i++){
8010602a:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
8010602c:	68 80 00 00 00       	push   $0x80
80106031:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80106037:	6a 00                	push   $0x0
80106039:	50                   	push   %eax
8010603a:	e8 51 f1 ff ff       	call   80105190 <memset>
8010603f:	83 c4 10             	add    $0x10,%esp
80106042:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80106048:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
8010604e:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80106055:	83 ec 08             	sub    $0x8,%esp
80106058:	57                   	push   %edi
80106059:	01 f0                	add    %esi,%eax
8010605b:	50                   	push   %eax
8010605c:	e8 6f f3 ff ff       	call   801053d0 <fetchint>
80106061:	83 c4 10             	add    $0x10,%esp
80106064:	85 c0                	test   %eax,%eax
80106066:	78 2c                	js     80106094 <sys_exec+0xb4>
      return -1;
    if(uarg == 0){
80106068:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010606e:	85 c0                	test   %eax,%eax
80106070:	74 36                	je     801060a8 <sys_exec+0xc8>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80106072:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80106078:	83 ec 08             	sub    $0x8,%esp
8010607b:	8d 14 31             	lea    (%ecx,%esi,1),%edx
8010607e:	52                   	push   %edx
8010607f:	50                   	push   %eax
80106080:	e8 8b f3 ff ff       	call   80105410 <fetchstr>
80106085:	83 c4 10             	add    $0x10,%esp
80106088:	85 c0                	test   %eax,%eax
8010608a:	78 08                	js     80106094 <sys_exec+0xb4>
  for(i=0;; i++){
8010608c:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
8010608f:	83 fb 20             	cmp    $0x20,%ebx
80106092:	75 b4                	jne    80106048 <sys_exec+0x68>
      return -1;
  }
  return exec(path, argv);
}
80106094:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
80106097:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010609c:	5b                   	pop    %ebx
8010609d:	5e                   	pop    %esi
8010609e:	5f                   	pop    %edi
8010609f:	5d                   	pop    %ebp
801060a0:	c3                   	ret    
801060a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
801060a8:	83 ec 08             	sub    $0x8,%esp
801060ab:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
      argv[i] = 0;
801060b1:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
801060b8:	00 00 00 00 
  return exec(path, argv);
801060bc:	50                   	push   %eax
801060bd:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
801060c3:	e8 88 ad ff ff       	call   80100e50 <exec>
801060c8:	83 c4 10             	add    $0x10,%esp
}
801060cb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801060ce:	5b                   	pop    %ebx
801060cf:	5e                   	pop    %esi
801060d0:	5f                   	pop    %edi
801060d1:	5d                   	pop    %ebp
801060d2:	c3                   	ret    
801060d3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801060da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801060e0 <sys_pipe>:

int
sys_pipe(void)
{
801060e0:	f3 0f 1e fb          	endbr32 
801060e4:	55                   	push   %ebp
801060e5:	89 e5                	mov    %esp,%ebp
801060e7:	57                   	push   %edi
801060e8:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801060e9:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
801060ec:	53                   	push   %ebx
801060ed:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801060f0:	6a 08                	push   $0x8
801060f2:	50                   	push   %eax
801060f3:	6a 00                	push   $0x0
801060f5:	e8 c6 f3 ff ff       	call   801054c0 <argptr>
801060fa:	83 c4 10             	add    $0x10,%esp
801060fd:	85 c0                	test   %eax,%eax
801060ff:	78 4e                	js     8010614f <sys_pipe+0x6f>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80106101:	83 ec 08             	sub    $0x8,%esp
80106104:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106107:	50                   	push   %eax
80106108:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010610b:	50                   	push   %eax
8010610c:	e8 df d6 ff ff       	call   801037f0 <pipealloc>
80106111:	83 c4 10             	add    $0x10,%esp
80106114:	85 c0                	test   %eax,%eax
80106116:	78 37                	js     8010614f <sys_pipe+0x6f>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106118:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
8010611b:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
8010611d:	e8 9e dc ff ff       	call   80103dc0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80106122:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[fd] == 0){
80106128:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
8010612c:	85 f6                	test   %esi,%esi
8010612e:	74 30                	je     80106160 <sys_pipe+0x80>
  for(fd = 0; fd < NOFILE; fd++){
80106130:	83 c3 01             	add    $0x1,%ebx
80106133:	83 fb 10             	cmp    $0x10,%ebx
80106136:	75 f0                	jne    80106128 <sys_pipe+0x48>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
80106138:	83 ec 0c             	sub    $0xc,%esp
8010613b:	ff 75 e0             	pushl  -0x20(%ebp)
8010613e:	e8 5d b1 ff ff       	call   801012a0 <fileclose>
    fileclose(wf);
80106143:	58                   	pop    %eax
80106144:	ff 75 e4             	pushl  -0x1c(%ebp)
80106147:	e8 54 b1 ff ff       	call   801012a0 <fileclose>
    return -1;
8010614c:	83 c4 10             	add    $0x10,%esp
8010614f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106154:	eb 5b                	jmp    801061b1 <sys_pipe+0xd1>
80106156:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010615d:	8d 76 00             	lea    0x0(%esi),%esi
      curproc->ofile[fd] = f;
80106160:	8d 73 08             	lea    0x8(%ebx),%esi
80106163:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106167:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
8010616a:	e8 51 dc ff ff       	call   80103dc0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010616f:	31 d2                	xor    %edx,%edx
80106171:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80106178:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
8010617c:	85 c9                	test   %ecx,%ecx
8010617e:	74 20                	je     801061a0 <sys_pipe+0xc0>
  for(fd = 0; fd < NOFILE; fd++){
80106180:	83 c2 01             	add    $0x1,%edx
80106183:	83 fa 10             	cmp    $0x10,%edx
80106186:	75 f0                	jne    80106178 <sys_pipe+0x98>
      myproc()->ofile[fd0] = 0;
80106188:	e8 33 dc ff ff       	call   80103dc0 <myproc>
8010618d:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80106194:	00 
80106195:	eb a1                	jmp    80106138 <sys_pipe+0x58>
80106197:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010619e:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
801061a0:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
  }
  fd[0] = fd0;
801061a4:	8b 45 dc             	mov    -0x24(%ebp),%eax
801061a7:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
801061a9:	8b 45 dc             	mov    -0x24(%ebp),%eax
801061ac:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
801061af:	31 c0                	xor    %eax,%eax
}
801061b1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801061b4:	5b                   	pop    %ebx
801061b5:	5e                   	pop    %esi
801061b6:	5f                   	pop    %edi
801061b7:	5d                   	pop    %ebp
801061b8:	c3                   	ret    
801061b9:	66 90                	xchg   %ax,%ax
801061bb:	66 90                	xchg   %ax,%ax
801061bd:	66 90                	xchg   %ax,%ax
801061bf:	90                   	nop

801061c0 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
801061c0:	f3 0f 1e fb          	endbr32 
  return fork();
801061c4:	e9 d7 dd ff ff       	jmp    80103fa0 <fork>
801061c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801061d0 <sys_exit>:
}

int
sys_exit(void)
{
801061d0:	f3 0f 1e fb          	endbr32 
801061d4:	55                   	push   %ebp
801061d5:	89 e5                	mov    %esp,%ebp
801061d7:	83 ec 08             	sub    $0x8,%esp
  exit();
801061da:	e8 81 e4 ff ff       	call   80104660 <exit>
  return 0;  // not reached
}
801061df:	31 c0                	xor    %eax,%eax
801061e1:	c9                   	leave  
801061e2:	c3                   	ret    
801061e3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801061ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801061f0 <sys_wait>:

int
sys_wait(void)
{
801061f0:	f3 0f 1e fb          	endbr32 
  return wait();
801061f4:	e9 57 e8 ff ff       	jmp    80104a50 <wait>
801061f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106200 <sys_kill>:
}

int
sys_kill(void)
{
80106200:	f3 0f 1e fb          	endbr32 
80106204:	55                   	push   %ebp
80106205:	89 e5                	mov    %esp,%ebp
80106207:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
8010620a:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010620d:	50                   	push   %eax
8010620e:	6a 00                	push   $0x0
80106210:	e8 5b f2 ff ff       	call   80105470 <argint>
80106215:	83 c4 10             	add    $0x10,%esp
80106218:	85 c0                	test   %eax,%eax
8010621a:	78 14                	js     80106230 <sys_kill+0x30>
    return -1;
  return kill(pid);
8010621c:	83 ec 0c             	sub    $0xc,%esp
8010621f:	ff 75 f4             	pushl  -0xc(%ebp)
80106222:	e8 99 e9 ff ff       	call   80104bc0 <kill>
80106227:	83 c4 10             	add    $0x10,%esp
}
8010622a:	c9                   	leave  
8010622b:	c3                   	ret    
8010622c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106230:	c9                   	leave  
    return -1;
80106231:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106236:	c3                   	ret    
80106237:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010623e:	66 90                	xchg   %ax,%ax

80106240 <sys_getpid>:

int
sys_getpid(void)
{
80106240:	f3 0f 1e fb          	endbr32 
80106244:	55                   	push   %ebp
80106245:	89 e5                	mov    %esp,%ebp
80106247:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
8010624a:	e8 71 db ff ff       	call   80103dc0 <myproc>
8010624f:	8b 40 10             	mov    0x10(%eax),%eax
}
80106252:	c9                   	leave  
80106253:	c3                   	ret    
80106254:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010625b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010625f:	90                   	nop

80106260 <sys_sbrk>:

int
sys_sbrk(void)
{
80106260:	f3 0f 1e fb          	endbr32 
80106264:	55                   	push   %ebp
80106265:	89 e5                	mov    %esp,%ebp
80106267:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80106268:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
8010626b:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010626e:	50                   	push   %eax
8010626f:	6a 00                	push   $0x0
80106271:	e8 fa f1 ff ff       	call   80105470 <argint>
80106276:	83 c4 10             	add    $0x10,%esp
80106279:	85 c0                	test   %eax,%eax
8010627b:	78 23                	js     801062a0 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
8010627d:	e8 3e db ff ff       	call   80103dc0 <myproc>
  if(growproc(n) < 0)
80106282:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80106285:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80106287:	ff 75 f4             	pushl  -0xc(%ebp)
8010628a:	e8 91 dc ff ff       	call   80103f20 <growproc>
8010628f:	83 c4 10             	add    $0x10,%esp
80106292:	85 c0                	test   %eax,%eax
80106294:	78 0a                	js     801062a0 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80106296:	89 d8                	mov    %ebx,%eax
80106298:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010629b:	c9                   	leave  
8010629c:	c3                   	ret    
8010629d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801062a0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801062a5:	eb ef                	jmp    80106296 <sys_sbrk+0x36>
801062a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801062ae:	66 90                	xchg   %ax,%ax

801062b0 <sys_sleep>:

int
sys_sleep(void)
{
801062b0:	f3 0f 1e fb          	endbr32 
801062b4:	55                   	push   %ebp
801062b5:	89 e5                	mov    %esp,%ebp
801062b7:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
801062b8:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801062bb:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
801062be:	50                   	push   %eax
801062bf:	6a 00                	push   $0x0
801062c1:	e8 aa f1 ff ff       	call   80105470 <argint>
801062c6:	83 c4 10             	add    $0x10,%esp
801062c9:	85 c0                	test   %eax,%eax
801062cb:	0f 88 86 00 00 00    	js     80106357 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
801062d1:	83 ec 0c             	sub    $0xc,%esp
801062d4:	68 c0 92 11 80       	push   $0x801192c0
801062d9:	e8 a2 ed ff ff       	call   80105080 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801062de:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
801062e1:	8b 1d 00 9b 11 80    	mov    0x80119b00,%ebx
  while(ticks - ticks0 < n){
801062e7:	83 c4 10             	add    $0x10,%esp
801062ea:	85 d2                	test   %edx,%edx
801062ec:	75 23                	jne    80106311 <sys_sleep+0x61>
801062ee:	eb 50                	jmp    80106340 <sys_sleep+0x90>
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
801062f0:	83 ec 08             	sub    $0x8,%esp
801062f3:	68 c0 92 11 80       	push   $0x801192c0
801062f8:	68 00 9b 11 80       	push   $0x80119b00
801062fd:	e8 8e e6 ff ff       	call   80104990 <sleep>
  while(ticks - ticks0 < n){
80106302:	a1 00 9b 11 80       	mov    0x80119b00,%eax
80106307:	83 c4 10             	add    $0x10,%esp
8010630a:	29 d8                	sub    %ebx,%eax
8010630c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010630f:	73 2f                	jae    80106340 <sys_sleep+0x90>
    if(myproc()->killed){
80106311:	e8 aa da ff ff       	call   80103dc0 <myproc>
80106316:	8b 40 24             	mov    0x24(%eax),%eax
80106319:	85 c0                	test   %eax,%eax
8010631b:	74 d3                	je     801062f0 <sys_sleep+0x40>
      release(&tickslock);
8010631d:	83 ec 0c             	sub    $0xc,%esp
80106320:	68 c0 92 11 80       	push   $0x801192c0
80106325:	e8 16 ee ff ff       	call   80105140 <release>
  }
  release(&tickslock);
  return 0;
}
8010632a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return -1;
8010632d:	83 c4 10             	add    $0x10,%esp
80106330:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106335:	c9                   	leave  
80106336:	c3                   	ret    
80106337:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010633e:	66 90                	xchg   %ax,%ax
  release(&tickslock);
80106340:	83 ec 0c             	sub    $0xc,%esp
80106343:	68 c0 92 11 80       	push   $0x801192c0
80106348:	e8 f3 ed ff ff       	call   80105140 <release>
  return 0;
8010634d:	83 c4 10             	add    $0x10,%esp
80106350:	31 c0                	xor    %eax,%eax
}
80106352:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106355:	c9                   	leave  
80106356:	c3                   	ret    
    return -1;
80106357:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010635c:	eb f4                	jmp    80106352 <sys_sleep+0xa2>
8010635e:	66 90                	xchg   %ax,%ax

80106360 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80106360:	f3 0f 1e fb          	endbr32 
80106364:	55                   	push   %ebp
80106365:	89 e5                	mov    %esp,%ebp
80106367:	53                   	push   %ebx
80106368:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
8010636b:	68 c0 92 11 80       	push   $0x801192c0
80106370:	e8 0b ed ff ff       	call   80105080 <acquire>
  xticks = ticks;
80106375:	8b 1d 00 9b 11 80    	mov    0x80119b00,%ebx
  release(&tickslock);
8010637b:	c7 04 24 c0 92 11 80 	movl   $0x801192c0,(%esp)
80106382:	e8 b9 ed ff ff       	call   80105140 <release>
  return xticks;
}
80106387:	89 d8                	mov    %ebx,%eax
80106389:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010638c:	c9                   	leave  
8010638d:	c3                   	ret    
8010638e:	66 90                	xchg   %ax,%ax

80106390 <sys_printProcess>:

int sys_printProcess(void) {
80106390:	f3 0f 1e fb          	endbr32 
  return printProcess();
80106394:	e9 f7 dd ff ff       	jmp    80104190 <printProcess>
80106399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801063a0 <sys_changeProcessMHRRN>:
}

int sys_changeProcessMHRRN(void) {
801063a0:	f3 0f 1e fb          	endbr32 
801063a4:	55                   	push   %ebp
801063a5:	89 e5                	mov    %esp,%ebp
801063a7:	83 ec 20             	sub    $0x20,%esp
  int pid, priority;
  if (argint(0, &pid) < 0) 
801063aa:	8d 45 f0             	lea    -0x10(%ebp),%eax
801063ad:	50                   	push   %eax
801063ae:	6a 00                	push   $0x0
801063b0:	e8 bb f0 ff ff       	call   80105470 <argint>
801063b5:	83 c4 10             	add    $0x10,%esp
801063b8:	85 c0                	test   %eax,%eax
801063ba:	78 2c                	js     801063e8 <sys_changeProcessMHRRN+0x48>
    return -1;
  if (argint(1, &priority) < 0) 
801063bc:	83 ec 08             	sub    $0x8,%esp
801063bf:	8d 45 f4             	lea    -0xc(%ebp),%eax
801063c2:	50                   	push   %eax
801063c3:	6a 01                	push   $0x1
801063c5:	e8 a6 f0 ff ff       	call   80105470 <argint>
801063ca:	83 c4 10             	add    $0x10,%esp
801063cd:	85 c0                	test   %eax,%eax
801063cf:	78 17                	js     801063e8 <sys_changeProcessMHRRN+0x48>
    return -1;
  return changeProcessMHRRN(pid, priority);
801063d1:	83 ec 08             	sub    $0x8,%esp
801063d4:	ff 75 f4             	pushl  -0xc(%ebp)
801063d7:	ff 75 f0             	pushl  -0x10(%ebp)
801063da:	e8 e1 dc ff ff       	call   801040c0 <changeProcessMHRRN>
801063df:	83 c4 10             	add    $0x10,%esp
}
801063e2:	c9                   	leave  
801063e3:	c3                   	ret    
801063e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801063e8:	c9                   	leave  
    return -1;
801063e9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801063ee:	c3                   	ret    
801063ef:	90                   	nop

801063f0 <sys_changeSystemMHRRN>:

int sys_changeSystemMHRRN(void) {
801063f0:	f3 0f 1e fb          	endbr32 
801063f4:	55                   	push   %ebp
801063f5:	89 e5                	mov    %esp,%ebp
801063f7:	83 ec 20             	sub    $0x20,%esp
  int priority;
  if (argint(0, &priority) < 0) 
801063fa:	8d 45 f4             	lea    -0xc(%ebp),%eax
801063fd:	50                   	push   %eax
801063fe:	6a 00                	push   $0x0
80106400:	e8 6b f0 ff ff       	call   80105470 <argint>
80106405:	83 c4 10             	add    $0x10,%esp
80106408:	85 c0                	test   %eax,%eax
8010640a:	78 14                	js     80106420 <sys_changeSystemMHRRN+0x30>
    return -1;
  return changeSystemMHRRN(priority);
8010640c:	83 ec 0c             	sub    $0xc,%esp
8010640f:	ff 75 f4             	pushl  -0xc(%ebp)
80106412:	e8 29 dd ff ff       	call   80104140 <changeSystemMHRRN>
80106417:	83 c4 10             	add    $0x10,%esp
}
8010641a:	c9                   	leave  
8010641b:	c3                   	ret    
8010641c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106420:	c9                   	leave  
    return -1;
80106421:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106426:	c3                   	ret    
80106427:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010642e:	66 90                	xchg   %ax,%ax

80106430 <sys_sem_init>:


int sys_sem_init(void)
{
80106430:	f3 0f 1e fb          	endbr32 
80106434:	55                   	push   %ebp
80106435:	89 e5                	mov    %esp,%ebp
80106437:	83 ec 20             	sub    $0x20,%esp
  int i, v;
  if (argint(0, &i) < 0) 
8010643a:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010643d:	50                   	push   %eax
8010643e:	6a 00                	push   $0x0
80106440:	e8 2b f0 ff ff       	call   80105470 <argint>
80106445:	83 c4 10             	add    $0x10,%esp
80106448:	85 c0                	test   %eax,%eax
8010644a:	78 2c                	js     80106478 <sys_sem_init+0x48>
    return -1;
  if (argint(1, &v) < 0) 
8010644c:	83 ec 08             	sub    $0x8,%esp
8010644f:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106452:	50                   	push   %eax
80106453:	6a 01                	push   $0x1
80106455:	e8 16 f0 ff ff       	call   80105470 <argint>
8010645a:	83 c4 10             	add    $0x10,%esp
8010645d:	85 c0                	test   %eax,%eax
8010645f:	78 17                	js     80106478 <sys_sem_init+0x48>
    return -1;
  return sem_init(i, v);
80106461:	83 ec 08             	sub    $0x8,%esp
80106464:	ff 75 f4             	pushl  -0xc(%ebp)
80106467:	ff 75 f0             	pushl  -0x10(%ebp)
8010646a:	e8 01 e4 ff ff       	call   80104870 <sem_init>
8010646f:	83 c4 10             	add    $0x10,%esp
}
80106472:	c9                   	leave  
80106473:	c3                   	ret    
80106474:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106478:	c9                   	leave  
    return -1;
80106479:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010647e:	c3                   	ret    
8010647f:	90                   	nop

80106480 <sys_sem_acquire>:

int sys_sem_acquire(void)
{
80106480:	f3 0f 1e fb          	endbr32 
80106484:	55                   	push   %ebp
80106485:	89 e5                	mov    %esp,%ebp
80106487:	83 ec 20             	sub    $0x20,%esp
  int i;
  if (argint(0, &i) < 0) 
8010648a:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010648d:	50                   	push   %eax
8010648e:	6a 00                	push   $0x0
80106490:	e8 db ef ff ff       	call   80105470 <argint>
80106495:	83 c4 10             	add    $0x10,%esp
80106498:	85 c0                	test   %eax,%eax
8010649a:	78 14                	js     801064b0 <sys_sem_acquire+0x30>
    return -1;

  return sem_acquire(i);
8010649c:	83 ec 0c             	sub    $0xc,%esp
8010649f:	ff 75 f4             	pushl  -0xc(%ebp)
801064a2:	e8 f9 e3 ff ff       	call   801048a0 <sem_acquire>
801064a7:	83 c4 10             	add    $0x10,%esp
}
801064aa:	c9                   	leave  
801064ab:	c3                   	ret    
801064ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801064b0:	c9                   	leave  
    return -1;
801064b1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801064b6:	c3                   	ret    
801064b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801064be:	66 90                	xchg   %ax,%ax

801064c0 <sys_sem_release>:

int sys_sem_release(void)
{
801064c0:	f3 0f 1e fb          	endbr32 
801064c4:	55                   	push   %ebp
801064c5:	89 e5                	mov    %esp,%ebp
801064c7:	83 ec 20             	sub    $0x20,%esp
  int i;
  if (argint(0, &i) < 0) 
801064ca:	8d 45 f4             	lea    -0xc(%ebp),%eax
801064cd:	50                   	push   %eax
801064ce:	6a 00                	push   $0x0
801064d0:	e8 9b ef ff ff       	call   80105470 <argint>
801064d5:	83 c4 10             	add    $0x10,%esp
801064d8:	85 c0                	test   %eax,%eax
801064da:	78 14                	js     801064f0 <sys_sem_release+0x30>
    return -1;
  return sem_release(i);
801064dc:	83 ec 0c             	sub    $0xc,%esp
801064df:	ff 75 f4             	pushl  -0xc(%ebp)
801064e2:	e8 39 e4 ff ff       	call   80104920 <sem_release>
801064e7:	83 c4 10             	add    $0x10,%esp
}
801064ea:	c9                   	leave  
801064eb:	c3                   	ret    
801064ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801064f0:	c9                   	leave  
    return -1;
801064f1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801064f6:	c3                   	ret    
801064f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801064fe:	66 90                	xchg   %ax,%ax

80106500 <sys_mmap>:

int sys_mmap(void) 
{
80106500:	f3 0f 1e fb          	endbr32 
80106504:	55                   	push   %ebp
80106505:	89 e5                	mov    %esp,%ebp
80106507:	83 ec 30             	sub    $0x30,%esp
  int addr = 0;
  int length;
  int prot, flag, fd, offset;
  argint(1, &length);
8010650a:	8d 45 e4             	lea    -0x1c(%ebp),%eax
8010650d:	50                   	push   %eax
8010650e:	6a 01                	push   $0x1
80106510:	e8 5b ef ff ff       	call   80105470 <argint>
  argint(2, &prot);
80106515:	58                   	pop    %eax
80106516:	8d 45 e8             	lea    -0x18(%ebp),%eax
80106519:	5a                   	pop    %edx
8010651a:	50                   	push   %eax
8010651b:	6a 02                	push   $0x2
8010651d:	e8 4e ef ff ff       	call   80105470 <argint>
  argint(3, &flag);
80106522:	59                   	pop    %ecx
80106523:	58                   	pop    %eax
80106524:	8d 45 ec             	lea    -0x14(%ebp),%eax
80106527:	50                   	push   %eax
80106528:	6a 03                	push   $0x3
8010652a:	e8 41 ef ff ff       	call   80105470 <argint>
  argint(4, &fd);
8010652f:	58                   	pop    %eax
80106530:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106533:	5a                   	pop    %edx
80106534:	50                   	push   %eax
80106535:	6a 04                	push   $0x4
80106537:	e8 34 ef ff ff       	call   80105470 <argint>
  argint(5, &offset);
8010653c:	59                   	pop    %ecx
8010653d:	58                   	pop    %eax
8010653e:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106541:	50                   	push   %eax
80106542:	6a 05                	push   $0x5
80106544:	e8 27 ef ff ff       	call   80105470 <argint>

  int a = mmap(addr, length, prot, flag, fd, offset);
80106549:	58                   	pop    %eax
8010654a:	5a                   	pop    %edx
8010654b:	ff 75 f4             	pushl  -0xc(%ebp)
8010654e:	ff 75 f0             	pushl  -0x10(%ebp)
80106551:	ff 75 ec             	pushl  -0x14(%ebp)
80106554:	ff 75 e8             	pushl  -0x18(%ebp)
80106557:	ff 75 e4             	pushl  -0x1c(%ebp)
8010655a:	6a 00                	push   $0x0
8010655c:	e8 cf e7 ff ff       	call   80104d30 <mmap>
  return a;
}
80106561:	c9                   	leave  
80106562:	c3                   	ret    
80106563:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010656a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106570 <sys_get_free_pages_count>:

int sys_get_free_pages_count(void)
{
80106570:	f3 0f 1e fb          	endbr32 
  return get_free_pages_count();
80106574:	e9 37 e8 ff ff       	jmp    80104db0 <get_free_pages_count>

80106579 <alltraps>:
80106579:	1e                   	push   %ds
8010657a:	06                   	push   %es
8010657b:	0f a0                	push   %fs
8010657d:	0f a8                	push   %gs
8010657f:	60                   	pusha  
80106580:	66 b8 10 00          	mov    $0x10,%ax
80106584:	8e d8                	mov    %eax,%ds
80106586:	8e c0                	mov    %eax,%es
80106588:	54                   	push   %esp
80106589:	e8 d2 01 00 00       	call   80106760 <trap>
8010658e:	83 c4 04             	add    $0x4,%esp

80106591 <trapret>:
80106591:	61                   	popa   
80106592:	0f a9                	pop    %gs
80106594:	0f a1                	pop    %fs
80106596:	07                   	pop    %es
80106597:	1f                   	pop    %ds
80106598:	83 c4 08             	add    $0x8,%esp
8010659b:	cf                   	iret   
8010659c:	66 90                	xchg   %ax,%ax
8010659e:	66 90                	xchg   %ax,%ax

801065a0 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
801065a0:	f3 0f 1e fb          	endbr32 
801065a4:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
801065a5:	31 c0                	xor    %eax,%eax
{
801065a7:	89 e5                	mov    %esp,%ebp
801065a9:	83 ec 08             	sub    $0x8,%esp
801065ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
801065b0:	8b 14 85 0c b0 10 80 	mov    -0x7fef4ff4(,%eax,4),%edx
801065b7:	c7 04 c5 02 93 11 80 	movl   $0x8e000008,-0x7fee6cfe(,%eax,8)
801065be:	08 00 00 8e 
801065c2:	66 89 14 c5 00 93 11 	mov    %dx,-0x7fee6d00(,%eax,8)
801065c9:	80 
801065ca:	c1 ea 10             	shr    $0x10,%edx
801065cd:	66 89 14 c5 06 93 11 	mov    %dx,-0x7fee6cfa(,%eax,8)
801065d4:	80 
  for(i = 0; i < 256; i++)
801065d5:	83 c0 01             	add    $0x1,%eax
801065d8:	3d 00 01 00 00       	cmp    $0x100,%eax
801065dd:	75 d1                	jne    801065b0 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
801065df:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801065e2:	a1 0c b1 10 80       	mov    0x8010b10c,%eax
801065e7:	c7 05 02 95 11 80 08 	movl   $0xef000008,0x80119502
801065ee:	00 00 ef 
  initlock(&tickslock, "time");
801065f1:	68 d9 87 10 80       	push   $0x801087d9
801065f6:	68 c0 92 11 80       	push   $0x801192c0
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801065fb:	66 a3 00 95 11 80    	mov    %ax,0x80119500
80106601:	c1 e8 10             	shr    $0x10,%eax
80106604:	66 a3 06 95 11 80    	mov    %ax,0x80119506
  initlock(&tickslock, "time");
8010660a:	e8 f1 e8 ff ff       	call   80104f00 <initlock>
}
8010660f:	83 c4 10             	add    $0x10,%esp
80106612:	c9                   	leave  
80106613:	c3                   	ret    
80106614:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010661b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010661f:	90                   	nop

80106620 <idtinit>:

void
idtinit(void)
{
80106620:	f3 0f 1e fb          	endbr32 
80106624:	55                   	push   %ebp
  pd[0] = size-1;
80106625:	b8 ff 07 00 00       	mov    $0x7ff,%eax
8010662a:	89 e5                	mov    %esp,%ebp
8010662c:	83 ec 10             	sub    $0x10,%esp
8010662f:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80106633:	b8 00 93 11 80       	mov    $0x80119300,%eax
80106638:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
8010663c:	c1 e8 10             	shr    $0x10,%eax
8010663f:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80106643:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106646:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80106649:	c9                   	leave  
8010664a:	c3                   	ret    
8010664b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010664f:	90                   	nop

80106650 <pageFaultHandler>:

extern int mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm);

int pageFaultHandler(void)
{
80106650:	f3 0f 1e fb          	endbr32 
80106654:	55                   	push   %ebp
80106655:	89 e5                	mov    %esp,%ebp
80106657:	57                   	push   %edi
80106658:	56                   	push   %esi
80106659:	53                   	push   %ebx
8010665a:	83 ec 1c             	sub    $0x1c,%esp
  struct proc *p = myproc();
8010665d:	e8 5e d7 ff ff       	call   80103dc0 <myproc>
80106662:	89 c7                	mov    %eax,%edi

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80106664:	0f 20 d6             	mov    %cr2,%esi
  uint addr = rcr2();
  // uint new_index = 0;
  int i = 0; 
  for(i = 0; i < 8; i++) {
80106667:	31 db                	xor    %ebx,%ebx
80106669:	8d 80 94 00 00 00    	lea    0x94(%eax),%eax
8010666f:	90                   	nop
    if((addr >= p->files[i].start_addr) && (addr < p->files[i].start_addr+p->files[i].length))
80106670:	8b 08                	mov    (%eax),%ecx
80106672:	39 f1                	cmp    %esi,%ecx
80106674:	77 07                	ja     8010667d <pageFaultHandler+0x2d>
80106676:	03 48 0c             	add    0xc(%eax),%ecx
80106679:	39 f1                	cmp    %esi,%ecx
8010667b:	77 1b                	ja     80106698 <pageFaultHandler+0x48>
  for(i = 0; i < 8; i++) {
8010667d:	83 c3 01             	add    $0x1,%ebx
80106680:	83 c0 18             	add    $0x18,%eax
80106683:	83 fb 08             	cmp    $0x8,%ebx
80106686:	75 e8                	jne    80106670 <pageFaultHandler+0x20>
    return 0;
  }
  // read from file
  if(p->ofile[p->files[i].fd] == 0) {
    cprintf("File is not opened\n");
    return 0;
80106688:	31 c0                	xor    %eax,%eax
  struct file* fd = p->ofile[p->files[i].fd];
  fileread(fd, mem, PGSIZE);

  cprintf("Address: %x\n", addr);
  return 1;
}
8010668a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010668d:	5b                   	pop    %ebx
8010668e:	5e                   	pop    %esi
8010668f:	5f                   	pop    %edi
80106690:	5d                   	pop    %ebp
80106691:	c3                   	ret    
80106692:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  mem = kalloc();
80106698:	e8 73 c3 ff ff       	call   80102a10 <kalloc>
  memset(mem, 0, PGSIZE);
8010669d:	83 ec 04             	sub    $0x4,%esp
801066a0:	68 00 10 00 00       	push   $0x1000
801066a5:	6a 00                	push   $0x0
801066a7:	50                   	push   %eax
801066a8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801066ab:	e8 e0 ea ff ff       	call   80105190 <memset>
  if(mappages(p->pgdir, (char*)PGROUNDDOWN(addr), PGSIZE, V2P(mem), PTE_W|PTE_U) < 0) {
801066b0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801066b3:	c7 04 24 06 00 00 00 	movl   $0x6,(%esp)
801066ba:	05 00 00 00 80       	add    $0x80000000,%eax
801066bf:	50                   	push   %eax
801066c0:	89 f0                	mov    %esi,%eax
801066c2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801066c7:	68 00 10 00 00       	push   $0x1000
801066cc:	50                   	push   %eax
801066cd:	ff 77 04             	pushl  0x4(%edi)
801066d0:	e8 bb 10 00 00       	call   80107790 <mappages>
801066d5:	83 c4 20             	add    $0x20,%esp
801066d8:	85 c0                	test   %eax,%eax
801066da:	78 5c                	js     80106738 <pageFaultHandler+0xe8>
  if(p->ofile[p->files[i].fd] == 0) {
801066dc:	8d 04 5b             	lea    (%ebx,%ebx,2),%eax
801066df:	8b 84 c7 98 00 00 00 	mov    0x98(%edi,%eax,8),%eax
801066e6:	8b 44 87 28          	mov    0x28(%edi,%eax,4),%eax
801066ea:	85 c0                	test   %eax,%eax
801066ec:	74 32                	je     80106720 <pageFaultHandler+0xd0>
  fileread(fd, mem, PGSIZE);
801066ee:	83 ec 04             	sub    $0x4,%esp
801066f1:	68 00 10 00 00       	push   $0x1000
801066f6:	ff 75 e4             	pushl  -0x1c(%ebp)
801066f9:	50                   	push   %eax
801066fa:	e8 d1 ac ff ff       	call   801013d0 <fileread>
  cprintf("Address: %x\n", addr);
801066ff:	58                   	pop    %eax
80106700:	5a                   	pop    %edx
80106701:	56                   	push   %esi
80106702:	68 01 88 10 80       	push   $0x80108801
80106707:	e8 a4 9f ff ff       	call   801006b0 <cprintf>
  return 1;
8010670c:	83 c4 10             	add    $0x10,%esp
}
8010670f:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 1;
80106712:	b8 01 00 00 00       	mov    $0x1,%eax
}
80106717:	5b                   	pop    %ebx
80106718:	5e                   	pop    %esi
80106719:	5f                   	pop    %edi
8010671a:	5d                   	pop    %ebp
8010671b:	c3                   	ret    
8010671c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("File is not opened\n");
80106720:	83 ec 0c             	sub    $0xc,%esp
80106723:	68 ed 87 10 80       	push   $0x801087ed
80106728:	e8 83 9f ff ff       	call   801006b0 <cprintf>
    return 0;
8010672d:	83 c4 10             	add    $0x10,%esp
80106730:	e9 53 ff ff ff       	jmp    80106688 <pageFaultHandler+0x38>
80106735:	8d 76 00             	lea    0x0(%esi),%esi
    cprintf("Access Denied\n");
80106738:	83 ec 0c             	sub    $0xc,%esp
8010673b:	68 de 87 10 80       	push   $0x801087de
80106740:	e8 6b 9f ff ff       	call   801006b0 <cprintf>
    kfree(mem);
80106745:	59                   	pop    %ecx
80106746:	ff 75 e4             	pushl  -0x1c(%ebp)
80106749:	e8 02 c1 ff ff       	call   80102850 <kfree>
    return 0;
8010674e:	83 c4 10             	add    $0x10,%esp
80106751:	31 c0                	xor    %eax,%eax
80106753:	e9 32 ff ff ff       	jmp    8010668a <pageFaultHandler+0x3a>
80106758:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010675f:	90                   	nop

80106760 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80106760:	f3 0f 1e fb          	endbr32 
80106764:	55                   	push   %ebp
80106765:	89 e5                	mov    %esp,%ebp
80106767:	57                   	push   %edi
80106768:	56                   	push   %esi
80106769:	53                   	push   %ebx
8010676a:	83 ec 1c             	sub    $0x1c,%esp
8010676d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
80106770:	8b 43 30             	mov    0x30(%ebx),%eax
80106773:	83 f8 40             	cmp    $0x40,%eax
80106776:	0f 84 9c 01 00 00    	je     80106918 <trap+0x1b8>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
8010677c:	83 e8 0e             	sub    $0xe,%eax
8010677f:	83 f8 31             	cmp    $0x31,%eax
80106782:	77 11                	ja     80106795 <trap+0x35>
80106784:	3e ff 24 85 b0 88 10 	notrack jmp *-0x7fef7750(,%eax,4)
8010678b:	80 
            cpuid(), tf->cs, tf->eip);
    lapiceoi();
    break;

  case T_PGFLT:
    if(pageFaultHandler()){
8010678c:	e8 bf fe ff ff       	call   80106650 <pageFaultHandler>
80106791:	85 c0                	test   %eax,%eax
80106793:	75 6e                	jne    80106803 <trap+0xa3>
      break;
    }

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80106795:	e8 26 d6 ff ff       	call   80103dc0 <myproc>
8010679a:	8b 7b 38             	mov    0x38(%ebx),%edi
8010679d:	85 c0                	test   %eax,%eax
8010679f:	0f 84 ff 01 00 00    	je     801069a4 <trap+0x244>
801067a5:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
801067a9:	0f 84 f5 01 00 00    	je     801069a4 <trap+0x244>
801067af:	0f 20 d1             	mov    %cr2,%ecx
801067b2:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801067b5:	e8 e6 d5 ff ff       	call   80103da0 <cpuid>
801067ba:	8b 73 30             	mov    0x30(%ebx),%esi
801067bd:	89 45 dc             	mov    %eax,-0x24(%ebp)
801067c0:	8b 43 34             	mov    0x34(%ebx),%eax
801067c3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
801067c6:	e8 f5 d5 ff ff       	call   80103dc0 <myproc>
801067cb:	89 45 e0             	mov    %eax,-0x20(%ebp)
801067ce:	e8 ed d5 ff ff       	call   80103dc0 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801067d3:	8b 4d d8             	mov    -0x28(%ebp),%ecx
801067d6:	8b 55 dc             	mov    -0x24(%ebp),%edx
801067d9:	51                   	push   %ecx
801067da:	57                   	push   %edi
801067db:	52                   	push   %edx
801067dc:	ff 75 e4             	pushl  -0x1c(%ebp)
801067df:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
801067e0:	8b 75 e0             	mov    -0x20(%ebp),%esi
801067e3:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801067e6:	56                   	push   %esi
801067e7:	ff 70 10             	pushl  0x10(%eax)
801067ea:	68 6c 88 10 80       	push   $0x8010886c
801067ef:	e8 bc 9e ff ff       	call   801006b0 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
801067f4:	83 c4 20             	add    $0x20,%esp
801067f7:	e8 c4 d5 ff ff       	call   80103dc0 <myproc>
801067fc:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106803:	e8 b8 d5 ff ff       	call   80103dc0 <myproc>
80106808:	85 c0                	test   %eax,%eax
8010680a:	74 1d                	je     80106829 <trap+0xc9>
8010680c:	e8 af d5 ff ff       	call   80103dc0 <myproc>
80106811:	8b 50 24             	mov    0x24(%eax),%edx
80106814:	85 d2                	test   %edx,%edx
80106816:	74 11                	je     80106829 <trap+0xc9>
80106818:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
8010681c:	83 e0 03             	and    $0x3,%eax
8010681f:	66 83 f8 03          	cmp    $0x3,%ax
80106823:	0f 84 27 01 00 00    	je     80106950 <trap+0x1f0>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80106829:	e8 92 d5 ff ff       	call   80103dc0 <myproc>
8010682e:	85 c0                	test   %eax,%eax
80106830:	74 0f                	je     80106841 <trap+0xe1>
80106832:	e8 89 d5 ff ff       	call   80103dc0 <myproc>
80106837:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
8010683b:	0f 84 bf 00 00 00    	je     80106900 <trap+0x1a0>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106841:	e8 7a d5 ff ff       	call   80103dc0 <myproc>
80106846:	85 c0                	test   %eax,%eax
80106848:	74 1d                	je     80106867 <trap+0x107>
8010684a:	e8 71 d5 ff ff       	call   80103dc0 <myproc>
8010684f:	8b 40 24             	mov    0x24(%eax),%eax
80106852:	85 c0                	test   %eax,%eax
80106854:	74 11                	je     80106867 <trap+0x107>
80106856:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
8010685a:	83 e0 03             	and    $0x3,%eax
8010685d:	66 83 f8 03          	cmp    $0x3,%ax
80106861:	0f 84 da 00 00 00    	je     80106941 <trap+0x1e1>
    exit();
}
80106867:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010686a:	5b                   	pop    %ebx
8010686b:	5e                   	pop    %esi
8010686c:	5f                   	pop    %edi
8010686d:	5d                   	pop    %ebp
8010686e:	c3                   	ret    
    if(cpuid() == 0){
8010686f:	e8 2c d5 ff ff       	call   80103da0 <cpuid>
80106874:	85 c0                	test   %eax,%eax
80106876:	0f 84 f4 00 00 00    	je     80106970 <trap+0x210>
    lapiceoi();
8010687c:	e8 3f c4 ff ff       	call   80102cc0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106881:	e8 3a d5 ff ff       	call   80103dc0 <myproc>
80106886:	85 c0                	test   %eax,%eax
80106888:	75 82                	jne    8010680c <trap+0xac>
8010688a:	eb 9d                	jmp    80106829 <trap+0xc9>
    kbdintr();
8010688c:	e8 ef c2 ff ff       	call   80102b80 <kbdintr>
    lapiceoi();
80106891:	e8 2a c4 ff ff       	call   80102cc0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106896:	e8 25 d5 ff ff       	call   80103dc0 <myproc>
8010689b:	85 c0                	test   %eax,%eax
8010689d:	0f 85 69 ff ff ff    	jne    8010680c <trap+0xac>
801068a3:	eb 84                	jmp    80106829 <trap+0xc9>
    uartintr();
801068a5:	e8 96 02 00 00       	call   80106b40 <uartintr>
    lapiceoi();
801068aa:	e8 11 c4 ff ff       	call   80102cc0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801068af:	e8 0c d5 ff ff       	call   80103dc0 <myproc>
801068b4:	85 c0                	test   %eax,%eax
801068b6:	0f 85 50 ff ff ff    	jne    8010680c <trap+0xac>
801068bc:	e9 68 ff ff ff       	jmp    80106829 <trap+0xc9>
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801068c1:	8b 7b 38             	mov    0x38(%ebx),%edi
801068c4:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
801068c8:	e8 d3 d4 ff ff       	call   80103da0 <cpuid>
801068cd:	57                   	push   %edi
801068ce:	56                   	push   %esi
801068cf:	50                   	push   %eax
801068d0:	68 14 88 10 80       	push   $0x80108814
801068d5:	e8 d6 9d ff ff       	call   801006b0 <cprintf>
    lapiceoi();
801068da:	e8 e1 c3 ff ff       	call   80102cc0 <lapiceoi>
    break;
801068df:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801068e2:	e8 d9 d4 ff ff       	call   80103dc0 <myproc>
801068e7:	85 c0                	test   %eax,%eax
801068e9:	0f 85 1d ff ff ff    	jne    8010680c <trap+0xac>
801068ef:	e9 35 ff ff ff       	jmp    80106829 <trap+0xc9>
    ideintr();
801068f4:	e8 c7 bc ff ff       	call   801025c0 <ideintr>
801068f9:	eb 81                	jmp    8010687c <trap+0x11c>
801068fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801068ff:	90                   	nop
  if(myproc() && myproc()->state == RUNNING &&
80106900:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80106904:	0f 85 37 ff ff ff    	jne    80106841 <trap+0xe1>
    yield();
8010690a:	e8 91 de ff ff       	call   801047a0 <yield>
8010690f:	e9 2d ff ff ff       	jmp    80106841 <trap+0xe1>
80106914:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
80106918:	e8 a3 d4 ff ff       	call   80103dc0 <myproc>
8010691d:	8b 70 24             	mov    0x24(%eax),%esi
80106920:	85 f6                	test   %esi,%esi
80106922:	75 3c                	jne    80106960 <trap+0x200>
    myproc()->tf = tf;
80106924:	e8 97 d4 ff ff       	call   80103dc0 <myproc>
80106929:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
8010692c:	e8 2f ec ff ff       	call   80105560 <syscall>
    if(myproc()->killed)
80106931:	e8 8a d4 ff ff       	call   80103dc0 <myproc>
80106936:	8b 48 24             	mov    0x24(%eax),%ecx
80106939:	85 c9                	test   %ecx,%ecx
8010693b:	0f 84 26 ff ff ff    	je     80106867 <trap+0x107>
}
80106941:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106944:	5b                   	pop    %ebx
80106945:	5e                   	pop    %esi
80106946:	5f                   	pop    %edi
80106947:	5d                   	pop    %ebp
      exit();
80106948:	e9 13 dd ff ff       	jmp    80104660 <exit>
8010694d:	8d 76 00             	lea    0x0(%esi),%esi
    exit();
80106950:	e8 0b dd ff ff       	call   80104660 <exit>
80106955:	e9 cf fe ff ff       	jmp    80106829 <trap+0xc9>
8010695a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80106960:	e8 fb dc ff ff       	call   80104660 <exit>
80106965:	eb bd                	jmp    80106924 <trap+0x1c4>
80106967:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010696e:	66 90                	xchg   %ax,%ax
      acquire(&tickslock);
80106970:	83 ec 0c             	sub    $0xc,%esp
80106973:	68 c0 92 11 80       	push   $0x801192c0
80106978:	e8 03 e7 ff ff       	call   80105080 <acquire>
      wakeup(&ticks);
8010697d:	c7 04 24 00 9b 11 80 	movl   $0x80119b00,(%esp)
      ticks++;
80106984:	83 05 00 9b 11 80 01 	addl   $0x1,0x80119b00
      wakeup(&ticks);
8010698b:	e8 c0 e1 ff ff       	call   80104b50 <wakeup>
      release(&tickslock);
80106990:	c7 04 24 c0 92 11 80 	movl   $0x801192c0,(%esp)
80106997:	e8 a4 e7 ff ff       	call   80105140 <release>
8010699c:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
8010699f:	e9 d8 fe ff ff       	jmp    8010687c <trap+0x11c>
801069a4:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
801069a7:	e8 f4 d3 ff ff       	call   80103da0 <cpuid>
801069ac:	83 ec 0c             	sub    $0xc,%esp
801069af:	56                   	push   %esi
801069b0:	57                   	push   %edi
801069b1:	50                   	push   %eax
801069b2:	ff 73 30             	pushl  0x30(%ebx)
801069b5:	68 38 88 10 80       	push   $0x80108838
801069ba:	e8 f1 9c ff ff       	call   801006b0 <cprintf>
      panic("trap");
801069bf:	83 c4 14             	add    $0x14,%esp
801069c2:	68 0e 88 10 80       	push   $0x8010880e
801069c7:	e8 c4 99 ff ff       	call   80100390 <panic>
801069cc:	66 90                	xchg   %ax,%ax
801069ce:	66 90                	xchg   %ax,%ax

801069d0 <uartgetc>:
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
801069d0:	f3 0f 1e fb          	endbr32 
  if(!uart)
801069d4:	a1 e4 b5 10 80       	mov    0x8010b5e4,%eax
801069d9:	85 c0                	test   %eax,%eax
801069db:	74 1b                	je     801069f8 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801069dd:	ba fd 03 00 00       	mov    $0x3fd,%edx
801069e2:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
801069e3:	a8 01                	test   $0x1,%al
801069e5:	74 11                	je     801069f8 <uartgetc+0x28>
801069e7:	ba f8 03 00 00       	mov    $0x3f8,%edx
801069ec:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
801069ed:	0f b6 c0             	movzbl %al,%eax
801069f0:	c3                   	ret    
801069f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801069f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801069fd:	c3                   	ret    
801069fe:	66 90                	xchg   %ax,%ax

80106a00 <uartputc.part.0>:
uartputc(int c)
80106a00:	55                   	push   %ebp
80106a01:	89 e5                	mov    %esp,%ebp
80106a03:	57                   	push   %edi
80106a04:	89 c7                	mov    %eax,%edi
80106a06:	56                   	push   %esi
80106a07:	be fd 03 00 00       	mov    $0x3fd,%esi
80106a0c:	53                   	push   %ebx
80106a0d:	bb 80 00 00 00       	mov    $0x80,%ebx
80106a12:	83 ec 0c             	sub    $0xc,%esp
80106a15:	eb 1b                	jmp    80106a32 <uartputc.part.0+0x32>
80106a17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106a1e:	66 90                	xchg   %ax,%ax
    microdelay(10);
80106a20:	83 ec 0c             	sub    $0xc,%esp
80106a23:	6a 0a                	push   $0xa
80106a25:	e8 b6 c2 ff ff       	call   80102ce0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106a2a:	83 c4 10             	add    $0x10,%esp
80106a2d:	83 eb 01             	sub    $0x1,%ebx
80106a30:	74 07                	je     80106a39 <uartputc.part.0+0x39>
80106a32:	89 f2                	mov    %esi,%edx
80106a34:	ec                   	in     (%dx),%al
80106a35:	a8 20                	test   $0x20,%al
80106a37:	74 e7                	je     80106a20 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106a39:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106a3e:	89 f8                	mov    %edi,%eax
80106a40:	ee                   	out    %al,(%dx)
}
80106a41:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106a44:	5b                   	pop    %ebx
80106a45:	5e                   	pop    %esi
80106a46:	5f                   	pop    %edi
80106a47:	5d                   	pop    %ebp
80106a48:	c3                   	ret    
80106a49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106a50 <uartinit>:
{
80106a50:	f3 0f 1e fb          	endbr32 
80106a54:	55                   	push   %ebp
80106a55:	31 c9                	xor    %ecx,%ecx
80106a57:	89 c8                	mov    %ecx,%eax
80106a59:	89 e5                	mov    %esp,%ebp
80106a5b:	57                   	push   %edi
80106a5c:	56                   	push   %esi
80106a5d:	53                   	push   %ebx
80106a5e:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80106a63:	89 da                	mov    %ebx,%edx
80106a65:	83 ec 0c             	sub    $0xc,%esp
80106a68:	ee                   	out    %al,(%dx)
80106a69:	bf fb 03 00 00       	mov    $0x3fb,%edi
80106a6e:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80106a73:	89 fa                	mov    %edi,%edx
80106a75:	ee                   	out    %al,(%dx)
80106a76:	b8 0c 00 00 00       	mov    $0xc,%eax
80106a7b:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106a80:	ee                   	out    %al,(%dx)
80106a81:	be f9 03 00 00       	mov    $0x3f9,%esi
80106a86:	89 c8                	mov    %ecx,%eax
80106a88:	89 f2                	mov    %esi,%edx
80106a8a:	ee                   	out    %al,(%dx)
80106a8b:	b8 03 00 00 00       	mov    $0x3,%eax
80106a90:	89 fa                	mov    %edi,%edx
80106a92:	ee                   	out    %al,(%dx)
80106a93:	ba fc 03 00 00       	mov    $0x3fc,%edx
80106a98:	89 c8                	mov    %ecx,%eax
80106a9a:	ee                   	out    %al,(%dx)
80106a9b:	b8 01 00 00 00       	mov    $0x1,%eax
80106aa0:	89 f2                	mov    %esi,%edx
80106aa2:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106aa3:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106aa8:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80106aa9:	3c ff                	cmp    $0xff,%al
80106aab:	74 52                	je     80106aff <uartinit+0xaf>
  uart = 1;
80106aad:	c7 05 e4 b5 10 80 01 	movl   $0x1,0x8010b5e4
80106ab4:	00 00 00 
80106ab7:	89 da                	mov    %ebx,%edx
80106ab9:	ec                   	in     (%dx),%al
80106aba:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106abf:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80106ac0:	83 ec 08             	sub    $0x8,%esp
80106ac3:	be 76 00 00 00       	mov    $0x76,%esi
  for(p="xv6...\n"; *p; p++)
80106ac8:	bb 78 89 10 80       	mov    $0x80108978,%ebx
  ioapicenable(IRQ_COM1, 0);
80106acd:	6a 00                	push   $0x0
80106acf:	6a 04                	push   $0x4
80106ad1:	e8 3a bd ff ff       	call   80102810 <ioapicenable>
80106ad6:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80106ad9:	b8 78 00 00 00       	mov    $0x78,%eax
80106ade:	eb 04                	jmp    80106ae4 <uartinit+0x94>
80106ae0:	0f b6 73 01          	movzbl 0x1(%ebx),%esi
  if(!uart)
80106ae4:	8b 15 e4 b5 10 80    	mov    0x8010b5e4,%edx
80106aea:	85 d2                	test   %edx,%edx
80106aec:	74 08                	je     80106af6 <uartinit+0xa6>
    uartputc(*p);
80106aee:	0f be c0             	movsbl %al,%eax
80106af1:	e8 0a ff ff ff       	call   80106a00 <uartputc.part.0>
  for(p="xv6...\n"; *p; p++)
80106af6:	89 f0                	mov    %esi,%eax
80106af8:	83 c3 01             	add    $0x1,%ebx
80106afb:	84 c0                	test   %al,%al
80106afd:	75 e1                	jne    80106ae0 <uartinit+0x90>
}
80106aff:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106b02:	5b                   	pop    %ebx
80106b03:	5e                   	pop    %esi
80106b04:	5f                   	pop    %edi
80106b05:	5d                   	pop    %ebp
80106b06:	c3                   	ret    
80106b07:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106b0e:	66 90                	xchg   %ax,%ax

80106b10 <uartputc>:
{
80106b10:	f3 0f 1e fb          	endbr32 
80106b14:	55                   	push   %ebp
  if(!uart)
80106b15:	8b 15 e4 b5 10 80    	mov    0x8010b5e4,%edx
{
80106b1b:	89 e5                	mov    %esp,%ebp
80106b1d:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
80106b20:	85 d2                	test   %edx,%edx
80106b22:	74 0c                	je     80106b30 <uartputc+0x20>
}
80106b24:	5d                   	pop    %ebp
80106b25:	e9 d6 fe ff ff       	jmp    80106a00 <uartputc.part.0>
80106b2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106b30:	5d                   	pop    %ebp
80106b31:	c3                   	ret    
80106b32:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106b39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106b40 <uartintr>:

void
uartintr(void)
{
80106b40:	f3 0f 1e fb          	endbr32 
80106b44:	55                   	push   %ebp
80106b45:	89 e5                	mov    %esp,%ebp
80106b47:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80106b4a:	68 d0 69 10 80       	push   $0x801069d0
80106b4f:	e8 6c 9d ff ff       	call   801008c0 <consoleintr>
}
80106b54:	83 c4 10             	add    $0x10,%esp
80106b57:	c9                   	leave  
80106b58:	c3                   	ret    

80106b59 <vector0>:
80106b59:	6a 00                	push   $0x0
80106b5b:	6a 00                	push   $0x0
80106b5d:	e9 17 fa ff ff       	jmp    80106579 <alltraps>

80106b62 <vector1>:
80106b62:	6a 00                	push   $0x0
80106b64:	6a 01                	push   $0x1
80106b66:	e9 0e fa ff ff       	jmp    80106579 <alltraps>

80106b6b <vector2>:
80106b6b:	6a 00                	push   $0x0
80106b6d:	6a 02                	push   $0x2
80106b6f:	e9 05 fa ff ff       	jmp    80106579 <alltraps>

80106b74 <vector3>:
80106b74:	6a 00                	push   $0x0
80106b76:	6a 03                	push   $0x3
80106b78:	e9 fc f9 ff ff       	jmp    80106579 <alltraps>

80106b7d <vector4>:
80106b7d:	6a 00                	push   $0x0
80106b7f:	6a 04                	push   $0x4
80106b81:	e9 f3 f9 ff ff       	jmp    80106579 <alltraps>

80106b86 <vector5>:
80106b86:	6a 00                	push   $0x0
80106b88:	6a 05                	push   $0x5
80106b8a:	e9 ea f9 ff ff       	jmp    80106579 <alltraps>

80106b8f <vector6>:
80106b8f:	6a 00                	push   $0x0
80106b91:	6a 06                	push   $0x6
80106b93:	e9 e1 f9 ff ff       	jmp    80106579 <alltraps>

80106b98 <vector7>:
80106b98:	6a 00                	push   $0x0
80106b9a:	6a 07                	push   $0x7
80106b9c:	e9 d8 f9 ff ff       	jmp    80106579 <alltraps>

80106ba1 <vector8>:
80106ba1:	6a 08                	push   $0x8
80106ba3:	e9 d1 f9 ff ff       	jmp    80106579 <alltraps>

80106ba8 <vector9>:
80106ba8:	6a 00                	push   $0x0
80106baa:	6a 09                	push   $0x9
80106bac:	e9 c8 f9 ff ff       	jmp    80106579 <alltraps>

80106bb1 <vector10>:
80106bb1:	6a 0a                	push   $0xa
80106bb3:	e9 c1 f9 ff ff       	jmp    80106579 <alltraps>

80106bb8 <vector11>:
80106bb8:	6a 0b                	push   $0xb
80106bba:	e9 ba f9 ff ff       	jmp    80106579 <alltraps>

80106bbf <vector12>:
80106bbf:	6a 0c                	push   $0xc
80106bc1:	e9 b3 f9 ff ff       	jmp    80106579 <alltraps>

80106bc6 <vector13>:
80106bc6:	6a 0d                	push   $0xd
80106bc8:	e9 ac f9 ff ff       	jmp    80106579 <alltraps>

80106bcd <vector14>:
80106bcd:	6a 0e                	push   $0xe
80106bcf:	e9 a5 f9 ff ff       	jmp    80106579 <alltraps>

80106bd4 <vector15>:
80106bd4:	6a 00                	push   $0x0
80106bd6:	6a 0f                	push   $0xf
80106bd8:	e9 9c f9 ff ff       	jmp    80106579 <alltraps>

80106bdd <vector16>:
80106bdd:	6a 00                	push   $0x0
80106bdf:	6a 10                	push   $0x10
80106be1:	e9 93 f9 ff ff       	jmp    80106579 <alltraps>

80106be6 <vector17>:
80106be6:	6a 11                	push   $0x11
80106be8:	e9 8c f9 ff ff       	jmp    80106579 <alltraps>

80106bed <vector18>:
80106bed:	6a 00                	push   $0x0
80106bef:	6a 12                	push   $0x12
80106bf1:	e9 83 f9 ff ff       	jmp    80106579 <alltraps>

80106bf6 <vector19>:
80106bf6:	6a 00                	push   $0x0
80106bf8:	6a 13                	push   $0x13
80106bfa:	e9 7a f9 ff ff       	jmp    80106579 <alltraps>

80106bff <vector20>:
80106bff:	6a 00                	push   $0x0
80106c01:	6a 14                	push   $0x14
80106c03:	e9 71 f9 ff ff       	jmp    80106579 <alltraps>

80106c08 <vector21>:
80106c08:	6a 00                	push   $0x0
80106c0a:	6a 15                	push   $0x15
80106c0c:	e9 68 f9 ff ff       	jmp    80106579 <alltraps>

80106c11 <vector22>:
80106c11:	6a 00                	push   $0x0
80106c13:	6a 16                	push   $0x16
80106c15:	e9 5f f9 ff ff       	jmp    80106579 <alltraps>

80106c1a <vector23>:
80106c1a:	6a 00                	push   $0x0
80106c1c:	6a 17                	push   $0x17
80106c1e:	e9 56 f9 ff ff       	jmp    80106579 <alltraps>

80106c23 <vector24>:
80106c23:	6a 00                	push   $0x0
80106c25:	6a 18                	push   $0x18
80106c27:	e9 4d f9 ff ff       	jmp    80106579 <alltraps>

80106c2c <vector25>:
80106c2c:	6a 00                	push   $0x0
80106c2e:	6a 19                	push   $0x19
80106c30:	e9 44 f9 ff ff       	jmp    80106579 <alltraps>

80106c35 <vector26>:
80106c35:	6a 00                	push   $0x0
80106c37:	6a 1a                	push   $0x1a
80106c39:	e9 3b f9 ff ff       	jmp    80106579 <alltraps>

80106c3e <vector27>:
80106c3e:	6a 00                	push   $0x0
80106c40:	6a 1b                	push   $0x1b
80106c42:	e9 32 f9 ff ff       	jmp    80106579 <alltraps>

80106c47 <vector28>:
80106c47:	6a 00                	push   $0x0
80106c49:	6a 1c                	push   $0x1c
80106c4b:	e9 29 f9 ff ff       	jmp    80106579 <alltraps>

80106c50 <vector29>:
80106c50:	6a 00                	push   $0x0
80106c52:	6a 1d                	push   $0x1d
80106c54:	e9 20 f9 ff ff       	jmp    80106579 <alltraps>

80106c59 <vector30>:
80106c59:	6a 00                	push   $0x0
80106c5b:	6a 1e                	push   $0x1e
80106c5d:	e9 17 f9 ff ff       	jmp    80106579 <alltraps>

80106c62 <vector31>:
80106c62:	6a 00                	push   $0x0
80106c64:	6a 1f                	push   $0x1f
80106c66:	e9 0e f9 ff ff       	jmp    80106579 <alltraps>

80106c6b <vector32>:
80106c6b:	6a 00                	push   $0x0
80106c6d:	6a 20                	push   $0x20
80106c6f:	e9 05 f9 ff ff       	jmp    80106579 <alltraps>

80106c74 <vector33>:
80106c74:	6a 00                	push   $0x0
80106c76:	6a 21                	push   $0x21
80106c78:	e9 fc f8 ff ff       	jmp    80106579 <alltraps>

80106c7d <vector34>:
80106c7d:	6a 00                	push   $0x0
80106c7f:	6a 22                	push   $0x22
80106c81:	e9 f3 f8 ff ff       	jmp    80106579 <alltraps>

80106c86 <vector35>:
80106c86:	6a 00                	push   $0x0
80106c88:	6a 23                	push   $0x23
80106c8a:	e9 ea f8 ff ff       	jmp    80106579 <alltraps>

80106c8f <vector36>:
80106c8f:	6a 00                	push   $0x0
80106c91:	6a 24                	push   $0x24
80106c93:	e9 e1 f8 ff ff       	jmp    80106579 <alltraps>

80106c98 <vector37>:
80106c98:	6a 00                	push   $0x0
80106c9a:	6a 25                	push   $0x25
80106c9c:	e9 d8 f8 ff ff       	jmp    80106579 <alltraps>

80106ca1 <vector38>:
80106ca1:	6a 00                	push   $0x0
80106ca3:	6a 26                	push   $0x26
80106ca5:	e9 cf f8 ff ff       	jmp    80106579 <alltraps>

80106caa <vector39>:
80106caa:	6a 00                	push   $0x0
80106cac:	6a 27                	push   $0x27
80106cae:	e9 c6 f8 ff ff       	jmp    80106579 <alltraps>

80106cb3 <vector40>:
80106cb3:	6a 00                	push   $0x0
80106cb5:	6a 28                	push   $0x28
80106cb7:	e9 bd f8 ff ff       	jmp    80106579 <alltraps>

80106cbc <vector41>:
80106cbc:	6a 00                	push   $0x0
80106cbe:	6a 29                	push   $0x29
80106cc0:	e9 b4 f8 ff ff       	jmp    80106579 <alltraps>

80106cc5 <vector42>:
80106cc5:	6a 00                	push   $0x0
80106cc7:	6a 2a                	push   $0x2a
80106cc9:	e9 ab f8 ff ff       	jmp    80106579 <alltraps>

80106cce <vector43>:
80106cce:	6a 00                	push   $0x0
80106cd0:	6a 2b                	push   $0x2b
80106cd2:	e9 a2 f8 ff ff       	jmp    80106579 <alltraps>

80106cd7 <vector44>:
80106cd7:	6a 00                	push   $0x0
80106cd9:	6a 2c                	push   $0x2c
80106cdb:	e9 99 f8 ff ff       	jmp    80106579 <alltraps>

80106ce0 <vector45>:
80106ce0:	6a 00                	push   $0x0
80106ce2:	6a 2d                	push   $0x2d
80106ce4:	e9 90 f8 ff ff       	jmp    80106579 <alltraps>

80106ce9 <vector46>:
80106ce9:	6a 00                	push   $0x0
80106ceb:	6a 2e                	push   $0x2e
80106ced:	e9 87 f8 ff ff       	jmp    80106579 <alltraps>

80106cf2 <vector47>:
80106cf2:	6a 00                	push   $0x0
80106cf4:	6a 2f                	push   $0x2f
80106cf6:	e9 7e f8 ff ff       	jmp    80106579 <alltraps>

80106cfb <vector48>:
80106cfb:	6a 00                	push   $0x0
80106cfd:	6a 30                	push   $0x30
80106cff:	e9 75 f8 ff ff       	jmp    80106579 <alltraps>

80106d04 <vector49>:
80106d04:	6a 00                	push   $0x0
80106d06:	6a 31                	push   $0x31
80106d08:	e9 6c f8 ff ff       	jmp    80106579 <alltraps>

80106d0d <vector50>:
80106d0d:	6a 00                	push   $0x0
80106d0f:	6a 32                	push   $0x32
80106d11:	e9 63 f8 ff ff       	jmp    80106579 <alltraps>

80106d16 <vector51>:
80106d16:	6a 00                	push   $0x0
80106d18:	6a 33                	push   $0x33
80106d1a:	e9 5a f8 ff ff       	jmp    80106579 <alltraps>

80106d1f <vector52>:
80106d1f:	6a 00                	push   $0x0
80106d21:	6a 34                	push   $0x34
80106d23:	e9 51 f8 ff ff       	jmp    80106579 <alltraps>

80106d28 <vector53>:
80106d28:	6a 00                	push   $0x0
80106d2a:	6a 35                	push   $0x35
80106d2c:	e9 48 f8 ff ff       	jmp    80106579 <alltraps>

80106d31 <vector54>:
80106d31:	6a 00                	push   $0x0
80106d33:	6a 36                	push   $0x36
80106d35:	e9 3f f8 ff ff       	jmp    80106579 <alltraps>

80106d3a <vector55>:
80106d3a:	6a 00                	push   $0x0
80106d3c:	6a 37                	push   $0x37
80106d3e:	e9 36 f8 ff ff       	jmp    80106579 <alltraps>

80106d43 <vector56>:
80106d43:	6a 00                	push   $0x0
80106d45:	6a 38                	push   $0x38
80106d47:	e9 2d f8 ff ff       	jmp    80106579 <alltraps>

80106d4c <vector57>:
80106d4c:	6a 00                	push   $0x0
80106d4e:	6a 39                	push   $0x39
80106d50:	e9 24 f8 ff ff       	jmp    80106579 <alltraps>

80106d55 <vector58>:
80106d55:	6a 00                	push   $0x0
80106d57:	6a 3a                	push   $0x3a
80106d59:	e9 1b f8 ff ff       	jmp    80106579 <alltraps>

80106d5e <vector59>:
80106d5e:	6a 00                	push   $0x0
80106d60:	6a 3b                	push   $0x3b
80106d62:	e9 12 f8 ff ff       	jmp    80106579 <alltraps>

80106d67 <vector60>:
80106d67:	6a 00                	push   $0x0
80106d69:	6a 3c                	push   $0x3c
80106d6b:	e9 09 f8 ff ff       	jmp    80106579 <alltraps>

80106d70 <vector61>:
80106d70:	6a 00                	push   $0x0
80106d72:	6a 3d                	push   $0x3d
80106d74:	e9 00 f8 ff ff       	jmp    80106579 <alltraps>

80106d79 <vector62>:
80106d79:	6a 00                	push   $0x0
80106d7b:	6a 3e                	push   $0x3e
80106d7d:	e9 f7 f7 ff ff       	jmp    80106579 <alltraps>

80106d82 <vector63>:
80106d82:	6a 00                	push   $0x0
80106d84:	6a 3f                	push   $0x3f
80106d86:	e9 ee f7 ff ff       	jmp    80106579 <alltraps>

80106d8b <vector64>:
80106d8b:	6a 00                	push   $0x0
80106d8d:	6a 40                	push   $0x40
80106d8f:	e9 e5 f7 ff ff       	jmp    80106579 <alltraps>

80106d94 <vector65>:
80106d94:	6a 00                	push   $0x0
80106d96:	6a 41                	push   $0x41
80106d98:	e9 dc f7 ff ff       	jmp    80106579 <alltraps>

80106d9d <vector66>:
80106d9d:	6a 00                	push   $0x0
80106d9f:	6a 42                	push   $0x42
80106da1:	e9 d3 f7 ff ff       	jmp    80106579 <alltraps>

80106da6 <vector67>:
80106da6:	6a 00                	push   $0x0
80106da8:	6a 43                	push   $0x43
80106daa:	e9 ca f7 ff ff       	jmp    80106579 <alltraps>

80106daf <vector68>:
80106daf:	6a 00                	push   $0x0
80106db1:	6a 44                	push   $0x44
80106db3:	e9 c1 f7 ff ff       	jmp    80106579 <alltraps>

80106db8 <vector69>:
80106db8:	6a 00                	push   $0x0
80106dba:	6a 45                	push   $0x45
80106dbc:	e9 b8 f7 ff ff       	jmp    80106579 <alltraps>

80106dc1 <vector70>:
80106dc1:	6a 00                	push   $0x0
80106dc3:	6a 46                	push   $0x46
80106dc5:	e9 af f7 ff ff       	jmp    80106579 <alltraps>

80106dca <vector71>:
80106dca:	6a 00                	push   $0x0
80106dcc:	6a 47                	push   $0x47
80106dce:	e9 a6 f7 ff ff       	jmp    80106579 <alltraps>

80106dd3 <vector72>:
80106dd3:	6a 00                	push   $0x0
80106dd5:	6a 48                	push   $0x48
80106dd7:	e9 9d f7 ff ff       	jmp    80106579 <alltraps>

80106ddc <vector73>:
80106ddc:	6a 00                	push   $0x0
80106dde:	6a 49                	push   $0x49
80106de0:	e9 94 f7 ff ff       	jmp    80106579 <alltraps>

80106de5 <vector74>:
80106de5:	6a 00                	push   $0x0
80106de7:	6a 4a                	push   $0x4a
80106de9:	e9 8b f7 ff ff       	jmp    80106579 <alltraps>

80106dee <vector75>:
80106dee:	6a 00                	push   $0x0
80106df0:	6a 4b                	push   $0x4b
80106df2:	e9 82 f7 ff ff       	jmp    80106579 <alltraps>

80106df7 <vector76>:
80106df7:	6a 00                	push   $0x0
80106df9:	6a 4c                	push   $0x4c
80106dfb:	e9 79 f7 ff ff       	jmp    80106579 <alltraps>

80106e00 <vector77>:
80106e00:	6a 00                	push   $0x0
80106e02:	6a 4d                	push   $0x4d
80106e04:	e9 70 f7 ff ff       	jmp    80106579 <alltraps>

80106e09 <vector78>:
80106e09:	6a 00                	push   $0x0
80106e0b:	6a 4e                	push   $0x4e
80106e0d:	e9 67 f7 ff ff       	jmp    80106579 <alltraps>

80106e12 <vector79>:
80106e12:	6a 00                	push   $0x0
80106e14:	6a 4f                	push   $0x4f
80106e16:	e9 5e f7 ff ff       	jmp    80106579 <alltraps>

80106e1b <vector80>:
80106e1b:	6a 00                	push   $0x0
80106e1d:	6a 50                	push   $0x50
80106e1f:	e9 55 f7 ff ff       	jmp    80106579 <alltraps>

80106e24 <vector81>:
80106e24:	6a 00                	push   $0x0
80106e26:	6a 51                	push   $0x51
80106e28:	e9 4c f7 ff ff       	jmp    80106579 <alltraps>

80106e2d <vector82>:
80106e2d:	6a 00                	push   $0x0
80106e2f:	6a 52                	push   $0x52
80106e31:	e9 43 f7 ff ff       	jmp    80106579 <alltraps>

80106e36 <vector83>:
80106e36:	6a 00                	push   $0x0
80106e38:	6a 53                	push   $0x53
80106e3a:	e9 3a f7 ff ff       	jmp    80106579 <alltraps>

80106e3f <vector84>:
80106e3f:	6a 00                	push   $0x0
80106e41:	6a 54                	push   $0x54
80106e43:	e9 31 f7 ff ff       	jmp    80106579 <alltraps>

80106e48 <vector85>:
80106e48:	6a 00                	push   $0x0
80106e4a:	6a 55                	push   $0x55
80106e4c:	e9 28 f7 ff ff       	jmp    80106579 <alltraps>

80106e51 <vector86>:
80106e51:	6a 00                	push   $0x0
80106e53:	6a 56                	push   $0x56
80106e55:	e9 1f f7 ff ff       	jmp    80106579 <alltraps>

80106e5a <vector87>:
80106e5a:	6a 00                	push   $0x0
80106e5c:	6a 57                	push   $0x57
80106e5e:	e9 16 f7 ff ff       	jmp    80106579 <alltraps>

80106e63 <vector88>:
80106e63:	6a 00                	push   $0x0
80106e65:	6a 58                	push   $0x58
80106e67:	e9 0d f7 ff ff       	jmp    80106579 <alltraps>

80106e6c <vector89>:
80106e6c:	6a 00                	push   $0x0
80106e6e:	6a 59                	push   $0x59
80106e70:	e9 04 f7 ff ff       	jmp    80106579 <alltraps>

80106e75 <vector90>:
80106e75:	6a 00                	push   $0x0
80106e77:	6a 5a                	push   $0x5a
80106e79:	e9 fb f6 ff ff       	jmp    80106579 <alltraps>

80106e7e <vector91>:
80106e7e:	6a 00                	push   $0x0
80106e80:	6a 5b                	push   $0x5b
80106e82:	e9 f2 f6 ff ff       	jmp    80106579 <alltraps>

80106e87 <vector92>:
80106e87:	6a 00                	push   $0x0
80106e89:	6a 5c                	push   $0x5c
80106e8b:	e9 e9 f6 ff ff       	jmp    80106579 <alltraps>

80106e90 <vector93>:
80106e90:	6a 00                	push   $0x0
80106e92:	6a 5d                	push   $0x5d
80106e94:	e9 e0 f6 ff ff       	jmp    80106579 <alltraps>

80106e99 <vector94>:
80106e99:	6a 00                	push   $0x0
80106e9b:	6a 5e                	push   $0x5e
80106e9d:	e9 d7 f6 ff ff       	jmp    80106579 <alltraps>

80106ea2 <vector95>:
80106ea2:	6a 00                	push   $0x0
80106ea4:	6a 5f                	push   $0x5f
80106ea6:	e9 ce f6 ff ff       	jmp    80106579 <alltraps>

80106eab <vector96>:
80106eab:	6a 00                	push   $0x0
80106ead:	6a 60                	push   $0x60
80106eaf:	e9 c5 f6 ff ff       	jmp    80106579 <alltraps>

80106eb4 <vector97>:
80106eb4:	6a 00                	push   $0x0
80106eb6:	6a 61                	push   $0x61
80106eb8:	e9 bc f6 ff ff       	jmp    80106579 <alltraps>

80106ebd <vector98>:
80106ebd:	6a 00                	push   $0x0
80106ebf:	6a 62                	push   $0x62
80106ec1:	e9 b3 f6 ff ff       	jmp    80106579 <alltraps>

80106ec6 <vector99>:
80106ec6:	6a 00                	push   $0x0
80106ec8:	6a 63                	push   $0x63
80106eca:	e9 aa f6 ff ff       	jmp    80106579 <alltraps>

80106ecf <vector100>:
80106ecf:	6a 00                	push   $0x0
80106ed1:	6a 64                	push   $0x64
80106ed3:	e9 a1 f6 ff ff       	jmp    80106579 <alltraps>

80106ed8 <vector101>:
80106ed8:	6a 00                	push   $0x0
80106eda:	6a 65                	push   $0x65
80106edc:	e9 98 f6 ff ff       	jmp    80106579 <alltraps>

80106ee1 <vector102>:
80106ee1:	6a 00                	push   $0x0
80106ee3:	6a 66                	push   $0x66
80106ee5:	e9 8f f6 ff ff       	jmp    80106579 <alltraps>

80106eea <vector103>:
80106eea:	6a 00                	push   $0x0
80106eec:	6a 67                	push   $0x67
80106eee:	e9 86 f6 ff ff       	jmp    80106579 <alltraps>

80106ef3 <vector104>:
80106ef3:	6a 00                	push   $0x0
80106ef5:	6a 68                	push   $0x68
80106ef7:	e9 7d f6 ff ff       	jmp    80106579 <alltraps>

80106efc <vector105>:
80106efc:	6a 00                	push   $0x0
80106efe:	6a 69                	push   $0x69
80106f00:	e9 74 f6 ff ff       	jmp    80106579 <alltraps>

80106f05 <vector106>:
80106f05:	6a 00                	push   $0x0
80106f07:	6a 6a                	push   $0x6a
80106f09:	e9 6b f6 ff ff       	jmp    80106579 <alltraps>

80106f0e <vector107>:
80106f0e:	6a 00                	push   $0x0
80106f10:	6a 6b                	push   $0x6b
80106f12:	e9 62 f6 ff ff       	jmp    80106579 <alltraps>

80106f17 <vector108>:
80106f17:	6a 00                	push   $0x0
80106f19:	6a 6c                	push   $0x6c
80106f1b:	e9 59 f6 ff ff       	jmp    80106579 <alltraps>

80106f20 <vector109>:
80106f20:	6a 00                	push   $0x0
80106f22:	6a 6d                	push   $0x6d
80106f24:	e9 50 f6 ff ff       	jmp    80106579 <alltraps>

80106f29 <vector110>:
80106f29:	6a 00                	push   $0x0
80106f2b:	6a 6e                	push   $0x6e
80106f2d:	e9 47 f6 ff ff       	jmp    80106579 <alltraps>

80106f32 <vector111>:
80106f32:	6a 00                	push   $0x0
80106f34:	6a 6f                	push   $0x6f
80106f36:	e9 3e f6 ff ff       	jmp    80106579 <alltraps>

80106f3b <vector112>:
80106f3b:	6a 00                	push   $0x0
80106f3d:	6a 70                	push   $0x70
80106f3f:	e9 35 f6 ff ff       	jmp    80106579 <alltraps>

80106f44 <vector113>:
80106f44:	6a 00                	push   $0x0
80106f46:	6a 71                	push   $0x71
80106f48:	e9 2c f6 ff ff       	jmp    80106579 <alltraps>

80106f4d <vector114>:
80106f4d:	6a 00                	push   $0x0
80106f4f:	6a 72                	push   $0x72
80106f51:	e9 23 f6 ff ff       	jmp    80106579 <alltraps>

80106f56 <vector115>:
80106f56:	6a 00                	push   $0x0
80106f58:	6a 73                	push   $0x73
80106f5a:	e9 1a f6 ff ff       	jmp    80106579 <alltraps>

80106f5f <vector116>:
80106f5f:	6a 00                	push   $0x0
80106f61:	6a 74                	push   $0x74
80106f63:	e9 11 f6 ff ff       	jmp    80106579 <alltraps>

80106f68 <vector117>:
80106f68:	6a 00                	push   $0x0
80106f6a:	6a 75                	push   $0x75
80106f6c:	e9 08 f6 ff ff       	jmp    80106579 <alltraps>

80106f71 <vector118>:
80106f71:	6a 00                	push   $0x0
80106f73:	6a 76                	push   $0x76
80106f75:	e9 ff f5 ff ff       	jmp    80106579 <alltraps>

80106f7a <vector119>:
80106f7a:	6a 00                	push   $0x0
80106f7c:	6a 77                	push   $0x77
80106f7e:	e9 f6 f5 ff ff       	jmp    80106579 <alltraps>

80106f83 <vector120>:
80106f83:	6a 00                	push   $0x0
80106f85:	6a 78                	push   $0x78
80106f87:	e9 ed f5 ff ff       	jmp    80106579 <alltraps>

80106f8c <vector121>:
80106f8c:	6a 00                	push   $0x0
80106f8e:	6a 79                	push   $0x79
80106f90:	e9 e4 f5 ff ff       	jmp    80106579 <alltraps>

80106f95 <vector122>:
80106f95:	6a 00                	push   $0x0
80106f97:	6a 7a                	push   $0x7a
80106f99:	e9 db f5 ff ff       	jmp    80106579 <alltraps>

80106f9e <vector123>:
80106f9e:	6a 00                	push   $0x0
80106fa0:	6a 7b                	push   $0x7b
80106fa2:	e9 d2 f5 ff ff       	jmp    80106579 <alltraps>

80106fa7 <vector124>:
80106fa7:	6a 00                	push   $0x0
80106fa9:	6a 7c                	push   $0x7c
80106fab:	e9 c9 f5 ff ff       	jmp    80106579 <alltraps>

80106fb0 <vector125>:
80106fb0:	6a 00                	push   $0x0
80106fb2:	6a 7d                	push   $0x7d
80106fb4:	e9 c0 f5 ff ff       	jmp    80106579 <alltraps>

80106fb9 <vector126>:
80106fb9:	6a 00                	push   $0x0
80106fbb:	6a 7e                	push   $0x7e
80106fbd:	e9 b7 f5 ff ff       	jmp    80106579 <alltraps>

80106fc2 <vector127>:
80106fc2:	6a 00                	push   $0x0
80106fc4:	6a 7f                	push   $0x7f
80106fc6:	e9 ae f5 ff ff       	jmp    80106579 <alltraps>

80106fcb <vector128>:
80106fcb:	6a 00                	push   $0x0
80106fcd:	68 80 00 00 00       	push   $0x80
80106fd2:	e9 a2 f5 ff ff       	jmp    80106579 <alltraps>

80106fd7 <vector129>:
80106fd7:	6a 00                	push   $0x0
80106fd9:	68 81 00 00 00       	push   $0x81
80106fde:	e9 96 f5 ff ff       	jmp    80106579 <alltraps>

80106fe3 <vector130>:
80106fe3:	6a 00                	push   $0x0
80106fe5:	68 82 00 00 00       	push   $0x82
80106fea:	e9 8a f5 ff ff       	jmp    80106579 <alltraps>

80106fef <vector131>:
80106fef:	6a 00                	push   $0x0
80106ff1:	68 83 00 00 00       	push   $0x83
80106ff6:	e9 7e f5 ff ff       	jmp    80106579 <alltraps>

80106ffb <vector132>:
80106ffb:	6a 00                	push   $0x0
80106ffd:	68 84 00 00 00       	push   $0x84
80107002:	e9 72 f5 ff ff       	jmp    80106579 <alltraps>

80107007 <vector133>:
80107007:	6a 00                	push   $0x0
80107009:	68 85 00 00 00       	push   $0x85
8010700e:	e9 66 f5 ff ff       	jmp    80106579 <alltraps>

80107013 <vector134>:
80107013:	6a 00                	push   $0x0
80107015:	68 86 00 00 00       	push   $0x86
8010701a:	e9 5a f5 ff ff       	jmp    80106579 <alltraps>

8010701f <vector135>:
8010701f:	6a 00                	push   $0x0
80107021:	68 87 00 00 00       	push   $0x87
80107026:	e9 4e f5 ff ff       	jmp    80106579 <alltraps>

8010702b <vector136>:
8010702b:	6a 00                	push   $0x0
8010702d:	68 88 00 00 00       	push   $0x88
80107032:	e9 42 f5 ff ff       	jmp    80106579 <alltraps>

80107037 <vector137>:
80107037:	6a 00                	push   $0x0
80107039:	68 89 00 00 00       	push   $0x89
8010703e:	e9 36 f5 ff ff       	jmp    80106579 <alltraps>

80107043 <vector138>:
80107043:	6a 00                	push   $0x0
80107045:	68 8a 00 00 00       	push   $0x8a
8010704a:	e9 2a f5 ff ff       	jmp    80106579 <alltraps>

8010704f <vector139>:
8010704f:	6a 00                	push   $0x0
80107051:	68 8b 00 00 00       	push   $0x8b
80107056:	e9 1e f5 ff ff       	jmp    80106579 <alltraps>

8010705b <vector140>:
8010705b:	6a 00                	push   $0x0
8010705d:	68 8c 00 00 00       	push   $0x8c
80107062:	e9 12 f5 ff ff       	jmp    80106579 <alltraps>

80107067 <vector141>:
80107067:	6a 00                	push   $0x0
80107069:	68 8d 00 00 00       	push   $0x8d
8010706e:	e9 06 f5 ff ff       	jmp    80106579 <alltraps>

80107073 <vector142>:
80107073:	6a 00                	push   $0x0
80107075:	68 8e 00 00 00       	push   $0x8e
8010707a:	e9 fa f4 ff ff       	jmp    80106579 <alltraps>

8010707f <vector143>:
8010707f:	6a 00                	push   $0x0
80107081:	68 8f 00 00 00       	push   $0x8f
80107086:	e9 ee f4 ff ff       	jmp    80106579 <alltraps>

8010708b <vector144>:
8010708b:	6a 00                	push   $0x0
8010708d:	68 90 00 00 00       	push   $0x90
80107092:	e9 e2 f4 ff ff       	jmp    80106579 <alltraps>

80107097 <vector145>:
80107097:	6a 00                	push   $0x0
80107099:	68 91 00 00 00       	push   $0x91
8010709e:	e9 d6 f4 ff ff       	jmp    80106579 <alltraps>

801070a3 <vector146>:
801070a3:	6a 00                	push   $0x0
801070a5:	68 92 00 00 00       	push   $0x92
801070aa:	e9 ca f4 ff ff       	jmp    80106579 <alltraps>

801070af <vector147>:
801070af:	6a 00                	push   $0x0
801070b1:	68 93 00 00 00       	push   $0x93
801070b6:	e9 be f4 ff ff       	jmp    80106579 <alltraps>

801070bb <vector148>:
801070bb:	6a 00                	push   $0x0
801070bd:	68 94 00 00 00       	push   $0x94
801070c2:	e9 b2 f4 ff ff       	jmp    80106579 <alltraps>

801070c7 <vector149>:
801070c7:	6a 00                	push   $0x0
801070c9:	68 95 00 00 00       	push   $0x95
801070ce:	e9 a6 f4 ff ff       	jmp    80106579 <alltraps>

801070d3 <vector150>:
801070d3:	6a 00                	push   $0x0
801070d5:	68 96 00 00 00       	push   $0x96
801070da:	e9 9a f4 ff ff       	jmp    80106579 <alltraps>

801070df <vector151>:
801070df:	6a 00                	push   $0x0
801070e1:	68 97 00 00 00       	push   $0x97
801070e6:	e9 8e f4 ff ff       	jmp    80106579 <alltraps>

801070eb <vector152>:
801070eb:	6a 00                	push   $0x0
801070ed:	68 98 00 00 00       	push   $0x98
801070f2:	e9 82 f4 ff ff       	jmp    80106579 <alltraps>

801070f7 <vector153>:
801070f7:	6a 00                	push   $0x0
801070f9:	68 99 00 00 00       	push   $0x99
801070fe:	e9 76 f4 ff ff       	jmp    80106579 <alltraps>

80107103 <vector154>:
80107103:	6a 00                	push   $0x0
80107105:	68 9a 00 00 00       	push   $0x9a
8010710a:	e9 6a f4 ff ff       	jmp    80106579 <alltraps>

8010710f <vector155>:
8010710f:	6a 00                	push   $0x0
80107111:	68 9b 00 00 00       	push   $0x9b
80107116:	e9 5e f4 ff ff       	jmp    80106579 <alltraps>

8010711b <vector156>:
8010711b:	6a 00                	push   $0x0
8010711d:	68 9c 00 00 00       	push   $0x9c
80107122:	e9 52 f4 ff ff       	jmp    80106579 <alltraps>

80107127 <vector157>:
80107127:	6a 00                	push   $0x0
80107129:	68 9d 00 00 00       	push   $0x9d
8010712e:	e9 46 f4 ff ff       	jmp    80106579 <alltraps>

80107133 <vector158>:
80107133:	6a 00                	push   $0x0
80107135:	68 9e 00 00 00       	push   $0x9e
8010713a:	e9 3a f4 ff ff       	jmp    80106579 <alltraps>

8010713f <vector159>:
8010713f:	6a 00                	push   $0x0
80107141:	68 9f 00 00 00       	push   $0x9f
80107146:	e9 2e f4 ff ff       	jmp    80106579 <alltraps>

8010714b <vector160>:
8010714b:	6a 00                	push   $0x0
8010714d:	68 a0 00 00 00       	push   $0xa0
80107152:	e9 22 f4 ff ff       	jmp    80106579 <alltraps>

80107157 <vector161>:
80107157:	6a 00                	push   $0x0
80107159:	68 a1 00 00 00       	push   $0xa1
8010715e:	e9 16 f4 ff ff       	jmp    80106579 <alltraps>

80107163 <vector162>:
80107163:	6a 00                	push   $0x0
80107165:	68 a2 00 00 00       	push   $0xa2
8010716a:	e9 0a f4 ff ff       	jmp    80106579 <alltraps>

8010716f <vector163>:
8010716f:	6a 00                	push   $0x0
80107171:	68 a3 00 00 00       	push   $0xa3
80107176:	e9 fe f3 ff ff       	jmp    80106579 <alltraps>

8010717b <vector164>:
8010717b:	6a 00                	push   $0x0
8010717d:	68 a4 00 00 00       	push   $0xa4
80107182:	e9 f2 f3 ff ff       	jmp    80106579 <alltraps>

80107187 <vector165>:
80107187:	6a 00                	push   $0x0
80107189:	68 a5 00 00 00       	push   $0xa5
8010718e:	e9 e6 f3 ff ff       	jmp    80106579 <alltraps>

80107193 <vector166>:
80107193:	6a 00                	push   $0x0
80107195:	68 a6 00 00 00       	push   $0xa6
8010719a:	e9 da f3 ff ff       	jmp    80106579 <alltraps>

8010719f <vector167>:
8010719f:	6a 00                	push   $0x0
801071a1:	68 a7 00 00 00       	push   $0xa7
801071a6:	e9 ce f3 ff ff       	jmp    80106579 <alltraps>

801071ab <vector168>:
801071ab:	6a 00                	push   $0x0
801071ad:	68 a8 00 00 00       	push   $0xa8
801071b2:	e9 c2 f3 ff ff       	jmp    80106579 <alltraps>

801071b7 <vector169>:
801071b7:	6a 00                	push   $0x0
801071b9:	68 a9 00 00 00       	push   $0xa9
801071be:	e9 b6 f3 ff ff       	jmp    80106579 <alltraps>

801071c3 <vector170>:
801071c3:	6a 00                	push   $0x0
801071c5:	68 aa 00 00 00       	push   $0xaa
801071ca:	e9 aa f3 ff ff       	jmp    80106579 <alltraps>

801071cf <vector171>:
801071cf:	6a 00                	push   $0x0
801071d1:	68 ab 00 00 00       	push   $0xab
801071d6:	e9 9e f3 ff ff       	jmp    80106579 <alltraps>

801071db <vector172>:
801071db:	6a 00                	push   $0x0
801071dd:	68 ac 00 00 00       	push   $0xac
801071e2:	e9 92 f3 ff ff       	jmp    80106579 <alltraps>

801071e7 <vector173>:
801071e7:	6a 00                	push   $0x0
801071e9:	68 ad 00 00 00       	push   $0xad
801071ee:	e9 86 f3 ff ff       	jmp    80106579 <alltraps>

801071f3 <vector174>:
801071f3:	6a 00                	push   $0x0
801071f5:	68 ae 00 00 00       	push   $0xae
801071fa:	e9 7a f3 ff ff       	jmp    80106579 <alltraps>

801071ff <vector175>:
801071ff:	6a 00                	push   $0x0
80107201:	68 af 00 00 00       	push   $0xaf
80107206:	e9 6e f3 ff ff       	jmp    80106579 <alltraps>

8010720b <vector176>:
8010720b:	6a 00                	push   $0x0
8010720d:	68 b0 00 00 00       	push   $0xb0
80107212:	e9 62 f3 ff ff       	jmp    80106579 <alltraps>

80107217 <vector177>:
80107217:	6a 00                	push   $0x0
80107219:	68 b1 00 00 00       	push   $0xb1
8010721e:	e9 56 f3 ff ff       	jmp    80106579 <alltraps>

80107223 <vector178>:
80107223:	6a 00                	push   $0x0
80107225:	68 b2 00 00 00       	push   $0xb2
8010722a:	e9 4a f3 ff ff       	jmp    80106579 <alltraps>

8010722f <vector179>:
8010722f:	6a 00                	push   $0x0
80107231:	68 b3 00 00 00       	push   $0xb3
80107236:	e9 3e f3 ff ff       	jmp    80106579 <alltraps>

8010723b <vector180>:
8010723b:	6a 00                	push   $0x0
8010723d:	68 b4 00 00 00       	push   $0xb4
80107242:	e9 32 f3 ff ff       	jmp    80106579 <alltraps>

80107247 <vector181>:
80107247:	6a 00                	push   $0x0
80107249:	68 b5 00 00 00       	push   $0xb5
8010724e:	e9 26 f3 ff ff       	jmp    80106579 <alltraps>

80107253 <vector182>:
80107253:	6a 00                	push   $0x0
80107255:	68 b6 00 00 00       	push   $0xb6
8010725a:	e9 1a f3 ff ff       	jmp    80106579 <alltraps>

8010725f <vector183>:
8010725f:	6a 00                	push   $0x0
80107261:	68 b7 00 00 00       	push   $0xb7
80107266:	e9 0e f3 ff ff       	jmp    80106579 <alltraps>

8010726b <vector184>:
8010726b:	6a 00                	push   $0x0
8010726d:	68 b8 00 00 00       	push   $0xb8
80107272:	e9 02 f3 ff ff       	jmp    80106579 <alltraps>

80107277 <vector185>:
80107277:	6a 00                	push   $0x0
80107279:	68 b9 00 00 00       	push   $0xb9
8010727e:	e9 f6 f2 ff ff       	jmp    80106579 <alltraps>

80107283 <vector186>:
80107283:	6a 00                	push   $0x0
80107285:	68 ba 00 00 00       	push   $0xba
8010728a:	e9 ea f2 ff ff       	jmp    80106579 <alltraps>

8010728f <vector187>:
8010728f:	6a 00                	push   $0x0
80107291:	68 bb 00 00 00       	push   $0xbb
80107296:	e9 de f2 ff ff       	jmp    80106579 <alltraps>

8010729b <vector188>:
8010729b:	6a 00                	push   $0x0
8010729d:	68 bc 00 00 00       	push   $0xbc
801072a2:	e9 d2 f2 ff ff       	jmp    80106579 <alltraps>

801072a7 <vector189>:
801072a7:	6a 00                	push   $0x0
801072a9:	68 bd 00 00 00       	push   $0xbd
801072ae:	e9 c6 f2 ff ff       	jmp    80106579 <alltraps>

801072b3 <vector190>:
801072b3:	6a 00                	push   $0x0
801072b5:	68 be 00 00 00       	push   $0xbe
801072ba:	e9 ba f2 ff ff       	jmp    80106579 <alltraps>

801072bf <vector191>:
801072bf:	6a 00                	push   $0x0
801072c1:	68 bf 00 00 00       	push   $0xbf
801072c6:	e9 ae f2 ff ff       	jmp    80106579 <alltraps>

801072cb <vector192>:
801072cb:	6a 00                	push   $0x0
801072cd:	68 c0 00 00 00       	push   $0xc0
801072d2:	e9 a2 f2 ff ff       	jmp    80106579 <alltraps>

801072d7 <vector193>:
801072d7:	6a 00                	push   $0x0
801072d9:	68 c1 00 00 00       	push   $0xc1
801072de:	e9 96 f2 ff ff       	jmp    80106579 <alltraps>

801072e3 <vector194>:
801072e3:	6a 00                	push   $0x0
801072e5:	68 c2 00 00 00       	push   $0xc2
801072ea:	e9 8a f2 ff ff       	jmp    80106579 <alltraps>

801072ef <vector195>:
801072ef:	6a 00                	push   $0x0
801072f1:	68 c3 00 00 00       	push   $0xc3
801072f6:	e9 7e f2 ff ff       	jmp    80106579 <alltraps>

801072fb <vector196>:
801072fb:	6a 00                	push   $0x0
801072fd:	68 c4 00 00 00       	push   $0xc4
80107302:	e9 72 f2 ff ff       	jmp    80106579 <alltraps>

80107307 <vector197>:
80107307:	6a 00                	push   $0x0
80107309:	68 c5 00 00 00       	push   $0xc5
8010730e:	e9 66 f2 ff ff       	jmp    80106579 <alltraps>

80107313 <vector198>:
80107313:	6a 00                	push   $0x0
80107315:	68 c6 00 00 00       	push   $0xc6
8010731a:	e9 5a f2 ff ff       	jmp    80106579 <alltraps>

8010731f <vector199>:
8010731f:	6a 00                	push   $0x0
80107321:	68 c7 00 00 00       	push   $0xc7
80107326:	e9 4e f2 ff ff       	jmp    80106579 <alltraps>

8010732b <vector200>:
8010732b:	6a 00                	push   $0x0
8010732d:	68 c8 00 00 00       	push   $0xc8
80107332:	e9 42 f2 ff ff       	jmp    80106579 <alltraps>

80107337 <vector201>:
80107337:	6a 00                	push   $0x0
80107339:	68 c9 00 00 00       	push   $0xc9
8010733e:	e9 36 f2 ff ff       	jmp    80106579 <alltraps>

80107343 <vector202>:
80107343:	6a 00                	push   $0x0
80107345:	68 ca 00 00 00       	push   $0xca
8010734a:	e9 2a f2 ff ff       	jmp    80106579 <alltraps>

8010734f <vector203>:
8010734f:	6a 00                	push   $0x0
80107351:	68 cb 00 00 00       	push   $0xcb
80107356:	e9 1e f2 ff ff       	jmp    80106579 <alltraps>

8010735b <vector204>:
8010735b:	6a 00                	push   $0x0
8010735d:	68 cc 00 00 00       	push   $0xcc
80107362:	e9 12 f2 ff ff       	jmp    80106579 <alltraps>

80107367 <vector205>:
80107367:	6a 00                	push   $0x0
80107369:	68 cd 00 00 00       	push   $0xcd
8010736e:	e9 06 f2 ff ff       	jmp    80106579 <alltraps>

80107373 <vector206>:
80107373:	6a 00                	push   $0x0
80107375:	68 ce 00 00 00       	push   $0xce
8010737a:	e9 fa f1 ff ff       	jmp    80106579 <alltraps>

8010737f <vector207>:
8010737f:	6a 00                	push   $0x0
80107381:	68 cf 00 00 00       	push   $0xcf
80107386:	e9 ee f1 ff ff       	jmp    80106579 <alltraps>

8010738b <vector208>:
8010738b:	6a 00                	push   $0x0
8010738d:	68 d0 00 00 00       	push   $0xd0
80107392:	e9 e2 f1 ff ff       	jmp    80106579 <alltraps>

80107397 <vector209>:
80107397:	6a 00                	push   $0x0
80107399:	68 d1 00 00 00       	push   $0xd1
8010739e:	e9 d6 f1 ff ff       	jmp    80106579 <alltraps>

801073a3 <vector210>:
801073a3:	6a 00                	push   $0x0
801073a5:	68 d2 00 00 00       	push   $0xd2
801073aa:	e9 ca f1 ff ff       	jmp    80106579 <alltraps>

801073af <vector211>:
801073af:	6a 00                	push   $0x0
801073b1:	68 d3 00 00 00       	push   $0xd3
801073b6:	e9 be f1 ff ff       	jmp    80106579 <alltraps>

801073bb <vector212>:
801073bb:	6a 00                	push   $0x0
801073bd:	68 d4 00 00 00       	push   $0xd4
801073c2:	e9 b2 f1 ff ff       	jmp    80106579 <alltraps>

801073c7 <vector213>:
801073c7:	6a 00                	push   $0x0
801073c9:	68 d5 00 00 00       	push   $0xd5
801073ce:	e9 a6 f1 ff ff       	jmp    80106579 <alltraps>

801073d3 <vector214>:
801073d3:	6a 00                	push   $0x0
801073d5:	68 d6 00 00 00       	push   $0xd6
801073da:	e9 9a f1 ff ff       	jmp    80106579 <alltraps>

801073df <vector215>:
801073df:	6a 00                	push   $0x0
801073e1:	68 d7 00 00 00       	push   $0xd7
801073e6:	e9 8e f1 ff ff       	jmp    80106579 <alltraps>

801073eb <vector216>:
801073eb:	6a 00                	push   $0x0
801073ed:	68 d8 00 00 00       	push   $0xd8
801073f2:	e9 82 f1 ff ff       	jmp    80106579 <alltraps>

801073f7 <vector217>:
801073f7:	6a 00                	push   $0x0
801073f9:	68 d9 00 00 00       	push   $0xd9
801073fe:	e9 76 f1 ff ff       	jmp    80106579 <alltraps>

80107403 <vector218>:
80107403:	6a 00                	push   $0x0
80107405:	68 da 00 00 00       	push   $0xda
8010740a:	e9 6a f1 ff ff       	jmp    80106579 <alltraps>

8010740f <vector219>:
8010740f:	6a 00                	push   $0x0
80107411:	68 db 00 00 00       	push   $0xdb
80107416:	e9 5e f1 ff ff       	jmp    80106579 <alltraps>

8010741b <vector220>:
8010741b:	6a 00                	push   $0x0
8010741d:	68 dc 00 00 00       	push   $0xdc
80107422:	e9 52 f1 ff ff       	jmp    80106579 <alltraps>

80107427 <vector221>:
80107427:	6a 00                	push   $0x0
80107429:	68 dd 00 00 00       	push   $0xdd
8010742e:	e9 46 f1 ff ff       	jmp    80106579 <alltraps>

80107433 <vector222>:
80107433:	6a 00                	push   $0x0
80107435:	68 de 00 00 00       	push   $0xde
8010743a:	e9 3a f1 ff ff       	jmp    80106579 <alltraps>

8010743f <vector223>:
8010743f:	6a 00                	push   $0x0
80107441:	68 df 00 00 00       	push   $0xdf
80107446:	e9 2e f1 ff ff       	jmp    80106579 <alltraps>

8010744b <vector224>:
8010744b:	6a 00                	push   $0x0
8010744d:	68 e0 00 00 00       	push   $0xe0
80107452:	e9 22 f1 ff ff       	jmp    80106579 <alltraps>

80107457 <vector225>:
80107457:	6a 00                	push   $0x0
80107459:	68 e1 00 00 00       	push   $0xe1
8010745e:	e9 16 f1 ff ff       	jmp    80106579 <alltraps>

80107463 <vector226>:
80107463:	6a 00                	push   $0x0
80107465:	68 e2 00 00 00       	push   $0xe2
8010746a:	e9 0a f1 ff ff       	jmp    80106579 <alltraps>

8010746f <vector227>:
8010746f:	6a 00                	push   $0x0
80107471:	68 e3 00 00 00       	push   $0xe3
80107476:	e9 fe f0 ff ff       	jmp    80106579 <alltraps>

8010747b <vector228>:
8010747b:	6a 00                	push   $0x0
8010747d:	68 e4 00 00 00       	push   $0xe4
80107482:	e9 f2 f0 ff ff       	jmp    80106579 <alltraps>

80107487 <vector229>:
80107487:	6a 00                	push   $0x0
80107489:	68 e5 00 00 00       	push   $0xe5
8010748e:	e9 e6 f0 ff ff       	jmp    80106579 <alltraps>

80107493 <vector230>:
80107493:	6a 00                	push   $0x0
80107495:	68 e6 00 00 00       	push   $0xe6
8010749a:	e9 da f0 ff ff       	jmp    80106579 <alltraps>

8010749f <vector231>:
8010749f:	6a 00                	push   $0x0
801074a1:	68 e7 00 00 00       	push   $0xe7
801074a6:	e9 ce f0 ff ff       	jmp    80106579 <alltraps>

801074ab <vector232>:
801074ab:	6a 00                	push   $0x0
801074ad:	68 e8 00 00 00       	push   $0xe8
801074b2:	e9 c2 f0 ff ff       	jmp    80106579 <alltraps>

801074b7 <vector233>:
801074b7:	6a 00                	push   $0x0
801074b9:	68 e9 00 00 00       	push   $0xe9
801074be:	e9 b6 f0 ff ff       	jmp    80106579 <alltraps>

801074c3 <vector234>:
801074c3:	6a 00                	push   $0x0
801074c5:	68 ea 00 00 00       	push   $0xea
801074ca:	e9 aa f0 ff ff       	jmp    80106579 <alltraps>

801074cf <vector235>:
801074cf:	6a 00                	push   $0x0
801074d1:	68 eb 00 00 00       	push   $0xeb
801074d6:	e9 9e f0 ff ff       	jmp    80106579 <alltraps>

801074db <vector236>:
801074db:	6a 00                	push   $0x0
801074dd:	68 ec 00 00 00       	push   $0xec
801074e2:	e9 92 f0 ff ff       	jmp    80106579 <alltraps>

801074e7 <vector237>:
801074e7:	6a 00                	push   $0x0
801074e9:	68 ed 00 00 00       	push   $0xed
801074ee:	e9 86 f0 ff ff       	jmp    80106579 <alltraps>

801074f3 <vector238>:
801074f3:	6a 00                	push   $0x0
801074f5:	68 ee 00 00 00       	push   $0xee
801074fa:	e9 7a f0 ff ff       	jmp    80106579 <alltraps>

801074ff <vector239>:
801074ff:	6a 00                	push   $0x0
80107501:	68 ef 00 00 00       	push   $0xef
80107506:	e9 6e f0 ff ff       	jmp    80106579 <alltraps>

8010750b <vector240>:
8010750b:	6a 00                	push   $0x0
8010750d:	68 f0 00 00 00       	push   $0xf0
80107512:	e9 62 f0 ff ff       	jmp    80106579 <alltraps>

80107517 <vector241>:
80107517:	6a 00                	push   $0x0
80107519:	68 f1 00 00 00       	push   $0xf1
8010751e:	e9 56 f0 ff ff       	jmp    80106579 <alltraps>

80107523 <vector242>:
80107523:	6a 00                	push   $0x0
80107525:	68 f2 00 00 00       	push   $0xf2
8010752a:	e9 4a f0 ff ff       	jmp    80106579 <alltraps>

8010752f <vector243>:
8010752f:	6a 00                	push   $0x0
80107531:	68 f3 00 00 00       	push   $0xf3
80107536:	e9 3e f0 ff ff       	jmp    80106579 <alltraps>

8010753b <vector244>:
8010753b:	6a 00                	push   $0x0
8010753d:	68 f4 00 00 00       	push   $0xf4
80107542:	e9 32 f0 ff ff       	jmp    80106579 <alltraps>

80107547 <vector245>:
80107547:	6a 00                	push   $0x0
80107549:	68 f5 00 00 00       	push   $0xf5
8010754e:	e9 26 f0 ff ff       	jmp    80106579 <alltraps>

80107553 <vector246>:
80107553:	6a 00                	push   $0x0
80107555:	68 f6 00 00 00       	push   $0xf6
8010755a:	e9 1a f0 ff ff       	jmp    80106579 <alltraps>

8010755f <vector247>:
8010755f:	6a 00                	push   $0x0
80107561:	68 f7 00 00 00       	push   $0xf7
80107566:	e9 0e f0 ff ff       	jmp    80106579 <alltraps>

8010756b <vector248>:
8010756b:	6a 00                	push   $0x0
8010756d:	68 f8 00 00 00       	push   $0xf8
80107572:	e9 02 f0 ff ff       	jmp    80106579 <alltraps>

80107577 <vector249>:
80107577:	6a 00                	push   $0x0
80107579:	68 f9 00 00 00       	push   $0xf9
8010757e:	e9 f6 ef ff ff       	jmp    80106579 <alltraps>

80107583 <vector250>:
80107583:	6a 00                	push   $0x0
80107585:	68 fa 00 00 00       	push   $0xfa
8010758a:	e9 ea ef ff ff       	jmp    80106579 <alltraps>

8010758f <vector251>:
8010758f:	6a 00                	push   $0x0
80107591:	68 fb 00 00 00       	push   $0xfb
80107596:	e9 de ef ff ff       	jmp    80106579 <alltraps>

8010759b <vector252>:
8010759b:	6a 00                	push   $0x0
8010759d:	68 fc 00 00 00       	push   $0xfc
801075a2:	e9 d2 ef ff ff       	jmp    80106579 <alltraps>

801075a7 <vector253>:
801075a7:	6a 00                	push   $0x0
801075a9:	68 fd 00 00 00       	push   $0xfd
801075ae:	e9 c6 ef ff ff       	jmp    80106579 <alltraps>

801075b3 <vector254>:
801075b3:	6a 00                	push   $0x0
801075b5:	68 fe 00 00 00       	push   $0xfe
801075ba:	e9 ba ef ff ff       	jmp    80106579 <alltraps>

801075bf <vector255>:
801075bf:	6a 00                	push   $0x0
801075c1:	68 ff 00 00 00       	push   $0xff
801075c6:	e9 ae ef ff ff       	jmp    80106579 <alltraps>
801075cb:	66 90                	xchg   %ax,%ax
801075cd:	66 90                	xchg   %ax,%ax
801075cf:	90                   	nop

801075d0 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
801075d0:	55                   	push   %ebp
801075d1:	89 e5                	mov    %esp,%ebp
801075d3:	57                   	push   %edi
801075d4:	56                   	push   %esi
801075d5:	89 d6                	mov    %edx,%esi
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
801075d7:	c1 ea 16             	shr    $0x16,%edx
{
801075da:	53                   	push   %ebx
  pde = &pgdir[PDX(va)];
801075db:	8d 3c 90             	lea    (%eax,%edx,4),%edi
{
801075de:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
801075e1:	8b 1f                	mov    (%edi),%ebx
801075e3:	f6 c3 01             	test   $0x1,%bl
801075e6:	74 28                	je     80107610 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801075e8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
801075ee:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
801075f4:	89 f0                	mov    %esi,%eax
}
801075f6:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
801075f9:	c1 e8 0a             	shr    $0xa,%eax
801075fc:	25 fc 0f 00 00       	and    $0xffc,%eax
80107601:	01 d8                	add    %ebx,%eax
}
80107603:	5b                   	pop    %ebx
80107604:	5e                   	pop    %esi
80107605:	5f                   	pop    %edi
80107606:	5d                   	pop    %ebp
80107607:	c3                   	ret    
80107608:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010760f:	90                   	nop
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107610:	85 c9                	test   %ecx,%ecx
80107612:	74 2c                	je     80107640 <walkpgdir+0x70>
80107614:	e8 f7 b3 ff ff       	call   80102a10 <kalloc>
80107619:	89 c3                	mov    %eax,%ebx
8010761b:	85 c0                	test   %eax,%eax
8010761d:	74 21                	je     80107640 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
8010761f:	83 ec 04             	sub    $0x4,%esp
80107622:	68 00 10 00 00       	push   $0x1000
80107627:	6a 00                	push   $0x0
80107629:	50                   	push   %eax
8010762a:	e8 61 db ff ff       	call   80105190 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010762f:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107635:	83 c4 10             	add    $0x10,%esp
80107638:	83 c8 07             	or     $0x7,%eax
8010763b:	89 07                	mov    %eax,(%edi)
8010763d:	eb b5                	jmp    801075f4 <walkpgdir+0x24>
8010763f:	90                   	nop
}
80107640:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
80107643:	31 c0                	xor    %eax,%eax
}
80107645:	5b                   	pop    %ebx
80107646:	5e                   	pop    %esi
80107647:	5f                   	pop    %edi
80107648:	5d                   	pop    %ebp
80107649:	c3                   	ret    
8010764a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107650 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107650:	55                   	push   %ebp
80107651:	89 e5                	mov    %esp,%ebp
80107653:	57                   	push   %edi
80107654:	56                   	push   %esi
80107655:	89 c6                	mov    %eax,%esi
80107657:	53                   	push   %ebx
80107658:	89 d3                	mov    %edx,%ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
8010765a:	8d 91 ff 0f 00 00    	lea    0xfff(%ecx),%edx
80107660:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107666:	83 ec 1c             	sub    $0x1c,%esp
80107669:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
8010766c:	39 da                	cmp    %ebx,%edx
8010766e:	73 5b                	jae    801076cb <deallocuvm.part.0+0x7b>
80107670:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80107673:	89 d7                	mov    %edx,%edi
80107675:	eb 14                	jmp    8010768b <deallocuvm.part.0+0x3b>
80107677:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010767e:	66 90                	xchg   %ax,%ax
80107680:	81 c7 00 10 00 00    	add    $0x1000,%edi
80107686:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80107689:	76 40                	jbe    801076cb <deallocuvm.part.0+0x7b>
    pte = walkpgdir(pgdir, (char*)a, 0);
8010768b:	31 c9                	xor    %ecx,%ecx
8010768d:	89 fa                	mov    %edi,%edx
8010768f:	89 f0                	mov    %esi,%eax
80107691:	e8 3a ff ff ff       	call   801075d0 <walkpgdir>
80107696:	89 c3                	mov    %eax,%ebx
    if(!pte)
80107698:	85 c0                	test   %eax,%eax
8010769a:	74 44                	je     801076e0 <deallocuvm.part.0+0x90>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
8010769c:	8b 00                	mov    (%eax),%eax
8010769e:	a8 01                	test   $0x1,%al
801076a0:	74 de                	je     80107680 <deallocuvm.part.0+0x30>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
801076a2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801076a7:	74 47                	je     801076f0 <deallocuvm.part.0+0xa0>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
801076a9:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
801076ac:	05 00 00 00 80       	add    $0x80000000,%eax
801076b1:	81 c7 00 10 00 00    	add    $0x1000,%edi
      kfree(v);
801076b7:	50                   	push   %eax
801076b8:	e8 93 b1 ff ff       	call   80102850 <kfree>
      *pte = 0;
801076bd:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801076c3:	83 c4 10             	add    $0x10,%esp
  for(; a  < oldsz; a += PGSIZE){
801076c6:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801076c9:	77 c0                	ja     8010768b <deallocuvm.part.0+0x3b>
    }
  }
  return newsz;
}
801076cb:	8b 45 e0             	mov    -0x20(%ebp),%eax
801076ce:	8d 65 f4             	lea    -0xc(%ebp),%esp
801076d1:	5b                   	pop    %ebx
801076d2:	5e                   	pop    %esi
801076d3:	5f                   	pop    %edi
801076d4:	5d                   	pop    %ebp
801076d5:	c3                   	ret    
801076d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801076dd:	8d 76 00             	lea    0x0(%esi),%esi
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
801076e0:	89 fa                	mov    %edi,%edx
801076e2:	81 e2 00 00 c0 ff    	and    $0xffc00000,%edx
801076e8:	8d ba 00 00 40 00    	lea    0x400000(%edx),%edi
801076ee:	eb 96                	jmp    80107686 <deallocuvm.part.0+0x36>
        panic("kfree");
801076f0:	83 ec 0c             	sub    $0xc,%esp
801076f3:	68 fe 81 10 80       	push   $0x801081fe
801076f8:	e8 93 8c ff ff       	call   80100390 <panic>
801076fd:	8d 76 00             	lea    0x0(%esi),%esi

80107700 <seginit>:
{
80107700:	f3 0f 1e fb          	endbr32 
80107704:	55                   	push   %ebp
80107705:	89 e5                	mov    %esp,%ebp
80107707:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
8010770a:	e8 91 c6 ff ff       	call   80103da0 <cpuid>
  pd[0] = size-1;
8010770f:	ba 2f 00 00 00       	mov    $0x2f,%edx
80107714:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
8010771a:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010771e:	c7 80 38 38 11 80 ff 	movl   $0xffff,-0x7feec7c8(%eax)
80107725:	ff 00 00 
80107728:	c7 80 3c 38 11 80 00 	movl   $0xcf9a00,-0x7feec7c4(%eax)
8010772f:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80107732:	c7 80 40 38 11 80 ff 	movl   $0xffff,-0x7feec7c0(%eax)
80107739:	ff 00 00 
8010773c:	c7 80 44 38 11 80 00 	movl   $0xcf9200,-0x7feec7bc(%eax)
80107743:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107746:	c7 80 48 38 11 80 ff 	movl   $0xffff,-0x7feec7b8(%eax)
8010774d:	ff 00 00 
80107750:	c7 80 4c 38 11 80 00 	movl   $0xcffa00,-0x7feec7b4(%eax)
80107757:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
8010775a:	c7 80 50 38 11 80 ff 	movl   $0xffff,-0x7feec7b0(%eax)
80107761:	ff 00 00 
80107764:	c7 80 54 38 11 80 00 	movl   $0xcff200,-0x7feec7ac(%eax)
8010776b:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
8010776e:	05 30 38 11 80       	add    $0x80113830,%eax
  pd[1] = (uint)p;
80107773:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80107777:	c1 e8 10             	shr    $0x10,%eax
8010777a:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
8010777e:	8d 45 f2             	lea    -0xe(%ebp),%eax
80107781:	0f 01 10             	lgdtl  (%eax)
}
80107784:	c9                   	leave  
80107785:	c3                   	ret    
80107786:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010778d:	8d 76 00             	lea    0x0(%esi),%esi

80107790 <mappages>:
{
80107790:	f3 0f 1e fb          	endbr32 
80107794:	55                   	push   %ebp
80107795:	89 e5                	mov    %esp,%ebp
80107797:	57                   	push   %edi
80107798:	56                   	push   %esi
80107799:	53                   	push   %ebx
8010779a:	83 ec 1c             	sub    $0x1c,%esp
8010779d:	8b 45 0c             	mov    0xc(%ebp),%eax
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
801077a0:	8b 4d 10             	mov    0x10(%ebp),%ecx
{
801077a3:	8b 7d 08             	mov    0x8(%ebp),%edi
  a = (char*)PGROUNDDOWN((uint)va);
801077a6:	89 c6                	mov    %eax,%esi
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
801077a8:	8d 44 08 ff          	lea    -0x1(%eax,%ecx,1),%eax
801077ac:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  a = (char*)PGROUNDDOWN((uint)va);
801077b1:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
801077b7:	89 45 e0             	mov    %eax,-0x20(%ebp)
801077ba:	8b 45 14             	mov    0x14(%ebp),%eax
801077bd:	29 f0                	sub    %esi,%eax
801077bf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801077c2:	eb 1c                	jmp    801077e0 <mappages+0x50>
801077c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(*pte & PTE_P)
801077c8:	f6 00 01             	testb  $0x1,(%eax)
801077cb:	75 45                	jne    80107812 <mappages+0x82>
    *pte = pa | perm | PTE_P;
801077cd:	0b 5d 18             	or     0x18(%ebp),%ebx
801077d0:	83 cb 01             	or     $0x1,%ebx
801077d3:	89 18                	mov    %ebx,(%eax)
    if(a == last)
801077d5:	3b 75 e0             	cmp    -0x20(%ebp),%esi
801077d8:	74 2e                	je     80107808 <mappages+0x78>
    a += PGSIZE;
801077da:	81 c6 00 10 00 00    	add    $0x1000,%esi
  for(;;){
801077e0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
801077e3:	b9 01 00 00 00       	mov    $0x1,%ecx
801077e8:	89 f2                	mov    %esi,%edx
801077ea:	8d 1c 06             	lea    (%esi,%eax,1),%ebx
801077ed:	89 f8                	mov    %edi,%eax
801077ef:	e8 dc fd ff ff       	call   801075d0 <walkpgdir>
801077f4:	85 c0                	test   %eax,%eax
801077f6:	75 d0                	jne    801077c8 <mappages+0x38>
}
801077f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801077fb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107800:	5b                   	pop    %ebx
80107801:	5e                   	pop    %esi
80107802:	5f                   	pop    %edi
80107803:	5d                   	pop    %ebp
80107804:	c3                   	ret    
80107805:	8d 76 00             	lea    0x0(%esi),%esi
80107808:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010780b:	31 c0                	xor    %eax,%eax
}
8010780d:	5b                   	pop    %ebx
8010780e:	5e                   	pop    %esi
8010780f:	5f                   	pop    %edi
80107810:	5d                   	pop    %ebp
80107811:	c3                   	ret    
      panic("remap");
80107812:	83 ec 0c             	sub    $0xc,%esp
80107815:	68 80 89 10 80       	push   $0x80108980
8010781a:	e8 71 8b ff ff       	call   80100390 <panic>
8010781f:	90                   	nop

80107820 <switchkvm>:
{
80107820:	f3 0f 1e fb          	endbr32 
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107824:	a1 04 9b 11 80       	mov    0x80119b04,%eax
80107829:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010782e:	0f 22 d8             	mov    %eax,%cr3
}
80107831:	c3                   	ret    
80107832:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107839:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107840 <switchuvm>:
{
80107840:	f3 0f 1e fb          	endbr32 
80107844:	55                   	push   %ebp
80107845:	89 e5                	mov    %esp,%ebp
80107847:	57                   	push   %edi
80107848:	56                   	push   %esi
80107849:	53                   	push   %ebx
8010784a:	83 ec 1c             	sub    $0x1c,%esp
8010784d:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80107850:	85 f6                	test   %esi,%esi
80107852:	0f 84 cb 00 00 00    	je     80107923 <switchuvm+0xe3>
  if(p->kstack == 0)
80107858:	8b 46 08             	mov    0x8(%esi),%eax
8010785b:	85 c0                	test   %eax,%eax
8010785d:	0f 84 da 00 00 00    	je     8010793d <switchuvm+0xfd>
  if(p->pgdir == 0)
80107863:	8b 46 04             	mov    0x4(%esi),%eax
80107866:	85 c0                	test   %eax,%eax
80107868:	0f 84 c2 00 00 00    	je     80107930 <switchuvm+0xf0>
  pushcli();
8010786e:	e8 0d d7 ff ff       	call   80104f80 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80107873:	e8 b8 c4 ff ff       	call   80103d30 <mycpu>
80107878:	89 c3                	mov    %eax,%ebx
8010787a:	e8 b1 c4 ff ff       	call   80103d30 <mycpu>
8010787f:	89 c7                	mov    %eax,%edi
80107881:	e8 aa c4 ff ff       	call   80103d30 <mycpu>
80107886:	83 c7 08             	add    $0x8,%edi
80107889:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010788c:	e8 9f c4 ff ff       	call   80103d30 <mycpu>
80107891:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107894:	ba 67 00 00 00       	mov    $0x67,%edx
80107899:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
801078a0:	83 c0 08             	add    $0x8,%eax
801078a3:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801078aa:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
801078af:	83 c1 08             	add    $0x8,%ecx
801078b2:	c1 e8 18             	shr    $0x18,%eax
801078b5:	c1 e9 10             	shr    $0x10,%ecx
801078b8:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
801078be:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
801078c4:	b9 99 40 00 00       	mov    $0x4099,%ecx
801078c9:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
801078d0:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
801078d5:	e8 56 c4 ff ff       	call   80103d30 <mycpu>
801078da:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
801078e1:	e8 4a c4 ff ff       	call   80103d30 <mycpu>
801078e6:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
801078ea:	8b 5e 08             	mov    0x8(%esi),%ebx
801078ed:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801078f3:	e8 38 c4 ff ff       	call   80103d30 <mycpu>
801078f8:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801078fb:	e8 30 c4 ff ff       	call   80103d30 <mycpu>
80107900:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80107904:	b8 28 00 00 00       	mov    $0x28,%eax
80107909:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
8010790c:	8b 46 04             	mov    0x4(%esi),%eax
8010790f:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107914:	0f 22 d8             	mov    %eax,%cr3
}
80107917:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010791a:	5b                   	pop    %ebx
8010791b:	5e                   	pop    %esi
8010791c:	5f                   	pop    %edi
8010791d:	5d                   	pop    %ebp
  popcli();
8010791e:	e9 ad d6 ff ff       	jmp    80104fd0 <popcli>
    panic("switchuvm: no process");
80107923:	83 ec 0c             	sub    $0xc,%esp
80107926:	68 86 89 10 80       	push   $0x80108986
8010792b:	e8 60 8a ff ff       	call   80100390 <panic>
    panic("switchuvm: no pgdir");
80107930:	83 ec 0c             	sub    $0xc,%esp
80107933:	68 b1 89 10 80       	push   $0x801089b1
80107938:	e8 53 8a ff ff       	call   80100390 <panic>
    panic("switchuvm: no kstack");
8010793d:	83 ec 0c             	sub    $0xc,%esp
80107940:	68 9c 89 10 80       	push   $0x8010899c
80107945:	e8 46 8a ff ff       	call   80100390 <panic>
8010794a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107950 <inituvm>:
{
80107950:	f3 0f 1e fb          	endbr32 
80107954:	55                   	push   %ebp
80107955:	89 e5                	mov    %esp,%ebp
80107957:	57                   	push   %edi
80107958:	56                   	push   %esi
80107959:	53                   	push   %ebx
8010795a:	83 ec 1c             	sub    $0x1c,%esp
8010795d:	8b 75 10             	mov    0x10(%ebp),%esi
80107960:	8b 55 08             	mov    0x8(%ebp),%edx
80107963:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(sz >= PGSIZE)
80107966:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
8010796c:	77 50                	ja     801079be <inituvm+0x6e>
8010796e:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  mem = kalloc();
80107971:	e8 9a b0 ff ff       	call   80102a10 <kalloc>
  memset(mem, 0, PGSIZE);
80107976:	83 ec 04             	sub    $0x4,%esp
80107979:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
8010797e:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80107980:	6a 00                	push   $0x0
80107982:	50                   	push   %eax
80107983:	e8 08 d8 ff ff       	call   80105190 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107988:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010798b:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107991:	c7 04 24 06 00 00 00 	movl   $0x6,(%esp)
80107998:	50                   	push   %eax
80107999:	68 00 10 00 00       	push   $0x1000
8010799e:	6a 00                	push   $0x0
801079a0:	52                   	push   %edx
801079a1:	e8 ea fd ff ff       	call   80107790 <mappages>
  memmove(mem, init, sz);
801079a6:	89 75 10             	mov    %esi,0x10(%ebp)
801079a9:	83 c4 20             	add    $0x20,%esp
801079ac:	89 7d 0c             	mov    %edi,0xc(%ebp)
801079af:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801079b2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801079b5:	5b                   	pop    %ebx
801079b6:	5e                   	pop    %esi
801079b7:	5f                   	pop    %edi
801079b8:	5d                   	pop    %ebp
  memmove(mem, init, sz);
801079b9:	e9 72 d8 ff ff       	jmp    80105230 <memmove>
    panic("inituvm: more than a page");
801079be:	83 ec 0c             	sub    $0xc,%esp
801079c1:	68 c5 89 10 80       	push   $0x801089c5
801079c6:	e8 c5 89 ff ff       	call   80100390 <panic>
801079cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801079cf:	90                   	nop

801079d0 <loaduvm>:
{
801079d0:	f3 0f 1e fb          	endbr32 
801079d4:	55                   	push   %ebp
801079d5:	89 e5                	mov    %esp,%ebp
801079d7:	57                   	push   %edi
801079d8:	56                   	push   %esi
801079d9:	53                   	push   %ebx
801079da:	83 ec 1c             	sub    $0x1c,%esp
801079dd:	8b 45 0c             	mov    0xc(%ebp),%eax
801079e0:	8b 75 18             	mov    0x18(%ebp),%esi
  if((uint) addr % PGSIZE != 0)
801079e3:	a9 ff 0f 00 00       	test   $0xfff,%eax
801079e8:	0f 85 99 00 00 00    	jne    80107a87 <loaduvm+0xb7>
  for(i = 0; i < sz; i += PGSIZE){
801079ee:	01 f0                	add    %esi,%eax
801079f0:	89 f3                	mov    %esi,%ebx
801079f2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
801079f5:	8b 45 14             	mov    0x14(%ebp),%eax
801079f8:	01 f0                	add    %esi,%eax
801079fa:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
801079fd:	85 f6                	test   %esi,%esi
801079ff:	75 15                	jne    80107a16 <loaduvm+0x46>
80107a01:	eb 6d                	jmp    80107a70 <loaduvm+0xa0>
80107a03:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107a07:	90                   	nop
80107a08:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
80107a0e:	89 f0                	mov    %esi,%eax
80107a10:	29 d8                	sub    %ebx,%eax
80107a12:	39 c6                	cmp    %eax,%esi
80107a14:	76 5a                	jbe    80107a70 <loaduvm+0xa0>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80107a16:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107a19:	8b 45 08             	mov    0x8(%ebp),%eax
80107a1c:	31 c9                	xor    %ecx,%ecx
80107a1e:	29 da                	sub    %ebx,%edx
80107a20:	e8 ab fb ff ff       	call   801075d0 <walkpgdir>
80107a25:	85 c0                	test   %eax,%eax
80107a27:	74 51                	je     80107a7a <loaduvm+0xaa>
    pa = PTE_ADDR(*pte);
80107a29:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107a2b:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    if(sz - i < PGSIZE)
80107a2e:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80107a33:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80107a38:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
80107a3e:	0f 46 fb             	cmovbe %ebx,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107a41:	29 d9                	sub    %ebx,%ecx
80107a43:	05 00 00 00 80       	add    $0x80000000,%eax
80107a48:	57                   	push   %edi
80107a49:	51                   	push   %ecx
80107a4a:	50                   	push   %eax
80107a4b:	ff 75 10             	pushl  0x10(%ebp)
80107a4e:	e8 ed a3 ff ff       	call   80101e40 <readi>
80107a53:	83 c4 10             	add    $0x10,%esp
80107a56:	39 f8                	cmp    %edi,%eax
80107a58:	74 ae                	je     80107a08 <loaduvm+0x38>
}
80107a5a:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107a5d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107a62:	5b                   	pop    %ebx
80107a63:	5e                   	pop    %esi
80107a64:	5f                   	pop    %edi
80107a65:	5d                   	pop    %ebp
80107a66:	c3                   	ret    
80107a67:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107a6e:	66 90                	xchg   %ax,%ax
80107a70:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107a73:	31 c0                	xor    %eax,%eax
}
80107a75:	5b                   	pop    %ebx
80107a76:	5e                   	pop    %esi
80107a77:	5f                   	pop    %edi
80107a78:	5d                   	pop    %ebp
80107a79:	c3                   	ret    
      panic("loaduvm: address should exist");
80107a7a:	83 ec 0c             	sub    $0xc,%esp
80107a7d:	68 df 89 10 80       	push   $0x801089df
80107a82:	e8 09 89 ff ff       	call   80100390 <panic>
    panic("loaduvm: addr must be page aligned");
80107a87:	83 ec 0c             	sub    $0xc,%esp
80107a8a:	68 80 8a 10 80       	push   $0x80108a80
80107a8f:	e8 fc 88 ff ff       	call   80100390 <panic>
80107a94:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107a9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107a9f:	90                   	nop

80107aa0 <allocuvm>:
{
80107aa0:	f3 0f 1e fb          	endbr32 
80107aa4:	55                   	push   %ebp
80107aa5:	89 e5                	mov    %esp,%ebp
80107aa7:	57                   	push   %edi
80107aa8:	56                   	push   %esi
80107aa9:	53                   	push   %ebx
80107aaa:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80107aad:	8b 7d 10             	mov    0x10(%ebp),%edi
80107ab0:	85 ff                	test   %edi,%edi
80107ab2:	0f 88 c0 00 00 00    	js     80107b78 <allocuvm+0xd8>
  if(newsz < oldsz)
80107ab8:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80107abb:	0f 82 a7 00 00 00    	jb     80107b68 <allocuvm+0xc8>
  a = PGROUNDUP(oldsz);
80107ac1:	8b 45 0c             	mov    0xc(%ebp),%eax
80107ac4:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
80107aca:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  for(; a < newsz; a += PGSIZE){
80107ad0:	39 75 10             	cmp    %esi,0x10(%ebp)
80107ad3:	0f 86 92 00 00 00    	jbe    80107b6b <allocuvm+0xcb>
80107ad9:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80107adc:	8b 7d 08             	mov    0x8(%ebp),%edi
80107adf:	eb 47                	jmp    80107b28 <allocuvm+0x88>
80107ae1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    memset(mem, 0, PGSIZE);
80107ae8:	83 ec 04             	sub    $0x4,%esp
80107aeb:	68 00 10 00 00       	push   $0x1000
80107af0:	6a 00                	push   $0x0
80107af2:	50                   	push   %eax
80107af3:	e8 98 d6 ff ff       	call   80105190 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80107af8:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107afe:	c7 04 24 06 00 00 00 	movl   $0x6,(%esp)
80107b05:	50                   	push   %eax
80107b06:	68 00 10 00 00       	push   $0x1000
80107b0b:	56                   	push   %esi
80107b0c:	57                   	push   %edi
80107b0d:	e8 7e fc ff ff       	call   80107790 <mappages>
80107b12:	83 c4 20             	add    $0x20,%esp
80107b15:	85 c0                	test   %eax,%eax
80107b17:	78 6f                	js     80107b88 <allocuvm+0xe8>
  for(; a < newsz; a += PGSIZE){
80107b19:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107b1f:	39 75 10             	cmp    %esi,0x10(%ebp)
80107b22:	0f 86 a0 00 00 00    	jbe    80107bc8 <allocuvm+0x128>
    mem = kalloc();
80107b28:	e8 e3 ae ff ff       	call   80102a10 <kalloc>
80107b2d:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
80107b2f:	85 c0                	test   %eax,%eax
80107b31:	75 b5                	jne    80107ae8 <allocuvm+0x48>
      cprintf("allocuvm out of memory\n");
80107b33:	83 ec 0c             	sub    $0xc,%esp
80107b36:	68 fd 89 10 80       	push   $0x801089fd
80107b3b:	e8 70 8b ff ff       	call   801006b0 <cprintf>
  if(newsz >= oldsz)
80107b40:	8b 45 0c             	mov    0xc(%ebp),%eax
80107b43:	83 c4 10             	add    $0x10,%esp
80107b46:	39 45 10             	cmp    %eax,0x10(%ebp)
80107b49:	74 2d                	je     80107b78 <allocuvm+0xd8>
80107b4b:	8b 55 10             	mov    0x10(%ebp),%edx
80107b4e:	89 c1                	mov    %eax,%ecx
80107b50:	8b 45 08             	mov    0x8(%ebp),%eax
      return 0;
80107b53:	31 ff                	xor    %edi,%edi
80107b55:	e8 f6 fa ff ff       	call   80107650 <deallocuvm.part.0>
}
80107b5a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107b5d:	89 f8                	mov    %edi,%eax
80107b5f:	5b                   	pop    %ebx
80107b60:	5e                   	pop    %esi
80107b61:	5f                   	pop    %edi
80107b62:	5d                   	pop    %ebp
80107b63:	c3                   	ret    
80107b64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
80107b68:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
80107b6b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107b6e:	89 f8                	mov    %edi,%eax
80107b70:	5b                   	pop    %ebx
80107b71:	5e                   	pop    %esi
80107b72:	5f                   	pop    %edi
80107b73:	5d                   	pop    %ebp
80107b74:	c3                   	ret    
80107b75:	8d 76 00             	lea    0x0(%esi),%esi
80107b78:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80107b7b:	31 ff                	xor    %edi,%edi
}
80107b7d:	5b                   	pop    %ebx
80107b7e:	89 f8                	mov    %edi,%eax
80107b80:	5e                   	pop    %esi
80107b81:	5f                   	pop    %edi
80107b82:	5d                   	pop    %ebp
80107b83:	c3                   	ret    
80107b84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      cprintf("allocuvm out of memory (2)\n");
80107b88:	83 ec 0c             	sub    $0xc,%esp
80107b8b:	68 15 8a 10 80       	push   $0x80108a15
80107b90:	e8 1b 8b ff ff       	call   801006b0 <cprintf>
  if(newsz >= oldsz)
80107b95:	8b 45 0c             	mov    0xc(%ebp),%eax
80107b98:	83 c4 10             	add    $0x10,%esp
80107b9b:	39 45 10             	cmp    %eax,0x10(%ebp)
80107b9e:	74 0d                	je     80107bad <allocuvm+0x10d>
80107ba0:	89 c1                	mov    %eax,%ecx
80107ba2:	8b 55 10             	mov    0x10(%ebp),%edx
80107ba5:	8b 45 08             	mov    0x8(%ebp),%eax
80107ba8:	e8 a3 fa ff ff       	call   80107650 <deallocuvm.part.0>
      kfree(mem);
80107bad:	83 ec 0c             	sub    $0xc,%esp
      return 0;
80107bb0:	31 ff                	xor    %edi,%edi
      kfree(mem);
80107bb2:	53                   	push   %ebx
80107bb3:	e8 98 ac ff ff       	call   80102850 <kfree>
      return 0;
80107bb8:	83 c4 10             	add    $0x10,%esp
}
80107bbb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107bbe:	89 f8                	mov    %edi,%eax
80107bc0:	5b                   	pop    %ebx
80107bc1:	5e                   	pop    %esi
80107bc2:	5f                   	pop    %edi
80107bc3:	5d                   	pop    %ebp
80107bc4:	c3                   	ret    
80107bc5:	8d 76 00             	lea    0x0(%esi),%esi
80107bc8:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80107bcb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107bce:	5b                   	pop    %ebx
80107bcf:	5e                   	pop    %esi
80107bd0:	89 f8                	mov    %edi,%eax
80107bd2:	5f                   	pop    %edi
80107bd3:	5d                   	pop    %ebp
80107bd4:	c3                   	ret    
80107bd5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107bdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107be0 <deallocuvm>:
{
80107be0:	f3 0f 1e fb          	endbr32 
80107be4:	55                   	push   %ebp
80107be5:	89 e5                	mov    %esp,%ebp
80107be7:	8b 55 0c             	mov    0xc(%ebp),%edx
80107bea:	8b 4d 10             	mov    0x10(%ebp),%ecx
80107bed:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
80107bf0:	39 d1                	cmp    %edx,%ecx
80107bf2:	73 0c                	jae    80107c00 <deallocuvm+0x20>
}
80107bf4:	5d                   	pop    %ebp
80107bf5:	e9 56 fa ff ff       	jmp    80107650 <deallocuvm.part.0>
80107bfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107c00:	89 d0                	mov    %edx,%eax
80107c02:	5d                   	pop    %ebp
80107c03:	c3                   	ret    
80107c04:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107c0b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107c0f:	90                   	nop

80107c10 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107c10:	f3 0f 1e fb          	endbr32 
80107c14:	55                   	push   %ebp
80107c15:	89 e5                	mov    %esp,%ebp
80107c17:	57                   	push   %edi
80107c18:	56                   	push   %esi
80107c19:	53                   	push   %ebx
80107c1a:	83 ec 0c             	sub    $0xc,%esp
80107c1d:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80107c20:	85 f6                	test   %esi,%esi
80107c22:	74 55                	je     80107c79 <freevm+0x69>
  if(newsz >= oldsz)
80107c24:	31 c9                	xor    %ecx,%ecx
80107c26:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107c2b:	89 f0                	mov    %esi,%eax
80107c2d:	89 f3                	mov    %esi,%ebx
80107c2f:	e8 1c fa ff ff       	call   80107650 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107c34:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107c3a:	eb 0b                	jmp    80107c47 <freevm+0x37>
80107c3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107c40:	83 c3 04             	add    $0x4,%ebx
80107c43:	39 df                	cmp    %ebx,%edi
80107c45:	74 23                	je     80107c6a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80107c47:	8b 03                	mov    (%ebx),%eax
80107c49:	a8 01                	test   $0x1,%al
80107c4b:	74 f3                	je     80107c40 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107c4d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80107c52:	83 ec 0c             	sub    $0xc,%esp
80107c55:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107c58:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80107c5d:	50                   	push   %eax
80107c5e:	e8 ed ab ff ff       	call   80102850 <kfree>
80107c63:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107c66:	39 df                	cmp    %ebx,%edi
80107c68:	75 dd                	jne    80107c47 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
80107c6a:	89 75 08             	mov    %esi,0x8(%ebp)
}
80107c6d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107c70:	5b                   	pop    %ebx
80107c71:	5e                   	pop    %esi
80107c72:	5f                   	pop    %edi
80107c73:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107c74:	e9 d7 ab ff ff       	jmp    80102850 <kfree>
    panic("freevm: no pgdir");
80107c79:	83 ec 0c             	sub    $0xc,%esp
80107c7c:	68 31 8a 10 80       	push   $0x80108a31
80107c81:	e8 0a 87 ff ff       	call   80100390 <panic>
80107c86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107c8d:	8d 76 00             	lea    0x0(%esi),%esi

80107c90 <setupkvm>:
{
80107c90:	f3 0f 1e fb          	endbr32 
80107c94:	55                   	push   %ebp
80107c95:	89 e5                	mov    %esp,%ebp
80107c97:	56                   	push   %esi
80107c98:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80107c99:	e8 72 ad ff ff       	call   80102a10 <kalloc>
80107c9e:	89 c6                	mov    %eax,%esi
80107ca0:	85 c0                	test   %eax,%eax
80107ca2:	74 42                	je     80107ce6 <setupkvm+0x56>
  memset(pgdir, 0, PGSIZE);
80107ca4:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107ca7:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  memset(pgdir, 0, PGSIZE);
80107cac:	68 00 10 00 00       	push   $0x1000
80107cb1:	6a 00                	push   $0x0
80107cb3:	50                   	push   %eax
80107cb4:	e8 d7 d4 ff ff       	call   80105190 <memset>
80107cb9:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80107cbc:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80107cbf:	8b 53 08             	mov    0x8(%ebx),%edx
80107cc2:	83 ec 0c             	sub    $0xc,%esp
80107cc5:	ff 73 0c             	pushl  0xc(%ebx)
80107cc8:	29 c2                	sub    %eax,%edx
80107cca:	50                   	push   %eax
80107ccb:	52                   	push   %edx
80107ccc:	ff 33                	pushl  (%ebx)
80107cce:	56                   	push   %esi
80107ccf:	e8 bc fa ff ff       	call   80107790 <mappages>
80107cd4:	83 c4 20             	add    $0x20,%esp
80107cd7:	85 c0                	test   %eax,%eax
80107cd9:	78 15                	js     80107cf0 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107cdb:	83 c3 10             	add    $0x10,%ebx
80107cde:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
80107ce4:	75 d6                	jne    80107cbc <setupkvm+0x2c>
}
80107ce6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107ce9:	89 f0                	mov    %esi,%eax
80107ceb:	5b                   	pop    %ebx
80107cec:	5e                   	pop    %esi
80107ced:	5d                   	pop    %ebp
80107cee:	c3                   	ret    
80107cef:	90                   	nop
      freevm(pgdir);
80107cf0:	83 ec 0c             	sub    $0xc,%esp
80107cf3:	56                   	push   %esi
      return 0;
80107cf4:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80107cf6:	e8 15 ff ff ff       	call   80107c10 <freevm>
      return 0;
80107cfb:	83 c4 10             	add    $0x10,%esp
}
80107cfe:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107d01:	89 f0                	mov    %esi,%eax
80107d03:	5b                   	pop    %ebx
80107d04:	5e                   	pop    %esi
80107d05:	5d                   	pop    %ebp
80107d06:	c3                   	ret    
80107d07:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107d0e:	66 90                	xchg   %ax,%ax

80107d10 <kvmalloc>:
{
80107d10:	f3 0f 1e fb          	endbr32 
80107d14:	55                   	push   %ebp
80107d15:	89 e5                	mov    %esp,%ebp
80107d17:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107d1a:	e8 71 ff ff ff       	call   80107c90 <setupkvm>
80107d1f:	a3 04 9b 11 80       	mov    %eax,0x80119b04
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107d24:	05 00 00 00 80       	add    $0x80000000,%eax
80107d29:	0f 22 d8             	mov    %eax,%cr3
}
80107d2c:	c9                   	leave  
80107d2d:	c3                   	ret    
80107d2e:	66 90                	xchg   %ax,%ax

80107d30 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107d30:	f3 0f 1e fb          	endbr32 
80107d34:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107d35:	31 c9                	xor    %ecx,%ecx
{
80107d37:	89 e5                	mov    %esp,%ebp
80107d39:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107d3c:	8b 55 0c             	mov    0xc(%ebp),%edx
80107d3f:	8b 45 08             	mov    0x8(%ebp),%eax
80107d42:	e8 89 f8 ff ff       	call   801075d0 <walkpgdir>
  if(pte == 0)
80107d47:	85 c0                	test   %eax,%eax
80107d49:	74 05                	je     80107d50 <clearpteu+0x20>
    panic("clearpteu");
  *pte &= ~PTE_U;
80107d4b:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80107d4e:	c9                   	leave  
80107d4f:	c3                   	ret    
    panic("clearpteu");
80107d50:	83 ec 0c             	sub    $0xc,%esp
80107d53:	68 42 8a 10 80       	push   $0x80108a42
80107d58:	e8 33 86 ff ff       	call   80100390 <panic>
80107d5d:	8d 76 00             	lea    0x0(%esi),%esi

80107d60 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107d60:	f3 0f 1e fb          	endbr32 
80107d64:	55                   	push   %ebp
80107d65:	89 e5                	mov    %esp,%ebp
80107d67:	57                   	push   %edi
80107d68:	56                   	push   %esi
80107d69:	53                   	push   %ebx
80107d6a:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107d6d:	e8 1e ff ff ff       	call   80107c90 <setupkvm>
80107d72:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107d75:	85 c0                	test   %eax,%eax
80107d77:	0f 84 9e 00 00 00    	je     80107e1b <copyuvm+0xbb>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107d7d:	8b 55 0c             	mov    0xc(%ebp),%edx
80107d80:	85 d2                	test   %edx,%edx
80107d82:	0f 84 93 00 00 00    	je     80107e1b <copyuvm+0xbb>
80107d88:	31 f6                	xor    %esi,%esi
80107d8a:	eb 44                	jmp    80107dd0 <copyuvm+0x70>
80107d8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107d90:	83 ec 04             	sub    $0x4,%esp
80107d93:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
80107d99:	68 00 10 00 00       	push   $0x1000
80107d9e:	53                   	push   %ebx
80107d9f:	50                   	push   %eax
80107da0:	e8 8b d4 ff ff       	call   80105230 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80107da5:	58                   	pop    %eax
80107da6:	8d 87 00 00 00 80    	lea    -0x80000000(%edi),%eax
80107dac:	ff 75 e4             	pushl  -0x1c(%ebp)
80107daf:	50                   	push   %eax
80107db0:	68 00 10 00 00       	push   $0x1000
80107db5:	56                   	push   %esi
80107db6:	ff 75 e0             	pushl  -0x20(%ebp)
80107db9:	e8 d2 f9 ff ff       	call   80107790 <mappages>
80107dbe:	83 c4 20             	add    $0x20,%esp
80107dc1:	85 c0                	test   %eax,%eax
80107dc3:	78 6b                	js     80107e30 <copyuvm+0xd0>
  for(i = 0; i < sz; i += PGSIZE){
80107dc5:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107dcb:	39 75 0c             	cmp    %esi,0xc(%ebp)
80107dce:	76 4b                	jbe    80107e1b <copyuvm+0xbb>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107dd0:	8b 45 08             	mov    0x8(%ebp),%eax
80107dd3:	31 c9                	xor    %ecx,%ecx
80107dd5:	89 f2                	mov    %esi,%edx
80107dd7:	e8 f4 f7 ff ff       	call   801075d0 <walkpgdir>
80107ddc:	85 c0                	test   %eax,%eax
80107dde:	74 6b                	je     80107e4b <copyuvm+0xeb>
    if(!(*pte & PTE_P))
80107de0:	8b 38                	mov    (%eax),%edi
80107de2:	f7 c7 01 00 00 00    	test   $0x1,%edi
80107de8:	74 54                	je     80107e3e <copyuvm+0xde>
    pa = PTE_ADDR(*pte);
80107dea:	89 fb                	mov    %edi,%ebx
    flags = PTE_FLAGS(*pte);
80107dec:	81 e7 ff 0f 00 00    	and    $0xfff,%edi
80107df2:	89 7d e4             	mov    %edi,-0x1c(%ebp)
    pa = PTE_ADDR(*pte);
80107df5:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    if((mem = kalloc()) == 0)
80107dfb:	e8 10 ac ff ff       	call   80102a10 <kalloc>
80107e00:	89 c7                	mov    %eax,%edi
80107e02:	85 c0                	test   %eax,%eax
80107e04:	75 8a                	jne    80107d90 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
80107e06:	83 ec 0c             	sub    $0xc,%esp
80107e09:	ff 75 e0             	pushl  -0x20(%ebp)
80107e0c:	e8 ff fd ff ff       	call   80107c10 <freevm>
  return 0;
80107e11:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
80107e18:	83 c4 10             	add    $0x10,%esp
}
80107e1b:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107e1e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107e21:	5b                   	pop    %ebx
80107e22:	5e                   	pop    %esi
80107e23:	5f                   	pop    %edi
80107e24:	5d                   	pop    %ebp
80107e25:	c3                   	ret    
80107e26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107e2d:	8d 76 00             	lea    0x0(%esi),%esi
      kfree(mem);
80107e30:	83 ec 0c             	sub    $0xc,%esp
80107e33:	57                   	push   %edi
80107e34:	e8 17 aa ff ff       	call   80102850 <kfree>
      goto bad;
80107e39:	83 c4 10             	add    $0x10,%esp
80107e3c:	eb c8                	jmp    80107e06 <copyuvm+0xa6>
      panic("copyuvm: page not present");
80107e3e:	83 ec 0c             	sub    $0xc,%esp
80107e41:	68 66 8a 10 80       	push   $0x80108a66
80107e46:	e8 45 85 ff ff       	call   80100390 <panic>
      panic("copyuvm: pte should exist");
80107e4b:	83 ec 0c             	sub    $0xc,%esp
80107e4e:	68 4c 8a 10 80       	push   $0x80108a4c
80107e53:	e8 38 85 ff ff       	call   80100390 <panic>
80107e58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107e5f:	90                   	nop

80107e60 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107e60:	f3 0f 1e fb          	endbr32 
80107e64:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107e65:	31 c9                	xor    %ecx,%ecx
{
80107e67:	89 e5                	mov    %esp,%ebp
80107e69:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107e6c:	8b 55 0c             	mov    0xc(%ebp),%edx
80107e6f:	8b 45 08             	mov    0x8(%ebp),%eax
80107e72:	e8 59 f7 ff ff       	call   801075d0 <walkpgdir>
  if((*pte & PTE_P) == 0)
80107e77:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107e79:	c9                   	leave  
  if((*pte & PTE_U) == 0)
80107e7a:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107e7c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
80107e81:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107e84:	05 00 00 00 80       	add    $0x80000000,%eax
80107e89:	83 fa 05             	cmp    $0x5,%edx
80107e8c:	ba 00 00 00 00       	mov    $0x0,%edx
80107e91:	0f 45 c2             	cmovne %edx,%eax
}
80107e94:	c3                   	ret    
80107e95:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107e9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107ea0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107ea0:	f3 0f 1e fb          	endbr32 
80107ea4:	55                   	push   %ebp
80107ea5:	89 e5                	mov    %esp,%ebp
80107ea7:	57                   	push   %edi
80107ea8:	56                   	push   %esi
80107ea9:	53                   	push   %ebx
80107eaa:	83 ec 0c             	sub    $0xc,%esp
80107ead:	8b 75 14             	mov    0x14(%ebp),%esi
80107eb0:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107eb3:	85 f6                	test   %esi,%esi
80107eb5:	75 3c                	jne    80107ef3 <copyout+0x53>
80107eb7:	eb 67                	jmp    80107f20 <copyout+0x80>
80107eb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80107ec0:	8b 55 0c             	mov    0xc(%ebp),%edx
80107ec3:	89 fb                	mov    %edi,%ebx
80107ec5:	29 d3                	sub    %edx,%ebx
80107ec7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if(n > len)
80107ecd:	39 f3                	cmp    %esi,%ebx
80107ecf:	0f 47 de             	cmova  %esi,%ebx
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107ed2:	29 fa                	sub    %edi,%edx
80107ed4:	83 ec 04             	sub    $0x4,%esp
80107ed7:	01 c2                	add    %eax,%edx
80107ed9:	53                   	push   %ebx
80107eda:	ff 75 10             	pushl  0x10(%ebp)
80107edd:	52                   	push   %edx
80107ede:	e8 4d d3 ff ff       	call   80105230 <memmove>
    len -= n;
    buf += n;
80107ee3:	01 5d 10             	add    %ebx,0x10(%ebp)
    va = va0 + PGSIZE;
80107ee6:	8d 97 00 10 00 00    	lea    0x1000(%edi),%edx
  while(len > 0){
80107eec:	83 c4 10             	add    $0x10,%esp
80107eef:	29 de                	sub    %ebx,%esi
80107ef1:	74 2d                	je     80107f20 <copyout+0x80>
    va0 = (uint)PGROUNDDOWN(va);
80107ef3:	89 d7                	mov    %edx,%edi
    pa0 = uva2ka(pgdir, (char*)va0);
80107ef5:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
80107ef8:	89 55 0c             	mov    %edx,0xc(%ebp)
80107efb:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    pa0 = uva2ka(pgdir, (char*)va0);
80107f01:	57                   	push   %edi
80107f02:	ff 75 08             	pushl  0x8(%ebp)
80107f05:	e8 56 ff ff ff       	call   80107e60 <uva2ka>
    if(pa0 == 0)
80107f0a:	83 c4 10             	add    $0x10,%esp
80107f0d:	85 c0                	test   %eax,%eax
80107f0f:	75 af                	jne    80107ec0 <copyout+0x20>
  }
  return 0;
}
80107f11:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107f14:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107f19:	5b                   	pop    %ebx
80107f1a:	5e                   	pop    %esi
80107f1b:	5f                   	pop    %edi
80107f1c:	5d                   	pop    %ebp
80107f1d:	c3                   	ret    
80107f1e:	66 90                	xchg   %ax,%ax
80107f20:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107f23:	31 c0                	xor    %eax,%eax
}
80107f25:	5b                   	pop    %ebx
80107f26:	5e                   	pop    %esi
80107f27:	5f                   	pop    %edi
80107f28:	5d                   	pop    %ebp
80107f29:	c3                   	ret    
