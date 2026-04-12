
user/_zombie:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(void)
{
   0:	1141                	addi	sp,sp,-16
   2:	e406                	sd	ra,8(sp)
   4:	e022                	sd	s0,0(sp)
   6:	0800                	addi	s0,sp,16
  if(fork() > 0)
   8:	332000ef          	jal	33a <fork>
   c:	00a04563          	bgtz	a0,16 <main+0x16>
    pause(5);  // Let child exit before parent.
  exit(0);
  10:	4501                	li	a0,0
  12:	330000ef          	jal	342 <exit>
    pause(5);  // Let child exit before parent.
  16:	4515                	li	a0,5
  18:	3ba000ef          	jal	3d2 <pause>
  1c:	bfd5                	j	10 <main+0x10>

000000000000001e <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
  1e:	1141                	addi	sp,sp,-16
  20:	e406                	sd	ra,8(sp)
  22:	e022                	sd	s0,0(sp)
  24:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
  26:	fdbff0ef          	jal	0 <main>
  exit(r);
  2a:	318000ef          	jal	342 <exit>

000000000000002e <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  2e:	1141                	addi	sp,sp,-16
  30:	e422                	sd	s0,8(sp)
  32:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  34:	87aa                	mv	a5,a0
  36:	0585                	addi	a1,a1,1
  38:	0785                	addi	a5,a5,1
  3a:	fff5c703          	lbu	a4,-1(a1)
  3e:	fee78fa3          	sb	a4,-1(a5)
  42:	fb75                	bnez	a4,36 <strcpy+0x8>
    ;
  return os;
}
  44:	6422                	ld	s0,8(sp)
  46:	0141                	addi	sp,sp,16
  48:	8082                	ret

000000000000004a <strcmp>:

int
strcmp(const char *p, const char *q)
{
  4a:	1141                	addi	sp,sp,-16
  4c:	e422                	sd	s0,8(sp)
  4e:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  50:	00054783          	lbu	a5,0(a0)
  54:	cb91                	beqz	a5,68 <strcmp+0x1e>
  56:	0005c703          	lbu	a4,0(a1)
  5a:	00f71763          	bne	a4,a5,68 <strcmp+0x1e>
    p++, q++;
  5e:	0505                	addi	a0,a0,1
  60:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  62:	00054783          	lbu	a5,0(a0)
  66:	fbe5                	bnez	a5,56 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  68:	0005c503          	lbu	a0,0(a1)
}
  6c:	40a7853b          	subw	a0,a5,a0
  70:	6422                	ld	s0,8(sp)
  72:	0141                	addi	sp,sp,16
  74:	8082                	ret

0000000000000076 <strlen>:

uint
strlen(const char *s)
{
  76:	1141                	addi	sp,sp,-16
  78:	e422                	sd	s0,8(sp)
  7a:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  7c:	00054783          	lbu	a5,0(a0)
  80:	cf91                	beqz	a5,9c <strlen+0x26>
  82:	0505                	addi	a0,a0,1
  84:	87aa                	mv	a5,a0
  86:	86be                	mv	a3,a5
  88:	0785                	addi	a5,a5,1
  8a:	fff7c703          	lbu	a4,-1(a5)
  8e:	ff65                	bnez	a4,86 <strlen+0x10>
  90:	40a6853b          	subw	a0,a3,a0
  94:	2505                	addiw	a0,a0,1
    ;
  return n;
}
  96:	6422                	ld	s0,8(sp)
  98:	0141                	addi	sp,sp,16
  9a:	8082                	ret
  for(n = 0; s[n]; n++)
  9c:	4501                	li	a0,0
  9e:	bfe5                	j	96 <strlen+0x20>

00000000000000a0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  a0:	1141                	addi	sp,sp,-16
  a2:	e422                	sd	s0,8(sp)
  a4:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  a6:	ca19                	beqz	a2,bc <memset+0x1c>
  a8:	87aa                	mv	a5,a0
  aa:	1602                	slli	a2,a2,0x20
  ac:	9201                	srli	a2,a2,0x20
  ae:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  b2:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  b6:	0785                	addi	a5,a5,1
  b8:	fee79de3          	bne	a5,a4,b2 <memset+0x12>
  }
  return dst;
}
  bc:	6422                	ld	s0,8(sp)
  be:	0141                	addi	sp,sp,16
  c0:	8082                	ret

00000000000000c2 <strchr>:

char*
strchr(const char *s, char c)
{
  c2:	1141                	addi	sp,sp,-16
  c4:	e422                	sd	s0,8(sp)
  c6:	0800                	addi	s0,sp,16
  for(; *s; s++)
  c8:	00054783          	lbu	a5,0(a0)
  cc:	cb99                	beqz	a5,e2 <strchr+0x20>
    if(*s == c)
  ce:	00f58763          	beq	a1,a5,dc <strchr+0x1a>
  for(; *s; s++)
  d2:	0505                	addi	a0,a0,1
  d4:	00054783          	lbu	a5,0(a0)
  d8:	fbfd                	bnez	a5,ce <strchr+0xc>
      return (char*)s;
  return 0;
  da:	4501                	li	a0,0
}
  dc:	6422                	ld	s0,8(sp)
  de:	0141                	addi	sp,sp,16
  e0:	8082                	ret
  return 0;
  e2:	4501                	li	a0,0
  e4:	bfe5                	j	dc <strchr+0x1a>

00000000000000e6 <gets>:

