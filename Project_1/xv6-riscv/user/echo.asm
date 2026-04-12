
user/_echo:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	7139                	addi	sp,sp,-64
   2:	fc06                	sd	ra,56(sp)
   4:	f822                	sd	s0,48(sp)
   6:	f426                	sd	s1,40(sp)
   8:	f04a                	sd	s2,32(sp)
   a:	ec4e                	sd	s3,24(sp)
   c:	e852                	sd	s4,16(sp)
   e:	e456                	sd	s5,8(sp)
  10:	0080                	addi	s0,sp,64
  int i;

  for(i = 1; i < argc; i++){
  12:	4785                	li	a5,1
  14:	06a7d063          	bge	a5,a0,74 <main+0x74>
  18:	00858493          	addi	s1,a1,8
  1c:	3579                	addiw	a0,a0,-2
  1e:	02051793          	slli	a5,a0,0x20
  22:	01d7d513          	srli	a0,a5,0x1d
  26:	00a48a33          	add	s4,s1,a0
  2a:	05c1                	addi	a1,a1,16
  2c:	00a589b3          	add	s3,a1,a0
    write(1, argv[i], strlen(argv[i]));
    if(i + 1 < argc){
      write(1, " ", 1);
  30:	00001a97          	auipc	s5,0x1
  34:	9d0a8a93          	addi	s5,s5,-1584 # a00 <malloc+0xfa>
  38:	a809                	j	4a <main+0x4a>
  3a:	4605                	li	a2,1
  3c:	85d6                	mv	a1,s5
  3e:	4505                	li	a0,1
  40:	37e000ef          	jal	3be <write>
  for(i = 1; i < argc; i++){
  44:	04a1                	addi	s1,s1,8
  46:	03348763          	beq	s1,s3,74 <main+0x74>
    write(1, argv[i], strlen(argv[i]));
  4a:	0004b903          	ld	s2,0(s1)
  4e:	854a                	mv	a0,s2
  50:	082000ef          	jal	d2 <strlen>
  54:	0005061b          	sext.w	a2,a0
  58:	85ca                	mv	a1,s2
  5a:	4505                	li	a0,1
  5c:	362000ef          	jal	3be <write>
    if(i + 1 < argc){
  60:	fd449de3          	bne	s1,s4,3a <main+0x3a>
    } else {
      write(1, "\n", 1);
  64:	4605                	li	a2,1
  66:	00001597          	auipc	a1,0x1
  6a:	9a258593          	addi	a1,a1,-1630 # a08 <malloc+0x102>
  6e:	4505                	li	a0,1
  70:	34e000ef          	jal	3be <write>
    }
  }
  exit(0);
  74:	4501                	li	a0,0
  76:	328000ef          	jal	39e <exit>

000000000000007a <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
  7a:	1141                	addi	sp,sp,-16
  7c:	e406                	sd	ra,8(sp)
  7e:	e022                	sd	s0,0(sp)
  80:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
  82:	f7fff0ef          	jal	0 <main>
  exit(r);
  86:	318000ef          	jal	39e <exit>

000000000000008a <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  8a:	1141                	addi	sp,sp,-16
  8c:	e422                	sd	s0,8(sp)
  8e:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  90:	87aa                	mv	a5,a0
  92:	0585                	addi	a1,a1,1
  94:	0785                	addi	a5,a5,1
  96:	fff5c703          	lbu	a4,-1(a1)
  9a:	fee78fa3          	sb	a4,-1(a5)
  9e:	fb75                	bnez	a4,92 <strcpy+0x8>
    ;
  return os;
}
  a0:	6422                	ld	s0,8(sp)
  a2:	0141                	addi	sp,sp,16
  a4:	8082                	ret

00000000000000a6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  a6:	1141                	addi	sp,sp,-16
  a8:	e422                	sd	s0,8(sp)
  aa:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  ac:	00054783          	lbu	a5,0(a0)
  b0:	cb91                	beqz	a5,c4 <strcmp+0x1e>
  b2:	0005c703          	lbu	a4,0(a1)
  b6:	00f71763          	bne	a4,a5,c4 <strcmp+0x1e>
    p++, q++;
  ba:	0505                	addi	a0,a0,1
  bc:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  be:	00054783          	lbu	a5,0(a0)
  c2:	fbe5                	bnez	a5,b2 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  c4:	0005c503          	lbu	a0,0(a1)
}
  c8:	40a7853b          	subw	a0,a5,a0
  cc:	6422                	ld	s0,8(sp)
  ce:	0141                	addi	sp,sp,16
  d0:	8082                	ret

00000000000000d2 <strlen>:

uint
strlen(const char *s)
{
  d2:	1141                	addi	sp,sp,-16
  d4:	e422                	sd	s0,8(sp)
  d6:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  d8:	00054783          	lbu	a5,0(a0)
  dc:	cf91                	beqz	a5,f8 <strlen+0x26>
  de:	0505                	addi	a0,a0,1
  e0:	87aa                	mv	a5,a0
  e2:	86be                	mv	a3,a5
  e4:	0785                	addi	a5,a5,1
  e6:	fff7c703          	lbu	a4,-1(a5)
  ea:	ff65                	bnez	a4,e2 <strlen+0x10>
  ec:	40a6853b          	subw	a0,a3,a0
  f0:	2505                	addiw	a0,a0,1
    ;
  return n;
}
  f2:	6422                	ld	s0,8(sp)
  f4:	0141                	addi	sp,sp,16
  f6:	8082                	ret
  for(n = 0; s[n]; n++)
  f8:	4501                	li	a0,0
  fa:	bfe5                	j	f2 <strlen+0x20>

00000000000000fc <memset>:

void*
memset(void *dst, int c, uint n)
{
  fc:	1141                	addi	sp,sp,-16
  fe:	e422                	sd	s0,8(sp)
 100:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 102:	ca19                	beqz	a2,118 <memset+0x1c>
 104:	87aa                	mv	a5,a0
 106:	1602                	slli	a2,a2,0x20
 108:	9201                	srli	a2,a2,0x20
 10a:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 10e:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 112:	0785                	addi	a5,a5,1
 114:	fee79de3          	bne	a5,a4,10e <memset+0x12>
  }
  return dst;
}
 118:	6422                	ld	s0,8(sp)
 11a:	0141                	addi	sp,sp,16
 11c:	8082                	ret

000000000000011e <strchr>:

char*
strchr(const char *s, char c)
{
 11e:	1141                	addi	sp,sp,-16
 120:	e422                	sd	s0,8(sp)
 122:	0800                	addi	s0,sp,16
  for(; *s; s++)
 124:	00054783          	lbu	a5,0(a0)
 128:	cb99                	beqz	a5,13e <strchr+0x20>
    if(*s == c)
 12a:	00f58763          	beq	a1,a5,138 <strchr+0x1a>
  for(; *s; s++)
 12e:	0505                	addi	a0,a0,1
 130:	00054783          	lbu	a5,0(a0)
 134:	fbfd                	bnez	a5,12a <strchr+0xc>
      return (char*)s;
  return 0;
 136:	4501                	li	a0,0
}
 138:	6422                	ld	s0,8(sp)
 13a:	0141                	addi	sp,sp,16
 13c:	8082                	ret
  return 0;
 13e:	4501                	li	a0,0
 140:	bfe5                	j	138 <strchr+0x1a>

0000000000000142 <gets>:

char*
gets(char *buf, int max)
{
 142:	711d                	addi	sp,sp,-96
 144:	ec86                	sd	ra,88(sp)
 146:	e8a2                	sd	s0,80(sp)
 148:	e4a6                	sd	s1,72(sp)
 14a:	e0ca                	sd	s2,64(sp)
 14c:	fc4e                	sd	s3,56(sp)
 14e:	f852                	sd	s4,48(sp)
 150:	f456                	sd	s5,40(sp)
 152:	f05a                	sd	s6,32(sp)
 154:	ec5e                	sd	s7,24(sp)
 156:	1080                	addi	s0,sp,96
 158:	8baa                	mv	s7,a0
 15a:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 15c:	892a                	mv	s2,a0
 15e:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 160:	4aa9                	li	s5,10
 162:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 164:	89a6                	mv	s3,s1
 166:	2485                	addiw	s1,s1,1
 168:	0344d663          	bge	s1,s4,194 <gets+0x52>
    cc = read(0, &c, 1);
 16c:	4605                	li	a2,1
 16e:	faf40593          	addi	a1,s0,-81
 172:	4501                	li	a0,0
 174:	242000ef          	jal	3b6 <read>
    if(cc < 1)
 178:	00a05e63          	blez	a0,194 <gets+0x52>
    buf[i++] = c;
 17c:	faf44783          	lbu	a5,-81(s0)
 180:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 184:	01578763          	beq	a5,s5,192 <gets+0x50>
 188:	0905                	addi	s2,s2,1
 18a:	fd679de3          	bne	a5,s6,164 <gets+0x22>
    buf[i++] = c;
 18e:	89a6                	mv	s3,s1
 190:	a011                	j	194 <gets+0x52>
 192:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 194:	99de                	add	s3,s3,s7
 196:	00098023          	sb	zero,0(s3)
  return buf;
}
 19a:	855e                	mv	a0,s7
 19c:	60e6                	ld	ra,88(sp)
 19e:	6446                	ld	s0,80(sp)
 1a0:	64a6                	ld	s1,72(sp)
 1a2:	6906                	ld	s2,64(sp)
 1a4:	79e2                	ld	s3,56(sp)
 1a6:	7a42                	ld	s4,48(sp)
 1a8:	7aa2                	ld	s5,40(sp)
 1aa:	7b02                	ld	s6,32(sp)
 1ac:	6be2                	ld	s7,24(sp)
 1ae:	6125                	addi	sp,sp,96
 1b0:	8082                	ret

00000000000001b2 <stat>:

int
stat(const char *n, struct stat *st)
{
 1b2:	1101                	addi	sp,sp,-32
 1b4:	ec06                	sd	ra,24(sp)
 1b6:	e822                	sd	s0,16(sp)
 1b8:	e04a                	sd	s2,0(sp)
 1ba:	1000                	addi	s0,sp,32
 1bc:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1be:	4581                	li	a1,0
 1c0:	21e000ef          	jal	3de <open>
  if(fd < 0)
 1c4:	02054263          	bltz	a0,1e8 <stat+0x36>
 1c8:	e426                	sd	s1,8(sp)
 1ca:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1cc:	85ca                	mv	a1,s2
 1ce:	228000ef          	jal	3f6 <fstat>
 1d2:	892a                	mv	s2,a0
  close(fd);
 1d4:	8526                	mv	a0,s1
 1d6:	1f0000ef          	jal	3c6 <close>
  return r;
 1da:	64a2                	ld	s1,8(sp)
}
 1dc:	854a                	mv	a0,s2
 1de:	60e2                	ld	ra,24(sp)
 1e0:	6442                	ld	s0,16(sp)
 1e2:	6902                	ld	s2,0(sp)
 1e4:	6105                	addi	sp,sp,32
 1e6:	8082                	ret
    return -1;
 1e8:	597d                	li	s2,-1
 1ea:	bfcd                	j	1dc <stat+0x2a>

00000000000001ec <atoi>:

int
atoi(const char *s)
{
 1ec:	1141                	addi	sp,sp,-16
 1ee:	e422                	sd	s0,8(sp)
 1f0:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1f2:	00054683          	lbu	a3,0(a0)
 1f6:	fd06879b          	addiw	a5,a3,-48
 1fa:	0ff7f793          	zext.b	a5,a5
 1fe:	4625                	li	a2,9
 200:	02f66863          	bltu	a2,a5,230 <atoi+0x44>
 204:	872a                	mv	a4,a0
  n = 0;
 206:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 208:	0705                	addi	a4,a4,1
 20a:	0025179b          	slliw	a5,a0,0x2
 20e:	9fa9                	addw	a5,a5,a0
 210:	0017979b          	slliw	a5,a5,0x1
 214:	9fb5                	addw	a5,a5,a3
 216:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 21a:	00074683          	lbu	a3,0(a4)
 21e:	fd06879b          	addiw	a5,a3,-48
 222:	0ff7f793          	zext.b	a5,a5
 226:	fef671e3          	bgeu	a2,a5,208 <atoi+0x1c>
  return n;
}
 22a:	6422                	ld	s0,8(sp)
 22c:	0141                	addi	sp,sp,16
 22e:	8082                	ret
  n = 0;
 230:	4501                	li	a0,0
 232:	bfe5                	j	22a <atoi+0x3e>

0000000000000234 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 234:	1141                	addi	sp,sp,-16
 236:	e422                	sd	s0,8(sp)
 238:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 23a:	02b57463          	bgeu	a0,a1,262 <memmove+0x2e>
    while(n-- > 0)
 23e:	00c05f63          	blez	a2,25c <memmove+0x28>
 242:	1602                	slli	a2,a2,0x20
 244:	9201                	srli	a2,a2,0x20
 246:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 24a:	872a                	mv	a4,a0
      *dst++ = *src++;
 24c:	0585                	addi	a1,a1,1
 24e:	0705                	addi	a4,a4,1
 250:	fff5c683          	lbu	a3,-1(a1)
 254:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 258:	fef71ae3          	bne	a4,a5,24c <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 25c:	6422                	ld	s0,8(sp)
 25e:	0141                	addi	sp,sp,16
 260:	8082                	ret
    dst += n;
 262:	00c50733          	add	a4,a0,a2
    src += n;
 266:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 268:	fec05ae3          	blez	a2,25c <memmove+0x28>
 26c:	fff6079b          	addiw	a5,a2,-1
 270:	1782                	slli	a5,a5,0x20
 272:	9381                	srli	a5,a5,0x20
 274:	fff7c793          	not	a5,a5
 278:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 27a:	15fd                	addi	a1,a1,-1
 27c:	177d                	addi	a4,a4,-1
 27e:	0005c683          	lbu	a3,0(a1)
 282:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 286:	fee79ae3          	bne	a5,a4,27a <memmove+0x46>
 28a:	bfc9                	j	25c <memmove+0x28>

