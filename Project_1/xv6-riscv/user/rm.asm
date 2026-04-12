
user/_rm:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	1000                	addi	s0,sp,32
  int i;

  if(argc < 2){
   8:	4785                	li	a5,1
   a:	02a7d763          	bge	a5,a0,38 <main+0x38>
   e:	e426                	sd	s1,8(sp)
  10:	e04a                	sd	s2,0(sp)
  12:	00858493          	addi	s1,a1,8
  16:	ffe5091b          	addiw	s2,a0,-2
  1a:	02091793          	slli	a5,s2,0x20
  1e:	01d7d913          	srli	s2,a5,0x1d
  22:	05c1                	addi	a1,a1,16
  24:	992e                	add	s2,s2,a1
    fprintf(2, "Usage: rm files...\n");
    exit(1);
  }

  for(i = 1; i < argc; i++){
    if(unlink(argv[i]) < 0){
  26:	6088                	ld	a0,0(s1)
  28:	3b2000ef          	jal	3da <unlink>
  2c:	02054263          	bltz	a0,50 <main+0x50>
  for(i = 1; i < argc; i++){
  30:	04a1                	addi	s1,s1,8
  32:	ff249ae3          	bne	s1,s2,26 <main+0x26>
  36:	a02d                	j	60 <main+0x60>
  38:	e426                	sd	s1,8(sp)
  3a:	e04a                	sd	s2,0(sp)
    fprintf(2, "Usage: rm files...\n");
  3c:	00001597          	auipc	a1,0x1
  40:	9b458593          	addi	a1,a1,-1612 # 9f0 <malloc+0xfe>
  44:	4509                	li	a0,2
  46:	7ce000ef          	jal	814 <fprintf>
    exit(1);
  4a:	4505                	li	a0,1
  4c:	33e000ef          	jal	38a <exit>
      fprintf(2, "rm: %s failed to delete\n", argv[i]);
  50:	6090                	ld	a2,0(s1)
  52:	00001597          	auipc	a1,0x1
  56:	9b658593          	addi	a1,a1,-1610 # a08 <malloc+0x116>
  5a:	4509                	li	a0,2
  5c:	7b8000ef          	jal	814 <fprintf>
      break;
    }
  }

  exit(0);
  60:	4501                	li	a0,0
  62:	328000ef          	jal	38a <exit>

0000000000000066 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
  66:	1141                	addi	sp,sp,-16
  68:	e406                	sd	ra,8(sp)
  6a:	e022                	sd	s0,0(sp)
  6c:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
  6e:	f93ff0ef          	jal	0 <main>
  exit(r);
  72:	318000ef          	jal	38a <exit>

0000000000000076 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  76:	1141                	addi	sp,sp,-16
  78:	e422                	sd	s0,8(sp)
  7a:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  7c:	87aa                	mv	a5,a0
  7e:	0585                	addi	a1,a1,1
  80:	0785                	addi	a5,a5,1
  82:	fff5c703          	lbu	a4,-1(a1)
  86:	fee78fa3          	sb	a4,-1(a5)
  8a:	fb75                	bnez	a4,7e <strcpy+0x8>
    ;
  return os;
}
  8c:	6422                	ld	s0,8(sp)
  8e:	0141                	addi	sp,sp,16
  90:	8082                	ret

0000000000000092 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  92:	1141                	addi	sp,sp,-16
  94:	e422                	sd	s0,8(sp)
  96:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  98:	00054783          	lbu	a5,0(a0)
  9c:	cb91                	beqz	a5,b0 <strcmp+0x1e>
  9e:	0005c703          	lbu	a4,0(a1)
  a2:	00f71763          	bne	a4,a5,b0 <strcmp+0x1e>
    p++, q++;
  a6:	0505                	addi	a0,a0,1
  a8:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  aa:	00054783          	lbu	a5,0(a0)
  ae:	fbe5                	bnez	a5,9e <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  b0:	0005c503          	lbu	a0,0(a1)
}
  b4:	40a7853b          	subw	a0,a5,a0
  b8:	6422                	ld	s0,8(sp)
  ba:	0141                	addi	sp,sp,16
  bc:	8082                	ret

00000000000000be <strlen>:

uint
strlen(const char *s)
{
  be:	1141                	addi	sp,sp,-16
  c0:	e422                	sd	s0,8(sp)
  c2:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  c4:	00054783          	lbu	a5,0(a0)
  c8:	cf91                	beqz	a5,e4 <strlen+0x26>
  ca:	0505                	addi	a0,a0,1
  cc:	87aa                	mv	a5,a0
  ce:	86be                	mv	a3,a5
  d0:	0785                	addi	a5,a5,1
  d2:	fff7c703          	lbu	a4,-1(a5)
  d6:	ff65                	bnez	a4,ce <strlen+0x10>
  d8:	40a6853b          	subw	a0,a3,a0
  dc:	2505                	addiw	a0,a0,1
    ;
  return n;
}
  de:	6422                	ld	s0,8(sp)
  e0:	0141                	addi	sp,sp,16
  e2:	8082                	ret
  for(n = 0; s[n]; n++)
  e4:	4501                	li	a0,0
  e6:	bfe5                	j	de <strlen+0x20>

00000000000000e8 <memset>:

void*
memset(void *dst, int c, uint n)
{
  e8:	1141                	addi	sp,sp,-16
  ea:	e422                	sd	s0,8(sp)
  ec:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  ee:	ca19                	beqz	a2,104 <memset+0x1c>
  f0:	87aa                	mv	a5,a0
  f2:	1602                	slli	a2,a2,0x20
  f4:	9201                	srli	a2,a2,0x20
  f6:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  fa:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  fe:	0785                	addi	a5,a5,1
 100:	fee79de3          	bne	a5,a4,fa <memset+0x12>
  }
  return dst;
}
 104:	6422                	ld	s0,8(sp)
 106:	0141                	addi	sp,sp,16
 108:	8082                	ret

000000000000010a <strchr>:

char*
strchr(const char *s, char c)
{
 10a:	1141                	addi	sp,sp,-16
 10c:	e422                	sd	s0,8(sp)
 10e:	0800                	addi	s0,sp,16
  for(; *s; s++)
 110:	00054783          	lbu	a5,0(a0)
 114:	cb99                	beqz	a5,12a <strchr+0x20>
    if(*s == c)
 116:	00f58763          	beq	a1,a5,124 <strchr+0x1a>
  for(; *s; s++)
 11a:	0505                	addi	a0,a0,1
 11c:	00054783          	lbu	a5,0(a0)
 120:	fbfd                	bnez	a5,116 <strchr+0xc>
      return (char*)s;
  return 0;
 122:	4501                	li	a0,0
}
 124:	6422                	ld	s0,8(sp)
 126:	0141                	addi	sp,sp,16
 128:	8082                	ret
  return 0;
 12a:	4501                	li	a0,0
 12c:	bfe5                	j	124 <strchr+0x1a>