char*
gets(char *buf, int max)
{
  e6:	711d                	addi	sp,sp,-96
  e8:	ec86                	sd	ra,88(sp)
  ea:	e8a2                	sd	s0,80(sp)
  ec:	e4a6                	sd	s1,72(sp)
  ee:	e0ca                	sd	s2,64(sp)
  f0:	fc4e                	sd	s3,56(sp)
  f2:	f852                	sd	s4,48(sp)
  f4:	f456                	sd	s5,40(sp)
  f6:	f05a                	sd	s6,32(sp)
  f8:	ec5e                	sd	s7,24(sp)
  fa:	1080                	addi	s0,sp,96
  fc:	8baa                	mv	s7,a0
  fe:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 100:	892a                	mv	s2,a0
 102:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 104:	4aa9                	li	s5,10
 106:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 108:	89a6                	mv	s3,s1
 10a:	2485                	addiw	s1,s1,1
 10c:	0344d663          	bge	s1,s4,138 <gets+0x52>
    cc = read(0, &c, 1);
 110:	4605                	li	a2,1
 112:	faf40593          	addi	a1,s0,-81
 116:	4501                	li	a0,0
 118:	242000ef          	jal	35a <read>
    if(cc < 1)
 11c:	00a05e63          	blez	a0,138 <gets+0x52>
    buf[i++] = c;
 120:	faf44783          	lbu	a5,-81(s0)
 124:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 128:	01578763          	beq	a5,s5,136 <gets+0x50>
 12c:	0905                	addi	s2,s2,1
 12e:	fd679de3          	bne	a5,s6,108 <gets+0x22>
    buf[i++] = c;
 132:	89a6                	mv	s3,s1
 134:	a011                	j	138 <gets+0x52>
 136:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 138:	99de                	add	s3,s3,s7
 13a:	00098023          	sb	zero,0(s3)
  return buf;
}
 13e:	855e                	mv	a0,s7
 140:	60e6                	ld	ra,88(sp)
 142:	6446                	ld	s0,80(sp)
 144:	64a6                	ld	s1,72(sp)
 146:	6906                	ld	s2,64(sp)
 148:	79e2                	ld	s3,56(sp)
 14a:	7a42                	ld	s4,48(sp)
 14c:	7aa2                	ld	s5,40(sp)
 14e:	7b02                	ld	s6,32(sp)
 150:	6be2                	ld	s7,24(sp)
 152:	6125                	addi	sp,sp,96
 154:	8082                	ret

0000000000000156 <stat>:

int
stat(const char *n, struct stat *st)
{
 156:	1101                	addi	sp,sp,-32
 158:	ec06                	sd	ra,24(sp)
 15a:	e822                	sd	s0,16(sp)
 15c:	e04a                	sd	s2,0(sp)
 15e:	1000                	addi	s0,sp,32
 160:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 162:	4581                	li	a1,0
 164:	21e000ef          	jal	382 <open>
  if(fd < 0)
 168:	02054263          	bltz	a0,18c <stat+0x36>
 16c:	e426                	sd	s1,8(sp)
 16e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 170:	85ca                	mv	a1,s2
 172:	228000ef          	jal	39a <fstat>
 176:	892a                	mv	s2,a0
  close(fd);
 178:	8526                	mv	a0,s1
 17a:	1f0000ef          	jal	36a <close>
  return r;
 17e:	64a2                	ld	s1,8(sp)
}
 180:	854a                	mv	a0,s2
 182:	60e2                	ld	ra,24(sp)
 184:	6442                	ld	s0,16(sp)
 186:	6902                	ld	s2,0(sp)
 188:	6105                	addi	sp,sp,32
 18a:	8082                	ret
    return -1;
 18c:	597d                	li	s2,-1
 18e:	bfcd                	j	180 <stat+0x2a>

0000000000000190 <atoi>:

int
atoi(const char *s)
{
 190:	1141                	addi	sp,sp,-16
 192:	e422                	sd	s0,8(sp)
 194:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 196:	00054683          	lbu	a3,0(a0)
 19a:	fd06879b          	addiw	a5,a3,-48
 19e:	0ff7f793          	zext.b	a5,a5
 1a2:	4625                	li	a2,9
 1a4:	02f66863          	bltu	a2,a5,1d4 <atoi+0x44>
 1a8:	872a                	mv	a4,a0
  n = 0;
 1aa:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 1ac:	0705                	addi	a4,a4,1
 1ae:	0025179b          	slliw	a5,a0,0x2
 1b2:	9fa9                	addw	a5,a5,a0
 1b4:	0017979b          	slliw	a5,a5,0x1
 1b8:	9fb5                	addw	a5,a5,a3
 1ba:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 1be:	00074683          	lbu	a3,0(a4)
 1c2:	fd06879b          	addiw	a5,a3,-48
 1c6:	0ff7f793          	zext.b	a5,a5
 1ca:	fef671e3          	bgeu	a2,a5,1ac <atoi+0x1c>
  return n;
}
 1ce:	6422                	ld	s0,8(sp)
 1d0:	0141                	addi	sp,sp,16
 1d2:	8082                	ret
  n = 0;
 1d4:	4501                	li	a0,0
 1d6:	bfe5                	j	1ce <atoi+0x3e>

00000000000001d8 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 1d8:	1141                	addi	sp,sp,-16
 1da:	e422                	sd	s0,8(sp)
 1dc:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 1de:	02b57463          	bgeu	a0,a1,206 <memmove+0x2e>
    while(n-- > 0)
 1e2:	00c05f63          	blez	a2,200 <memmove+0x28>
 1e6:	1602                	slli	a2,a2,0x20
 1e8:	9201                	srli	a2,a2,0x20
 1ea:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 1ee:	872a                	mv	a4,a0
      *dst++ = *src++;
 1f0:	0585                	addi	a1,a1,1
 1f2:	0705                	addi	a4,a4,1
 1f4:	fff5c683          	lbu	a3,-1(a1)
 1f8:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 1fc:	fef71ae3          	bne	a4,a5,1f0 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 200:	6422                	ld	s0,8(sp)
 202:	0141                	addi	sp,sp,16
 204:	8082                	ret
    dst += n;
 206:	00c50733          	add	a4,a0,a2
    src += n;
 20a:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 20c:	fec05ae3          	blez	a2,200 <memmove+0x28>
 210:	fff6079b          	addiw	a5,a2,-1
 214:	1782                	slli	a5,a5,0x20
 216:	9381                	srli	a5,a5,0x20
 218:	fff7c793          	not	a5,a5
 21c:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 21e:	15fd                	addi	a1,a1,-1
 220:	177d                	addi	a4,a4,-1
 222:	0005c683          	lbu	a3,0(a1)
 226:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 22a:	fee79ae3          	bne	a5,a4,21e <memmove+0x46>
 22e:	bfc9                	j	200 <memmove+0x28>

0000000000000230 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 230:	1141                	addi	sp,sp,-16
 232:	e422                	sd	s0,8(sp)
 234:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 236:	ca05                	beqz	a2,266 <memcmp+0x36>
 238:	fff6069b          	addiw	a3,a2,-1
 23c:	1682                	slli	a3,a3,0x20
 23e:	9281                	srli	a3,a3,0x20
 240:	0685                	addi	a3,a3,1
 242:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 244:	00054783          	lbu	a5,0(a0)
 248:	0005c703          	lbu	a4,0(a1)
 24c:	00e79863          	bne	a5,a4,25c <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 250:	0505                	addi	a0,a0,1
    p2++;
 252:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 254:	fed518e3          	bne	a0,a3,244 <memcmp+0x14>
  }
  return 0;
 258:	4501                	li	a0,0
 25a:	a019                	j	260 <memcmp+0x30>
      return *p1 - *p2;
 25c:	40e7853b          	subw	a0,a5,a4
}
 260:	6422                	ld	s0,8(sp)
 262:	0141                	addi	sp,sp,16
 264:	8082                	ret
  return 0;
 266:	4501                	li	a0,0
 268:	bfe5                	j	260 <memcmp+0x30>