000000000000028c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 28c:	1141                	addi	sp,sp,-16
 28e:	e422                	sd	s0,8(sp)
 290:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 292:	ca05                	beqz	a2,2c2 <memcmp+0x36>
 294:	fff6069b          	addiw	a3,a2,-1
 298:	1682                	slli	a3,a3,0x20
 29a:	9281                	srli	a3,a3,0x20
 29c:	0685                	addi	a3,a3,1
 29e:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2a0:	00054783          	lbu	a5,0(a0)
 2a4:	0005c703          	lbu	a4,0(a1)
 2a8:	00e79863          	bne	a5,a4,2b8 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 2ac:	0505                	addi	a0,a0,1
    p2++;
 2ae:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2b0:	fed518e3          	bne	a0,a3,2a0 <memcmp+0x14>
  }
  return 0;
 2b4:	4501                	li	a0,0
 2b6:	a019                	j	2bc <memcmp+0x30>
      return *p1 - *p2;
 2b8:	40e7853b          	subw	a0,a5,a4
}
 2bc:	6422                	ld	s0,8(sp)
 2be:	0141                	addi	sp,sp,16
 2c0:	8082                	ret
  return 0;
 2c2:	4501                	li	a0,0
 2c4:	bfe5                	j	2bc <memcmp+0x30>

00000000000002c6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2c6:	1141                	addi	sp,sp,-16
 2c8:	e406                	sd	ra,8(sp)
 2ca:	e022                	sd	s0,0(sp)
 2cc:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2ce:	f67ff0ef          	jal	234 <memmove>
}
 2d2:	60a2                	ld	ra,8(sp)
 2d4:	6402                	ld	s0,0(sp)
 2d6:	0141                	addi	sp,sp,16
 2d8:	8082                	ret

00000000000002da <sbrk>:

char *
sbrk(int n) {
 2da:	1141                	addi	sp,sp,-16
 2dc:	e406                	sd	ra,8(sp)
 2de:	e022                	sd	s0,0(sp)
 2e0:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 2e2:	4585                	li	a1,1
 2e4:	142000ef          	jal	426 <sys_sbrk>
}
 2e8:	60a2                	ld	ra,8(sp)
 2ea:	6402                	ld	s0,0(sp)
 2ec:	0141                	addi	sp,sp,16
 2ee:	8082                	ret

00000000000002f0 <sbrklazy>:

char *
sbrklazy(int n) {
 2f0:	1141                	addi	sp,sp,-16
 2f2:	e406                	sd	ra,8(sp)
 2f4:	e022                	sd	s0,0(sp)
 2f6:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 2f8:	4589                	li	a1,2
 2fa:	12c000ef          	jal	426 <sys_sbrk>
}
 2fe:	60a2                	ld	ra,8(sp)
 300:	6402                	ld	s0,0(sp)
 302:	0141                	addi	sp,sp,16
 304:	8082                	ret

0000000000000306 <thread_create>:
// thread_create allocates a page-sized stack, calls clone(fn, arg, stacktop).
// Returns the new thread's pid, or -1 on error.
// The stack is passed back via *stack so the caller can free it after join.
int
thread_create(void(*fn)(void*), void *arg, void **stack)
{
 306:	7179                	addi	sp,sp,-48
 308:	f406                	sd	ra,40(sp)
 30a:	f022                	sd	s0,32(sp)
 30c:	e84a                	sd	s2,16(sp)
 30e:	e44e                	sd	s3,8(sp)
 310:	e052                	sd	s4,0(sp)
 312:	1800                	addi	s0,sp,48
 314:	89aa                	mv	s3,a0
 316:	8a2e                	mv	s4,a1
 318:	8932                	mv	s2,a2
  char *s = malloc(PGSIZE);
 31a:	6505                	lui	a0,0x1
 31c:	5ea000ef          	jal	906 <malloc>
  if(s == 0)
 320:	cd0d                	beqz	a0,35a <thread_create+0x54>
 322:	ec26                	sd	s1,24(sp)
 324:	84aa                	mv	s1,a0
    return -1;
  *stack = s;
 326:	00a93023          	sd	a0,0(s2)
  // Stack grows downward- pass the top of the allocated region.
  int pid = clone(fn, arg, s + PGSIZE);
 32a:	6605                	lui	a2,0x1
 32c:	962a                	add	a2,a2,a0
 32e:	85d2                	mv	a1,s4
 330:	854e                	mv	a0,s3
 332:	166000ef          	jal	498 <clone>
  if(pid < 0){
 336:	00054a63          	bltz	a0,34a <thread_create+0x44>
 33a:	64e2                	ld	s1,24(sp)
    free(s);
    *stack = 0;
    return -1;
  }
  return pid;
}
 33c:	70a2                	ld	ra,40(sp)
 33e:	7402                	ld	s0,32(sp)
 340:	6942                	ld	s2,16(sp)
 342:	69a2                	ld	s3,8(sp)
 344:	6a02                	ld	s4,0(sp)
 346:	6145                	addi	sp,sp,48
 348:	8082                	ret
    free(s);
 34a:	8526                	mv	a0,s1
 34c:	538000ef          	jal	884 <free>
    *stack = 0;
 350:	00093023          	sd	zero,0(s2)
    return -1;
 354:	557d                	li	a0,-1
 356:	64e2                	ld	s1,24(sp)
 358:	b7d5                	j	33c <thread_create+0x36>
    return -1;
 35a:	557d                	li	a0,-1
 35c:	b7c5                	j	33c <thread_create+0x36>

