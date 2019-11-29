
_normalfile_test:     file format elf32-i386


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
    creating();
   6:	e8 15 00 00 00       	call   20 <creating>
    loading();
   b:	e8 c0 00 00 00       	call   d0 <loading>
    exit();
  10:	e8 bf 03 00 00       	call   3d4 <exit>
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
    fd = open("normalfile", O_CREATE | O_RDWR);
  27:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
  2e:	00 
  2f:	c7 04 24 10 08 00 00 	movl   $0x810,(%esp)
  36:	e8 d9 03 00 00       	call   414 <open>

    if(fd >= 0) {
  3b:	85 c0                	test   %eax,%eax
#include "user.h"
#include "fcntl.h"

void creating(void){
    int fd;
    fd = open("normalfile", O_CREATE | O_RDWR);
  3d:	89 c3                	mov    %eax,%ebx

    if(fd >= 0) {
  3f:	78 55                	js     96 <creating+0x76>
        printf(1, "Normal File Created Successfully\n");
  41:	c7 44 24 04 2c 08 00 	movl   $0x82c,0x4(%esp)
  48:	00 
  49:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  50:	e8 db 04 00 00       	call   530 <printf>
    } else {
        printf(1, "Error: Normal File Failed to Create\n");
        exit();
    }
   
    if(write(fd, "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent maximus ullamcorper scelerisque. Sed non convallis quam. Fusce eleifend vulputate viverra. Sed dui tortor, finibus ut turpis eu, imperdiet feugiat nulla. Nunc at ullamcorper nunc. Vivamus eu iaculis ipsum. Quisque placerat enim vitae nisi mollis, eget ultricies massa convallis. Pellentesque ac tortor quis ante euismod dapibus malesuada a nisi. Donec malesuada nulla dui, in consectetur justo consequat ac. Integer nisl.", 487) != 487){
  55:	c7 44 24 08 e7 01 00 	movl   $0x1e7,0x8(%esp)
  5c:	00 
  5d:	c7 44 24 04 50 08 00 	movl   $0x850,0x4(%esp)
  64:	00 
  65:	89 1c 24             	mov    %ebx,(%esp)
  68:	e8 87 03 00 00       	call   3f4 <write>
  6d:	3d e7 01 00 00       	cmp    $0x1e7,%eax
  72:	75 3b                	jne    af <creating+0x8f>
        printf(1, "error: write to ordinary file failed\n");
        exit();
    }

    printf(1, "Successfully Written to Normal File\n");
  74:	c7 44 24 04 88 0a 00 	movl   $0xa88,0x4(%esp)
  7b:	00 
  7c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  83:	e8 a8 04 00 00       	call   530 <printf>
    close(fd);
  88:	89 1c 24             	mov    %ebx,(%esp)
  8b:	e8 6c 03 00 00       	call   3fc <close>
}
  90:	83 c4 14             	add    $0x14,%esp
  93:	5b                   	pop    %ebx
  94:	5d                   	pop    %ebp
  95:	c3                   	ret    
    fd = open("normalfile", O_CREATE | O_RDWR);

    if(fd >= 0) {
        printf(1, "Normal File Created Successfully\n");
    } else {
        printf(1, "Error: Normal File Failed to Create\n");
  96:	c7 44 24 04 38 0a 00 	movl   $0xa38,0x4(%esp)
  9d:	00 
  9e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  a5:	e8 86 04 00 00       	call   530 <printf>
        exit();
  aa:	e8 25 03 00 00       	call   3d4 <exit>
    }
   
    if(write(fd, "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent maximus ullamcorper scelerisque. Sed non convallis quam. Fusce eleifend vulputate viverra. Sed dui tortor, finibus ut turpis eu, imperdiet feugiat nulla. Nunc at ullamcorper nunc. Vivamus eu iaculis ipsum. Quisque placerat enim vitae nisi mollis, eget ultricies massa convallis. Pellentesque ac tortor quis ante euismod dapibus malesuada a nisi. Donec malesuada nulla dui, in consectetur justo consequat ac. Integer nisl.", 487) != 487){
        printf(1, "error: write to ordinary file failed\n");
  af:	c7 44 24 04 60 0a 00 	movl   $0xa60,0x4(%esp)
  b6:	00 
  b7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  be:	e8 6d 04 00 00       	call   530 <printf>
        exit();
  c3:	e8 0c 03 00 00       	call   3d4 <exit>
  c8:	90                   	nop
  c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000000d0 <loading>:

    printf(1, "Successfully Written to Normal File\n");
    close(fd);
}

void loading(void){
  d0:	55                   	push   %ebp
  d1:	89 e5                	mov    %esp,%ebp
  d3:	56                   	push   %esi
  d4:	53                   	push   %ebx
  d5:	81 ec 10 02 00 00    	sub    $0x210,%esp
    int fd;
    char buf[512];
    fd = open("normalfile", O_RDONLY);
  db:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
  e2:	00 
  e3:	c7 04 24 10 08 00 00 	movl   $0x810,(%esp)
  ea:	e8 25 03 00 00       	call   414 <open>

    if(fd >= 0) {
  ef:	85 c0                	test   %eax,%eax
}

void loading(void){
    int fd;
    char buf[512];
    fd = open("normalfile", O_RDONLY);
  f1:	89 c3                	mov    %eax,%ebx

    if(fd >= 0) {
  f3:	78 73                	js     168 <loading+0x98>
    } else {
        printf(1, "Error: Normal File Failed to Load\n");
        exit();
    }

    if (read(fd, buf, 487) != 487) {
  f5:	8d b5 f8 fd ff ff    	lea    -0x208(%ebp),%esi
    int fd;
    char buf[512];
    fd = open("normalfile", O_RDONLY);

    if(fd >= 0) {
        printf(1, "Normal File Loaded Successfully\n");
  fb:	c7 44 24 04 b0 0a 00 	movl   $0xab0,0x4(%esp)
 102:	00 
 103:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 10a:	e8 21 04 00 00       	call   530 <printf>
    } else {
        printf(1, "Error: Normal File Failed to Load\n");
        exit();
    }

    if (read(fd, buf, 487) != 487) {
 10f:	c7 44 24 08 e7 01 00 	movl   $0x1e7,0x8(%esp)
 116:	00 
 117:	89 74 24 04          	mov    %esi,0x4(%esp)
 11b:	89 1c 24             	mov    %ebx,(%esp)
 11e:	e8 c9 02 00 00       	call   3ec <read>
 123:	3d e7 01 00 00       	cmp    $0x1e7,%eax
 128:	75 57                	jne    181 <loading+0xb1>
        printf(1, "Error: Failed to Read from Normal File\n");
        exit();
    }
    
    printf(1, "Contents: %s\n", buf);
 12a:	89 74 24 08          	mov    %esi,0x8(%esp)
 12e:	c7 44 24 04 1b 08 00 	movl   $0x81b,0x4(%esp)
 135:	00 
 136:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 13d:	e8 ee 03 00 00       	call   530 <printf>
    printf(1, "Normal File Successfully Loaded and Read\n");
 142:	c7 44 24 04 20 0b 00 	movl   $0xb20,0x4(%esp)
 149:	00 
 14a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 151:	e8 da 03 00 00       	call   530 <printf>
    close(fd);
 156:	89 1c 24             	mov    %ebx,(%esp)
 159:	e8 9e 02 00 00       	call   3fc <close>
}
 15e:	81 c4 10 02 00 00    	add    $0x210,%esp
 164:	5b                   	pop    %ebx
 165:	5e                   	pop    %esi
 166:	5d                   	pop    %ebp
 167:	c3                   	ret    
    fd = open("normalfile", O_RDONLY);

    if(fd >= 0) {
        printf(1, "Normal File Loaded Successfully\n");
    } else {
        printf(1, "Error: Normal File Failed to Load\n");
 168:	c7 44 24 04 d4 0a 00 	movl   $0xad4,0x4(%esp)
 16f:	00 
 170:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 177:	e8 b4 03 00 00       	call   530 <printf>
        exit();
 17c:	e8 53 02 00 00       	call   3d4 <exit>
    }

    if (read(fd, buf, 487) != 487) {
        printf(1, "Error: Failed to Read from Normal File\n");
 181:	c7 44 24 04 f8 0a 00 	movl   $0xaf8,0x4(%esp)
 188:	00 
 189:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 190:	e8 9b 03 00 00       	call   530 <printf>
        exit();
 195:	e8 3a 02 00 00       	call   3d4 <exit>
 19a:	90                   	nop
 19b:	90                   	nop
 19c:	90                   	nop
 19d:	90                   	nop
 19e:	90                   	nop
 19f:	90                   	nop

000001a0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 1a0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1a1:	31 d2                	xor    %edx,%edx
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 1a3:	89 e5                	mov    %esp,%ebp
 1a5:	8b 45 08             	mov    0x8(%ebp),%eax
 1a8:	53                   	push   %ebx
 1a9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 1ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1b0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
 1b4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 1b7:	83 c2 01             	add    $0x1,%edx
 1ba:	84 c9                	test   %cl,%cl
 1bc:	75 f2                	jne    1b0 <strcpy+0x10>
    ;
  return os;
}
 1be:	5b                   	pop    %ebx
 1bf:	5d                   	pop    %ebp
 1c0:	c3                   	ret    
 1c1:	eb 0d                	jmp    1d0 <strcmp>
 1c3:	90                   	nop
 1c4:	90                   	nop
 1c5:	90                   	nop
 1c6:	90                   	nop
 1c7:	90                   	nop
 1c8:	90                   	nop
 1c9:	90                   	nop
 1ca:	90                   	nop
 1cb:	90                   	nop
 1cc:	90                   	nop
 1cd:	90                   	nop
 1ce:	90                   	nop
 1cf:	90                   	nop

000001d0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1d6:	56                   	push   %esi
 1d7:	8b 55 0c             	mov    0xc(%ebp),%edx
 1da:	53                   	push   %ebx
  while(*p && *p == *q)
 1db:	0f b6 01             	movzbl (%ecx),%eax
 1de:	0f b6 1a             	movzbl (%edx),%ebx
 1e1:	84 c0                	test   %al,%al
 1e3:	74 23                	je     208 <strcmp+0x38>
 1e5:	38 d8                	cmp    %bl,%al
 1e7:	74 10                	je     1f9 <strcmp+0x29>
 1e9:	eb 2d                	jmp    218 <strcmp+0x48>
 1eb:	90                   	nop
 1ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1f0:	83 c1 01             	add    $0x1,%ecx
 1f3:	38 d8                	cmp    %bl,%al
 1f5:	75 21                	jne    218 <strcmp+0x48>
    p++, q++;
 1f7:	89 f2                	mov    %esi,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1f9:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 1fd:	8d 72 01             	lea    0x1(%edx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 200:	0f b6 5a 01          	movzbl 0x1(%edx),%ebx
 204:	84 c0                	test   %al,%al
 206:	75 e8                	jne    1f0 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 208:	0f b6 db             	movzbl %bl,%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 20b:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 20d:	29 d8                	sub    %ebx,%eax
}
 20f:	5b                   	pop    %ebx
 210:	5e                   	pop    %esi
 211:	5d                   	pop    %ebp
 212:	c3                   	ret    
 213:	90                   	nop
 214:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    p++, q++;
  return (uchar)*p - (uchar)*q;
 218:	0f b6 db             	movzbl %bl,%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 21b:	0f b6 c0             	movzbl %al,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 21e:	29 d8                	sub    %ebx,%eax
}
 220:	5b                   	pop    %ebx
 221:	5e                   	pop    %esi
 222:	5d                   	pop    %ebp
 223:	c3                   	ret    
 224:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 22a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000230 <strlen>:

uint
strlen(const char *s)
{
 230:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
 231:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}

uint
strlen(const char *s)
{
 233:	89 e5                	mov    %esp,%ebp
 235:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 238:	80 39 00             	cmpb   $0x0,(%ecx)
 23b:	74 0e                	je     24b <strlen+0x1b>
 23d:	31 d2                	xor    %edx,%edx
 23f:	90                   	nop
 240:	83 c2 01             	add    $0x1,%edx
 243:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 247:	89 d0                	mov    %edx,%eax
 249:	75 f5                	jne    240 <strlen+0x10>
    ;
  return n;
}
 24b:	5d                   	pop    %ebp
 24c:	c3                   	ret    
 24d:	8d 76 00             	lea    0x0(%esi),%esi

00000250 <memset>:

void*
memset(void *dst, int c, uint n)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	8b 55 08             	mov    0x8(%ebp),%edx
 256:	57                   	push   %edi
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 257:	8b 4d 10             	mov    0x10(%ebp),%ecx
 25a:	8b 45 0c             	mov    0xc(%ebp),%eax
 25d:	89 d7                	mov    %edx,%edi
 25f:	fc                   	cld    
 260:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 262:	89 d0                	mov    %edx,%eax
 264:	5f                   	pop    %edi
 265:	5d                   	pop    %ebp
 266:	c3                   	ret    
 267:	89 f6                	mov    %esi,%esi
 269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000270 <strchr>:

char*
strchr(const char *s, char c)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	8b 45 08             	mov    0x8(%ebp),%eax
 276:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 27a:	0f b6 10             	movzbl (%eax),%edx
 27d:	84 d2                	test   %dl,%dl
 27f:	75 12                	jne    293 <strchr+0x23>
 281:	eb 1d                	jmp    2a0 <strchr+0x30>
 283:	90                   	nop
 284:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 288:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 28c:	84 d2                	test   %dl,%dl
 28e:	74 10                	je     2a0 <strchr+0x30>
 290:	83 c0 01             	add    $0x1,%eax
    if(*s == c)
 293:	38 ca                	cmp    %cl,%dl
 295:	75 f1                	jne    288 <strchr+0x18>
      return (char*)s;
  return 0;
}
 297:	5d                   	pop    %ebp
 298:	c3                   	ret    
 299:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
strchr(const char *s, char c)
{
  for(; *s; s++)
    if(*s == c)
      return (char*)s;
  return 0;
 2a0:	31 c0                	xor    %eax,%eax
}
 2a2:	5d                   	pop    %ebp
 2a3:	c3                   	ret    
 2a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 2aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000002b0 <gets>:

char*
gets(char *buf, int max)
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	57                   	push   %edi
 2b4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2b5:	31 f6                	xor    %esi,%esi
  return 0;
}