000000000000026a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 26a:	1141                	addi	sp,sp,-16
 26c:	e406                	sd	ra,8(sp)
 26e:	e022                	sd	s0,0(sp)
 270:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 272:	f67ff0ef          	jal	1d8 <memmove>
}
 276:	60a2                	ld	ra,8(sp)
 278:	6402                	ld	s0,0(sp)
 27a:	0141                	addi	sp,sp,16
 27c:	8082                	ret

000000000000027e <sbrk>:

char *
sbrk(int n) {
 27e:	1141                	addi	sp,sp,-16
 280:	e406                	sd	ra,8(sp)
 282:	e022                	sd	s0,0(sp)
 284:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 286:	4585                	li	a1,1
 288:	142000ef          	jal	3ca <sys_sbrk>
}
 28c:	60a2                	ld	ra,8(sp)
 28e:	6402                	ld	s0,0(sp)
 290:	0141                	addi	sp,sp,16
 292:	8082                	ret

0000000000000294 <sbrklazy>:

char *
sbrklazy(int n) {
 294:	1141                	addi	sp,sp,-16
 296:	e406                	sd	ra,8(sp)
 298:	e022                	sd	s0,0(sp)
 29a:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 29c:	4589                	li	a1,2
 29e:	12c000ef          	jal	3ca <sys_sbrk>
}
 2a2:	60a2                	ld	ra,8(sp)
 2a4:	6402                	ld	s0,0(sp)
 2a6:	0141                	addi	sp,sp,16
 2a8:	8082                	ret

00000000000002aa <thread_create>:
// thread_create allocates a page-sized stack, calls clone(fn, arg, stacktop).
// Returns the new thread's pid, or -1 on error.
// The stack is passed back via *stack so the caller can free it after join.
int
thread_create(void(*fn)(void*), void *arg, void **stack)
{
 2aa:	7179                	addi	sp,sp,-48
 2ac:	f406                	sd	ra,40(sp)
 2ae:	f022                	sd	s0,32(sp)
 2b0:	e84a                	sd	s2,16(sp)
 2b2:	e44e                	sd	s3,8(sp)
 2b4:	e052                	sd	s4,0(sp)
 2b6:	1800                	addi	s0,sp,48
 2b8:	89aa                	mv	s3,a0
 2ba:	8a2e                	mv	s4,a1
 2bc:	8932                	mv	s2,a2
  char *s = malloc(PGSIZE);
 2be:	6505                	lui	a0,0x1
 2c0:	5ea000ef          	jal	8aa <malloc>
  if(s == 0)
 2c4:	cd0d                	beqz	a0,2fe <thread_create+0x54>
 2c6:	ec26                	sd	s1,24(sp)
 2c8:	84aa                	mv	s1,a0
    return -1;
  *stack = s;
 2ca:	00a93023          	sd	a0,0(s2)
  // Stack grows downward- pass the top of the allocated region.
  int pid = clone(fn, arg, s + PGSIZE);
 2ce:	6605                	lui	a2,0x1
 2d0:	962a                	add	a2,a2,a0
 2d2:	85d2                	mv	a1,s4
 2d4:	854e                	mv	a0,s3
 2d6:	166000ef          	jal	43c <clone>
  if(pid < 0){
 2da:	00054a63          	bltz	a0,2ee <thread_create+0x44>
 2de:	64e2                	ld	s1,24(sp)
    free(s);
    *stack = 0;
    return -1;
  }
  return pid;
}
 2e0:	70a2                	ld	ra,40(sp)
 2e2:	7402                	ld	s0,32(sp)
 2e4:	6942                	ld	s2,16(sp)
 2e6:	69a2                	ld	s3,8(sp)
 2e8:	6a02                	ld	s4,0(sp)
 2ea:	6145                	addi	sp,sp,48
 2ec:	8082                	ret
    free(s);
 2ee:	8526                	mv	a0,s1
 2f0:	538000ef          	jal	828 <free>
    *stack = 0;
 2f4:	00093023          	sd	zero,0(s2)
    return -1;
 2f8:	557d                	li	a0,-1
 2fa:	64e2                	ld	s1,24(sp)
 2fc:	b7d5                	j	2e0 <thread_create+0x36>
    return -1;
 2fe:	557d                	li	a0,-1
 300:	b7c5                	j	2e0 <thread_create+0x36>

0000000000000302 <thread_join>:
// Wait for any child thread to exit.
// If stack is non-null, frees the memory pointed to by *stack and clears it.
// Returns the joined thread's pid, or -1 Son error.
int
thread_join(void **stack)
{
 302:	1101                	addi	sp,sp,-32
 304:	ec06                	sd	ra,24(sp)
 306:	e822                	sd	s0,16(sp)
 308:	e426                	sd	s1,8(sp)
 30a:	e04a                	sd	s2,0(sp)
 30c:	1000                	addi	s0,sp,32
 30e:	84aa                	mv	s1,a0
  int pid = join();
 310:	134000ef          	jal	444 <join>
  if(pid < 0)
 314:	02054163          	bltz	a0,336 <thread_join+0x34>
 318:	892a                	mv	s2,a0
    return -1;
  if(stack && *stack){
 31a:	c499                	beqz	s1,328 <thread_join+0x26>
 31c:	6088                	ld	a0,0(s1)
 31e:	c509                	beqz	a0,328 <thread_join+0x26>
    free(*stack);
 320:	508000ef          	jal	828 <free>
    *stack = 0;
 324:	0004b023          	sd	zero,0(s1)
  }
  return pid;
}
 328:	854a                	mv	a0,s2
 32a:	60e2                	ld	ra,24(sp)
 32c:	6442                	ld	s0,16(sp)
 32e:	64a2                	ld	s1,8(sp)
 330:	6902                	ld	s2,0(sp)
 332:	6105                	addi	sp,sp,32
 334:	8082                	ret
    return -1;
 336:	597d                	li	s2,-1
 338:	bfc5                	j	328 <thread_join+0x26>

