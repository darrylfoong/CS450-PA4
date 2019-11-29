
_file_test3:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
    close(fd);
}

int
main(void)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
    save();
   6:	e8 15 00 00 00       	call   20 <save>
    load();
   b:	e8 e0 00 00 00       	call   f0 <load>

    exit();
  10:	e8 ef 03 00 00       	call   404 <exit>
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

00000020 <save>:
#include "user.h"
#include "fcntl.h"

void
save(void)
{
  20:	55                   	push   %ebp
  21:	89 e5                	mov    %esp,%ebp
  23:	53                   	push   %ebx
  24:	83 ec 14             	sub    $0x14,%esp
    int fd;

    fd = open("small1", O_CREATE | O_SMALL | O_RDWR);
  27:	c7 44 24 04 02 06 00 	movl   $0x602,0x4(%esp)
  2e:	00 
  2f:	c7 04 24 40 08 00 00 	movl   $0x840,(%esp)
  36:	e8 09 04 00 00       	call   444 <open>
    if(fd >= 0) {
  3b:	85 c0                	test   %eax,%eax
void
save(void)
{
    int fd;

    fd = open("small1", O_CREATE | O_SMALL | O_RDWR);
  3d:	89 c3                	mov    %eax,%ebx
    if(fd >= 0) {
  3f:	0f 88 89 00 00 00    	js     ce <save+0xae>
        printf(1, "ok: create small1 file succeed\n");
  45:	c7 44 24 04 90 08 00 	movl   $0x890,0x4(%esp)
  4c:	00 
  4d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  54:	e8 07 05 00 00       	call   560 <printf>
    } else {
        printf(1, "error: create small1 file failed\n");
        exit();
    }
   
    if(write(fd, "hello ", 6) != 6){
  59:	c7 44 24 08 06 00 00 	movl   $0x6,0x8(%esp)
  60:	00 
  61:	c7 44 24 04 47 08 00 	movl   $0x847,0x4(%esp)
  68:	00 
  69:	89 1c 24             	mov    %ebx,(%esp)
  6c:	e8 b3 03 00 00       	call   424 <write>
  71:	83 f8 06             	cmp    $0x6,%eax
  74:	75 3f                	jne    b5 <save+0x95>
        printf(1, "error: write to small1 file failed\n");
        exit();
    }
    if(write(fd, "world", 5) != 5){
  76:	c7 44 24 08 05 00 00 	movl   $0x5,0x8(%esp)
  7d:	00 
  7e:	c7 44 24 04 4e 08 00 	movl   $0x84e,0x4(%esp)
  85:	00 
  86:	89 1c 24             	mov    %ebx,(%esp)
  89:	e8 96 03 00 00       	call   424 <write>
  8e:	83 f8 05             	cmp    $0x5,%eax
  91:	75 22                	jne    b5 <save+0x95>
        printf(1, "error: write to small1 file failed\n");
        exit();
    }


    printf(1, "write ok\n");
  93:	c7 44 24 04 54 08 00 	movl   $0x854,0x4(%esp)
  9a:	00 
  9b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  a2:	e8 b9 04 00 00       	call   560 <printf>
    close(fd);
  a7:	89 1c 24             	mov    %ebx,(%esp)
  aa:	e8 7d 03 00 00       	call   42c <close>
}
  af:	83 c4 14             	add    $0x14,%esp
  b2:	5b                   	pop    %ebx
  b3:	5d                   	pop    %ebp
  b4:	c3                   	ret    
    if(write(fd, "hello ", 6) != 6){
        printf(1, "error: write to small1 file failed\n");
        exit();
    }
    if(write(fd, "world", 5) != 5){
        printf(1, "error: write to small1 file failed\n");
  b5:	c7 44 24 04 d4 08 00 	movl   $0x8d4,0x4(%esp)
  bc:	00 
  bd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  c4:	e8 97 04 00 00       	call   560 <printf>
        exit();
  c9:	e8 36 03 00 00       	call   404 <exit>

    fd = open("small1", O_CREATE | O_SMALL | O_RDWR);
    if(fd >= 0) {
        printf(1, "ok: create small1 file succeed\n");
    } else {
        printf(1, "error: create small1 file failed\n");
  ce:	c7 44 24 04 b0 08 00 	movl   $0x8b0,0x4(%esp)
  d5:	00 
  d6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  dd:	e8 7e 04 00 00       	call   560 <printf>
        exit();
  e2:	e8 1d 03 00 00       	call   404 <exit>
  e7:	89 f6                	mov    %esi,%esi
  e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000000f0 <load>:
    close(fd);
}

void
load(void)
{
  f0:	55                   	push   %ebp
  f1:	89 e5                	mov    %esp,%ebp
  f3:	56                   	push   %esi
  f4:	53                   	push   %ebx
  f5:	83 ec 20             	sub    $0x20,%esp
    int fd;
    char dst[12];

    fd = open("small1", O_RDONLY);
  f8:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  ff:	00 
 100:	c7 04 24 40 08 00 00 	movl   $0x840,(%esp)
 107:	e8 38 03 00 00       	call   444 <open>
    if(fd >= 0) {
 10c:	85 c0                	test   %eax,%eax
load(void)
{
    int fd;
    char dst[12];

    fd = open("small1", O_RDONLY);
 10e:	89 c3                	mov    %eax,%ebx
    if(fd >= 0) {
 110:	0f 88 a0 00 00 00    	js     1b6 <load+0xc6>
        printf(1, "ok: read small1 file succeed\n");
    } else {
        printf(1, "error: read small1 file failed\n");
        exit();
    }
    if (read(fd, dst, 6) != 6) {
 116:	8d 75 ec             	lea    -0x14(%ebp),%esi
    int fd;
    char dst[12];

    fd = open("small1", O_RDONLY);
    if(fd >= 0) {
        printf(1, "ok: read small1 file succeed\n");
 119:	c7 44 24 04 5e 08 00 	movl   $0x85e,0x4(%esp)
 120:	00 
 121:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 128:	e8 33 04 00 00       	call   560 <printf>
    } else {
        printf(1, "error: read small1 file failed\n");
        exit();
    }
    if (read(fd, dst, 6) != 6) {
 12d:	c7 44 24 08 06 00 00 	movl   $0x6,0x8(%esp)
 134:	00 
 135:	89 74 24 04          	mov    %esi,0x4(%esp)
 139:	89 1c 24             	mov    %ebx,(%esp)
 13c:	e8 db 02 00 00       	call   41c <read>
 141:	83 f8 06             	cmp    $0x6,%eax
 144:	75 57                	jne    19d <load+0xad>
        printf(1, "error: read from small1 file failed\n");
        exit();
     }

    if(read(fd, dst + 6, 10) != 5) {
 146:	8d 45 f2             	lea    -0xe(%ebp),%eax
 149:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 150:	00 
 151:	89 44 24 04          	mov    %eax,0x4(%esp)
 155:	89 1c 24             	mov    %ebx,(%esp)
 158:	e8 bf 02 00 00       	call   41c <read>
 15d:	83 f8 05             	cmp    $0x5,%eax
 160:	75 3b                	jne    19d <load+0xad>
        printf(1, "error: read from small1 file failed\n");
        exit();
     }
    printf(1, "dst= %s\n", dst);
 162:	89 74 24 08          	mov    %esi,0x8(%esp)
 166:	c7 44 24 04 7c 08 00 	movl   $0x87c,0x4(%esp)
 16d:	00 
 16e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 175:	e8 e6 03 00 00       	call   560 <printf>

    printf(1, "read ok\n");
 17a:	c7 44 24 04 85 08 00 	movl   $0x885,0x4(%esp)
 181:	00 
 182:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 189:	e8 d2 03 00 00       	call   560 <printf>
    close(fd);
 18e:	89 1c 24             	mov    %ebx,(%esp)
 191:	e8 96 02 00 00       	call   42c <close>
}
 196:	83 c4 20             	add    $0x20,%esp
 199:	5b                   	pop    %ebx
 19a:	5e                   	pop    %esi
 19b:	5d                   	pop    %ebp
 19c:	c3                   	ret    
        printf(1, "error: read from small1 file failed\n");
        exit();
     }

    if(read(fd, dst + 6, 10) != 5) {
        printf(1, "error: read from small1 file failed\n");
 19d:	c7 44 24 04 18 09 00 	movl   $0x918,0x4(%esp)
 1a4:	00 
 1a5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1ac:	e8 af 03 00 00       	call   560 <printf>
        exit();
 1b1:	e8 4e 02 00 00       	call   404 <exit>

    fd = open("small1", O_RDONLY);
    if(fd >= 0) {
        printf(1, "ok: read small1 file succeed\n");
    } else {
        printf(1, "error: read small1 file failed\n");
 1b6:	c7 44 24 04 f8 08 00 	movl   $0x8f8,0x4(%esp)
 1bd:	00 
 1be:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 1c5:	e8 96 03 00 00       	call   560 <printf>
        exit();
 1ca:	e8 35 02 00 00       	call   404 <exit>
 1cf:	90                   	nop

000001d0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 1d0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1d1:	31 d2                	xor    %edx,%edx
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 1d3:	89 e5                	mov    %esp,%ebp
 1d5:	8b 45 08             	mov    0x8(%ebp),%eax
 1d8:	53                   	push   %ebx
 1d9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 1dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1e0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
 1e4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 1e7:	83 c2 01             	add    $0x1,%edx
 1ea:	84 c9                	test   %cl,%cl
 1ec:	75 f2                	jne    1e0 <strcpy+0x10>
    ;
  return os;
}
 1ee:	5b                   	pop    %ebx
 1ef:	5d                   	pop    %ebp
 1f0:	c3                   	ret    
 1f1:	eb 0d                	jmp    200 <strcmp>
 1f3:	90                   	nop
 1f4:	90                   	nop
 1f5:	90                   	nop
 1f6:	90                   	nop
 1f7:	90                   	nop
 1f8:	90                   	nop
 1f9:	90                   	nop
 1fa:	90                   	nop
 1fb:	90                   	nop
 1fc:	90                   	nop
 1fd:	90                   	nop
 1fe:	90                   	nop
 1ff:	90                   	nop

00000200 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	8b 4d 08             	mov    0x8(%ebp),%ecx
 206:	56                   	push   %esi
 207:	8b 55 0c             	mov    0xc(%ebp),%edx
 20a:	53                   	push   %ebx
  while(*p && *p == *q)
 20b:	0f b6 01             	movzbl (%ecx),%eax
 20e:	0f b6 1a             	movzbl (%edx),%ebx
 211:	84 c0                	test   %al,%al
 213:	74 23                	je     238 <strcmp+0x38>
 215:	38 d8                	cmp    %bl,%al
 217:	74 10                	je     229 <strcmp+0x29>
 219:	eb 2d                	jmp    248 <strcmp+0x48>
 21b:	90                   	nop
 21c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 220:	83 c1 01             	add    $0x1,%ecx
 223:	38 d8                	cmp    %bl,%al
 225:	75 21                	jne    248 <strcmp+0x48>
    p++, q++;
 227:	89 f2                	mov    %esi,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 229:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 22d:	8d 72 01             	lea    0x1(%edx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 230:	0f b6 5a 01          	movzbl 0x1(%edx),%ebx
 234:	84 c0                	test   %al,%al
 236:	75 e8                	jne    220 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 238:	0f b6 db             	movzbl %bl,%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 23b:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 23d:	29 d8                	sub    %ebx,%eax
}
 23f:	5b                   	pop    %ebx
 240:	5e                   	pop    %esi
 241:	5d                   	pop    %ebp
 242:	c3                   	ret    
 243:	90                   	nop
 244:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    p++, q++;
  return (uchar)*p - (uchar)*q;
 248:	0f b6 db             	movzbl %bl,%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 24b:	0f b6 c0             	movzbl %al,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 24e:	29 d8                	sub    %ebx,%eax
}
 250:	5b                   	pop    %ebx
 251:	5e                   	pop    %esi
 252:	5d                   	pop    %ebp
 253:	c3                   	ret    
 254:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 25a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000260 <strlen>:

uint
strlen(const char *s)
{
 260:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
 261:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(const char *s)
{
 263:	89 e5                	mov    %esp,%ebp
 265:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 268:	80 39 00             	cmpb   $0x0,(%ecx)
 26b:	74 0e                	je     27b <strlen+0x1b>
 26d:	31 d2                	xor    %edx,%edx
 26f:	90                   	nop
 270:	83 c2 01             	add    $0x1,%edx
 273:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 277:	89 d0                	mov    %edx,%eax
 279:	75 f5                	jne    270 <strlen+0x10>
    ;
  return n;
}
 27b:	5d                   	pop    %ebp
 27c:	c3                   	ret    
 27d:	8d 76 00             	lea    0x0(%esi),%esi

00000280 <memset>:

void*
memset(void *dst, int c, uint n)
{
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	8b 55 08             	mov    0x8(%ebp),%edx
 286:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 287:	8b 4d 10             	mov    0x10(%ebp),%ecx
 28a:	8b 45 0c             	mov    0xc(%ebp),%eax
 28d:	89 d7                	mov    %edx,%edi
 28f:	fc                   	cld    
 290:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 292:	89 d0                	mov    %edx,%eax
 294:	5f                   	pop    %edi
 295:	5d                   	pop    %ebp
 296:	c3                   	ret    
 297:	89 f6                	mov    %esi,%esi
 299:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002a0 <strchr>:

char*
strchr(const char *s, char c)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	8b 45 08             	mov    0x8(%ebp),%eax
 2a6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 2aa:	0f b6 10             	movzbl (%eax),%edx
 2ad:	84 d2                	test   %dl,%dl
 2af:	75 12                	jne    2c3 <strchr+0x23>
 2b1:	eb 1d                	jmp    2d0 <strchr+0x30>
 2b3:	90                   	nop
 2b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2b8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 2bc:	84 d2                	test   %dl,%dl
 2be:	74 10                	je     2d0 <strchr+0x30>
 2c0:	83 c0 01             	add    $0x1,%eax
    if(*s == c)
 2c3:	38 ca                	cmp    %cl,%dl
 2c5:	75 f1                	jne    2b8 <strchr+0x18>
      return (char*)s;
  return 0;
}
 2c7:	5d                   	pop    %ebp
 2c8:	c3                   	ret    
 2c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
strchr(const char *s, char c)
{
  for(; *s; s++)
    if(*s == c)
      return (char*)s;
  return 0;
 2d0:	31 c0                	xor    %eax,%eax
}
 2d2:	5d                   	pop    %ebp
 2d3:	c3                   	ret    
 2d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 2da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000002e0 <gets>:

char*
gets(char *buf, int max)
{
 2e0:	55                   	push   %ebp
 2e1:	89 e5                	mov    %esp,%ebp
 2e3:	57                   	push   %edi
 2e4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2e5:	31 f6                	xor    %esi,%esi
  return 0;
}

char*
gets(char *buf, int max)
{
 2e7:	53                   	push   %ebx
 2e8:	83 ec 2c             	sub    $0x2c,%esp
 2eb:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2ee:	eb 31                	jmp    321 <gets+0x41>
    cc = read(0, &c, 1);
 2f0:	8d 45 e7             	lea    -0x19(%ebp),%eax
 2f3:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 2fa:	00 
 2fb:	89 44 24 04          	mov    %eax,0x4(%esp)
 2ff:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 306:	e8 11 01 00 00       	call   41c <read>
    if(cc < 1)
 30b:	85 c0                	test   %eax,%eax
 30d:	7e 1a                	jle    329 <gets+0x49>
      break;
    buf[i++] = c;
 30f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 313:	89 de                	mov    %ebx,%esi
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 315:	3c 0d                	cmp    $0xd,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 317:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
 31b:	74 0c                	je     329 <gets+0x49>
 31d:	3c 0a                	cmp    $0xa,%al
 31f:	74 08                	je     329 <gets+0x49>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 321:	8d 5e 01             	lea    0x1(%esi),%ebx
 324:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 327:	7c c7                	jl     2f0 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 329:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 32d:	83 c4 2c             	add    $0x2c,%esp
 330:	89 f8                	mov    %edi,%eax
 332:	5b                   	pop    %ebx
 333:	5e                   	pop    %esi
 334:	5f                   	pop    %edi
 335:	5d                   	pop    %ebp
 336:	c3                   	ret    
 337:	89 f6                	mov    %esi,%esi
 339:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000340 <stat>:

int
stat(const char *n, struct stat *st)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 346:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(const char *n, struct stat *st)
{
 349:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 34c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 34f:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(const char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 354:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 35b:	00 
 35c:	89 04 24             	mov    %eax,(%esp)
 35f:	e8 e0 00 00 00       	call   444 <open>
  if(fd < 0)
 364:	85 c0                	test   %eax,%eax
stat(const char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 366:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 368:	78 19                	js     383 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 36a:	8b 45 0c             	mov    0xc(%ebp),%eax
 36d:	89 1c 24             	mov    %ebx,(%esp)
 370:	89 44 24 04          	mov    %eax,0x4(%esp)
 374:	e8 e3 00 00 00       	call   45c <fstat>
  close(fd);
 379:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 37c:	89 c6                	mov    %eax,%esi
  close(fd);
 37e:	e8 a9 00 00 00       	call   42c <close>
  return r;
}
 383:	89 f0                	mov    %esi,%eax
 385:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 388:	8b 75 fc             	mov    -0x4(%ebp),%esi
 38b:	89 ec                	mov    %ebp,%esp
 38d:	5d                   	pop    %ebp
 38e:	c3                   	ret    
 38f:	90                   	nop

00000390 <atoi>:

int
atoi(const char *s)
{
 390:	55                   	push   %ebp
  int n;

  n = 0;
 391:	31 c0                	xor    %eax,%eax
  return r;
}

int
atoi(const char *s)
{
 393:	89 e5                	mov    %esp,%ebp
 395:	8b 4d 08             	mov    0x8(%ebp),%ecx
 398:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 399:	0f b6 11             	movzbl (%ecx),%edx
 39c:	8d 5a d0             	lea    -0x30(%edx),%ebx
 39f:	80 fb 09             	cmp    $0x9,%bl
 3a2:	77 1c                	ja     3c0 <atoi+0x30>
 3a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 3a8:	0f be d2             	movsbl %dl,%edx
 3ab:	83 c1 01             	add    $0x1,%ecx
 3ae:	8d 04 80             	lea    (%eax,%eax,4),%eax
 3b1:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3b5:	0f b6 11             	movzbl (%ecx),%edx
 3b8:	8d 5a d0             	lea    -0x30(%edx),%ebx
 3bb:	80 fb 09             	cmp    $0x9,%bl
 3be:	76 e8                	jbe    3a8 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 3c0:	5b                   	pop    %ebx
 3c1:	5d                   	pop    %ebp
 3c2:	c3                   	ret    
 3c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003d0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	56                   	push   %esi
 3d4:	8b 45 08             	mov    0x8(%ebp),%eax
 3d7:	53                   	push   %ebx
 3d8:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3db:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3de:	85 db                	test   %ebx,%ebx
 3e0:	7e 14                	jle    3f6 <memmove+0x26>
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, const void *vsrc, int n)
 3e2:	31 d2                	xor    %edx,%edx
 3e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    *dst++ = *src++;
 3e8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 3ec:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 3ef:	83 c2 01             	add    $0x1,%edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3f2:	39 da                	cmp    %ebx,%edx
 3f4:	75 f2                	jne    3e8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 3f6:	5b                   	pop    %ebx
 3f7:	5e                   	pop    %esi
 3f8:	5d                   	pop    %ebp
 3f9:	c3                   	ret    
 3fa:	90                   	nop
 3fb:	90                   	nop

000003fc <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3fc:	b8 01 00 00 00       	mov    $0x1,%eax
 401:	cd 40                	int    $0x40
 403:	c3                   	ret    

00000404 <exit>:
SYSCALL(exit)
 404:	b8 02 00 00 00       	mov    $0x2,%eax
 409:	cd 40                	int    $0x40
 40b:	c3                   	ret    

0000040c <wait>:
SYSCALL(wait)
 40c:	b8 03 00 00 00       	mov    $0x3,%eax
 411:	cd 40                	int    $0x40
 413:	c3                   	ret    

00000414 <pipe>:
SYSCALL(pipe)
 414:	b8 04 00 00 00       	mov    $0x4,%eax
 419:	cd 40                	int    $0x40
 41b:	c3                   	ret    

0000041c <read>:
SYSCALL(read)
 41c:	b8 05 00 00 00       	mov    $0x5,%eax
 421:	cd 40                	int    $0x40
 423:	c3                   	ret    

00000424 <write>:
SYSCALL(write)
 424:	b8 10 00 00 00       	mov    $0x10,%eax
 429:	cd 40                	int    $0x40
 42b:	c3                   	ret    

0000042c <close>:
SYSCALL(close)
 42c:	b8 15 00 00 00       	mov    $0x15,%eax
 431:	cd 40                	int    $0x40
 433:	c3                   	ret    

00000434 <kill>:
SYSCALL(kill)
 434:	b8 06 00 00 00       	mov    $0x6,%eax
 439:	cd 40                	int    $0x40
 43b:	c3                   	ret    

0000043c <exec>:
SYSCALL(exec)
 43c:	b8 07 00 00 00       	mov    $0x7,%eax
 441:	cd 40                	int    $0x40
 443:	c3                   	ret    

00000444 <open>:
SYSCALL(open)
 444:	b8 0f 00 00 00       	mov    $0xf,%eax
 449:	cd 40                	int    $0x40
 44b:	c3                   	ret    

0000044c <mknod>:
SYSCALL(mknod)
 44c:	b8 11 00 00 00       	mov    $0x11,%eax
 451:	cd 40                	int    $0x40
 453:	c3                   	ret    

00000454 <unlink>:
SYSCALL(unlink)
 454:	b8 12 00 00 00       	mov    $0x12,%eax
 459:	cd 40                	int    $0x40
 45b:	c3                   	ret    

0000045c <fstat>:
SYSCALL(fstat)
 45c:	b8 08 00 00 00       	mov    $0x8,%eax
 461:	cd 40                	int    $0x40
 463:	c3                   	ret    

00000464 <link>:
SYSCALL(link)
 464:	b8 13 00 00 00       	mov    $0x13,%eax
 469:	cd 40                	int    $0x40
 46b:	c3                   	ret    

0000046c <mkdir>:
SYSCALL(mkdir)
 46c:	b8 14 00 00 00       	mov    $0x14,%eax
 471:	cd 40                	int    $0x40
 473:	c3                   	ret    

00000474 <mksfdir>:
SYSCALL(mksfdir)
 474:	b8 16 00 00 00       	mov    $0x16,%eax
 479:	cd 40                	int    $0x40
 47b:	c3                   	ret    

0000047c <chdir>:
SYSCALL(chdir)
 47c:	b8 09 00 00 00       	mov    $0x9,%eax
 481:	cd 40                	int    $0x40
 483:	c3                   	ret    

00000484 <dup>:
SYSCALL(dup)
 484:	b8 0a 00 00 00       	mov    $0xa,%eax
 489:	cd 40                	int    $0x40
 48b:	c3                   	ret    

0000048c <getpid>:
SYSCALL(getpid)
 48c:	b8 0b 00 00 00       	mov    $0xb,%eax
 491:	cd 40                	int    $0x40
 493:	c3                   	ret    

00000494 <sbrk>:
SYSCALL(sbrk)
 494:	b8 0c 00 00 00       	mov    $0xc,%eax
 499:	cd 40                	int    $0x40
 49b:	c3                   	ret    

0000049c <sleep>:
SYSCALL(sleep)
 49c:	b8 0d 00 00 00       	mov    $0xd,%eax
 4a1:	cd 40                	int    $0x40
 4a3:	c3                   	ret    

000004a4 <uptime>:
SYSCALL(uptime)
 4a4:	b8 0e 00 00 00       	mov    $0xe,%eax
 4a9:	cd 40                	int    $0x40
 4ab:	c3                   	ret    
 4ac:	90                   	nop
 4ad:	90                   	nop
 4ae:	90                   	nop
 4af:	90                   	nop

000004b0 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 4b0:	55                   	push   %ebp
 4b1:	89 e5                	mov    %esp,%ebp
 4b3:	83 ec 28             	sub    $0x28,%esp
 4b6:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 4b9:	8d 55 f4             	lea    -0xc(%ebp),%edx
 4bc:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4c3:	00 
 4c4:	89 54 24 04          	mov    %edx,0x4(%esp)
 4c8:	89 04 24             	mov    %eax,(%esp)
 4cb:	e8 54 ff ff ff       	call   424 <write>
}
 4d0:	c9                   	leave  
 4d1:	c3                   	ret    
 4d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000004e0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4e0:	55                   	push   %ebp
 4e1:	89 e5                	mov    %esp,%ebp
 4e3:	57                   	push   %edi
 4e4:	56                   	push   %esi
 4e5:	89 c6                	mov    %eax,%esi
 4e7:	53                   	push   %ebx
 4e8:	83 ec 1c             	sub    $0x1c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4eb:	8b 45 08             	mov    0x8(%ebp),%eax
 4ee:	85 c0                	test   %eax,%eax
 4f0:	74 5e                	je     550 <printint+0x70>
 4f2:	89 d0                	mov    %edx,%eax
 4f4:	c1 e8 1f             	shr    $0x1f,%eax
 4f7:	84 c0                	test   %al,%al
 4f9:	74 55                	je     550 <printint+0x70>
    neg = 1;
    x = -xx;
 4fb:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 4fd:	bf 01 00 00 00       	mov    $0x1,%edi
    x = -xx;
 502:	f7 d8                	neg    %eax
  } else {
    x = xx;
  }

  i = 0;
 504:	31 db                	xor    %ebx,%ebx
 506:	eb 02                	jmp    50a <printint+0x2a>
  do{
    buf[i++] = digits[x % base];
 508:	89 d3                	mov    %edx,%ebx
 50a:	31 d2                	xor    %edx,%edx
 50c:	f7 f1                	div    %ecx
 50e:	0f b6 92 47 09 00 00 	movzbl 0x947(%edx),%edx
  }while((x /= base) != 0);
 515:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 517:	88 54 1d d8          	mov    %dl,-0x28(%ebp,%ebx,1)
 51b:	8d 53 01             	lea    0x1(%ebx),%edx
  }while((x /= base) != 0);
 51e:	75 e8                	jne    508 <printint+0x28>
  if(neg)
 520:	85 ff                	test   %edi,%edi
 522:	74 08                	je     52c <printint+0x4c>
    buf[i++] = '-';
 524:	c6 44 15 d8 2d       	movb   $0x2d,-0x28(%ebp,%edx,1)
 529:	8d 53 02             	lea    0x2(%ebx),%edx

  while(--i >= 0)
 52c:	8d 5a ff             	lea    -0x1(%edx),%ebx
 52f:	90                   	nop
    putc(fd, buf[i]);
 530:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
 535:	89 f0                	mov    %esi,%eax
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 537:	83 eb 01             	sub    $0x1,%ebx
    putc(fd, buf[i]);
 53a:	e8 71 ff ff ff       	call   4b0 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 53f:	83 fb ff             	cmp    $0xffffffff,%ebx
 542:	75 ec                	jne    530 <printint+0x50>
    putc(fd, buf[i]);
}
 544:	83 c4 1c             	add    $0x1c,%esp
 547:	5b                   	pop    %ebx
 548:	5e                   	pop    %esi
 549:	5f                   	pop    %edi
 54a:	5d                   	pop    %ebp
 54b:	c3                   	ret    
 54c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 550:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 552:	31 ff                	xor    %edi,%edi
 554:	eb ae                	jmp    504 <printint+0x24>
 556:	8d 76 00             	lea    0x0(%esi),%esi
 559:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000560 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 560:	55                   	push   %ebp
 561:	89 e5                	mov    %esp,%ebp
 563:	57                   	push   %edi
 564:	56                   	push   %esi
 565:	53                   	push   %ebx
 566:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 569:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 56c:	0f b6 0b             	movzbl (%ebx),%ecx
 56f:	84 c9                	test   %cl,%cl
 571:	0f 84 89 00 00 00    	je     600 <printf+0xa0>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 577:	8d 45 10             	lea    0x10(%ebp),%eax
{
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 57a:	31 f6                	xor    %esi,%esi
  ap = (uint*)(void*)&fmt + 1;
 57c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 57f:	eb 21                	jmp    5a2 <printf+0x42>
 581:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 588:	83 f9 25             	cmp    $0x25,%ecx
 58b:	74 7b                	je     608 <printf+0xa8>
        state = '%';
      } else {
        putc(fd, c);
 58d:	8b 45 08             	mov    0x8(%ebp),%eax
 590:	0f be d1             	movsbl %cl,%edx
 593:	e8 18 ff ff ff       	call   4b0 <putc>
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 598:	83 c3 01             	add    $0x1,%ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 59b:	0f b6 0b             	movzbl (%ebx),%ecx
 59e:	84 c9                	test   %cl,%cl
 5a0:	74 5e                	je     600 <printf+0xa0>
    c = fmt[i] & 0xff;
    if(state == 0){
 5a2:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 5a4:	0f b6 c9             	movzbl %cl,%ecx
    if(state == 0){
 5a7:	74 df                	je     588 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 5a9:	83 fe 25             	cmp    $0x25,%esi
 5ac:	75 ea                	jne    598 <printf+0x38>
      if(c == 'd'){
 5ae:	83 f9 64             	cmp    $0x64,%ecx
 5b1:	0f 84 c9 00 00 00    	je     680 <printf+0x120>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 5b7:	83 f9 70             	cmp    $0x70,%ecx
 5ba:	74 54                	je     610 <printf+0xb0>
 5bc:	83 f9 78             	cmp    $0x78,%ecx
 5bf:	90                   	nop
 5c0:	74 4e                	je     610 <printf+0xb0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 5c2:	83 f9 73             	cmp    $0x73,%ecx
 5c5:	74 71                	je     638 <printf+0xd8>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5c7:	83 f9 63             	cmp    $0x63,%ecx
 5ca:	0f 84 d2 00 00 00    	je     6a2 <printf+0x142>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 5d0:	83 f9 25             	cmp    $0x25,%ecx
        putc(fd, c);
 5d3:	ba 25 00 00 00       	mov    $0x25,%edx
 5d8:	8b 45 08             	mov    0x8(%ebp),%eax
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 5db:	74 11                	je     5ee <printf+0x8e>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5dd:	89 4d e0             	mov    %ecx,-0x20(%ebp)
 5e0:	e8 cb fe ff ff       	call   4b0 <putc>
        putc(fd, c);
 5e5:	8b 4d e0             	mov    -0x20(%ebp),%ecx
 5e8:	8b 45 08             	mov    0x8(%ebp),%eax
 5eb:	0f be d1             	movsbl %cl,%edx
 5ee:	83 c3 01             	add    $0x1,%ebx
      }
      state = 0;
 5f1:	31 f6                	xor    %esi,%esi
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 5f3:	e8 b8 fe ff ff       	call   4b0 <putc>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5f8:	0f b6 0b             	movzbl (%ebx),%ecx
 5fb:	84 c9                	test   %cl,%cl
 5fd:	75 a3                	jne    5a2 <printf+0x42>
 5ff:	90                   	nop
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 600:	83 c4 2c             	add    $0x2c,%esp
 603:	5b                   	pop    %ebx
 604:	5e                   	pop    %esi
 605:	5f                   	pop    %edi
 606:	5d                   	pop    %ebp
 607:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 608:	be 25 00 00 00       	mov    $0x25,%esi
 60d:	eb 89                	jmp    598 <printf+0x38>
 60f:	90                   	nop
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 610:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 613:	b9 10 00 00 00       	mov    $0x10,%ecx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 618:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 61a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 621:	8b 10                	mov    (%eax),%edx
 623:	8b 45 08             	mov    0x8(%ebp),%eax
 626:	e8 b5 fe ff ff       	call   4e0 <printint>
        ap++;
 62b:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
 62f:	e9 64 ff ff ff       	jmp    598 <printf+0x38>
 634:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 638:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 63b:	8b 38                	mov    (%eax),%edi
        ap++;
 63d:	83 c0 04             	add    $0x4,%eax
 640:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
          s = "(null)";
 643:	b8 40 09 00 00       	mov    $0x940,%eax
 648:	85 ff                	test   %edi,%edi
 64a:	0f 44 f8             	cmove  %eax,%edi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 64d:	31 f6                	xor    %esi,%esi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 64f:	0f b6 17             	movzbl (%edi),%edx
 652:	84 d2                	test   %dl,%dl
 654:	0f 84 3e ff ff ff    	je     598 <printf+0x38>
 65a:	89 de                	mov    %ebx,%esi
 65c:	8b 5d 08             	mov    0x8(%ebp),%ebx
 65f:	90                   	nop
          putc(fd, *s);
 660:	0f be d2             	movsbl %dl,%edx
          s++;
 663:	83 c7 01             	add    $0x1,%edi
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
 666:	89 d8                	mov    %ebx,%eax
 668:	e8 43 fe ff ff       	call   4b0 <putc>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 66d:	0f b6 17             	movzbl (%edi),%edx
 670:	84 d2                	test   %dl,%dl
 672:	75 ec                	jne    660 <printf+0x100>
 674:	89 f3                	mov    %esi,%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 676:	31 f6                	xor    %esi,%esi
 678:	e9 1b ff ff ff       	jmp    598 <printf+0x38>
 67d:	8d 76 00             	lea    0x0(%esi),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 680:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 683:	b1 0a                	mov    $0xa,%cl
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 685:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 688:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 68f:	8b 10                	mov    (%eax),%edx
 691:	8b 45 08             	mov    0x8(%ebp),%eax
 694:	e8 47 fe ff ff       	call   4e0 <printint>
        ap++;
 699:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
 69d:	e9 f6 fe ff ff       	jmp    598 <printf+0x38>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 6a2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 6a5:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 6a7:	0f be 10             	movsbl (%eax),%edx
 6aa:	8b 45 08             	mov    0x8(%ebp),%eax
 6ad:	e8 fe fd ff ff       	call   4b0 <putc>
        ap++;
 6b2:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
 6b6:	e9 dd fe ff ff       	jmp    598 <printf+0x38>
 6bb:	90                   	nop
 6bc:	90                   	nop
 6bd:	90                   	nop
 6be:	90                   	nop
 6bf:	90                   	nop

000006c0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6c0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6c1:	a1 44 0c 00 00       	mov    0xc44,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 6c6:	89 e5                	mov    %esp,%ebp
 6c8:	57                   	push   %edi
 6c9:	56                   	push   %esi
 6ca:	53                   	push   %ebx
 6cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6ce:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 6d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6d8:	39 c8                	cmp    %ecx,%eax
 6da:	8b 10                	mov    (%eax),%edx
 6dc:	73 04                	jae    6e2 <free+0x22>
 6de:	39 d1                	cmp    %edx,%ecx
 6e0:	72 16                	jb     6f8 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6e2:	39 d0                	cmp    %edx,%eax
 6e4:	72 0c                	jb     6f2 <free+0x32>
 6e6:	39 c8                	cmp    %ecx,%eax
 6e8:	72 0e                	jb     6f8 <free+0x38>
 6ea:	39 d1                	cmp    %edx,%ecx
 6ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6f0:	72 06                	jb     6f8 <free+0x38>
static Header base;
static Header *freep;

void
free(void *ap)
{
 6f2:	89 d0                	mov    %edx,%eax
 6f4:	eb e2                	jmp    6d8 <free+0x18>
 6f6:	66 90                	xchg   %ax,%ax

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 6f8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6fb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6fe:	39 d7                	cmp    %edx,%edi
 700:	74 19                	je     71b <free+0x5b>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 702:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 705:	8b 50 04             	mov    0x4(%eax),%edx
 708:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 70b:	39 f1                	cmp    %esi,%ecx
 70d:	74 23                	je     732 <free+0x72>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 70f:	89 08                	mov    %ecx,(%eax)
  freep = p;
 711:	a3 44 0c 00 00       	mov    %eax,0xc44
}
 716:	5b                   	pop    %ebx
 717:	5e                   	pop    %esi
 718:	5f                   	pop    %edi
 719:	5d                   	pop    %ebp
 71a:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 71b:	03 72 04             	add    0x4(%edx),%esi
 71e:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 721:	8b 10                	mov    (%eax),%edx
 723:	8b 12                	mov    (%edx),%edx
 725:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 728:	8b 50 04             	mov    0x4(%eax),%edx
 72b:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 72e:	39 f1                	cmp    %esi,%ecx
 730:	75 dd                	jne    70f <free+0x4f>
    p->s.size += bp->s.size;
 732:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 735:	a3 44 0c 00 00       	mov    %eax,0xc44
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 73a:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 73d:	8b 53 f8             	mov    -0x8(%ebx),%edx
 740:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 742:	5b                   	pop    %ebx
 743:	5e                   	pop    %esi
 744:	5f                   	pop    %edi
 745:	5d                   	pop    %ebp
 746:	c3                   	ret    
 747:	89 f6                	mov    %esi,%esi
 749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000750 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 750:	55                   	push   %ebp
 751:	89 e5                	mov    %esp,%ebp
 753:	57                   	push   %edi
 754:	56                   	push   %esi
 755:	53                   	push   %ebx
 756:	83 ec 2c             	sub    $0x2c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 759:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((prevp = freep) == 0){
 75c:	8b 15 44 0c 00 00    	mov    0xc44,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 762:	83 c3 07             	add    $0x7,%ebx
 765:	c1 eb 03             	shr    $0x3,%ebx
 768:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 76b:	85 d2                	test   %edx,%edx
 76d:	0f 84 a3 00 00 00    	je     816 <malloc+0xc6>
 773:	8b 02                	mov    (%edx),%eax
 775:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 778:	39 d9                	cmp    %ebx,%ecx
 77a:	73 74                	jae    7f0 <malloc+0xa0>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
 77c:	8d 14 dd 00 00 00 00 	lea    0x0(,%ebx,8),%edx
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 783:	bf 00 80 00 00       	mov    $0x8000,%edi
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
 788:	89 55 e4             	mov    %edx,-0x1c(%ebp)
 78b:	eb 0c                	jmp    799 <malloc+0x49>
 78d:	8d 76 00             	lea    0x0(%esi),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 790:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 792:	8b 48 04             	mov    0x4(%eax),%ecx
 795:	39 cb                	cmp    %ecx,%ebx
 797:	76 57                	jbe    7f0 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 799:	3b 05 44 0c 00 00    	cmp    0xc44,%eax
 79f:	89 c2                	mov    %eax,%edx
 7a1:	75 ed                	jne    790 <malloc+0x40>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 7a3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7a6:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
 7ac:	be 00 10 00 00       	mov    $0x1000,%esi
 7b1:	0f 43 f3             	cmovae %ebx,%esi
 7b4:	0f 42 c7             	cmovb  %edi,%eax
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 7b7:	89 04 24             	mov    %eax,(%esp)
 7ba:	e8 d5 fc ff ff       	call   494 <sbrk>
  if(p == (char*)-1)
 7bf:	83 f8 ff             	cmp    $0xffffffff,%eax
 7c2:	74 1c                	je     7e0 <malloc+0x90>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 7c4:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 7c7:	83 c0 08             	add    $0x8,%eax
 7ca:	89 04 24             	mov    %eax,(%esp)
 7cd:	e8 ee fe ff ff       	call   6c0 <free>
  return freep;
 7d2:	8b 15 44 0c 00 00    	mov    0xc44,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 7d8:	85 d2                	test   %edx,%edx
 7da:	75 b4                	jne    790 <malloc+0x40>
 7dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return 0;
  }
}
 7e0:	83 c4 2c             	add    $0x2c,%esp
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
 7e3:	31 c0                	xor    %eax,%eax
  }
}
 7e5:	5b                   	pop    %ebx
 7e6:	5e                   	pop    %esi
 7e7:	5f                   	pop    %edi
 7e8:	5d                   	pop    %ebp
 7e9:	c3                   	ret    
 7ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 7f0:	39 cb                	cmp    %ecx,%ebx
 7f2:	74 1c                	je     810 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 7f4:	29 d9                	sub    %ebx,%ecx
 7f6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 7f9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 7fc:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 7ff:	89 15 44 0c 00 00    	mov    %edx,0xc44
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 805:	83 c4 2c             	add    $0x2c,%esp
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
 808:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 80b:	5b                   	pop    %ebx
 80c:	5e                   	pop    %esi
 80d:	5f                   	pop    %edi
 80e:	5d                   	pop    %ebp
 80f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 810:	8b 08                	mov    (%eax),%ecx
 812:	89 0a                	mov    %ecx,(%edx)
 814:	eb e9                	jmp    7ff <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 816:	c7 05 44 0c 00 00 48 	movl   $0xc48,0xc44
 81d:	0c 00 00 
    base.s.size = 0;
 820:	b8 48 0c 00 00       	mov    $0xc48,%eax
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 825:	c7 05 48 0c 00 00 48 	movl   $0xc48,0xc48
 82c:	0c 00 00 
    base.s.size = 0;
 82f:	c7 05 4c 0c 00 00 00 	movl   $0x0,0xc4c
 836:	00 00 00 
 839:	e9 3e ff ff ff       	jmp    77c <malloc+0x2c>