000000000000012e <gets>:

char*
gets(char *buf, int max)
{
 12e:	711d                	addi	sp,sp,-96
 130:	ec86                	sd	ra,88(sp)
 132:	e8a2                	sd	s0,80(sp)
 134:	e4a6                	sd	s1,72(sp)
 136:	e0ca                	sd	s2,64(sp)
 138:	fc4e                	sd	s3,56(sp)
 13a:	f852                	sd	s4,48(sp)
 13c:	f456                	sd	s5,40(sp)
 13e:	f05a                	sd	s6,32(sp)
 140:	ec5e                	sd	s7,24(sp)
 142:	1080                	addi	s0,sp,96
 144:	8baa                	mv	s7,a0
 146:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 148:	892a                	mv	s2,a0
 14a:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 14c:	4aa9                	li	s5,10
 14e:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 150:	89a6                	mv	s3,s1
 152:	2485                	addiw	s1,s1,1
 154:	0344d663          	bge	s1,s4,180 <gets+0x52>
    cc = read(0, &c, 1);
 158:	4605                	li	a2,1
 15a:	faf40593          	addi	a1,s0,-81
 15e:	4501                	li	a0,0
 160:	242000ef          	jal	3a2 <read>
    if(cc < 1)
 164:	00a05e63          	blez	a0,180 <gets+0x52>
    buf[i++] = c;
 168:	faf44783          	lbu	a5,-81(s0)
 16c:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 170:	01578763          	beq	a5,s5,17e <gets+0x50>
 174:	0905                	addi	s2,s2,1
 176:	fd679de3          	bne	a5,s6,150 <gets+0x22>
    buf[i++] = c;
 17a:	89a6                	mv	s3,s1
 17c:	a011                	j	180 <gets+0x52>
 17e:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 180:	99de                	add	s3,s3,s7
 182:	00098023          	sb	zero,0(s3)
  return buf;
}
 186:	855e                	mv	a0,s7
 188:	60e6                	ld	ra,88(sp)
 18a:	6446                	ld	s0,80(sp)
 18c:	64a6                	ld	s1,72(sp)
 18e:	6906                	ld	s2,64(sp)
 190:	79e2                	ld	s3,56(sp)
 192:	7a42                	ld	s4,48(sp)
 194:	7aa2                	ld	s5,40(sp)
 196:	7b02                	ld	s6,32(sp)
 198:	6be2                	ld	s7,24(sp)
 19a:	6125                	addi	sp,sp,96
 19c:	8082                	ret

000000000000019e <stat>:

int
stat(const char *n, struct stat *st)
{
 19e:	1101                	addi	sp,sp,-32
 1a0:	ec06                	sd	ra,24(sp)
 1a2:	e822                	sd	s0,16(sp)
 1a4:	e04a                	sd	s2,0(sp)
 1a6:	1000                	addi	s0,sp,32
 1a8:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1aa:	4581                	li	a1,0
 1ac:	21e000ef          	jal	3ca <open>
  if(fd < 0)
 1b0:	02054263          	bltz	a0,1d4 <stat+0x36>
 1b4:	e426                	sd	s1,8(sp)
 1b6:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1b8:	85ca                	mv	a1,s2
 1ba:	228000ef          	jal	3e2 <fstat>
 1be:	892a                	mv	s2,a0
  close(fd);
 1c0:	8526                	mv	a0,s1
 1c2:	1f0000ef          	jal	3b2 <close>
  return r;
 1c6:	64a2                	ld	s1,8(sp)
}
 1c8:	854a                	mv	a0,s2
 1ca:	60e2                	ld	ra,24(sp)
 1cc:	6442                	ld	s0,16(sp)
 1ce:	6902                	ld	s2,0(sp)
 1d0:	6105                	addi	sp,sp,32
 1d2:	8082                	ret
    return -1;
 1d4:	597d                	li	s2,-1
 1d6:	bfcd                	j	1c8 <stat+0x2a>

00000000000001d8 <atoi>:

int
atoi(const char *s)
{
 1d8:	1141                	addi	sp,sp,-16
 1da:	e422                	sd	s0,8(sp)
 1dc:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1de:	00054683          	lbu	a3,0(a0)
 1e2:	fd06879b          	addiw	a5,a3,-48
 1e6:	0ff7f793          	zext.b	a5,a5
 1ea:	4625                	li	a2,9
 1ec:	02f66863          	bltu	a2,a5,21c <atoi+0x44>
 1f0:	872a                	mv	a4,a0
  n = 0;
 1f2:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 1f4:	0705                	addi	a4,a4,1
 1f6:	0025179b          	slliw	a5,a0,0x2
 1fa:	9fa9                	addw	a5,a5,a0
 1fc:	0017979b          	slliw	a5,a5,0x1
 200:	9fb5                	addw	a5,a5,a3
 202:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 206:	00074683          	lbu	a3,0(a4)
 20a:	fd06879b          	addiw	a5,a3,-48
 20e:	0ff7f793          	zext.b	a5,a5
 212:	fef671e3          	bgeu	a2,a5,1f4 <atoi+0x1c>
  return n;
}
 216:	6422                	ld	s0,8(sp)
 218:	0141                	addi	sp,sp,16
 21a:	8082                	ret
  n = 0;
 21c:	4501                	li	a0,0
 21e:	bfe5                	j	216 <atoi+0x3e>

0000000000000220 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 220:	1141                	addi	sp,sp,-16
 222:	e422                	sd	s0,8(sp)
 224:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 226:	02b57463          	bgeu	a0,a1,24e <memmove+0x2e>
    while(n-- > 0)
 22a:	00c05f63          	blez	a2,248 <memmove+0x28>
 22e:	1602                	slli	a2,a2,0x20
 230:	9201                	srli	a2,a2,0x20
 232:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 236:	872a                	mv	a4,a0
      *dst++ = *src++;
 238:	0585                	addi	a1,a1,1
 23a:	0705                	addi	a4,a4,1
 23c:	fff5c683          	lbu	a3,-1(a1)
 240:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 244:	fef71ae3          	bne	a4,a5,238 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 248:	6422                	ld	s0,8(sp)
 24a:	0141                	addi	sp,sp,16
 24c:	8082                	ret
    dst += n;
 24e:	00c50733          	add	a4,a0,a2
    src += n;
 252:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 254:	fec05ae3          	blez	a2,248 <memmove+0x28>
 258:	fff6079b          	addiw	a5,a2,-1
 25c:	1782                	slli	a5,a5,0x20
 25e:	9381                	srli	a5,a5,0x20
 260:	fff7c793          	not	a5,a5
 264:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 266:	15fd                	addi	a1,a1,-1
 268:	177d                	addi	a4,a4,-1
 26a:	0005c683          	lbu	a3,0(a1)
 26e:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 272:	fee79ae3          	bne	a5,a4,266 <memmove+0x46>
 276:	bfc9                	j	248 <memmove+0x28>