000000000000033a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 33a:	4885                	li	a7,1
 ecall
 33c:	00000073          	ecall
 ret
 340:	8082                	ret

0000000000000342 <exit>:
.global exit
exit:
 li a7, SYS_exit
 342:	4889                	li	a7,2
 ecall
 344:	00000073          	ecall
 ret
 348:	8082                	ret

000000000000034a <wait>:
.global wait
wait:
 li a7, SYS_wait
 34a:	488d                	li	a7,3
 ecall
 34c:	00000073          	ecall
 ret
 350:	8082                	ret

0000000000000352 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 352:	4891                	li	a7,4
 ecall
 354:	00000073          	ecall
 ret
 358:	8082                	ret

000000000000035a <read>:
.global read
read:
 li a7, SYS_read
 35a:	4895                	li	a7,5
 ecall
 35c:	00000073          	ecall
 ret
 360:	8082                	ret

0000000000000362 <write>:
.global write
write:
 li a7, SYS_write
 362:	48c1                	li	a7,16
 ecall
 364:	00000073          	ecall
 ret
 368:	8082                	ret

000000000000036a <close>:
.global close
close:
 li a7, SYS_close
 36a:	48d5                	li	a7,21
 ecall
 36c:	00000073          	ecall
 ret
 370:	8082                	ret

0000000000000372 <kill>:
.global kill
kill:
 li a7, SYS_kill
 372:	4899                	li	a7,6
 ecall
 374:	00000073          	ecall
 ret
 378:	8082                	ret

000000000000037a <exec>:
.global exec
exec:
 li a7, SYS_exec
 37a:	489d                	li	a7,7
 ecall
 37c:	00000073          	ecall
 ret
 380:	8082                	ret

0000000000000382 <open>:
.global open
open:
 li a7, SYS_open
 382:	48bd                	li	a7,15
 ecall
 384:	00000073          	ecall
 ret
 388:	8082                	ret

000000000000038a <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 38a:	48c5                	li	a7,17
 ecall
 38c:	00000073          	ecall
 ret
 390:	8082                	ret

0000000000000392 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 392:	48c9                	li	a7,18
 ecall
 394:	00000073          	ecall
 ret
 398:	8082                	ret

000000000000039a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 39a:	48a1                	li	a7,8
 ecall
 39c:	00000073          	ecall
 ret
 3a0:	8082                	ret

00000000000003a2 <link>:
.global link
link:
 li a7, SYS_link
 3a2:	48cd                	li	a7,19
 ecall
 3a4:	00000073          	ecall
 ret
 3a8:	8082                	ret

00000000000003aa <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3aa:	48d1                	li	a7,20
 ecall
 3ac:	00000073          	ecall
 ret
 3b0:	8082                	ret

00000000000003b2 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3b2:	48a5                	li	a7,9
 ecall
 3b4:	00000073          	ecall
 ret
 3b8:	8082                	ret

00000000000003ba <dup>:
.global dup
dup:
 li a7, SYS_dup
 3ba:	48a9                	li	a7,10
 ecall
 3bc:	00000073          	ecall
 ret
 3c0:	8082                	ret

00000000000003c2 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3c2:	48ad                	li	a7,11
 ecall
 3c4:	00000073          	ecall
 ret
 3c8:	8082                	ret

00000000000003ca <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 3ca:	48b1                	li	a7,12
 ecall
 3cc:	00000073          	ecall
 ret
 3d0:	8082                	ret

00000000000003d2 <pause>:
.global pause
pause:
 li a7, SYS_pause
 3d2:	48b5                	li	a7,13
 ecall
 3d4:	00000073          	ecall
 ret
 3d8:	8082                	ret

00000000000003da <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3da:	48b9                	li	a7,14
 ecall
 3dc:	00000073          	ecall
 ret
 3e0:	8082                	ret

00000000000003e2 <getppid>:
.global getppid
getppid:
 li a7, SYS_getppid
 3e2:	02100893          	li	a7,33
 ecall
 3e6:	00000073          	ecall
 ret
 3ea:	8082                	ret

00000000000003ec <ps>:
.global ps
ps:
 li a7, SYS_ps
 3ec:	02200893          	li	a7,34
 ecall
 3f0:	00000073          	ecall
 ret
 3f4:	8082                	ret

00000000000003f6 <trace>:
.global trace
trace:
 li a7, SYS_trace
 3f6:	02300893          	li	a7,35
 ecall
 3fa:	00000073          	ecall
 ret
 3fe:	8082                	ret

0000000000000400 <waitx>:
.global waitx
waitx:
 li a7, SYS_waitx
 400:	02400893          	li	a7,36
 ecall
 404:	00000073          	ecall
 ret
 408:	8082                	ret

000000000000040a <getcount>:
.global getcount
getcount:
 li a7, SYS_getcount
 40a:	02500893          	li	a7,37
 ecall
 40e:	00000073          	ecall
 ret
 412:	8082                	ret

0000000000000414 <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 414:	48d9                	li	a7,22
 ecall
 416:	00000073          	ecall
 ret
 41a:	8082                	ret

000000000000041c <lock_create>:
.global lock_create
lock_create:
 li a7, SYS_lock_create
 41c:	48dd                	li	a7,23
 ecall
 41e:	00000073          	ecall
 ret
 422:	8082                	ret

0000000000000424 <lock_acquire>:
.global lock_acquire
lock_acquire:
 li a7, SYS_lock_acquire
 424:	48e1                	li	a7,24
 ecall
 426:	00000073          	ecall
 ret
 42a:	8082                	ret

000000000000042c <lock_release>:
.global lock_release
lock_release:
 li a7, SYS_lock_release
 42c:	48e5                	li	a7,25
 ecall
 42e:	00000073          	ecall
 ret
 432:	8082                	ret

0000000000000434 <lock_destroy>:
.global lock_destroy
lock_destroy:
 li a7, SYS_lock_destroy
 434:	48e9                	li	a7,26
 ecall
 436:	00000073          	ecall
 ret
 43a:	8082                	ret

000000000000043c <clone>:
.global clone
clone:
 li a7, SYS_clone
 43c:	48ed                	li	a7,27
 ecall
 43e:	00000073          	ecall
 ret
 442:	8082                	ret

0000000000000444 <join>:
.global join
join:
 li a7, SYS_join
 444:	48f1                	li	a7,28
 ecall
 446:	00000073          	ecall
 ret
 44a:	8082                	ret