000000000000035e <thread_join>:
// Wait for any child thread to exit.
// If stack is non-null, frees the memory pointed to by *stack and clears it.
// Returns the joined thread's pid, or -1 Son error.
int
thread_join(void **stack)
{
 35e:	1101                	addi	sp,sp,-32
 360:	ec06                	sd	ra,24(sp)
 362:	e822                	sd	s0,16(sp)
 364:	e426                	sd	s1,8(sp)
 366:	e04a                	sd	s2,0(sp)
 368:	1000                	addi	s0,sp,32
 36a:	84aa                	mv	s1,a0
  int pid = join();
 36c:	134000ef          	jal	4a0 <join>
  if(pid < 0)
 370:	02054163          	bltz	a0,392 <thread_join+0x34>
 374:	892a                	mv	s2,a0
    return -1;
  if(stack && *stack){
 376:	c499                	beqz	s1,384 <thread_join+0x26>
 378:	6088                	ld	a0,0(s1)
 37a:	c509                	beqz	a0,384 <thread_join+0x26>
    free(*stack);
 37c:	508000ef          	jal	884 <free>
    *stack = 0;
 380:	0004b023          	sd	zero,0(s1)
  }
  return pid;
}
 384:	854a                	mv	a0,s2
 386:	60e2                	ld	ra,24(sp)
 388:	6442                	ld	s0,16(sp)
 38a:	64a2                	ld	s1,8(sp)
 38c:	6902                	ld	s2,0(sp)
 38e:	6105                	addi	sp,sp,32
 390:	8082                	ret
    return -1;
 392:	597d                	li	s2,-1
 394:	bfc5                	j	384 <thread_join+0x26>

0000000000000396 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 396:	4885                	li	a7,1
 ecall
 398:	00000073          	ecall
 ret
 39c:	8082                	ret

000000000000039e <exit>:
.global exit
exit:
 li a7, SYS_exit
 39e:	4889                	li	a7,2
 ecall
 3a0:	00000073          	ecall
 ret
 3a4:	8082                	ret

00000000000003a6 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3a6:	488d                	li	a7,3
 ecall
 3a8:	00000073          	ecall
 ret
 3ac:	8082                	ret

00000000000003ae <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3ae:	4891                	li	a7,4
 ecall
 3b0:	00000073          	ecall
 ret
 3b4:	8082                	ret

00000000000003b6 <read>:
.global read
read:
 li a7, SYS_read
 3b6:	4895                	li	a7,5
 ecall
 3b8:	00000073          	ecall
 ret
 3bc:	8082                	ret

00000000000003be <write>:
.global write
write:
 li a7, SYS_write
 3be:	48c1                	li	a7,16
 ecall
 3c0:	00000073          	ecall
 ret
 3c4:	8082                	ret

00000000000003c6 <close>:
.global close
close:
 li a7, SYS_close
 3c6:	48d5                	li	a7,21
 ecall
 3c8:	00000073          	ecall
 ret
 3cc:	8082                	ret

00000000000003ce <kill>:
.global kill
kill:
 li a7, SYS_kill
 3ce:	4899                	li	a7,6
 ecall
 3d0:	00000073          	ecall
 ret
 3d4:	8082                	ret

00000000000003d6 <exec>:
.global exec
exec:
 li a7, SYS_exec
 3d6:	489d                	li	a7,7
 ecall
 3d8:	00000073          	ecall
 ret
 3dc:	8082                	ret

00000000000003de <open>:
.global open
open:
 li a7, SYS_open
 3de:	48bd                	li	a7,15
 ecall
 3e0:	00000073          	ecall
 ret
 3e4:	8082                	ret

00000000000003e6 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3e6:	48c5                	li	a7,17
 ecall
 3e8:	00000073          	ecall
 ret
 3ec:	8082                	ret

00000000000003ee <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3ee:	48c9                	li	a7,18
 ecall
 3f0:	00000073          	ecall
 ret
 3f4:	8082                	ret

00000000000003f6 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3f6:	48a1                	li	a7,8
 ecall
 3f8:	00000073          	ecall
 ret
 3fc:	8082                	ret

00000000000003fe <link>:
.global link
link:
 li a7, SYS_link
 3fe:	48cd                	li	a7,19
 ecall
 400:	00000073          	ecall
 ret
 404:	8082                	ret

0000000000000406 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 406:	48d1                	li	a7,20
 ecall
 408:	00000073          	ecall
 ret
 40c:	8082                	ret

000000000000040e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 40e:	48a5                	li	a7,9
 ecall
 410:	00000073          	ecall
 ret
 414:	8082                	ret

0000000000000416 <dup>:
.global dup
dup:
 li a7, SYS_dup
 416:	48a9                	li	a7,10
 ecall
 418:	00000073          	ecall
 ret
 41c:	8082                	ret

000000000000041e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 41e:	48ad                	li	a7,11
 ecall
 420:	00000073          	ecall
 ret
 424:	8082                	ret

0000000000000426 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 426:	48b1                	li	a7,12
 ecall
 428:	00000073          	ecall
 ret
 42c:	8082                	ret

000000000000042e <pause>:
.global pause
pause:
 li a7, SYS_pause
 42e:	48b5                	li	a7,13
 ecall
 430:	00000073          	ecall
 ret
 434:	8082                	ret

0000000000000436 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 436:	48b9                	li	a7,14
 ecall
 438:	00000073          	ecall
 ret
 43c:	8082                	ret

000000000000043e <getppid>:
.global getppid
getppid:
 li a7, SYS_getppid
 43e:	02100893          	li	a7,33
 ecall
 442:	00000073          	ecall
 ret
 446:	8082                	ret

0000000000000448 <ps>:
.global ps
ps:
 li a7, SYS_ps
 448:	02200893          	li	a7,34
 ecall
 44c:	00000073          	ecall
 ret
 450:	8082                	ret

0000000000000452 <trace>:
.global trace
trace:
 li a7, SYS_trace
 452:	02300893          	li	a7,35
 ecall
 456:	00000073          	ecall
 ret
 45a:	8082                	ret

000000000000045c <waitx>:
.global waitx
waitx:
 li a7, SYS_waitx
 45c:	02400893          	li	a7,36
 ecall
 460:	00000073          	ecall
 ret
 464:	8082                	ret

0000000000000466 <getcount>:
.global getcount
getcount:
 li a7, SYS_getcount
 466:	02500893          	li	a7,37
 ecall
 46a:	00000073          	ecall
 ret
 46e:	8082                	ret

0000000000000470 <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 470:	48d9                	li	a7,22
 ecall
 472:	00000073          	ecall
 ret
 476:	8082                	ret

0000000000000478 <lock_create>:
.global lock_create
lock_create:
 li a7, SYS_lock_create
 478:	48dd                	li	a7,23
 ecall
 47a:	00000073          	ecall
 ret
 47e:	8082                	ret

0000000000000480 <lock_acquire>:
.global lock_acquire
lock_acquire:
 li a7, SYS_lock_acquire
 480:	48e1                	li	a7,24
 ecall
 482:	00000073          	ecall
 ret
 486:	8082                	ret

0000000000000488 <lock_release>:
.global lock_release
lock_release:
 li a7, SYS_lock_release
 488:	48e5                	li	a7,25
 ecall
 48a:	00000073          	ecall
 ret
 48e:	8082                	ret

