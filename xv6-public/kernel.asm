
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4 0f                	in     $0xf,%al

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc b0 b5 10 80       	mov    $0x8010b5b0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 10 2f 10 80       	mov    $0x80102f10,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
	...

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb f4 b5 10 80       	mov    $0x8010b5f4,%ebx
  struct buf head;
} bcache;

void
binit(void)
{
80100049:	83 ec 14             	sub    $0x14,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
8010004c:	c7 44 24 04 a0 6e 10 	movl   $0x80106ea0,0x4(%esp)
80100053:	80 
80100054:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
8010005b:	e8 70 41 00 00       	call   801041d0 <initlock>

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
80100060:	ba bc fc 10 80       	mov    $0x8010fcbc,%edx

  initlock(&bcache.lock, "bcache");

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
80100065:	c7 05 0c fd 10 80 bc 	movl   $0x8010fcbc,0x8010fd0c
8010006c:	fc 10 80 
  bcache.head.next = &bcache.head;
8010006f:	c7 05 10 fd 10 80 bc 	movl   $0x8010fcbc,0x8010fd10
80100076:	fc 10 80 
80100079:	eb 09                	jmp    80100084 <binit+0x44>
8010007b:	90                   	nop
8010007c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100080:	89 da                	mov    %ebx,%edx
80100082:	89 c3                	mov    %eax,%ebx
    b->next = bcache.head.next;
80100084:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100087:	8d 43 0c             	lea    0xc(%ebx),%eax
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    b->next = bcache.head.next;
    b->prev = &bcache.head;
8010008a:	c7 43 50 bc fc 10 80 	movl   $0x8010fcbc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100091:	89 04 24             	mov    %eax,(%esp)
80100094:	c7 44 24 04 a7 6e 10 	movl   $0x80106ea7,0x4(%esp)
8010009b:	80 
8010009c:	e8 ff 3f 00 00       	call   801040a0 <initsleeplock>
    bcache.head.next->prev = b;
801000a1:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
801000a6:	89 58 50             	mov    %ebx,0x50(%eax)

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a9:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
801000af:	3d bc fc 10 80       	cmp    $0x8010fcbc,%eax
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
    bcache.head.next = b;
801000b4:	89 1d 10 fd 10 80    	mov    %ebx,0x8010fd10

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000ba:	72 c4                	jb     80100080 <binit+0x40>
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
}
801000bc:	83 c4 14             	add    $0x14,%esp
801000bf:	5b                   	pop    %ebx
801000c0:	5d                   	pop    %ebp
801000c1:	c3                   	ret    
801000c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 1c             	sub    $0x1c,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
static struct buf*
bget(uint dev, uint blockno)
{
  struct buf *b;

  acquire(&bcache.lock);
801000df:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
801000e6:	e8 55 42 00 00       	call   80104340 <acquire>

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000eb:	8b 1d 10 fd 10 80    	mov    0x8010fd10,%ebx
801000f1:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
801000f7:	75 12                	jne    8010010b <bread+0x3b>
801000f9:	eb 25                	jmp    80100120 <bread+0x50>
801000fb:	90                   	nop
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	90                   	nop
8010011c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }

  // Not cached; recycle an unused buffer.
  // Even if refcnt==0, B_DIRTY indicates a buffer is in use
  // because log.c has modified it but not yet committed it.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 0c fd 10 80    	mov    0x8010fd0c,%ebx
80100126:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 58                	jmp    80100188 <bread+0xb8>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb bc fc 10 80    	cmp    $0x8010fcbc,%ebx
80100139:	74 4d                	je     80100188 <bread+0xb8>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
80100161:	e8 4a 42 00 00       	call   801043b0 <release>
      acquiresleep(&b->lock);
80100166:	8d 43 0c             	lea    0xc(%ebx),%eax
80100169:	89 04 24             	mov    %eax,(%esp)
8010016c:	e8 6f 3f 00 00       	call   801040e0 <acquiresleep>
bread(uint dev, uint blockno)
{
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100171:	f6 03 02             	testb  $0x2,(%ebx)
80100174:	75 08                	jne    8010017e <bread+0xae>
    iderw(b);
80100176:	89 1c 24             	mov    %ebx,(%esp)
80100179:	e8 d2 20 00 00       	call   80102250 <iderw>
  }
  return b;
}
8010017e:	83 c4 1c             	add    $0x1c,%esp
80100181:	89 d8                	mov    %ebx,%eax
80100183:	5b                   	pop    %ebx
80100184:	5e                   	pop    %esi
80100185:	5f                   	pop    %edi
80100186:	5d                   	pop    %ebp
80100187:	c3                   	ret    
      release(&bcache.lock);
      acquiresleep(&b->lock);
      return b;
    }
  }
  panic("bget: no buffers");
80100188:	c7 04 24 ae 6e 10 80 	movl   $0x80106eae,(%esp)
8010018f:	e8 dc 01 00 00       	call   80100370 <panic>
80100194:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010019a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801001a0 <bwrite>:
}

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	53                   	push   %ebx
801001a4:	83 ec 14             	sub    $0x14,%esp
801001a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001aa:	8d 43 0c             	lea    0xc(%ebx),%eax
801001ad:	89 04 24             	mov    %eax,(%esp)
801001b0:	e8 cb 3f 00 00       	call   80104180 <holdingsleep>
801001b5:	85 c0                	test   %eax,%eax
801001b7:	74 10                	je     801001c9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001b9:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001bc:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001bf:	83 c4 14             	add    $0x14,%esp
801001c2:	5b                   	pop    %ebx
801001c3:	5d                   	pop    %ebp
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
  b->flags |= B_DIRTY;
  iderw(b);
801001c4:	e9 87 20 00 00       	jmp    80102250 <iderw>
// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
801001c9:	c7 04 24 bf 6e 10 80 	movl   $0x80106ebf,(%esp)
801001d0:	e8 9b 01 00 00       	call   80100370 <panic>
801001d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801001d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801001e0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001e0:	55                   	push   %ebp
801001e1:	89 e5                	mov    %esp,%ebp
801001e3:	56                   	push   %esi
801001e4:	53                   	push   %ebx
801001e5:	83 ec 10             	sub    $0x10,%esp
801001e8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001eb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ee:	89 34 24             	mov    %esi,(%esp)
801001f1:	e8 8a 3f 00 00       	call   80104180 <holdingsleep>
801001f6:	85 c0                	test   %eax,%eax
801001f8:	74 62                	je     8010025c <brelse+0x7c>
    panic("brelse");

  releasesleep(&b->lock);
801001fa:	89 34 24             	mov    %esi,(%esp)
801001fd:	e8 3e 3f 00 00       	call   80104140 <releasesleep>

  acquire(&bcache.lock);
80100202:	c7 04 24 c0 b5 10 80 	movl   $0x8010b5c0,(%esp)
80100209:	e8 32 41 00 00       	call   80104340 <acquire>
  b->refcnt--;
8010020e:	8b 43 4c             	mov    0x4c(%ebx),%eax
80100211:	83 e8 01             	sub    $0x1,%eax
  if (b->refcnt == 0) {
80100214:	85 c0                	test   %eax,%eax
    panic("brelse");

  releasesleep(&b->lock);

  acquire(&bcache.lock);
  b->refcnt--;
80100216:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
80100219:	75 2f                	jne    8010024a <brelse+0x6a>
    // no one is waiting for it.
    b->next->prev = b->prev;
8010021b:	8b 43 54             	mov    0x54(%ebx),%eax
8010021e:	8b 53 50             	mov    0x50(%ebx),%edx
80100221:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100224:	8b 43 50             	mov    0x50(%ebx),%eax
80100227:	8b 53 54             	mov    0x54(%ebx),%edx
8010022a:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
8010022d:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
    b->prev = &bcache.head;
80100232:	c7 43 50 bc fc 10 80 	movl   $0x8010fcbc,0x50(%ebx)
  b->refcnt--;
  if (b->refcnt == 0) {
    // no one is waiting for it.
    b->next->prev = b->prev;
    b->prev->next = b->next;
    b->next = bcache.head.next;
80100239:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    bcache.head.next->prev = b;
8010023c:	a1 10 fd 10 80       	mov    0x8010fd10,%eax
80100241:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100244:	89 1d 10 fd 10 80    	mov    %ebx,0x8010fd10
  }
  
  release(&bcache.lock);
8010024a:	c7 45 08 c0 b5 10 80 	movl   $0x8010b5c0,0x8(%ebp)
}
80100251:	83 c4 10             	add    $0x10,%esp
80100254:	5b                   	pop    %ebx
80100255:	5e                   	pop    %esi
80100256:	5d                   	pop    %ebp
    b->prev = &bcache.head;
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
  
  release(&bcache.lock);
80100257:	e9 54 41 00 00       	jmp    801043b0 <release>
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("brelse");
8010025c:	c7 04 24 c6 6e 10 80 	movl   $0x80106ec6,(%esp)
80100263:	e8 08 01 00 00       	call   80100370 <panic>
	...

80100270 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100270:	55                   	push   %ebp
80100271:	89 e5                	mov    %esp,%ebp
80100273:	57                   	push   %edi
80100274:	56                   	push   %esi
80100275:	53                   	push   %ebx
80100276:	83 ec 2c             	sub    $0x2c,%esp
80100279:	8b 5d 10             	mov    0x10(%ebp),%ebx
8010027c:	8b 7d 08             	mov    0x8(%ebp),%edi
8010027f:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
80100282:	89 3c 24             	mov    %edi,(%esp)
80100285:	e8 16 15 00 00       	call   801017a0 <iunlock>
  target = n;
8010028a:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  acquire(&cons.lock);
8010028d:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
80100294:	e8 a7 40 00 00       	call   80104340 <acquire>
  while(n > 0){
80100299:	31 c0                	xor    %eax,%eax
8010029b:	85 db                	test   %ebx,%ebx
8010029d:	7f 29                	jg     801002c8 <consoleread+0x58>
8010029f:	eb 6a                	jmp    8010030b <consoleread+0x9b>
801002a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    while(input.r == input.w){
      if(myproc()->killed){
801002a8:	e8 43 35 00 00       	call   801037f0 <myproc>
801002ad:	8b 40 24             	mov    0x24(%eax),%eax
801002b0:	85 c0                	test   %eax,%eax
801002b2:	75 7c                	jne    80100330 <consoleread+0xc0>
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002b4:	c7 44 24 04 20 a5 10 	movl   $0x8010a520,0x4(%esp)
801002bb:	80 
801002bc:	c7 04 24 a0 ff 10 80 	movl   $0x8010ffa0,(%esp)
801002c3:	e8 88 3a 00 00       	call   80103d50 <sleep>

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
    while(input.r == input.w){
801002c8:	a1 a0 ff 10 80       	mov    0x8010ffa0,%eax
801002cd:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
801002d3:	74 d3                	je     801002a8 <consoleread+0x38>
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
801002d5:	89 c2                	mov    %eax,%edx
801002d7:	83 e2 7f             	and    $0x7f,%edx
801002da:	0f b6 8a 20 ff 10 80 	movzbl -0x7fef00e0(%edx),%ecx
801002e1:	0f be d1             	movsbl %cl,%edx
801002e4:	89 55 dc             	mov    %edx,-0x24(%ebp)
801002e7:	8d 50 01             	lea    0x1(%eax),%edx
    if(c == C('D')){  // EOF
801002ea:	83 7d dc 04          	cmpl   $0x4,-0x24(%ebp)
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
801002ee:	89 15 a0 ff 10 80    	mov    %edx,0x8010ffa0
    if(c == C('D')){  // EOF
801002f4:	74 5b                	je     80100351 <consoleread+0xe1>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
801002f6:	88 0e                	mov    %cl,(%esi)
    --n;
801002f8:	83 eb 01             	sub    $0x1,%ebx
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
801002fb:	83 c6 01             	add    $0x1,%esi
    --n;
    if(c == '\n')
801002fe:	83 7d dc 0a          	cmpl   $0xa,-0x24(%ebp)
80100302:	74 57                	je     8010035b <consoleread+0xeb>
  int c;

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
80100304:	85 db                	test   %ebx,%ebx
80100306:	75 c0                	jne    801002c8 <consoleread+0x58>
80100308:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
  }
  release(&cons.lock);
8010030b:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010030e:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
80100315:	e8 96 40 00 00       	call   801043b0 <release>
  ilock(ip);
8010031a:	89 3c 24             	mov    %edi,(%esp)
8010031d:	e8 9e 13 00 00       	call   801016c0 <ilock>
80100322:	8b 45 e0             	mov    -0x20(%ebp),%eax

  return target - n;
}
80100325:	83 c4 2c             	add    $0x2c,%esp
80100328:	5b                   	pop    %ebx
80100329:	5e                   	pop    %esi
8010032a:	5f                   	pop    %edi
8010032b:	5d                   	pop    %ebp
8010032c:	c3                   	ret    
8010032d:	8d 76 00             	lea    0x0(%esi),%esi
  target = n;
  acquire(&cons.lock);
  while(n > 0){
    while(input.r == input.w){
      if(myproc()->killed){
        release(&cons.lock);
80100330:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
80100337:	e8 74 40 00 00       	call   801043b0 <release>
        ilock(ip);
8010033c:	89 3c 24             	mov    %edi,(%esp)
8010033f:	e8 7c 13 00 00       	call   801016c0 <ilock>
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
80100344:	83 c4 2c             	add    $0x2c,%esp
  while(n > 0){
    while(input.r == input.w){
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
80100347:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
8010034c:	5b                   	pop    %ebx
8010034d:	5e                   	pop    %esi
8010034e:	5f                   	pop    %edi
8010034f:	5d                   	pop    %ebp
80100350:	c3                   	ret    
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
    if(c == C('D')){  // EOF
      if(n < target){
80100351:	39 5d e4             	cmp    %ebx,-0x1c(%ebp)
80100354:	76 05                	jbe    8010035b <consoleread+0xeb>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
80100356:	a3 a0 ff 10 80       	mov    %eax,0x8010ffa0
8010035b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010035e:	29 d8                	sub    %ebx,%eax
80100360:	eb a9                	jmp    8010030b <consoleread+0x9b>
80100362:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100370 <panic>:
    release(&cons.lock);
}

void
panic(char *s)
{
80100370:	55                   	push   %ebp
80100371:	89 e5                	mov    %esp,%ebp
80100373:	56                   	push   %esi
80100374:	53                   	push   %ebx
80100375:	83 ec 40             	sub    $0x40,%esp
  int i;
  uint pcs[10];

  cli();
  cons.locking = 0;
80100378:	c7 05 54 a5 10 80 00 	movl   $0x0,0x8010a554
8010037f:	00 00 00 
}

static inline void
cli(void)
{
  asm volatile("cli");
80100382:	fa                   	cli    
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
80100383:	e8 28 24 00 00       	call   801027b0 <lapicid>
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
80100388:	8d 5d d0             	lea    -0x30(%ebp),%ebx
  uint pcs[10];

  cli();
  cons.locking = 0;
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
8010038b:	c7 04 24 cd 6e 10 80 	movl   $0x80106ecd,(%esp)
  if(locking)
    release(&cons.lock);
}

void
panic(char *s)
80100392:	8d 75 f8             	lea    -0x8(%ebp),%esi
  uint pcs[10];

  cli();
  cons.locking = 0;
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
80100395:	89 44 24 04          	mov    %eax,0x4(%esp)
80100399:	e8 b2 02 00 00       	call   80100650 <cprintf>
  cprintf(s);
8010039e:	8b 45 08             	mov    0x8(%ebp),%eax
801003a1:	89 04 24             	mov    %eax,(%esp)
801003a4:	e8 a7 02 00 00       	call   80100650 <cprintf>
  cprintf("\n");
801003a9:	c7 04 24 fb 77 10 80 	movl   $0x801077fb,(%esp)
801003b0:	e8 9b 02 00 00       	call   80100650 <cprintf>
  getcallerpcs(&s, pcs);
801003b5:	8d 45 08             	lea    0x8(%ebp),%eax
801003b8:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801003bc:	89 04 24             	mov    %eax,(%esp)
801003bf:	e8 2c 3e 00 00       	call   801041f0 <getcallerpcs>
801003c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
801003c8:	8b 03                	mov    (%ebx),%eax
801003ca:	83 c3 04             	add    $0x4,%ebx
801003cd:	c7 04 24 e1 6e 10 80 	movl   $0x80106ee1,(%esp)
801003d4:	89 44 24 04          	mov    %eax,0x4(%esp)
801003d8:	e8 73 02 00 00       	call   80100650 <cprintf>
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
801003dd:	39 f3                	cmp    %esi,%ebx
801003df:	75 e7                	jne    801003c8 <panic+0x58>
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
801003e1:	c7 05 58 a5 10 80 01 	movl   $0x1,0x8010a558
801003e8:	00 00 00 
801003eb:	eb fe                	jmp    801003eb <panic+0x7b>
801003ed:	8d 76 00             	lea    0x0(%esi),%esi

801003f0 <consputc>:
  crt[pos] = ' ' | 0x0700;
}

void
consputc(int c)
{
801003f0:	55                   	push   %ebp
801003f1:	89 e5                	mov    %esp,%ebp
801003f3:	57                   	push   %edi
801003f4:	56                   	push   %esi
801003f5:	89 c6                	mov    %eax,%esi
801003f7:	53                   	push   %ebx
801003f8:	83 ec 1c             	sub    $0x1c,%esp
  if(panicked){
801003fb:	8b 15 58 a5 10 80    	mov    0x8010a558,%edx
80100401:	85 d2                	test   %edx,%edx
80100403:	74 03                	je     80100408 <consputc+0x18>
80100405:	fa                   	cli    
80100406:	eb fe                	jmp    80100406 <consputc+0x16>
    cli();
    for(;;)
      ;
  }

  if(c == BACKSPACE){
80100408:	3d 00 01 00 00       	cmp    $0x100,%eax
8010040d:	0f 84 ac 00 00 00    	je     801004bf <consputc+0xcf>
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
80100413:	89 04 24             	mov    %eax,(%esp)
80100416:	e8 d5 55 00 00       	call   801059f0 <uartputc>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010041b:	b9 d4 03 00 00       	mov    $0x3d4,%ecx
80100420:	b8 0e 00 00 00       	mov    $0xe,%eax
80100425:	89 ca                	mov    %ecx,%edx
80100427:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100428:	bf d5 03 00 00       	mov    $0x3d5,%edi
8010042d:	89 fa                	mov    %edi,%edx
8010042f:	ec                   	in     (%dx),%al
{
  int pos;

  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
  pos = inb(CRTPORT+1) << 8;
80100430:	0f b6 d8             	movzbl %al,%ebx
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100433:	89 ca                	mov    %ecx,%edx
80100435:	c1 e3 08             	shl    $0x8,%ebx
80100438:	b8 0f 00 00 00       	mov    $0xf,%eax
8010043d:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010043e:	89 fa                	mov    %edi,%edx
80100440:	ec                   	in     (%dx),%al
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);
80100441:	0f b6 c0             	movzbl %al,%eax
80100444:	09 c3                	or     %eax,%ebx

  if(c == '\n')
80100446:	83 fe 0a             	cmp    $0xa,%esi
80100449:	0f 84 fd 00 00 00    	je     8010054c <consputc+0x15c>
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
8010044f:	81 fe 00 01 00 00    	cmp    $0x100,%esi
80100455:	0f 84 e3 00 00 00    	je     8010053e <consputc+0x14e>
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
8010045b:	66 81 e6 ff 00       	and    $0xff,%si
80100460:	66 81 ce 00 07       	or     $0x700,%si
80100465:	66 89 b4 1b 00 80 0b 	mov    %si,-0x7ff48000(%ebx,%ebx,1)
8010046c:	80 
8010046d:	83 c3 01             	add    $0x1,%ebx

  if(pos < 0 || pos > 25*80)
80100470:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
80100476:	0f 87 b6 00 00 00    	ja     80100532 <consputc+0x142>
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
8010047c:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
80100482:	8d b4 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%esi
80100489:	7f 5d                	jg     801004e8 <consputc+0xf8>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010048b:	b9 d4 03 00 00       	mov    $0x3d4,%ecx
80100490:	b8 0e 00 00 00       	mov    $0xe,%eax
80100495:	89 ca                	mov    %ecx,%edx
80100497:	ee                   	out    %al,(%dx)
80100498:	bf d5 03 00 00       	mov    $0x3d5,%edi
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
  }

  outb(CRTPORT, 14);
  outb(CRTPORT+1, pos>>8);
8010049d:	89 d8                	mov    %ebx,%eax
8010049f:	c1 f8 08             	sar    $0x8,%eax
801004a2:	89 fa                	mov    %edi,%edx
801004a4:	ee                   	out    %al,(%dx)
801004a5:	b8 0f 00 00 00       	mov    $0xf,%eax
801004aa:	89 ca                	mov    %ecx,%edx
801004ac:	ee                   	out    %al,(%dx)
801004ad:	89 d8                	mov    %ebx,%eax
801004af:	89 fa                	mov    %edi,%edx
801004b1:	ee                   	out    %al,(%dx)
  outb(CRTPORT, 15);
  outb(CRTPORT+1, pos);
  crt[pos] = ' ' | 0x0700;
801004b2:	66 c7 06 20 07       	movw   $0x720,(%esi)
  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
  cgaputc(c);
}
801004b7:	83 c4 1c             	add    $0x1c,%esp
801004ba:	5b                   	pop    %ebx
801004bb:	5e                   	pop    %esi
801004bc:	5f                   	pop    %edi
801004bd:	5d                   	pop    %ebp
801004be:	c3                   	ret    
    for(;;)
      ;
  }

  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004bf:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004c6:	e8 25 55 00 00       	call   801059f0 <uartputc>
801004cb:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004d2:	e8 19 55 00 00       	call   801059f0 <uartputc>
801004d7:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004de:	e8 0d 55 00 00       	call   801059f0 <uartputc>
801004e3:	e9 33 ff ff ff       	jmp    8010041b <consputc+0x2b>

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004e8:	c7 44 24 08 60 0e 00 	movl   $0xe60,0x8(%esp)
801004ef:	00 
    pos -= 80;
801004f0:	8d 7b b0             	lea    -0x50(%ebx),%edi

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004f3:	c7 44 24 04 a0 80 0b 	movl   $0x800b80a0,0x4(%esp)
801004fa:	80 
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801004fb:	8d b4 3f 00 80 0b 80 	lea    -0x7ff48000(%edi,%edi,1),%esi

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100502:	c7 04 24 00 80 0b 80 	movl   $0x800b8000,(%esp)
80100509:	e8 b2 3f 00 00       	call   801044c0 <memmove>
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
8010050e:	b8 d0 07 00 00       	mov    $0x7d0,%eax
80100513:	29 d8                	sub    %ebx,%eax
  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
    pos -= 80;
80100515:	89 fb                	mov    %edi,%ebx
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100517:	01 c0                	add    %eax,%eax
80100519:	89 44 24 08          	mov    %eax,0x8(%esp)
8010051d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80100524:	00 
80100525:	89 34 24             	mov    %esi,(%esp)
80100528:	e8 d3 3e 00 00       	call   80104400 <memset>
8010052d:	e9 59 ff ff ff       	jmp    8010048b <consputc+0x9b>
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");
80100532:	c7 04 24 e5 6e 10 80 	movl   $0x80106ee5,(%esp)
80100539:	e8 32 fe ff ff       	call   80100370 <panic>
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
    if(pos > 0) --pos;
8010053e:	31 c0                	xor    %eax,%eax
80100540:	85 db                	test   %ebx,%ebx
80100542:	0f 9f c0             	setg   %al
80100545:	29 c3                	sub    %eax,%ebx
80100547:	e9 24 ff ff ff       	jmp    80100470 <consputc+0x80>
  pos = inb(CRTPORT+1) << 8;
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
8010054c:	89 d8                	mov    %ebx,%eax
8010054e:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100553:	f7 ea                	imul   %edx
80100555:	c1 ea 05             	shr    $0x5,%edx
80100558:	8d 04 92             	lea    (%edx,%edx,4),%eax
8010055b:	c1 e0 04             	shl    $0x4,%eax
8010055e:	8d 58 50             	lea    0x50(%eax),%ebx
80100561:	e9 0a ff ff ff       	jmp    80100470 <consputc+0x80>
80100566:	8d 76 00             	lea    0x0(%esi),%esi
80100569:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100570 <consolewrite>:
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100570:	55                   	push   %ebp
80100571:	89 e5                	mov    %esp,%ebp
80100573:	57                   	push   %edi
80100574:	56                   	push   %esi
80100575:	53                   	push   %ebx
80100576:	83 ec 1c             	sub    $0x1c,%esp
  int i;

  iunlock(ip);
80100579:	8b 45 08             	mov    0x8(%ebp),%eax
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
8010057c:	8b 75 10             	mov    0x10(%ebp),%esi
8010057f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  iunlock(ip);
80100582:	89 04 24             	mov    %eax,(%esp)
80100585:	e8 16 12 00 00       	call   801017a0 <iunlock>
  acquire(&cons.lock);
8010058a:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
80100591:	e8 aa 3d 00 00       	call   80104340 <acquire>
  for(i = 0; i < n; i++)
80100596:	85 f6                	test   %esi,%esi
80100598:	7e 16                	jle    801005b0 <consolewrite+0x40>
8010059a:	31 db                	xor    %ebx,%ebx
8010059c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    consputc(buf[i] & 0xff);
801005a0:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
801005a4:	83 c3 01             	add    $0x1,%ebx
    consputc(buf[i] & 0xff);
801005a7:	e8 44 fe ff ff       	call   801003f0 <consputc>
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
801005ac:	39 f3                	cmp    %esi,%ebx
801005ae:	75 f0                	jne    801005a0 <consolewrite+0x30>
    consputc(buf[i] & 0xff);
  release(&cons.lock);
801005b0:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
801005b7:	e8 f4 3d 00 00       	call   801043b0 <release>
  ilock(ip);
801005bc:	8b 45 08             	mov    0x8(%ebp),%eax
801005bf:	89 04 24             	mov    %eax,(%esp)
801005c2:	e8 f9 10 00 00       	call   801016c0 <ilock>

  return n;
}
801005c7:	83 c4 1c             	add    $0x1c,%esp
801005ca:	89 f0                	mov    %esi,%eax
801005cc:	5b                   	pop    %ebx
801005cd:	5e                   	pop    %esi
801005ce:	5f                   	pop    %edi
801005cf:	5d                   	pop    %ebp
801005d0:	c3                   	ret    
801005d1:	eb 0d                	jmp    801005e0 <printint>
801005d3:	90                   	nop
801005d4:	90                   	nop
801005d5:	90                   	nop
801005d6:	90                   	nop
801005d7:	90                   	nop
801005d8:	90                   	nop
801005d9:	90                   	nop
801005da:	90                   	nop
801005db:	90                   	nop
801005dc:	90                   	nop
801005dd:	90                   	nop
801005de:	90                   	nop
801005df:	90                   	nop

801005e0 <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
801005e0:	55                   	push   %ebp
801005e1:	89 e5                	mov    %esp,%ebp
801005e3:	56                   	push   %esi
801005e4:	53                   	push   %ebx
801005e5:	89 d3                	mov    %edx,%ebx
801005e7:	83 ec 10             	sub    $0x10,%esp
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
801005ea:	85 c9                	test   %ecx,%ecx
801005ec:	74 5a                	je     80100648 <printint+0x68>
801005ee:	85 c0                	test   %eax,%eax
801005f0:	79 56                	jns    80100648 <printint+0x68>
    x = -xx;
801005f2:	f7 d8                	neg    %eax
801005f4:	be 01 00 00 00       	mov    $0x1,%esi
  else
    x = xx;

  i = 0;
801005f9:	31 c9                	xor    %ecx,%ecx
801005fb:	eb 05                	jmp    80100602 <printint+0x22>
801005fd:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
80100600:	89 d1                	mov    %edx,%ecx
80100602:	31 d2                	xor    %edx,%edx
80100604:	f7 f3                	div    %ebx
80100606:	0f b6 92 10 6f 10 80 	movzbl -0x7fef90f0(%edx),%edx
  }while((x /= base) != 0);
8010060d:	85 c0                	test   %eax,%eax
  else
    x = xx;

  i = 0;
  do{
    buf[i++] = digits[x % base];
8010060f:	88 54 0d e8          	mov    %dl,-0x18(%ebp,%ecx,1)
80100613:	8d 51 01             	lea    0x1(%ecx),%edx
  }while((x /= base) != 0);
80100616:	75 e8                	jne    80100600 <printint+0x20>

  if(sign)
80100618:	85 f6                	test   %esi,%esi
8010061a:	74 08                	je     80100624 <printint+0x44>
    buf[i++] = '-';
8010061c:	c6 44 15 e8 2d       	movb   $0x2d,-0x18(%ebp,%edx,1)
80100621:	8d 51 02             	lea    0x2(%ecx),%edx

  while(--i >= 0)
80100624:	8d 5a ff             	lea    -0x1(%edx),%ebx
80100627:	90                   	nop
    consputc(buf[i]);
80100628:	0f be 44 1d e8       	movsbl -0x18(%ebp,%ebx,1),%eax
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
8010062d:	83 eb 01             	sub    $0x1,%ebx
    consputc(buf[i]);
80100630:	e8 bb fd ff ff       	call   801003f0 <consputc>
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
80100635:	83 fb ff             	cmp    $0xffffffff,%ebx
80100638:	75 ee                	jne    80100628 <printint+0x48>
    consputc(buf[i]);
}
8010063a:	83 c4 10             	add    $0x10,%esp
8010063d:	5b                   	pop    %ebx
8010063e:	5e                   	pop    %esi
8010063f:	5d                   	pop    %ebp
80100640:	c3                   	ret    
80100641:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  uint x;

  if(sign && (sign = xx < 0))
    x = -xx;
  else
    x = xx;
80100648:	31 f6                	xor    %esi,%esi
8010064a:	eb ad                	jmp    801005f9 <printint+0x19>
8010064c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100650 <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
80100650:	55                   	push   %ebp
80100651:	89 e5                	mov    %esp,%ebp
80100653:	57                   	push   %edi
80100654:	56                   	push   %esi
80100655:	53                   	push   %ebx
80100656:	83 ec 2c             	sub    $0x2c,%esp
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
80100659:	8b 3d 54 a5 10 80    	mov    0x8010a554,%edi
  if(locking)
8010065f:	85 ff                	test   %edi,%edi
80100661:	0f 85 39 01 00 00    	jne    801007a0 <cprintf+0x150>
    acquire(&cons.lock);

  if (fmt == 0)
80100667:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010066a:	85 c9                	test   %ecx,%ecx
8010066c:	0f 84 3f 01 00 00    	je     801007b1 <cprintf+0x161>
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100672:	0f b6 01             	movzbl (%ecx),%eax
80100675:	31 db                	xor    %ebx,%ebx
80100677:	8d 75 0c             	lea    0xc(%ebp),%esi
8010067a:	85 c0                	test   %eax,%eax
8010067c:	0f 84 89 00 00 00    	je     8010070b <cprintf+0xbb>
80100682:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80100685:	eb 3c                	jmp    801006c3 <cprintf+0x73>
80100687:	90                   	nop
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
80100688:	83 fa 25             	cmp    $0x25,%edx
8010068b:	0f 84 f7 00 00 00    	je     80100788 <cprintf+0x138>
80100691:	83 fa 64             	cmp    $0x64,%edx
80100694:	0f 84 ce 00 00 00    	je     80100768 <cprintf+0x118>
    case '%':
      consputc('%');
      break;
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
8010069a:	b8 25 00 00 00       	mov    $0x25,%eax
8010069f:	89 55 e0             	mov    %edx,-0x20(%ebp)
801006a2:	e8 49 fd ff ff       	call   801003f0 <consputc>
      consputc(c);
801006a7:	8b 55 e0             	mov    -0x20(%ebp),%edx
801006aa:	89 d0                	mov    %edx,%eax
801006ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801006b0:	e8 3b fd ff ff       	call   801003f0 <consputc>
801006b5:	8b 4d 08             	mov    0x8(%ebp),%ecx

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006b8:	83 c3 01             	add    $0x1,%ebx
801006bb:	0f b6 04 19          	movzbl (%ecx,%ebx,1),%eax
801006bf:	85 c0                	test   %eax,%eax
801006c1:	74 45                	je     80100708 <cprintf+0xb8>
    if(c != '%'){
801006c3:	83 f8 25             	cmp    $0x25,%eax
801006c6:	75 e8                	jne    801006b0 <cprintf+0x60>
      consputc(c);
      continue;
    }
    c = fmt[++i] & 0xff;
801006c8:	83 c3 01             	add    $0x1,%ebx
801006cb:	0f b6 14 19          	movzbl (%ecx,%ebx,1),%edx
    if(c == 0)
801006cf:	85 d2                	test   %edx,%edx
801006d1:	74 35                	je     80100708 <cprintf+0xb8>
      break;
    switch(c){
801006d3:	83 fa 70             	cmp    $0x70,%edx
801006d6:	74 0f                	je     801006e7 <cprintf+0x97>
801006d8:	7e ae                	jle    80100688 <cprintf+0x38>
801006da:	83 fa 73             	cmp    $0x73,%edx
801006dd:	8d 76 00             	lea    0x0(%esi),%esi
801006e0:	74 46                	je     80100728 <cprintf+0xd8>
801006e2:	83 fa 78             	cmp    $0x78,%edx
801006e5:	75 b3                	jne    8010069a <cprintf+0x4a>
    case 'd':
      printint(*argp++, 10, 1);
      break;
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
801006e7:	8b 06                	mov    (%esi),%eax
801006e9:	31 c9                	xor    %ecx,%ecx
801006eb:	ba 10 00 00 00       	mov    $0x10,%edx

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006f0:	83 c3 01             	add    $0x1,%ebx
    case 'd':
      printint(*argp++, 10, 1);
      break;
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
801006f3:	83 c6 04             	add    $0x4,%esi
801006f6:	e8 e5 fe ff ff       	call   801005e0 <printint>
801006fb:	8b 4d 08             	mov    0x8(%ebp),%ecx

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006fe:	0f b6 04 19          	movzbl (%ecx,%ebx,1),%eax
80100702:	85 c0                	test   %eax,%eax
80100704:	75 bd                	jne    801006c3 <cprintf+0x73>
80100706:	66 90                	xchg   %ax,%ax
80100708:	8b 7d e4             	mov    -0x1c(%ebp),%edi
      consputc(c);
      break;
    }
  }

  if(locking)
8010070b:	85 ff                	test   %edi,%edi
8010070d:	74 0c                	je     8010071b <cprintf+0xcb>
    release(&cons.lock);
8010070f:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
80100716:	e8 95 3c 00 00       	call   801043b0 <release>
}
8010071b:	83 c4 2c             	add    $0x2c,%esp
8010071e:	5b                   	pop    %ebx
8010071f:	5e                   	pop    %esi
80100720:	5f                   	pop    %edi
80100721:	5d                   	pop    %ebp
80100722:	c3                   	ret    
80100723:	90                   	nop
80100724:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
80100728:	8b 16                	mov    (%esi),%edx
        s = "(null)";
8010072a:	b8 f8 6e 10 80       	mov    $0x80106ef8,%eax
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
8010072f:	83 c6 04             	add    $0x4,%esi
        s = "(null)";
80100732:	85 d2                	test   %edx,%edx
80100734:	0f 44 d0             	cmove  %eax,%edx
      for(; *s; s++)
80100737:	0f b6 02             	movzbl (%edx),%eax
8010073a:	84 c0                	test   %al,%al
8010073c:	0f 84 76 ff ff ff    	je     801006b8 <cprintf+0x68>
80100742:	89 f7                	mov    %esi,%edi
80100744:	89 de                	mov    %ebx,%esi
80100746:	89 d3                	mov    %edx,%ebx
        consputc(*s);
80100748:	0f be c0             	movsbl %al,%eax
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
8010074b:	83 c3 01             	add    $0x1,%ebx
        consputc(*s);
8010074e:	e8 9d fc ff ff       	call   801003f0 <consputc>
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
80100753:	0f b6 03             	movzbl (%ebx),%eax
80100756:	84 c0                	test   %al,%al
80100758:	75 ee                	jne    80100748 <cprintf+0xf8>
8010075a:	89 f3                	mov    %esi,%ebx
8010075c:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010075f:	89 fe                	mov    %edi,%esi
80100761:	e9 52 ff ff ff       	jmp    801006b8 <cprintf+0x68>
80100766:	66 90                	xchg   %ax,%ax
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
    case 'd':
      printint(*argp++, 10, 1);
80100768:	8b 06                	mov    (%esi),%eax
8010076a:	b9 01 00 00 00       	mov    $0x1,%ecx
8010076f:	ba 0a 00 00 00       	mov    $0xa,%edx
80100774:	83 c6 04             	add    $0x4,%esi
80100777:	e8 64 fe ff ff       	call   801005e0 <printint>
8010077c:	8b 4d 08             	mov    0x8(%ebp),%ecx
      break;
8010077f:	e9 34 ff ff ff       	jmp    801006b8 <cprintf+0x68>
80100784:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
80100788:	b8 25 00 00 00       	mov    $0x25,%eax
8010078d:	e8 5e fc ff ff       	call   801003f0 <consputc>
80100792:	8b 4d 08             	mov    0x8(%ebp),%ecx
      break;
80100795:	e9 1e ff ff ff       	jmp    801006b8 <cprintf+0x68>
8010079a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  uint *argp;
  char *s;

  locking = cons.locking;
  if(locking)
    acquire(&cons.lock);
801007a0:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
801007a7:	e8 94 3b 00 00       	call   80104340 <acquire>
801007ac:	e9 b6 fe ff ff       	jmp    80100667 <cprintf+0x17>

  if (fmt == 0)
    panic("null fmt");
801007b1:	c7 04 24 ff 6e 10 80 	movl   $0x80106eff,(%esp)
801007b8:	e8 b3 fb ff ff       	call   80100370 <panic>
801007bd:	8d 76 00             	lea    0x0(%esi),%esi

801007c0 <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
801007c0:	55                   	push   %ebp
801007c1:	89 e5                	mov    %esp,%ebp
801007c3:	57                   	push   %edi
  int c, doprocdump = 0;
801007c4:	31 ff                	xor    %edi,%edi

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
801007c6:	56                   	push   %esi
801007c7:	53                   	push   %ebx
801007c8:	83 ec 1c             	sub    $0x1c,%esp
801007cb:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, doprocdump = 0;

  acquire(&cons.lock);
801007ce:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
801007d5:	e8 66 3b 00 00       	call   80104340 <acquire>
801007da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  while((c = getc()) >= 0){
801007e0:	ff d6                	call   *%esi
801007e2:	85 c0                	test   %eax,%eax
801007e4:	89 c3                	mov    %eax,%ebx
801007e6:	0f 88 8c 00 00 00    	js     80100878 <consoleintr+0xb8>
    switch(c){
801007ec:	83 fb 10             	cmp    $0x10,%ebx
801007ef:	90                   	nop
801007f0:	0f 84 da 00 00 00    	je     801008d0 <consoleintr+0x110>
801007f6:	0f 8f 9c 00 00 00    	jg     80100898 <consoleintr+0xd8>
801007fc:	83 fb 08             	cmp    $0x8,%ebx
801007ff:	90                   	nop
80100800:	0f 84 a0 00 00 00    	je     801008a6 <consoleintr+0xe6>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100806:	85 db                	test   %ebx,%ebx
80100808:	74 d6                	je     801007e0 <consoleintr+0x20>
8010080a:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
8010080f:	89 c2                	mov    %eax,%edx
80100811:	2b 15 a0 ff 10 80    	sub    0x8010ffa0,%edx
80100817:	83 fa 7f             	cmp    $0x7f,%edx
8010081a:	77 c4                	ja     801007e0 <consoleintr+0x20>
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
8010081c:	89 c2                	mov    %eax,%edx
8010081e:	83 e2 7f             	and    $0x7f,%edx
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
80100821:	83 fb 0d             	cmp    $0xd,%ebx
80100824:	0f 84 12 01 00 00    	je     8010093c <consoleintr+0x17c>
        input.buf[input.e++ % INPUT_BUF] = c;
8010082a:	83 c0 01             	add    $0x1,%eax
8010082d:	88 9a 20 ff 10 80    	mov    %bl,-0x7fef00e0(%edx)
80100833:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
        consputc(c);
80100838:	89 d8                	mov    %ebx,%eax
8010083a:	e8 b1 fb ff ff       	call   801003f0 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
8010083f:	83 fb 04             	cmp    $0x4,%ebx
80100842:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
80100847:	74 12                	je     8010085b <consoleintr+0x9b>
80100849:	83 fb 0a             	cmp    $0xa,%ebx
8010084c:	74 0d                	je     8010085b <consoleintr+0x9b>
8010084e:	8b 15 a0 ff 10 80    	mov    0x8010ffa0,%edx
80100854:	83 ea 80             	sub    $0xffffff80,%edx
80100857:	39 d0                	cmp    %edx,%eax
80100859:	75 85                	jne    801007e0 <consoleintr+0x20>
          input.w = input.e;
8010085b:	a3 a4 ff 10 80       	mov    %eax,0x8010ffa4
          wakeup(&input.r);
80100860:	c7 04 24 a0 ff 10 80 	movl   $0x8010ffa0,(%esp)
80100867:	e8 84 36 00 00       	call   80103ef0 <wakeup>
consoleintr(int (*getc)(void))
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
8010086c:	ff d6                	call   *%esi
8010086e:	85 c0                	test   %eax,%eax
80100870:	89 c3                	mov    %eax,%ebx
80100872:	0f 89 74 ff ff ff    	jns    801007ec <consoleintr+0x2c>
        }
      }
      break;
    }
  }
  release(&cons.lock);
80100878:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010087f:	e8 2c 3b 00 00       	call   801043b0 <release>
  if(doprocdump) {
80100884:	85 ff                	test   %edi,%edi
80100886:	0f 85 a4 00 00 00    	jne    80100930 <consoleintr+0x170>
    procdump();  // now call procdump() wo. cons.lock held
  }
}
8010088c:	83 c4 1c             	add    $0x1c,%esp
8010088f:	5b                   	pop    %ebx
80100890:	5e                   	pop    %esi
80100891:	5f                   	pop    %edi
80100892:	5d                   	pop    %ebp
80100893:	c3                   	ret    
80100894:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
80100898:	83 fb 15             	cmp    $0x15,%ebx
8010089b:	74 43                	je     801008e0 <consoleintr+0x120>
8010089d:	83 fb 7f             	cmp    $0x7f,%ebx
801008a0:	0f 85 60 ff ff ff    	jne    80100806 <consoleintr+0x46>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
801008a6:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
801008ab:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
801008b1:	0f 84 29 ff ff ff    	je     801007e0 <consoleintr+0x20>
        input.e--;
801008b7:	83 e8 01             	sub    $0x1,%eax
801008ba:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
        consputc(BACKSPACE);
801008bf:	b8 00 01 00 00       	mov    $0x100,%eax
801008c4:	e8 27 fb ff ff       	call   801003f0 <consputc>
801008c9:	e9 12 ff ff ff       	jmp    801007e0 <consoleintr+0x20>
801008ce:	66 90                	xchg   %ax,%ax
  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
801008d0:	bf 01 00 00 00       	mov    $0x1,%edi
801008d5:	e9 06 ff ff ff       	jmp    801007e0 <consoleintr+0x20>
801008da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
801008e0:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
801008e5:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
801008eb:	75 2b                	jne    80100918 <consoleintr+0x158>
801008ed:	e9 ee fe ff ff       	jmp    801007e0 <consoleintr+0x20>
801008f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
801008f8:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
        consputc(BACKSPACE);
801008fd:	b8 00 01 00 00       	mov    $0x100,%eax
80100902:	e8 e9 fa ff ff       	call   801003f0 <consputc>
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100907:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
8010090c:	3b 05 a4 ff 10 80    	cmp    0x8010ffa4,%eax
80100912:	0f 84 c8 fe ff ff    	je     801007e0 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100918:	83 e8 01             	sub    $0x1,%eax
8010091b:	89 c2                	mov    %eax,%edx
8010091d:	83 e2 7f             	and    $0x7f,%edx
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100920:	80 ba 20 ff 10 80 0a 	cmpb   $0xa,-0x7fef00e0(%edx)
80100927:	75 cf                	jne    801008f8 <consoleintr+0x138>
80100929:	e9 b2 fe ff ff       	jmp    801007e0 <consoleintr+0x20>
8010092e:	66 90                	xchg   %ax,%ax
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
  }
}
80100930:	83 c4 1c             	add    $0x1c,%esp
80100933:	5b                   	pop    %ebx
80100934:	5e                   	pop    %esi
80100935:	5f                   	pop    %edi
80100936:	5d                   	pop    %ebp
      break;
    }
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
80100937:	e9 94 36 00 00       	jmp    80103fd0 <procdump>
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
8010093c:	83 c0 01             	add    $0x1,%eax
8010093f:	c6 82 20 ff 10 80 0a 	movb   $0xa,-0x7fef00e0(%edx)
80100946:	a3 a8 ff 10 80       	mov    %eax,0x8010ffa8
        consputc(c);
8010094b:	b8 0a 00 00 00       	mov    $0xa,%eax
80100950:	e8 9b fa ff ff       	call   801003f0 <consputc>
80100955:	a1 a8 ff 10 80       	mov    0x8010ffa8,%eax
8010095a:	e9 fc fe ff ff       	jmp    8010085b <consoleintr+0x9b>
8010095f:	90                   	nop

80100960 <consoleinit>:
  return n;
}

void
consoleinit(void)
{
80100960:	55                   	push   %ebp
80100961:	89 e5                	mov    %esp,%ebp
80100963:	83 ec 18             	sub    $0x18,%esp
  initlock(&cons.lock, "console");
80100966:	c7 44 24 04 08 6f 10 	movl   $0x80106f08,0x4(%esp)
8010096d:	80 
8010096e:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
80100975:	e8 56 38 00 00       	call   801041d0 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
8010097a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80100981:	00 
80100982:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
void
consoleinit(void)
{
  initlock(&cons.lock, "console");

  devsw[CONSOLE].write = consolewrite;
80100989:	c7 05 6c 09 11 80 70 	movl   $0x80100570,0x8011096c
80100990:	05 10 80 
  devsw[CONSOLE].read = consoleread;
80100993:	c7 05 68 09 11 80 70 	movl   $0x80100270,0x80110968
8010099a:	02 10 80 
  cons.locking = 1;
8010099d:	c7 05 54 a5 10 80 01 	movl   $0x1,0x8010a554
801009a4:	00 00 00 

  ioapicenable(IRQ_KBD, 0);
801009a7:	e8 14 1a 00 00       	call   801023c0 <ioapicenable>
}
801009ac:	c9                   	leave  
801009ad:	c3                   	ret    
	...

801009b0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
801009b0:	55                   	push   %ebp
801009b1:	89 e5                	mov    %esp,%ebp
801009b3:	81 ec 38 01 00 00    	sub    $0x138,%esp
801009b9:	89 5d f4             	mov    %ebx,-0xc(%ebp)
801009bc:	89 75 f8             	mov    %esi,-0x8(%ebp)
801009bf:	89 7d fc             	mov    %edi,-0x4(%ebp)
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
801009c2:	e8 29 2e 00 00       	call   801037f0 <myproc>
801009c7:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)

  begin_op();
801009cd:	e8 5e 22 00 00       	call   80102c30 <begin_op>

  if((ip = namei(path)) == 0){
801009d2:	8b 55 08             	mov    0x8(%ebp),%edx
801009d5:	89 14 24             	mov    %edx,(%esp)
801009d8:	e8 53 16 00 00       	call   80102030 <namei>
801009dd:	85 c0                	test   %eax,%eax
801009df:	89 c3                	mov    %eax,%ebx
801009e1:	0f 84 42 02 00 00    	je     80100c29 <exec+0x279>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
801009e7:	89 04 24             	mov    %eax,(%esp)
801009ea:	e8 d1 0c 00 00       	call   801016c0 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
801009ef:	8d 45 94             	lea    -0x6c(%ebp),%eax
801009f2:	c7 44 24 0c 34 00 00 	movl   $0x34,0xc(%esp)
801009f9:	00 
801009fa:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80100a01:	00 
80100a02:	89 44 24 04          	mov    %eax,0x4(%esp)
80100a06:	89 1c 24             	mov    %ebx,(%esp)
80100a09:	e8 b2 0f 00 00       	call   801019c0 <readi>
80100a0e:	83 f8 34             	cmp    $0x34,%eax
80100a11:	74 25                	je     80100a38 <exec+0x88>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100a13:	89 1c 24             	mov    %ebx,(%esp)
80100a16:	e8 55 0f 00 00       	call   80101970 <iunlockput>
    end_op();
80100a1b:	e8 80 22 00 00       	call   80102ca0 <end_op>
  }
  return -1;
80100a20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100a25:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80100a28:	8b 75 f8             	mov    -0x8(%ebp),%esi
80100a2b:	8b 7d fc             	mov    -0x4(%ebp),%edi
80100a2e:	89 ec                	mov    %ebp,%esp
80100a30:	5d                   	pop    %ebp
80100a31:	c3                   	ret    
80100a32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100a38:	81 7d 94 7f 45 4c 46 	cmpl   $0x464c457f,-0x6c(%ebp)
80100a3f:	75 d2                	jne    80100a13 <exec+0x63>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100a41:	e8 da 61 00 00       	call   80106c20 <setupkvm>
80100a46:	85 c0                	test   %eax,%eax
80100a48:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100a4e:	74 c3                	je     80100a13 <exec+0x63>
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100a50:	66 83 7d c0 00       	cmpw   $0x0,-0x40(%ebp)
80100a55:	8b 75 b0             	mov    -0x50(%ebp),%esi

  if((pgdir = setupkvm()) == 0)
    goto bad;

  // Load program into memory.
  sz = 0;
80100a58:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100a5f:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100a62:	0f 84 cb 00 00 00    	je     80100b33 <exec+0x183>
80100a68:	31 ff                	xor    %edi,%edi
80100a6a:	eb 16                	jmp    80100a82 <exec+0xd2>
80100a6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100a70:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80100a74:	83 c7 01             	add    $0x1,%edi
#include "defs.h"
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
80100a77:	83 c6 20             	add    $0x20,%esi
  if((pgdir = setupkvm()) == 0)
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100a7a:	39 f8                	cmp    %edi,%eax
80100a7c:	0f 8e b1 00 00 00    	jle    80100b33 <exec+0x183>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100a82:	8d 4d c8             	lea    -0x38(%ebp),%ecx
80100a85:	c7 44 24 0c 20 00 00 	movl   $0x20,0xc(%esp)
80100a8c:	00 
80100a8d:	89 74 24 08          	mov    %esi,0x8(%esp)
80100a91:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80100a95:	89 1c 24             	mov    %ebx,(%esp)
80100a98:	e8 23 0f 00 00       	call   801019c0 <readi>
80100a9d:	83 f8 20             	cmp    $0x20,%eax
80100aa0:	75 76                	jne    80100b18 <exec+0x168>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100aa2:	83 7d c8 01          	cmpl   $0x1,-0x38(%ebp)
80100aa6:	75 c8                	jne    80100a70 <exec+0xc0>
      continue;
    if(ph.memsz < ph.filesz)
80100aa8:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100aab:	3b 45 d8             	cmp    -0x28(%ebp),%eax
80100aae:	72 68                	jb     80100b18 <exec+0x168>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100ab0:	03 45 d0             	add    -0x30(%ebp),%eax
80100ab3:	72 63                	jb     80100b18 <exec+0x168>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100ab5:	89 44 24 08          	mov    %eax,0x8(%esp)
80100ab9:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100abf:	89 44 24 04          	mov    %eax,0x4(%esp)
80100ac3:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100ac9:	89 04 24             	mov    %eax,(%esp)
80100acc:	e8 9f 5f 00 00       	call   80106a70 <allocuvm>
80100ad1:	85 c0                	test   %eax,%eax
80100ad3:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100ad9:	74 3d                	je     80100b18 <exec+0x168>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
80100adb:	8b 45 d0             	mov    -0x30(%ebp),%eax
80100ade:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100ae3:	75 33                	jne    80100b18 <exec+0x168>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100ae5:	8b 55 d8             	mov    -0x28(%ebp),%edx
80100ae8:	89 44 24 04          	mov    %eax,0x4(%esp)
80100aec:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100af2:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80100af6:	89 54 24 10          	mov    %edx,0x10(%esp)
80100afa:	8b 55 cc             	mov    -0x34(%ebp),%edx
80100afd:	89 04 24             	mov    %eax,(%esp)
80100b00:	89 54 24 0c          	mov    %edx,0xc(%esp)
80100b04:	e8 07 5e 00 00       	call   80106910 <loaduvm>
80100b09:	85 c0                	test   %eax,%eax
80100b0b:	0f 89 5f ff ff ff    	jns    80100a70 <exec+0xc0>
80100b11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100b18:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100b1e:	89 04 24             	mov    %eax,(%esp)
80100b21:	e8 7a 60 00 00       	call   80106ba0 <freevm>
  if(ip){
80100b26:	85 db                	test   %ebx,%ebx
80100b28:	0f 85 e5 fe ff ff    	jne    80100a13 <exec+0x63>
80100b2e:	e9 ed fe ff ff       	jmp    80100a20 <exec+0x70>
    if(ph.vaddr % PGSIZE != 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
80100b33:	89 1c 24             	mov    %ebx,(%esp)
  end_op();
  ip = 0;
80100b36:	31 db                	xor    %ebx,%ebx
    if(ph.vaddr % PGSIZE != 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
80100b38:	e8 33 0e 00 00       	call   80101970 <iunlockput>
  end_op();
80100b3d:	e8 5e 21 00 00       	call   80102ca0 <end_op>
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100b42:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100b48:	05 ff 0f 00 00       	add    $0xfff,%eax
80100b4d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b52:	8d 90 00 20 00 00    	lea    0x2000(%eax),%edx
80100b58:	89 44 24 04          	mov    %eax,0x4(%esp)
80100b5c:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100b62:	89 54 24 08          	mov    %edx,0x8(%esp)
80100b66:	89 04 24             	mov    %eax,(%esp)
80100b69:	e8 02 5f 00 00       	call   80106a70 <allocuvm>
80100b6e:	85 c0                	test   %eax,%eax
80100b70:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100b76:	74 a0                	je     80100b18 <exec+0x168>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100b78:	2d 00 20 00 00       	sub    $0x2000,%eax
80100b7d:	89 44 24 04          	mov    %eax,0x4(%esp)
80100b81:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100b87:	89 04 24             	mov    %eax,(%esp)
80100b8a:	e8 31 61 00 00       	call   80106cc0 <clearpteu>
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100b8f:	8b 55 0c             	mov    0xc(%ebp),%edx
80100b92:	8b 02                	mov    (%edx),%eax
80100b94:	85 c0                	test   %eax,%eax
80100b96:	0f 84 af 00 00 00    	je     80100c4b <exec+0x29b>
#include "defs.h"
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
80100b9c:	89 d7                	mov    %edx,%edi
80100b9e:	8b 9d f0 fe ff ff    	mov    -0x110(%ebp),%ebx
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100ba4:	31 f6                	xor    %esi,%esi
#include "defs.h"
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
80100ba6:	83 c7 04             	add    $0x4,%edi
80100ba9:	89 d1                	mov    %edx,%ecx
80100bab:	eb 27                	jmp    80100bd4 <exec+0x224>
80100bad:	8d 76 00             	lea    0x0(%esi),%esi
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100bb0:	8b 07                	mov    (%edi),%eax
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
80100bb2:	8d 95 04 ff ff ff    	lea    -0xfc(%ebp),%edx
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100bb8:	89 f9                	mov    %edi,%ecx
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
80100bba:	89 9c b5 10 ff ff ff 	mov    %ebx,-0xf0(%ebp,%esi,4)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100bc1:	83 c6 01             	add    $0x1,%esi
80100bc4:	85 c0                	test   %eax,%eax
80100bc6:	0f 84 8d 00 00 00    	je     80100c59 <exec+0x2a9>
80100bcc:	83 c7 04             	add    $0x4,%edi
    if(argc >= MAXARG)
80100bcf:	83 fe 20             	cmp    $0x20,%esi
80100bd2:	74 4e                	je     80100c22 <exec+0x272>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100bd4:	89 8d e8 fe ff ff    	mov    %ecx,-0x118(%ebp)
80100bda:	89 04 24             	mov    %eax,(%esp)
80100bdd:	e8 4e 3a 00 00       	call   80104630 <strlen>
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100be2:	8b 8d e8 fe ff ff    	mov    -0x118(%ebp),%ecx

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100be8:	f7 d0                	not    %eax
80100bea:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100bec:	8b 01                	mov    (%ecx),%eax

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100bee:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100bf1:	89 04 24             	mov    %eax,(%esp)
80100bf4:	e8 37 3a 00 00       	call   80104630 <strlen>
80100bf9:	8b 8d e8 fe ff ff    	mov    -0x118(%ebp),%ecx
80100bff:	83 c0 01             	add    $0x1,%eax
80100c02:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100c06:	8b 01                	mov    (%ecx),%eax
80100c08:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80100c0c:	89 44 24 08          	mov    %eax,0x8(%esp)
80100c10:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100c16:	89 04 24             	mov    %eax,(%esp)
80100c19:	e8 e2 61 00 00       	call   80106e00 <copyout>
80100c1e:	85 c0                	test   %eax,%eax
80100c20:	79 8e                	jns    80100bb0 <exec+0x200>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
  end_op();
  ip = 0;
80100c22:	31 db                	xor    %ebx,%ebx
80100c24:	e9 ef fe ff ff       	jmp    80100b18 <exec+0x168>
80100c29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  struct proc *curproc = myproc();

  begin_op();

  if((ip = namei(path)) == 0){
    end_op();
80100c30:	e8 6b 20 00 00       	call   80102ca0 <end_op>
    cprintf("exec: fail\n");
80100c35:	c7 04 24 21 6f 10 80 	movl   $0x80106f21,(%esp)
80100c3c:	e8 0f fa ff ff       	call   80100650 <cprintf>
    return -1;
80100c41:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100c46:	e9 da fd ff ff       	jmp    80100a25 <exec+0x75>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c4b:	8b 9d f0 fe ff ff    	mov    -0x110(%ebp),%ebx
80100c51:	31 f6                	xor    %esi,%esi
80100c53:	8d 95 04 ff ff ff    	lea    -0xfc(%ebp),%edx
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c59:	8d 04 b5 04 00 00 00 	lea    0x4(,%esi,4),%eax
80100c60:	89 d9                	mov    %ebx,%ecx
80100c62:	29 c1                	sub    %eax,%ecx

  sp -= (3+argc+1) * 4;
80100c64:	8d 04 b5 10 00 00 00 	lea    0x10(,%esi,4),%eax
80100c6b:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100c6d:	89 44 24 0c          	mov    %eax,0xc(%esp)
80100c71:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;
80100c77:	c7 84 b5 10 ff ff ff 	movl   $0x0,-0xf0(%ebp,%esi,4)
80100c7e:	00 00 00 00 
  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer

  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100c82:	89 54 24 08          	mov    %edx,0x8(%esp)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
80100c86:	c7 85 04 ff ff ff ff 	movl   $0xffffffff,-0xfc(%ebp)
80100c8d:	ff ff ff 
  ustack[1] = argc;
80100c90:	89 b5 08 ff ff ff    	mov    %esi,-0xf8(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c96:	89 8d 0c ff ff ff    	mov    %ecx,-0xf4(%ebp)

  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100c9c:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80100ca0:	89 04 24             	mov    %eax,(%esp)
80100ca3:	e8 58 61 00 00       	call   80106e00 <copyout>
80100ca8:	85 c0                	test   %eax,%eax
80100caa:	0f 88 72 ff ff ff    	js     80100c22 <exec+0x272>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100cb0:	8b 4d 08             	mov    0x8(%ebp),%ecx
80100cb3:	0f b6 11             	movzbl (%ecx),%edx
80100cb6:	84 d2                	test   %dl,%dl
80100cb8:	74 14                	je     80100cce <exec+0x31e>
#include "defs.h"
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
80100cba:	8d 41 01             	lea    0x1(%ecx),%eax
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
    if(*s == '/')
      last = s+1;
80100cbd:	80 fa 2f             	cmp    $0x2f,%dl
80100cc0:	0f 44 c8             	cmove  %eax,%ecx
80100cc3:	83 c0 01             	add    $0x1,%eax
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100cc6:	0f b6 50 ff          	movzbl -0x1(%eax),%edx
80100cca:	84 d2                	test   %dl,%dl
80100ccc:	75 ef                	jne    80100cbd <exec+0x30d>
    if(*s == '/')
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100cce:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
80100cd4:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80100cd8:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80100cdf:	00 
80100ce0:	83 c0 6c             	add    $0x6c,%eax
80100ce3:	89 04 24             	mov    %eax,(%esp)
80100ce6:	e8 05 39 00 00       	call   801045f0 <safestrcpy>

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
80100ceb:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
  curproc->pgdir = pgdir;
80100cf1:	8b 95 ec fe ff ff    	mov    -0x114(%ebp),%edx
  curproc->sz = sz;
80100cf7:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
    if(*s == '/')
      last = s+1;
  safestrcpy(curproc->name, last, sizeof(curproc->name));

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
80100cfd:	8b 70 04             	mov    0x4(%eax),%esi
  curproc->pgdir = pgdir;
80100d00:	89 50 04             	mov    %edx,0x4(%eax)
  curproc->sz = sz;
80100d03:	89 08                	mov    %ecx,(%eax)
  curproc->tf->eip = elf.entry;  // main
80100d05:	8b 40 18             	mov    0x18(%eax),%eax
  curproc->tf->esp = sp;
80100d08:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
  curproc->pgdir = pgdir;
  curproc->sz = sz;
  curproc->tf->eip = elf.entry;  // main
80100d0e:	8b 55 ac             	mov    -0x54(%ebp),%edx
80100d11:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100d14:	8b 41 18             	mov    0x18(%ecx),%eax
80100d17:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100d1a:	89 0c 24             	mov    %ecx,(%esp)
80100d1d:	e8 5e 5a 00 00       	call   80106780 <switchuvm>
  freevm(oldpgdir);
80100d22:	89 34 24             	mov    %esi,(%esp)
80100d25:	e8 76 5e 00 00       	call   80106ba0 <freevm>
  return 0;
80100d2a:	31 c0                	xor    %eax,%eax
80100d2c:	e9 f4 fc ff ff       	jmp    80100a25 <exec+0x75>
	...

80100d40 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100d40:	55                   	push   %ebp
80100d41:	89 e5                	mov    %esp,%ebp
80100d43:	83 ec 18             	sub    $0x18,%esp
  initlock(&ftable.lock, "ftable");
80100d46:	c7 44 24 04 2d 6f 10 	movl   $0x80106f2d,0x4(%esp)
80100d4d:	80 
80100d4e:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100d55:	e8 76 34 00 00       	call   801041d0 <initlock>
}
80100d5a:	c9                   	leave  
80100d5b:	c3                   	ret    
80100d5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100d60 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d60:	55                   	push   %ebp
80100d61:	89 e5                	mov    %esp,%ebp
80100d63:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d64:	bb f4 ff 10 80       	mov    $0x8010fff4,%ebx
}

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d69:	83 ec 14             	sub    $0x14,%esp
  struct file *f;

  acquire(&ftable.lock);
80100d6c:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100d73:	e8 c8 35 00 00       	call   80104340 <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    if(f->ref == 0){
80100d78:	8b 15 f8 ff 10 80    	mov    0x8010fff8,%edx
80100d7e:	85 d2                	test   %edx,%edx
80100d80:	74 18                	je     80100d9a <filealloc+0x3a>
80100d82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
filealloc(void)
{
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d88:	83 c3 18             	add    $0x18,%ebx
80100d8b:	81 fb 54 09 11 80    	cmp    $0x80110954,%ebx
80100d91:	73 25                	jae    80100db8 <filealloc+0x58>
    if(f->ref == 0){
80100d93:	8b 43 04             	mov    0x4(%ebx),%eax
80100d96:	85 c0                	test   %eax,%eax
80100d98:	75 ee                	jne    80100d88 <filealloc+0x28>
      f->ref = 1;
80100d9a:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100da1:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100da8:	e8 03 36 00 00       	call   801043b0 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100dad:	83 c4 14             	add    $0x14,%esp
80100db0:	89 d8                	mov    %ebx,%eax
80100db2:	5b                   	pop    %ebx
80100db3:	5d                   	pop    %ebp
80100db4:	c3                   	ret    
80100db5:	8d 76 00             	lea    0x0(%esi),%esi
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
80100db8:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
  return 0;
80100dbf:	31 db                	xor    %ebx,%ebx
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
80100dc1:	e8 ea 35 00 00       	call   801043b0 <release>
  return 0;
}
80100dc6:	83 c4 14             	add    $0x14,%esp
80100dc9:	89 d8                	mov    %ebx,%eax
80100dcb:	5b                   	pop    %ebx
80100dcc:	5d                   	pop    %ebp
80100dcd:	c3                   	ret    
80100dce:	66 90                	xchg   %ax,%ax

80100dd0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100dd0:	55                   	push   %ebp
80100dd1:	89 e5                	mov    %esp,%ebp
80100dd3:	53                   	push   %ebx
80100dd4:	83 ec 14             	sub    $0x14,%esp
80100dd7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100dda:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100de1:	e8 5a 35 00 00       	call   80104340 <acquire>
  if(f->ref < 1)
80100de6:	8b 43 04             	mov    0x4(%ebx),%eax
80100de9:	85 c0                	test   %eax,%eax
80100deb:	7e 1a                	jle    80100e07 <filedup+0x37>
    panic("filedup");
  f->ref++;
80100ded:	83 c0 01             	add    $0x1,%eax
80100df0:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100df3:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100dfa:	e8 b1 35 00 00       	call   801043b0 <release>
  return f;
}
80100dff:	83 c4 14             	add    $0x14,%esp
80100e02:	89 d8                	mov    %ebx,%eax
80100e04:	5b                   	pop    %ebx
80100e05:	5d                   	pop    %ebp
80100e06:	c3                   	ret    
struct file*
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
80100e07:	c7 04 24 34 6f 10 80 	movl   $0x80106f34,(%esp)
80100e0e:	e8 5d f5 ff ff       	call   80100370 <panic>
80100e13:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100e19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100e20 <fileclose>:
}

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100e20:	55                   	push   %ebp
80100e21:	89 e5                	mov    %esp,%ebp
80100e23:	83 ec 38             	sub    $0x38,%esp
80100e26:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80100e29:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100e2c:	89 75 f8             	mov    %esi,-0x8(%ebp)
80100e2f:	89 7d fc             	mov    %edi,-0x4(%ebp)
  struct file ff;

  acquire(&ftable.lock);
80100e32:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
80100e39:	e8 02 35 00 00       	call   80104340 <acquire>
  if(f->ref < 1)
80100e3e:	8b 43 04             	mov    0x4(%ebx),%eax
80100e41:	85 c0                	test   %eax,%eax
80100e43:	0f 8e 9c 00 00 00    	jle    80100ee5 <fileclose+0xc5>
    panic("fileclose");
  if(--f->ref > 0){
80100e49:	83 e8 01             	sub    $0x1,%eax
80100e4c:	85 c0                	test   %eax,%eax
80100e4e:	89 43 04             	mov    %eax,0x4(%ebx)
80100e51:	74 1d                	je     80100e70 <fileclose+0x50>
    release(&ftable.lock);
80100e53:	c7 45 08 c0 ff 10 80 	movl   $0x8010ffc0,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100e5a:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80100e5d:	8b 75 f8             	mov    -0x8(%ebp),%esi
80100e60:	8b 7d fc             	mov    -0x4(%ebp),%edi
80100e63:	89 ec                	mov    %ebp,%esp
80100e65:	5d                   	pop    %ebp

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
80100e66:	e9 45 35 00 00       	jmp    801043b0 <release>
80100e6b:	90                   	nop
80100e6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return;
  }
  ff = *f;
80100e70:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
80100e74:	8b 33                	mov    (%ebx),%esi
  f->ref = 0;
  f->type = FD_NONE;
80100e76:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100e7c:	8b 7b 10             	mov    0x10(%ebx),%edi
80100e7f:	88 45 e7             	mov    %al,-0x19(%ebp)
80100e82:	8b 43 0c             	mov    0xc(%ebx),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100e85:	c7 04 24 c0 ff 10 80 	movl   $0x8010ffc0,(%esp)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100e8c:	89 45 e0             	mov    %eax,-0x20(%ebp)
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100e8f:	e8 1c 35 00 00       	call   801043b0 <release>

  if(ff.type == FD_PIPE)
80100e94:	83 fe 01             	cmp    $0x1,%esi
80100e97:	74 37                	je     80100ed0 <fileclose+0xb0>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80100e99:	83 fe 02             	cmp    $0x2,%esi
80100e9c:	74 12                	je     80100eb0 <fileclose+0x90>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100e9e:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80100ea1:	8b 75 f8             	mov    -0x8(%ebp),%esi
80100ea4:	8b 7d fc             	mov    -0x4(%ebp),%edi
80100ea7:	89 ec                	mov    %ebp,%esp
80100ea9:	5d                   	pop    %ebp
80100eaa:	c3                   	ret    
80100eab:	90                   	nop
80100eac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ftable.lock);

  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
    begin_op();
80100eb0:	e8 7b 1d 00 00       	call   80102c30 <begin_op>
    iput(ff.ip);
80100eb5:	89 3c 24             	mov    %edi,(%esp)
80100eb8:	e8 33 09 00 00       	call   801017f0 <iput>
    end_op();
  }
}
80100ebd:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80100ec0:	8b 75 f8             	mov    -0x8(%ebp),%esi
80100ec3:	8b 7d fc             	mov    -0x4(%ebp),%edi
80100ec6:	89 ec                	mov    %ebp,%esp
80100ec8:	5d                   	pop    %ebp
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
80100ec9:	e9 d2 1d 00 00       	jmp    80102ca0 <end_op>
80100ece:	66 90                	xchg   %ax,%ax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);

  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
80100ed0:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
80100ed4:	89 44 24 04          	mov    %eax,0x4(%esp)
80100ed8:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100edb:	89 04 24             	mov    %eax,(%esp)
80100ede:	e8 ad 24 00 00       	call   80103390 <pipeclose>
80100ee3:	eb b9                	jmp    80100e9e <fileclose+0x7e>
{
  struct file ff;

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
80100ee5:	c7 04 24 3c 6f 10 80 	movl   $0x80106f3c,(%esp)
80100eec:	e8 7f f4 ff ff       	call   80100370 <panic>
80100ef1:	eb 0d                	jmp    80100f00 <filestat>
80100ef3:	90                   	nop
80100ef4:	90                   	nop
80100ef5:	90                   	nop
80100ef6:	90                   	nop
80100ef7:	90                   	nop
80100ef8:	90                   	nop
80100ef9:	90                   	nop
80100efa:	90                   	nop
80100efb:	90                   	nop
80100efc:	90                   	nop
80100efd:	90                   	nop
80100efe:	90                   	nop
80100eff:	90                   	nop

80100f00 <filestat>:
}

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100f00:	55                   	push   %ebp
    ilock(f->ip);
    stati(f->ip, st);
    iunlock(f->ip);
    return 0;
  }
  return -1;
80100f01:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100f06:	89 e5                	mov    %esp,%ebp
80100f08:	53                   	push   %ebx
80100f09:	83 ec 14             	sub    $0x14,%esp
80100f0c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100f0f:	83 3b 02             	cmpl   $0x2,(%ebx)
80100f12:	75 2a                	jne    80100f3e <filestat+0x3e>
    ilock(f->ip);
80100f14:	8b 43 10             	mov    0x10(%ebx),%eax
80100f17:	89 04 24             	mov    %eax,(%esp)
80100f1a:	e8 a1 07 00 00       	call   801016c0 <ilock>
    stati(f->ip, st);
80100f1f:	8b 45 0c             	mov    0xc(%ebp),%eax
80100f22:	89 44 24 04          	mov    %eax,0x4(%esp)
80100f26:	8b 43 10             	mov    0x10(%ebx),%eax
80100f29:	89 04 24             	mov    %eax,(%esp)
80100f2c:	e8 5f 0a 00 00       	call   80101990 <stati>
    iunlock(f->ip);
80100f31:	8b 43 10             	mov    0x10(%ebx),%eax
80100f34:	89 04 24             	mov    %eax,(%esp)
80100f37:	e8 64 08 00 00       	call   801017a0 <iunlock>
    return 0;
80100f3c:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80100f3e:	83 c4 14             	add    $0x14,%esp
80100f41:	5b                   	pop    %ebx
80100f42:	5d                   	pop    %ebp
80100f43:	c3                   	ret    
80100f44:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100f4a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80100f50 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100f50:	55                   	push   %ebp
80100f51:	89 e5                	mov    %esp,%ebp
80100f53:	83 ec 28             	sub    $0x28,%esp
80100f56:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80100f59:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100f5c:	89 75 f8             	mov    %esi,-0x8(%ebp)
80100f5f:	8b 75 0c             	mov    0xc(%ebp),%esi
80100f62:	89 7d fc             	mov    %edi,-0x4(%ebp)
80100f65:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80100f68:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100f6c:	74 72                	je     80100fe0 <fileread+0x90>
    return -1;
  if(f->type == FD_PIPE)
80100f6e:	8b 03                	mov    (%ebx),%eax
80100f70:	83 f8 01             	cmp    $0x1,%eax
80100f73:	74 53                	je     80100fc8 <fileread+0x78>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100f75:	83 f8 02             	cmp    $0x2,%eax
80100f78:	75 6d                	jne    80100fe7 <fileread+0x97>
    ilock(f->ip);
80100f7a:	8b 43 10             	mov    0x10(%ebx),%eax
80100f7d:	89 04 24             	mov    %eax,(%esp)
80100f80:	e8 3b 07 00 00       	call   801016c0 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100f85:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80100f89:	8b 43 14             	mov    0x14(%ebx),%eax
80100f8c:	89 74 24 04          	mov    %esi,0x4(%esp)
80100f90:	89 44 24 08          	mov    %eax,0x8(%esp)
80100f94:	8b 43 10             	mov    0x10(%ebx),%eax
80100f97:	89 04 24             	mov    %eax,(%esp)
80100f9a:	e8 21 0a 00 00       	call   801019c0 <readi>
80100f9f:	85 c0                	test   %eax,%eax
80100fa1:	89 c6                	mov    %eax,%esi
80100fa3:	7e 03                	jle    80100fa8 <fileread+0x58>
      f->off += r;
80100fa5:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80100fa8:	8b 43 10             	mov    0x10(%ebx),%eax
80100fab:	89 04 24             	mov    %eax,(%esp)
80100fae:	e8 ed 07 00 00       	call   801017a0 <iunlock>
    return r;
  }
  panic("fileread");
}
80100fb3:	89 f0                	mov    %esi,%eax
80100fb5:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80100fb8:	8b 75 f8             	mov    -0x8(%ebp),%esi
80100fbb:	8b 7d fc             	mov    -0x4(%ebp),%edi
80100fbe:	89 ec                	mov    %ebp,%esp
80100fc0:	5d                   	pop    %ebp
80100fc1:	c3                   	ret    
80100fc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80100fc8:	8b 43 0c             	mov    0xc(%ebx),%eax
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
80100fcb:	8b 75 f8             	mov    -0x8(%ebp),%esi
80100fce:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80100fd1:	8b 7d fc             	mov    -0x4(%ebp),%edi
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80100fd4:	89 45 08             	mov    %eax,0x8(%ebp)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
80100fd7:	89 ec                	mov    %ebp,%esp
80100fd9:	5d                   	pop    %ebp
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80100fda:	e9 41 25 00 00       	jmp    80103520 <piperead>
80100fdf:	90                   	nop
fileread(struct file *f, char *addr, int n)
{
  int r;

  if(f->readable == 0)
    return -1;
80100fe0:	be ff ff ff ff       	mov    $0xffffffff,%esi
80100fe5:	eb cc                	jmp    80100fb3 <fileread+0x63>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
80100fe7:	c7 04 24 46 6f 10 80 	movl   $0x80106f46,(%esp)
80100fee:	e8 7d f3 ff ff       	call   80100370 <panic>
80100ff3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100ff9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101000 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101000:	55                   	push   %ebp
80101001:	89 e5                	mov    %esp,%ebp
80101003:	57                   	push   %edi
80101004:	56                   	push   %esi
80101005:	53                   	push   %ebx
80101006:	83 ec 2c             	sub    $0x2c,%esp
80101009:	8b 45 0c             	mov    0xc(%ebp),%eax
8010100c:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010100f:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101012:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
80101015:	80 7b 09 00          	cmpb   $0x0,0x9(%ebx)

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101019:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int r;

  if(f->writable == 0)
8010101c:	0f 84 ae 00 00 00    	je     801010d0 <filewrite+0xd0>
    return -1;
  if(f->type == FD_PIPE)
80101022:	8b 03                	mov    (%ebx),%eax
80101024:	83 f8 01             	cmp    $0x1,%eax
80101027:	0f 84 c6 00 00 00    	je     801010f3 <filewrite+0xf3>
    return pipewrite(f->pipe, addr, n);

  if(f->type == FD_INODE){
8010102d:	83 f8 02             	cmp    $0x2,%eax
80101030:	0f 85 db 00 00 00    	jne    80101111 <filewrite+0x111>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101036:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101039:	31 f6                	xor    %esi,%esi
8010103b:	85 c9                	test   %ecx,%ecx
8010103d:	7f 31                	jg     80101070 <filewrite+0x70>
8010103f:	e9 9c 00 00 00       	jmp    801010e0 <filewrite+0xe0>
80101044:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101048:	01 43 14             	add    %eax,0x14(%ebx)
      iunlock(f->ip);
8010104b:	8b 53 10             	mov    0x10(%ebx),%edx
8010104e:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101051:	89 14 24             	mov    %edx,(%esp)
80101054:	e8 47 07 00 00       	call   801017a0 <iunlock>
      end_op();
80101059:	e8 42 1c 00 00       	call   80102ca0 <end_op>
8010105e:	8b 45 dc             	mov    -0x24(%ebp),%eax

      if(r < 0)
        break;
      if(r != n1)
80101061:	39 f8                	cmp    %edi,%eax
80101063:	0f 85 9c 00 00 00    	jne    80101105 <filewrite+0x105>
        panic("short filewrite");
      i += r;
80101069:	01 c6                	add    %eax,%esi
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
8010106b:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
8010106e:	7e 70                	jle    801010e0 <filewrite+0xe0>
      int n1 = n - i;
80101070:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101073:	b8 00 06 00 00       	mov    $0x600,%eax
80101078:	29 f7                	sub    %esi,%edi
8010107a:	81 ff 00 06 00 00    	cmp    $0x600,%edi
80101080:	0f 4f f8             	cmovg  %eax,%edi
      if(n1 > max)
        n1 = max;

      begin_op();
80101083:	e8 a8 1b 00 00       	call   80102c30 <begin_op>
      ilock(f->ip);
80101088:	8b 43 10             	mov    0x10(%ebx),%eax
8010108b:	89 04 24             	mov    %eax,(%esp)
8010108e:	e8 2d 06 00 00       	call   801016c0 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101093:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80101097:	8b 43 14             	mov    0x14(%ebx),%eax
8010109a:	89 44 24 08          	mov    %eax,0x8(%esp)
8010109e:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010a1:	01 f0                	add    %esi,%eax
801010a3:	89 44 24 04          	mov    %eax,0x4(%esp)
801010a7:	8b 43 10             	mov    0x10(%ebx),%eax
801010aa:	89 04 24             	mov    %eax,(%esp)
801010ad:	e8 6e 0a 00 00       	call   80101b20 <writei>
801010b2:	85 c0                	test   %eax,%eax
801010b4:	7f 92                	jg     80101048 <filewrite+0x48>
        f->off += r;
      iunlock(f->ip);
801010b6:	8b 53 10             	mov    0x10(%ebx),%edx
801010b9:	89 45 dc             	mov    %eax,-0x24(%ebp)
801010bc:	89 14 24             	mov    %edx,(%esp)
801010bf:	e8 dc 06 00 00       	call   801017a0 <iunlock>
      end_op();
801010c4:	e8 d7 1b 00 00       	call   80102ca0 <end_op>

      if(r < 0)
801010c9:	8b 45 dc             	mov    -0x24(%ebp),%eax
801010cc:	85 c0                	test   %eax,%eax
801010ce:	74 91                	je     80101061 <filewrite+0x61>
    }
    return i == n ? n : -1;
  } 
 
  panic("filewrite");
}
801010d0:	83 c4 2c             	add    $0x2c,%esp
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
801010d3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  } 
 
  panic("filewrite");
}
801010d8:	5b                   	pop    %ebx
801010d9:	5e                   	pop    %esi
801010da:	5f                   	pop    %edi
801010db:	5d                   	pop    %ebp
801010dc:	c3                   	ret    
801010dd:	8d 76 00             	lea    0x0(%esi),%esi
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
801010e0:	3b 75 e4             	cmp    -0x1c(%ebp),%esi
801010e3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801010e8:	0f 44 c6             	cmove  %esi,%eax
  } 
 
  panic("filewrite");
}
801010eb:	83 c4 2c             	add    $0x2c,%esp
801010ee:	5b                   	pop    %ebx
801010ef:	5e                   	pop    %esi
801010f0:	5f                   	pop    %edi
801010f1:	5d                   	pop    %ebp
801010f2:	c3                   	ret    
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
801010f3:	8b 43 0c             	mov    0xc(%ebx),%eax
801010f6:	89 45 08             	mov    %eax,0x8(%ebp)
    }
    return i == n ? n : -1;
  } 
 
  panic("filewrite");
}
801010f9:	83 c4 2c             	add    $0x2c,%esp
801010fc:	5b                   	pop    %ebx
801010fd:	5e                   	pop    %esi
801010fe:	5f                   	pop    %edi
801010ff:	5d                   	pop    %ebp
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
80101100:	e9 2b 23 00 00       	jmp    80103430 <pipewrite>
      end_op();

      if(r < 0)
        break;
      if(r != n1)
        panic("short filewrite");
80101105:	c7 04 24 4f 6f 10 80 	movl   $0x80106f4f,(%esp)
8010110c:	e8 5f f2 ff ff       	call   80100370 <panic>
      i += r;
    }
    return i == n ? n : -1;
  } 
 
  panic("filewrite");
80101111:	c7 04 24 55 6f 10 80 	movl   $0x80106f55,(%esp)
80101118:	e8 53 f2 ff ff       	call   80100370 <panic>
8010111d:	00 00                	add    %al,(%eax)
	...

80101120 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101120:	55                   	push   %ebp
80101121:	89 e5                	mov    %esp,%ebp
80101123:	57                   	push   %edi
80101124:	89 d7                	mov    %edx,%edi
80101126:	56                   	push   %esi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101127:	31 f6                	xor    %esi,%esi
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101129:	53                   	push   %ebx
8010112a:	89 c3                	mov    %eax,%ebx
8010112c:	83 ec 2c             	sub    $0x2c,%esp
  struct inode *ip, *empty;

  acquire(&icache.lock);
8010112f:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101136:	e8 05 32 00 00       	call   80104340 <acquire>

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010113b:	b8 14 0a 11 80       	mov    $0x80110a14,%eax
80101140:	eb 16                	jmp    80101158 <iget+0x38>
80101142:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101148:	85 f6                	test   %esi,%esi
8010114a:	74 3c                	je     80101188 <iget+0x68>

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010114c:	05 90 00 00 00       	add    $0x90,%eax
80101151:	3d 34 26 11 80       	cmp    $0x80112634,%eax
80101156:	73 48                	jae    801011a0 <iget+0x80>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101158:	8b 48 08             	mov    0x8(%eax),%ecx
8010115b:	85 c9                	test   %ecx,%ecx
8010115d:	7e e9                	jle    80101148 <iget+0x28>
8010115f:	39 18                	cmp    %ebx,(%eax)
80101161:	75 e5                	jne    80101148 <iget+0x28>
80101163:	39 78 04             	cmp    %edi,0x4(%eax)
80101166:	75 e0                	jne    80101148 <iget+0x28>
      ip->ref++;
80101168:	83 c1 01             	add    $0x1,%ecx
8010116b:	89 48 08             	mov    %ecx,0x8(%eax)
      release(&icache.lock);
8010116e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101171:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101178:	e8 33 32 00 00       	call   801043b0 <release>
      return ip;
8010117d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);

  return ip;
}
80101180:	83 c4 2c             	add    $0x2c,%esp
80101183:	5b                   	pop    %ebx
80101184:	5e                   	pop    %esi
80101185:	5f                   	pop    %edi
80101186:	5d                   	pop    %ebp
80101187:	c3                   	ret    
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101188:	85 c9                	test   %ecx,%ecx
8010118a:	0f 44 f0             	cmove  %eax,%esi

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010118d:	05 90 00 00 00       	add    $0x90,%eax
80101192:	3d 34 26 11 80       	cmp    $0x80112634,%eax
80101197:	72 bf                	jb     80101158 <iget+0x38>
80101199:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
801011a0:	85 f6                	test   %esi,%esi
801011a2:	74 29                	je     801011cd <iget+0xad>
    panic("iget: no inodes");

  ip = empty;
  ip->dev = dev;
801011a4:	89 1e                	mov    %ebx,(%esi)
  ip->inum = inum;
801011a6:	89 7e 04             	mov    %edi,0x4(%esi)
  ip->ref = 1;
801011a9:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
801011b0:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
801011b7:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
801011be:	e8 ed 31 00 00       	call   801043b0 <release>

  return ip;
}
801011c3:	83 c4 2c             	add    $0x2c,%esp
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);

  return ip;
801011c6:	89 f0                	mov    %esi,%eax
}
801011c8:	5b                   	pop    %ebx
801011c9:	5e                   	pop    %esi
801011ca:	5f                   	pop    %edi
801011cb:	5d                   	pop    %ebp
801011cc:	c3                   	ret    
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
    panic("iget: no inodes");
801011cd:	c7 04 24 5f 6f 10 80 	movl   $0x80106f5f,(%esp)
801011d4:	e8 97 f1 ff ff       	call   80100370 <panic>
801011d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801011e0 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
801011e0:	55                   	push   %ebp
801011e1:	89 e5                	mov    %esp,%ebp
801011e3:	57                   	push   %edi
801011e4:	56                   	push   %esi
801011e5:	53                   	push   %ebx
801011e6:	83 ec 3c             	sub    $0x3c,%esp
801011e9:	89 45 d8             	mov    %eax,-0x28(%ebp)
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
801011ec:	a1 c0 09 11 80       	mov    0x801109c0,%eax
801011f1:	85 c0                	test   %eax,%eax
801011f3:	0f 84 90 00 00 00    	je     80101289 <balloc+0xa9>
801011f9:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101200:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101203:	c1 f8 0c             	sar    $0xc,%eax
80101206:	03 05 d8 09 11 80    	add    0x801109d8,%eax
8010120c:	89 44 24 04          	mov    %eax,0x4(%esp)
80101210:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101213:	89 04 24             	mov    %eax,(%esp)
80101216:	e8 b5 ee ff ff       	call   801000d0 <bread>
8010121b:	8b 15 c0 09 11 80    	mov    0x801109c0,%edx
80101221:	8b 5d dc             	mov    -0x24(%ebp),%ebx
80101224:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101227:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010122a:	31 c0                	xor    %eax,%eax
8010122c:	eb 35                	jmp    80101263 <balloc+0x83>
8010122e:	66 90                	xchg   %ax,%ax
      m = 1 << (bi % 8);
80101230:	89 c1                	mov    %eax,%ecx
80101232:	bf 01 00 00 00       	mov    $0x1,%edi
80101237:	83 e1 07             	and    $0x7,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010123a:	89 c2                	mov    %eax,%edx

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
8010123c:	d3 e7                	shl    %cl,%edi
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010123e:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101241:	c1 fa 03             	sar    $0x3,%edx

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
80101244:	89 7d d4             	mov    %edi,-0x2c(%ebp)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101247:	0f b6 74 11 5c       	movzbl 0x5c(%ecx,%edx,1),%esi
8010124c:	89 f1                	mov    %esi,%ecx
8010124e:	0f b6 f9             	movzbl %cl,%edi
80101251:	85 7d d4             	test   %edi,-0x2c(%ebp)
80101254:	74 42                	je     80101298 <balloc+0xb8>
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101256:	83 c0 01             	add    $0x1,%eax
80101259:	83 c3 01             	add    $0x1,%ebx
8010125c:	3d 00 10 00 00       	cmp    $0x1000,%eax
80101261:	74 05                	je     80101268 <balloc+0x88>
80101263:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
80101266:	72 c8                	jb     80101230 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
80101268:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010126b:	89 04 24             	mov    %eax,(%esp)
8010126e:	e8 6d ef ff ff       	call   801001e0 <brelse>
{
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101273:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
8010127a:	8b 55 dc             	mov    -0x24(%ebp),%edx
8010127d:	3b 15 c0 09 11 80    	cmp    0x801109c0,%edx
80101283:	0f 82 77 ff ff ff    	jb     80101200 <balloc+0x20>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
80101289:	c7 04 24 6f 6f 10 80 	movl   $0x80106f6f,(%esp)
80101290:	e8 db f0 ff ff       	call   80100370 <panic>
80101295:	8d 76 00             	lea    0x0(%esi),%esi
80101298:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
8010129b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010129e:	09 f1                	or     %esi,%ecx
801012a0:	88 4c 10 5c          	mov    %cl,0x5c(%eax,%edx,1)
        log_write(bp);
801012a4:	89 04 24             	mov    %eax,(%esp)
801012a7:	e8 24 1b 00 00       	call   80102dd0 <log_write>
        brelse(bp);
801012ac:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801012af:	89 04 24             	mov    %eax,(%esp)
801012b2:	e8 29 ef ff ff       	call   801001e0 <brelse>
static void
bzero(int dev, int bno)
{
  struct buf *bp;

  bp = bread(dev, bno);
801012b7:	8b 45 d8             	mov    -0x28(%ebp),%eax
801012ba:	89 5c 24 04          	mov    %ebx,0x4(%esp)
801012be:	89 04 24             	mov    %eax,(%esp)
801012c1:	e8 0a ee ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
801012c6:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
801012cd:	00 
801012ce:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801012d5:	00 
static void
bzero(int dev, int bno)
{
  struct buf *bp;

  bp = bread(dev, bno);
801012d6:	89 c6                	mov    %eax,%esi
  memset(bp->data, 0, BSIZE);
801012d8:	8d 40 5c             	lea    0x5c(%eax),%eax
801012db:	89 04 24             	mov    %eax,(%esp)
801012de:	e8 1d 31 00 00       	call   80104400 <memset>
  log_write(bp);
801012e3:	89 34 24             	mov    %esi,(%esp)
801012e6:	e8 e5 1a 00 00       	call   80102dd0 <log_write>
  brelse(bp);
801012eb:	89 34 24             	mov    %esi,(%esp)
801012ee:	e8 ed ee ff ff       	call   801001e0 <brelse>
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
}
801012f3:	83 c4 3c             	add    $0x3c,%esp
801012f6:	89 d8                	mov    %ebx,%eax
801012f8:	5b                   	pop    %ebx
801012f9:	5e                   	pop    %esi
801012fa:	5f                   	pop    %edi
801012fb:	5d                   	pop    %ebp
801012fc:	c3                   	ret    
801012fd:	8d 76 00             	lea    0x0(%esi),%esi

80101300 <bmap.part.0>:
// listed in block ip->addrs[NDIRECT].

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
80101300:	55                   	push   %ebp
80101301:	89 e5                	mov    %esp,%ebp
80101303:	83 ec 38             	sub    $0x38,%esp
80101306:	89 7d fc             	mov    %edi,-0x4(%ebp)
  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80101309:	8d 7a f4             	lea    -0xc(%edx),%edi

  if(bn < NINDIRECT){
8010130c:	83 ff 7f             	cmp    $0x7f,%edi
// listed in block ip->addrs[NDIRECT].

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
8010130f:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80101312:	89 c3                	mov    %eax,%ebx
80101314:	89 75 f8             	mov    %esi,-0x8(%ebp)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;

  if(bn < NINDIRECT){
80101317:	77 66                	ja     8010137f <bmap.part.0+0x7f>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101319:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
8010131f:	85 c0                	test   %eax,%eax
80101321:	74 4d                	je     80101370 <bmap.part.0+0x70>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
80101323:	89 44 24 04          	mov    %eax,0x4(%esp)
80101327:	8b 03                	mov    (%ebx),%eax
80101329:	89 04 24             	mov    %eax,(%esp)
8010132c:	e8 9f ed ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101331:	8d 7c b8 5c          	lea    0x5c(%eax,%edi,4),%edi

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
80101335:	89 c6                	mov    %eax,%esi
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101337:	8b 07                	mov    (%edi),%eax
80101339:	85 c0                	test   %eax,%eax
8010133b:	75 17                	jne    80101354 <bmap.part.0+0x54>
      a[bn] = addr = balloc(ip->dev);
8010133d:	8b 03                	mov    (%ebx),%eax
8010133f:	e8 9c fe ff ff       	call   801011e0 <balloc>
80101344:	89 07                	mov    %eax,(%edi)
      log_write(bp);
80101346:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101349:	89 34 24             	mov    %esi,(%esp)
8010134c:	e8 7f 1a 00 00       	call   80102dd0 <log_write>
80101351:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    }
    brelse(bp);
80101354:	89 34 24             	mov    %esi,(%esp)
80101357:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010135a:	e8 81 ee ff ff       	call   801001e0 <brelse>
    return addr;
  }

  panic("bmap: out of range");
}
8010135f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101362:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80101365:	8b 75 f8             	mov    -0x8(%ebp),%esi
80101368:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010136b:	89 ec                	mov    %ebp,%esp
8010136d:	5d                   	pop    %ebp
8010136e:	c3                   	ret    
8010136f:	90                   	nop
  bn -= NDIRECT;

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101370:	8b 03                	mov    (%ebx),%eax
80101372:	e8 69 fe ff ff       	call   801011e0 <balloc>
80101377:	89 83 8c 00 00 00    	mov    %eax,0x8c(%ebx)
8010137d:	eb a4                	jmp    80101323 <bmap.part.0+0x23>
    }
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
8010137f:	c7 04 24 85 6f 10 80 	movl   $0x80106f85,(%esp)
80101386:	e8 e5 ef ff ff       	call   80100370 <panic>
8010138b:	90                   	nop
8010138c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101390 <readsb>:
struct superblock sb; 

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
80101390:	55                   	push   %ebp
80101391:	89 e5                	mov    %esp,%ebp
80101393:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;

  bp = bread(dev, 1);
80101396:	8b 45 08             	mov    0x8(%ebp),%eax
struct superblock sb; 

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
80101399:	89 5d f8             	mov    %ebx,-0x8(%ebp)
8010139c:	89 75 fc             	mov    %esi,-0x4(%ebp)
8010139f:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct buf *bp;

  bp = bread(dev, 1);
801013a2:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
801013a9:	00 
801013aa:	89 04 24             	mov    %eax,(%esp)
801013ad:	e8 1e ed ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
801013b2:	89 34 24             	mov    %esi,(%esp)
801013b5:	c7 44 24 08 1c 00 00 	movl   $0x1c,0x8(%esp)
801013bc:	00 
void
readsb(int dev, struct superblock *sb)
{
  struct buf *bp;

  bp = bread(dev, 1);
801013bd:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801013bf:	8d 40 5c             	lea    0x5c(%eax),%eax
801013c2:	89 44 24 04          	mov    %eax,0x4(%esp)
801013c6:	e8 f5 30 00 00       	call   801044c0 <memmove>
  brelse(bp);
}
801013cb:	8b 75 fc             	mov    -0x4(%ebp),%esi
{
  struct buf *bp;

  bp = bread(dev, 1);
  memmove(sb, bp->data, sizeof(*sb));
  brelse(bp);
801013ce:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801013d1:	8b 5d f8             	mov    -0x8(%ebp),%ebx
801013d4:	89 ec                	mov    %ebp,%esp
801013d6:	5d                   	pop    %ebp
{
  struct buf *bp;

  bp = bread(dev, 1);
  memmove(sb, bp->data, sizeof(*sb));
  brelse(bp);
801013d7:	e9 04 ee ff ff       	jmp    801001e0 <brelse>
801013dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801013e0 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
801013e0:	55                   	push   %ebp
801013e1:	89 e5                	mov    %esp,%ebp
801013e3:	83 ec 28             	sub    $0x28,%esp
801013e6:	89 75 f8             	mov    %esi,-0x8(%ebp)
801013e9:	89 d6                	mov    %edx,%esi
801013eb:	89 5d f4             	mov    %ebx,-0xc(%ebp)
801013ee:	89 c3                	mov    %eax,%ebx
801013f0:	89 7d fc             	mov    %edi,-0x4(%ebp)
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
801013f3:	89 04 24             	mov    %eax,(%esp)
801013f6:	c7 44 24 04 c0 09 11 	movl   $0x801109c0,0x4(%esp)
801013fd:	80 
801013fe:	e8 8d ff ff ff       	call   80101390 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
80101403:	89 f0                	mov    %esi,%eax
80101405:	c1 e8 0c             	shr    $0xc,%eax
80101408:	03 05 d8 09 11 80    	add    0x801109d8,%eax
8010140e:	89 1c 24             	mov    %ebx,(%esp)
  bi = b % BPB;
80101411:	89 f3                	mov    %esi,%ebx
80101413:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
{
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
80101419:	89 44 24 04          	mov    %eax,0x4(%esp)
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
8010141d:	c1 fb 03             	sar    $0x3,%ebx
{
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
80101420:	e8 ab ec ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
80101425:	89 f1                	mov    %esi,%ecx
80101427:	be 01 00 00 00       	mov    $0x1,%esi
8010142c:	83 e1 07             	and    $0x7,%ecx
8010142f:	d3 e6                	shl    %cl,%esi
  if((bp->data[bi/8] & m) == 0)
80101431:	0f b6 54 18 5c       	movzbl 0x5c(%eax,%ebx,1),%edx
{
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
80101436:	89 c7                	mov    %eax,%edi
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
80101438:	0f b6 c2             	movzbl %dl,%eax
8010143b:	85 f0                	test   %esi,%eax
8010143d:	74 27                	je     80101466 <bfree+0x86>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
8010143f:	89 f0                	mov    %esi,%eax
80101441:	f7 d0                	not    %eax
80101443:	21 d0                	and    %edx,%eax
80101445:	88 44 1f 5c          	mov    %al,0x5c(%edi,%ebx,1)
  log_write(bp);
80101449:	89 3c 24             	mov    %edi,(%esp)
8010144c:	e8 7f 19 00 00       	call   80102dd0 <log_write>
  brelse(bp);
80101451:	89 3c 24             	mov    %edi,(%esp)
80101454:	e8 87 ed ff ff       	call   801001e0 <brelse>
}
80101459:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010145c:	8b 75 f8             	mov    -0x8(%ebp),%esi
8010145f:	8b 7d fc             	mov    -0x4(%ebp),%edi
80101462:	89 ec                	mov    %ebp,%esp
80101464:	5d                   	pop    %ebp
80101465:	c3                   	ret    
  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
80101466:	c7 04 24 98 6f 10 80 	movl   $0x80106f98,(%esp)
8010146d:	e8 fe ee ff ff       	call   80100370 <panic>
80101472:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101480 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
80101480:	55                   	push   %ebp
80101481:	89 e5                	mov    %esp,%ebp
80101483:	53                   	push   %ebx
  int i = 0;
  
  initlock(&icache.lock, "icache");
  for(i = 0; i < NINODE; i++) {
80101484:	31 db                	xor    %ebx,%ebx
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
80101486:	83 ec 24             	sub    $0x24,%esp
  int i = 0;
  
  initlock(&icache.lock, "icache");
80101489:	c7 44 24 04 ab 6f 10 	movl   $0x80106fab,0x4(%esp)
80101490:	80 
80101491:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101498:	e8 33 2d 00 00       	call   801041d0 <initlock>
8010149d:	8d 76 00             	lea    0x0(%esi),%esi
  for(i = 0; i < NINODE; i++) {
    initsleeplock(&icache.inode[i].lock, "inode");
801014a0:	8d 04 db             	lea    (%ebx,%ebx,8),%eax
iinit(int dev)
{
  int i = 0;
  
  initlock(&icache.lock, "icache");
  for(i = 0; i < NINODE; i++) {
801014a3:	83 c3 01             	add    $0x1,%ebx
    initsleeplock(&icache.inode[i].lock, "inode");
801014a6:	c1 e0 04             	shl    $0x4,%eax
801014a9:	05 20 0a 11 80       	add    $0x80110a20,%eax
801014ae:	c7 44 24 04 b2 6f 10 	movl   $0x80106fb2,0x4(%esp)
801014b5:	80 
801014b6:	89 04 24             	mov    %eax,(%esp)
801014b9:	e8 e2 2b 00 00       	call   801040a0 <initsleeplock>
iinit(int dev)
{
  int i = 0;
  
  initlock(&icache.lock, "icache");
  for(i = 0; i < NINODE; i++) {
801014be:	83 fb 32             	cmp    $0x32,%ebx
801014c1:	75 dd                	jne    801014a0 <iinit+0x20>
    initsleeplock(&icache.inode[i].lock, "inode");
  }

  readsb(dev, &sb);
801014c3:	8b 45 08             	mov    0x8(%ebp),%eax
801014c6:	c7 44 24 04 c0 09 11 	movl   $0x801109c0,0x4(%esp)
801014cd:	80 
801014ce:	89 04 24             	mov    %eax,(%esp)
801014d1:	e8 ba fe ff ff       	call   80101390 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801014d6:	a1 d8 09 11 80       	mov    0x801109d8,%eax
801014db:	c7 04 24 18 70 10 80 	movl   $0x80107018,(%esp)
801014e2:	89 44 24 1c          	mov    %eax,0x1c(%esp)
801014e6:	a1 d4 09 11 80       	mov    0x801109d4,%eax
801014eb:	89 44 24 18          	mov    %eax,0x18(%esp)
801014ef:	a1 d0 09 11 80       	mov    0x801109d0,%eax
801014f4:	89 44 24 14          	mov    %eax,0x14(%esp)
801014f8:	a1 cc 09 11 80       	mov    0x801109cc,%eax
801014fd:	89 44 24 10          	mov    %eax,0x10(%esp)
80101501:	a1 c8 09 11 80       	mov    0x801109c8,%eax
80101506:	89 44 24 0c          	mov    %eax,0xc(%esp)
8010150a:	a1 c4 09 11 80       	mov    0x801109c4,%eax
8010150f:	89 44 24 08          	mov    %eax,0x8(%esp)
80101513:	a1 c0 09 11 80       	mov    0x801109c0,%eax
80101518:	89 44 24 04          	mov    %eax,0x4(%esp)
8010151c:	e8 2f f1 ff ff       	call   80100650 <cprintf>
 inodestart %d bmap start %d\n", sb.size, sb.nblocks,
          sb.ninodes, sb.nlog, sb.logstart, sb.inodestart,
          sb.bmapstart);
}
80101521:	83 c4 24             	add    $0x24,%esp
80101524:	5b                   	pop    %ebx
80101525:	5d                   	pop    %ebp
80101526:	c3                   	ret    
80101527:	89 f6                	mov    %esi,%esi
80101529:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101530 <ialloc>:
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
80101530:	55                   	push   %ebp
80101531:	89 e5                	mov    %esp,%ebp
80101533:	57                   	push   %edi
80101534:	56                   	push   %esi
80101535:	53                   	push   %ebx
80101536:	83 ec 2c             	sub    $0x2c,%esp
80101539:	8b 45 08             	mov    0x8(%ebp),%eax
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
8010153c:	83 3d c8 09 11 80 01 	cmpl   $0x1,0x801109c8
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
80101543:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101546:	0f b7 45 0c          	movzwl 0xc(%ebp),%eax
8010154a:	66 89 45 e2          	mov    %ax,-0x1e(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
8010154e:	0f 86 95 00 00 00    	jbe    801015e9 <ialloc+0xb9>
80101554:	be 01 00 00 00       	mov    $0x1,%esi
80101559:	bb 01 00 00 00       	mov    $0x1,%ebx
8010155e:	eb 15                	jmp    80101575 <ialloc+0x45>
80101560:	83 c3 01             	add    $0x1,%ebx
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
80101563:	89 3c 24             	mov    %edi,(%esp)
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101566:	89 de                	mov    %ebx,%esi
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
80101568:	e8 73 ec ff ff       	call   801001e0 <brelse>
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
8010156d:	3b 1d c8 09 11 80    	cmp    0x801109c8,%ebx
80101573:	73 74                	jae    801015e9 <ialloc+0xb9>
    bp = bread(dev, IBLOCK(inum, sb));
80101575:	89 f0                	mov    %esi,%eax
80101577:	c1 e8 03             	shr    $0x3,%eax
8010157a:	03 05 d4 09 11 80    	add    0x801109d4,%eax
80101580:	89 44 24 04          	mov    %eax,0x4(%esp)
80101584:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101587:	89 04 24             	mov    %eax,(%esp)
8010158a:	e8 41 eb ff ff       	call   801000d0 <bread>
8010158f:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
80101591:	89 f0                	mov    %esi,%eax
80101593:	83 e0 07             	and    $0x7,%eax
80101596:	c1 e0 06             	shl    $0x6,%eax
80101599:	8d 54 07 5c          	lea    0x5c(%edi,%eax,1),%edx
    if(dip->type == 0){  // a free inode
8010159d:	66 83 3a 00          	cmpw   $0x0,(%edx)
801015a1:	75 bd                	jne    80101560 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
801015a3:	89 14 24             	mov    %edx,(%esp)
801015a6:	89 55 dc             	mov    %edx,-0x24(%ebp)
801015a9:	c7 44 24 08 40 00 00 	movl   $0x40,0x8(%esp)
801015b0:	00 
801015b1:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801015b8:	00 
801015b9:	e8 42 2e 00 00       	call   80104400 <memset>
      dip->type = type;
801015be:	8b 55 dc             	mov    -0x24(%ebp),%edx
801015c1:	0f b7 45 e2          	movzwl -0x1e(%ebp),%eax
801015c5:	66 89 02             	mov    %ax,(%edx)
      log_write(bp);   // mark it allocated on the disk
801015c8:	89 3c 24             	mov    %edi,(%esp)
801015cb:	e8 00 18 00 00       	call   80102dd0 <log_write>
      brelse(bp);
801015d0:	89 3c 24             	mov    %edi,(%esp)
801015d3:	e8 08 ec ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
801015d8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
801015db:	83 c4 2c             	add    $0x2c,%esp
801015de:	5b                   	pop    %ebx
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
801015df:	89 f2                	mov    %esi,%edx
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
801015e1:	5e                   	pop    %esi
801015e2:	5f                   	pop    %edi
801015e3:	5d                   	pop    %ebp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
801015e4:	e9 37 fb ff ff       	jmp    80101120 <iget>
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
801015e9:	c7 04 24 b8 6f 10 80 	movl   $0x80106fb8,(%esp)
801015f0:	e8 7b ed ff ff       	call   80100370 <panic>
801015f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801015f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101600 <iupdate>:
// Must be called after every change to an ip->xxx field
// that lives on disk, since i-node cache is write-through.
// Caller must hold ip->lock.
void
iupdate(struct inode *ip)
{
80101600:	55                   	push   %ebp
80101601:	89 e5                	mov    %esp,%ebp
80101603:	56                   	push   %esi
80101604:	53                   	push   %ebx
80101605:	83 ec 10             	sub    $0x10,%esp
80101608:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010160b:	8b 43 04             	mov    0x4(%ebx),%eax
8010160e:	c1 e8 03             	shr    $0x3,%eax
80101611:	03 05 d4 09 11 80    	add    0x801109d4,%eax
80101617:	89 44 24 04          	mov    %eax,0x4(%esp)
8010161b:	8b 03                	mov    (%ebx),%eax
8010161d:	89 04 24             	mov    %eax,(%esp)
80101620:	e8 ab ea ff ff       	call   801000d0 <bread>
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  dip->type = ip->type;
80101625:	0f b7 53 50          	movzwl 0x50(%ebx),%edx
void
iupdate(struct inode *ip)
{
  struct buf *bp;
  struct dinode *dip;
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101629:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010162b:	8b 43 04             	mov    0x4(%ebx),%eax
8010162e:	83 e0 07             	and    $0x7,%eax
80101631:	c1 e0 06             	shl    $0x6,%eax
80101634:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101638:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010163b:	0f b7 53 52          	movzwl 0x52(%ebx),%edx
8010163f:	66 89 50 02          	mov    %dx,0x2(%eax)
  dip->minor = ip->minor;
80101643:	0f b7 53 54          	movzwl 0x54(%ebx),%edx
80101647:	66 89 50 04          	mov    %dx,0x4(%eax)
  dip->nlink = ip->nlink;
8010164b:	0f b7 53 56          	movzwl 0x56(%ebx),%edx
8010164f:	66 89 50 06          	mov    %dx,0x6(%eax)
  dip->size = ip->size;
80101653:	8b 53 58             	mov    0x58(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101656:	83 c3 5c             	add    $0x5c,%ebx
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  dip->type = ip->type;
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
80101659:	89 50 08             	mov    %edx,0x8(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010165c:	83 c0 0c             	add    $0xc,%eax
8010165f:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80101663:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
8010166a:	00 
8010166b:	89 04 24             	mov    %eax,(%esp)
8010166e:	e8 4d 2e 00 00       	call   801044c0 <memmove>
  log_write(bp);
80101673:	89 34 24             	mov    %esi,(%esp)
80101676:	e8 55 17 00 00       	call   80102dd0 <log_write>
  brelse(bp);
8010167b:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010167e:	83 c4 10             	add    $0x10,%esp
80101681:	5b                   	pop    %ebx
80101682:	5e                   	pop    %esi
80101683:	5d                   	pop    %ebp
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  log_write(bp);
  brelse(bp);
80101684:	e9 57 eb ff ff       	jmp    801001e0 <brelse>
80101689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101690 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
80101690:	55                   	push   %ebp
80101691:	89 e5                	mov    %esp,%ebp
80101693:	53                   	push   %ebx
80101694:	83 ec 14             	sub    $0x14,%esp
80101697:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010169a:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
801016a1:	e8 9a 2c 00 00       	call   80104340 <acquire>
  ip->ref++;
801016a6:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
801016aa:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
801016b1:	e8 fa 2c 00 00       	call   801043b0 <release>
  return ip;
}
801016b6:	83 c4 14             	add    $0x14,%esp
801016b9:	89 d8                	mov    %ebx,%eax
801016bb:	5b                   	pop    %ebx
801016bc:	5d                   	pop    %ebp
801016bd:	c3                   	ret    
801016be:	66 90                	xchg   %ax,%ax

801016c0 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
801016c0:	55                   	push   %ebp
801016c1:	89 e5                	mov    %esp,%ebp
801016c3:	56                   	push   %esi
801016c4:	53                   	push   %ebx
801016c5:	83 ec 10             	sub    $0x10,%esp
801016c8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
801016cb:	85 db                	test   %ebx,%ebx
801016cd:	0f 84 b3 00 00 00    	je     80101786 <ilock+0xc6>
801016d3:	8b 4b 08             	mov    0x8(%ebx),%ecx
801016d6:	85 c9                	test   %ecx,%ecx
801016d8:	0f 8e a8 00 00 00    	jle    80101786 <ilock+0xc6>
    panic("ilock");

  acquiresleep(&ip->lock);
801016de:	8d 43 0c             	lea    0xc(%ebx),%eax
801016e1:	89 04 24             	mov    %eax,(%esp)
801016e4:	e8 f7 29 00 00       	call   801040e0 <acquiresleep>

  if(ip->valid == 0){
801016e9:	8b 53 4c             	mov    0x4c(%ebx),%edx
801016ec:	85 d2                	test   %edx,%edx
801016ee:	74 08                	je     801016f8 <ilock+0x38>
    brelse(bp);
    ip->valid = 1;
    if(ip->type == 0)
      panic("ilock: no type");
  }
}
801016f0:	83 c4 10             	add    $0x10,%esp
801016f3:	5b                   	pop    %ebx
801016f4:	5e                   	pop    %esi
801016f5:	5d                   	pop    %ebp
801016f6:	c3                   	ret    
801016f7:	90                   	nop
    panic("ilock");

  acquiresleep(&ip->lock);

  if(ip->valid == 0){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016f8:	8b 43 04             	mov    0x4(%ebx),%eax
801016fb:	c1 e8 03             	shr    $0x3,%eax
801016fe:	03 05 d4 09 11 80    	add    0x801109d4,%eax
80101704:	89 44 24 04          	mov    %eax,0x4(%esp)
80101708:	8b 03                	mov    (%ebx),%eax
8010170a:	89 04 24             	mov    %eax,(%esp)
8010170d:	e8 be e9 ff ff       	call   801000d0 <bread>
80101712:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101714:	8b 43 04             	mov    0x4(%ebx),%eax
80101717:	83 e0 07             	and    $0x7,%eax
8010171a:	c1 e0 06             	shl    $0x6,%eax
8010171d:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101721:	0f b7 10             	movzwl (%eax),%edx
80101724:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101728:	0f b7 50 02          	movzwl 0x2(%eax),%edx
8010172c:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
80101730:	0f b7 50 04          	movzwl 0x4(%eax),%edx
80101734:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101738:	0f b7 50 06          	movzwl 0x6(%eax),%edx
8010173c:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
80101740:	8b 50 08             	mov    0x8(%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101743:	83 c0 0c             	add    $0xc,%eax
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    ip->type = dip->type;
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
80101746:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101749:	89 44 24 04          	mov    %eax,0x4(%esp)
8010174d:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101750:	c7 44 24 08 34 00 00 	movl   $0x34,0x8(%esp)
80101757:	00 
80101758:	89 04 24             	mov    %eax,(%esp)
8010175b:	e8 60 2d 00 00       	call   801044c0 <memmove>
    //memmove(ip->data, dip->data, sizeof(ip->data));
    brelse(bp);
80101760:	89 34 24             	mov    %esi,(%esp)
80101763:	e8 78 ea ff ff       	call   801001e0 <brelse>
    ip->valid = 1;
    if(ip->type == 0)
80101768:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    //memmove(ip->data, dip->data, sizeof(ip->data));
    brelse(bp);
    ip->valid = 1;
8010176d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101774:	0f 85 76 ff ff ff    	jne    801016f0 <ilock+0x30>
      panic("ilock: no type");
8010177a:	c7 04 24 d0 6f 10 80 	movl   $0x80106fd0,(%esp)
80101781:	e8 ea eb ff ff       	call   80100370 <panic>
{
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    panic("ilock");
80101786:	c7 04 24 ca 6f 10 80 	movl   $0x80106fca,(%esp)
8010178d:	e8 de eb ff ff       	call   80100370 <panic>
80101792:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801017a0 <iunlock>:
}

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
801017a0:	55                   	push   %ebp
801017a1:	89 e5                	mov    %esp,%ebp
801017a3:	83 ec 18             	sub    $0x18,%esp
801017a6:	89 5d f8             	mov    %ebx,-0x8(%ebp)
801017a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801017ac:	89 75 fc             	mov    %esi,-0x4(%ebp)
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
801017af:	85 db                	test   %ebx,%ebx
801017b1:	74 27                	je     801017da <iunlock+0x3a>
801017b3:	8d 73 0c             	lea    0xc(%ebx),%esi
801017b6:	89 34 24             	mov    %esi,(%esp)
801017b9:	e8 c2 29 00 00       	call   80104180 <holdingsleep>
801017be:	85 c0                	test   %eax,%eax
801017c0:	74 18                	je     801017da <iunlock+0x3a>
801017c2:	8b 5b 08             	mov    0x8(%ebx),%ebx
801017c5:	85 db                	test   %ebx,%ebx
801017c7:	7e 11                	jle    801017da <iunlock+0x3a>
    panic("iunlock");

  releasesleep(&ip->lock);
801017c9:	89 75 08             	mov    %esi,0x8(%ebp)
}
801017cc:	8b 5d f8             	mov    -0x8(%ebp),%ebx
801017cf:	8b 75 fc             	mov    -0x4(%ebp),%esi
801017d2:	89 ec                	mov    %ebp,%esp
801017d4:	5d                   	pop    %ebp
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");

  releasesleep(&ip->lock);
801017d5:	e9 66 29 00 00       	jmp    80104140 <releasesleep>
// Unlock the given inode.
void
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");
801017da:	c7 04 24 df 6f 10 80 	movl   $0x80106fdf,(%esp)
801017e1:	e8 8a eb ff ff       	call   80100370 <panic>
801017e6:	8d 76 00             	lea    0x0(%esi),%esi
801017e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801017f0 <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
801017f0:	55                   	push   %ebp
801017f1:	89 e5                	mov    %esp,%ebp
801017f3:	83 ec 38             	sub    $0x38,%esp
801017f6:	89 5d f4             	mov    %ebx,-0xc(%ebp)
801017f9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801017fc:	89 75 f8             	mov    %esi,-0x8(%ebp)
801017ff:	89 7d fc             	mov    %edi,-0x4(%ebp)
  acquiresleep(&ip->lock);
80101802:	8d 73 0c             	lea    0xc(%ebx),%esi
80101805:	89 34 24             	mov    %esi,(%esp)
80101808:	e8 d3 28 00 00       	call   801040e0 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
8010180d:	8b 7b 4c             	mov    0x4c(%ebx),%edi
80101810:	85 ff                	test   %edi,%edi
80101812:	74 07                	je     8010181b <iput+0x2b>
80101814:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101819:	74 35                	je     80101850 <iput+0x60>
      ip->type = 0;
      iupdate(ip);
      ip->valid = 0;
    }
  }
  releasesleep(&ip->lock);
8010181b:	89 34 24             	mov    %esi,(%esp)
8010181e:	e8 1d 29 00 00       	call   80104140 <releasesleep>

  acquire(&icache.lock);
80101823:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
8010182a:	e8 11 2b 00 00       	call   80104340 <acquire>
  ip->ref--;
8010182f:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
}
80101833:	8b 5d f4             	mov    -0xc(%ebp),%ebx
  }
  releasesleep(&ip->lock);

  acquire(&icache.lock);
  ip->ref--;
  release(&icache.lock);
80101836:	c7 45 08 e0 09 11 80 	movl   $0x801109e0,0x8(%ebp)
}
8010183d:	8b 75 f8             	mov    -0x8(%ebp),%esi
80101840:	8b 7d fc             	mov    -0x4(%ebp),%edi
80101843:	89 ec                	mov    %ebp,%esp
80101845:	5d                   	pop    %ebp
  }
  releasesleep(&ip->lock);

  acquire(&icache.lock);
  ip->ref--;
  release(&icache.lock);
80101846:	e9 65 2b 00 00       	jmp    801043b0 <release>
8010184b:	90                   	nop
8010184c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
void
iput(struct inode *ip)
{
  acquiresleep(&ip->lock);
  if(ip->valid && ip->nlink == 0){
    acquire(&icache.lock);
80101850:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101857:	e8 e4 2a 00 00       	call   80104340 <acquire>
    int r = ip->ref;
8010185c:	8b 7b 08             	mov    0x8(%ebx),%edi
    release(&icache.lock);
8010185f:	c7 04 24 e0 09 11 80 	movl   $0x801109e0,(%esp)
80101866:	e8 45 2b 00 00       	call   801043b0 <release>
    if(r == 1){
8010186b:	83 ff 01             	cmp    $0x1,%edi
8010186e:	75 ab                	jne    8010181b <iput+0x2b>
{
  int i, j;
  struct buf *bp;
  uint *a;

  if(ip->type == T_SMALL){
80101870:	66 83 7b 50 04       	cmpw   $0x4,0x50(%ebx)
    for(i = 0; i <= NDIRECT; i++){
      ip->addrs[i] = 0;
    }

    ip->size = 0;
    iupdate(ip);
80101875:	89 df                	mov    %ebx,%edi
// If that was the last reference and the inode has no links
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
80101877:	8d 4b 30             	lea    0x30(%ebx),%ecx
{
  int i, j;
  struct buf *bp;
  uint *a;

  if(ip->type == T_SMALL){
8010187a:	74 64                	je     801018e0 <iput+0xf0>
8010187c:	89 75 e4             	mov    %esi,-0x1c(%ebp)
8010187f:	89 ce                	mov    %ecx,%esi
80101881:	eb 0c                	jmp    8010188f <iput+0x9f>
80101883:	90                   	nop
80101884:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }

  for(i = 0; i < NDIRECT; i++){
    if(ip->addrs[i]){
      bfree(ip->dev, ip->addrs[i]);
      ip->addrs[i] = 0;
80101888:	83 c7 04             	add    $0x4,%edi
    ip->size = 0;
    iupdate(ip);
    return;
  }

  for(i = 0; i < NDIRECT; i++){
8010188b:	39 f7                	cmp    %esi,%edi
8010188d:	74 19                	je     801018a8 <iput+0xb8>
    if(ip->addrs[i]){
8010188f:	8b 57 5c             	mov    0x5c(%edi),%edx
80101892:	85 d2                	test   %edx,%edx
80101894:	74 f2                	je     80101888 <iput+0x98>
      bfree(ip->dev, ip->addrs[i]);
80101896:	8b 03                	mov    (%ebx),%eax
80101898:	e8 43 fb ff ff       	call   801013e0 <bfree>
      ip->addrs[i] = 0;
8010189d:	c7 47 5c 00 00 00 00 	movl   $0x0,0x5c(%edi)
801018a4:	eb e2                	jmp    80101888 <iput+0x98>
801018a6:	66 90                	xchg   %ax,%ax
    }
  }

  if(ip->addrs[NDIRECT]){
801018a8:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
801018ae:	8b 75 e4             	mov    -0x1c(%ebp),%esi
801018b1:	85 c0                	test   %eax,%eax
801018b3:	75 45                	jne    801018fa <iput+0x10a>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
801018b5:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
801018bc:	89 1c 24             	mov    %ebx,(%esp)
801018bf:	e8 3c fd ff ff       	call   80101600 <iupdate>
    int r = ip->ref;
    release(&icache.lock);
    if(r == 1){
      // inode has no links and no other references: truncate and free.
      itrunc(ip);
      ip->type = 0;
801018c4:	66 c7 43 50 00 00    	movw   $0x0,0x50(%ebx)
      iupdate(ip);
801018ca:	89 1c 24             	mov    %ebx,(%esp)
801018cd:	e8 2e fd ff ff       	call   80101600 <iupdate>
      ip->valid = 0;
801018d2:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
801018d9:	e9 3d ff ff ff       	jmp    8010181b <iput+0x2b>
801018de:	66 90                	xchg   %ax,%ax
{
  int i, j;
  struct buf *bp;
  uint *a;

  if(ip->type == T_SMALL){
801018e0:	31 c0                	xor    %eax,%eax
801018e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    for(i = 0; i <= NDIRECT; i++){
      ip->addrs[i] = 0;
801018e8:	c7 44 83 5c 00 00 00 	movl   $0x0,0x5c(%ebx,%eax,4)
801018ef:	00 
  int i, j;
  struct buf *bp;
  uint *a;

  if(ip->type == T_SMALL){
    for(i = 0; i <= NDIRECT; i++){
801018f0:	83 c0 01             	add    $0x1,%eax
801018f3:	83 f8 0d             	cmp    $0xd,%eax
801018f6:	75 f0                	jne    801018e8 <iput+0xf8>
801018f8:	eb bb                	jmp    801018b5 <iput+0xc5>
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801018fa:	89 44 24 04          	mov    %eax,0x4(%esp)
801018fe:	8b 03                	mov    (%ebx),%eax
    a = (uint*)bp->data;
    for(j = 0; j < NINDIRECT; j++){
80101900:	31 ff                	xor    %edi,%edi
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101902:	89 04 24             	mov    %eax,(%esp)
80101905:	e8 c6 e7 ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    for(j = 0; j < NINDIRECT; j++){
8010190a:	89 75 e0             	mov    %esi,-0x20(%ebp)
8010190d:	89 de                	mov    %ebx,%esi
    }
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    a = (uint*)bp->data;
8010190f:	89 c1                	mov    %eax,%ecx
80101911:	83 c1 5c             	add    $0x5c,%ecx
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101914:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
    for(j = 0; j < NINDIRECT; j++){
80101917:	89 cb                	mov    %ecx,%ebx
80101919:	31 c0                	xor    %eax,%eax
8010191b:	eb 10                	jmp    8010192d <iput+0x13d>
8010191d:	8d 76 00             	lea    0x0(%esi),%esi
80101920:	83 c7 01             	add    $0x1,%edi
80101923:	81 ff 80 00 00 00    	cmp    $0x80,%edi
80101929:	89 f8                	mov    %edi,%eax
8010192b:	74 10                	je     8010193d <iput+0x14d>
      if(a[j])
8010192d:	8b 14 83             	mov    (%ebx,%eax,4),%edx
80101930:	85 d2                	test   %edx,%edx
80101932:	74 ec                	je     80101920 <iput+0x130>
        bfree(ip->dev, a[j]);
80101934:	8b 06                	mov    (%esi),%eax
80101936:	e8 a5 fa ff ff       	call   801013e0 <bfree>
8010193b:	eb e3                	jmp    80101920 <iput+0x130>
    }
    brelse(bp);
8010193d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101940:	89 f3                	mov    %esi,%ebx
80101942:	8b 75 e0             	mov    -0x20(%ebp),%esi
80101945:	89 04 24             	mov    %eax,(%esp)
80101948:	e8 93 e8 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
8010194d:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101953:	8b 03                	mov    (%ebx),%eax
80101955:	e8 86 fa ff ff       	call   801013e0 <bfree>
    ip->addrs[NDIRECT] = 0;
8010195a:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101961:	00 00 00 
80101964:	e9 4c ff ff ff       	jmp    801018b5 <iput+0xc5>
80101969:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101970 <iunlockput>:
}

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
80101970:	55                   	push   %ebp
80101971:	89 e5                	mov    %esp,%ebp
80101973:	53                   	push   %ebx
80101974:	83 ec 14             	sub    $0x14,%esp
80101977:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
8010197a:	89 1c 24             	mov    %ebx,(%esp)
8010197d:	e8 1e fe ff ff       	call   801017a0 <iunlock>
  iput(ip);
80101982:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80101985:	83 c4 14             	add    $0x14,%esp
80101988:	5b                   	pop    %ebx
80101989:	5d                   	pop    %ebp
// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
  iput(ip);
8010198a:	e9 61 fe ff ff       	jmp    801017f0 <iput>
8010198f:	90                   	nop

80101990 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101990:	55                   	push   %ebp
80101991:	89 e5                	mov    %esp,%ebp
80101993:	8b 55 08             	mov    0x8(%ebp),%edx
80101996:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101999:	8b 0a                	mov    (%edx),%ecx
8010199b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
8010199e:	8b 4a 04             	mov    0x4(%edx),%ecx
801019a1:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
801019a4:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
801019a8:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
801019ab:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
801019af:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
801019b3:	8b 52 58             	mov    0x58(%edx),%edx
801019b6:	89 50 10             	mov    %edx,0x10(%eax)
}
801019b9:	5d                   	pop    %ebp
801019ba:	c3                   	ret    
801019bb:	90                   	nop
801019bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801019c0 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
801019c0:	55                   	push   %ebp
801019c1:	89 e5                	mov    %esp,%ebp
801019c3:	57                   	push   %edi
801019c4:	56                   	push   %esi
801019c5:	53                   	push   %ebx
801019c6:	83 ec 2c             	sub    $0x2c,%esp
801019c9:	8b 75 08             	mov    0x8(%ebp),%esi
801019cc:	8b 45 0c             	mov    0xc(%ebp),%eax
801019cf:	8b 55 14             	mov    0x14(%ebp),%edx
801019d2:	8b 5d 10             	mov    0x10(%ebp),%ebx
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
801019d5:	0f b7 4e 50          	movzwl 0x50(%esi),%ecx
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
801019d9:	89 45 e0             	mov    %eax,-0x20(%ebp)
801019dc:	89 55 dc             	mov    %edx,-0x24(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
801019df:	66 83 f9 03          	cmp    $0x3,%cx
801019e3:	0f 84 e7 00 00 00    	je     80101ad0 <readi+0x110>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
801019e9:	8b 56 58             	mov    0x58(%esi),%edx
    return -1;
801019ec:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
801019f1:	39 da                	cmp    %ebx,%edx
801019f3:	0f 82 ca 00 00 00    	jb     80101ac3 <readi+0x103>
801019f9:	8b 7d dc             	mov    -0x24(%ebp),%edi
801019fc:	01 df                	add    %ebx,%edi
801019fe:	0f 82 bf 00 00 00    	jb     80101ac3 <readi+0x103>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101a04:	89 d0                	mov    %edx,%eax
80101a06:	29 d8                	sub    %ebx,%eax
80101a08:	39 fa                	cmp    %edi,%edx
80101a0a:	0f 43 45 dc          	cmovae -0x24(%ebp),%eax

  // Small Files
  if(ip->type == T_SMALL) {
80101a0e:	66 83 f9 04          	cmp    $0x4,%cx
  }

  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101a12:	89 45 dc             	mov    %eax,-0x24(%ebp)

  // Small Files
  if(ip->type == T_SMALL) {
80101a15:	0f 84 d7 00 00 00    	je     80101af2 <readi+0x132>
     memmove(dst, (void*)ip->addrs + off, n);
     return n;
  } 
    
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a1b:	85 c0                	test   %eax,%eax
80101a1d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101a24:	75 73                	jne    80101a99 <readi+0xd9>
80101a26:	e9 95 00 00 00       	jmp    80101ac0 <readi+0x100>
80101a2b:	90                   	nop
80101a2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
80101a30:	8d 7a 14             	lea    0x14(%edx),%edi
80101a33:	8b 44 be 0c          	mov    0xc(%esi,%edi,4),%eax
80101a37:	85 c0                	test   %eax,%eax
80101a39:	74 75                	je     80101ab0 <readi+0xf0>
     memmove(dst, (void*)ip->addrs + off, n);
     return n;
  } 
    
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a3b:	89 44 24 04          	mov    %eax,0x4(%esp)
80101a3f:	8b 06                	mov    (%esi),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101a41:	bf 00 02 00 00       	mov    $0x200,%edi
     memmove(dst, (void*)ip->addrs + off, n);
     return n;
  } 
    
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a46:	89 04 24             	mov    %eax,(%esp)
80101a49:	e8 82 e6 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101a4e:	8b 4d dc             	mov    -0x24(%ebp),%ecx
80101a51:	2b 4d e4             	sub    -0x1c(%ebp),%ecx
     memmove(dst, (void*)ip->addrs + off, n);
     return n;
  } 
    
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a54:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101a56:	89 d8                	mov    %ebx,%eax
80101a58:	25 ff 01 00 00       	and    $0x1ff,%eax
80101a5d:	29 c7                	sub    %eax,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80101a5f:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
     return n;
  } 
    
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101a63:	39 cf                	cmp    %ecx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80101a65:	89 44 24 04          	mov    %eax,0x4(%esp)
80101a69:	8b 45 e0             	mov    -0x20(%ebp),%eax
     return n;
  } 
    
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101a6c:	0f 47 f9             	cmova  %ecx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80101a6f:	89 55 d8             	mov    %edx,-0x28(%ebp)
  if(ip->type == T_SMALL) {
     memmove(dst, (void*)ip->addrs + off, n);
     return n;
  } 
    
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a72:	01 fb                	add    %edi,%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
80101a74:	89 7c 24 08          	mov    %edi,0x8(%esp)
80101a78:	89 04 24             	mov    %eax,(%esp)
80101a7b:	e8 40 2a 00 00       	call   801044c0 <memmove>
    brelse(bp);
80101a80:	8b 55 d8             	mov    -0x28(%ebp),%edx
80101a83:	89 14 24             	mov    %edx,(%esp)
80101a86:	e8 55 e7 ff ff       	call   801001e0 <brelse>
  if(ip->type == T_SMALL) {
     memmove(dst, (void*)ip->addrs + off, n);
     return n;
  } 
    
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a8b:	01 7d e4             	add    %edi,-0x1c(%ebp)
80101a8e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101a91:	01 7d e0             	add    %edi,-0x20(%ebp)
80101a94:	39 55 dc             	cmp    %edx,-0x24(%ebp)
80101a97:	76 27                	jbe    80101ac0 <readi+0x100>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101a99:	89 da                	mov    %ebx,%edx
80101a9b:	c1 ea 09             	shr    $0x9,%edx
bmap(struct inode *ip, uint bn)
{
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
80101a9e:	83 fa 0b             	cmp    $0xb,%edx
80101aa1:	76 8d                	jbe    80101a30 <readi+0x70>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
80101aa3:	89 f0                	mov    %esi,%eax
80101aa5:	e8 56 f8 ff ff       	call   80101300 <bmap.part.0>
80101aaa:	eb 8f                	jmp    80101a3b <readi+0x7b>
80101aac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101ab0:	8b 06                	mov    (%esi),%eax
80101ab2:	e8 29 f7 ff ff       	call   801011e0 <balloc>
80101ab7:	89 44 be 0c          	mov    %eax,0xc(%esi,%edi,4)
80101abb:	e9 7b ff ff ff       	jmp    80101a3b <readi+0x7b>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  } 
  return n;
80101ac0:	8b 45 dc             	mov    -0x24(%ebp),%eax
}
80101ac3:	83 c4 2c             	add    $0x2c,%esp
80101ac6:	5b                   	pop    %ebx
80101ac7:	5e                   	pop    %esi
80101ac8:	5f                   	pop    %edi
80101ac9:	5d                   	pop    %ebp
80101aca:	c3                   	ret    
80101acb:	90                   	nop
80101acc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101ad0:	0f b7 46 52          	movzwl 0x52(%esi),%eax
80101ad4:	66 83 f8 09          	cmp    $0x9,%ax
80101ad8:	77 37                	ja     80101b11 <readi+0x151>
80101ada:	98                   	cwtl   
80101adb:	8b 04 c5 60 09 11 80 	mov    -0x7feef6a0(,%eax,8),%eax
80101ae2:	85 c0                	test   %eax,%eax
80101ae4:	74 2b                	je     80101b11 <readi+0x151>
      return -1;
    return devsw[ip->major].read(ip, dst, n);
80101ae6:	89 55 10             	mov    %edx,0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  } 
  return n;
}
80101ae9:	83 c4 2c             	add    $0x2c,%esp
80101aec:	5b                   	pop    %ebx
80101aed:	5e                   	pop    %esi
80101aee:	5f                   	pop    %edi
80101aef:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
80101af0:	ff e0                	jmp    *%eax
  if(off + n > ip->size)
    n = ip->size - off;

  // Small Files
  if(ip->type == T_SMALL) {
     memmove(dst, (void*)ip->addrs + off, n);
80101af2:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101af5:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101af8:	89 44 24 08          	mov    %eax,0x8(%esp)
80101afc:	8d 44 1e 5c          	lea    0x5c(%esi,%ebx,1),%eax
80101b00:	89 44 24 04          	mov    %eax,0x4(%esp)
80101b04:	89 14 24             	mov    %edx,(%esp)
80101b07:	e8 b4 29 00 00       	call   801044c0 <memmove>
     return n;
80101b0c:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101b0f:	eb b2                	jmp    80101ac3 <readi+0x103>
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
80101b11:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101b16:	eb ab                	jmp    80101ac3 <readi+0x103>
80101b18:	90                   	nop
80101b19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101b20 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101b20:	55                   	push   %ebp
80101b21:	89 e5                	mov    %esp,%ebp
80101b23:	57                   	push   %edi
80101b24:	56                   	push   %esi
80101b25:	53                   	push   %ebx
80101b26:	83 ec 2c             	sub    $0x2c,%esp
80101b29:	8b 75 08             	mov    0x8(%ebp),%esi
80101b2c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101b2f:	8b 5d 10             	mov    0x10(%ebp),%ebx
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101b32:	0f b7 56 50          	movzwl 0x50(%esi),%edx
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101b36:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101b39:	8b 4d 14             	mov    0x14(%ebp),%ecx
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101b3c:	66 83 fa 03          	cmp    $0x3,%dx
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101b40:	89 4d dc             	mov    %ecx,-0x24(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101b43:	0f 84 47 01 00 00    	je     80101c90 <writei+0x170>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off){
80101b49:	39 5e 58             	cmp    %ebx,0x58(%esi)
    return -1;
80101b4c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off){
80101b51:	0f 82 0f 01 00 00    	jb     80101c66 <writei+0x146>
80101b57:	8b 4d dc             	mov    -0x24(%ebp),%ecx
80101b5a:	01 d9                	add    %ebx,%ecx
80101b5c:	0f 82 04 01 00 00    	jb     80101c66 <writei+0x146>
    return -1;
  }

  if(off + n > MAXFILE*BSIZE){
80101b62:	81 f9 00 18 01 00    	cmp    $0x11800,%ecx
80101b68:	0f 87 f8 00 00 00    	ja     80101c66 <writei+0x146>
    return -1;
  }

  if (ip->type == T_SMALL) {
80101b6e:	66 83 fa 04          	cmp    $0x4,%dx
80101b72:	0f 84 a8 00 00 00    	je     80101c20 <writei+0x100>
      iupdate(ip);
    }
    return n;
  } 

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b78:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101b7b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101b82:	85 c0                	test   %eax,%eax
80101b84:	0f 85 7e 00 00 00    	jne    80101c08 <writei+0xe8>
80101b8a:	e9 d4 00 00 00       	jmp    80101c63 <writei+0x143>
80101b8f:	90                   	nop
{
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
80101b90:	8d 7a 14             	lea    0x14(%edx),%edi
80101b93:	8b 44 be 0c          	mov    0xc(%esi,%edi,4),%eax
80101b97:	85 c0                	test   %eax,%eax
80101b99:	0f 84 d1 00 00 00    	je     80101c70 <writei+0x150>
    }
    return n;
  } 

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101b9f:	89 44 24 04          	mov    %eax,0x4(%esp)
80101ba3:	8b 06                	mov    (%esi),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101ba5:	bf 00 02 00 00       	mov    $0x200,%edi
    }
    return n;
  } 

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101baa:	89 04 24             	mov    %eax,(%esp)
80101bad:	e8 1e e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101bb2:	8b 4d dc             	mov    -0x24(%ebp),%ecx
80101bb5:	2b 4d e4             	sub    -0x1c(%ebp),%ecx
    }
    return n;
  } 

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101bb8:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101bba:	89 d8                	mov    %ebx,%eax
80101bbc:	25 ff 01 00 00       	and    $0x1ff,%eax
80101bc1:	29 c7                	sub    %eax,%edi
80101bc3:	39 cf                	cmp    %ecx,%edi
80101bc5:	0f 47 f9             	cmova  %ecx,%edi
    memmove(bp->data + off%BSIZE, src, m);
80101bc8:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101bcb:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
      iupdate(ip);
    }
    return n;
  } 

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101bcf:	01 fb                	add    %edi,%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(bp->data + off%BSIZE, src, m);
80101bd1:	89 55 d8             	mov    %edx,-0x28(%ebp)
80101bd4:	89 7c 24 08          	mov    %edi,0x8(%esp)
80101bd8:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80101bdc:	89 04 24             	mov    %eax,(%esp)
80101bdf:	e8 dc 28 00 00       	call   801044c0 <memmove>
    log_write(bp);
80101be4:	8b 55 d8             	mov    -0x28(%ebp),%edx
80101be7:	89 14 24             	mov    %edx,(%esp)
80101bea:	e8 e1 11 00 00       	call   80102dd0 <log_write>
    brelse(bp);
80101bef:	8b 55 d8             	mov    -0x28(%ebp),%edx
80101bf2:	89 14 24             	mov    %edx,(%esp)
80101bf5:	e8 e6 e5 ff ff       	call   801001e0 <brelse>
      iupdate(ip);
    }
    return n;
  } 

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101bfa:	01 7d e4             	add    %edi,-0x1c(%ebp)
80101bfd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101c00:	01 7d e0             	add    %edi,-0x20(%ebp)
80101c03:	39 4d dc             	cmp    %ecx,-0x24(%ebp)
80101c06:	76 78                	jbe    80101c80 <writei+0x160>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101c08:	89 da                	mov    %ebx,%edx
80101c0a:	c1 ea 09             	shr    $0x9,%edx
bmap(struct inode *ip, uint bn)
{
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
80101c0d:	83 fa 0b             	cmp    $0xb,%edx
80101c10:	0f 86 7a ff ff ff    	jbe    80101b90 <writei+0x70>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
80101c16:	89 f0                	mov    %esi,%eax
80101c18:	e8 e3 f6 ff ff       	call   80101300 <bmap.part.0>
80101c1d:	eb 80                	jmp    80101b9f <writei+0x7f>
80101c1f:	90                   	nop
  if(off + n > MAXFILE*BSIZE){
    return -1;
  }

  if (ip->type == T_SMALL) {
    if(off + n > (NDIRECT+1)*4){
80101c20:	83 f9 34             	cmp    $0x34,%ecx
80101c23:	76 0a                	jbe    80101c2f <writei+0x10f>
      n = (NDIRECT+1) * 4 - off;
80101c25:	c7 45 dc 34 00 00 00 	movl   $0x34,-0x24(%ebp)
80101c2c:	29 5d dc             	sub    %ebx,-0x24(%ebp)
     }
    
    memmove((void*)ip->addrs + off, src, n); 
80101c2f:	8b 4d dc             	mov    -0x24(%ebp),%ecx
80101c32:	8d 44 1e 5c          	lea    0x5c(%esi,%ebx,1),%eax
80101c36:	89 04 24             	mov    %eax,(%esp)
80101c39:	89 4c 24 08          	mov    %ecx,0x8(%esp)
80101c3d:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101c40:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80101c44:	e8 77 28 00 00       	call   801044c0 <memmove>
    if(n > 0 && ip->size < (off + n)) {
80101c49:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101c4c:	85 c0                	test   %eax,%eax
80101c4e:	74 13                	je     80101c63 <writei+0x143>
80101c50:	03 5d dc             	add    -0x24(%ebp),%ebx
80101c53:	39 5e 58             	cmp    %ebx,0x58(%esi)
80101c56:	73 0b                	jae    80101c63 <writei+0x143>
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
    ip->size = off;
80101c58:	89 5e 58             	mov    %ebx,0x58(%esi)
    iupdate(ip);
80101c5b:	89 34 24             	mov    %esi,(%esp)
80101c5e:	e8 9d f9 ff ff       	call   80101600 <iupdate>
  }
  return n;
80101c63:	8b 45 dc             	mov    -0x24(%ebp),%eax
}
80101c66:	83 c4 2c             	add    $0x2c,%esp
80101c69:	5b                   	pop    %ebx
80101c6a:	5e                   	pop    %esi
80101c6b:	5f                   	pop    %edi
80101c6c:	5d                   	pop    %ebp
80101c6d:	c3                   	ret    
80101c6e:	66 90                	xchg   %ax,%ax
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
80101c70:	8b 06                	mov    (%esi),%eax
80101c72:	e8 69 f5 ff ff       	call   801011e0 <balloc>
80101c77:	89 44 be 0c          	mov    %eax,0xc(%esi,%edi,4)
80101c7b:	e9 1f ff ff ff       	jmp    80101b9f <writei+0x7f>
    memmove(bp->data + off%BSIZE, src, m);
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
80101c80:	39 5e 58             	cmp    %ebx,0x58(%esi)
80101c83:	72 d3                	jb     80101c58 <writei+0x138>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101c85:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101c88:	eb dc                	jmp    80101c66 <writei+0x146>
80101c8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101c90:	0f b7 46 52          	movzwl 0x52(%esi),%eax
80101c94:	66 83 f8 09          	cmp    $0x9,%ax
80101c98:	77 18                	ja     80101cb2 <writei+0x192>
80101c9a:	98                   	cwtl   
80101c9b:	8b 04 c5 64 09 11 80 	mov    -0x7feef69c(,%eax,8),%eax
80101ca2:	85 c0                	test   %eax,%eax
80101ca4:	74 0c                	je     80101cb2 <writei+0x192>
      return -1;
    return devsw[ip->major].write(ip, src, n);
80101ca6:	89 4d 10             	mov    %ecx,0x10(%ebp)
  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
}
80101ca9:	83 c4 2c             	add    $0x2c,%esp
80101cac:	5b                   	pop    %ebx
80101cad:	5e                   	pop    %esi
80101cae:	5f                   	pop    %edi
80101caf:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
80101cb0:	ff e0                	jmp    *%eax
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
80101cb2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101cb7:	eb ad                	jmp    80101c66 <writei+0x146>
80101cb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101cc0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101cc0:	55                   	push   %ebp
80101cc1:	89 e5                	mov    %esp,%ebp
80101cc3:	83 ec 18             	sub    $0x18,%esp
  return strncmp(s, t, DIRSIZ);
80101cc6:	8b 45 0c             	mov    0xc(%ebp),%eax
80101cc9:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80101cd0:	00 
80101cd1:	89 44 24 04          	mov    %eax,0x4(%esp)
80101cd5:	8b 45 08             	mov    0x8(%ebp),%eax
80101cd8:	89 04 24             	mov    %eax,(%esp)
80101cdb:	e8 60 28 00 00       	call   80104540 <strncmp>
}
80101ce0:	c9                   	leave  
80101ce1:	c3                   	ret    
80101ce2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101ce9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101cf0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101cf0:	55                   	push   %ebp
80101cf1:	89 e5                	mov    %esp,%ebp
80101cf3:	57                   	push   %edi
80101cf4:	56                   	push   %esi
80101cf5:	53                   	push   %ebx
80101cf6:	83 ec 2c             	sub    $0x2c,%esp
80101cf9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR && dp->type != T_SFDIR){
80101cfc:	0f b7 43 50          	movzwl 0x50(%ebx),%eax
80101d00:	66 83 f8 05          	cmp    $0x5,%ax
80101d04:	0f 85 8c 00 00 00    	jne    80101d96 <dirlookup+0xa6>
    panic("dirlookup not DIR");
  }

  for(off = 0; off < dp->size; off += sizeof(de)){
80101d0a:	8b 43 58             	mov    0x58(%ebx),%eax
80101d0d:	31 f6                	xor    %esi,%esi
80101d0f:	8d 7d d8             	lea    -0x28(%ebp),%edi
80101d12:	85 c0                	test   %eax,%eax
80101d14:	75 0a                	jne    80101d20 <dirlookup+0x30>
80101d16:	eb 68                	jmp    80101d80 <dirlookup+0x90>
80101d18:	83 c6 10             	add    $0x10,%esi
80101d1b:	39 73 58             	cmp    %esi,0x58(%ebx)
80101d1e:	76 60                	jbe    80101d80 <dirlookup+0x90>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101d20:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80101d27:	00 
80101d28:	89 74 24 08          	mov    %esi,0x8(%esp)
80101d2c:	89 7c 24 04          	mov    %edi,0x4(%esp)
80101d30:	89 1c 24             	mov    %ebx,(%esp)
80101d33:	e8 88 fc ff ff       	call   801019c0 <readi>
80101d38:	83 f8 10             	cmp    $0x10,%eax
80101d3b:	75 4d                	jne    80101d8a <dirlookup+0x9a>
      panic("dirlookup read");
    if(de.inum == 0)
80101d3d:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101d42:	74 d4                	je     80101d18 <dirlookup+0x28>
      continue;
    if(namecmp(name, de.name) == 0){
80101d44:	8d 45 da             	lea    -0x26(%ebp),%eax
80101d47:	89 44 24 04          	mov    %eax,0x4(%esp)
80101d4b:	8b 45 0c             	mov    0xc(%ebp),%eax
80101d4e:	89 04 24             	mov    %eax,(%esp)
80101d51:	e8 6a ff ff ff       	call   80101cc0 <namecmp>
80101d56:	85 c0                	test   %eax,%eax
80101d58:	75 be                	jne    80101d18 <dirlookup+0x28>
      // entry matches path element
      if(poff)
80101d5a:	8b 45 10             	mov    0x10(%ebp),%eax
80101d5d:	85 c0                	test   %eax,%eax
80101d5f:	74 05                	je     80101d66 <dirlookup+0x76>
        *poff = off;
80101d61:	8b 45 10             	mov    0x10(%ebp),%eax
80101d64:	89 30                	mov    %esi,(%eax)
      inum = de.inum;
80101d66:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101d6a:	8b 03                	mov    (%ebx),%eax
80101d6c:	e8 af f3 ff ff       	call   80101120 <iget>
    }
  }

  return 0;
}
80101d71:	83 c4 2c             	add    $0x2c,%esp
80101d74:	5b                   	pop    %ebx
80101d75:	5e                   	pop    %esi
80101d76:	5f                   	pop    %edi
80101d77:	5d                   	pop    %ebp
80101d78:	c3                   	ret    
80101d79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101d80:	83 c4 2c             	add    $0x2c,%esp
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
80101d83:	31 c0                	xor    %eax,%eax
}
80101d85:	5b                   	pop    %ebx
80101d86:	5e                   	pop    %esi
80101d87:	5f                   	pop    %edi
80101d88:	5d                   	pop    %ebp
80101d89:	c3                   	ret    
    panic("dirlookup not DIR");
  }

  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlookup read");
80101d8a:	c7 04 24 f9 6f 10 80 	movl   $0x80106ff9,(%esp)
80101d91:	e8 da e5 ff ff       	call   80100370 <panic>
dirlookup(struct inode *dp, char *name, uint *poff)
{
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR && dp->type != T_SFDIR){
80101d96:	66 83 f8 01          	cmp    $0x1,%ax
80101d9a:	0f 84 6a ff ff ff    	je     80101d0a <dirlookup+0x1a>
    panic("dirlookup not DIR");
80101da0:	c7 04 24 e7 6f 10 80 	movl   $0x80106fe7,(%esp)
80101da7:	e8 c4 e5 ff ff       	call   80100370 <panic>
80101dac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101db0 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101db0:	55                   	push   %ebp
80101db1:	89 e5                	mov    %esp,%ebp
80101db3:	57                   	push   %edi
80101db4:	56                   	push   %esi
80101db5:	53                   	push   %ebx
80101db6:	89 c3                	mov    %eax,%ebx
80101db8:	83 ec 2c             	sub    $0x2c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101dbb:	80 38 2f             	cmpb   $0x2f,(%eax)
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101dbe:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101dc1:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  struct inode *ip, *next;

  if(*path == '/')
80101dc4:	0f 84 1d 01 00 00    	je     80101ee7 <namex+0x137>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101dca:	e8 21 1a 00 00       	call   801037f0 <myproc>
80101dcf:	8b 40 68             	mov    0x68(%eax),%eax
80101dd2:	89 04 24             	mov    %eax,(%esp)
80101dd5:	e8 b6 f8 ff ff       	call   80101690 <idup>
80101dda:	89 c7                	mov    %eax,%edi
80101ddc:	eb 05                	jmp    80101de3 <namex+0x33>
80101dde:	66 90                	xchg   %ax,%ax
{
  char *s;
  int len;

  while(*path == '/')
    path++;
80101de0:	83 c3 01             	add    $0x1,%ebx
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
80101de3:	0f b6 03             	movzbl (%ebx),%eax
80101de6:	3c 2f                	cmp    $0x2f,%al
80101de8:	74 f6                	je     80101de0 <namex+0x30>
    path++;
  if(*path == 0)
80101dea:	84 c0                	test   %al,%al
80101dec:	75 1a                	jne    80101e08 <namex+0x58>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101dee:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101df1:	85 c0                	test   %eax,%eax
80101df3:	0f 85 45 01 00 00    	jne    80101f3e <namex+0x18e>
    iput(ip);
    return 0;
  }
  return ip;
}
80101df9:	83 c4 2c             	add    $0x2c,%esp
80101dfc:	89 f8                	mov    %edi,%eax
80101dfe:	5b                   	pop    %ebx
80101dff:	5e                   	pop    %esi
80101e00:	5f                   	pop    %edi
80101e01:	5d                   	pop    %ebp
80101e02:	c3                   	ret    
80101e03:	90                   	nop
80101e04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101e08:	0f b6 03             	movzbl (%ebx),%eax
80101e0b:	89 de                	mov    %ebx,%esi
80101e0d:	84 c0                	test   %al,%al
80101e0f:	0f 84 a5 00 00 00    	je     80101eba <namex+0x10a>
80101e15:	3c 2f                	cmp    $0x2f,%al
80101e17:	75 0b                	jne    80101e24 <namex+0x74>
80101e19:	e9 9c 00 00 00       	jmp    80101eba <namex+0x10a>
80101e1e:	66 90                	xchg   %ax,%ax
80101e20:	3c 2f                	cmp    $0x2f,%al
80101e22:	74 0a                	je     80101e2e <namex+0x7e>
    path++;
80101e24:	83 c6 01             	add    $0x1,%esi
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101e27:	0f b6 06             	movzbl (%esi),%eax
80101e2a:	84 c0                	test   %al,%al
80101e2c:	75 f2                	jne    80101e20 <namex+0x70>
80101e2e:	89 f2                	mov    %esi,%edx
80101e30:	29 da                	sub    %ebx,%edx
    path++;
  len = path - s;
  if(len >= DIRSIZ)
80101e32:	83 fa 0d             	cmp    $0xd,%edx
80101e35:	0f 8e 85 00 00 00    	jle    80101ec0 <namex+0x110>
    memmove(name, s, DIRSIZ);
80101e3b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101e3e:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
80101e42:	89 f3                	mov    %esi,%ebx
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
80101e44:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80101e4b:	00 
80101e4c:	89 04 24             	mov    %eax,(%esp)
80101e4f:	e8 6c 26 00 00       	call   801044c0 <memmove>
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101e54:	80 3e 2f             	cmpb   $0x2f,(%esi)
80101e57:	75 0f                	jne    80101e68 <namex+0xb8>
80101e59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101e60:	83 c3 01             	add    $0x1,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101e63:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101e66:	74 f8                	je     80101e60 <namex+0xb0>
  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);

  while((path = skipelem(path, name)) != 0){
80101e68:	85 db                	test   %ebx,%ebx
80101e6a:	74 82                	je     80101dee <namex+0x3e>
    ilock(ip);
80101e6c:	89 3c 24             	mov    %edi,(%esp)
80101e6f:	e8 4c f8 ff ff       	call   801016c0 <ilock>
    if(ip->type != T_DIR && ip->type != T_SFDIR){
80101e74:	0f b7 47 50          	movzwl 0x50(%edi),%eax
80101e78:	66 83 f8 05          	cmp    $0x5,%ax
80101e7c:	75 7f                	jne    80101efd <namex+0x14d>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101e7e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101e81:	85 c0                	test   %eax,%eax
80101e83:	74 09                	je     80101e8e <namex+0xde>
80101e85:	80 3b 00             	cmpb   $0x0,(%ebx)
80101e88:	0f 84 9e 00 00 00    	je     80101f2c <namex+0x17c>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101e8e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101e91:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80101e98:	00 
80101e99:	89 3c 24             	mov    %edi,(%esp)
80101e9c:	89 44 24 04          	mov    %eax,0x4(%esp)
80101ea0:	e8 4b fe ff ff       	call   80101cf0 <dirlookup>
      iunlockput(ip);
80101ea5:	89 3c 24             	mov    %edi,(%esp)
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101ea8:	85 c0                	test   %eax,%eax
80101eaa:	89 c6                	mov    %eax,%esi
80101eac:	74 6d                	je     80101f1b <namex+0x16b>
      iunlockput(ip);
      return 0;
    }
    iunlockput(ip);
80101eae:	e8 bd fa ff ff       	call   80101970 <iunlockput>
    ip = next;
80101eb3:	89 f7                	mov    %esi,%edi
80101eb5:	e9 29 ff ff ff       	jmp    80101de3 <namex+0x33>
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101eba:	31 d2                	xor    %edx,%edx
80101ebc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
80101ec0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101ec3:	89 54 24 08          	mov    %edx,0x8(%esp)
80101ec7:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    name[len] = 0;
80101ecb:	89 f3                	mov    %esi,%ebx
    path++;
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
80101ecd:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101ed0:	89 04 24             	mov    %eax,(%esp)
80101ed3:	e8 e8 25 00 00       	call   801044c0 <memmove>
    name[len] = 0;
80101ed8:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101edb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101ede:	c6 04 10 00          	movb   $0x0,(%eax,%edx,1)
80101ee2:	e9 6d ff ff ff       	jmp    80101e54 <namex+0xa4>
namex(char *path, int nameiparent, char *name)
{
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
80101ee7:	ba 01 00 00 00       	mov    $0x1,%edx
80101eec:	b8 01 00 00 00       	mov    $0x1,%eax
80101ef1:	e8 2a f2 ff ff       	call   80101120 <iget>
80101ef6:	89 c7                	mov    %eax,%edi
80101ef8:	e9 e6 fe ff ff       	jmp    80101de3 <namex+0x33>
  else
    ip = idup(myproc()->cwd);

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
    if(ip->type != T_DIR && ip->type != T_SFDIR){
80101efd:	66 83 f8 01          	cmp    $0x1,%ax
80101f01:	0f 84 77 ff ff ff    	je     80101e7e <namex+0xce>
      iunlockput(ip);
80101f07:	89 3c 24             	mov    %edi,(%esp)
      return 0;
80101f0a:	31 ff                	xor    %edi,%edi
    ip = idup(myproc()->cwd);

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
    if(ip->type != T_DIR && ip->type != T_SFDIR){
      iunlockput(ip);
80101f0c:	e8 5f fa ff ff       	call   80101970 <iunlockput>
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101f11:	83 c4 2c             	add    $0x2c,%esp
80101f14:	89 f8                	mov    %edi,%eax
80101f16:	5b                   	pop    %ebx
80101f17:	5e                   	pop    %esi
80101f18:	5f                   	pop    %edi
80101f19:	5d                   	pop    %ebp
80101f1a:	c3                   	ret    
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
80101f1b:	e8 50 fa ff ff       	call   80101970 <iunlockput>
      return 0;
80101f20:	31 ff                	xor    %edi,%edi
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101f22:	83 c4 2c             	add    $0x2c,%esp
80101f25:	5b                   	pop    %ebx
80101f26:	89 f8                	mov    %edi,%eax
80101f28:	5e                   	pop    %esi
80101f29:	5f                   	pop    %edi
80101f2a:	5d                   	pop    %ebp
80101f2b:	c3                   	ret    
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
80101f2c:	89 3c 24             	mov    %edi,(%esp)
80101f2f:	e8 6c f8 ff ff       	call   801017a0 <iunlock>
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101f34:	83 c4 2c             	add    $0x2c,%esp
80101f37:	89 f8                	mov    %edi,%eax
80101f39:	5b                   	pop    %ebx
80101f3a:	5e                   	pop    %esi
80101f3b:	5f                   	pop    %edi
80101f3c:	5d                   	pop    %ebp
80101f3d:	c3                   	ret    
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
    iput(ip);
80101f3e:	89 3c 24             	mov    %edi,(%esp)
    return 0;
80101f41:	31 ff                	xor    %edi,%edi
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
    iput(ip);
80101f43:	e8 a8 f8 ff ff       	call   801017f0 <iput>
    return 0;
80101f48:	e9 ac fe ff ff       	jmp    80101df9 <namex+0x49>
80101f4d:	8d 76 00             	lea    0x0(%esi),%esi

80101f50 <dirlink>:
}

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
80101f50:	55                   	push   %ebp
80101f51:	89 e5                	mov    %esp,%ebp
80101f53:	57                   	push   %edi
80101f54:	56                   	push   %esi
80101f55:	53                   	push   %ebx
80101f56:	83 ec 2c             	sub    $0x2c,%esp
80101f59:	8b 75 08             	mov    0x8(%ebp),%esi
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
80101f5c:	8b 45 0c             	mov    0xc(%ebp),%eax
80101f5f:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80101f66:	00 
80101f67:	89 34 24             	mov    %esi,(%esp)
80101f6a:	89 44 24 04          	mov    %eax,0x4(%esp)
80101f6e:	e8 7d fd ff ff       	call   80101cf0 <dirlookup>
80101f73:	85 c0                	test   %eax,%eax
80101f75:	0f 85 89 00 00 00    	jne    80102004 <dirlink+0xb4>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
80101f7b:	8b 56 58             	mov    0x58(%esi),%edx
80101f7e:	31 db                	xor    %ebx,%ebx
80101f80:	8d 7d d8             	lea    -0x28(%ebp),%edi
80101f83:	85 d2                	test   %edx,%edx
80101f85:	75 11                	jne    80101f98 <dirlink+0x48>
80101f87:	eb 33                	jmp    80101fbc <dirlink+0x6c>
80101f89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101f90:	83 c3 10             	add    $0x10,%ebx
80101f93:	39 5e 58             	cmp    %ebx,0x58(%esi)
80101f96:	76 24                	jbe    80101fbc <dirlink+0x6c>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f98:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80101f9f:	00 
80101fa0:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80101fa4:	89 7c 24 04          	mov    %edi,0x4(%esp)
80101fa8:	89 34 24             	mov    %esi,(%esp)
80101fab:	e8 10 fa ff ff       	call   801019c0 <readi>
80101fb0:	83 f8 10             	cmp    $0x10,%eax
80101fb3:	75 5e                	jne    80102013 <dirlink+0xc3>
      panic("dirlink read");
    if(de.inum == 0)
80101fb5:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101fba:	75 d4                	jne    80101f90 <dirlink+0x40>
      break;
  }

  strncpy(de.name, name, DIRSIZ);
80101fbc:	8b 45 0c             	mov    0xc(%ebp),%eax
80101fbf:	c7 44 24 08 0e 00 00 	movl   $0xe,0x8(%esp)
80101fc6:	00 
80101fc7:	89 44 24 04          	mov    %eax,0x4(%esp)
80101fcb:	8d 45 da             	lea    -0x26(%ebp),%eax
80101fce:	89 04 24             	mov    %eax,(%esp)
80101fd1:	e8 ca 25 00 00       	call   801045a0 <strncpy>
  de.inum = inum;
80101fd6:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101fd9:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80101fe0:	00 
80101fe1:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80101fe5:	89 7c 24 04          	mov    %edi,0x4(%esp)
    if(de.inum == 0)
      break;
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
80101fe9:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101fed:	89 34 24             	mov    %esi,(%esp)
80101ff0:	e8 2b fb ff ff       	call   80101b20 <writei>
80101ff5:	83 f8 10             	cmp    $0x10,%eax
80101ff8:	75 25                	jne    8010201f <dirlink+0xcf>
    panic("dirlink");

  return 0;
80101ffa:	31 c0                	xor    %eax,%eax
}
80101ffc:	83 c4 2c             	add    $0x2c,%esp
80101fff:	5b                   	pop    %ebx
80102000:	5e                   	pop    %esi
80102001:	5f                   	pop    %edi
80102002:	5d                   	pop    %ebp
80102003:	c3                   	ret    
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    iput(ip);
80102004:	89 04 24             	mov    %eax,(%esp)
80102007:	e8 e4 f7 ff ff       	call   801017f0 <iput>
    return -1;
8010200c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102011:	eb e9                	jmp    80101ffc <dirlink+0xac>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
80102013:	c7 04 24 08 70 10 80 	movl   $0x80107008,(%esp)
8010201a:	e8 51 e3 ff ff       	call   80100370 <panic>
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("dirlink");
8010201f:	c7 04 24 e2 75 10 80 	movl   $0x801075e2,(%esp)
80102026:	e8 45 e3 ff ff       	call   80100370 <panic>
8010202b:	90                   	nop
8010202c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102030 <namei>:
  return ip;
}

struct inode*
namei(char *path)
{
80102030:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102031:	31 d2                	xor    %edx,%edx
  return ip;
}

struct inode*
namei(char *path)
{
80102033:	89 e5                	mov    %esp,%ebp
80102035:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102038:	8b 45 08             	mov    0x8(%ebp),%eax
8010203b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
8010203e:	e8 6d fd ff ff       	call   80101db0 <namex>
}
80102043:	c9                   	leave  
80102044:	c3                   	ret    
80102045:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102049:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102050 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102050:	55                   	push   %ebp
  return namex(path, 1, name);
80102051:	ba 01 00 00 00       	mov    $0x1,%edx
  return namex(path, 0, name);
}

struct inode*
nameiparent(char *path, char *name)
{
80102056:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80102058:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010205b:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010205e:	5d                   	pop    %ebp
}

struct inode*
nameiparent(char *path, char *name)
{
  return namex(path, 1, name);
8010205f:	e9 4c fd ff ff       	jmp    80101db0 <namex>
	...

80102070 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102070:	55                   	push   %ebp
80102071:	89 e5                	mov    %esp,%ebp
80102073:	56                   	push   %esi
80102074:	89 c6                	mov    %eax,%esi
80102076:	53                   	push   %ebx
80102077:	83 ec 10             	sub    $0x10,%esp
  if(b == 0)
8010207a:	85 c0                	test   %eax,%eax
8010207c:	0f 84 99 00 00 00    	je     8010211b <idestart+0xab>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80102082:	8b 48 08             	mov    0x8(%eax),%ecx
80102085:	81 f9 e7 03 00 00    	cmp    $0x3e7,%ecx
8010208b:	0f 87 7e 00 00 00    	ja     8010210f <idestart+0x9f>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102091:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102096:	66 90                	xchg   %ax,%ax
80102098:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102099:	25 c0 00 00 00       	and    $0xc0,%eax
8010209e:	83 f8 40             	cmp    $0x40,%eax
801020a1:	75 f5                	jne    80102098 <idestart+0x28>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801020a3:	31 db                	xor    %ebx,%ebx
801020a5:	ba f6 03 00 00       	mov    $0x3f6,%edx
801020aa:	89 d8                	mov    %ebx,%eax
801020ac:	ee                   	out    %al,(%dx)
801020ad:	ba f2 01 00 00       	mov    $0x1f2,%edx
801020b2:	b8 01 00 00 00       	mov    $0x1,%eax
801020b7:	ee                   	out    %al,(%dx)
801020b8:	b2 f3                	mov    $0xf3,%dl
801020ba:	89 c8                	mov    %ecx,%eax
801020bc:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
801020bd:	89 c8                	mov    %ecx,%eax
801020bf:	b2 f4                	mov    $0xf4,%dl
801020c1:	c1 f8 08             	sar    $0x8,%eax
801020c4:	ee                   	out    %al,(%dx)
801020c5:	b2 f5                	mov    $0xf5,%dl
801020c7:	89 d8                	mov    %ebx,%eax
801020c9:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
801020ca:	8b 46 04             	mov    0x4(%esi),%eax
801020cd:	b2 f6                	mov    $0xf6,%dl
801020cf:	83 e0 01             	and    $0x1,%eax
801020d2:	c1 e0 04             	shl    $0x4,%eax
801020d5:	83 c8 e0             	or     $0xffffffe0,%eax
801020d8:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
801020d9:	f6 06 04             	testb  $0x4,(%esi)
801020dc:	75 12                	jne    801020f0 <idestart+0x80>
801020de:	ba f7 01 00 00       	mov    $0x1f7,%edx
801020e3:	b8 20 00 00 00       	mov    $0x20,%eax
801020e8:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
801020e9:	83 c4 10             	add    $0x10,%esp
801020ec:	5b                   	pop    %ebx
801020ed:	5e                   	pop    %esi
801020ee:	5d                   	pop    %ebp
801020ef:	c3                   	ret    
801020f0:	b2 f7                	mov    $0xf7,%dl
801020f2:	b8 30 00 00 00       	mov    $0x30,%eax
801020f7:	ee                   	out    %al,(%dx)
}

static inline void
outsl(int port, const void *addr, int cnt)
{
  asm volatile("cld; rep outsl" :
801020f8:	b9 80 00 00 00       	mov    $0x80,%ecx
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
801020fd:	83 c6 5c             	add    $0x5c,%esi
80102100:	ba f0 01 00 00       	mov    $0x1f0,%edx
80102105:	fc                   	cld    
80102106:	f3 6f                	rep outsl %ds:(%esi),(%dx)
  } else {
    outb(0x1f7, read_cmd);
  }
}
80102108:	83 c4 10             	add    $0x10,%esp
8010210b:	5b                   	pop    %ebx
8010210c:	5e                   	pop    %esi
8010210d:	5d                   	pop    %ebp
8010210e:	c3                   	ret    
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
  if(b->blockno >= FSSIZE)
    panic("incorrect blockno");
8010210f:	c7 04 24 74 70 10 80 	movl   $0x80107074,(%esp)
80102116:	e8 55 e2 ff ff       	call   80100370 <panic>
// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
8010211b:	c7 04 24 6b 70 10 80 	movl   $0x8010706b,(%esp)
80102122:	e8 49 e2 ff ff       	call   80100370 <panic>
80102127:	89 f6                	mov    %esi,%esi
80102129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102130 <ideinit>:
  return 0;
}

void
ideinit(void)
{
80102130:	55                   	push   %ebp
80102131:	89 e5                	mov    %esp,%ebp
80102133:	83 ec 18             	sub    $0x18,%esp
  int i;

  initlock(&idelock, "ide");
80102136:	c7 44 24 04 86 70 10 	movl   $0x80107086,0x4(%esp)
8010213d:	80 
8010213e:	c7 04 24 60 a5 10 80 	movl   $0x8010a560,(%esp)
80102145:	e8 86 20 00 00       	call   801041d0 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
8010214a:	a1 00 2d 11 80       	mov    0x80112d00,%eax
8010214f:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
80102156:	83 e8 01             	sub    $0x1,%eax
80102159:	89 44 24 04          	mov    %eax,0x4(%esp)
8010215d:	e8 5e 02 00 00       	call   801023c0 <ioapicenable>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102162:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102167:	90                   	nop
80102168:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102169:	25 c0 00 00 00       	and    $0xc0,%eax
8010216e:	83 f8 40             	cmp    $0x40,%eax
80102171:	75 f5                	jne    80102168 <ideinit+0x38>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102173:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102178:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010217d:	ee                   	out    %al,(%dx)
8010217e:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102183:	b2 f7                	mov    $0xf7,%dl
80102185:	eb 06                	jmp    8010218d <ideinit+0x5d>
80102187:	90                   	nop
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);

  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
80102188:	83 e9 01             	sub    $0x1,%ecx
8010218b:	74 0f                	je     8010219c <ideinit+0x6c>
8010218d:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
8010218e:	84 c0                	test   %al,%al
80102190:	74 f6                	je     80102188 <ideinit+0x58>
      havedisk1 = 1;
80102192:	c7 05 94 a5 10 80 01 	movl   $0x1,0x8010a594
80102199:	00 00 00 
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010219c:	ba f6 01 00 00       	mov    $0x1f6,%edx
801021a1:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
801021a6:	ee                   	out    %al,(%dx)
    }
  }

  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
}
801021a7:	c9                   	leave  
801021a8:	c3                   	ret    
801021a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801021b0 <ideintr>:
}

// Interrupt handler.
void
ideintr(void)
{
801021b0:	55                   	push   %ebp
801021b1:	89 e5                	mov    %esp,%ebp
801021b3:	57                   	push   %edi
801021b4:	53                   	push   %ebx
801021b5:	83 ec 10             	sub    $0x10,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
801021b8:	c7 04 24 60 a5 10 80 	movl   $0x8010a560,(%esp)
801021bf:	e8 7c 21 00 00       	call   80104340 <acquire>

  if((b = idequeue) == 0){
801021c4:	8b 1d 98 a5 10 80    	mov    0x8010a598,%ebx
801021ca:	85 db                	test   %ebx,%ebx
801021cc:	74 2d                	je     801021fb <ideintr+0x4b>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
801021ce:	8b 43 58             	mov    0x58(%ebx),%eax
801021d1:	a3 98 a5 10 80       	mov    %eax,0x8010a598

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801021d6:	8b 0b                	mov    (%ebx),%ecx
801021d8:	f6 c1 04             	test   $0x4,%cl
801021db:	74 33                	je     80102210 <ideintr+0x60>
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
801021dd:	83 c9 02             	or     $0x2,%ecx
  b->flags &= ~B_DIRTY;
801021e0:	83 e1 fb             	and    $0xfffffffb,%ecx
801021e3:	89 0b                	mov    %ecx,(%ebx)
  wakeup(b);
801021e5:	89 1c 24             	mov    %ebx,(%esp)
801021e8:	e8 03 1d 00 00       	call   80103ef0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801021ed:	a1 98 a5 10 80       	mov    0x8010a598,%eax
801021f2:	85 c0                	test   %eax,%eax
801021f4:	74 05                	je     801021fb <ideintr+0x4b>
    idestart(idequeue);
801021f6:	e8 75 fe ff ff       	call   80102070 <idestart>

  release(&idelock);
801021fb:	c7 04 24 60 a5 10 80 	movl   $0x8010a560,(%esp)
80102202:	e8 a9 21 00 00       	call   801043b0 <release>
}
80102207:	83 c4 10             	add    $0x10,%esp
8010220a:	5b                   	pop    %ebx
8010220b:	5f                   	pop    %edi
8010220c:	5d                   	pop    %ebp
8010220d:	c3                   	ret    
8010220e:	66 90                	xchg   %ax,%ax
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102210:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102215:	8d 76 00             	lea    0x0(%esi),%esi
80102218:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102219:	0f b6 c0             	movzbl %al,%eax
8010221c:	89 c7                	mov    %eax,%edi
8010221e:	81 e7 c0 00 00 00    	and    $0xc0,%edi
80102224:	83 ff 40             	cmp    $0x40,%edi
80102227:	75 ef                	jne    80102218 <ideintr+0x68>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
80102229:	a8 21                	test   $0x21,%al
8010222b:	75 b0                	jne    801021dd <ideintr+0x2d>
  }
  idequeue = b->qnext;

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, BSIZE/4);
8010222d:	8d 7b 5c             	lea    0x5c(%ebx),%edi
}

static inline void
insl(int port, void *addr, int cnt)
{
  asm volatile("cld; rep insl" :
80102230:	b9 80 00 00 00       	mov    $0x80,%ecx
80102235:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010223a:	fc                   	cld    
8010223b:	f3 6d                	rep insl (%dx),%es:(%edi)
8010223d:	8b 0b                	mov    (%ebx),%ecx
8010223f:	eb 9c                	jmp    801021dd <ideintr+0x2d>
80102241:	eb 0d                	jmp    80102250 <iderw>
80102243:	90                   	nop
80102244:	90                   	nop
80102245:	90                   	nop
80102246:	90                   	nop
80102247:	90                   	nop
80102248:	90                   	nop
80102249:	90                   	nop
8010224a:	90                   	nop
8010224b:	90                   	nop
8010224c:	90                   	nop
8010224d:	90                   	nop
8010224e:	90                   	nop
8010224f:	90                   	nop

80102250 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102250:	55                   	push   %ebp
80102251:	89 e5                	mov    %esp,%ebp
80102253:	53                   	push   %ebx
80102254:	83 ec 14             	sub    $0x14,%esp
80102257:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010225a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010225d:	89 04 24             	mov    %eax,(%esp)
80102260:	e8 1b 1f 00 00       	call   80104180 <holdingsleep>
80102265:	85 c0                	test   %eax,%eax
80102267:	0f 84 8f 00 00 00    	je     801022fc <iderw+0xac>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010226d:	8b 03                	mov    (%ebx),%eax
8010226f:	83 e0 06             	and    $0x6,%eax
80102272:	83 f8 02             	cmp    $0x2,%eax
80102275:	0f 84 99 00 00 00    	je     80102314 <iderw+0xc4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010227b:	8b 53 04             	mov    0x4(%ebx),%edx
8010227e:	85 d2                	test   %edx,%edx
80102280:	74 09                	je     8010228b <iderw+0x3b>
80102282:	a1 94 a5 10 80       	mov    0x8010a594,%eax
80102287:	85 c0                	test   %eax,%eax
80102289:	74 7d                	je     80102308 <iderw+0xb8>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
8010228b:	c7 04 24 60 a5 10 80 	movl   $0x8010a560,(%esp)
80102292:	e8 a9 20 00 00       	call   80104340 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102297:	a1 98 a5 10 80       	mov    0x8010a598,%eax
8010229c:	ba 98 a5 10 80       	mov    $0x8010a598,%edx
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
801022a1:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801022a8:	85 c0                	test   %eax,%eax
801022aa:	74 0e                	je     801022ba <iderw+0x6a>
801022ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801022b0:	8d 50 58             	lea    0x58(%eax),%edx
801022b3:	8b 40 58             	mov    0x58(%eax),%eax
801022b6:	85 c0                	test   %eax,%eax
801022b8:	75 f6                	jne    801022b0 <iderw+0x60>
    ;
  *pp = b;
801022ba:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
801022bc:	39 1d 98 a5 10 80    	cmp    %ebx,0x8010a598
801022c2:	75 14                	jne    801022d8 <iderw+0x88>
801022c4:	eb 2d                	jmp    801022f3 <iderw+0xa3>
801022c6:	66 90                	xchg   %ax,%ax
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
    sleep(b, &idelock);
801022c8:	c7 44 24 04 60 a5 10 	movl   $0x8010a560,0x4(%esp)
801022cf:	80 
801022d0:	89 1c 24             	mov    %ebx,(%esp)
801022d3:	e8 78 1a 00 00       	call   80103d50 <sleep>
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801022d8:	8b 03                	mov    (%ebx),%eax
801022da:	83 e0 06             	and    $0x6,%eax
801022dd:	83 f8 02             	cmp    $0x2,%eax
801022e0:	75 e6                	jne    801022c8 <iderw+0x78>
    sleep(b, &idelock);
  }


  release(&idelock);
801022e2:	c7 45 08 60 a5 10 80 	movl   $0x8010a560,0x8(%ebp)
}
801022e9:	83 c4 14             	add    $0x14,%esp
801022ec:	5b                   	pop    %ebx
801022ed:	5d                   	pop    %ebp
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
    sleep(b, &idelock);
  }


  release(&idelock);
801022ee:	e9 bd 20 00 00       	jmp    801043b0 <release>
    ;
  *pp = b;

  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);
801022f3:	89 d8                	mov    %ebx,%eax
801022f5:	e8 76 fd ff ff       	call   80102070 <idestart>
801022fa:	eb dc                	jmp    801022d8 <iderw+0x88>
iderw(struct buf *b)
{
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
801022fc:	c7 04 24 8a 70 10 80 	movl   $0x8010708a,(%esp)
80102303:	e8 68 e0 ff ff       	call   80100370 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
    panic("iderw: ide disk 1 not present");
80102308:	c7 04 24 b5 70 10 80 	movl   $0x801070b5,(%esp)
8010230f:	e8 5c e0 ff ff       	call   80100370 <panic>
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
80102314:	c7 04 24 a0 70 10 80 	movl   $0x801070a0,(%esp)
8010231b:	e8 50 e0 ff ff       	call   80100370 <panic>

80102320 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102320:	55                   	push   %ebp
80102321:	89 e5                	mov    %esp,%ebp
80102323:	56                   	push   %esi
80102324:	53                   	push   %ebx

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
  return ioapic->data;
80102325:	bb 00 00 c0 fe       	mov    $0xfec00000,%ebx
  ioapic->data = data;
}

void
ioapicinit(void)
{
8010232a:	83 ec 10             	sub    $0x10,%esp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010232d:	0f b6 15 60 27 11 80 	movzbl 0x80112760,%edx
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
80102334:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
8010233b:	00 00 00 
  return ioapic->data;
8010233e:	8b 35 10 00 c0 fe    	mov    0xfec00010,%esi
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
80102344:	c7 05 00 00 c0 fe 00 	movl   $0x0,0xfec00000
8010234b:	00 00 00 
  return ioapic->data;
8010234e:	a1 10 00 c0 fe       	mov    0xfec00010,%eax
void
ioapicinit(void)
{
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102353:	c7 05 34 26 11 80 00 	movl   $0xfec00000,0x80112634
8010235a:	00 c0 fe 
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
8010235d:	c1 ee 10             	shr    $0x10,%esi
  id = ioapicread(REG_ID) >> 24;
80102360:	c1 e8 18             	shr    $0x18,%eax
ioapicinit(void)
{
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102363:	81 e6 ff 00 00 00    	and    $0xff,%esi
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
80102369:	39 c2                	cmp    %eax,%edx
8010236b:	74 12                	je     8010237f <ioapicinit+0x5f>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
8010236d:	c7 04 24 d4 70 10 80 	movl   $0x801070d4,(%esp)
80102374:	e8 d7 e2 ff ff       	call   80100650 <cprintf>
80102379:	8b 1d 34 26 11 80    	mov    0x80112634,%ebx
  ioapic->data = data;
}

void
ioapicinit(void)
{
8010237f:	ba 10 00 00 00       	mov    $0x10,%edx
80102384:	31 c0                	xor    %eax,%eax
80102386:	66 90                	xchg   %ax,%ax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102388:	89 13                	mov    %edx,(%ebx)
  ioapic->data = data;
8010238a:	8b 1d 34 26 11 80    	mov    0x80112634,%ebx
}

void
ioapicinit(void)
80102390:	8d 48 20             	lea    0x20(%eax),%ecx
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102393:	81 c9 00 00 01 00    	or     $0x10000,%ecx
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80102399:	83 c0 01             	add    $0x1,%eax

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
8010239c:	89 4b 10             	mov    %ecx,0x10(%ebx)
}

void
ioapicinit(void)
8010239f:	8d 4a 01             	lea    0x1(%edx),%ecx
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
801023a2:	83 c2 02             	add    $0x2,%edx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801023a5:	89 0b                	mov    %ecx,(%ebx)
  ioapic->data = data;
801023a7:	8b 1d 34 26 11 80    	mov    0x80112634,%ebx
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
801023ad:	39 c6                	cmp    %eax,%esi

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
801023af:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
801023b6:	7d d0                	jge    80102388 <ioapicinit+0x68>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
801023b8:	83 c4 10             	add    $0x10,%esp
801023bb:	5b                   	pop    %ebx
801023bc:	5e                   	pop    %esi
801023bd:	5d                   	pop    %ebp
801023be:	c3                   	ret    
801023bf:	90                   	nop

801023c0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801023c0:	55                   	push   %ebp
801023c1:	89 e5                	mov    %esp,%ebp
801023c3:	8b 55 08             	mov    0x8(%ebp),%edx
801023c6:	53                   	push   %ebx
801023c7:	8b 45 0c             	mov    0xc(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801023ca:	8d 5a 20             	lea    0x20(%edx),%ebx
801023cd:	8d 4c 12 10          	lea    0x10(%edx,%edx,1),%ecx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801023d1:	8b 15 34 26 11 80    	mov    0x80112634,%edx
{
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801023d7:	c1 e0 18             	shl    $0x18,%eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801023da:	89 0a                	mov    %ecx,(%edx)
  ioapic->data = data;
801023dc:	8b 15 34 26 11 80    	mov    0x80112634,%edx
{
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801023e2:	83 c1 01             	add    $0x1,%ecx

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
801023e5:	89 5a 10             	mov    %ebx,0x10(%edx)
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801023e8:	89 0a                	mov    %ecx,(%edx)
  ioapic->data = data;
801023ea:	8b 15 34 26 11 80    	mov    0x80112634,%edx
801023f0:	89 42 10             	mov    %eax,0x10(%edx)
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
}
801023f3:	5b                   	pop    %ebx
801023f4:	5d                   	pop    %ebp
801023f5:	c3                   	ret    
	...

80102400 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102400:	55                   	push   %ebp
80102401:	89 e5                	mov    %esp,%ebp
80102403:	53                   	push   %ebx
80102404:	83 ec 14             	sub    $0x14,%esp
80102407:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010240a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102410:	75 7c                	jne    8010248e <kfree+0x8e>
80102412:	81 fb a8 54 11 80    	cmp    $0x801154a8,%ebx
80102418:	72 74                	jb     8010248e <kfree+0x8e>
8010241a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102420:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102425:	77 67                	ja     8010248e <kfree+0x8e>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102427:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
8010242e:	00 
8010242f:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
80102436:	00 
80102437:	89 1c 24             	mov    %ebx,(%esp)
8010243a:	e8 c1 1f 00 00       	call   80104400 <memset>

  if(kmem.use_lock)
8010243f:	8b 15 74 26 11 80    	mov    0x80112674,%edx
80102445:	85 d2                	test   %edx,%edx
80102447:	75 37                	jne    80102480 <kfree+0x80>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102449:	a1 78 26 11 80       	mov    0x80112678,%eax
8010244e:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
80102450:	a1 74 26 11 80       	mov    0x80112674,%eax

  if(kmem.use_lock)
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
80102455:	89 1d 78 26 11 80    	mov    %ebx,0x80112678
  if(kmem.use_lock)
8010245b:	85 c0                	test   %eax,%eax
8010245d:	75 09                	jne    80102468 <kfree+0x68>
    release(&kmem.lock);
}
8010245f:	83 c4 14             	add    $0x14,%esp
80102462:	5b                   	pop    %ebx
80102463:	5d                   	pop    %ebp
80102464:	c3                   	ret    
80102465:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
80102468:	c7 45 08 40 26 11 80 	movl   $0x80112640,0x8(%ebp)
}
8010246f:	83 c4 14             	add    $0x14,%esp
80102472:	5b                   	pop    %ebx
80102473:	5d                   	pop    %ebp
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
80102474:	e9 37 1f 00 00       	jmp    801043b0 <release>
80102479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);

  if(kmem.use_lock)
    acquire(&kmem.lock);
80102480:	c7 04 24 40 26 11 80 	movl   $0x80112640,(%esp)
80102487:	e8 b4 1e 00 00       	call   80104340 <acquire>
8010248c:	eb bb                	jmp    80102449 <kfree+0x49>
kfree(char *v)
{
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
    panic("kfree");
8010248e:	c7 04 24 06 71 10 80 	movl   $0x80107106,(%esp)
80102495:	e8 d6 de ff ff       	call   80100370 <panic>
8010249a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801024a0 <freerange>:
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
801024a0:	55                   	push   %ebp
801024a1:	89 e5                	mov    %esp,%ebp
801024a3:	56                   	push   %esi
801024a4:	53                   	push   %ebx
801024a5:	83 ec 10             	sub    $0x10,%esp
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801024a8:	8b 55 08             	mov    0x8(%ebp),%edx
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
801024ab:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801024ae:	81 c2 ff 0f 00 00    	add    $0xfff,%edx
801024b4:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024ba:	8d 9a 00 10 00 00    	lea    0x1000(%edx),%ebx
801024c0:	39 de                	cmp    %ebx,%esi
801024c2:	73 08                	jae    801024cc <freerange+0x2c>
801024c4:	eb 18                	jmp    801024de <freerange+0x3e>
801024c6:	66 90                	xchg   %ax,%ax
801024c8:	89 da                	mov    %ebx,%edx
801024ca:	89 c3                	mov    %eax,%ebx
    kfree(p);
801024cc:	89 14 24             	mov    %edx,(%esp)
801024cf:	e8 2c ff ff ff       	call   80102400 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024d4:	8d 83 00 10 00 00    	lea    0x1000(%ebx),%eax
801024da:	39 f0                	cmp    %esi,%eax
801024dc:	76 ea                	jbe    801024c8 <freerange+0x28>
    kfree(p);
}
801024de:	83 c4 10             	add    $0x10,%esp
801024e1:	5b                   	pop    %ebx
801024e2:	5e                   	pop    %esi
801024e3:	5d                   	pop    %ebp
801024e4:	c3                   	ret    
801024e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801024e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801024f0 <kinit2>:
  freerange(vstart, vend);
}

void
kinit2(void *vstart, void *vend)
{
801024f0:	55                   	push   %ebp
801024f1:	89 e5                	mov    %esp,%ebp
801024f3:	83 ec 18             	sub    $0x18,%esp
  freerange(vstart, vend);
801024f6:	8b 45 0c             	mov    0xc(%ebp),%eax
801024f9:	89 44 24 04          	mov    %eax,0x4(%esp)
801024fd:	8b 45 08             	mov    0x8(%ebp),%eax
80102500:	89 04 24             	mov    %eax,(%esp)
80102503:	e8 98 ff ff ff       	call   801024a0 <freerange>
  kmem.use_lock = 1;
80102508:	c7 05 74 26 11 80 01 	movl   $0x1,0x80112674
8010250f:	00 00 00 
}
80102512:	c9                   	leave  
80102513:	c3                   	ret    
80102514:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010251a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80102520 <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
80102520:	55                   	push   %ebp
80102521:	89 e5                	mov    %esp,%ebp
80102523:	83 ec 18             	sub    $0x18,%esp
80102526:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80102529:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010252c:	89 75 fc             	mov    %esi,-0x4(%ebp)
8010252f:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102532:	c7 44 24 04 0c 71 10 	movl   $0x8010710c,0x4(%esp)
80102539:	80 
8010253a:	c7 04 24 40 26 11 80 	movl   $0x80112640,(%esp)
80102541:	e8 8a 1c 00 00       	call   801041d0 <initlock>
  kmem.use_lock = 0;
  freerange(vstart, vend);
80102546:	89 75 0c             	mov    %esi,0xc(%ebp)
}
80102549:	8b 75 fc             	mov    -0x4(%ebp),%esi
void
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
  freerange(vstart, vend);
8010254c:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010254f:	8b 5d f8             	mov    -0x8(%ebp),%ebx
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
80102552:	c7 05 74 26 11 80 00 	movl   $0x0,0x80112674
80102559:	00 00 00 
  freerange(vstart, vend);
}
8010255c:	89 ec                	mov    %ebp,%esp
8010255e:	5d                   	pop    %ebp
void
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
  freerange(vstart, vend);
8010255f:	e9 3c ff ff ff       	jmp    801024a0 <freerange>
80102564:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010256a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80102570 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102570:	55                   	push   %ebp
  struct run *r;

  if(kmem.use_lock)
80102571:	31 c0                	xor    %eax,%eax
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102573:	89 e5                	mov    %esp,%ebp
80102575:	53                   	push   %ebx
80102576:	83 ec 14             	sub    $0x14,%esp
  struct run *r;

  if(kmem.use_lock)
80102579:	8b 0d 74 26 11 80    	mov    0x80112674,%ecx
8010257f:	85 c9                	test   %ecx,%ecx
80102581:	75 2d                	jne    801025b0 <kalloc+0x40>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102583:	8b 1d 78 26 11 80    	mov    0x80112678,%ebx
  if(r)
80102589:	85 db                	test   %ebx,%ebx
8010258b:	74 08                	je     80102595 <kalloc+0x25>
    kmem.freelist = r->next;
8010258d:	8b 13                	mov    (%ebx),%edx
8010258f:	89 15 78 26 11 80    	mov    %edx,0x80112678
  if(kmem.use_lock)
80102595:	85 c0                	test   %eax,%eax
80102597:	74 0c                	je     801025a5 <kalloc+0x35>
    release(&kmem.lock);
80102599:	c7 04 24 40 26 11 80 	movl   $0x80112640,(%esp)
801025a0:	e8 0b 1e 00 00       	call   801043b0 <release>
  return (char*)r;
}
801025a5:	83 c4 14             	add    $0x14,%esp
801025a8:	89 d8                	mov    %ebx,%eax
801025aa:	5b                   	pop    %ebx
801025ab:	5d                   	pop    %ebp
801025ac:	c3                   	ret    
801025ad:	8d 76 00             	lea    0x0(%esi),%esi
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
    acquire(&kmem.lock);
801025b0:	c7 04 24 40 26 11 80 	movl   $0x80112640,(%esp)
801025b7:	e8 84 1d 00 00       	call   80104340 <acquire>
801025bc:	a1 74 26 11 80       	mov    0x80112674,%eax
801025c1:	eb c0                	jmp    80102583 <kalloc+0x13>
	...

801025d0 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
801025d0:	55                   	push   %ebp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801025d1:	ba 64 00 00 00       	mov    $0x64,%edx
801025d6:	89 e5                	mov    %esp,%ebp
801025d8:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
801025d9:	a8 01                	test   $0x1,%al
    return -1;
801025db:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
801025e0:	74 3e                	je     80102620 <kbdgetc+0x50>
801025e2:	b2 60                	mov    $0x60,%dl
801025e4:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
801025e5:	0f b6 c0             	movzbl %al,%eax

  if(data == 0xE0){
801025e8:	3d e0 00 00 00       	cmp    $0xe0,%eax
801025ed:	0f 84 85 00 00 00    	je     80102678 <kbdgetc+0xa8>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
801025f3:	a8 80                	test   $0x80,%al
801025f5:	74 31                	je     80102628 <kbdgetc+0x58>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
801025f7:	8b 15 9c a5 10 80    	mov    0x8010a59c,%edx
801025fd:	89 c1                	mov    %eax,%ecx
801025ff:	83 e1 7f             	and    $0x7f,%ecx
80102602:	f6 c2 40             	test   $0x40,%dl
80102605:	0f 44 c1             	cmove  %ecx,%eax
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
80102608:	31 c9                	xor    %ecx,%ecx
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
8010260a:	0f b6 80 20 71 10 80 	movzbl -0x7fef8ee0(%eax),%eax
80102611:	83 c8 40             	or     $0x40,%eax
80102614:	0f b6 c0             	movzbl %al,%eax
80102617:	f7 d0                	not    %eax
80102619:	21 d0                	and    %edx,%eax
8010261b:	a3 9c a5 10 80       	mov    %eax,0x8010a59c
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102620:	89 c8                	mov    %ecx,%eax
80102622:	5d                   	pop    %ebp
80102623:	c3                   	ret    
80102624:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102628:	8b 0d 9c a5 10 80    	mov    0x8010a59c,%ecx
8010262e:	f6 c1 40             	test   $0x40,%cl
80102631:	74 05                	je     80102638 <kbdgetc+0x68>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102633:	0c 80                	or     $0x80,%al
    shift &= ~E0ESC;
80102635:	83 e1 bf             	and    $0xffffffbf,%ecx
  }

  shift |= shiftcode[data];
80102638:	0f b6 90 20 71 10 80 	movzbl -0x7fef8ee0(%eax),%edx
8010263f:	09 ca                	or     %ecx,%edx
  shift ^= togglecode[data];
80102641:	0f b6 88 20 72 10 80 	movzbl -0x7fef8de0(%eax),%ecx
80102648:	31 ca                	xor    %ecx,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
8010264a:	89 d1                	mov    %edx,%ecx
8010264c:	83 e1 03             	and    $0x3,%ecx
8010264f:	8b 0c 8d 20 73 10 80 	mov    -0x7fef8ce0(,%ecx,4),%ecx
    data |= 0x80;
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
80102656:	89 15 9c a5 10 80    	mov    %edx,0x8010a59c
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
8010265c:	83 e2 08             	and    $0x8,%edx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
8010265f:	0f b6 0c 01          	movzbl (%ecx,%eax,1),%ecx
  if(shift & CAPSLOCK){
80102663:	74 bb                	je     80102620 <kbdgetc+0x50>
    if('a' <= c && c <= 'z')
80102665:	8d 41 9f             	lea    -0x61(%ecx),%eax
80102668:	83 f8 19             	cmp    $0x19,%eax
8010266b:	77 1b                	ja     80102688 <kbdgetc+0xb8>
      c += 'A' - 'a';
8010266d:	83 e9 20             	sub    $0x20,%ecx
80102670:	eb ae                	jmp    80102620 <kbdgetc+0x50>
80102672:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
80102678:	31 c9                	xor    %ecx,%ecx
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
8010267a:	89 c8                	mov    %ecx,%eax
  if((st & KBS_DIB) == 0)
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
8010267c:	83 0d 9c a5 10 80 40 	orl    $0x40,0x8010a59c
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102683:	5d                   	pop    %ebp
80102684:	c3                   	ret    
80102685:	8d 76 00             	lea    0x0(%esi),%esi
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
80102688:	8d 51 bf             	lea    -0x41(%ecx),%edx
      c += 'a' - 'A';
8010268b:	8d 41 20             	lea    0x20(%ecx),%eax
8010268e:	83 fa 19             	cmp    $0x19,%edx
80102691:	0f 46 c8             	cmovbe %eax,%ecx
  }
  return c;
80102694:	eb 8a                	jmp    80102620 <kbdgetc+0x50>
80102696:	8d 76 00             	lea    0x0(%esi),%esi
80102699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801026a0 <kbdintr>:
}

void
kbdintr(void)
{
801026a0:	55                   	push   %ebp
801026a1:	89 e5                	mov    %esp,%ebp
801026a3:	83 ec 18             	sub    $0x18,%esp
  consoleintr(kbdgetc);
801026a6:	c7 04 24 d0 25 10 80 	movl   $0x801025d0,(%esp)
801026ad:	e8 0e e1 ff ff       	call   801007c0 <consoleintr>
}
801026b2:	c9                   	leave  
801026b3:	c3                   	ret    
	...

801026c0 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
801026c0:	a1 7c 26 11 80       	mov    0x8011267c,%eax
  lapic[ID];  // wait for write to finish, by reading
}

void
lapicinit(void)
{
801026c5:	55                   	push   %ebp
801026c6:	89 e5                	mov    %esp,%ebp
  if(!lapic)
801026c8:	85 c0                	test   %eax,%eax
801026ca:	0f 84 c0 00 00 00    	je     80102790 <lapicinit+0xd0>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026d0:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
801026d7:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026da:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026dd:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
801026e4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026e7:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026ea:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
801026f1:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
801026f4:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026f7:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
801026fe:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102701:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102704:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
8010270b:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010270e:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102711:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102718:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010271b:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010271e:	8b 50 30             	mov    0x30(%eax),%edx
80102721:	c1 ea 10             	shr    $0x10,%edx
80102724:	80 fa 03             	cmp    $0x3,%dl
80102727:	77 6f                	ja     80102798 <lapicinit+0xd8>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102729:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102730:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102733:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102736:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010273d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102740:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102743:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010274a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010274d:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102750:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102757:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010275a:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010275d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102764:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102767:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010276a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102771:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102774:	8b 50 20             	mov    0x20(%eax),%edx
80102777:	90                   	nop
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102778:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
8010277e:	80 e6 10             	and    $0x10,%dh
80102781:	75 f5                	jne    80102778 <lapicinit+0xb8>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102783:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
8010278a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010278d:	8b 40 20             	mov    0x20(%eax),%eax
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102790:	5d                   	pop    %ebp
80102791:	c3                   	ret    
80102792:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102798:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
8010279f:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801027a2:	8b 50 20             	mov    0x20(%eax),%edx
801027a5:	eb 82                	jmp    80102729 <lapicinit+0x69>
801027a7:	89 f6                	mov    %esi,%esi
801027a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801027b0 <lapicid>:
}

int
lapicid(void)
{
  if (!lapic)
801027b0:	8b 15 7c 26 11 80    	mov    0x8011267c,%edx
    return 0;
801027b6:	31 c0                	xor    %eax,%eax
  lapicw(TPR, 0);
}

int
lapicid(void)
{
801027b8:	55                   	push   %ebp
801027b9:	89 e5                	mov    %esp,%ebp
  if (!lapic)
801027bb:	85 d2                	test   %edx,%edx
801027bd:	74 06                	je     801027c5 <lapicid+0x15>
    return 0;
  return lapic[ID] >> 24;
801027bf:	8b 42 20             	mov    0x20(%edx),%eax
801027c2:	c1 e8 18             	shr    $0x18,%eax
}
801027c5:	5d                   	pop    %ebp
801027c6:	c3                   	ret    
801027c7:	89 f6                	mov    %esi,%esi
801027c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801027d0 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
801027d0:	a1 7c 26 11 80       	mov    0x8011267c,%eax
}

// Acknowledge interrupt.
void
lapiceoi(void)
{
801027d5:	55                   	push   %ebp
801027d6:	89 e5                	mov    %esp,%ebp
  if(lapic)
801027d8:	85 c0                	test   %eax,%eax
801027da:	74 0d                	je     801027e9 <lapiceoi+0x19>

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027dc:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801027e3:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027e6:	8b 40 20             	mov    0x20(%eax),%eax
void
lapiceoi(void)
{
  if(lapic)
    lapicw(EOI, 0);
}
801027e9:	5d                   	pop    %ebp
801027ea:	c3                   	ret    
801027eb:	90                   	nop
801027ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801027f0 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
801027f0:	55                   	push   %ebp
801027f1:	89 e5                	mov    %esp,%ebp
}
801027f3:	5d                   	pop    %ebp
801027f4:	c3                   	ret    
801027f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801027f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102800 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102800:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102801:	ba 70 00 00 00       	mov    $0x70,%edx
80102806:	89 e5                	mov    %esp,%ebp
80102808:	b8 0f 00 00 00       	mov    $0xf,%eax
8010280d:	53                   	push   %ebx
8010280e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102811:	0f b6 5d 08          	movzbl 0x8(%ebp),%ebx
80102815:	ee                   	out    %al,(%dx)
80102816:	b8 0a 00 00 00       	mov    $0xa,%eax
8010281b:	b2 71                	mov    $0x71,%dl
8010281d:	ee                   	out    %al,(%dx)
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
8010281e:	89 c8                	mov    %ecx,%eax
80102820:	c1 e8 04             	shr    $0x4,%eax
80102823:	66 a3 69 04 00 80    	mov    %ax,0x80000469

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102829:	a1 7c 26 11 80       	mov    0x8011267c,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
8010282e:	c1 e9 0c             	shr    $0xc,%ecx
  wrv[0] = 0;
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102831:	c1 e3 18             	shl    $0x18,%ebx
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102834:	80 cd 06             	or     $0x6,%ch
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102837:	66 c7 05 67 04 00 80 	movw   $0x0,0x80000467
8010283e:	00 00 

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102840:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102846:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102849:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102850:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102853:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102856:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
8010285d:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102860:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102863:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102869:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010286c:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102872:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102875:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010287b:	8b 50 20             	mov    0x20(%eax),%edx

//PAGEBREAK!
static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010287e:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102884:	8b 40 20             	mov    0x20(%eax),%eax
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
80102887:	5b                   	pop    %ebx
80102888:	5d                   	pop    %ebp
80102889:	c3                   	ret    
8010288a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102890 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102890:	55                   	push   %ebp
80102891:	ba 70 00 00 00       	mov    $0x70,%edx
80102896:	89 e5                	mov    %esp,%ebp
80102898:	b8 0b 00 00 00       	mov    $0xb,%eax
8010289d:	57                   	push   %edi
8010289e:	56                   	push   %esi
8010289f:	53                   	push   %ebx
801028a0:	83 ec 6c             	sub    $0x6c,%esp
801028a3:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028a4:	b2 71                	mov    $0x71,%dl
801028a6:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
801028a7:	89 c2                	mov    %eax,%edx
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028a9:	bb 70 00 00 00       	mov    $0x70,%ebx
801028ae:	83 e2 04             	and    $0x4,%edx
801028b1:	89 55 a4             	mov    %edx,-0x5c(%ebp)
801028b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801028b8:	31 c0                	xor    %eax,%eax
801028ba:	89 da                	mov    %ebx,%edx
801028bc:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028bd:	b9 71 00 00 00       	mov    $0x71,%ecx
801028c2:	89 ca                	mov    %ecx,%edx
801028c4:	ec                   	in     (%dx),%al
cmos_read(uint reg)
{
  outb(CMOS_PORT,  reg);
  microdelay(200);

  return inb(CMOS_RETURN);
801028c5:	0f b6 f0             	movzbl %al,%esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028c8:	89 da                	mov    %ebx,%edx
801028ca:	b8 02 00 00 00       	mov    $0x2,%eax
801028cf:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028d0:	89 ca                	mov    %ecx,%edx
801028d2:	ec                   	in     (%dx),%al
801028d3:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028d6:	89 da                	mov    %ebx,%edx
801028d8:	89 45 b4             	mov    %eax,-0x4c(%ebp)
801028db:	b8 04 00 00 00       	mov    $0x4,%eax
801028e0:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028e1:	89 ca                	mov    %ecx,%edx
801028e3:	ec                   	in     (%dx),%al
801028e4:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028e7:	89 da                	mov    %ebx,%edx
801028e9:	89 45 b0             	mov    %eax,-0x50(%ebp)
801028ec:	b8 07 00 00 00       	mov    $0x7,%eax
801028f1:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028f2:	89 ca                	mov    %ecx,%edx
801028f4:	ec                   	in     (%dx),%al
801028f5:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028f8:	89 da                	mov    %ebx,%edx
801028fa:	89 45 ac             	mov    %eax,-0x54(%ebp)
801028fd:	b8 08 00 00 00       	mov    $0x8,%eax
80102902:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102903:	89 ca                	mov    %ecx,%edx
80102905:	ec                   	in     (%dx),%al
80102906:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102909:	89 da                	mov    %ebx,%edx
8010290b:	89 45 a8             	mov    %eax,-0x58(%ebp)
8010290e:	b8 09 00 00 00       	mov    $0x9,%eax
80102913:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102914:	89 ca                	mov    %ecx,%edx
80102916:	ec                   	in     (%dx),%al
80102917:	0f b6 f8             	movzbl %al,%edi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010291a:	89 da                	mov    %ebx,%edx
8010291c:	b8 0a 00 00 00       	mov    $0xa,%eax
80102921:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102922:	89 ca                	mov    %ecx,%edx
80102924:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102925:	a8 80                	test   $0x80,%al
80102927:	75 8f                	jne    801028b8 <cmostime+0x28>
80102929:	8b 45 b4             	mov    -0x4c(%ebp),%eax
8010292c:	8b 55 b0             	mov    -0x50(%ebp),%edx
8010292f:	89 75 b8             	mov    %esi,-0x48(%ebp)
80102932:	89 7d cc             	mov    %edi,-0x34(%ebp)
80102935:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102938:	8b 45 ac             	mov    -0x54(%ebp),%eax
8010293b:	89 55 c0             	mov    %edx,-0x40(%ebp)
8010293e:	8b 55 a8             	mov    -0x58(%ebp),%edx
80102941:	89 45 c4             	mov    %eax,-0x3c(%ebp)
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102944:	31 c0                	xor    %eax,%eax
80102946:	89 55 c8             	mov    %edx,-0x38(%ebp)
80102949:	89 da                	mov    %ebx,%edx
8010294b:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010294c:	89 ca                	mov    %ecx,%edx
8010294e:	ec                   	in     (%dx),%al
cmos_read(uint reg)
{
  outb(CMOS_PORT,  reg);
  microdelay(200);

  return inb(CMOS_RETURN);
8010294f:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102952:	89 da                	mov    %ebx,%edx
80102954:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102957:	b8 02 00 00 00       	mov    $0x2,%eax
8010295c:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010295d:	89 ca                	mov    %ecx,%edx
8010295f:	ec                   	in     (%dx),%al
80102960:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102963:	89 da                	mov    %ebx,%edx
80102965:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102968:	b8 04 00 00 00       	mov    $0x4,%eax
8010296d:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010296e:	89 ca                	mov    %ecx,%edx
80102970:	ec                   	in     (%dx),%al
80102971:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102974:	89 da                	mov    %ebx,%edx
80102976:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102979:	b8 07 00 00 00       	mov    $0x7,%eax
8010297e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010297f:	89 ca                	mov    %ecx,%edx
80102981:	ec                   	in     (%dx),%al
80102982:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102985:	89 da                	mov    %ebx,%edx
80102987:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010298a:	b8 08 00 00 00       	mov    $0x8,%eax
8010298f:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102990:	89 ca                	mov    %ecx,%edx
80102992:	ec                   	in     (%dx),%al
80102993:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102996:	89 da                	mov    %ebx,%edx
80102998:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010299b:	b8 09 00 00 00       	mov    $0x9,%eax
801029a0:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029a1:	89 ca                	mov    %ecx,%edx
801029a3:	ec                   	in     (%dx),%al
801029a4:	0f b6 c8             	movzbl %al,%ecx
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801029a7:	8d 55 b8             	lea    -0x48(%ebp),%edx
801029aa:	8d 45 d0             	lea    -0x30(%ebp),%eax
cmos_read(uint reg)
{
  outb(CMOS_PORT,  reg);
  microdelay(200);

  return inb(CMOS_RETURN);
801029ad:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801029b0:	c7 44 24 08 18 00 00 	movl   $0x18,0x8(%esp)
801029b7:	00 
801029b8:	89 44 24 04          	mov    %eax,0x4(%esp)
801029bc:	89 14 24             	mov    %edx,(%esp)
801029bf:	e8 9c 1a 00 00       	call   80104460 <memcmp>
801029c4:	85 c0                	test   %eax,%eax
801029c6:	0f 85 ec fe ff ff    	jne    801028b8 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
801029cc:	8b 45 a4             	mov    -0x5c(%ebp),%eax
801029cf:	85 c0                	test   %eax,%eax
801029d1:	75 78                	jne    80102a4b <cmostime+0x1bb>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
801029d3:	8b 45 b8             	mov    -0x48(%ebp),%eax
801029d6:	89 c2                	mov    %eax,%edx
801029d8:	83 e0 0f             	and    $0xf,%eax
801029db:	c1 ea 04             	shr    $0x4,%edx
801029de:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029e1:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029e4:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
801029e7:	8b 45 bc             	mov    -0x44(%ebp),%eax
801029ea:	89 c2                	mov    %eax,%edx
801029ec:	83 e0 0f             	and    $0xf,%eax
801029ef:	c1 ea 04             	shr    $0x4,%edx
801029f2:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029f5:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029f8:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
801029fb:	8b 45 c0             	mov    -0x40(%ebp),%eax
801029fe:	89 c2                	mov    %eax,%edx
80102a00:	83 e0 0f             	and    $0xf,%eax
80102a03:	c1 ea 04             	shr    $0x4,%edx
80102a06:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a09:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a0c:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102a0f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102a12:	89 c2                	mov    %eax,%edx
80102a14:	83 e0 0f             	and    $0xf,%eax
80102a17:	c1 ea 04             	shr    $0x4,%edx
80102a1a:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a1d:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a20:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102a23:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102a26:	89 c2                	mov    %eax,%edx
80102a28:	83 e0 0f             	and    $0xf,%eax
80102a2b:	c1 ea 04             	shr    $0x4,%edx
80102a2e:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a31:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a34:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102a37:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102a3a:	89 c2                	mov    %eax,%edx
80102a3c:	83 e0 0f             	and    $0xf,%eax
80102a3f:	c1 ea 04             	shr    $0x4,%edx
80102a42:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a45:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a48:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102a4b:	8b 55 08             	mov    0x8(%ebp),%edx
80102a4e:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102a51:	89 02                	mov    %eax,(%edx)
80102a53:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102a56:	89 42 04             	mov    %eax,0x4(%edx)
80102a59:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102a5c:	89 42 08             	mov    %eax,0x8(%edx)
80102a5f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102a62:	89 42 0c             	mov    %eax,0xc(%edx)
80102a65:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102a68:	89 42 10             	mov    %eax,0x10(%edx)
80102a6b:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102a6e:	89 42 14             	mov    %eax,0x14(%edx)
  r->year += 2000;
80102a71:	81 42 14 d0 07 00 00 	addl   $0x7d0,0x14(%edx)
}
80102a78:	83 c4 6c             	add    $0x6c,%esp
80102a7b:	5b                   	pop    %ebx
80102a7c:	5e                   	pop    %esi
80102a7d:	5f                   	pop    %edi
80102a7e:	5d                   	pop    %ebp
80102a7f:	c3                   	ret    

80102a80 <install_trans>:
}

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
80102a80:	55                   	push   %ebp
80102a81:	89 e5                	mov    %esp,%ebp
80102a83:	57                   	push   %edi
80102a84:	56                   	push   %esi
80102a85:	53                   	push   %ebx
80102a86:	83 ec 1c             	sub    $0x1c,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102a89:	a1 c8 26 11 80       	mov    0x801126c8,%eax
80102a8e:	85 c0                	test   %eax,%eax
80102a90:	7e 7a                	jle    80102b0c <install_trans+0x8c>
80102a92:	31 db                	xor    %ebx,%ebx
80102a94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102a98:	a1 b4 26 11 80       	mov    0x801126b4,%eax
80102a9d:	01 d8                	add    %ebx,%eax
80102a9f:	83 c0 01             	add    $0x1,%eax
80102aa2:	89 44 24 04          	mov    %eax,0x4(%esp)
80102aa6:	a1 c4 26 11 80       	mov    0x801126c4,%eax
80102aab:	89 04 24             	mov    %eax,(%esp)
80102aae:	e8 1d d6 ff ff       	call   801000d0 <bread>
80102ab3:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102ab5:	8b 04 9d cc 26 11 80 	mov    -0x7feed934(,%ebx,4),%eax
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102abc:	83 c3 01             	add    $0x1,%ebx
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102abf:	89 44 24 04          	mov    %eax,0x4(%esp)
80102ac3:	a1 c4 26 11 80       	mov    0x801126c4,%eax
80102ac8:	89 04 24             	mov    %eax,(%esp)
80102acb:	e8 00 d6 ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102ad0:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
80102ad7:	00 
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102ad8:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102ada:	8d 47 5c             	lea    0x5c(%edi),%eax
80102add:	89 44 24 04          	mov    %eax,0x4(%esp)
80102ae1:	8d 46 5c             	lea    0x5c(%esi),%eax
80102ae4:	89 04 24             	mov    %eax,(%esp)
80102ae7:	e8 d4 19 00 00       	call   801044c0 <memmove>
    bwrite(dbuf);  // write dst to disk
80102aec:	89 34 24             	mov    %esi,(%esp)
80102aef:	e8 ac d6 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102af4:	89 3c 24             	mov    %edi,(%esp)
80102af7:	e8 e4 d6 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102afc:	89 34 24             	mov    %esi,(%esp)
80102aff:	e8 dc d6 ff ff       	call   801001e0 <brelse>
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102b04:	39 1d c8 26 11 80    	cmp    %ebx,0x801126c8
80102b0a:	7f 8c                	jg     80102a98 <install_trans+0x18>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf);
    brelse(dbuf);
  }
}
80102b0c:	83 c4 1c             	add    $0x1c,%esp
80102b0f:	5b                   	pop    %ebx
80102b10:	5e                   	pop    %esi
80102b11:	5f                   	pop    %edi
80102b12:	5d                   	pop    %ebp
80102b13:	c3                   	ret    
80102b14:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102b1a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80102b20 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102b20:	55                   	push   %ebp
80102b21:	89 e5                	mov    %esp,%ebp
80102b23:	57                   	push   %edi
80102b24:	56                   	push   %esi
80102b25:	53                   	push   %ebx
80102b26:	83 ec 1c             	sub    $0x1c,%esp
  struct buf *buf = bread(log.dev, log.start);
80102b29:	a1 b4 26 11 80       	mov    0x801126b4,%eax
80102b2e:	89 44 24 04          	mov    %eax,0x4(%esp)
80102b32:	a1 c4 26 11 80       	mov    0x801126c4,%eax
80102b37:	89 04 24             	mov    %eax,(%esp)
80102b3a:	e8 91 d5 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102b3f:	8b 1d c8 26 11 80    	mov    0x801126c8,%ebx
  for (i = 0; i < log.lh.n; i++) {
80102b45:	85 db                	test   %ebx,%ebx
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102b47:	89 c7                	mov    %eax,%edi
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102b49:	89 58 5c             	mov    %ebx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102b4c:	7e 1c                	jle    80102b6a <write_head+0x4a>
80102b4e:	31 d2                	xor    %edx,%edx
80102b50:	8d 70 5c             	lea    0x5c(%eax),%esi
80102b53:	90                   	nop
80102b54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    hb->block[i] = log.lh.block[i];
80102b58:	8b 0c 95 cc 26 11 80 	mov    -0x7feed934(,%edx,4),%ecx
80102b5f:	89 4c 96 04          	mov    %ecx,0x4(%esi,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102b63:	83 c2 01             	add    $0x1,%edx
80102b66:	39 da                	cmp    %ebx,%edx
80102b68:	75 ee                	jne    80102b58 <write_head+0x38>
    hb->block[i] = log.lh.block[i];
  }
  bwrite(buf);
80102b6a:	89 3c 24             	mov    %edi,(%esp)
80102b6d:	e8 2e d6 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102b72:	89 3c 24             	mov    %edi,(%esp)
80102b75:	e8 66 d6 ff ff       	call   801001e0 <brelse>
}
80102b7a:	83 c4 1c             	add    $0x1c,%esp
80102b7d:	5b                   	pop    %ebx
80102b7e:	5e                   	pop    %esi
80102b7f:	5f                   	pop    %edi
80102b80:	5d                   	pop    %ebp
80102b81:	c3                   	ret    
80102b82:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102b90 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
80102b90:	55                   	push   %ebp
80102b91:	89 e5                	mov    %esp,%ebp
80102b93:	56                   	push   %esi
80102b94:	53                   	push   %ebx
80102b95:	83 ec 30             	sub    $0x30,%esp
80102b98:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
80102b9b:	c7 44 24 04 30 73 10 	movl   $0x80107330,0x4(%esp)
80102ba2:	80 
80102ba3:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102baa:	e8 21 16 00 00       	call   801041d0 <initlock>
  readsb(dev, &sb);
80102baf:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102bb2:	89 44 24 04          	mov    %eax,0x4(%esp)
80102bb6:	89 1c 24             	mov    %ebx,(%esp)
80102bb9:	e8 d2 e7 ff ff       	call   80101390 <readsb>
  log.start = sb.logstart;
80102bbe:	8b 45 ec             	mov    -0x14(%ebp),%eax
  log.size = sb.nlog;
80102bc1:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.dev = dev;
80102bc4:	89 1d c4 26 11 80    	mov    %ebx,0x801126c4

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102bca:	89 1c 24             	mov    %ebx,(%esp)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102bcd:	a3 b4 26 11 80       	mov    %eax,0x801126b4
  log.size = sb.nlog;
80102bd2:	89 15 b8 26 11 80    	mov    %edx,0x801126b8

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102bd8:	89 44 24 04          	mov    %eax,0x4(%esp)
80102bdc:	e8 ef d4 ff ff       	call   801000d0 <bread>
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102be1:	8b 58 5c             	mov    0x5c(%eax),%ebx
  for (i = 0; i < log.lh.n; i++) {
80102be4:	85 db                	test   %ebx,%ebx
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102be6:	89 1d c8 26 11 80    	mov    %ebx,0x801126c8
  for (i = 0; i < log.lh.n; i++) {
80102bec:	7e 1c                	jle    80102c0a <initlog+0x7a>
80102bee:	31 d2                	xor    %edx,%edx
80102bf0:	8d 70 5c             	lea    0x5c(%eax),%esi
80102bf3:	90                   	nop
80102bf4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    log.lh.block[i] = lh->block[i];
80102bf8:	8b 4c 96 04          	mov    0x4(%esi,%edx,4),%ecx
80102bfc:	89 0c 95 cc 26 11 80 	mov    %ecx,-0x7feed934(,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
80102c03:	83 c2 01             	add    $0x1,%edx
80102c06:	39 da                	cmp    %ebx,%edx
80102c08:	75 ee                	jne    80102bf8 <initlog+0x68>
    log.lh.block[i] = lh->block[i];
  }
  brelse(buf);
80102c0a:	89 04 24             	mov    %eax,(%esp)
80102c0d:	e8 ce d5 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102c12:	e8 69 fe ff ff       	call   80102a80 <install_trans>
  log.lh.n = 0;
80102c17:	c7 05 c8 26 11 80 00 	movl   $0x0,0x801126c8
80102c1e:	00 00 00 
  write_head(); // clear the log
80102c21:	e8 fa fe ff ff       	call   80102b20 <write_head>
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
  recover_from_log();
}
80102c26:	83 c4 30             	add    $0x30,%esp
80102c29:	5b                   	pop    %ebx
80102c2a:	5e                   	pop    %esi
80102c2b:	5d                   	pop    %ebp
80102c2c:	c3                   	ret    
80102c2d:	8d 76 00             	lea    0x0(%esi),%esi

80102c30 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102c30:	55                   	push   %ebp
80102c31:	89 e5                	mov    %esp,%ebp
80102c33:	83 ec 18             	sub    $0x18,%esp
  acquire(&log.lock);
80102c36:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102c3d:	e8 fe 16 00 00       	call   80104340 <acquire>
80102c42:	eb 18                	jmp    80102c5c <begin_op+0x2c>
80102c44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
80102c48:	c7 44 24 04 80 26 11 	movl   $0x80112680,0x4(%esp)
80102c4f:	80 
80102c50:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102c57:	e8 f4 10 00 00       	call   80103d50 <sleep>
void
begin_op(void)
{
  acquire(&log.lock);
  while(1){
    if(log.committing){
80102c5c:	a1 c0 26 11 80       	mov    0x801126c0,%eax
80102c61:	85 c0                	test   %eax,%eax
80102c63:	75 e3                	jne    80102c48 <begin_op+0x18>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102c65:	8b 15 bc 26 11 80    	mov    0x801126bc,%edx
80102c6b:	8b 0d c8 26 11 80    	mov    0x801126c8,%ecx
80102c71:	83 c2 01             	add    $0x1,%edx
80102c74:	8d 04 92             	lea    (%edx,%edx,4),%eax
80102c77:	8d 04 41             	lea    (%ecx,%eax,2),%eax
80102c7a:	83 f8 1e             	cmp    $0x1e,%eax
80102c7d:	7f c9                	jg     80102c48 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102c7f:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
80102c86:	89 15 bc 26 11 80    	mov    %edx,0x801126bc
      release(&log.lock);
80102c8c:	e8 1f 17 00 00       	call   801043b0 <release>
      break;
    }
  }
}
80102c91:	c9                   	leave  
80102c92:	c3                   	ret    
80102c93:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102c99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102ca0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102ca0:	55                   	push   %ebp
80102ca1:	89 e5                	mov    %esp,%ebp
80102ca3:	57                   	push   %edi
80102ca4:	56                   	push   %esi
80102ca5:	53                   	push   %ebx
80102ca6:	83 ec 1c             	sub    $0x1c,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102ca9:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102cb0:	e8 8b 16 00 00       	call   80104340 <acquire>
  log.outstanding -= 1;
80102cb5:	a1 bc 26 11 80       	mov    0x801126bc,%eax
  if(log.committing)
80102cba:	8b 15 c0 26 11 80    	mov    0x801126c0,%edx
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102cc0:	83 e8 01             	sub    $0x1,%eax
  if(log.committing)
80102cc3:	85 d2                	test   %edx,%edx
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102cc5:	a3 bc 26 11 80       	mov    %eax,0x801126bc
  if(log.committing)
80102cca:	0f 85 f3 00 00 00    	jne    80102dc3 <end_op+0x123>
    panic("log.committing");
  if(log.outstanding == 0){
80102cd0:	85 c0                	test   %eax,%eax
80102cd2:	0f 85 cb 00 00 00    	jne    80102da3 <end_op+0x103>
    do_commit = 1;
    log.committing = 1;
80102cd8:	c7 05 c0 26 11 80 01 	movl   $0x1,0x801126c0
80102cdf:	00 00 00 
}

static void
commit()
{
  if (log.lh.n > 0) {
80102ce2:	31 db                	xor    %ebx,%ebx
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102ce4:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102ceb:	e8 c0 16 00 00       	call   801043b0 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102cf0:	a1 c8 26 11 80       	mov    0x801126c8,%eax
80102cf5:	85 c0                	test   %eax,%eax
80102cf7:	0f 8e 90 00 00 00    	jle    80102d8d <end_op+0xed>
80102cfd:	8d 76 00             	lea    0x0(%esi),%esi
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102d00:	a1 b4 26 11 80       	mov    0x801126b4,%eax
80102d05:	01 d8                	add    %ebx,%eax
80102d07:	83 c0 01             	add    $0x1,%eax
80102d0a:	89 44 24 04          	mov    %eax,0x4(%esp)
80102d0e:	a1 c4 26 11 80       	mov    0x801126c4,%eax
80102d13:	89 04 24             	mov    %eax,(%esp)
80102d16:	e8 b5 d3 ff ff       	call   801000d0 <bread>
80102d1b:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d1d:	8b 04 9d cc 26 11 80 	mov    -0x7feed934(,%ebx,4),%eax
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102d24:	83 c3 01             	add    $0x1,%ebx
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d27:	89 44 24 04          	mov    %eax,0x4(%esp)
80102d2b:	a1 c4 26 11 80       	mov    0x801126c4,%eax
80102d30:	89 04 24             	mov    %eax,(%esp)
80102d33:	e8 98 d3 ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80102d38:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
80102d3f:	00 
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d40:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102d42:	8d 40 5c             	lea    0x5c(%eax),%eax
80102d45:	89 44 24 04          	mov    %eax,0x4(%esp)
80102d49:	8d 46 5c             	lea    0x5c(%esi),%eax
80102d4c:	89 04 24             	mov    %eax,(%esp)
80102d4f:	e8 6c 17 00 00       	call   801044c0 <memmove>
    bwrite(to);  // write the log
80102d54:	89 34 24             	mov    %esi,(%esp)
80102d57:	e8 44 d4 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102d5c:	89 3c 24             	mov    %edi,(%esp)
80102d5f:	e8 7c d4 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102d64:	89 34 24             	mov    %esi,(%esp)
80102d67:	e8 74 d4 ff ff       	call   801001e0 <brelse>
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102d6c:	3b 1d c8 26 11 80    	cmp    0x801126c8,%ebx
80102d72:	7c 8c                	jl     80102d00 <end_op+0x60>
static void
commit()
{
  if (log.lh.n > 0) {
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102d74:	e8 a7 fd ff ff       	call   80102b20 <write_head>
    install_trans(); // Now install writes to home locations
80102d79:	e8 02 fd ff ff       	call   80102a80 <install_trans>
    log.lh.n = 0;
80102d7e:	c7 05 c8 26 11 80 00 	movl   $0x0,0x801126c8
80102d85:	00 00 00 
    write_head();    // Erase the transaction from the log
80102d88:	e8 93 fd ff ff       	call   80102b20 <write_head>

  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
80102d8d:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102d94:	e8 a7 15 00 00       	call   80104340 <acquire>
    log.committing = 0;
80102d99:	c7 05 c0 26 11 80 00 	movl   $0x0,0x801126c0
80102da0:	00 00 00 
    wakeup(&log);
80102da3:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102daa:	e8 41 11 00 00       	call   80103ef0 <wakeup>
    release(&log.lock);
80102daf:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102db6:	e8 f5 15 00 00       	call   801043b0 <release>
  }
}
80102dbb:	83 c4 1c             	add    $0x1c,%esp
80102dbe:	5b                   	pop    %ebx
80102dbf:	5e                   	pop    %esi
80102dc0:	5f                   	pop    %edi
80102dc1:	5d                   	pop    %ebp
80102dc2:	c3                   	ret    
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
80102dc3:	c7 04 24 34 73 10 80 	movl   $0x80107334,(%esp)
80102dca:	e8 a1 d5 ff ff       	call   80100370 <panic>
80102dcf:	90                   	nop

80102dd0 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102dd0:	55                   	push   %ebp
80102dd1:	89 e5                	mov    %esp,%ebp
80102dd3:	53                   	push   %ebx
80102dd4:	83 ec 14             	sub    $0x14,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102dd7:	a1 c8 26 11 80       	mov    0x801126c8,%eax
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102ddc:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102ddf:	83 f8 1d             	cmp    $0x1d,%eax
80102de2:	0f 8f 98 00 00 00    	jg     80102e80 <log_write+0xb0>
80102de8:	8b 15 b8 26 11 80    	mov    0x801126b8,%edx
80102dee:	83 ea 01             	sub    $0x1,%edx
80102df1:	39 d0                	cmp    %edx,%eax
80102df3:	0f 8d 87 00 00 00    	jge    80102e80 <log_write+0xb0>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102df9:	8b 0d bc 26 11 80    	mov    0x801126bc,%ecx
80102dff:	85 c9                	test   %ecx,%ecx
80102e01:	0f 8e 85 00 00 00    	jle    80102e8c <log_write+0xbc>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102e07:	c7 04 24 80 26 11 80 	movl   $0x80112680,(%esp)
80102e0e:	e8 2d 15 00 00       	call   80104340 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102e13:	8b 15 c8 26 11 80    	mov    0x801126c8,%edx
80102e19:	83 fa 00             	cmp    $0x0,%edx
80102e1c:	7e 53                	jle    80102e71 <log_write+0xa1>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102e1e:	8b 4b 08             	mov    0x8(%ebx),%ecx
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102e21:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102e23:	39 0d cc 26 11 80    	cmp    %ecx,0x801126cc
80102e29:	75 0e                	jne    80102e39 <log_write+0x69>
80102e2b:	eb 3b                	jmp    80102e68 <log_write+0x98>
80102e2d:	8d 76 00             	lea    0x0(%esi),%esi
80102e30:	39 0c 85 cc 26 11 80 	cmp    %ecx,-0x7feed934(,%eax,4)
80102e37:	74 2f                	je     80102e68 <log_write+0x98>
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102e39:	83 c0 01             	add    $0x1,%eax
80102e3c:	39 d0                	cmp    %edx,%eax
80102e3e:	75 f0                	jne    80102e30 <log_write+0x60>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102e40:	89 0c 95 cc 26 11 80 	mov    %ecx,-0x7feed934(,%edx,4)
  if (i == log.lh.n)
    log.lh.n++;
80102e47:	83 c2 01             	add    $0x1,%edx
80102e4a:	89 15 c8 26 11 80    	mov    %edx,0x801126c8
  b->flags |= B_DIRTY; // prevent eviction
80102e50:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102e53:	c7 45 08 80 26 11 80 	movl   $0x80112680,0x8(%ebp)
}
80102e5a:	83 c4 14             	add    $0x14,%esp
80102e5d:	5b                   	pop    %ebx
80102e5e:	5d                   	pop    %ebp
  }
  log.lh.block[i] = b->blockno;
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
  release(&log.lock);
80102e5f:	e9 4c 15 00 00       	jmp    801043b0 <release>
80102e64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102e68:	89 0c 85 cc 26 11 80 	mov    %ecx,-0x7feed934(,%eax,4)
80102e6f:	eb df                	jmp    80102e50 <log_write+0x80>
80102e71:	8b 43 08             	mov    0x8(%ebx),%eax
80102e74:	a3 cc 26 11 80       	mov    %eax,0x801126cc
  if (i == log.lh.n)
80102e79:	75 d5                	jne    80102e50 <log_write+0x80>
80102e7b:	eb ca                	jmp    80102e47 <log_write+0x77>
80102e7d:	8d 76 00             	lea    0x0(%esi),%esi
log_write(struct buf *b)
{
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    panic("too big a transaction");
80102e80:	c7 04 24 43 73 10 80 	movl   $0x80107343,(%esp)
80102e87:	e8 e4 d4 ff ff       	call   80100370 <panic>
  if (log.outstanding < 1)
    panic("log_write outside of trans");
80102e8c:	c7 04 24 59 73 10 80 	movl   $0x80107359,(%esp)
80102e93:	e8 d8 d4 ff ff       	call   80100370 <panic>
	...

80102ea0 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102ea0:	55                   	push   %ebp
80102ea1:	89 e5                	mov    %esp,%ebp
80102ea3:	53                   	push   %ebx
80102ea4:	83 ec 14             	sub    $0x14,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102ea7:	e8 24 09 00 00       	call   801037d0 <cpuid>
80102eac:	89 c3                	mov    %eax,%ebx
80102eae:	e8 1d 09 00 00       	call   801037d0 <cpuid>
80102eb3:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80102eb7:	c7 04 24 74 73 10 80 	movl   $0x80107374,(%esp)
80102ebe:	89 44 24 04          	mov    %eax,0x4(%esp)
80102ec2:	e8 89 d7 ff ff       	call   80100650 <cprintf>
  idtinit();       // load idt register
80102ec7:	e8 44 28 00 00       	call   80105710 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102ecc:	e8 7f 08 00 00       	call   80103750 <mycpu>
80102ed1:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102ed3:	b8 01 00 00 00       	mov    $0x1,%eax
80102ed8:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102edf:	e8 cc 0b 00 00       	call   80103ab0 <scheduler>
80102ee4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102eea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80102ef0 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
80102ef0:	55                   	push   %ebp
80102ef1:	89 e5                	mov    %esp,%ebp
80102ef3:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102ef6:	e8 65 38 00 00       	call   80106760 <switchkvm>
  seginit();
80102efb:	e8 80 37 00 00       	call   80106680 <seginit>
  lapicinit();
80102f00:	e8 bb f7 ff ff       	call   801026c0 <lapicinit>
  mpmain();
80102f05:	e8 96 ff ff ff       	call   80102ea0 <mpmain>
80102f0a:	00 00                	add    %al,(%eax)
80102f0c:	00 00                	add    %al,(%eax)
	...

80102f10 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
80102f10:	55                   	push   %ebp
80102f11:	89 e5                	mov    %esp,%ebp
80102f13:	53                   	push   %ebx
80102f14:	83 e4 f0             	and    $0xfffffff0,%esp
80102f17:	83 ec 10             	sub    $0x10,%esp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102f1a:	c7 44 24 04 00 00 40 	movl   $0x80400000,0x4(%esp)
80102f21:	80 
80102f22:	c7 04 24 a8 54 11 80 	movl   $0x801154a8,(%esp)
80102f29:	e8 f2 f5 ff ff       	call   80102520 <kinit1>
  kvmalloc();      // kernel page table
80102f2e:	e8 6d 3d 00 00       	call   80106ca0 <kvmalloc>
  mpinit();        // detect other processors
80102f33:	e8 68 01 00 00       	call   801030a0 <mpinit>
  lapicinit();     // interrupt controller
80102f38:	e8 83 f7 ff ff       	call   801026c0 <lapicinit>
80102f3d:	8d 76 00             	lea    0x0(%esi),%esi
  seginit();       // segment descriptors
80102f40:	e8 3b 37 00 00       	call   80106680 <seginit>
  picinit();       // disable pic
80102f45:	e8 26 03 00 00       	call   80103270 <picinit>
  ioapicinit();    // another interrupt controller
80102f4a:	e8 d1 f3 ff ff       	call   80102320 <ioapicinit>
80102f4f:	90                   	nop
  consoleinit();   // console hardware
80102f50:	e8 0b da ff ff       	call   80100960 <consoleinit>
  uartinit();      // serial port
80102f55:	e8 e6 2a 00 00       	call   80105a40 <uartinit>
  pinit();         // process table
80102f5a:	e8 d1 07 00 00       	call   80103730 <pinit>
80102f5f:	90                   	nop
  tvinit();        // trap vectors
80102f60:	e8 1b 27 00 00       	call   80105680 <tvinit>
  binit();         // buffer cache
80102f65:	e8 d6 d0 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80102f6a:	e8 d1 dd ff ff       	call   80100d40 <fileinit>
80102f6f:	90                   	nop
  ideinit();       // disk 
80102f70:	e8 bb f1 ff ff       	call   80102130 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102f75:	c7 44 24 08 8a 00 00 	movl   $0x8a,0x8(%esp)
80102f7c:	00 
80102f7d:	c7 44 24 04 8c a4 10 	movl   $0x8010a48c,0x4(%esp)
80102f84:	80 
80102f85:	c7 04 24 00 70 00 80 	movl   $0x80007000,(%esp)
80102f8c:	e8 2f 15 00 00       	call   801044c0 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80102f91:	69 05 00 2d 11 80 b0 	imul   $0xb0,0x80112d00,%eax
80102f98:	00 00 00 
80102f9b:	05 80 27 11 80       	add    $0x80112780,%eax
80102fa0:	3d 80 27 11 80       	cmp    $0x80112780,%eax
80102fa5:	76 6c                	jbe    80103013 <main+0x103>
80102fa7:	bb 80 27 11 80       	mov    $0x80112780,%ebx
80102fac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(c == mycpu())  // We've started already.
80102fb0:	e8 9b 07 00 00       	call   80103750 <mycpu>
80102fb5:	39 d8                	cmp    %ebx,%eax
80102fb7:	74 41                	je     80102ffa <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80102fb9:	e8 b2 f5 ff ff       	call   80102570 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
80102fbe:	c7 05 f8 6f 00 80 f0 	movl   $0x80102ef0,0x80006ff8
80102fc5:	2e 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80102fc8:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
80102fcf:	90 10 00 

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
    *(void**)(code-4) = stack + KSTACKSIZE;
80102fd2:	05 00 10 00 00       	add    $0x1000,%eax
80102fd7:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80102fdc:	0f b6 03             	movzbl (%ebx),%eax
80102fdf:	c7 44 24 04 00 70 00 	movl   $0x7000,0x4(%esp)
80102fe6:	00 
80102fe7:	89 04 24             	mov    %eax,(%esp)
80102fea:	e8 11 f8 ff ff       	call   80102800 <lapicstartap>
80102fef:	90                   	nop

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80102ff0:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80102ff6:	85 c0                	test   %eax,%eax
80102ff8:	74 f6                	je     80102ff0 <main+0xe0>
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
80102ffa:	69 05 00 2d 11 80 b0 	imul   $0xb0,0x80112d00,%eax
80103001:	00 00 00 
80103004:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
8010300a:	05 80 27 11 80       	add    $0x80112780,%eax
8010300f:	39 c3                	cmp    %eax,%ebx
80103011:	72 9d                	jb     80102fb0 <main+0xa0>
  tvinit();        // trap vectors
  binit();         // buffer cache
  fileinit();      // file table
  ideinit();       // disk 
  startothers();   // start other processors
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103013:	c7 44 24 04 00 00 00 	movl   $0x8e000000,0x4(%esp)
8010301a:	8e 
8010301b:	c7 04 24 00 00 40 80 	movl   $0x80400000,(%esp)
80103022:	e8 c9 f4 ff ff       	call   801024f0 <kinit2>
  userinit();      // first user process
80103027:	e8 f4 07 00 00       	call   80103820 <userinit>
  mpmain();        // finish this processor's setup
8010302c:	e8 6f fe ff ff       	call   80102ea0 <mpmain>
	...

80103040 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103040:	55                   	push   %ebp
  uchar *e, *p, *addr;

  addr = P2V(a);
80103041:	05 00 00 00 80       	add    $0x80000000,%eax
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103046:	89 e5                	mov    %esp,%ebp
80103048:	56                   	push   %esi
80103049:	53                   	push   %ebx
  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
8010304a:	31 db                	xor    %ebx,%ebx
mpsearch1(uint a, int len)
{
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
8010304c:	8d 34 10             	lea    (%eax,%edx,1),%esi
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
8010304f:	83 ec 10             	sub    $0x10,%esp
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80103052:	39 f0                	cmp    %esi,%eax
80103054:	73 3d                	jae    80103093 <mpsearch1+0x53>
80103056:	89 c3                	mov    %eax,%ebx
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103058:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
8010305f:	00 
80103060:	c7 44 24 04 88 73 10 	movl   $0x80107388,0x4(%esp)
80103067:	80 
80103068:	89 1c 24             	mov    %ebx,(%esp)
8010306b:	e8 f0 13 00 00       	call   80104460 <memcmp>
80103070:	85 c0                	test   %eax,%eax
80103072:	75 16                	jne    8010308a <mpsearch1+0x4a>
80103074:	31 d2                	xor    %edx,%edx
80103076:	66 90                	xchg   %ax,%ax
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
    sum += addr[i];
80103078:	0f b6 0c 03          	movzbl (%ebx,%eax,1),%ecx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
8010307c:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
8010307f:	01 ca                	add    %ecx,%edx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80103081:	83 f8 10             	cmp    $0x10,%eax
80103084:	75 f2                	jne    80103078 <mpsearch1+0x38>
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103086:	84 d2                	test   %dl,%dl
80103088:	74 09                	je     80103093 <mpsearch1+0x53>
{
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
8010308a:	83 c3 10             	add    $0x10,%ebx
8010308d:	39 de                	cmp    %ebx,%esi
8010308f:	77 c7                	ja     80103058 <mpsearch1+0x18>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
80103091:	31 db                	xor    %ebx,%ebx
}
80103093:	83 c4 10             	add    $0x10,%esp
80103096:	89 d8                	mov    %ebx,%eax
80103098:	5b                   	pop    %ebx
80103099:	5e                   	pop    %esi
8010309a:	5d                   	pop    %ebp
8010309b:	c3                   	ret    
8010309c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801030a0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
801030a0:	55                   	push   %ebp
801030a1:	89 e5                	mov    %esp,%ebp
801030a3:	57                   	push   %edi
801030a4:	56                   	push   %esi
801030a5:	53                   	push   %ebx
801030a6:	83 ec 2c             	sub    $0x2c,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
801030a9:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
801030b0:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
801030b7:	c1 e0 08             	shl    $0x8,%eax
801030ba:	09 d0                	or     %edx,%eax
801030bc:	c1 e0 04             	shl    $0x4,%eax
801030bf:	85 c0                	test   %eax,%eax
801030c1:	75 1b                	jne    801030de <mpinit+0x3e>
    if((mp = mpsearch1(p, 1024)))
      return mp;
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
801030c3:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
801030ca:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
801030d1:	c1 e0 08             	shl    $0x8,%eax
801030d4:	09 d0                	or     %edx,%eax
801030d6:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
801030d9:	2d 00 04 00 00       	sub    $0x400,%eax
801030de:	ba 00 04 00 00       	mov    $0x400,%edx
801030e3:	e8 58 ff ff ff       	call   80103040 <mpsearch1>
801030e8:	85 c0                	test   %eax,%eax
801030ea:	89 c6                	mov    %eax,%esi
801030ec:	0f 84 38 01 00 00    	je     8010322a <mpinit+0x18a>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801030f2:	8b 5e 04             	mov    0x4(%esi),%ebx
801030f5:	85 db                	test   %ebx,%ebx
801030f7:	0f 84 46 01 00 00    	je     80103243 <mpinit+0x1a3>
    return 0;
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
801030fd:	8d 93 00 00 00 80    	lea    -0x80000000(%ebx),%edx
80103103:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103106:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
8010310d:	00 
8010310e:	c7 44 24 04 8d 73 10 	movl   $0x8010738d,0x4(%esp)
80103115:	80 
80103116:	89 14 24             	mov    %edx,(%esp)
80103119:	e8 42 13 00 00       	call   80104460 <memcmp>
8010311e:	85 c0                	test   %eax,%eax
80103120:	0f 85 1d 01 00 00    	jne    80103243 <mpinit+0x1a3>
    return 0;
  if(conf->version != 1 && conf->version != 4)
80103126:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
8010312d:	3c 04                	cmp    $0x4,%al
8010312f:	0f 85 1b 01 00 00    	jne    80103250 <mpinit+0x1b0>
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
80103135:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
8010313c:	85 ff                	test   %edi,%edi
8010313e:	74 21                	je     80103161 <mpinit+0xc1>
80103140:	31 d2                	xor    %edx,%edx
80103142:	31 c0                	xor    %eax,%eax
80103144:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
80103148:	0f b6 8c 03 00 00 00 	movzbl -0x80000000(%ebx,%eax,1),%ecx
8010314f:	80 
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80103150:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
80103153:	01 ca                	add    %ecx,%edx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80103155:	39 c7                	cmp    %eax,%edi
80103157:	7f ef                	jg     80103148 <mpinit+0xa8>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
  if(memcmp(conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
80103159:	84 d2                	test   %dl,%dl
8010315b:	0f 85 e2 00 00 00    	jne    80103243 <mpinit+0x1a3>
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
80103161:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103164:	85 c0                	test   %eax,%eax
80103166:	0f 84 d7 00 00 00    	je     80103243 <mpinit+0x1a3>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
8010316c:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
80103172:	89 75 e0             	mov    %esi,-0x20(%ebp)
80103175:	a3 7c 26 11 80       	mov    %eax,0x8011267c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010317a:	0f b7 8b 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%ecx
80103181:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
80103187:	03 4d e4             	add    -0x1c(%ebp),%ecx
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
8010318a:	bb 01 00 00 00       	mov    $0x1,%ebx
8010318f:	90                   	nop
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103190:	39 c8                	cmp    %ecx,%eax
80103192:	73 23                	jae    801031b7 <mpinit+0x117>
80103194:	0f b6 10             	movzbl (%eax),%edx
    switch(*p){
80103197:	80 fa 04             	cmp    $0x4,%dl
8010319a:	76 07                	jbe    801031a3 <mpinit+0x103>
    case MPIOINTR:
    case MPLINTR:
      p += 8;
      continue;
    default:
      ismp = 0;
8010319c:	31 db                	xor    %ebx,%ebx
  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
8010319e:	80 fa 04             	cmp    $0x4,%dl
801031a1:	77 f9                	ja     8010319c <mpinit+0xfc>
801031a3:	0f b6 d2             	movzbl %dl,%edx
801031a6:	ff 24 95 cc 73 10 80 	jmp    *-0x7fef8c34(,%edx,4)
801031ad:	8d 76 00             	lea    0x0(%esi),%esi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
801031b0:	83 c0 08             	add    $0x8,%eax

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801031b3:	39 c8                	cmp    %ecx,%eax
801031b5:	72 dd                	jb     80103194 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
801031b7:	85 db                	test   %ebx,%ebx
801031b9:	8b 75 e0             	mov    -0x20(%ebp),%esi
801031bc:	0f 84 98 00 00 00    	je     8010325a <mpinit+0x1ba>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
801031c2:	80 7e 0c 00          	cmpb   $0x0,0xc(%esi)
801031c6:	74 12                	je     801031da <mpinit+0x13a>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801031c8:	ba 22 00 00 00       	mov    $0x22,%edx
801031cd:	b8 70 00 00 00       	mov    $0x70,%eax
801031d2:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801031d3:	b2 23                	mov    $0x23,%dl
801031d5:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
801031d6:	83 c8 01             	or     $0x1,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801031d9:	ee                   	out    %al,(%dx)
  }
}
801031da:	83 c4 2c             	add    $0x2c,%esp
801031dd:	5b                   	pop    %ebx
801031de:	5e                   	pop    %esi
801031df:	5f                   	pop    %edi
801031e0:	5d                   	pop    %ebp
801031e1:	c3                   	ret    
801031e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
801031e8:	8b 15 00 2d 11 80    	mov    0x80112d00,%edx
801031ee:	83 fa 07             	cmp    $0x7,%edx
801031f1:	7f 1b                	jg     8010320e <mpinit+0x16e>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801031f3:	0f b6 78 01          	movzbl 0x1(%eax),%edi
801031f7:	69 d2 b0 00 00 00    	imul   $0xb0,%edx,%edx
        ncpu++;
801031fd:	83 05 00 2d 11 80 01 	addl   $0x1,0x80112d00
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103204:	89 d6                	mov    %edx,%esi
80103206:	89 fa                	mov    %edi,%edx
80103208:	88 96 80 27 11 80    	mov    %dl,-0x7feed880(%esi)
        ncpu++;
      }
      p += sizeof(struct mpproc);
8010320e:	83 c0 14             	add    $0x14,%eax
      continue;
80103211:	e9 7a ff ff ff       	jmp    80103190 <mpinit+0xf0>
80103216:	66 90                	xchg   %ax,%ax
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
80103218:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
8010321c:	83 c0 08             	add    $0x8,%eax
      }
      p += sizeof(struct mpproc);
      continue;
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
8010321f:	88 15 60 27 11 80    	mov    %dl,0x80112760
      p += sizeof(struct mpioapic);
      continue;
80103225:	e9 66 ff ff ff       	jmp    80103190 <mpinit+0xf0>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
8010322a:	ba 00 00 01 00       	mov    $0x10000,%edx
8010322f:	b8 00 00 0f 00       	mov    $0xf0000,%eax
80103234:	e8 07 fe ff ff       	call   80103040 <mpsearch1>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103239:	85 c0                	test   %eax,%eax
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
8010323b:	89 c6                	mov    %eax,%esi
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
8010323d:	0f 85 af fe ff ff    	jne    801030f2 <mpinit+0x52>
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
80103243:	c7 04 24 92 73 10 80 	movl   $0x80107392,(%esp)
8010324a:	e8 21 d1 ff ff       	call   80100370 <panic>
8010324f:	90                   	nop
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
    return 0;
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
  if(memcmp(conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
80103250:	3c 01                	cmp    $0x1,%al
80103252:	0f 84 dd fe ff ff    	je     80103135 <mpinit+0x95>
80103258:	eb e9                	jmp    80103243 <mpinit+0x1a3>
      ismp = 0;
      break;
    }
  }
  if(!ismp)
    panic("Didn't find a suitable machine");
8010325a:	c7 04 24 ac 73 10 80 	movl   $0x801073ac,(%esp)
80103261:	e8 0a d1 ff ff       	call   80100370 <panic>
	...

80103270 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
80103270:	55                   	push   %ebp
80103271:	ba 21 00 00 00       	mov    $0x21,%edx
80103276:	89 e5                	mov    %esp,%ebp
80103278:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010327d:	ee                   	out    %al,(%dx)
8010327e:	b2 a1                	mov    $0xa1,%dl
80103280:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103281:	5d                   	pop    %ebp
80103282:	c3                   	ret    
	...

80103290 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103290:	55                   	push   %ebp
80103291:	89 e5                	mov    %esp,%ebp
80103293:	83 ec 28             	sub    $0x28,%esp
80103296:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80103299:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010329c:	89 75 f8             	mov    %esi,-0x8(%ebp)
8010329f:	8b 75 08             	mov    0x8(%ebp),%esi
801032a2:	89 7d fc             	mov    %edi,-0x4(%ebp)
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
801032a5:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801032ab:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
801032b1:	e8 aa da ff ff       	call   80100d60 <filealloc>
801032b6:	85 c0                	test   %eax,%eax
801032b8:	89 06                	mov    %eax,(%esi)
801032ba:	0f 84 a6 00 00 00    	je     80103366 <pipealloc+0xd6>
801032c0:	e8 9b da ff ff       	call   80100d60 <filealloc>
801032c5:	85 c0                	test   %eax,%eax
801032c7:	89 03                	mov    %eax,(%ebx)
801032c9:	0f 84 89 00 00 00    	je     80103358 <pipealloc+0xc8>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
801032cf:	e8 9c f2 ff ff       	call   80102570 <kalloc>
801032d4:	85 c0                	test   %eax,%eax
801032d6:	89 c7                	mov    %eax,%edi
801032d8:	74 7e                	je     80103358 <pipealloc+0xc8>
    goto bad;
  p->readopen = 1;
801032da:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801032e1:	00 00 00 
  p->writeopen = 1;
801032e4:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801032eb:	00 00 00 
  p->nwrite = 0;
801032ee:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801032f5:	00 00 00 
  p->nread = 0;
801032f8:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801032ff:	00 00 00 
  initlock(&p->lock, "pipe");
80103302:	89 04 24             	mov    %eax,(%esp)
80103305:	c7 44 24 04 e0 73 10 	movl   $0x801073e0,0x4(%esp)
8010330c:	80 
8010330d:	e8 be 0e 00 00       	call   801041d0 <initlock>
  (*f0)->type = FD_PIPE;
80103312:	8b 06                	mov    (%esi),%eax
80103314:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
8010331a:	8b 06                	mov    (%esi),%eax
8010331c:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103320:	8b 06                	mov    (%esi),%eax
80103322:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103326:	8b 06                	mov    (%esi),%eax
80103328:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
8010332b:	8b 03                	mov    (%ebx),%eax
8010332d:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103333:	8b 03                	mov    (%ebx),%eax
80103335:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103339:	8b 03                	mov    (%ebx),%eax
8010333b:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
8010333f:	8b 03                	mov    (%ebx),%eax
  return 0;
80103341:	31 db                	xor    %ebx,%ebx
  (*f0)->writable = 0;
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
80103343:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103346:	89 d8                	mov    %ebx,%eax
80103348:	8b 75 f8             	mov    -0x8(%ebp),%esi
8010334b:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010334e:	8b 7d fc             	mov    -0x4(%ebp),%edi
80103351:	89 ec                	mov    %ebp,%esp
80103353:	5d                   	pop    %ebp
80103354:	c3                   	ret    
80103355:	8d 76 00             	lea    0x0(%esi),%esi

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
80103358:	8b 06                	mov    (%esi),%eax
8010335a:	85 c0                	test   %eax,%eax
8010335c:	74 08                	je     80103366 <pipealloc+0xd6>
    fileclose(*f0);
8010335e:	89 04 24             	mov    %eax,(%esp)
80103361:	e8 ba da ff ff       	call   80100e20 <fileclose>
  if(*f1)
80103366:	8b 03                	mov    (%ebx),%eax
    fileclose(*f1);
  return -1;
80103368:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
    fileclose(*f0);
  if(*f1)
8010336d:	85 c0                	test   %eax,%eax
8010336f:	74 d5                	je     80103346 <pipealloc+0xb6>
    fileclose(*f1);
80103371:	89 04 24             	mov    %eax,(%esp)
80103374:	e8 a7 da ff ff       	call   80100e20 <fileclose>
  return -1;
}
80103379:	89 d8                	mov    %ebx,%eax
8010337b:	8b 75 f8             	mov    -0x8(%ebp),%esi
8010337e:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80103381:	8b 7d fc             	mov    -0x4(%ebp),%edi
80103384:	89 ec                	mov    %ebp,%esp
80103386:	5d                   	pop    %ebp
80103387:	c3                   	ret    
80103388:	90                   	nop
80103389:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103390 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103390:	55                   	push   %ebp
80103391:	89 e5                	mov    %esp,%ebp
80103393:	83 ec 18             	sub    $0x18,%esp
80103396:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80103399:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010339c:	89 75 fc             	mov    %esi,-0x4(%ebp)
8010339f:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
801033a2:	89 1c 24             	mov    %ebx,(%esp)
801033a5:	e8 96 0f 00 00       	call   80104340 <acquire>
  if(writable){
801033aa:	85 f6                	test   %esi,%esi
801033ac:	74 42                	je     801033f0 <pipeclose+0x60>
    p->writeopen = 0;
801033ae:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
801033b5:	00 00 00 
    wakeup(&p->nread);
801033b8:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801033be:	89 04 24             	mov    %eax,(%esp)
801033c1:	e8 2a 0b 00 00       	call   80103ef0 <wakeup>
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
801033c6:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
801033cc:	85 d2                	test   %edx,%edx
801033ce:	75 0a                	jne    801033da <pipeclose+0x4a>
801033d0:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
801033d6:	85 c0                	test   %eax,%eax
801033d8:	74 36                	je     80103410 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
801033da:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801033dd:	8b 75 fc             	mov    -0x4(%ebp),%esi
801033e0:	8b 5d f8             	mov    -0x8(%ebp),%ebx
801033e3:	89 ec                	mov    %ebp,%esp
801033e5:	5d                   	pop    %ebp
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
801033e6:	e9 c5 0f 00 00       	jmp    801043b0 <release>
801033eb:	90                   	nop
801033ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
801033f0:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801033f7:	00 00 00 
    wakeup(&p->nwrite);
801033fa:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103400:	89 04 24             	mov    %eax,(%esp)
80103403:	e8 e8 0a 00 00       	call   80103ef0 <wakeup>
80103408:	eb bc                	jmp    801033c6 <pipeclose+0x36>
8010340a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
80103410:	89 1c 24             	mov    %ebx,(%esp)
80103413:	e8 98 0f 00 00       	call   801043b0 <release>
    kfree((char*)p);
  } else
    release(&p->lock);
}
80103418:	8b 75 fc             	mov    -0x4(%ebp),%esi
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
8010341b:	89 5d 08             	mov    %ebx,0x8(%ebp)
  } else
    release(&p->lock);
}
8010341e:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80103421:	89 ec                	mov    %ebp,%esp
80103423:	5d                   	pop    %ebp
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
80103424:	e9 d7 ef ff ff       	jmp    80102400 <kfree>
80103429:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103430 <pipewrite>:
}

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103430:	55                   	push   %ebp
80103431:	89 e5                	mov    %esp,%ebp
80103433:	57                   	push   %edi
80103434:	56                   	push   %esi
80103435:	53                   	push   %ebx
80103436:	83 ec 2c             	sub    $0x2c,%esp
80103439:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
8010343c:	89 1c 24             	mov    %ebx,(%esp)
8010343f:	e8 fc 0e 00 00       	call   80104340 <acquire>
  for(i = 0; i < n; i++){
80103444:	8b 45 10             	mov    0x10(%ebp),%eax
80103447:	85 c0                	test   %eax,%eax
80103449:	0f 8e 97 00 00 00    	jle    801034e6 <pipewrite+0xb6>
8010344f:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103455:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
8010345b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103462:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
80103468:	eb 3a                	jmp    801034a4 <pipewrite+0x74>
8010346a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
80103470:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103476:	85 c0                	test   %eax,%eax
80103478:	0f 84 82 00 00 00    	je     80103500 <pipewrite+0xd0>
8010347e:	e8 6d 03 00 00       	call   801037f0 <myproc>
80103483:	8b 48 24             	mov    0x24(%eax),%ecx
80103486:	85 c9                	test   %ecx,%ecx
80103488:	75 76                	jne    80103500 <pipewrite+0xd0>
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
8010348a:	89 3c 24             	mov    %edi,(%esp)
8010348d:	e8 5e 0a 00 00       	call   80103ef0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103492:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80103496:	89 34 24             	mov    %esi,(%esp)
80103499:	e8 b2 08 00 00       	call   80103d50 <sleep>
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010349e:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
801034a4:	8b 93 34 02 00 00    	mov    0x234(%ebx),%edx
801034aa:	81 c2 00 02 00 00    	add    $0x200,%edx
801034b0:	39 d0                	cmp    %edx,%eax
801034b2:	74 bc                	je     80103470 <pipewrite+0x40>
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801034b4:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801034b7:	8b 55 e4             	mov    -0x1c(%ebp),%edx
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
801034ba:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801034be:	0f b6 14 11          	movzbl (%ecx,%edx,1),%edx
801034c2:	88 55 e3             	mov    %dl,-0x1d(%ebp)
801034c5:	0f b6 4d e3          	movzbl -0x1d(%ebp),%ecx
801034c9:	89 c2                	mov    %eax,%edx
801034cb:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
801034d1:	83 c0 01             	add    $0x1,%eax
801034d4:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
801034d8:	8b 55 10             	mov    0x10(%ebp),%edx
801034db:	39 55 e4             	cmp    %edx,-0x1c(%ebp)
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801034de:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
801034e4:	75 be                	jne    801034a4 <pipewrite+0x74>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801034e6:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801034ec:	89 04 24             	mov    %eax,(%esp)
801034ef:	e8 fc 09 00 00       	call   80103ef0 <wakeup>
  release(&p->lock);
801034f4:	89 1c 24             	mov    %ebx,(%esp)
801034f7:	e8 b4 0e 00 00       	call   801043b0 <release>
  return n;
801034fc:	eb 11                	jmp    8010350f <pipewrite+0xdf>
801034fe:	66 90                	xchg   %ax,%ax

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
80103500:	89 1c 24             	mov    %ebx,(%esp)
80103503:	e8 a8 0e 00 00       	call   801043b0 <release>
        return -1;
80103508:	c7 45 10 ff ff ff ff 	movl   $0xffffffff,0x10(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
8010350f:	8b 45 10             	mov    0x10(%ebp),%eax
80103512:	83 c4 2c             	add    $0x2c,%esp
80103515:	5b                   	pop    %ebx
80103516:	5e                   	pop    %esi
80103517:	5f                   	pop    %edi
80103518:	5d                   	pop    %ebp
80103519:	c3                   	ret    
8010351a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103520 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103520:	55                   	push   %ebp
80103521:	89 e5                	mov    %esp,%ebp
80103523:	57                   	push   %edi
80103524:	56                   	push   %esi
80103525:	53                   	push   %ebx
80103526:	83 ec 1c             	sub    $0x1c,%esp
80103529:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010352c:	8b 7d 10             	mov    0x10(%ebp),%edi
  int i;

  acquire(&p->lock);
8010352f:	89 1c 24             	mov    %ebx,(%esp)
80103532:	e8 09 0e 00 00       	call   80104340 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103537:	8b 93 34 02 00 00    	mov    0x234(%ebx),%edx
8010353d:	3b 93 38 02 00 00    	cmp    0x238(%ebx),%edx
80103543:	75 5b                	jne    801035a0 <piperead+0x80>
80103545:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
8010354b:	85 c0                	test   %eax,%eax
8010354d:	74 51                	je     801035a0 <piperead+0x80>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
8010354f:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
80103555:	eb 25                	jmp    8010357c <piperead+0x5c>
80103557:	90                   	nop
80103558:	89 5c 24 04          	mov    %ebx,0x4(%esp)
8010355c:	89 34 24             	mov    %esi,(%esp)
8010355f:	e8 ec 07 00 00       	call   80103d50 <sleep>
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103564:	8b 93 34 02 00 00    	mov    0x234(%ebx),%edx
8010356a:	3b 93 38 02 00 00    	cmp    0x238(%ebx),%edx
80103570:	75 2e                	jne    801035a0 <piperead+0x80>
80103572:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103578:	85 c0                	test   %eax,%eax
8010357a:	74 24                	je     801035a0 <piperead+0x80>
    if(myproc()->killed){
8010357c:	e8 6f 02 00 00       	call   801037f0 <myproc>
80103581:	8b 40 24             	mov    0x24(%eax),%eax
80103584:	85 c0                	test   %eax,%eax
80103586:	74 d0                	je     80103558 <piperead+0x38>
      release(&p->lock);
80103588:	89 1c 24             	mov    %ebx,(%esp)
      return -1;
8010358b:	be ff ff ff ff       	mov    $0xffffffff,%esi
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
    if(myproc()->killed){
      release(&p->lock);
80103590:	e8 1b 0e 00 00       	call   801043b0 <release>
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103595:	83 c4 1c             	add    $0x1c,%esp
80103598:	89 f0                	mov    %esi,%eax
8010359a:	5b                   	pop    %ebx
8010359b:	5e                   	pop    %esi
8010359c:	5f                   	pop    %edi
8010359d:	5d                   	pop    %ebp
8010359e:	c3                   	ret    
8010359f:	90                   	nop
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801035a0:	31 f6                	xor    %esi,%esi
801035a2:	85 ff                	test   %edi,%edi
801035a4:	7e 39                	jle    801035df <piperead+0xbf>
    if(p->nread == p->nwrite)
801035a6:	3b 93 38 02 00 00    	cmp    0x238(%ebx),%edx
801035ac:	74 31                	je     801035df <piperead+0xbf>
  release(&p->lock);
  return n;
}

int
piperead(struct pipe *p, char *addr, int n)
801035ae:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801035b1:	29 d1                	sub    %edx,%ecx
801035b3:	eb 0b                	jmp    801035c0 <piperead+0xa0>
801035b5:	8d 76 00             	lea    0x0(%esi),%esi
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    if(p->nread == p->nwrite)
801035b8:	39 93 38 02 00 00    	cmp    %edx,0x238(%ebx)
801035be:	74 1f                	je     801035df <piperead+0xbf>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
801035c0:	89 d0                	mov    %edx,%eax
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801035c2:	83 c6 01             	add    $0x1,%esi
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
801035c5:	25 ff 01 00 00       	and    $0x1ff,%eax
801035ca:	0f b6 44 03 34       	movzbl 0x34(%ebx,%eax,1),%eax
801035cf:	88 04 11             	mov    %al,(%ecx,%edx,1)
801035d2:	83 c2 01             	add    $0x1,%edx
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801035d5:	39 fe                	cmp    %edi,%esi
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
801035d7:	89 93 34 02 00 00    	mov    %edx,0x234(%ebx)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801035dd:	75 d9                	jne    801035b8 <piperead+0x98>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
801035df:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
801035e5:	89 04 24             	mov    %eax,(%esp)
801035e8:	e8 03 09 00 00       	call   80103ef0 <wakeup>
  release(&p->lock);
801035ed:	89 1c 24             	mov    %ebx,(%esp)
801035f0:	e8 bb 0d 00 00       	call   801043b0 <release>
  return i;
}
801035f5:	83 c4 1c             	add    $0x1c,%esp
801035f8:	89 f0                	mov    %esi,%eax
801035fa:	5b                   	pop    %ebx
801035fb:	5e                   	pop    %esi
801035fc:	5f                   	pop    %edi
801035fd:	5d                   	pop    %ebp
801035fe:	c3                   	ret    
	...

80103600 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103600:	55                   	push   %ebp
80103601:	89 e5                	mov    %esp,%ebp
80103603:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103604:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103609:	83 ec 14             	sub    $0x14,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
8010360c:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103613:	e8 28 0d 00 00       	call   80104340 <acquire>

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
80103618:	8b 15 60 2d 11 80    	mov    0x80112d60,%edx
8010361e:	85 d2                	test   %edx,%edx
80103620:	74 18                	je     8010363a <allocproc+0x3a>
80103622:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103628:	83 c3 7c             	add    $0x7c,%ebx
8010362b:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
80103631:	73 7d                	jae    801036b0 <allocproc+0xb0>
    if(p->state == UNUSED)
80103633:	8b 43 0c             	mov    0xc(%ebx),%eax
80103636:	85 c0                	test   %eax,%eax
80103638:	75 ee                	jne    80103628 <allocproc+0x28>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
8010363a:	a1 00 a0 10 80       	mov    0x8010a000,%eax

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
8010363f:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103646:	89 43 10             	mov    %eax,0x10(%ebx)
80103649:	83 c0 01             	add    $0x1,%eax
8010364c:	a3 00 a0 10 80       	mov    %eax,0x8010a000

  release(&ptable.lock);
80103651:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103658:	e8 53 0d 00 00       	call   801043b0 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
8010365d:	e8 0e ef ff ff       	call   80102570 <kalloc>
80103662:	85 c0                	test   %eax,%eax
80103664:	89 43 08             	mov    %eax,0x8(%ebx)
80103667:	74 5d                	je     801036c6 <allocproc+0xc6>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103669:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
8010366f:	89 53 18             	mov    %edx,0x18(%ebx)
  p->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;
80103672:	c7 80 b0 0f 00 00 68 	movl   $0x80105668,0xfb0(%eax)
80103679:	56 10 80 

  sp -= sizeof *p->context;
8010367c:	05 9c 0f 00 00       	add    $0xf9c,%eax
  p->context = (struct context*)sp;
80103681:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103684:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
8010368b:	00 
8010368c:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80103693:	00 
80103694:	89 04 24             	mov    %eax,(%esp)
80103697:	e8 64 0d 00 00       	call   80104400 <memset>
  p->context->eip = (uint)forkret;
8010369c:	8b 43 1c             	mov    0x1c(%ebx),%eax
8010369f:	c7 40 10 e0 36 10 80 	movl   $0x801036e0,0x10(%eax)

  return p;
}
801036a6:	83 c4 14             	add    $0x14,%esp
801036a9:	89 d8                	mov    %ebx,%eax
801036ab:	5b                   	pop    %ebx
801036ac:	5d                   	pop    %ebp
801036ad:	c3                   	ret    
801036ae:	66 90                	xchg   %ax,%ax

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
801036b0:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
  return 0;
801036b7:	31 db                	xor    %ebx,%ebx

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
801036b9:	e8 f2 0c 00 00       	call   801043b0 <release>
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  return p;
}
801036be:	83 c4 14             	add    $0x14,%esp
801036c1:	89 d8                	mov    %ebx,%eax
801036c3:	5b                   	pop    %ebx
801036c4:	5d                   	pop    %ebp
801036c5:	c3                   	ret    

  release(&ptable.lock);

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
801036c6:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
801036cd:	31 db                	xor    %ebx,%ebx
801036cf:	eb d5                	jmp    801036a6 <allocproc+0xa6>
801036d1:	eb 0d                	jmp    801036e0 <forkret>
801036d3:	90                   	nop
801036d4:	90                   	nop
801036d5:	90                   	nop
801036d6:	90                   	nop
801036d7:	90                   	nop
801036d8:	90                   	nop
801036d9:	90                   	nop
801036da:	90                   	nop
801036db:	90                   	nop
801036dc:	90                   	nop
801036dd:	90                   	nop
801036de:	90                   	nop
801036df:	90                   	nop

801036e0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
801036e0:	55                   	push   %ebp
801036e1:	89 e5                	mov    %esp,%ebp
801036e3:	83 ec 18             	sub    $0x18,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
801036e6:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801036ed:	e8 be 0c 00 00       	call   801043b0 <release>

  if (first) {
801036f2:	8b 0d 04 a0 10 80    	mov    0x8010a004,%ecx
801036f8:	85 c9                	test   %ecx,%ecx
801036fa:	75 04                	jne    80103700 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
801036fc:	c9                   	leave  
801036fd:	c3                   	ret    
801036fe:	66 90                	xchg   %ax,%ax
  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
80103700:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
80103707:	c7 05 04 a0 10 80 00 	movl   $0x0,0x8010a004
8010370e:	00 00 00 
    iinit(ROOTDEV);
80103711:	e8 6a dd ff ff       	call   80101480 <iinit>
    initlog(ROOTDEV);
80103716:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010371d:	e8 6e f4 ff ff       	call   80102b90 <initlog>
  }

  // Return to "caller", actually trapret (see allocproc).
}
80103722:	c9                   	leave  
80103723:	c3                   	ret    
80103724:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010372a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103730 <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
80103730:	55                   	push   %ebp
80103731:	89 e5                	mov    %esp,%ebp
80103733:	83 ec 18             	sub    $0x18,%esp
  initlock(&ptable.lock, "ptable");
80103736:	c7 44 24 04 e5 73 10 	movl   $0x801073e5,0x4(%esp)
8010373d:	80 
8010373e:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103745:	e8 86 0a 00 00       	call   801041d0 <initlock>
}
8010374a:	c9                   	leave  
8010374b:	c3                   	ret    
8010374c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103750 <mycpu>:

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu*
mycpu(void)
{
80103750:	55                   	push   %ebp
80103751:	89 e5                	mov    %esp,%ebp
80103753:	56                   	push   %esi
80103754:	53                   	push   %ebx
80103755:	83 ec 10             	sub    $0x10,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103758:	9c                   	pushf  
80103759:	58                   	pop    %eax
  int apicid, i;
  
  if(readeflags()&FL_IF)
8010375a:	f6 c4 02             	test   $0x2,%ah
8010375d:	75 57                	jne    801037b6 <mycpu+0x66>
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
8010375f:	e8 4c f0 ff ff       	call   801027b0 <lapicid>
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
80103764:	8b 35 00 2d 11 80    	mov    0x80112d00,%esi
8010376a:	85 f6                	test   %esi,%esi
8010376c:	7e 3c                	jle    801037aa <mycpu+0x5a>
    if (cpus[i].apicid == apicid)
8010376e:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx
80103775:	39 c2                	cmp    %eax,%edx
80103777:	74 2d                	je     801037a6 <mycpu+0x56>
      return &cpus[i];
80103779:	b9 30 28 11 80       	mov    $0x80112830,%ecx
    panic("mycpu called with interrupts enabled\n");
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
8010377e:	31 d2                	xor    %edx,%edx
80103780:	83 c2 01             	add    $0x1,%edx
80103783:	39 f2                	cmp    %esi,%edx
80103785:	74 23                	je     801037aa <mycpu+0x5a>
    if (cpus[i].apicid == apicid)
80103787:	0f b6 19             	movzbl (%ecx),%ebx
8010378a:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
80103790:	39 c3                	cmp    %eax,%ebx
80103792:	75 ec                	jne    80103780 <mycpu+0x30>
      return &cpus[i];
80103794:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
  }
  panic("unknown apicid\n");
}
8010379a:	83 c4 10             	add    $0x10,%esp
8010379d:	5b                   	pop    %ebx
8010379e:	5e                   	pop    %esi
8010379f:	5d                   	pop    %ebp
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return &cpus[i];
801037a0:	05 80 27 11 80       	add    $0x80112780,%eax
  }
  panic("unknown apicid\n");
}
801037a5:	c3                   	ret    
  
  apicid = lapicid();
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
801037a6:	31 d2                	xor    %edx,%edx
801037a8:	eb ea                	jmp    80103794 <mycpu+0x44>
      return &cpus[i];
  }
  panic("unknown apicid\n");
801037aa:	c7 04 24 ec 73 10 80 	movl   $0x801073ec,(%esp)
801037b1:	e8 ba cb ff ff       	call   80100370 <panic>
mycpu(void)
{
  int apicid, i;
  
  if(readeflags()&FL_IF)
    panic("mycpu called with interrupts enabled\n");
801037b6:	c7 04 24 c8 74 10 80 	movl   $0x801074c8,(%esp)
801037bd:	e8 ae cb ff ff       	call   80100370 <panic>
801037c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801037c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801037d0 <cpuid>:
  initlock(&ptable.lock, "ptable");
}

// Must be called with interrupts disabled
int
cpuid() {
801037d0:	55                   	push   %ebp
801037d1:	89 e5                	mov    %esp,%ebp
801037d3:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
801037d6:	e8 75 ff ff ff       	call   80103750 <mycpu>
}
801037db:	c9                   	leave  
}

// Must be called with interrupts disabled
int
cpuid() {
  return mycpu()-cpus;
801037dc:	2d 80 27 11 80       	sub    $0x80112780,%eax
801037e1:	c1 f8 04             	sar    $0x4,%eax
801037e4:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
801037ea:	c3                   	ret    
801037eb:	90                   	nop
801037ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801037f0 <myproc>:
}

// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc*
myproc(void) {
801037f0:	55                   	push   %ebp
801037f1:	89 e5                	mov    %esp,%ebp
801037f3:	53                   	push   %ebx
801037f4:	83 ec 04             	sub    $0x4,%esp
  struct cpu *c;
  struct proc *p;
  pushcli();
801037f7:	e8 54 0a 00 00       	call   80104250 <pushcli>
  c = mycpu();
801037fc:	e8 4f ff ff ff       	call   80103750 <mycpu>
  p = c->proc;
80103801:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103807:	e8 84 0a 00 00       	call   80104290 <popcli>
  return p;
}
8010380c:	83 c4 04             	add    $0x4,%esp
8010380f:	89 d8                	mov    %ebx,%eax
80103811:	5b                   	pop    %ebx
80103812:	5d                   	pop    %ebp
80103813:	c3                   	ret    
80103814:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010381a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103820 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
80103820:	55                   	push   %ebp
80103821:	89 e5                	mov    %esp,%ebp
80103823:	53                   	push   %ebx
80103824:	83 ec 14             	sub    $0x14,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();
80103827:	e8 d4 fd ff ff       	call   80103600 <allocproc>
8010382c:	89 c3                	mov    %eax,%ebx
  
  initproc = p;
8010382e:	a3 a0 a5 10 80       	mov    %eax,0x8010a5a0
  if((p->pgdir = setupkvm()) == 0)
80103833:	e8 e8 33 00 00       	call   80106c20 <setupkvm>
80103838:	85 c0                	test   %eax,%eax
8010383a:	89 43 04             	mov    %eax,0x4(%ebx)
8010383d:	0f 84 ce 00 00 00    	je     80103911 <userinit+0xf1>
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103843:	89 04 24             	mov    %eax,(%esp)
80103846:	c7 44 24 08 2c 00 00 	movl   $0x2c,0x8(%esp)
8010384d:	00 
8010384e:	c7 44 24 04 60 a4 10 	movl   $0x8010a460,0x4(%esp)
80103855:	80 
80103856:	e8 25 30 00 00       	call   80106880 <inituvm>
  p->sz = PGSIZE;
8010385b:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103861:	c7 44 24 08 4c 00 00 	movl   $0x4c,0x8(%esp)
80103868:	00 
80103869:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80103870:	00 
80103871:	8b 43 18             	mov    0x18(%ebx),%eax
80103874:	89 04 24             	mov    %eax,(%esp)
80103877:	e8 84 0b 00 00       	call   80104400 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010387c:	8b 43 18             	mov    0x18(%ebx),%eax
8010387f:	66 c7 40 3c 1b 00    	movw   $0x1b,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103885:	8b 43 18             	mov    0x18(%ebx),%eax
80103888:	66 c7 40 2c 23 00    	movw   $0x23,0x2c(%eax)
  p->tf->es = p->tf->ds;
8010388e:	8b 43 18             	mov    0x18(%ebx),%eax
80103891:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103895:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103899:	8b 43 18             	mov    0x18(%ebx),%eax
8010389c:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801038a0:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
801038a4:	8b 43 18             	mov    0x18(%ebx),%eax
801038a7:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
801038ae:	8b 43 18             	mov    0x18(%ebx),%eax
801038b1:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
801038b8:	8b 43 18             	mov    0x18(%ebx),%eax
801038bb:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
801038c2:	8d 43 6c             	lea    0x6c(%ebx),%eax
801038c5:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
801038cc:	00 
801038cd:	c7 44 24 04 15 74 10 	movl   $0x80107415,0x4(%esp)
801038d4:	80 
801038d5:	89 04 24             	mov    %eax,(%esp)
801038d8:	e8 13 0d 00 00       	call   801045f0 <safestrcpy>
  p->cwd = namei("/");
801038dd:	c7 04 24 1e 74 10 80 	movl   $0x8010741e,(%esp)
801038e4:	e8 47 e7 ff ff       	call   80102030 <namei>
801038e9:	89 43 68             	mov    %eax,0x68(%ebx)

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);
801038ec:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
801038f3:	e8 48 0a 00 00       	call   80104340 <acquire>

  p->state = RUNNABLE;
801038f8:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)

  release(&ptable.lock);
801038ff:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103906:	e8 a5 0a 00 00       	call   801043b0 <release>
}
8010390b:	83 c4 14             	add    $0x14,%esp
8010390e:	5b                   	pop    %ebx
8010390f:	5d                   	pop    %ebp
80103910:	c3                   	ret    

  p = allocproc();
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
80103911:	c7 04 24 fc 73 10 80 	movl   $0x801073fc,(%esp)
80103918:	e8 53 ca ff ff       	call   80100370 <panic>
8010391d:	8d 76 00             	lea    0x0(%esi),%esi

80103920 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
80103920:	55                   	push   %ebp
80103921:	89 e5                	mov    %esp,%ebp
80103923:	83 ec 18             	sub    $0x18,%esp
80103926:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80103929:	89 75 fc             	mov    %esi,-0x4(%ebp)
8010392c:	8b 75 08             	mov    0x8(%ebp),%esi
  uint sz;
  struct proc *curproc = myproc();
8010392f:	e8 bc fe ff ff       	call   801037f0 <myproc>

  sz = curproc->sz;
  if(n > 0){
80103934:	83 fe 00             	cmp    $0x0,%esi
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
  uint sz;
  struct proc *curproc = myproc();
80103937:	89 c3                	mov    %eax,%ebx

  sz = curproc->sz;
80103939:	8b 10                	mov    (%eax),%edx
  if(n > 0){
8010393b:	7e 3b                	jle    80103978 <growproc+0x58>
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
8010393d:	01 d6                	add    %edx,%esi
8010393f:	89 54 24 04          	mov    %edx,0x4(%esp)
80103943:	89 74 24 08          	mov    %esi,0x8(%esp)
80103947:	8b 40 04             	mov    0x4(%eax),%eax
8010394a:	89 04 24             	mov    %eax,(%esp)
8010394d:	e8 1e 31 00 00       	call   80106a70 <allocuvm>
80103952:	89 c2                	mov    %eax,%edx
      return -1;
80103954:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  uint sz;
  struct proc *curproc = myproc();

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103959:	85 d2                	test   %edx,%edx
8010395b:	74 0c                	je     80103969 <growproc+0x49>
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  curproc->sz = sz;
8010395d:	89 13                	mov    %edx,(%ebx)
  switchuvm(curproc);
8010395f:	89 1c 24             	mov    %ebx,(%esp)
80103962:	e8 19 2e 00 00       	call   80106780 <switchuvm>
  return 0;
80103967:	31 c0                	xor    %eax,%eax
}
80103969:	8b 5d f8             	mov    -0x8(%ebp),%ebx
8010396c:	8b 75 fc             	mov    -0x4(%ebp),%esi
8010396f:	89 ec                	mov    %ebp,%esp
80103971:	5d                   	pop    %ebp
80103972:	c3                   	ret    
80103973:	90                   	nop
80103974:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
80103978:	74 e3                	je     8010395d <growproc+0x3d>
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
8010397a:	01 d6                	add    %edx,%esi
8010397c:	89 54 24 04          	mov    %edx,0x4(%esp)
80103980:	89 74 24 08          	mov    %esi,0x8(%esp)
80103984:	8b 40 04             	mov    0x4(%eax),%eax
80103987:	89 04 24             	mov    %eax,(%esp)
8010398a:	e8 41 30 00 00       	call   801069d0 <deallocuvm>
8010398f:	89 c2                	mov    %eax,%edx
      return -1;
80103991:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  sz = curproc->sz;
  if(n > 0){
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103996:	85 d2                	test   %edx,%edx
80103998:	75 c3                	jne    8010395d <growproc+0x3d>
8010399a:	eb cd                	jmp    80103969 <growproc+0x49>
8010399c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801039a0 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
801039a0:	55                   	push   %ebp
801039a1:	89 e5                	mov    %esp,%ebp
801039a3:	57                   	push   %edi
801039a4:	56                   	push   %esi
801039a5:	53                   	push   %ebx
801039a6:	83 ec 2c             	sub    $0x2c,%esp
  int i, pid;
  struct proc *np;
  struct proc *curproc = myproc();
801039a9:	e8 42 fe ff ff       	call   801037f0 <myproc>
801039ae:	89 c3                	mov    %eax,%ebx

  // Allocate process.
  if((np = allocproc()) == 0){
801039b0:	e8 4b fc ff ff       	call   80103600 <allocproc>
801039b5:	85 c0                	test   %eax,%eax
801039b7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801039ba:	0f 84 c6 00 00 00    	je     80103a86 <fork+0xe6>
    return -1;
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
801039c0:	8b 03                	mov    (%ebx),%eax
801039c2:	89 44 24 04          	mov    %eax,0x4(%esp)
801039c6:	8b 43 04             	mov    0x4(%ebx),%eax
801039c9:	89 04 24             	mov    %eax,(%esp)
801039cc:	e8 1f 33 00 00       	call   80106cf0 <copyuvm>
801039d1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801039d4:	85 c0                	test   %eax,%eax
801039d6:	89 42 04             	mov    %eax,0x4(%edx)
801039d9:	0f 84 ae 00 00 00    	je     80103a8d <fork+0xed>
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
801039df:	8b 03                	mov    (%ebx),%eax
  np->parent = curproc;
  *np->tf = *curproc->tf;
801039e1:	b9 13 00 00 00       	mov    $0x13,%ecx
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
801039e6:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801039e9:	89 02                	mov    %eax,(%edx)
  np->parent = curproc;
  *np->tf = *curproc->tf;
801039eb:	8b 42 18             	mov    0x18(%edx),%eax
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = curproc->sz;
  np->parent = curproc;
801039ee:	89 5a 14             	mov    %ebx,0x14(%edx)
  *np->tf = *curproc->tf;
801039f1:	8b 73 18             	mov    0x18(%ebx),%esi
801039f4:	89 c7                	mov    %eax,%edi
801039f6:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
801039f8:	31 f6                	xor    %esi,%esi
  np->sz = curproc->sz;
  np->parent = curproc;
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
801039fa:	8b 42 18             	mov    0x18(%edx),%eax
801039fd:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
80103a04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
80103a08:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103a0c:	85 c0                	test   %eax,%eax
80103a0e:	74 0f                	je     80103a1f <fork+0x7f>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103a10:	89 04 24             	mov    %eax,(%esp)
80103a13:	e8 b8 d3 ff ff       	call   80100dd0 <filedup>
80103a18:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103a1b:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  *np->tf = *curproc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80103a1f:	83 c6 01             	add    $0x1,%esi
80103a22:	83 fe 10             	cmp    $0x10,%esi
80103a25:	75 e1                	jne    80103a08 <fork+0x68>
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103a27:	8b 43 68             	mov    0x68(%ebx),%eax

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103a2a:	83 c3 6c             	add    $0x6c,%ebx
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
    if(curproc->ofile[i])
      np->ofile[i] = filedup(curproc->ofile[i]);
  np->cwd = idup(curproc->cwd);
80103a2d:	89 04 24             	mov    %eax,(%esp)
80103a30:	e8 5b dc ff ff       	call   80101690 <idup>
80103a35:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103a38:	89 42 68             	mov    %eax,0x68(%edx)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103a3b:	89 d0                	mov    %edx,%eax
80103a3d:	83 c0 6c             	add    $0x6c,%eax
80103a40:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80103a44:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80103a4b:	00 
80103a4c:	89 04 24             	mov    %eax,(%esp)
80103a4f:	e8 9c 0b 00 00       	call   801045f0 <safestrcpy>

  pid = np->pid;
80103a54:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103a57:	8b 58 10             	mov    0x10(%eax),%ebx

  acquire(&ptable.lock);
80103a5a:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103a61:	e8 da 08 00 00       	call   80104340 <acquire>

  np->state = RUNNABLE;
80103a66:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103a69:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)

  release(&ptable.lock);
80103a70:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103a77:	e8 34 09 00 00       	call   801043b0 <release>

  return pid;
}
80103a7c:	83 c4 2c             	add    $0x2c,%esp
80103a7f:	89 d8                	mov    %ebx,%eax
80103a81:	5b                   	pop    %ebx
80103a82:	5e                   	pop    %esi
80103a83:	5f                   	pop    %edi
80103a84:	5d                   	pop    %ebp
80103a85:	c3                   	ret    
  struct proc *np;
  struct proc *curproc = myproc();

  // Allocate process.
  if((np = allocproc()) == 0){
    return -1;
80103a86:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103a8b:	eb ef                	jmp    80103a7c <fork+0xdc>
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
    kfree(np->kstack);
80103a8d:	8b 42 08             	mov    0x8(%edx),%eax
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
80103a90:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    return -1;
  }

  // Copy process state from proc.
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
    kfree(np->kstack);
80103a95:	89 04 24             	mov    %eax,(%esp)
80103a98:	e8 63 e9 ff ff       	call   80102400 <kfree>
    np->kstack = 0;
80103a9d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103aa0:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    np->state = UNUSED;
80103aa7:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    return -1;
80103aae:	eb cc                	jmp    80103a7c <fork+0xdc>

80103ab0 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
80103ab0:	55                   	push   %ebp
80103ab1:	89 e5                	mov    %esp,%ebp
80103ab3:	57                   	push   %edi
80103ab4:	56                   	push   %esi
80103ab5:	53                   	push   %ebx
80103ab6:	83 ec 1c             	sub    $0x1c,%esp
  struct proc *p;
  struct cpu *c = mycpu();
80103ab9:	e8 92 fc ff ff       	call   80103750 <mycpu>
80103abe:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103ac0:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103ac7:	00 00 00 
80103aca:	8d 78 04             	lea    0x4(%eax),%edi
80103acd:	8d 76 00             	lea    0x0(%esi),%esi
}

static inline void
sti(void)
{
  asm volatile("sti");
80103ad0:	fb                   	sti    
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ad1:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103ad6:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103add:	e8 5e 08 00 00       	call   80104340 <acquire>
80103ae2:	eb 0f                	jmp    80103af3 <scheduler+0x43>
80103ae4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ae8:	83 c3 7c             	add    $0x7c,%ebx
80103aeb:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
80103af1:	73 45                	jae    80103b38 <scheduler+0x88>
      if(p->state != RUNNABLE)
80103af3:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103af7:	75 ef                	jne    80103ae8 <scheduler+0x38>
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
80103af9:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103aff:	89 1c 24             	mov    %ebx,(%esp)
80103b02:	e8 79 2c 00 00       	call   80106780 <switchuvm>
      p->state = RUNNING;

      swtch(&(c->scheduler), p->context);
80103b07:	8b 43 1c             	mov    0x1c(%ebx),%eax
      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
      p->state = RUNNING;
80103b0a:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b11:	83 c3 7c             	add    $0x7c,%ebx
      // before jumping back to us.
      c->proc = p;
      switchuvm(p);
      p->state = RUNNING;

      swtch(&(c->scheduler), p->context);
80103b14:	89 3c 24             	mov    %edi,(%esp)
80103b17:	89 44 24 04          	mov    %eax,0x4(%esp)
80103b1b:	e8 2c 0b 00 00       	call   8010464c <swtch>
      switchkvm();
80103b20:	e8 3b 2c 00 00       	call   80106760 <switchkvm>
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b25:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
      swtch(&(c->scheduler), p->context);
      switchkvm();

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
80103b2b:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103b32:	00 00 00 
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b35:	72 bc                	jb     80103af3 <scheduler+0x43>
80103b37:	90                   	nop

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      c->proc = 0;
    }
    release(&ptable.lock);
80103b38:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103b3f:	e8 6c 08 00 00       	call   801043b0 <release>

  }
80103b44:	eb 8a                	jmp    80103ad0 <scheduler+0x20>
80103b46:	8d 76 00             	lea    0x0(%esi),%esi
80103b49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103b50 <sched>:
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
80103b50:	55                   	push   %ebp
80103b51:	89 e5                	mov    %esp,%ebp
80103b53:	56                   	push   %esi
80103b54:	53                   	push   %ebx
80103b55:	83 ec 10             	sub    $0x10,%esp
  int intena;
  struct proc *p = myproc();
80103b58:	e8 93 fc ff ff       	call   801037f0 <myproc>

  if(!holding(&ptable.lock))
80103b5d:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
// there's no process.
void
sched(void)
{
  int intena;
  struct proc *p = myproc();
80103b64:	89 c3                	mov    %eax,%ebx

  if(!holding(&ptable.lock))
80103b66:	e8 95 07 00 00       	call   80104300 <holding>
80103b6b:	85 c0                	test   %eax,%eax
80103b6d:	74 4f                	je     80103bbe <sched+0x6e>
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
80103b6f:	e8 dc fb ff ff       	call   80103750 <mycpu>
80103b74:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103b7b:	75 65                	jne    80103be2 <sched+0x92>
    panic("sched locks");
  if(p->state == RUNNING)
80103b7d:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103b81:	74 53                	je     80103bd6 <sched+0x86>

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103b83:	9c                   	pushf  
80103b84:	58                   	pop    %eax
    panic("sched running");
  if(readeflags()&FL_IF)
80103b85:	f6 c4 02             	test   $0x2,%ah
80103b88:	75 40                	jne    80103bca <sched+0x7a>
    panic("sched interruptible");
  intena = mycpu()->intena;
80103b8a:	e8 c1 fb ff ff       	call   80103750 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103b8f:	83 c3 1c             	add    $0x1c,%ebx
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = mycpu()->intena;
80103b92:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103b98:	e8 b3 fb ff ff       	call   80103750 <mycpu>
80103b9d:	8b 40 04             	mov    0x4(%eax),%eax
80103ba0:	89 1c 24             	mov    %ebx,(%esp)
80103ba3:	89 44 24 04          	mov    %eax,0x4(%esp)
80103ba7:	e8 a0 0a 00 00       	call   8010464c <swtch>
  mycpu()->intena = intena;
80103bac:	e8 9f fb ff ff       	call   80103750 <mycpu>
80103bb1:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103bb7:	83 c4 10             	add    $0x10,%esp
80103bba:	5b                   	pop    %ebx
80103bbb:	5e                   	pop    %esi
80103bbc:	5d                   	pop    %ebp
80103bbd:	c3                   	ret    
{
  int intena;
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
80103bbe:	c7 04 24 20 74 10 80 	movl   $0x80107420,(%esp)
80103bc5:	e8 a6 c7 ff ff       	call   80100370 <panic>
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
80103bca:	c7 04 24 4c 74 10 80 	movl   $0x8010744c,(%esp)
80103bd1:	e8 9a c7 ff ff       	call   80100370 <panic>
  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
  if(p->state == RUNNING)
    panic("sched running");
80103bd6:	c7 04 24 3e 74 10 80 	movl   $0x8010743e,(%esp)
80103bdd:	e8 8e c7 ff ff       	call   80100370 <panic>
  struct proc *p = myproc();

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(mycpu()->ncli != 1)
    panic("sched locks");
80103be2:	c7 04 24 32 74 10 80 	movl   $0x80107432,(%esp)
80103be9:	e8 82 c7 ff ff       	call   80100370 <panic>
80103bee:	66 90                	xchg   %ax,%ax

80103bf0 <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
80103bf0:	55                   	push   %ebp
80103bf1:	89 e5                	mov    %esp,%ebp
80103bf3:	56                   	push   %esi
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
80103bf4:	31 f6                	xor    %esi,%esi
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
80103bf6:	53                   	push   %ebx
80103bf7:	83 ec 10             	sub    $0x10,%esp
  struct proc *curproc = myproc();
80103bfa:	e8 f1 fb ff ff       	call   801037f0 <myproc>
  struct proc *p;
  int fd;

  if(curproc == initproc)
80103bff:	3b 05 a0 a5 10 80    	cmp    0x8010a5a0,%eax
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
  struct proc *curproc = myproc();
80103c05:	89 c3                	mov    %eax,%ebx
  struct proc *p;
  int fd;

  if(curproc == initproc)
80103c07:	0f 84 ea 00 00 00    	je     80103cf7 <exit+0x107>
80103c0d:	8d 76 00             	lea    0x0(%esi),%esi
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd]){
80103c10:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103c14:	85 c0                	test   %eax,%eax
80103c16:	74 10                	je     80103c28 <exit+0x38>
      fileclose(curproc->ofile[fd]);
80103c18:	89 04 24             	mov    %eax,(%esp)
80103c1b:	e8 00 d2 ff ff       	call   80100e20 <fileclose>
      curproc->ofile[fd] = 0;
80103c20:	c7 44 b3 28 00 00 00 	movl   $0x0,0x28(%ebx,%esi,4)
80103c27:	00 

  if(curproc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80103c28:	83 c6 01             	add    $0x1,%esi
80103c2b:	83 fe 10             	cmp    $0x10,%esi
80103c2e:	75 e0                	jne    80103c10 <exit+0x20>
      fileclose(curproc->ofile[fd]);
      curproc->ofile[fd] = 0;
    }
  }

  begin_op();
80103c30:	e8 fb ef ff ff       	call   80102c30 <begin_op>
  iput(curproc->cwd);
80103c35:	8b 43 68             	mov    0x68(%ebx),%eax
80103c38:	89 04 24             	mov    %eax,(%esp)
80103c3b:	e8 b0 db ff ff       	call   801017f0 <iput>
  end_op();
80103c40:	e8 5b f0 ff ff       	call   80102ca0 <end_op>
  curproc->cwd = 0;
80103c45:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)

  acquire(&ptable.lock);
80103c4c:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103c53:	e8 e8 06 00 00       	call   80104340 <acquire>

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);
80103c58:	8b 43 14             	mov    0x14(%ebx),%eax
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103c5b:	ba 54 2d 11 80       	mov    $0x80112d54,%edx
80103c60:	eb 11                	jmp    80103c73 <exit+0x83>
80103c62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103c68:	83 c2 7c             	add    $0x7c,%edx
80103c6b:	81 fa 54 4c 11 80    	cmp    $0x80114c54,%edx
80103c71:	73 1d                	jae    80103c90 <exit+0xa0>
    if(p->state == SLEEPING && p->chan == chan)
80103c73:	83 7a 0c 02          	cmpl   $0x2,0xc(%edx)
80103c77:	75 ef                	jne    80103c68 <exit+0x78>
80103c79:	3b 42 20             	cmp    0x20(%edx),%eax
80103c7c:	75 ea                	jne    80103c68 <exit+0x78>
      p->state = RUNNABLE;
80103c7e:	c7 42 0c 03 00 00 00 	movl   $0x3,0xc(%edx)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103c85:	83 c2 7c             	add    $0x7c,%edx
80103c88:	81 fa 54 4c 11 80    	cmp    $0x80114c54,%edx
80103c8e:	72 e3                	jb     80103c73 <exit+0x83>
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
80103c90:	a1 a0 a5 10 80       	mov    0x8010a5a0,%eax
80103c95:	b9 54 2d 11 80       	mov    $0x80112d54,%ecx
80103c9a:	eb 0f                	jmp    80103cab <exit+0xbb>
80103c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ca0:	83 c1 7c             	add    $0x7c,%ecx
80103ca3:	81 f9 54 4c 11 80    	cmp    $0x80114c54,%ecx
80103ca9:	73 34                	jae    80103cdf <exit+0xef>
    if(p->parent == curproc){
80103cab:	39 59 14             	cmp    %ebx,0x14(%ecx)
80103cae:	75 f0                	jne    80103ca0 <exit+0xb0>
      p->parent = initproc;
      if(p->state == ZOMBIE)
80103cb0:	83 79 0c 05          	cmpl   $0x5,0xc(%ecx)
  wakeup1(curproc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == curproc){
      p->parent = initproc;
80103cb4:	89 41 14             	mov    %eax,0x14(%ecx)
      if(p->state == ZOMBIE)
80103cb7:	75 e7                	jne    80103ca0 <exit+0xb0>
80103cb9:	ba 54 2d 11 80       	mov    $0x80112d54,%edx
80103cbe:	eb 0b                	jmp    80103ccb <exit+0xdb>
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103cc0:	83 c2 7c             	add    $0x7c,%edx
80103cc3:	81 fa 54 4c 11 80    	cmp    $0x80114c54,%edx
80103cc9:	73 d5                	jae    80103ca0 <exit+0xb0>
    if(p->state == SLEEPING && p->chan == chan)
80103ccb:	83 7a 0c 02          	cmpl   $0x2,0xc(%edx)
80103ccf:	75 ef                	jne    80103cc0 <exit+0xd0>
80103cd1:	3b 42 20             	cmp    0x20(%edx),%eax
80103cd4:	75 ea                	jne    80103cc0 <exit+0xd0>
      p->state = RUNNABLE;
80103cd6:	c7 42 0c 03 00 00 00 	movl   $0x3,0xc(%edx)
80103cdd:	eb e1                	jmp    80103cc0 <exit+0xd0>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  curproc->state = ZOMBIE;
80103cdf:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
80103ce6:	e8 65 fe ff ff       	call   80103b50 <sched>
  panic("zombie exit");
80103ceb:	c7 04 24 6d 74 10 80 	movl   $0x8010746d,(%esp)
80103cf2:	e8 79 c6 ff ff       	call   80100370 <panic>
  struct proc *curproc = myproc();
  struct proc *p;
  int fd;

  if(curproc == initproc)
    panic("init exiting");
80103cf7:	c7 04 24 60 74 10 80 	movl   $0x80107460,(%esp)
80103cfe:	e8 6d c6 ff ff       	call   80100370 <panic>
80103d03:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103d09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103d10 <yield>:
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
80103d10:	55                   	push   %ebp
80103d11:	89 e5                	mov    %esp,%ebp
80103d13:	83 ec 18             	sub    $0x18,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103d16:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103d1d:	e8 1e 06 00 00       	call   80104340 <acquire>
  myproc()->state = RUNNABLE;
80103d22:	e8 c9 fa ff ff       	call   801037f0 <myproc>
80103d27:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
80103d2e:	e8 1d fe ff ff       	call   80103b50 <sched>
  release(&ptable.lock);
80103d33:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103d3a:	e8 71 06 00 00       	call   801043b0 <release>
}
80103d3f:	c9                   	leave  
80103d40:	c3                   	ret    
80103d41:	eb 0d                	jmp    80103d50 <sleep>
80103d43:	90                   	nop
80103d44:	90                   	nop
80103d45:	90                   	nop
80103d46:	90                   	nop
80103d47:	90                   	nop
80103d48:	90                   	nop
80103d49:	90                   	nop
80103d4a:	90                   	nop
80103d4b:	90                   	nop
80103d4c:	90                   	nop
80103d4d:	90                   	nop
80103d4e:	90                   	nop
80103d4f:	90                   	nop

80103d50 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80103d50:	55                   	push   %ebp
80103d51:	89 e5                	mov    %esp,%ebp
80103d53:	83 ec 28             	sub    $0x28,%esp
80103d56:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80103d59:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80103d5c:	89 75 f8             	mov    %esi,-0x8(%ebp)
80103d5f:	8b 75 08             	mov    0x8(%ebp),%esi
80103d62:	89 7d fc             	mov    %edi,-0x4(%ebp)
  struct proc *p = myproc();
80103d65:	e8 86 fa ff ff       	call   801037f0 <myproc>
  
  if(p == 0)
80103d6a:	85 c0                	test   %eax,%eax
// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
80103d6c:	89 c7                	mov    %eax,%edi
  
  if(p == 0)
80103d6e:	0f 84 8b 00 00 00    	je     80103dff <sleep+0xaf>
    panic("sleep");

  if(lk == 0)
80103d74:	85 db                	test   %ebx,%ebx
80103d76:	74 7b                	je     80103df3 <sleep+0xa3>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103d78:	81 fb 20 2d 11 80    	cmp    $0x80112d20,%ebx
80103d7e:	74 50                	je     80103dd0 <sleep+0x80>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103d80:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103d87:	e8 b4 05 00 00       	call   80104340 <acquire>
    release(lk);
80103d8c:	89 1c 24             	mov    %ebx,(%esp)
80103d8f:	e8 1c 06 00 00       	call   801043b0 <release>
  }
  // Go to sleep.
  p->chan = chan;
80103d94:	89 77 20             	mov    %esi,0x20(%edi)
  p->state = SLEEPING;
80103d97:	c7 47 0c 02 00 00 00 	movl   $0x2,0xc(%edi)

  sched();
80103d9e:	e8 ad fd ff ff       	call   80103b50 <sched>

  // Tidy up.
  p->chan = 0;
80103da3:	c7 47 20 00 00 00 00 	movl   $0x0,0x20(%edi)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
80103daa:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103db1:	e8 fa 05 00 00       	call   801043b0 <release>
    acquire(lk);
  }
}
80103db6:	8b 75 f8             	mov    -0x8(%ebp),%esi
  p->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
80103db9:	89 5d 08             	mov    %ebx,0x8(%ebp)
  }
}
80103dbc:	8b 7d fc             	mov    -0x4(%ebp),%edi
80103dbf:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80103dc2:	89 ec                	mov    %ebp,%esp
80103dc4:	5d                   	pop    %ebp
  p->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
80103dc5:	e9 76 05 00 00       	jmp    80104340 <acquire>
80103dca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(lk != &ptable.lock){  //DOC: sleeplock0
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }
  // Go to sleep.
  p->chan = chan;
80103dd0:	89 70 20             	mov    %esi,0x20(%eax)
  p->state = SLEEPING;
80103dd3:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)

  sched();
80103dda:	e8 71 fd ff ff       	call   80103b50 <sched>

  // Tidy up.
  p->chan = 0;
80103ddf:	c7 47 20 00 00 00 00 	movl   $0x0,0x20(%edi)
  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}
80103de6:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80103de9:	8b 75 f8             	mov    -0x8(%ebp),%esi
80103dec:	8b 7d fc             	mov    -0x4(%ebp),%edi
80103def:	89 ec                	mov    %ebp,%esp
80103df1:	5d                   	pop    %ebp
80103df2:	c3                   	ret    
  
  if(p == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");
80103df3:	c7 04 24 7f 74 10 80 	movl   $0x8010747f,(%esp)
80103dfa:	e8 71 c5 ff ff       	call   80100370 <panic>
sleep(void *chan, struct spinlock *lk)
{
  struct proc *p = myproc();
  
  if(p == 0)
    panic("sleep");
80103dff:	c7 04 24 79 74 10 80 	movl   $0x80107479,(%esp)
80103e06:	e8 65 c5 ff ff       	call   80100370 <panic>
80103e0b:	90                   	nop
80103e0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103e10 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
80103e10:	55                   	push   %ebp
80103e11:	89 e5                	mov    %esp,%ebp
80103e13:	56                   	push   %esi
80103e14:	53                   	push   %ebx
80103e15:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();
80103e18:	e8 d3 f9 ff ff       	call   801037f0 <myproc>
  
  acquire(&ptable.lock);
80103e1d:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
int
wait(void)
{
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();
80103e24:	89 c6                	mov    %eax,%esi
  
  acquire(&ptable.lock);
80103e26:	e8 15 05 00 00       	call   80104340 <acquire>
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
80103e2b:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e2d:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
80103e32:	eb 0f                	jmp    80103e43 <wait+0x33>
80103e34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103e38:	83 c3 7c             	add    $0x7c,%ebx
80103e3b:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
80103e41:	73 1d                	jae    80103e60 <wait+0x50>
      if(p->parent != curproc)
80103e43:	39 73 14             	cmp    %esi,0x14(%ebx)
80103e46:	75 f0                	jne    80103e38 <wait+0x28>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
80103e48:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103e4c:	74 2f                	je     80103e7d <wait+0x6d>
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e4e:	83 c3 7c             	add    $0x7c,%ebx
      if(p->parent != curproc)
        continue;
      havekids = 1;
80103e51:	b8 01 00 00 00       	mov    $0x1,%eax
  
  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e56:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
80103e5c:	72 e5                	jb     80103e43 <wait+0x33>
80103e5e:	66 90                	xchg   %ax,%ax
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
80103e60:	85 c0                	test   %eax,%eax
80103e62:	74 6e                	je     80103ed2 <wait+0xc2>
80103e64:	8b 5e 24             	mov    0x24(%esi),%ebx
80103e67:	85 db                	test   %ebx,%ebx
80103e69:	75 67                	jne    80103ed2 <wait+0xc2>
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80103e6b:	c7 44 24 04 20 2d 11 	movl   $0x80112d20,0x4(%esp)
80103e72:	80 
80103e73:	89 34 24             	mov    %esi,(%esp)
80103e76:	e8 d5 fe ff ff       	call   80103d50 <sleep>
  }
80103e7b:	eb ae                	jmp    80103e2b <wait+0x1b>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
80103e7d:	8b 43 08             	mov    0x8(%ebx),%eax
      if(p->parent != curproc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
80103e80:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80103e83:	89 04 24             	mov    %eax,(%esp)
80103e86:	e8 75 e5 ff ff       	call   80102400 <kfree>
        p->kstack = 0;
        freevm(p->pgdir);
80103e8b:	8b 43 04             	mov    0x4(%ebx),%eax
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
80103e8e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80103e95:	89 04 24             	mov    %eax,(%esp)
80103e98:	e8 03 2d 00 00       	call   80106ba0 <freevm>
        p->pid = 0;
80103e9d:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80103ea4:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80103eab:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80103eaf:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80103eb6:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80103ebd:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103ec4:	e8 e7 04 00 00       	call   801043b0 <release>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103ec9:	83 c4 10             	add    $0x10,%esp
80103ecc:	89 f0                	mov    %esi,%eax
80103ece:	5b                   	pop    %ebx
80103ecf:	5e                   	pop    %esi
80103ed0:	5d                   	pop    %ebp
80103ed1:	c3                   	ret    
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
80103ed2:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
      return -1;
80103ed9:	be ff ff ff ff       	mov    $0xffffffff,%esi
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || curproc->killed){
      release(&ptable.lock);
80103ede:	e8 cd 04 00 00       	call   801043b0 <release>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103ee3:	83 c4 10             	add    $0x10,%esp
80103ee6:	89 f0                	mov    %esi,%eax
80103ee8:	5b                   	pop    %ebx
80103ee9:	5e                   	pop    %esi
80103eea:	5d                   	pop    %ebp
80103eeb:	c3                   	ret    
80103eec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103ef0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80103ef0:	55                   	push   %ebp
80103ef1:	89 e5                	mov    %esp,%ebp
80103ef3:	53                   	push   %ebx
80103ef4:	83 ec 14             	sub    $0x14,%esp
80103ef7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
80103efa:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103f01:	e8 3a 04 00 00       	call   80104340 <acquire>
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f06:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
80103f0b:	eb 0d                	jmp    80103f1a <wakeup+0x2a>
80103f0d:	8d 76 00             	lea    0x0(%esi),%esi
80103f10:	83 c0 7c             	add    $0x7c,%eax
80103f13:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80103f18:	73 1e                	jae    80103f38 <wakeup+0x48>
    if(p->state == SLEEPING && p->chan == chan)
80103f1a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103f1e:	75 f0                	jne    80103f10 <wakeup+0x20>
80103f20:	3b 58 20             	cmp    0x20(%eax),%ebx
80103f23:	75 eb                	jne    80103f10 <wakeup+0x20>
      p->state = RUNNABLE;
80103f25:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f2c:	83 c0 7c             	add    $0x7c,%eax
80103f2f:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80103f34:	72 e4                	jb     80103f1a <wakeup+0x2a>
80103f36:	66 90                	xchg   %ax,%ax
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
80103f38:	c7 45 08 20 2d 11 80 	movl   $0x80112d20,0x8(%ebp)
}
80103f3f:	83 c4 14             	add    $0x14,%esp
80103f42:	5b                   	pop    %ebx
80103f43:	5d                   	pop    %ebp
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
80103f44:	e9 67 04 00 00       	jmp    801043b0 <release>
80103f49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103f50 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80103f50:	55                   	push   %ebp
80103f51:	89 e5                	mov    %esp,%ebp
80103f53:	53                   	push   %ebx
80103f54:	83 ec 14             	sub    $0x14,%esp
80103f57:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
80103f5a:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103f61:	e8 da 03 00 00       	call   80104340 <acquire>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f66:	b8 54 2d 11 80       	mov    $0x80112d54,%eax
    if(p->pid == pid){
80103f6b:	39 1d 64 2d 11 80    	cmp    %ebx,0x80112d64
80103f71:	74 14                	je     80103f87 <kill+0x37>
80103f73:	90                   	nop
80103f74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
kill(int pid)
{
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f78:	83 c0 7c             	add    $0x7c,%eax
80103f7b:	3d 54 4c 11 80       	cmp    $0x80114c54,%eax
80103f80:	73 36                	jae    80103fb8 <kill+0x68>
    if(p->pid == pid){
80103f82:	39 58 10             	cmp    %ebx,0x10(%eax)
80103f85:	75 f1                	jne    80103f78 <kill+0x28>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80103f87:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
80103f8b:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80103f92:	74 14                	je     80103fa8 <kill+0x58>
        p->state = RUNNABLE;
      release(&ptable.lock);
80103f94:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103f9b:	e8 10 04 00 00       	call   801043b0 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
80103fa0:	83 c4 14             	add    $0x14,%esp
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
      release(&ptable.lock);
      return 0;
80103fa3:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
80103fa5:	5b                   	pop    %ebx
80103fa6:	5d                   	pop    %ebp
80103fa7:	c3                   	ret    
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
80103fa8:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103faf:	eb e3                	jmp    80103f94 <kill+0x44>
80103fb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
80103fb8:	c7 04 24 20 2d 11 80 	movl   $0x80112d20,(%esp)
80103fbf:	e8 ec 03 00 00       	call   801043b0 <release>
  return -1;
}
80103fc4:	83 c4 14             	add    $0x14,%esp
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
80103fc7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103fcc:	5b                   	pop    %ebx
80103fcd:	5d                   	pop    %ebp
80103fce:	c3                   	ret    
80103fcf:	90                   	nop

80103fd0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80103fd0:	55                   	push   %ebp
80103fd1:	89 e5                	mov    %esp,%ebp
80103fd3:	57                   	push   %edi
80103fd4:	56                   	push   %esi
80103fd5:	53                   	push   %ebx
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103fd6:	bb 54 2d 11 80       	mov    $0x80112d54,%ebx
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80103fdb:	83 ec 4c             	sub    $0x4c,%esp
//PAGEBREAK: 36
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
80103fde:	8d 7d e8             	lea    -0x18(%ebp),%edi
80103fe1:	eb 20                	jmp    80104003 <procdump+0x33>
80103fe3:	90                   	nop
80103fe4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80103fe8:	c7 04 24 fb 77 10 80 	movl   $0x801077fb,(%esp)
80103fef:	e8 5c c6 ff ff       	call   80100650 <cprintf>
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ff4:	83 c3 7c             	add    $0x7c,%ebx
80103ff7:	81 fb 54 4c 11 80    	cmp    $0x80114c54,%ebx
80103ffd:	0f 83 8d 00 00 00    	jae    80104090 <procdump+0xc0>
    if(p->state == UNUSED)
80104003:	8b 43 0c             	mov    0xc(%ebx),%eax
80104006:	85 c0                	test   %eax,%eax
80104008:	74 ea                	je     80103ff4 <procdump+0x24>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010400a:	83 f8 05             	cmp    $0x5,%eax
      state = states[p->state];
    else
      state = "???";
8010400d:	ba 90 74 10 80       	mov    $0x80107490,%edx
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104012:	77 11                	ja     80104025 <procdump+0x55>
80104014:	8b 14 85 f0 74 10 80 	mov    -0x7fef8b10(,%eax,4),%edx
      state = states[p->state];
    else
      state = "???";
8010401b:	b8 90 74 10 80       	mov    $0x80107490,%eax
80104020:	85 d2                	test   %edx,%edx
80104022:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104025:	8d 43 6c             	lea    0x6c(%ebx),%eax
80104028:	89 44 24 0c          	mov    %eax,0xc(%esp)
8010402c:	8b 43 10             	mov    0x10(%ebx),%eax
8010402f:	89 54 24 08          	mov    %edx,0x8(%esp)
80104033:	c7 04 24 94 74 10 80 	movl   $0x80107494,(%esp)
8010403a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010403e:	e8 0d c6 ff ff       	call   80100650 <cprintf>
    if(p->state == SLEEPING){
80104043:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
80104047:	75 9f                	jne    80103fe8 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104049:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010404c:	89 44 24 04          	mov    %eax,0x4(%esp)
80104050:	8b 43 1c             	mov    0x1c(%ebx),%eax
80104053:	8d 75 c0             	lea    -0x40(%ebp),%esi
80104056:	8b 40 0c             	mov    0xc(%eax),%eax
80104059:	83 c0 08             	add    $0x8,%eax
8010405c:	89 04 24             	mov    %eax,(%esp)
8010405f:	e8 8c 01 00 00       	call   801041f0 <getcallerpcs>
80104064:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
80104068:	8b 06                	mov    (%esi),%eax
8010406a:	85 c0                	test   %eax,%eax
8010406c:	0f 84 76 ff ff ff    	je     80103fe8 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104072:	83 c6 04             	add    $0x4,%esi
80104075:	89 44 24 04          	mov    %eax,0x4(%esp)
80104079:	c7 04 24 e1 6e 10 80 	movl   $0x80106ee1,(%esp)
80104080:	e8 cb c5 ff ff       	call   80100650 <cprintf>
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
80104085:	39 fe                	cmp    %edi,%esi
80104087:	75 df                	jne    80104068 <procdump+0x98>
80104089:	e9 5a ff ff ff       	jmp    80103fe8 <procdump+0x18>
8010408e:	66 90                	xchg   %ax,%ax
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
80104090:	83 c4 4c             	add    $0x4c,%esp
80104093:	5b                   	pop    %ebx
80104094:	5e                   	pop    %esi
80104095:	5f                   	pop    %edi
80104096:	5d                   	pop    %ebp
80104097:	c3                   	ret    
	...

801040a0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
801040a0:	55                   	push   %ebp
801040a1:	89 e5                	mov    %esp,%ebp
801040a3:	53                   	push   %ebx
801040a4:	83 ec 14             	sub    $0x14,%esp
801040a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
801040aa:	c7 44 24 04 08 75 10 	movl   $0x80107508,0x4(%esp)
801040b1:	80 
801040b2:	8d 43 04             	lea    0x4(%ebx),%eax
801040b5:	89 04 24             	mov    %eax,(%esp)
801040b8:	e8 13 01 00 00       	call   801041d0 <initlock>
  lk->name = name;
801040bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
801040c0:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801040c6:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)

void
initsleeplock(struct sleeplock *lk, char *name)
{
  initlock(&lk->lk, "sleep lock");
  lk->name = name;
801040cd:	89 43 38             	mov    %eax,0x38(%ebx)
  lk->locked = 0;
  lk->pid = 0;
}
801040d0:	83 c4 14             	add    $0x14,%esp
801040d3:	5b                   	pop    %ebx
801040d4:	5d                   	pop    %ebp
801040d5:	c3                   	ret    
801040d6:	8d 76 00             	lea    0x0(%esi),%esi
801040d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801040e0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
801040e0:	55                   	push   %ebp
801040e1:	89 e5                	mov    %esp,%ebp
801040e3:	56                   	push   %esi
801040e4:	53                   	push   %ebx
801040e5:	83 ec 10             	sub    $0x10,%esp
801040e8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801040eb:	8d 73 04             	lea    0x4(%ebx),%esi
801040ee:	89 34 24             	mov    %esi,(%esp)
801040f1:	e8 4a 02 00 00       	call   80104340 <acquire>
  while (lk->locked) {
801040f6:	8b 13                	mov    (%ebx),%edx
801040f8:	85 d2                	test   %edx,%edx
801040fa:	74 16                	je     80104112 <acquiresleep+0x32>
801040fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sleep(lk, &lk->lk);
80104100:	89 74 24 04          	mov    %esi,0x4(%esp)
80104104:	89 1c 24             	mov    %ebx,(%esp)
80104107:	e8 44 fc ff ff       	call   80103d50 <sleep>

void
acquiresleep(struct sleeplock *lk)
{
  acquire(&lk->lk);
  while (lk->locked) {
8010410c:	8b 03                	mov    (%ebx),%eax
8010410e:	85 c0                	test   %eax,%eax
80104110:	75 ee                	jne    80104100 <acquiresleep+0x20>
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
80104112:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104118:	e8 d3 f6 ff ff       	call   801037f0 <myproc>
8010411d:	8b 40 10             	mov    0x10(%eax),%eax
80104120:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104123:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104126:	83 c4 10             	add    $0x10,%esp
80104129:	5b                   	pop    %ebx
8010412a:	5e                   	pop    %esi
8010412b:	5d                   	pop    %ebp
  while (lk->locked) {
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
  lk->pid = myproc()->pid;
  release(&lk->lk);
8010412c:	e9 7f 02 00 00       	jmp    801043b0 <release>
80104131:	eb 0d                	jmp    80104140 <releasesleep>
80104133:	90                   	nop
80104134:	90                   	nop
80104135:	90                   	nop
80104136:	90                   	nop
80104137:	90                   	nop
80104138:	90                   	nop
80104139:	90                   	nop
8010413a:	90                   	nop
8010413b:	90                   	nop
8010413c:	90                   	nop
8010413d:	90                   	nop
8010413e:	90                   	nop
8010413f:	90                   	nop

80104140 <releasesleep>:
}

void
releasesleep(struct sleeplock *lk)
{
80104140:	55                   	push   %ebp
80104141:	89 e5                	mov    %esp,%ebp
80104143:	83 ec 18             	sub    $0x18,%esp
80104146:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80104149:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010414c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  acquire(&lk->lk);
8010414f:	8d 73 04             	lea    0x4(%ebx),%esi
80104152:	89 34 24             	mov    %esi,(%esp)
80104155:	e8 e6 01 00 00       	call   80104340 <acquire>
  lk->locked = 0;
8010415a:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80104160:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104167:	89 1c 24             	mov    %ebx,(%esp)
8010416a:	e8 81 fd ff ff       	call   80103ef0 <wakeup>
  release(&lk->lk);
}
8010416f:	8b 5d f8             	mov    -0x8(%ebp),%ebx
{
  acquire(&lk->lk);
  lk->locked = 0;
  lk->pid = 0;
  wakeup(lk);
  release(&lk->lk);
80104172:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104175:	8b 75 fc             	mov    -0x4(%ebp),%esi
80104178:	89 ec                	mov    %ebp,%esp
8010417a:	5d                   	pop    %ebp
{
  acquire(&lk->lk);
  lk->locked = 0;
  lk->pid = 0;
  wakeup(lk);
  release(&lk->lk);
8010417b:	e9 30 02 00 00       	jmp    801043b0 <release>

80104180 <holdingsleep>:
}

int
holdingsleep(struct sleeplock *lk)
{
80104180:	55                   	push   %ebp
80104181:	89 e5                	mov    %esp,%ebp
80104183:	83 ec 28             	sub    $0x28,%esp
80104186:	89 75 f8             	mov    %esi,-0x8(%ebp)
80104189:	8b 75 08             	mov    0x8(%ebp),%esi
8010418c:	89 5d f4             	mov    %ebx,-0xc(%ebp)
8010418f:	89 7d fc             	mov    %edi,-0x4(%ebp)
  int r;
  
  acquire(&lk->lk);
  r = lk->locked && (lk->pid == myproc()->pid);
80104192:	31 ff                	xor    %edi,%edi
int
holdingsleep(struct sleeplock *lk)
{
  int r;
  
  acquire(&lk->lk);
80104194:	8d 5e 04             	lea    0x4(%esi),%ebx
80104197:	89 1c 24             	mov    %ebx,(%esp)
8010419a:	e8 a1 01 00 00       	call   80104340 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
8010419f:	8b 0e                	mov    (%esi),%ecx
801041a1:	85 c9                	test   %ecx,%ecx
801041a3:	74 13                	je     801041b8 <holdingsleep+0x38>
801041a5:	8b 76 3c             	mov    0x3c(%esi),%esi
801041a8:	e8 43 f6 ff ff       	call   801037f0 <myproc>
801041ad:	3b 70 10             	cmp    0x10(%eax),%esi
801041b0:	0f 94 c0             	sete   %al
801041b3:	0f b6 c0             	movzbl %al,%eax
801041b6:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
801041b8:	89 1c 24             	mov    %ebx,(%esp)
801041bb:	e8 f0 01 00 00       	call   801043b0 <release>
  return r;
}
801041c0:	89 f8                	mov    %edi,%eax
801041c2:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801041c5:	8b 75 f8             	mov    -0x8(%ebp),%esi
801041c8:	8b 7d fc             	mov    -0x4(%ebp),%edi
801041cb:	89 ec                	mov    %ebp,%esp
801041cd:	5d                   	pop    %ebp
801041ce:	c3                   	ret    
	...

801041d0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
801041d0:	55                   	push   %ebp
801041d1:	89 e5                	mov    %esp,%ebp
801041d3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
801041d6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
801041d9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
  lk->name = name;
801041df:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
  lk->cpu = 0;
801041e2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
801041e9:	5d                   	pop    %ebp
801041ea:	c3                   	ret    
801041eb:	90                   	nop
801041ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801041f0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801041f0:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801041f1:	31 c0                	xor    %eax,%eax
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801041f3:	89 e5                	mov    %esp,%ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
801041f5:	8b 55 08             	mov    0x8(%ebp),%edx
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801041f8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801041fb:	53                   	push   %ebx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
801041fc:	83 ea 08             	sub    $0x8,%edx
801041ff:	90                   	nop
  for(i = 0; i < 10; i++){
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104200:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104206:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010420c:	77 1a                	ja     80104228 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010420e:	8b 5a 04             	mov    0x4(%edx),%ebx
80104211:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104214:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
80104217:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104219:	83 f8 0a             	cmp    $0xa,%eax
8010421c:	75 e2                	jne    80104200 <getcallerpcs+0x10>
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010421e:	5b                   	pop    %ebx
8010421f:	5d                   	pop    %ebp
80104220:	c3                   	ret    
80104221:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
80104228:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010422f:	83 c0 01             	add    $0x1,%eax
80104232:	83 f8 0a             	cmp    $0xa,%eax
80104235:	74 e7                	je     8010421e <getcallerpcs+0x2e>
    pcs[i] = 0;
80104237:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010423e:	83 c0 01             	add    $0x1,%eax
80104241:	83 f8 0a             	cmp    $0xa,%eax
80104244:	75 e2                	jne    80104228 <getcallerpcs+0x38>
80104246:	eb d6                	jmp    8010421e <getcallerpcs+0x2e>
80104248:	90                   	nop
80104249:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104250 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104250:	55                   	push   %ebp
80104251:	89 e5                	mov    %esp,%ebp
80104253:	53                   	push   %ebx
80104254:	83 ec 04             	sub    $0x4,%esp
80104257:	9c                   	pushf  
80104258:	5b                   	pop    %ebx
}

static inline void
cli(void)
{
  asm volatile("cli");
80104259:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010425a:	e8 f1 f4 ff ff       	call   80103750 <mycpu>
8010425f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104265:	85 c0                	test   %eax,%eax
80104267:	75 11                	jne    8010427a <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
80104269:	e8 e2 f4 ff ff       	call   80103750 <mycpu>
8010426e:	81 e3 00 02 00 00    	and    $0x200,%ebx
80104274:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
8010427a:	e8 d1 f4 ff ff       	call   80103750 <mycpu>
8010427f:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104286:	83 c4 04             	add    $0x4,%esp
80104289:	5b                   	pop    %ebx
8010428a:	5d                   	pop    %ebp
8010428b:	c3                   	ret    
8010428c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104290 <popcli>:

void
popcli(void)
{
80104290:	55                   	push   %ebp
80104291:	89 e5                	mov    %esp,%ebp
80104293:	83 ec 18             	sub    $0x18,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104296:	9c                   	pushf  
80104297:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104298:	f6 c4 02             	test   $0x2,%ah
8010429b:	75 49                	jne    801042e6 <popcli+0x56>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010429d:	e8 ae f4 ff ff       	call   80103750 <mycpu>
801042a2:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
801042a8:	83 ea 01             	sub    $0x1,%edx
801042ab:	85 d2                	test   %edx,%edx
801042ad:	89 90 a4 00 00 00    	mov    %edx,0xa4(%eax)
801042b3:	78 25                	js     801042da <popcli+0x4a>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
801042b5:	e8 96 f4 ff ff       	call   80103750 <mycpu>
801042ba:	8b 88 a4 00 00 00    	mov    0xa4(%eax),%ecx
801042c0:	85 c9                	test   %ecx,%ecx
801042c2:	74 04                	je     801042c8 <popcli+0x38>
    sti();
}
801042c4:	c9                   	leave  
801042c5:	c3                   	ret    
801042c6:	66 90                	xchg   %ax,%ax
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
801042c8:	e8 83 f4 ff ff       	call   80103750 <mycpu>
801042cd:	8b 90 a8 00 00 00    	mov    0xa8(%eax),%edx
801042d3:	85 d2                	test   %edx,%edx
801042d5:	74 ed                	je     801042c4 <popcli+0x34>
}

static inline void
sti(void)
{
  asm volatile("sti");
801042d7:	fb                   	sti    
    sti();
}
801042d8:	c9                   	leave  
801042d9:	c3                   	ret    
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
    panic("popcli");
801042da:	c7 04 24 2a 75 10 80 	movl   $0x8010752a,(%esp)
801042e1:	e8 8a c0 ff ff       	call   80100370 <panic>

void
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
801042e6:	c7 04 24 13 75 10 80 	movl   $0x80107513,(%esp)
801042ed:	e8 7e c0 ff ff       	call   80100370 <panic>
801042f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801042f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104300 <holding>:
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80104300:	55                   	push   %ebp
80104301:	89 e5                	mov    %esp,%ebp
80104303:	83 ec 08             	sub    $0x8,%esp
80104306:	89 75 fc             	mov    %esi,-0x4(%ebp)
80104309:	8b 75 08             	mov    0x8(%ebp),%esi
8010430c:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  int r;
  pushcli();
  r = lock->locked && lock->cpu == mycpu();
8010430f:	31 db                	xor    %ebx,%ebx
// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  int r;
  pushcli();
80104311:	e8 3a ff ff ff       	call   80104250 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104316:	8b 06                	mov    (%esi),%eax
80104318:	85 c0                	test   %eax,%eax
8010431a:	74 10                	je     8010432c <holding+0x2c>
8010431c:	8b 5e 08             	mov    0x8(%esi),%ebx
8010431f:	e8 2c f4 ff ff       	call   80103750 <mycpu>
80104324:	39 c3                	cmp    %eax,%ebx
80104326:	0f 94 c3             	sete   %bl
80104329:	0f b6 db             	movzbl %bl,%ebx
  popcli();
8010432c:	e8 5f ff ff ff       	call   80104290 <popcli>
  return r;
}
80104331:	89 d8                	mov    %ebx,%eax
80104333:	8b 75 fc             	mov    -0x4(%ebp),%esi
80104336:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80104339:	89 ec                	mov    %ebp,%esp
8010433b:	5d                   	pop    %ebp
8010433c:	c3                   	ret    
8010433d:	8d 76 00             	lea    0x0(%esi),%esi

80104340 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
80104340:	55                   	push   %ebp
80104341:	89 e5                	mov    %esp,%ebp
80104343:	53                   	push   %ebx
80104344:	83 ec 14             	sub    $0x14,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80104347:	e8 04 ff ff ff       	call   80104250 <pushcli>
  if(holding(lk))
8010434c:	8b 45 08             	mov    0x8(%ebp),%eax
8010434f:	89 04 24             	mov    %eax,(%esp)
80104352:	e8 a9 ff ff ff       	call   80104300 <holding>
80104357:	85 c0                	test   %eax,%eax
80104359:	75 3c                	jne    80104397 <acquire+0x57>
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
8010435b:	b9 01 00 00 00       	mov    $0x1,%ecx
    panic("acquire");

  // The xchg is atomic.
  while(xchg(&lk->locked, 1) != 0)
80104360:	8b 55 08             	mov    0x8(%ebp),%edx
80104363:	89 c8                	mov    %ecx,%eax
80104365:	f0 87 02             	lock xchg %eax,(%edx)
80104368:	85 c0                	test   %eax,%eax
8010436a:	75 f4                	jne    80104360 <acquire+0x20>
    ;

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();
8010436c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
80104371:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104374:	e8 d7 f3 ff ff       	call   80103750 <mycpu>
80104379:	89 43 08             	mov    %eax,0x8(%ebx)
  getcallerpcs(&lk, lk->pcs);
8010437c:	8b 45 08             	mov    0x8(%ebp),%eax
8010437f:	83 c0 0c             	add    $0xc,%eax
80104382:	89 44 24 04          	mov    %eax,0x4(%esp)
80104386:	8d 45 08             	lea    0x8(%ebp),%eax
80104389:	89 04 24             	mov    %eax,(%esp)
8010438c:	e8 5f fe ff ff       	call   801041f0 <getcallerpcs>
}
80104391:	83 c4 14             	add    $0x14,%esp
80104394:	5b                   	pop    %ebx
80104395:	5d                   	pop    %ebp
80104396:	c3                   	ret    
void
acquire(struct spinlock *lk)
{
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");
80104397:	c7 04 24 31 75 10 80 	movl   $0x80107531,(%esp)
8010439e:	e8 cd bf ff ff       	call   80100370 <panic>
801043a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801043a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801043b0 <release>:
}

// Release the lock.
void
release(struct spinlock *lk)
{
801043b0:	55                   	push   %ebp
801043b1:	89 e5                	mov    %esp,%ebp
801043b3:	53                   	push   %ebx
801043b4:	83 ec 14             	sub    $0x14,%esp
801043b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
801043ba:	89 1c 24             	mov    %ebx,(%esp)
801043bd:	e8 3e ff ff ff       	call   80104300 <holding>
801043c2:	85 c0                	test   %eax,%eax
801043c4:	74 23                	je     801043e9 <release+0x39>
    panic("release");

  lk->pcs[0] = 0;
801043c6:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
801043cd:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that all the stores in the critical
  // section are visible to other cores before the lock is released.
  // Both the C compiler and the hardware may re-order loads and
  // stores; __sync_synchronize() tells them both not to.
  __sync_synchronize();
801043d4:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
801043d9:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)

  popcli();
}
801043df:	83 c4 14             	add    $0x14,%esp
801043e2:	5b                   	pop    %ebx
801043e3:	5d                   	pop    %ebp
  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );

  popcli();
801043e4:	e9 a7 fe ff ff       	jmp    80104290 <popcli>
// Release the lock.
void
release(struct spinlock *lk)
{
  if(!holding(lk))
    panic("release");
801043e9:	c7 04 24 39 75 10 80 	movl   $0x80107539,(%esp)
801043f0:	e8 7b bf ff ff       	call   80100370 <panic>
	...

80104400 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104400:	55                   	push   %ebp
80104401:	89 e5                	mov    %esp,%ebp
80104403:	83 ec 08             	sub    $0x8,%esp
80104406:	8b 55 08             	mov    0x8(%ebp),%edx
80104409:	89 5d f8             	mov    %ebx,-0x8(%ebp)
8010440c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010440f:	89 7d fc             	mov    %edi,-0x4(%ebp)
80104412:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
80104415:	f6 c2 03             	test   $0x3,%dl
80104418:	75 05                	jne    8010441f <memset+0x1f>
8010441a:	f6 c1 03             	test   $0x3,%cl
8010441d:	74 11                	je     80104430 <memset+0x30>
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
8010441f:	89 d7                	mov    %edx,%edi
80104421:	fc                   	cld    
80104422:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80104424:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80104427:	89 d0                	mov    %edx,%eax
80104429:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010442c:	89 ec                	mov    %ebp,%esp
8010442e:	5d                   	pop    %ebp
8010442f:	c3                   	ret    

void*
memset(void *dst, int c, uint n)
{
  if ((int)dst%4 == 0 && n%4 == 0){
    c &= 0xFF;
80104430:	0f b6 f8             	movzbl %al,%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80104433:	89 f8                	mov    %edi,%eax
80104435:	89 fb                	mov    %edi,%ebx
80104437:	c1 e0 18             	shl    $0x18,%eax
8010443a:	c1 e3 10             	shl    $0x10,%ebx
8010443d:	09 d8                	or     %ebx,%eax
8010443f:	09 f8                	or     %edi,%eax
80104441:	c1 e7 08             	shl    $0x8,%edi
80104444:	09 f8                	or     %edi,%eax
}

static inline void
stosl(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosl" :
80104446:	89 d7                	mov    %edx,%edi
80104448:	c1 e9 02             	shr    $0x2,%ecx
8010444b:	fc                   	cld    
8010444c:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
8010444e:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80104451:	89 d0                	mov    %edx,%eax
80104453:	8b 7d fc             	mov    -0x4(%ebp),%edi
80104456:	89 ec                	mov    %ebp,%esp
80104458:	5d                   	pop    %ebp
80104459:	c3                   	ret    
8010445a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104460 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104460:	55                   	push   %ebp
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
80104461:	31 c0                	xor    %eax,%eax
  return dst;
}

int
memcmp(const void *v1, const void *v2, uint n)
{
80104463:	89 e5                	mov    %esp,%ebp
80104465:	57                   	push   %edi
80104466:	8b 7d 10             	mov    0x10(%ebp),%edi
80104469:	56                   	push   %esi
8010446a:	8b 75 0c             	mov    0xc(%ebp),%esi
8010446d:	53                   	push   %ebx
8010446e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104471:	85 ff                	test   %edi,%edi
80104473:	74 29                	je     8010449e <memcmp+0x3e>
    if(*s1 != *s2)
80104475:	0f b6 03             	movzbl (%ebx),%eax
{
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104478:	83 ef 01             	sub    $0x1,%edi
8010447b:	31 d2                	xor    %edx,%edx
    if(*s1 != *s2)
8010447d:	0f b6 0e             	movzbl (%esi),%ecx
80104480:	38 c8                	cmp    %cl,%al
80104482:	74 14                	je     80104498 <memcmp+0x38>
80104484:	eb 22                	jmp    801044a8 <memcmp+0x48>
80104486:	66 90                	xchg   %ax,%ax
80104488:	0f b6 44 13 01       	movzbl 0x1(%ebx,%edx,1),%eax
8010448d:	83 c2 01             	add    $0x1,%edx
80104490:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
80104494:	38 c8                	cmp    %cl,%al
80104496:	75 10                	jne    801044a8 <memcmp+0x48>
{
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104498:	39 d7                	cmp    %edx,%edi
8010449a:	75 ec                	jne    80104488 <memcmp+0x28>
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
8010449c:	31 c0                	xor    %eax,%eax
}
8010449e:	5b                   	pop    %ebx
8010449f:	5e                   	pop    %esi
801044a0:	5f                   	pop    %edi
801044a1:	5d                   	pop    %ebp
801044a2:	c3                   	ret    
801044a3:	90                   	nop
801044a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
801044a8:	0f b6 c0             	movzbl %al,%eax
801044ab:	0f b6 c9             	movzbl %cl,%ecx
    s1++, s2++;
  }

  return 0;
}
801044ae:	5b                   	pop    %ebx

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
801044af:	29 c8                	sub    %ecx,%eax
    s1++, s2++;
  }

  return 0;
}
801044b1:	5e                   	pop    %esi
801044b2:	5f                   	pop    %edi
801044b3:	5d                   	pop    %ebp
801044b4:	c3                   	ret    
801044b5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801044b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801044c0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
801044c0:	55                   	push   %ebp
801044c1:	89 e5                	mov    %esp,%ebp
801044c3:	57                   	push   %edi
801044c4:	8b 45 08             	mov    0x8(%ebp),%eax
801044c7:	56                   	push   %esi
801044c8:	8b 75 0c             	mov    0xc(%ebp),%esi
801044cb:	53                   	push   %ebx
801044cc:	8b 5d 10             	mov    0x10(%ebp),%ebx
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
801044cf:	39 c6                	cmp    %eax,%esi
801044d1:	73 35                	jae    80104508 <memmove+0x48>
801044d3:	8d 0c 1e             	lea    (%esi,%ebx,1),%ecx
801044d6:	39 c8                	cmp    %ecx,%eax
801044d8:	73 2e                	jae    80104508 <memmove+0x48>
    s += n;
    d += n;
    while(n-- > 0)
801044da:	85 db                	test   %ebx,%ebx
801044dc:	74 20                	je     801044fe <memmove+0x3e>

  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
801044de:	8d 3c 18             	lea    (%eax,%ebx,1),%edi
801044e1:	89 da                	mov    %ebx,%edx

  return 0;
}

void*
memmove(void *dst, const void *src, uint n)
801044e3:	f7 db                	neg    %ebx
801044e5:	8d 34 19             	lea    (%ecx,%ebx,1),%esi
801044e8:	01 fb                	add    %edi,%ebx
801044ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
801044f0:	0f b6 4c 16 ff       	movzbl -0x1(%esi,%edx,1),%ecx
801044f5:	88 4c 13 ff          	mov    %cl,-0x1(%ebx,%edx,1)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
801044f9:	83 ea 01             	sub    $0x1,%edx
801044fc:	75 f2                	jne    801044f0 <memmove+0x30>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
801044fe:	5b                   	pop    %ebx
801044ff:	5e                   	pop    %esi
80104500:	5f                   	pop    %edi
80104501:	5d                   	pop    %ebp
80104502:	c3                   	ret    
80104503:	90                   	nop
80104504:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
80104508:	31 d2                	xor    %edx,%edx
8010450a:	85 db                	test   %ebx,%ebx
8010450c:	74 f0                	je     801044fe <memmove+0x3e>
8010450e:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80104510:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
80104514:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104517:	83 c2 01             	add    $0x1,%edx
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
8010451a:	39 d3                	cmp    %edx,%ebx
8010451c:	75 f2                	jne    80104510 <memmove+0x50>
      *d++ = *s++;

  return dst;
}
8010451e:	5b                   	pop    %ebx
8010451f:	5e                   	pop    %esi
80104520:	5f                   	pop    %edi
80104521:	5d                   	pop    %ebp
80104522:	c3                   	ret    
80104523:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104529:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104530 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104530:	55                   	push   %ebp
80104531:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80104533:	5d                   	pop    %ebp

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80104534:	e9 87 ff ff ff       	jmp    801044c0 <memmove>
80104539:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104540 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80104540:	55                   	push   %ebp
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
80104541:	31 c0                	xor    %eax,%eax
  return memmove(dst, src, n);
}

int
strncmp(const char *p, const char *q, uint n)
{
80104543:	89 e5                	mov    %esp,%ebp
  while(n > 0 && *p && *p == *q)
80104545:	8b 55 10             	mov    0x10(%ebp),%edx
  return memmove(dst, src, n);
}

int
strncmp(const char *p, const char *q, uint n)
{
80104548:	57                   	push   %edi
80104549:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010454c:	56                   	push   %esi
8010454d:	53                   	push   %ebx
8010454e:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while(n > 0 && *p && *p == *q)
80104551:	85 d2                	test   %edx,%edx
80104553:	74 34                	je     80104589 <strncmp+0x49>
80104555:	0f b6 01             	movzbl (%ecx),%eax
80104558:	0f b6 33             	movzbl (%ebx),%esi
8010455b:	84 c0                	test   %al,%al
8010455d:	74 31                	je     80104590 <strncmp+0x50>
8010455f:	89 f2                	mov    %esi,%edx
80104561:	38 d0                	cmp    %dl,%al
80104563:	74 1c                	je     80104581 <strncmp+0x41>
80104565:	eb 29                	jmp    80104590 <strncmp+0x50>
80104567:	90                   	nop
    n--, p++, q++;
80104568:	83 c1 01             	add    $0x1,%ecx
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
8010456b:	0f b6 73 01          	movzbl 0x1(%ebx),%esi
8010456f:	0f b6 01             	movzbl (%ecx),%eax
    n--, p++, q++;
80104572:	8d 7b 01             	lea    0x1(%ebx),%edi
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
80104575:	84 c0                	test   %al,%al
80104577:	74 17                	je     80104590 <strncmp+0x50>
80104579:	89 f2                	mov    %esi,%edx
8010457b:	38 d0                	cmp    %dl,%al
8010457d:	75 11                	jne    80104590 <strncmp+0x50>
    n--, p++, q++;
8010457f:	89 fb                	mov    %edi,%ebx
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
80104581:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80104585:	75 e1                	jne    80104568 <strncmp+0x28>
    n--, p++, q++;
  if(n == 0)
    return 0;
80104587:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}
80104589:	5b                   	pop    %ebx
8010458a:	5e                   	pop    %esi
8010458b:	5f                   	pop    %edi
8010458c:	5d                   	pop    %ebp
8010458d:	c3                   	ret    
8010458e:	66 90                	xchg   %ax,%ax
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
80104590:	81 e6 ff 00 00 00    	and    $0xff,%esi
80104596:	0f b6 c0             	movzbl %al,%eax
}
80104599:	5b                   	pop    %ebx
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
8010459a:	29 f0                	sub    %esi,%eax
}
8010459c:	5e                   	pop    %esi
8010459d:	5f                   	pop    %edi
8010459e:	5d                   	pop    %ebp
8010459f:	c3                   	ret    

801045a0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
801045a0:	55                   	push   %ebp
801045a1:	89 e5                	mov    %esp,%ebp
801045a3:	57                   	push   %edi
801045a4:	8b 7d 08             	mov    0x8(%ebp),%edi
801045a7:	56                   	push   %esi
801045a8:	8b 4d 10             	mov    0x10(%ebp),%ecx
801045ab:	53                   	push   %ebx
801045ac:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
801045af:	89 fa                	mov    %edi,%edx
801045b1:	eb 14                	jmp    801045c7 <strncpy+0x27>
801045b3:	90                   	nop
801045b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801045b8:	0f b6 03             	movzbl (%ebx),%eax
801045bb:	83 c3 01             	add    $0x1,%ebx
801045be:	88 02                	mov    %al,(%edx)
801045c0:	83 c2 01             	add    $0x1,%edx
801045c3:	84 c0                	test   %al,%al
801045c5:	74 0a                	je     801045d1 <strncpy+0x31>
801045c7:	83 e9 01             	sub    $0x1,%ecx
    return 0;
  return (uchar)*p - (uchar)*q;
}

char*
strncpy(char *s, const char *t, int n)
801045ca:	8d 71 01             	lea    0x1(%ecx),%esi
{
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
801045cd:	85 f6                	test   %esi,%esi
801045cf:	7f e7                	jg     801045b8 <strncpy+0x18>
    ;
  while(n-- > 0)
801045d1:	85 c9                	test   %ecx,%ecx
    return 0;
  return (uchar)*p - (uchar)*q;
}

char*
strncpy(char *s, const char *t, int n)
801045d3:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
801045d6:	7e 0a                	jle    801045e2 <strncpy+0x42>
    *s++ = 0;
801045d8:	c6 02 00             	movb   $0x0,(%edx)
801045db:	83 c2 01             	add    $0x1,%edx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
801045de:	39 c2                	cmp    %eax,%edx
801045e0:	75 f6                	jne    801045d8 <strncpy+0x38>
    *s++ = 0;
  return os;
}
801045e2:	5b                   	pop    %ebx
801045e3:	89 f8                	mov    %edi,%eax
801045e5:	5e                   	pop    %esi
801045e6:	5f                   	pop    %edi
801045e7:	5d                   	pop    %ebp
801045e8:	c3                   	ret    
801045e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801045f0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
801045f0:	55                   	push   %ebp
801045f1:	89 e5                	mov    %esp,%ebp
801045f3:	8b 55 10             	mov    0x10(%ebp),%edx
801045f6:	56                   	push   %esi
801045f7:	8b 75 08             	mov    0x8(%ebp),%esi
801045fa:	53                   	push   %ebx
801045fb:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *os;

  os = s;
  if(n <= 0)
801045fe:	85 d2                	test   %edx,%edx
80104600:	7e 1d                	jle    8010461f <safestrcpy+0x2f>
80104602:	89 f1                	mov    %esi,%ecx
80104604:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104608:	83 ea 01             	sub    $0x1,%edx
8010460b:	74 0f                	je     8010461c <safestrcpy+0x2c>
8010460d:	0f b6 03             	movzbl (%ebx),%eax
80104610:	83 c3 01             	add    $0x1,%ebx
80104613:	88 01                	mov    %al,(%ecx)
80104615:	83 c1 01             	add    $0x1,%ecx
80104618:	84 c0                	test   %al,%al
8010461a:	75 ec                	jne    80104608 <safestrcpy+0x18>
    ;
  *s = 0;
8010461c:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
8010461f:	89 f0                	mov    %esi,%eax
80104621:	5b                   	pop    %ebx
80104622:	5e                   	pop    %esi
80104623:	5d                   	pop    %ebp
80104624:	c3                   	ret    
80104625:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104630 <strlen>:

int
strlen(const char *s)
{
80104630:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104631:	31 c0                	xor    %eax,%eax
  return os;
}

int
strlen(const char *s)
{
80104633:	89 e5                	mov    %esp,%ebp
80104635:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
80104638:	80 3a 00             	cmpb   $0x0,(%edx)
8010463b:	74 0c                	je     80104649 <strlen+0x19>
8010463d:	8d 76 00             	lea    0x0(%esi),%esi
80104640:	83 c0 01             	add    $0x1,%eax
80104643:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104647:	75 f7                	jne    80104640 <strlen+0x10>
    ;
  return n;
}
80104649:	5d                   	pop    %ebp
8010464a:	c3                   	ret    
	...

8010464c <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
8010464c:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80104650:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80104654:	55                   	push   %ebp
  pushl %ebx
80104655:	53                   	push   %ebx
  pushl %esi
80104656:	56                   	push   %esi
  pushl %edi
80104657:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104658:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
8010465a:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
8010465c:	5f                   	pop    %edi
  popl %esi
8010465d:	5e                   	pop    %esi
  popl %ebx
8010465e:	5b                   	pop    %ebx
  popl %ebp
8010465f:	5d                   	pop    %ebp
  ret
80104660:	c3                   	ret    
	...

80104670 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104670:	55                   	push   %ebp
80104671:	89 e5                	mov    %esp,%ebp
80104673:	53                   	push   %ebx
80104674:	83 ec 04             	sub    $0x4,%esp
80104677:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
8010467a:	e8 71 f1 ff ff       	call   801037f0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010467f:	8b 10                	mov    (%eax),%edx
    return -1;
80104681:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
int
fetchint(uint addr, int *ip)
{
  struct proc *curproc = myproc();

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104686:	39 da                	cmp    %ebx,%edx
80104688:	76 10                	jbe    8010469a <fetchint+0x2a>
8010468a:	8d 4b 04             	lea    0x4(%ebx),%ecx
8010468d:	39 ca                	cmp    %ecx,%edx
8010468f:	72 09                	jb     8010469a <fetchint+0x2a>
    return -1;
  *ip = *(int*)(addr);
80104691:	8b 45 0c             	mov    0xc(%ebp),%eax
80104694:	8b 13                	mov    (%ebx),%edx
80104696:	89 10                	mov    %edx,(%eax)
  return 0;
80104698:	31 c0                	xor    %eax,%eax
}
8010469a:	83 c4 04             	add    $0x4,%esp
8010469d:	5b                   	pop    %ebx
8010469e:	5d                   	pop    %ebp
8010469f:	c3                   	ret    

801046a0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
801046a0:	55                   	push   %ebp
801046a1:	89 e5                	mov    %esp,%ebp
801046a3:	53                   	push   %ebx
801046a4:	83 ec 04             	sub    $0x4,%esp
801046a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
801046aa:	e8 41 f1 ff ff       	call   801037f0 <myproc>

  if(addr >= curproc->sz)
    return -1;
801046af:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
fetchstr(uint addr, char **pp)
{
  char *s, *ep;
  struct proc *curproc = myproc();

  if(addr >= curproc->sz)
801046b4:	39 18                	cmp    %ebx,(%eax)
801046b6:	76 29                	jbe    801046e1 <fetchstr+0x41>
    return -1;
  *pp = (char*)addr;
801046b8:	8b 55 0c             	mov    0xc(%ebp),%edx
801046bb:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
801046bd:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
801046bf:	39 d3                	cmp    %edx,%ebx
801046c1:	73 1e                	jae    801046e1 <fetchstr+0x41>
    if(*s == 0)
801046c3:	31 c9                	xor    %ecx,%ecx
801046c5:	89 d8                	mov    %ebx,%eax
801046c7:	80 3b 00             	cmpb   $0x0,(%ebx)
801046ca:	75 09                	jne    801046d5 <fetchstr+0x35>
801046cc:	eb 13                	jmp    801046e1 <fetchstr+0x41>
801046ce:	66 90                	xchg   %ax,%ax
801046d0:	80 38 00             	cmpb   $0x0,(%eax)
801046d3:	74 1b                	je     801046f0 <fetchstr+0x50>

  if(addr >= curproc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
801046d5:	83 c0 01             	add    $0x1,%eax
801046d8:	39 c2                	cmp    %eax,%edx
801046da:	77 f4                	ja     801046d0 <fetchstr+0x30>
    if(*s == 0)
      return s - *pp;
  }
  return -1;
801046dc:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
}
801046e1:	83 c4 04             	add    $0x4,%esp
801046e4:	89 c8                	mov    %ecx,%eax
801046e6:	5b                   	pop    %ebx
801046e7:	5d                   	pop    %ebp
801046e8:	c3                   	ret    
801046e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(addr >= curproc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
    if(*s == 0)
801046f0:	89 c1                	mov    %eax,%ecx
      return s - *pp;
  }
  return -1;
}
801046f2:	83 c4 04             	add    $0x4,%esp
  if(addr >= curproc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)curproc->sz;
  for(s = *pp; s < ep; s++){
    if(*s == 0)
801046f5:	29 d9                	sub    %ebx,%ecx
      return s - *pp;
  }
  return -1;
}
801046f7:	89 c8                	mov    %ecx,%eax
801046f9:	5b                   	pop    %ebx
801046fa:	5d                   	pop    %ebp
801046fb:	c3                   	ret    
801046fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104700 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104700:	55                   	push   %ebp
80104701:	89 e5                	mov    %esp,%ebp
80104703:	83 ec 08             	sub    $0x8,%esp
80104706:	89 5d f8             	mov    %ebx,-0x8(%ebp)
80104709:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010470c:	89 75 fc             	mov    %esi,-0x4(%ebp)
8010470f:	8b 75 0c             	mov    0xc(%ebp),%esi
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104712:	e8 d9 f0 ff ff       	call   801037f0 <myproc>
80104717:	89 75 0c             	mov    %esi,0xc(%ebp)
}
8010471a:	8b 75 fc             	mov    -0x4(%ebp),%esi

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010471d:	8b 40 18             	mov    0x18(%eax),%eax
80104720:	8b 40 44             	mov    0x44(%eax),%eax
80104723:	8d 44 98 04          	lea    0x4(%eax,%ebx,4),%eax
}
80104727:	8b 5d f8             	mov    -0x8(%ebp),%ebx

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010472a:	89 45 08             	mov    %eax,0x8(%ebp)
}
8010472d:	89 ec                	mov    %ebp,%esp
8010472f:	5d                   	pop    %ebp

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104730:	e9 3b ff ff ff       	jmp    80104670 <fetchint>
80104735:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104739:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104740 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104740:	55                   	push   %ebp
80104741:	89 e5                	mov    %esp,%ebp
80104743:	56                   	push   %esi
80104744:	53                   	push   %ebx
80104745:	83 ec 20             	sub    $0x20,%esp
80104748:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
8010474b:	e8 a0 f0 ff ff       	call   801037f0 <myproc>
80104750:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80104752:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104755:	89 44 24 04          	mov    %eax,0x4(%esp)
80104759:	8b 45 08             	mov    0x8(%ebp),%eax
8010475c:	89 04 24             	mov    %eax,(%esp)
8010475f:	e8 9c ff ff ff       	call   80104700 <argint>
80104764:	85 c0                	test   %eax,%eax
80104766:	78 28                	js     80104790 <argptr+0x50>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104768:	85 db                	test   %ebx,%ebx
8010476a:	78 24                	js     80104790 <argptr+0x50>
8010476c:	8b 55 f4             	mov    -0xc(%ebp),%edx
    return -1;
8010476f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  int i;
  struct proc *curproc = myproc();
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104774:	8b 0e                	mov    (%esi),%ecx
80104776:	39 ca                	cmp    %ecx,%edx
80104778:	73 0d                	jae    80104787 <argptr+0x47>
8010477a:	01 d3                	add    %edx,%ebx
8010477c:	39 d9                	cmp    %ebx,%ecx
8010477e:	72 07                	jb     80104787 <argptr+0x47>
    return -1;
  *pp = (char*)i;
80104780:	8b 45 0c             	mov    0xc(%ebp),%eax
80104783:	89 10                	mov    %edx,(%eax)
  return 0;
80104785:	31 c0                	xor    %eax,%eax
}
80104787:	83 c4 20             	add    $0x20,%esp
8010478a:	5b                   	pop    %ebx
8010478b:	5e                   	pop    %esi
8010478c:	5d                   	pop    %ebp
8010478d:	c3                   	ret    
8010478e:	66 90                	xchg   %ax,%ax
  struct proc *curproc = myproc();
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
    return -1;
80104790:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104795:	eb f0                	jmp    80104787 <argptr+0x47>
80104797:	89 f6                	mov    %esi,%esi
80104799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801047a0 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
801047a0:	55                   	push   %ebp
801047a1:	89 e5                	mov    %esp,%ebp
801047a3:	83 ec 28             	sub    $0x28,%esp
  int addr;
  if(argint(n, &addr) < 0)
801047a6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801047a9:	89 44 24 04          	mov    %eax,0x4(%esp)
801047ad:	8b 45 08             	mov    0x8(%ebp),%eax
801047b0:	89 04 24             	mov    %eax,(%esp)
801047b3:	e8 48 ff ff ff       	call   80104700 <argint>
801047b8:	89 c2                	mov    %eax,%edx
    return -1;
801047ba:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
  int addr;
  if(argint(n, &addr) < 0)
801047bf:	85 d2                	test   %edx,%edx
801047c1:	78 12                	js     801047d5 <argstr+0x35>
    return -1;
  return fetchstr(addr, pp);
801047c3:	8b 45 0c             	mov    0xc(%ebp),%eax
801047c6:	89 44 24 04          	mov    %eax,0x4(%esp)
801047ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
801047cd:	89 04 24             	mov    %eax,(%esp)
801047d0:	e8 cb fe ff ff       	call   801046a0 <fetchstr>
}
801047d5:	c9                   	leave  
801047d6:	c3                   	ret    
801047d7:	89 f6                	mov    %esi,%esi
801047d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801047e0 <syscall>:
[SYS_close]   sys_close,
};

void
syscall(void)
{
801047e0:	55                   	push   %ebp
801047e1:	89 e5                	mov    %esp,%ebp
801047e3:	83 ec 18             	sub    $0x18,%esp
801047e6:	89 5d f8             	mov    %ebx,-0x8(%ebp)
801047e9:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int num;
  struct proc *curproc = myproc();
801047ec:	e8 ff ef ff ff       	call   801037f0 <myproc>

  num = curproc->tf->eax;
801047f1:	8b 58 18             	mov    0x18(%eax),%ebx

void
syscall(void)
{
  int num;
  struct proc *curproc = myproc();
801047f4:	89 c6                	mov    %eax,%esi

  num = curproc->tf->eax;
801047f6:	8b 43 1c             	mov    0x1c(%ebx),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
801047f9:	8d 50 ff             	lea    -0x1(%eax),%edx
801047fc:	83 fa 15             	cmp    $0x15,%edx
801047ff:	77 1f                	ja     80104820 <syscall+0x40>
80104801:	8b 14 85 60 75 10 80 	mov    -0x7fef8aa0(,%eax,4),%edx
80104808:	85 d2                	test   %edx,%edx
8010480a:	74 14                	je     80104820 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
8010480c:	ff d2                	call   *%edx
8010480e:	89 43 1c             	mov    %eax,0x1c(%ebx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80104811:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80104814:	8b 75 fc             	mov    -0x4(%ebp),%esi
80104817:	89 ec                	mov    %ebp,%esp
80104819:	5d                   	pop    %ebp
8010481a:	c3                   	ret    
8010481b:	90                   	nop
8010481c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80104820:	89 44 24 0c          	mov    %eax,0xc(%esp)
            curproc->pid, curproc->name, num);
80104824:	8d 46 6c             	lea    0x6c(%esi),%eax
80104827:	89 44 24 08          	mov    %eax,0x8(%esp)

  num = curproc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    curproc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
8010482b:	8b 46 10             	mov    0x10(%esi),%eax
8010482e:	c7 04 24 41 75 10 80 	movl   $0x80107541,(%esp)
80104835:	89 44 24 04          	mov    %eax,0x4(%esp)
80104839:	e8 12 be ff ff       	call   80100650 <cprintf>
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
8010483e:	8b 46 18             	mov    0x18(%esi),%eax
80104841:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
80104848:	8b 5d f8             	mov    -0x8(%ebp),%ebx
8010484b:	8b 75 fc             	mov    -0x4(%ebp),%esi
8010484e:	89 ec                	mov    %ebp,%esp
80104850:	5d                   	pop    %ebp
80104851:	c3                   	ret    
	...

80104860 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104860:	55                   	push   %ebp
80104861:	89 e5                	mov    %esp,%ebp
80104863:	83 ec 58             	sub    $0x58,%esp
80104866:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
80104869:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010486c:	89 75 f8             	mov    %esi,-0x8(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
8010486f:	8d 75 d6             	lea    -0x2a(%ebp),%esi
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104872:	89 7d fc             	mov    %edi,-0x4(%ebp)
80104875:	89 d7                	mov    %edx,%edi
80104877:	89 5d f4             	mov    %ebx,-0xc(%ebp)
8010487a:	89 4d c0             	mov    %ecx,-0x40(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
8010487d:	89 74 24 04          	mov    %esi,0x4(%esp)
80104881:	89 04 24             	mov    %eax,(%esp)
80104884:	e8 c7 d7 ff ff       	call   80102050 <nameiparent>
80104889:	85 c0                	test   %eax,%eax
8010488b:	0f 84 07 01 00 00    	je     80104998 <create+0x138>
    return 0;
  ilock(dp);
80104891:	89 04 24             	mov    %eax,(%esp)
80104894:	89 45 bc             	mov    %eax,-0x44(%ebp)
80104897:	e8 24 ce ff ff       	call   801016c0 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
8010489c:	8b 55 bc             	mov    -0x44(%ebp),%edx
8010489f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801048a2:	89 44 24 08          	mov    %eax,0x8(%esp)
801048a6:	89 74 24 04          	mov    %esi,0x4(%esp)
801048aa:	89 14 24             	mov    %edx,(%esp)
801048ad:	e8 3e d4 ff ff       	call   80101cf0 <dirlookup>
801048b2:	8b 55 bc             	mov    -0x44(%ebp),%edx
801048b5:	85 c0                	test   %eax,%eax
801048b7:	89 c3                	mov    %eax,%ebx
801048b9:	74 55                	je     80104910 <create+0xb0>
    iunlockput(dp);
801048bb:	89 14 24             	mov    %edx,(%esp)
801048be:	e8 ad d0 ff ff       	call   80101970 <iunlockput>
    ilock(ip);
801048c3:	89 1c 24             	mov    %ebx,(%esp)
801048c6:	e8 f5 cd ff ff       	call   801016c0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
801048cb:	66 83 ff 02          	cmp    $0x2,%di
801048cf:	74 1f                	je     801048f0 <create+0x90>
      return ip;
    if(type == T_SMALL && ip->type == T_SMALL)
801048d1:	66 83 ff 04          	cmp    $0x4,%di
801048d5:	75 20                	jne    801048f7 <create+0x97>
801048d7:	66 83 7b 50 04       	cmpw   $0x4,0x50(%ebx)
801048dc:	75 19                	jne    801048f7 <create+0x97>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
801048de:	89 d8                	mov    %ebx,%eax
801048e0:	8b 75 f8             	mov    -0x8(%ebp),%esi
801048e3:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801048e6:	8b 7d fc             	mov    -0x4(%ebp),%edi
801048e9:	89 ec                	mov    %ebp,%esp
801048eb:	5d                   	pop    %ebp
801048ec:	c3                   	ret    
801048ed:	8d 76 00             	lea    0x0(%esi),%esi
  ilock(dp);

  if((ip = dirlookup(dp, name, &off)) != 0){
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
801048f0:	66 83 7b 50 02       	cmpw   $0x2,0x50(%ebx)
801048f5:	74 e7                	je     801048de <create+0x7e>
      return ip;
    if(type == T_SMALL && ip->type == T_SMALL)
      return ip;
    iunlockput(ip);
801048f7:	89 1c 24             	mov    %ebx,(%esp)
    return 0;
801048fa:	31 db                	xor    %ebx,%ebx
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    if(type == T_SMALL && ip->type == T_SMALL)
      return ip;
    iunlockput(ip);
801048fc:	e8 6f d0 ff ff       	call   80101970 <iunlockput>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104901:	89 d8                	mov    %ebx,%eax
80104903:	8b 75 f8             	mov    -0x8(%ebp),%esi
80104906:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80104909:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010490c:	89 ec                	mov    %ebp,%esp
8010490e:	5d                   	pop    %ebp
8010490f:	c3                   	ret    
      return ip;
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80104910:	0f bf c7             	movswl %di,%eax
80104913:	89 44 24 04          	mov    %eax,0x4(%esp)
80104917:	8b 02                	mov    (%edx),%eax
80104919:	89 55 bc             	mov    %edx,-0x44(%ebp)
8010491c:	89 04 24             	mov    %eax,(%esp)
8010491f:	e8 0c cc ff ff       	call   80101530 <ialloc>
80104924:	8b 55 bc             	mov    -0x44(%ebp),%edx
80104927:	85 c0                	test   %eax,%eax
80104929:	89 c3                	mov    %eax,%ebx
8010492b:	0f 84 d7 00 00 00    	je     80104a08 <create+0x1a8>
    panic("create: ialloc");

  ilock(ip);
80104931:	89 55 bc             	mov    %edx,-0x44(%ebp)
80104934:	89 04 24             	mov    %eax,(%esp)
80104937:	e8 84 cd ff ff       	call   801016c0 <ilock>
  ip->major = major;
8010493c:	0f b7 45 c4          	movzwl -0x3c(%ebp),%eax
  ip->minor = minor;
80104940:	0f b7 4d c0          	movzwl -0x40(%ebp),%ecx
  ip->nlink = 1;
80104944:	66 c7 43 56 01 00    	movw   $0x1,0x56(%ebx)

  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");

  ilock(ip);
  ip->major = major;
8010494a:	66 89 43 52          	mov    %ax,0x52(%ebx)
  ip->minor = minor;
8010494e:	66 89 4b 54          	mov    %cx,0x54(%ebx)
  ip->nlink = 1;
  iupdate(ip);
80104952:	89 1c 24             	mov    %ebx,(%esp)
80104955:	e8 a6 cc ff ff       	call   80101600 <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
8010495a:	66 83 ff 01          	cmp    $0x1,%di
8010495e:	8b 55 bc             	mov    -0x44(%ebp),%edx
80104961:	74 3d                	je     801049a0 <create+0x140>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
80104963:	8b 43 04             	mov    0x4(%ebx),%eax
80104966:	89 14 24             	mov    %edx,(%esp)
80104969:	89 55 bc             	mov    %edx,-0x44(%ebp)
8010496c:	89 74 24 04          	mov    %esi,0x4(%esp)
80104970:	89 44 24 08          	mov    %eax,0x8(%esp)
80104974:	e8 d7 d5 ff ff       	call   80101f50 <dirlink>
80104979:	8b 55 bc             	mov    -0x44(%ebp),%edx
8010497c:	85 c0                	test   %eax,%eax
8010497e:	78 7c                	js     801049fc <create+0x19c>
    panic("create: dirlink");

  iunlockput(dp);
80104980:	89 14 24             	mov    %edx,(%esp)
80104983:	e8 e8 cf ff ff       	call   80101970 <iunlockput>

  return ip;
}
80104988:	89 d8                	mov    %ebx,%eax
8010498a:	8b 75 f8             	mov    -0x8(%ebp),%esi
8010498d:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80104990:	8b 7d fc             	mov    -0x4(%ebp),%edi
80104993:	89 ec                	mov    %ebp,%esp
80104995:	5d                   	pop    %ebp
80104996:	c3                   	ret    
80104997:	90                   	nop
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    return 0;
80104998:	31 db                	xor    %ebx,%ebx
8010499a:	e9 3f ff ff ff       	jmp    801048de <create+0x7e>
8010499f:	90                   	nop
  ip->minor = minor;
  ip->nlink = 1;
  iupdate(ip);

  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
801049a0:	66 83 42 56 01       	addw   $0x1,0x56(%edx)
    iupdate(dp);
801049a5:	89 14 24             	mov    %edx,(%esp)
801049a8:	89 55 bc             	mov    %edx,-0x44(%ebp)
801049ab:	e8 50 cc ff ff       	call   80101600 <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
801049b0:	8b 43 04             	mov    0x4(%ebx),%eax
801049b3:	c7 44 24 04 cc 75 10 	movl   $0x801075cc,0x4(%esp)
801049ba:	80 
801049bb:	89 1c 24             	mov    %ebx,(%esp)
801049be:	89 44 24 08          	mov    %eax,0x8(%esp)
801049c2:	e8 89 d5 ff ff       	call   80101f50 <dirlink>
801049c7:	8b 55 bc             	mov    -0x44(%ebp),%edx
801049ca:	85 c0                	test   %eax,%eax
801049cc:	78 22                	js     801049f0 <create+0x190>
801049ce:	8b 42 04             	mov    0x4(%edx),%eax
801049d1:	c7 44 24 04 cb 75 10 	movl   $0x801075cb,0x4(%esp)
801049d8:	80 
801049d9:	89 1c 24             	mov    %ebx,(%esp)
801049dc:	89 44 24 08          	mov    %eax,0x8(%esp)
801049e0:	e8 6b d5 ff ff       	call   80101f50 <dirlink>
801049e5:	8b 55 bc             	mov    -0x44(%ebp),%edx
801049e8:	85 c0                	test   %eax,%eax
801049ea:	0f 89 73 ff ff ff    	jns    80104963 <create+0x103>
      panic("create dots");
801049f0:	c7 04 24 ce 75 10 80 	movl   $0x801075ce,(%esp)
801049f7:	e8 74 b9 ff ff       	call   80100370 <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");
801049fc:	c7 04 24 da 75 10 80 	movl   $0x801075da,(%esp)
80104a03:	e8 68 b9 ff ff       	call   80100370 <panic>
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");
80104a08:	c7 04 24 bc 75 10 80 	movl   $0x801075bc,(%esp)
80104a0f:	e8 5c b9 ff ff       	call   80100370 <panic>
80104a14:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104a1a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104a20 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
80104a20:	55                   	push   %ebp
80104a21:	89 e5                	mov    %esp,%ebp
80104a23:	53                   	push   %ebx
80104a24:	89 c3                	mov    %eax,%ebx
80104a26:	83 ec 04             	sub    $0x4,%esp
  int fd;
  struct proc *curproc = myproc();
80104a29:	e8 c2 ed ff ff       	call   801037f0 <myproc>

  for(fd = 0; fd < NOFILE; fd++){
80104a2e:	31 d2                	xor    %edx,%edx
    if(curproc->ofile[fd] == 0){
80104a30:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80104a34:	85 c9                	test   %ecx,%ecx
80104a36:	74 18                	je     80104a50 <fdalloc+0x30>
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
80104a38:	83 c2 01             	add    $0x1,%edx
80104a3b:	83 fa 10             	cmp    $0x10,%edx
80104a3e:	75 f0                	jne    80104a30 <fdalloc+0x10>
      curproc->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
}
80104a40:	83 c4 04             	add    $0x4,%esp
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
80104a43:	ba ff ff ff ff       	mov    $0xffffffff,%edx
}
80104a48:	89 d0                	mov    %edx,%eax
80104a4a:	5b                   	pop    %ebx
80104a4b:	5d                   	pop    %ebp
80104a4c:	c3                   	ret    
80104a4d:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
80104a50:	89 5c 90 28          	mov    %ebx,0x28(%eax,%edx,4)
      return fd;
    }
  }
  return -1;
}
80104a54:	83 c4 04             	add    $0x4,%esp
80104a57:	89 d0                	mov    %edx,%eax
80104a59:	5b                   	pop    %ebx
80104a5a:	5d                   	pop    %ebp
80104a5b:	c3                   	ret    
80104a5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104a60 <argfd.constprop.0>:
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
80104a60:	55                   	push   %ebp
80104a61:	89 e5                	mov    %esp,%ebp
80104a63:	83 ec 38             	sub    $0x38,%esp
80104a66:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80104a69:	89 c3                	mov    %eax,%ebx
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80104a6b:	8d 45 e4             	lea    -0x1c(%ebp),%eax
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
80104a6e:	89 75 f8             	mov    %esi,-0x8(%ebp)
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    return -1;
80104a71:	be ff ff ff ff       	mov    $0xffffffff,%esi
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
80104a76:	89 7d fc             	mov    %edi,-0x4(%ebp)
80104a79:	89 d7                	mov    %edx,%edi
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80104a7b:	89 44 24 04          	mov    %eax,0x4(%esp)
80104a7f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104a86:	e8 75 fc ff ff       	call   80104700 <argint>
80104a8b:	85 c0                	test   %eax,%eax
80104a8d:	78 24                	js     80104ab3 <argfd.constprop.0+0x53>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104a8f:	83 7d e4 0f          	cmpl   $0xf,-0x1c(%ebp)
80104a93:	77 1e                	ja     80104ab3 <argfd.constprop.0+0x53>
80104a95:	e8 56 ed ff ff       	call   801037f0 <myproc>
80104a9a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104a9d:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80104aa1:	85 c0                	test   %eax,%eax
80104aa3:	74 0e                	je     80104ab3 <argfd.constprop.0+0x53>
    return -1;
  if(pfd)
80104aa5:	85 db                	test   %ebx,%ebx
80104aa7:	74 02                	je     80104aab <argfd.constprop.0+0x4b>
    *pfd = fd;
80104aa9:	89 13                	mov    %edx,(%ebx)
  if(pf)
    *pf = f;
  return 0;
80104aab:	31 f6                	xor    %esi,%esi
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    return -1;
  if(pfd)
    *pfd = fd;
  if(pf)
80104aad:	85 ff                	test   %edi,%edi
80104aaf:	74 02                	je     80104ab3 <argfd.constprop.0+0x53>
    *pf = f;
80104ab1:	89 07                	mov    %eax,(%edi)
  return 0;
}
80104ab3:	89 f0                	mov    %esi,%eax
80104ab5:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80104ab8:	8b 75 f8             	mov    -0x8(%ebp),%esi
80104abb:	8b 7d fc             	mov    -0x4(%ebp),%edi
80104abe:	89 ec                	mov    %ebp,%esp
80104ac0:	5d                   	pop    %ebp
80104ac1:	c3                   	ret    
80104ac2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ac9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ad0 <sys_dup>:
  return -1;
}

int
sys_dup(void)
{
80104ad0:	55                   	push   %ebp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104ad1:	31 c0                	xor    %eax,%eax
  return -1;
}

int
sys_dup(void)
{
80104ad3:	89 e5                	mov    %esp,%ebp
80104ad5:	53                   	push   %ebx
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
80104ad6:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  return -1;
}

int
sys_dup(void)
{
80104adb:	83 ec 24             	sub    $0x24,%esp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104ade:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104ae1:	e8 7a ff ff ff       	call   80104a60 <argfd.constprop.0>
80104ae6:	85 c0                	test   %eax,%eax
80104ae8:	78 19                	js     80104b03 <sys_dup+0x33>
    return -1;
  if((fd=fdalloc(f)) < 0)
80104aea:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104aed:	e8 2e ff ff ff       	call   80104a20 <fdalloc>
80104af2:	85 c0                	test   %eax,%eax
80104af4:	89 c3                	mov    %eax,%ebx
80104af6:	78 18                	js     80104b10 <sys_dup+0x40>
    return -1;
  filedup(f);
80104af8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104afb:	89 04 24             	mov    %eax,(%esp)
80104afe:	e8 cd c2 ff ff       	call   80100dd0 <filedup>
  return fd;
}
80104b03:	83 c4 24             	add    $0x24,%esp
80104b06:	89 d8                	mov    %ebx,%eax
80104b08:	5b                   	pop    %ebx
80104b09:	5d                   	pop    %ebp
80104b0a:	c3                   	ret    
80104b0b:	90                   	nop
80104b0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
80104b10:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80104b15:	eb ec                	jmp    80104b03 <sys_dup+0x33>
80104b17:	89 f6                	mov    %esi,%esi
80104b19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104b20 <sys_read>:
  return fd;
}

int
sys_read(void)
{
80104b20:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104b21:	31 c0                	xor    %eax,%eax
  return fd;
}

int
sys_read(void)
{
80104b23:	89 e5                	mov    %esp,%ebp
80104b25:	53                   	push   %ebx
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80104b26:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  return fd;
}

int
sys_read(void)
{
80104b2b:	83 ec 24             	sub    $0x24,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104b2e:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104b31:	e8 2a ff ff ff       	call   80104a60 <argfd.constprop.0>
80104b36:	85 c0                	test   %eax,%eax
80104b38:	78 50                	js     80104b8a <sys_read+0x6a>
80104b3a:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104b3d:	89 44 24 04          	mov    %eax,0x4(%esp)
80104b41:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80104b48:	e8 b3 fb ff ff       	call   80104700 <argint>
80104b4d:	85 c0                	test   %eax,%eax
80104b4f:	78 39                	js     80104b8a <sys_read+0x6a>
80104b51:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104b54:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104b5b:	89 44 24 08          	mov    %eax,0x8(%esp)
80104b5f:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104b62:	89 44 24 04          	mov    %eax,0x4(%esp)
80104b66:	e8 d5 fb ff ff       	call   80104740 <argptr>
80104b6b:	85 c0                	test   %eax,%eax
80104b6d:	78 1b                	js     80104b8a <sys_read+0x6a>
    return -1;
  return fileread(f, p, n);
80104b6f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104b72:	89 44 24 08          	mov    %eax,0x8(%esp)
80104b76:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b79:	89 44 24 04          	mov    %eax,0x4(%esp)
80104b7d:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104b80:	89 04 24             	mov    %eax,(%esp)
80104b83:	e8 c8 c3 ff ff       	call   80100f50 <fileread>
80104b88:	89 c3                	mov    %eax,%ebx
}
80104b8a:	83 c4 24             	add    $0x24,%esp
80104b8d:	89 d8                	mov    %ebx,%eax
80104b8f:	5b                   	pop    %ebx
80104b90:	5d                   	pop    %ebp
80104b91:	c3                   	ret    
80104b92:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ba0 <sys_write>:

int
sys_write(void)
{
80104ba0:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104ba1:	31 c0                	xor    %eax,%eax
  return fileread(f, p, n);
}

int
sys_write(void)
{
80104ba3:	89 e5                	mov    %esp,%ebp
80104ba5:	53                   	push   %ebx
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80104ba6:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  return fileread(f, p, n);
}

int
sys_write(void)
{
80104bab:	83 ec 24             	sub    $0x24,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104bae:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104bb1:	e8 aa fe ff ff       	call   80104a60 <argfd.constprop.0>
80104bb6:	85 c0                	test   %eax,%eax
80104bb8:	78 50                	js     80104c0a <sys_write+0x6a>
80104bba:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104bbd:	89 44 24 04          	mov    %eax,0x4(%esp)
80104bc1:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
80104bc8:	e8 33 fb ff ff       	call   80104700 <argint>
80104bcd:	85 c0                	test   %eax,%eax
80104bcf:	78 39                	js     80104c0a <sys_write+0x6a>
80104bd1:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104bd4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104bdb:	89 44 24 08          	mov    %eax,0x8(%esp)
80104bdf:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104be2:	89 44 24 04          	mov    %eax,0x4(%esp)
80104be6:	e8 55 fb ff ff       	call   80104740 <argptr>
80104beb:	85 c0                	test   %eax,%eax
80104bed:	78 1b                	js     80104c0a <sys_write+0x6a>
    return -1;
  return filewrite(f, p, n);
80104bef:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104bf2:	89 44 24 08          	mov    %eax,0x8(%esp)
80104bf6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104bf9:	89 44 24 04          	mov    %eax,0x4(%esp)
80104bfd:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104c00:	89 04 24             	mov    %eax,(%esp)
80104c03:	e8 f8 c3 ff ff       	call   80101000 <filewrite>
80104c08:	89 c3                	mov    %eax,%ebx
}
80104c0a:	83 c4 24             	add    $0x24,%esp
80104c0d:	89 d8                	mov    %ebx,%eax
80104c0f:	5b                   	pop    %ebx
80104c10:	5d                   	pop    %ebp
80104c11:	c3                   	ret    
80104c12:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104c20 <sys_close>:

int
sys_close(void)
{
80104c20:	55                   	push   %ebp
80104c21:	89 e5                	mov    %esp,%ebp
80104c23:	83 ec 28             	sub    $0x28,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
80104c26:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104c29:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104c2c:	e8 2f fe ff ff       	call   80104a60 <argfd.constprop.0>
    return -1;
80104c31:	ba ff ff ff ff       	mov    $0xffffffff,%edx
sys_close(void)
{
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
80104c36:	85 c0                	test   %eax,%eax
80104c38:	78 1d                	js     80104c57 <sys_close+0x37>
    return -1;
  myproc()->ofile[fd] = 0;
80104c3a:	e8 b1 eb ff ff       	call   801037f0 <myproc>
80104c3f:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104c42:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80104c49:	00 
  fileclose(f);
80104c4a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c4d:	89 04 24             	mov    %eax,(%esp)
80104c50:	e8 cb c1 ff ff       	call   80100e20 <fileclose>
  return 0;
80104c55:	31 d2                	xor    %edx,%edx
}
80104c57:	89 d0                	mov    %edx,%eax
80104c59:	c9                   	leave  
80104c5a:	c3                   	ret    
80104c5b:	90                   	nop
80104c5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104c60 <sys_fstat>:

int
sys_fstat(void)
{
80104c60:	55                   	push   %ebp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104c61:	31 c0                	xor    %eax,%eax
  return 0;
}

int
sys_fstat(void)
{
80104c63:	89 e5                	mov    %esp,%ebp
80104c65:	53                   	push   %ebx
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
    return -1;
80104c66:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  return 0;
}

int
sys_fstat(void)
{
80104c6b:	83 ec 24             	sub    $0x24,%esp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104c6e:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104c71:	e8 ea fd ff ff       	call   80104a60 <argfd.constprop.0>
80104c76:	85 c0                	test   %eax,%eax
80104c78:	78 33                	js     80104cad <sys_fstat+0x4d>
80104c7a:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104c7d:	c7 44 24 08 14 00 00 	movl   $0x14,0x8(%esp)
80104c84:	00 
80104c85:	89 44 24 04          	mov    %eax,0x4(%esp)
80104c89:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104c90:	e8 ab fa ff ff       	call   80104740 <argptr>
80104c95:	85 c0                	test   %eax,%eax
80104c97:	78 14                	js     80104cad <sys_fstat+0x4d>
    return -1;
  return filestat(f, st);
80104c99:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c9c:	89 44 24 04          	mov    %eax,0x4(%esp)
80104ca0:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104ca3:	89 04 24             	mov    %eax,(%esp)
80104ca6:	e8 55 c2 ff ff       	call   80100f00 <filestat>
80104cab:	89 c3                	mov    %eax,%ebx
}
80104cad:	83 c4 24             	add    $0x24,%esp
80104cb0:	89 d8                	mov    %ebx,%eax
80104cb2:	5b                   	pop    %ebx
80104cb3:	5d                   	pop    %ebp
80104cb4:	c3                   	ret    
80104cb5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104cb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104cc0 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80104cc0:	55                   	push   %ebp
80104cc1:	89 e5                	mov    %esp,%ebp
80104cc3:	57                   	push   %edi
80104cc4:	56                   	push   %esi
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
    return -1;
80104cc5:	be ff ff ff ff       	mov    $0xffffffff,%esi
}

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80104cca:	53                   	push   %ebx
80104ccb:	83 ec 3c             	sub    $0x3c,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104cce:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80104cd1:	89 44 24 04          	mov    %eax,0x4(%esp)
80104cd5:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104cdc:	e8 bf fa ff ff       	call   801047a0 <argstr>
80104ce1:	85 c0                	test   %eax,%eax
80104ce3:	0f 88 b1 00 00 00    	js     80104d9a <sys_link+0xda>
80104ce9:	8d 45 e0             	lea    -0x20(%ebp),%eax
80104cec:	89 44 24 04          	mov    %eax,0x4(%esp)
80104cf0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80104cf7:	e8 a4 fa ff ff       	call   801047a0 <argstr>
80104cfc:	85 c0                	test   %eax,%eax
80104cfe:	0f 88 96 00 00 00    	js     80104d9a <sys_link+0xda>
    return -1;

  begin_op();
80104d04:	e8 27 df ff ff       	call   80102c30 <begin_op>
  if((ip = namei(old)) == 0){
80104d09:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80104d0c:	89 04 24             	mov    %eax,(%esp)
80104d0f:	e8 1c d3 ff ff       	call   80102030 <namei>
80104d14:	85 c0                	test   %eax,%eax
80104d16:	89 c3                	mov    %eax,%ebx
80104d18:	0f 84 d2 00 00 00    	je     80104df0 <sys_link+0x130>
    end_op();
    return -1;
  }

  ilock(ip);
80104d1e:	89 04 24             	mov    %eax,(%esp)
80104d21:	e8 9a c9 ff ff       	call   801016c0 <ilock>
  if(ip->type == T_DIR){
80104d26:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80104d2b:	0f 84 b7 00 00 00    	je     80104de8 <sys_link+0x128>
    iunlockput(ip);
    end_op();
    return -1;
  }

  ip->nlink++;
80104d31:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
80104d36:	8d 7d d2             	lea    -0x2e(%ebp),%edi
    end_op();
    return -1;
  }

  ip->nlink++;
  iupdate(ip);
80104d39:	89 1c 24             	mov    %ebx,(%esp)
80104d3c:	e8 bf c8 ff ff       	call   80101600 <iupdate>
  iunlock(ip);
80104d41:	89 1c 24             	mov    %ebx,(%esp)
80104d44:	e8 57 ca ff ff       	call   801017a0 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
80104d49:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104d4c:	89 7c 24 04          	mov    %edi,0x4(%esp)
80104d50:	89 04 24             	mov    %eax,(%esp)
80104d53:	e8 f8 d2 ff ff       	call   80102050 <nameiparent>
80104d58:	85 c0                	test   %eax,%eax
80104d5a:	89 c6                	mov    %eax,%esi
80104d5c:	74 52                	je     80104db0 <sys_link+0xf0>
    goto bad;
  ilock(dp);
80104d5e:	89 04 24             	mov    %eax,(%esp)
80104d61:	e8 5a c9 ff ff       	call   801016c0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80104d66:	8b 03                	mov    (%ebx),%eax
80104d68:	39 06                	cmp    %eax,(%esi)
80104d6a:	75 3c                	jne    80104da8 <sys_link+0xe8>
80104d6c:	8b 43 04             	mov    0x4(%ebx),%eax
80104d6f:	89 7c 24 04          	mov    %edi,0x4(%esp)
80104d73:	89 34 24             	mov    %esi,(%esp)
80104d76:	89 44 24 08          	mov    %eax,0x8(%esp)
80104d7a:	e8 d1 d1 ff ff       	call   80101f50 <dirlink>
80104d7f:	85 c0                	test   %eax,%eax
80104d81:	78 25                	js     80104da8 <sys_link+0xe8>
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
80104d83:	89 34 24             	mov    %esi,(%esp)
  iput(ip);

  end_op();

  return 0;
80104d86:	31 f6                	xor    %esi,%esi
  ilock(dp);
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
80104d88:	e8 e3 cb ff ff       	call   80101970 <iunlockput>
  iput(ip);
80104d8d:	89 1c 24             	mov    %ebx,(%esp)
80104d90:	e8 5b ca ff ff       	call   801017f0 <iput>

  end_op();
80104d95:	e8 06 df ff ff       	call   80102ca0 <end_op>
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
}
80104d9a:	83 c4 3c             	add    $0x3c,%esp
80104d9d:	89 f0                	mov    %esi,%eax
80104d9f:	5b                   	pop    %ebx
80104da0:	5e                   	pop    %esi
80104da1:	5f                   	pop    %edi
80104da2:	5d                   	pop    %ebp
80104da3:	c3                   	ret    
80104da4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
  ilock(dp);
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    iunlockput(dp);
80104da8:	89 34 24             	mov    %esi,(%esp)
80104dab:	e8 c0 cb ff ff       	call   80101970 <iunlockput>
  end_op();

  return 0;

bad:
  ilock(ip);
80104db0:	89 1c 24             	mov    %ebx,(%esp)
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
80104db3:	be ff ff ff ff       	mov    $0xffffffff,%esi
  end_op();

  return 0;

bad:
  ilock(ip);
80104db8:	e8 03 c9 ff ff       	call   801016c0 <ilock>
  ip->nlink--;
80104dbd:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80104dc2:	89 1c 24             	mov    %ebx,(%esp)
80104dc5:	e8 36 c8 ff ff       	call   80101600 <iupdate>
  iunlockput(ip);
80104dca:	89 1c 24             	mov    %ebx,(%esp)
80104dcd:	e8 9e cb ff ff       	call   80101970 <iunlockput>
  end_op();
80104dd2:	e8 c9 de ff ff       	call   80102ca0 <end_op>
  return -1;
}
80104dd7:	83 c4 3c             	add    $0x3c,%esp
80104dda:	89 f0                	mov    %esi,%eax
80104ddc:	5b                   	pop    %ebx
80104ddd:	5e                   	pop    %esi
80104dde:	5f                   	pop    %edi
80104ddf:	5d                   	pop    %ebp
80104de0:	c3                   	ret    
80104de1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  }

  ilock(ip);
  if(ip->type == T_DIR){
    iunlockput(ip);
80104de8:	89 1c 24             	mov    %ebx,(%esp)
80104deb:	e8 80 cb ff ff       	call   80101970 <iunlockput>
    end_op();
80104df0:	e8 ab de ff ff       	call   80102ca0 <end_op>
    return -1;
80104df5:	eb a3                	jmp    80104d9a <sys_link+0xda>
80104df7:	89 f6                	mov    %esi,%esi
80104df9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e00 <sys_unlink>:
}

//PAGEBREAK!
int
sys_unlink(void)
{
80104e00:	55                   	push   %ebp
80104e01:	89 e5                	mov    %esp,%ebp
80104e03:	57                   	push   %edi
80104e04:	56                   	push   %esi
80104e05:	53                   	push   %ebx
80104e06:	83 ec 6c             	sub    $0x6c,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80104e09:	8d 45 e0             	lea    -0x20(%ebp),%eax
80104e0c:	89 44 24 04          	mov    %eax,0x4(%esp)
80104e10:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80104e17:	e8 84 f9 ff ff       	call   801047a0 <argstr>
80104e1c:	85 c0                	test   %eax,%eax
80104e1e:	0f 88 99 01 00 00    	js     80104fbd <sys_unlink+0x1bd>
    return -1;

  begin_op();
80104e24:	e8 07 de ff ff       	call   80102c30 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80104e29:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104e2c:	8d 5d d2             	lea    -0x2e(%ebp),%ebx
80104e2f:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80104e33:	89 04 24             	mov    %eax,(%esp)
80104e36:	e8 15 d2 ff ff       	call   80102050 <nameiparent>
80104e3b:	85 c0                	test   %eax,%eax
80104e3d:	89 45 a4             	mov    %eax,-0x5c(%ebp)
80104e40:	0f 84 4d 01 00 00    	je     80104f93 <sys_unlink+0x193>
    end_op();
    return -1;
  }

  ilock(dp);
80104e46:	8b 45 a4             	mov    -0x5c(%ebp),%eax
80104e49:	89 04 24             	mov    %eax,(%esp)
80104e4c:	e8 6f c8 ff ff       	call   801016c0 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80104e51:	c7 44 24 04 cc 75 10 	movl   $0x801075cc,0x4(%esp)
80104e58:	80 
80104e59:	89 1c 24             	mov    %ebx,(%esp)
80104e5c:	e8 5f ce ff ff       	call   80101cc0 <namecmp>
80104e61:	85 c0                	test   %eax,%eax
80104e63:	0f 84 1f 01 00 00    	je     80104f88 <sys_unlink+0x188>
80104e69:	c7 44 24 04 cb 75 10 	movl   $0x801075cb,0x4(%esp)
80104e70:	80 
80104e71:	89 1c 24             	mov    %ebx,(%esp)
80104e74:	e8 47 ce ff ff       	call   80101cc0 <namecmp>
80104e79:	85 c0                	test   %eax,%eax
80104e7b:	0f 84 07 01 00 00    	je     80104f88 <sys_unlink+0x188>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
80104e81:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80104e84:	89 44 24 08          	mov    %eax,0x8(%esp)
80104e88:	8b 45 a4             	mov    -0x5c(%ebp),%eax
80104e8b:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80104e8f:	89 04 24             	mov    %eax,(%esp)
80104e92:	e8 59 ce ff ff       	call   80101cf0 <dirlookup>
80104e97:	85 c0                	test   %eax,%eax
80104e99:	89 c6                	mov    %eax,%esi
80104e9b:	0f 84 e7 00 00 00    	je     80104f88 <sys_unlink+0x188>
    goto bad;
  ilock(ip);
80104ea1:	89 04 24             	mov    %eax,(%esp)
80104ea4:	e8 17 c8 ff ff       	call   801016c0 <ilock>

  if(ip->nlink < 1)
80104ea9:	66 83 7e 56 00       	cmpw   $0x0,0x56(%esi)
80104eae:	0f 8e 1f 01 00 00    	jle    80104fd3 <sys_unlink+0x1d3>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
80104eb4:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80104eb9:	74 7d                	je     80104f38 <sys_unlink+0x138>
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
80104ebb:	8d 5d b2             	lea    -0x4e(%ebp),%ebx
80104ebe:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
80104ec5:	00 
80104ec6:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80104ecd:	00 
80104ece:	89 1c 24             	mov    %ebx,(%esp)
80104ed1:	e8 2a f5 ff ff       	call   80104400 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80104ed6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80104ed9:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80104ee0:	00 
80104ee1:	89 5c 24 04          	mov    %ebx,0x4(%esp)
80104ee5:	89 44 24 08          	mov    %eax,0x8(%esp)
80104ee9:	8b 45 a4             	mov    -0x5c(%ebp),%eax
80104eec:	89 04 24             	mov    %eax,(%esp)
80104eef:	e8 2c cc ff ff       	call   80101b20 <writei>
80104ef4:	83 f8 10             	cmp    $0x10,%eax
80104ef7:	0f 85 e2 00 00 00    	jne    80104fdf <sys_unlink+0x1df>
    panic("unlink: writei");
  if(ip->type == T_DIR){
80104efd:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80104f02:	0f 84 a0 00 00 00    	je     80104fa8 <sys_unlink+0x1a8>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);
80104f08:	8b 45 a4             	mov    -0x5c(%ebp),%eax
80104f0b:	89 04 24             	mov    %eax,(%esp)
80104f0e:	e8 5d ca ff ff       	call   80101970 <iunlockput>

  ip->nlink--;
80104f13:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
  iupdate(ip);
80104f18:	89 34 24             	mov    %esi,(%esp)
80104f1b:	e8 e0 c6 ff ff       	call   80101600 <iupdate>
  iunlockput(ip);
80104f20:	89 34 24             	mov    %esi,(%esp)
80104f23:	e8 48 ca ff ff       	call   80101970 <iunlockput>

  end_op();
80104f28:	e8 73 dd ff ff       	call   80102ca0 <end_op>

  return 0;
80104f2d:	31 c0                	xor    %eax,%eax

bad:
  iunlockput(dp);
  end_op();
  return -1;
}
80104f2f:	83 c4 6c             	add    $0x6c,%esp
80104f32:	5b                   	pop    %ebx
80104f33:	5e                   	pop    %esi
80104f34:	5f                   	pop    %edi
80104f35:	5d                   	pop    %ebp
80104f36:	c3                   	ret    
80104f37:	90                   	nop
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80104f38:	83 7e 58 20          	cmpl   $0x20,0x58(%esi)
80104f3c:	0f 86 79 ff ff ff    	jbe    80104ebb <sys_unlink+0xbb>
80104f42:	bb 20 00 00 00       	mov    $0x20,%ebx
80104f47:	8d 7d c2             	lea    -0x3e(%ebp),%edi
80104f4a:	eb 10                	jmp    80104f5c <sys_unlink+0x15c>
80104f4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104f50:	83 c3 10             	add    $0x10,%ebx
80104f53:	3b 5e 58             	cmp    0x58(%esi),%ebx
80104f56:	0f 83 5f ff ff ff    	jae    80104ebb <sys_unlink+0xbb>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80104f5c:	c7 44 24 0c 10 00 00 	movl   $0x10,0xc(%esp)
80104f63:	00 
80104f64:	89 5c 24 08          	mov    %ebx,0x8(%esp)
80104f68:	89 7c 24 04          	mov    %edi,0x4(%esp)
80104f6c:	89 34 24             	mov    %esi,(%esp)
80104f6f:	e8 4c ca ff ff       	call   801019c0 <readi>
80104f74:	83 f8 10             	cmp    $0x10,%eax
80104f77:	75 4e                	jne    80104fc7 <sys_unlink+0x1c7>
      panic("isdirempty: readi");
    if(de.inum != 0)
80104f79:	66 83 7d c2 00       	cmpw   $0x0,-0x3e(%ebp)
80104f7e:	74 d0                	je     80104f50 <sys_unlink+0x150>
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
80104f80:	89 34 24             	mov    %esi,(%esp)
80104f83:	e8 e8 c9 ff ff       	call   80101970 <iunlockput>
  end_op();

  return 0;

bad:
  iunlockput(dp);
80104f88:	8b 45 a4             	mov    -0x5c(%ebp),%eax
80104f8b:	89 04 24             	mov    %eax,(%esp)
80104f8e:	e8 dd c9 ff ff       	call   80101970 <iunlockput>
  end_op();
80104f93:	e8 08 dd ff ff       	call   80102ca0 <end_op>
  return -1;
}
80104f98:	83 c4 6c             	add    $0x6c,%esp
  return 0;

bad:
  iunlockput(dp);
  end_op();
  return -1;
80104f9b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104fa0:	5b                   	pop    %ebx
80104fa1:	5e                   	pop    %esi
80104fa2:	5f                   	pop    %edi
80104fa3:	5d                   	pop    %ebp
80104fa4:	c3                   	ret    
80104fa5:	8d 76 00             	lea    0x0(%esi),%esi

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
80104fa8:	8b 45 a4             	mov    -0x5c(%ebp),%eax
80104fab:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
80104fb0:	89 04 24             	mov    %eax,(%esp)
80104fb3:	e8 48 c6 ff ff       	call   80101600 <iupdate>
80104fb8:	e9 4b ff ff ff       	jmp    80104f08 <sys_unlink+0x108>
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
    return -1;
80104fbd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104fc2:	e9 68 ff ff ff       	jmp    80104f2f <sys_unlink+0x12f>
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
80104fc7:	c7 04 24 fc 75 10 80 	movl   $0x801075fc,(%esp)
80104fce:	e8 9d b3 ff ff       	call   80100370 <panic>
  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
80104fd3:	c7 04 24 ea 75 10 80 	movl   $0x801075ea,(%esp)
80104fda:	e8 91 b3 ff ff       	call   80100370 <panic>
    goto bad;
  }

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
80104fdf:	c7 04 24 0e 76 10 80 	movl   $0x8010760e,(%esp)
80104fe6:	e8 85 b3 ff ff       	call   80100370 <panic>
80104feb:	90                   	nop
80104fec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104ff0 <sys_open>:
  return ip;
}

int
sys_open(void)
{
80104ff0:	55                   	push   %ebp
80104ff1:	89 e5                	mov    %esp,%ebp
80104ff3:	57                   	push   %edi
80104ff4:	56                   	push   %esi
80104ff5:	53                   	push   %ebx
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
    return -1;
80104ff6:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  return ip;
}

int
sys_open(void)
{
80104ffb:	83 ec 2c             	sub    $0x2c,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80104ffe:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105001:	89 44 24 04          	mov    %eax,0x4(%esp)
80105005:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010500c:	e8 8f f7 ff ff       	call   801047a0 <argstr>
80105011:	85 c0                	test   %eax,%eax
80105013:	0f 88 9b 00 00 00    	js     801050b4 <sys_open+0xc4>
80105019:	8d 45 e4             	lea    -0x1c(%ebp),%eax
8010501c:	89 44 24 04          	mov    %eax,0x4(%esp)
80105020:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80105027:	e8 d4 f6 ff ff       	call   80104700 <argint>
8010502c:	85 c0                	test   %eax,%eax
8010502e:	0f 88 80 00 00 00    	js     801050b4 <sys_open+0xc4>
    return -1;

  begin_op();
80105034:	e8 f7 db ff ff       	call   80102c30 <begin_op>
  
  if(omode & O_CREATE){
80105039:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010503c:	f6 c4 02             	test   $0x2,%ah
8010503f:	0f 84 83 00 00 00    	je     801050c8 <sys_open+0xd8>
    if(omode & O_SMALL){
       if((ip = create(path, T_SMALL, 0, 0)) == 0){  // Added if case for small file
80105045:	31 c9                	xor    %ecx,%ecx
    return -1;

  begin_op();
  
  if(omode & O_CREATE){
    if(omode & O_SMALL){
80105047:	f6 c4 04             	test   $0x4,%ah
       if((ip = create(path, T_SMALL, 0, 0)) == 0){  // Added if case for small file
8010504a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105051:	ba 04 00 00 00       	mov    $0x4,%edx
    return -1;

  begin_op();
  
  if(omode & O_CREATE){
    if(omode & O_SMALL){
80105056:	74 68                	je     801050c0 <sys_open+0xd0>
       if((ip = create(path, T_SMALL, 0, 0)) == 0){  // Added if case for small file
         end_op();
         return -1;
       }
    } else {
       if((ip = create(path, T_FILE, 0, 0)) == 0){  // Keep if case for file
80105058:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010505b:	e8 00 f8 ff ff       	call   80104860 <create>
80105060:	85 c0                	test   %eax,%eax
80105062:	89 c7                	mov    %eax,%edi
80105064:	0f 84 bd 00 00 00    	je     80105127 <sys_open+0x137>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
8010506a:	e8 f1 bc ff ff       	call   80100d60 <filealloc>
8010506f:	85 c0                	test   %eax,%eax
80105071:	89 c6                	mov    %eax,%esi
80105073:	0f 84 87 00 00 00    	je     80105100 <sys_open+0x110>
80105079:	e8 a2 f9 ff ff       	call   80104a20 <fdalloc>
8010507e:	85 c0                	test   %eax,%eax
80105080:	89 c3                	mov    %eax,%ebx
80105082:	0f 88 90 00 00 00    	js     80105118 <sys_open+0x128>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105088:	89 3c 24             	mov    %edi,(%esp)
8010508b:	e8 10 c7 ff ff       	call   801017a0 <iunlock>
  end_op();
80105090:	e8 0b dc ff ff       	call   80102ca0 <end_op>

  f->type = FD_INODE;
80105095:	c7 06 02 00 00 00    	movl   $0x2,(%esi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
8010509b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  }
  iunlock(ip);
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
8010509e:	89 7e 10             	mov    %edi,0x10(%esi)
  f->off = 0;
801050a1:	c7 46 14 00 00 00 00 	movl   $0x0,0x14(%esi)
  f->readable = !(omode & O_WRONLY);
801050a8:	a8 01                	test   $0x1,%al
801050aa:	0f 94 46 08          	sete   0x8(%esi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801050ae:	a8 03                	test   $0x3,%al
801050b0:	0f 95 46 09          	setne  0x9(%esi)
  return fd;
}
801050b4:	83 c4 2c             	add    $0x2c,%esp
801050b7:	89 d8                	mov    %ebx,%eax
801050b9:	5b                   	pop    %ebx
801050ba:	5e                   	pop    %esi
801050bb:	5f                   	pop    %edi
801050bc:	5d                   	pop    %ebp
801050bd:	c3                   	ret    
801050be:	66 90                	xchg   %ax,%ax
       if((ip = create(path, T_SMALL, 0, 0)) == 0){  // Added if case for small file
         end_op();
         return -1;
       }
    } else {
       if((ip = create(path, T_FILE, 0, 0)) == 0){  // Keep if case for file
801050c0:	ba 02 00 00 00       	mov    $0x2,%edx
801050c5:	eb 91                	jmp    80105058 <sys_open+0x68>
801050c7:	90                   	nop
         end_op();
         return -1;
       } 
    }
  } else {
    if((ip = namei(path)) == 0){
801050c8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801050cb:	89 04 24             	mov    %eax,(%esp)
801050ce:	e8 5d cf ff ff       	call   80102030 <namei>
801050d3:	85 c0                	test   %eax,%eax
801050d5:	89 c7                	mov    %eax,%edi
801050d7:	74 4e                	je     80105127 <sys_open+0x137>
      end_op();
      return -1;
    }
    ilock(ip);
801050d9:	89 04 24             	mov    %eax,(%esp)
801050dc:	e8 df c5 ff ff       	call   801016c0 <ilock>
    if((ip->type == T_DIR || ip->type == T_SFDIR) && omode != O_RDONLY){ // Added small file case
801050e1:	0f b7 47 50          	movzwl 0x50(%edi),%eax
801050e5:	66 83 f8 05          	cmp    $0x5,%ax
801050e9:	74 0a                	je     801050f5 <sys_open+0x105>
801050eb:	66 83 f8 01          	cmp    $0x1,%ax
801050ef:	0f 85 75 ff ff ff    	jne    8010506a <sys_open+0x7a>
801050f5:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801050f8:	85 db                	test   %ebx,%ebx
801050fa:	0f 84 6a ff ff ff    	je     8010506a <sys_open+0x7a>
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    iunlockput(ip);
80105100:	89 3c 24             	mov    %edi,(%esp)
    end_op();
    return -1;
80105103:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    iunlockput(ip);
80105108:	e8 63 c8 ff ff       	call   80101970 <iunlockput>
    end_op();
8010510d:	e8 8e db ff ff       	call   80102ca0 <end_op>
    return -1;
80105112:	eb a0                	jmp    801050b4 <sys_open+0xc4>
80105114:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
80105118:	89 34 24             	mov    %esi,(%esp)
8010511b:	90                   	nop
8010511c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105120:	e8 fb bc ff ff       	call   80100e20 <fileclose>
80105125:	eb d9                	jmp    80105100 <sys_open+0x110>
         return -1;
       } 
    }
  } else {
    if((ip = namei(path)) == 0){
      end_op();
80105127:	e8 74 db ff ff       	call   80102ca0 <end_op>
8010512c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return -1;
80105130:	e9 7f ff ff ff       	jmp    801050b4 <sys_open+0xc4>
80105135:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105140 <sys_mkdir>:
  return fd;
}

int
sys_mkdir(void)
{
80105140:	55                   	push   %ebp
80105141:	89 e5                	mov    %esp,%ebp
80105143:	83 ec 28             	sub    $0x28,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105146:	e8 e5 da ff ff       	call   80102c30 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010514b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010514e:	89 44 24 04          	mov    %eax,0x4(%esp)
80105152:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105159:	e8 42 f6 ff ff       	call   801047a0 <argstr>
8010515e:	85 c0                	test   %eax,%eax
80105160:	78 2e                	js     80105190 <sys_mkdir+0x50>
80105162:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105165:	31 c9                	xor    %ecx,%ecx
80105167:	ba 01 00 00 00       	mov    $0x1,%edx
8010516c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105173:	e8 e8 f6 ff ff       	call   80104860 <create>
80105178:	85 c0                	test   %eax,%eax
8010517a:	74 14                	je     80105190 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010517c:	89 04 24             	mov    %eax,(%esp)
8010517f:	e8 ec c7 ff ff       	call   80101970 <iunlockput>
  end_op();
80105184:	e8 17 db ff ff       	call   80102ca0 <end_op>
  return 0;
80105189:	31 c0                	xor    %eax,%eax
}
8010518b:	c9                   	leave  
8010518c:	c3                   	ret    
8010518d:	8d 76 00             	lea    0x0(%esi),%esi
  char *path;
  struct inode *ip;

  begin_op();
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    end_op();
80105190:	e8 0b db ff ff       	call   80102ca0 <end_op>
    return -1;
80105195:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
8010519a:	c9                   	leave  
8010519b:	c3                   	ret    
8010519c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801051a0 <sys_mknod>:

int
sys_mknod(void)
{
801051a0:	55                   	push   %ebp
801051a1:	89 e5                	mov    %esp,%ebp
801051a3:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
801051a6:	e8 85 da ff ff       	call   80102c30 <begin_op>
  if((argstr(0, &path)) < 0 ||
801051ab:	8d 45 ec             	lea    -0x14(%ebp),%eax
801051ae:	89 44 24 04          	mov    %eax,0x4(%esp)
801051b2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801051b9:	e8 e2 f5 ff ff       	call   801047a0 <argstr>
801051be:	85 c0                	test   %eax,%eax
801051c0:	78 5e                	js     80105220 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
801051c2:	8d 45 f0             	lea    -0x10(%ebp),%eax
801051c5:	89 44 24 04          	mov    %eax,0x4(%esp)
801051c9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801051d0:	e8 2b f5 ff ff       	call   80104700 <argint>
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
801051d5:	85 c0                	test   %eax,%eax
801051d7:	78 47                	js     80105220 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
801051d9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801051dc:	89 44 24 04          	mov    %eax,0x4(%esp)
801051e0:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
801051e7:	e8 14 f5 ff ff       	call   80104700 <argint>
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
801051ec:	85 c0                	test   %eax,%eax
801051ee:	78 30                	js     80105220 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
801051f0:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
801051f4:	ba 03 00 00 00       	mov    $0x3,%edx
     (ip = create(path, T_DEV, major, minor)) == 0){
801051f9:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
801051fd:	89 04 24             	mov    %eax,(%esp)
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80105200:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105203:	e8 58 f6 ff ff       	call   80104860 <create>
80105208:	85 c0                	test   %eax,%eax
8010520a:	74 14                	je     80105220 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
    return -1;
  }
  iunlockput(ip);
8010520c:	89 04 24             	mov    %eax,(%esp)
8010520f:	e8 5c c7 ff ff       	call   80101970 <iunlockput>
  end_op();
80105214:	e8 87 da ff ff       	call   80102ca0 <end_op>
  return 0;
80105219:	31 c0                	xor    %eax,%eax
}
8010521b:	c9                   	leave  
8010521c:	c3                   	ret    
8010521d:	8d 76 00             	lea    0x0(%esi),%esi
  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
80105220:	e8 7b da ff ff       	call   80102ca0 <end_op>
    return -1;
80105225:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
8010522a:	c9                   	leave  
8010522b:	c3                   	ret    
8010522c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105230 <sys_chdir>:

int
sys_chdir(void)
{
80105230:	55                   	push   %ebp
80105231:	89 e5                	mov    %esp,%ebp
80105233:	56                   	push   %esi
80105234:	53                   	push   %ebx
80105235:	83 ec 20             	sub    $0x20,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105238:	e8 b3 e5 ff ff       	call   801037f0 <myproc>
8010523d:	89 c3                	mov    %eax,%ebx
  
  begin_op();
8010523f:	e8 ec d9 ff ff       	call   80102c30 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105244:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105247:	89 44 24 04          	mov    %eax,0x4(%esp)
8010524b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105252:	e8 49 f5 ff ff       	call   801047a0 <argstr>
80105257:	85 c0                	test   %eax,%eax
80105259:	78 4a                	js     801052a5 <sys_chdir+0x75>
8010525b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010525e:	89 04 24             	mov    %eax,(%esp)
80105261:	e8 ca cd ff ff       	call   80102030 <namei>
80105266:	85 c0                	test   %eax,%eax
80105268:	89 c6                	mov    %eax,%esi
8010526a:	74 39                	je     801052a5 <sys_chdir+0x75>
    end_op();
    return -1;
  }
  ilock(ip);
8010526c:	89 04 24             	mov    %eax,(%esp)
8010526f:	e8 4c c4 ff ff       	call   801016c0 <ilock>
  if(ip->type != T_DIR){
80105274:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
    iunlockput(ip);
80105279:	89 34 24             	mov    %esi,(%esp)
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
    end_op();
    return -1;
  }
  ilock(ip);
  if(ip->type != T_DIR){
8010527c:	75 22                	jne    801052a0 <sys_chdir+0x70>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
8010527e:	e8 1d c5 ff ff       	call   801017a0 <iunlock>
  iput(curproc->cwd);
80105283:	8b 43 68             	mov    0x68(%ebx),%eax
80105286:	89 04 24             	mov    %eax,(%esp)
80105289:	e8 62 c5 ff ff       	call   801017f0 <iput>
  end_op();
8010528e:	e8 0d da ff ff       	call   80102ca0 <end_op>
  curproc->cwd = ip;
  return 0;
80105293:	31 c0                	xor    %eax,%eax
    return -1;
  }
  iunlock(ip);
  iput(curproc->cwd);
  end_op();
  curproc->cwd = ip;
80105295:	89 73 68             	mov    %esi,0x68(%ebx)
  return 0;
}
80105298:	83 c4 20             	add    $0x20,%esp
8010529b:	5b                   	pop    %ebx
8010529c:	5e                   	pop    %esi
8010529d:	5d                   	pop    %ebp
8010529e:	c3                   	ret    
8010529f:	90                   	nop
    end_op();
    return -1;
  }
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
801052a0:	e8 cb c6 ff ff       	call   80101970 <iunlockput>
    end_op();
801052a5:	e8 f6 d9 ff ff       	call   80102ca0 <end_op>
  iunlock(ip);
  iput(curproc->cwd);
  end_op();
  curproc->cwd = ip;
  return 0;
}
801052aa:	83 c4 20             	add    $0x20,%esp
  }
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
    end_op();
    return -1;
801052ad:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  iunlock(ip);
  iput(curproc->cwd);
  end_op();
  curproc->cwd = ip;
  return 0;
}
801052b2:	5b                   	pop    %ebx
801052b3:	5e                   	pop    %esi
801052b4:	5d                   	pop    %ebp
801052b5:	c3                   	ret    
801052b6:	8d 76 00             	lea    0x0(%esi),%esi
801052b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801052c0 <sys_exec>:

int
sys_exec(void)
{
801052c0:	55                   	push   %ebp
801052c1:	89 e5                	mov    %esp,%ebp
801052c3:	57                   	push   %edi
801052c4:	56                   	push   %esi
801052c5:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
801052c6:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  return 0;
}

int
sys_exec(void)
{
801052cb:	81 ec ac 00 00 00    	sub    $0xac,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801052d1:	8d 45 dc             	lea    -0x24(%ebp),%eax
801052d4:	89 44 24 04          	mov    %eax,0x4(%esp)
801052d8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801052df:	e8 bc f4 ff ff       	call   801047a0 <argstr>
801052e4:	85 c0                	test   %eax,%eax
801052e6:	0f 88 82 00 00 00    	js     8010536e <sys_exec+0xae>
801052ec:	8d 45 e0             	lea    -0x20(%ebp),%eax
801052ef:	89 44 24 04          	mov    %eax,0x4(%esp)
801052f3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801052fa:	e8 01 f4 ff ff       	call   80104700 <argint>
801052ff:	85 c0                	test   %eax,%eax
80105301:	78 6b                	js     8010536e <sys_exec+0xae>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105303:	8d bd 5c ff ff ff    	lea    -0xa4(%ebp),%edi
  for(i=0;; i++){
    if(i >= NELEM(argv))
80105309:	31 f6                	xor    %esi,%esi
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
8010530b:	c7 44 24 08 80 00 00 	movl   $0x80,0x8(%esp)
80105312:	00 
  for(i=0;; i++){
80105313:	31 db                	xor    %ebx,%ebx
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105315:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
8010531c:	00 
8010531d:	89 3c 24             	mov    %edi,(%esp)
80105320:	e8 db f0 ff ff       	call   80104400 <memset>
80105325:	8d 76 00             	lea    0x0(%esi),%esi
  for(i=0;; i++){
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105328:	8d 45 e4             	lea    -0x1c(%ebp),%eax
8010532b:	89 44 24 04          	mov    %eax,0x4(%esp)
  curproc->cwd = ip;
  return 0;
}

int
sys_exec(void)
8010532f:	8d 04 9d 00 00 00 00 	lea    0x0(,%ebx,4),%eax
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105336:	03 45 e0             	add    -0x20(%ebp),%eax
80105339:	89 04 24             	mov    %eax,(%esp)
8010533c:	e8 2f f3 ff ff       	call   80104670 <fetchint>
80105341:	85 c0                	test   %eax,%eax
80105343:	78 24                	js     80105369 <sys_exec+0xa9>
      return -1;
    if(uarg == 0){
80105345:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105348:	85 c0                	test   %eax,%eax
8010534a:	74 34                	je     80105380 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
8010534c:	8d 14 b7             	lea    (%edi,%esi,4),%edx
8010534f:	89 54 24 04          	mov    %edx,0x4(%esp)
80105353:	89 04 24             	mov    %eax,(%esp)
80105356:	e8 45 f3 ff ff       	call   801046a0 <fetchstr>
8010535b:	85 c0                	test   %eax,%eax
8010535d:	78 0a                	js     80105369 <sys_exec+0xa9>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
8010535f:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105362:	83 fb 20             	cmp    $0x20,%ebx
80105365:	89 de                	mov    %ebx,%esi
80105367:	75 bf                	jne    80105328 <sys_exec+0x68>
    if(uarg == 0){
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
80105369:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  }
  return exec(path, argv);
}
8010536e:	81 c4 ac 00 00 00    	add    $0xac,%esp
80105374:	89 d8                	mov    %ebx,%eax
80105376:	5b                   	pop    %ebx
80105377:	5e                   	pop    %esi
80105378:	5f                   	pop    %edi
80105379:	5d                   	pop    %ebp
8010537a:	c3                   	ret    
8010537b:	90                   	nop
8010537c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80105380:	8b 45 dc             	mov    -0x24(%ebp),%eax
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
      argv[i] = 0;
80105383:	c7 84 9d 5c ff ff ff 	movl   $0x0,-0xa4(%ebp,%ebx,4)
8010538a:	00 00 00 00 
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
8010538e:	89 7c 24 04          	mov    %edi,0x4(%esp)
80105392:	89 04 24             	mov    %eax,(%esp)
80105395:	e8 16 b6 ff ff       	call   801009b0 <exec>
}
8010539a:	81 c4 ac 00 00 00    	add    $0xac,%esp
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
801053a0:	89 c3                	mov    %eax,%ebx
}
801053a2:	89 d8                	mov    %ebx,%eax
801053a4:	5b                   	pop    %ebx
801053a5:	5e                   	pop    %esi
801053a6:	5f                   	pop    %edi
801053a7:	5d                   	pop    %ebp
801053a8:	c3                   	ret    
801053a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801053b0 <sys_pipe>:

int
sys_pipe(void)
{
801053b0:	55                   	push   %ebp
801053b1:	89 e5                	mov    %esp,%ebp
801053b3:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
801053b4:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  return exec(path, argv);
}

int
sys_pipe(void)
{
801053b9:	83 ec 24             	sub    $0x24,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801053bc:	8d 45 ec             	lea    -0x14(%ebp),%eax
801053bf:	c7 44 24 08 08 00 00 	movl   $0x8,0x8(%esp)
801053c6:	00 
801053c7:	89 44 24 04          	mov    %eax,0x4(%esp)
801053cb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801053d2:	e8 69 f3 ff ff       	call   80104740 <argptr>
801053d7:	85 c0                	test   %eax,%eax
801053d9:	78 3d                	js     80105418 <sys_pipe+0x68>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
801053db:	8d 45 f4             	lea    -0xc(%ebp),%eax
801053de:	89 44 24 04          	mov    %eax,0x4(%esp)
801053e2:	8d 45 f0             	lea    -0x10(%ebp),%eax
801053e5:	89 04 24             	mov    %eax,(%esp)
801053e8:	e8 a3 de ff ff       	call   80103290 <pipealloc>
801053ed:	85 c0                	test   %eax,%eax
801053ef:	78 27                	js     80105418 <sys_pipe+0x68>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801053f1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801053f4:	e8 27 f6 ff ff       	call   80104a20 <fdalloc>
801053f9:	85 c0                	test   %eax,%eax
801053fb:	89 c3                	mov    %eax,%ebx
801053fd:	78 2e                	js     8010542d <sys_pipe+0x7d>
801053ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105402:	e8 19 f6 ff ff       	call   80104a20 <fdalloc>
80105407:	85 c0                	test   %eax,%eax
80105409:	78 15                	js     80105420 <sys_pipe+0x70>
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
8010540b:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010540e:	89 1a                	mov    %ebx,(%edx)
  fd[1] = fd1;
80105410:	8b 55 ec             	mov    -0x14(%ebp),%edx
  return 0;
80105413:	31 db                	xor    %ebx,%ebx
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
  fd[1] = fd1;
80105415:	89 42 04             	mov    %eax,0x4(%edx)
  return 0;
}
80105418:	83 c4 24             	add    $0x24,%esp
8010541b:	89 d8                	mov    %ebx,%eax
8010541d:	5b                   	pop    %ebx
8010541e:	5d                   	pop    %ebp
8010541f:	c3                   	ret    
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
80105420:	e8 cb e3 ff ff       	call   801037f0 <myproc>
80105425:	c7 44 98 28 00 00 00 	movl   $0x0,0x28(%eax,%ebx,4)
8010542c:	00 
    fileclose(rf);
8010542d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    fileclose(wf);
    return -1;
80105430:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
80105435:	89 04 24             	mov    %eax,(%esp)
80105438:	e8 e3 b9 ff ff       	call   80100e20 <fileclose>
    fileclose(wf);
8010543d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105440:	89 04 24             	mov    %eax,(%esp)
80105443:	e8 d8 b9 ff ff       	call   80100e20 <fileclose>
    return -1;
80105448:	eb ce                	jmp    80105418 <sys_pipe+0x68>
8010544a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105450 <sys_mksfdir>:
  return 0;
}

int 
sys_mksfdir(void)
{
80105450:	55                   	push   %ebp
80105451:	89 e5                	mov    %esp,%ebp
80105453:	83 ec 28             	sub    $0x28,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105456:	e8 d5 d7 ff ff       	call   80102c30 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_SFDIR, 0, 0)) == 0){
8010545b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010545e:	89 44 24 04          	mov    %eax,0x4(%esp)
80105462:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105469:	e8 32 f3 ff ff       	call   801047a0 <argstr>
8010546e:	85 c0                	test   %eax,%eax
80105470:	78 2e                	js     801054a0 <sys_mksfdir+0x50>
80105472:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105475:	31 c9                	xor    %ecx,%ecx
80105477:	ba 05 00 00 00       	mov    $0x5,%edx
8010547c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105483:	e8 d8 f3 ff ff       	call   80104860 <create>
80105488:	85 c0                	test   %eax,%eax
8010548a:	74 14                	je     801054a0 <sys_mksfdir+0x50>
    end_op();
    return -1;
  }

  iunlockput(ip);
8010548c:	89 04 24             	mov    %eax,(%esp)
8010548f:	e8 dc c4 ff ff       	call   80101970 <iunlockput>
  end_op();
80105494:	e8 07 d8 ff ff       	call   80102ca0 <end_op>
  return 0;
80105499:	31 c0                	xor    %eax,%eax
}
8010549b:	c9                   	leave  
8010549c:	c3                   	ret    
8010549d:	8d 76 00             	lea    0x0(%esi),%esi
  char *path;
  struct inode *ip;

  begin_op();
  if(argstr(0, &path) < 0 || (ip = create(path, T_SFDIR, 0, 0)) == 0){
    end_op();
801054a0:	e8 fb d7 ff ff       	call   80102ca0 <end_op>
    return -1;
801054a5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }

  iunlockput(ip);
  end_op();
  return 0;
}
801054aa:	c9                   	leave  
801054ab:	c3                   	ret    
801054ac:	00 00                	add    %al,(%eax)
	...

801054b0 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
801054b0:	55                   	push   %ebp
801054b1:	89 e5                	mov    %esp,%ebp
  return fork();
}
801054b3:	5d                   	pop    %ebp
#include "proc.h"

int
sys_fork(void)
{
  return fork();
801054b4:	e9 e7 e4 ff ff       	jmp    801039a0 <fork>
801054b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801054c0 <sys_exit>:
}

int
sys_exit(void)
{
801054c0:	55                   	push   %ebp
801054c1:	89 e5                	mov    %esp,%ebp
801054c3:	83 ec 08             	sub    $0x8,%esp
  exit();
801054c6:	e8 25 e7 ff ff       	call   80103bf0 <exit>
  return 0;  // not reached
}
801054cb:	31 c0                	xor    %eax,%eax
801054cd:	c9                   	leave  
801054ce:	c3                   	ret    
801054cf:	90                   	nop

801054d0 <sys_wait>:

int
sys_wait(void)
{
801054d0:	55                   	push   %ebp
801054d1:	89 e5                	mov    %esp,%ebp
  return wait();
}
801054d3:	5d                   	pop    %ebp
}

int
sys_wait(void)
{
  return wait();
801054d4:	e9 37 e9 ff ff       	jmp    80103e10 <wait>
801054d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801054e0 <sys_kill>:
}

int
sys_kill(void)
{
801054e0:	55                   	push   %ebp
801054e1:	89 e5                	mov    %esp,%ebp
801054e3:	83 ec 28             	sub    $0x28,%esp
  int pid;

  if(argint(0, &pid) < 0)
801054e6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801054e9:	89 44 24 04          	mov    %eax,0x4(%esp)
801054ed:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
801054f4:	e8 07 f2 ff ff       	call   80104700 <argint>
801054f9:	89 c2                	mov    %eax,%edx
    return -1;
801054fb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
int
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
80105500:	85 d2                	test   %edx,%edx
80105502:	78 0b                	js     8010550f <sys_kill+0x2f>
    return -1;
  return kill(pid);
80105504:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105507:	89 04 24             	mov    %eax,(%esp)
8010550a:	e8 41 ea ff ff       	call   80103f50 <kill>
}
8010550f:	c9                   	leave  
80105510:	c3                   	ret    
80105511:	eb 0d                	jmp    80105520 <sys_getpid>
80105513:	90                   	nop
80105514:	90                   	nop
80105515:	90                   	nop
80105516:	90                   	nop
80105517:	90                   	nop
80105518:	90                   	nop
80105519:	90                   	nop
8010551a:	90                   	nop
8010551b:	90                   	nop
8010551c:	90                   	nop
8010551d:	90                   	nop
8010551e:	90                   	nop
8010551f:	90                   	nop

80105520 <sys_getpid>:

int
sys_getpid(void)
{
80105520:	55                   	push   %ebp
80105521:	89 e5                	mov    %esp,%ebp
80105523:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105526:	e8 c5 e2 ff ff       	call   801037f0 <myproc>
8010552b:	8b 40 10             	mov    0x10(%eax),%eax
}
8010552e:	c9                   	leave  
8010552f:	c3                   	ret    

80105530 <sys_sbrk>:

int
sys_sbrk(void)
{
80105530:	55                   	push   %ebp
80105531:	89 e5                	mov    %esp,%ebp
80105533:	83 ec 28             	sub    $0x28,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105536:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return myproc()->pid;
}

int
sys_sbrk(void)
{
80105539:	89 5d f8             	mov    %ebx,-0x8(%ebp)
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
8010553c:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
  return myproc()->pid;
}

int
sys_sbrk(void)
{
80105541:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105544:	89 44 24 04          	mov    %eax,0x4(%esp)
80105548:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
8010554f:	e8 ac f1 ff ff       	call   80104700 <argint>
80105554:	85 c0                	test   %eax,%eax
80105556:	78 17                	js     8010556f <sys_sbrk+0x3f>
    return -1;
  addr = myproc()->sz;
80105558:	e8 93 e2 ff ff       	call   801037f0 <myproc>
8010555d:	8b 30                	mov    (%eax),%esi
  if(growproc(n) < 0)
8010555f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105562:	89 04 24             	mov    %eax,(%esp)
80105565:	e8 b6 e3 ff ff       	call   80103920 <growproc>
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
8010556a:	85 c0                	test   %eax,%eax
8010556c:	0f 49 de             	cmovns %esi,%ebx
  if(growproc(n) < 0)
    return -1;
  return addr;
}
8010556f:	89 d8                	mov    %ebx,%eax
80105571:	8b 75 fc             	mov    -0x4(%ebp),%esi
80105574:	8b 5d f8             	mov    -0x8(%ebp),%ebx
80105577:	89 ec                	mov    %ebp,%esp
80105579:	5d                   	pop    %ebp
8010557a:	c3                   	ret    
8010557b:	90                   	nop
8010557c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105580 <sys_sleep>:

int
sys_sleep(void)
{
80105580:	55                   	push   %ebp
80105581:	89 e5                	mov    %esp,%ebp
80105583:	53                   	push   %ebx
80105584:	83 ec 24             	sub    $0x24,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105587:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010558a:	89 44 24 04          	mov    %eax,0x4(%esp)
8010558e:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
80105595:	e8 66 f1 ff ff       	call   80104700 <argint>
    return -1;
8010559a:	ba ff ff ff ff       	mov    $0xffffffff,%edx
sys_sleep(void)
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
8010559f:	85 c0                	test   %eax,%eax
801055a1:	78 5a                	js     801055fd <sys_sleep+0x7d>
    return -1;
  acquire(&tickslock);
801055a3:	c7 04 24 60 4c 11 80 	movl   $0x80114c60,(%esp)
801055aa:	e8 91 ed ff ff       	call   80104340 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801055af:	8b 55 f4             	mov    -0xc(%ebp),%edx
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
801055b2:	8b 1d a0 54 11 80    	mov    0x801154a0,%ebx
  while(ticks - ticks0 < n){
801055b8:	85 d2                	test   %edx,%edx
801055ba:	75 24                	jne    801055e0 <sys_sleep+0x60>
801055bc:	eb 4a                	jmp    80105608 <sys_sleep+0x88>
801055be:	66 90                	xchg   %ax,%ax
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
801055c0:	c7 44 24 04 60 4c 11 	movl   $0x80114c60,0x4(%esp)
801055c7:	80 
801055c8:	c7 04 24 a0 54 11 80 	movl   $0x801154a0,(%esp)
801055cf:	e8 7c e7 ff ff       	call   80103d50 <sleep>

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801055d4:	a1 a0 54 11 80       	mov    0x801154a0,%eax
801055d9:	29 d8                	sub    %ebx,%eax
801055db:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801055de:	73 28                	jae    80105608 <sys_sleep+0x88>
    if(myproc()->killed){
801055e0:	e8 0b e2 ff ff       	call   801037f0 <myproc>
801055e5:	8b 40 24             	mov    0x24(%eax),%eax
801055e8:	85 c0                	test   %eax,%eax
801055ea:	74 d4                	je     801055c0 <sys_sleep+0x40>
      release(&tickslock);
801055ec:	c7 04 24 60 4c 11 80 	movl   $0x80114c60,(%esp)
801055f3:	e8 b8 ed ff ff       	call   801043b0 <release>
      return -1;
801055f8:	ba ff ff ff ff       	mov    $0xffffffff,%edx
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}
801055fd:	83 c4 24             	add    $0x24,%esp
80105600:	89 d0                	mov    %edx,%eax
80105602:	5b                   	pop    %ebx
80105603:	5d                   	pop    %ebp
80105604:	c3                   	ret    
80105605:	8d 76 00             	lea    0x0(%esi),%esi
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
80105608:	c7 04 24 60 4c 11 80 	movl   $0x80114c60,(%esp)
8010560f:	e8 9c ed ff ff       	call   801043b0 <release>
  return 0;
}
80105614:	83 c4 24             	add    $0x24,%esp
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
80105617:	31 d2                	xor    %edx,%edx
}
80105619:	89 d0                	mov    %edx,%eax
8010561b:	5b                   	pop    %ebx
8010561c:	5d                   	pop    %ebp
8010561d:	c3                   	ret    
8010561e:	66 90                	xchg   %ax,%ax

80105620 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105620:	55                   	push   %ebp
80105621:	89 e5                	mov    %esp,%ebp
80105623:	53                   	push   %ebx
80105624:	83 ec 14             	sub    $0x14,%esp
  uint xticks;

  acquire(&tickslock);
80105627:	c7 04 24 60 4c 11 80 	movl   $0x80114c60,(%esp)
8010562e:	e8 0d ed ff ff       	call   80104340 <acquire>
  xticks = ticks;
80105633:	8b 1d a0 54 11 80    	mov    0x801154a0,%ebx
  release(&tickslock);
80105639:	c7 04 24 60 4c 11 80 	movl   $0x80114c60,(%esp)
80105640:	e8 6b ed ff ff       	call   801043b0 <release>
  return xticks;
}
80105645:	83 c4 14             	add    $0x14,%esp
80105648:	89 d8                	mov    %ebx,%eax
8010564a:	5b                   	pop    %ebx
8010564b:	5d                   	pop    %ebp
8010564c:	c3                   	ret    
8010564d:	00 00                	add    %al,(%eax)
	...

80105650 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80105650:	1e                   	push   %ds
  pushl %es
80105651:	06                   	push   %es
  pushl %fs
80105652:	0f a0                	push   %fs
  pushl %gs
80105654:	0f a8                	push   %gs
  pushal
80105656:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80105657:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
8010565b:	8e d8                	mov    %eax,%ds
  movw %ax, %es
8010565d:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
8010565f:	54                   	push   %esp
  call trap
80105660:	e8 db 00 00 00       	call   80105740 <trap>
  addl $4, %esp
80105665:	83 c4 04             	add    $0x4,%esp

80105668 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80105668:	61                   	popa   
  popl %gs
80105669:	0f a9                	pop    %gs
  popl %fs
8010566b:	0f a1                	pop    %fs
  popl %es
8010566d:	07                   	pop    %es
  popl %ds
8010566e:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
8010566f:	83 c4 08             	add    $0x8,%esp
  iret
80105672:	cf                   	iret   
	...

80105680 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105680:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105681:	31 c0                	xor    %eax,%eax
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105683:	89 e5                	mov    %esp,%ebp
80105685:	ba a0 4c 11 80       	mov    $0x80114ca0,%edx
8010568a:	83 ec 18             	sub    $0x18,%esp
8010568d:	8d 76 00             	lea    0x0(%esi),%esi
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105690:	8b 0c 85 08 a0 10 80 	mov    -0x7fef5ff8(,%eax,4),%ecx
80105697:	66 89 0c c5 a0 4c 11 	mov    %cx,-0x7feeb360(,%eax,8)
8010569e:	80 
8010569f:	c1 e9 10             	shr    $0x10,%ecx
801056a2:	66 c7 44 c2 02 08 00 	movw   $0x8,0x2(%edx,%eax,8)
801056a9:	c6 44 c2 04 00       	movb   $0x0,0x4(%edx,%eax,8)
801056ae:	c6 44 c2 05 8e       	movb   $0x8e,0x5(%edx,%eax,8)
801056b3:	66 89 4c c2 06       	mov    %cx,0x6(%edx,%eax,8)
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
801056b8:	83 c0 01             	add    $0x1,%eax
801056bb:	3d 00 01 00 00       	cmp    $0x100,%eax
801056c0:	75 ce                	jne    80105690 <tvinit+0x10>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801056c2:	a1 08 a1 10 80       	mov    0x8010a108,%eax

  initlock(&tickslock, "time");
801056c7:	c7 44 24 04 1d 76 10 	movl   $0x8010761d,0x4(%esp)
801056ce:	80 
801056cf:	c7 04 24 60 4c 11 80 	movl   $0x80114c60,(%esp)
{
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801056d6:	66 c7 05 a2 4e 11 80 	movw   $0x8,0x80114ea2
801056dd:	08 00 
801056df:	66 a3 a0 4e 11 80    	mov    %ax,0x80114ea0
801056e5:	c1 e8 10             	shr    $0x10,%eax
801056e8:	c6 05 a4 4e 11 80 00 	movb   $0x0,0x80114ea4
801056ef:	c6 05 a5 4e 11 80 ef 	movb   $0xef,0x80114ea5
801056f6:	66 a3 a6 4e 11 80    	mov    %ax,0x80114ea6

  initlock(&tickslock, "time");
801056fc:	e8 cf ea ff ff       	call   801041d0 <initlock>
}
80105701:	c9                   	leave  
80105702:	c3                   	ret    
80105703:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105709:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105710 <idtinit>:

void
idtinit(void)
{
80105710:	55                   	push   %ebp
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
  pd[1] = (uint)p;
80105711:	b8 a0 4c 11 80       	mov    $0x80114ca0,%eax
80105716:	89 e5                	mov    %esp,%ebp
80105718:	83 ec 10             	sub    $0x10,%esp
static inline void
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
8010571b:	66 c7 45 fa ff 07    	movw   $0x7ff,-0x6(%ebp)
  pd[1] = (uint)p;
80105721:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105725:	c1 e8 10             	shr    $0x10,%eax
80105728:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
8010572c:	8d 45 fa             	lea    -0x6(%ebp),%eax
8010572f:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105732:	c9                   	leave  
80105733:	c3                   	ret    
80105734:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010573a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105740 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105740:	55                   	push   %ebp
80105741:	89 e5                	mov    %esp,%ebp
80105743:	83 ec 48             	sub    $0x48,%esp
80105746:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80105749:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010574c:	89 75 f8             	mov    %esi,-0x8(%ebp)
8010574f:	89 7d fc             	mov    %edi,-0x4(%ebp)
  if(tf->trapno == T_SYSCALL){
80105752:	8b 43 30             	mov    0x30(%ebx),%eax
80105755:	83 f8 40             	cmp    $0x40,%eax
80105758:	0f 84 d2 01 00 00    	je     80105930 <trap+0x1f0>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
8010575e:	83 e8 20             	sub    $0x20,%eax
80105761:	83 f8 1f             	cmp    $0x1f,%eax
80105764:	0f 86 fe 00 00 00    	jbe    80105868 <trap+0x128>
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
8010576a:	e8 81 e0 ff ff       	call   801037f0 <myproc>
8010576f:	85 c0                	test   %eax,%eax
80105771:	0f 84 10 02 00 00    	je     80105987 <trap+0x247>
80105777:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
8010577b:	0f 84 06 02 00 00    	je     80105987 <trap+0x247>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105781:	0f 20 d2             	mov    %cr2,%edx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105784:	8b 7b 38             	mov    0x38(%ebx),%edi
80105787:	89 55 dc             	mov    %edx,-0x24(%ebp)
8010578a:	e8 41 e0 ff ff       	call   801037d0 <cpuid>
8010578f:	8b 4b 34             	mov    0x34(%ebx),%ecx
80105792:	89 c6                	mov    %eax,%esi
80105794:	8b 43 30             	mov    0x30(%ebx),%eax
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80105797:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010579a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
8010579d:	e8 4e e0 ff ff       	call   801037f0 <myproc>
801057a2:	89 45 e0             	mov    %eax,-0x20(%ebp)
801057a5:	e8 46 e0 ff ff       	call   801037f0 <myproc>
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801057aa:	8b 55 dc             	mov    -0x24(%ebp),%edx
801057ad:	8b 4d d8             	mov    -0x28(%ebp),%ecx
801057b0:	89 7c 24 18          	mov    %edi,0x18(%esp)
801057b4:	89 74 24 14          	mov    %esi,0x14(%esp)
801057b8:	89 54 24 1c          	mov    %edx,0x1c(%esp)
801057bc:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801057bf:	89 4c 24 10          	mov    %ecx,0x10(%esp)
801057c3:	89 54 24 0c          	mov    %edx,0xc(%esp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
801057c7:	8b 55 e0             	mov    -0x20(%ebp),%edx
801057ca:	83 c2 6c             	add    $0x6c,%edx
801057cd:	89 54 24 08          	mov    %edx,0x8(%esp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801057d1:	8b 40 10             	mov    0x10(%eax),%eax
801057d4:	c7 04 24 80 76 10 80 	movl   $0x80107680,(%esp)
801057db:	89 44 24 04          	mov    %eax,0x4(%esp)
801057df:	e8 6c ae ff ff       	call   80100650 <cprintf>
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
801057e4:	e8 07 e0 ff ff       	call   801037f0 <myproc>
801057e9:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801057f0:	e8 fb df ff ff       	call   801037f0 <myproc>
801057f5:	85 c0                	test   %eax,%eax
801057f7:	74 1c                	je     80105815 <trap+0xd5>
801057f9:	e8 f2 df ff ff       	call   801037f0 <myproc>
801057fe:	8b 50 24             	mov    0x24(%eax),%edx
80105801:	85 d2                	test   %edx,%edx
80105803:	74 10                	je     80105815 <trap+0xd5>
80105805:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105809:	83 e0 03             	and    $0x3,%eax
8010580c:	83 f8 03             	cmp    $0x3,%eax
8010580f:	0f 84 5b 01 00 00    	je     80105970 <trap+0x230>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105815:	e8 d6 df ff ff       	call   801037f0 <myproc>
8010581a:	85 c0                	test   %eax,%eax
8010581c:	74 11                	je     8010582f <trap+0xef>
8010581e:	66 90                	xchg   %ax,%ax
80105820:	e8 cb df ff ff       	call   801037f0 <myproc>
80105825:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105829:	0f 84 e1 00 00 00    	je     80105910 <trap+0x1d0>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010582f:	e8 bc df ff ff       	call   801037f0 <myproc>
80105834:	85 c0                	test   %eax,%eax
80105836:	74 1c                	je     80105854 <trap+0x114>
80105838:	e8 b3 df ff ff       	call   801037f0 <myproc>
8010583d:	8b 40 24             	mov    0x24(%eax),%eax
80105840:	85 c0                	test   %eax,%eax
80105842:	74 10                	je     80105854 <trap+0x114>
80105844:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105848:	83 e0 03             	and    $0x3,%eax
8010584b:	83 f8 03             	cmp    $0x3,%eax
8010584e:	0f 84 05 01 00 00    	je     80105959 <trap+0x219>
    exit();
}
80105854:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105857:	8b 75 f8             	mov    -0x8(%ebp),%esi
8010585a:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010585d:	89 ec                	mov    %ebp,%esp
8010585f:	5d                   	pop    %ebp
80105860:	c3                   	ret    
80105861:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105868:	ff 24 85 c4 76 10 80 	jmp    *-0x7fef893c(,%eax,4)
8010586f:	90                   	nop
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80105870:	e8 3b c9 ff ff       	call   801021b0 <ideintr>
    lapiceoi();
80105875:	e8 56 cf ff ff       	call   801027d0 <lapiceoi>
    break;
8010587a:	e9 71 ff ff ff       	jmp    801057f0 <trap+0xb0>
8010587f:	90                   	nop
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105880:	8b 7b 38             	mov    0x38(%ebx),%edi
80105883:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80105887:	e8 44 df ff ff       	call   801037d0 <cpuid>
8010588c:	c7 04 24 28 76 10 80 	movl   $0x80107628,(%esp)
80105893:	89 7c 24 0c          	mov    %edi,0xc(%esp)
80105897:	89 74 24 08          	mov    %esi,0x8(%esp)
8010589b:	89 44 24 04          	mov    %eax,0x4(%esp)
8010589f:	e8 ac ad ff ff       	call   80100650 <cprintf>
            cpuid(), tf->cs, tf->eip);
    lapiceoi();
801058a4:	e8 27 cf ff ff       	call   801027d0 <lapiceoi>
    break;
801058a9:	e9 42 ff ff ff       	jmp    801057f0 <trap+0xb0>
801058ae:	66 90                	xchg   %ax,%ax
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_COM1:
    uartintr();
801058b0:	e8 2b 02 00 00       	call   80105ae0 <uartintr>
    lapiceoi();
801058b5:	e8 16 cf ff ff       	call   801027d0 <lapiceoi>
    break;
801058ba:	e9 31 ff ff ff       	jmp    801057f0 <trap+0xb0>
801058bf:	90                   	nop
    break;
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
801058c0:	e8 db cd ff ff       	call   801026a0 <kbdintr>
    lapiceoi();
801058c5:	e8 06 cf ff ff       	call   801027d0 <lapiceoi>
    break;
801058ca:	e9 21 ff ff ff       	jmp    801057f0 <trap+0xb0>
801058cf:	90                   	nop
    return;
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
801058d0:	e8 fb de ff ff       	call   801037d0 <cpuid>
801058d5:	85 c0                	test   %eax,%eax
801058d7:	75 9c                	jne    80105875 <trap+0x135>
      acquire(&tickslock);
801058d9:	c7 04 24 60 4c 11 80 	movl   $0x80114c60,(%esp)
801058e0:	e8 5b ea ff ff       	call   80104340 <acquire>
      ticks++;
801058e5:	83 05 a0 54 11 80 01 	addl   $0x1,0x801154a0
      wakeup(&ticks);
801058ec:	c7 04 24 a0 54 11 80 	movl   $0x801154a0,(%esp)
801058f3:	e8 f8 e5 ff ff       	call   80103ef0 <wakeup>
      release(&tickslock);
801058f8:	c7 04 24 60 4c 11 80 	movl   $0x80114c60,(%esp)
801058ff:	e8 ac ea ff ff       	call   801043b0 <release>
80105904:	e9 6c ff ff ff       	jmp    80105875 <trap+0x135>
80105909:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105910:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80105914:	0f 85 15 ff ff ff    	jne    8010582f <trap+0xef>
8010591a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();
80105920:	e8 eb e3 ff ff       	call   80103d10 <yield>
80105925:	e9 05 ff ff ff       	jmp    8010582f <trap+0xef>
8010592a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
80105930:	e8 bb de ff ff       	call   801037f0 <myproc>
80105935:	8b 70 24             	mov    0x24(%eax),%esi
80105938:	85 f6                	test   %esi,%esi
8010593a:	75 44                	jne    80105980 <trap+0x240>
      exit();
    myproc()->tf = tf;
8010593c:	e8 af de ff ff       	call   801037f0 <myproc>
80105941:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80105944:	e8 97 ee ff ff       	call   801047e0 <syscall>
    if(myproc()->killed)
80105949:	e8 a2 de ff ff       	call   801037f0 <myproc>
8010594e:	8b 48 24             	mov    0x24(%eax),%ecx
80105951:	85 c9                	test   %ecx,%ecx
80105953:	0f 84 fb fe ff ff    	je     80105854 <trap+0x114>
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
    exit();
}
80105959:	8b 5d f4             	mov    -0xc(%ebp),%ebx
8010595c:	8b 75 f8             	mov    -0x8(%ebp),%esi
8010595f:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105962:	89 ec                	mov    %ebp,%esp
80105964:	5d                   	pop    %ebp
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
    exit();
80105965:	e9 86 e2 ff ff       	jmp    80103bf0 <exit>
8010596a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
    exit();
80105970:	e8 7b e2 ff ff       	call   80103bf0 <exit>
80105975:	e9 9b fe ff ff       	jmp    80105815 <trap+0xd5>
8010597a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
      exit();
80105980:	e8 6b e2 ff ff       	call   80103bf0 <exit>
80105985:	eb b5                	jmp    8010593c <trap+0x1fc>
80105987:	0f 20 d7             	mov    %cr2,%edi

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
8010598a:	8b 73 38             	mov    0x38(%ebx),%esi
8010598d:	8d 76 00             	lea    0x0(%esi),%esi
80105990:	e8 3b de ff ff       	call   801037d0 <cpuid>
80105995:	89 7c 24 10          	mov    %edi,0x10(%esp)
80105999:	89 74 24 0c          	mov    %esi,0xc(%esp)
8010599d:	89 44 24 08          	mov    %eax,0x8(%esp)
801059a1:	8b 43 30             	mov    0x30(%ebx),%eax
801059a4:	c7 04 24 4c 76 10 80 	movl   $0x8010764c,(%esp)
801059ab:	89 44 24 04          	mov    %eax,0x4(%esp)
801059af:	e8 9c ac ff ff       	call   80100650 <cprintf>
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
801059b4:	c7 04 24 22 76 10 80 	movl   $0x80107622,(%esp)
801059bb:	e8 b0 a9 ff ff       	call   80100370 <panic>

801059c0 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
801059c0:	a1 a4 a5 10 80       	mov    0x8010a5a4,%eax
    return -1;
801059c5:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
801059ca:	55                   	push   %ebp
801059cb:	89 e5                	mov    %esp,%ebp
  if(!uart)
801059cd:	85 c0                	test   %eax,%eax
801059cf:	74 10                	je     801059e1 <uartgetc+0x21>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801059d1:	ba fd 03 00 00       	mov    $0x3fd,%edx
801059d6:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
801059d7:	a8 01                	test   $0x1,%al
801059d9:	74 06                	je     801059e1 <uartgetc+0x21>
801059db:	b2 f8                	mov    $0xf8,%dl
801059dd:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
801059de:	0f b6 c8             	movzbl %al,%ecx
}
801059e1:	89 c8                	mov    %ecx,%eax
801059e3:	5d                   	pop    %ebp
801059e4:	c3                   	ret    
801059e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801059e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801059f0 <uartputc>:
    uartputc(*p);
}

void
uartputc(int c)
{
801059f0:	55                   	push   %ebp
801059f1:	89 e5                	mov    %esp,%ebp
801059f3:	56                   	push   %esi
801059f4:	be fd 03 00 00       	mov    $0x3fd,%esi
801059f9:	53                   	push   %ebx
  int i;

  if(!uart)
801059fa:	bb 80 00 00 00       	mov    $0x80,%ebx
    uartputc(*p);
}

void
uartputc(int c)
{
801059ff:	83 ec 10             	sub    $0x10,%esp
  int i;

  if(!uart)
80105a02:	8b 15 a4 a5 10 80    	mov    0x8010a5a4,%edx
80105a08:	85 d2                	test   %edx,%edx
80105a0a:	75 15                	jne    80105a21 <uartputc+0x31>
80105a0c:	eb 23                	jmp    80105a31 <uartputc+0x41>
80105a0e:	66 90                	xchg   %ax,%ax
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
80105a10:	c7 04 24 0a 00 00 00 	movl   $0xa,(%esp)
80105a17:	e8 d4 cd ff ff       	call   801027f0 <microdelay>
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105a1c:	83 eb 01             	sub    $0x1,%ebx
80105a1f:	74 07                	je     80105a28 <uartputc+0x38>
80105a21:	89 f2                	mov    %esi,%edx
80105a23:	ec                   	in     (%dx),%al
80105a24:	a8 20                	test   $0x20,%al
80105a26:	74 e8                	je     80105a10 <uartputc+0x20>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105a28:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105a2d:	8b 45 08             	mov    0x8(%ebp),%eax
80105a30:	ee                   	out    %al,(%dx)
    microdelay(10);
  outb(COM1+0, c);
}
80105a31:	83 c4 10             	add    $0x10,%esp
80105a34:	5b                   	pop    %ebx
80105a35:	5e                   	pop    %esi
80105a36:	5d                   	pop    %ebp
80105a37:	c3                   	ret    
80105a38:	90                   	nop
80105a39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105a40 <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
80105a40:	55                   	push   %ebp
80105a41:	31 c9                	xor    %ecx,%ecx
80105a43:	89 e5                	mov    %esp,%ebp
80105a45:	89 c8                	mov    %ecx,%eax
80105a47:	57                   	push   %edi
80105a48:	bf fa 03 00 00       	mov    $0x3fa,%edi
80105a4d:	56                   	push   %esi
80105a4e:	89 fa                	mov    %edi,%edx
80105a50:	53                   	push   %ebx
80105a51:	83 ec 1c             	sub    $0x1c,%esp
80105a54:	ee                   	out    %al,(%dx)
80105a55:	bb fb 03 00 00       	mov    $0x3fb,%ebx
80105a5a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105a5f:	89 da                	mov    %ebx,%edx
80105a61:	ee                   	out    %al,(%dx)
80105a62:	b8 0c 00 00 00       	mov    $0xc,%eax
80105a67:	b2 f8                	mov    $0xf8,%dl
80105a69:	ee                   	out    %al,(%dx)
80105a6a:	be f9 03 00 00       	mov    $0x3f9,%esi
80105a6f:	89 c8                	mov    %ecx,%eax
80105a71:	89 f2                	mov    %esi,%edx
80105a73:	ee                   	out    %al,(%dx)
80105a74:	b8 03 00 00 00       	mov    $0x3,%eax
80105a79:	89 da                	mov    %ebx,%edx
80105a7b:	ee                   	out    %al,(%dx)
80105a7c:	b2 fc                	mov    $0xfc,%dl
80105a7e:	89 c8                	mov    %ecx,%eax
80105a80:	ee                   	out    %al,(%dx)
80105a81:	b8 01 00 00 00       	mov    $0x1,%eax
80105a86:	89 f2                	mov    %esi,%edx
80105a88:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105a89:	b2 fd                	mov    $0xfd,%dl
80105a8b:	ec                   	in     (%dx),%al
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
80105a8c:	3c ff                	cmp    $0xff,%al
80105a8e:	74 45                	je     80105ad5 <uartinit+0x95>
    return;
  uart = 1;
80105a90:	c7 05 a4 a5 10 80 01 	movl   $0x1,0x8010a5a4
80105a97:	00 00 00 
80105a9a:	89 fa                	mov    %edi,%edx
80105a9c:	ec                   	in     (%dx),%al
80105a9d:	b2 f8                	mov    $0xf8,%dl
80105a9f:	ec                   	in     (%dx),%al
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80105aa0:	bb 44 77 10 80       	mov    $0x80107744,%ebx

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);
80105aa5:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80105aac:	00 
80105aad:	c7 04 24 04 00 00 00 	movl   $0x4,(%esp)
80105ab4:	e8 07 c9 ff ff       	call   801023c0 <ioapicenable>

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80105ab9:	b8 78 00 00 00       	mov    $0x78,%eax
80105abe:	66 90                	xchg   %ax,%ax
    uartputc(*p);
80105ac0:	0f be c0             	movsbl %al,%eax
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80105ac3:	83 c3 01             	add    $0x1,%ebx
    uartputc(*p);
80105ac6:	89 04 24             	mov    %eax,(%esp)
80105ac9:	e8 22 ff ff ff       	call   801059f0 <uartputc>
  inb(COM1+2);
  inb(COM1+0);
  ioapicenable(IRQ_COM1, 0);

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80105ace:	0f b6 03             	movzbl (%ebx),%eax
80105ad1:	84 c0                	test   %al,%al
80105ad3:	75 eb                	jne    80105ac0 <uartinit+0x80>
    uartputc(*p);
}
80105ad5:	83 c4 1c             	add    $0x1c,%esp
80105ad8:	5b                   	pop    %ebx
80105ad9:	5e                   	pop    %esi
80105ada:	5f                   	pop    %edi
80105adb:	5d                   	pop    %ebp
80105adc:	c3                   	ret    
80105add:	8d 76 00             	lea    0x0(%esi),%esi

80105ae0 <uartintr>:
  return inb(COM1+0);
}

void
uartintr(void)
{
80105ae0:	55                   	push   %ebp
80105ae1:	89 e5                	mov    %esp,%ebp
80105ae3:	83 ec 18             	sub    $0x18,%esp
  consoleintr(uartgetc);
80105ae6:	c7 04 24 c0 59 10 80 	movl   $0x801059c0,(%esp)
80105aed:	e8 ce ac ff ff       	call   801007c0 <consoleintr>
}
80105af2:	c9                   	leave  
80105af3:	c3                   	ret    

80105af4 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80105af4:	6a 00                	push   $0x0
  pushl $0
80105af6:	6a 00                	push   $0x0
  jmp alltraps
80105af8:	e9 53 fb ff ff       	jmp    80105650 <alltraps>

80105afd <vector1>:
.globl vector1
vector1:
  pushl $0
80105afd:	6a 00                	push   $0x0
  pushl $1
80105aff:	6a 01                	push   $0x1
  jmp alltraps
80105b01:	e9 4a fb ff ff       	jmp    80105650 <alltraps>

80105b06 <vector2>:
.globl vector2
vector2:
  pushl $0
80105b06:	6a 00                	push   $0x0
  pushl $2
80105b08:	6a 02                	push   $0x2
  jmp alltraps
80105b0a:	e9 41 fb ff ff       	jmp    80105650 <alltraps>

80105b0f <vector3>:
.globl vector3
vector3:
  pushl $0
80105b0f:	6a 00                	push   $0x0
  pushl $3
80105b11:	6a 03                	push   $0x3
  jmp alltraps
80105b13:	e9 38 fb ff ff       	jmp    80105650 <alltraps>

80105b18 <vector4>:
.globl vector4
vector4:
  pushl $0
80105b18:	6a 00                	push   $0x0
  pushl $4
80105b1a:	6a 04                	push   $0x4
  jmp alltraps
80105b1c:	e9 2f fb ff ff       	jmp    80105650 <alltraps>

80105b21 <vector5>:
.globl vector5
vector5:
  pushl $0
80105b21:	6a 00                	push   $0x0
  pushl $5
80105b23:	6a 05                	push   $0x5
  jmp alltraps
80105b25:	e9 26 fb ff ff       	jmp    80105650 <alltraps>

80105b2a <vector6>:
.globl vector6
vector6:
  pushl $0
80105b2a:	6a 00                	push   $0x0
  pushl $6
80105b2c:	6a 06                	push   $0x6
  jmp alltraps
80105b2e:	e9 1d fb ff ff       	jmp    80105650 <alltraps>

80105b33 <vector7>:
.globl vector7
vector7:
  pushl $0
80105b33:	6a 00                	push   $0x0
  pushl $7
80105b35:	6a 07                	push   $0x7
  jmp alltraps
80105b37:	e9 14 fb ff ff       	jmp    80105650 <alltraps>

80105b3c <vector8>:
.globl vector8
vector8:
  pushl $8
80105b3c:	6a 08                	push   $0x8
  jmp alltraps
80105b3e:	e9 0d fb ff ff       	jmp    80105650 <alltraps>

80105b43 <vector9>:
.globl vector9
vector9:
  pushl $0
80105b43:	6a 00                	push   $0x0
  pushl $9
80105b45:	6a 09                	push   $0x9
  jmp alltraps
80105b47:	e9 04 fb ff ff       	jmp    80105650 <alltraps>

80105b4c <vector10>:
.globl vector10
vector10:
  pushl $10
80105b4c:	6a 0a                	push   $0xa
  jmp alltraps
80105b4e:	e9 fd fa ff ff       	jmp    80105650 <alltraps>

80105b53 <vector11>:
.globl vector11
vector11:
  pushl $11
80105b53:	6a 0b                	push   $0xb
  jmp alltraps
80105b55:	e9 f6 fa ff ff       	jmp    80105650 <alltraps>

80105b5a <vector12>:
.globl vector12
vector12:
  pushl $12
80105b5a:	6a 0c                	push   $0xc
  jmp alltraps
80105b5c:	e9 ef fa ff ff       	jmp    80105650 <alltraps>

80105b61 <vector13>:
.globl vector13
vector13:
  pushl $13
80105b61:	6a 0d                	push   $0xd
  jmp alltraps
80105b63:	e9 e8 fa ff ff       	jmp    80105650 <alltraps>

80105b68 <vector14>:
.globl vector14
vector14:
  pushl $14
80105b68:	6a 0e                	push   $0xe
  jmp alltraps
80105b6a:	e9 e1 fa ff ff       	jmp    80105650 <alltraps>

80105b6f <vector15>:
.globl vector15
vector15:
  pushl $0
80105b6f:	6a 00                	push   $0x0
  pushl $15
80105b71:	6a 0f                	push   $0xf
  jmp alltraps
80105b73:	e9 d8 fa ff ff       	jmp    80105650 <alltraps>

80105b78 <vector16>:
.globl vector16
vector16:
  pushl $0
80105b78:	6a 00                	push   $0x0
  pushl $16
80105b7a:	6a 10                	push   $0x10
  jmp alltraps
80105b7c:	e9 cf fa ff ff       	jmp    80105650 <alltraps>

80105b81 <vector17>:
.globl vector17
vector17:
  pushl $17
80105b81:	6a 11                	push   $0x11
  jmp alltraps
80105b83:	e9 c8 fa ff ff       	jmp    80105650 <alltraps>

80105b88 <vector18>:
.globl vector18
vector18:
  pushl $0
80105b88:	6a 00                	push   $0x0
  pushl $18
80105b8a:	6a 12                	push   $0x12
  jmp alltraps
80105b8c:	e9 bf fa ff ff       	jmp    80105650 <alltraps>

80105b91 <vector19>:
.globl vector19
vector19:
  pushl $0
80105b91:	6a 00                	push   $0x0
  pushl $19
80105b93:	6a 13                	push   $0x13
  jmp alltraps
80105b95:	e9 b6 fa ff ff       	jmp    80105650 <alltraps>

80105b9a <vector20>:
.globl vector20
vector20:
  pushl $0
80105b9a:	6a 00                	push   $0x0
  pushl $20
80105b9c:	6a 14                	push   $0x14
  jmp alltraps
80105b9e:	e9 ad fa ff ff       	jmp    80105650 <alltraps>

80105ba3 <vector21>:
.globl vector21
vector21:
  pushl $0
80105ba3:	6a 00                	push   $0x0
  pushl $21
80105ba5:	6a 15                	push   $0x15
  jmp alltraps
80105ba7:	e9 a4 fa ff ff       	jmp    80105650 <alltraps>

80105bac <vector22>:
.globl vector22
vector22:
  pushl $0
80105bac:	6a 00                	push   $0x0
  pushl $22
80105bae:	6a 16                	push   $0x16
  jmp alltraps
80105bb0:	e9 9b fa ff ff       	jmp    80105650 <alltraps>

80105bb5 <vector23>:
.globl vector23
vector23:
  pushl $0
80105bb5:	6a 00                	push   $0x0
  pushl $23
80105bb7:	6a 17                	push   $0x17
  jmp alltraps
80105bb9:	e9 92 fa ff ff       	jmp    80105650 <alltraps>

80105bbe <vector24>:
.globl vector24
vector24:
  pushl $0
80105bbe:	6a 00                	push   $0x0
  pushl $24
80105bc0:	6a 18                	push   $0x18
  jmp alltraps
80105bc2:	e9 89 fa ff ff       	jmp    80105650 <alltraps>

80105bc7 <vector25>:
.globl vector25
vector25:
  pushl $0
80105bc7:	6a 00                	push   $0x0
  pushl $25
80105bc9:	6a 19                	push   $0x19
  jmp alltraps
80105bcb:	e9 80 fa ff ff       	jmp    80105650 <alltraps>

80105bd0 <vector26>:
.globl vector26
vector26:
  pushl $0
80105bd0:	6a 00                	push   $0x0
  pushl $26
80105bd2:	6a 1a                	push   $0x1a
  jmp alltraps
80105bd4:	e9 77 fa ff ff       	jmp    80105650 <alltraps>

80105bd9 <vector27>:
.globl vector27
vector27:
  pushl $0
80105bd9:	6a 00                	push   $0x0
  pushl $27
80105bdb:	6a 1b                	push   $0x1b
  jmp alltraps
80105bdd:	e9 6e fa ff ff       	jmp    80105650 <alltraps>

80105be2 <vector28>:
.globl vector28
vector28:
  pushl $0
80105be2:	6a 00                	push   $0x0
  pushl $28
80105be4:	6a 1c                	push   $0x1c
  jmp alltraps
80105be6:	e9 65 fa ff ff       	jmp    80105650 <alltraps>

80105beb <vector29>:
.globl vector29
vector29:
  pushl $0
80105beb:	6a 00                	push   $0x0
  pushl $29
80105bed:	6a 1d                	push   $0x1d
  jmp alltraps
80105bef:	e9 5c fa ff ff       	jmp    80105650 <alltraps>

80105bf4 <vector30>:
.globl vector30
vector30:
  pushl $0
80105bf4:	6a 00                	push   $0x0
  pushl $30
80105bf6:	6a 1e                	push   $0x1e
  jmp alltraps
80105bf8:	e9 53 fa ff ff       	jmp    80105650 <alltraps>

80105bfd <vector31>:
.globl vector31
vector31:
  pushl $0
80105bfd:	6a 00                	push   $0x0
  pushl $31
80105bff:	6a 1f                	push   $0x1f
  jmp alltraps
80105c01:	e9 4a fa ff ff       	jmp    80105650 <alltraps>

80105c06 <vector32>:
.globl vector32
vector32:
  pushl $0
80105c06:	6a 00                	push   $0x0
  pushl $32
80105c08:	6a 20                	push   $0x20
  jmp alltraps
80105c0a:	e9 41 fa ff ff       	jmp    80105650 <alltraps>

80105c0f <vector33>:
.globl vector33
vector33:
  pushl $0
80105c0f:	6a 00                	push   $0x0
  pushl $33
80105c11:	6a 21                	push   $0x21
  jmp alltraps
80105c13:	e9 38 fa ff ff       	jmp    80105650 <alltraps>

80105c18 <vector34>:
.globl vector34
vector34:
  pushl $0
80105c18:	6a 00                	push   $0x0
  pushl $34
80105c1a:	6a 22                	push   $0x22
  jmp alltraps
80105c1c:	e9 2f fa ff ff       	jmp    80105650 <alltraps>

80105c21 <vector35>:
.globl vector35
vector35:
  pushl $0
80105c21:	6a 00                	push   $0x0
  pushl $35
80105c23:	6a 23                	push   $0x23
  jmp alltraps
80105c25:	e9 26 fa ff ff       	jmp    80105650 <alltraps>

80105c2a <vector36>:
.globl vector36
vector36:
  pushl $0
80105c2a:	6a 00                	push   $0x0
  pushl $36
80105c2c:	6a 24                	push   $0x24
  jmp alltraps
80105c2e:	e9 1d fa ff ff       	jmp    80105650 <alltraps>

80105c33 <vector37>:
.globl vector37
vector37:
  pushl $0
80105c33:	6a 00                	push   $0x0
  pushl $37
80105c35:	6a 25                	push   $0x25
  jmp alltraps
80105c37:	e9 14 fa ff ff       	jmp    80105650 <alltraps>

80105c3c <vector38>:
.globl vector38
vector38:
  pushl $0
80105c3c:	6a 00                	push   $0x0
  pushl $38
80105c3e:	6a 26                	push   $0x26
  jmp alltraps
80105c40:	e9 0b fa ff ff       	jmp    80105650 <alltraps>

80105c45 <vector39>:
.globl vector39
vector39:
  pushl $0
80105c45:	6a 00                	push   $0x0
  pushl $39
80105c47:	6a 27                	push   $0x27
  jmp alltraps
80105c49:	e9 02 fa ff ff       	jmp    80105650 <alltraps>

80105c4e <vector40>:
.globl vector40
vector40:
  pushl $0
80105c4e:	6a 00                	push   $0x0
  pushl $40
80105c50:	6a 28                	push   $0x28
  jmp alltraps
80105c52:	e9 f9 f9 ff ff       	jmp    80105650 <alltraps>

80105c57 <vector41>:
.globl vector41
vector41:
  pushl $0
80105c57:	6a 00                	push   $0x0
  pushl $41
80105c59:	6a 29                	push   $0x29
  jmp alltraps
80105c5b:	e9 f0 f9 ff ff       	jmp    80105650 <alltraps>

80105c60 <vector42>:
.globl vector42
vector42:
  pushl $0
80105c60:	6a 00                	push   $0x0
  pushl $42
80105c62:	6a 2a                	push   $0x2a
  jmp alltraps
80105c64:	e9 e7 f9 ff ff       	jmp    80105650 <alltraps>

80105c69 <vector43>:
.globl vector43
vector43:
  pushl $0
80105c69:	6a 00                	push   $0x0
  pushl $43
80105c6b:	6a 2b                	push   $0x2b
  jmp alltraps
80105c6d:	e9 de f9 ff ff       	jmp    80105650 <alltraps>

80105c72 <vector44>:
.globl vector44
vector44:
  pushl $0
80105c72:	6a 00                	push   $0x0
  pushl $44
80105c74:	6a 2c                	push   $0x2c
  jmp alltraps
80105c76:	e9 d5 f9 ff ff       	jmp    80105650 <alltraps>

80105c7b <vector45>:
.globl vector45
vector45:
  pushl $0
80105c7b:	6a 00                	push   $0x0
  pushl $45
80105c7d:	6a 2d                	push   $0x2d
  jmp alltraps
80105c7f:	e9 cc f9 ff ff       	jmp    80105650 <alltraps>

80105c84 <vector46>:
.globl vector46
vector46:
  pushl $0
80105c84:	6a 00                	push   $0x0
  pushl $46
80105c86:	6a 2e                	push   $0x2e
  jmp alltraps
80105c88:	e9 c3 f9 ff ff       	jmp    80105650 <alltraps>

80105c8d <vector47>:
.globl vector47
vector47:
  pushl $0
80105c8d:	6a 00                	push   $0x0
  pushl $47
80105c8f:	6a 2f                	push   $0x2f
  jmp alltraps
80105c91:	e9 ba f9 ff ff       	jmp    80105650 <alltraps>

80105c96 <vector48>:
.globl vector48
vector48:
  pushl $0
80105c96:	6a 00                	push   $0x0
  pushl $48
80105c98:	6a 30                	push   $0x30
  jmp alltraps
80105c9a:	e9 b1 f9 ff ff       	jmp    80105650 <alltraps>

80105c9f <vector49>:
.globl vector49
vector49:
  pushl $0
80105c9f:	6a 00                	push   $0x0
  pushl $49
80105ca1:	6a 31                	push   $0x31
  jmp alltraps
80105ca3:	e9 a8 f9 ff ff       	jmp    80105650 <alltraps>

80105ca8 <vector50>:
.globl vector50
vector50:
  pushl $0
80105ca8:	6a 00                	push   $0x0
  pushl $50
80105caa:	6a 32                	push   $0x32
  jmp alltraps
80105cac:	e9 9f f9 ff ff       	jmp    80105650 <alltraps>

80105cb1 <vector51>:
.globl vector51
vector51:
  pushl $0
80105cb1:	6a 00                	push   $0x0
  pushl $51
80105cb3:	6a 33                	push   $0x33
  jmp alltraps
80105cb5:	e9 96 f9 ff ff       	jmp    80105650 <alltraps>

80105cba <vector52>:
.globl vector52
vector52:
  pushl $0
80105cba:	6a 00                	push   $0x0
  pushl $52
80105cbc:	6a 34                	push   $0x34
  jmp alltraps
80105cbe:	e9 8d f9 ff ff       	jmp    80105650 <alltraps>

80105cc3 <vector53>:
.globl vector53
vector53:
  pushl $0
80105cc3:	6a 00                	push   $0x0
  pushl $53
80105cc5:	6a 35                	push   $0x35
  jmp alltraps
80105cc7:	e9 84 f9 ff ff       	jmp    80105650 <alltraps>

80105ccc <vector54>:
.globl vector54
vector54:
  pushl $0
80105ccc:	6a 00                	push   $0x0
  pushl $54
80105cce:	6a 36                	push   $0x36
  jmp alltraps
80105cd0:	e9 7b f9 ff ff       	jmp    80105650 <alltraps>

80105cd5 <vector55>:
.globl vector55
vector55:
  pushl $0
80105cd5:	6a 00                	push   $0x0
  pushl $55
80105cd7:	6a 37                	push   $0x37
  jmp alltraps
80105cd9:	e9 72 f9 ff ff       	jmp    80105650 <alltraps>

80105cde <vector56>:
.globl vector56
vector56:
  pushl $0
80105cde:	6a 00                	push   $0x0
  pushl $56
80105ce0:	6a 38                	push   $0x38
  jmp alltraps
80105ce2:	e9 69 f9 ff ff       	jmp    80105650 <alltraps>

80105ce7 <vector57>:
.globl vector57
vector57:
  pushl $0
80105ce7:	6a 00                	push   $0x0
  pushl $57
80105ce9:	6a 39                	push   $0x39
  jmp alltraps
80105ceb:	e9 60 f9 ff ff       	jmp    80105650 <alltraps>

80105cf0 <vector58>:
.globl vector58
vector58:
  pushl $0
80105cf0:	6a 00                	push   $0x0
  pushl $58
80105cf2:	6a 3a                	push   $0x3a
  jmp alltraps
80105cf4:	e9 57 f9 ff ff       	jmp    80105650 <alltraps>

80105cf9 <vector59>:
.globl vector59
vector59:
  pushl $0
80105cf9:	6a 00                	push   $0x0
  pushl $59
80105cfb:	6a 3b                	push   $0x3b
  jmp alltraps
80105cfd:	e9 4e f9 ff ff       	jmp    80105650 <alltraps>

80105d02 <vector60>:
.globl vector60
vector60:
  pushl $0
80105d02:	6a 00                	push   $0x0
  pushl $60
80105d04:	6a 3c                	push   $0x3c
  jmp alltraps
80105d06:	e9 45 f9 ff ff       	jmp    80105650 <alltraps>

80105d0b <vector61>:
.globl vector61
vector61:
  pushl $0
80105d0b:	6a 00                	push   $0x0
  pushl $61
80105d0d:	6a 3d                	push   $0x3d
  jmp alltraps
80105d0f:	e9 3c f9 ff ff       	jmp    80105650 <alltraps>

80105d14 <vector62>:
.globl vector62
vector62:
  pushl $0
80105d14:	6a 00                	push   $0x0
  pushl $62
80105d16:	6a 3e                	push   $0x3e
  jmp alltraps
80105d18:	e9 33 f9 ff ff       	jmp    80105650 <alltraps>

80105d1d <vector63>:
.globl vector63
vector63:
  pushl $0
80105d1d:	6a 00                	push   $0x0
  pushl $63
80105d1f:	6a 3f                	push   $0x3f
  jmp alltraps
80105d21:	e9 2a f9 ff ff       	jmp    80105650 <alltraps>

80105d26 <vector64>:
.globl vector64
vector64:
  pushl $0
80105d26:	6a 00                	push   $0x0
  pushl $64
80105d28:	6a 40                	push   $0x40
  jmp alltraps
80105d2a:	e9 21 f9 ff ff       	jmp    80105650 <alltraps>

80105d2f <vector65>:
.globl vector65
vector65:
  pushl $0
80105d2f:	6a 00                	push   $0x0
  pushl $65
80105d31:	6a 41                	push   $0x41
  jmp alltraps
80105d33:	e9 18 f9 ff ff       	jmp    80105650 <alltraps>

80105d38 <vector66>:
.globl vector66
vector66:
  pushl $0
80105d38:	6a 00                	push   $0x0
  pushl $66
80105d3a:	6a 42                	push   $0x42
  jmp alltraps
80105d3c:	e9 0f f9 ff ff       	jmp    80105650 <alltraps>

80105d41 <vector67>:
.globl vector67
vector67:
  pushl $0
80105d41:	6a 00                	push   $0x0
  pushl $67
80105d43:	6a 43                	push   $0x43
  jmp alltraps
80105d45:	e9 06 f9 ff ff       	jmp    80105650 <alltraps>

80105d4a <vector68>:
.globl vector68
vector68:
  pushl $0
80105d4a:	6a 00                	push   $0x0
  pushl $68
80105d4c:	6a 44                	push   $0x44
  jmp alltraps
80105d4e:	e9 fd f8 ff ff       	jmp    80105650 <alltraps>

80105d53 <vector69>:
.globl vector69
vector69:
  pushl $0
80105d53:	6a 00                	push   $0x0
  pushl $69
80105d55:	6a 45                	push   $0x45
  jmp alltraps
80105d57:	e9 f4 f8 ff ff       	jmp    80105650 <alltraps>

80105d5c <vector70>:
.globl vector70
vector70:
  pushl $0
80105d5c:	6a 00                	push   $0x0
  pushl $70
80105d5e:	6a 46                	push   $0x46
  jmp alltraps
80105d60:	e9 eb f8 ff ff       	jmp    80105650 <alltraps>

80105d65 <vector71>:
.globl vector71
vector71:
  pushl $0
80105d65:	6a 00                	push   $0x0
  pushl $71
80105d67:	6a 47                	push   $0x47
  jmp alltraps
80105d69:	e9 e2 f8 ff ff       	jmp    80105650 <alltraps>

80105d6e <vector72>:
.globl vector72
vector72:
  pushl $0
80105d6e:	6a 00                	push   $0x0
  pushl $72
80105d70:	6a 48                	push   $0x48
  jmp alltraps
80105d72:	e9 d9 f8 ff ff       	jmp    80105650 <alltraps>

80105d77 <vector73>:
.globl vector73
vector73:
  pushl $0
80105d77:	6a 00                	push   $0x0
  pushl $73
80105d79:	6a 49                	push   $0x49
  jmp alltraps
80105d7b:	e9 d0 f8 ff ff       	jmp    80105650 <alltraps>

80105d80 <vector74>:
.globl vector74
vector74:
  pushl $0
80105d80:	6a 00                	push   $0x0
  pushl $74
80105d82:	6a 4a                	push   $0x4a
  jmp alltraps
80105d84:	e9 c7 f8 ff ff       	jmp    80105650 <alltraps>

80105d89 <vector75>:
.globl vector75
vector75:
  pushl $0
80105d89:	6a 00                	push   $0x0
  pushl $75
80105d8b:	6a 4b                	push   $0x4b
  jmp alltraps
80105d8d:	e9 be f8 ff ff       	jmp    80105650 <alltraps>

80105d92 <vector76>:
.globl vector76
vector76:
  pushl $0
80105d92:	6a 00                	push   $0x0
  pushl $76
80105d94:	6a 4c                	push   $0x4c
  jmp alltraps
80105d96:	e9 b5 f8 ff ff       	jmp    80105650 <alltraps>

80105d9b <vector77>:
.globl vector77
vector77:
  pushl $0
80105d9b:	6a 00                	push   $0x0
  pushl $77
80105d9d:	6a 4d                	push   $0x4d
  jmp alltraps
80105d9f:	e9 ac f8 ff ff       	jmp    80105650 <alltraps>

80105da4 <vector78>:
.globl vector78
vector78:
  pushl $0
80105da4:	6a 00                	push   $0x0
  pushl $78
80105da6:	6a 4e                	push   $0x4e
  jmp alltraps
80105da8:	e9 a3 f8 ff ff       	jmp    80105650 <alltraps>

80105dad <vector79>:
.globl vector79
vector79:
  pushl $0
80105dad:	6a 00                	push   $0x0
  pushl $79
80105daf:	6a 4f                	push   $0x4f
  jmp alltraps
80105db1:	e9 9a f8 ff ff       	jmp    80105650 <alltraps>

80105db6 <vector80>:
.globl vector80
vector80:
  pushl $0
80105db6:	6a 00                	push   $0x0
  pushl $80
80105db8:	6a 50                	push   $0x50
  jmp alltraps
80105dba:	e9 91 f8 ff ff       	jmp    80105650 <alltraps>

80105dbf <vector81>:
.globl vector81
vector81:
  pushl $0
80105dbf:	6a 00                	push   $0x0
  pushl $81
80105dc1:	6a 51                	push   $0x51
  jmp alltraps
80105dc3:	e9 88 f8 ff ff       	jmp    80105650 <alltraps>

80105dc8 <vector82>:
.globl vector82
vector82:
  pushl $0
80105dc8:	6a 00                	push   $0x0
  pushl $82
80105dca:	6a 52                	push   $0x52
  jmp alltraps
80105dcc:	e9 7f f8 ff ff       	jmp    80105650 <alltraps>

80105dd1 <vector83>:
.globl vector83
vector83:
  pushl $0
80105dd1:	6a 00                	push   $0x0
  pushl $83
80105dd3:	6a 53                	push   $0x53
  jmp alltraps
80105dd5:	e9 76 f8 ff ff       	jmp    80105650 <alltraps>

80105dda <vector84>:
.globl vector84
vector84:
  pushl $0
80105dda:	6a 00                	push   $0x0
  pushl $84
80105ddc:	6a 54                	push   $0x54
  jmp alltraps
80105dde:	e9 6d f8 ff ff       	jmp    80105650 <alltraps>

80105de3 <vector85>:
.globl vector85
vector85:
  pushl $0
80105de3:	6a 00                	push   $0x0
  pushl $85
80105de5:	6a 55                	push   $0x55
  jmp alltraps
80105de7:	e9 64 f8 ff ff       	jmp    80105650 <alltraps>

80105dec <vector86>:
.globl vector86
vector86:
  pushl $0
80105dec:	6a 00                	push   $0x0
  pushl $86
80105dee:	6a 56                	push   $0x56
  jmp alltraps
80105df0:	e9 5b f8 ff ff       	jmp    80105650 <alltraps>

80105df5 <vector87>:
.globl vector87
vector87:
  pushl $0
80105df5:	6a 00                	push   $0x0
  pushl $87
80105df7:	6a 57                	push   $0x57
  jmp alltraps
80105df9:	e9 52 f8 ff ff       	jmp    80105650 <alltraps>

80105dfe <vector88>:
.globl vector88
vector88:
  pushl $0
80105dfe:	6a 00                	push   $0x0
  pushl $88
80105e00:	6a 58                	push   $0x58
  jmp alltraps
80105e02:	e9 49 f8 ff ff       	jmp    80105650 <alltraps>

80105e07 <vector89>:
.globl vector89
vector89:
  pushl $0
80105e07:	6a 00                	push   $0x0
  pushl $89
80105e09:	6a 59                	push   $0x59
  jmp alltraps
80105e0b:	e9 40 f8 ff ff       	jmp    80105650 <alltraps>

80105e10 <vector90>:
.globl vector90
vector90:
  pushl $0
80105e10:	6a 00                	push   $0x0
  pushl $90
80105e12:	6a 5a                	push   $0x5a
  jmp alltraps
80105e14:	e9 37 f8 ff ff       	jmp    80105650 <alltraps>

80105e19 <vector91>:
.globl vector91
vector91:
  pushl $0
80105e19:	6a 00                	push   $0x0
  pushl $91
80105e1b:	6a 5b                	push   $0x5b
  jmp alltraps
80105e1d:	e9 2e f8 ff ff       	jmp    80105650 <alltraps>

80105e22 <vector92>:
.globl vector92
vector92:
  pushl $0
80105e22:	6a 00                	push   $0x0
  pushl $92
80105e24:	6a 5c                	push   $0x5c
  jmp alltraps
80105e26:	e9 25 f8 ff ff       	jmp    80105650 <alltraps>

80105e2b <vector93>:
.globl vector93
vector93:
  pushl $0
80105e2b:	6a 00                	push   $0x0
  pushl $93
80105e2d:	6a 5d                	push   $0x5d
  jmp alltraps
80105e2f:	e9 1c f8 ff ff       	jmp    80105650 <alltraps>

80105e34 <vector94>:
.globl vector94
vector94:
  pushl $0
80105e34:	6a 00                	push   $0x0
  pushl $94
80105e36:	6a 5e                	push   $0x5e
  jmp alltraps
80105e38:	e9 13 f8 ff ff       	jmp    80105650 <alltraps>

80105e3d <vector95>:
.globl vector95
vector95:
  pushl $0
80105e3d:	6a 00                	push   $0x0
  pushl $95
80105e3f:	6a 5f                	push   $0x5f
  jmp alltraps
80105e41:	e9 0a f8 ff ff       	jmp    80105650 <alltraps>

80105e46 <vector96>:
.globl vector96
vector96:
  pushl $0
80105e46:	6a 00                	push   $0x0
  pushl $96
80105e48:	6a 60                	push   $0x60
  jmp alltraps
80105e4a:	e9 01 f8 ff ff       	jmp    80105650 <alltraps>

80105e4f <vector97>:
.globl vector97
vector97:
  pushl $0
80105e4f:	6a 00                	push   $0x0
  pushl $97
80105e51:	6a 61                	push   $0x61
  jmp alltraps
80105e53:	e9 f8 f7 ff ff       	jmp    80105650 <alltraps>

80105e58 <vector98>:
.globl vector98
vector98:
  pushl $0
80105e58:	6a 00                	push   $0x0
  pushl $98
80105e5a:	6a 62                	push   $0x62
  jmp alltraps
80105e5c:	e9 ef f7 ff ff       	jmp    80105650 <alltraps>

80105e61 <vector99>:
.globl vector99
vector99:
  pushl $0
80105e61:	6a 00                	push   $0x0
  pushl $99
80105e63:	6a 63                	push   $0x63
  jmp alltraps
80105e65:	e9 e6 f7 ff ff       	jmp    80105650 <alltraps>

80105e6a <vector100>:
.globl vector100
vector100:
  pushl $0
80105e6a:	6a 00                	push   $0x0
  pushl $100
80105e6c:	6a 64                	push   $0x64
  jmp alltraps
80105e6e:	e9 dd f7 ff ff       	jmp    80105650 <alltraps>

80105e73 <vector101>:
.globl vector101
vector101:
  pushl $0
80105e73:	6a 00                	push   $0x0
  pushl $101
80105e75:	6a 65                	push   $0x65
  jmp alltraps
80105e77:	e9 d4 f7 ff ff       	jmp    80105650 <alltraps>

80105e7c <vector102>:
.globl vector102
vector102:
  pushl $0
80105e7c:	6a 00                	push   $0x0
  pushl $102
80105e7e:	6a 66                	push   $0x66
  jmp alltraps
80105e80:	e9 cb f7 ff ff       	jmp    80105650 <alltraps>

80105e85 <vector103>:
.globl vector103
vector103:
  pushl $0
80105e85:	6a 00                	push   $0x0
  pushl $103
80105e87:	6a 67                	push   $0x67
  jmp alltraps
80105e89:	e9 c2 f7 ff ff       	jmp    80105650 <alltraps>

80105e8e <vector104>:
.globl vector104
vector104:
  pushl $0
80105e8e:	6a 00                	push   $0x0
  pushl $104
80105e90:	6a 68                	push   $0x68
  jmp alltraps
80105e92:	e9 b9 f7 ff ff       	jmp    80105650 <alltraps>

80105e97 <vector105>:
.globl vector105
vector105:
  pushl $0
80105e97:	6a 00                	push   $0x0
  pushl $105
80105e99:	6a 69                	push   $0x69
  jmp alltraps
80105e9b:	e9 b0 f7 ff ff       	jmp    80105650 <alltraps>

80105ea0 <vector106>:
.globl vector106
vector106:
  pushl $0
80105ea0:	6a 00                	push   $0x0
  pushl $106
80105ea2:	6a 6a                	push   $0x6a
  jmp alltraps
80105ea4:	e9 a7 f7 ff ff       	jmp    80105650 <alltraps>

80105ea9 <vector107>:
.globl vector107
vector107:
  pushl $0
80105ea9:	6a 00                	push   $0x0
  pushl $107
80105eab:	6a 6b                	push   $0x6b
  jmp alltraps
80105ead:	e9 9e f7 ff ff       	jmp    80105650 <alltraps>

80105eb2 <vector108>:
.globl vector108
vector108:
  pushl $0
80105eb2:	6a 00                	push   $0x0
  pushl $108
80105eb4:	6a 6c                	push   $0x6c
  jmp alltraps
80105eb6:	e9 95 f7 ff ff       	jmp    80105650 <alltraps>

80105ebb <vector109>:
.globl vector109
vector109:
  pushl $0
80105ebb:	6a 00                	push   $0x0
  pushl $109
80105ebd:	6a 6d                	push   $0x6d
  jmp alltraps
80105ebf:	e9 8c f7 ff ff       	jmp    80105650 <alltraps>

80105ec4 <vector110>:
.globl vector110
vector110:
  pushl $0
80105ec4:	6a 00                	push   $0x0
  pushl $110
80105ec6:	6a 6e                	push   $0x6e
  jmp alltraps
80105ec8:	e9 83 f7 ff ff       	jmp    80105650 <alltraps>

80105ecd <vector111>:
.globl vector111
vector111:
  pushl $0
80105ecd:	6a 00                	push   $0x0
  pushl $111
80105ecf:	6a 6f                	push   $0x6f
  jmp alltraps
80105ed1:	e9 7a f7 ff ff       	jmp    80105650 <alltraps>

80105ed6 <vector112>:
.globl vector112
vector112:
  pushl $0
80105ed6:	6a 00                	push   $0x0
  pushl $112
80105ed8:	6a 70                	push   $0x70
  jmp alltraps
80105eda:	e9 71 f7 ff ff       	jmp    80105650 <alltraps>

80105edf <vector113>:
.globl vector113
vector113:
  pushl $0
80105edf:	6a 00                	push   $0x0
  pushl $113
80105ee1:	6a 71                	push   $0x71
  jmp alltraps
80105ee3:	e9 68 f7 ff ff       	jmp    80105650 <alltraps>

80105ee8 <vector114>:
.globl vector114
vector114:
  pushl $0
80105ee8:	6a 00                	push   $0x0
  pushl $114
80105eea:	6a 72                	push   $0x72
  jmp alltraps
80105eec:	e9 5f f7 ff ff       	jmp    80105650 <alltraps>

80105ef1 <vector115>:
.globl vector115
vector115:
  pushl $0
80105ef1:	6a 00                	push   $0x0
  pushl $115
80105ef3:	6a 73                	push   $0x73
  jmp alltraps
80105ef5:	e9 56 f7 ff ff       	jmp    80105650 <alltraps>

80105efa <vector116>:
.globl vector116
vector116:
  pushl $0
80105efa:	6a 00                	push   $0x0
  pushl $116
80105efc:	6a 74                	push   $0x74
  jmp alltraps
80105efe:	e9 4d f7 ff ff       	jmp    80105650 <alltraps>

80105f03 <vector117>:
.globl vector117
vector117:
  pushl $0
80105f03:	6a 00                	push   $0x0
  pushl $117
80105f05:	6a 75                	push   $0x75
  jmp alltraps
80105f07:	e9 44 f7 ff ff       	jmp    80105650 <alltraps>

80105f0c <vector118>:
.globl vector118
vector118:
  pushl $0
80105f0c:	6a 00                	push   $0x0
  pushl $118
80105f0e:	6a 76                	push   $0x76
  jmp alltraps
80105f10:	e9 3b f7 ff ff       	jmp    80105650 <alltraps>

80105f15 <vector119>:
.globl vector119
vector119:
  pushl $0
80105f15:	6a 00                	push   $0x0
  pushl $119
80105f17:	6a 77                	push   $0x77
  jmp alltraps
80105f19:	e9 32 f7 ff ff       	jmp    80105650 <alltraps>

80105f1e <vector120>:
.globl vector120
vector120:
  pushl $0
80105f1e:	6a 00                	push   $0x0
  pushl $120
80105f20:	6a 78                	push   $0x78
  jmp alltraps
80105f22:	e9 29 f7 ff ff       	jmp    80105650 <alltraps>

80105f27 <vector121>:
.globl vector121
vector121:
  pushl $0
80105f27:	6a 00                	push   $0x0
  pushl $121
80105f29:	6a 79                	push   $0x79
  jmp alltraps
80105f2b:	e9 20 f7 ff ff       	jmp    80105650 <alltraps>

80105f30 <vector122>:
.globl vector122
vector122:
  pushl $0
80105f30:	6a 00                	push   $0x0
  pushl $122
80105f32:	6a 7a                	push   $0x7a
  jmp alltraps
80105f34:	e9 17 f7 ff ff       	jmp    80105650 <alltraps>

80105f39 <vector123>:
.globl vector123
vector123:
  pushl $0
80105f39:	6a 00                	push   $0x0
  pushl $123
80105f3b:	6a 7b                	push   $0x7b
  jmp alltraps
80105f3d:	e9 0e f7 ff ff       	jmp    80105650 <alltraps>

80105f42 <vector124>:
.globl vector124
vector124:
  pushl $0
80105f42:	6a 00                	push   $0x0
  pushl $124
80105f44:	6a 7c                	push   $0x7c
  jmp alltraps
80105f46:	e9 05 f7 ff ff       	jmp    80105650 <alltraps>

80105f4b <vector125>:
.globl vector125
vector125:
  pushl $0
80105f4b:	6a 00                	push   $0x0
  pushl $125
80105f4d:	6a 7d                	push   $0x7d
  jmp alltraps
80105f4f:	e9 fc f6 ff ff       	jmp    80105650 <alltraps>

80105f54 <vector126>:
.globl vector126
vector126:
  pushl $0
80105f54:	6a 00                	push   $0x0
  pushl $126
80105f56:	6a 7e                	push   $0x7e
  jmp alltraps
80105f58:	e9 f3 f6 ff ff       	jmp    80105650 <alltraps>

80105f5d <vector127>:
.globl vector127
vector127:
  pushl $0
80105f5d:	6a 00                	push   $0x0
  pushl $127
80105f5f:	6a 7f                	push   $0x7f
  jmp alltraps
80105f61:	e9 ea f6 ff ff       	jmp    80105650 <alltraps>

80105f66 <vector128>:
.globl vector128
vector128:
  pushl $0
80105f66:	6a 00                	push   $0x0
  pushl $128
80105f68:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80105f6d:	e9 de f6 ff ff       	jmp    80105650 <alltraps>

80105f72 <vector129>:
.globl vector129
vector129:
  pushl $0
80105f72:	6a 00                	push   $0x0
  pushl $129
80105f74:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80105f79:	e9 d2 f6 ff ff       	jmp    80105650 <alltraps>

80105f7e <vector130>:
.globl vector130
vector130:
  pushl $0
80105f7e:	6a 00                	push   $0x0
  pushl $130
80105f80:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80105f85:	e9 c6 f6 ff ff       	jmp    80105650 <alltraps>

80105f8a <vector131>:
.globl vector131
vector131:
  pushl $0
80105f8a:	6a 00                	push   $0x0
  pushl $131
80105f8c:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80105f91:	e9 ba f6 ff ff       	jmp    80105650 <alltraps>

80105f96 <vector132>:
.globl vector132
vector132:
  pushl $0
80105f96:	6a 00                	push   $0x0
  pushl $132
80105f98:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80105f9d:	e9 ae f6 ff ff       	jmp    80105650 <alltraps>

80105fa2 <vector133>:
.globl vector133
vector133:
  pushl $0
80105fa2:	6a 00                	push   $0x0
  pushl $133
80105fa4:	68 85 00 00 00       	push   $0x85
  jmp alltraps
80105fa9:	e9 a2 f6 ff ff       	jmp    80105650 <alltraps>

80105fae <vector134>:
.globl vector134
vector134:
  pushl $0
80105fae:	6a 00                	push   $0x0
  pushl $134
80105fb0:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80105fb5:	e9 96 f6 ff ff       	jmp    80105650 <alltraps>

80105fba <vector135>:
.globl vector135
vector135:
  pushl $0
80105fba:	6a 00                	push   $0x0
  pushl $135
80105fbc:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80105fc1:	e9 8a f6 ff ff       	jmp    80105650 <alltraps>

80105fc6 <vector136>:
.globl vector136
vector136:
  pushl $0
80105fc6:	6a 00                	push   $0x0
  pushl $136
80105fc8:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80105fcd:	e9 7e f6 ff ff       	jmp    80105650 <alltraps>

80105fd2 <vector137>:
.globl vector137
vector137:
  pushl $0
80105fd2:	6a 00                	push   $0x0
  pushl $137
80105fd4:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80105fd9:	e9 72 f6 ff ff       	jmp    80105650 <alltraps>

80105fde <vector138>:
.globl vector138
vector138:
  pushl $0
80105fde:	6a 00                	push   $0x0
  pushl $138
80105fe0:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80105fe5:	e9 66 f6 ff ff       	jmp    80105650 <alltraps>

80105fea <vector139>:
.globl vector139
vector139:
  pushl $0
80105fea:	6a 00                	push   $0x0
  pushl $139
80105fec:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80105ff1:	e9 5a f6 ff ff       	jmp    80105650 <alltraps>

80105ff6 <vector140>:
.globl vector140
vector140:
  pushl $0
80105ff6:	6a 00                	push   $0x0
  pushl $140
80105ff8:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80105ffd:	e9 4e f6 ff ff       	jmp    80105650 <alltraps>

80106002 <vector141>:
.globl vector141
vector141:
  pushl $0
80106002:	6a 00                	push   $0x0
  pushl $141
80106004:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80106009:	e9 42 f6 ff ff       	jmp    80105650 <alltraps>

8010600e <vector142>:
.globl vector142
vector142:
  pushl $0
8010600e:	6a 00                	push   $0x0
  pushl $142
80106010:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106015:	e9 36 f6 ff ff       	jmp    80105650 <alltraps>

8010601a <vector143>:
.globl vector143
vector143:
  pushl $0
8010601a:	6a 00                	push   $0x0
  pushl $143
8010601c:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106021:	e9 2a f6 ff ff       	jmp    80105650 <alltraps>

80106026 <vector144>:
.globl vector144
vector144:
  pushl $0
80106026:	6a 00                	push   $0x0
  pushl $144
80106028:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010602d:	e9 1e f6 ff ff       	jmp    80105650 <alltraps>

80106032 <vector145>:
.globl vector145
vector145:
  pushl $0
80106032:	6a 00                	push   $0x0
  pushl $145
80106034:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80106039:	e9 12 f6 ff ff       	jmp    80105650 <alltraps>

8010603e <vector146>:
.globl vector146
vector146:
  pushl $0
8010603e:	6a 00                	push   $0x0
  pushl $146
80106040:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106045:	e9 06 f6 ff ff       	jmp    80105650 <alltraps>

8010604a <vector147>:
.globl vector147
vector147:
  pushl $0
8010604a:	6a 00                	push   $0x0
  pushl $147
8010604c:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106051:	e9 fa f5 ff ff       	jmp    80105650 <alltraps>

80106056 <vector148>:
.globl vector148
vector148:
  pushl $0
80106056:	6a 00                	push   $0x0
  pushl $148
80106058:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010605d:	e9 ee f5 ff ff       	jmp    80105650 <alltraps>

80106062 <vector149>:
.globl vector149
vector149:
  pushl $0
80106062:	6a 00                	push   $0x0
  pushl $149
80106064:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80106069:	e9 e2 f5 ff ff       	jmp    80105650 <alltraps>

8010606e <vector150>:
.globl vector150
vector150:
  pushl $0
8010606e:	6a 00                	push   $0x0
  pushl $150
80106070:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106075:	e9 d6 f5 ff ff       	jmp    80105650 <alltraps>

8010607a <vector151>:
.globl vector151
vector151:
  pushl $0
8010607a:	6a 00                	push   $0x0
  pushl $151
8010607c:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106081:	e9 ca f5 ff ff       	jmp    80105650 <alltraps>

80106086 <vector152>:
.globl vector152
vector152:
  pushl $0
80106086:	6a 00                	push   $0x0
  pushl $152
80106088:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010608d:	e9 be f5 ff ff       	jmp    80105650 <alltraps>

80106092 <vector153>:
.globl vector153
vector153:
  pushl $0
80106092:	6a 00                	push   $0x0
  pushl $153
80106094:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80106099:	e9 b2 f5 ff ff       	jmp    80105650 <alltraps>

8010609e <vector154>:
.globl vector154
vector154:
  pushl $0
8010609e:	6a 00                	push   $0x0
  pushl $154
801060a0:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
801060a5:	e9 a6 f5 ff ff       	jmp    80105650 <alltraps>

801060aa <vector155>:
.globl vector155
vector155:
  pushl $0
801060aa:	6a 00                	push   $0x0
  pushl $155
801060ac:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
801060b1:	e9 9a f5 ff ff       	jmp    80105650 <alltraps>

801060b6 <vector156>:
.globl vector156
vector156:
  pushl $0
801060b6:	6a 00                	push   $0x0
  pushl $156
801060b8:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
801060bd:	e9 8e f5 ff ff       	jmp    80105650 <alltraps>

801060c2 <vector157>:
.globl vector157
vector157:
  pushl $0
801060c2:	6a 00                	push   $0x0
  pushl $157
801060c4:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
801060c9:	e9 82 f5 ff ff       	jmp    80105650 <alltraps>

801060ce <vector158>:
.globl vector158
vector158:
  pushl $0
801060ce:	6a 00                	push   $0x0
  pushl $158
801060d0:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
801060d5:	e9 76 f5 ff ff       	jmp    80105650 <alltraps>

801060da <vector159>:
.globl vector159
vector159:
  pushl $0
801060da:	6a 00                	push   $0x0
  pushl $159
801060dc:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
801060e1:	e9 6a f5 ff ff       	jmp    80105650 <alltraps>

801060e6 <vector160>:
.globl vector160
vector160:
  pushl $0
801060e6:	6a 00                	push   $0x0
  pushl $160
801060e8:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
801060ed:	e9 5e f5 ff ff       	jmp    80105650 <alltraps>

801060f2 <vector161>:
.globl vector161
vector161:
  pushl $0
801060f2:	6a 00                	push   $0x0
  pushl $161
801060f4:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
801060f9:	e9 52 f5 ff ff       	jmp    80105650 <alltraps>

801060fe <vector162>:
.globl vector162
vector162:
  pushl $0
801060fe:	6a 00                	push   $0x0
  pushl $162
80106100:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106105:	e9 46 f5 ff ff       	jmp    80105650 <alltraps>

8010610a <vector163>:
.globl vector163
vector163:
  pushl $0
8010610a:	6a 00                	push   $0x0
  pushl $163
8010610c:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106111:	e9 3a f5 ff ff       	jmp    80105650 <alltraps>

80106116 <vector164>:
.globl vector164
vector164:
  pushl $0
80106116:	6a 00                	push   $0x0
  pushl $164
80106118:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010611d:	e9 2e f5 ff ff       	jmp    80105650 <alltraps>

80106122 <vector165>:
.globl vector165
vector165:
  pushl $0
80106122:	6a 00                	push   $0x0
  pushl $165
80106124:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80106129:	e9 22 f5 ff ff       	jmp    80105650 <alltraps>

8010612e <vector166>:
.globl vector166
vector166:
  pushl $0
8010612e:	6a 00                	push   $0x0
  pushl $166
80106130:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106135:	e9 16 f5 ff ff       	jmp    80105650 <alltraps>

8010613a <vector167>:
.globl vector167
vector167:
  pushl $0
8010613a:	6a 00                	push   $0x0
  pushl $167
8010613c:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106141:	e9 0a f5 ff ff       	jmp    80105650 <alltraps>

80106146 <vector168>:
.globl vector168
vector168:
  pushl $0
80106146:	6a 00                	push   $0x0
  pushl $168
80106148:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010614d:	e9 fe f4 ff ff       	jmp    80105650 <alltraps>

80106152 <vector169>:
.globl vector169
vector169:
  pushl $0
80106152:	6a 00                	push   $0x0
  pushl $169
80106154:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80106159:	e9 f2 f4 ff ff       	jmp    80105650 <alltraps>

8010615e <vector170>:
.globl vector170
vector170:
  pushl $0
8010615e:	6a 00                	push   $0x0
  pushl $170
80106160:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106165:	e9 e6 f4 ff ff       	jmp    80105650 <alltraps>

8010616a <vector171>:
.globl vector171
vector171:
  pushl $0
8010616a:	6a 00                	push   $0x0
  pushl $171
8010616c:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106171:	e9 da f4 ff ff       	jmp    80105650 <alltraps>

80106176 <vector172>:
.globl vector172
vector172:
  pushl $0
80106176:	6a 00                	push   $0x0
  pushl $172
80106178:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010617d:	e9 ce f4 ff ff       	jmp    80105650 <alltraps>

80106182 <vector173>:
.globl vector173
vector173:
  pushl $0
80106182:	6a 00                	push   $0x0
  pushl $173
80106184:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80106189:	e9 c2 f4 ff ff       	jmp    80105650 <alltraps>

8010618e <vector174>:
.globl vector174
vector174:
  pushl $0
8010618e:	6a 00                	push   $0x0
  pushl $174
80106190:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106195:	e9 b6 f4 ff ff       	jmp    80105650 <alltraps>

8010619a <vector175>:
.globl vector175
vector175:
  pushl $0
8010619a:	6a 00                	push   $0x0
  pushl $175
8010619c:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
801061a1:	e9 aa f4 ff ff       	jmp    80105650 <alltraps>

801061a6 <vector176>:
.globl vector176
vector176:
  pushl $0
801061a6:	6a 00                	push   $0x0
  pushl $176
801061a8:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
801061ad:	e9 9e f4 ff ff       	jmp    80105650 <alltraps>

801061b2 <vector177>:
.globl vector177
vector177:
  pushl $0
801061b2:	6a 00                	push   $0x0
  pushl $177
801061b4:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
801061b9:	e9 92 f4 ff ff       	jmp    80105650 <alltraps>

801061be <vector178>:
.globl vector178
vector178:
  pushl $0
801061be:	6a 00                	push   $0x0
  pushl $178
801061c0:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
801061c5:	e9 86 f4 ff ff       	jmp    80105650 <alltraps>

801061ca <vector179>:
.globl vector179
vector179:
  pushl $0
801061ca:	6a 00                	push   $0x0
  pushl $179
801061cc:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
801061d1:	e9 7a f4 ff ff       	jmp    80105650 <alltraps>

801061d6 <vector180>:
.globl vector180
vector180:
  pushl $0
801061d6:	6a 00                	push   $0x0
  pushl $180
801061d8:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
801061dd:	e9 6e f4 ff ff       	jmp    80105650 <alltraps>

801061e2 <vector181>:
.globl vector181
vector181:
  pushl $0
801061e2:	6a 00                	push   $0x0
  pushl $181
801061e4:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
801061e9:	e9 62 f4 ff ff       	jmp    80105650 <alltraps>

801061ee <vector182>:
.globl vector182
vector182:
  pushl $0
801061ee:	6a 00                	push   $0x0
  pushl $182
801061f0:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
801061f5:	e9 56 f4 ff ff       	jmp    80105650 <alltraps>

801061fa <vector183>:
.globl vector183
vector183:
  pushl $0
801061fa:	6a 00                	push   $0x0
  pushl $183
801061fc:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106201:	e9 4a f4 ff ff       	jmp    80105650 <alltraps>

80106206 <vector184>:
.globl vector184
vector184:
  pushl $0
80106206:	6a 00                	push   $0x0
  pushl $184
80106208:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010620d:	e9 3e f4 ff ff       	jmp    80105650 <alltraps>

80106212 <vector185>:
.globl vector185
vector185:
  pushl $0
80106212:	6a 00                	push   $0x0
  pushl $185
80106214:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80106219:	e9 32 f4 ff ff       	jmp    80105650 <alltraps>

8010621e <vector186>:
.globl vector186
vector186:
  pushl $0
8010621e:	6a 00                	push   $0x0
  pushl $186
80106220:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106225:	e9 26 f4 ff ff       	jmp    80105650 <alltraps>

8010622a <vector187>:
.globl vector187
vector187:
  pushl $0
8010622a:	6a 00                	push   $0x0
  pushl $187
8010622c:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106231:	e9 1a f4 ff ff       	jmp    80105650 <alltraps>

80106236 <vector188>:
.globl vector188
vector188:
  pushl $0
80106236:	6a 00                	push   $0x0
  pushl $188
80106238:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010623d:	e9 0e f4 ff ff       	jmp    80105650 <alltraps>

80106242 <vector189>:
.globl vector189
vector189:
  pushl $0
80106242:	6a 00                	push   $0x0
  pushl $189
80106244:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80106249:	e9 02 f4 ff ff       	jmp    80105650 <alltraps>

8010624e <vector190>:
.globl vector190
vector190:
  pushl $0
8010624e:	6a 00                	push   $0x0
  pushl $190
80106250:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106255:	e9 f6 f3 ff ff       	jmp    80105650 <alltraps>

8010625a <vector191>:
.globl vector191
vector191:
  pushl $0
8010625a:	6a 00                	push   $0x0
  pushl $191
8010625c:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106261:	e9 ea f3 ff ff       	jmp    80105650 <alltraps>

80106266 <vector192>:
.globl vector192
vector192:
  pushl $0
80106266:	6a 00                	push   $0x0
  pushl $192
80106268:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010626d:	e9 de f3 ff ff       	jmp    80105650 <alltraps>

80106272 <vector193>:
.globl vector193
vector193:
  pushl $0
80106272:	6a 00                	push   $0x0
  pushl $193
80106274:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80106279:	e9 d2 f3 ff ff       	jmp    80105650 <alltraps>

8010627e <vector194>:
.globl vector194
vector194:
  pushl $0
8010627e:	6a 00                	push   $0x0
  pushl $194
80106280:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106285:	e9 c6 f3 ff ff       	jmp    80105650 <alltraps>

8010628a <vector195>:
.globl vector195
vector195:
  pushl $0
8010628a:	6a 00                	push   $0x0
  pushl $195
8010628c:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106291:	e9 ba f3 ff ff       	jmp    80105650 <alltraps>

80106296 <vector196>:
.globl vector196
vector196:
  pushl $0
80106296:	6a 00                	push   $0x0
  pushl $196
80106298:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
8010629d:	e9 ae f3 ff ff       	jmp    80105650 <alltraps>

801062a2 <vector197>:
.globl vector197
vector197:
  pushl $0
801062a2:	6a 00                	push   $0x0
  pushl $197
801062a4:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
801062a9:	e9 a2 f3 ff ff       	jmp    80105650 <alltraps>

801062ae <vector198>:
.globl vector198
vector198:
  pushl $0
801062ae:	6a 00                	push   $0x0
  pushl $198
801062b0:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
801062b5:	e9 96 f3 ff ff       	jmp    80105650 <alltraps>

801062ba <vector199>:
.globl vector199
vector199:
  pushl $0
801062ba:	6a 00                	push   $0x0
  pushl $199
801062bc:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
801062c1:	e9 8a f3 ff ff       	jmp    80105650 <alltraps>

801062c6 <vector200>:
.globl vector200
vector200:
  pushl $0
801062c6:	6a 00                	push   $0x0
  pushl $200
801062c8:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
801062cd:	e9 7e f3 ff ff       	jmp    80105650 <alltraps>

801062d2 <vector201>:
.globl vector201
vector201:
  pushl $0
801062d2:	6a 00                	push   $0x0
  pushl $201
801062d4:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
801062d9:	e9 72 f3 ff ff       	jmp    80105650 <alltraps>

801062de <vector202>:
.globl vector202
vector202:
  pushl $0
801062de:	6a 00                	push   $0x0
  pushl $202
801062e0:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
801062e5:	e9 66 f3 ff ff       	jmp    80105650 <alltraps>

801062ea <vector203>:
.globl vector203
vector203:
  pushl $0
801062ea:	6a 00                	push   $0x0
  pushl $203
801062ec:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
801062f1:	e9 5a f3 ff ff       	jmp    80105650 <alltraps>

801062f6 <vector204>:
.globl vector204
vector204:
  pushl $0
801062f6:	6a 00                	push   $0x0
  pushl $204
801062f8:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
801062fd:	e9 4e f3 ff ff       	jmp    80105650 <alltraps>

80106302 <vector205>:
.globl vector205
vector205:
  pushl $0
80106302:	6a 00                	push   $0x0
  pushl $205
80106304:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80106309:	e9 42 f3 ff ff       	jmp    80105650 <alltraps>

8010630e <vector206>:
.globl vector206
vector206:
  pushl $0
8010630e:	6a 00                	push   $0x0
  pushl $206
80106310:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106315:	e9 36 f3 ff ff       	jmp    80105650 <alltraps>

8010631a <vector207>:
.globl vector207
vector207:
  pushl $0
8010631a:	6a 00                	push   $0x0
  pushl $207
8010631c:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106321:	e9 2a f3 ff ff       	jmp    80105650 <alltraps>

80106326 <vector208>:
.globl vector208
vector208:
  pushl $0
80106326:	6a 00                	push   $0x0
  pushl $208
80106328:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
8010632d:	e9 1e f3 ff ff       	jmp    80105650 <alltraps>

80106332 <vector209>:
.globl vector209
vector209:
  pushl $0
80106332:	6a 00                	push   $0x0
  pushl $209
80106334:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80106339:	e9 12 f3 ff ff       	jmp    80105650 <alltraps>

8010633e <vector210>:
.globl vector210
vector210:
  pushl $0
8010633e:	6a 00                	push   $0x0
  pushl $210
80106340:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106345:	e9 06 f3 ff ff       	jmp    80105650 <alltraps>

8010634a <vector211>:
.globl vector211
vector211:
  pushl $0
8010634a:	6a 00                	push   $0x0
  pushl $211
8010634c:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106351:	e9 fa f2 ff ff       	jmp    80105650 <alltraps>

80106356 <vector212>:
.globl vector212
vector212:
  pushl $0
80106356:	6a 00                	push   $0x0
  pushl $212
80106358:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010635d:	e9 ee f2 ff ff       	jmp    80105650 <alltraps>

80106362 <vector213>:
.globl vector213
vector213:
  pushl $0
80106362:	6a 00                	push   $0x0
  pushl $213
80106364:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80106369:	e9 e2 f2 ff ff       	jmp    80105650 <alltraps>

8010636e <vector214>:
.globl vector214
vector214:
  pushl $0
8010636e:	6a 00                	push   $0x0
  pushl $214
80106370:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106375:	e9 d6 f2 ff ff       	jmp    80105650 <alltraps>

8010637a <vector215>:
.globl vector215
vector215:
  pushl $0
8010637a:	6a 00                	push   $0x0
  pushl $215
8010637c:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106381:	e9 ca f2 ff ff       	jmp    80105650 <alltraps>

80106386 <vector216>:
.globl vector216
vector216:
  pushl $0
80106386:	6a 00                	push   $0x0
  pushl $216
80106388:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
8010638d:	e9 be f2 ff ff       	jmp    80105650 <alltraps>

80106392 <vector217>:
.globl vector217
vector217:
  pushl $0
80106392:	6a 00                	push   $0x0
  pushl $217
80106394:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80106399:	e9 b2 f2 ff ff       	jmp    80105650 <alltraps>

8010639e <vector218>:
.globl vector218
vector218:
  pushl $0
8010639e:	6a 00                	push   $0x0
  pushl $218
801063a0:	68 da 00 00 00       	push   $0xda
  jmp alltraps
801063a5:	e9 a6 f2 ff ff       	jmp    80105650 <alltraps>

801063aa <vector219>:
.globl vector219
vector219:
  pushl $0
801063aa:	6a 00                	push   $0x0
  pushl $219
801063ac:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
801063b1:	e9 9a f2 ff ff       	jmp    80105650 <alltraps>

801063b6 <vector220>:
.globl vector220
vector220:
  pushl $0
801063b6:	6a 00                	push   $0x0
  pushl $220
801063b8:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
801063bd:	e9 8e f2 ff ff       	jmp    80105650 <alltraps>

801063c2 <vector221>:
.globl vector221
vector221:
  pushl $0
801063c2:	6a 00                	push   $0x0
  pushl $221
801063c4:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
801063c9:	e9 82 f2 ff ff       	jmp    80105650 <alltraps>

801063ce <vector222>:
.globl vector222
vector222:
  pushl $0
801063ce:	6a 00                	push   $0x0
  pushl $222
801063d0:	68 de 00 00 00       	push   $0xde
  jmp alltraps
801063d5:	e9 76 f2 ff ff       	jmp    80105650 <alltraps>

801063da <vector223>:
.globl vector223
vector223:
  pushl $0
801063da:	6a 00                	push   $0x0
  pushl $223
801063dc:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
801063e1:	e9 6a f2 ff ff       	jmp    80105650 <alltraps>

801063e6 <vector224>:
.globl vector224
vector224:
  pushl $0
801063e6:	6a 00                	push   $0x0
  pushl $224
801063e8:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
801063ed:	e9 5e f2 ff ff       	jmp    80105650 <alltraps>

801063f2 <vector225>:
.globl vector225
vector225:
  pushl $0
801063f2:	6a 00                	push   $0x0
  pushl $225
801063f4:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
801063f9:	e9 52 f2 ff ff       	jmp    80105650 <alltraps>

801063fe <vector226>:
.globl vector226
vector226:
  pushl $0
801063fe:	6a 00                	push   $0x0
  pushl $226
80106400:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106405:	e9 46 f2 ff ff       	jmp    80105650 <alltraps>

8010640a <vector227>:
.globl vector227
vector227:
  pushl $0
8010640a:	6a 00                	push   $0x0
  pushl $227
8010640c:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106411:	e9 3a f2 ff ff       	jmp    80105650 <alltraps>

80106416 <vector228>:
.globl vector228
vector228:
  pushl $0
80106416:	6a 00                	push   $0x0
  pushl $228
80106418:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
8010641d:	e9 2e f2 ff ff       	jmp    80105650 <alltraps>

80106422 <vector229>:
.globl vector229
vector229:
  pushl $0
80106422:	6a 00                	push   $0x0
  pushl $229
80106424:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80106429:	e9 22 f2 ff ff       	jmp    80105650 <alltraps>

8010642e <vector230>:
.globl vector230
vector230:
  pushl $0
8010642e:	6a 00                	push   $0x0
  pushl $230
80106430:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106435:	e9 16 f2 ff ff       	jmp    80105650 <alltraps>

8010643a <vector231>:
.globl vector231
vector231:
  pushl $0
8010643a:	6a 00                	push   $0x0
  pushl $231
8010643c:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106441:	e9 0a f2 ff ff       	jmp    80105650 <alltraps>

80106446 <vector232>:
.globl vector232
vector232:
  pushl $0
80106446:	6a 00                	push   $0x0
  pushl $232
80106448:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010644d:	e9 fe f1 ff ff       	jmp    80105650 <alltraps>

80106452 <vector233>:
.globl vector233
vector233:
  pushl $0
80106452:	6a 00                	push   $0x0
  pushl $233
80106454:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80106459:	e9 f2 f1 ff ff       	jmp    80105650 <alltraps>

8010645e <vector234>:
.globl vector234
vector234:
  pushl $0
8010645e:	6a 00                	push   $0x0
  pushl $234
80106460:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106465:	e9 e6 f1 ff ff       	jmp    80105650 <alltraps>

8010646a <vector235>:
.globl vector235
vector235:
  pushl $0
8010646a:	6a 00                	push   $0x0
  pushl $235
8010646c:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106471:	e9 da f1 ff ff       	jmp    80105650 <alltraps>

80106476 <vector236>:
.globl vector236
vector236:
  pushl $0
80106476:	6a 00                	push   $0x0
  pushl $236
80106478:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010647d:	e9 ce f1 ff ff       	jmp    80105650 <alltraps>

80106482 <vector237>:
.globl vector237
vector237:
  pushl $0
80106482:	6a 00                	push   $0x0
  pushl $237
80106484:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80106489:	e9 c2 f1 ff ff       	jmp    80105650 <alltraps>

8010648e <vector238>:
.globl vector238
vector238:
  pushl $0
8010648e:	6a 00                	push   $0x0
  pushl $238
80106490:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106495:	e9 b6 f1 ff ff       	jmp    80105650 <alltraps>

8010649a <vector239>:
.globl vector239
vector239:
  pushl $0
8010649a:	6a 00                	push   $0x0
  pushl $239
8010649c:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
801064a1:	e9 aa f1 ff ff       	jmp    80105650 <alltraps>

801064a6 <vector240>:
.globl vector240
vector240:
  pushl $0
801064a6:	6a 00                	push   $0x0
  pushl $240
801064a8:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
801064ad:	e9 9e f1 ff ff       	jmp    80105650 <alltraps>

801064b2 <vector241>:
.globl vector241
vector241:
  pushl $0
801064b2:	6a 00                	push   $0x0
  pushl $241
801064b4:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
801064b9:	e9 92 f1 ff ff       	jmp    80105650 <alltraps>

801064be <vector242>:
.globl vector242
vector242:
  pushl $0
801064be:	6a 00                	push   $0x0
  pushl $242
801064c0:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
801064c5:	e9 86 f1 ff ff       	jmp    80105650 <alltraps>

801064ca <vector243>:
.globl vector243
vector243:
  pushl $0
801064ca:	6a 00                	push   $0x0
  pushl $243
801064cc:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
801064d1:	e9 7a f1 ff ff       	jmp    80105650 <alltraps>

801064d6 <vector244>:
.globl vector244
vector244:
  pushl $0
801064d6:	6a 00                	push   $0x0
  pushl $244
801064d8:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
801064dd:	e9 6e f1 ff ff       	jmp    80105650 <alltraps>

801064e2 <vector245>:
.globl vector245
vector245:
  pushl $0
801064e2:	6a 00                	push   $0x0
  pushl $245
801064e4:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
801064e9:	e9 62 f1 ff ff       	jmp    80105650 <alltraps>

801064ee <vector246>:
.globl vector246
vector246:
  pushl $0
801064ee:	6a 00                	push   $0x0
  pushl $246
801064f0:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
801064f5:	e9 56 f1 ff ff       	jmp    80105650 <alltraps>

801064fa <vector247>:
.globl vector247
vector247:
  pushl $0
801064fa:	6a 00                	push   $0x0
  pushl $247
801064fc:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106501:	e9 4a f1 ff ff       	jmp    80105650 <alltraps>

80106506 <vector248>:
.globl vector248
vector248:
  pushl $0
80106506:	6a 00                	push   $0x0
  pushl $248
80106508:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
8010650d:	e9 3e f1 ff ff       	jmp    80105650 <alltraps>

80106512 <vector249>:
.globl vector249
vector249:
  pushl $0
80106512:	6a 00                	push   $0x0
  pushl $249
80106514:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80106519:	e9 32 f1 ff ff       	jmp    80105650 <alltraps>

8010651e <vector250>:
.globl vector250
vector250:
  pushl $0
8010651e:	6a 00                	push   $0x0
  pushl $250
80106520:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106525:	e9 26 f1 ff ff       	jmp    80105650 <alltraps>

8010652a <vector251>:
.globl vector251
vector251:
  pushl $0
8010652a:	6a 00                	push   $0x0
  pushl $251
8010652c:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106531:	e9 1a f1 ff ff       	jmp    80105650 <alltraps>

80106536 <vector252>:
.globl vector252
vector252:
  pushl $0
80106536:	6a 00                	push   $0x0
  pushl $252
80106538:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
8010653d:	e9 0e f1 ff ff       	jmp    80105650 <alltraps>

80106542 <vector253>:
.globl vector253
vector253:
  pushl $0
80106542:	6a 00                	push   $0x0
  pushl $253
80106544:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80106549:	e9 02 f1 ff ff       	jmp    80105650 <alltraps>

8010654e <vector254>:
.globl vector254
vector254:
  pushl $0
8010654e:	6a 00                	push   $0x0
  pushl $254
80106550:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106555:	e9 f6 f0 ff ff       	jmp    80105650 <alltraps>

8010655a <vector255>:
.globl vector255
vector255:
  pushl $0
8010655a:	6a 00                	push   $0x0
  pushl $255
8010655c:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106561:	e9 ea f0 ff ff       	jmp    80105650 <alltraps>
	...

80106570 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106570:	55                   	push   %ebp
80106571:	89 e5                	mov    %esp,%ebp
80106573:	83 ec 38             	sub    $0x38,%esp
80106576:	89 5d f4             	mov    %ebx,-0xc(%ebp)
80106579:	89 d3                	mov    %edx,%ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
8010657b:	c1 ea 16             	shr    $0x16,%edx
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
8010657e:	89 7d fc             	mov    %edi,-0x4(%ebp)
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106581:	8d 3c 90             	lea    (%eax,%edx,4),%edi
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106584:	89 75 f8             	mov    %esi,-0x8(%ebp)
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
80106587:	8b 37                	mov    (%edi),%esi
80106589:	89 f2                	mov    %esi,%edx
8010658b:	83 e2 01             	and    $0x1,%edx
8010658e:	74 28                	je     801065b8 <walkpgdir+0x48>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106590:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
80106596:	81 c6 00 00 00 80    	add    $0x80000000,%esi
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
8010659c:	c1 eb 0a             	shr    $0xa,%ebx
8010659f:	81 e3 fc 0f 00 00    	and    $0xffc,%ebx
801065a5:	8d 04 1e             	lea    (%esi,%ebx,1),%eax
}
801065a8:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801065ab:	8b 75 f8             	mov    -0x8(%ebp),%esi
801065ae:	8b 7d fc             	mov    -0x4(%ebp),%edi
801065b1:	89 ec                	mov    %ebp,%esp
801065b3:	5d                   	pop    %ebp
801065b4:	c3                   	ret    
801065b5:	8d 76 00             	lea    0x0(%esi),%esi
  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
      return 0;
801065b8:	31 c0                	xor    %eax,%eax

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
801065ba:	85 c9                	test   %ecx,%ecx
801065bc:	74 ea                	je     801065a8 <walkpgdir+0x38>
801065be:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801065c1:	e8 aa bf ff ff       	call   80102570 <kalloc>
      return 0;
801065c6:	8b 55 e4             	mov    -0x1c(%ebp),%edx

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
801065c9:	89 c6                	mov    %eax,%esi
      return 0;
801065cb:	89 d0                	mov    %edx,%eax

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
801065cd:	85 f6                	test   %esi,%esi
801065cf:	74 d7                	je     801065a8 <walkpgdir+0x38>
      return 0;
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
801065d1:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
801065d8:	00 
801065d9:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801065e0:	00 
801065e1:	89 34 24             	mov    %esi,(%esp)
801065e4:	e8 17 de ff ff       	call   80104400 <memset>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
801065e9:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801065ef:	83 c8 07             	or     $0x7,%eax
801065f2:	89 07                	mov    %eax,(%edi)
801065f4:	eb a6                	jmp    8010659c <walkpgdir+0x2c>
801065f6:	8d 76 00             	lea    0x0(%esi),%esi
801065f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106600 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106600:	55                   	push   %ebp
80106601:	89 e5                	mov    %esp,%ebp
80106603:	57                   	push   %edi
80106604:	56                   	push   %esi
80106605:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80106606:	89 d3                	mov    %edx,%ebx
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106608:	8d 7c 0a ff          	lea    -0x1(%edx,%ecx,1),%edi
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
8010660c:	83 ec 2c             	sub    $0x2c,%esp
8010660f:	8b 75 08             	mov    0x8(%ebp),%esi
80106612:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80106615:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
8010661b:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80106621:	83 4d 0c 01          	orl    $0x1,0xc(%ebp)
80106625:	eb 1d                	jmp    80106644 <mappages+0x44>
80106627:	90                   	nop
  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
80106628:	f6 00 01             	testb  $0x1,(%eax)
8010662b:	75 45                	jne    80106672 <mappages+0x72>
      panic("remap");
    *pte = pa | perm | PTE_P;
8010662d:	8b 55 0c             	mov    0xc(%ebp),%edx
80106630:	09 f2                	or     %esi,%edx
    if(a == last)
80106632:	39 fb                	cmp    %edi,%ebx
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80106634:	89 10                	mov    %edx,(%eax)
    if(a == last)
80106636:	74 30                	je     80106668 <mappages+0x68>
      break;
    a += PGSIZE;
80106638:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    pa += PGSIZE;
8010663e:	81 c6 00 10 00 00    	add    $0x1000,%esi
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106644:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106647:	b9 01 00 00 00       	mov    $0x1,%ecx
8010664c:	89 da                	mov    %ebx,%edx
8010664e:	e8 1d ff ff ff       	call   80106570 <walkpgdir>
80106653:	85 c0                	test   %eax,%eax
80106655:	75 d1                	jne    80106628 <mappages+0x28>
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
80106657:	83 c4 2c             	add    $0x2c,%esp

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
8010665a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
8010665f:	5b                   	pop    %ebx
80106660:	5e                   	pop    %esi
80106661:	5f                   	pop    %edi
80106662:	5d                   	pop    %ebp
80106663:	c3                   	ret    
80106664:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106668:	83 c4 2c             	add    $0x2c,%esp
    if(a == last)
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
8010666b:	31 c0                	xor    %eax,%eax
}
8010666d:	5b                   	pop    %ebx
8010666e:	5e                   	pop    %esi
8010666f:	5f                   	pop    %edi
80106670:	5d                   	pop    %ebp
80106671:	c3                   	ret    
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
80106672:	c7 04 24 4c 77 10 80 	movl   $0x8010774c,(%esp)
80106679:	e8 f2 9c ff ff       	call   80100370 <panic>
8010667e:	66 90                	xchg   %ax,%ax

80106680 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
80106680:	55                   	push   %ebp
80106681:	89 e5                	mov    %esp,%ebp
80106683:	83 ec 18             	sub    $0x18,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
80106686:	e8 45 d1 ff ff       	call   801037d0 <cpuid>
8010668b:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80106691:	05 80 27 11 80       	add    $0x80112780,%eax
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106696:	c6 40 7d 9a          	movb   $0x9a,0x7d(%eax)
8010669a:	c6 40 7e cf          	movb   $0xcf,0x7e(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010669e:	c6 80 85 00 00 00 92 	movb   $0x92,0x85(%eax)
801066a5:	c6 80 86 00 00 00 cf 	movb   $0xcf,0x86(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801066ac:	c6 80 8d 00 00 00 fa 	movb   $0xfa,0x8d(%eax)
801066b3:	c6 80 8e 00 00 00 cf 	movb   $0xcf,0x8e(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801066ba:	c6 80 95 00 00 00 f2 	movb   $0xf2,0x95(%eax)
801066c1:	c6 80 96 00 00 00 cf 	movb   $0xcf,0x96(%eax)
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801066c8:	66 c7 40 78 ff ff    	movw   $0xffff,0x78(%eax)
801066ce:	66 c7 40 7a 00 00    	movw   $0x0,0x7a(%eax)
801066d4:	c6 40 7c 00          	movb   $0x0,0x7c(%eax)
801066d8:	c6 40 7f 00          	movb   $0x0,0x7f(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801066dc:	66 c7 80 80 00 00 00 	movw   $0xffff,0x80(%eax)
801066e3:	ff ff 
801066e5:	66 c7 80 82 00 00 00 	movw   $0x0,0x82(%eax)
801066ec:	00 00 
801066ee:	c6 80 84 00 00 00 00 	movb   $0x0,0x84(%eax)
801066f5:	c6 80 87 00 00 00 00 	movb   $0x0,0x87(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801066fc:	66 c7 80 88 00 00 00 	movw   $0xffff,0x88(%eax)
80106703:	ff ff 
80106705:	66 c7 80 8a 00 00 00 	movw   $0x0,0x8a(%eax)
8010670c:	00 00 
8010670e:	c6 80 8c 00 00 00 00 	movb   $0x0,0x8c(%eax)
80106715:	c6 80 8f 00 00 00 00 	movb   $0x0,0x8f(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
8010671c:	66 c7 80 90 00 00 00 	movw   $0xffff,0x90(%eax)
80106723:	ff ff 
80106725:	66 c7 80 92 00 00 00 	movw   $0x0,0x92(%eax)
8010672c:	00 00 
8010672e:	c6 80 94 00 00 00 00 	movb   $0x0,0x94(%eax)
80106735:	c6 80 97 00 00 00 00 	movb   $0x0,0x97(%eax)
  lgdt(c->gdt, sizeof(c->gdt));
8010673c:	83 c0 70             	add    $0x70,%eax
static inline void
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
8010673f:	66 c7 45 f2 2f 00    	movw   $0x2f,-0xe(%ebp)
  pd[1] = (uint)p;
80106745:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106749:	c1 e8 10             	shr    $0x10,%eax
8010674c:	66 89 45 f6          	mov    %ax,-0xa(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
80106750:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106753:	0f 01 10             	lgdtl  (%eax)
}
80106756:	c9                   	leave  
80106757:	c3                   	ret    
80106758:	90                   	nop
80106759:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106760 <switchkvm>:
// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106760:	a1 a4 54 11 80       	mov    0x801154a4,%eax

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80106765:	55                   	push   %ebp
80106766:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106768:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010676d:	0f 22 d8             	mov    %eax,%cr3
}
80106770:	5d                   	pop    %ebp
80106771:	c3                   	ret    
80106772:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106780 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80106780:	55                   	push   %ebp
80106781:	89 e5                	mov    %esp,%ebp
80106783:	57                   	push   %edi
80106784:	56                   	push   %esi
80106785:	53                   	push   %ebx
80106786:	83 ec 2c             	sub    $0x2c,%esp
80106789:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
8010678c:	85 f6                	test   %esi,%esi
8010678e:	0f 84 c4 00 00 00    	je     80106858 <switchuvm+0xd8>
    panic("switchuvm: no process");
  if(p->kstack == 0)
80106794:	8b 56 08             	mov    0x8(%esi),%edx
80106797:	85 d2                	test   %edx,%edx
80106799:	0f 84 d1 00 00 00    	je     80106870 <switchuvm+0xf0>
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
8010679f:	8b 46 04             	mov    0x4(%esi),%eax
801067a2:	85 c0                	test   %eax,%eax
801067a4:	0f 84 ba 00 00 00    	je     80106864 <switchuvm+0xe4>
    panic("switchuvm: no pgdir");

  pushcli();
801067aa:	e8 a1 da ff ff       	call   80104250 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
801067af:	e8 9c cf ff ff       	call   80103750 <mycpu>
801067b4:	89 c3                	mov    %eax,%ebx
801067b6:	e8 95 cf ff ff       	call   80103750 <mycpu>
801067bb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801067be:	e8 8d cf ff ff       	call   80103750 <mycpu>
801067c3:	89 c7                	mov    %eax,%edi
801067c5:	e8 86 cf ff ff       	call   80103750 <mycpu>
801067ca:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801067cd:	66 c7 83 98 00 00 00 	movw   $0x67,0x98(%ebx)
801067d4:	67 00 
801067d6:	c6 83 9d 00 00 00 99 	movb   $0x99,0x9d(%ebx)
801067dd:	c6 83 9e 00 00 00 40 	movb   $0x40,0x9e(%ebx)
801067e4:	83 c2 08             	add    $0x8,%edx
801067e7:	66 89 93 9a 00 00 00 	mov    %dx,0x9a(%ebx)
801067ee:	8d 57 08             	lea    0x8(%edi),%edx
801067f1:	83 c0 08             	add    $0x8,%eax
801067f4:	c1 ea 10             	shr    $0x10,%edx
801067f7:	c1 e8 18             	shr    $0x18,%eax
801067fa:	88 93 9c 00 00 00    	mov    %dl,0x9c(%ebx)
80106800:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
                                sizeof(mycpu()->ts)-1, 0);
  mycpu()->gdt[SEG_TSS].s = 0;
80106806:	e8 45 cf ff ff       	call   80103750 <mycpu>
8010680b:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106812:	e8 39 cf ff ff       	call   80103750 <mycpu>
80106817:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
8010681d:	e8 2e cf ff ff       	call   80103750 <mycpu>
80106822:	8b 56 08             	mov    0x8(%esi),%edx
80106825:	81 c2 00 10 00 00    	add    $0x1000,%edx
8010682b:	89 50 0c             	mov    %edx,0xc(%eax)
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
8010682e:	e8 1d cf ff ff       	call   80103750 <mycpu>
80106833:	66 c7 40 6e ff ff    	movw   $0xffff,0x6e(%eax)
}

static inline void
ltr(ushort sel)
{
  asm volatile("ltr %0" : : "r" (sel));
80106839:	b8 28 00 00 00       	mov    $0x28,%eax
8010683e:	0f 00 d8             	ltr    %ax
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
80106841:	8b 46 04             	mov    0x4(%esi),%eax
80106844:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106849:	0f 22 d8             	mov    %eax,%cr3
  popcli();
}
8010684c:	83 c4 2c             	add    $0x2c,%esp
8010684f:	5b                   	pop    %ebx
80106850:	5e                   	pop    %esi
80106851:	5f                   	pop    %edi
80106852:	5d                   	pop    %ebp
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
80106853:	e9 38 da ff ff       	jmp    80104290 <popcli>
// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
80106858:	c7 04 24 52 77 10 80 	movl   $0x80107752,(%esp)
8010685f:	e8 0c 9b ff ff       	call   80100370 <panic>
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
    panic("switchuvm: no pgdir");
80106864:	c7 04 24 7d 77 10 80 	movl   $0x8010777d,(%esp)
8010686b:	e8 00 9b ff ff       	call   80100370 <panic>
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
80106870:	c7 04 24 68 77 10 80 	movl   $0x80107768,(%esp)
80106877:	e8 f4 9a ff ff       	call   80100370 <panic>
8010687c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106880 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80106880:	55                   	push   %ebp
80106881:	89 e5                	mov    %esp,%ebp
80106883:	83 ec 38             	sub    $0x38,%esp
80106886:	89 75 f8             	mov    %esi,-0x8(%ebp)
80106889:	8b 75 10             	mov    0x10(%ebp),%esi
8010688c:	8b 45 08             	mov    0x8(%ebp),%eax
8010688f:	89 7d fc             	mov    %edi,-0x4(%ebp)
80106892:	8b 7d 0c             	mov    0xc(%ebp),%edi
80106895:	89 5d f4             	mov    %ebx,-0xc(%ebp)
  char *mem;

  if(sz >= PGSIZE)
80106898:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
8010689e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *mem;

  if(sz >= PGSIZE)
801068a1:	77 59                	ja     801068fc <inituvm+0x7c>
    panic("inituvm: more than a page");
  mem = kalloc();
801068a3:	e8 c8 bc ff ff       	call   80102570 <kalloc>
  memset(mem, 0, PGSIZE);
801068a8:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
801068af:	00 
801068b0:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
801068b7:	00 
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
801068b8:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
801068ba:	89 04 24             	mov    %eax,(%esp)
801068bd:	e8 3e db ff ff       	call   80104400 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
801068c2:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801068c8:	b9 00 10 00 00       	mov    $0x1000,%ecx
801068cd:	89 04 24             	mov    %eax,(%esp)
801068d0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801068d3:	31 d2                	xor    %edx,%edx
801068d5:	c7 44 24 04 06 00 00 	movl   $0x6,0x4(%esp)
801068dc:	00 
801068dd:	e8 1e fd ff ff       	call   80106600 <mappages>
  memmove(mem, init, sz);
801068e2:	89 75 10             	mov    %esi,0x10(%ebp)
}
801068e5:	8b 75 f8             	mov    -0x8(%ebp),%esi
  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
801068e8:	89 7d 0c             	mov    %edi,0xc(%ebp)
}
801068eb:	8b 7d fc             	mov    -0x4(%ebp),%edi
  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
801068ee:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801068f1:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801068f4:	89 ec                	mov    %ebp,%esp
801068f6:	5d                   	pop    %ebp
  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
801068f7:	e9 c4 db ff ff       	jmp    801044c0 <memmove>
inituvm(pde_t *pgdir, char *init, uint sz)
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
801068fc:	c7 04 24 91 77 10 80 	movl   $0x80107791,(%esp)
80106903:	e8 68 9a ff ff       	call   80100370 <panic>
80106908:	90                   	nop
80106909:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106910 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80106910:	55                   	push   %ebp
80106911:	89 e5                	mov    %esp,%ebp
80106913:	57                   	push   %edi
80106914:	56                   	push   %esi
80106915:	53                   	push   %ebx
80106916:	83 ec 2c             	sub    $0x2c,%esp
80106919:	8b 7d 0c             	mov    0xc(%ebp),%edi
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
8010691c:	f7 c7 ff 0f 00 00    	test   $0xfff,%edi
80106922:	0f 85 96 00 00 00    	jne    801069be <loaduvm+0xae>
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
80106928:	8b 75 18             	mov    0x18(%ebp),%esi
8010692b:	31 db                	xor    %ebx,%ebx
8010692d:	85 f6                	test   %esi,%esi
8010692f:	75 18                	jne    80106949 <loaduvm+0x39>
80106931:	eb 75                	jmp    801069a8 <loaduvm+0x98>
80106933:	90                   	nop
80106934:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106938:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010693e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80106944:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106947:	76 5f                	jbe    801069a8 <loaduvm+0x98>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106949:	8b 45 08             	mov    0x8(%ebp),%eax
8010694c:	31 c9                	xor    %ecx,%ecx
}

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
8010694e:	8d 14 1f             	lea    (%edi,%ebx,1),%edx
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106951:	e8 1a fc ff ff       	call   80106570 <walkpgdir>
80106956:	85 c0                	test   %eax,%eax
80106958:	74 58                	je     801069b2 <loaduvm+0xa2>
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
8010695a:	8b 00                	mov    (%eax),%eax
    if(sz - i < PGSIZE)
8010695c:	ba 00 10 00 00       	mov    $0x1000,%edx
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106961:	8b 4d 14             	mov    0x14(%ebp),%ecx
  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
80106964:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80106969:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
8010696f:	0f 46 d6             	cmovbe %esi,%edx
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106972:	05 00 00 00 80       	add    $0x80000000,%eax
80106977:	89 44 24 04          	mov    %eax,0x4(%esp)
8010697b:	8b 45 10             	mov    0x10(%ebp),%eax
8010697e:	01 d9                	add    %ebx,%ecx
80106980:	89 54 24 0c          	mov    %edx,0xc(%esp)
80106984:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80106987:	89 4c 24 08          	mov    %ecx,0x8(%esp)
8010698b:	89 04 24             	mov    %eax,(%esp)
8010698e:	e8 2d b0 ff ff       	call   801019c0 <readi>
80106993:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80106996:	39 d0                	cmp    %edx,%eax
80106998:	74 9e                	je     80106938 <loaduvm+0x28>
      return -1;
  }
  return 0;
}
8010699a:	83 c4 2c             	add    $0x2c,%esp
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
8010699d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return 0;
}
801069a2:	5b                   	pop    %ebx
801069a3:	5e                   	pop    %esi
801069a4:	5f                   	pop    %edi
801069a5:	5d                   	pop    %ebp
801069a6:	c3                   	ret    
801069a7:	90                   	nop
801069a8:	83 c4 2c             	add    $0x2c,%esp
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
801069ab:	31 c0                	xor    %eax,%eax
}
801069ad:	5b                   	pop    %ebx
801069ae:	5e                   	pop    %esi
801069af:	5f                   	pop    %edi
801069b0:	5d                   	pop    %ebp
801069b1:	c3                   	ret    

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
801069b2:	c7 04 24 ab 77 10 80 	movl   $0x801077ab,(%esp)
801069b9:	e8 b2 99 ff ff       	call   80100370 <panic>
{
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
801069be:	c7 04 24 4c 78 10 80 	movl   $0x8010784c,(%esp)
801069c5:	e8 a6 99 ff ff       	call   80100370 <panic>
801069ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801069d0 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
801069d0:	55                   	push   %ebp
801069d1:	89 e5                	mov    %esp,%ebp
801069d3:	57                   	push   %edi
801069d4:	56                   	push   %esi
801069d5:	53                   	push   %ebx
801069d6:	83 ec 2c             	sub    $0x2c,%esp
801069d9:	8b 75 0c             	mov    0xc(%ebp),%esi
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
801069dc:	39 75 10             	cmp    %esi,0x10(%ebp)
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
801069df:	8b 7d 08             	mov    0x8(%ebp),%edi
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;
801069e2:	89 f0                	mov    %esi,%eax
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
801069e4:	73 75                	jae    80106a5b <deallocuvm+0x8b>
    return oldsz;

  a = PGROUNDUP(newsz);
801069e6:	8b 5d 10             	mov    0x10(%ebp),%ebx
801069e9:	81 c3 ff 0f 00 00    	add    $0xfff,%ebx
801069ef:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
801069f5:	39 de                	cmp    %ebx,%esi
801069f7:	77 3a                	ja     80106a33 <deallocuvm+0x63>
801069f9:	eb 5d                	jmp    80106a58 <deallocuvm+0x88>
801069fb:	90                   	nop
801069fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80106a00:	8b 10                	mov    (%eax),%edx
80106a02:	f6 c2 01             	test   $0x1,%dl
80106a05:	74 22                	je     80106a29 <deallocuvm+0x59>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80106a07:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106a0d:	74 54                	je     80106a63 <deallocuvm+0x93>
        panic("kfree");
      char *v = P2V(pa);
80106a0f:	81 c2 00 00 00 80    	add    $0x80000000,%edx
      kfree(v);
80106a15:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106a18:	89 14 24             	mov    %edx,(%esp)
80106a1b:	e8 e0 b9 ff ff       	call   80102400 <kfree>
      *pte = 0;
80106a20:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106a23:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80106a29:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106a2f:	39 de                	cmp    %ebx,%esi
80106a31:	76 25                	jbe    80106a58 <deallocuvm+0x88>
    pte = walkpgdir(pgdir, (char*)a, 0);
80106a33:	31 c9                	xor    %ecx,%ecx
80106a35:	89 da                	mov    %ebx,%edx
80106a37:	89 f8                	mov    %edi,%eax
80106a39:	e8 32 fb ff ff       	call   80106570 <walkpgdir>
    if(!pte)
80106a3e:	85 c0                	test   %eax,%eax
80106a40:	75 be                	jne    80106a00 <deallocuvm+0x30>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80106a42:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80106a48:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80106a4e:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106a54:	39 de                	cmp    %ebx,%esi
80106a56:	77 db                	ja     80106a33 <deallocuvm+0x63>
      char *v = P2V(pa);
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
80106a58:	8b 45 10             	mov    0x10(%ebp),%eax
}
80106a5b:	83 c4 2c             	add    $0x2c,%esp
80106a5e:	5b                   	pop    %ebx
80106a5f:	5e                   	pop    %esi
80106a60:	5f                   	pop    %edi
80106a61:	5d                   	pop    %ebp
80106a62:	c3                   	ret    
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
      pa = PTE_ADDR(*pte);
      if(pa == 0)
        panic("kfree");
80106a63:	c7 04 24 06 71 10 80 	movl   $0x80107106,(%esp)
80106a6a:	e8 01 99 ff ff       	call   80100370 <panic>
80106a6f:	90                   	nop

80106a70 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80106a70:	55                   	push   %ebp
80106a71:	89 e5                	mov    %esp,%ebp
80106a73:	57                   	push   %edi
80106a74:	56                   	push   %esi
80106a75:	53                   	push   %ebx
80106a76:	83 ec 2c             	sub    $0x2c,%esp
80106a79:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
80106a7c:	85 ff                	test   %edi,%edi
80106a7e:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80106a81:	0f 88 c1 00 00 00    	js     80106b48 <allocuvm+0xd8>
    return 0;
  if(newsz < oldsz)
80106a87:	8b 45 0c             	mov    0xc(%ebp),%eax
80106a8a:	39 c7                	cmp    %eax,%edi
80106a8c:	0f 82 a6 00 00 00    	jb     80106b38 <allocuvm+0xc8>
    return oldsz;

  a = PGROUNDUP(oldsz);
80106a92:	8b 75 0c             	mov    0xc(%ebp),%esi
80106a95:	81 c6 ff 0f 00 00    	add    $0xfff,%esi
80106a9b:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  for(; a < newsz; a += PGSIZE){
80106aa1:	39 f7                	cmp    %esi,%edi
80106aa3:	77 51                	ja     80106af6 <allocuvm+0x86>
80106aa5:	e9 91 00 00 00       	jmp    80106b3b <allocuvm+0xcb>
80106aaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
80106ab0:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80106ab7:	00 
80106ab8:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106abf:	00 
80106ac0:	89 04 24             	mov    %eax,(%esp)
80106ac3:	e8 38 d9 ff ff       	call   80104400 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106ac8:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106ace:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106ad3:	89 04 24             	mov    %eax,(%esp)
80106ad6:	8b 45 08             	mov    0x8(%ebp),%eax
80106ad9:	89 f2                	mov    %esi,%edx
80106adb:	c7 44 24 04 06 00 00 	movl   $0x6,0x4(%esp)
80106ae2:	00 
80106ae3:	e8 18 fb ff ff       	call   80106600 <mappages>
80106ae8:	85 c0                	test   %eax,%eax
80106aea:	78 74                	js     80106b60 <allocuvm+0xf0>
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80106aec:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106af2:	39 f7                	cmp    %esi,%edi
80106af4:	76 45                	jbe    80106b3b <allocuvm+0xcb>
    mem = kalloc();
80106af6:	e8 75 ba ff ff       	call   80102570 <kalloc>
    if(mem == 0){
80106afb:	85 c0                	test   %eax,%eax
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
80106afd:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
80106aff:	75 af                	jne    80106ab0 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80106b01:	c7 04 24 c9 77 10 80 	movl   $0x801077c9,(%esp)
80106b08:	e8 43 9b ff ff       	call   80100650 <cprintf>
      deallocuvm(pgdir, newsz, oldsz);
80106b0d:	8b 45 0c             	mov    0xc(%ebp),%eax
80106b10:	89 7c 24 04          	mov    %edi,0x4(%esp)
80106b14:	89 44 24 08          	mov    %eax,0x8(%esp)
80106b18:	8b 45 08             	mov    0x8(%ebp),%eax
80106b1b:	89 04 24             	mov    %eax,(%esp)
80106b1e:	e8 ad fe ff ff       	call   801069d0 <deallocuvm>
      return 0;
80106b23:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80106b2a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106b2d:	83 c4 2c             	add    $0x2c,%esp
80106b30:	5b                   	pop    %ebx
80106b31:	5e                   	pop    %esi
80106b32:	5f                   	pop    %edi
80106b33:	5d                   	pop    %ebp
80106b34:	c3                   	ret    
80106b35:	8d 76 00             	lea    0x0(%esi),%esi
  uint a;

  if(newsz >= KERNBASE)
    return 0;
  if(newsz < oldsz)
    return oldsz;
80106b38:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80106b3b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106b3e:	83 c4 2c             	add    $0x2c,%esp
80106b41:	5b                   	pop    %ebx
80106b42:	5e                   	pop    %esi
80106b43:	5f                   	pop    %edi
80106b44:	5d                   	pop    %ebp
80106b45:	c3                   	ret    
80106b46:	66 90                	xchg   %ax,%ax
{
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
    return 0;
80106b48:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
      kfree(mem);
      return 0;
    }
  }
  return newsz;
}
80106b4f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106b52:	83 c4 2c             	add    $0x2c,%esp
80106b55:	5b                   	pop    %ebx
80106b56:	5e                   	pop    %esi
80106b57:	5f                   	pop    %edi
80106b58:	5d                   	pop    %ebp
80106b59:	c3                   	ret    
80106b5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
80106b60:	c7 04 24 e1 77 10 80 	movl   $0x801077e1,(%esp)
80106b67:	e8 e4 9a ff ff       	call   80100650 <cprintf>
      deallocuvm(pgdir, newsz, oldsz);
80106b6c:	8b 45 0c             	mov    0xc(%ebp),%eax
80106b6f:	89 7c 24 04          	mov    %edi,0x4(%esp)
80106b73:	89 44 24 08          	mov    %eax,0x8(%esp)
80106b77:	8b 45 08             	mov    0x8(%ebp),%eax
80106b7a:	89 04 24             	mov    %eax,(%esp)
80106b7d:	e8 4e fe ff ff       	call   801069d0 <deallocuvm>
      kfree(mem);
80106b82:	89 1c 24             	mov    %ebx,(%esp)
80106b85:	e8 76 b8 ff ff       	call   80102400 <kfree>
      return 0;
80106b8a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    }
  }
  return newsz;
}
80106b91:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106b94:	83 c4 2c             	add    $0x2c,%esp
80106b97:	5b                   	pop    %ebx
80106b98:	5e                   	pop    %esi
80106b99:	5f                   	pop    %edi
80106b9a:	5d                   	pop    %ebp
80106b9b:	c3                   	ret    
80106b9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106ba0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80106ba0:	55                   	push   %ebp
80106ba1:	89 e5                	mov    %esp,%ebp
80106ba3:	56                   	push   %esi
80106ba4:	53                   	push   %ebx
80106ba5:	83 ec 10             	sub    $0x10,%esp
80106ba8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint i;

  if(pgdir == 0)
80106bab:	85 db                	test   %ebx,%ebx
80106bad:	74 5e                	je     80106c0d <freevm+0x6d>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
80106baf:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
80106bb6:	00 
  for(i = 0; i < NPDENTRIES; i++){
80106bb7:	31 f6                	xor    %esi,%esi
{
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
80106bb9:	c7 44 24 04 00 00 00 	movl   $0x80000000,0x4(%esp)
80106bc0:	80 
80106bc1:	89 1c 24             	mov    %ebx,(%esp)
80106bc4:	e8 07 fe ff ff       	call   801069d0 <deallocuvm>
80106bc9:	eb 10                	jmp    80106bdb <freevm+0x3b>
80106bcb:	90                   	nop
80106bcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; i < NPDENTRIES; i++){
80106bd0:	83 c6 01             	add    $0x1,%esi
80106bd3:	81 fe 00 04 00 00    	cmp    $0x400,%esi
80106bd9:	74 24                	je     80106bff <freevm+0x5f>
    if(pgdir[i] & PTE_P){
80106bdb:	8b 04 b3             	mov    (%ebx,%esi,4),%eax
80106bde:	a8 01                	test   $0x1,%al
80106be0:	74 ee                	je     80106bd0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106be2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106be7:	83 c6 01             	add    $0x1,%esi
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106bea:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80106bef:	89 04 24             	mov    %eax,(%esp)
80106bf2:	e8 09 b8 ff ff       	call   80102400 <kfree>
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106bf7:	81 fe 00 04 00 00    	cmp    $0x400,%esi
80106bfd:	75 dc                	jne    80106bdb <freevm+0x3b>
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80106bff:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106c02:	83 c4 10             	add    $0x10,%esp
80106c05:	5b                   	pop    %ebx
80106c06:	5e                   	pop    %esi
80106c07:	5d                   	pop    %ebp
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80106c08:	e9 f3 b7 ff ff       	jmp    80102400 <kfree>
freevm(pde_t *pgdir)
{
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
80106c0d:	c7 04 24 fd 77 10 80 	movl   $0x801077fd,(%esp)
80106c14:	e8 57 97 ff ff       	call   80100370 <panic>
80106c19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106c20 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
80106c20:	55                   	push   %ebp
80106c21:	89 e5                	mov    %esp,%ebp
80106c23:	56                   	push   %esi
80106c24:	53                   	push   %ebx
80106c25:	83 ec 10             	sub    $0x10,%esp
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80106c28:	e8 43 b9 ff ff       	call   80102570 <kalloc>
80106c2d:	85 c0                	test   %eax,%eax
80106c2f:	89 c6                	mov    %eax,%esi
80106c31:	74 47                	je     80106c7a <setupkvm+0x5a>
    return 0;
  memset(pgdir, 0, PGSIZE);
80106c33:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80106c3a:	00 
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106c3b:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
80106c40:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
80106c47:	00 
80106c48:	89 04 24             	mov    %eax,(%esp)
80106c4b:	e8 b0 d7 ff ff       	call   80104400 <memset>
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106c50:	8b 53 0c             	mov    0xc(%ebx),%edx
80106c53:	8b 43 04             	mov    0x4(%ebx),%eax
80106c56:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106c59:	89 54 24 04          	mov    %edx,0x4(%esp)
80106c5d:	8b 13                	mov    (%ebx),%edx
80106c5f:	89 04 24             	mov    %eax,(%esp)
80106c62:	29 c1                	sub    %eax,%ecx
80106c64:	89 f0                	mov    %esi,%eax
80106c66:	e8 95 f9 ff ff       	call   80106600 <mappages>
80106c6b:	85 c0                	test   %eax,%eax
80106c6d:	78 19                	js     80106c88 <setupkvm+0x68>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106c6f:	83 c3 10             	add    $0x10,%ebx
80106c72:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80106c78:	72 d6                	jb     80106c50 <setupkvm+0x30>
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
      return 0;
    }
  return pgdir;
}
80106c7a:	83 c4 10             	add    $0x10,%esp
80106c7d:	89 f0                	mov    %esi,%eax
80106c7f:	5b                   	pop    %ebx
80106c80:	5e                   	pop    %esi
80106c81:	5d                   	pop    %ebp
80106c82:	c3                   	ret    
80106c83:	90                   	nop
80106c84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
80106c88:	89 34 24             	mov    %esi,(%esp)
      return 0;
80106c8b:	31 f6                	xor    %esi,%esi
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0) {
      freevm(pgdir);
80106c8d:	e8 0e ff ff ff       	call   80106ba0 <freevm>
      return 0;
    }
  return pgdir;
}
80106c92:	83 c4 10             	add    $0x10,%esp
80106c95:	89 f0                	mov    %esi,%eax
80106c97:	5b                   	pop    %ebx
80106c98:	5e                   	pop    %esi
80106c99:	5d                   	pop    %ebp
80106c9a:	c3                   	ret    
80106c9b:	90                   	nop
80106c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106ca0 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80106ca0:	55                   	push   %ebp
80106ca1:	89 e5                	mov    %esp,%ebp
80106ca3:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80106ca6:	e8 75 ff ff ff       	call   80106c20 <setupkvm>
80106cab:	a3 a4 54 11 80       	mov    %eax,0x801154a4
// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106cb0:	05 00 00 00 80       	add    $0x80000000,%eax
80106cb5:	0f 22 d8             	mov    %eax,%cr3
void
kvmalloc(void)
{
  kpgdir = setupkvm();
  switchkvm();
}
80106cb8:	c9                   	leave  
80106cb9:	c3                   	ret    
80106cba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106cc0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106cc0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106cc1:	31 c9                	xor    %ecx,%ecx

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106cc3:	89 e5                	mov    %esp,%ebp
80106cc5:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106cc8:	8b 55 0c             	mov    0xc(%ebp),%edx
80106ccb:	8b 45 08             	mov    0x8(%ebp),%eax
80106cce:	e8 9d f8 ff ff       	call   80106570 <walkpgdir>
  if(pte == 0)
80106cd3:	85 c0                	test   %eax,%eax
80106cd5:	74 05                	je     80106cdc <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80106cd7:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80106cda:	c9                   	leave  
80106cdb:	c3                   	ret    
{
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
80106cdc:	c7 04 24 0e 78 10 80 	movl   $0x8010780e,(%esp)
80106ce3:	e8 88 96 ff ff       	call   80100370 <panic>
80106ce8:	90                   	nop
80106ce9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106cf0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80106cf0:	55                   	push   %ebp
80106cf1:	89 e5                	mov    %esp,%ebp
80106cf3:	57                   	push   %edi
80106cf4:	56                   	push   %esi
80106cf5:	53                   	push   %ebx
80106cf6:	83 ec 2c             	sub    $0x2c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80106cf9:	e8 22 ff ff ff       	call   80106c20 <setupkvm>
80106cfe:	85 c0                	test   %eax,%eax
80106d00:	89 c7                	mov    %eax,%edi
80106d02:	0f 84 91 00 00 00    	je     80106d99 <copyuvm+0xa9>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106d08:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106d0b:	85 c9                	test   %ecx,%ecx
80106d0d:	0f 84 86 00 00 00    	je     80106d99 <copyuvm+0xa9>
80106d13:	31 f6                	xor    %esi,%esi
80106d15:	eb 54                	jmp    80106d6b <copyuvm+0x7b>
80106d17:	90                   	nop
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80106d18:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80106d1b:	c7 44 24 08 00 10 00 	movl   $0x1000,0x8(%esp)
80106d22:	00 
80106d23:	89 1c 24             	mov    %ebx,(%esp)
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80106d26:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80106d2b:	05 00 00 00 80       	add    $0x80000000,%eax
80106d30:	89 44 24 04          	mov    %eax,0x4(%esp)
80106d34:	e8 87 d7 ff ff       	call   801044c0 <memmove>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
80106d39:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80106d3c:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106d41:	89 f2                	mov    %esi,%edx
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
80106d43:	25 ff 0f 00 00       	and    $0xfff,%eax
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80106d48:	89 44 24 04          	mov    %eax,0x4(%esp)
80106d4c:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106d52:	89 04 24             	mov    %eax,(%esp)
80106d55:	89 f8                	mov    %edi,%eax
80106d57:	e8 a4 f8 ff ff       	call   80106600 <mappages>
80106d5c:	85 c0                	test   %eax,%eax
80106d5e:	78 48                	js     80106da8 <copyuvm+0xb8>
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106d60:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106d66:	39 75 0c             	cmp    %esi,0xc(%ebp)
80106d69:	76 2e                	jbe    80106d99 <copyuvm+0xa9>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80106d6b:	8b 45 08             	mov    0x8(%ebp),%eax
80106d6e:	31 c9                	xor    %ecx,%ecx
80106d70:	89 f2                	mov    %esi,%edx
80106d72:	e8 f9 f7 ff ff       	call   80106570 <walkpgdir>
80106d77:	85 c0                	test   %eax,%eax
80106d79:	74 43                	je     80106dbe <copyuvm+0xce>
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
80106d7b:	8b 00                	mov    (%eax),%eax
80106d7d:	a8 01                	test   $0x1,%al
80106d7f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106d82:	74 2e                	je     80106db2 <copyuvm+0xc2>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
80106d84:	e8 e7 b7 ff ff       	call   80102570 <kalloc>
80106d89:	85 c0                	test   %eax,%eax
80106d8b:	89 c3                	mov    %eax,%ebx
80106d8d:	75 89                	jne    80106d18 <copyuvm+0x28>
    }
  }
  return d;

bad:
  freevm(d);
80106d8f:	89 3c 24             	mov    %edi,(%esp)
  return 0;
80106d92:	31 ff                	xor    %edi,%edi
    }
  }
  return d;

bad:
  freevm(d);
80106d94:	e8 07 fe ff ff       	call   80106ba0 <freevm>
  return 0;
}
80106d99:	83 c4 2c             	add    $0x2c,%esp
80106d9c:	89 f8                	mov    %edi,%eax
80106d9e:	5b                   	pop    %ebx
80106d9f:	5e                   	pop    %esi
80106da0:	5f                   	pop    %edi
80106da1:	5d                   	pop    %ebp
80106da2:	c3                   	ret    
80106da3:	90                   	nop
80106da4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
      kfree(mem);
80106da8:	89 1c 24             	mov    %ebx,(%esp)
80106dab:	e8 50 b6 ff ff       	call   80102400 <kfree>
      goto bad;
80106db0:	eb dd                	jmp    80106d8f <copyuvm+0x9f>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
80106db2:	c7 04 24 32 78 10 80 	movl   $0x80107832,(%esp)
80106db9:	e8 b2 95 ff ff       	call   80100370 <panic>

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
80106dbe:	c7 04 24 18 78 10 80 	movl   $0x80107818,(%esp)
80106dc5:	e8 a6 95 ff ff       	call   80100370 <panic>
80106dca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106dd0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80106dd0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106dd1:	31 c9                	xor    %ecx,%ecx

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80106dd3:	89 e5                	mov    %esp,%ebp
80106dd5:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80106dd8:	8b 55 0c             	mov    0xc(%ebp),%edx
80106ddb:	8b 45 08             	mov    0x8(%ebp),%eax
80106dde:	e8 8d f7 ff ff       	call   80106570 <walkpgdir>
  if((*pte & PTE_P) == 0)
80106de3:	8b 10                	mov    (%eax),%edx
    return 0;
80106de5:	31 c0                	xor    %eax,%eax
uva2ka(pde_t *pgdir, char *uva)
{
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
80106de7:	f6 c2 01             	test   $0x1,%dl
80106dea:	74 11                	je     80106dfd <uva2ka+0x2d>
    return 0;
  if((*pte & PTE_U) == 0)
80106dec:	f6 c2 04             	test   $0x4,%dl
80106def:	74 0c                	je     80106dfd <uva2ka+0x2d>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
80106df1:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106df7:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
}
80106dfd:	c9                   	leave  
80106dfe:	c3                   	ret    
80106dff:	90                   	nop

80106e00 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80106e00:	55                   	push   %ebp
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
80106e01:	31 c0                	xor    %eax,%eax
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80106e03:	89 e5                	mov    %esp,%ebp
80106e05:	57                   	push   %edi
80106e06:	56                   	push   %esi
80106e07:	53                   	push   %ebx
80106e08:	83 ec 2c             	sub    $0x2c,%esp
80106e0b:	8b 5d 14             	mov    0x14(%ebp),%ebx
80106e0e:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80106e11:	85 db                	test   %ebx,%ebx
80106e13:	74 64                	je     80106e79 <copyout+0x79>
80106e15:	8b 4d 10             	mov    0x10(%ebp),%ecx
80106e18:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80106e1b:	eb 36                	jmp    80106e53 <copyout+0x53>
80106e1d:	8d 76 00             	lea    0x0(%esi),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80106e20:	89 f7                	mov    %esi,%edi
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80106e22:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80106e25:	29 d7                	sub    %edx,%edi
80106e27:	81 c7 00 10 00 00    	add    $0x1000,%edi
80106e2d:	39 df                	cmp    %ebx,%edi
80106e2f:	0f 47 fb             	cmova  %ebx,%edi
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80106e32:	29 f2                	sub    %esi,%edx
80106e34:	01 c2                	add    %eax,%edx
80106e36:	89 14 24             	mov    %edx,(%esp)
80106e39:	89 7c 24 08          	mov    %edi,0x8(%esp)
80106e3d:	89 4c 24 04          	mov    %ecx,0x4(%esp)
80106e41:	e8 7a d6 ff ff       	call   801044c0 <memmove>
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
80106e46:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    n = PGSIZE - (va - va0);
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
80106e4c:	01 7d e4             	add    %edi,-0x1c(%ebp)
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80106e4f:	29 fb                	sub    %edi,%ebx
80106e51:	74 35                	je     80106e88 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
80106e53:	8b 4d 08             	mov    0x8(%ebp),%ecx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
80106e56:	89 d6                	mov    %edx,%esi
80106e58:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80106e5e:	89 55 e0             	mov    %edx,-0x20(%ebp)
80106e61:	89 74 24 04          	mov    %esi,0x4(%esp)
80106e65:	89 0c 24             	mov    %ecx,(%esp)
80106e68:	e8 63 ff ff ff       	call   80106dd0 <uva2ka>
    if(pa0 == 0)
80106e6d:	8b 55 e0             	mov    -0x20(%ebp),%edx
80106e70:	85 c0                	test   %eax,%eax
80106e72:	75 ac                	jne    80106e20 <copyout+0x20>
      return -1;
80106e74:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
80106e79:	83 c4 2c             	add    $0x2c,%esp
80106e7c:	5b                   	pop    %ebx
80106e7d:	5e                   	pop    %esi
80106e7e:	5f                   	pop    %edi
80106e7f:	5d                   	pop    %ebp
80106e80:	c3                   	ret    
80106e81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106e88:	83 c4 2c             	add    $0x2c,%esp
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
80106e8b:	31 c0                	xor    %eax,%eax
}
80106e8d:	5b                   	pop    %ebx
80106e8e:	5e                   	pop    %esi
80106e8f:	5f                   	pop    %edi
80106e90:	5d                   	pop    %ebp
80106e91:	c3                   	ret    