000000000000044c <getprocessinfo>:
.global getprocessinfo
getprocessinfo:
 li a7, SYS_getprocessinfo
 44c:	48f5                	li	a7,29
 ecall
 44e:	00000073          	ecall
 ret
 452:	8082                	ret

0000000000000454 <shmget>:
.global shmget
shmget:
 li a7, SYS_shmget
 454:	48f9                	li	a7,30
 ecall
 456:	00000073          	ecall
 ret
 45a:	8082                	ret

000000000000045c <shmattach>:
.global shmattach
shmattach:
 li a7, SYS_shmattach
 45c:	48fd                	li	a7,31
 ecall
 45e:	00000073          	ecall
 ret
 462:	8082                	ret

0000000000000464 <shmdetach>:
.global shmdetach
shmdetach:
 li a7, SYS_shmdetach
 464:	02000893          	li	a7,32
 ecall
 468:	00000073          	ecall
 ret
 46c:	8082                	ret

000000000000046e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 46e:	1101                	addi	sp,sp,-32
 470:	ec06                	sd	ra,24(sp)
 472:	e822                	sd	s0,16(sp)
 474:	1000                	addi	s0,sp,32
 476:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 47a:	4605                	li	a2,1
 47c:	fef40593          	addi	a1,s0,-17
 480:	ee3ff0ef          	jal	362 <write>
}
 484:	60e2                	ld	ra,24(sp)
 486:	6442                	ld	s0,16(sp)
 488:	6105                	addi	sp,sp,32
 48a:	8082                	ret

000000000000048c <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 48c:	715d                	addi	sp,sp,-80
 48e:	e486                	sd	ra,72(sp)
 490:	e0a2                	sd	s0,64(sp)
 492:	f84a                	sd	s2,48(sp)
 494:	0880                	addi	s0,sp,80
 496:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 498:	c299                	beqz	a3,49e <printint+0x12>
 49a:	0805c363          	bltz	a1,520 <printint+0x94>
  neg = 0;
 49e:	4881                	li	a7,0
 4a0:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 4a4:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 4a6:	00000517          	auipc	a0,0x0
 4aa:	51250513          	addi	a0,a0,1298 # 9b8 <digits>
 4ae:	883e                	mv	a6,a5
 4b0:	2785                	addiw	a5,a5,1
 4b2:	02c5f733          	remu	a4,a1,a2
 4b6:	972a                	add	a4,a4,a0
 4b8:	00074703          	lbu	a4,0(a4)
 4bc:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 4c0:	872e                	mv	a4,a1
 4c2:	02c5d5b3          	divu	a1,a1,a2
 4c6:	0685                	addi	a3,a3,1
 4c8:	fec773e3          	bgeu	a4,a2,4ae <printint+0x22>
  if(neg)
 4cc:	00088b63          	beqz	a7,4e2 <printint+0x56>
    buf[i++] = '-';
 4d0:	fd078793          	addi	a5,a5,-48
 4d4:	97a2                	add	a5,a5,s0
 4d6:	02d00713          	li	a4,45
 4da:	fee78423          	sb	a4,-24(a5)
 4de:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
 4e2:	02f05a63          	blez	a5,516 <printint+0x8a>
 4e6:	fc26                	sd	s1,56(sp)
 4e8:	f44e                	sd	s3,40(sp)
 4ea:	fb840713          	addi	a4,s0,-72
 4ee:	00f704b3          	add	s1,a4,a5
 4f2:	fff70993          	addi	s3,a4,-1
 4f6:	99be                	add	s3,s3,a5
 4f8:	37fd                	addiw	a5,a5,-1
 4fa:	1782                	slli	a5,a5,0x20
 4fc:	9381                	srli	a5,a5,0x20
 4fe:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 502:	fff4c583          	lbu	a1,-1(s1)
 506:	854a                	mv	a0,s2
 508:	f67ff0ef          	jal	46e <putc>
  while(--i >= 0)
 50c:	14fd                	addi	s1,s1,-1
 50e:	ff349ae3          	bne	s1,s3,502 <printint+0x76>
 512:	74e2                	ld	s1,56(sp)
 514:	79a2                	ld	s3,40(sp)
}
 516:	60a6                	ld	ra,72(sp)
 518:	6406                	ld	s0,64(sp)
 51a:	7942                	ld	s2,48(sp)
 51c:	6161                	addi	sp,sp,80
 51e:	8082                	ret
    x = -xx;
 520:	40b005b3          	neg	a1,a1
    neg = 1;
 524:	4885                	li	a7,1
    x = -xx;
 526:	bfad                	j	4a0 <printint+0x14>