0000000000000490 <lock_destroy>:
.global lock_destroy
lock_destroy:
 li a7, SYS_lock_destroy
 490:	48e9                	li	a7,26
 ecall
 492:	00000073          	ecall
 ret
 496:	8082                	ret

0000000000000498 <clone>:
.global clone
clone:
 li a7, SYS_clone
 498:	48ed                	li	a7,27
 ecall
 49a:	00000073          	ecall
 ret
 49e:	8082                	ret

00000000000004a0 <join>:
.global join
join:
 li a7, SYS_join
 4a0:	48f1                	li	a7,28
 ecall
 4a2:	00000073          	ecall
 ret
 4a6:	8082                	ret

00000000000004a8 <getprocessinfo>:
.global getprocessinfo
getprocessinfo:
 li a7, SYS_getprocessinfo
 4a8:	48f5                	li	a7,29
 ecall
 4aa:	00000073          	ecall
 ret
 4ae:	8082                	ret

00000000000004b0 <shmget>:
.global shmget
shmget:
 li a7, SYS_shmget
 4b0:	48f9                	li	a7,30
 ecall
 4b2:	00000073          	ecall
 ret
 4b6:	8082                	ret

00000000000004b8 <shmattach>:
.global shmattach
shmattach:
 li a7, SYS_shmattach
 4b8:	48fd                	li	a7,31
 ecall
 4ba:	00000073          	ecall
 ret
 4be:	8082                	ret

00000000000004c0 <shmdetach>:
.global shmdetach
shmdetach:
 li a7, SYS_shmdetach
 4c0:	02000893          	li	a7,32
 ecall
 4c4:	00000073          	ecall
 ret
 4c8:	8082                	ret

00000000000004ca <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4ca:	1101                	addi	sp,sp,-32
 4cc:	ec06                	sd	ra,24(sp)
 4ce:	e822                	sd	s0,16(sp)
 4d0:	1000                	addi	s0,sp,32
 4d2:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4d6:	4605                	li	a2,1
 4d8:	fef40593          	addi	a1,s0,-17
 4dc:	ee3ff0ef          	jal	3be <write>
}
 4e0:	60e2                	ld	ra,24(sp)
 4e2:	6442                	ld	s0,16(sp)
 4e4:	6105                	addi	sp,sp,32
 4e6:	8082                	ret

00000000000004e8 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 4e8:	715d                	addi	sp,sp,-80
 4ea:	e486                	sd	ra,72(sp)
 4ec:	e0a2                	sd	s0,64(sp)
 4ee:	f84a                	sd	s2,48(sp)
 4f0:	0880                	addi	s0,sp,80
 4f2:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 4f4:	c299                	beqz	a3,4fa <printint+0x12>
 4f6:	0805c363          	bltz	a1,57c <printint+0x94>
  neg = 0;
 4fa:	4881                	li	a7,0
 4fc:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 500:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 502:	00000517          	auipc	a0,0x0
 506:	51650513          	addi	a0,a0,1302 # a18 <digits>
 50a:	883e                	mv	a6,a5
 50c:	2785                	addiw	a5,a5,1
 50e:	02c5f733          	remu	a4,a1,a2
 512:	972a                	add	a4,a4,a0
 514:	00074703          	lbu	a4,0(a4)
 518:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 51c:	872e                	mv	a4,a1
 51e:	02c5d5b3          	divu	a1,a1,a2
 522:	0685                	addi	a3,a3,1
 524:	fec773e3          	bgeu	a4,a2,50a <printint+0x22>
  if(neg)
 528:	00088b63          	beqz	a7,53e <printint+0x56>
    buf[i++] = '-';
 52c:	fd078793          	addi	a5,a5,-48
 530:	97a2                	add	a5,a5,s0
 532:	02d00713          	li	a4,45
 536:	fee78423          	sb	a4,-24(a5)
 53a:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
 53e:	02f05a63          	blez	a5,572 <printint+0x8a>
 542:	fc26                	sd	s1,56(sp)
 544:	f44e                	sd	s3,40(sp)
 546:	fb840713          	addi	a4,s0,-72
 54a:	00f704b3          	add	s1,a4,a5
 54e:	fff70993          	addi	s3,a4,-1
 552:	99be                	add	s3,s3,a5
 554:	37fd                	addiw	a5,a5,-1
 556:	1782                	slli	a5,a5,0x20
 558:	9381                	srli	a5,a5,0x20
 55a:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 55e:	fff4c583          	lbu	a1,-1(s1)
 562:	854a                	mv	a0,s2
 564:	f67ff0ef          	jal	4ca <putc>
  while(--i >= 0)
 568:	14fd                	addi	s1,s1,-1
 56a:	ff349ae3          	bne	s1,s3,55e <printint+0x76>
 56e:	74e2                	ld	s1,56(sp)
 570:	79a2                	ld	s3,40(sp)
}
 572:	60a6                	ld	ra,72(sp)
 574:	6406                	ld	s0,64(sp)
 576:	7942                	ld	s2,48(sp)
 578:	6161                	addi	sp,sp,80
 57a:	8082                	ret
    x = -xx;
 57c:	40b005b3          	neg	a1,a1
    neg = 1;
 580:	4885                	li	a7,1
    x = -xx;
 582:	bfad                	j	4fc <printint+0x14>

