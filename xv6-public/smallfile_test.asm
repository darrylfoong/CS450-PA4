
_smallfile_test:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
    printf(1, "Contents: %s\n", buf);
    printf(1, "Small File Successfully Loaded and Read\n");
    close(fd);
}

int main(void){
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
    creating();
   6:	e8 15 00 00 00       	call   20 <creating>
    loading();
   b:	e8 00 01 00 00       	call   110 <loading>
    exit();
  10:	e8 4f 04 00 00       	call   464 <exit>
  15:	90                   	nop
  16:	90                   	nop
  17:	90                   	nop
  18:	90                   	nop
  19:	90                   	nop
  1a:	90                   	nop
  1b:	90                   	nop
  1c:	90                   	nop
  1d:	90                   	nop
  1e:	90                   	nop
  1f:	90                   	nop

00000020 <creating>:
#include "types.h"
#include "user.h"
#include "fcntl.h"

void creating(void){
  20:	55                   	push   %ebp
  21:	89 e5                	mov    %esp,%ebp
  23:	53                   	push   %ebx
  24:	83 ec 14             	sub    $0x14,%esp
    int fd;
    fd = open("smallfile", O_CREATE | O_SMALL | O_RDWR);
  27:	c7 44 24 04 02 06 00 	movl   $0x602,0x4(%esp)
  2e:	00 
  2f:	c7 04 24 a0 08 00 00 	movl   $0x8a0,(%esp)
  36:	e8 69 04 00 00       	call   4a4 <open>

    if(fd >= 0) {
  3b:	85 c0                	test   %eax,%eax
#include "user.h"
#include "fcntl.h"

void creating(void){
    int fd;
    fd = open("smallfile", O_CREATE | O_SMALL | O_RDWR);
  3d:	89 c3                	mov    %eax,%ebx

    if(fd >= 0) {
  3f:	0f 88 a6 00 00 00    	js     eb <creating+0xcb>
        printf(1, "Normal File Created Successfully\n");
  45:	c7 44 24 04 cc 08 00 	movl   $0x8cc,0x4(%esp)
  4c:	00 
  4d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  54:	e8 67 05 00 00       	call   5c0 <printf>
    } else {
        printf(1, "Error: Normal File Failed to Create\n");
        exit();
    }
  
    if(write(fd, "Darryl ", 7) != 7){
  59:	c7 44 24 08 07 00 00 	movl   $0x7,0x8(%esp)
  60:	00 
  61:	c7 44 24 04 aa 08 00 	movl   $0x8aa,0x4(%esp)
  68:	00 
  69:	89 1c 24             	mov    %ebx,(%esp)
  6c:	e8 13 04 00 00       	call   484 <write>
  71:	83 f8 07             	cmp    $0x7,%eax
  74:	75 5c                	jne    d2 <creating+0xb2>
        printf(1, "Error: Failed to Write to Normal File\n");
        exit();
    }

    if(write(fd, "and ", 4) != 4){
  76:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
  7d:	00 
  7e:	c7 44 24 04 b2 08 00 	movl   $0x8b2,0x4(%esp)
  85:	00 
  86:	89 1c 24             	mov    %ebx,(%esp)
  89:	e8 f6 03 00 00       	call   484 <write>
  8e:	83 f8 04             	cmp    $0x4,%eax
  91:	75 3f                	jne    d2 <creating+0xb2>
        printf(1, "Error: Failed to Write to Normal File\n");
        exit();
    }

    if(write(fd, "Mark", 4) != 4){
  93:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
  9a:	00 
  9b:	c7 44 24 04 b7 08 00 	movl   $0x8b7,0x4(%esp)
  a2:	00 
  a3:	89 1c 24             	mov    %ebx,(%esp)
  a6:	e8 d9 03 00 00       	call   484 <write>
  ab:	83 f8 04             	cmp    $0x4,%eax
  ae:	75 22                	jne    d2 <creating+0xb2>
        printf(1, "Error: Failed to Write to Normal File\n");
        exit();
    }

    printf(1, "Successfully Written to Small File\n");
  b0:	c7 44 24 04 40 09 00 	movl   $0x940,0x4(%esp)
  b7:	00 
  b8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  bf:	e8 fc 04 00 00       	call   5c0 <printf>
    close(fd);
  c4:	89 1c 24             	mov    %ebx,(%esp)
  c7:	e8 c0 03 00 00       	call   48c <close>
}
  cc:	83 c4 14             	add    $0x14,%esp
  cf:	5b                   	pop    %ebx
  d0:	5d                   	pop    %ebp
  d1:	c3                   	ret    
        printf(1, "Error: Failed to Write to Normal File\n");
        exit();
    }

    if(write(fd, "Mark", 4) != 4){
        printf(1, "Error: Failed to Write to Normal File\n");
  d2:	c7 44 24 04 18 09 00 	movl   $0x918,0x4(%esp)
  d9:	00 
  da:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  e1:	e8 da 04 00 00       	call   5c0 <printf>
        exit();
  e6:	e8 79 03 00 00       	call   464 <exit>
    fd = open("smallfile", O_CREATE | O_SMALL | O_RDWR);

    if(fd >= 0) {
        printf(1, "Normal File Created Successfully\n");
    } else {
        printf(1, "Error: Normal File Failed to Create\n");
  eb:	c7 44 24 04 f0 08 00 	movl   $0x8f0,0x4(%esp)
  f2:	00 
  f3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  fa:	e8 c1 04 00 00       	call   5c0 <printf>
        exit();
  ff:	e8 60 03 00 00       	call   464 <exit>
 104:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 10a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000110 <loading>:

    printf(1, "Successfully Written to Small File\n");
    close(fd);
}

void loading(void){
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	56                   	push   %esi
 114:	53                   	push   %ebx
 115:	83 ec 20             	sub    $0x20,%esp
    int fd;
    char buf[16];
    fd = open("smallfile", O_RDONLY);
 118:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 11f:	00 
 120:	c7 04 24 a0 08 00 00 	movl   $0x8a0,(%esp)
 127:	e8 78 03 00 00       	call   4a4 <open>

    if(fd >= 0) {
 12c:	85 c0                	test   %eax,%eax
}

void loading(void){
    int fd;
    char buf[16];
    fd = open("smallfile", O_RDONLY);
 12e:	89 c3                	mov    %eax,%ebx

    if(fd >= 0) {
 130:	0f 88 d9 00 00 00    	js     20f <loading+0xff>
    } else {
        printf(1, "Error: Small File Failed to Load\n");
        exit();
    }

    if (read(fd, buf, 7) != 7) {
 136:	8d 75 e8             	lea    -0x18(%ebp),%esi
    int fd;
    char buf[16];
    fd = open("smallfile", O_RDONLY);

    if(fd >= 0) {
        printf(1, "Small File Loaded Successfully\n");
 139:	c7 44 24 04 64 09 00 	movl   $0x964,0x4(%esp)
 140:	00 
 141:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 148:	e8 73 04 00 00       	call   5c0 <printf>
    } else {
        printf(1, "Error: Small File Failed to Load\n");
        exit();
    }

    if (read(fd, buf, 7) != 7) {
 14d:	c7 44 24 08 07 00 00 	movl   $0x7,0x8(%esp)
 154:	00 
 155:	89 74 24 04          	mov    %esi,0x4(%esp)
 159:	89 1c 24             	mov    %ebx,(%esp)
 15c:	e8 1b 03 00 00       	call   47c <read>
 161:	83 f8 07             	cmp    $0x7,%eax
 164:	0f 85 8c 00 00 00    	jne    1f6 <loading+0xe6>
        printf(1, "Error: Failed to Read from Normal File\n");
        exit();
    }
    if (read(fd, buf+7, 4) != 4) {
 16a:	8d 45 ef             	lea    -0x11(%ebp),%eax
 16d:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
 174:	00 
 175:	89 44 24 04          	mov    %eax,0x4(%esp)
 179:	89 1c 24             	mov    %ebx,(%esp)
 17c:	e8 fb 02 00 00       	call   47c <read>
 181:	83 f8 04             	cmp    $0x4,%eax
 184:	75 57                	jne    1dd <loading+0xcd>
        printf(1, "error: failed to read from normal file\n");
        exit();
    }
    if (read(fd, buf+11, 4) != 4) {
 186:	8d 45 f3             	lea    -0xd(%ebp),%eax
 189:	c7 44 24 08 04 00 00 	movl   $0x4,0x8(%esp)
 190:	00 
 191:	89 44 24 04          	mov    %eax,0x4(%esp)
 195:	89 1c 24             	mov    %ebx,(%esp)
 198:	e8 df 02 00 00       	call   47c <read>
 19d:	83 f8 04             	cmp    $0x4,%eax
 1a0:	75 3b                	jne    1dd <loading+0xcd>
        printf(1, "error: failed to read from normal file\n");
        exit();
    }

    printf(1, "Contents: %s\n", buf);
 1a2:	89 74 24 08          	mov    %esi,0x8(%esp)
 1a6:	c7 44 24 04 bc 08 00 	movl   $0x8bc,0x4(%esp)
 1ad:	00 
 1ae:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1b5:	e8 06 04 00 00       	call   5c0 <printf>
    printf(1, "Small File Successfully Loaded and Read\n");
 1ba:	c7 44 24 04 f8 09 00 	movl   $0x9f8,0x4(%esp)
 1c1:	00 
 1c2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1c9:	e8 f2 03 00 00       	call   5c0 <printf>
    close(fd);
 1ce:	89 1c 24             	mov    %ebx,(%esp)
 1d1:	e8 b6 02 00 00       	call   48c <close>
}
 1d6:	83 c4 20             	add    $0x20,%esp
 1d9:	5b                   	pop    %ebx
 1da:	5e                   	pop    %esi
 1db:	5d                   	pop    %ebp
 1dc:	c3                   	ret    
    if (read(fd, buf+7, 4) != 4) {
        printf(1, "error: failed to read from normal file\n");
        exit();
    }
    if (read(fd, buf+11, 4) != 4) {
        printf(1, "error: failed to read from normal file\n");
 1dd:	c7 44 24 04 d0 09 00 	movl   $0x9d0,0x4(%esp)
 1e4:	00 
 1e5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1ec:	e8 cf 03 00 00       	call   5c0 <printf>
        exit();
 1f1:	e8 6e 02 00 00       	call   464 <exit>
        printf(1, "Error: Small File Failed to Load\n");
        exit();
    }

    if (read(fd, buf, 7) != 7) {
        printf(1, "Error: Failed to Read from Normal File\n");
 1f6:	c7 44 24 04 a8 09 00 	movl   $0x9a8,0x4(%esp)
 1fd:	00 
 1fe:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 205:	e8 b6 03 00 00       	call   5c0 <printf>
        exit();
 20a:	e8 55 02 00 00       	call   464 <exit>
    fd = open("smallfile", O_RDONLY);

    if(fd >= 0) {
        printf(1, "Small File Loaded Successfully\n");
    } else {
        printf(1, "Error: Small File Failed to Load\n");
 20f:	c7 44 24 04 84 09 00 	movl   $0x984,0x4(%esp)
 216:	00 
 217:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 21e:	e8 9d 03 00 00       	call   5c0 <printf>
        exit();
 223:	e8 3c 02 00 00       	call   464 <exit>
 228:	90                   	nop
 229:	90                   	nop
 22a:	90                   	nop
 22b:	90                   	nop
 22c:	90                   	nop
 22d:	90                   	nop
 22e:	90                   	nop
 22f:	90                   	nop

00000230 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 230:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 231:	31 d2                	xor    %edx,%edx
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 233:	89 e5                	mov    %esp,%ebp
 235:	8b 45 08             	mov    0x8(%ebp),%eax
 238:	53                   	push   %ebx
 239:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 23c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 240:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
 244:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 247:	83 c2 01             	add    $0x1,%edx
 24a:	84 c9                	test   %cl,%cl
 24c:	75 f2                	jne    240 <strcpy+0x10>
    ;
  return os;
}
 24e:	5b                   	pop    %ebx
 24f:	5d                   	pop    %ebp
 250:	c3                   	ret    
 251:	eb 0d                	jmp    260 <strcmp>
 253:	90                   	nop
 254:	90                   	nop
 255:	90                   	nop
 256:	90                   	nop
 257:	90                   	nop
 258:	90                   	nop
 259:	90                   	nop
 25a:	90                   	nop
 25b:	90                   	nop
 25c:	90                   	nop
 25d:	90                   	nop
 25e:	90                   	nop
 25f:	90                   	nop

00000260 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	8b 4d 08             	mov    0x8(%ebp),%ecx
 266:	56                   	push   %esi
 267:	8b 55 0c             	mov    0xc(%ebp),%edx
 26a:	53                   	push   %ebx
  while(*p && *p == *q)
 26b:	0f b6 01             	movzbl (%ecx),%eax
 26e:	0f b6 1a             	movzbl (%edx),%ebx
 271:	84 c0                	test   %al,%al
 273:	74 23                	je     298 <strcmp+0x38>
 275:	38 d8                	cmp    %bl,%al
 277:	74 10                	je     289 <strcmp+0x29>
 279:	eb 2d                	jmp    2a8 <strcmp+0x48>
 27b:	90                   	nop
 27c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 280:	83 c1 01             	add    $0x1,%ecx
 283:	38 d8                	cmp    %bl,%al
 285:	75 21                	jne    2a8 <strcmp+0x48>
    p++, q++;
 287:	89 f2                	mov    %esi,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 289:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 28d:	8d 72 01             	lea    0x1(%edx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 290:	0f b6 5a 01          	movzbl 0x1(%edx),%ebx
 294:	84 c0                	test   %al,%al
 296:	75 e8                	jne    280 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 298:	0f b6 db             	movzbl %bl,%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 29b:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 29d:	29 d8                	sub    %ebx,%eax
}
 29f:	5b                   	pop    %ebx
 2a0:	5e                   	pop    %esi
 2a1:	5d                   	pop    %ebp
 2a2:	c3                   	ret    
 2a3:	90                   	nop
 2a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    p++, q++;
  return (uchar)*p - (uchar)*q;
 2a8:	0f b6 db             	movzbl %bl,%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 2ab:	0f b6 c0             	movzbl %al,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 2ae:	29 d8                	sub    %ebx,%eax
}
 2b0:	5b                   	pop    %ebx
 2b1:	5e                   	pop    %esi
 2b2:	5d                   	pop    %ebp
 2b3:	c3                   	ret    
 2b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 2ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000002c0 <strlen>:

uint
strlen(const char *s)
{
 2c0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
 2c1:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(const char *s)
{
 2c3:	89 e5                	mov    %esp,%ebp
 2c5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 2c8:	80 39 00             	cmpb   $0x0,(%ecx)
 2cb:	74 0e                	je     2db <strlen+0x1b>
 2cd:	31 d2                	xor    %edx,%edx
 2cf:	90                   	nop
 2d0:	83 c2 01             	add    $0x1,%edx
 2d3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 2d7:	89 d0                	mov    %edx,%eax
 2d9:	75 f5                	jne    2d0 <strlen+0x10>
    ;
  return n;
}
 2db:	5d                   	pop    %ebp
 2dc:	c3                   	ret    
 2dd:	8d 76 00             	lea    0x0(%esi),%esi

000002e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 2e0:	55                   	push   %ebp
 2e1:	89 e5                	mov    %esp,%ebp
 2e3:	8b 55 08             	mov    0x8(%ebp),%edx
 2e6:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 2e7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 2ea:	8b 45 0c             	mov    0xc(%ebp),%eax
 2ed:	89 d7                	mov    %edx,%edi
 2ef:	fc                   	cld    
 2f0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 2f2:	89 d0                	mov    %edx,%eax
 2f4:	5f                   	pop    %edi
 2f5:	5d                   	pop    %ebp
 2f6:	c3                   	ret    
 2f7:	89 f6                	mov    %esi,%esi
 2f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000300 <strchr>:

char*
strchr(const char *s, char c)
{
 300:	55                   	push   %ebp
 301:	89 e5                	mov    %esp,%ebp
 303:	8b 45 08             	mov    0x8(%ebp),%eax
 306:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 30a:	0f b6 10             	movzbl (%eax),%edx
 30d:	84 d2                	test   %dl,%dl
 30f:	75 12                	jne    323 <strchr+0x23>
 311:	eb 1d                	jmp    330 <strchr+0x30>
 313:	90                   	nop
 314:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 318:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 31c:	84 d2                	test   %dl,%dl
 31e:	74 10                	je     330 <strchr+0x30>
 320:	83 c0 01             	add    $0x1,%eax
    if(*s == c)
 323:	38 ca                	cmp    %cl,%dl
 325:	75 f1                	jne    318 <strchr+0x18>
      return (char*)s;
  return 0;
}
 327:	5d                   	pop    %ebp
 328:	c3                   	ret    
 329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
strchr(const char *s, char c)
{
  for(; *s; s++)
    if(*s == c)
      return (char*)s;
  return 0;
 330:	31 c0                	xor    %eax,%eax
}
 332:	5d                   	pop    %ebp
 333:	c3                   	ret    
 334:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 33a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000340 <gets>:

char*
gets(char *buf, int max)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	57                   	push   %edi
 344:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 345:	31 f6                	xor    %esi,%esi
  return 0;
}

char*
gets(char *buf, int max)
{
 347:	53                   	push   %ebx
 348:	83 ec 2c             	sub    $0x2c,%esp
 34b:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 34e:	eb 31                	jmp    381 <gets+0x41>
    cc = read(0, &c, 1);
 350:	8d 45 e7             	lea    -0x19(%ebp),%eax
 353:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 35a:	00 
 35b:	89 44 24 04          	mov    %eax,0x4(%esp)
 35f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 366:	e8 11 01 00 00       	call   47c <read>
    if(cc < 1)
 36b:	85 c0                	test   %eax,%eax
 36d:	7e 1a                	jle    389 <gets+0x49>
      break;
    buf[i++] = c;
 36f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 373:	89 de                	mov    %ebx,%esi
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 375:	3c 0d                	cmp    $0xd,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 377:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
 37b:	74 0c                	je     389 <gets+0x49>
 37d:	3c 0a                	cmp    $0xa,%al
 37f:	74 08                	je     389 <gets+0x49>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 381:	8d 5e 01             	lea    0x1(%esi),%ebx
 384:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 387:	7c c7                	jl     350 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 389:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 38d:	83 c4 2c             	add    $0x2c,%esp
 390:	89 f8                	mov    %edi,%eax
 392:	5b                   	pop    %ebx
 393:	5e                   	pop    %esi
 394:	5f                   	pop    %edi
 395:	5d                   	pop    %ebp
 396:	c3                   	ret    
 397:	89 f6                	mov    %esi,%esi
 399:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003a0 <stat>:

int
stat(const char *n, struct stat *st)
{
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3a6:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(const char *n, struct stat *st)
{
 3a9:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 3ac:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 3af:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(const char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3b4:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 3bb:	00 
 3bc:	89 04 24             	mov    %eax,(%esp)
 3bf:	e8 e0 00 00 00       	call   4a4 <open>
  if(fd < 0)
 3c4:	85 c0                	test   %eax,%eax
stat(const char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3c6:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 3c8:	78 19                	js     3e3 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 3ca:	8b 45 0c             	mov    0xc(%ebp),%eax
 3cd:	89 1c 24             	mov    %ebx,(%esp)
 3d0:	89 44 24 04          	mov    %eax,0x4(%esp)
 3d4:	e8 e3 00 00 00       	call   4bc <fstat>
  close(fd);
 3d9:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 3dc:	89 c6                	mov    %eax,%esi
  close(fd);
 3de:	e8 a9 00 00 00       	call   48c <close>
  return r;
}
 3e3:	89 f0                	mov    %esi,%eax
 3e5:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 3e8:	8b 75 fc             	mov    -0x4(%ebp),%esi
 3eb:	89 ec                	mov    %ebp,%esp
 3ed:	5d                   	pop    %ebp
 3ee:	c3                   	ret    
 3ef:	90                   	nop

000003f0 <atoi>:

int
atoi(const char *s)
{
 3f0:	55                   	push   %ebp
  int n;

  n = 0;
 3f1:	31 c0                	xor    %eax,%eax
  return r;
}

int
atoi(const char *s)
{
 3f3:	89 e5                	mov    %esp,%ebp
 3f5:	8b 4d 08             	mov    0x8(%ebp),%ecx
 3f8:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3f9:	0f b6 11             	movzbl (%ecx),%edx
 3fc:	8d 5a d0             	lea    -0x30(%edx),%ebx
 3ff:	80 fb 09             	cmp    $0x9,%bl
 402:	77 1c                	ja     420 <atoi+0x30>
 404:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 408:	0f be d2             	movsbl %dl,%edx
 40b:	83 c1 01             	add    $0x1,%ecx
 40e:	8d 04 80             	lea    (%eax,%eax,4),%eax
 411:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 415:	0f b6 11             	movzbl (%ecx),%edx
 418:	8d 5a d0             	lea    -0x30(%edx),%ebx
 41b:	80 fb 09             	cmp    $0x9,%bl
 41e:	76 e8                	jbe    408 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 420:	5b                   	pop    %ebx
 421:	5d                   	pop    %ebp
 422:	c3                   	ret    
 423:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000430 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 430:	55                   	push   %ebp
 431:	89 e5                	mov    %esp,%ebp
 433:	56                   	push   %esi
 434:	8b 45 08             	mov    0x8(%ebp),%eax
 437:	53                   	push   %ebx
 438:	8b 5d 10             	mov    0x10(%ebp),%ebx
 43b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 43e:	85 db                	test   %ebx,%ebx
 440:	7e 14                	jle    456 <memmove+0x26>
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, const void *vsrc, int n)
 442:	31 d2                	xor    %edx,%edx
 444:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    *dst++ = *src++;
 448:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 44c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 44f:	83 c2 01             	add    $0x1,%edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 452:	39 da                	cmp    %ebx,%edx
 454:	75 f2                	jne    448 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 456:	5b                   	pop    %ebx
 457:	5e                   	pop    %esi
 458:	5d                   	pop    %ebp
 459:	c3                   	ret    
 45a:	90                   	nop
 45b:	90                   	nop

0000045c <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 45c:	b8 01 00 00 00       	mov    $0x1,%eax
 461:	cd 40                	int    $0x40
 463:	c3                   	ret    

00000464 <exit>:
SYSCALL(exit)
 464:	b8 02 00 00 00       	mov    $0x2,%eax
 469:	cd 40                	int    $0x40
 46b:	c3                   	ret    

0000046c <wait>:
SYSCALL(wait)
 46c:	b8 03 00 00 00       	mov    $0x3,%eax
 471:	cd 40                	int    $0x40
 473:	c3                   	ret    

00000474 <pipe>:
SYSCALL(pipe)
 474:	b8 04 00 00 00       	mov    $0x4,%eax
 479:	cd 40                	int    $0x40
 47b:	c3                   	ret    

0000047c <read>:
SYSCALL(read)
 47c:	b8 05 00 00 00       	mov    $0x5,%eax
 481:	cd 40                	int    $0x40
 483:	c3                   	ret    

00000484 <write>:
SYSCALL(write)
 484:	b8 10 00 00 00       	mov    $0x10,%eax
 489:	cd 40                	int    $0x40
 48b:	c3                   	ret    

0000048c <close>:
SYSCALL(close)
 48c:	b8 15 00 00 00       	mov    $0x15,%eax
 491:	cd 40                	int    $0x40
 493:	c3                   	ret    

00000494 <kill>:
SYSCALL(kill)
 494:	b8 06 00 00 00       	mov    $0x6,%eax
 499:	cd 40                	int    $0x40
 49b:	c3                   	ret    

0000049c <exec>:
SYSCALL(exec)
 49c:	b8 07 00 00 00       	mov    $0x7,%eax
 4a1:	cd 40                	int    $0x40
 4a3:	c3                   	ret    

000004a4 <open>:
SYSCALL(open)
 4a4:	b8 0f 00 00 00       	mov    $0xf,%eax
 4a9:	cd 40                	int    $0x40
 4ab:	c3                   	ret    

000004ac <mknod>:
SYSCALL(mknod)
 4ac:	b8 11 00 00 00       	mov    $0x11,%eax
 4b1:	cd 40                	int    $0x40
 4b3:	c3                   	ret    

000004b4 <unlink>:
SYSCALL(unlink)
 4b4:	b8 12 00 00 00       	mov    $0x12,%eax
 4b9:	cd 40                	int    $0x40
 4bb:	c3                   	ret    

000004bc <fstat>:
SYSCALL(fstat)
 4bc:	b8 08 00 00 00       	mov    $0x8,%eax
 4c1:	cd 40                	int    $0x40
 4c3:	c3                   	ret    

000004c4 <link>:
SYSCALL(link)
 4c4:	b8 13 00 00 00       	mov    $0x13,%eax
 4c9:	cd 40                	int    $0x40
 4cb:	c3                   	ret    

000004cc <mkdir>:
SYSCALL(mkdir)
 4cc:	b8 14 00 00 00       	mov    $0x14,%eax
 4d1:	cd 40                	int    $0x40
 4d3:	c3                   	ret    

000004d4 <mksfdir>:
SYSCALL(mksfdir)
 4d4:	b8 16 00 00 00       	mov    $0x16,%eax
 4d9:	cd 40                	int    $0x40
 4db:	c3                   	ret    

000004dc <chdir>:
SYSCALL(chdir)
 4dc:	b8 09 00 00 00       	mov    $0x9,%eax
 4e1:	cd 40                	int    $0x40
 4e3:	c3                   	ret    

000004e4 <dup>:
SYSCALL(dup)
 4e4:	b8 0a 00 00 00       	mov    $0xa,%eax
 4e9:	cd 40                	int    $0x40
 4eb:	c3                   	ret    

000004ec <getpid>:
SYSCALL(getpid)
 4ec:	b8 0b 00 00 00       	mov    $0xb,%eax
 4f1:	cd 40                	int    $0x40
 4f3:	c3                   	ret    

000004f4 <sbrk>:
SYSCALL(sbrk)
 4f4:	b8 0c 00 00 00       	mov    $0xc,%eax
 4f9:	cd 40                	int    $0x40
 4fb:	c3                   	ret    

000004fc <sleep>:
SYSCALL(sleep)
 4fc:	b8 0d 00 00 00       	mov    $0xd,%eax
 501:	cd 40                	int    $0x40
 503:	c3                   	ret    

00000504 <uptime>:
SYSCALL(uptime)
 504:	b8 0e 00 00 00       	mov    $0xe,%eax
 509:	cd 40                	int    $0x40
 50b:	c3                   	ret    
 50c:	90                   	nop
 50d:	90                   	nop
 50e:	90                   	nop
 50f:	90                   	nop

00000510 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 510:	55                   	push   %ebp
 511:	89 e5                	mov    %esp,%ebp
 513:	83 ec 28             	sub    $0x28,%esp
 516:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 519:	8d 55 f4             	lea    -0xc(%ebp),%edx
 51c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 523:	00 
 524:	89 54 24 04          	mov    %edx,0x4(%esp)
 528:	89 04 24             	mov    %eax,(%esp)
 52b:	e8 54 ff ff ff       	call   484 <write>
}
 530:	c9                   	leave  
 531:	c3                   	ret    
 532:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000540 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 540:	55                   	push   %ebp
 541:	89 e5                	mov    %esp,%ebp
 543:	57                   	push   %edi
 544:	56                   	push   %esi
 545:	89 c6                	mov    %eax,%esi
 547:	53                   	push   %ebx
 548:	83 ec 1c             	sub    $0x1c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 54b:	8b 45 08             	mov    0x8(%ebp),%eax
 54e:	85 c0                	test   %eax,%eax
 550:	74 5e                	je     5b0 <printint+0x70>
 552:	89 d0                	mov    %edx,%eax
 554:	c1 e8 1f             	shr    $0x1f,%eax
 557:	84 c0                	test   %al,%al
 559:	74 55                	je     5b0 <printint+0x70>
    neg = 1;
    x = -xx;
 55b:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 55d:	bf 01 00 00 00       	mov    $0x1,%edi
    x = -xx;
 562:	f7 d8                	neg    %eax
  } else {
    x = xx;
  }

  i = 0;
 564:	31 db                	xor    %ebx,%ebx
 566:	eb 02                	jmp    56a <printint+0x2a>
  do{
    buf[i++] = digits[x % base];
 568:	89 d3                	mov    %edx,%ebx
 56a:	31 d2                	xor    %edx,%edx
 56c:	f7 f1                	div    %ecx
 56e:	0f b6 92 2b 0a 00 00 	movzbl 0xa2b(%edx),%edx
  }while((x /= base) != 0);
 575:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 577:	88 54 1d d8          	mov    %dl,-0x28(%ebp,%ebx,1)
 57b:	8d 53 01             	lea    0x1(%ebx),%edx
  }while((x /= base) != 0);
 57e:	75 e8                	jne    568 <printint+0x28>
  if(neg)
 580:	85 ff                	test   %edi,%edi
 582:	74 08                	je     58c <printint+0x4c>
    buf[i++] = '-';
 584:	c6 44 15 d8 2d       	movb   $0x2d,-0x28(%ebp,%edx,1)
 589:	8d 53 02             	lea    0x2(%ebx),%edx

  while(--i >= 0)
 58c:	8d 5a ff             	lea    -0x1(%edx),%ebx
 58f:	90                   	nop
    putc(fd, buf[i]);
 590:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
 595:	89 f0                	mov    %esi,%eax
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 597:	83 eb 01             	sub    $0x1,%ebx
    putc(fd, buf[i]);
 59a:	e8 71 ff ff ff       	call   510 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 59f:	83 fb ff             	cmp    $0xffffffff,%ebx
 5a2:	75 ec                	jne    590 <printint+0x50>
    putc(fd, buf[i]);
}
 5a4:	83 c4 1c             	add    $0x1c,%esp
 5a7:	5b                   	pop    %ebx
 5a8:	5e                   	pop    %esi
 5a9:	5f                   	pop    %edi
 5aa:	5d                   	pop    %ebp
 5ab:	c3                   	ret    
 5ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 5b0:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 5b2:	31 ff                	xor    %edi,%edi
 5b4:	eb ae                	jmp    564 <printint+0x24>
 5b6:	8d 76 00             	lea    0x0(%esi),%esi
 5b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000005c0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 5c0:	55                   	push   %ebp
 5c1:	89 e5                	mov    %esp,%ebp
 5c3:	57                   	push   %edi
 5c4:	56                   	push   %esi
 5c5:	53                   	push   %ebx
 5c6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5c9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 5cc:	0f b6 0b             	movzbl (%ebx),%ecx
 5cf:	84 c9                	test   %cl,%cl
 5d1:	0f 84 89 00 00 00    	je     660 <printf+0xa0>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 5d7:	8d 45 10             	lea    0x10(%ebp),%eax
{
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 5da:	31 f6                	xor    %esi,%esi
  ap = (uint*)(void*)&fmt + 1;
 5dc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 5df:	eb 21                	jmp    602 <printf+0x42>
 5e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 5e8:	83 f9 25             	cmp    $0x25,%ecx
 5eb:	74 7b                	je     668 <printf+0xa8>
        state = '%';
      } else {
        putc(fd, c);
 5ed:	8b 45 08             	mov    0x8(%ebp),%eax
 5f0:	0f be d1             	movsbl %cl,%edx
 5f3:	e8 18 ff ff ff       	call   510 <putc>
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 5f8:	83 c3 01             	add    $0x1,%ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5fb:	0f b6 0b             	movzbl (%ebx),%ecx
 5fe:	84 c9                	test   %cl,%cl
 600:	74 5e                	je     660 <printf+0xa0>
    c = fmt[i] & 0xff;
    if(state == 0){
 602:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 604:	0f b6 c9             	movzbl %cl,%ecx
    if(state == 0){
 607:	74 df                	je     5e8 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 609:	83 fe 25             	cmp    $0x25,%esi
 60c:	75 ea                	jne    5f8 <printf+0x38>
      if(c == 'd'){
 60e:	83 f9 64             	cmp    $0x64,%ecx
 611:	0f 84 c9 00 00 00    	je     6e0 <printf+0x120>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 617:	83 f9 70             	cmp    $0x70,%ecx
 61a:	74 54                	je     670 <printf+0xb0>
 61c:	83 f9 78             	cmp    $0x78,%ecx
 61f:	90                   	nop
 620:	74 4e                	je     670 <printf+0xb0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 622:	83 f9 73             	cmp    $0x73,%ecx
 625:	74 71                	je     698 <printf+0xd8>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 627:	83 f9 63             	cmp    $0x63,%ecx
 62a:	0f 84 d2 00 00 00    	je     702 <printf+0x142>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 630:	83 f9 25             	cmp    $0x25,%ecx
        putc(fd, c);
 633:	ba 25 00 00 00       	mov    $0x25,%edx
 638:	8b 45 08             	mov    0x8(%ebp),%eax
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 63b:	74 11                	je     64e <printf+0x8e>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 63d:	89 4d e0             	mov    %ecx,-0x20(%ebp)
 640:	e8 cb fe ff ff       	call   510 <putc>
        putc(fd, c);
 645:	8b 4d e0             	mov    -0x20(%ebp),%ecx
 648:	8b 45 08             	mov    0x8(%ebp),%eax
 64b:	0f be d1             	movsbl %cl,%edx
 64e:	83 c3 01             	add    $0x1,%ebx
      }
      state = 0;
 651:	31 f6                	xor    %esi,%esi
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 653:	e8 b8 fe ff ff       	call   510 <putc>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 658:	0f b6 0b             	movzbl (%ebx),%ecx
 65b:	84 c9                	test   %cl,%cl
 65d:	75 a3                	jne    602 <printf+0x42>
 65f:	90                   	nop
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 660:	83 c4 2c             	add    $0x2c,%esp
 663:	5b                   	pop    %ebx
 664:	5e                   	pop    %esi
 665:	5f                   	pop    %edi
 666:	5d                   	pop    %ebp
 667:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 668:	be 25 00 00 00       	mov    $0x25,%esi
 66d:	eb 89                	jmp    5f8 <printf+0x38>
 66f:	90                   	nop
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 670:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 673:	b9 10 00 00 00       	mov    $0x10,%ecx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 678:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 67a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 681:	8b 10                	mov    (%eax),%edx
 683:	8b 45 08             	mov    0x8(%ebp),%eax
 686:	e8 b5 fe ff ff       	call   540 <printint>
        ap++;
 68b:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
 68f:	e9 64 ff ff ff       	jmp    5f8 <printf+0x38>
 694:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 698:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 69b:	8b 38                	mov    (%eax),%edi
        ap++;
 69d:	83 c0 04             	add    $0x4,%eax
 6a0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
          s = "(null)";
 6a3:	b8 24 0a 00 00       	mov    $0xa24,%eax
 6a8:	85 ff                	test   %edi,%edi
 6aa:	0f 44 f8             	cmove  %eax,%edi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 6ad:	31 f6                	xor    %esi,%esi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 6af:	0f b6 17             	movzbl (%edi),%edx
 6b2:	84 d2                	test   %dl,%dl
 6b4:	0f 84 3e ff ff ff    	je     5f8 <printf+0x38>
 6ba:	89 de                	mov    %ebx,%esi
 6bc:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6bf:	90                   	nop
          putc(fd, *s);
 6c0:	0f be d2             	movsbl %dl,%edx
          s++;
 6c3:	83 c7 01             	add    $0x1,%edi
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
 6c6:	89 d8                	mov    %ebx,%eax
 6c8:	e8 43 fe ff ff       	call   510 <putc>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 6cd:	0f b6 17             	movzbl (%edi),%edx
 6d0:	84 d2                	test   %dl,%dl
 6d2:	75 ec                	jne    6c0 <printf+0x100>
 6d4:	89 f3                	mov    %esi,%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 6d6:	31 f6                	xor    %esi,%esi
 6d8:	e9 1b ff ff ff       	jmp    5f8 <printf+0x38>
 6dd:	8d 76 00             	lea    0x0(%esi),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 6e0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6e3:	b1 0a                	mov    $0xa,%cl
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 6e5:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 6e8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 6ef:	8b 10                	mov    (%eax),%edx
 6f1:	8b 45 08             	mov    0x8(%ebp),%eax
 6f4:	e8 47 fe ff ff       	call   540 <printint>
        ap++;
 6f9:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
 6fd:	e9 f6 fe ff ff       	jmp    5f8 <printf+0x38>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 702:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 705:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 707:	0f be 10             	movsbl (%eax),%edx
 70a:	8b 45 08             	mov    0x8(%ebp),%eax
 70d:	e8 fe fd ff ff       	call   510 <putc>
        ap++;
 712:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
 716:	e9 dd fe ff ff       	jmp    5f8 <printf+0x38>
 71b:	90                   	nop
 71c:	90                   	nop
 71d:	90                   	nop
 71e:	90                   	nop
 71f:	90                   	nop

00000720 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 720:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 721:	a1 28 0d 00 00       	mov    0xd28,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 726:	89 e5                	mov    %esp,%ebp
 728:	57                   	push   %edi
 729:	56                   	push   %esi
 72a:	53                   	push   %ebx
 72b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 72e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 731:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 738:	39 c8                	cmp    %ecx,%eax
 73a:	8b 10                	mov    (%eax),%edx
 73c:	73 04                	jae    742 <free+0x22>
 73e:	39 d1                	cmp    %edx,%ecx
 740:	72 16                	jb     758 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 742:	39 d0                	cmp    %edx,%eax
 744:	72 0c                	jb     752 <free+0x32>
 746:	39 c8                	cmp    %ecx,%eax
 748:	72 0e                	jb     758 <free+0x38>
 74a:	39 d1                	cmp    %edx,%ecx
 74c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 750:	72 06                	jb     758 <free+0x38>
static Header base;
static Header *freep;

void
free(void *ap)
{
 752:	89 d0                	mov    %edx,%eax
 754:	eb e2                	jmp    738 <free+0x18>
 756:	66 90                	xchg   %ax,%ax

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 758:	8b 73 fc             	mov    -0x4(%ebx),%esi
 75b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 75e:	39 d7                	cmp    %edx,%edi
 760:	74 19                	je     77b <free+0x5b>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 762:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 765:	8b 50 04             	mov    0x4(%eax),%edx
 768:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 76b:	39 f1                	cmp    %esi,%ecx
 76d:	74 23                	je     792 <free+0x72>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 76f:	89 08                	mov    %ecx,(%eax)
  freep = p;
 771:	a3 28 0d 00 00       	mov    %eax,0xd28
}
 776:	5b                   	pop    %ebx
 777:	5e                   	pop    %esi
 778:	5f                   	pop    %edi
 779:	5d                   	pop    %ebp
 77a:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 77b:	03 72 04             	add    0x4(%edx),%esi
 77e:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 781:	8b 10                	mov    (%eax),%edx
 783:	8b 12                	mov    (%edx),%edx
 785:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 788:	8b 50 04             	mov    0x4(%eax),%edx
 78b:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 78e:	39 f1                	cmp    %esi,%ecx
 790:	75 dd                	jne    76f <free+0x4f>
    p->s.size += bp->s.size;
 792:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 795:	a3 28 0d 00 00       	mov    %eax,0xd28
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 79a:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 79d:	8b 53 f8             	mov    -0x8(%ebx),%edx
 7a0:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 7a2:	5b                   	pop    %ebx
 7a3:	5e                   	pop    %esi
 7a4:	5f                   	pop    %edi
 7a5:	5d                   	pop    %ebp
 7a6:	c3                   	ret    
 7a7:	89 f6                	mov    %esi,%esi
 7a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000007b0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7b0:	55                   	push   %ebp
 7b1:	89 e5                	mov    %esp,%ebp
 7b3:	57                   	push   %edi
 7b4:	56                   	push   %esi
 7b5:	53                   	push   %ebx
 7b6:	83 ec 2c             	sub    $0x2c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((prevp = freep) == 0){
 7bc:	8b 15 28 0d 00 00    	mov    0xd28,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7c2:	83 c3 07             	add    $0x7,%ebx
 7c5:	c1 eb 03             	shr    $0x3,%ebx
 7c8:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 7cb:	85 d2                	test   %edx,%edx
 7cd:	0f 84 a3 00 00 00    	je     876 <malloc+0xc6>
 7d3:	8b 02                	mov    (%edx),%eax
 7d5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 7d8:	39 d9                	cmp    %ebx,%ecx
 7da:	73 74                	jae    850 <malloc+0xa0>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
 7dc:	8d 14 dd 00 00 00 00 	lea    0x0(,%ebx,8),%edx
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 7e3:	bf 00 80 00 00       	mov    $0x8000,%edi
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
 7e8:	89 55 e4             	mov    %edx,-0x1c(%ebp)
 7eb:	eb 0c                	jmp    7f9 <malloc+0x49>
 7ed:	8d 76 00             	lea    0x0(%esi),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7f0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 7f2:	8b 48 04             	mov    0x4(%eax),%ecx
 7f5:	39 cb                	cmp    %ecx,%ebx
 7f7:	76 57                	jbe    850 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 7f9:	3b 05 28 0d 00 00    	cmp    0xd28,%eax
 7ff:	89 c2                	mov    %eax,%edx
 801:	75 ed                	jne    7f0 <malloc+0x40>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 803:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 806:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
 80c:	be 00 10 00 00       	mov    $0x1000,%esi
 811:	0f 43 f3             	cmovae %ebx,%esi
 814:	0f 42 c7             	cmovb  %edi,%eax
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 817:	89 04 24             	mov    %eax,(%esp)
 81a:	e8 d5 fc ff ff       	call   4f4 <sbrk>
  if(p == (char*)-1)
 81f:	83 f8 ff             	cmp    $0xffffffff,%eax
 822:	74 1c                	je     840 <malloc+0x90>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 824:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 827:	83 c0 08             	add    $0x8,%eax
 82a:	89 04 24             	mov    %eax,(%esp)
 82d:	e8 ee fe ff ff       	call   720 <free>
  return freep;
 832:	8b 15 28 0d 00 00    	mov    0xd28,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 838:	85 d2                	test   %edx,%edx
 83a:	75 b4                	jne    7f0 <malloc+0x40>
 83c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return 0;
  }
}
 840:	83 c4 2c             	add    $0x2c,%esp
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
 843:	31 c0                	xor    %eax,%eax
  }
}
 845:	5b                   	pop    %ebx
 846:	5e                   	pop    %esi
 847:	5f                   	pop    %edi
 848:	5d                   	pop    %ebp
 849:	c3                   	ret    
 84a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 850:	39 cb                	cmp    %ecx,%ebx
 852:	74 1c                	je     870 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 854:	29 d9                	sub    %ebx,%ecx
 856:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 859:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 85c:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 85f:	89 15 28 0d 00 00    	mov    %edx,0xd28
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 865:	83 c4 2c             	add    $0x2c,%esp
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
 868:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 86b:	5b                   	pop    %ebx
 86c:	5e                   	pop    %esi
 86d:	5f                   	pop    %edi
 86e:	5d                   	pop    %ebp
 86f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 870:	8b 08                	mov    (%eax),%ecx
 872:	89 0a                	mov    %ecx,(%edx)
 874:	eb e9                	jmp    85f <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 876:	c7 05 28 0d 00 00 2c 	movl   $0xd2c,0xd28
 87d:	0d 00 00 
    base.s.size = 0;
 880:	b8 2c 0d 00 00       	mov    $0xd2c,%eax
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 885:	c7 05 2c 0d 00 00 2c 	movl   $0xd2c,0xd2c
 88c:	0d 00 00 
    base.s.size = 0;
 88f:	c7 05 30 0d 00 00 00 	movl   $0x0,0xd30
 896:	00 00 00 
 899:	e9 3e ff ff ff       	jmp    7dc <malloc+0x2c>