0000000000000528 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 528:	711d                	addi	sp,sp,-96
 52a:	ec86                	sd	ra,88(sp)
 52c:	e8a2                	sd	s0,80(sp)
 52e:	e0ca                	sd	s2,64(sp)
 530:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 532:	0005c903          	lbu	s2,0(a1)
 536:	28090663          	beqz	s2,7c2 <vprintf+0x29a>
 53a:	e4a6                	sd	s1,72(sp)
 53c:	fc4e                	sd	s3,56(sp)
 53e:	f852                	sd	s4,48(sp)
 540:	f456                	sd	s5,40(sp)
 542:	f05a                	sd	s6,32(sp)
 544:	ec5e                	sd	s7,24(sp)
 546:	e862                	sd	s8,16(sp)
 548:	e466                	sd	s9,8(sp)
 54a:	8b2a                	mv	s6,a0
 54c:	8a2e                	mv	s4,a1
 54e:	8bb2                	mv	s7,a2
  state = 0;
 550:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 552:	4481                	li	s1,0
 554:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 556:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 55a:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 55e:	06c00c93          	li	s9,108
 562:	a005                	j	582 <vprintf+0x5a>
        putc(fd, c0);
 564:	85ca                	mv	a1,s2
 566:	855a                	mv	a0,s6
 568:	f07ff0ef          	jal	46e <putc>
 56c:	a019                	j	572 <vprintf+0x4a>
    } else if(state == '%'){
 56e:	03598263          	beq	s3,s5,592 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 572:	2485                	addiw	s1,s1,1
 574:	8726                	mv	a4,s1
 576:	009a07b3          	add	a5,s4,s1
 57a:	0007c903          	lbu	s2,0(a5)
 57e:	22090a63          	beqz	s2,7b2 <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 582:	0009079b          	sext.w	a5,s2
    if(state == 0){
 586:	fe0994e3          	bnez	s3,56e <vprintf+0x46>
      if(c0 == '%'){
 58a:	fd579de3          	bne	a5,s5,564 <vprintf+0x3c>
        state = '%';
 58e:	89be                	mv	s3,a5
 590:	b7cd                	j	572 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 592:	00ea06b3          	add	a3,s4,a4
 596:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 59a:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 59c:	c681                	beqz	a3,5a4 <vprintf+0x7c>
 59e:	9752                	add	a4,a4,s4
 5a0:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 5a4:	05878363          	beq	a5,s8,5ea <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 5a8:	05978d63          	beq	a5,s9,602 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 5ac:	07500713          	li	a4,117
 5b0:	0ee78763          	beq	a5,a4,69e <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 5b4:	07800713          	li	a4,120
 5b8:	12e78963          	beq	a5,a4,6ea <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 5bc:	07000713          	li	a4,112
 5c0:	14e78e63          	beq	a5,a4,71c <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 5c4:	06300713          	li	a4,99
 5c8:	18e78e63          	beq	a5,a4,764 <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 5cc:	07300713          	li	a4,115
 5d0:	1ae78463          	beq	a5,a4,778 <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 5d4:	02500713          	li	a4,37
 5d8:	04e79563          	bne	a5,a4,622 <vprintf+0xfa>
        putc(fd, '%');
 5dc:	02500593          	li	a1,37
 5e0:	855a                	mv	a0,s6
 5e2:	e8dff0ef          	jal	46e <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 5e6:	4981                	li	s3,0
 5e8:	b769                	j	572 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 5ea:	008b8913          	addi	s2,s7,8
 5ee:	4685                	li	a3,1
 5f0:	4629                	li	a2,10
 5f2:	000ba583          	lw	a1,0(s7)
 5f6:	855a                	mv	a0,s6
 5f8:	e95ff0ef          	jal	48c <printint>
 5fc:	8bca                	mv	s7,s2
      state = 0;
 5fe:	4981                	li	s3,0
 600:	bf8d                	j	572 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 602:	06400793          	li	a5,100
 606:	02f68963          	beq	a3,a5,638 <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 60a:	06c00793          	li	a5,108
 60e:	04f68263          	beq	a3,a5,652 <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 612:	07500793          	li	a5,117
 616:	0af68063          	beq	a3,a5,6b6 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 61a:	07800793          	li	a5,120
 61e:	0ef68263          	beq	a3,a5,702 <vprintf+0x1da>
        putc(fd, '%');
 622:	02500593          	li	a1,37
 626:	855a                	mv	a0,s6
 628:	e47ff0ef          	jal	46e <putc>
        putc(fd, c0);
 62c:	85ca                	mv	a1,s2
 62e:	855a                	mv	a0,s6
 630:	e3fff0ef          	jal	46e <putc>
      state = 0;
 634:	4981                	li	s3,0
 636:	bf35                	j	572 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 638:	008b8913          	addi	s2,s7,8
 63c:	4685                	li	a3,1
 63e:	4629                	li	a2,10
 640:	000bb583          	ld	a1,0(s7)
 644:	855a                	mv	a0,s6
 646:	e47ff0ef          	jal	48c <printint>
        i += 1;
 64a:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 64c:	8bca                	mv	s7,s2
      state = 0;
 64e:	4981                	li	s3,0
        i += 1;
 650:	b70d                	j	572 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 652:	06400793          	li	a5,100
 656:	02f60763          	beq	a2,a5,684 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 65a:	07500793          	li	a5,117
 65e:	06f60963          	beq	a2,a5,6d0 <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 662:	07800793          	li	a5,120
 666:	faf61ee3          	bne	a2,a5,622 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 66a:	008b8913          	addi	s2,s7,8
 66e:	4681                	li	a3,0
 670:	4641                	li	a2,16
 672:	000bb583          	ld	a1,0(s7)
 676:	855a                	mv	a0,s6
 678:	e15ff0ef          	jal	48c <printint>
        i += 2;
 67c:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 67e:	8bca                	mv	s7,s2
      state = 0;
 680:	4981                	li	s3,0
        i += 2;
 682:	bdc5                	j	572 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 684:	008b8913          	addi	s2,s7,8
 688:	4685                	li	a3,1
 68a:	4629                	li	a2,10
 68c:	000bb583          	ld	a1,0(s7)
 690:	855a                	mv	a0,s6
 692:	dfbff0ef          	jal	48c <printint>
        i += 2;
 696:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 698:	8bca                	mv	s7,s2
      state = 0;
 69a:	4981                	li	s3,0
        i += 2;
 69c:	bdd9                	j	572 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 69e:	008b8913          	addi	s2,s7,8
 6a2:	4681                	li	a3,0
 6a4:	4629                	li	a2,10
 6a6:	000be583          	lwu	a1,0(s7)
 6aa:	855a                	mv	a0,s6
 6ac:	de1ff0ef          	jal	48c <printint>
 6b0:	8bca                	mv	s7,s2
      state = 0;
 6b2:	4981                	li	s3,0
 6b4:	bd7d                	j	572 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6b6:	008b8913          	addi	s2,s7,8
 6ba:	4681                	li	a3,0
 6bc:	4629                	li	a2,10
 6be:	000bb583          	ld	a1,0(s7)
 6c2:	855a                	mv	a0,s6
 6c4:	dc9ff0ef          	jal	48c <printint>
        i += 1;
 6c8:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 6ca:	8bca                	mv	s7,s2
      state = 0;
 6cc:	4981                	li	s3,0
        i += 1;
 6ce:	b555                	j	572 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6d0:	008b8913          	addi	s2,s7,8
 6d4:	4681                	li	a3,0
 6d6:	4629                	li	a2,10
 6d8:	000bb583          	ld	a1,0(s7)
 6dc:	855a                	mv	a0,s6
 6de:	dafff0ef          	jal	48c <printint>
        i += 2;
 6e2:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 6e4:	8bca                	mv	s7,s2
      state = 0;
 6e6:	4981                	li	s3,0
        i += 2;
 6e8:	b569                	j	572 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 6ea:	008b8913          	addi	s2,s7,8
 6ee:	4681                	li	a3,0
 6f0:	4641                	li	a2,16
 6f2:	000be583          	lwu	a1,0(s7)
 6f6:	855a                	mv	a0,s6
 6f8:	d95ff0ef          	jal	48c <printint>
 6fc:	8bca                	mv	s7,s2
      state = 0;
 6fe:	4981                	li	s3,0
 700:	bd8d                	j	572 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 702:	008b8913          	addi	s2,s7,8
 706:	4681                	li	a3,0
 708:	4641                	li	a2,16
 70a:	000bb583          	ld	a1,0(s7)
 70e:	855a                	mv	a0,s6
 710:	d7dff0ef          	jal	48c <printint>
        i += 1;
 714:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 716:	8bca                	mv	s7,s2
      state = 0;
 718:	4981                	li	s3,0
        i += 1;
 71a:	bda1                	j	572 <vprintf+0x4a>
 71c:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 71e:	008b8d13          	addi	s10,s7,8
 722:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 726:	03000593          	li	a1,48
 72a:	855a                	mv	a0,s6
 72c:	d43ff0ef          	jal	46e <putc>
  putc(fd, 'x');
 730:	07800593          	li	a1,120
 734:	855a                	mv	a0,s6
 736:	d39ff0ef          	jal	46e <putc>
 73a:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 73c:	00000b97          	auipc	s7,0x0
 740:	27cb8b93          	addi	s7,s7,636 # 9b8 <digits>
 744:	03c9d793          	srli	a5,s3,0x3c
 748:	97de                	add	a5,a5,s7
 74a:	0007c583          	lbu	a1,0(a5)
 74e:	855a                	mv	a0,s6
 750:	d1fff0ef          	jal	46e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 754:	0992                	slli	s3,s3,0x4
 756:	397d                	addiw	s2,s2,-1
 758:	fe0916e3          	bnez	s2,744 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 75c:	8bea                	mv	s7,s10
      state = 0;
 75e:	4981                	li	s3,0
 760:	6d02                	ld	s10,0(sp)
 762:	bd01                	j	572 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 764:	008b8913          	addi	s2,s7,8
 768:	000bc583          	lbu	a1,0(s7)
 76c:	855a                	mv	a0,s6
 76e:	d01ff0ef          	jal	46e <putc>
 772:	8bca                	mv	s7,s2
      state = 0;
 774:	4981                	li	s3,0
 776:	bbf5                	j	572 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 778:	008b8993          	addi	s3,s7,8
 77c:	000bb903          	ld	s2,0(s7)
 780:	00090f63          	beqz	s2,79e <vprintf+0x276>
        for(; *s; s++)
 784:	00094583          	lbu	a1,0(s2)
 788:	c195                	beqz	a1,7ac <vprintf+0x284>
          putc(fd, *s);
 78a:	855a                	mv	a0,s6
 78c:	ce3ff0ef          	jal	46e <putc>
        for(; *s; s++)
 790:	0905                	addi	s2,s2,1
 792:	00094583          	lbu	a1,0(s2)
 796:	f9f5                	bnez	a1,78a <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 798:	8bce                	mv	s7,s3
      state = 0;
 79a:	4981                	li	s3,0
 79c:	bbd9                	j	572 <vprintf+0x4a>
          s = "(null)";
 79e:	00000917          	auipc	s2,0x0
 7a2:	21290913          	addi	s2,s2,530 # 9b0 <malloc+0x106>
        for(; *s; s++)
 7a6:	02800593          	li	a1,40
 7aa:	b7c5                	j	78a <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 7ac:	8bce                	mv	s7,s3
      state = 0;
 7ae:	4981                	li	s3,0
 7b0:	b3c9                	j	572 <vprintf+0x4a>
 7b2:	64a6                	ld	s1,72(sp)
 7b4:	79e2                	ld	s3,56(sp)
 7b6:	7a42                	ld	s4,48(sp)
 7b8:	7aa2                	ld	s5,40(sp)
 7ba:	7b02                	ld	s6,32(sp)
 7bc:	6be2                	ld	s7,24(sp)
 7be:	6c42                	ld	s8,16(sp)
 7c0:	6ca2                	ld	s9,8(sp)
    }
  }
}
 7c2:	60e6                	ld	ra,88(sp)
 7c4:	6446                	ld	s0,80(sp)
 7c6:	6906                	ld	s2,64(sp)
 7c8:	6125                	addi	sp,sp,96
 7ca:	8082                	ret