0000000000000584 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 584:	711d                	addi	sp,sp,-96
 586:	ec86                	sd	ra,88(sp)
 588:	e8a2                	sd	s0,80(sp)
 58a:	e0ca                	sd	s2,64(sp)
 58c:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 58e:	0005c903          	lbu	s2,0(a1)
 592:	28090663          	beqz	s2,81e <vprintf+0x29a>
 596:	e4a6                	sd	s1,72(sp)
 598:	fc4e                	sd	s3,56(sp)
 59a:	f852                	sd	s4,48(sp)
 59c:	f456                	sd	s5,40(sp)
 59e:	f05a                	sd	s6,32(sp)
 5a0:	ec5e                	sd	s7,24(sp)
 5a2:	e862                	sd	s8,16(sp)
 5a4:	e466                	sd	s9,8(sp)
 5a6:	8b2a                	mv	s6,a0
 5a8:	8a2e                	mv	s4,a1
 5aa:	8bb2                	mv	s7,a2
  state = 0;
 5ac:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 5ae:	4481                	li	s1,0
 5b0:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 5b2:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 5b6:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 5ba:	06c00c93          	li	s9,108
 5be:	a005                	j	5de <vprintf+0x5a>
        putc(fd, c0);
 5c0:	85ca                	mv	a1,s2
 5c2:	855a                	mv	a0,s6
 5c4:	f07ff0ef          	jal	4ca <putc>
 5c8:	a019                	j	5ce <vprintf+0x4a>
    } else if(state == '%'){
 5ca:	03598263          	beq	s3,s5,5ee <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 5ce:	2485                	addiw	s1,s1,1
 5d0:	8726                	mv	a4,s1
 5d2:	009a07b3          	add	a5,s4,s1
 5d6:	0007c903          	lbu	s2,0(a5)
 5da:	22090a63          	beqz	s2,80e <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 5de:	0009079b          	sext.w	a5,s2
    if(state == 0){
 5e2:	fe0994e3          	bnez	s3,5ca <vprintf+0x46>
      if(c0 == '%'){
 5e6:	fd579de3          	bne	a5,s5,5c0 <vprintf+0x3c>
        state = '%';
 5ea:	89be                	mv	s3,a5
 5ec:	b7cd                	j	5ce <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 5ee:	00ea06b3          	add	a3,s4,a4
 5f2:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 5f6:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 5f8:	c681                	beqz	a3,600 <vprintf+0x7c>
 5fa:	9752                	add	a4,a4,s4
 5fc:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 600:	05878363          	beq	a5,s8,646 <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 604:	05978d63          	beq	a5,s9,65e <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 608:	07500713          	li	a4,117
 60c:	0ee78763          	beq	a5,a4,6fa <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 610:	07800713          	li	a4,120
 614:	12e78963          	beq	a5,a4,746 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 618:	07000713          	li	a4,112
 61c:	14e78e63          	beq	a5,a4,778 <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 620:	06300713          	li	a4,99
 624:	18e78e63          	beq	a5,a4,7c0 <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 628:	07300713          	li	a4,115
 62c:	1ae78463          	beq	a5,a4,7d4 <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 630:	02500713          	li	a4,37
 634:	04e79563          	bne	a5,a4,67e <vprintf+0xfa>
        putc(fd, '%');
 638:	02500593          	li	a1,37
 63c:	855a                	mv	a0,s6
 63e:	e8dff0ef          	jal	4ca <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 642:	4981                	li	s3,0
 644:	b769                	j	5ce <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 646:	008b8913          	addi	s2,s7,8
 64a:	4685                	li	a3,1
 64c:	4629                	li	a2,10
 64e:	000ba583          	lw	a1,0(s7)
 652:	855a                	mv	a0,s6
 654:	e95ff0ef          	jal	4e8 <printint>
 658:	8bca                	mv	s7,s2
      state = 0;
 65a:	4981                	li	s3,0
 65c:	bf8d                	j	5ce <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 65e:	06400793          	li	a5,100
 662:	02f68963          	beq	a3,a5,694 <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 666:	06c00793          	li	a5,108
 66a:	04f68263          	beq	a3,a5,6ae <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 66e:	07500793          	li	a5,117
 672:	0af68063          	beq	a3,a5,712 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 676:	07800793          	li	a5,120
 67a:	0ef68263          	beq	a3,a5,75e <vprintf+0x1da>
        putc(fd, '%');
 67e:	02500593          	li	a1,37
 682:	855a                	mv	a0,s6
 684:	e47ff0ef          	jal	4ca <putc>
        putc(fd, c0);
 688:	85ca                	mv	a1,s2
 68a:	855a                	mv	a0,s6
 68c:	e3fff0ef          	jal	4ca <putc>
      state = 0;
 690:	4981                	li	s3,0
 692:	bf35                	j	5ce <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 694:	008b8913          	addi	s2,s7,8
 698:	4685                	li	a3,1
 69a:	4629                	li	a2,10
 69c:	000bb583          	ld	a1,0(s7)
 6a0:	855a                	mv	a0,s6
 6a2:	e47ff0ef          	jal	4e8 <printint>
        i += 1;
 6a6:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 6a8:	8bca                	mv	s7,s2
      state = 0;
 6aa:	4981                	li	s3,0
        i += 1;
 6ac:	b70d                	j	5ce <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 6ae:	06400793          	li	a5,100
 6b2:	02f60763          	beq	a2,a5,6e0 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 6b6:	07500793          	li	a5,117
 6ba:	06f60963          	beq	a2,a5,72c <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 6be:	07800793          	li	a5,120
 6c2:	faf61ee3          	bne	a2,a5,67e <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6c6:	008b8913          	addi	s2,s7,8
 6ca:	4681                	li	a3,0
 6cc:	4641                	li	a2,16
 6ce:	000bb583          	ld	a1,0(s7)
 6d2:	855a                	mv	a0,s6
 6d4:	e15ff0ef          	jal	4e8 <printint>
        i += 2;
 6d8:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 6da:	8bca                	mv	s7,s2
      state = 0;
 6dc:	4981                	li	s3,0
        i += 2;
 6de:	bdc5                	j	5ce <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 6e0:	008b8913          	addi	s2,s7,8
 6e4:	4685                	li	a3,1
 6e6:	4629                	li	a2,10
 6e8:	000bb583          	ld	a1,0(s7)
 6ec:	855a                	mv	a0,s6
 6ee:	dfbff0ef          	jal	4e8 <printint>
        i += 2;
 6f2:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 6f4:	8bca                	mv	s7,s2
      state = 0;
 6f6:	4981                	li	s3,0
        i += 2;
 6f8:	bdd9                	j	5ce <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 6fa:	008b8913          	addi	s2,s7,8
 6fe:	4681                	li	a3,0
 700:	4629                	li	a2,10
 702:	000be583          	lwu	a1,0(s7)
 706:	855a                	mv	a0,s6
 708:	de1ff0ef          	jal	4e8 <printint>
 70c:	8bca                	mv	s7,s2
      state = 0;
 70e:	4981                	li	s3,0
 710:	bd7d                	j	5ce <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 712:	008b8913          	addi	s2,s7,8
 716:	4681                	li	a3,0
 718:	4629                	li	a2,10
 71a:	000bb583          	ld	a1,0(s7)
 71e:	855a                	mv	a0,s6
 720:	dc9ff0ef          	jal	4e8 <printint>
        i += 1;
 724:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 726:	8bca                	mv	s7,s2
      state = 0;
 728:	4981                	li	s3,0
        i += 1;
 72a:	b555                	j	5ce <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 72c:	008b8913          	addi	s2,s7,8
 730:	4681                	li	a3,0
 732:	4629                	li	a2,10
 734:	000bb583          	ld	a1,0(s7)
 738:	855a                	mv	a0,s6
 73a:	dafff0ef          	jal	4e8 <printint>
        i += 2;
 73e:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 740:	8bca                	mv	s7,s2
      state = 0;
 742:	4981                	li	s3,0
        i += 2;
 744:	b569                	j	5ce <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 746:	008b8913          	addi	s2,s7,8
 74a:	4681                	li	a3,0
 74c:	4641                	li	a2,16
 74e:	000be583          	lwu	a1,0(s7)
 752:	855a                	mv	a0,s6
 754:	d95ff0ef          	jal	4e8 <printint>
 758:	8bca                	mv	s7,s2
      state = 0;
 75a:	4981                	li	s3,0
 75c:	bd8d                	j	5ce <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 75e:	008b8913          	addi	s2,s7,8
 762:	4681                	li	a3,0
 764:	4641                	li	a2,16
 766:	000bb583          	ld	a1,0(s7)
 76a:	855a                	mv	a0,s6
 76c:	d7dff0ef          	jal	4e8 <printint>
        i += 1;
 770:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 772:	8bca                	mv	s7,s2
      state = 0;
 774:	4981                	li	s3,0
        i += 1;
 776:	bda1                	j	5ce <vprintf+0x4a>
 778:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 77a:	008b8d13          	addi	s10,s7,8
 77e:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 782:	03000593          	li	a1,48
 786:	855a                	mv	a0,s6
 788:	d43ff0ef          	jal	4ca <putc>
  putc(fd, 'x');
 78c:	07800593          	li	a1,120
 790:	855a                	mv	a0,s6
 792:	d39ff0ef          	jal	4ca <putc>
 796:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 798:	00000b97          	auipc	s7,0x0
 79c:	280b8b93          	addi	s7,s7,640 # a18 <digits>
 7a0:	03c9d793          	srli	a5,s3,0x3c
 7a4:	97de                	add	a5,a5,s7
 7a6:	0007c583          	lbu	a1,0(a5)
 7aa:	855a                	mv	a0,s6
 7ac:	d1fff0ef          	jal	4ca <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7b0:	0992                	slli	s3,s3,0x4
 7b2:	397d                	addiw	s2,s2,-1
 7b4:	fe0916e3          	bnez	s2,7a0 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 7b8:	8bea                	mv	s7,s10
      state = 0;
 7ba:	4981                	li	s3,0
 7bc:	6d02                	ld	s10,0(sp)
 7be:	bd01                	j	5ce <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 7c0:	008b8913          	addi	s2,s7,8
 7c4:	000bc583          	lbu	a1,0(s7)
 7c8:	855a                	mv	a0,s6
 7ca:	d01ff0ef          	jal	4ca <putc>
 7ce:	8bca                	mv	s7,s2
      state = 0;
 7d0:	4981                	li	s3,0
 7d2:	bbf5                	j	5ce <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 7d4:	008b8993          	addi	s3,s7,8
 7d8:	000bb903          	ld	s2,0(s7)
 7dc:	00090f63          	beqz	s2,7fa <vprintf+0x276>
        for(; *s; s++)
 7e0:	00094583          	lbu	a1,0(s2)
 7e4:	c195                	beqz	a1,808 <vprintf+0x284>
          putc(fd, *s);
 7e6:	855a                	mv	a0,s6
 7e8:	ce3ff0ef          	jal	4ca <putc>
        for(; *s; s++)
 7ec:	0905                	addi	s2,s2,1
 7ee:	00094583          	lbu	a1,0(s2)
 7f2:	f9f5                	bnez	a1,7e6 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 7f4:	8bce                	mv	s7,s3
      state = 0;
 7f6:	4981                	li	s3,0
 7f8:	bbd9                	j	5ce <vprintf+0x4a>
          s = "(null)";
 7fa:	00000917          	auipc	s2,0x0
 7fe:	21690913          	addi	s2,s2,534 # a10 <malloc+0x10a>
        for(; *s; s++)
 802:	02800593          	li	a1,40
 806:	b7c5                	j	7e6 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 808:	8bce                	mv	s7,s3
      state = 0;
 80a:	4981                	li	s3,0
 80c:	b3c9                	j	5ce <vprintf+0x4a>
 80e:	64a6                	ld	s1,72(sp)
 810:	79e2                	ld	s3,56(sp)
 812:	7a42                	ld	s4,48(sp)
 814:	7aa2                	ld	s5,40(sp)
 816:	7b02                	ld	s6,32(sp)
 818:	6be2                	ld	s7,24(sp)
 81a:	6c42                	ld	s8,16(sp)
 81c:	6ca2                	ld	s9,8(sp)
    }
  }
}
 81e:	60e6                	ld	ra,88(sp)
 820:	6446                	ld	s0,80(sp)
 822:	6906                	ld	s2,64(sp)
 824:	6125                	addi	sp,sp,96
 826:	8082                	ret