char*
gets(char *buf, int max)
{
 2b7:	53                   	push   %ebx
 2b8:	83 ec 2c             	sub    $0x2c,%esp
 2bb:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2be:	eb 31                	jmp    2f1 <gets+0x41>
    cc = read(0, &c, 1);
 2c0:	8d 45 e7             	lea    -0x19(%ebp),%eax
 2c3:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 2ca:	00 
 2cb:	89 44 24 04          	mov    %eax,0x4(%esp)
 2cf:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 2d6:	e8 11 01 00 00       	call   3ec <read>
    if(cc < 1)
 2db:	85 c0                	test   %eax,%eax
 2dd:	7e 1a                	jle    2f9 <gets+0x49>
      break;
    buf[i++] = c;
 2df:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2e3:	89 de                	mov    %ebx,%esi
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 2e5:	3c 0d                	cmp    $0xd,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 2e7:	88 44 1f ff          	mov    %al,-0x1(%edi,%ebx,1)
    if(c == '\n' || c == '\r')
 2eb:	74 0c                	je     2f9 <gets+0x49>
 2ed:	3c 0a                	cmp    $0xa,%al
 2ef:	74 08                	je     2f9 <gets+0x49>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2f1:	8d 5e 01             	lea    0x1(%esi),%ebx
 2f4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 2f7:	7c c7                	jl     2c0 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 2f9:	c6 04 37 00          	movb   $0x0,(%edi,%esi,1)
  return buf;
}
 2fd:	83 c4 2c             	add    $0x2c,%esp
 300:	89 f8                	mov    %edi,%eax
 302:	5b                   	pop    %ebx
 303:	5e                   	pop    %esi
 304:	5f                   	pop    %edi
 305:	5d                   	pop    %ebp
 306:	c3                   	ret    
 307:	89 f6                	mov    %esi,%esi
 309:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000310 <stat>:

int
stat(const char *n, struct stat *st)
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 316:	8b 45 08             	mov    0x8(%ebp),%eax
  return buf;
}

int
stat(const char *n, struct stat *st)
{
 319:	89 5d f8             	mov    %ebx,-0x8(%ebp)
 31c:	89 75 fc             	mov    %esi,-0x4(%ebp)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 31f:	be ff ff ff ff       	mov    $0xffffffff,%esi
stat(const char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 324:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 32b:	00 
 32c:	89 04 24             	mov    %eax,(%esp)
 32f:	e8 e0 00 00 00       	call   414 <open>
  if(fd < 0)
 334:	85 c0                	test   %eax,%eax
stat(const char *n, struct stat *st)
{
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 336:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 338:	78 19                	js     353 <stat+0x43>
    return -1;
  r = fstat(fd, st);
 33a:	8b 45 0c             	mov    0xc(%ebp),%eax
 33d:	89 1c 24             	mov    %ebx,(%esp)
 340:	89 44 24 04          	mov    %eax,0x4(%esp)
 344:	e8 e3 00 00 00       	call   42c <fstat>
  close(fd);
 349:	89 1c 24             	mov    %ebx,(%esp)
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
  r = fstat(fd, st);
 34c:	89 c6                	mov    %eax,%esi
  close(fd);
 34e:	e8 a9 00 00 00       	call   3fc <close>
  return r;
}
 353:	89 f0                	mov    %esi,%eax
 355:	8b 5d f8             	mov    -0x8(%ebp),%ebx
 358:	8b 75 fc             	mov    -0x4(%ebp),%esi
 35b:	89 ec                	mov    %ebp,%esp
 35d:	5d                   	pop    %ebp
 35e:	c3                   	ret    
 35f:	90                   	nop

00000360 <atoi>:

int
atoi(const char *s)
{
 360:	55                   	push   %ebp
  int n;

  n = 0;
 361:	31 c0                	xor    %eax,%eax
  return r;
}

int
atoi(const char *s)
{
 363:	89 e5                	mov    %esp,%ebp
 365:	8b 4d 08             	mov    0x8(%ebp),%ecx
 368:	53                   	push   %ebx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 369:	0f b6 11             	movzbl (%ecx),%edx
 36c:	8d 5a d0             	lea    -0x30(%edx),%ebx
 36f:	80 fb 09             	cmp    $0x9,%bl
 372:	77 1c                	ja     390 <atoi+0x30>
 374:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    n = n*10 + *s++ - '0';
 378:	0f be d2             	movsbl %dl,%edx
 37b:	83 c1 01             	add    $0x1,%ecx
 37e:	8d 04 80             	lea    (%eax,%eax,4),%eax
 381:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 385:	0f b6 11             	movzbl (%ecx),%edx
 388:	8d 5a d0             	lea    -0x30(%edx),%ebx
 38b:	80 fb 09             	cmp    $0x9,%bl
 38e:	76 e8                	jbe    378 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 390:	5b                   	pop    %ebx
 391:	5d                   	pop    %ebp
 392:	c3                   	ret    
 393:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 399:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003a0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	56                   	push   %esi
 3a4:	8b 45 08             	mov    0x8(%ebp),%eax
 3a7:	53                   	push   %ebx
 3a8:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3ab:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3ae:	85 db                	test   %ebx,%ebx
 3b0:	7e 14                	jle    3c6 <memmove+0x26>
    n = n*10 + *s++ - '0';
  return n;
}

void*
memmove(void *vdst, const void *vsrc, int n)
 3b2:	31 d2                	xor    %edx,%edx
 3b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    *dst++ = *src++;
 3b8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 3bc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 3bf:	83 c2 01             	add    $0x1,%edx
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3c2:	39 da                	cmp    %ebx,%edx
 3c4:	75 f2                	jne    3b8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 3c6:	5b                   	pop    %ebx
 3c7:	5e                   	pop    %esi
 3c8:	5d                   	pop    %ebp
 3c9:	c3                   	ret    
 3ca:	90                   	nop
 3cb:	90                   	nop

000003cc <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3cc:	b8 01 00 00 00       	mov    $0x1,%eax
 3d1:	cd 40                	int    $0x40
 3d3:	c3                   	ret    

000003d4 <exit>:
SYSCALL(exit)
 3d4:	b8 02 00 00 00       	mov    $0x2,%eax
 3d9:	cd 40                	int    $0x40
 3db:	c3                   	ret    

000003dc <wait>:
SYSCALL(wait)
 3dc:	b8 03 00 00 00       	mov    $0x3,%eax
 3e1:	cd 40                	int    $0x40
 3e3:	c3                   	ret    

000003e4 <pipe>:
SYSCALL(pipe)
 3e4:	b8 04 00 00 00       	mov    $0x4,%eax
 3e9:	cd 40                	int    $0x40
 3eb:	c3                   	ret    

000003ec <read>:
SYSCALL(read)
 3ec:	b8 05 00 00 00       	mov    $0x5,%eax
 3f1:	cd 40                	int    $0x40
 3f3:	c3                   	ret    

000003f4 <write>:
SYSCALL(write)
 3f4:	b8 10 00 00 00       	mov    $0x10,%eax
 3f9:	cd 40                	int    $0x40
 3fb:	c3                   	ret    

000003fc <close>:
SYSCALL(close)
 3fc:	b8 15 00 00 00       	mov    $0x15,%eax
 401:	cd 40                	int    $0x40
 403:	c3                   	ret    

00000404 <kill>:
SYSCALL(kill)
 404:	b8 06 00 00 00       	mov    $0x6,%eax
 409:	cd 40                	int    $0x40
 40b:	c3                   	ret    

0000040c <exec>:
SYSCALL(exec)
 40c:	b8 07 00 00 00       	mov    $0x7,%eax
 411:	cd 40                	int    $0x40
 413:	c3                   	ret    

00000414 <open>:
SYSCALL(open)
 414:	b8 0f 00 00 00       	mov    $0xf,%eax
 419:	cd 40                	int    $0x40
 41b:	c3                   	ret    

0000041c <mknod>:
SYSCALL(mknod)
 41c:	b8 11 00 00 00       	mov    $0x11,%eax
 421:	cd 40                	int    $0x40
 423:	c3                   	ret    

00000424 <unlink>:
SYSCALL(unlink)
 424:	b8 12 00 00 00       	mov    $0x12,%eax
 429:	cd 40                	int    $0x40
 42b:	c3                   	ret    

0000042c <fstat>:
SYSCALL(fstat)
 42c:	b8 08 00 00 00       	mov    $0x8,%eax
 431:	cd 40                	int    $0x40
 433:	c3                   	ret    

00000434 <link>:
SYSCALL(link)
 434:	b8 13 00 00 00       	mov    $0x13,%eax
 439:	cd 40                	int    $0x40
 43b:	c3                   	ret    

0000043c <mkdir>:
SYSCALL(mkdir)
 43c:	b8 14 00 00 00       	mov    $0x14,%eax
 441:	cd 40                	int    $0x40
 443:	c3                   	ret    

00000444 <mksfdir>:
SYSCALL(mksfdir)
 444:	b8 16 00 00 00       	mov    $0x16,%eax
 449:	cd 40                	int    $0x40
 44b:	c3                   	ret    

0000044c <chdir>:
SYSCALL(chdir)
 44c:	b8 09 00 00 00       	mov    $0x9,%eax
 451:	cd 40                	int    $0x40
 453:	c3                   	ret    

00000454 <dup>:
SYSCALL(dup)
 454:	b8 0a 00 00 00       	mov    $0xa,%eax
 459:	cd 40                	int    $0x40
 45b:	c3                   	ret    

0000045c <getpid>:
SYSCALL(getpid)
 45c:	b8 0b 00 00 00       	mov    $0xb,%eax
 461:	cd 40                	int    $0x40
 463:	c3                   	ret    

00000464 <sbrk>:
SYSCALL(sbrk)
 464:	b8 0c 00 00 00       	mov    $0xc,%eax
 469:	cd 40                	int    $0x40
 46b:	c3                   	ret    

0000046c <sleep>:
SYSCALL(sleep)
 46c:	b8 0d 00 00 00       	mov    $0xd,%eax
 471:	cd 40                	int    $0x40
 473:	c3                   	ret    

00000474 <uptime>:
SYSCALL(uptime)
 474:	b8 0e 00 00 00       	mov    $0xe,%eax
 479:	cd 40                	int    $0x40
 47b:	c3                   	ret    
 47c:	90                   	nop
 47d:	90                   	nop
 47e:	90                   	nop
 47f:	90                   	nop

00000480 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 480:	55                   	push   %ebp
 481:	89 e5                	mov    %esp,%ebp
 483:	83 ec 28             	sub    $0x28,%esp
 486:	88 55 f4             	mov    %dl,-0xc(%ebp)
  write(fd, &c, 1);
 489:	8d 55 f4             	lea    -0xc(%ebp),%edx
 48c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 493:	00 
 494:	89 54 24 04          	mov    %edx,0x4(%esp)
 498:	89 04 24             	mov    %eax,(%esp)
 49b:	e8 54 ff ff ff       	call   3f4 <write>
}
 4a0:	c9                   	leave  
 4a1:	c3                   	ret    
 4a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000004b0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4b0:	55                   	push   %ebp
 4b1:	89 e5                	mov    %esp,%ebp
 4b3:	57                   	push   %edi
 4b4:	56                   	push   %esi
 4b5:	89 c6                	mov    %eax,%esi
 4b7:	53                   	push   %ebx
 4b8:	83 ec 1c             	sub    $0x1c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 4bb:	8b 45 08             	mov    0x8(%ebp),%eax
 4be:	85 c0                	test   %eax,%eax
 4c0:	74 5e                	je     520 <printint+0x70>
 4c2:	89 d0                	mov    %edx,%eax
 4c4:	c1 e8 1f             	shr    $0x1f,%eax
 4c7:	84 c0                	test   %al,%al
 4c9:	74 55                	je     520 <printint+0x70>
    neg = 1;
    x = -xx;
 4cb:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 4cd:	bf 01 00 00 00       	mov    $0x1,%edi
    x = -xx;
 4d2:	f7 d8                	neg    %eax
  } else {
    x = xx;
  }

  i = 0;
 4d4:	31 db                	xor    %ebx,%ebx
 4d6:	eb 02                	jmp    4da <printint+0x2a>
  do{
    buf[i++] = digits[x % base];
 4d8:	89 d3                	mov    %edx,%ebx
 4da:	31 d2                	xor    %edx,%edx
 4dc:	f7 f1                	div    %ecx
 4de:	0f b6 92 53 0b 00 00 	movzbl 0xb53(%edx),%edx
  }while((x /= base) != 0);
 4e5:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 4e7:	88 54 1d d8          	mov    %dl,-0x28(%ebp,%ebx,1)
 4eb:	8d 53 01             	lea    0x1(%ebx),%edx
  }while((x /= base) != 0);
 4ee:	75 e8                	jne    4d8 <printint+0x28>
  if(neg)
 4f0:	85 ff                	test   %edi,%edi
 4f2:	74 08                	je     4fc <printint+0x4c>
    buf[i++] = '-';
 4f4:	c6 44 15 d8 2d       	movb   $0x2d,-0x28(%ebp,%edx,1)
 4f9:	8d 53 02             	lea    0x2(%ebx),%edx

  while(--i >= 0)
 4fc:	8d 5a ff             	lea    -0x1(%edx),%ebx
 4ff:	90                   	nop
    putc(fd, buf[i]);
 500:	0f be 54 1d d8       	movsbl -0x28(%ebp,%ebx,1),%edx
 505:	89 f0                	mov    %esi,%eax
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 507:	83 eb 01             	sub    $0x1,%ebx
    putc(fd, buf[i]);
 50a:	e8 71 ff ff ff       	call   480 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 50f:	83 fb ff             	cmp    $0xffffffff,%ebx
 512:	75 ec                	jne    500 <printint+0x50>
    putc(fd, buf[i]);
}
 514:	83 c4 1c             	add    $0x1c,%esp
 517:	5b                   	pop    %ebx
 518:	5e                   	pop    %esi
 519:	5f                   	pop    %edi
 51a:	5d                   	pop    %ebp
 51b:	c3                   	ret    
 51c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 520:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 522:	31 ff                	xor    %edi,%edi
 524:	eb ae                	jmp    4d4 <printint+0x24>
 526:	8d 76 00             	lea    0x0(%esi),%esi
 529:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000530 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 530:	55                   	push   %ebp
 531:	89 e5                	mov    %esp,%ebp
 533:	57                   	push   %edi
 534:	56                   	push   %esi
 535:	53                   	push   %ebx
 536:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 539:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 53c:	0f b6 0b             	movzbl (%ebx),%ecx
 53f:	84 c9                	test   %cl,%cl
 541:	0f 84 89 00 00 00    	je     5d0 <printf+0xa0>
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 547:	8d 45 10             	lea    0x10(%ebp),%eax
{
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 54a:	31 f6                	xor    %esi,%esi
  ap = (uint*)(void*)&fmt + 1;
 54c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 54f:	eb 21                	jmp    572 <printf+0x42>
 551:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 558:	83 f9 25             	cmp    $0x25,%ecx
 55b:	74 7b                	je     5d8 <printf+0xa8>
        state = '%';
      } else {
        putc(fd, c);
 55d:	8b 45 08             	mov    0x8(%ebp),%eax
 560:	0f be d1             	movsbl %cl,%edx
 563:	e8 18 ff ff ff       	call   480 <putc>
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 568:	83 c3 01             	add    $0x1,%ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 56b:	0f b6 0b             	movzbl (%ebx),%ecx
 56e:	84 c9                	test   %cl,%cl
 570:	74 5e                	je     5d0 <printf+0xa0>
    c = fmt[i] & 0xff;
    if(state == 0){
 572:	85 f6                	test   %esi,%esi
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 574:	0f b6 c9             	movzbl %cl,%ecx
    if(state == 0){
 577:	74 df                	je     558 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 579:	83 fe 25             	cmp    $0x25,%esi
 57c:	75 ea                	jne    568 <printf+0x38>
      if(c == 'd'){
 57e:	83 f9 64             	cmp    $0x64,%ecx
 581:	0f 84 c9 00 00 00    	je     650 <printf+0x120>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 587:	83 f9 70             	cmp    $0x70,%ecx
 58a:	74 54                	je     5e0 <printf+0xb0>
 58c:	83 f9 78             	cmp    $0x78,%ecx
 58f:	90                   	nop
 590:	74 4e                	je     5e0 <printf+0xb0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 592:	83 f9 73             	cmp    $0x73,%ecx
 595:	74 71                	je     608 <printf+0xd8>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 597:	83 f9 63             	cmp    $0x63,%ecx
 59a:	0f 84 d2 00 00 00    	je     672 <printf+0x142>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 5a0:	83 f9 25             	cmp    $0x25,%ecx
        putc(fd, c);
 5a3:	ba 25 00 00 00       	mov    $0x25,%edx
 5a8:	8b 45 08             	mov    0x8(%ebp),%eax
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 5ab:	74 11                	je     5be <printf+0x8e>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5ad:	89 4d e0             	mov    %ecx,-0x20(%ebp)
 5b0:	e8 cb fe ff ff       	call   480 <putc>
        putc(fd, c);
 5b5:	8b 4d e0             	mov    -0x20(%ebp),%ecx
 5b8:	8b 45 08             	mov    0x8(%ebp),%eax
 5bb:	0f be d1             	movsbl %cl,%edx
 5be:	83 c3 01             	add    $0x1,%ebx
      }
      state = 0;
 5c1:	31 f6                	xor    %esi,%esi
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 5c3:	e8 b8 fe ff ff       	call   480 <putc>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5c8:	0f b6 0b             	movzbl (%ebx),%ecx
 5cb:	84 c9                	test   %cl,%cl
 5cd:	75 a3                	jne    572 <printf+0x42>
 5cf:	90                   	nop
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5d0:	83 c4 2c             	add    $0x2c,%esp
 5d3:	5b                   	pop    %ebx
 5d4:	5e                   	pop    %esi
 5d5:	5f                   	pop    %edi
 5d6:	5d                   	pop    %ebp
 5d7:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 5d8:	be 25 00 00 00       	mov    $0x25,%esi
 5dd:	eb 89                	jmp    568 <printf+0x38>
 5df:	90                   	nop
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 5e0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5e3:	b9 10 00 00 00       	mov    $0x10,%ecx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 5e8:	31 f6                	xor    %esi,%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 5ea:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 5f1:	8b 10                	mov    (%eax),%edx
 5f3:	8b 45 08             	mov    0x8(%ebp),%eax
 5f6:	e8 b5 fe ff ff       	call   4b0 <printint>
        ap++;
 5fb:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
 5ff:	e9 64 ff ff ff       	jmp    568 <printf+0x38>
 604:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 608:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 60b:	8b 38                	mov    (%eax),%edi
        ap++;
 60d:	83 c0 04             	add    $0x4,%eax
 610:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        if(s == 0)
          s = "(null)";
 613:	b8 4c 0b 00 00       	mov    $0xb4c,%eax
 618:	85 ff                	test   %edi,%edi
 61a:	0f 44 f8             	cmove  %eax,%edi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 61d:	31 f6                	xor    %esi,%esi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 61f:	0f b6 17             	movzbl (%edi),%edx
 622:	84 d2                	test   %dl,%dl
 624:	0f 84 3e ff ff ff    	je     568 <printf+0x38>
 62a:	89 de                	mov    %ebx,%esi
 62c:	8b 5d 08             	mov    0x8(%ebp),%ebx
 62f:	90                   	nop
          putc(fd, *s);
 630:	0f be d2             	movsbl %dl,%edx
          s++;
 633:	83 c7 01             	add    $0x1,%edi
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
 636:	89 d8                	mov    %ebx,%eax
 638:	e8 43 fe ff ff       	call   480 <putc>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 63d:	0f b6 17             	movzbl (%edi),%edx
 640:	84 d2                	test   %dl,%dl
 642:	75 ec                	jne    630 <printf+0x100>
 644:	89 f3                	mov    %esi,%ebx
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 646:	31 f6                	xor    %esi,%esi
 648:	e9 1b ff ff ff       	jmp    568 <printf+0x38>
 64d:	8d 76 00             	lea    0x0(%esi),%esi
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 650:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 653:	b1 0a                	mov    $0xa,%cl
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 655:	66 31 f6             	xor    %si,%si
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 658:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 65f:	8b 10                	mov    (%eax),%edx
 661:	8b 45 08             	mov    0x8(%ebp),%eax
 664:	e8 47 fe ff ff       	call   4b0 <printint>
        ap++;
 669:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
 66d:	e9 f6 fe ff ff       	jmp    568 <printf+0x38>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 672:	8b 45 e4             	mov    -0x1c(%ebp),%eax
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 675:	31 f6                	xor    %esi,%esi
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 677:	0f be 10             	movsbl (%eax),%edx
 67a:	8b 45 08             	mov    0x8(%ebp),%eax
 67d:	e8 fe fd ff ff       	call   480 <putc>
        ap++;
 682:	83 45 e4 04          	addl   $0x4,-0x1c(%ebp)
 686:	e9 dd fe ff ff       	jmp    568 <printf+0x38>
 68b:	90                   	nop
 68c:	90                   	nop
 68d:	90                   	nop
 68e:	90                   	nop
 68f:	90                   	nop

00000690 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 690:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 691:	a1 50 0e 00 00       	mov    0xe50,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 696:	89 e5                	mov    %esp,%ebp
 698:	57                   	push   %edi
 699:	56                   	push   %esi
 69a:	53                   	push   %ebx
 69b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 69e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 6a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6a8:	39 c8                	cmp    %ecx,%eax
 6aa:	8b 10                	mov    (%eax),%edx
 6ac:	73 04                	jae    6b2 <free+0x22>
 6ae:	39 d1                	cmp    %edx,%ecx
 6b0:	72 16                	jb     6c8 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6b2:	39 d0                	cmp    %edx,%eax
 6b4:	72 0c                	jb     6c2 <free+0x32>
 6b6:	39 c8                	cmp    %ecx,%eax
 6b8:	72 0e                	jb     6c8 <free+0x38>
 6ba:	39 d1                	cmp    %edx,%ecx
 6bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6c0:	72 06                	jb     6c8 <free+0x38>
static Header base;
static Header *freep;

void
free(void *ap)
{
 6c2:	89 d0                	mov    %edx,%eax
 6c4:	eb e2                	jmp    6a8 <free+0x18>
 6c6:	66 90                	xchg   %ax,%ax

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 6c8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6cb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6ce:	39 d7                	cmp    %edx,%edi
 6d0:	74 19                	je     6eb <free+0x5b>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 6d2:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6d5:	8b 50 04             	mov    0x4(%eax),%edx
 6d8:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6db:	39 f1                	cmp    %esi,%ecx
 6dd:	74 23                	je     702 <free+0x72>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 6df:	89 08                	mov    %ecx,(%eax)
  freep = p;
 6e1:	a3 50 0e 00 00       	mov    %eax,0xe50
}
 6e6:	5b                   	pop    %ebx
 6e7:	5e                   	pop    %esi
 6e8:	5f                   	pop    %edi
 6e9:	5d                   	pop    %ebp
 6ea:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 6eb:	03 72 04             	add    0x4(%edx),%esi
 6ee:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6f1:	8b 10                	mov    (%eax),%edx
 6f3:	8b 12                	mov    (%edx),%edx
 6f5:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 6f8:	8b 50 04             	mov    0x4(%eax),%edx
 6fb:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6fe:	39 f1                	cmp    %esi,%ecx
 700:	75 dd                	jne    6df <free+0x4f>
    p->s.size += bp->s.size;
 702:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 705:	a3 50 0e 00 00       	mov    %eax,0xe50
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 70a:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 70d:	8b 53 f8             	mov    -0x8(%ebx),%edx
 710:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 712:	5b                   	pop    %ebx
 713:	5e                   	pop    %esi
 714:	5f                   	pop    %edi
 715:	5d                   	pop    %ebp
 716:	c3                   	ret    
 717:	89 f6                	mov    %esi,%esi
 719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000720 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 720:	55                   	push   %ebp
 721:	89 e5                	mov    %esp,%ebp
 723:	57                   	push   %edi
 724:	56                   	push   %esi
 725:	53                   	push   %ebx
 726:	83 ec 2c             	sub    $0x2c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 729:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((prevp = freep) == 0){
 72c:	8b 15 50 0e 00 00    	mov    0xe50,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 732:	83 c3 07             	add    $0x7,%ebx
 735:	c1 eb 03             	shr    $0x3,%ebx
 738:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 73b:	85 d2                	test   %edx,%edx
 73d:	0f 84 a3 00 00 00    	je     7e6 <malloc+0xc6>
 743:	8b 02                	mov    (%edx),%eax
 745:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 748:	39 d9                	cmp    %ebx,%ecx
 74a:	73 74                	jae    7c0 <malloc+0xa0>
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
 74c:	8d 14 dd 00 00 00 00 	lea    0x0(,%ebx,8),%edx
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 753:	bf 00 80 00 00       	mov    $0x8000,%edi
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
 758:	89 55 e4             	mov    %edx,-0x1c(%ebp)
 75b:	eb 0c                	jmp    769 <malloc+0x49>
 75d:	8d 76 00             	lea    0x0(%esi),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 760:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 762:	8b 48 04             	mov    0x4(%eax),%ecx
 765:	39 cb                	cmp    %ecx,%ebx
 767:	76 57                	jbe    7c0 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 769:	3b 05 50 0e 00 00    	cmp    0xe50,%eax
 76f:	89 c2                	mov    %eax,%edx
 771:	75 ed                	jne    760 <malloc+0x40>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 773:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 776:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
 77c:	be 00 10 00 00       	mov    $0x1000,%esi
 781:	0f 43 f3             	cmovae %ebx,%esi
 784:	0f 42 c7             	cmovb  %edi,%eax
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 787:	89 04 24             	mov    %eax,(%esp)
 78a:	e8 d5 fc ff ff       	call   464 <sbrk>
  if(p == (char*)-1)
 78f:	83 f8 ff             	cmp    $0xffffffff,%eax
 792:	74 1c                	je     7b0 <malloc+0x90>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 794:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 797:	83 c0 08             	add    $0x8,%eax
 79a:	89 04 24             	mov    %eax,(%esp)
 79d:	e8 ee fe ff ff       	call   690 <free>
  return freep;
 7a2:	8b 15 50 0e 00 00    	mov    0xe50,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 7a8:	85 d2                	test   %edx,%edx
 7aa:	75 b4                	jne    760 <malloc+0x40>
 7ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return 0;
  }
}
 7b0:	83 c4 2c             	add    $0x2c,%esp
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
 7b3:	31 c0                	xor    %eax,%eax
  }
}
 7b5:	5b                   	pop    %ebx
 7b6:	5e                   	pop    %esi
 7b7:	5f                   	pop    %edi
 7b8:	5d                   	pop    %ebp
 7b9:	c3                   	ret    
 7ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 7c0:	39 cb                	cmp    %ecx,%ebx
 7c2:	74 1c                	je     7e0 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 7c4:	29 d9                	sub    %ebx,%ecx
 7c6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 7c9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 7cc:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 7cf:	89 15 50 0e 00 00    	mov    %edx,0xe50
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 7d5:	83 c4 2c             	add    $0x2c,%esp
        p->s.size -= nunits;
        p += p->s.size;
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
 7d8:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 7db:	5b                   	pop    %ebx
 7dc:	5e                   	pop    %esi
 7dd:	5f                   	pop    %edi
 7de:	5d                   	pop    %ebp
 7df:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 7e0:	8b 08                	mov    (%eax),%ecx
 7e2:	89 0a                	mov    %ecx,(%edx)
 7e4:	eb e9                	jmp    7cf <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 7e6:	c7 05 50 0e 00 00 54 	movl   $0xe54,0xe50
 7ed:	0e 00 00 
    base.s.size = 0;
 7f0:	b8 54 0e 00 00       	mov    $0xe54,%eax
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 7f5:	c7 05 54 0e 00 00 54 	movl   $0xe54,0xe54
 7fc:	0e 00 00 
    base.s.size = 0;
 7ff:	c7 05 58 0e 00 00 00 	movl   $0x0,0xe58
 806:	00 00 00 
 809:	e9 3e ff ff ff       	jmp    74c <malloc+0x2c>