0000000000000278 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 278:	1141                	addi	sp,sp,-16
 27a:	e422                	sd	s0,8(sp)
 27c:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 27e:	ca05                	beqz	a2,2ae <memcmp+0x36>
 280:	fff6069b          	addiw	a3,a2,-1
 284:	1682                	slli	a3,a3,0x20
 286:	9281                	srli	a3,a3,0x20
 288:	0685                	addi	a3,a3,1
 28a:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 28c:	00054783          	lbu	a5,0(a0)
 290:	0005c703          	lbu	a4,0(a1)
 294:	00e79863          	bne	a5,a4,2a4 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 298:	0505                	addi	a0,a0,1
    p2++;
 29a:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 29c:	fed518e3          	bne	a0,a3,28c <memcmp+0x14>
  }
  return 0;
 2a0:	4501                	li	a0,0
 2a2:	a019                	j	2a8 <memcmp+0x30>
      return *p1 - *p2;
 2a4:	40e7853b          	subw	a0,a5,a4
}
 2a8:	6422                	ld	s0,8(sp)
 2aa:	0141                	addi	sp,sp,16
 2ac:	8082                	ret
  return 0;
 2ae:	4501                	li	a0,0
 2b0:	bfe5                	j	2a8 <memcmp+0x30>

00000000000002b2 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2b2:	1141                	addi	sp,sp,-16
 2b4:	e406                	sd	ra,8(sp)
 2b6:	e022                	sd	s0,0(sp)
 2b8:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2ba:	f67ff0ef          	jal	220 <memmove>
}
 2be:	60a2                	ld	ra,8(sp)
 2c0:	6402                	ld	s0,0(sp)
 2c2:	0141                	addi	sp,sp,16
 2c4:	8082                	ret

00000000000002c6 <sbrk>:

char *
sbrk(int n) {
 2c6:	1141                	addi	sp,sp,-16
 2c8:	e406                	sd	ra,8(sp)
 2ca:	e022                	sd	s0,0(sp)
 2cc:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 2ce:	4585                	li	a1,1
 2d0:	142000ef          	jal	412 <sys_sbrk>
}
 2d4:	60a2                	ld	ra,8(sp)
 2d6:	6402                	ld	s0,0(sp)
 2d8:	0141                	addi	sp,sp,16
 2da:	8082                	ret

00000000000002dc <sbrklazy>:

char *
sbrklazy(int n) {
 2dc:	1141                	addi	sp,sp,-16
 2de:	e406                	sd	ra,8(sp)
 2e0:	e022                	sd	s0,0(sp)
 2e2:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 2e4:	4589                	li	a1,2
 2e6:	12c000ef          	jal	412 <sys_sbrk>
}
 2ea:	60a2                	ld	ra,8(sp)
 2ec:	6402                	ld	s0,0(sp)
 2ee:	0141                	addi	sp,sp,16
 2f0:	8082                	ret

00000000000002f2 <thread_create>:
// thread_create allocates a page-sized stack, calls clone(fn, arg, stacktop).
// Returns the new thread's pid, or -1 on error.
// The stack is passed back via *stack so the caller can free it after join.
int
thread_create(void(*fn)(void*), void *arg, void **stack)
{
 2f2:	7179                	addi	sp,sp,-48
 2f4:	f406                	sd	ra,40(sp)
 2f6:	f022                	sd	s0,32(sp)
 2f8:	e84a                	sd	s2,16(sp)
 2fa:	e44e                	sd	s3,8(sp)
 2fc:	e052                	sd	s4,0(sp)
 2fe:	1800                	addi	s0,sp,48
 300:	89aa                	mv	s3,a0
 302:	8a2e                	mv	s4,a1
 304:	8932                	mv	s2,a2
  char *s = malloc(PGSIZE);
 306:	6505                	lui	a0,0x1
 308:	5ea000ef          	jal	8f2 <malloc>
  if(s == 0)
 30c:	cd0d                	beqz	a0,346 <thread_create+0x54>
 30e:	ec26                	sd	s1,24(sp)
 310:	84aa                	mv	s1,a0
    return -1;
  *stack = s;
 312:	00a93023          	sd	a0,0(s2)
  // Stack grows downward- pass the top of the allocated region.
  int pid = clone(fn, arg, s + PGSIZE);
 316:	6605                	lui	a2,0x1
 318:	962a                	add	a2,a2,a0
 31a:	85d2                	mv	a1,s4
 31c:	854e                	mv	a0,s3
 31e:	166000ef          	jal	484 <clone>
  if(pid < 0){
 322:	00054a63          	bltz	a0,336 <thread_create+0x44>
 326:	64e2                	ld	s1,24(sp)
    free(s);
    *stack = 0;
    return -1;
  }
  return pid;
}
 328:	70a2                	ld	ra,40(sp)
 32a:	7402                	ld	s0,32(sp)
 32c:	6942                	ld	s2,16(sp)
 32e:	69a2                	ld	s3,8(sp)
 330:	6a02                	ld	s4,0(sp)
 332:	6145                	addi	sp,sp,48
 334:	8082                	ret
    free(s);
 336:	8526                	mv	a0,s1
 338:	538000ef          	jal	870 <free>
    *stack = 0;
 33c:	00093023          	sd	zero,0(s2)
    return -1;
 340:	557d                	li	a0,-1
 342:	64e2                	ld	s1,24(sp)
 344:	b7d5                	j	328 <thread_create+0x36>
    return -1;
 346:	557d                	li	a0,-1
 348:	b7c5                	j	328 <thread_create+0x36>