0000000000000828 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 828:	715d                	addi	sp,sp,-80
 82a:	ec06                	sd	ra,24(sp)
 82c:	e822                	sd	s0,16(sp)
 82e:	1000                	addi	s0,sp,32
 830:	e010                	sd	a2,0(s0)
 832:	e414                	sd	a3,8(s0)
 834:	e818                	sd	a4,16(s0)
 836:	ec1c                	sd	a5,24(s0)
 838:	03043023          	sd	a6,32(s0)
 83c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 840:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 844:	8622                	mv	a2,s0
 846:	d3fff0ef          	jal	584 <vprintf>
}
 84a:	60e2                	ld	ra,24(sp)
 84c:	6442                	ld	s0,16(sp)
 84e:	6161                	addi	sp,sp,80
 850:	8082                	ret

0000000000000852 <printf>:

void
printf(const char *fmt, ...)
{
 852:	711d                	addi	sp,sp,-96
 854:	ec06                	sd	ra,24(sp)
 856:	e822                	sd	s0,16(sp)
 858:	1000                	addi	s0,sp,32
 85a:	e40c                	sd	a1,8(s0)
 85c:	e810                	sd	a2,16(s0)
 85e:	ec14                	sd	a3,24(s0)
 860:	f018                	sd	a4,32(s0)
 862:	f41c                	sd	a5,40(s0)
 864:	03043823          	sd	a6,48(s0)
 868:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 86c:	00840613          	addi	a2,s0,8
 870:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 874:	85aa                	mv	a1,a0
 876:	4505                	li	a0,1
 878:	d0dff0ef          	jal	584 <vprintf>
}
 87c:	60e2                	ld	ra,24(sp)
 87e:	6442                	ld	s0,16(sp)
 880:	6125                	addi	sp,sp,96
 882:	8082                	ret

