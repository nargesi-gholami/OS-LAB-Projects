
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
80100050:	68 e0 7a 10 80       	push   $0x80107ae0
80100055:	68 00 c6 10 80       	push   $0x8010c600
8010005a:	e8 91 4c 00 00       	call   80104cf0 <initlock>
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
80100092:	68 e7 7a 10 80       	push   $0x80107ae7
80100097:	50                   	push   %eax
80100098:	e8 13 4b 00 00       	call   80104bb0 <initsleeplock>
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
801000e8:	e8 83 4d 00 00       	call   80104e70 <acquire>
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
80100162:	e8 c9 4d 00 00       	call   80104f30 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 7e 4a 00 00       	call   80104bf0 <acquiresleep>
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
801001a3:	68 ee 7a 10 80       	push   $0x80107aee
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
801001c2:	e8 c9 4a 00 00       	call   80104c90 <holdingsleep>
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
801001e0:	68 ff 7a 10 80       	push   $0x80107aff
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
80100203:	e8 88 4a 00 00       	call   80104c90 <holdingsleep>
80100208:	83 c4 10             	add    $0x10,%esp
8010020b:	85 c0                	test   %eax,%eax
8010020d:	74 66                	je     80100275 <brelse+0x85>
    panic("brelse");

  releasesleep(&b->lock);
8010020f:	83 ec 0c             	sub    $0xc,%esp
80100212:	56                   	push   %esi
80100213:	e8 38 4a 00 00       	call   80104c50 <releasesleep>

  acquire(&bcache.lock);
80100218:	c7 04 24 00 c6 10 80 	movl   $0x8010c600,(%esp)
8010021f:	e8 4c 4c 00 00       	call   80104e70 <acquire>
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
80100270:	e9 bb 4c 00 00       	jmp    80104f30 <release>
    panic("brelse");
80100275:	83 ec 0c             	sub    $0xc,%esp
80100278:	68 06 7b 10 80       	push   $0x80107b06
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
801002b1:	e8 ba 4b 00 00       	call   80104e70 <acquire>
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
801002e5:	e8 26 45 00 00       	call   80104810 <sleep>
    while(input.r == input.w){
801002ea:	a1 e0 0f 11 80       	mov    0x80110fe0,%eax
801002ef:	83 c4 10             	add    $0x10,%esp
801002f2:	3b 05 e4 0f 11 80    	cmp    0x80110fe4,%eax
801002f8:	75 36                	jne    80100330 <consoleread+0xa0>
      if(myproc()->killed){
801002fa:	e8 91 3a 00 00       	call   80103d90 <myproc>
801002ff:	8b 48 24             	mov    0x24(%eax),%ecx
80100302:	85 c9                	test   %ecx,%ecx
80100304:	74 d2                	je     801002d8 <consoleread+0x48>
        release(&cons.lock);
80100306:	83 ec 0c             	sub    $0xc,%esp
80100309:	68 40 b5 10 80       	push   $0x8010b540
8010030e:	e8 1d 4c 00 00       	call   80104f30 <release>
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
80100365:	e8 c6 4b 00 00       	call   80104f30 <release>
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
801003b6:	68 0d 7b 10 80       	push   $0x80107b0d
801003bb:	e8 f0 02 00 00       	call   801006b0 <cprintf>
  cprintf(s);
801003c0:	58                   	pop    %eax
801003c1:	ff 75 08             	pushl  0x8(%ebp)
801003c4:	e8 e7 02 00 00       	call   801006b0 <cprintf>
  cprintf("\n");
801003c9:	c7 04 24 47 85 10 80 	movl   $0x80108547,(%esp)
801003d0:	e8 db 02 00 00       	call   801006b0 <cprintf>
  getcallerpcs(&s, pcs);
801003d5:	8d 45 08             	lea    0x8(%ebp),%eax
801003d8:	5a                   	pop    %edx
801003d9:	59                   	pop    %ecx
801003da:	53                   	push   %ebx
801003db:	50                   	push   %eax
801003dc:	e8 2f 49 00 00       	call   80104d10 <getcallerpcs>
  for(i=0; i<10; i++)
801003e1:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003e4:	83 ec 08             	sub    $0x8,%esp
801003e7:	ff 33                	pushl  (%ebx)
801003e9:	83 c3 04             	add    $0x4,%ebx
801003ec:	68 21 7b 10 80       	push   $0x80107b21
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
8010042a:	e8 a1 62 00 00       	call   801066d0 <uartputc>
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
80100515:	e8 b6 61 00 00       	call   801066d0 <uartputc>
8010051a:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100521:	e8 aa 61 00 00       	call   801066d0 <uartputc>
80100526:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010052d:	e8 9e 61 00 00       	call   801066d0 <uartputc>
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
80100561:	e8 ba 4a 00 00       	call   80105020 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100566:	b8 80 07 00 00       	mov    $0x780,%eax
8010056b:	83 c4 0c             	add    $0xc,%esp
8010056e:	29 d8                	sub    %ebx,%eax
80100570:	01 c0                	add    %eax,%eax
80100572:	50                   	push   %eax
80100573:	6a 00                	push   $0x0
80100575:	56                   	push   %esi
80100576:	e8 05 4a 00 00       	call   80104f80 <memset>
8010057b:	88 5d e7             	mov    %bl,-0x19(%ebp)
8010057e:	83 c4 10             	add    $0x10,%esp
80100581:	e9 22 ff ff ff       	jmp    801004a8 <consputc.part.0+0x98>
    panic("pos under/overflow");
80100586:	83 ec 0c             	sub    $0xc,%esp
80100589:	68 25 7b 10 80       	push   $0x80107b25
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
801005c9:	0f b6 92 a8 7b 10 80 	movzbl -0x7fef8458(%edx),%edx
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
8010065f:	e8 0c 48 00 00       	call   80104e70 <acquire>
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
80100697:	e8 94 48 00 00       	call   80104f30 <release>
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
8010077d:	bb 38 7b 10 80       	mov    $0x80107b38,%ebx
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
801007bd:	e8 ae 46 00 00       	call   80104e70 <acquire>
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
80100828:	e8 03 47 00 00       	call   80104f30 <release>
8010082d:	83 c4 10             	add    $0x10,%esp
}
80100830:	e9 ee fe ff ff       	jmp    80100723 <cprintf+0x73>
    panic("null fmt");
80100835:	83 ec 0c             	sub    $0xc,%esp
80100838:	68 3f 7b 10 80       	push   $0x80107b3f
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
801008da:	e8 91 45 00 00       	call   80104e70 <acquire>
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
80100903:	3e ff 24 b5 50 7b 10 	notrack jmp *-0x7fef84b0(,%esi,4)
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
80100c68:	e8 c3 42 00 00       	call   80104f30 <release>
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
80100dc1:	e8 0a 3c 00 00       	call   801049d0 <wakeup>
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
80100ddf:	e9 ec 3c 00 00       	jmp    80104ad0 <procdump>
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
80100e0a:	68 48 7b 10 80       	push   $0x80107b48
80100e0f:	68 40 b5 10 80       	push   $0x8010b540
80100e14:	e8 d7 3e 00 00       	call   80104cf0 <initlock>

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
80100e60:	e8 2b 2f 00 00       	call   80103d90 <myproc>
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
80100edc:	e8 5f 69 00 00       	call   80107840 <setupkvm>
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
80100f43:	e8 18 67 00 00       	call   80107660 <allocuvm>
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
80100f79:	e8 12 66 00 00       	call   80107590 <loaduvm>
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
80100fbb:	e8 00 68 00 00       	call   801077c0 <freevm>
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
80101002:	e8 59 66 00 00       	call   80107660 <allocuvm>
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
80101023:	e8 b8 68 00 00       	call   801078e0 <clearpteu>
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
80101073:	e8 08 41 00 00       	call   80105180 <strlen>
80101078:	f7 d0                	not    %eax
8010107a:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
8010107c:	58                   	pop    %eax
8010107d:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80101080:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80101083:	ff 34 b8             	pushl  (%eax,%edi,4)
80101086:	e8 f5 40 00 00       	call   80105180 <strlen>
8010108b:	83 c0 01             	add    $0x1,%eax
8010108e:	50                   	push   %eax
8010108f:	8b 45 0c             	mov    0xc(%ebp),%eax
80101092:	ff 34 b8             	pushl  (%eax,%edi,4)
80101095:	53                   	push   %ebx
80101096:	56                   	push   %esi
80101097:	e8 a4 69 00 00       	call   80107a40 <copyout>
8010109c:	83 c4 20             	add    $0x20,%esp
8010109f:	85 c0                	test   %eax,%eax
801010a1:	79 ad                	jns    80101050 <exec+0x200>
801010a3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801010a7:	90                   	nop
    freevm(pgdir);
801010a8:	83 ec 0c             	sub    $0xc,%esp
801010ab:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
801010b1:	e8 0a 67 00 00       	call   801077c0 <freevm>
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
80101103:	e8 38 69 00 00       	call   80107a40 <copyout>
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
80101141:	e8 fa 3f 00 00       	call   80105140 <safestrcpy>
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
80101174:	e8 87 62 00 00       	call   80107400 <switchuvm>
  freevm(oldpgdir);
80101179:	89 3c 24             	mov    %edi,(%esp)
8010117c:	e8 3f 66 00 00       	call   801077c0 <freevm>
  return 0;
80101181:	83 c4 10             	add    $0x10,%esp
80101184:	31 c0                	xor    %eax,%eax
80101186:	e9 35 fd ff ff       	jmp    80100ec0 <exec+0x70>
    end_op();
8010118b:	e8 f0 1f 00 00       	call   80103180 <end_op>
    cprintf("exec: fail\n");
80101190:	83 ec 0c             	sub    $0xc,%esp
80101193:	68 b9 7b 10 80       	push   $0x80107bb9
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
801011ca:	68 c5 7b 10 80       	push   $0x80107bc5
801011cf:	68 00 10 11 80       	push   $0x80111000
801011d4:	e8 17 3b 00 00       	call   80104cf0 <initlock>
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
801011f5:	e8 76 3c 00 00       	call   80104e70 <acquire>
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
80101221:	e8 0a 3d 00 00       	call   80104f30 <release>
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
8010123a:	e8 f1 3c 00 00       	call   80104f30 <release>
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
80101263:	e8 08 3c 00 00       	call   80104e70 <acquire>
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
80101280:	e8 ab 3c 00 00       	call   80104f30 <release>
  return f;
}
80101285:	89 d8                	mov    %ebx,%eax
80101287:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010128a:	c9                   	leave  
8010128b:	c3                   	ret    
    panic("filedup");
8010128c:	83 ec 0c             	sub    $0xc,%esp
8010128f:	68 cc 7b 10 80       	push   $0x80107bcc
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
801012b5:	e8 b6 3b 00 00       	call   80104e70 <acquire>
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
801012f0:	e8 3b 3c 00 00       	call   80104f30 <release>

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
8010131e:	e9 0d 3c 00 00       	jmp    80104f30 <release>
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
8010136c:	68 d4 7b 10 80       	push   $0x80107bd4
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
8010145a:	68 de 7b 10 80       	push   $0x80107bde
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
80101543:	68 e7 7b 10 80       	push   $0x80107be7
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
80101579:	68 ed 7b 10 80       	push   $0x80107bed
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
801015f7:	68 f7 7b 10 80       	push   $0x80107bf7
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
801016b4:	68 0a 7c 10 80       	push   $0x80107c0a
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
801016f5:	e8 86 38 00 00       	call   80104f80 <memset>
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
8010173a:	e8 31 37 00 00       	call   80104e70 <acquire>
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
801017a7:	e8 84 37 00 00       	call   80104f30 <release>

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
801017d5:	e8 56 37 00 00       	call   80104f30 <release>
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
80101802:	68 20 7c 10 80       	push   $0x80107c20
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
801018cb:	68 30 7c 10 80       	push   $0x80107c30
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
80101905:	e8 16 37 00 00       	call   80105020 <memmove>
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
80101930:	68 43 7c 10 80       	push   $0x80107c43
80101935:	68 20 1a 11 80       	push   $0x80111a20
8010193a:	e8 b1 33 00 00       	call   80104cf0 <initlock>
  for(i = 0; i < NINODE; i++) {
8010193f:	83 c4 10             	add    $0x10,%esp
80101942:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    initsleeplock(&icache.inode[i].lock, "inode");
80101948:	83 ec 08             	sub    $0x8,%esp
8010194b:	68 4a 7c 10 80       	push   $0x80107c4a
80101950:	53                   	push   %ebx
80101951:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101957:	e8 54 32 00 00       	call   80104bb0 <initsleeplock>
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
801019a1:	68 b0 7c 10 80       	push   $0x80107cb0
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
80101a3e:	e8 3d 35 00 00       	call   80104f80 <memset>
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
80101a73:	68 50 7c 10 80       	push   $0x80107c50
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
80101ae5:	e8 36 35 00 00       	call   80105020 <memmove>
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
80101b23:	e8 48 33 00 00       	call   80104e70 <acquire>
  ip->ref++;
80101b28:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101b2c:	c7 04 24 20 1a 11 80 	movl   $0x80111a20,(%esp)
80101b33:	e8 f8 33 00 00       	call   80104f30 <release>
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
80101b66:	e8 85 30 00 00       	call   80104bf0 <acquiresleep>
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
80101bd8:	e8 43 34 00 00       	call   80105020 <memmove>
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
80101bfd:	68 68 7c 10 80       	push   $0x80107c68
80101c02:	e8 89 e7 ff ff       	call   80100390 <panic>
    panic("ilock");
80101c07:	83 ec 0c             	sub    $0xc,%esp
80101c0a:	68 62 7c 10 80       	push   $0x80107c62
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
80101c37:	e8 54 30 00 00       	call   80104c90 <holdingsleep>
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
80101c53:	e9 f8 2f 00 00       	jmp    80104c50 <releasesleep>
    panic("iunlock");
80101c58:	83 ec 0c             	sub    $0xc,%esp
80101c5b:	68 77 7c 10 80       	push   $0x80107c77
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
80101c84:	e8 67 2f 00 00       	call   80104bf0 <acquiresleep>
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
80101c9e:	e8 ad 2f 00 00       	call   80104c50 <releasesleep>
  acquire(&icache.lock);
80101ca3:	c7 04 24 20 1a 11 80 	movl   $0x80111a20,(%esp)
80101caa:	e8 c1 31 00 00       	call   80104e70 <acquire>
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
80101cc4:	e9 67 32 00 00       	jmp    80104f30 <release>
80101cc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&icache.lock);
80101cd0:	83 ec 0c             	sub    $0xc,%esp
80101cd3:	68 20 1a 11 80       	push   $0x80111a20
80101cd8:	e8 93 31 00 00       	call   80104e70 <acquire>
    int r = ip->ref;
80101cdd:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101ce0:	c7 04 24 20 1a 11 80 	movl   $0x80111a20,(%esp)
80101ce7:	e8 44 32 00 00       	call   80104f30 <release>
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
80101ee7:	e8 34 31 00 00       	call   80105020 <memmove>
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
80101fe3:	e8 38 30 00 00       	call   80105020 <memmove>
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
80102082:	e8 09 30 00 00       	call   80105090 <strncmp>
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
801020e5:	e8 a6 2f 00 00       	call   80105090 <strncmp>
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
8010212a:	68 91 7c 10 80       	push   $0x80107c91
8010212f:	e8 5c e2 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
80102134:	83 ec 0c             	sub    $0xc,%esp
80102137:	68 7f 7c 10 80       	push   $0x80107c7f
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
8010216a:	e8 21 1c 00 00       	call   80103d90 <myproc>
  acquire(&icache.lock);
8010216f:	83 ec 0c             	sub    $0xc,%esp
80102172:	89 df                	mov    %ebx,%edi
    ip = idup(myproc()->cwd);
80102174:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80102177:	68 20 1a 11 80       	push   $0x80111a20
8010217c:	e8 ef 2c 00 00       	call   80104e70 <acquire>
  ip->ref++;
80102181:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80102185:	c7 04 24 20 1a 11 80 	movl   $0x80111a20,(%esp)
8010218c:	e8 9f 2d 00 00       	call   80104f30 <release>
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
801021f7:	e8 24 2e 00 00       	call   80105020 <memmove>
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
80102283:	e8 98 2d 00 00       	call   80105020 <memmove>
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
801023b5:	e8 26 2d 00 00       	call   801050e0 <strncpy>
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
801023f3:	68 a0 7c 10 80       	push   $0x80107ca0
801023f8:	e8 93 df ff ff       	call   80100390 <panic>
    panic("dirlink");
801023fd:	83 ec 0c             	sub    $0xc,%esp
80102400:	68 2e 83 10 80       	push   $0x8010832e
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
8010250b:	68 0c 7d 10 80       	push   $0x80107d0c
80102510:	e8 7b de ff ff       	call   80100390 <panic>
    panic("idestart");
80102515:	83 ec 0c             	sub    $0xc,%esp
80102518:	68 03 7d 10 80       	push   $0x80107d03
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
8010253a:	68 1e 7d 10 80       	push   $0x80107d1e
8010253f:	68 a0 b5 10 80       	push   $0x8010b5a0
80102544:	e8 a7 27 00 00       	call   80104cf0 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102549:	58                   	pop    %eax
8010254a:	a1 70 38 11 80       	mov    0x80113870,%eax
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
801025d2:	e8 99 28 00 00       	call   80104e70 <acquire>

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
8010262d:	e8 9e 23 00 00       	call   801049d0 <wakeup>

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
8010264b:	e8 e0 28 00 00       	call   80104f30 <release>

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
80102672:	e8 19 26 00 00       	call   80104c90 <holdingsleep>
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
801026ac:	e8 bf 27 00 00       	call   80104e70 <acquire>

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
801026f9:	e8 12 21 00 00       	call   80104810 <sleep>
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
80102716:	e9 15 28 00 00       	jmp    80104f30 <release>
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
8010273a:	68 4d 7d 10 80       	push   $0x80107d4d
8010273f:	e8 4c dc ff ff       	call   80100390 <panic>
    panic("iderw: nothing to do");
80102744:	83 ec 0c             	sub    $0xc,%esp
80102747:	68 38 7d 10 80       	push   $0x80107d38
8010274c:	e8 3f dc ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
80102751:	83 ec 0c             	sub    $0xc,%esp
80102754:	68 22 7d 10 80       	push   $0x80107d22
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
801027ae:	68 6c 7d 10 80       	push   $0x80107d6c
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
80102866:	81 fb 08 65 11 80    	cmp    $0x80116508,%ebx
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
80102886:	e8 f5 26 00 00       	call   80104f80 <memset>

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
801028c0:	e8 ab 25 00 00       	call   80104e70 <acquire>
801028c5:	83 c4 10             	add    $0x10,%esp
801028c8:	eb ce                	jmp    80102898 <kfree+0x48>
801028ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
801028d0:	c7 45 08 80 36 11 80 	movl   $0x80113680,0x8(%ebp)
}
801028d7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801028da:	c9                   	leave  
    release(&kmem.lock);
801028db:	e9 50 26 00 00       	jmp    80104f30 <release>
    panic("kfree");
801028e0:	83 ec 0c             	sub    $0xc,%esp
801028e3:	68 9e 7d 10 80       	push   $0x80107d9e
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
8010294f:	68 a4 7d 10 80       	push   $0x80107da4
80102954:	68 80 36 11 80       	push   $0x80113680
80102959:	e8 92 23 00 00       	call   80104cf0 <initlock>
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
80102a43:	e8 28 24 00 00       	call   80104e70 <acquire>
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
80102a71:	e8 ba 24 00 00       	call   80104f30 <release>
  return (char*)r;
80102a76:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
80102a79:	83 c4 10             	add    $0x10,%esp
}
80102a7c:	c9                   	leave  
80102a7d:	c3                   	ret    
80102a7e:	66 90                	xchg   %ax,%ax

80102a80 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
80102a80:	f3 0f 1e fb          	endbr32 
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a84:	ba 64 00 00 00       	mov    $0x64,%edx
80102a89:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102a8a:	a8 01                	test   $0x1,%al
80102a8c:	0f 84 be 00 00 00    	je     80102b50 <kbdgetc+0xd0>
{
80102a92:	55                   	push   %ebp
80102a93:	ba 60 00 00 00       	mov    $0x60,%edx
80102a98:	89 e5                	mov    %esp,%ebp
80102a9a:	53                   	push   %ebx
80102a9b:	ec                   	in     (%dx),%al
  return data;
80102a9c:	8b 1d d4 b5 10 80    	mov    0x8010b5d4,%ebx
    return -1;
  data = inb(KBDATAP);
80102aa2:	0f b6 d0             	movzbl %al,%edx

  if(data == 0xE0){
80102aa5:	3c e0                	cmp    $0xe0,%al
80102aa7:	74 57                	je     80102b00 <kbdgetc+0x80>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102aa9:	89 d9                	mov    %ebx,%ecx
80102aab:	83 e1 40             	and    $0x40,%ecx
80102aae:	84 c0                	test   %al,%al
80102ab0:	78 5e                	js     80102b10 <kbdgetc+0x90>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102ab2:	85 c9                	test   %ecx,%ecx
80102ab4:	74 09                	je     80102abf <kbdgetc+0x3f>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102ab6:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102ab9:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
80102abc:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
80102abf:	0f b6 8a e0 7e 10 80 	movzbl -0x7fef8120(%edx),%ecx
  shift ^= togglecode[data];
80102ac6:	0f b6 82 e0 7d 10 80 	movzbl -0x7fef8220(%edx),%eax
  shift |= shiftcode[data];
80102acd:	09 d9                	or     %ebx,%ecx
  shift ^= togglecode[data];
80102acf:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102ad1:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
80102ad3:	89 0d d4 b5 10 80    	mov    %ecx,0x8010b5d4
  c = charcode[shift & (CTL | SHIFT)][data];
80102ad9:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102adc:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102adf:	8b 04 85 c0 7d 10 80 	mov    -0x7fef8240(,%eax,4),%eax
80102ae6:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
80102aea:	74 0b                	je     80102af7 <kbdgetc+0x77>
    if('a' <= c && c <= 'z')
80102aec:	8d 50 9f             	lea    -0x61(%eax),%edx
80102aef:	83 fa 19             	cmp    $0x19,%edx
80102af2:	77 44                	ja     80102b38 <kbdgetc+0xb8>
      c += 'A' - 'a';
80102af4:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102af7:	5b                   	pop    %ebx
80102af8:	5d                   	pop    %ebp
80102af9:	c3                   	ret    
80102afa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    shift |= E0ESC;
80102b00:	83 cb 40             	or     $0x40,%ebx
    return 0;
80102b03:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
80102b05:	89 1d d4 b5 10 80    	mov    %ebx,0x8010b5d4
}
80102b0b:	5b                   	pop    %ebx
80102b0c:	5d                   	pop    %ebp
80102b0d:	c3                   	ret    
80102b0e:	66 90                	xchg   %ax,%ax
    data = (shift & E0ESC ? data : data & 0x7F);
80102b10:	83 e0 7f             	and    $0x7f,%eax
80102b13:	85 c9                	test   %ecx,%ecx
80102b15:	0f 44 d0             	cmove  %eax,%edx
    return 0;
80102b18:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
80102b1a:	0f b6 8a e0 7e 10 80 	movzbl -0x7fef8120(%edx),%ecx
80102b21:	83 c9 40             	or     $0x40,%ecx
80102b24:	0f b6 c9             	movzbl %cl,%ecx
80102b27:	f7 d1                	not    %ecx
80102b29:	21 d9                	and    %ebx,%ecx
}
80102b2b:	5b                   	pop    %ebx
80102b2c:	5d                   	pop    %ebp
    shift &= ~(shiftcode[data] | E0ESC);
80102b2d:	89 0d d4 b5 10 80    	mov    %ecx,0x8010b5d4
}
80102b33:	c3                   	ret    
80102b34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
80102b38:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
80102b3b:	8d 50 20             	lea    0x20(%eax),%edx
}
80102b3e:	5b                   	pop    %ebx
80102b3f:	5d                   	pop    %ebp
      c += 'a' - 'A';
80102b40:	83 f9 1a             	cmp    $0x1a,%ecx
80102b43:	0f 42 c2             	cmovb  %edx,%eax
}
80102b46:	c3                   	ret    
80102b47:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102b4e:	66 90                	xchg   %ax,%ax
    return -1;
80102b50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102b55:	c3                   	ret    
80102b56:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102b5d:	8d 76 00             	lea    0x0(%esi),%esi

80102b60 <kbdintr>:

void
kbdintr(void)
{
80102b60:	f3 0f 1e fb          	endbr32 
80102b64:	55                   	push   %ebp
80102b65:	89 e5                	mov    %esp,%ebp
80102b67:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102b6a:	68 80 2a 10 80       	push   $0x80102a80
80102b6f:	e8 4c dd ff ff       	call   801008c0 <consoleintr>
}
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
80102e9f:	e8 2c 21 00 00       	call   80104fd0 <memcmp>
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
80102fd4:	e8 47 20 00 00       	call   80105020 <memmove>
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
8010307e:	68 e0 7f 10 80       	push   $0x80107fe0
80103083:	68 c0 36 11 80       	push   $0x801136c0
80103088:	e8 63 1c 00 00       	call   80104cf0 <initlock>
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
8010311f:	e8 4c 1d 00 00       	call   80104e70 <acquire>
80103124:	83 c4 10             	add    $0x10,%esp
80103127:	eb 1c                	jmp    80103145 <begin_op+0x35>
80103129:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80103130:	83 ec 08             	sub    $0x8,%esp
80103133:	68 c0 36 11 80       	push   $0x801136c0
80103138:	68 c0 36 11 80       	push   $0x801136c0
8010313d:	e8 ce 16 00 00       	call   80104810 <sleep>
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
80103174:	e8 b7 1d 00 00       	call   80104f30 <release>
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
80103192:	e8 d9 1c 00 00       	call   80104e70 <acquire>
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
801031d0:	e8 5b 1d 00 00       	call   80104f30 <release>
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
801031ea:	e8 81 1c 00 00       	call   80104e70 <acquire>
    wakeup(&log);
801031ef:	c7 04 24 c0 36 11 80 	movl   $0x801136c0,(%esp)
    log.committing = 0;
801031f6:	c7 05 00 37 11 80 00 	movl   $0x0,0x80113700
801031fd:	00 00 00 
    wakeup(&log);
80103200:	e8 cb 17 00 00       	call   801049d0 <wakeup>
    release(&log.lock);
80103205:	c7 04 24 c0 36 11 80 	movl   $0x801136c0,(%esp)
8010320c:	e8 1f 1d 00 00       	call   80104f30 <release>
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
80103264:	e8 b7 1d 00 00       	call   80105020 <memmove>
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
801032b8:	e8 13 17 00 00       	call   801049d0 <wakeup>
  release(&log.lock);
801032bd:	c7 04 24 c0 36 11 80 	movl   $0x801136c0,(%esp)
801032c4:	e8 67 1c 00 00       	call   80104f30 <release>
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
801032d7:	68 e4 7f 10 80       	push   $0x80107fe4
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
80103332:	e8 39 1b 00 00       	call   80104e70 <acquire>
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
80103375:	e9 b6 1b 00 00       	jmp    80104f30 <release>
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
801033a1:	68 f3 7f 10 80       	push   $0x80107ff3
801033a6:	e8 e5 cf ff ff       	call   80100390 <panic>
    panic("log_write outside of trans");
801033ab:	83 ec 0c             	sub    $0xc,%esp
801033ae:	68 09 80 10 80       	push   $0x80108009
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
801033c7:	e8 a4 09 00 00       	call   80103d70 <cpuid>
801033cc:	89 c3                	mov    %eax,%ebx
801033ce:	e8 9d 09 00 00       	call   80103d70 <cpuid>
801033d3:	83 ec 04             	sub    $0x4,%esp
801033d6:	53                   	push   %ebx
801033d7:	50                   	push   %eax
801033d8:	68 24 80 10 80       	push   $0x80108024
801033dd:	e8 ce d2 ff ff       	call   801006b0 <cprintf>
  idtinit();       // load idt register
801033e2:	e8 29 2f 00 00       	call   80106310 <idtinit>
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
801033fa:	e8 f1 10 00 00       	call   801044f0 <scheduler>
801033ff:	90                   	nop

80103400 <mpenter>:
{
80103400:	f3 0f 1e fb          	endbr32 
80103404:	55                   	push   %ebp
80103405:	89 e5                	mov    %esp,%ebp
80103407:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
8010340a:	e8 d1 3f 00 00       	call   801073e0 <switchkvm>
  seginit();
8010340f:	e8 3c 3f 00 00       	call   80107350 <seginit>
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
8010343b:	68 08 65 11 80       	push   $0x80116508
80103440:	e8 fb f4 ff ff       	call   80102940 <kinit1>
  kvmalloc();      // kernel page table
80103445:	e8 76 44 00 00       	call   801078c0 <kvmalloc>
  mpinit();        // detect other processors
8010344a:	e8 81 01 00 00       	call   801035d0 <mpinit>
  lapicinit();     // interrupt controller
8010344f:	e8 2c f7 ff ff       	call   80102b80 <lapicinit>
  seginit();       // segment descriptors
80103454:	e8 f7 3e 00 00       	call   80107350 <seginit>
  picinit();       // disable pic
80103459:	e8 52 03 00 00       	call   801037b0 <picinit>
  ioapicinit();    // another interrupt controller
8010345e:	e8 fd f2 ff ff       	call   80102760 <ioapicinit>
  consoleinit();   // console hardware
80103463:	e8 98 d9 ff ff       	call   80100e00 <consoleinit>
  uartinit();      // serial port
80103468:	e8 a3 31 00 00       	call   80106610 <uartinit>
  pinit();         // process table
8010346d:	e8 7e 08 00 00       	call   80103cf0 <pinit>
  tvinit();        // trap vectors
80103472:	e8 19 2e 00 00       	call   80106290 <tvinit>
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
80103498:	e8 83 1b 00 00       	call   80105020 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
8010349d:	83 c4 10             	add    $0x10,%esp
801034a0:	69 05 70 38 11 80 b0 	imul   $0xb0,0x80113870,%eax
801034a7:	00 00 00 
801034aa:	05 c0 37 11 80       	add    $0x801137c0,%eax
801034af:	3d c0 37 11 80       	cmp    $0x801137c0,%eax
801034b4:	76 7a                	jbe    80103530 <main+0x110>
801034b6:	bb c0 37 11 80       	mov    $0x801137c0,%ebx
801034bb:	eb 1c                	jmp    801034d9 <main+0xb9>
801034bd:	8d 76 00             	lea    0x0(%esi),%esi
801034c0:	69 05 70 38 11 80 b0 	imul   $0xb0,0x80113870,%eax
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
80103542:	e8 a9 08 00 00       	call   80103df0 <userinit>
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
8010357e:	68 38 80 10 80       	push   $0x80108038
80103583:	56                   	push   %esi
80103584:	e8 47 1a 00 00       	call   80104fd0 <memcmp>
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
8010363a:	68 3d 80 10 80       	push   $0x8010803d
8010363f:	50                   	push   %eax
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103640:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103643:	e8 88 19 00 00       	call   80104fd0 <memcmp>
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
80103740:	8b 0d 70 38 11 80    	mov    0x80113870,%ecx
80103746:	85 c9                	test   %ecx,%ecx
80103748:	7f 19                	jg     80103763 <mpinit+0x193>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010374a:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
80103750:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
        ncpu++;
80103754:	83 c1 01             	add    $0x1,%ecx
80103757:	89 0d 70 38 11 80    	mov    %ecx,0x80113870
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010375d:	88 9f c0 37 11 80    	mov    %bl,-0x7feec840(%edi)
      p += sizeof(struct mpproc);
80103763:	83 c0 14             	add    $0x14,%eax
      continue;
80103766:	e9 55 ff ff ff       	jmp    801036c0 <mpinit+0xf0>
8010376b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010376f:	90                   	nop
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
80103793:	68 42 80 10 80       	push   $0x80108042
80103798:	e8 f3 cb ff ff       	call   80100390 <panic>
    panic("Didn't find a suitable machine");
8010379d:	83 ec 0c             	sub    $0xc,%esp
801037a0:	68 5c 80 10 80       	push   $0x8010805c
801037a5:	e8 e6 cb ff ff       	call   80100390 <panic>
801037aa:	66 90                	xchg   %ax,%ax
801037ac:	66 90                	xchg   %ax,%ax
801037ae:	66 90                	xchg   %ax,%ax

801037b0 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
801037b0:	f3 0f 1e fb          	endbr32 
801037b4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801037b9:	ba 21 00 00 00       	mov    $0x21,%edx
801037be:	ee                   	out    %al,(%dx)
801037bf:	ba a1 00 00 00       	mov    $0xa1,%edx
801037c4:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
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
80103847:	68 7b 80 10 80       	push   $0x8010807b
8010384c:	50                   	push   %eax
8010384d:	e8 9e 14 00 00       	call   80104cf0 <initlock>
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
801038f3:	e8 78 15 00 00       	call   80104e70 <acquire>
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
80103913:	e8 b8 10 00 00       	call   801049d0 <wakeup>
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
80103938:	e9 f3 15 00 00       	jmp    80104f30 <release>
8010393d:	8d 76 00             	lea    0x0(%esi),%esi
    wakeup(&p->nwrite);
80103940:	83 ec 0c             	sub    $0xc,%esp
80103943:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
80103949:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103950:	00 00 00 
    wakeup(&p->nwrite);
80103953:	50                   	push   %eax
80103954:	e8 77 10 00 00       	call   801049d0 <wakeup>
80103959:	83 c4 10             	add    $0x10,%esp
8010395c:	eb bd                	jmp    8010391b <pipeclose+0x3b>
8010395e:	66 90                	xchg   %ax,%ax
    release(&p->lock);
80103960:	83 ec 0c             	sub    $0xc,%esp
80103963:	53                   	push   %ebx
80103964:	e8 c7 15 00 00       	call   80104f30 <release>
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
80103991:	e8 da 14 00 00       	call   80104e70 <acquire>
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
801039d8:	e8 b3 03 00 00       	call   80103d90 <myproc>
801039dd:	8b 48 24             	mov    0x24(%eax),%ecx
801039e0:	85 c9                	test   %ecx,%ecx
801039e2:	75 34                	jne    80103a18 <pipewrite+0x98>
      wakeup(&p->nread);
801039e4:	83 ec 0c             	sub    $0xc,%esp
801039e7:	57                   	push   %edi
801039e8:	e8 e3 0f 00 00       	call   801049d0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801039ed:	58                   	pop    %eax
801039ee:	5a                   	pop    %edx
801039ef:	53                   	push   %ebx
801039f0:	56                   	push   %esi
801039f1:	e8 1a 0e 00 00       	call   80104810 <sleep>
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
80103a1c:	e8 0f 15 00 00       	call   80104f30 <release>
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
80103a6a:	e8 61 0f 00 00       	call   801049d0 <wakeup>
  release(&p->lock);
80103a6f:	89 1c 24             	mov    %ebx,(%esp)
80103a72:	e8 b9 14 00 00       	call   80104f30 <release>
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
80103a9a:	e8 d1 13 00 00       	call   80104e70 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103a9f:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103aa5:	83 c4 10             	add    $0x10,%esp
80103aa8:	39 86 38 02 00 00    	cmp    %eax,0x238(%esi)
80103aae:	74 33                	je     80103ae3 <piperead+0x63>
80103ab0:	eb 3b                	jmp    80103aed <piperead+0x6d>
80103ab2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(myproc()->killed){
80103ab8:	e8 d3 02 00 00       	call   80103d90 <myproc>
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
80103acd:	e8 3e 0d 00 00       	call   80104810 <sleep>
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
80103b36:	e8 95 0e 00 00       	call   801049d0 <wakeup>
  release(&p->lock);
80103b3b:	89 34 24             	mov    %esi,(%esp)
80103b3e:	e8 ed 13 00 00       	call   80104f30 <release>
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
80103b59:	e8 d2 13 00 00       	call   80104f30 <release>
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
80103b75:	bb b4 38 11 80       	mov    $0x801138b4,%ebx
  acquire(&ptable.lock);
80103b7a:	83 ec 0c             	sub    $0xc,%esp
80103b7d:	68 80 38 11 80       	push   $0x80113880
80103b82:	e8 e9 12 00 00       	call   80104e70 <acquire>
80103b87:	83 c4 10             	add    $0x10,%esp
80103b8a:	eb 16                	jmp    80103ba2 <allocproc+0x32>
80103b8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103b90:	81 c3 90 00 00 00    	add    $0x90,%ebx
80103b96:	81 fb b4 5c 11 80    	cmp    $0x80115cb4,%ebx
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
80103bc5:	68 c0 5c 11 80       	push   $0x80115cc0
  p->pid = nextpid++;
80103bca:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
  acquire(&tickslock);
80103bd0:	e8 9b 12 00 00       	call   80104e70 <acquire>
  ticks0 = ticks;
80103bd5:	8b 35 00 65 11 80    	mov    0x80116500,%esi
  release(&tickslock);
80103bdb:	c7 04 24 c0 5c 11 80 	movl   $0x80115cc0,(%esp)
80103be2:	e8 49 13 00 00       	call   80104f30 <release>
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
80103c0b:	c7 04 24 80 38 11 80 	movl   $0x80113880,(%esp)
80103c12:	e8 19 13 00 00       	call   80104f30 <release>

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
80103c37:	c7 40 14 7f 62 10 80 	movl   $0x8010627f,0x14(%eax)
  p->context = (struct context*)sp;
80103c3e:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103c41:	6a 14                	push   $0x14
80103c43:	6a 00                	push   $0x0
80103c45:	50                   	push   %eax
80103c46:	e8 35 13 00 00       	call   80104f80 <memset>
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
80103c6d:	68 80 38 11 80       	push   $0x80113880
80103c72:	e8 b9 12 00 00       	call   80104f30 <release>
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
80103caa:	68 80 38 11 80       	push   $0x80113880
80103caf:	e8 7c 12 00 00       	call   80104f30 <release>

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
80103cfa:	68 80 80 10 80       	push   $0x80108080
80103cff:	68 80 38 11 80       	push   $0x80113880
80103d04:	e8 e7 0f 00 00       	call   80104cf0 <initlock>
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
80103d17:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103d1a:	9c                   	pushf  
80103d1b:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103d1c:	f6 c4 02             	test   $0x2,%ah
80103d1f:	75 36                	jne    80103d57 <mycpu+0x47>
  apicid = lapicid();
80103d21:	e8 5a ef ff ff       	call   80102c80 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103d26:	8b 15 70 38 11 80    	mov    0x80113870,%edx
80103d2c:	85 d2                	test   %edx,%edx
80103d2e:	7e 0b                	jle    80103d3b <mycpu+0x2b>
    if (cpus[i].apicid == apicid)
80103d30:	0f b6 15 c0 37 11 80 	movzbl 0x801137c0,%edx
80103d37:	39 d0                	cmp    %edx,%eax
80103d39:	74 15                	je     80103d50 <mycpu+0x40>
  panic("unknown apicid\n");
80103d3b:	83 ec 0c             	sub    $0xc,%esp
80103d3e:	68 87 80 10 80       	push   $0x80108087
80103d43:	e8 48 c6 ff ff       	call   80100390 <panic>
80103d48:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103d4f:	90                   	nop
}
80103d50:	c9                   	leave  
80103d51:	b8 c0 37 11 80       	mov    $0x801137c0,%eax
80103d56:	c3                   	ret    
    panic("mycpu called with interrupts enabled\n");
80103d57:	83 ec 0c             	sub    $0xc,%esp
80103d5a:	68 a4 81 10 80       	push   $0x801081a4
80103d5f:	e8 2c c6 ff ff       	call   80100390 <panic>
80103d64:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103d6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103d6f:	90                   	nop

80103d70 <cpuid>:
cpuid() {
80103d70:	f3 0f 1e fb          	endbr32 
80103d74:	55                   	push   %ebp
80103d75:	89 e5                	mov    %esp,%ebp
80103d77:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103d7a:	e8 91 ff ff ff       	call   80103d10 <mycpu>
}
80103d7f:	c9                   	leave  
  return mycpu()-cpus;
80103d80:	2d c0 37 11 80       	sub    $0x801137c0,%eax
80103d85:	c1 f8 04             	sar    $0x4,%eax
80103d88:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
80103d8e:	c3                   	ret    
80103d8f:	90                   	nop

80103d90 <myproc>:
myproc(void) {
80103d90:	f3 0f 1e fb          	endbr32 
80103d94:	55                   	push   %ebp
80103d95:	89 e5                	mov    %esp,%ebp
80103d97:	53                   	push   %ebx
80103d98:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103d9b:	e8 d0 0f 00 00       	call   80104d70 <pushcli>
  c = mycpu();
80103da0:	e8 6b ff ff ff       	call   80103d10 <mycpu>
  p = c->proc;
80103da5:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103dab:	e8 10 10 00 00       	call   80104dc0 <popcli>
}
80103db0:	83 c4 04             	add    $0x4,%esp
80103db3:	89 d8                	mov    %ebx,%eax
80103db5:	5b                   	pop    %ebx
80103db6:	5d                   	pop    %ebp
80103db7:	c3                   	ret    
80103db8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103dbf:	90                   	nop

80103dc0 <getTime>:
int getTime(void) {
80103dc0:	f3 0f 1e fb          	endbr32 
80103dc4:	55                   	push   %ebp
80103dc5:	89 e5                	mov    %esp,%ebp
80103dc7:	53                   	push   %ebx
80103dc8:	83 ec 10             	sub    $0x10,%esp
  acquire(&tickslock);
80103dcb:	68 c0 5c 11 80       	push   $0x80115cc0
80103dd0:	e8 9b 10 00 00       	call   80104e70 <acquire>
  ticks0 = ticks;
80103dd5:	8b 1d 00 65 11 80    	mov    0x80116500,%ebx
  release(&tickslock);
80103ddb:	c7 04 24 c0 5c 11 80 	movl   $0x80115cc0,(%esp)
80103de2:	e8 49 11 00 00       	call   80104f30 <release>
}
80103de7:	89 d8                	mov    %ebx,%eax
80103de9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103dec:	c9                   	leave  
80103ded:	c3                   	ret    
80103dee:	66 90                	xchg   %ax,%ax

80103df0 <userinit>:
{
80103df0:	f3 0f 1e fb          	endbr32 
80103df4:	55                   	push   %ebp
80103df5:	89 e5                	mov    %esp,%ebp
80103df7:	53                   	push   %ebx
80103df8:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103dfb:	e8 70 fd ff ff       	call   80103b70 <allocproc>
80103e00:	89 c3                	mov    %eax,%ebx
  initproc = p;
80103e02:	a3 e0 b5 10 80       	mov    %eax,0x8010b5e0
  if((p->pgdir = setupkvm()) == 0)
80103e07:	e8 34 3a 00 00       	call   80107840 <setupkvm>
80103e0c:	89 43 04             	mov    %eax,0x4(%ebx)
80103e0f:	85 c0                	test   %eax,%eax
80103e11:	0f 84 bd 00 00 00    	je     80103ed4 <userinit+0xe4>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103e17:	83 ec 04             	sub    $0x4,%esp
80103e1a:	68 2c 00 00 00       	push   $0x2c
80103e1f:	68 60 b4 10 80       	push   $0x8010b460
80103e24:	50                   	push   %eax
80103e25:	e8 e6 36 00 00       	call   80107510 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103e2a:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103e2d:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103e33:	6a 4c                	push   $0x4c
80103e35:	6a 00                	push   $0x0
80103e37:	ff 73 18             	pushl  0x18(%ebx)
80103e3a:	e8 41 11 00 00       	call   80104f80 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103e3f:	8b 43 18             	mov    0x18(%ebx),%eax
80103e42:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103e47:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103e4a:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103e4f:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103e53:	8b 43 18             	mov    0x18(%ebx),%eax
80103e56:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103e5a:	8b 43 18             	mov    0x18(%ebx),%eax
80103e5d:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103e61:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103e65:	8b 43 18             	mov    0x18(%ebx),%eax
80103e68:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103e6c:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103e70:	8b 43 18             	mov    0x18(%ebx),%eax
80103e73:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103e7a:	8b 43 18             	mov    0x18(%ebx),%eax
80103e7d:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103e84:	8b 43 18             	mov    0x18(%ebx),%eax
80103e87:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103e8e:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103e91:	6a 10                	push   $0x10
80103e93:	68 b0 80 10 80       	push   $0x801080b0
80103e98:	50                   	push   %eax
80103e99:	e8 a2 12 00 00       	call   80105140 <safestrcpy>
  p->cwd = namei("/");
80103e9e:	c7 04 24 b9 80 10 80 	movl   $0x801080b9,(%esp)
80103ea5:	e8 66 e5 ff ff       	call   80102410 <namei>
80103eaa:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103ead:	c7 04 24 80 38 11 80 	movl   $0x80113880,(%esp)
80103eb4:	e8 b7 0f 00 00       	call   80104e70 <acquire>
  p->state = RUNNABLE;
80103eb9:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103ec0:	c7 04 24 80 38 11 80 	movl   $0x80113880,(%esp)
80103ec7:	e8 64 10 00 00       	call   80104f30 <release>
}
80103ecc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103ecf:	83 c4 10             	add    $0x10,%esp
80103ed2:	c9                   	leave  
80103ed3:	c3                   	ret    
    panic("userinit: out of memory?");
80103ed4:	83 ec 0c             	sub    $0xc,%esp
80103ed7:	68 97 80 10 80       	push   $0x80108097
80103edc:	e8 af c4 ff ff       	call   80100390 <panic>
80103ee1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103ee8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103eef:	90                   	nop

80103ef0 <growproc>:
{
80103ef0:	f3 0f 1e fb          	endbr32 
80103ef4:	55                   	push   %ebp
80103ef5:	89 e5                	mov    %esp,%ebp
80103ef7:	56                   	push   %esi
80103ef8:	53                   	push   %ebx
80103ef9:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103efc:	e8 6f 0e 00 00       	call   80104d70 <pushcli>
  c = mycpu();
80103f01:	e8 0a fe ff ff       	call   80103d10 <mycpu>
  p = c->proc;
80103f06:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103f0c:	e8 af 0e 00 00       	call   80104dc0 <popcli>
  sz = curproc->sz;
80103f11:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103f13:	85 f6                	test   %esi,%esi
80103f15:	7f 19                	jg     80103f30 <growproc+0x40>
  } else if(n < 0){
80103f17:	75 37                	jne    80103f50 <growproc+0x60>
  switchuvm(curproc);
80103f19:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103f1c:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103f1e:	53                   	push   %ebx
80103f1f:	e8 dc 34 00 00       	call   80107400 <switchuvm>
  return 0;
80103f24:	83 c4 10             	add    $0x10,%esp
80103f27:	31 c0                	xor    %eax,%eax
}
80103f29:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103f2c:	5b                   	pop    %ebx
80103f2d:	5e                   	pop    %esi
80103f2e:	5d                   	pop    %ebp
80103f2f:	c3                   	ret    
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103f30:	83 ec 04             	sub    $0x4,%esp
80103f33:	01 c6                	add    %eax,%esi
80103f35:	56                   	push   %esi
80103f36:	50                   	push   %eax
80103f37:	ff 73 04             	pushl  0x4(%ebx)
80103f3a:	e8 21 37 00 00       	call   80107660 <allocuvm>
80103f3f:	83 c4 10             	add    $0x10,%esp
80103f42:	85 c0                	test   %eax,%eax
80103f44:	75 d3                	jne    80103f19 <growproc+0x29>
      return -1;
80103f46:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103f4b:	eb dc                	jmp    80103f29 <growproc+0x39>
80103f4d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103f50:	83 ec 04             	sub    $0x4,%esp
80103f53:	01 c6                	add    %eax,%esi
80103f55:	56                   	push   %esi
80103f56:	50                   	push   %eax
80103f57:	ff 73 04             	pushl  0x4(%ebx)
80103f5a:	e8 31 38 00 00       	call   80107790 <deallocuvm>
80103f5f:	83 c4 10             	add    $0x10,%esp
80103f62:	85 c0                	test   %eax,%eax
80103f64:	75 b3                	jne    80103f19 <growproc+0x29>
80103f66:	eb de                	jmp    80103f46 <growproc+0x56>
80103f68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103f6f:	90                   	nop

80103f70 <fork>:
{
80103f70:	f3 0f 1e fb          	endbr32 
80103f74:	55                   	push   %ebp
80103f75:	89 e5                	mov    %esp,%ebp
80103f77:	57                   	push   %edi
80103f78:	56                   	push   %esi
80103f79:	53                   	push   %ebx
80103f7a:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103f7d:	e8 ee 0d 00 00       	call   80104d70 <pushcli>
  c = mycpu();
80103f82:	e8 89 fd ff ff       	call   80103d10 <mycpu>
  p = c->proc;
80103f87:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103f8d:	e8 2e 0e 00 00       	call   80104dc0 <popcli>
  if((np = allocproc()) == 0){
80103f92:	e8 d9 fb ff ff       	call   80103b70 <allocproc>
80103f97:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103f9a:	85 c0                	test   %eax,%eax
80103f9c:	0f 84 bb 00 00 00    	je     8010405d <fork+0xed>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103fa2:	83 ec 08             	sub    $0x8,%esp
80103fa5:	ff 33                	pushl  (%ebx)
80103fa7:	89 c7                	mov    %eax,%edi
80103fa9:	ff 73 04             	pushl  0x4(%ebx)
80103fac:	e8 5f 39 00 00       	call   80107910 <copyuvm>
80103fb1:	83 c4 10             	add    $0x10,%esp
80103fb4:	89 47 04             	mov    %eax,0x4(%edi)
80103fb7:	85 c0                	test   %eax,%eax
80103fb9:	0f 84 a5 00 00 00    	je     80104064 <fork+0xf4>
  np->sz = curproc->sz;
80103fbf:	8b 03                	mov    (%ebx),%eax
80103fc1:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103fc4:	89 01                	mov    %eax,(%ecx)
  *np->tf = *curproc->tf;
80103fc6:	8b 79 18             	mov    0x18(%ecx),%edi
  np->parent = curproc;
80103fc9:	89 c8                	mov    %ecx,%eax
80103fcb:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
80103fce:	b9 13 00 00 00       	mov    $0x13,%ecx
80103fd3:	8b 73 18             	mov    0x18(%ebx),%esi
80103fd6:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103fd8:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103fda:	8b 40 18             	mov    0x18(%eax),%eax
80103fdd:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  for(i = 0; i < NOFILE; i++)
80103fe4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[i])
80103fe8:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103fec:	85 c0                	test   %eax,%eax
80103fee:	74 13                	je     80104003 <fork+0x93>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103ff0:	83 ec 0c             	sub    $0xc,%esp
80103ff3:	50                   	push   %eax
80103ff4:	e8 57 d2 ff ff       	call   80101250 <filedup>
80103ff9:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103ffc:	83 c4 10             	add    $0x10,%esp
80103fff:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80104003:	83 c6 01             	add    $0x1,%esi
80104006:	83 fe 10             	cmp    $0x10,%esi
80104009:	75 dd                	jne    80103fe8 <fork+0x78>
  np->cwd = idup(curproc->cwd);
8010400b:	83 ec 0c             	sub    $0xc,%esp
8010400e:	ff 73 68             	pushl  0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104011:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
80104014:	e8 f7 da ff ff       	call   80101b10 <idup>
80104019:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
8010401c:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
8010401f:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104022:	8d 47 6c             	lea    0x6c(%edi),%eax
80104025:	6a 10                	push   $0x10
80104027:	53                   	push   %ebx
80104028:	50                   	push   %eax
80104029:	e8 12 11 00 00       	call   80105140 <safestrcpy>
  pid = np->pid;
8010402e:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80104031:	c7 04 24 80 38 11 80 	movl   $0x80113880,(%esp)
80104038:	e8 33 0e 00 00       	call   80104e70 <acquire>
  np->state = RUNNABLE;
8010403d:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80104044:	c7 04 24 80 38 11 80 	movl   $0x80113880,(%esp)
8010404b:	e8 e0 0e 00 00       	call   80104f30 <release>
  return pid;
80104050:	83 c4 10             	add    $0x10,%esp
}
80104053:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104056:	89 d8                	mov    %ebx,%eax
80104058:	5b                   	pop    %ebx
80104059:	5e                   	pop    %esi
8010405a:	5f                   	pop    %edi
8010405b:	5d                   	pop    %ebp
8010405c:	c3                   	ret    
    return -1;
8010405d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80104062:	eb ef                	jmp    80104053 <fork+0xe3>
    kfree(np->kstack);
80104064:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80104067:	83 ec 0c             	sub    $0xc,%esp
8010406a:	ff 73 08             	pushl  0x8(%ebx)
8010406d:	e8 de e7 ff ff       	call   80102850 <kfree>
    np->kstack = 0;
80104072:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    return -1;
80104079:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
8010407c:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80104083:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80104088:	eb c9                	jmp    80104053 <fork+0xe3>
8010408a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104090 <changeProcessMHRRN>:
int changeProcessMHRRN(int pid, int priority) {
80104090:	f3 0f 1e fb          	endbr32 
80104094:	55                   	push   %ebp
80104095:	89 e5                	mov    %esp,%ebp
80104097:	53                   	push   %ebx
80104098:	83 ec 10             	sub    $0x10,%esp
8010409b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010409e:	68 80 38 11 80       	push   $0x80113880
801040a3:	e8 c8 0d 00 00       	call   80104e70 <acquire>
801040a8:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801040ab:	b8 b4 38 11 80       	mov    $0x801138b4,%eax
801040b0:	eb 12                	jmp    801040c4 <changeProcessMHRRN+0x34>
801040b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801040b8:	05 90 00 00 00       	add    $0x90,%eax
801040bd:	3d b4 5c 11 80       	cmp    $0x80115cb4,%eax
801040c2:	74 2c                	je     801040f0 <changeProcessMHRRN+0x60>
    if(p->pid == pid){
801040c4:	39 58 10             	cmp    %ebx,0x10(%eax)
801040c7:	75 ef                	jne    801040b8 <changeProcessMHRRN+0x28>
      p->HRRN_priority = priority;
801040c9:	8b 55 0c             	mov    0xc(%ebp),%edx
      release(&ptable.lock);
801040cc:	83 ec 0c             	sub    $0xc,%esp
      p->HRRN_priority = priority;
801040cf:	89 90 88 00 00 00    	mov    %edx,0x88(%eax)
      release(&ptable.lock);
801040d5:	68 80 38 11 80       	push   $0x80113880
801040da:	e8 51 0e 00 00       	call   80104f30 <release>
}
801040df:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
801040e2:	83 c4 10             	add    $0x10,%esp
801040e5:	31 c0                	xor    %eax,%eax
}
801040e7:	c9                   	leave  
801040e8:	c3                   	ret    
801040e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
801040f0:	83 ec 0c             	sub    $0xc,%esp
801040f3:	68 80 38 11 80       	push   $0x80113880
801040f8:	e8 33 0e 00 00       	call   80104f30 <release>
}
801040fd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80104100:	83 c4 10             	add    $0x10,%esp
80104103:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104108:	c9                   	leave  
80104109:	c3                   	ret    
8010410a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104110 <changeSystemMHRRN>:
int changeSystemMHRRN(int priority) {
80104110:	f3 0f 1e fb          	endbr32 
80104114:	55                   	push   %ebp
80104115:	89 e5                	mov    %esp,%ebp
80104117:	53                   	push   %ebx
80104118:	83 ec 10             	sub    $0x10,%esp
8010411b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010411e:	68 80 38 11 80       	push   $0x80113880
80104123:	e8 48 0d 00 00       	call   80104e70 <acquire>
80104128:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010412b:	b8 b4 38 11 80       	mov    $0x801138b4,%eax
    p->HRRN_priority = priority;
80104130:	89 98 88 00 00 00    	mov    %ebx,0x88(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104136:	05 90 00 00 00       	add    $0x90,%eax
8010413b:	3d b4 5c 11 80       	cmp    $0x80115cb4,%eax
80104140:	75 ee                	jne    80104130 <changeSystemMHRRN+0x20>
  release(&ptable.lock);
80104142:	83 ec 0c             	sub    $0xc,%esp
80104145:	68 80 38 11 80       	push   $0x80113880
8010414a:	e8 e1 0d 00 00       	call   80104f30 <release>
}
8010414f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104152:	31 c0                	xor    %eax,%eax
80104154:	c9                   	leave  
80104155:	c3                   	ret    
80104156:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010415d:	8d 76 00             	lea    0x0(%esi),%esi

80104160 <changeQueue>:
int changeQueue(int pid, int tqnum) {
80104160:	f3 0f 1e fb          	endbr32 
80104164:	55                   	push   %ebp
80104165:	89 e5                	mov    %esp,%ebp
80104167:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010416a:	8b 55 08             	mov    0x8(%ebp),%edx
  if (tqnum < 1 || tqnum > 3)
8010416d:	8d 41 ff             	lea    -0x1(%ecx),%eax
80104170:	83 f8 02             	cmp    $0x2,%eax
80104173:	77 2b                	ja     801041a0 <changeQueue+0x40>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104175:	b8 b4 38 11 80       	mov    $0x801138b4,%eax
8010417a:	eb 10                	jmp    8010418c <changeQueue+0x2c>
8010417c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104180:	05 90 00 00 00       	add    $0x90,%eax
80104185:	3d b4 5c 11 80       	cmp    $0x80115cb4,%eax
8010418a:	74 14                	je     801041a0 <changeQueue+0x40>
    if(p->pid == pid){
8010418c:	39 50 10             	cmp    %edx,0x10(%eax)
8010418f:	75 ef                	jne    80104180 <changeQueue+0x20>
      p->qnum = tqnum;
80104191:	89 48 7c             	mov    %ecx,0x7c(%eax)
      return 0;
80104194:	31 c0                	xor    %eax,%eax
}
80104196:	5d                   	pop    %ebp
80104197:	c3                   	ret    
80104198:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010419f:	90                   	nop
    return -1;
801041a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801041a5:	5d                   	pop    %ebp
801041a6:	c3                   	ret    
801041a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801041ae:	66 90                	xchg   %ax,%ax

801041b0 <printProcess>:
int printProcess(void) {
801041b0:	f3 0f 1e fb          	endbr32 
801041b4:	55                   	push   %ebp
801041b5:	89 e5                	mov    %esp,%ebp
801041b7:	56                   	push   %esi
801041b8:	53                   	push   %ebx
801041b9:	bb 20 39 11 80       	mov    $0x80113920,%ebx
  acquire(&ptable.lock);
801041be:	83 ec 0c             	sub    $0xc,%esp
801041c1:	68 80 38 11 80       	push   $0x80113880
801041c6:	e8 a5 0c 00 00       	call   80104e70 <acquire>
  cprintf("name\tpid\tstate\t\tqueue\tcycles\tarrival time\tHRRN\tMHRRN\n");
801041cb:	c7 04 24 cc 81 10 80 	movl   $0x801081cc,(%esp)
801041d2:	e8 d9 c4 ff ff       	call   801006b0 <cprintf>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041d7:	83 c4 10             	add    $0x10,%esp
801041da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(p->state == 0) continue;
801041e0:	8b 43 a0             	mov    -0x60(%ebx),%eax
801041e3:	85 c0                	test   %eax,%eax
801041e5:	0f 84 fa 00 00 00    	je     801042e5 <printProcess+0x135>
    cprintf("%s\t", p->name);
801041eb:	83 ec 08             	sub    $0x8,%esp
801041ee:	53                   	push   %ebx
801041ef:	68 bb 80 10 80       	push   $0x801080bb
801041f4:	e8 b7 c4 ff ff       	call   801006b0 <cprintf>
    cprintf("%d\t", p->pid);
801041f9:	59                   	pop    %ecx
801041fa:	5e                   	pop    %esi
801041fb:	ff 73 a4             	pushl  -0x5c(%ebx)
801041fe:	68 bf 80 10 80       	push   $0x801080bf
80104203:	e8 a8 c4 ff ff       	call   801006b0 <cprintf>
    switch (p->state)
80104208:	83 c4 10             	add    $0x10,%esp
8010420b:	83 7b a0 05          	cmpl   $0x5,-0x60(%ebx)
8010420f:	77 27                	ja     80104238 <printProcess+0x88>
80104211:	8b 43 a0             	mov    -0x60(%ebx),%eax
80104214:	3e ff 24 85 04 82 10 	notrack jmp *-0x7fef7dfc(,%eax,4)
8010421b:	80 
8010421c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        cprintf("%s\t\t", "RUNNING");
80104220:	83 ec 08             	sub    $0x8,%esp
80104223:	68 e8 80 10 80       	push   $0x801080e8
80104228:	68 ca 80 10 80       	push   $0x801080ca
8010422d:	e8 7e c4 ff ff       	call   801006b0 <cprintf>
        break;
80104232:	83 c4 10             	add    $0x10,%esp
80104235:	8d 76 00             	lea    0x0(%esi),%esi
    cprintf("%d\t", p->qnum);
80104238:	83 ec 08             	sub    $0x8,%esp
8010423b:	ff 73 10             	pushl  0x10(%ebx)
8010423e:	68 bf 80 10 80       	push   $0x801080bf
80104243:	e8 68 c4 ff ff       	call   801006b0 <cprintf>
    cprintf("%d\t", p->cycles);
80104248:	58                   	pop    %eax
80104249:	5a                   	pop    %edx
8010424a:	ff 73 18             	pushl  0x18(%ebx)
8010424d:	68 bf 80 10 80       	push   $0x801080bf
80104252:	e8 59 c4 ff ff       	call   801006b0 <cprintf>
    cprintf("%d\t\t", p->arrival_time);
80104257:	59                   	pop    %ecx
80104258:	5e                   	pop    %esi
80104259:	ff 73 14             	pushl  0x14(%ebx)
8010425c:	68 f7 80 10 80       	push   $0x801080f7
80104261:	e8 4a c4 ff ff       	call   801006b0 <cprintf>
  acquire(&tickslock);
80104266:	c7 04 24 c0 5c 11 80 	movl   $0x80115cc0,(%esp)
8010426d:	e8 fe 0b 00 00       	call   80104e70 <acquire>
  ticks0 = ticks;
80104272:	8b 35 00 65 11 80    	mov    0x80116500,%esi
  release(&tickslock);
80104278:	c7 04 24 c0 5c 11 80 	movl   $0x80115cc0,(%esp)
8010427f:	e8 ac 0c 00 00       	call   80104f30 <release>
    cprintf("%d\t", ((getTime() - p->arrival_time + p->cycles)/(p->cycles)));
80104284:	8b 4b 18             	mov    0x18(%ebx),%ecx
80104287:	58                   	pop    %eax
80104288:	89 f0                	mov    %esi,%eax
8010428a:	2b 43 14             	sub    0x14(%ebx),%eax
8010428d:	5a                   	pop    %edx
8010428e:	01 c8                	add    %ecx,%eax
80104290:	99                   	cltd   
80104291:	f7 f9                	idiv   %ecx
80104293:	50                   	push   %eax
80104294:	68 bf 80 10 80       	push   $0x801080bf
80104299:	e8 12 c4 ff ff       	call   801006b0 <cprintf>
  acquire(&tickslock);
8010429e:	c7 04 24 c0 5c 11 80 	movl   $0x80115cc0,(%esp)
801042a5:	e8 c6 0b 00 00       	call   80104e70 <acquire>
  ticks0 = ticks;
801042aa:	8b 35 00 65 11 80    	mov    0x80116500,%esi
  release(&tickslock);
801042b0:	c7 04 24 c0 5c 11 80 	movl   $0x80115cc0,(%esp)
801042b7:	e8 74 0c 00 00       	call   80104f30 <release>
    cprintf("%d\t", (((getTime() - p->arrival_time + p->cycles)/(p->cycles))+p->HRRN_priority)/2);
801042bc:	8b 4b 18             	mov    0x18(%ebx),%ecx
801042bf:	58                   	pop    %eax
801042c0:	89 f0                	mov    %esi,%eax
801042c2:	2b 43 14             	sub    0x14(%ebx),%eax
801042c5:	5a                   	pop    %edx
801042c6:	01 c8                	add    %ecx,%eax
801042c8:	99                   	cltd   
801042c9:	f7 f9                	idiv   %ecx
801042cb:	03 43 1c             	add    0x1c(%ebx),%eax
801042ce:	89 c2                	mov    %eax,%edx
801042d0:	c1 ea 1f             	shr    $0x1f,%edx
801042d3:	01 d0                	add    %edx,%eax
801042d5:	d1 f8                	sar    %eax
801042d7:	50                   	push   %eax
801042d8:	68 bf 80 10 80       	push   $0x801080bf
801042dd:	e8 ce c3 ff ff       	call   801006b0 <cprintf>
801042e2:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801042e5:	81 c3 90 00 00 00    	add    $0x90,%ebx
801042eb:	81 fb 20 5d 11 80    	cmp    $0x80115d20,%ebx
801042f1:	0f 85 e9 fe ff ff    	jne    801041e0 <printProcess+0x30>
  release(&ptable.lock);
801042f7:	83 ec 0c             	sub    $0xc,%esp
801042fa:	68 80 38 11 80       	push   $0x80113880
801042ff:	e8 2c 0c 00 00       	call   80104f30 <release>
}
80104304:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104307:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010430c:	5b                   	pop    %ebx
8010430d:	5e                   	pop    %esi
8010430e:	5d                   	pop    %ebp
8010430f:	c3                   	ret    
        cprintf("%s\t", "RUNNABLE");
80104310:	83 ec 08             	sub    $0x8,%esp
80104313:	68 df 80 10 80       	push   $0x801080df
80104318:	68 bb 80 10 80       	push   $0x801080bb
8010431d:	e8 8e c3 ff ff       	call   801006b0 <cprintf>
        break;
80104322:	83 c4 10             	add    $0x10,%esp
80104325:	e9 0e ff ff ff       	jmp    80104238 <printProcess+0x88>
8010432a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        cprintf("%s\t\t", "UNUSED");
80104330:	83 ec 08             	sub    $0x8,%esp
80104333:	68 c3 80 10 80       	push   $0x801080c3
80104338:	68 ca 80 10 80       	push   $0x801080ca
8010433d:	e8 6e c3 ff ff       	call   801006b0 <cprintf>
        break;
80104342:	83 c4 10             	add    $0x10,%esp
80104345:	e9 ee fe ff ff       	jmp    80104238 <printProcess+0x88>
8010434a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        cprintf("%s\t\t", "ZOMBIE");
80104350:	83 ec 08             	sub    $0x8,%esp
80104353:	68 f0 80 10 80       	push   $0x801080f0
80104358:	68 ca 80 10 80       	push   $0x801080ca
8010435d:	e8 4e c3 ff ff       	call   801006b0 <cprintf>
        break;
80104362:	83 c4 10             	add    $0x10,%esp
80104365:	e9 ce fe ff ff       	jmp    80104238 <printProcess+0x88>
8010436a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        cprintf("%s\t", "SLEEPING");
80104370:	83 ec 08             	sub    $0x8,%esp
80104373:	68 d6 80 10 80       	push   $0x801080d6
80104378:	68 bb 80 10 80       	push   $0x801080bb
8010437d:	e8 2e c3 ff ff       	call   801006b0 <cprintf>
        break;
80104382:	83 c4 10             	add    $0x10,%esp
80104385:	e9 ae fe ff ff       	jmp    80104238 <printProcess+0x88>
8010438a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        cprintf("%s\t\t", "EMBRYO");
80104390:	83 ec 08             	sub    $0x8,%esp
80104393:	68 cf 80 10 80       	push   $0x801080cf
80104398:	68 ca 80 10 80       	push   $0x801080ca
8010439d:	e8 0e c3 ff ff       	call   801006b0 <cprintf>
        break;
801043a2:	83 c4 10             	add    $0x10,%esp
801043a5:	e9 8e fe ff ff       	jmp    80104238 <printProcess+0x88>
801043aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801043b0 <findProcess>:
struct proc* findProcess(int* flag) {
801043b0:	f3 0f 1e fb          	endbr32 
801043b4:	55                   	push   %ebp
801043b5:	89 e5                	mov    %esp,%ebp
801043b7:	57                   	push   %edi
801043b8:	56                   	push   %esi
801043b9:	53                   	push   %ebx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) 
801043ba:	bb b4 38 11 80       	mov    $0x801138b4,%ebx
struct proc* findProcess(int* flag) {
801043bf:	83 ec 0c             	sub    $0xc,%esp
801043c2:	eb 12                	jmp    801043d6 <findProcess+0x26>
801043c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) 
801043c8:	81 c3 90 00 00 00    	add    $0x90,%ebx
801043ce:	81 fb b4 5c 11 80    	cmp    $0x80115cb4,%ebx
801043d4:	74 22                	je     801043f8 <findProcess+0x48>
    if(p->state == RUNNABLE && p->qnum == 1) {
801043d6:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
801043da:	75 ec                	jne    801043c8 <findProcess+0x18>
801043dc:	83 7b 7c 01          	cmpl   $0x1,0x7c(%ebx)
801043e0:	75 e6                	jne    801043c8 <findProcess+0x18>
    *flag = 1;
801043e2:	8b 45 08             	mov    0x8(%ebp),%eax
801043e5:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
}
801043eb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801043ee:	89 d8                	mov    %ebx,%eax
801043f0:	5b                   	pop    %ebx
801043f1:	5e                   	pop    %esi
801043f2:	5f                   	pop    %edi
801043f3:	5d                   	pop    %ebp
801043f4:	c3                   	ret    
801043f5:	8d 76 00             	lea    0x0(%esi),%esi
  int max_arrival_time = -1;
801043f8:	be ff ff ff ff       	mov    $0xffffffff,%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801043fd:	b8 b4 38 11 80       	mov    $0x801138b4,%eax
80104402:	eb 10                	jmp    80104414 <findProcess+0x64>
80104404:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104408:	05 90 00 00 00       	add    $0x90,%eax
8010440d:	3d b4 5c 11 80       	cmp    $0x80115cb4,%eax
80104412:	74 2c                	je     80104440 <findProcess+0x90>
    if(p->state == RUNNABLE && p->qnum == 2) 
80104414:	83 78 0c 03          	cmpl   $0x3,0xc(%eax)
80104418:	75 ee                	jne    80104408 <findProcess+0x58>
8010441a:	83 78 7c 02          	cmpl   $0x2,0x7c(%eax)
8010441e:	75 e8                	jne    80104408 <findProcess+0x58>
      if(p->arrival_time > max_arrival_time) {
80104420:	8b 90 80 00 00 00    	mov    0x80(%eax),%edx
80104426:	39 f2                	cmp    %esi,%edx
80104428:	7e de                	jle    80104408 <findProcess+0x58>
8010442a:	89 c3                	mov    %eax,%ebx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010442c:	05 90 00 00 00       	add    $0x90,%eax
      if(p->arrival_time > max_arrival_time) {
80104431:	89 d6                	mov    %edx,%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104433:	3d b4 5c 11 80       	cmp    $0x80115cb4,%eax
80104438:	75 da                	jne    80104414 <findProcess+0x64>
8010443a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(max_arrival_time != -1) {
80104440:	83 fe ff             	cmp    $0xffffffff,%esi
80104443:	75 9d                	jne    801043e2 <findProcess+0x32>
  acquire(&tickslock);
80104445:	83 ec 0c             	sub    $0xc,%esp
80104448:	68 c0 5c 11 80       	push   $0x80115cc0
8010444d:	e8 1e 0a 00 00       	call   80104e70 <acquire>
  release(&tickslock);
80104452:	c7 04 24 c0 5c 11 80 	movl   $0x80115cc0,(%esp)
  ticks0 = ticks;
80104459:	8b 3d 00 65 11 80    	mov    0x80116500,%edi
  release(&tickslock);
8010445f:	e8 cc 0a 00 00       	call   80104f30 <release>
  return ticks0;
80104464:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104467:	b9 b4 38 11 80       	mov    $0x801138b4,%ecx
8010446c:	eb 10                	jmp    8010447e <findProcess+0xce>
8010446e:	66 90                	xchg   %ax,%ax
80104470:	81 c1 90 00 00 00    	add    $0x90,%ecx
80104476:	81 f9 b4 5c 11 80    	cmp    $0x80115cb4,%ecx
8010447c:	74 46                	je     801044c4 <findProcess+0x114>
    if(p->state == RUNNABLE && p->qnum == 3) {
8010447e:	83 79 0c 03          	cmpl   $0x3,0xc(%ecx)
80104482:	75 ec                	jne    80104470 <findProcess+0xc0>
80104484:	83 79 7c 03          	cmpl   $0x3,0x7c(%ecx)
80104488:	75 e6                	jne    80104470 <findProcess+0xc0>
      int MHRRN = (((curr_time - p->arrival_time + p->cycles)/(p->cycles))+p->HRRN_priority)/2;
8010448a:	89 f8                	mov    %edi,%eax
8010448c:	2b 81 80 00 00 00    	sub    0x80(%ecx),%eax
80104492:	03 81 84 00 00 00    	add    0x84(%ecx),%eax
80104498:	99                   	cltd   
80104499:	f7 b9 84 00 00 00    	idivl  0x84(%ecx)
8010449f:	03 81 88 00 00 00    	add    0x88(%ecx),%eax
801044a5:	89 c2                	mov    %eax,%edx
801044a7:	c1 e8 1f             	shr    $0x1f,%eax
801044aa:	01 d0                	add    %edx,%eax
801044ac:	d1 f8                	sar    %eax
      if(MHRRN > max_MHRRN) {
801044ae:	39 f0                	cmp    %esi,%eax
801044b0:	7e be                	jle    80104470 <findProcess+0xc0>
801044b2:	89 cb                	mov    %ecx,%ebx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801044b4:	81 c1 90 00 00 00    	add    $0x90,%ecx
      if(MHRRN > max_MHRRN) {
801044ba:	89 c6                	mov    %eax,%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801044bc:	81 f9 b4 5c 11 80    	cmp    $0x80115cb4,%ecx
801044c2:	75 ba                	jne    8010447e <findProcess+0xce>
    *flag = 1;
801044c4:	8b 45 08             	mov    0x8(%ebp),%eax
  if(max_MHRRN != -1) {
801044c7:	83 fe ff             	cmp    $0xffffffff,%esi
801044ca:	74 0b                	je     801044d7 <findProcess+0x127>
    *flag = 1;
801044cc:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
    return last_p;
801044d2:	e9 14 ff ff ff       	jmp    801043eb <findProcess+0x3b>
  *flag = 0;
801044d7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801044dd:	bb b4 5c 11 80       	mov    $0x80115cb4,%ebx
  return p;
801044e2:	e9 04 ff ff ff       	jmp    801043eb <findProcess+0x3b>
801044e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801044ee:	66 90                	xchg   %ax,%ax

801044f0 <scheduler>:
{
801044f0:	f3 0f 1e fb          	endbr32 
801044f4:	55                   	push   %ebp
801044f5:	89 e5                	mov    %esp,%ebp
801044f7:	57                   	push   %edi
801044f8:	56                   	push   %esi
801044f9:	8d 7d e4             	lea    -0x1c(%ebp),%edi
801044fc:	53                   	push   %ebx
801044fd:	83 ec 2c             	sub    $0x2c,%esp
  struct cpu *c = mycpu();
80104500:	e8 0b f8 ff ff       	call   80103d10 <mycpu>
  c->proc = 0;
80104505:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
8010450c:	00 00 00 
  struct cpu *c = mycpu();
8010450f:	89 c3                	mov    %eax,%ebx
  c->proc = 0;
80104511:	8d 40 04             	lea    0x4(%eax),%eax
80104514:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80104517:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010451e:	66 90                	xchg   %ax,%ax
  asm volatile("sti");
80104520:	fb                   	sti    
    acquire(&ptable.lock);
80104521:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104524:	be b4 38 11 80       	mov    $0x801138b4,%esi
    acquire(&ptable.lock);
80104529:	68 80 38 11 80       	push   $0x80113880
8010452e:	e8 3d 09 00 00       	call   80104e70 <acquire>
80104533:	83 c4 10             	add    $0x10,%esp
      if(p->state != RUNNABLE)
80104536:	83 7e 0c 03          	cmpl   $0x3,0xc(%esi)
8010453a:	75 57                	jne    80104593 <scheduler+0xa3>
      p = findProcess(&flag);
8010453c:	83 ec 0c             	sub    $0xc,%esp
      int flag = 0;
8010453f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
      p = findProcess(&flag);
80104546:	57                   	push   %edi
80104547:	e8 64 fe ff ff       	call   801043b0 <findProcess>
      c->proc = p;
8010454c:	89 83 ac 00 00 00    	mov    %eax,0xac(%ebx)
      p = findProcess(&flag);
80104552:	89 c6                	mov    %eax,%esi
      switchuvm(p);
80104554:	89 04 24             	mov    %eax,(%esp)
80104557:	e8 a4 2e 00 00       	call   80107400 <switchuvm>
      p->cycles++;
8010455c:	83 86 84 00 00 00 01 	addl   $0x1,0x84(%esi)
      p->state = RUNNING;
80104563:	c7 46 0c 04 00 00 00 	movl   $0x4,0xc(%esi)
      p->wait_cycles = 0;
8010456a:	c7 86 8c 00 00 00 00 	movl   $0x0,0x8c(%esi)
80104571:	00 00 00 
      swtch(&(c->scheduler), p->context);
80104574:	58                   	pop    %eax
80104575:	5a                   	pop    %edx
80104576:	ff 76 1c             	pushl  0x1c(%esi)
80104579:	ff 75 d4             	pushl  -0x2c(%ebp)
8010457c:	e8 22 0c 00 00       	call   801051a3 <swtch>
      switchkvm();
80104581:	e8 5a 2e 00 00       	call   801073e0 <switchkvm>
      c->proc = 0;
80104586:	83 c4 10             	add    $0x10,%esp
80104589:	c7 83 ac 00 00 00 00 	movl   $0x0,0xac(%ebx)
80104590:	00 00 00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104593:	81 c6 90 00 00 00    	add    $0x90,%esi
80104599:	81 fe b4 5c 11 80    	cmp    $0x80115cb4,%esi
8010459f:	72 95                	jb     80104536 <scheduler+0x46>
    release(&ptable.lock);
801045a1:	83 ec 0c             	sub    $0xc,%esp
801045a4:	68 80 38 11 80       	push   $0x80113880
801045a9:	e8 82 09 00 00       	call   80104f30 <release>
    sti();
801045ae:	83 c4 10             	add    $0x10,%esp
801045b1:	e9 6a ff ff ff       	jmp    80104520 <scheduler+0x30>
801045b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801045bd:	8d 76 00             	lea    0x0(%esi),%esi

801045c0 <sched>:
{
801045c0:	f3 0f 1e fb          	endbr32 
801045c4:	55                   	push   %ebp
801045c5:	89 e5                	mov    %esp,%ebp
801045c7:	56                   	push   %esi
801045c8:	53                   	push   %ebx
  pushcli();
801045c9:	e8 a2 07 00 00       	call   80104d70 <pushcli>
  c = mycpu();
801045ce:	e8 3d f7 ff ff       	call   80103d10 <mycpu>
  p = c->proc;
801045d3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801045d9:	e8 e2 07 00 00       	call   80104dc0 <popcli>
  if(!holding(&ptable.lock))
801045de:	83 ec 0c             	sub    $0xc,%esp
801045e1:	68 80 38 11 80       	push   $0x80113880
801045e6:	e8 35 08 00 00       	call   80104e20 <holding>
801045eb:	83 c4 10             	add    $0x10,%esp
801045ee:	85 c0                	test   %eax,%eax
801045f0:	74 4f                	je     80104641 <sched+0x81>
  if(mycpu()->ncli != 1)
801045f2:	e8 19 f7 ff ff       	call   80103d10 <mycpu>
801045f7:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
801045fe:	75 68                	jne    80104668 <sched+0xa8>
  if(p->state == RUNNING)
80104600:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80104604:	74 55                	je     8010465b <sched+0x9b>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104606:	9c                   	pushf  
80104607:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104608:	f6 c4 02             	test   $0x2,%ah
8010460b:	75 41                	jne    8010464e <sched+0x8e>
  intena = mycpu()->intena;
8010460d:	e8 fe f6 ff ff       	call   80103d10 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80104612:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80104615:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
8010461b:	e8 f0 f6 ff ff       	call   80103d10 <mycpu>
80104620:	83 ec 08             	sub    $0x8,%esp
80104623:	ff 70 04             	pushl  0x4(%eax)
80104626:	53                   	push   %ebx
80104627:	e8 77 0b 00 00       	call   801051a3 <swtch>
  mycpu()->intena = intena;
8010462c:	e8 df f6 ff ff       	call   80103d10 <mycpu>
}
80104631:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80104634:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
8010463a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010463d:	5b                   	pop    %ebx
8010463e:	5e                   	pop    %esi
8010463f:	5d                   	pop    %ebp
80104640:	c3                   	ret    
    panic("sched ptable.lock");
80104641:	83 ec 0c             	sub    $0xc,%esp
80104644:	68 fc 80 10 80       	push   $0x801080fc
80104649:	e8 42 bd ff ff       	call   80100390 <panic>
    panic("sched interruptible");
8010464e:	83 ec 0c             	sub    $0xc,%esp
80104651:	68 28 81 10 80       	push   $0x80108128
80104656:	e8 35 bd ff ff       	call   80100390 <panic>
    panic("sched running");
8010465b:	83 ec 0c             	sub    $0xc,%esp
8010465e:	68 1a 81 10 80       	push   $0x8010811a
80104663:	e8 28 bd ff ff       	call   80100390 <panic>
    panic("sched locks");
80104668:	83 ec 0c             	sub    $0xc,%esp
8010466b:	68 0e 81 10 80       	push   $0x8010810e
80104670:	e8 1b bd ff ff       	call   80100390 <panic>
80104675:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010467c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104680 <exit>:
{
80104680:	f3 0f 1e fb          	endbr32 
80104684:	55                   	push   %ebp
80104685:	89 e5                	mov    %esp,%ebp
80104687:	57                   	push   %edi
80104688:	56                   	push   %esi
80104689:	53                   	push   %ebx
8010468a:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
8010468d:	e8 de 06 00 00       	call   80104d70 <pushcli>
  c = mycpu();
80104692:	e8 79 f6 ff ff       	call   80103d10 <mycpu>
  p = c->proc;
80104697:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
8010469d:	e8 1e 07 00 00       	call   80104dc0 <popcli>
  if(curproc == initproc)
801046a2:	8d 5e 28             	lea    0x28(%esi),%ebx
801046a5:	8d 7e 68             	lea    0x68(%esi),%edi
801046a8:	39 35 e0 b5 10 80    	cmp    %esi,0x8010b5e0
801046ae:	0f 84 fd 00 00 00    	je     801047b1 <exit+0x131>
801046b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd]){
801046b8:	8b 03                	mov    (%ebx),%eax
801046ba:	85 c0                	test   %eax,%eax
801046bc:	74 12                	je     801046d0 <exit+0x50>
      fileclose(curproc->ofile[fd]);
801046be:	83 ec 0c             	sub    $0xc,%esp
801046c1:	50                   	push   %eax
801046c2:	e8 d9 cb ff ff       	call   801012a0 <fileclose>
      curproc->ofile[fd] = 0;
801046c7:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801046cd:	83 c4 10             	add    $0x10,%esp
  for(fd = 0; fd < NOFILE; fd++){
801046d0:	83 c3 04             	add    $0x4,%ebx
801046d3:	39 df                	cmp    %ebx,%edi
801046d5:	75 e1                	jne    801046b8 <exit+0x38>
  begin_op();
801046d7:	e8 34 ea ff ff       	call   80103110 <begin_op>
  iput(curproc->cwd);
801046dc:	83 ec 0c             	sub    $0xc,%esp
801046df:	ff 76 68             	pushl  0x68(%esi)
801046e2:	e8 89 d5 ff ff       	call   80101c70 <iput>
  end_op();
801046e7:	e8 94 ea ff ff       	call   80103180 <end_op>
  curproc->cwd = 0;
801046ec:	c7 46 68 00 00 00 00 	movl   $0x0,0x68(%esi)
  acquire(&ptable.lock);
801046f3:	c7 04 24 80 38 11 80 	movl   $0x80113880,(%esp)
801046fa:	e8 71 07 00 00       	call   80104e70 <acquire>
  wakeup1(curproc->parent);
801046ff:	8b 56 14             	mov    0x14(%esi),%edx
80104702:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104705:	b8 b4 38 11 80       	mov    $0x801138b4,%eax
8010470a:	eb 10                	jmp    8010471c <exit+0x9c>
8010470c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104710:	05 90 00 00 00       	add    $0x90,%eax
80104715:	3d b4 5c 11 80       	cmp    $0x80115cb4,%eax
8010471a:	74 1e                	je     8010473a <exit+0xba>
    if(p->state == SLEEPING && p->chan == chan)
8010471c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104720:	75 ee                	jne    80104710 <exit+0x90>
80104722:	3b 50 20             	cmp    0x20(%eax),%edx
80104725:	75 e9                	jne    80104710 <exit+0x90>
      p->state = RUNNABLE;
80104727:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010472e:	05 90 00 00 00       	add    $0x90,%eax
80104733:	3d b4 5c 11 80       	cmp    $0x80115cb4,%eax
80104738:	75 e2                	jne    8010471c <exit+0x9c>
      p->parent = initproc;
8010473a:	8b 0d e0 b5 10 80    	mov    0x8010b5e0,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104740:	ba b4 38 11 80       	mov    $0x801138b4,%edx
80104745:	eb 17                	jmp    8010475e <exit+0xde>
80104747:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010474e:	66 90                	xchg   %ax,%ax
80104750:	81 c2 90 00 00 00    	add    $0x90,%edx
80104756:	81 fa b4 5c 11 80    	cmp    $0x80115cb4,%edx
8010475c:	74 3a                	je     80104798 <exit+0x118>
    if(p->parent == curproc){
8010475e:	39 72 14             	cmp    %esi,0x14(%edx)
80104761:	75 ed                	jne    80104750 <exit+0xd0>
      if(p->state == ZOMBIE)
80104763:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80104767:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
8010476a:	75 e4                	jne    80104750 <exit+0xd0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010476c:	b8 b4 38 11 80       	mov    $0x801138b4,%eax
80104771:	eb 11                	jmp    80104784 <exit+0x104>
80104773:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104777:	90                   	nop
80104778:	05 90 00 00 00       	add    $0x90,%eax
8010477d:	3d b4 5c 11 80       	cmp    $0x80115cb4,%eax
80104782:	74 cc                	je     80104750 <exit+0xd0>
    if(p->state == SLEEPING && p->chan == chan)
80104784:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104788:	75 ee                	jne    80104778 <exit+0xf8>
8010478a:	3b 48 20             	cmp    0x20(%eax),%ecx
8010478d:	75 e9                	jne    80104778 <exit+0xf8>
      p->state = RUNNABLE;
8010478f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80104796:	eb e0                	jmp    80104778 <exit+0xf8>
  curproc->state = ZOMBIE;
80104798:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
8010479f:	e8 1c fe ff ff       	call   801045c0 <sched>
  panic("zombie exit");
801047a4:	83 ec 0c             	sub    $0xc,%esp
801047a7:	68 49 81 10 80       	push   $0x80108149
801047ac:	e8 df bb ff ff       	call   80100390 <panic>
    panic("init exiting");
801047b1:	83 ec 0c             	sub    $0xc,%esp
801047b4:	68 3c 81 10 80       	push   $0x8010813c
801047b9:	e8 d2 bb ff ff       	call   80100390 <panic>
801047be:	66 90                	xchg   %ax,%ax

801047c0 <yield>:
{
801047c0:	f3 0f 1e fb          	endbr32 
801047c4:	55                   	push   %ebp
801047c5:	89 e5                	mov    %esp,%ebp
801047c7:	53                   	push   %ebx
801047c8:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
801047cb:	68 80 38 11 80       	push   $0x80113880
801047d0:	e8 9b 06 00 00       	call   80104e70 <acquire>
  pushcli();
801047d5:	e8 96 05 00 00       	call   80104d70 <pushcli>
  c = mycpu();
801047da:	e8 31 f5 ff ff       	call   80103d10 <mycpu>
  p = c->proc;
801047df:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801047e5:	e8 d6 05 00 00       	call   80104dc0 <popcli>
  myproc()->state = RUNNABLE;
801047ea:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
801047f1:	e8 ca fd ff ff       	call   801045c0 <sched>
  release(&ptable.lock);
801047f6:	c7 04 24 80 38 11 80 	movl   $0x80113880,(%esp)
801047fd:	e8 2e 07 00 00       	call   80104f30 <release>
}
80104802:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104805:	83 c4 10             	add    $0x10,%esp
80104808:	c9                   	leave  
80104809:	c3                   	ret    
8010480a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104810 <sleep>:
{
80104810:	f3 0f 1e fb          	endbr32 
80104814:	55                   	push   %ebp
80104815:	89 e5                	mov    %esp,%ebp
80104817:	57                   	push   %edi
80104818:	56                   	push   %esi
80104819:	53                   	push   %ebx
8010481a:	83 ec 0c             	sub    $0xc,%esp
8010481d:	8b 7d 08             	mov    0x8(%ebp),%edi
80104820:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
80104823:	e8 48 05 00 00       	call   80104d70 <pushcli>
  c = mycpu();
80104828:	e8 e3 f4 ff ff       	call   80103d10 <mycpu>
  p = c->proc;
8010482d:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104833:	e8 88 05 00 00       	call   80104dc0 <popcli>
  if(p == 0)
80104838:	85 db                	test   %ebx,%ebx
8010483a:	0f 84 83 00 00 00    	je     801048c3 <sleep+0xb3>
  if(lk == 0)
80104840:	85 f6                	test   %esi,%esi
80104842:	74 72                	je     801048b6 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104844:	81 fe 80 38 11 80    	cmp    $0x80113880,%esi
8010484a:	74 4c                	je     80104898 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
8010484c:	83 ec 0c             	sub    $0xc,%esp
8010484f:	68 80 38 11 80       	push   $0x80113880
80104854:	e8 17 06 00 00       	call   80104e70 <acquire>
    release(lk);
80104859:	89 34 24             	mov    %esi,(%esp)
8010485c:	e8 cf 06 00 00       	call   80104f30 <release>
  p->chan = chan;
80104861:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104864:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
8010486b:	e8 50 fd ff ff       	call   801045c0 <sched>
  p->chan = 0;
80104870:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80104877:	c7 04 24 80 38 11 80 	movl   $0x80113880,(%esp)
8010487e:	e8 ad 06 00 00       	call   80104f30 <release>
    acquire(lk);
80104883:	89 75 08             	mov    %esi,0x8(%ebp)
80104886:	83 c4 10             	add    $0x10,%esp
}
80104889:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010488c:	5b                   	pop    %ebx
8010488d:	5e                   	pop    %esi
8010488e:	5f                   	pop    %edi
8010488f:	5d                   	pop    %ebp
    acquire(lk);
80104890:	e9 db 05 00 00       	jmp    80104e70 <acquire>
80104895:	8d 76 00             	lea    0x0(%esi),%esi
  p->chan = chan;
80104898:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
8010489b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801048a2:	e8 19 fd ff ff       	call   801045c0 <sched>
  p->chan = 0;
801048a7:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
801048ae:	8d 65 f4             	lea    -0xc(%ebp),%esp
801048b1:	5b                   	pop    %ebx
801048b2:	5e                   	pop    %esi
801048b3:	5f                   	pop    %edi
801048b4:	5d                   	pop    %ebp
801048b5:	c3                   	ret    
    panic("sleep without lk");
801048b6:	83 ec 0c             	sub    $0xc,%esp
801048b9:	68 5b 81 10 80       	push   $0x8010815b
801048be:	e8 cd ba ff ff       	call   80100390 <panic>
    panic("sleep");
801048c3:	83 ec 0c             	sub    $0xc,%esp
801048c6:	68 55 81 10 80       	push   $0x80108155
801048cb:	e8 c0 ba ff ff       	call   80100390 <panic>

801048d0 <wait>:
{
801048d0:	f3 0f 1e fb          	endbr32 
801048d4:	55                   	push   %ebp
801048d5:	89 e5                	mov    %esp,%ebp
801048d7:	56                   	push   %esi
801048d8:	53                   	push   %ebx
  pushcli();
801048d9:	e8 92 04 00 00       	call   80104d70 <pushcli>
  c = mycpu();
801048de:	e8 2d f4 ff ff       	call   80103d10 <mycpu>
  p = c->proc;
801048e3:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801048e9:	e8 d2 04 00 00       	call   80104dc0 <popcli>
  acquire(&ptable.lock);
801048ee:	83 ec 0c             	sub    $0xc,%esp
801048f1:	68 80 38 11 80       	push   $0x80113880
801048f6:	e8 75 05 00 00       	call   80104e70 <acquire>
801048fb:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
801048fe:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104900:	bb b4 38 11 80       	mov    $0x801138b4,%ebx
80104905:	eb 17                	jmp    8010491e <wait+0x4e>
80104907:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010490e:	66 90                	xchg   %ax,%ax
80104910:	81 c3 90 00 00 00    	add    $0x90,%ebx
80104916:	81 fb b4 5c 11 80    	cmp    $0x80115cb4,%ebx
8010491c:	74 1e                	je     8010493c <wait+0x6c>
      if(p->parent != curproc)
8010491e:	39 73 14             	cmp    %esi,0x14(%ebx)
80104921:	75 ed                	jne    80104910 <wait+0x40>
      if(p->state == ZOMBIE){
80104923:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80104927:	74 37                	je     80104960 <wait+0x90>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104929:	81 c3 90 00 00 00    	add    $0x90,%ebx
      havekids = 1;
8010492f:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104934:	81 fb b4 5c 11 80    	cmp    $0x80115cb4,%ebx
8010493a:	75 e2                	jne    8010491e <wait+0x4e>
    if(!havekids || curproc->killed){
8010493c:	85 c0                	test   %eax,%eax
8010493e:	74 76                	je     801049b6 <wait+0xe6>
80104940:	8b 46 24             	mov    0x24(%esi),%eax
80104943:	85 c0                	test   %eax,%eax
80104945:	75 6f                	jne    801049b6 <wait+0xe6>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80104947:	83 ec 08             	sub    $0x8,%esp
8010494a:	68 80 38 11 80       	push   $0x80113880
8010494f:	56                   	push   %esi
80104950:	e8 bb fe ff ff       	call   80104810 <sleep>
    havekids = 0;
80104955:	83 c4 10             	add    $0x10,%esp
80104958:	eb a4                	jmp    801048fe <wait+0x2e>
8010495a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        kfree(p->kstack);
80104960:	83 ec 0c             	sub    $0xc,%esp
80104963:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
80104966:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104969:	e8 e2 de ff ff       	call   80102850 <kfree>
        freevm(p->pgdir);
8010496e:	5a                   	pop    %edx
8010496f:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
80104972:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104979:	e8 42 2e 00 00       	call   801077c0 <freevm>
        release(&ptable.lock);
8010497e:	c7 04 24 80 38 11 80 	movl   $0x80113880,(%esp)
        p->pid = 0;
80104985:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
8010498c:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80104993:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80104997:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
8010499e:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
801049a5:	e8 86 05 00 00       	call   80104f30 <release>
        return pid;
801049aa:	83 c4 10             	add    $0x10,%esp
}
801049ad:	8d 65 f8             	lea    -0x8(%ebp),%esp
801049b0:	89 f0                	mov    %esi,%eax
801049b2:	5b                   	pop    %ebx
801049b3:	5e                   	pop    %esi
801049b4:	5d                   	pop    %ebp
801049b5:	c3                   	ret    
      release(&ptable.lock);
801049b6:	83 ec 0c             	sub    $0xc,%esp
      return -1;
801049b9:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
801049be:	68 80 38 11 80       	push   $0x80113880
801049c3:	e8 68 05 00 00       	call   80104f30 <release>
      return -1;
801049c8:	83 c4 10             	add    $0x10,%esp
801049cb:	eb e0                	jmp    801049ad <wait+0xdd>
801049cd:	8d 76 00             	lea    0x0(%esi),%esi

801049d0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
801049d0:	f3 0f 1e fb          	endbr32 
801049d4:	55                   	push   %ebp
801049d5:	89 e5                	mov    %esp,%ebp
801049d7:	53                   	push   %ebx
801049d8:	83 ec 10             	sub    $0x10,%esp
801049db:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
801049de:	68 80 38 11 80       	push   $0x80113880
801049e3:	e8 88 04 00 00       	call   80104e70 <acquire>
801049e8:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801049eb:	b8 b4 38 11 80       	mov    $0x801138b4,%eax
801049f0:	eb 12                	jmp    80104a04 <wakeup+0x34>
801049f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801049f8:	05 90 00 00 00       	add    $0x90,%eax
801049fd:	3d b4 5c 11 80       	cmp    $0x80115cb4,%eax
80104a02:	74 1e                	je     80104a22 <wakeup+0x52>
    if(p->state == SLEEPING && p->chan == chan)
80104a04:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104a08:	75 ee                	jne    801049f8 <wakeup+0x28>
80104a0a:	3b 58 20             	cmp    0x20(%eax),%ebx
80104a0d:	75 e9                	jne    801049f8 <wakeup+0x28>
      p->state = RUNNABLE;
80104a0f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104a16:	05 90 00 00 00       	add    $0x90,%eax
80104a1b:	3d b4 5c 11 80       	cmp    $0x80115cb4,%eax
80104a20:	75 e2                	jne    80104a04 <wakeup+0x34>
  wakeup1(chan);
  release(&ptable.lock);
80104a22:	c7 45 08 80 38 11 80 	movl   $0x80113880,0x8(%ebp)
}
80104a29:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a2c:	c9                   	leave  
  release(&ptable.lock);
80104a2d:	e9 fe 04 00 00       	jmp    80104f30 <release>
80104a32:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104a40 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104a40:	f3 0f 1e fb          	endbr32 
80104a44:	55                   	push   %ebp
80104a45:	89 e5                	mov    %esp,%ebp
80104a47:	53                   	push   %ebx
80104a48:	83 ec 10             	sub    $0x10,%esp
80104a4b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
80104a4e:	68 80 38 11 80       	push   $0x80113880
80104a53:	e8 18 04 00 00       	call   80104e70 <acquire>
80104a58:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a5b:	b8 b4 38 11 80       	mov    $0x801138b4,%eax
80104a60:	eb 12                	jmp    80104a74 <kill+0x34>
80104a62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104a68:	05 90 00 00 00       	add    $0x90,%eax
80104a6d:	3d b4 5c 11 80       	cmp    $0x80115cb4,%eax
80104a72:	74 34                	je     80104aa8 <kill+0x68>
    if(p->pid == pid){
80104a74:	39 58 10             	cmp    %ebx,0x10(%eax)
80104a77:	75 ef                	jne    80104a68 <kill+0x28>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104a79:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104a7d:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
80104a84:	75 07                	jne    80104a8d <kill+0x4d>
        p->state = RUNNABLE;
80104a86:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104a8d:	83 ec 0c             	sub    $0xc,%esp
80104a90:	68 80 38 11 80       	push   $0x80113880
80104a95:	e8 96 04 00 00       	call   80104f30 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
80104a9a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
80104a9d:	83 c4 10             	add    $0x10,%esp
80104aa0:	31 c0                	xor    %eax,%eax
}
80104aa2:	c9                   	leave  
80104aa3:	c3                   	ret    
80104aa4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80104aa8:	83 ec 0c             	sub    $0xc,%esp
80104aab:	68 80 38 11 80       	push   $0x80113880
80104ab0:	e8 7b 04 00 00       	call   80104f30 <release>
}
80104ab5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80104ab8:	83 c4 10             	add    $0x10,%esp
80104abb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104ac0:	c9                   	leave  
80104ac1:	c3                   	ret    
80104ac2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ac9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104ad0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104ad0:	f3 0f 1e fb          	endbr32 
80104ad4:	55                   	push   %ebp
80104ad5:	89 e5                	mov    %esp,%ebp
80104ad7:	57                   	push   %edi
80104ad8:	56                   	push   %esi
80104ad9:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104adc:	53                   	push   %ebx
80104add:	bb 20 39 11 80       	mov    $0x80113920,%ebx
80104ae2:	83 ec 3c             	sub    $0x3c,%esp
80104ae5:	eb 2b                	jmp    80104b12 <procdump+0x42>
80104ae7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104aee:	66 90                	xchg   %ax,%ax
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104af0:	83 ec 0c             	sub    $0xc,%esp
80104af3:	68 47 85 10 80       	push   $0x80108547
80104af8:	e8 b3 bb ff ff       	call   801006b0 <cprintf>
80104afd:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104b00:	81 c3 90 00 00 00    	add    $0x90,%ebx
80104b06:	81 fb 20 5d 11 80    	cmp    $0x80115d20,%ebx
80104b0c:	0f 84 8e 00 00 00    	je     80104ba0 <procdump+0xd0>
    if(p->state == UNUSED)
80104b12:	8b 43 a0             	mov    -0x60(%ebx),%eax
80104b15:	85 c0                	test   %eax,%eax
80104b17:	74 e7                	je     80104b00 <procdump+0x30>
      state = "???";
80104b19:	ba 6c 81 10 80       	mov    $0x8010816c,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104b1e:	83 f8 05             	cmp    $0x5,%eax
80104b21:	77 11                	ja     80104b34 <procdump+0x64>
80104b23:	8b 14 85 1c 82 10 80 	mov    -0x7fef7de4(,%eax,4),%edx
      state = "???";
80104b2a:	b8 6c 81 10 80       	mov    $0x8010816c,%eax
80104b2f:	85 d2                	test   %edx,%edx
80104b31:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104b34:	53                   	push   %ebx
80104b35:	52                   	push   %edx
80104b36:	ff 73 a4             	pushl  -0x5c(%ebx)
80104b39:	68 70 81 10 80       	push   $0x80108170
80104b3e:	e8 6d bb ff ff       	call   801006b0 <cprintf>
    if(p->state == SLEEPING){
80104b43:	83 c4 10             	add    $0x10,%esp
80104b46:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
80104b4a:	75 a4                	jne    80104af0 <procdump+0x20>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104b4c:	83 ec 08             	sub    $0x8,%esp
80104b4f:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104b52:	8d 7d c0             	lea    -0x40(%ebp),%edi
80104b55:	50                   	push   %eax
80104b56:	8b 43 b0             	mov    -0x50(%ebx),%eax
80104b59:	8b 40 0c             	mov    0xc(%eax),%eax
80104b5c:	83 c0 08             	add    $0x8,%eax
80104b5f:	50                   	push   %eax
80104b60:	e8 ab 01 00 00       	call   80104d10 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
80104b65:	83 c4 10             	add    $0x10,%esp
80104b68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b6f:	90                   	nop
80104b70:	8b 17                	mov    (%edi),%edx
80104b72:	85 d2                	test   %edx,%edx
80104b74:	0f 84 76 ff ff ff    	je     80104af0 <procdump+0x20>
        cprintf(" %p", pc[i]);
80104b7a:	83 ec 08             	sub    $0x8,%esp
80104b7d:	83 c7 04             	add    $0x4,%edi
80104b80:	52                   	push   %edx
80104b81:	68 21 7b 10 80       	push   $0x80107b21
80104b86:	e8 25 bb ff ff       	call   801006b0 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104b8b:	83 c4 10             	add    $0x10,%esp
80104b8e:	39 fe                	cmp    %edi,%esi
80104b90:	75 de                	jne    80104b70 <procdump+0xa0>
80104b92:	e9 59 ff ff ff       	jmp    80104af0 <procdump+0x20>
80104b97:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b9e:	66 90                	xchg   %ax,%ax
  }
80104ba0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104ba3:	5b                   	pop    %ebx
80104ba4:	5e                   	pop    %esi
80104ba5:	5f                   	pop    %edi
80104ba6:	5d                   	pop    %ebp
80104ba7:	c3                   	ret    
80104ba8:	66 90                	xchg   %ax,%ax
80104baa:	66 90                	xchg   %ax,%ax
80104bac:	66 90                	xchg   %ax,%ax
80104bae:	66 90                	xchg   %ax,%ax

80104bb0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104bb0:	f3 0f 1e fb          	endbr32 
80104bb4:	55                   	push   %ebp
80104bb5:	89 e5                	mov    %esp,%ebp
80104bb7:	53                   	push   %ebx
80104bb8:	83 ec 0c             	sub    $0xc,%esp
80104bbb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
80104bbe:	68 34 82 10 80       	push   $0x80108234
80104bc3:	8d 43 04             	lea    0x4(%ebx),%eax
80104bc6:	50                   	push   %eax
80104bc7:	e8 24 01 00 00       	call   80104cf0 <initlock>
  lk->name = name;
80104bcc:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
80104bcf:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104bd5:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104bd8:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
80104bdf:	89 43 38             	mov    %eax,0x38(%ebx)
}
80104be2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104be5:	c9                   	leave  
80104be6:	c3                   	ret    
80104be7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104bee:	66 90                	xchg   %ax,%ax

80104bf0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104bf0:	f3 0f 1e fb          	endbr32 
80104bf4:	55                   	push   %ebp
80104bf5:	89 e5                	mov    %esp,%ebp
80104bf7:	56                   	push   %esi
80104bf8:	53                   	push   %ebx
80104bf9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104bfc:	8d 73 04             	lea    0x4(%ebx),%esi
80104bff:	83 ec 0c             	sub    $0xc,%esp
80104c02:	56                   	push   %esi
80104c03:	e8 68 02 00 00       	call   80104e70 <acquire>
  while (lk->locked) {
80104c08:	8b 13                	mov    (%ebx),%edx
80104c0a:	83 c4 10             	add    $0x10,%esp
80104c0d:	85 d2                	test   %edx,%edx
80104c0f:	74 1a                	je     80104c2b <acquiresleep+0x3b>
80104c11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(lk, &lk->lk);
80104c18:	83 ec 08             	sub    $0x8,%esp
80104c1b:	56                   	push   %esi
80104c1c:	53                   	push   %ebx
80104c1d:	e8 ee fb ff ff       	call   80104810 <sleep>
  while (lk->locked) {
80104c22:	8b 03                	mov    (%ebx),%eax
80104c24:	83 c4 10             	add    $0x10,%esp
80104c27:	85 c0                	test   %eax,%eax
80104c29:	75 ed                	jne    80104c18 <acquiresleep+0x28>
  }
  lk->locked = 1;
80104c2b:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104c31:	e8 5a f1 ff ff       	call   80103d90 <myproc>
80104c36:	8b 40 10             	mov    0x10(%eax),%eax
80104c39:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104c3c:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104c3f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104c42:	5b                   	pop    %ebx
80104c43:	5e                   	pop    %esi
80104c44:	5d                   	pop    %ebp
  release(&lk->lk);
80104c45:	e9 e6 02 00 00       	jmp    80104f30 <release>
80104c4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104c50 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104c50:	f3 0f 1e fb          	endbr32 
80104c54:	55                   	push   %ebp
80104c55:	89 e5                	mov    %esp,%ebp
80104c57:	56                   	push   %esi
80104c58:	53                   	push   %ebx
80104c59:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104c5c:	8d 73 04             	lea    0x4(%ebx),%esi
80104c5f:	83 ec 0c             	sub    $0xc,%esp
80104c62:	56                   	push   %esi
80104c63:	e8 08 02 00 00       	call   80104e70 <acquire>
  lk->locked = 0;
80104c68:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80104c6e:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104c75:	89 1c 24             	mov    %ebx,(%esp)
80104c78:	e8 53 fd ff ff       	call   801049d0 <wakeup>
  release(&lk->lk);
80104c7d:	89 75 08             	mov    %esi,0x8(%ebp)
80104c80:	83 c4 10             	add    $0x10,%esp
}
80104c83:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104c86:	5b                   	pop    %ebx
80104c87:	5e                   	pop    %esi
80104c88:	5d                   	pop    %ebp
  release(&lk->lk);
80104c89:	e9 a2 02 00 00       	jmp    80104f30 <release>
80104c8e:	66 90                	xchg   %ax,%ax

80104c90 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104c90:	f3 0f 1e fb          	endbr32 
80104c94:	55                   	push   %ebp
80104c95:	89 e5                	mov    %esp,%ebp
80104c97:	57                   	push   %edi
80104c98:	31 ff                	xor    %edi,%edi
80104c9a:	56                   	push   %esi
80104c9b:	53                   	push   %ebx
80104c9c:	83 ec 18             	sub    $0x18,%esp
80104c9f:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
80104ca2:	8d 73 04             	lea    0x4(%ebx),%esi
80104ca5:	56                   	push   %esi
80104ca6:	e8 c5 01 00 00       	call   80104e70 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104cab:	8b 03                	mov    (%ebx),%eax
80104cad:	83 c4 10             	add    $0x10,%esp
80104cb0:	85 c0                	test   %eax,%eax
80104cb2:	75 1c                	jne    80104cd0 <holdingsleep+0x40>
  release(&lk->lk);
80104cb4:	83 ec 0c             	sub    $0xc,%esp
80104cb7:	56                   	push   %esi
80104cb8:	e8 73 02 00 00       	call   80104f30 <release>
  return r;
}
80104cbd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104cc0:	89 f8                	mov    %edi,%eax
80104cc2:	5b                   	pop    %ebx
80104cc3:	5e                   	pop    %esi
80104cc4:	5f                   	pop    %edi
80104cc5:	5d                   	pop    %ebp
80104cc6:	c3                   	ret    
80104cc7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104cce:	66 90                	xchg   %ax,%ax
  r = lk->locked && (lk->pid == myproc()->pid);
80104cd0:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104cd3:	e8 b8 f0 ff ff       	call   80103d90 <myproc>
80104cd8:	39 58 10             	cmp    %ebx,0x10(%eax)
80104cdb:	0f 94 c0             	sete   %al
80104cde:	0f b6 c0             	movzbl %al,%eax
80104ce1:	89 c7                	mov    %eax,%edi
80104ce3:	eb cf                	jmp    80104cb4 <holdingsleep+0x24>
80104ce5:	66 90                	xchg   %ax,%ax
80104ce7:	66 90                	xchg   %ax,%ax
80104ce9:	66 90                	xchg   %ax,%ax
80104ceb:	66 90                	xchg   %ax,%ax
80104ced:	66 90                	xchg   %ax,%ax
80104cef:	90                   	nop

80104cf0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104cf0:	f3 0f 1e fb          	endbr32 
80104cf4:	55                   	push   %ebp
80104cf5:	89 e5                	mov    %esp,%ebp
80104cf7:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104cfa:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104cfd:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
80104d03:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104d06:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104d0d:	5d                   	pop    %ebp
80104d0e:	c3                   	ret    
80104d0f:	90                   	nop

80104d10 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104d10:	f3 0f 1e fb          	endbr32 
80104d14:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104d15:	31 d2                	xor    %edx,%edx
{
80104d17:	89 e5                	mov    %esp,%ebp
80104d19:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104d1a:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104d1d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
80104d20:	83 e8 08             	sub    $0x8,%eax
  for(i = 0; i < 10; i++){
80104d23:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104d27:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104d28:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104d2e:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104d34:	77 1a                	ja     80104d50 <getcallerpcs+0x40>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104d36:	8b 58 04             	mov    0x4(%eax),%ebx
80104d39:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104d3c:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104d3f:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104d41:	83 fa 0a             	cmp    $0xa,%edx
80104d44:	75 e2                	jne    80104d28 <getcallerpcs+0x18>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
80104d46:	5b                   	pop    %ebx
80104d47:	5d                   	pop    %ebp
80104d48:	c3                   	ret    
80104d49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(; i < 10; i++)
80104d50:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80104d53:	8d 51 28             	lea    0x28(%ecx),%edx
80104d56:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d5d:	8d 76 00             	lea    0x0(%esi),%esi
    pcs[i] = 0;
80104d60:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104d66:	83 c0 04             	add    $0x4,%eax
80104d69:	39 d0                	cmp    %edx,%eax
80104d6b:	75 f3                	jne    80104d60 <getcallerpcs+0x50>
}
80104d6d:	5b                   	pop    %ebx
80104d6e:	5d                   	pop    %ebp
80104d6f:	c3                   	ret    

80104d70 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104d70:	f3 0f 1e fb          	endbr32 
80104d74:	55                   	push   %ebp
80104d75:	89 e5                	mov    %esp,%ebp
80104d77:	53                   	push   %ebx
80104d78:	83 ec 04             	sub    $0x4,%esp
80104d7b:	9c                   	pushf  
80104d7c:	5b                   	pop    %ebx
  asm volatile("cli");
80104d7d:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
80104d7e:	e8 8d ef ff ff       	call   80103d10 <mycpu>
80104d83:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104d89:	85 c0                	test   %eax,%eax
80104d8b:	74 13                	je     80104da0 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
80104d8d:	e8 7e ef ff ff       	call   80103d10 <mycpu>
80104d92:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104d99:	83 c4 04             	add    $0x4,%esp
80104d9c:	5b                   	pop    %ebx
80104d9d:	5d                   	pop    %ebp
80104d9e:	c3                   	ret    
80104d9f:	90                   	nop
    mycpu()->intena = eflags & FL_IF;
80104da0:	e8 6b ef ff ff       	call   80103d10 <mycpu>
80104da5:	81 e3 00 02 00 00    	and    $0x200,%ebx
80104dab:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80104db1:	eb da                	jmp    80104d8d <pushcli+0x1d>
80104db3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104dba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104dc0 <popcli>:

void
popcli(void)
{
80104dc0:	f3 0f 1e fb          	endbr32 
80104dc4:	55                   	push   %ebp
80104dc5:	89 e5                	mov    %esp,%ebp
80104dc7:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104dca:	9c                   	pushf  
80104dcb:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104dcc:	f6 c4 02             	test   $0x2,%ah
80104dcf:	75 31                	jne    80104e02 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
80104dd1:	e8 3a ef ff ff       	call   80103d10 <mycpu>
80104dd6:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104ddd:	78 30                	js     80104e0f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104ddf:	e8 2c ef ff ff       	call   80103d10 <mycpu>
80104de4:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104dea:	85 d2                	test   %edx,%edx
80104dec:	74 02                	je     80104df0 <popcli+0x30>
    sti();
}
80104dee:	c9                   	leave  
80104def:	c3                   	ret    
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104df0:	e8 1b ef ff ff       	call   80103d10 <mycpu>
80104df5:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80104dfb:	85 c0                	test   %eax,%eax
80104dfd:	74 ef                	je     80104dee <popcli+0x2e>
  asm volatile("sti");
80104dff:	fb                   	sti    
}
80104e00:	c9                   	leave  
80104e01:	c3                   	ret    
    panic("popcli - interruptible");
80104e02:	83 ec 0c             	sub    $0xc,%esp
80104e05:	68 3f 82 10 80       	push   $0x8010823f
80104e0a:	e8 81 b5 ff ff       	call   80100390 <panic>
    panic("popcli");
80104e0f:	83 ec 0c             	sub    $0xc,%esp
80104e12:	68 56 82 10 80       	push   $0x80108256
80104e17:	e8 74 b5 ff ff       	call   80100390 <panic>
80104e1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104e20 <holding>:
{
80104e20:	f3 0f 1e fb          	endbr32 
80104e24:	55                   	push   %ebp
80104e25:	89 e5                	mov    %esp,%ebp
80104e27:	56                   	push   %esi
80104e28:	53                   	push   %ebx
80104e29:	8b 75 08             	mov    0x8(%ebp),%esi
80104e2c:	31 db                	xor    %ebx,%ebx
  pushcli();
80104e2e:	e8 3d ff ff ff       	call   80104d70 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104e33:	8b 06                	mov    (%esi),%eax
80104e35:	85 c0                	test   %eax,%eax
80104e37:	75 0f                	jne    80104e48 <holding+0x28>
  popcli();
80104e39:	e8 82 ff ff ff       	call   80104dc0 <popcli>
}
80104e3e:	89 d8                	mov    %ebx,%eax
80104e40:	5b                   	pop    %ebx
80104e41:	5e                   	pop    %esi
80104e42:	5d                   	pop    %ebp
80104e43:	c3                   	ret    
80104e44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  r = lock->locked && lock->cpu == mycpu();
80104e48:	8b 5e 08             	mov    0x8(%esi),%ebx
80104e4b:	e8 c0 ee ff ff       	call   80103d10 <mycpu>
80104e50:	39 c3                	cmp    %eax,%ebx
80104e52:	0f 94 c3             	sete   %bl
  popcli();
80104e55:	e8 66 ff ff ff       	call   80104dc0 <popcli>
  r = lock->locked && lock->cpu == mycpu();
80104e5a:	0f b6 db             	movzbl %bl,%ebx
}
80104e5d:	89 d8                	mov    %ebx,%eax
80104e5f:	5b                   	pop    %ebx
80104e60:	5e                   	pop    %esi
80104e61:	5d                   	pop    %ebp
80104e62:	c3                   	ret    
80104e63:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104e70 <acquire>:
{
80104e70:	f3 0f 1e fb          	endbr32 
80104e74:	55                   	push   %ebp
80104e75:	89 e5                	mov    %esp,%ebp
80104e77:	56                   	push   %esi
80104e78:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
80104e79:	e8 f2 fe ff ff       	call   80104d70 <pushcli>
  if(holding(lk))
80104e7e:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104e81:	83 ec 0c             	sub    $0xc,%esp
80104e84:	53                   	push   %ebx
80104e85:	e8 96 ff ff ff       	call   80104e20 <holding>
80104e8a:	83 c4 10             	add    $0x10,%esp
80104e8d:	85 c0                	test   %eax,%eax
80104e8f:	0f 85 7f 00 00 00    	jne    80104f14 <acquire+0xa4>
80104e95:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
80104e97:	ba 01 00 00 00       	mov    $0x1,%edx
80104e9c:	eb 05                	jmp    80104ea3 <acquire+0x33>
80104e9e:	66 90                	xchg   %ax,%ax
80104ea0:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104ea3:	89 d0                	mov    %edx,%eax
80104ea5:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
80104ea8:	85 c0                	test   %eax,%eax
80104eaa:	75 f4                	jne    80104ea0 <acquire+0x30>
  __sync_synchronize();
80104eac:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104eb1:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104eb4:	e8 57 ee ff ff       	call   80103d10 <mycpu>
80104eb9:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
80104ebc:	89 e8                	mov    %ebp,%eax
80104ebe:	66 90                	xchg   %ax,%ax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104ec0:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
80104ec6:	81 fa fe ff ff 7f    	cmp    $0x7ffffffe,%edx
80104ecc:	77 22                	ja     80104ef0 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
80104ece:	8b 50 04             	mov    0x4(%eax),%edx
80104ed1:	89 54 b3 0c          	mov    %edx,0xc(%ebx,%esi,4)
  for(i = 0; i < 10; i++){
80104ed5:	83 c6 01             	add    $0x1,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
80104ed8:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104eda:	83 fe 0a             	cmp    $0xa,%esi
80104edd:	75 e1                	jne    80104ec0 <acquire+0x50>
}
80104edf:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104ee2:	5b                   	pop    %ebx
80104ee3:	5e                   	pop    %esi
80104ee4:	5d                   	pop    %ebp
80104ee5:	c3                   	ret    
80104ee6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104eed:	8d 76 00             	lea    0x0(%esi),%esi
  for(; i < 10; i++)
80104ef0:	8d 44 b3 0c          	lea    0xc(%ebx,%esi,4),%eax
80104ef4:	83 c3 34             	add    $0x34,%ebx
80104ef7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104efe:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104f00:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104f06:	83 c0 04             	add    $0x4,%eax
80104f09:	39 d8                	cmp    %ebx,%eax
80104f0b:	75 f3                	jne    80104f00 <acquire+0x90>
}
80104f0d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104f10:	5b                   	pop    %ebx
80104f11:	5e                   	pop    %esi
80104f12:	5d                   	pop    %ebp
80104f13:	c3                   	ret    
    panic("acquire");
80104f14:	83 ec 0c             	sub    $0xc,%esp
80104f17:	68 5d 82 10 80       	push   $0x8010825d
80104f1c:	e8 6f b4 ff ff       	call   80100390 <panic>
80104f21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f28:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f2f:	90                   	nop

80104f30 <release>:
{
80104f30:	f3 0f 1e fb          	endbr32 
80104f34:	55                   	push   %ebp
80104f35:	89 e5                	mov    %esp,%ebp
80104f37:	53                   	push   %ebx
80104f38:	83 ec 10             	sub    $0x10,%esp
80104f3b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
80104f3e:	53                   	push   %ebx
80104f3f:	e8 dc fe ff ff       	call   80104e20 <holding>
80104f44:	83 c4 10             	add    $0x10,%esp
80104f47:	85 c0                	test   %eax,%eax
80104f49:	74 22                	je     80104f6d <release+0x3d>
  lk->pcs[0] = 0;
80104f4b:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80104f52:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104f59:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80104f5e:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104f64:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104f67:	c9                   	leave  
  popcli();
80104f68:	e9 53 fe ff ff       	jmp    80104dc0 <popcli>
    panic("release");
80104f6d:	83 ec 0c             	sub    $0xc,%esp
80104f70:	68 65 82 10 80       	push   $0x80108265
80104f75:	e8 16 b4 ff ff       	call   80100390 <panic>
80104f7a:	66 90                	xchg   %ax,%ax
80104f7c:	66 90                	xchg   %ax,%ax
80104f7e:	66 90                	xchg   %ax,%ax

80104f80 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104f80:	f3 0f 1e fb          	endbr32 
80104f84:	55                   	push   %ebp
80104f85:	89 e5                	mov    %esp,%ebp
80104f87:	57                   	push   %edi
80104f88:	8b 55 08             	mov    0x8(%ebp),%edx
80104f8b:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104f8e:	53                   	push   %ebx
80104f8f:	8b 45 0c             	mov    0xc(%ebp),%eax
  if ((int)dst%4 == 0 && n%4 == 0){
80104f92:	89 d7                	mov    %edx,%edi
80104f94:	09 cf                	or     %ecx,%edi
80104f96:	83 e7 03             	and    $0x3,%edi
80104f99:	75 25                	jne    80104fc0 <memset+0x40>
    c &= 0xFF;
80104f9b:	0f b6 f8             	movzbl %al,%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80104f9e:	c1 e0 18             	shl    $0x18,%eax
80104fa1:	89 fb                	mov    %edi,%ebx
80104fa3:	c1 e9 02             	shr    $0x2,%ecx
80104fa6:	c1 e3 10             	shl    $0x10,%ebx
80104fa9:	09 d8                	or     %ebx,%eax
80104fab:	09 f8                	or     %edi,%eax
80104fad:	c1 e7 08             	shl    $0x8,%edi
80104fb0:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80104fb2:	89 d7                	mov    %edx,%edi
80104fb4:	fc                   	cld    
80104fb5:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
80104fb7:	5b                   	pop    %ebx
80104fb8:	89 d0                	mov    %edx,%eax
80104fba:	5f                   	pop    %edi
80104fbb:	5d                   	pop    %ebp
80104fbc:	c3                   	ret    
80104fbd:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("cld; rep stosb" :
80104fc0:	89 d7                	mov    %edx,%edi
80104fc2:	fc                   	cld    
80104fc3:	f3 aa                	rep stos %al,%es:(%edi)
80104fc5:	5b                   	pop    %ebx
80104fc6:	89 d0                	mov    %edx,%eax
80104fc8:	5f                   	pop    %edi
80104fc9:	5d                   	pop    %ebp
80104fca:	c3                   	ret    
80104fcb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104fcf:	90                   	nop

80104fd0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104fd0:	f3 0f 1e fb          	endbr32 
80104fd4:	55                   	push   %ebp
80104fd5:	89 e5                	mov    %esp,%ebp
80104fd7:	56                   	push   %esi
80104fd8:	8b 75 10             	mov    0x10(%ebp),%esi
80104fdb:	8b 55 08             	mov    0x8(%ebp),%edx
80104fde:	53                   	push   %ebx
80104fdf:	8b 45 0c             	mov    0xc(%ebp),%eax
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104fe2:	85 f6                	test   %esi,%esi
80104fe4:	74 2a                	je     80105010 <memcmp+0x40>
80104fe6:	01 c6                	add    %eax,%esi
80104fe8:	eb 10                	jmp    80104ffa <memcmp+0x2a>
80104fea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
80104ff0:	83 c0 01             	add    $0x1,%eax
80104ff3:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
80104ff6:	39 f0                	cmp    %esi,%eax
80104ff8:	74 16                	je     80105010 <memcmp+0x40>
    if(*s1 != *s2)
80104ffa:	0f b6 0a             	movzbl (%edx),%ecx
80104ffd:	0f b6 18             	movzbl (%eax),%ebx
80105000:	38 d9                	cmp    %bl,%cl
80105002:	74 ec                	je     80104ff0 <memcmp+0x20>
      return *s1 - *s2;
80105004:	0f b6 c1             	movzbl %cl,%eax
80105007:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
80105009:	5b                   	pop    %ebx
8010500a:	5e                   	pop    %esi
8010500b:	5d                   	pop    %ebp
8010500c:	c3                   	ret    
8010500d:	8d 76 00             	lea    0x0(%esi),%esi
80105010:	5b                   	pop    %ebx
  return 0;
80105011:	31 c0                	xor    %eax,%eax
}
80105013:	5e                   	pop    %esi
80105014:	5d                   	pop    %ebp
80105015:	c3                   	ret    
80105016:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010501d:	8d 76 00             	lea    0x0(%esi),%esi

80105020 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80105020:	f3 0f 1e fb          	endbr32 
80105024:	55                   	push   %ebp
80105025:	89 e5                	mov    %esp,%ebp
80105027:	57                   	push   %edi
80105028:	8b 55 08             	mov    0x8(%ebp),%edx
8010502b:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010502e:	56                   	push   %esi
8010502f:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80105032:	39 d6                	cmp    %edx,%esi
80105034:	73 2a                	jae    80105060 <memmove+0x40>
80105036:	8d 3c 0e             	lea    (%esi,%ecx,1),%edi
80105039:	39 fa                	cmp    %edi,%edx
8010503b:	73 23                	jae    80105060 <memmove+0x40>
8010503d:	8d 41 ff             	lea    -0x1(%ecx),%eax
    s += n;
    d += n;
    while(n-- > 0)
80105040:	85 c9                	test   %ecx,%ecx
80105042:	74 13                	je     80105057 <memmove+0x37>
80105044:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      *--d = *--s;
80105048:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
8010504c:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
8010504f:	83 e8 01             	sub    $0x1,%eax
80105052:	83 f8 ff             	cmp    $0xffffffff,%eax
80105055:	75 f1                	jne    80105048 <memmove+0x28>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80105057:	5e                   	pop    %esi
80105058:	89 d0                	mov    %edx,%eax
8010505a:	5f                   	pop    %edi
8010505b:	5d                   	pop    %ebp
8010505c:	c3                   	ret    
8010505d:	8d 76 00             	lea    0x0(%esi),%esi
    while(n-- > 0)
80105060:	8d 04 0e             	lea    (%esi,%ecx,1),%eax
80105063:	89 d7                	mov    %edx,%edi
80105065:	85 c9                	test   %ecx,%ecx
80105067:	74 ee                	je     80105057 <memmove+0x37>
80105069:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
80105070:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
80105071:	39 f0                	cmp    %esi,%eax
80105073:	75 fb                	jne    80105070 <memmove+0x50>
}
80105075:	5e                   	pop    %esi
80105076:	89 d0                	mov    %edx,%eax
80105078:	5f                   	pop    %edi
80105079:	5d                   	pop    %ebp
8010507a:	c3                   	ret    
8010507b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010507f:	90                   	nop

80105080 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80105080:	f3 0f 1e fb          	endbr32 
  return memmove(dst, src, n);
80105084:	eb 9a                	jmp    80105020 <memmove>
80105086:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010508d:	8d 76 00             	lea    0x0(%esi),%esi

80105090 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80105090:	f3 0f 1e fb          	endbr32 
80105094:	55                   	push   %ebp
80105095:	89 e5                	mov    %esp,%ebp
80105097:	56                   	push   %esi
80105098:	8b 75 10             	mov    0x10(%ebp),%esi
8010509b:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010509e:	53                   	push   %ebx
8010509f:	8b 45 0c             	mov    0xc(%ebp),%eax
  while(n > 0 && *p && *p == *q)
801050a2:	85 f6                	test   %esi,%esi
801050a4:	74 32                	je     801050d8 <strncmp+0x48>
801050a6:	01 c6                	add    %eax,%esi
801050a8:	eb 14                	jmp    801050be <strncmp+0x2e>
801050aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801050b0:	38 da                	cmp    %bl,%dl
801050b2:	75 14                	jne    801050c8 <strncmp+0x38>
    n--, p++, q++;
801050b4:	83 c0 01             	add    $0x1,%eax
801050b7:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
801050ba:	39 f0                	cmp    %esi,%eax
801050bc:	74 1a                	je     801050d8 <strncmp+0x48>
801050be:	0f b6 11             	movzbl (%ecx),%edx
801050c1:	0f b6 18             	movzbl (%eax),%ebx
801050c4:	84 d2                	test   %dl,%dl
801050c6:	75 e8                	jne    801050b0 <strncmp+0x20>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
801050c8:	0f b6 c2             	movzbl %dl,%eax
801050cb:	29 d8                	sub    %ebx,%eax
}
801050cd:	5b                   	pop    %ebx
801050ce:	5e                   	pop    %esi
801050cf:	5d                   	pop    %ebp
801050d0:	c3                   	ret    
801050d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801050d8:	5b                   	pop    %ebx
    return 0;
801050d9:	31 c0                	xor    %eax,%eax
}
801050db:	5e                   	pop    %esi
801050dc:	5d                   	pop    %ebp
801050dd:	c3                   	ret    
801050de:	66 90                	xchg   %ax,%ax

801050e0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
801050e0:	f3 0f 1e fb          	endbr32 
801050e4:	55                   	push   %ebp
801050e5:	89 e5                	mov    %esp,%ebp
801050e7:	57                   	push   %edi
801050e8:	56                   	push   %esi
801050e9:	8b 75 08             	mov    0x8(%ebp),%esi
801050ec:	53                   	push   %ebx
801050ed:	8b 45 10             	mov    0x10(%ebp),%eax
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
801050f0:	89 f2                	mov    %esi,%edx
801050f2:	eb 1b                	jmp    8010510f <strncpy+0x2f>
801050f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801050f8:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
801050fc:	8b 7d 0c             	mov    0xc(%ebp),%edi
801050ff:	83 c2 01             	add    $0x1,%edx
80105102:	0f b6 7f ff          	movzbl -0x1(%edi),%edi
80105106:	89 f9                	mov    %edi,%ecx
80105108:	88 4a ff             	mov    %cl,-0x1(%edx)
8010510b:	84 c9                	test   %cl,%cl
8010510d:	74 09                	je     80105118 <strncpy+0x38>
8010510f:	89 c3                	mov    %eax,%ebx
80105111:	83 e8 01             	sub    $0x1,%eax
80105114:	85 db                	test   %ebx,%ebx
80105116:	7f e0                	jg     801050f8 <strncpy+0x18>
    ;
  while(n-- > 0)
80105118:	89 d1                	mov    %edx,%ecx
8010511a:	85 c0                	test   %eax,%eax
8010511c:	7e 15                	jle    80105133 <strncpy+0x53>
8010511e:	66 90                	xchg   %ax,%ax
    *s++ = 0;
80105120:	83 c1 01             	add    $0x1,%ecx
80105123:	c6 41 ff 00          	movb   $0x0,-0x1(%ecx)
  while(n-- > 0)
80105127:	89 c8                	mov    %ecx,%eax
80105129:	f7 d0                	not    %eax
8010512b:	01 d0                	add    %edx,%eax
8010512d:	01 d8                	add    %ebx,%eax
8010512f:	85 c0                	test   %eax,%eax
80105131:	7f ed                	jg     80105120 <strncpy+0x40>
  return os;
}
80105133:	5b                   	pop    %ebx
80105134:	89 f0                	mov    %esi,%eax
80105136:	5e                   	pop    %esi
80105137:	5f                   	pop    %edi
80105138:	5d                   	pop    %ebp
80105139:	c3                   	ret    
8010513a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105140 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80105140:	f3 0f 1e fb          	endbr32 
80105144:	55                   	push   %ebp
80105145:	89 e5                	mov    %esp,%ebp
80105147:	56                   	push   %esi
80105148:	8b 55 10             	mov    0x10(%ebp),%edx
8010514b:	8b 75 08             	mov    0x8(%ebp),%esi
8010514e:	53                   	push   %ebx
8010514f:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
80105152:	85 d2                	test   %edx,%edx
80105154:	7e 21                	jle    80105177 <safestrcpy+0x37>
80105156:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
8010515a:	89 f2                	mov    %esi,%edx
8010515c:	eb 12                	jmp    80105170 <safestrcpy+0x30>
8010515e:	66 90                	xchg   %ax,%ax
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80105160:	0f b6 08             	movzbl (%eax),%ecx
80105163:	83 c0 01             	add    $0x1,%eax
80105166:	83 c2 01             	add    $0x1,%edx
80105169:	88 4a ff             	mov    %cl,-0x1(%edx)
8010516c:	84 c9                	test   %cl,%cl
8010516e:	74 04                	je     80105174 <safestrcpy+0x34>
80105170:	39 d8                	cmp    %ebx,%eax
80105172:	75 ec                	jne    80105160 <safestrcpy+0x20>
    ;
  *s = 0;
80105174:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
80105177:	89 f0                	mov    %esi,%eax
80105179:	5b                   	pop    %ebx
8010517a:	5e                   	pop    %esi
8010517b:	5d                   	pop    %ebp
8010517c:	c3                   	ret    
8010517d:	8d 76 00             	lea    0x0(%esi),%esi

80105180 <strlen>:

int
strlen(const char *s)
{
80105180:	f3 0f 1e fb          	endbr32 
80105184:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80105185:	31 c0                	xor    %eax,%eax
{
80105187:	89 e5                	mov    %esp,%ebp
80105189:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
8010518c:	80 3a 00             	cmpb   $0x0,(%edx)
8010518f:	74 10                	je     801051a1 <strlen+0x21>
80105191:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105198:	83 c0 01             	add    $0x1,%eax
8010519b:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
8010519f:	75 f7                	jne    80105198 <strlen+0x18>
    ;
  return n;
}
801051a1:	5d                   	pop    %ebp
801051a2:	c3                   	ret    

801051a3 <swtch>:
801051a3:	8b 44 24 04          	mov    0x4(%esp),%eax
801051a7:	8b 54 24 08          	mov    0x8(%esp),%edx
801051ab:	55                   	push   %ebp
801051ac:	53                   	push   %ebx
801051ad:	56                   	push   %esi
801051ae:	57                   	push   %edi
801051af:	89 20                	mov    %esp,(%eax)
801051b1:	89 d4                	mov    %edx,%esp
801051b3:	5f                   	pop    %edi
801051b4:	5e                   	pop    %esi
801051b5:	5b                   	pop    %ebx
801051b6:	5d                   	pop    %ebp
801051b7:	c3                   	ret    
801051b8:	66 90                	xchg   %ax,%ax
801051ba:	66 90                	xchg   %ax,%ax
801051bc:	66 90                	xchg   %ax,%ax
801051be:	66 90                	xchg   %ax,%ax

801051c0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
801051c0:	f3 0f 1e fb          	endbr32 
801051c4:	55                   	push   %ebp
801051c5:	89 e5                	mov    %esp,%ebp
801051c7:	53                   	push   %ebx
801051c8:	83 ec 04             	sub    $0x4,%esp
801051cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
801051ce:	e8 bd eb ff ff       	call   80103d90 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
801051d3:	8b 00                	mov    (%eax),%eax
801051d5:	39 d8                	cmp    %ebx,%eax
801051d7:	76 17                	jbe    801051f0 <fetchint+0x30>
801051d9:	8d 53 04             	lea    0x4(%ebx),%edx
801051dc:	39 d0                	cmp    %edx,%eax
801051de:	72 10                	jb     801051f0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
801051e0:	8b 45 0c             	mov    0xc(%ebp),%eax
801051e3:	8b 13                	mov    (%ebx),%edx
801051e5:	89 10                	mov    %edx,(%eax)
  return 0;
801051e7:	31 c0                	xor    %eax,%eax
}
801051e9:	83 c4 04             	add    $0x4,%esp
801051ec:	5b                   	pop    %ebx
801051ed:	5d                   	pop    %ebp
801051ee:	c3                   	ret    
801051ef:	90                   	nop
    return -1;
801051f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801051f5:	eb f2                	jmp    801051e9 <fetchint+0x29>
801051f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801051fe:	66 90                	xchg   %ax,%ax

80105200 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80105200:	f3 0f 1e fb          	endbr32 
80105204:	55                   	push   %ebp
80105205:	89 e5                	mov    %esp,%ebp
80105207:	53                   	push   %ebx
80105208:	83 ec 04             	sub    $0x4,%esp
8010520b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010520e:	e8 7d eb ff ff       	call   80103d90 <myproc>

  if(addr >= curproc->sz)
80105213:	39 18                	cmp    %ebx,(%eax)
80105215:	76 31                	jbe    80105248 <fetchstr+0x48>
    return -1;
  *pp = (char*)addr;
80105217:	8b 55 0c             	mov    0xc(%ebp),%edx
8010521a:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
8010521c:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
8010521e:	39 d3                	cmp    %edx,%ebx
80105220:	73 26                	jae    80105248 <fetchstr+0x48>
80105222:	89 d8                	mov    %ebx,%eax
80105224:	eb 11                	jmp    80105237 <fetchstr+0x37>
80105226:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010522d:	8d 76 00             	lea    0x0(%esi),%esi
80105230:	83 c0 01             	add    $0x1,%eax
80105233:	39 c2                	cmp    %eax,%edx
80105235:	76 11                	jbe    80105248 <fetchstr+0x48>
    if(*s == 0)
80105237:	80 38 00             	cmpb   $0x0,(%eax)
8010523a:	75 f4                	jne    80105230 <fetchstr+0x30>
      return s - *pp;
  }
  return -1;
}
8010523c:	83 c4 04             	add    $0x4,%esp
      return s - *pp;
8010523f:	29 d8                	sub    %ebx,%eax
}
80105241:	5b                   	pop    %ebx
80105242:	5d                   	pop    %ebp
80105243:	c3                   	ret    
80105244:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105248:	83 c4 04             	add    $0x4,%esp
    return -1;
8010524b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105250:	5b                   	pop    %ebx
80105251:	5d                   	pop    %ebp
80105252:	c3                   	ret    
80105253:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010525a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105260 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80105260:	f3 0f 1e fb          	endbr32 
80105264:	55                   	push   %ebp
80105265:	89 e5                	mov    %esp,%ebp
80105267:	56                   	push   %esi
80105268:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105269:	e8 22 eb ff ff       	call   80103d90 <myproc>
8010526e:	8b 55 08             	mov    0x8(%ebp),%edx
80105271:	8b 40 18             	mov    0x18(%eax),%eax
80105274:	8b 40 44             	mov    0x44(%eax),%eax
80105277:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
8010527a:	e8 11 eb ff ff       	call   80103d90 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010527f:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105282:	8b 00                	mov    (%eax),%eax
80105284:	39 c6                	cmp    %eax,%esi
80105286:	73 18                	jae    801052a0 <argint+0x40>
80105288:	8d 53 08             	lea    0x8(%ebx),%edx
8010528b:	39 d0                	cmp    %edx,%eax
8010528d:	72 11                	jb     801052a0 <argint+0x40>
  *ip = *(int*)(addr);
8010528f:	8b 45 0c             	mov    0xc(%ebp),%eax
80105292:	8b 53 04             	mov    0x4(%ebx),%edx
80105295:	89 10                	mov    %edx,(%eax)
  return 0;
80105297:	31 c0                	xor    %eax,%eax
}
80105299:	5b                   	pop    %ebx
8010529a:	5e                   	pop    %esi
8010529b:	5d                   	pop    %ebp
8010529c:	c3                   	ret    
8010529d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801052a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801052a5:	eb f2                	jmp    80105299 <argint+0x39>
801052a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801052ae:	66 90                	xchg   %ax,%ax

801052b0 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
801052b0:	f3 0f 1e fb          	endbr32 
801052b4:	55                   	push   %ebp
801052b5:	89 e5                	mov    %esp,%ebp
801052b7:	56                   	push   %esi
801052b8:	53                   	push   %ebx
801052b9:	83 ec 10             	sub    $0x10,%esp
801052bc:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
801052bf:	e8 cc ea ff ff       	call   80103d90 <myproc>
 
  if(argint(n, &i) < 0)
801052c4:	83 ec 08             	sub    $0x8,%esp
  struct proc *curproc = myproc();
801052c7:	89 c6                	mov    %eax,%esi
  if(argint(n, &i) < 0)
801052c9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801052cc:	50                   	push   %eax
801052cd:	ff 75 08             	pushl  0x8(%ebp)
801052d0:	e8 8b ff ff ff       	call   80105260 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
801052d5:	83 c4 10             	add    $0x10,%esp
801052d8:	85 c0                	test   %eax,%eax
801052da:	78 24                	js     80105300 <argptr+0x50>
801052dc:	85 db                	test   %ebx,%ebx
801052de:	78 20                	js     80105300 <argptr+0x50>
801052e0:	8b 16                	mov    (%esi),%edx
801052e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801052e5:	39 c2                	cmp    %eax,%edx
801052e7:	76 17                	jbe    80105300 <argptr+0x50>
801052e9:	01 c3                	add    %eax,%ebx
801052eb:	39 da                	cmp    %ebx,%edx
801052ed:	72 11                	jb     80105300 <argptr+0x50>
    return -1;
  *pp = (char*)i;
801052ef:	8b 55 0c             	mov    0xc(%ebp),%edx
801052f2:	89 02                	mov    %eax,(%edx)
  return 0;
801052f4:	31 c0                	xor    %eax,%eax
}
801052f6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801052f9:	5b                   	pop    %ebx
801052fa:	5e                   	pop    %esi
801052fb:	5d                   	pop    %ebp
801052fc:	c3                   	ret    
801052fd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105300:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105305:	eb ef                	jmp    801052f6 <argptr+0x46>
80105307:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010530e:	66 90                	xchg   %ax,%ax

80105310 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105310:	f3 0f 1e fb          	endbr32 
80105314:	55                   	push   %ebp
80105315:	89 e5                	mov    %esp,%ebp
80105317:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
8010531a:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010531d:	50                   	push   %eax
8010531e:	ff 75 08             	pushl  0x8(%ebp)
80105321:	e8 3a ff ff ff       	call   80105260 <argint>
80105326:	83 c4 10             	add    $0x10,%esp
80105329:	85 c0                	test   %eax,%eax
8010532b:	78 13                	js     80105340 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
8010532d:	83 ec 08             	sub    $0x8,%esp
80105330:	ff 75 0c             	pushl  0xc(%ebp)
80105333:	ff 75 f4             	pushl  -0xc(%ebp)
80105336:	e8 c5 fe ff ff       	call   80105200 <fetchstr>
8010533b:	83 c4 10             	add    $0x10,%esp
}
8010533e:	c9                   	leave  
8010533f:	c3                   	ret    
80105340:	c9                   	leave  
    return -1;
80105341:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105346:	c3                   	ret    
80105347:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010534e:	66 90                	xchg   %ax,%ax

80105350 <syscall>:
[SYS_changeSystemMHRRN] sys_changeSystemMHRRN,
};

void
syscall(void)
{
80105350:	f3 0f 1e fb          	endbr32 
80105354:	55                   	push   %ebp
80105355:	89 e5                	mov    %esp,%ebp
80105357:	53                   	push   %ebx
80105358:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
8010535b:	e8 30 ea ff ff       	call   80103d90 <myproc>
80105360:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80105362:	8b 40 18             	mov    0x18(%eax),%eax
80105365:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80105368:	8d 50 ff             	lea    -0x1(%eax),%edx
8010536b:	83 fa 18             	cmp    $0x18,%edx
8010536e:	77 20                	ja     80105390 <syscall+0x40>
80105370:	8b 14 85 a0 82 10 80 	mov    -0x7fef7d60(,%eax,4),%edx
80105377:	85 d2                	test   %edx,%edx
80105379:	74 15                	je     80105390 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
8010537b:	ff d2                	call   *%edx
8010537d:	89 c2                	mov    %eax,%edx
8010537f:	8b 43 18             	mov    0x18(%ebx),%eax
80105382:	89 50 1c             	mov    %edx,0x1c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80105385:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105388:	c9                   	leave  
80105389:	c3                   	ret    
8010538a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cprintf("%d %s: unknown sys call %d\n",
80105390:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80105391:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80105394:	50                   	push   %eax
80105395:	ff 73 10             	pushl  0x10(%ebx)
80105398:	68 6d 82 10 80       	push   $0x8010826d
8010539d:	e8 0e b3 ff ff       	call   801006b0 <cprintf>
    curproc->tf->eax = -1;
801053a2:	8b 43 18             	mov    0x18(%ebx),%eax
801053a5:	83 c4 10             	add    $0x10,%esp
801053a8:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
801053af:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801053b2:	c9                   	leave  
801053b3:	c3                   	ret    
801053b4:	66 90                	xchg   %ax,%ax
801053b6:	66 90                	xchg   %ax,%ax
801053b8:	66 90                	xchg   %ax,%ax
801053ba:	66 90                	xchg   %ax,%ax
801053bc:	66 90                	xchg   %ax,%ax
801053be:	66 90                	xchg   %ax,%ax

801053c0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
801053c0:	55                   	push   %ebp
801053c1:	89 e5                	mov    %esp,%ebp
801053c3:	57                   	push   %edi
801053c4:	56                   	push   %esi
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
801053c5:	8d 7d da             	lea    -0x26(%ebp),%edi
{
801053c8:	53                   	push   %ebx
801053c9:	83 ec 34             	sub    $0x34,%esp
801053cc:	89 4d d0             	mov    %ecx,-0x30(%ebp)
801053cf:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
801053d2:	57                   	push   %edi
801053d3:	50                   	push   %eax
{
801053d4:	89 55 d4             	mov    %edx,-0x2c(%ebp)
801053d7:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
801053da:	e8 51 d0 ff ff       	call   80102430 <nameiparent>
801053df:	83 c4 10             	add    $0x10,%esp
801053e2:	85 c0                	test   %eax,%eax
801053e4:	0f 84 46 01 00 00    	je     80105530 <create+0x170>
    return 0;
  ilock(dp);
801053ea:	83 ec 0c             	sub    $0xc,%esp
801053ed:	89 c3                	mov    %eax,%ebx
801053ef:	50                   	push   %eax
801053f0:	e8 4b c7 ff ff       	call   80101b40 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
801053f5:	83 c4 0c             	add    $0xc,%esp
801053f8:	6a 00                	push   $0x0
801053fa:	57                   	push   %edi
801053fb:	53                   	push   %ebx
801053fc:	e8 8f cc ff ff       	call   80102090 <dirlookup>
80105401:	83 c4 10             	add    $0x10,%esp
80105404:	89 c6                	mov    %eax,%esi
80105406:	85 c0                	test   %eax,%eax
80105408:	74 56                	je     80105460 <create+0xa0>
    iunlockput(dp);
8010540a:	83 ec 0c             	sub    $0xc,%esp
8010540d:	53                   	push   %ebx
8010540e:	e8 cd c9 ff ff       	call   80101de0 <iunlockput>
    ilock(ip);
80105413:	89 34 24             	mov    %esi,(%esp)
80105416:	e8 25 c7 ff ff       	call   80101b40 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
8010541b:	83 c4 10             	add    $0x10,%esp
8010541e:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80105423:	75 1b                	jne    80105440 <create+0x80>
80105425:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
8010542a:	75 14                	jne    80105440 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
8010542c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010542f:	89 f0                	mov    %esi,%eax
80105431:	5b                   	pop    %ebx
80105432:	5e                   	pop    %esi
80105433:	5f                   	pop    %edi
80105434:	5d                   	pop    %ebp
80105435:	c3                   	ret    
80105436:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010543d:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
80105440:	83 ec 0c             	sub    $0xc,%esp
80105443:	56                   	push   %esi
    return 0;
80105444:	31 f6                	xor    %esi,%esi
    iunlockput(ip);
80105446:	e8 95 c9 ff ff       	call   80101de0 <iunlockput>
    return 0;
8010544b:	83 c4 10             	add    $0x10,%esp
}
8010544e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105451:	89 f0                	mov    %esi,%eax
80105453:	5b                   	pop    %ebx
80105454:	5e                   	pop    %esi
80105455:	5f                   	pop    %edi
80105456:	5d                   	pop    %ebp
80105457:	c3                   	ret    
80105458:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010545f:	90                   	nop
  if((ip = ialloc(dp->dev, type)) == 0)
80105460:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80105464:	83 ec 08             	sub    $0x8,%esp
80105467:	50                   	push   %eax
80105468:	ff 33                	pushl  (%ebx)
8010546a:	e8 51 c5 ff ff       	call   801019c0 <ialloc>
8010546f:	83 c4 10             	add    $0x10,%esp
80105472:	89 c6                	mov    %eax,%esi
80105474:	85 c0                	test   %eax,%eax
80105476:	0f 84 cd 00 00 00    	je     80105549 <create+0x189>
  ilock(ip);
8010547c:	83 ec 0c             	sub    $0xc,%esp
8010547f:	50                   	push   %eax
80105480:	e8 bb c6 ff ff       	call   80101b40 <ilock>
  ip->major = major;
80105485:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80105489:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
8010548d:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80105491:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
80105495:	b8 01 00 00 00       	mov    $0x1,%eax
8010549a:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
8010549e:	89 34 24             	mov    %esi,(%esp)
801054a1:	e8 da c5 ff ff       	call   80101a80 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
801054a6:	83 c4 10             	add    $0x10,%esp
801054a9:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
801054ae:	74 30                	je     801054e0 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
801054b0:	83 ec 04             	sub    $0x4,%esp
801054b3:	ff 76 04             	pushl  0x4(%esi)
801054b6:	57                   	push   %edi
801054b7:	53                   	push   %ebx
801054b8:	e8 93 ce ff ff       	call   80102350 <dirlink>
801054bd:	83 c4 10             	add    $0x10,%esp
801054c0:	85 c0                	test   %eax,%eax
801054c2:	78 78                	js     8010553c <create+0x17c>
  iunlockput(dp);
801054c4:	83 ec 0c             	sub    $0xc,%esp
801054c7:	53                   	push   %ebx
801054c8:	e8 13 c9 ff ff       	call   80101de0 <iunlockput>
  return ip;
801054cd:	83 c4 10             	add    $0x10,%esp
}
801054d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801054d3:	89 f0                	mov    %esi,%eax
801054d5:	5b                   	pop    %ebx
801054d6:	5e                   	pop    %esi
801054d7:	5f                   	pop    %edi
801054d8:	5d                   	pop    %ebp
801054d9:	c3                   	ret    
801054da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
801054e0:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
801054e3:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
801054e8:	53                   	push   %ebx
801054e9:	e8 92 c5 ff ff       	call   80101a80 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
801054ee:	83 c4 0c             	add    $0xc,%esp
801054f1:	ff 76 04             	pushl  0x4(%esi)
801054f4:	68 24 83 10 80       	push   $0x80108324
801054f9:	56                   	push   %esi
801054fa:	e8 51 ce ff ff       	call   80102350 <dirlink>
801054ff:	83 c4 10             	add    $0x10,%esp
80105502:	85 c0                	test   %eax,%eax
80105504:	78 18                	js     8010551e <create+0x15e>
80105506:	83 ec 04             	sub    $0x4,%esp
80105509:	ff 73 04             	pushl  0x4(%ebx)
8010550c:	68 23 83 10 80       	push   $0x80108323
80105511:	56                   	push   %esi
80105512:	e8 39 ce ff ff       	call   80102350 <dirlink>
80105517:	83 c4 10             	add    $0x10,%esp
8010551a:	85 c0                	test   %eax,%eax
8010551c:	79 92                	jns    801054b0 <create+0xf0>
      panic("create dots");
8010551e:	83 ec 0c             	sub    $0xc,%esp
80105521:	68 17 83 10 80       	push   $0x80108317
80105526:	e8 65 ae ff ff       	call   80100390 <panic>
8010552b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010552f:	90                   	nop
}
80105530:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80105533:	31 f6                	xor    %esi,%esi
}
80105535:	5b                   	pop    %ebx
80105536:	89 f0                	mov    %esi,%eax
80105538:	5e                   	pop    %esi
80105539:	5f                   	pop    %edi
8010553a:	5d                   	pop    %ebp
8010553b:	c3                   	ret    
    panic("create: dirlink");
8010553c:	83 ec 0c             	sub    $0xc,%esp
8010553f:	68 26 83 10 80       	push   $0x80108326
80105544:	e8 47 ae ff ff       	call   80100390 <panic>
    panic("create: ialloc");
80105549:	83 ec 0c             	sub    $0xc,%esp
8010554c:	68 08 83 10 80       	push   $0x80108308
80105551:	e8 3a ae ff ff       	call   80100390 <panic>
80105556:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010555d:	8d 76 00             	lea    0x0(%esi),%esi

80105560 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80105560:	55                   	push   %ebp
80105561:	89 e5                	mov    %esp,%ebp
80105563:	56                   	push   %esi
80105564:	89 d6                	mov    %edx,%esi
80105566:	53                   	push   %ebx
80105567:	89 c3                	mov    %eax,%ebx
  if(argint(n, &fd) < 0)
80105569:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
8010556c:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010556f:	50                   	push   %eax
80105570:	6a 00                	push   $0x0
80105572:	e8 e9 fc ff ff       	call   80105260 <argint>
80105577:	83 c4 10             	add    $0x10,%esp
8010557a:	85 c0                	test   %eax,%eax
8010557c:	78 2a                	js     801055a8 <argfd.constprop.0+0x48>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010557e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105582:	77 24                	ja     801055a8 <argfd.constprop.0+0x48>
80105584:	e8 07 e8 ff ff       	call   80103d90 <myproc>
80105589:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010558c:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80105590:	85 c0                	test   %eax,%eax
80105592:	74 14                	je     801055a8 <argfd.constprop.0+0x48>
  if(pfd)
80105594:	85 db                	test   %ebx,%ebx
80105596:	74 02                	je     8010559a <argfd.constprop.0+0x3a>
    *pfd = fd;
80105598:	89 13                	mov    %edx,(%ebx)
    *pf = f;
8010559a:	89 06                	mov    %eax,(%esi)
  return 0;
8010559c:	31 c0                	xor    %eax,%eax
}
8010559e:	8d 65 f8             	lea    -0x8(%ebp),%esp
801055a1:	5b                   	pop    %ebx
801055a2:	5e                   	pop    %esi
801055a3:	5d                   	pop    %ebp
801055a4:	c3                   	ret    
801055a5:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801055a8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801055ad:	eb ef                	jmp    8010559e <argfd.constprop.0+0x3e>
801055af:	90                   	nop

801055b0 <sys_dup>:
{
801055b0:	f3 0f 1e fb          	endbr32 
801055b4:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
801055b5:	31 c0                	xor    %eax,%eax
{
801055b7:	89 e5                	mov    %esp,%ebp
801055b9:	56                   	push   %esi
801055ba:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
801055bb:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
801055be:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
801055c1:	e8 9a ff ff ff       	call   80105560 <argfd.constprop.0>
801055c6:	85 c0                	test   %eax,%eax
801055c8:	78 1e                	js     801055e8 <sys_dup+0x38>
  if((fd=fdalloc(f)) < 0)
801055ca:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
801055cd:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
801055cf:	e8 bc e7 ff ff       	call   80103d90 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801055d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
801055d8:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801055dc:	85 d2                	test   %edx,%edx
801055de:	74 20                	je     80105600 <sys_dup+0x50>
  for(fd = 0; fd < NOFILE; fd++){
801055e0:	83 c3 01             	add    $0x1,%ebx
801055e3:	83 fb 10             	cmp    $0x10,%ebx
801055e6:	75 f0                	jne    801055d8 <sys_dup+0x28>
}
801055e8:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
801055eb:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
801055f0:	89 d8                	mov    %ebx,%eax
801055f2:	5b                   	pop    %ebx
801055f3:	5e                   	pop    %esi
801055f4:	5d                   	pop    %ebp
801055f5:	c3                   	ret    
801055f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801055fd:	8d 76 00             	lea    0x0(%esi),%esi
      curproc->ofile[fd] = f;
80105600:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80105604:	83 ec 0c             	sub    $0xc,%esp
80105607:	ff 75 f4             	pushl  -0xc(%ebp)
8010560a:	e8 41 bc ff ff       	call   80101250 <filedup>
  return fd;
8010560f:	83 c4 10             	add    $0x10,%esp
}
80105612:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105615:	89 d8                	mov    %ebx,%eax
80105617:	5b                   	pop    %ebx
80105618:	5e                   	pop    %esi
80105619:	5d                   	pop    %ebp
8010561a:	c3                   	ret    
8010561b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010561f:	90                   	nop

80105620 <sys_read>:
{
80105620:	f3 0f 1e fb          	endbr32 
80105624:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105625:	31 c0                	xor    %eax,%eax
{
80105627:	89 e5                	mov    %esp,%ebp
80105629:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
8010562c:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010562f:	e8 2c ff ff ff       	call   80105560 <argfd.constprop.0>
80105634:	85 c0                	test   %eax,%eax
80105636:	78 48                	js     80105680 <sys_read+0x60>
80105638:	83 ec 08             	sub    $0x8,%esp
8010563b:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010563e:	50                   	push   %eax
8010563f:	6a 02                	push   $0x2
80105641:	e8 1a fc ff ff       	call   80105260 <argint>
80105646:	83 c4 10             	add    $0x10,%esp
80105649:	85 c0                	test   %eax,%eax
8010564b:	78 33                	js     80105680 <sys_read+0x60>
8010564d:	83 ec 04             	sub    $0x4,%esp
80105650:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105653:	ff 75 f0             	pushl  -0x10(%ebp)
80105656:	50                   	push   %eax
80105657:	6a 01                	push   $0x1
80105659:	e8 52 fc ff ff       	call   801052b0 <argptr>
8010565e:	83 c4 10             	add    $0x10,%esp
80105661:	85 c0                	test   %eax,%eax
80105663:	78 1b                	js     80105680 <sys_read+0x60>
  return fileread(f, p, n);
80105665:	83 ec 04             	sub    $0x4,%esp
80105668:	ff 75 f0             	pushl  -0x10(%ebp)
8010566b:	ff 75 f4             	pushl  -0xc(%ebp)
8010566e:	ff 75 ec             	pushl  -0x14(%ebp)
80105671:	e8 5a bd ff ff       	call   801013d0 <fileread>
80105676:	83 c4 10             	add    $0x10,%esp
}
80105679:	c9                   	leave  
8010567a:	c3                   	ret    
8010567b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010567f:	90                   	nop
80105680:	c9                   	leave  
    return -1;
80105681:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105686:	c3                   	ret    
80105687:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010568e:	66 90                	xchg   %ax,%ax

80105690 <sys_write>:
{
80105690:	f3 0f 1e fb          	endbr32 
80105694:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105695:	31 c0                	xor    %eax,%eax
{
80105697:	89 e5                	mov    %esp,%ebp
80105699:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
8010569c:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010569f:	e8 bc fe ff ff       	call   80105560 <argfd.constprop.0>
801056a4:	85 c0                	test   %eax,%eax
801056a6:	78 48                	js     801056f0 <sys_write+0x60>
801056a8:	83 ec 08             	sub    $0x8,%esp
801056ab:	8d 45 f0             	lea    -0x10(%ebp),%eax
801056ae:	50                   	push   %eax
801056af:	6a 02                	push   $0x2
801056b1:	e8 aa fb ff ff       	call   80105260 <argint>
801056b6:	83 c4 10             	add    $0x10,%esp
801056b9:	85 c0                	test   %eax,%eax
801056bb:	78 33                	js     801056f0 <sys_write+0x60>
801056bd:	83 ec 04             	sub    $0x4,%esp
801056c0:	8d 45 f4             	lea    -0xc(%ebp),%eax
801056c3:	ff 75 f0             	pushl  -0x10(%ebp)
801056c6:	50                   	push   %eax
801056c7:	6a 01                	push   $0x1
801056c9:	e8 e2 fb ff ff       	call   801052b0 <argptr>
801056ce:	83 c4 10             	add    $0x10,%esp
801056d1:	85 c0                	test   %eax,%eax
801056d3:	78 1b                	js     801056f0 <sys_write+0x60>
  return filewrite(f, p, n);
801056d5:	83 ec 04             	sub    $0x4,%esp
801056d8:	ff 75 f0             	pushl  -0x10(%ebp)
801056db:	ff 75 f4             	pushl  -0xc(%ebp)
801056de:	ff 75 ec             	pushl  -0x14(%ebp)
801056e1:	e8 8a bd ff ff       	call   80101470 <filewrite>
801056e6:	83 c4 10             	add    $0x10,%esp
}
801056e9:	c9                   	leave  
801056ea:	c3                   	ret    
801056eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801056ef:	90                   	nop
801056f0:	c9                   	leave  
    return -1;
801056f1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801056f6:	c3                   	ret    
801056f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801056fe:	66 90                	xchg   %ax,%ax

80105700 <sys_close>:
{
80105700:	f3 0f 1e fb          	endbr32 
80105704:	55                   	push   %ebp
80105705:	89 e5                	mov    %esp,%ebp
80105707:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, &fd, &f) < 0)
8010570a:	8d 55 f4             	lea    -0xc(%ebp),%edx
8010570d:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105710:	e8 4b fe ff ff       	call   80105560 <argfd.constprop.0>
80105715:	85 c0                	test   %eax,%eax
80105717:	78 27                	js     80105740 <sys_close+0x40>
  myproc()->ofile[fd] = 0;
80105719:	e8 72 e6 ff ff       	call   80103d90 <myproc>
8010571e:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
80105721:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80105724:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
8010572b:	00 
  fileclose(f);
8010572c:	ff 75 f4             	pushl  -0xc(%ebp)
8010572f:	e8 6c bb ff ff       	call   801012a0 <fileclose>
  return 0;
80105734:	83 c4 10             	add    $0x10,%esp
80105737:	31 c0                	xor    %eax,%eax
}
80105739:	c9                   	leave  
8010573a:	c3                   	ret    
8010573b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010573f:	90                   	nop
80105740:	c9                   	leave  
    return -1;
80105741:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105746:	c3                   	ret    
80105747:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010574e:	66 90                	xchg   %ax,%ax

80105750 <sys_fstat>:
{
80105750:	f3 0f 1e fb          	endbr32 
80105754:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105755:	31 c0                	xor    %eax,%eax
{
80105757:	89 e5                	mov    %esp,%ebp
80105759:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
8010575c:	8d 55 f0             	lea    -0x10(%ebp),%edx
8010575f:	e8 fc fd ff ff       	call   80105560 <argfd.constprop.0>
80105764:	85 c0                	test   %eax,%eax
80105766:	78 30                	js     80105798 <sys_fstat+0x48>
80105768:	83 ec 04             	sub    $0x4,%esp
8010576b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010576e:	6a 14                	push   $0x14
80105770:	50                   	push   %eax
80105771:	6a 01                	push   $0x1
80105773:	e8 38 fb ff ff       	call   801052b0 <argptr>
80105778:	83 c4 10             	add    $0x10,%esp
8010577b:	85 c0                	test   %eax,%eax
8010577d:	78 19                	js     80105798 <sys_fstat+0x48>
  return filestat(f, st);
8010577f:	83 ec 08             	sub    $0x8,%esp
80105782:	ff 75 f4             	pushl  -0xc(%ebp)
80105785:	ff 75 f0             	pushl  -0x10(%ebp)
80105788:	e8 f3 bb ff ff       	call   80101380 <filestat>
8010578d:	83 c4 10             	add    $0x10,%esp
}
80105790:	c9                   	leave  
80105791:	c3                   	ret    
80105792:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105798:	c9                   	leave  
    return -1;
80105799:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010579e:	c3                   	ret    
8010579f:	90                   	nop

801057a0 <sys_link>:
{
801057a0:	f3 0f 1e fb          	endbr32 
801057a4:	55                   	push   %ebp
801057a5:	89 e5                	mov    %esp,%ebp
801057a7:	57                   	push   %edi
801057a8:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801057a9:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
801057ac:	53                   	push   %ebx
801057ad:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801057b0:	50                   	push   %eax
801057b1:	6a 00                	push   $0x0
801057b3:	e8 58 fb ff ff       	call   80105310 <argstr>
801057b8:	83 c4 10             	add    $0x10,%esp
801057bb:	85 c0                	test   %eax,%eax
801057bd:	0f 88 ff 00 00 00    	js     801058c2 <sys_link+0x122>
801057c3:	83 ec 08             	sub    $0x8,%esp
801057c6:	8d 45 d0             	lea    -0x30(%ebp),%eax
801057c9:	50                   	push   %eax
801057ca:	6a 01                	push   $0x1
801057cc:	e8 3f fb ff ff       	call   80105310 <argstr>
801057d1:	83 c4 10             	add    $0x10,%esp
801057d4:	85 c0                	test   %eax,%eax
801057d6:	0f 88 e6 00 00 00    	js     801058c2 <sys_link+0x122>
  begin_op();
801057dc:	e8 2f d9 ff ff       	call   80103110 <begin_op>
  if((ip = namei(old)) == 0){
801057e1:	83 ec 0c             	sub    $0xc,%esp
801057e4:	ff 75 d4             	pushl  -0x2c(%ebp)
801057e7:	e8 24 cc ff ff       	call   80102410 <namei>
801057ec:	83 c4 10             	add    $0x10,%esp
801057ef:	89 c3                	mov    %eax,%ebx
801057f1:	85 c0                	test   %eax,%eax
801057f3:	0f 84 e8 00 00 00    	je     801058e1 <sys_link+0x141>
  ilock(ip);
801057f9:	83 ec 0c             	sub    $0xc,%esp
801057fc:	50                   	push   %eax
801057fd:	e8 3e c3 ff ff       	call   80101b40 <ilock>
  if(ip->type == T_DIR){
80105802:	83 c4 10             	add    $0x10,%esp
80105805:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010580a:	0f 84 b9 00 00 00    	je     801058c9 <sys_link+0x129>
  iupdate(ip);
80105810:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
80105813:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
80105818:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
8010581b:	53                   	push   %ebx
8010581c:	e8 5f c2 ff ff       	call   80101a80 <iupdate>
  iunlock(ip);
80105821:	89 1c 24             	mov    %ebx,(%esp)
80105824:	e8 f7 c3 ff ff       	call   80101c20 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105829:	58                   	pop    %eax
8010582a:	5a                   	pop    %edx
8010582b:	57                   	push   %edi
8010582c:	ff 75 d0             	pushl  -0x30(%ebp)
8010582f:	e8 fc cb ff ff       	call   80102430 <nameiparent>
80105834:	83 c4 10             	add    $0x10,%esp
80105837:	89 c6                	mov    %eax,%esi
80105839:	85 c0                	test   %eax,%eax
8010583b:	74 5f                	je     8010589c <sys_link+0xfc>
  ilock(dp);
8010583d:	83 ec 0c             	sub    $0xc,%esp
80105840:	50                   	push   %eax
80105841:	e8 fa c2 ff ff       	call   80101b40 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105846:	8b 03                	mov    (%ebx),%eax
80105848:	83 c4 10             	add    $0x10,%esp
8010584b:	39 06                	cmp    %eax,(%esi)
8010584d:	75 41                	jne    80105890 <sys_link+0xf0>
8010584f:	83 ec 04             	sub    $0x4,%esp
80105852:	ff 73 04             	pushl  0x4(%ebx)
80105855:	57                   	push   %edi
80105856:	56                   	push   %esi
80105857:	e8 f4 ca ff ff       	call   80102350 <dirlink>
8010585c:	83 c4 10             	add    $0x10,%esp
8010585f:	85 c0                	test   %eax,%eax
80105861:	78 2d                	js     80105890 <sys_link+0xf0>
  iunlockput(dp);
80105863:	83 ec 0c             	sub    $0xc,%esp
80105866:	56                   	push   %esi
80105867:	e8 74 c5 ff ff       	call   80101de0 <iunlockput>
  iput(ip);
8010586c:	89 1c 24             	mov    %ebx,(%esp)
8010586f:	e8 fc c3 ff ff       	call   80101c70 <iput>
  end_op();
80105874:	e8 07 d9 ff ff       	call   80103180 <end_op>
  return 0;
80105879:	83 c4 10             	add    $0x10,%esp
8010587c:	31 c0                	xor    %eax,%eax
}
8010587e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105881:	5b                   	pop    %ebx
80105882:	5e                   	pop    %esi
80105883:	5f                   	pop    %edi
80105884:	5d                   	pop    %ebp
80105885:	c3                   	ret    
80105886:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010588d:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(dp);
80105890:	83 ec 0c             	sub    $0xc,%esp
80105893:	56                   	push   %esi
80105894:	e8 47 c5 ff ff       	call   80101de0 <iunlockput>
    goto bad;
80105899:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
8010589c:	83 ec 0c             	sub    $0xc,%esp
8010589f:	53                   	push   %ebx
801058a0:	e8 9b c2 ff ff       	call   80101b40 <ilock>
  ip->nlink--;
801058a5:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801058aa:	89 1c 24             	mov    %ebx,(%esp)
801058ad:	e8 ce c1 ff ff       	call   80101a80 <iupdate>
  iunlockput(ip);
801058b2:	89 1c 24             	mov    %ebx,(%esp)
801058b5:	e8 26 c5 ff ff       	call   80101de0 <iunlockput>
  end_op();
801058ba:	e8 c1 d8 ff ff       	call   80103180 <end_op>
  return -1;
801058bf:	83 c4 10             	add    $0x10,%esp
801058c2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058c7:	eb b5                	jmp    8010587e <sys_link+0xde>
    iunlockput(ip);
801058c9:	83 ec 0c             	sub    $0xc,%esp
801058cc:	53                   	push   %ebx
801058cd:	e8 0e c5 ff ff       	call   80101de0 <iunlockput>
    end_op();
801058d2:	e8 a9 d8 ff ff       	call   80103180 <end_op>
    return -1;
801058d7:	83 c4 10             	add    $0x10,%esp
801058da:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058df:	eb 9d                	jmp    8010587e <sys_link+0xde>
    end_op();
801058e1:	e8 9a d8 ff ff       	call   80103180 <end_op>
    return -1;
801058e6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058eb:	eb 91                	jmp    8010587e <sys_link+0xde>
801058ed:	8d 76 00             	lea    0x0(%esi),%esi

801058f0 <sys_unlink>:
{
801058f0:	f3 0f 1e fb          	endbr32 
801058f4:	55                   	push   %ebp
801058f5:	89 e5                	mov    %esp,%ebp
801058f7:	57                   	push   %edi
801058f8:	56                   	push   %esi
  if(argstr(0, &path) < 0)
801058f9:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
801058fc:	53                   	push   %ebx
801058fd:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
80105900:	50                   	push   %eax
80105901:	6a 00                	push   $0x0
80105903:	e8 08 fa ff ff       	call   80105310 <argstr>
80105908:	83 c4 10             	add    $0x10,%esp
8010590b:	85 c0                	test   %eax,%eax
8010590d:	0f 88 7d 01 00 00    	js     80105a90 <sys_unlink+0x1a0>
  begin_op();
80105913:	e8 f8 d7 ff ff       	call   80103110 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105918:	8d 5d ca             	lea    -0x36(%ebp),%ebx
8010591b:	83 ec 08             	sub    $0x8,%esp
8010591e:	53                   	push   %ebx
8010591f:	ff 75 c0             	pushl  -0x40(%ebp)
80105922:	e8 09 cb ff ff       	call   80102430 <nameiparent>
80105927:	83 c4 10             	add    $0x10,%esp
8010592a:	89 c6                	mov    %eax,%esi
8010592c:	85 c0                	test   %eax,%eax
8010592e:	0f 84 66 01 00 00    	je     80105a9a <sys_unlink+0x1aa>
  ilock(dp);
80105934:	83 ec 0c             	sub    $0xc,%esp
80105937:	50                   	push   %eax
80105938:	e8 03 c2 ff ff       	call   80101b40 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
8010593d:	58                   	pop    %eax
8010593e:	5a                   	pop    %edx
8010593f:	68 24 83 10 80       	push   $0x80108324
80105944:	53                   	push   %ebx
80105945:	e8 26 c7 ff ff       	call   80102070 <namecmp>
8010594a:	83 c4 10             	add    $0x10,%esp
8010594d:	85 c0                	test   %eax,%eax
8010594f:	0f 84 03 01 00 00    	je     80105a58 <sys_unlink+0x168>
80105955:	83 ec 08             	sub    $0x8,%esp
80105958:	68 23 83 10 80       	push   $0x80108323
8010595d:	53                   	push   %ebx
8010595e:	e8 0d c7 ff ff       	call   80102070 <namecmp>
80105963:	83 c4 10             	add    $0x10,%esp
80105966:	85 c0                	test   %eax,%eax
80105968:	0f 84 ea 00 00 00    	je     80105a58 <sys_unlink+0x168>
  if((ip = dirlookup(dp, name, &off)) == 0)
8010596e:	83 ec 04             	sub    $0x4,%esp
80105971:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105974:	50                   	push   %eax
80105975:	53                   	push   %ebx
80105976:	56                   	push   %esi
80105977:	e8 14 c7 ff ff       	call   80102090 <dirlookup>
8010597c:	83 c4 10             	add    $0x10,%esp
8010597f:	89 c3                	mov    %eax,%ebx
80105981:	85 c0                	test   %eax,%eax
80105983:	0f 84 cf 00 00 00    	je     80105a58 <sys_unlink+0x168>
  ilock(ip);
80105989:	83 ec 0c             	sub    $0xc,%esp
8010598c:	50                   	push   %eax
8010598d:	e8 ae c1 ff ff       	call   80101b40 <ilock>
  if(ip->nlink < 1)
80105992:	83 c4 10             	add    $0x10,%esp
80105995:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
8010599a:	0f 8e 23 01 00 00    	jle    80105ac3 <sys_unlink+0x1d3>
  if(ip->type == T_DIR && !isdirempty(ip)){
801059a0:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801059a5:	8d 7d d8             	lea    -0x28(%ebp),%edi
801059a8:	74 66                	je     80105a10 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
801059aa:	83 ec 04             	sub    $0x4,%esp
801059ad:	6a 10                	push   $0x10
801059af:	6a 00                	push   $0x0
801059b1:	57                   	push   %edi
801059b2:	e8 c9 f5 ff ff       	call   80104f80 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801059b7:	6a 10                	push   $0x10
801059b9:	ff 75 c4             	pushl  -0x3c(%ebp)
801059bc:	57                   	push   %edi
801059bd:	56                   	push   %esi
801059be:	e8 7d c5 ff ff       	call   80101f40 <writei>
801059c3:	83 c4 20             	add    $0x20,%esp
801059c6:	83 f8 10             	cmp    $0x10,%eax
801059c9:	0f 85 e7 00 00 00    	jne    80105ab6 <sys_unlink+0x1c6>
  if(ip->type == T_DIR){
801059cf:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801059d4:	0f 84 96 00 00 00    	je     80105a70 <sys_unlink+0x180>
  iunlockput(dp);
801059da:	83 ec 0c             	sub    $0xc,%esp
801059dd:	56                   	push   %esi
801059de:	e8 fd c3 ff ff       	call   80101de0 <iunlockput>
  ip->nlink--;
801059e3:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801059e8:	89 1c 24             	mov    %ebx,(%esp)
801059eb:	e8 90 c0 ff ff       	call   80101a80 <iupdate>
  iunlockput(ip);
801059f0:	89 1c 24             	mov    %ebx,(%esp)
801059f3:	e8 e8 c3 ff ff       	call   80101de0 <iunlockput>
  end_op();
801059f8:	e8 83 d7 ff ff       	call   80103180 <end_op>
  return 0;
801059fd:	83 c4 10             	add    $0x10,%esp
80105a00:	31 c0                	xor    %eax,%eax
}
80105a02:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105a05:	5b                   	pop    %ebx
80105a06:	5e                   	pop    %esi
80105a07:	5f                   	pop    %edi
80105a08:	5d                   	pop    %ebp
80105a09:	c3                   	ret    
80105a0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105a10:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105a14:	76 94                	jbe    801059aa <sys_unlink+0xba>
80105a16:	ba 20 00 00 00       	mov    $0x20,%edx
80105a1b:	eb 0b                	jmp    80105a28 <sys_unlink+0x138>
80105a1d:	8d 76 00             	lea    0x0(%esi),%esi
80105a20:	83 c2 10             	add    $0x10,%edx
80105a23:	39 53 58             	cmp    %edx,0x58(%ebx)
80105a26:	76 82                	jbe    801059aa <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105a28:	6a 10                	push   $0x10
80105a2a:	52                   	push   %edx
80105a2b:	57                   	push   %edi
80105a2c:	53                   	push   %ebx
80105a2d:	89 55 b4             	mov    %edx,-0x4c(%ebp)
80105a30:	e8 0b c4 ff ff       	call   80101e40 <readi>
80105a35:	83 c4 10             	add    $0x10,%esp
80105a38:	8b 55 b4             	mov    -0x4c(%ebp),%edx
80105a3b:	83 f8 10             	cmp    $0x10,%eax
80105a3e:	75 69                	jne    80105aa9 <sys_unlink+0x1b9>
    if(de.inum != 0)
80105a40:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105a45:	74 d9                	je     80105a20 <sys_unlink+0x130>
    iunlockput(ip);
80105a47:	83 ec 0c             	sub    $0xc,%esp
80105a4a:	53                   	push   %ebx
80105a4b:	e8 90 c3 ff ff       	call   80101de0 <iunlockput>
    goto bad;
80105a50:	83 c4 10             	add    $0x10,%esp
80105a53:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105a57:	90                   	nop
  iunlockput(dp);
80105a58:	83 ec 0c             	sub    $0xc,%esp
80105a5b:	56                   	push   %esi
80105a5c:	e8 7f c3 ff ff       	call   80101de0 <iunlockput>
  end_op();
80105a61:	e8 1a d7 ff ff       	call   80103180 <end_op>
  return -1;
80105a66:	83 c4 10             	add    $0x10,%esp
80105a69:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a6e:	eb 92                	jmp    80105a02 <sys_unlink+0x112>
    iupdate(dp);
80105a70:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
80105a73:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
80105a78:	56                   	push   %esi
80105a79:	e8 02 c0 ff ff       	call   80101a80 <iupdate>
80105a7e:	83 c4 10             	add    $0x10,%esp
80105a81:	e9 54 ff ff ff       	jmp    801059da <sys_unlink+0xea>
80105a86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a8d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105a90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a95:	e9 68 ff ff ff       	jmp    80105a02 <sys_unlink+0x112>
    end_op();
80105a9a:	e8 e1 d6 ff ff       	call   80103180 <end_op>
    return -1;
80105a9f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105aa4:	e9 59 ff ff ff       	jmp    80105a02 <sys_unlink+0x112>
      panic("isdirempty: readi");
80105aa9:	83 ec 0c             	sub    $0xc,%esp
80105aac:	68 48 83 10 80       	push   $0x80108348
80105ab1:	e8 da a8 ff ff       	call   80100390 <panic>
    panic("unlink: writei");
80105ab6:	83 ec 0c             	sub    $0xc,%esp
80105ab9:	68 5a 83 10 80       	push   $0x8010835a
80105abe:	e8 cd a8 ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
80105ac3:	83 ec 0c             	sub    $0xc,%esp
80105ac6:	68 36 83 10 80       	push   $0x80108336
80105acb:	e8 c0 a8 ff ff       	call   80100390 <panic>

80105ad0 <sys_open>:

int
sys_open(void)
{
80105ad0:	f3 0f 1e fb          	endbr32 
80105ad4:	55                   	push   %ebp
80105ad5:	89 e5                	mov    %esp,%ebp
80105ad7:	57                   	push   %edi
80105ad8:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105ad9:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105adc:	53                   	push   %ebx
80105add:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105ae0:	50                   	push   %eax
80105ae1:	6a 00                	push   $0x0
80105ae3:	e8 28 f8 ff ff       	call   80105310 <argstr>
80105ae8:	83 c4 10             	add    $0x10,%esp
80105aeb:	85 c0                	test   %eax,%eax
80105aed:	0f 88 8a 00 00 00    	js     80105b7d <sys_open+0xad>
80105af3:	83 ec 08             	sub    $0x8,%esp
80105af6:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105af9:	50                   	push   %eax
80105afa:	6a 01                	push   $0x1
80105afc:	e8 5f f7 ff ff       	call   80105260 <argint>
80105b01:	83 c4 10             	add    $0x10,%esp
80105b04:	85 c0                	test   %eax,%eax
80105b06:	78 75                	js     80105b7d <sys_open+0xad>
    return -1;

  begin_op();
80105b08:	e8 03 d6 ff ff       	call   80103110 <begin_op>

  if(omode & O_CREATE){
80105b0d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105b11:	75 75                	jne    80105b88 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105b13:	83 ec 0c             	sub    $0xc,%esp
80105b16:	ff 75 e0             	pushl  -0x20(%ebp)
80105b19:	e8 f2 c8 ff ff       	call   80102410 <namei>
80105b1e:	83 c4 10             	add    $0x10,%esp
80105b21:	89 c6                	mov    %eax,%esi
80105b23:	85 c0                	test   %eax,%eax
80105b25:	74 7e                	je     80105ba5 <sys_open+0xd5>
      end_op();
      return -1;
    }
    ilock(ip);
80105b27:	83 ec 0c             	sub    $0xc,%esp
80105b2a:	50                   	push   %eax
80105b2b:	e8 10 c0 ff ff       	call   80101b40 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105b30:	83 c4 10             	add    $0x10,%esp
80105b33:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105b38:	0f 84 c2 00 00 00    	je     80105c00 <sys_open+0x130>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105b3e:	e8 9d b6 ff ff       	call   801011e0 <filealloc>
80105b43:	89 c7                	mov    %eax,%edi
80105b45:	85 c0                	test   %eax,%eax
80105b47:	74 23                	je     80105b6c <sys_open+0x9c>
  struct proc *curproc = myproc();
80105b49:	e8 42 e2 ff ff       	call   80103d90 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105b4e:	31 db                	xor    %ebx,%ebx
    if(curproc->ofile[fd] == 0){
80105b50:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105b54:	85 d2                	test   %edx,%edx
80105b56:	74 60                	je     80105bb8 <sys_open+0xe8>
  for(fd = 0; fd < NOFILE; fd++){
80105b58:	83 c3 01             	add    $0x1,%ebx
80105b5b:	83 fb 10             	cmp    $0x10,%ebx
80105b5e:	75 f0                	jne    80105b50 <sys_open+0x80>
    if(f)
      fileclose(f);
80105b60:	83 ec 0c             	sub    $0xc,%esp
80105b63:	57                   	push   %edi
80105b64:	e8 37 b7 ff ff       	call   801012a0 <fileclose>
80105b69:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80105b6c:	83 ec 0c             	sub    $0xc,%esp
80105b6f:	56                   	push   %esi
80105b70:	e8 6b c2 ff ff       	call   80101de0 <iunlockput>
    end_op();
80105b75:	e8 06 d6 ff ff       	call   80103180 <end_op>
    return -1;
80105b7a:	83 c4 10             	add    $0x10,%esp
80105b7d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105b82:	eb 6d                	jmp    80105bf1 <sys_open+0x121>
80105b84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
80105b88:	83 ec 0c             	sub    $0xc,%esp
80105b8b:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105b8e:	31 c9                	xor    %ecx,%ecx
80105b90:	ba 02 00 00 00       	mov    $0x2,%edx
80105b95:	6a 00                	push   $0x0
80105b97:	e8 24 f8 ff ff       	call   801053c0 <create>
    if(ip == 0){
80105b9c:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
80105b9f:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80105ba1:	85 c0                	test   %eax,%eax
80105ba3:	75 99                	jne    80105b3e <sys_open+0x6e>
      end_op();
80105ba5:	e8 d6 d5 ff ff       	call   80103180 <end_op>
      return -1;
80105baa:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105baf:	eb 40                	jmp    80105bf1 <sys_open+0x121>
80105bb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
80105bb8:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105bbb:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
80105bbf:	56                   	push   %esi
80105bc0:	e8 5b c0 ff ff       	call   80101c20 <iunlock>
  end_op();
80105bc5:	e8 b6 d5 ff ff       	call   80103180 <end_op>

  f->type = FD_INODE;
80105bca:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105bd0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105bd3:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105bd6:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
80105bd9:	89 d0                	mov    %edx,%eax
  f->off = 0;
80105bdb:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80105be2:	f7 d0                	not    %eax
80105be4:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105be7:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80105bea:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105bed:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80105bf1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105bf4:	89 d8                	mov    %ebx,%eax
80105bf6:	5b                   	pop    %ebx
80105bf7:	5e                   	pop    %esi
80105bf8:	5f                   	pop    %edi
80105bf9:	5d                   	pop    %ebp
80105bfa:	c3                   	ret    
80105bfb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105bff:	90                   	nop
    if(ip->type == T_DIR && omode != O_RDONLY){
80105c00:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105c03:	85 c9                	test   %ecx,%ecx
80105c05:	0f 84 33 ff ff ff    	je     80105b3e <sys_open+0x6e>
80105c0b:	e9 5c ff ff ff       	jmp    80105b6c <sys_open+0x9c>

80105c10 <sys_mkdir>:

int
sys_mkdir(void)
{
80105c10:	f3 0f 1e fb          	endbr32 
80105c14:	55                   	push   %ebp
80105c15:	89 e5                	mov    %esp,%ebp
80105c17:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105c1a:	e8 f1 d4 ff ff       	call   80103110 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80105c1f:	83 ec 08             	sub    $0x8,%esp
80105c22:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105c25:	50                   	push   %eax
80105c26:	6a 00                	push   $0x0
80105c28:	e8 e3 f6 ff ff       	call   80105310 <argstr>
80105c2d:	83 c4 10             	add    $0x10,%esp
80105c30:	85 c0                	test   %eax,%eax
80105c32:	78 34                	js     80105c68 <sys_mkdir+0x58>
80105c34:	83 ec 0c             	sub    $0xc,%esp
80105c37:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c3a:	31 c9                	xor    %ecx,%ecx
80105c3c:	ba 01 00 00 00       	mov    $0x1,%edx
80105c41:	6a 00                	push   $0x0
80105c43:	e8 78 f7 ff ff       	call   801053c0 <create>
80105c48:	83 c4 10             	add    $0x10,%esp
80105c4b:	85 c0                	test   %eax,%eax
80105c4d:	74 19                	je     80105c68 <sys_mkdir+0x58>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105c4f:	83 ec 0c             	sub    $0xc,%esp
80105c52:	50                   	push   %eax
80105c53:	e8 88 c1 ff ff       	call   80101de0 <iunlockput>
  end_op();
80105c58:	e8 23 d5 ff ff       	call   80103180 <end_op>
  return 0;
80105c5d:	83 c4 10             	add    $0x10,%esp
80105c60:	31 c0                	xor    %eax,%eax
}
80105c62:	c9                   	leave  
80105c63:	c3                   	ret    
80105c64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    end_op();
80105c68:	e8 13 d5 ff ff       	call   80103180 <end_op>
    return -1;
80105c6d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105c72:	c9                   	leave  
80105c73:	c3                   	ret    
80105c74:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c7b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105c7f:	90                   	nop

80105c80 <sys_mknod>:

int
sys_mknod(void)
{
80105c80:	f3 0f 1e fb          	endbr32 
80105c84:	55                   	push   %ebp
80105c85:	89 e5                	mov    %esp,%ebp
80105c87:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105c8a:	e8 81 d4 ff ff       	call   80103110 <begin_op>
  if((argstr(0, &path)) < 0 ||
80105c8f:	83 ec 08             	sub    $0x8,%esp
80105c92:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105c95:	50                   	push   %eax
80105c96:	6a 00                	push   $0x0
80105c98:	e8 73 f6 ff ff       	call   80105310 <argstr>
80105c9d:	83 c4 10             	add    $0x10,%esp
80105ca0:	85 c0                	test   %eax,%eax
80105ca2:	78 64                	js     80105d08 <sys_mknod+0x88>
     argint(1, &major) < 0 ||
80105ca4:	83 ec 08             	sub    $0x8,%esp
80105ca7:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105caa:	50                   	push   %eax
80105cab:	6a 01                	push   $0x1
80105cad:	e8 ae f5 ff ff       	call   80105260 <argint>
  if((argstr(0, &path)) < 0 ||
80105cb2:	83 c4 10             	add    $0x10,%esp
80105cb5:	85 c0                	test   %eax,%eax
80105cb7:	78 4f                	js     80105d08 <sys_mknod+0x88>
     argint(2, &minor) < 0 ||
80105cb9:	83 ec 08             	sub    $0x8,%esp
80105cbc:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105cbf:	50                   	push   %eax
80105cc0:	6a 02                	push   $0x2
80105cc2:	e8 99 f5 ff ff       	call   80105260 <argint>
     argint(1, &major) < 0 ||
80105cc7:	83 c4 10             	add    $0x10,%esp
80105cca:	85 c0                	test   %eax,%eax
80105ccc:	78 3a                	js     80105d08 <sys_mknod+0x88>
     (ip = create(path, T_DEV, major, minor)) == 0){
80105cce:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
80105cd2:	83 ec 0c             	sub    $0xc,%esp
80105cd5:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105cd9:	ba 03 00 00 00       	mov    $0x3,%edx
80105cde:	50                   	push   %eax
80105cdf:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105ce2:	e8 d9 f6 ff ff       	call   801053c0 <create>
     argint(2, &minor) < 0 ||
80105ce7:	83 c4 10             	add    $0x10,%esp
80105cea:	85 c0                	test   %eax,%eax
80105cec:	74 1a                	je     80105d08 <sys_mknod+0x88>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105cee:	83 ec 0c             	sub    $0xc,%esp
80105cf1:	50                   	push   %eax
80105cf2:	e8 e9 c0 ff ff       	call   80101de0 <iunlockput>
  end_op();
80105cf7:	e8 84 d4 ff ff       	call   80103180 <end_op>
  return 0;
80105cfc:	83 c4 10             	add    $0x10,%esp
80105cff:	31 c0                	xor    %eax,%eax
}
80105d01:	c9                   	leave  
80105d02:	c3                   	ret    
80105d03:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105d07:	90                   	nop
    end_op();
80105d08:	e8 73 d4 ff ff       	call   80103180 <end_op>
    return -1;
80105d0d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105d12:	c9                   	leave  
80105d13:	c3                   	ret    
80105d14:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d1b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105d1f:	90                   	nop

80105d20 <sys_chdir>:

int
sys_chdir(void)
{
80105d20:	f3 0f 1e fb          	endbr32 
80105d24:	55                   	push   %ebp
80105d25:	89 e5                	mov    %esp,%ebp
80105d27:	56                   	push   %esi
80105d28:	53                   	push   %ebx
80105d29:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105d2c:	e8 5f e0 ff ff       	call   80103d90 <myproc>
80105d31:	89 c6                	mov    %eax,%esi
  
  begin_op();
80105d33:	e8 d8 d3 ff ff       	call   80103110 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105d38:	83 ec 08             	sub    $0x8,%esp
80105d3b:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105d3e:	50                   	push   %eax
80105d3f:	6a 00                	push   $0x0
80105d41:	e8 ca f5 ff ff       	call   80105310 <argstr>
80105d46:	83 c4 10             	add    $0x10,%esp
80105d49:	85 c0                	test   %eax,%eax
80105d4b:	78 73                	js     80105dc0 <sys_chdir+0xa0>
80105d4d:	83 ec 0c             	sub    $0xc,%esp
80105d50:	ff 75 f4             	pushl  -0xc(%ebp)
80105d53:	e8 b8 c6 ff ff       	call   80102410 <namei>
80105d58:	83 c4 10             	add    $0x10,%esp
80105d5b:	89 c3                	mov    %eax,%ebx
80105d5d:	85 c0                	test   %eax,%eax
80105d5f:	74 5f                	je     80105dc0 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
80105d61:	83 ec 0c             	sub    $0xc,%esp
80105d64:	50                   	push   %eax
80105d65:	e8 d6 bd ff ff       	call   80101b40 <ilock>
  if(ip->type != T_DIR){
80105d6a:	83 c4 10             	add    $0x10,%esp
80105d6d:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105d72:	75 2c                	jne    80105da0 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105d74:	83 ec 0c             	sub    $0xc,%esp
80105d77:	53                   	push   %ebx
80105d78:	e8 a3 be ff ff       	call   80101c20 <iunlock>
  iput(curproc->cwd);
80105d7d:	58                   	pop    %eax
80105d7e:	ff 76 68             	pushl  0x68(%esi)
80105d81:	e8 ea be ff ff       	call   80101c70 <iput>
  end_op();
80105d86:	e8 f5 d3 ff ff       	call   80103180 <end_op>
  curproc->cwd = ip;
80105d8b:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
80105d8e:	83 c4 10             	add    $0x10,%esp
80105d91:	31 c0                	xor    %eax,%eax
}
80105d93:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105d96:	5b                   	pop    %ebx
80105d97:	5e                   	pop    %esi
80105d98:	5d                   	pop    %ebp
80105d99:	c3                   	ret    
80105d9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(ip);
80105da0:	83 ec 0c             	sub    $0xc,%esp
80105da3:	53                   	push   %ebx
80105da4:	e8 37 c0 ff ff       	call   80101de0 <iunlockput>
    end_op();
80105da9:	e8 d2 d3 ff ff       	call   80103180 <end_op>
    return -1;
80105dae:	83 c4 10             	add    $0x10,%esp
80105db1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105db6:	eb db                	jmp    80105d93 <sys_chdir+0x73>
80105db8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105dbf:	90                   	nop
    end_op();
80105dc0:	e8 bb d3 ff ff       	call   80103180 <end_op>
    return -1;
80105dc5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105dca:	eb c7                	jmp    80105d93 <sys_chdir+0x73>
80105dcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105dd0 <sys_exec>:

int
sys_exec(void)
{
80105dd0:	f3 0f 1e fb          	endbr32 
80105dd4:	55                   	push   %ebp
80105dd5:	89 e5                	mov    %esp,%ebp
80105dd7:	57                   	push   %edi
80105dd8:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105dd9:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
80105ddf:	53                   	push   %ebx
80105de0:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105de6:	50                   	push   %eax
80105de7:	6a 00                	push   $0x0
80105de9:	e8 22 f5 ff ff       	call   80105310 <argstr>
80105dee:	83 c4 10             	add    $0x10,%esp
80105df1:	85 c0                	test   %eax,%eax
80105df3:	0f 88 8b 00 00 00    	js     80105e84 <sys_exec+0xb4>
80105df9:	83 ec 08             	sub    $0x8,%esp
80105dfc:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105e02:	50                   	push   %eax
80105e03:	6a 01                	push   $0x1
80105e05:	e8 56 f4 ff ff       	call   80105260 <argint>
80105e0a:	83 c4 10             	add    $0x10,%esp
80105e0d:	85 c0                	test   %eax,%eax
80105e0f:	78 73                	js     80105e84 <sys_exec+0xb4>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105e11:	83 ec 04             	sub    $0x4,%esp
80105e14:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
  for(i=0;; i++){
80105e1a:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105e1c:	68 80 00 00 00       	push   $0x80
80105e21:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105e27:	6a 00                	push   $0x0
80105e29:	50                   	push   %eax
80105e2a:	e8 51 f1 ff ff       	call   80104f80 <memset>
80105e2f:	83 c4 10             	add    $0x10,%esp
80105e32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105e38:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105e3e:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80105e45:	83 ec 08             	sub    $0x8,%esp
80105e48:	57                   	push   %edi
80105e49:	01 f0                	add    %esi,%eax
80105e4b:	50                   	push   %eax
80105e4c:	e8 6f f3 ff ff       	call   801051c0 <fetchint>
80105e51:	83 c4 10             	add    $0x10,%esp
80105e54:	85 c0                	test   %eax,%eax
80105e56:	78 2c                	js     80105e84 <sys_exec+0xb4>
      return -1;
    if(uarg == 0){
80105e58:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105e5e:	85 c0                	test   %eax,%eax
80105e60:	74 36                	je     80105e98 <sys_exec+0xc8>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105e62:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80105e68:	83 ec 08             	sub    $0x8,%esp
80105e6b:	8d 14 31             	lea    (%ecx,%esi,1),%edx
80105e6e:	52                   	push   %edx
80105e6f:	50                   	push   %eax
80105e70:	e8 8b f3 ff ff       	call   80105200 <fetchstr>
80105e75:	83 c4 10             	add    $0x10,%esp
80105e78:	85 c0                	test   %eax,%eax
80105e7a:	78 08                	js     80105e84 <sys_exec+0xb4>
  for(i=0;; i++){
80105e7c:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105e7f:	83 fb 20             	cmp    $0x20,%ebx
80105e82:	75 b4                	jne    80105e38 <sys_exec+0x68>
      return -1;
  }
  return exec(path, argv);
}
80105e84:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
80105e87:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105e8c:	5b                   	pop    %ebx
80105e8d:	5e                   	pop    %esi
80105e8e:	5f                   	pop    %edi
80105e8f:	5d                   	pop    %ebp
80105e90:	c3                   	ret    
80105e91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
80105e98:	83 ec 08             	sub    $0x8,%esp
80105e9b:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
      argv[i] = 0;
80105ea1:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105ea8:	00 00 00 00 
  return exec(path, argv);
80105eac:	50                   	push   %eax
80105ead:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
80105eb3:	e8 98 af ff ff       	call   80100e50 <exec>
80105eb8:	83 c4 10             	add    $0x10,%esp
}
80105ebb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105ebe:	5b                   	pop    %ebx
80105ebf:	5e                   	pop    %esi
80105ec0:	5f                   	pop    %edi
80105ec1:	5d                   	pop    %ebp
80105ec2:	c3                   	ret    
80105ec3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105eca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105ed0 <sys_pipe>:

int
sys_pipe(void)
{
80105ed0:	f3 0f 1e fb          	endbr32 
80105ed4:	55                   	push   %ebp
80105ed5:	89 e5                	mov    %esp,%ebp
80105ed7:	57                   	push   %edi
80105ed8:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105ed9:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105edc:	53                   	push   %ebx
80105edd:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105ee0:	6a 08                	push   $0x8
80105ee2:	50                   	push   %eax
80105ee3:	6a 00                	push   $0x0
80105ee5:	e8 c6 f3 ff ff       	call   801052b0 <argptr>
80105eea:	83 c4 10             	add    $0x10,%esp
80105eed:	85 c0                	test   %eax,%eax
80105eef:	78 4e                	js     80105f3f <sys_pipe+0x6f>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105ef1:	83 ec 08             	sub    $0x8,%esp
80105ef4:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105ef7:	50                   	push   %eax
80105ef8:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105efb:	50                   	push   %eax
80105efc:	e8 cf d8 ff ff       	call   801037d0 <pipealloc>
80105f01:	83 c4 10             	add    $0x10,%esp
80105f04:	85 c0                	test   %eax,%eax
80105f06:	78 37                	js     80105f3f <sys_pipe+0x6f>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105f08:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
80105f0b:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105f0d:	e8 7e de ff ff       	call   80103d90 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105f12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[fd] == 0){
80105f18:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105f1c:	85 f6                	test   %esi,%esi
80105f1e:	74 30                	je     80105f50 <sys_pipe+0x80>
  for(fd = 0; fd < NOFILE; fd++){
80105f20:	83 c3 01             	add    $0x1,%ebx
80105f23:	83 fb 10             	cmp    $0x10,%ebx
80105f26:	75 f0                	jne    80105f18 <sys_pipe+0x48>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
80105f28:	83 ec 0c             	sub    $0xc,%esp
80105f2b:	ff 75 e0             	pushl  -0x20(%ebp)
80105f2e:	e8 6d b3 ff ff       	call   801012a0 <fileclose>
    fileclose(wf);
80105f33:	58                   	pop    %eax
80105f34:	ff 75 e4             	pushl  -0x1c(%ebp)
80105f37:	e8 64 b3 ff ff       	call   801012a0 <fileclose>
    return -1;
80105f3c:	83 c4 10             	add    $0x10,%esp
80105f3f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f44:	eb 5b                	jmp    80105fa1 <sys_pipe+0xd1>
80105f46:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f4d:	8d 76 00             	lea    0x0(%esi),%esi
      curproc->ofile[fd] = f;
80105f50:	8d 73 08             	lea    0x8(%ebx),%esi
80105f53:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105f57:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
80105f5a:	e8 31 de ff ff       	call   80103d90 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105f5f:	31 d2                	xor    %edx,%edx
80105f61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80105f68:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80105f6c:	85 c9                	test   %ecx,%ecx
80105f6e:	74 20                	je     80105f90 <sys_pipe+0xc0>
  for(fd = 0; fd < NOFILE; fd++){
80105f70:	83 c2 01             	add    $0x1,%edx
80105f73:	83 fa 10             	cmp    $0x10,%edx
80105f76:	75 f0                	jne    80105f68 <sys_pipe+0x98>
      myproc()->ofile[fd0] = 0;
80105f78:	e8 13 de ff ff       	call   80103d90 <myproc>
80105f7d:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105f84:	00 
80105f85:	eb a1                	jmp    80105f28 <sys_pipe+0x58>
80105f87:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f8e:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
80105f90:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
  }
  fd[0] = fd0;
80105f94:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105f97:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105f99:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105f9c:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80105f9f:	31 c0                	xor    %eax,%eax
}
80105fa1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105fa4:	5b                   	pop    %ebx
80105fa5:	5e                   	pop    %esi
80105fa6:	5f                   	pop    %edi
80105fa7:	5d                   	pop    %ebp
80105fa8:	c3                   	ret    
80105fa9:	66 90                	xchg   %ax,%ax
80105fab:	66 90                	xchg   %ax,%ax
80105fad:	66 90                	xchg   %ax,%ax
80105faf:	90                   	nop

80105fb0 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80105fb0:	f3 0f 1e fb          	endbr32 
  return fork();
80105fb4:	e9 b7 df ff ff       	jmp    80103f70 <fork>
80105fb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105fc0 <sys_exit>:
}

int
sys_exit(void)
{
80105fc0:	f3 0f 1e fb          	endbr32 
80105fc4:	55                   	push   %ebp
80105fc5:	89 e5                	mov    %esp,%ebp
80105fc7:	83 ec 08             	sub    $0x8,%esp
  exit();
80105fca:	e8 b1 e6 ff ff       	call   80104680 <exit>
  return 0;  // not reached
}
80105fcf:	31 c0                	xor    %eax,%eax
80105fd1:	c9                   	leave  
80105fd2:	c3                   	ret    
80105fd3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105fda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105fe0 <sys_wait>:

int
sys_wait(void)
{
80105fe0:	f3 0f 1e fb          	endbr32 
  return wait();
80105fe4:	e9 e7 e8 ff ff       	jmp    801048d0 <wait>
80105fe9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105ff0 <sys_kill>:
}

int
sys_kill(void)
{
80105ff0:	f3 0f 1e fb          	endbr32 
80105ff4:	55                   	push   %ebp
80105ff5:	89 e5                	mov    %esp,%ebp
80105ff7:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105ffa:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105ffd:	50                   	push   %eax
80105ffe:	6a 00                	push   $0x0
80106000:	e8 5b f2 ff ff       	call   80105260 <argint>
80106005:	83 c4 10             	add    $0x10,%esp
80106008:	85 c0                	test   %eax,%eax
8010600a:	78 14                	js     80106020 <sys_kill+0x30>
    return -1;
  return kill(pid);
8010600c:	83 ec 0c             	sub    $0xc,%esp
8010600f:	ff 75 f4             	pushl  -0xc(%ebp)
80106012:	e8 29 ea ff ff       	call   80104a40 <kill>
80106017:	83 c4 10             	add    $0x10,%esp
}
8010601a:	c9                   	leave  
8010601b:	c3                   	ret    
8010601c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106020:	c9                   	leave  
    return -1;
80106021:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106026:	c3                   	ret    
80106027:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010602e:	66 90                	xchg   %ax,%ax

80106030 <sys_getpid>:

int
sys_getpid(void)
{
80106030:	f3 0f 1e fb          	endbr32 
80106034:	55                   	push   %ebp
80106035:	89 e5                	mov    %esp,%ebp
80106037:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
8010603a:	e8 51 dd ff ff       	call   80103d90 <myproc>
8010603f:	8b 40 10             	mov    0x10(%eax),%eax
}
80106042:	c9                   	leave  
80106043:	c3                   	ret    
80106044:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010604b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010604f:	90                   	nop

80106050 <sys_sbrk>:

int
sys_sbrk(void)
{
80106050:	f3 0f 1e fb          	endbr32 
80106054:	55                   	push   %ebp
80106055:	89 e5                	mov    %esp,%ebp
80106057:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80106058:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
8010605b:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010605e:	50                   	push   %eax
8010605f:	6a 00                	push   $0x0
80106061:	e8 fa f1 ff ff       	call   80105260 <argint>
80106066:	83 c4 10             	add    $0x10,%esp
80106069:	85 c0                	test   %eax,%eax
8010606b:	78 23                	js     80106090 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
8010606d:	e8 1e dd ff ff       	call   80103d90 <myproc>
  if(growproc(n) < 0)
80106072:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80106075:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80106077:	ff 75 f4             	pushl  -0xc(%ebp)
8010607a:	e8 71 de ff ff       	call   80103ef0 <growproc>
8010607f:	83 c4 10             	add    $0x10,%esp
80106082:	85 c0                	test   %eax,%eax
80106084:	78 0a                	js     80106090 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80106086:	89 d8                	mov    %ebx,%eax
80106088:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010608b:	c9                   	leave  
8010608c:	c3                   	ret    
8010608d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80106090:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106095:	eb ef                	jmp    80106086 <sys_sbrk+0x36>
80106097:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010609e:	66 90                	xchg   %ax,%ax

801060a0 <sys_sleep>:

int
sys_sleep(void)
{
801060a0:	f3 0f 1e fb          	endbr32 
801060a4:	55                   	push   %ebp
801060a5:	89 e5                	mov    %esp,%ebp
801060a7:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
801060a8:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801060ab:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
801060ae:	50                   	push   %eax
801060af:	6a 00                	push   $0x0
801060b1:	e8 aa f1 ff ff       	call   80105260 <argint>
801060b6:	83 c4 10             	add    $0x10,%esp
801060b9:	85 c0                	test   %eax,%eax
801060bb:	0f 88 86 00 00 00    	js     80106147 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
801060c1:	83 ec 0c             	sub    $0xc,%esp
801060c4:	68 c0 5c 11 80       	push   $0x80115cc0
801060c9:	e8 a2 ed ff ff       	call   80104e70 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801060ce:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
801060d1:	8b 1d 00 65 11 80    	mov    0x80116500,%ebx
  while(ticks - ticks0 < n){
801060d7:	83 c4 10             	add    $0x10,%esp
801060da:	85 d2                	test   %edx,%edx
801060dc:	75 23                	jne    80106101 <sys_sleep+0x61>
801060de:	eb 50                	jmp    80106130 <sys_sleep+0x90>
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
801060e0:	83 ec 08             	sub    $0x8,%esp
801060e3:	68 c0 5c 11 80       	push   $0x80115cc0
801060e8:	68 00 65 11 80       	push   $0x80116500
801060ed:	e8 1e e7 ff ff       	call   80104810 <sleep>
  while(ticks - ticks0 < n){
801060f2:	a1 00 65 11 80       	mov    0x80116500,%eax
801060f7:	83 c4 10             	add    $0x10,%esp
801060fa:	29 d8                	sub    %ebx,%eax
801060fc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801060ff:	73 2f                	jae    80106130 <sys_sleep+0x90>
    if(myproc()->killed){
80106101:	e8 8a dc ff ff       	call   80103d90 <myproc>
80106106:	8b 40 24             	mov    0x24(%eax),%eax
80106109:	85 c0                	test   %eax,%eax
8010610b:	74 d3                	je     801060e0 <sys_sleep+0x40>
      release(&tickslock);
8010610d:	83 ec 0c             	sub    $0xc,%esp
80106110:	68 c0 5c 11 80       	push   $0x80115cc0
80106115:	e8 16 ee ff ff       	call   80104f30 <release>
  }
  release(&tickslock);
  return 0;
}
8010611a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return -1;
8010611d:	83 c4 10             	add    $0x10,%esp
80106120:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106125:	c9                   	leave  
80106126:	c3                   	ret    
80106127:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010612e:	66 90                	xchg   %ax,%ax
  release(&tickslock);
80106130:	83 ec 0c             	sub    $0xc,%esp
80106133:	68 c0 5c 11 80       	push   $0x80115cc0
80106138:	e8 f3 ed ff ff       	call   80104f30 <release>
  return 0;
8010613d:	83 c4 10             	add    $0x10,%esp
80106140:	31 c0                	xor    %eax,%eax
}
80106142:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106145:	c9                   	leave  
80106146:	c3                   	ret    
    return -1;
80106147:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010614c:	eb f4                	jmp    80106142 <sys_sleep+0xa2>
8010614e:	66 90                	xchg   %ax,%ax

80106150 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80106150:	f3 0f 1e fb          	endbr32 
80106154:	55                   	push   %ebp
80106155:	89 e5                	mov    %esp,%ebp
80106157:	53                   	push   %ebx
80106158:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
8010615b:	68 c0 5c 11 80       	push   $0x80115cc0
80106160:	e8 0b ed ff ff       	call   80104e70 <acquire>
  xticks = ticks;
80106165:	8b 1d 00 65 11 80    	mov    0x80116500,%ebx
  release(&tickslock);
8010616b:	c7 04 24 c0 5c 11 80 	movl   $0x80115cc0,(%esp)
80106172:	e8 b9 ed ff ff       	call   80104f30 <release>
  return xticks;
}
80106177:	89 d8                	mov    %ebx,%eax
80106179:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010617c:	c9                   	leave  
8010617d:	c3                   	ret    
8010617e:	66 90                	xchg   %ax,%ax

80106180 <sys_changeQueue>:

int sys_changeQueue(void) {
80106180:	f3 0f 1e fb          	endbr32 
80106184:	55                   	push   %ebp
80106185:	89 e5                	mov    %esp,%ebp
80106187:	83 ec 20             	sub    $0x20,%esp
  int pid, queue;
  if (argint(0, &pid) < 0) 
8010618a:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010618d:	50                   	push   %eax
8010618e:	6a 00                	push   $0x0
80106190:	e8 cb f0 ff ff       	call   80105260 <argint>
80106195:	83 c4 10             	add    $0x10,%esp
80106198:	85 c0                	test   %eax,%eax
8010619a:	78 2c                	js     801061c8 <sys_changeQueue+0x48>
    return -1;
  if (argint(1, &queue) < 0) 
8010619c:	83 ec 08             	sub    $0x8,%esp
8010619f:	8d 45 f4             	lea    -0xc(%ebp),%eax
801061a2:	50                   	push   %eax
801061a3:	6a 01                	push   $0x1
801061a5:	e8 b6 f0 ff ff       	call   80105260 <argint>
801061aa:	83 c4 10             	add    $0x10,%esp
801061ad:	85 c0                	test   %eax,%eax
801061af:	78 17                	js     801061c8 <sys_changeQueue+0x48>
    return -1;
  return changeQueue(pid, queue);
801061b1:	83 ec 08             	sub    $0x8,%esp
801061b4:	ff 75 f4             	pushl  -0xc(%ebp)
801061b7:	ff 75 f0             	pushl  -0x10(%ebp)
801061ba:	e8 a1 df ff ff       	call   80104160 <changeQueue>
801061bf:	83 c4 10             	add    $0x10,%esp
}
801061c2:	c9                   	leave  
801061c3:	c3                   	ret    
801061c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801061c8:	c9                   	leave  
    return -1;
801061c9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801061ce:	c3                   	ret    
801061cf:	90                   	nop

801061d0 <sys_printProcess>:

int sys_printProcess(void) {
801061d0:	f3 0f 1e fb          	endbr32 
  return printProcess();
801061d4:	e9 d7 df ff ff       	jmp    801041b0 <printProcess>
801061d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801061e0 <sys_changeProcessMHRRN>:
}

int sys_changeProcessMHRRN(void) {
801061e0:	f3 0f 1e fb          	endbr32 
801061e4:	55                   	push   %ebp
801061e5:	89 e5                	mov    %esp,%ebp
801061e7:	83 ec 20             	sub    $0x20,%esp
  int pid, priority;
  if (argint(0, &pid) < 0) 
801061ea:	8d 45 f0             	lea    -0x10(%ebp),%eax
801061ed:	50                   	push   %eax
801061ee:	6a 00                	push   $0x0
801061f0:	e8 6b f0 ff ff       	call   80105260 <argint>
801061f5:	83 c4 10             	add    $0x10,%esp
801061f8:	85 c0                	test   %eax,%eax
801061fa:	78 2c                	js     80106228 <sys_changeProcessMHRRN+0x48>
    return -1;
  if (argint(1, &priority) < 0) 
801061fc:	83 ec 08             	sub    $0x8,%esp
801061ff:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106202:	50                   	push   %eax
80106203:	6a 01                	push   $0x1
80106205:	e8 56 f0 ff ff       	call   80105260 <argint>
8010620a:	83 c4 10             	add    $0x10,%esp
8010620d:	85 c0                	test   %eax,%eax
8010620f:	78 17                	js     80106228 <sys_changeProcessMHRRN+0x48>
    return -1;
  return changeProcessMHRRN(pid, priority);
80106211:	83 ec 08             	sub    $0x8,%esp
80106214:	ff 75 f4             	pushl  -0xc(%ebp)
80106217:	ff 75 f0             	pushl  -0x10(%ebp)
8010621a:	e8 71 de ff ff       	call   80104090 <changeProcessMHRRN>
8010621f:	83 c4 10             	add    $0x10,%esp
}
80106222:	c9                   	leave  
80106223:	c3                   	ret    
80106224:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106228:	c9                   	leave  
    return -1;
80106229:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010622e:	c3                   	ret    
8010622f:	90                   	nop

80106230 <sys_changeSystemMHRRN>:

int sys_changeSystemMHRRN(void) {
80106230:	f3 0f 1e fb          	endbr32 
80106234:	55                   	push   %ebp
80106235:	89 e5                	mov    %esp,%ebp
80106237:	83 ec 20             	sub    $0x20,%esp
  int priority;
  if (argint(0, &priority) < 0) 
8010623a:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010623d:	50                   	push   %eax
8010623e:	6a 00                	push   $0x0
80106240:	e8 1b f0 ff ff       	call   80105260 <argint>
80106245:	83 c4 10             	add    $0x10,%esp
80106248:	85 c0                	test   %eax,%eax
8010624a:	78 14                	js     80106260 <sys_changeSystemMHRRN+0x30>
    return -1;
  return changeSystemMHRRN(priority);
8010624c:	83 ec 0c             	sub    $0xc,%esp
8010624f:	ff 75 f4             	pushl  -0xc(%ebp)
80106252:	e8 b9 de ff ff       	call   80104110 <changeSystemMHRRN>
80106257:	83 c4 10             	add    $0x10,%esp
}
8010625a:	c9                   	leave  
8010625b:	c3                   	ret    
8010625c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106260:	c9                   	leave  
    return -1;
80106261:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106266:	c3                   	ret    

80106267 <alltraps>:
80106267:	1e                   	push   %ds
80106268:	06                   	push   %es
80106269:	0f a0                	push   %fs
8010626b:	0f a8                	push   %gs
8010626d:	60                   	pusha  
8010626e:	66 b8 10 00          	mov    $0x10,%ax
80106272:	8e d8                	mov    %eax,%ds
80106274:	8e c0                	mov    %eax,%es
80106276:	54                   	push   %esp
80106277:	e8 c4 00 00 00       	call   80106340 <trap>
8010627c:	83 c4 04             	add    $0x4,%esp

8010627f <trapret>:
8010627f:	61                   	popa   
80106280:	0f a9                	pop    %gs
80106282:	0f a1                	pop    %fs
80106284:	07                   	pop    %es
80106285:	1f                   	pop    %ds
80106286:	83 c4 08             	add    $0x8,%esp
80106289:	cf                   	iret   
8010628a:	66 90                	xchg   %ax,%ax
8010628c:	66 90                	xchg   %ax,%ax
8010628e:	66 90                	xchg   %ax,%ax

80106290 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106290:	f3 0f 1e fb          	endbr32 
80106294:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80106295:	31 c0                	xor    %eax,%eax
{
80106297:	89 e5                	mov    %esp,%ebp
80106299:	83 ec 08             	sub    $0x8,%esp
8010629c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
801062a0:	8b 14 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%edx
801062a7:	c7 04 c5 02 5d 11 80 	movl   $0x8e000008,-0x7feea2fe(,%eax,8)
801062ae:	08 00 00 8e 
801062b2:	66 89 14 c5 00 5d 11 	mov    %dx,-0x7feea300(,%eax,8)
801062b9:	80 
801062ba:	c1 ea 10             	shr    $0x10,%edx
801062bd:	66 89 14 c5 06 5d 11 	mov    %dx,-0x7feea2fa(,%eax,8)
801062c4:	80 
  for(i = 0; i < 256; i++)
801062c5:	83 c0 01             	add    $0x1,%eax
801062c8:	3d 00 01 00 00       	cmp    $0x100,%eax
801062cd:	75 d1                	jne    801062a0 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
801062cf:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801062d2:	a1 08 b1 10 80       	mov    0x8010b108,%eax
801062d7:	c7 05 02 5f 11 80 08 	movl   $0xef000008,0x80115f02
801062de:	00 00 ef 
  initlock(&tickslock, "time");
801062e1:	68 69 83 10 80       	push   $0x80108369
801062e6:	68 c0 5c 11 80       	push   $0x80115cc0
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801062eb:	66 a3 00 5f 11 80    	mov    %ax,0x80115f00
801062f1:	c1 e8 10             	shr    $0x10,%eax
801062f4:	66 a3 06 5f 11 80    	mov    %ax,0x80115f06
  initlock(&tickslock, "time");
801062fa:	e8 f1 e9 ff ff       	call   80104cf0 <initlock>
}
801062ff:	83 c4 10             	add    $0x10,%esp
80106302:	c9                   	leave  
80106303:	c3                   	ret    
80106304:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010630b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010630f:	90                   	nop

80106310 <idtinit>:

void
idtinit(void)
{
80106310:	f3 0f 1e fb          	endbr32 
80106314:	55                   	push   %ebp
  pd[0] = size-1;
80106315:	b8 ff 07 00 00       	mov    $0x7ff,%eax
8010631a:	89 e5                	mov    %esp,%ebp
8010631c:	83 ec 10             	sub    $0x10,%esp
8010631f:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80106323:	b8 00 5d 11 80       	mov    $0x80115d00,%eax
80106328:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
8010632c:	c1 e8 10             	shr    $0x10,%eax
8010632f:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80106333:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106336:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80106339:	c9                   	leave  
8010633a:	c3                   	ret    
8010633b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010633f:	90                   	nop

80106340 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80106340:	f3 0f 1e fb          	endbr32 
80106344:	55                   	push   %ebp
80106345:	89 e5                	mov    %esp,%ebp
80106347:	57                   	push   %edi
80106348:	56                   	push   %esi
80106349:	53                   	push   %ebx
8010634a:	83 ec 1c             	sub    $0x1c,%esp
8010634d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
80106350:	8b 43 30             	mov    0x30(%ebx),%eax
80106353:	83 f8 40             	cmp    $0x40,%eax
80106356:	0f 84 bc 01 00 00    	je     80106518 <trap+0x1d8>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
8010635c:	83 e8 20             	sub    $0x20,%eax
8010635f:	83 f8 1f             	cmp    $0x1f,%eax
80106362:	77 08                	ja     8010636c <trap+0x2c>
80106364:	3e ff 24 85 10 84 10 	notrack jmp *-0x7fef7bf0(,%eax,4)
8010636b:	80 
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
8010636c:	e8 1f da ff ff       	call   80103d90 <myproc>
80106371:	8b 7b 38             	mov    0x38(%ebx),%edi
80106374:	85 c0                	test   %eax,%eax
80106376:	0f 84 eb 01 00 00    	je     80106567 <trap+0x227>
8010637c:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80106380:	0f 84 e1 01 00 00    	je     80106567 <trap+0x227>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80106386:	0f 20 d1             	mov    %cr2,%ecx
80106389:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010638c:	e8 df d9 ff ff       	call   80103d70 <cpuid>
80106391:	8b 73 30             	mov    0x30(%ebx),%esi
80106394:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106397:	8b 43 34             	mov    0x34(%ebx),%eax
8010639a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
8010639d:	e8 ee d9 ff ff       	call   80103d90 <myproc>
801063a2:	89 45 e0             	mov    %eax,-0x20(%ebp)
801063a5:	e8 e6 d9 ff ff       	call   80103d90 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801063aa:	8b 4d d8             	mov    -0x28(%ebp),%ecx
801063ad:	8b 55 dc             	mov    -0x24(%ebp),%edx
801063b0:	51                   	push   %ecx
801063b1:	57                   	push   %edi
801063b2:	52                   	push   %edx
801063b3:	ff 75 e4             	pushl  -0x1c(%ebp)
801063b6:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
801063b7:	8b 75 e0             	mov    -0x20(%ebp),%esi
801063ba:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801063bd:	56                   	push   %esi
801063be:	ff 70 10             	pushl  0x10(%eax)
801063c1:	68 cc 83 10 80       	push   $0x801083cc
801063c6:	e8 e5 a2 ff ff       	call   801006b0 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
801063cb:	83 c4 20             	add    $0x20,%esp
801063ce:	e8 bd d9 ff ff       	call   80103d90 <myproc>
801063d3:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801063da:	e8 b1 d9 ff ff       	call   80103d90 <myproc>
801063df:	85 c0                	test   %eax,%eax
801063e1:	74 1d                	je     80106400 <trap+0xc0>
801063e3:	e8 a8 d9 ff ff       	call   80103d90 <myproc>
801063e8:	8b 50 24             	mov    0x24(%eax),%edx
801063eb:	85 d2                	test   %edx,%edx
801063ed:	74 11                	je     80106400 <trap+0xc0>
801063ef:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
801063f3:	83 e0 03             	and    $0x3,%eax
801063f6:	66 83 f8 03          	cmp    $0x3,%ax
801063fa:	0f 84 50 01 00 00    	je     80106550 <trap+0x210>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80106400:	e8 8b d9 ff ff       	call   80103d90 <myproc>
80106405:	85 c0                	test   %eax,%eax
80106407:	74 0f                	je     80106418 <trap+0xd8>
80106409:	e8 82 d9 ff ff       	call   80103d90 <myproc>
8010640e:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80106412:	0f 84 e8 00 00 00    	je     80106500 <trap+0x1c0>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106418:	e8 73 d9 ff ff       	call   80103d90 <myproc>
8010641d:	85 c0                	test   %eax,%eax
8010641f:	74 1d                	je     8010643e <trap+0xfe>
80106421:	e8 6a d9 ff ff       	call   80103d90 <myproc>
80106426:	8b 40 24             	mov    0x24(%eax),%eax
80106429:	85 c0                	test   %eax,%eax
8010642b:	74 11                	je     8010643e <trap+0xfe>
8010642d:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80106431:	83 e0 03             	and    $0x3,%eax
80106434:	66 83 f8 03          	cmp    $0x3,%ax
80106438:	0f 84 03 01 00 00    	je     80106541 <trap+0x201>
    exit();
}
8010643e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106441:	5b                   	pop    %ebx
80106442:	5e                   	pop    %esi
80106443:	5f                   	pop    %edi
80106444:	5d                   	pop    %ebp
80106445:	c3                   	ret    
    ideintr();
80106446:	e8 75 c1 ff ff       	call   801025c0 <ideintr>
    lapiceoi();
8010644b:	e8 50 c8 ff ff       	call   80102ca0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106450:	e8 3b d9 ff ff       	call   80103d90 <myproc>
80106455:	85 c0                	test   %eax,%eax
80106457:	75 8a                	jne    801063e3 <trap+0xa3>
80106459:	eb a5                	jmp    80106400 <trap+0xc0>
    if(cpuid() == 0){
8010645b:	e8 10 d9 ff ff       	call   80103d70 <cpuid>
80106460:	85 c0                	test   %eax,%eax
80106462:	75 e7                	jne    8010644b <trap+0x10b>
      acquire(&tickslock);
80106464:	83 ec 0c             	sub    $0xc,%esp
80106467:	68 c0 5c 11 80       	push   $0x80115cc0
8010646c:	e8 ff e9 ff ff       	call   80104e70 <acquire>
      wakeup(&ticks);
80106471:	c7 04 24 00 65 11 80 	movl   $0x80116500,(%esp)
      ticks++;
80106478:	83 05 00 65 11 80 01 	addl   $0x1,0x80116500
      wakeup(&ticks);
8010647f:	e8 4c e5 ff ff       	call   801049d0 <wakeup>
      release(&tickslock);
80106484:	c7 04 24 c0 5c 11 80 	movl   $0x80115cc0,(%esp)
8010648b:	e8 a0 ea ff ff       	call   80104f30 <release>
80106490:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
80106493:	eb b6                	jmp    8010644b <trap+0x10b>
    kbdintr();
80106495:	e8 c6 c6 ff ff       	call   80102b60 <kbdintr>
    lapiceoi();
8010649a:	e8 01 c8 ff ff       	call   80102ca0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010649f:	e8 ec d8 ff ff       	call   80103d90 <myproc>
801064a4:	85 c0                	test   %eax,%eax
801064a6:	0f 85 37 ff ff ff    	jne    801063e3 <trap+0xa3>
801064ac:	e9 4f ff ff ff       	jmp    80106400 <trap+0xc0>
    uartintr();
801064b1:	e8 4a 02 00 00       	call   80106700 <uartintr>
    lapiceoi();
801064b6:	e8 e5 c7 ff ff       	call   80102ca0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801064bb:	e8 d0 d8 ff ff       	call   80103d90 <myproc>
801064c0:	85 c0                	test   %eax,%eax
801064c2:	0f 85 1b ff ff ff    	jne    801063e3 <trap+0xa3>
801064c8:	e9 33 ff ff ff       	jmp    80106400 <trap+0xc0>
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801064cd:	8b 7b 38             	mov    0x38(%ebx),%edi
801064d0:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
801064d4:	e8 97 d8 ff ff       	call   80103d70 <cpuid>
801064d9:	57                   	push   %edi
801064da:	56                   	push   %esi
801064db:	50                   	push   %eax
801064dc:	68 74 83 10 80       	push   $0x80108374
801064e1:	e8 ca a1 ff ff       	call   801006b0 <cprintf>
    lapiceoi();
801064e6:	e8 b5 c7 ff ff       	call   80102ca0 <lapiceoi>
    break;
801064eb:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801064ee:	e8 9d d8 ff ff       	call   80103d90 <myproc>
801064f3:	85 c0                	test   %eax,%eax
801064f5:	0f 85 e8 fe ff ff    	jne    801063e3 <trap+0xa3>
801064fb:	e9 00 ff ff ff       	jmp    80106400 <trap+0xc0>
  if(myproc() && myproc()->state == RUNNING &&
80106500:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80106504:	0f 85 0e ff ff ff    	jne    80106418 <trap+0xd8>
    yield();
8010650a:	e8 b1 e2 ff ff       	call   801047c0 <yield>
8010650f:	e9 04 ff ff ff       	jmp    80106418 <trap+0xd8>
80106514:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
80106518:	e8 73 d8 ff ff       	call   80103d90 <myproc>
8010651d:	8b 70 24             	mov    0x24(%eax),%esi
80106520:	85 f6                	test   %esi,%esi
80106522:	75 3c                	jne    80106560 <trap+0x220>
    myproc()->tf = tf;
80106524:	e8 67 d8 ff ff       	call   80103d90 <myproc>
80106529:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
8010652c:	e8 1f ee ff ff       	call   80105350 <syscall>
    if(myproc()->killed)
80106531:	e8 5a d8 ff ff       	call   80103d90 <myproc>
80106536:	8b 48 24             	mov    0x24(%eax),%ecx
80106539:	85 c9                	test   %ecx,%ecx
8010653b:	0f 84 fd fe ff ff    	je     8010643e <trap+0xfe>
}
80106541:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106544:	5b                   	pop    %ebx
80106545:	5e                   	pop    %esi
80106546:	5f                   	pop    %edi
80106547:	5d                   	pop    %ebp
      exit();
80106548:	e9 33 e1 ff ff       	jmp    80104680 <exit>
8010654d:	8d 76 00             	lea    0x0(%esi),%esi
    exit();
80106550:	e8 2b e1 ff ff       	call   80104680 <exit>
80106555:	e9 a6 fe ff ff       	jmp    80106400 <trap+0xc0>
8010655a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80106560:	e8 1b e1 ff ff       	call   80104680 <exit>
80106565:	eb bd                	jmp    80106524 <trap+0x1e4>
80106567:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
8010656a:	e8 01 d8 ff ff       	call   80103d70 <cpuid>
8010656f:	83 ec 0c             	sub    $0xc,%esp
80106572:	56                   	push   %esi
80106573:	57                   	push   %edi
80106574:	50                   	push   %eax
80106575:	ff 73 30             	pushl  0x30(%ebx)
80106578:	68 98 83 10 80       	push   $0x80108398
8010657d:	e8 2e a1 ff ff       	call   801006b0 <cprintf>
      panic("trap");
80106582:	83 c4 14             	add    $0x14,%esp
80106585:	68 6e 83 10 80       	push   $0x8010836e
8010658a:	e8 01 9e ff ff       	call   80100390 <panic>
8010658f:	90                   	nop

80106590 <uartgetc>:
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
80106590:	f3 0f 1e fb          	endbr32 
  if(!uart)
80106594:	a1 e4 b5 10 80       	mov    0x8010b5e4,%eax
80106599:	85 c0                	test   %eax,%eax
8010659b:	74 1b                	je     801065b8 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010659d:	ba fd 03 00 00       	mov    $0x3fd,%edx
801065a2:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
801065a3:	a8 01                	test   $0x1,%al
801065a5:	74 11                	je     801065b8 <uartgetc+0x28>
801065a7:	ba f8 03 00 00       	mov    $0x3f8,%edx
801065ac:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
801065ad:	0f b6 c0             	movzbl %al,%eax
801065b0:	c3                   	ret    
801065b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801065b8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801065bd:	c3                   	ret    
801065be:	66 90                	xchg   %ax,%ax

801065c0 <uartputc.part.0>:
uartputc(int c)
801065c0:	55                   	push   %ebp
801065c1:	89 e5                	mov    %esp,%ebp
801065c3:	57                   	push   %edi
801065c4:	89 c7                	mov    %eax,%edi
801065c6:	56                   	push   %esi
801065c7:	be fd 03 00 00       	mov    $0x3fd,%esi
801065cc:	53                   	push   %ebx
801065cd:	bb 80 00 00 00       	mov    $0x80,%ebx
801065d2:	83 ec 0c             	sub    $0xc,%esp
801065d5:	eb 1b                	jmp    801065f2 <uartputc.part.0+0x32>
801065d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801065de:	66 90                	xchg   %ax,%ax
    microdelay(10);
801065e0:	83 ec 0c             	sub    $0xc,%esp
801065e3:	6a 0a                	push   $0xa
801065e5:	e8 d6 c6 ff ff       	call   80102cc0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801065ea:	83 c4 10             	add    $0x10,%esp
801065ed:	83 eb 01             	sub    $0x1,%ebx
801065f0:	74 07                	je     801065f9 <uartputc.part.0+0x39>
801065f2:	89 f2                	mov    %esi,%edx
801065f4:	ec                   	in     (%dx),%al
801065f5:	a8 20                	test   $0x20,%al
801065f7:	74 e7                	je     801065e0 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801065f9:	ba f8 03 00 00       	mov    $0x3f8,%edx
801065fe:	89 f8                	mov    %edi,%eax
80106600:	ee                   	out    %al,(%dx)
}
80106601:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106604:	5b                   	pop    %ebx
80106605:	5e                   	pop    %esi
80106606:	5f                   	pop    %edi
80106607:	5d                   	pop    %ebp
80106608:	c3                   	ret    
80106609:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106610 <uartinit>:
{
80106610:	f3 0f 1e fb          	endbr32 
80106614:	55                   	push   %ebp
80106615:	31 c9                	xor    %ecx,%ecx
80106617:	89 c8                	mov    %ecx,%eax
80106619:	89 e5                	mov    %esp,%ebp
8010661b:	57                   	push   %edi
8010661c:	56                   	push   %esi
8010661d:	53                   	push   %ebx
8010661e:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80106623:	89 da                	mov    %ebx,%edx
80106625:	83 ec 0c             	sub    $0xc,%esp
80106628:	ee                   	out    %al,(%dx)
80106629:	bf fb 03 00 00       	mov    $0x3fb,%edi
8010662e:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80106633:	89 fa                	mov    %edi,%edx
80106635:	ee                   	out    %al,(%dx)
80106636:	b8 0c 00 00 00       	mov    $0xc,%eax
8010663b:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106640:	ee                   	out    %al,(%dx)
80106641:	be f9 03 00 00       	mov    $0x3f9,%esi
80106646:	89 c8                	mov    %ecx,%eax
80106648:	89 f2                	mov    %esi,%edx
8010664a:	ee                   	out    %al,(%dx)
8010664b:	b8 03 00 00 00       	mov    $0x3,%eax
80106650:	89 fa                	mov    %edi,%edx
80106652:	ee                   	out    %al,(%dx)
80106653:	ba fc 03 00 00       	mov    $0x3fc,%edx
80106658:	89 c8                	mov    %ecx,%eax
8010665a:	ee                   	out    %al,(%dx)
8010665b:	b8 01 00 00 00       	mov    $0x1,%eax
80106660:	89 f2                	mov    %esi,%edx
80106662:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106663:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106668:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80106669:	3c ff                	cmp    $0xff,%al
8010666b:	74 52                	je     801066bf <uartinit+0xaf>
  uart = 1;
8010666d:	c7 05 e4 b5 10 80 01 	movl   $0x1,0x8010b5e4
80106674:	00 00 00 
80106677:	89 da                	mov    %ebx,%edx
80106679:	ec                   	in     (%dx),%al
8010667a:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010667f:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80106680:	83 ec 08             	sub    $0x8,%esp
80106683:	be 76 00 00 00       	mov    $0x76,%esi
  for(p="xv6...\n"; *p; p++)
80106688:	bb 90 84 10 80       	mov    $0x80108490,%ebx
  ioapicenable(IRQ_COM1, 0);
8010668d:	6a 00                	push   $0x0
8010668f:	6a 04                	push   $0x4
80106691:	e8 7a c1 ff ff       	call   80102810 <ioapicenable>
80106696:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80106699:	b8 78 00 00 00       	mov    $0x78,%eax
8010669e:	eb 04                	jmp    801066a4 <uartinit+0x94>
801066a0:	0f b6 73 01          	movzbl 0x1(%ebx),%esi
  if(!uart)
801066a4:	8b 15 e4 b5 10 80    	mov    0x8010b5e4,%edx
801066aa:	85 d2                	test   %edx,%edx
801066ac:	74 08                	je     801066b6 <uartinit+0xa6>
    uartputc(*p);
801066ae:	0f be c0             	movsbl %al,%eax
801066b1:	e8 0a ff ff ff       	call   801065c0 <uartputc.part.0>
  for(p="xv6...\n"; *p; p++)
801066b6:	89 f0                	mov    %esi,%eax
801066b8:	83 c3 01             	add    $0x1,%ebx
801066bb:	84 c0                	test   %al,%al
801066bd:	75 e1                	jne    801066a0 <uartinit+0x90>
}
801066bf:	8d 65 f4             	lea    -0xc(%ebp),%esp
801066c2:	5b                   	pop    %ebx
801066c3:	5e                   	pop    %esi
801066c4:	5f                   	pop    %edi
801066c5:	5d                   	pop    %ebp
801066c6:	c3                   	ret    
801066c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801066ce:	66 90                	xchg   %ax,%ax

801066d0 <uartputc>:
{
801066d0:	f3 0f 1e fb          	endbr32 
801066d4:	55                   	push   %ebp
  if(!uart)
801066d5:	8b 15 e4 b5 10 80    	mov    0x8010b5e4,%edx
{
801066db:	89 e5                	mov    %esp,%ebp
801066dd:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
801066e0:	85 d2                	test   %edx,%edx
801066e2:	74 0c                	je     801066f0 <uartputc+0x20>
}
801066e4:	5d                   	pop    %ebp
801066e5:	e9 d6 fe ff ff       	jmp    801065c0 <uartputc.part.0>
801066ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801066f0:	5d                   	pop    %ebp
801066f1:	c3                   	ret    
801066f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801066f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106700 <uartintr>:

void
uartintr(void)
{
80106700:	f3 0f 1e fb          	endbr32 
80106704:	55                   	push   %ebp
80106705:	89 e5                	mov    %esp,%ebp
80106707:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
8010670a:	68 90 65 10 80       	push   $0x80106590
8010670f:	e8 ac a1 ff ff       	call   801008c0 <consoleintr>
}
80106714:	83 c4 10             	add    $0x10,%esp
80106717:	c9                   	leave  
80106718:	c3                   	ret    

80106719 <vector0>:
80106719:	6a 00                	push   $0x0
8010671b:	6a 00                	push   $0x0
8010671d:	e9 45 fb ff ff       	jmp    80106267 <alltraps>

80106722 <vector1>:
80106722:	6a 00                	push   $0x0
80106724:	6a 01                	push   $0x1
80106726:	e9 3c fb ff ff       	jmp    80106267 <alltraps>

8010672b <vector2>:
8010672b:	6a 00                	push   $0x0
8010672d:	6a 02                	push   $0x2
8010672f:	e9 33 fb ff ff       	jmp    80106267 <alltraps>

80106734 <vector3>:
80106734:	6a 00                	push   $0x0
80106736:	6a 03                	push   $0x3
80106738:	e9 2a fb ff ff       	jmp    80106267 <alltraps>

8010673d <vector4>:
8010673d:	6a 00                	push   $0x0
8010673f:	6a 04                	push   $0x4
80106741:	e9 21 fb ff ff       	jmp    80106267 <alltraps>

80106746 <vector5>:
80106746:	6a 00                	push   $0x0
80106748:	6a 05                	push   $0x5
8010674a:	e9 18 fb ff ff       	jmp    80106267 <alltraps>

8010674f <vector6>:
8010674f:	6a 00                	push   $0x0
80106751:	6a 06                	push   $0x6
80106753:	e9 0f fb ff ff       	jmp    80106267 <alltraps>

80106758 <vector7>:
80106758:	6a 00                	push   $0x0
8010675a:	6a 07                	push   $0x7
8010675c:	e9 06 fb ff ff       	jmp    80106267 <alltraps>

80106761 <vector8>:
80106761:	6a 08                	push   $0x8
80106763:	e9 ff fa ff ff       	jmp    80106267 <alltraps>

80106768 <vector9>:
80106768:	6a 00                	push   $0x0
8010676a:	6a 09                	push   $0x9
8010676c:	e9 f6 fa ff ff       	jmp    80106267 <alltraps>

80106771 <vector10>:
80106771:	6a 0a                	push   $0xa
80106773:	e9 ef fa ff ff       	jmp    80106267 <alltraps>

80106778 <vector11>:
80106778:	6a 0b                	push   $0xb
8010677a:	e9 e8 fa ff ff       	jmp    80106267 <alltraps>

8010677f <vector12>:
8010677f:	6a 0c                	push   $0xc
80106781:	e9 e1 fa ff ff       	jmp    80106267 <alltraps>

80106786 <vector13>:
80106786:	6a 0d                	push   $0xd
80106788:	e9 da fa ff ff       	jmp    80106267 <alltraps>

8010678d <vector14>:
8010678d:	6a 0e                	push   $0xe
8010678f:	e9 d3 fa ff ff       	jmp    80106267 <alltraps>

80106794 <vector15>:
80106794:	6a 00                	push   $0x0
80106796:	6a 0f                	push   $0xf
80106798:	e9 ca fa ff ff       	jmp    80106267 <alltraps>

8010679d <vector16>:
8010679d:	6a 00                	push   $0x0
8010679f:	6a 10                	push   $0x10
801067a1:	e9 c1 fa ff ff       	jmp    80106267 <alltraps>

801067a6 <vector17>:
801067a6:	6a 11                	push   $0x11
801067a8:	e9 ba fa ff ff       	jmp    80106267 <alltraps>

801067ad <vector18>:
801067ad:	6a 00                	push   $0x0
801067af:	6a 12                	push   $0x12
801067b1:	e9 b1 fa ff ff       	jmp    80106267 <alltraps>

801067b6 <vector19>:
801067b6:	6a 00                	push   $0x0
801067b8:	6a 13                	push   $0x13
801067ba:	e9 a8 fa ff ff       	jmp    80106267 <alltraps>

801067bf <vector20>:
801067bf:	6a 00                	push   $0x0
801067c1:	6a 14                	push   $0x14
801067c3:	e9 9f fa ff ff       	jmp    80106267 <alltraps>

801067c8 <vector21>:
801067c8:	6a 00                	push   $0x0
801067ca:	6a 15                	push   $0x15
801067cc:	e9 96 fa ff ff       	jmp    80106267 <alltraps>

801067d1 <vector22>:
801067d1:	6a 00                	push   $0x0
801067d3:	6a 16                	push   $0x16
801067d5:	e9 8d fa ff ff       	jmp    80106267 <alltraps>

801067da <vector23>:
801067da:	6a 00                	push   $0x0
801067dc:	6a 17                	push   $0x17
801067de:	e9 84 fa ff ff       	jmp    80106267 <alltraps>

801067e3 <vector24>:
801067e3:	6a 00                	push   $0x0
801067e5:	6a 18                	push   $0x18
801067e7:	e9 7b fa ff ff       	jmp    80106267 <alltraps>

801067ec <vector25>:
801067ec:	6a 00                	push   $0x0
801067ee:	6a 19                	push   $0x19
801067f0:	e9 72 fa ff ff       	jmp    80106267 <alltraps>

801067f5 <vector26>:
801067f5:	6a 00                	push   $0x0
801067f7:	6a 1a                	push   $0x1a
801067f9:	e9 69 fa ff ff       	jmp    80106267 <alltraps>

801067fe <vector27>:
801067fe:	6a 00                	push   $0x0
80106800:	6a 1b                	push   $0x1b
80106802:	e9 60 fa ff ff       	jmp    80106267 <alltraps>

80106807 <vector28>:
80106807:	6a 00                	push   $0x0
80106809:	6a 1c                	push   $0x1c
8010680b:	e9 57 fa ff ff       	jmp    80106267 <alltraps>

80106810 <vector29>:
80106810:	6a 00                	push   $0x0
80106812:	6a 1d                	push   $0x1d
80106814:	e9 4e fa ff ff       	jmp    80106267 <alltraps>

80106819 <vector30>:
80106819:	6a 00                	push   $0x0
8010681b:	6a 1e                	push   $0x1e
8010681d:	e9 45 fa ff ff       	jmp    80106267 <alltraps>

80106822 <vector31>:
80106822:	6a 00                	push   $0x0
80106824:	6a 1f                	push   $0x1f
80106826:	e9 3c fa ff ff       	jmp    80106267 <alltraps>

8010682b <vector32>:
8010682b:	6a 00                	push   $0x0
8010682d:	6a 20                	push   $0x20
8010682f:	e9 33 fa ff ff       	jmp    80106267 <alltraps>

80106834 <vector33>:
80106834:	6a 00                	push   $0x0
80106836:	6a 21                	push   $0x21
80106838:	e9 2a fa ff ff       	jmp    80106267 <alltraps>

8010683d <vector34>:
8010683d:	6a 00                	push   $0x0
8010683f:	6a 22                	push   $0x22
80106841:	e9 21 fa ff ff       	jmp    80106267 <alltraps>

80106846 <vector35>:
80106846:	6a 00                	push   $0x0
80106848:	6a 23                	push   $0x23
8010684a:	e9 18 fa ff ff       	jmp    80106267 <alltraps>

8010684f <vector36>:
8010684f:	6a 00                	push   $0x0
80106851:	6a 24                	push   $0x24
80106853:	e9 0f fa ff ff       	jmp    80106267 <alltraps>

80106858 <vector37>:
80106858:	6a 00                	push   $0x0
8010685a:	6a 25                	push   $0x25
8010685c:	e9 06 fa ff ff       	jmp    80106267 <alltraps>

80106861 <vector38>:
80106861:	6a 00                	push   $0x0
80106863:	6a 26                	push   $0x26
80106865:	e9 fd f9 ff ff       	jmp    80106267 <alltraps>

8010686a <vector39>:
8010686a:	6a 00                	push   $0x0
8010686c:	6a 27                	push   $0x27
8010686e:	e9 f4 f9 ff ff       	jmp    80106267 <alltraps>

80106873 <vector40>:
80106873:	6a 00                	push   $0x0
80106875:	6a 28                	push   $0x28
80106877:	e9 eb f9 ff ff       	jmp    80106267 <alltraps>

8010687c <vector41>:
8010687c:	6a 00                	push   $0x0
8010687e:	6a 29                	push   $0x29
80106880:	e9 e2 f9 ff ff       	jmp    80106267 <alltraps>

80106885 <vector42>:
80106885:	6a 00                	push   $0x0
80106887:	6a 2a                	push   $0x2a
80106889:	e9 d9 f9 ff ff       	jmp    80106267 <alltraps>

8010688e <vector43>:
8010688e:	6a 00                	push   $0x0
80106890:	6a 2b                	push   $0x2b
80106892:	e9 d0 f9 ff ff       	jmp    80106267 <alltraps>

80106897 <vector44>:
80106897:	6a 00                	push   $0x0
80106899:	6a 2c                	push   $0x2c
8010689b:	e9 c7 f9 ff ff       	jmp    80106267 <alltraps>

801068a0 <vector45>:
801068a0:	6a 00                	push   $0x0
801068a2:	6a 2d                	push   $0x2d
801068a4:	e9 be f9 ff ff       	jmp    80106267 <alltraps>

801068a9 <vector46>:
801068a9:	6a 00                	push   $0x0
801068ab:	6a 2e                	push   $0x2e
801068ad:	e9 b5 f9 ff ff       	jmp    80106267 <alltraps>

801068b2 <vector47>:
801068b2:	6a 00                	push   $0x0
801068b4:	6a 2f                	push   $0x2f
801068b6:	e9 ac f9 ff ff       	jmp    80106267 <alltraps>

801068bb <vector48>:
801068bb:	6a 00                	push   $0x0
801068bd:	6a 30                	push   $0x30
801068bf:	e9 a3 f9 ff ff       	jmp    80106267 <alltraps>

801068c4 <vector49>:
801068c4:	6a 00                	push   $0x0
801068c6:	6a 31                	push   $0x31
801068c8:	e9 9a f9 ff ff       	jmp    80106267 <alltraps>

801068cd <vector50>:
801068cd:	6a 00                	push   $0x0
801068cf:	6a 32                	push   $0x32
801068d1:	e9 91 f9 ff ff       	jmp    80106267 <alltraps>

801068d6 <vector51>:
801068d6:	6a 00                	push   $0x0
801068d8:	6a 33                	push   $0x33
801068da:	e9 88 f9 ff ff       	jmp    80106267 <alltraps>

801068df <vector52>:
801068df:	6a 00                	push   $0x0
801068e1:	6a 34                	push   $0x34
801068e3:	e9 7f f9 ff ff       	jmp    80106267 <alltraps>

801068e8 <vector53>:
801068e8:	6a 00                	push   $0x0
801068ea:	6a 35                	push   $0x35
801068ec:	e9 76 f9 ff ff       	jmp    80106267 <alltraps>

801068f1 <vector54>:
801068f1:	6a 00                	push   $0x0
801068f3:	6a 36                	push   $0x36
801068f5:	e9 6d f9 ff ff       	jmp    80106267 <alltraps>

801068fa <vector55>:
801068fa:	6a 00                	push   $0x0
801068fc:	6a 37                	push   $0x37
801068fe:	e9 64 f9 ff ff       	jmp    80106267 <alltraps>

80106903 <vector56>:
80106903:	6a 00                	push   $0x0
80106905:	6a 38                	push   $0x38
80106907:	e9 5b f9 ff ff       	jmp    80106267 <alltraps>

8010690c <vector57>:
8010690c:	6a 00                	push   $0x0
8010690e:	6a 39                	push   $0x39
80106910:	e9 52 f9 ff ff       	jmp    80106267 <alltraps>

80106915 <vector58>:
80106915:	6a 00                	push   $0x0
80106917:	6a 3a                	push   $0x3a
80106919:	e9 49 f9 ff ff       	jmp    80106267 <alltraps>

8010691e <vector59>:
8010691e:	6a 00                	push   $0x0
80106920:	6a 3b                	push   $0x3b
80106922:	e9 40 f9 ff ff       	jmp    80106267 <alltraps>

80106927 <vector60>:
80106927:	6a 00                	push   $0x0
80106929:	6a 3c                	push   $0x3c
8010692b:	e9 37 f9 ff ff       	jmp    80106267 <alltraps>

80106930 <vector61>:
80106930:	6a 00                	push   $0x0
80106932:	6a 3d                	push   $0x3d
80106934:	e9 2e f9 ff ff       	jmp    80106267 <alltraps>

80106939 <vector62>:
80106939:	6a 00                	push   $0x0
8010693b:	6a 3e                	push   $0x3e
8010693d:	e9 25 f9 ff ff       	jmp    80106267 <alltraps>

80106942 <vector63>:
80106942:	6a 00                	push   $0x0
80106944:	6a 3f                	push   $0x3f
80106946:	e9 1c f9 ff ff       	jmp    80106267 <alltraps>

8010694b <vector64>:
8010694b:	6a 00                	push   $0x0
8010694d:	6a 40                	push   $0x40
8010694f:	e9 13 f9 ff ff       	jmp    80106267 <alltraps>

80106954 <vector65>:
80106954:	6a 00                	push   $0x0
80106956:	6a 41                	push   $0x41
80106958:	e9 0a f9 ff ff       	jmp    80106267 <alltraps>

8010695d <vector66>:
8010695d:	6a 00                	push   $0x0
8010695f:	6a 42                	push   $0x42
80106961:	e9 01 f9 ff ff       	jmp    80106267 <alltraps>

80106966 <vector67>:
80106966:	6a 00                	push   $0x0
80106968:	6a 43                	push   $0x43
8010696a:	e9 f8 f8 ff ff       	jmp    80106267 <alltraps>

8010696f <vector68>:
8010696f:	6a 00                	push   $0x0
80106971:	6a 44                	push   $0x44
80106973:	e9 ef f8 ff ff       	jmp    80106267 <alltraps>

80106978 <vector69>:
80106978:	6a 00                	push   $0x0
8010697a:	6a 45                	push   $0x45
8010697c:	e9 e6 f8 ff ff       	jmp    80106267 <alltraps>

80106981 <vector70>:
80106981:	6a 00                	push   $0x0
80106983:	6a 46                	push   $0x46
80106985:	e9 dd f8 ff ff       	jmp    80106267 <alltraps>

8010698a <vector71>:
8010698a:	6a 00                	push   $0x0
8010698c:	6a 47                	push   $0x47
8010698e:	e9 d4 f8 ff ff       	jmp    80106267 <alltraps>

80106993 <vector72>:
80106993:	6a 00                	push   $0x0
80106995:	6a 48                	push   $0x48
80106997:	e9 cb f8 ff ff       	jmp    80106267 <alltraps>

8010699c <vector73>:
8010699c:	6a 00                	push   $0x0
8010699e:	6a 49                	push   $0x49
801069a0:	e9 c2 f8 ff ff       	jmp    80106267 <alltraps>

801069a5 <vector74>:
801069a5:	6a 00                	push   $0x0
801069a7:	6a 4a                	push   $0x4a
801069a9:	e9 b9 f8 ff ff       	jmp    80106267 <alltraps>

801069ae <vector75>:
801069ae:	6a 00                	push   $0x0
801069b0:	6a 4b                	push   $0x4b
801069b2:	e9 b0 f8 ff ff       	jmp    80106267 <alltraps>

801069b7 <vector76>:
801069b7:	6a 00                	push   $0x0
801069b9:	6a 4c                	push   $0x4c
801069bb:	e9 a7 f8 ff ff       	jmp    80106267 <alltraps>

801069c0 <vector77>:
801069c0:	6a 00                	push   $0x0
801069c2:	6a 4d                	push   $0x4d
801069c4:	e9 9e f8 ff ff       	jmp    80106267 <alltraps>

801069c9 <vector78>:
801069c9:	6a 00                	push   $0x0
801069cb:	6a 4e                	push   $0x4e
801069cd:	e9 95 f8 ff ff       	jmp    80106267 <alltraps>

801069d2 <vector79>:
801069d2:	6a 00                	push   $0x0
801069d4:	6a 4f                	push   $0x4f
801069d6:	e9 8c f8 ff ff       	jmp    80106267 <alltraps>

801069db <vector80>:
801069db:	6a 00                	push   $0x0
801069dd:	6a 50                	push   $0x50
801069df:	e9 83 f8 ff ff       	jmp    80106267 <alltraps>

801069e4 <vector81>:
801069e4:	6a 00                	push   $0x0
801069e6:	6a 51                	push   $0x51
801069e8:	e9 7a f8 ff ff       	jmp    80106267 <alltraps>

801069ed <vector82>:
801069ed:	6a 00                	push   $0x0
801069ef:	6a 52                	push   $0x52
801069f1:	e9 71 f8 ff ff       	jmp    80106267 <alltraps>

801069f6 <vector83>:
801069f6:	6a 00                	push   $0x0
801069f8:	6a 53                	push   $0x53
801069fa:	e9 68 f8 ff ff       	jmp    80106267 <alltraps>

801069ff <vector84>:
801069ff:	6a 00                	push   $0x0
80106a01:	6a 54                	push   $0x54
80106a03:	e9 5f f8 ff ff       	jmp    80106267 <alltraps>

80106a08 <vector85>:
80106a08:	6a 00                	push   $0x0
80106a0a:	6a 55                	push   $0x55
80106a0c:	e9 56 f8 ff ff       	jmp    80106267 <alltraps>

80106a11 <vector86>:
80106a11:	6a 00                	push   $0x0
80106a13:	6a 56                	push   $0x56
80106a15:	e9 4d f8 ff ff       	jmp    80106267 <alltraps>

80106a1a <vector87>:
80106a1a:	6a 00                	push   $0x0
80106a1c:	6a 57                	push   $0x57
80106a1e:	e9 44 f8 ff ff       	jmp    80106267 <alltraps>

80106a23 <vector88>:
80106a23:	6a 00                	push   $0x0
80106a25:	6a 58                	push   $0x58
80106a27:	e9 3b f8 ff ff       	jmp    80106267 <alltraps>

80106a2c <vector89>:
80106a2c:	6a 00                	push   $0x0
80106a2e:	6a 59                	push   $0x59
80106a30:	e9 32 f8 ff ff       	jmp    80106267 <alltraps>

80106a35 <vector90>:
80106a35:	6a 00                	push   $0x0
80106a37:	6a 5a                	push   $0x5a
80106a39:	e9 29 f8 ff ff       	jmp    80106267 <alltraps>

80106a3e <vector91>:
80106a3e:	6a 00                	push   $0x0
80106a40:	6a 5b                	push   $0x5b
80106a42:	e9 20 f8 ff ff       	jmp    80106267 <alltraps>

80106a47 <vector92>:
80106a47:	6a 00                	push   $0x0
80106a49:	6a 5c                	push   $0x5c
80106a4b:	e9 17 f8 ff ff       	jmp    80106267 <alltraps>

80106a50 <vector93>:
80106a50:	6a 00                	push   $0x0
80106a52:	6a 5d                	push   $0x5d
80106a54:	e9 0e f8 ff ff       	jmp    80106267 <alltraps>

80106a59 <vector94>:
80106a59:	6a 00                	push   $0x0
80106a5b:	6a 5e                	push   $0x5e
80106a5d:	e9 05 f8 ff ff       	jmp    80106267 <alltraps>

80106a62 <vector95>:
80106a62:	6a 00                	push   $0x0
80106a64:	6a 5f                	push   $0x5f
80106a66:	e9 fc f7 ff ff       	jmp    80106267 <alltraps>

80106a6b <vector96>:
80106a6b:	6a 00                	push   $0x0
80106a6d:	6a 60                	push   $0x60
80106a6f:	e9 f3 f7 ff ff       	jmp    80106267 <alltraps>

80106a74 <vector97>:
80106a74:	6a 00                	push   $0x0
80106a76:	6a 61                	push   $0x61
80106a78:	e9 ea f7 ff ff       	jmp    80106267 <alltraps>

80106a7d <vector98>:
80106a7d:	6a 00                	push   $0x0
80106a7f:	6a 62                	push   $0x62
80106a81:	e9 e1 f7 ff ff       	jmp    80106267 <alltraps>

80106a86 <vector99>:
80106a86:	6a 00                	push   $0x0
80106a88:	6a 63                	push   $0x63
80106a8a:	e9 d8 f7 ff ff       	jmp    80106267 <alltraps>

80106a8f <vector100>:
80106a8f:	6a 00                	push   $0x0
80106a91:	6a 64                	push   $0x64
80106a93:	e9 cf f7 ff ff       	jmp    80106267 <alltraps>

80106a98 <vector101>:
80106a98:	6a 00                	push   $0x0
80106a9a:	6a 65                	push   $0x65
80106a9c:	e9 c6 f7 ff ff       	jmp    80106267 <alltraps>

80106aa1 <vector102>:
80106aa1:	6a 00                	push   $0x0
80106aa3:	6a 66                	push   $0x66
80106aa5:	e9 bd f7 ff ff       	jmp    80106267 <alltraps>

80106aaa <vector103>:
80106aaa:	6a 00                	push   $0x0
80106aac:	6a 67                	push   $0x67
80106aae:	e9 b4 f7 ff ff       	jmp    80106267 <alltraps>

80106ab3 <vector104>:
80106ab3:	6a 00                	push   $0x0
80106ab5:	6a 68                	push   $0x68
80106ab7:	e9 ab f7 ff ff       	jmp    80106267 <alltraps>

80106abc <vector105>:
80106abc:	6a 00                	push   $0x0
80106abe:	6a 69                	push   $0x69
80106ac0:	e9 a2 f7 ff ff       	jmp    80106267 <alltraps>

80106ac5 <vector106>:
80106ac5:	6a 00                	push   $0x0
80106ac7:	6a 6a                	push   $0x6a
80106ac9:	e9 99 f7 ff ff       	jmp    80106267 <alltraps>

80106ace <vector107>:
80106ace:	6a 00                	push   $0x0
80106ad0:	6a 6b                	push   $0x6b
80106ad2:	e9 90 f7 ff ff       	jmp    80106267 <alltraps>

80106ad7 <vector108>:
80106ad7:	6a 00                	push   $0x0
80106ad9:	6a 6c                	push   $0x6c
80106adb:	e9 87 f7 ff ff       	jmp    80106267 <alltraps>

80106ae0 <vector109>:
80106ae0:	6a 00                	push   $0x0
80106ae2:	6a 6d                	push   $0x6d
80106ae4:	e9 7e f7 ff ff       	jmp    80106267 <alltraps>

80106ae9 <vector110>:
80106ae9:	6a 00                	push   $0x0
80106aeb:	6a 6e                	push   $0x6e
80106aed:	e9 75 f7 ff ff       	jmp    80106267 <alltraps>

80106af2 <vector111>:
80106af2:	6a 00                	push   $0x0
80106af4:	6a 6f                	push   $0x6f
80106af6:	e9 6c f7 ff ff       	jmp    80106267 <alltraps>

80106afb <vector112>:
80106afb:	6a 00                	push   $0x0
80106afd:	6a 70                	push   $0x70
80106aff:	e9 63 f7 ff ff       	jmp    80106267 <alltraps>

80106b04 <vector113>:
80106b04:	6a 00                	push   $0x0
80106b06:	6a 71                	push   $0x71
80106b08:	e9 5a f7 ff ff       	jmp    80106267 <alltraps>

80106b0d <vector114>:
80106b0d:	6a 00                	push   $0x0
80106b0f:	6a 72                	push   $0x72
80106b11:	e9 51 f7 ff ff       	jmp    80106267 <alltraps>

80106b16 <vector115>:
80106b16:	6a 00                	push   $0x0
80106b18:	6a 73                	push   $0x73
80106b1a:	e9 48 f7 ff ff       	jmp    80106267 <alltraps>

80106b1f <vector116>:
80106b1f:	6a 00                	push   $0x0
80106b21:	6a 74                	push   $0x74
80106b23:	e9 3f f7 ff ff       	jmp    80106267 <alltraps>

80106b28 <vector117>:
80106b28:	6a 00                	push   $0x0
80106b2a:	6a 75                	push   $0x75
80106b2c:	e9 36 f7 ff ff       	jmp    80106267 <alltraps>

80106b31 <vector118>:
80106b31:	6a 00                	push   $0x0
80106b33:	6a 76                	push   $0x76
80106b35:	e9 2d f7 ff ff       	jmp    80106267 <alltraps>

80106b3a <vector119>:
80106b3a:	6a 00                	push   $0x0
80106b3c:	6a 77                	push   $0x77
80106b3e:	e9 24 f7 ff ff       	jmp    80106267 <alltraps>

80106b43 <vector120>:
80106b43:	6a 00                	push   $0x0
80106b45:	6a 78                	push   $0x78
80106b47:	e9 1b f7 ff ff       	jmp    80106267 <alltraps>

80106b4c <vector121>:
80106b4c:	6a 00                	push   $0x0
80106b4e:	6a 79                	push   $0x79
80106b50:	e9 12 f7 ff ff       	jmp    80106267 <alltraps>

80106b55 <vector122>:
80106b55:	6a 00                	push   $0x0
80106b57:	6a 7a                	push   $0x7a
80106b59:	e9 09 f7 ff ff       	jmp    80106267 <alltraps>

80106b5e <vector123>:
80106b5e:	6a 00                	push   $0x0
80106b60:	6a 7b                	push   $0x7b
80106b62:	e9 00 f7 ff ff       	jmp    80106267 <alltraps>

80106b67 <vector124>:
80106b67:	6a 00                	push   $0x0
80106b69:	6a 7c                	push   $0x7c
80106b6b:	e9 f7 f6 ff ff       	jmp    80106267 <alltraps>

80106b70 <vector125>:
80106b70:	6a 00                	push   $0x0
80106b72:	6a 7d                	push   $0x7d
80106b74:	e9 ee f6 ff ff       	jmp    80106267 <alltraps>

80106b79 <vector126>:
80106b79:	6a 00                	push   $0x0
80106b7b:	6a 7e                	push   $0x7e
80106b7d:	e9 e5 f6 ff ff       	jmp    80106267 <alltraps>

80106b82 <vector127>:
80106b82:	6a 00                	push   $0x0
80106b84:	6a 7f                	push   $0x7f
80106b86:	e9 dc f6 ff ff       	jmp    80106267 <alltraps>

80106b8b <vector128>:
80106b8b:	6a 00                	push   $0x0
80106b8d:	68 80 00 00 00       	push   $0x80
80106b92:	e9 d0 f6 ff ff       	jmp    80106267 <alltraps>

80106b97 <vector129>:
80106b97:	6a 00                	push   $0x0
80106b99:	68 81 00 00 00       	push   $0x81
80106b9e:	e9 c4 f6 ff ff       	jmp    80106267 <alltraps>

80106ba3 <vector130>:
80106ba3:	6a 00                	push   $0x0
80106ba5:	68 82 00 00 00       	push   $0x82
80106baa:	e9 b8 f6 ff ff       	jmp    80106267 <alltraps>

80106baf <vector131>:
80106baf:	6a 00                	push   $0x0
80106bb1:	68 83 00 00 00       	push   $0x83
80106bb6:	e9 ac f6 ff ff       	jmp    80106267 <alltraps>

80106bbb <vector132>:
80106bbb:	6a 00                	push   $0x0
80106bbd:	68 84 00 00 00       	push   $0x84
80106bc2:	e9 a0 f6 ff ff       	jmp    80106267 <alltraps>

80106bc7 <vector133>:
80106bc7:	6a 00                	push   $0x0
80106bc9:	68 85 00 00 00       	push   $0x85
80106bce:	e9 94 f6 ff ff       	jmp    80106267 <alltraps>

80106bd3 <vector134>:
80106bd3:	6a 00                	push   $0x0
80106bd5:	68 86 00 00 00       	push   $0x86
80106bda:	e9 88 f6 ff ff       	jmp    80106267 <alltraps>

80106bdf <vector135>:
80106bdf:	6a 00                	push   $0x0
80106be1:	68 87 00 00 00       	push   $0x87
80106be6:	e9 7c f6 ff ff       	jmp    80106267 <alltraps>

80106beb <vector136>:
80106beb:	6a 00                	push   $0x0
80106bed:	68 88 00 00 00       	push   $0x88
80106bf2:	e9 70 f6 ff ff       	jmp    80106267 <alltraps>

80106bf7 <vector137>:
80106bf7:	6a 00                	push   $0x0
80106bf9:	68 89 00 00 00       	push   $0x89
80106bfe:	e9 64 f6 ff ff       	jmp    80106267 <alltraps>

80106c03 <vector138>:
80106c03:	6a 00                	push   $0x0
80106c05:	68 8a 00 00 00       	push   $0x8a
80106c0a:	e9 58 f6 ff ff       	jmp    80106267 <alltraps>

80106c0f <vector139>:
80106c0f:	6a 00                	push   $0x0
80106c11:	68 8b 00 00 00       	push   $0x8b
80106c16:	e9 4c f6 ff ff       	jmp    80106267 <alltraps>

80106c1b <vector140>:
80106c1b:	6a 00                	push   $0x0
80106c1d:	68 8c 00 00 00       	push   $0x8c
80106c22:	e9 40 f6 ff ff       	jmp    80106267 <alltraps>

80106c27 <vector141>:
80106c27:	6a 00                	push   $0x0
80106c29:	68 8d 00 00 00       	push   $0x8d
80106c2e:	e9 34 f6 ff ff       	jmp    80106267 <alltraps>

80106c33 <vector142>:
80106c33:	6a 00                	push   $0x0
80106c35:	68 8e 00 00 00       	push   $0x8e
80106c3a:	e9 28 f6 ff ff       	jmp    80106267 <alltraps>

80106c3f <vector143>:
80106c3f:	6a 00                	push   $0x0
80106c41:	68 8f 00 00 00       	push   $0x8f
80106c46:	e9 1c f6 ff ff       	jmp    80106267 <alltraps>

80106c4b <vector144>:
80106c4b:	6a 00                	push   $0x0
80106c4d:	68 90 00 00 00       	push   $0x90
80106c52:	e9 10 f6 ff ff       	jmp    80106267 <alltraps>

80106c57 <vector145>:
80106c57:	6a 00                	push   $0x0
80106c59:	68 91 00 00 00       	push   $0x91
80106c5e:	e9 04 f6 ff ff       	jmp    80106267 <alltraps>

80106c63 <vector146>:
80106c63:	6a 00                	push   $0x0
80106c65:	68 92 00 00 00       	push   $0x92
80106c6a:	e9 f8 f5 ff ff       	jmp    80106267 <alltraps>

80106c6f <vector147>:
80106c6f:	6a 00                	push   $0x0
80106c71:	68 93 00 00 00       	push   $0x93
80106c76:	e9 ec f5 ff ff       	jmp    80106267 <alltraps>

80106c7b <vector148>:
80106c7b:	6a 00                	push   $0x0
80106c7d:	68 94 00 00 00       	push   $0x94
80106c82:	e9 e0 f5 ff ff       	jmp    80106267 <alltraps>

80106c87 <vector149>:
80106c87:	6a 00                	push   $0x0
80106c89:	68 95 00 00 00       	push   $0x95
80106c8e:	e9 d4 f5 ff ff       	jmp    80106267 <alltraps>

80106c93 <vector150>:
80106c93:	6a 00                	push   $0x0
80106c95:	68 96 00 00 00       	push   $0x96
80106c9a:	e9 c8 f5 ff ff       	jmp    80106267 <alltraps>

80106c9f <vector151>:
80106c9f:	6a 00                	push   $0x0
80106ca1:	68 97 00 00 00       	push   $0x97
80106ca6:	e9 bc f5 ff ff       	jmp    80106267 <alltraps>

80106cab <vector152>:
80106cab:	6a 00                	push   $0x0
80106cad:	68 98 00 00 00       	push   $0x98
80106cb2:	e9 b0 f5 ff ff       	jmp    80106267 <alltraps>

80106cb7 <vector153>:
80106cb7:	6a 00                	push   $0x0
80106cb9:	68 99 00 00 00       	push   $0x99
80106cbe:	e9 a4 f5 ff ff       	jmp    80106267 <alltraps>

80106cc3 <vector154>:
80106cc3:	6a 00                	push   $0x0
80106cc5:	68 9a 00 00 00       	push   $0x9a
80106cca:	e9 98 f5 ff ff       	jmp    80106267 <alltraps>

80106ccf <vector155>:
80106ccf:	6a 00                	push   $0x0
80106cd1:	68 9b 00 00 00       	push   $0x9b
80106cd6:	e9 8c f5 ff ff       	jmp    80106267 <alltraps>

80106cdb <vector156>:
80106cdb:	6a 00                	push   $0x0
80106cdd:	68 9c 00 00 00       	push   $0x9c
80106ce2:	e9 80 f5 ff ff       	jmp    80106267 <alltraps>

80106ce7 <vector157>:
80106ce7:	6a 00                	push   $0x0
80106ce9:	68 9d 00 00 00       	push   $0x9d
80106cee:	e9 74 f5 ff ff       	jmp    80106267 <alltraps>

80106cf3 <vector158>:
80106cf3:	6a 00                	push   $0x0
80106cf5:	68 9e 00 00 00       	push   $0x9e
80106cfa:	e9 68 f5 ff ff       	jmp    80106267 <alltraps>

80106cff <vector159>:
80106cff:	6a 00                	push   $0x0
80106d01:	68 9f 00 00 00       	push   $0x9f
80106d06:	e9 5c f5 ff ff       	jmp    80106267 <alltraps>

80106d0b <vector160>:
80106d0b:	6a 00                	push   $0x0
80106d0d:	68 a0 00 00 00       	push   $0xa0
80106d12:	e9 50 f5 ff ff       	jmp    80106267 <alltraps>

80106d17 <vector161>:
80106d17:	6a 00                	push   $0x0
80106d19:	68 a1 00 00 00       	push   $0xa1
80106d1e:	e9 44 f5 ff ff       	jmp    80106267 <alltraps>

80106d23 <vector162>:
80106d23:	6a 00                	push   $0x0
80106d25:	68 a2 00 00 00       	push   $0xa2
80106d2a:	e9 38 f5 ff ff       	jmp    80106267 <alltraps>

80106d2f <vector163>:
80106d2f:	6a 00                	push   $0x0
80106d31:	68 a3 00 00 00       	push   $0xa3
80106d36:	e9 2c f5 ff ff       	jmp    80106267 <alltraps>

80106d3b <vector164>:
80106d3b:	6a 00                	push   $0x0
80106d3d:	68 a4 00 00 00       	push   $0xa4
80106d42:	e9 20 f5 ff ff       	jmp    80106267 <alltraps>

80106d47 <vector165>:
80106d47:	6a 00                	push   $0x0
80106d49:	68 a5 00 00 00       	push   $0xa5
80106d4e:	e9 14 f5 ff ff       	jmp    80106267 <alltraps>

80106d53 <vector166>:
80106d53:	6a 00                	push   $0x0
80106d55:	68 a6 00 00 00       	push   $0xa6
80106d5a:	e9 08 f5 ff ff       	jmp    80106267 <alltraps>

80106d5f <vector167>:
80106d5f:	6a 00                	push   $0x0
80106d61:	68 a7 00 00 00       	push   $0xa7
80106d66:	e9 fc f4 ff ff       	jmp    80106267 <alltraps>

80106d6b <vector168>:
80106d6b:	6a 00                	push   $0x0
80106d6d:	68 a8 00 00 00       	push   $0xa8
80106d72:	e9 f0 f4 ff ff       	jmp    80106267 <alltraps>

80106d77 <vector169>:
80106d77:	6a 00                	push   $0x0
80106d79:	68 a9 00 00 00       	push   $0xa9
80106d7e:	e9 e4 f4 ff ff       	jmp    80106267 <alltraps>

80106d83 <vector170>:
80106d83:	6a 00                	push   $0x0
80106d85:	68 aa 00 00 00       	push   $0xaa
80106d8a:	e9 d8 f4 ff ff       	jmp    80106267 <alltraps>

80106d8f <vector171>:
80106d8f:	6a 00                	push   $0x0
80106d91:	68 ab 00 00 00       	push   $0xab
80106d96:	e9 cc f4 ff ff       	jmp    80106267 <alltraps>

80106d9b <vector172>:
80106d9b:	6a 00                	push   $0x0
80106d9d:	68 ac 00 00 00       	push   $0xac
80106da2:	e9 c0 f4 ff ff       	jmp    80106267 <alltraps>

80106da7 <vector173>:
80106da7:	6a 00                	push   $0x0
80106da9:	68 ad 00 00 00       	push   $0xad
80106dae:	e9 b4 f4 ff ff       	jmp    80106267 <alltraps>

80106db3 <vector174>:
80106db3:	6a 00                	push   $0x0
80106db5:	68 ae 00 00 00       	push   $0xae
80106dba:	e9 a8 f4 ff ff       	jmp    80106267 <alltraps>

80106dbf <vector175>:
80106dbf:	6a 00                	push   $0x0
80106dc1:	68 af 00 00 00       	push   $0xaf
80106dc6:	e9 9c f4 ff ff       	jmp    80106267 <alltraps>

80106dcb <vector176>:
80106dcb:	6a 00                	push   $0x0
80106dcd:	68 b0 00 00 00       	push   $0xb0
80106dd2:	e9 90 f4 ff ff       	jmp    80106267 <alltraps>

80106dd7 <vector177>:
80106dd7:	6a 00                	push   $0x0
80106dd9:	68 b1 00 00 00       	push   $0xb1
80106dde:	e9 84 f4 ff ff       	jmp    80106267 <alltraps>

80106de3 <vector178>:
80106de3:	6a 00                	push   $0x0
80106de5:	68 b2 00 00 00       	push   $0xb2
80106dea:	e9 78 f4 ff ff       	jmp    80106267 <alltraps>

80106def <vector179>:
80106def:	6a 00                	push   $0x0
80106df1:	68 b3 00 00 00       	push   $0xb3
80106df6:	e9 6c f4 ff ff       	jmp    80106267 <alltraps>

80106dfb <vector180>:
80106dfb:	6a 00                	push   $0x0
80106dfd:	68 b4 00 00 00       	push   $0xb4
80106e02:	e9 60 f4 ff ff       	jmp    80106267 <alltraps>

80106e07 <vector181>:
80106e07:	6a 00                	push   $0x0
80106e09:	68 b5 00 00 00       	push   $0xb5
80106e0e:	e9 54 f4 ff ff       	jmp    80106267 <alltraps>

80106e13 <vector182>:
80106e13:	6a 00                	push   $0x0
80106e15:	68 b6 00 00 00       	push   $0xb6
80106e1a:	e9 48 f4 ff ff       	jmp    80106267 <alltraps>

80106e1f <vector183>:
80106e1f:	6a 00                	push   $0x0
80106e21:	68 b7 00 00 00       	push   $0xb7
80106e26:	e9 3c f4 ff ff       	jmp    80106267 <alltraps>

80106e2b <vector184>:
80106e2b:	6a 00                	push   $0x0
80106e2d:	68 b8 00 00 00       	push   $0xb8
80106e32:	e9 30 f4 ff ff       	jmp    80106267 <alltraps>

80106e37 <vector185>:
80106e37:	6a 00                	push   $0x0
80106e39:	68 b9 00 00 00       	push   $0xb9
80106e3e:	e9 24 f4 ff ff       	jmp    80106267 <alltraps>

80106e43 <vector186>:
80106e43:	6a 00                	push   $0x0
80106e45:	68 ba 00 00 00       	push   $0xba
80106e4a:	e9 18 f4 ff ff       	jmp    80106267 <alltraps>

80106e4f <vector187>:
80106e4f:	6a 00                	push   $0x0
80106e51:	68 bb 00 00 00       	push   $0xbb
80106e56:	e9 0c f4 ff ff       	jmp    80106267 <alltraps>

80106e5b <vector188>:
80106e5b:	6a 00                	push   $0x0
80106e5d:	68 bc 00 00 00       	push   $0xbc
80106e62:	e9 00 f4 ff ff       	jmp    80106267 <alltraps>

80106e67 <vector189>:
80106e67:	6a 00                	push   $0x0
80106e69:	68 bd 00 00 00       	push   $0xbd
80106e6e:	e9 f4 f3 ff ff       	jmp    80106267 <alltraps>

80106e73 <vector190>:
80106e73:	6a 00                	push   $0x0
80106e75:	68 be 00 00 00       	push   $0xbe
80106e7a:	e9 e8 f3 ff ff       	jmp    80106267 <alltraps>

80106e7f <vector191>:
80106e7f:	6a 00                	push   $0x0
80106e81:	68 bf 00 00 00       	push   $0xbf
80106e86:	e9 dc f3 ff ff       	jmp    80106267 <alltraps>

80106e8b <vector192>:
80106e8b:	6a 00                	push   $0x0
80106e8d:	68 c0 00 00 00       	push   $0xc0
80106e92:	e9 d0 f3 ff ff       	jmp    80106267 <alltraps>

80106e97 <vector193>:
80106e97:	6a 00                	push   $0x0
80106e99:	68 c1 00 00 00       	push   $0xc1
80106e9e:	e9 c4 f3 ff ff       	jmp    80106267 <alltraps>

80106ea3 <vector194>:
80106ea3:	6a 00                	push   $0x0
80106ea5:	68 c2 00 00 00       	push   $0xc2
80106eaa:	e9 b8 f3 ff ff       	jmp    80106267 <alltraps>

80106eaf <vector195>:
80106eaf:	6a 00                	push   $0x0
80106eb1:	68 c3 00 00 00       	push   $0xc3
80106eb6:	e9 ac f3 ff ff       	jmp    80106267 <alltraps>

80106ebb <vector196>:
80106ebb:	6a 00                	push   $0x0
80106ebd:	68 c4 00 00 00       	push   $0xc4
80106ec2:	e9 a0 f3 ff ff       	jmp    80106267 <alltraps>

80106ec7 <vector197>:
80106ec7:	6a 00                	push   $0x0
80106ec9:	68 c5 00 00 00       	push   $0xc5
80106ece:	e9 94 f3 ff ff       	jmp    80106267 <alltraps>

80106ed3 <vector198>:
80106ed3:	6a 00                	push   $0x0
80106ed5:	68 c6 00 00 00       	push   $0xc6
80106eda:	e9 88 f3 ff ff       	jmp    80106267 <alltraps>

80106edf <vector199>:
80106edf:	6a 00                	push   $0x0
80106ee1:	68 c7 00 00 00       	push   $0xc7
80106ee6:	e9 7c f3 ff ff       	jmp    80106267 <alltraps>

80106eeb <vector200>:
80106eeb:	6a 00                	push   $0x0
80106eed:	68 c8 00 00 00       	push   $0xc8
80106ef2:	e9 70 f3 ff ff       	jmp    80106267 <alltraps>

80106ef7 <vector201>:
80106ef7:	6a 00                	push   $0x0
80106ef9:	68 c9 00 00 00       	push   $0xc9
80106efe:	e9 64 f3 ff ff       	jmp    80106267 <alltraps>

80106f03 <vector202>:
80106f03:	6a 00                	push   $0x0
80106f05:	68 ca 00 00 00       	push   $0xca
80106f0a:	e9 58 f3 ff ff       	jmp    80106267 <alltraps>

80106f0f <vector203>:
80106f0f:	6a 00                	push   $0x0
80106f11:	68 cb 00 00 00       	push   $0xcb
80106f16:	e9 4c f3 ff ff       	jmp    80106267 <alltraps>

80106f1b <vector204>:
80106f1b:	6a 00                	push   $0x0
80106f1d:	68 cc 00 00 00       	push   $0xcc
80106f22:	e9 40 f3 ff ff       	jmp    80106267 <alltraps>

80106f27 <vector205>:
80106f27:	6a 00                	push   $0x0
80106f29:	68 cd 00 00 00       	push   $0xcd
80106f2e:	e9 34 f3 ff ff       	jmp    80106267 <alltraps>

80106f33 <vector206>:
80106f33:	6a 00                	push   $0x0
80106f35:	68 ce 00 00 00       	push   $0xce
80106f3a:	e9 28 f3 ff ff       	jmp    80106267 <alltraps>

80106f3f <vector207>:
80106f3f:	6a 00                	push   $0x0
80106f41:	68 cf 00 00 00       	push   $0xcf
80106f46:	e9 1c f3 ff ff       	jmp    80106267 <alltraps>

80106f4b <vector208>:
80106f4b:	6a 00                	push   $0x0
80106f4d:	68 d0 00 00 00       	push   $0xd0
80106f52:	e9 10 f3 ff ff       	jmp    80106267 <alltraps>

80106f57 <vector209>:
80106f57:	6a 00                	push   $0x0
80106f59:	68 d1 00 00 00       	push   $0xd1
80106f5e:	e9 04 f3 ff ff       	jmp    80106267 <alltraps>

80106f63 <vector210>:
80106f63:	6a 00                	push   $0x0
80106f65:	68 d2 00 00 00       	push   $0xd2
80106f6a:	e9 f8 f2 ff ff       	jmp    80106267 <alltraps>

80106f6f <vector211>:
80106f6f:	6a 00                	push   $0x0
80106f71:	68 d3 00 00 00       	push   $0xd3
80106f76:	e9 ec f2 ff ff       	jmp    80106267 <alltraps>

80106f7b <vector212>:
80106f7b:	6a 00                	push   $0x0
80106f7d:	68 d4 00 00 00       	push   $0xd4
80106f82:	e9 e0 f2 ff ff       	jmp    80106267 <alltraps>

80106f87 <vector213>:
80106f87:	6a 00                	push   $0x0
80106f89:	68 d5 00 00 00       	push   $0xd5
80106f8e:	e9 d4 f2 ff ff       	jmp    80106267 <alltraps>

80106f93 <vector214>:
80106f93:	6a 00                	push   $0x0
80106f95:	68 d6 00 00 00       	push   $0xd6
80106f9a:	e9 c8 f2 ff ff       	jmp    80106267 <alltraps>

80106f9f <vector215>:
80106f9f:	6a 00                	push   $0x0
80106fa1:	68 d7 00 00 00       	push   $0xd7
80106fa6:	e9 bc f2 ff ff       	jmp    80106267 <alltraps>

80106fab <vector216>:
80106fab:	6a 00                	push   $0x0
80106fad:	68 d8 00 00 00       	push   $0xd8
80106fb2:	e9 b0 f2 ff ff       	jmp    80106267 <alltraps>

80106fb7 <vector217>:
80106fb7:	6a 00                	push   $0x0
80106fb9:	68 d9 00 00 00       	push   $0xd9
80106fbe:	e9 a4 f2 ff ff       	jmp    80106267 <alltraps>

80106fc3 <vector218>:
80106fc3:	6a 00                	push   $0x0
80106fc5:	68 da 00 00 00       	push   $0xda
80106fca:	e9 98 f2 ff ff       	jmp    80106267 <alltraps>

80106fcf <vector219>:
80106fcf:	6a 00                	push   $0x0
80106fd1:	68 db 00 00 00       	push   $0xdb
80106fd6:	e9 8c f2 ff ff       	jmp    80106267 <alltraps>

80106fdb <vector220>:
80106fdb:	6a 00                	push   $0x0
80106fdd:	68 dc 00 00 00       	push   $0xdc
80106fe2:	e9 80 f2 ff ff       	jmp    80106267 <alltraps>

80106fe7 <vector221>:
80106fe7:	6a 00                	push   $0x0
80106fe9:	68 dd 00 00 00       	push   $0xdd
80106fee:	e9 74 f2 ff ff       	jmp    80106267 <alltraps>

80106ff3 <vector222>:
80106ff3:	6a 00                	push   $0x0
80106ff5:	68 de 00 00 00       	push   $0xde
80106ffa:	e9 68 f2 ff ff       	jmp    80106267 <alltraps>

80106fff <vector223>:
80106fff:	6a 00                	push   $0x0
80107001:	68 df 00 00 00       	push   $0xdf
80107006:	e9 5c f2 ff ff       	jmp    80106267 <alltraps>

8010700b <vector224>:
8010700b:	6a 00                	push   $0x0
8010700d:	68 e0 00 00 00       	push   $0xe0
80107012:	e9 50 f2 ff ff       	jmp    80106267 <alltraps>

80107017 <vector225>:
80107017:	6a 00                	push   $0x0
80107019:	68 e1 00 00 00       	push   $0xe1
8010701e:	e9 44 f2 ff ff       	jmp    80106267 <alltraps>

80107023 <vector226>:
80107023:	6a 00                	push   $0x0
80107025:	68 e2 00 00 00       	push   $0xe2
8010702a:	e9 38 f2 ff ff       	jmp    80106267 <alltraps>

8010702f <vector227>:
8010702f:	6a 00                	push   $0x0
80107031:	68 e3 00 00 00       	push   $0xe3
80107036:	e9 2c f2 ff ff       	jmp    80106267 <alltraps>

8010703b <vector228>:
8010703b:	6a 00                	push   $0x0
8010703d:	68 e4 00 00 00       	push   $0xe4
80107042:	e9 20 f2 ff ff       	jmp    80106267 <alltraps>

80107047 <vector229>:
80107047:	6a 00                	push   $0x0
80107049:	68 e5 00 00 00       	push   $0xe5
8010704e:	e9 14 f2 ff ff       	jmp    80106267 <alltraps>

80107053 <vector230>:
80107053:	6a 00                	push   $0x0
80107055:	68 e6 00 00 00       	push   $0xe6
8010705a:	e9 08 f2 ff ff       	jmp    80106267 <alltraps>

8010705f <vector231>:
8010705f:	6a 00                	push   $0x0
80107061:	68 e7 00 00 00       	push   $0xe7
80107066:	e9 fc f1 ff ff       	jmp    80106267 <alltraps>

8010706b <vector232>:
8010706b:	6a 00                	push   $0x0
8010706d:	68 e8 00 00 00       	push   $0xe8
80107072:	e9 f0 f1 ff ff       	jmp    80106267 <alltraps>

80107077 <vector233>:
80107077:	6a 00                	push   $0x0
80107079:	68 e9 00 00 00       	push   $0xe9
8010707e:	e9 e4 f1 ff ff       	jmp    80106267 <alltraps>

80107083 <vector234>:
80107083:	6a 00                	push   $0x0
80107085:	68 ea 00 00 00       	push   $0xea
8010708a:	e9 d8 f1 ff ff       	jmp    80106267 <alltraps>

8010708f <vector235>:
8010708f:	6a 00                	push   $0x0
80107091:	68 eb 00 00 00       	push   $0xeb
80107096:	e9 cc f1 ff ff       	jmp    80106267 <alltraps>

8010709b <vector236>:
8010709b:	6a 00                	push   $0x0
8010709d:	68 ec 00 00 00       	push   $0xec
801070a2:	e9 c0 f1 ff ff       	jmp    80106267 <alltraps>

801070a7 <vector237>:
801070a7:	6a 00                	push   $0x0
801070a9:	68 ed 00 00 00       	push   $0xed
801070ae:	e9 b4 f1 ff ff       	jmp    80106267 <alltraps>

801070b3 <vector238>:
801070b3:	6a 00                	push   $0x0
801070b5:	68 ee 00 00 00       	push   $0xee
801070ba:	e9 a8 f1 ff ff       	jmp    80106267 <alltraps>

801070bf <vector239>:
801070bf:	6a 00                	push   $0x0
801070c1:	68 ef 00 00 00       	push   $0xef
801070c6:	e9 9c f1 ff ff       	jmp    80106267 <alltraps>

801070cb <vector240>:
801070cb:	6a 00                	push   $0x0
801070cd:	68 f0 00 00 00       	push   $0xf0
801070d2:	e9 90 f1 ff ff       	jmp    80106267 <alltraps>

801070d7 <vector241>:
801070d7:	6a 00                	push   $0x0
801070d9:	68 f1 00 00 00       	push   $0xf1
801070de:	e9 84 f1 ff ff       	jmp    80106267 <alltraps>

801070e3 <vector242>:
801070e3:	6a 00                	push   $0x0
801070e5:	68 f2 00 00 00       	push   $0xf2
801070ea:	e9 78 f1 ff ff       	jmp    80106267 <alltraps>

801070ef <vector243>:
801070ef:	6a 00                	push   $0x0
801070f1:	68 f3 00 00 00       	push   $0xf3
801070f6:	e9 6c f1 ff ff       	jmp    80106267 <alltraps>

801070fb <vector244>:
801070fb:	6a 00                	push   $0x0
801070fd:	68 f4 00 00 00       	push   $0xf4
80107102:	e9 60 f1 ff ff       	jmp    80106267 <alltraps>

80107107 <vector245>:
80107107:	6a 00                	push   $0x0
80107109:	68 f5 00 00 00       	push   $0xf5
8010710e:	e9 54 f1 ff ff       	jmp    80106267 <alltraps>

80107113 <vector246>:
80107113:	6a 00                	push   $0x0
80107115:	68 f6 00 00 00       	push   $0xf6
8010711a:	e9 48 f1 ff ff       	jmp    80106267 <alltraps>

8010711f <vector247>:
8010711f:	6a 00                	push   $0x0
80107121:	68 f7 00 00 00       	push   $0xf7
80107126:	e9 3c f1 ff ff       	jmp    80106267 <alltraps>

8010712b <vector248>:
8010712b:	6a 00                	push   $0x0
8010712d:	68 f8 00 00 00       	push   $0xf8
80107132:	e9 30 f1 ff ff       	jmp    80106267 <alltraps>

80107137 <vector249>:
80107137:	6a 00                	push   $0x0
80107139:	68 f9 00 00 00       	push   $0xf9
8010713e:	e9 24 f1 ff ff       	jmp    80106267 <alltraps>

80107143 <vector250>:
80107143:	6a 00                	push   $0x0
80107145:	68 fa 00 00 00       	push   $0xfa
8010714a:	e9 18 f1 ff ff       	jmp    80106267 <alltraps>

8010714f <vector251>:
8010714f:	6a 00                	push   $0x0
80107151:	68 fb 00 00 00       	push   $0xfb
80107156:	e9 0c f1 ff ff       	jmp    80106267 <alltraps>

8010715b <vector252>:
8010715b:	6a 00                	push   $0x0
8010715d:	68 fc 00 00 00       	push   $0xfc
80107162:	e9 00 f1 ff ff       	jmp    80106267 <alltraps>

80107167 <vector253>:
80107167:	6a 00                	push   $0x0
80107169:	68 fd 00 00 00       	push   $0xfd
8010716e:	e9 f4 f0 ff ff       	jmp    80106267 <alltraps>

80107173 <vector254>:
80107173:	6a 00                	push   $0x0
80107175:	68 fe 00 00 00       	push   $0xfe
8010717a:	e9 e8 f0 ff ff       	jmp    80106267 <alltraps>

8010717f <vector255>:
8010717f:	6a 00                	push   $0x0
80107181:	68 ff 00 00 00       	push   $0xff
80107186:	e9 dc f0 ff ff       	jmp    80106267 <alltraps>
8010718b:	66 90                	xchg   %ax,%ax
8010718d:	66 90                	xchg   %ax,%ax
8010718f:	90                   	nop

80107190 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107190:	55                   	push   %ebp
80107191:	89 e5                	mov    %esp,%ebp
80107193:	57                   	push   %edi
80107194:	56                   	push   %esi
80107195:	89 d6                	mov    %edx,%esi
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80107197:	c1 ea 16             	shr    $0x16,%edx
{
8010719a:	53                   	push   %ebx
  pde = &pgdir[PDX(va)];
8010719b:	8d 3c 90             	lea    (%eax,%edx,4),%edi
{
8010719e:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
801071a1:	8b 1f                	mov    (%edi),%ebx
801071a3:	f6 c3 01             	test   $0x1,%bl
801071a6:	74 28                	je     801071d0 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801071a8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
801071ae:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
801071b4:	89 f0                	mov    %esi,%eax
}
801071b6:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
801071b9:	c1 e8 0a             	shr    $0xa,%eax
801071bc:	25 fc 0f 00 00       	and    $0xffc,%eax
801071c1:	01 d8                	add    %ebx,%eax
}
801071c3:	5b                   	pop    %ebx
801071c4:	5e                   	pop    %esi
801071c5:	5f                   	pop    %edi
801071c6:	5d                   	pop    %ebp
801071c7:	c3                   	ret    
801071c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801071cf:	90                   	nop
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
801071d0:	85 c9                	test   %ecx,%ecx
801071d2:	74 2c                	je     80107200 <walkpgdir+0x70>
801071d4:	e8 37 b8 ff ff       	call   80102a10 <kalloc>
801071d9:	89 c3                	mov    %eax,%ebx
801071db:	85 c0                	test   %eax,%eax
801071dd:	74 21                	je     80107200 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
801071df:	83 ec 04             	sub    $0x4,%esp
801071e2:	68 00 10 00 00       	push   $0x1000
801071e7:	6a 00                	push   $0x0
801071e9:	50                   	push   %eax
801071ea:	e8 91 dd ff ff       	call   80104f80 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
801071ef:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801071f5:	83 c4 10             	add    $0x10,%esp
801071f8:	83 c8 07             	or     $0x7,%eax
801071fb:	89 07                	mov    %eax,(%edi)
801071fd:	eb b5                	jmp    801071b4 <walkpgdir+0x24>
801071ff:	90                   	nop
}
80107200:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
80107203:	31 c0                	xor    %eax,%eax
}
80107205:	5b                   	pop    %ebx
80107206:	5e                   	pop    %esi
80107207:	5f                   	pop    %edi
80107208:	5d                   	pop    %ebp
80107209:	c3                   	ret    
8010720a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107210 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80107210:	55                   	push   %ebp
80107211:	89 e5                	mov    %esp,%ebp
80107213:	57                   	push   %edi
80107214:	89 c7                	mov    %eax,%edi
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107216:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
{
8010721a:	56                   	push   %esi
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
8010721b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  a = (char*)PGROUNDDOWN((uint)va);
80107220:	89 d6                	mov    %edx,%esi
{
80107222:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
80107223:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
{
80107229:	83 ec 1c             	sub    $0x1c,%esp
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
8010722c:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010722f:	8b 45 08             	mov    0x8(%ebp),%eax
80107232:	29 f0                	sub    %esi,%eax
80107234:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107237:	eb 1f                	jmp    80107258 <mappages+0x48>
80107239:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
80107240:	f6 00 01             	testb  $0x1,(%eax)
80107243:	75 45                	jne    8010728a <mappages+0x7a>
      panic("remap");
    *pte = pa | perm | PTE_P;
80107245:	0b 5d 0c             	or     0xc(%ebp),%ebx
80107248:	83 cb 01             	or     $0x1,%ebx
8010724b:	89 18                	mov    %ebx,(%eax)
    if(a == last)
8010724d:	3b 75 e0             	cmp    -0x20(%ebp),%esi
80107250:	74 2e                	je     80107280 <mappages+0x70>
      break;
    a += PGSIZE;
80107252:	81 c6 00 10 00 00    	add    $0x1000,%esi
  for(;;){
80107258:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
8010725b:	b9 01 00 00 00       	mov    $0x1,%ecx
80107260:	89 f2                	mov    %esi,%edx
80107262:	8d 1c 06             	lea    (%esi,%eax,1),%ebx
80107265:	89 f8                	mov    %edi,%eax
80107267:	e8 24 ff ff ff       	call   80107190 <walkpgdir>
8010726c:	85 c0                	test   %eax,%eax
8010726e:	75 d0                	jne    80107240 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
80107270:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107273:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107278:	5b                   	pop    %ebx
80107279:	5e                   	pop    %esi
8010727a:	5f                   	pop    %edi
8010727b:	5d                   	pop    %ebp
8010727c:	c3                   	ret    
8010727d:	8d 76 00             	lea    0x0(%esi),%esi
80107280:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107283:	31 c0                	xor    %eax,%eax
}
80107285:	5b                   	pop    %ebx
80107286:	5e                   	pop    %esi
80107287:	5f                   	pop    %edi
80107288:	5d                   	pop    %ebp
80107289:	c3                   	ret    
      panic("remap");
8010728a:	83 ec 0c             	sub    $0xc,%esp
8010728d:	68 98 84 10 80       	push   $0x80108498
80107292:	e8 f9 90 ff ff       	call   80100390 <panic>
80107297:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010729e:	66 90                	xchg   %ax,%ax

801072a0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801072a0:	55                   	push   %ebp
801072a1:	89 e5                	mov    %esp,%ebp
801072a3:	57                   	push   %edi
801072a4:	56                   	push   %esi
801072a5:	89 c6                	mov    %eax,%esi
801072a7:	53                   	push   %ebx
801072a8:	89 d3                	mov    %edx,%ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
801072aa:	8d 91 ff 0f 00 00    	lea    0xfff(%ecx),%edx
801072b0:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801072b6:	83 ec 1c             	sub    $0x1c,%esp
801072b9:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
801072bc:	39 da                	cmp    %ebx,%edx
801072be:	73 5b                	jae    8010731b <deallocuvm.part.0+0x7b>
801072c0:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801072c3:	89 d7                	mov    %edx,%edi
801072c5:	eb 14                	jmp    801072db <deallocuvm.part.0+0x3b>
801072c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801072ce:	66 90                	xchg   %ax,%ax
801072d0:	81 c7 00 10 00 00    	add    $0x1000,%edi
801072d6:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801072d9:	76 40                	jbe    8010731b <deallocuvm.part.0+0x7b>
    pte = walkpgdir(pgdir, (char*)a, 0);
801072db:	31 c9                	xor    %ecx,%ecx
801072dd:	89 fa                	mov    %edi,%edx
801072df:	89 f0                	mov    %esi,%eax
801072e1:	e8 aa fe ff ff       	call   80107190 <walkpgdir>
801072e6:	89 c3                	mov    %eax,%ebx
    if(!pte)
801072e8:	85 c0                	test   %eax,%eax
801072ea:	74 44                	je     80107330 <deallocuvm.part.0+0x90>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
801072ec:	8b 00                	mov    (%eax),%eax
801072ee:	a8 01                	test   $0x1,%al
801072f0:	74 de                	je     801072d0 <deallocuvm.part.0+0x30>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
801072f2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801072f7:	74 47                	je     80107340 <deallocuvm.part.0+0xa0>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
801072f9:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
801072fc:	05 00 00 00 80       	add    $0x80000000,%eax
80107301:	81 c7 00 10 00 00    	add    $0x1000,%edi
      kfree(v);
80107307:	50                   	push   %eax
80107308:	e8 43 b5 ff ff       	call   80102850 <kfree>
      *pte = 0;
8010730d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80107313:	83 c4 10             	add    $0x10,%esp
  for(; a  < oldsz; a += PGSIZE){
80107316:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80107319:	77 c0                	ja     801072db <deallocuvm.part.0+0x3b>
    }
  }
  return newsz;
}
8010731b:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010731e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107321:	5b                   	pop    %ebx
80107322:	5e                   	pop    %esi
80107323:	5f                   	pop    %edi
80107324:	5d                   	pop    %ebp
80107325:	c3                   	ret    
80107326:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010732d:	8d 76 00             	lea    0x0(%esi),%esi
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80107330:	89 fa                	mov    %edi,%edx
80107332:	81 e2 00 00 c0 ff    	and    $0xffc00000,%edx
80107338:	8d ba 00 00 40 00    	lea    0x400000(%edx),%edi
8010733e:	eb 96                	jmp    801072d6 <deallocuvm.part.0+0x36>
        panic("kfree");
80107340:	83 ec 0c             	sub    $0xc,%esp
80107343:	68 9e 7d 10 80       	push   $0x80107d9e
80107348:	e8 43 90 ff ff       	call   80100390 <panic>
8010734d:	8d 76 00             	lea    0x0(%esi),%esi

80107350 <seginit>:
{
80107350:	f3 0f 1e fb          	endbr32 
80107354:	55                   	push   %ebp
80107355:	89 e5                	mov    %esp,%ebp
80107357:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
8010735a:	e8 11 ca ff ff       	call   80103d70 <cpuid>
static inline void
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
8010735f:	ba 2f 00 00 00       	mov    $0x2f,%edx
80107364:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
8010736a:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010736e:	c7 80 38 38 11 80 ff 	movl   $0xffff,-0x7feec7c8(%eax)
80107375:	ff 00 00 
80107378:	c7 80 3c 38 11 80 00 	movl   $0xcf9a00,-0x7feec7c4(%eax)
8010737f:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80107382:	c7 80 40 38 11 80 ff 	movl   $0xffff,-0x7feec7c0(%eax)
80107389:	ff 00 00 
8010738c:	c7 80 44 38 11 80 00 	movl   $0xcf9200,-0x7feec7bc(%eax)
80107393:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107396:	c7 80 48 38 11 80 ff 	movl   $0xffff,-0x7feec7b8(%eax)
8010739d:	ff 00 00 
801073a0:	c7 80 4c 38 11 80 00 	movl   $0xcffa00,-0x7feec7b4(%eax)
801073a7:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801073aa:	c7 80 50 38 11 80 ff 	movl   $0xffff,-0x7feec7b0(%eax)
801073b1:	ff 00 00 
801073b4:	c7 80 54 38 11 80 00 	movl   $0xcff200,-0x7feec7ac(%eax)
801073bb:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
801073be:	05 30 38 11 80       	add    $0x80113830,%eax
  pd[1] = (uint)p;
801073c3:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
801073c7:	c1 e8 10             	shr    $0x10,%eax
801073ca:	66 89 45 f6          	mov    %ax,-0xa(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
801073ce:	8d 45 f2             	lea    -0xe(%ebp),%eax
801073d1:	0f 01 10             	lgdtl  (%eax)
}
801073d4:	c9                   	leave  
801073d5:	c3                   	ret    
801073d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801073dd:	8d 76 00             	lea    0x0(%esi),%esi

801073e0 <switchkvm>:
{
801073e0:	f3 0f 1e fb          	endbr32 
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801073e4:	a1 04 65 11 80       	mov    0x80116504,%eax
801073e9:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
801073ee:	0f 22 d8             	mov    %eax,%cr3
}
801073f1:	c3                   	ret    
801073f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801073f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107400 <switchuvm>:
{
80107400:	f3 0f 1e fb          	endbr32 
80107404:	55                   	push   %ebp
80107405:	89 e5                	mov    %esp,%ebp
80107407:	57                   	push   %edi
80107408:	56                   	push   %esi
80107409:	53                   	push   %ebx
8010740a:	83 ec 1c             	sub    $0x1c,%esp
8010740d:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80107410:	85 f6                	test   %esi,%esi
80107412:	0f 84 cb 00 00 00    	je     801074e3 <switchuvm+0xe3>
  if(p->kstack == 0)
80107418:	8b 46 08             	mov    0x8(%esi),%eax
8010741b:	85 c0                	test   %eax,%eax
8010741d:	0f 84 da 00 00 00    	je     801074fd <switchuvm+0xfd>
  if(p->pgdir == 0)
80107423:	8b 46 04             	mov    0x4(%esi),%eax
80107426:	85 c0                	test   %eax,%eax
80107428:	0f 84 c2 00 00 00    	je     801074f0 <switchuvm+0xf0>
  pushcli();
8010742e:	e8 3d d9 ff ff       	call   80104d70 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80107433:	e8 d8 c8 ff ff       	call   80103d10 <mycpu>
80107438:	89 c3                	mov    %eax,%ebx
8010743a:	e8 d1 c8 ff ff       	call   80103d10 <mycpu>
8010743f:	89 c7                	mov    %eax,%edi
80107441:	e8 ca c8 ff ff       	call   80103d10 <mycpu>
80107446:	83 c7 08             	add    $0x8,%edi
80107449:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010744c:	e8 bf c8 ff ff       	call   80103d10 <mycpu>
80107451:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107454:	ba 67 00 00 00       	mov    $0x67,%edx
80107459:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80107460:	83 c0 08             	add    $0x8,%eax
80107463:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
8010746a:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010746f:	83 c1 08             	add    $0x8,%ecx
80107472:	c1 e8 18             	shr    $0x18,%eax
80107475:	c1 e9 10             	shr    $0x10,%ecx
80107478:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
8010747e:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80107484:	b9 99 40 00 00       	mov    $0x4099,%ecx
80107489:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80107490:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
80107495:	e8 76 c8 ff ff       	call   80103d10 <mycpu>
8010749a:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
801074a1:	e8 6a c8 ff ff       	call   80103d10 <mycpu>
801074a6:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
801074aa:	8b 5e 08             	mov    0x8(%esi),%ebx
801074ad:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801074b3:	e8 58 c8 ff ff       	call   80103d10 <mycpu>
801074b8:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801074bb:	e8 50 c8 ff ff       	call   80103d10 <mycpu>
801074c0:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
801074c4:	b8 28 00 00 00       	mov    $0x28,%eax
801074c9:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
801074cc:	8b 46 04             	mov    0x4(%esi),%eax
801074cf:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
801074d4:	0f 22 d8             	mov    %eax,%cr3
}
801074d7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801074da:	5b                   	pop    %ebx
801074db:	5e                   	pop    %esi
801074dc:	5f                   	pop    %edi
801074dd:	5d                   	pop    %ebp
  popcli();
801074de:	e9 dd d8 ff ff       	jmp    80104dc0 <popcli>
    panic("switchuvm: no process");
801074e3:	83 ec 0c             	sub    $0xc,%esp
801074e6:	68 9e 84 10 80       	push   $0x8010849e
801074eb:	e8 a0 8e ff ff       	call   80100390 <panic>
    panic("switchuvm: no pgdir");
801074f0:	83 ec 0c             	sub    $0xc,%esp
801074f3:	68 c9 84 10 80       	push   $0x801084c9
801074f8:	e8 93 8e ff ff       	call   80100390 <panic>
    panic("switchuvm: no kstack");
801074fd:	83 ec 0c             	sub    $0xc,%esp
80107500:	68 b4 84 10 80       	push   $0x801084b4
80107505:	e8 86 8e ff ff       	call   80100390 <panic>
8010750a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107510 <inituvm>:
{
80107510:	f3 0f 1e fb          	endbr32 
80107514:	55                   	push   %ebp
80107515:	89 e5                	mov    %esp,%ebp
80107517:	57                   	push   %edi
80107518:	56                   	push   %esi
80107519:	53                   	push   %ebx
8010751a:	83 ec 1c             	sub    $0x1c,%esp
8010751d:	8b 45 0c             	mov    0xc(%ebp),%eax
80107520:	8b 75 10             	mov    0x10(%ebp),%esi
80107523:	8b 7d 08             	mov    0x8(%ebp),%edi
80107526:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80107529:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
8010752f:	77 4b                	ja     8010757c <inituvm+0x6c>
  mem = kalloc();
80107531:	e8 da b4 ff ff       	call   80102a10 <kalloc>
  memset(mem, 0, PGSIZE);
80107536:	83 ec 04             	sub    $0x4,%esp
80107539:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
8010753e:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80107540:	6a 00                	push   $0x0
80107542:	50                   	push   %eax
80107543:	e8 38 da ff ff       	call   80104f80 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107548:	58                   	pop    %eax
80107549:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010754f:	5a                   	pop    %edx
80107550:	6a 06                	push   $0x6
80107552:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107557:	31 d2                	xor    %edx,%edx
80107559:	50                   	push   %eax
8010755a:	89 f8                	mov    %edi,%eax
8010755c:	e8 af fc ff ff       	call   80107210 <mappages>
  memmove(mem, init, sz);
80107561:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107564:	89 75 10             	mov    %esi,0x10(%ebp)
80107567:	83 c4 10             	add    $0x10,%esp
8010756a:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010756d:	89 45 0c             	mov    %eax,0xc(%ebp)
}
80107570:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107573:	5b                   	pop    %ebx
80107574:	5e                   	pop    %esi
80107575:	5f                   	pop    %edi
80107576:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80107577:	e9 a4 da ff ff       	jmp    80105020 <memmove>
    panic("inituvm: more than a page");
8010757c:	83 ec 0c             	sub    $0xc,%esp
8010757f:	68 dd 84 10 80       	push   $0x801084dd
80107584:	e8 07 8e ff ff       	call   80100390 <panic>
80107589:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107590 <loaduvm>:
{
80107590:	f3 0f 1e fb          	endbr32 
80107594:	55                   	push   %ebp
80107595:	89 e5                	mov    %esp,%ebp
80107597:	57                   	push   %edi
80107598:	56                   	push   %esi
80107599:	53                   	push   %ebx
8010759a:	83 ec 1c             	sub    $0x1c,%esp
8010759d:	8b 45 0c             	mov    0xc(%ebp),%eax
801075a0:	8b 75 18             	mov    0x18(%ebp),%esi
  if((uint) addr % PGSIZE != 0)
801075a3:	a9 ff 0f 00 00       	test   $0xfff,%eax
801075a8:	0f 85 99 00 00 00    	jne    80107647 <loaduvm+0xb7>
  for(i = 0; i < sz; i += PGSIZE){
801075ae:	01 f0                	add    %esi,%eax
801075b0:	89 f3                	mov    %esi,%ebx
801075b2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
801075b5:	8b 45 14             	mov    0x14(%ebp),%eax
801075b8:	01 f0                	add    %esi,%eax
801075ba:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
801075bd:	85 f6                	test   %esi,%esi
801075bf:	75 15                	jne    801075d6 <loaduvm+0x46>
801075c1:	eb 6d                	jmp    80107630 <loaduvm+0xa0>
801075c3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801075c7:	90                   	nop
801075c8:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
801075ce:	89 f0                	mov    %esi,%eax
801075d0:	29 d8                	sub    %ebx,%eax
801075d2:	39 c6                	cmp    %eax,%esi
801075d4:	76 5a                	jbe    80107630 <loaduvm+0xa0>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
801075d6:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801075d9:	8b 45 08             	mov    0x8(%ebp),%eax
801075dc:	31 c9                	xor    %ecx,%ecx
801075de:	29 da                	sub    %ebx,%edx
801075e0:	e8 ab fb ff ff       	call   80107190 <walkpgdir>
801075e5:	85 c0                	test   %eax,%eax
801075e7:	74 51                	je     8010763a <loaduvm+0xaa>
    pa = PTE_ADDR(*pte);
801075e9:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
801075eb:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    if(sz - i < PGSIZE)
801075ee:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
801075f3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
801075f8:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
801075fe:	0f 46 fb             	cmovbe %ebx,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107601:	29 d9                	sub    %ebx,%ecx
80107603:	05 00 00 00 80       	add    $0x80000000,%eax
80107608:	57                   	push   %edi
80107609:	51                   	push   %ecx
8010760a:	50                   	push   %eax
8010760b:	ff 75 10             	pushl  0x10(%ebp)
8010760e:	e8 2d a8 ff ff       	call   80101e40 <readi>
80107613:	83 c4 10             	add    $0x10,%esp
80107616:	39 f8                	cmp    %edi,%eax
80107618:	74 ae                	je     801075c8 <loaduvm+0x38>
}
8010761a:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010761d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107622:	5b                   	pop    %ebx
80107623:	5e                   	pop    %esi
80107624:	5f                   	pop    %edi
80107625:	5d                   	pop    %ebp
80107626:	c3                   	ret    
80107627:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010762e:	66 90                	xchg   %ax,%ax
80107630:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107633:	31 c0                	xor    %eax,%eax
}
80107635:	5b                   	pop    %ebx
80107636:	5e                   	pop    %esi
80107637:	5f                   	pop    %edi
80107638:	5d                   	pop    %ebp
80107639:	c3                   	ret    
      panic("loaduvm: address should exist");
8010763a:	83 ec 0c             	sub    $0xc,%esp
8010763d:	68 f7 84 10 80       	push   $0x801084f7
80107642:	e8 49 8d ff ff       	call   80100390 <panic>
    panic("loaduvm: addr must be page aligned");
80107647:	83 ec 0c             	sub    $0xc,%esp
8010764a:	68 98 85 10 80       	push   $0x80108598
8010764f:	e8 3c 8d ff ff       	call   80100390 <panic>
80107654:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010765b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010765f:	90                   	nop

80107660 <allocuvm>:
{
80107660:	f3 0f 1e fb          	endbr32 
80107664:	55                   	push   %ebp
80107665:	89 e5                	mov    %esp,%ebp
80107667:	57                   	push   %edi
80107668:	56                   	push   %esi
80107669:	53                   	push   %ebx
8010766a:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
8010766d:	8b 45 10             	mov    0x10(%ebp),%eax
{
80107670:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(newsz >= KERNBASE)
80107673:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107676:	85 c0                	test   %eax,%eax
80107678:	0f 88 b2 00 00 00    	js     80107730 <allocuvm+0xd0>
  if(newsz < oldsz)
8010767e:	3b 45 0c             	cmp    0xc(%ebp),%eax
    return oldsz;
80107681:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(newsz < oldsz)
80107684:	0f 82 96 00 00 00    	jb     80107720 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
8010768a:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
80107690:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  for(; a < newsz; a += PGSIZE){
80107696:	39 75 10             	cmp    %esi,0x10(%ebp)
80107699:	77 40                	ja     801076db <allocuvm+0x7b>
8010769b:	e9 83 00 00 00       	jmp    80107723 <allocuvm+0xc3>
    memset(mem, 0, PGSIZE);
801076a0:	83 ec 04             	sub    $0x4,%esp
801076a3:	68 00 10 00 00       	push   $0x1000
801076a8:	6a 00                	push   $0x0
801076aa:	50                   	push   %eax
801076ab:	e8 d0 d8 ff ff       	call   80104f80 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
801076b0:	58                   	pop    %eax
801076b1:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801076b7:	5a                   	pop    %edx
801076b8:	6a 06                	push   $0x6
801076ba:	b9 00 10 00 00       	mov    $0x1000,%ecx
801076bf:	89 f2                	mov    %esi,%edx
801076c1:	50                   	push   %eax
801076c2:	89 f8                	mov    %edi,%eax
801076c4:	e8 47 fb ff ff       	call   80107210 <mappages>
801076c9:	83 c4 10             	add    $0x10,%esp
801076cc:	85 c0                	test   %eax,%eax
801076ce:	78 78                	js     80107748 <allocuvm+0xe8>
  for(; a < newsz; a += PGSIZE){
801076d0:	81 c6 00 10 00 00    	add    $0x1000,%esi
801076d6:	39 75 10             	cmp    %esi,0x10(%ebp)
801076d9:	76 48                	jbe    80107723 <allocuvm+0xc3>
    mem = kalloc();
801076db:	e8 30 b3 ff ff       	call   80102a10 <kalloc>
801076e0:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
801076e2:	85 c0                	test   %eax,%eax
801076e4:	75 ba                	jne    801076a0 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
801076e6:	83 ec 0c             	sub    $0xc,%esp
801076e9:	68 15 85 10 80       	push   $0x80108515
801076ee:	e8 bd 8f ff ff       	call   801006b0 <cprintf>
  if(newsz >= oldsz)
801076f3:	8b 45 0c             	mov    0xc(%ebp),%eax
801076f6:	83 c4 10             	add    $0x10,%esp
801076f9:	39 45 10             	cmp    %eax,0x10(%ebp)
801076fc:	74 32                	je     80107730 <allocuvm+0xd0>
801076fe:	8b 55 10             	mov    0x10(%ebp),%edx
80107701:	89 c1                	mov    %eax,%ecx
80107703:	89 f8                	mov    %edi,%eax
80107705:	e8 96 fb ff ff       	call   801072a0 <deallocuvm.part.0>
      return 0;
8010770a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80107711:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107714:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107717:	5b                   	pop    %ebx
80107718:	5e                   	pop    %esi
80107719:	5f                   	pop    %edi
8010771a:	5d                   	pop    %ebp
8010771b:	c3                   	ret    
8010771c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
80107720:	89 45 e4             	mov    %eax,-0x1c(%ebp)
}
80107723:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107726:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107729:	5b                   	pop    %ebx
8010772a:	5e                   	pop    %esi
8010772b:	5f                   	pop    %edi
8010772c:	5d                   	pop    %ebp
8010772d:	c3                   	ret    
8010772e:	66 90                	xchg   %ax,%ax
    return 0;
80107730:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80107737:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010773a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010773d:	5b                   	pop    %ebx
8010773e:	5e                   	pop    %esi
8010773f:	5f                   	pop    %edi
80107740:	5d                   	pop    %ebp
80107741:	c3                   	ret    
80107742:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80107748:	83 ec 0c             	sub    $0xc,%esp
8010774b:	68 2d 85 10 80       	push   $0x8010852d
80107750:	e8 5b 8f ff ff       	call   801006b0 <cprintf>
  if(newsz >= oldsz)
80107755:	8b 45 0c             	mov    0xc(%ebp),%eax
80107758:	83 c4 10             	add    $0x10,%esp
8010775b:	39 45 10             	cmp    %eax,0x10(%ebp)
8010775e:	74 0c                	je     8010776c <allocuvm+0x10c>
80107760:	8b 55 10             	mov    0x10(%ebp),%edx
80107763:	89 c1                	mov    %eax,%ecx
80107765:	89 f8                	mov    %edi,%eax
80107767:	e8 34 fb ff ff       	call   801072a0 <deallocuvm.part.0>
      kfree(mem);
8010776c:	83 ec 0c             	sub    $0xc,%esp
8010776f:	53                   	push   %ebx
80107770:	e8 db b0 ff ff       	call   80102850 <kfree>
      return 0;
80107775:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
8010777c:	83 c4 10             	add    $0x10,%esp
}
8010777f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107782:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107785:	5b                   	pop    %ebx
80107786:	5e                   	pop    %esi
80107787:	5f                   	pop    %edi
80107788:	5d                   	pop    %ebp
80107789:	c3                   	ret    
8010778a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107790 <deallocuvm>:
{
80107790:	f3 0f 1e fb          	endbr32 
80107794:	55                   	push   %ebp
80107795:	89 e5                	mov    %esp,%ebp
80107797:	8b 55 0c             	mov    0xc(%ebp),%edx
8010779a:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010779d:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
801077a0:	39 d1                	cmp    %edx,%ecx
801077a2:	73 0c                	jae    801077b0 <deallocuvm+0x20>
}
801077a4:	5d                   	pop    %ebp
801077a5:	e9 f6 fa ff ff       	jmp    801072a0 <deallocuvm.part.0>
801077aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801077b0:	89 d0                	mov    %edx,%eax
801077b2:	5d                   	pop    %ebp
801077b3:	c3                   	ret    
801077b4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801077bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801077bf:	90                   	nop

801077c0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
801077c0:	f3 0f 1e fb          	endbr32 
801077c4:	55                   	push   %ebp
801077c5:	89 e5                	mov    %esp,%ebp
801077c7:	57                   	push   %edi
801077c8:	56                   	push   %esi
801077c9:	53                   	push   %ebx
801077ca:	83 ec 0c             	sub    $0xc,%esp
801077cd:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
801077d0:	85 f6                	test   %esi,%esi
801077d2:	74 55                	je     80107829 <freevm+0x69>
  if(newsz >= oldsz)
801077d4:	31 c9                	xor    %ecx,%ecx
801077d6:	ba 00 00 00 80       	mov    $0x80000000,%edx
801077db:	89 f0                	mov    %esi,%eax
801077dd:	89 f3                	mov    %esi,%ebx
801077df:	e8 bc fa ff ff       	call   801072a0 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
801077e4:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
801077ea:	eb 0b                	jmp    801077f7 <freevm+0x37>
801077ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801077f0:	83 c3 04             	add    $0x4,%ebx
801077f3:	39 df                	cmp    %ebx,%edi
801077f5:	74 23                	je     8010781a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
801077f7:	8b 03                	mov    (%ebx),%eax
801077f9:	a8 01                	test   $0x1,%al
801077fb:	74 f3                	je     801077f0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
801077fd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80107802:	83 ec 0c             	sub    $0xc,%esp
80107805:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107808:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
8010780d:	50                   	push   %eax
8010780e:	e8 3d b0 ff ff       	call   80102850 <kfree>
80107813:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107816:	39 df                	cmp    %ebx,%edi
80107818:	75 dd                	jne    801077f7 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
8010781a:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010781d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107820:	5b                   	pop    %ebx
80107821:	5e                   	pop    %esi
80107822:	5f                   	pop    %edi
80107823:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107824:	e9 27 b0 ff ff       	jmp    80102850 <kfree>
    panic("freevm: no pgdir");
80107829:	83 ec 0c             	sub    $0xc,%esp
8010782c:	68 49 85 10 80       	push   $0x80108549
80107831:	e8 5a 8b ff ff       	call   80100390 <panic>
80107836:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010783d:	8d 76 00             	lea    0x0(%esi),%esi

80107840 <setupkvm>:
{
80107840:	f3 0f 1e fb          	endbr32 
80107844:	55                   	push   %ebp
80107845:	89 e5                	mov    %esp,%ebp
80107847:	56                   	push   %esi
80107848:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80107849:	e8 c2 b1 ff ff       	call   80102a10 <kalloc>
8010784e:	89 c6                	mov    %eax,%esi
80107850:	85 c0                	test   %eax,%eax
80107852:	74 42                	je     80107896 <setupkvm+0x56>
  memset(pgdir, 0, PGSIZE);
80107854:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107857:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  memset(pgdir, 0, PGSIZE);
8010785c:	68 00 10 00 00       	push   $0x1000
80107861:	6a 00                	push   $0x0
80107863:	50                   	push   %eax
80107864:	e8 17 d7 ff ff       	call   80104f80 <memset>
80107869:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
8010786c:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
8010786f:	83 ec 08             	sub    $0x8,%esp
80107872:	8b 4b 08             	mov    0x8(%ebx),%ecx
80107875:	ff 73 0c             	pushl  0xc(%ebx)
80107878:	8b 13                	mov    (%ebx),%edx
8010787a:	50                   	push   %eax
8010787b:	29 c1                	sub    %eax,%ecx
8010787d:	89 f0                	mov    %esi,%eax
8010787f:	e8 8c f9 ff ff       	call   80107210 <mappages>
80107884:	83 c4 10             	add    $0x10,%esp
80107887:	85 c0                	test   %eax,%eax
80107889:	78 15                	js     801078a0 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
8010788b:	83 c3 10             	add    $0x10,%ebx
8010788e:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
80107894:	75 d6                	jne    8010786c <setupkvm+0x2c>
}
80107896:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107899:	89 f0                	mov    %esi,%eax
8010789b:	5b                   	pop    %ebx
8010789c:	5e                   	pop    %esi
8010789d:	5d                   	pop    %ebp
8010789e:	c3                   	ret    
8010789f:	90                   	nop
      freevm(pgdir);
801078a0:	83 ec 0c             	sub    $0xc,%esp
801078a3:	56                   	push   %esi
      return 0;
801078a4:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
801078a6:	e8 15 ff ff ff       	call   801077c0 <freevm>
      return 0;
801078ab:	83 c4 10             	add    $0x10,%esp
}
801078ae:	8d 65 f8             	lea    -0x8(%ebp),%esp
801078b1:	89 f0                	mov    %esi,%eax
801078b3:	5b                   	pop    %ebx
801078b4:	5e                   	pop    %esi
801078b5:	5d                   	pop    %ebp
801078b6:	c3                   	ret    
801078b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801078be:	66 90                	xchg   %ax,%ax

801078c0 <kvmalloc>:
{
801078c0:	f3 0f 1e fb          	endbr32 
801078c4:	55                   	push   %ebp
801078c5:	89 e5                	mov    %esp,%ebp
801078c7:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
801078ca:	e8 71 ff ff ff       	call   80107840 <setupkvm>
801078cf:	a3 04 65 11 80       	mov    %eax,0x80116504
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801078d4:	05 00 00 00 80       	add    $0x80000000,%eax
801078d9:	0f 22 d8             	mov    %eax,%cr3
}
801078dc:	c9                   	leave  
801078dd:	c3                   	ret    
801078de:	66 90                	xchg   %ax,%ax

801078e0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
801078e0:	f3 0f 1e fb          	endbr32 
801078e4:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801078e5:	31 c9                	xor    %ecx,%ecx
{
801078e7:	89 e5                	mov    %esp,%ebp
801078e9:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
801078ec:	8b 55 0c             	mov    0xc(%ebp),%edx
801078ef:	8b 45 08             	mov    0x8(%ebp),%eax
801078f2:	e8 99 f8 ff ff       	call   80107190 <walkpgdir>
  if(pte == 0)
801078f7:	85 c0                	test   %eax,%eax
801078f9:	74 05                	je     80107900 <clearpteu+0x20>
    panic("clearpteu");
  *pte &= ~PTE_U;
801078fb:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
801078fe:	c9                   	leave  
801078ff:	c3                   	ret    
    panic("clearpteu");
80107900:	83 ec 0c             	sub    $0xc,%esp
80107903:	68 5a 85 10 80       	push   $0x8010855a
80107908:	e8 83 8a ff ff       	call   80100390 <panic>
8010790d:	8d 76 00             	lea    0x0(%esi),%esi

80107910 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107910:	f3 0f 1e fb          	endbr32 
80107914:	55                   	push   %ebp
80107915:	89 e5                	mov    %esp,%ebp
80107917:	57                   	push   %edi
80107918:	56                   	push   %esi
80107919:	53                   	push   %ebx
8010791a:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
8010791d:	e8 1e ff ff ff       	call   80107840 <setupkvm>
80107922:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107925:	85 c0                	test   %eax,%eax
80107927:	0f 84 9b 00 00 00    	je     801079c8 <copyuvm+0xb8>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
8010792d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107930:	85 c9                	test   %ecx,%ecx
80107932:	0f 84 90 00 00 00    	je     801079c8 <copyuvm+0xb8>
80107938:	31 f6                	xor    %esi,%esi
8010793a:	eb 46                	jmp    80107982 <copyuvm+0x72>
8010793c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107940:	83 ec 04             	sub    $0x4,%esp
80107943:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107949:	68 00 10 00 00       	push   $0x1000
8010794e:	57                   	push   %edi
8010794f:	50                   	push   %eax
80107950:	e8 cb d6 ff ff       	call   80105020 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80107955:	58                   	pop    %eax
80107956:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010795c:	5a                   	pop    %edx
8010795d:	ff 75 e4             	pushl  -0x1c(%ebp)
80107960:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107965:	89 f2                	mov    %esi,%edx
80107967:	50                   	push   %eax
80107968:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010796b:	e8 a0 f8 ff ff       	call   80107210 <mappages>
80107970:	83 c4 10             	add    $0x10,%esp
80107973:	85 c0                	test   %eax,%eax
80107975:	78 61                	js     801079d8 <copyuvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
80107977:	81 c6 00 10 00 00    	add    $0x1000,%esi
8010797d:	39 75 0c             	cmp    %esi,0xc(%ebp)
80107980:	76 46                	jbe    801079c8 <copyuvm+0xb8>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107982:	8b 45 08             	mov    0x8(%ebp),%eax
80107985:	31 c9                	xor    %ecx,%ecx
80107987:	89 f2                	mov    %esi,%edx
80107989:	e8 02 f8 ff ff       	call   80107190 <walkpgdir>
8010798e:	85 c0                	test   %eax,%eax
80107990:	74 61                	je     801079f3 <copyuvm+0xe3>
    if(!(*pte & PTE_P))
80107992:	8b 00                	mov    (%eax),%eax
80107994:	a8 01                	test   $0x1,%al
80107996:	74 4e                	je     801079e6 <copyuvm+0xd6>
    pa = PTE_ADDR(*pte);
80107998:	89 c7                	mov    %eax,%edi
    flags = PTE_FLAGS(*pte);
8010799a:	25 ff 0f 00 00       	and    $0xfff,%eax
8010799f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    pa = PTE_ADDR(*pte);
801079a2:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
801079a8:	e8 63 b0 ff ff       	call   80102a10 <kalloc>
801079ad:	89 c3                	mov    %eax,%ebx
801079af:	85 c0                	test   %eax,%eax
801079b1:	75 8d                	jne    80107940 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
801079b3:	83 ec 0c             	sub    $0xc,%esp
801079b6:	ff 75 e0             	pushl  -0x20(%ebp)
801079b9:	e8 02 fe ff ff       	call   801077c0 <freevm>
  return 0;
801079be:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
801079c5:	83 c4 10             	add    $0x10,%esp
}
801079c8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801079cb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801079ce:	5b                   	pop    %ebx
801079cf:	5e                   	pop    %esi
801079d0:	5f                   	pop    %edi
801079d1:	5d                   	pop    %ebp
801079d2:	c3                   	ret    
801079d3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801079d7:	90                   	nop
      kfree(mem);
801079d8:	83 ec 0c             	sub    $0xc,%esp
801079db:	53                   	push   %ebx
801079dc:	e8 6f ae ff ff       	call   80102850 <kfree>
      goto bad;
801079e1:	83 c4 10             	add    $0x10,%esp
801079e4:	eb cd                	jmp    801079b3 <copyuvm+0xa3>
      panic("copyuvm: page not present");
801079e6:	83 ec 0c             	sub    $0xc,%esp
801079e9:	68 7e 85 10 80       	push   $0x8010857e
801079ee:	e8 9d 89 ff ff       	call   80100390 <panic>
      panic("copyuvm: pte should exist");
801079f3:	83 ec 0c             	sub    $0xc,%esp
801079f6:	68 64 85 10 80       	push   $0x80108564
801079fb:	e8 90 89 ff ff       	call   80100390 <panic>

80107a00 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107a00:	f3 0f 1e fb          	endbr32 
80107a04:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107a05:	31 c9                	xor    %ecx,%ecx
{
80107a07:	89 e5                	mov    %esp,%ebp
80107a09:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107a0c:	8b 55 0c             	mov    0xc(%ebp),%edx
80107a0f:	8b 45 08             	mov    0x8(%ebp),%eax
80107a12:	e8 79 f7 ff ff       	call   80107190 <walkpgdir>
  if((*pte & PTE_P) == 0)
80107a17:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107a19:	c9                   	leave  
  if((*pte & PTE_U) == 0)
80107a1a:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107a1c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
80107a21:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107a24:	05 00 00 00 80       	add    $0x80000000,%eax
80107a29:	83 fa 05             	cmp    $0x5,%edx
80107a2c:	ba 00 00 00 00       	mov    $0x0,%edx
80107a31:	0f 45 c2             	cmovne %edx,%eax
}
80107a34:	c3                   	ret    
80107a35:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107a3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107a40 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107a40:	f3 0f 1e fb          	endbr32 
80107a44:	55                   	push   %ebp
80107a45:	89 e5                	mov    %esp,%ebp
80107a47:	57                   	push   %edi
80107a48:	56                   	push   %esi
80107a49:	53                   	push   %ebx
80107a4a:	83 ec 0c             	sub    $0xc,%esp
80107a4d:	8b 75 14             	mov    0x14(%ebp),%esi
80107a50:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107a53:	85 f6                	test   %esi,%esi
80107a55:	75 3c                	jne    80107a93 <copyout+0x53>
80107a57:	eb 67                	jmp    80107ac0 <copyout+0x80>
80107a59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80107a60:	8b 55 0c             	mov    0xc(%ebp),%edx
80107a63:	89 fb                	mov    %edi,%ebx
80107a65:	29 d3                	sub    %edx,%ebx
80107a67:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if(n > len)
80107a6d:	39 f3                	cmp    %esi,%ebx
80107a6f:	0f 47 de             	cmova  %esi,%ebx
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107a72:	29 fa                	sub    %edi,%edx
80107a74:	83 ec 04             	sub    $0x4,%esp
80107a77:	01 c2                	add    %eax,%edx
80107a79:	53                   	push   %ebx
80107a7a:	ff 75 10             	pushl  0x10(%ebp)
80107a7d:	52                   	push   %edx
80107a7e:	e8 9d d5 ff ff       	call   80105020 <memmove>
    len -= n;
    buf += n;
80107a83:	01 5d 10             	add    %ebx,0x10(%ebp)
    va = va0 + PGSIZE;
80107a86:	8d 97 00 10 00 00    	lea    0x1000(%edi),%edx
  while(len > 0){
80107a8c:	83 c4 10             	add    $0x10,%esp
80107a8f:	29 de                	sub    %ebx,%esi
80107a91:	74 2d                	je     80107ac0 <copyout+0x80>
    va0 = (uint)PGROUNDDOWN(va);
80107a93:	89 d7                	mov    %edx,%edi
    pa0 = uva2ka(pgdir, (char*)va0);
80107a95:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
80107a98:	89 55 0c             	mov    %edx,0xc(%ebp)
80107a9b:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    pa0 = uva2ka(pgdir, (char*)va0);
80107aa1:	57                   	push   %edi
80107aa2:	ff 75 08             	pushl  0x8(%ebp)
80107aa5:	e8 56 ff ff ff       	call   80107a00 <uva2ka>
    if(pa0 == 0)
80107aaa:	83 c4 10             	add    $0x10,%esp
80107aad:	85 c0                	test   %eax,%eax
80107aaf:	75 af                	jne    80107a60 <copyout+0x20>
  }
  return 0;
}
80107ab1:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107ab4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107ab9:	5b                   	pop    %ebx
80107aba:	5e                   	pop    %esi
80107abb:	5f                   	pop    %edi
80107abc:	5d                   	pop    %ebp
80107abd:	c3                   	ret    
80107abe:	66 90                	xchg   %ax,%ax
80107ac0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107ac3:	31 c0                	xor    %eax,%eax
}
80107ac5:	5b                   	pop    %ebx
80107ac6:	5e                   	pop    %esi
80107ac7:	5f                   	pop    %edi
80107ac8:	5d                   	pop    %ebp
80107ac9:	c3                   	ret    