000000000000034a <thread_join>:
// Wait for any child thread to exit.
// If stack is non-null, frees the memory pointed to by *stack and clears it.
// Returns the joined thread's pid, or -1 Son error.
int
thread_join(void **stack)
{
 34a:	1101                	addi	sp,sp,-32
 34c:	ec06                	sd	ra,24(sp)
 34e:	e822                	sd	s0,16(sp)
 350:	e426                	sd	s1,8(sp)
 352:	e04a                	sd	s2,0(sp)
 354:	1000                	addi	s0,sp,32
 356:	84aa                	mv	s1,a0
  int pid = join();
 358:	134000ef          	jal	48c <join>
  if(pid < 0)
 35c:	02054163          	bltz	a0,37e <thread_join+0x34>
 360:	892a                	mv	s2,a0
    return -1;
  if(stack && *stack){
 362:	c499                	beqz	s1,370 <thread_join+0x26>
 364:	6088                	ld	a0,0(s1)
 366:	c509                	beqz	a0,370 <thread_join+0x26>
    free(*stack);
 368:	508000ef          	jal	870 <free>
    *stack = 0;
 36c:	0004b023          	sd	zero,0(s1)
  }
  return pid;
}
 370:	854a                	mv	a0,s2
 372:	60e2                	ld	ra,24(sp)
 374:	6442                	ld	s0,16(sp)
 376:	64a2                	ld	s1,8(sp)
 378:	6902                	ld	s2,0(sp)
 37a:	6105                	addi	sp,sp,32
 37c:	8082                	ret
    return -1;
 37e:	597d                	li	s2,-1
 380:	bfc5                	j	370 <thread_join+0x26>

0000000000000382 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 382:	4885                	li	a7,1
 ecall
 384:	00000073          	ecall
 ret
 388:	8082                	ret

000000000000038a <exit>:
.global exit
exit:
 li a7, SYS_exit
 38a:	4889                	li	a7,2
 ecall
 38c:	00000073          	ecall
 ret
 390:	8082                	ret

0000000000000392 <wait>:
.global wait
wait:
 li a7, SYS_wait
 392:	488d                	li	a7,3
 ecall
 394:	00000073          	ecall
 ret
 398:	8082                	ret

000000000000039a <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 39a:	4891                	li	a7,4
 ecall
 39c:	00000073          	ecall
 ret
 3a0:	8082                	ret

00000000000003a2 <read>:
.global read
read:
 li a7, SYS_read
 3a2:	4895                	li	a7,5
 ecall
 3a4:	00000073          	ecall
 ret
 3a8:	8082                	ret

00000000000003aa <write>:
.global write
write:
 li a7, SYS_write
 3aa:	48c1                	li	a7,16
 ecall
 3ac:	00000073          	ecall
 ret
 3b0:	8082                	ret

00000000000003b2 <close>:
.global close
close:
 li a7, SYS_close
 3b2:	48d5                	li	a7,21
 ecall
 3b4:	00000073          	ecall
 ret
 3b8:	8082                	ret

00000000000003ba <kill>:
.global kill
kill:
 li a7, SYS_kill
 3ba:	4899                	li	a7,6
 ecall
 3bc:	00000073          	ecall
 ret
 3c0:	8082                	ret

00000000000003c2 <exec>:
.global exec
exec:
 li a7, SYS_exec
 3c2:	489d                	li	a7,7
 ecall
 3c4:	00000073          	ecall
 ret
 3c8:	8082                	ret

00000000000003ca <open>:
.global open
open:
 li a7, SYS_open
 3ca:	48bd                	li	a7,15
 ecall
 3cc:	00000073          	ecall
 ret
 3d0:	8082                	ret

00000000000003d2 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3d2:	48c5                	li	a7,17
 ecall
 3d4:	00000073          	ecall
 ret
 3d8:	8082                	ret

00000000000003da <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3da:	48c9                	li	a7,18
 ecall
 3dc:	00000073          	ecall
 ret
 3e0:	8082                	ret

00000000000003e2 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3e2:	48a1                	li	a7,8
 ecall
 3e4:	00000073          	ecall
 ret
 3e8:	8082                	ret

00000000000003ea <link>:
.global link
link:
 li a7, SYS_link
 3ea:	48cd                	li	a7,19
 ecall
 3ec:	00000073          	ecall
 ret
 3f0:	8082                	ret

00000000000003f2 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3f2:	48d1                	li	a7,20
 ecall
 3f4:	00000073          	ecall
 ret
 3f8:	8082                	ret

00000000000003fa <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3fa:	48a5                	li	a7,9
 ecall
 3fc:	00000073          	ecall
 ret
 400:	8082                	ret

0000000000000402 <dup>:
.global dup
dup:
 li a7, SYS_dup
 402:	48a9                	li	a7,10
 ecall
 404:	00000073          	ecall
 ret
 408:	8082                	ret

000000000000040a <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 40a:	48ad                	li	a7,11
 ecall
 40c:	00000073          	ecall
 ret
 410:	8082                	ret

0000000000000412 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 412:	48b1                	li	a7,12
 ecall
 414:	00000073          	ecall
 ret
 418:	8082                	ret

000000000000041a <pause>:
.global pause
pause:
 li a7, SYS_pause
 41a:	48b5                	li	a7,13
 ecall
 41c:	00000073          	ecall
 ret
 420:	8082                	ret

0000000000000422 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 422:	48b9                	li	a7,14
 ecall
 424:	00000073          	ecall
 ret
 428:	8082                	ret

000000000000042a <getppid>:
.global getppid
getppid:
 li a7, SYS_getppid
 42a:	02100893          	li	a7,33
 ecall
 42e:	00000073          	ecall
 ret
 432:	8082                	ret

0000000000000434 <ps>:
.global ps
ps:
 li a7, SYS_ps
 434:	02200893          	li	a7,34
 ecall
 438:	00000073          	ecall
 ret
 43c:	8082                	ret

000000000000043e <trace>:
.global trace
trace:
 li a7, SYS_trace
 43e:	02300893          	li	a7,35
 ecall
 442:	00000073          	ecall
 ret
 446:	8082                	ret

0000000000000448 <waitx>:
.global waitx
waitx:
 li a7, SYS_waitx
 448:	02400893          	li	a7,36
 ecall
 44c:	00000073          	ecall
 ret
 450:	8082                	ret

0000000000000452 <getcount>:
.global getcount
getcount:
 li a7, SYS_getcount
 452:	02500893          	li	a7,37
 ecall
 456:	00000073          	ecall
 ret
 45a:	8082                	ret

000000000000045c <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 45c:	48d9                	li	a7,22
 ecall
 45e:	00000073          	ecall
 ret
 462:	8082                	ret

0000000000000464 <lock_create>:
.global lock_create
lock_create:
 li a7, SYS_lock_create
 464:	48dd                	li	a7,23
 ecall
 466:	00000073          	ecall
 ret
 46a:	8082                	ret

000000000000046c <lock_acquire>:
.global lock_acquire
lock_acquire:
 li a7, SYS_lock_acquire
 46c:	48e1                	li	a7,24
 ecall
 46e:	00000073          	ecall
 ret
 472:	8082                	ret

0000000000000474 <lock_release>:
.global lock_release
lock_release:
 li a7, SYS_lock_release
 474:	48e5                	li	a7,25
 ecall
 476:	00000073          	ecall
 ret
 47a:	8082                	ret