0000000000000884 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 884:	1141                	addi	sp,sp,-16
 886:	e422                	sd	s0,8(sp)
 888:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 88a:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 88e:	00000797          	auipc	a5,0x0
 892:	7727b783          	ld	a5,1906(a5) # 1000 <freep>
 896:	a02d                	j	8c0 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 898:	4618                	lw	a4,8(a2)
 89a:	9f2d                	addw	a4,a4,a1
 89c:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8a0:	6398                	ld	a4,0(a5)
 8a2:	6310                	ld	a2,0(a4)
 8a4:	a83d                	j	8e2 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8a6:	ff852703          	lw	a4,-8(a0)
 8aa:	9f31                	addw	a4,a4,a2
 8ac:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 8ae:	ff053683          	ld	a3,-16(a0)
 8b2:	a091                	j	8f6 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8b4:	6398                	ld	a4,0(a5)
 8b6:	00e7e463          	bltu	a5,a4,8be <free+0x3a>
 8ba:	00e6ea63          	bltu	a3,a4,8ce <free+0x4a>
{
 8be:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8c0:	fed7fae3          	bgeu	a5,a3,8b4 <free+0x30>
 8c4:	6398                	ld	a4,0(a5)
 8c6:	00e6e463          	bltu	a3,a4,8ce <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8ca:	fee7eae3          	bltu	a5,a4,8be <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 8ce:	ff852583          	lw	a1,-8(a0)
 8d2:	6390                	ld	a2,0(a5)
 8d4:	02059813          	slli	a6,a1,0x20
 8d8:	01c85713          	srli	a4,a6,0x1c
 8dc:	9736                	add	a4,a4,a3
 8de:	fae60de3          	beq	a2,a4,898 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 8e2:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8e6:	4790                	lw	a2,8(a5)
 8e8:	02061593          	slli	a1,a2,0x20
 8ec:	01c5d713          	srli	a4,a1,0x1c
 8f0:	973e                	add	a4,a4,a5
 8f2:	fae68ae3          	beq	a3,a4,8a6 <free+0x22>
    p->s.ptr = bp->s.ptr;
 8f6:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 8f8:	00000717          	auipc	a4,0x0
 8fc:	70f73423          	sd	a5,1800(a4) # 1000 <freep>
}
 900:	6422                	ld	s0,8(sp)
 902:	0141                	addi	sp,sp,16
 904:	8082                	ret

0000000000000906 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 906:	7139                	addi	sp,sp,-64
 908:	fc06                	sd	ra,56(sp)
 90a:	f822                	sd	s0,48(sp)
 90c:	f426                	sd	s1,40(sp)
 90e:	ec4e                	sd	s3,24(sp)
 910:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 912:	02051493          	slli	s1,a0,0x20
 916:	9081                	srli	s1,s1,0x20
 918:	04bd                	addi	s1,s1,15
 91a:	8091                	srli	s1,s1,0x4
 91c:	0014899b          	addiw	s3,s1,1
 920:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 922:	00000517          	auipc	a0,0x0
 926:	6de53503          	ld	a0,1758(a0) # 1000 <freep>
 92a:	c915                	beqz	a0,95e <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 92c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 92e:	4798                	lw	a4,8(a5)
 930:	08977a63          	bgeu	a4,s1,9c4 <malloc+0xbe>
 934:	f04a                	sd	s2,32(sp)
 936:	e852                	sd	s4,16(sp)
 938:	e456                	sd	s5,8(sp)
 93a:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 93c:	8a4e                	mv	s4,s3
 93e:	0009871b          	sext.w	a4,s3
 942:	6685                	lui	a3,0x1
 944:	00d77363          	bgeu	a4,a3,94a <malloc+0x44>
 948:	6a05                	lui	s4,0x1
 94a:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 94e:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 952:	00000917          	auipc	s2,0x0
 956:	6ae90913          	addi	s2,s2,1710 # 1000 <freep>
  if(p == SBRK_ERROR)
 95a:	5afd                	li	s5,-1
 95c:	a081                	j	99c <malloc+0x96>
 95e:	f04a                	sd	s2,32(sp)
 960:	e852                	sd	s4,16(sp)
 962:	e456                	sd	s5,8(sp)
 964:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 966:	00000797          	auipc	a5,0x0
 96a:	6aa78793          	addi	a5,a5,1706 # 1010 <base>
 96e:	00000717          	auipc	a4,0x0
 972:	68f73923          	sd	a5,1682(a4) # 1000 <freep>
 976:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 978:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 97c:	b7c1                	j	93c <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 97e:	6398                	ld	a4,0(a5)
 980:	e118                	sd	a4,0(a0)
 982:	a8a9                	j	9dc <malloc+0xd6>
  hp->s.size = nu;
 984:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 988:	0541                	addi	a0,a0,16
 98a:	efbff0ef          	jal	884 <free>
  return freep;
 98e:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 992:	c12d                	beqz	a0,9f4 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 994:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 996:	4798                	lw	a4,8(a5)
 998:	02977263          	bgeu	a4,s1,9bc <malloc+0xb6>
    if(p == freep)
 99c:	00093703          	ld	a4,0(s2)
 9a0:	853e                	mv	a0,a5
 9a2:	fef719e3          	bne	a4,a5,994 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 9a6:	8552                	mv	a0,s4
 9a8:	933ff0ef          	jal	2da <sbrk>
  if(p == SBRK_ERROR)
 9ac:	fd551ce3          	bne	a0,s5,984 <malloc+0x7e>
        return 0;
 9b0:	4501                	li	a0,0
 9b2:	7902                	ld	s2,32(sp)
 9b4:	6a42                	ld	s4,16(sp)
 9b6:	6aa2                	ld	s5,8(sp)
 9b8:	6b02                	ld	s6,0(sp)
 9ba:	a03d                	j	9e8 <malloc+0xe2>
 9bc:	7902                	ld	s2,32(sp)
 9be:	6a42                	ld	s4,16(sp)
 9c0:	6aa2                	ld	s5,8(sp)
 9c2:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 9c4:	fae48de3          	beq	s1,a4,97e <malloc+0x78>
        p->s.size -= nunits;
 9c8:	4137073b          	subw	a4,a4,s3
 9cc:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9ce:	02071693          	slli	a3,a4,0x20
 9d2:	01c6d713          	srli	a4,a3,0x1c
 9d6:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9d8:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9dc:	00000717          	auipc	a4,0x0
 9e0:	62a73223          	sd	a0,1572(a4) # 1000 <freep>
      return (void*)(p + 1);
 9e4:	01078513          	addi	a0,a5,16
  }
}
 9e8:	70e2                	ld	ra,56(sp)
 9ea:	7442                	ld	s0,48(sp)
 9ec:	74a2                	ld	s1,40(sp)
 9ee:	69e2                	ld	s3,24(sp)
 9f0:	6121                	addi	sp,sp,64
 9f2:	8082                	ret
 9f4:	7902                	ld	s2,32(sp)
 9f6:	6a42                	ld	s4,16(sp)
 9f8:	6aa2                	ld	s5,8(sp)
 9fa:	6b02                	ld	s6,0(sp)
 9fc:	b7f5                	j	9e8 <malloc+0xe2>