00000000000007cc <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7cc:	715d                	addi	sp,sp,-80
 7ce:	ec06                	sd	ra,24(sp)
 7d0:	e822                	sd	s0,16(sp)
 7d2:	1000                	addi	s0,sp,32
 7d4:	e010                	sd	a2,0(s0)
 7d6:	e414                	sd	a3,8(s0)
 7d8:	e818                	sd	a4,16(s0)
 7da:	ec1c                	sd	a5,24(s0)
 7dc:	03043023          	sd	a6,32(s0)
 7e0:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 7e4:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 7e8:	8622                	mv	a2,s0
 7ea:	d3fff0ef          	jal	528 <vprintf>
}
 7ee:	60e2                	ld	ra,24(sp)
 7f0:	6442                	ld	s0,16(sp)
 7f2:	6161                	addi	sp,sp,80
 7f4:	8082                	ret

00000000000007f6 <printf>:

void
printf(const char *fmt, ...)
{
 7f6:	711d                	addi	sp,sp,-96
 7f8:	ec06                	sd	ra,24(sp)
 7fa:	e822                	sd	s0,16(sp)
 7fc:	1000                	addi	s0,sp,32
 7fe:	e40c                	sd	a1,8(s0)
 800:	e810                	sd	a2,16(s0)
 802:	ec14                	sd	a3,24(s0)
 804:	f018                	sd	a4,32(s0)
 806:	f41c                	sd	a5,40(s0)
 808:	03043823          	sd	a6,48(s0)
 80c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 810:	00840613          	addi	a2,s0,8
 814:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 818:	85aa                	mv	a1,a0
 81a:	4505                	li	a0,1
 81c:	d0dff0ef          	jal	528 <vprintf>
}
 820:	60e2                	ld	ra,24(sp)
 822:	6442                	ld	s0,16(sp)
 824:	6125                	addi	sp,sp,96
 826:	8082                	ret