000000000000047c <lock_destroy>:
.global lock_destroy
lock_destroy:
 li a7, SYS_lock_destroy
 47c:	48e9                	li	a7,26
 ecall
 47e:	00000073          	ecall
 ret
 482:	8082                	ret

0000000000000484 <clone>:
.global clone
clone:
 li a7, SYS_clone
 484:	48ed                	li	a7,27
 ecall
 486:	00000073          	ecall
 ret
 48a:	8082                	ret

000000000000048c <join>:
.global join
join:
 li a7, SYS_join
 48c:	48f1                	li	a7,28
 ecall
 48e:	00000073          	ecall
 ret
 492:	8082                	ret

0000000000000494 <getprocessinfo>:
.global getprocessinfo
getprocessinfo:
 li a7, SYS_getprocessinfo
 494:	48f5                	li	a7,29
 ecall
 496:	00000073          	ecall
 ret
 49a:	8082                	ret

000000000000049c <shmget>:
.global shmget
shmget:
 li a7, SYS_shmget
 49c:	48f9                	li	a7,30
 ecall
 49e:	00000073          	ecall
 ret
 4a2:	8082                	ret

00000000000004a4 <shmattach>:
.global shmattach
shmattach:
 li a7, SYS_shmattach
 4a4:	48fd                	li	a7,31
 ecall
 4a6:	00000073          	ecall
 ret
 4aa:	8082                	ret

00000000000004ac <shmdetach>:
.global shmdetach
shmdetach:
 li a7, SYS_shmdetach
 4ac:	02000893          	li	a7,32
 ecall
 4b0:	00000073          	ecall
 ret
 4b4:	8082                	ret

00000000000004b6 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4b6:	1101                	addi	sp,sp,-32
 4b8:	ec06                	sd	ra,24(sp)
 4ba:	e822                	sd	s0,16(sp)
 4bc:	1000                	addi	s0,sp,32
 4be:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4c2:	4605                	li	a2,1
 4c4:	fef40593          	addi	a1,s0,-17
 4c8:	ee3ff0ef          	jal	3aa <write>
}
 4cc:	60e2                	ld	ra,24(sp)
 4ce:	6442                	ld	s0,16(sp)
 4d0:	6105                	addi	sp,sp,32
 4d2:	8082                	ret

00000000000004d4 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 4d4:	715d                	addi	sp,sp,-80
 4d6:	e486                	sd	ra,72(sp)
 4d8:	e0a2                	sd	s0,64(sp)
 4da:	f84a                	sd	s2,48(sp)
 4dc:	0880                	addi	s0,sp,80
 4de:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 4e0:	c299                	beqz	a3,4e6 <printint+0x12>
 4e2:	0805c363          	bltz	a1,568 <printint+0x94>
  neg = 0;
 4e6:	4881                	li	a7,0
 4e8:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 4ec:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 4ee:	00000517          	auipc	a0,0x0
 4f2:	54250513          	addi	a0,a0,1346 # a30 <digits>
 4f6:	883e                	mv	a6,a5
 4f8:	2785                	addiw	a5,a5,1
 4fa:	02c5f733          	remu	a4,a1,a2
 4fe:	972a                	add	a4,a4,a0
 500:	00074703          	lbu	a4,0(a4)
 504:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 508:	872e                	mv	a4,a1
 50a:	02c5d5b3          	divu	a1,a1,a2
 50e:	0685                	addi	a3,a3,1
 510:	fec773e3          	bgeu	a4,a2,4f6 <printint+0x22>
  if(neg)
 514:	00088b63          	beqz	a7,52a <printint+0x56>
    buf[i++] = '-';
 518:	fd078793          	addi	a5,a5,-48
 51c:	97a2                	add	a5,a5,s0
 51e:	02d00713          	li	a4,45
 522:	fee78423          	sb	a4,-24(a5)
 526:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
 52a:	02f05a63          	blez	a5,55e <printint+0x8a>
 52e:	fc26                	sd	s1,56(sp)
 530:	f44e                	sd	s3,40(sp)
 532:	fb840713          	addi	a4,s0,-72
 536:	00f704b3          	add	s1,a4,a5
 53a:	fff70993          	addi	s3,a4,-1
 53e:	99be                	add	s3,s3,a5
 540:	37fd                	addiw	a5,a5,-1
 542:	1782                	slli	a5,a5,0x20
 544:	9381                	srli	a5,a5,0x20
 546:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 54a:	fff4c583          	lbu	a1,-1(s1)
 54e:	854a                	mv	a0,s2
 550:	f67ff0ef          	jal	4b6 <putc>
  while(--i >= 0)
 554:	14fd                	addi	s1,s1,-1
 556:	ff349ae3          	bne	s1,s3,54a <printint+0x76>
 55a:	74e2                	ld	s1,56(sp)
 55c:	79a2                	ld	s3,40(sp)
}
 55e:	60a6                	ld	ra,72(sp)
 560:	6406                	ld	s0,64(sp)
 562:	7942                	ld	s2,48(sp)
 564:	6161                	addi	sp,sp,80
 566:	8082                	ret
    x = -xx;
 568:	40b005b3          	neg	a1,a1
    neg = 1;
 56c:	4885                	li	a7,1
    x = -xx;
 56e:	bfad                	j	4e8 <printint+0x14>