0000000000000828 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 828:	1141                	addi	sp,sp,-16
 82a:	e422                	sd	s0,8(sp)
 82c:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 82e:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 832:	00000797          	auipc	a5,0x0
 836:	7ce7b783          	ld	a5,1998(a5) # 1000 <freep>
 83a:	a02d                	j	864 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 83c:	4618                	lw	a4,8(a2)
 83e:	9f2d                	addw	a4,a4,a1
 840:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 844:	6398                	ld	a4,0(a5)
 846:	6310                	ld	a2,0(a4)
 848:	a83d                	j	886 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 84a:	ff852703          	lw	a4,-8(a0)
 84e:	9f31                	addw	a4,a4,a2
 850:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 852:	ff053683          	ld	a3,-16(a0)
 856:	a091                	j	89a <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 858:	6398                	ld	a4,0(a5)
 85a:	00e7e463          	bltu	a5,a4,862 <free+0x3a>
 85e:	00e6ea63          	bltu	a3,a4,872 <free+0x4a>
{
 862:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 864:	fed7fae3          	bgeu	a5,a3,858 <free+0x30>
 868:	6398                	ld	a4,0(a5)
 86a:	00e6e463          	bltu	a3,a4,872 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 86e:	fee7eae3          	bltu	a5,a4,862 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 872:	ff852583          	lw	a1,-8(a0)
 876:	6390                	ld	a2,0(a5)
 878:	02059813          	slli	a6,a1,0x20
 87c:	01c85713          	srli	a4,a6,0x1c
 880:	9736                	add	a4,a4,a3
 882:	fae60de3          	beq	a2,a4,83c <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 886:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 88a:	4790                	lw	a2,8(a5)
 88c:	02061593          	slli	a1,a2,0x20
 890:	01c5d713          	srli	a4,a1,0x1c
 894:	973e                	add	a4,a4,a5
 896:	fae68ae3          	beq	a3,a4,84a <free+0x22>
    p->s.ptr = bp->s.ptr;
 89a:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 89c:	00000717          	auipc	a4,0x0
 8a0:	76f73223          	sd	a5,1892(a4) # 1000 <freep>
}
 8a4:	6422                	ld	s0,8(sp)
 8a6:	0141                	addi	sp,sp,16
 8a8:	8082                	ret

00000000000008aa <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8aa:	7139                	addi	sp,sp,-64
 8ac:	fc06                	sd	ra,56(sp)
 8ae:	f822                	sd	s0,48(sp)
 8b0:	f426                	sd	s1,40(sp)
 8b2:	ec4e                	sd	s3,24(sp)
 8b4:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8b6:	02051493          	slli	s1,a0,0x20
 8ba:	9081                	srli	s1,s1,0x20
 8bc:	04bd                	addi	s1,s1,15
 8be:	8091                	srli	s1,s1,0x4
 8c0:	0014899b          	addiw	s3,s1,1
 8c4:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 8c6:	00000517          	auipc	a0,0x0
 8ca:	73a53503          	ld	a0,1850(a0) # 1000 <freep>
 8ce:	c915                	beqz	a0,902 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8d0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 8d2:	4798                	lw	a4,8(a5)
 8d4:	08977a63          	bgeu	a4,s1,968 <malloc+0xbe>
 8d8:	f04a                	sd	s2,32(sp)
 8da:	e852                	sd	s4,16(sp)
 8dc:	e456                	sd	s5,8(sp)
 8de:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 8e0:	8a4e                	mv	s4,s3
 8e2:	0009871b          	sext.w	a4,s3
 8e6:	6685                	lui	a3,0x1
 8e8:	00d77363          	bgeu	a4,a3,8ee <malloc+0x44>
 8ec:	6a05                	lui	s4,0x1
 8ee:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 8f2:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8f6:	00000917          	auipc	s2,0x0
 8fa:	70a90913          	addi	s2,s2,1802 # 1000 <freep>
  if(p == SBRK_ERROR)
 8fe:	5afd                	li	s5,-1
 900:	a081                	j	940 <malloc+0x96>
 902:	f04a                	sd	s2,32(sp)
 904:	e852                	sd	s4,16(sp)
 906:	e456                	sd	s5,8(sp)
 908:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 90a:	00000797          	auipc	a5,0x0
 90e:	70678793          	addi	a5,a5,1798 # 1010 <base>
 912:	00000717          	auipc	a4,0x0
 916:	6ef73723          	sd	a5,1774(a4) # 1000 <freep>
 91a:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 91c:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 920:	b7c1                	j	8e0 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 922:	6398                	ld	a4,0(a5)
 924:	e118                	sd	a4,0(a0)
 926:	a8a9                	j	980 <malloc+0xd6>
  hp->s.size = nu;
 928:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 92c:	0541                	addi	a0,a0,16
 92e:	efbff0ef          	jal	828 <free>
  return freep;
 932:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 936:	c12d                	beqz	a0,998 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 938:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 93a:	4798                	lw	a4,8(a5)
 93c:	02977263          	bgeu	a4,s1,960 <malloc+0xb6>
    if(p == freep)
 940:	00093703          	ld	a4,0(s2)
 944:	853e                	mv	a0,a5
 946:	fef719e3          	bne	a4,a5,938 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 94a:	8552                	mv	a0,s4
 94c:	933ff0ef          	jal	27e <sbrk>
  if(p == SBRK_ERROR)
 950:	fd551ce3          	bne	a0,s5,928 <malloc+0x7e>
        return 0;
 954:	4501                	li	a0,0
 956:	7902                	ld	s2,32(sp)
 958:	6a42                	ld	s4,16(sp)
 95a:	6aa2                	ld	s5,8(sp)
 95c:	6b02                	ld	s6,0(sp)
 95e:	a03d                	j	98c <malloc+0xe2>
 960:	7902                	ld	s2,32(sp)
 962:	6a42                	ld	s4,16(sp)
 964:	6aa2                	ld	s5,8(sp)
 966:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 968:	fae48de3          	beq	s1,a4,922 <malloc+0x78>
        p->s.size -= nunits;
 96c:	4137073b          	subw	a4,a4,s3
 970:	c798                	sw	a4,8(a5)
        p += p->s.size;
 972:	02071693          	slli	a3,a4,0x20
 976:	01c6d713          	srli	a4,a3,0x1c
 97a:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 97c:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 980:	00000717          	auipc	a4,0x0
 984:	68a73023          	sd	a0,1664(a4) # 1000 <freep>
      return (void*)(p + 1);
 988:	01078513          	addi	a0,a5,16
  }
}
 98c:	70e2                	ld	ra,56(sp)
 98e:	7442                	ld	s0,48(sp)
 990:	74a2                	ld	s1,40(sp)
 992:	69e2                	ld	s3,24(sp)
 994:	6121                	addi	sp,sp,64
 996:	8082                	ret
 998:	7902                	ld	s2,32(sp)
 99a:	6a42                	ld	s4,16(sp)
 99c:	6aa2                	ld	s5,8(sp)
 99e:	6b02                	ld	s6,0(sp)
 9a0:	b7f5                	j	98c <malloc+0xe2>