0000000000000570 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 570:	711d                	addi	sp,sp,-96
 572:	ec86                	sd	ra,88(sp)
 574:	e8a2                	sd	s0,80(sp)
 576:	e0ca                	sd	s2,64(sp)
 578:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 57a:	0005c903          	lbu	s2,0(a1)
 57e:	28090663          	beqz	s2,80a <vprintf+0x29a>
 582:	e4a6                	sd	s1,72(sp)
 584:	fc4e                	sd	s3,56(sp)
 586:	f852                	sd	s4,48(sp)
 588:	f456                	sd	s5,40(sp)
 58a:	f05a                	sd	s6,32(sp)
 58c:	ec5e                	sd	s7,24(sp)
 58e:	e862                	sd	s8,16(sp)
 590:	e466                	sd	s9,8(sp)
 592:	8b2a                	mv	s6,a0
 594:	8a2e                	mv	s4,a1
 596:	8bb2                	mv	s7,a2
  state = 0;
 598:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 59a:	4481                	li	s1,0
 59c:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 59e:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 5a2:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 5a6:	06c00c93          	li	s9,108
 5aa:	a005                	j	5ca <vprintf+0x5a>
        putc(fd, c0);
 5ac:	85ca                	mv	a1,s2
 5ae:	855a                	mv	a0,s6
 5b0:	f07ff0ef          	jal	4b6 <putc>
 5b4:	a019                	j	5ba <vprintf+0x4a>
    } else if(state == '%'){
 5b6:	03598263          	beq	s3,s5,5da <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 5ba:	2485                	addiw	s1,s1,1
 5bc:	8726                	mv	a4,s1
 5be:	009a07b3          	add	a5,s4,s1
 5c2:	0007c903          	lbu	s2,0(a5)
 5c6:	22090a63          	beqz	s2,7fa <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 5ca:	0009079b          	sext.w	a5,s2
    if(state == 0){
 5ce:	fe0994e3          	bnez	s3,5b6 <vprintf+0x46>
      if(c0 == '%'){
 5d2:	fd579de3          	bne	a5,s5,5ac <vprintf+0x3c>
        state = '%';
 5d6:	89be                	mv	s3,a5
 5d8:	b7cd                	j	5ba <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 5da:	00ea06b3          	add	a3,s4,a4
 5de:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 5e2:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 5e4:	c681                	beqz	a3,5ec <vprintf+0x7c>
 5e6:	9752                	add	a4,a4,s4
 5e8:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 5ec:	05878363          	beq	a5,s8,632 <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 5f0:	05978d63          	beq	a5,s9,64a <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 5f4:	07500713          	li	a4,117
 5f8:	0ee78763          	beq	a5,a4,6e6 <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 5fc:	07800713          	li	a4,120
 600:	12e78963          	beq	a5,a4,732 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 604:	07000713          	li	a4,112
 608:	14e78e63          	beq	a5,a4,764 <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 60c:	06300713          	li	a4,99
 610:	18e78e63          	beq	a5,a4,7ac <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 614:	07300713          	li	a4,115
 618:	1ae78463          	beq	a5,a4,7c0 <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 61c:	02500713          	li	a4,37
 620:	04e79563          	bne	a5,a4,66a <vprintf+0xfa>
        putc(fd, '%');
 624:	02500593          	li	a1,37
 628:	855a                	mv	a0,s6
 62a:	e8dff0ef          	jal	4b6 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 62e:	4981                	li	s3,0
 630:	b769                	j	5ba <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 632:	008b8913          	addi	s2,s7,8
 636:	4685                	li	a3,1
 638:	4629                	li	a2,10
 63a:	000ba583          	lw	a1,0(s7)
 63e:	855a                	mv	a0,s6
 640:	e95ff0ef          	jal	4d4 <printint>
 644:	8bca                	mv	s7,s2
      state = 0;
 646:	4981                	li	s3,0
 648:	bf8d                	j	5ba <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 64a:	06400793          	li	a5,100
 64e:	02f68963          	beq	a3,a5,680 <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 652:	06c00793          	li	a5,108
 656:	04f68263          	beq	a3,a5,69a <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 65a:	07500793          	li	a5,117
 65e:	0af68063          	beq	a3,a5,6fe <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 662:	07800793          	li	a5,120
 666:	0ef68263          	beq	a3,a5,74a <vprintf+0x1da>
        putc(fd, '%');
 66a:	02500593          	li	a1,37
 66e:	855a                	mv	a0,s6
 670:	e47ff0ef          	jal	4b6 <putc>
        putc(fd, c0);
 674:	85ca                	mv	a1,s2
 676:	855a                	mv	a0,s6
 678:	e3fff0ef          	jal	4b6 <putc>
      state = 0;
 67c:	4981                	li	s3,0
 67e:	bf35                	j	5ba <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 680:	008b8913          	addi	s2,s7,8
 684:	4685                	li	a3,1
 686:	4629                	li	a2,10
 688:	000bb583          	ld	a1,0(s7)
 68c:	855a                	mv	a0,s6
 68e:	e47ff0ef          	jal	4d4 <printint>
        i += 1;
 692:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 694:	8bca                	mv	s7,s2
      state = 0;
 696:	4981                	li	s3,0
        i += 1;
 698:	b70d                	j	5ba <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 69a:	06400793          	li	a5,100
 69e:	02f60763          	beq	a2,a5,6cc <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 6a2:	07500793          	li	a5,117
 6a6:	06f60963          	beq	a2,a5,718 <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 6aa:	07800793          	li	a5,120
 6ae:	faf61ee3          	bne	a2,a5,66a <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6b2:	008b8913          	addi	s2,s7,8
 6b6:	4681                	li	a3,0
 6b8:	4641                	li	a2,16
 6ba:	000bb583          	ld	a1,0(s7)
 6be:	855a                	mv	a0,s6
 6c0:	e15ff0ef          	jal	4d4 <printint>
        i += 2;
 6c4:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 6c6:	8bca                	mv	s7,s2
      state = 0;
 6c8:	4981                	li	s3,0
        i += 2;
 6ca:	bdc5                	j	5ba <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 6cc:	008b8913          	addi	s2,s7,8
 6d0:	4685                	li	a3,1
 6d2:	4629                	li	a2,10
 6d4:	000bb583          	ld	a1,0(s7)
 6d8:	855a                	mv	a0,s6
 6da:	dfbff0ef          	jal	4d4 <printint>
        i += 2;
 6de:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 6e0:	8bca                	mv	s7,s2
      state = 0;
 6e2:	4981                	li	s3,0
        i += 2;
 6e4:	bdd9                	j	5ba <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 6e6:	008b8913          	addi	s2,s7,8
 6ea:	4681                	li	a3,0
 6ec:	4629                	li	a2,10
 6ee:	000be583          	lwu	a1,0(s7)
 6f2:	855a                	mv	a0,s6
 6f4:	de1ff0ef          	jal	4d4 <printint>
 6f8:	8bca                	mv	s7,s2
      state = 0;
 6fa:	4981                	li	s3,0
 6fc:	bd7d                	j	5ba <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6fe:	008b8913          	addi	s2,s7,8
 702:	4681                	li	a3,0
 704:	4629                	li	a2,10
 706:	000bb583          	ld	a1,0(s7)
 70a:	855a                	mv	a0,s6
 70c:	dc9ff0ef          	jal	4d4 <printint>
        i += 1;
 710:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 712:	8bca                	mv	s7,s2
      state = 0;
 714:	4981                	li	s3,0
        i += 1;
 716:	b555                	j	5ba <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 718:	008b8913          	addi	s2,s7,8
 71c:	4681                	li	a3,0
 71e:	4629                	li	a2,10
 720:	000bb583          	ld	a1,0(s7)
 724:	855a                	mv	a0,s6
 726:	dafff0ef          	jal	4d4 <printint>
        i += 2;
 72a:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 72c:	8bca                	mv	s7,s2
      state = 0;
 72e:	4981                	li	s3,0
        i += 2;
 730:	b569                	j	5ba <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 732:	008b8913          	addi	s2,s7,8
 736:	4681                	li	a3,0
 738:	4641                	li	a2,16
 73a:	000be583          	lwu	a1,0(s7)
 73e:	855a                	mv	a0,s6
 740:	d95ff0ef          	jal	4d4 <printint>
 744:	8bca                	mv	s7,s2
      state = 0;
 746:	4981                	li	s3,0
 748:	bd8d                	j	5ba <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 74a:	008b8913          	addi	s2,s7,8
 74e:	4681                	li	a3,0
 750:	4641                	li	a2,16
 752:	000bb583          	ld	a1,0(s7)
 756:	855a                	mv	a0,s6
 758:	d7dff0ef          	jal	4d4 <printint>
        i += 1;
 75c:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 75e:	8bca                	mv	s7,s2
      state = 0;
 760:	4981                	li	s3,0
        i += 1;
 762:	bda1                	j	5ba <vprintf+0x4a>
 764:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 766:	008b8d13          	addi	s10,s7,8
 76a:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 76e:	03000593          	li	a1,48
 772:	855a                	mv	a0,s6
 774:	d43ff0ef          	jal	4b6 <putc>
  putc(fd, 'x');
 778:	07800593          	li	a1,120
 77c:	855a                	mv	a0,s6
 77e:	d39ff0ef          	jal	4b6 <putc>
 782:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 784:	00000b97          	auipc	s7,0x0
 788:	2acb8b93          	addi	s7,s7,684 # a30 <digits>
 78c:	03c9d793          	srli	a5,s3,0x3c
 790:	97de                	add	a5,a5,s7
 792:	0007c583          	lbu	a1,0(a5)
 796:	855a                	mv	a0,s6
 798:	d1fff0ef          	jal	4b6 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 79c:	0992                	slli	s3,s3,0x4
 79e:	397d                	addiw	s2,s2,-1
 7a0:	fe0916e3          	bnez	s2,78c <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 7a4:	8bea                	mv	s7,s10
      state = 0;
 7a6:	4981                	li	s3,0
 7a8:	6d02                	ld	s10,0(sp)
 7aa:	bd01                	j	5ba <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 7ac:	008b8913          	addi	s2,s7,8
 7b0:	000bc583          	lbu	a1,0(s7)
 7b4:	855a                	mv	a0,s6
 7b6:	d01ff0ef          	jal	4b6 <putc>
 7ba:	8bca                	mv	s7,s2
      state = 0;
 7bc:	4981                	li	s3,0
 7be:	bbf5                	j	5ba <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 7c0:	008b8993          	addi	s3,s7,8
 7c4:	000bb903          	ld	s2,0(s7)
 7c8:	00090f63          	beqz	s2,7e6 <vprintf+0x276>
        for(; *s; s++)
 7cc:	00094583          	lbu	a1,0(s2)
 7d0:	c195                	beqz	a1,7f4 <vprintf+0x284>
          putc(fd, *s);
 7d2:	855a                	mv	a0,s6
 7d4:	ce3ff0ef          	jal	4b6 <putc>
        for(; *s; s++)
 7d8:	0905                	addi	s2,s2,1
 7da:	00094583          	lbu	a1,0(s2)
 7de:	f9f5                	bnez	a1,7d2 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 7e0:	8bce                	mv	s7,s3
      state = 0;
 7e2:	4981                	li	s3,0
 7e4:	bbd9                	j	5ba <vprintf+0x4a>
          s = "(null)";
 7e6:	00000917          	auipc	s2,0x0
 7ea:	24290913          	addi	s2,s2,578 # a28 <malloc+0x136>
        for(; *s; s++)
 7ee:	02800593          	li	a1,40
 7f2:	b7c5                	j	7d2 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 7f4:	8bce                	mv	s7,s3
      state = 0;
 7f6:	4981                	li	s3,0
 7f8:	b3c9                	j	5ba <vprintf+0x4a>
 7fa:	64a6                	ld	s1,72(sp)
 7fc:	79e2                	ld	s3,56(sp)
 7fe:	7a42                	ld	s4,48(sp)
 800:	7aa2                	ld	s5,40(sp)
 802:	7b02                	ld	s6,32(sp)
 804:	6be2                	ld	s7,24(sp)
 806:	6c42                	ld	s8,16(sp)
 808:	6ca2                	ld	s9,8(sp)
    }
  }
}
 80a:	60e6                	ld	ra,88(sp)
 80c:	6446                	ld	s0,80(sp)
 80e:	6906                	ld	s2,64(sp)
 810:	6125                	addi	sp,sp,96
 812:	8082                	ret

0000000000000814 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 814:	715d                	addi	sp,sp,-80
 816:	ec06                	sd	ra,24(sp)
 818:	e822                	sd	s0,16(sp)
 81a:	1000                	addi	s0,sp,32
 81c:	e010                	sd	a2,0(s0)
 81e:	e414                	sd	a3,8(s0)
 820:	e818                	sd	a4,16(s0)
 822:	ec1c                	sd	a5,24(s0)
 824:	03043023          	sd	a6,32(s0)
 828:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 82c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 830:	8622                	mv	a2,s0
 832:	d3fff0ef          	jal	570 <vprintf>
}
 836:	60e2                	ld	ra,24(sp)
 838:	6442                	ld	s0,16(sp)
 83a:	6161                	addi	sp,sp,80
 83c:	8082                	ret

000000000000083e <printf>:

void
printf(const char *fmt, ...)
{
 83e:	711d                	addi	sp,sp,-96
 840:	ec06                	sd	ra,24(sp)
 842:	e822                	sd	s0,16(sp)
 844:	1000                	addi	s0,sp,32
 846:	e40c                	sd	a1,8(s0)
 848:	e810                	sd	a2,16(s0)
 84a:	ec14                	sd	a3,24(s0)
 84c:	f018                	sd	a4,32(s0)
 84e:	f41c                	sd	a5,40(s0)
 850:	03043823          	sd	a6,48(s0)
 854:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 858:	00840613          	addi	a2,s0,8
 85c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 860:	85aa                	mv	a1,a0
 862:	4505                	li	a0,1
 864:	d0dff0ef          	jal	570 <vprintf>
}
 868:	60e2                	ld	ra,24(sp)
 86a:	6442                	ld	s0,16(sp)
 86c:	6125                	addi	sp,sp,96
 86e:	8082                	ret

0000000000000870 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 870:	1141                	addi	sp,sp,-16
 872:	e422                	sd	s0,8(sp)
 874:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 876:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 87a:	00000797          	auipc	a5,0x0
 87e:	7867b783          	ld	a5,1926(a5) # 1000 <freep>
 882:	a02d                	j	8ac <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 884:	4618                	lw	a4,8(a2)
 886:	9f2d                	addw	a4,a4,a1
 888:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 88c:	6398                	ld	a4,0(a5)
 88e:	6310                	ld	a2,0(a4)
 890:	a83d                	j	8ce <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 892:	ff852703          	lw	a4,-8(a0)
 896:	9f31                	addw	a4,a4,a2
 898:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 89a:	ff053683          	ld	a3,-16(a0)
 89e:	a091                	j	8e2 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8a0:	6398                	ld	a4,0(a5)
 8a2:	00e7e463          	bltu	a5,a4,8aa <free+0x3a>
 8a6:	00e6ea63          	bltu	a3,a4,8ba <free+0x4a>
{
 8aa:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8ac:	fed7fae3          	bgeu	a5,a3,8a0 <free+0x30>
 8b0:	6398                	ld	a4,0(a5)
 8b2:	00e6e463          	bltu	a3,a4,8ba <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8b6:	fee7eae3          	bltu	a5,a4,8aa <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 8ba:	ff852583          	lw	a1,-8(a0)
 8be:	6390                	ld	a2,0(a5)
 8c0:	02059813          	slli	a6,a1,0x20
 8c4:	01c85713          	srli	a4,a6,0x1c
 8c8:	9736                	add	a4,a4,a3
 8ca:	fae60de3          	beq	a2,a4,884 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 8ce:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8d2:	4790                	lw	a2,8(a5)
 8d4:	02061593          	slli	a1,a2,0x20
 8d8:	01c5d713          	srli	a4,a1,0x1c
 8dc:	973e                	add	a4,a4,a5
 8de:	fae68ae3          	beq	a3,a4,892 <free+0x22>
    p->s.ptr = bp->s.ptr;
 8e2:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 8e4:	00000717          	auipc	a4,0x0
 8e8:	70f73e23          	sd	a5,1820(a4) # 1000 <freep>
}
 8ec:	6422                	ld	s0,8(sp)
 8ee:	0141                	addi	sp,sp,16
 8f0:	8082                	ret

00000000000008f2 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8f2:	7139                	addi	sp,sp,-64
 8f4:	fc06                	sd	ra,56(sp)
 8f6:	f822                	sd	s0,48(sp)
 8f8:	f426                	sd	s1,40(sp)
 8fa:	ec4e                	sd	s3,24(sp)
 8fc:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8fe:	02051493          	slli	s1,a0,0x20
 902:	9081                	srli	s1,s1,0x20
 904:	04bd                	addi	s1,s1,15
 906:	8091                	srli	s1,s1,0x4
 908:	0014899b          	addiw	s3,s1,1
 90c:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 90e:	00000517          	auipc	a0,0x0
 912:	6f253503          	ld	a0,1778(a0) # 1000 <freep>
 916:	c915                	beqz	a0,94a <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 918:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 91a:	4798                	lw	a4,8(a5)
 91c:	08977a63          	bgeu	a4,s1,9b0 <malloc+0xbe>
 920:	f04a                	sd	s2,32(sp)
 922:	e852                	sd	s4,16(sp)
 924:	e456                	sd	s5,8(sp)
 926:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 928:	8a4e                	mv	s4,s3
 92a:	0009871b          	sext.w	a4,s3
 92e:	6685                	lui	a3,0x1
 930:	00d77363          	bgeu	a4,a3,936 <malloc+0x44>
 934:	6a05                	lui	s4,0x1
 936:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 93a:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 93e:	00000917          	auipc	s2,0x0
 942:	6c290913          	addi	s2,s2,1730 # 1000 <freep>
  if(p == SBRK_ERROR)
 946:	5afd                	li	s5,-1
 948:	a081                	j	988 <malloc+0x96>
 94a:	f04a                	sd	s2,32(sp)
 94c:	e852                	sd	s4,16(sp)
 94e:	e456                	sd	s5,8(sp)
 950:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 952:	00000797          	auipc	a5,0x0
 956:	6be78793          	addi	a5,a5,1726 # 1010 <base>
 95a:	00000717          	auipc	a4,0x0
 95e:	6af73323          	sd	a5,1702(a4) # 1000 <freep>
 962:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 964:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 968:	b7c1                	j	928 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 96a:	6398                	ld	a4,0(a5)
 96c:	e118                	sd	a4,0(a0)
 96e:	a8a9                	j	9c8 <malloc+0xd6>
  hp->s.size = nu;
 970:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 974:	0541                	addi	a0,a0,16
 976:	efbff0ef          	jal	870 <free>
  return freep;
 97a:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 97e:	c12d                	beqz	a0,9e0 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 980:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 982:	4798                	lw	a4,8(a5)
 984:	02977263          	bgeu	a4,s1,9a8 <malloc+0xb6>
    if(p == freep)
 988:	00093703          	ld	a4,0(s2)
 98c:	853e                	mv	a0,a5
 98e:	fef719e3          	bne	a4,a5,980 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 992:	8552                	mv	a0,s4
 994:	933ff0ef          	jal	2c6 <sbrk>
  if(p == SBRK_ERROR)
 998:	fd551ce3          	bne	a0,s5,970 <malloc+0x7e>
        return 0;
 99c:	4501                	li	a0,0
 99e:	7902                	ld	s2,32(sp)
 9a0:	6a42                	ld	s4,16(sp)
 9a2:	6aa2                	ld	s5,8(sp)
 9a4:	6b02                	ld	s6,0(sp)
 9a6:	a03d                	j	9d4 <malloc+0xe2>
 9a8:	7902                	ld	s2,32(sp)
 9aa:	6a42                	ld	s4,16(sp)
 9ac:	6aa2                	ld	s5,8(sp)
 9ae:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 9b0:	fae48de3          	beq	s1,a4,96a <malloc+0x78>
        p->s.size -= nunits;
 9b4:	4137073b          	subw	a4,a4,s3
 9b8:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9ba:	02071693          	slli	a3,a4,0x20
 9be:	01c6d713          	srli	a4,a3,0x1c
 9c2:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9c4:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9c8:	00000717          	auipc	a4,0x0
 9cc:	62a73c23          	sd	a0,1592(a4) # 1000 <freep>
      return (void*)(p + 1);
 9d0:	01078513          	addi	a0,a5,16
  }
}
 9d4:	70e2                	ld	ra,56(sp)
 9d6:	7442                	ld	s0,48(sp)
 9d8:	74a2                	ld	s1,40(sp)
 9da:	69e2                	ld	s3,24(sp)
 9dc:	6121                	addi	sp,sp,64
 9de:	8082                	ret
 9e0:	7902                	ld	s2,32(sp)
 9e2:	6a42                	ld	s4,16(sp)
 9e4:	6aa2                	ld	s5,8(sp)
 9e6:	6b02                	ld	s6,0(sp)
 9e8:	b7f5                	j	9d4 <malloc+0xe2>
