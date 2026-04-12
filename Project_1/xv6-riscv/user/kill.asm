
user/_kill:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char **argv)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	1000                	addi	s0,sp,32
  int i;

  if(argc < 2){
   8:	4785                	li	a5,1
   a:	02a7d963          	bge	a5,a0,3c <main+0x3c>
   e:	e426                	sd	s1,8(sp)
  10:	e04a                	sd	s2,0(sp)
  12:	00858493          	addi	s1,a1,8
  16:	ffe5091b          	addiw	s2,a0,-2
  1a:	02091793          	slli	a5,s2,0x20
  1e:	01d7d913          	srli	s2,a5,0x1d
  22:	05c1                	addi	a1,a1,16
  24:	992e                	add	s2,s2,a1
    fprintf(2, "usage: kill pid...\n");
    exit(1);
  }
  for(i=1; i<argc; i++)
    kill(atoi(argv[i]));
  26:	6088                	ld	a0,0(s1)
  28:	19e000ef          	jal	1c6 <atoi>
  2c:	37c000ef          	jal	3a8 <kill>
  for(i=1; i<argc; i++)
  30:	04a1                	addi	s1,s1,8
  32:	ff249ae3          	bne	s1,s2,26 <main+0x26>
  exit(0);
  36:	4501                	li	a0,0
  38:	340000ef          	jal	378 <exit>
  3c:	e426                	sd	s1,8(sp)
  3e:	e04a                	sd	s2,0(sp)
    fprintf(2, "usage: kill pid...\n");
  40:	00001597          	auipc	a1,0x1
  44:	9a058593          	addi	a1,a1,-1632 # 9e0 <malloc+0x100>
  48:	4509                	li	a0,2
  4a:	7b8000ef          	jal	802 <fprintf>
    exit(1);
  4e:	4505                	li	a0,1
  50:	328000ef          	jal	378 <exit>

0000000000000054 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
  54:	1141                	addi	sp,sp,-16
  56:	e406                	sd	ra,8(sp)
  58:	e022                	sd	s0,0(sp)
  5a:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
  5c:	fa5ff0ef          	jal	0 <main>
  exit(r);
  60:	318000ef          	jal	378 <exit>

0000000000000064 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  64:	1141                	addi	sp,sp,-16
  66:	e422                	sd	s0,8(sp)
  68:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  6a:	87aa                	mv	a5,a0
  6c:	0585                	addi	a1,a1,1
  6e:	0785                	addi	a5,a5,1
  70:	fff5c703          	lbu	a4,-1(a1)
  74:	fee78fa3          	sb	a4,-1(a5)
  78:	fb75                	bnez	a4,6c <strcpy+0x8>
    ;
  return os;
}
  7a:	6422                	ld	s0,8(sp)
  7c:	0141                	addi	sp,sp,16
  7e:	8082                	ret

0000000000000080 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80:	1141                	addi	sp,sp,-16
  82:	e422                	sd	s0,8(sp)
  84:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  86:	00054783          	lbu	a5,0(a0)
  8a:	cb91                	beqz	a5,9e <strcmp+0x1e>
  8c:	0005c703          	lbu	a4,0(a1)
  90:	00f71763          	bne	a4,a5,9e <strcmp+0x1e>
    p++, q++;
  94:	0505                	addi	a0,a0,1
  96:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  98:	00054783          	lbu	a5,0(a0)
  9c:	fbe5                	bnez	a5,8c <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  9e:	0005c503          	lbu	a0,0(a1)
}
  a2:	40a7853b          	subw	a0,a5,a0
  a6:	6422                	ld	s0,8(sp)
  a8:	0141                	addi	sp,sp,16
  aa:	8082                	ret

00000000000000ac <strlen>:

uint
strlen(const char *s)
{
  ac:	1141                	addi	sp,sp,-16
  ae:	e422                	sd	s0,8(sp)
  b0:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  b2:	00054783          	lbu	a5,0(a0)
  b6:	cf91                	beqz	a5,d2 <strlen+0x26>
  b8:	0505                	addi	a0,a0,1
  ba:	87aa                	mv	a5,a0
  bc:	86be                	mv	a3,a5
  be:	0785                	addi	a5,a5,1
  c0:	fff7c703          	lbu	a4,-1(a5)
  c4:	ff65                	bnez	a4,bc <strlen+0x10>
  c6:	40a6853b          	subw	a0,a3,a0
  ca:	2505                	addiw	a0,a0,1
    ;
  return n;
}
  cc:	6422                	ld	s0,8(sp)
  ce:	0141                	addi	sp,sp,16
  d0:	8082                	ret
  for(n = 0; s[n]; n++)
  d2:	4501                	li	a0,0
  d4:	bfe5                	j	cc <strlen+0x20>

00000000000000d6 <memset>:

void*
memset(void *dst, int c, uint n)
{
  d6:	1141                	addi	sp,sp,-16
  d8:	e422                	sd	s0,8(sp)
  da:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  dc:	ca19                	beqz	a2,f2 <memset+0x1c>
  de:	87aa                	mv	a5,a0
  e0:	1602                	slli	a2,a2,0x20
  e2:	9201                	srli	a2,a2,0x20
  e4:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  e8:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  ec:	0785                	addi	a5,a5,1
  ee:	fee79de3          	bne	a5,a4,e8 <memset+0x12>
  }
  return dst;
}
  f2:	6422                	ld	s0,8(sp)
  f4:	0141                	addi	sp,sp,16
  f6:	8082                	ret

00000000000000f8 <strchr>:

char*
strchr(const char *s, char c)
{
  f8:	1141                	addi	sp,sp,-16
  fa:	e422                	sd	s0,8(sp)
  fc:	0800                	addi	s0,sp,16
  for(; *s; s++)
  fe:	00054783          	lbu	a5,0(a0)
 102:	cb99                	beqz	a5,118 <strchr+0x20>
    if(*s == c)
 104:	00f58763          	beq	a1,a5,112 <strchr+0x1a>
  for(; *s; s++)
 108:	0505                	addi	a0,a0,1
 10a:	00054783          	lbu	a5,0(a0)
 10e:	fbfd                	bnez	a5,104 <strchr+0xc>
      return (char*)s;
  return 0;
 110:	4501                	li	a0,0
}
 112:	6422                	ld	s0,8(sp)
 114:	0141                	addi	sp,sp,16
 116:	8082                	ret
  return 0;
 118:	4501                	li	a0,0
 11a:	bfe5                	j	112 <strchr+0x1a>

000000000000011c <gets>:

char*
gets(char *buf, int max)
{
 11c:	711d                	addi	sp,sp,-96
 11e:	ec86                	sd	ra,88(sp)
 120:	e8a2                	sd	s0,80(sp)
 122:	e4a6                	sd	s1,72(sp)
 124:	e0ca                	sd	s2,64(sp)
 126:	fc4e                	sd	s3,56(sp)
 128:	f852                	sd	s4,48(sp)
 12a:	f456                	sd	s5,40(sp)
 12c:	f05a                	sd	s6,32(sp)
 12e:	ec5e                	sd	s7,24(sp)
 130:	1080                	addi	s0,sp,96
 132:	8baa                	mv	s7,a0
 134:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 136:	892a                	mv	s2,a0
 138:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 13a:	4aa9                	li	s5,10
 13c:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 13e:	89a6                	mv	s3,s1
 140:	2485                	addiw	s1,s1,1
 142:	0344d663          	bge	s1,s4,16e <gets+0x52>
    cc = read(0, &c, 1);
 146:	4605                	li	a2,1
 148:	faf40593          	addi	a1,s0,-81
 14c:	4501                	li	a0,0
 14e:	242000ef          	jal	390 <read>
    if(cc < 1)
 152:	00a05e63          	blez	a0,16e <gets+0x52>
    buf[i++] = c;
 156:	faf44783          	lbu	a5,-81(s0)
 15a:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 15e:	01578763          	beq	a5,s5,16c <gets+0x50>
 162:	0905                	addi	s2,s2,1
 164:	fd679de3          	bne	a5,s6,13e <gets+0x22>
    buf[i++] = c;
 168:	89a6                	mv	s3,s1
 16a:	a011                	j	16e <gets+0x52>
 16c:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 16e:	99de                	add	s3,s3,s7
 170:	00098023          	sb	zero,0(s3)
  return buf;
}
 174:	855e                	mv	a0,s7
 176:	60e6                	ld	ra,88(sp)
 178:	6446                	ld	s0,80(sp)
 17a:	64a6                	ld	s1,72(sp)
 17c:	6906                	ld	s2,64(sp)
 17e:	79e2                	ld	s3,56(sp)
 180:	7a42                	ld	s4,48(sp)
 182:	7aa2                	ld	s5,40(sp)
 184:	7b02                	ld	s6,32(sp)
 186:	6be2                	ld	s7,24(sp)
 188:	6125                	addi	sp,sp,96
 18a:	8082                	ret

000000000000018c <stat>:

int
stat(const char *n, struct stat *st)
{
 18c:	1101                	addi	sp,sp,-32
 18e:	ec06                	sd	ra,24(sp)
 190:	e822                	sd	s0,16(sp)
 192:	e04a                	sd	s2,0(sp)
 194:	1000                	addi	s0,sp,32
 196:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 198:	4581                	li	a1,0
 19a:	21e000ef          	jal	3b8 <open>
  if(fd < 0)
 19e:	02054263          	bltz	a0,1c2 <stat+0x36>
 1a2:	e426                	sd	s1,8(sp)
 1a4:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1a6:	85ca                	mv	a1,s2
 1a8:	228000ef          	jal	3d0 <fstat>
 1ac:	892a                	mv	s2,a0
  close(fd);
 1ae:	8526                	mv	a0,s1
 1b0:	1f0000ef          	jal	3a0 <close>
  return r;
 1b4:	64a2                	ld	s1,8(sp)
}
 1b6:	854a                	mv	a0,s2
 1b8:	60e2                	ld	ra,24(sp)
 1ba:	6442                	ld	s0,16(sp)
 1bc:	6902                	ld	s2,0(sp)
 1be:	6105                	addi	sp,sp,32
 1c0:	8082                	ret
    return -1;
 1c2:	597d                	li	s2,-1
 1c4:	bfcd                	j	1b6 <stat+0x2a>

00000000000001c6 <atoi>:

int
atoi(const char *s)
{
 1c6:	1141                	addi	sp,sp,-16
 1c8:	e422                	sd	s0,8(sp)
 1ca:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1cc:	00054683          	lbu	a3,0(a0)
 1d0:	fd06879b          	addiw	a5,a3,-48
 1d4:	0ff7f793          	zext.b	a5,a5
 1d8:	4625                	li	a2,9
 1da:	02f66863          	bltu	a2,a5,20a <atoi+0x44>
 1de:	872a                	mv	a4,a0
  n = 0;
 1e0:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 1e2:	0705                	addi	a4,a4,1
 1e4:	0025179b          	slliw	a5,a0,0x2
 1e8:	9fa9                	addw	a5,a5,a0
 1ea:	0017979b          	slliw	a5,a5,0x1
 1ee:	9fb5                	addw	a5,a5,a3
 1f0:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 1f4:	00074683          	lbu	a3,0(a4)
 1f8:	fd06879b          	addiw	a5,a3,-48
 1fc:	0ff7f793          	zext.b	a5,a5
 200:	fef671e3          	bgeu	a2,a5,1e2 <atoi+0x1c>
  return n;
}
 204:	6422                	ld	s0,8(sp)
 206:	0141                	addi	sp,sp,16
 208:	8082                	ret
  n = 0;
 20a:	4501                	li	a0,0
 20c:	bfe5                	j	204 <atoi+0x3e>

000000000000020e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 20e:	1141                	addi	sp,sp,-16
 210:	e422                	sd	s0,8(sp)
 212:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 214:	02b57463          	bgeu	a0,a1,23c <memmove+0x2e>
    while(n-- > 0)
 218:	00c05f63          	blez	a2,236 <memmove+0x28>
 21c:	1602                	slli	a2,a2,0x20
 21e:	9201                	srli	a2,a2,0x20
 220:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 224:	872a                	mv	a4,a0
      *dst++ = *src++;
 226:	0585                	addi	a1,a1,1
 228:	0705                	addi	a4,a4,1
 22a:	fff5c683          	lbu	a3,-1(a1)
 22e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 232:	fef71ae3          	bne	a4,a5,226 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 236:	6422                	ld	s0,8(sp)
 238:	0141                	addi	sp,sp,16
 23a:	8082                	ret
    dst += n;
 23c:	00c50733          	add	a4,a0,a2
    src += n;
 240:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 242:	fec05ae3          	blez	a2,236 <memmove+0x28>
 246:	fff6079b          	addiw	a5,a2,-1
 24a:	1782                	slli	a5,a5,0x20
 24c:	9381                	srli	a5,a5,0x20
 24e:	fff7c793          	not	a5,a5
 252:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 254:	15fd                	addi	a1,a1,-1
 256:	177d                	addi	a4,a4,-1
 258:	0005c683          	lbu	a3,0(a1)
 25c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 260:	fee79ae3          	bne	a5,a4,254 <memmove+0x46>
 264:	bfc9                	j	236 <memmove+0x28>

0000000000000266 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 266:	1141                	addi	sp,sp,-16
 268:	e422                	sd	s0,8(sp)
 26a:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 26c:	ca05                	beqz	a2,29c <memcmp+0x36>
 26e:	fff6069b          	addiw	a3,a2,-1
 272:	1682                	slli	a3,a3,0x20
 274:	9281                	srli	a3,a3,0x20
 276:	0685                	addi	a3,a3,1
 278:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 27a:	00054783          	lbu	a5,0(a0)
 27e:	0005c703          	lbu	a4,0(a1)
 282:	00e79863          	bne	a5,a4,292 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 286:	0505                	addi	a0,a0,1
    p2++;
 288:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 28a:	fed518e3          	bne	a0,a3,27a <memcmp+0x14>
  }
  return 0;
 28e:	4501                	li	a0,0
 290:	a019                	j	296 <memcmp+0x30>
      return *p1 - *p2;
 292:	40e7853b          	subw	a0,a5,a4
}
 296:	6422                	ld	s0,8(sp)
 298:	0141                	addi	sp,sp,16
 29a:	8082                	ret
  return 0;
 29c:	4501                	li	a0,0
 29e:	bfe5                	j	296 <memcmp+0x30>

00000000000002a0 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2a0:	1141                	addi	sp,sp,-16
 2a2:	e406                	sd	ra,8(sp)
 2a4:	e022                	sd	s0,0(sp)
 2a6:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2a8:	f67ff0ef          	jal	20e <memmove>
}
 2ac:	60a2                	ld	ra,8(sp)
 2ae:	6402                	ld	s0,0(sp)
 2b0:	0141                	addi	sp,sp,16
 2b2:	8082                	ret

00000000000002b4 <sbrk>:

char *
sbrk(int n) {
 2b4:	1141                	addi	sp,sp,-16
 2b6:	e406                	sd	ra,8(sp)
 2b8:	e022                	sd	s0,0(sp)
 2ba:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 2bc:	4585                	li	a1,1
 2be:	142000ef          	jal	400 <sys_sbrk>
}
 2c2:	60a2                	ld	ra,8(sp)
 2c4:	6402                	ld	s0,0(sp)
 2c6:	0141                	addi	sp,sp,16
 2c8:	8082                	ret

00000000000002ca <sbrklazy>:

char *
sbrklazy(int n) {
 2ca:	1141                	addi	sp,sp,-16
 2cc:	e406                	sd	ra,8(sp)
 2ce:	e022                	sd	s0,0(sp)
 2d0:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 2d2:	4589                	li	a1,2
 2d4:	12c000ef          	jal	400 <sys_sbrk>
}
 2d8:	60a2                	ld	ra,8(sp)
 2da:	6402                	ld	s0,0(sp)
 2dc:	0141                	addi	sp,sp,16
 2de:	8082                	ret

00000000000002e0 <thread_create>:
// thread_create allocates a page-sized stack, calls clone(fn, arg, stacktop).
// Returns the new thread's pid, or -1 on error.
// The stack is passed back via *stack so the caller can free it after join.
int
thread_create(void(*fn)(void*), void *arg, void **stack)
{
 2e0:	7179                	addi	sp,sp,-48
 2e2:	f406                	sd	ra,40(sp)
 2e4:	f022                	sd	s0,32(sp)
 2e6:	e84a                	sd	s2,16(sp)
 2e8:	e44e                	sd	s3,8(sp)
 2ea:	e052                	sd	s4,0(sp)
 2ec:	1800                	addi	s0,sp,48
 2ee:	89aa                	mv	s3,a0
 2f0:	8a2e                	mv	s4,a1
 2f2:	8932                	mv	s2,a2
  char *s = malloc(PGSIZE);
 2f4:	6505                	lui	a0,0x1
 2f6:	5ea000ef          	jal	8e0 <malloc>
  if(s == 0)
 2fa:	cd0d                	beqz	a0,334 <thread_create+0x54>
 2fc:	ec26                	sd	s1,24(sp)
 2fe:	84aa                	mv	s1,a0
    return -1;
  *stack = s;
 300:	00a93023          	sd	a0,0(s2)
  // Stack grows downward- pass the top of the allocated region.
  int pid = clone(fn, arg, s + PGSIZE);
 304:	6605                	lui	a2,0x1
 306:	962a                	add	a2,a2,a0
 308:	85d2                	mv	a1,s4
 30a:	854e                	mv	a0,s3
 30c:	166000ef          	jal	472 <clone>
  if(pid < 0){
 310:	00054a63          	bltz	a0,324 <thread_create+0x44>
 314:	64e2                	ld	s1,24(sp)
    free(s);
    *stack = 0;
    return -1;
  }
  return pid;
}
 316:	70a2                	ld	ra,40(sp)
 318:	7402                	ld	s0,32(sp)
 31a:	6942                	ld	s2,16(sp)
 31c:	69a2                	ld	s3,8(sp)
 31e:	6a02                	ld	s4,0(sp)
 320:	6145                	addi	sp,sp,48
 322:	8082                	ret
    free(s);
 324:	8526                	mv	a0,s1
 326:	538000ef          	jal	85e <free>
    *stack = 0;
 32a:	00093023          	sd	zero,0(s2)
    return -1;
 32e:	557d                	li	a0,-1
 330:	64e2                	ld	s1,24(sp)
 332:	b7d5                	j	316 <thread_create+0x36>
    return -1;
 334:	557d                	li	a0,-1
 336:	b7c5                	j	316 <thread_create+0x36>

0000000000000338 <thread_join>:
// Wait for any child thread to exit.
// If stack is non-null, frees the memory pointed to by *stack and clears it.
// Returns the joined thread's pid, or -1 Son error.
int
thread_join(void **stack)
{
 338:	1101                	addi	sp,sp,-32
 33a:	ec06                	sd	ra,24(sp)
 33c:	e822                	sd	s0,16(sp)
 33e:	e426                	sd	s1,8(sp)
 340:	e04a                	sd	s2,0(sp)
 342:	1000                	addi	s0,sp,32
 344:	84aa                	mv	s1,a0
  int pid = join();
 346:	134000ef          	jal	47a <join>
  if(pid < 0)
 34a:	02054163          	bltz	a0,36c <thread_join+0x34>
 34e:	892a                	mv	s2,a0
    return -1;
  if(stack && *stack){
 350:	c499                	beqz	s1,35e <thread_join+0x26>
 352:	6088                	ld	a0,0(s1)
 354:	c509                	beqz	a0,35e <thread_join+0x26>
    free(*stack);
 356:	508000ef          	jal	85e <free>
    *stack = 0;
 35a:	0004b023          	sd	zero,0(s1)
  }
  return pid;
}
 35e:	854a                	mv	a0,s2
 360:	60e2                	ld	ra,24(sp)
 362:	6442                	ld	s0,16(sp)
 364:	64a2                	ld	s1,8(sp)
 366:	6902                	ld	s2,0(sp)
 368:	6105                	addi	sp,sp,32
 36a:	8082                	ret
    return -1;
 36c:	597d                	li	s2,-1
 36e:	bfc5                	j	35e <thread_join+0x26>

0000000000000370 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 370:	4885                	li	a7,1
 ecall
 372:	00000073          	ecall
 ret
 376:	8082                	ret

0000000000000378 <exit>:
.global exit
exit:
 li a7, SYS_exit
 378:	4889                	li	a7,2
 ecall
 37a:	00000073          	ecall
 ret
 37e:	8082                	ret

0000000000000380 <wait>:
.global wait
wait:
 li a7, SYS_wait
 380:	488d                	li	a7,3
 ecall
 382:	00000073          	ecall
 ret
 386:	8082                	ret

0000000000000388 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 388:	4891                	li	a7,4
 ecall
 38a:	00000073          	ecall
 ret
 38e:	8082                	ret

0000000000000390 <read>:
.global read
read:
 li a7, SYS_read
 390:	4895                	li	a7,5
 ecall
 392:	00000073          	ecall
 ret
 396:	8082                	ret

0000000000000398 <write>:
.global write
write:
 li a7, SYS_write
 398:	48c1                	li	a7,16
 ecall
 39a:	00000073          	ecall
 ret
 39e:	8082                	ret

00000000000003a0 <close>:
.global close
close:
 li a7, SYS_close
 3a0:	48d5                	li	a7,21
 ecall
 3a2:	00000073          	ecall
 ret
 3a6:	8082                	ret

00000000000003a8 <kill>:
.global kill
kill:
 li a7, SYS_kill
 3a8:	4899                	li	a7,6
 ecall
 3aa:	00000073          	ecall
 ret
 3ae:	8082                	ret

00000000000003b0 <exec>:
.global exec
exec:
 li a7, SYS_exec
 3b0:	489d                	li	a7,7
 ecall
 3b2:	00000073          	ecall
 ret
 3b6:	8082                	ret

00000000000003b8 <open>:
.global open
open:
 li a7, SYS_open
 3b8:	48bd                	li	a7,15
 ecall
 3ba:	00000073          	ecall
 ret
 3be:	8082                	ret

00000000000003c0 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3c0:	48c5                	li	a7,17
 ecall
 3c2:	00000073          	ecall
 ret
 3c6:	8082                	ret

00000000000003c8 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3c8:	48c9                	li	a7,18
 ecall
 3ca:	00000073          	ecall
 ret
 3ce:	8082                	ret

00000000000003d0 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3d0:	48a1                	li	a7,8
 ecall
 3d2:	00000073          	ecall
 ret
 3d6:	8082                	ret

00000000000003d8 <link>:
.global link
link:
 li a7, SYS_link
 3d8:	48cd                	li	a7,19
 ecall
 3da:	00000073          	ecall
 ret
 3de:	8082                	ret

00000000000003e0 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3e0:	48d1                	li	a7,20
 ecall
 3e2:	00000073          	ecall
 ret
 3e6:	8082                	ret

00000000000003e8 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3e8:	48a5                	li	a7,9
 ecall
 3ea:	00000073          	ecall
 ret
 3ee:	8082                	ret

00000000000003f0 <dup>:
.global dup
dup:
 li a7, SYS_dup
 3f0:	48a9                	li	a7,10
 ecall
 3f2:	00000073          	ecall
 ret
 3f6:	8082                	ret

00000000000003f8 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3f8:	48ad                	li	a7,11
 ecall
 3fa:	00000073          	ecall
 ret
 3fe:	8082                	ret

0000000000000400 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 400:	48b1                	li	a7,12
 ecall
 402:	00000073          	ecall
 ret
 406:	8082                	ret

0000000000000408 <pause>:
.global pause
pause:
 li a7, SYS_pause
 408:	48b5                	li	a7,13
 ecall
 40a:	00000073          	ecall
 ret
 40e:	8082                	ret

0000000000000410 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 410:	48b9                	li	a7,14
 ecall
 412:	00000073          	ecall
 ret
 416:	8082                	ret

0000000000000418 <getppid>:
.global getppid
getppid:
 li a7, SYS_getppid
 418:	02100893          	li	a7,33
 ecall
 41c:	00000073          	ecall
 ret
 420:	8082                	ret

0000000000000422 <ps>:
.global ps
ps:
 li a7, SYS_ps
 422:	02200893          	li	a7,34
 ecall
 426:	00000073          	ecall
 ret
 42a:	8082                	ret

000000000000042c <trace>:
.global trace
trace:
 li a7, SYS_trace
 42c:	02300893          	li	a7,35
 ecall
 430:	00000073          	ecall
 ret
 434:	8082                	ret

0000000000000436 <waitx>:
.global waitx
waitx:
 li a7, SYS_waitx
 436:	02400893          	li	a7,36
 ecall
 43a:	00000073          	ecall
 ret
 43e:	8082                	ret

0000000000000440 <getcount>:
.global getcount
getcount:
 li a7, SYS_getcount
 440:	02500893          	li	a7,37
 ecall
 444:	00000073          	ecall
 ret
 448:	8082                	ret

000000000000044a <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 44a:	48d9                	li	a7,22
 ecall
 44c:	00000073          	ecall
 ret
 450:	8082                	ret

0000000000000452 <lock_create>:
.global lock_create
lock_create:
 li a7, SYS_lock_create
 452:	48dd                	li	a7,23
 ecall
 454:	00000073          	ecall
 ret
 458:	8082                	ret

000000000000045a <lock_acquire>:
.global lock_acquire
lock_acquire:
 li a7, SYS_lock_acquire
 45a:	48e1                	li	a7,24
 ecall
 45c:	00000073          	ecall
 ret
 460:	8082                	ret

0000000000000462 <lock_release>:
.global lock_release
lock_release:
 li a7, SYS_lock_release
 462:	48e5                	li	a7,25
 ecall
 464:	00000073          	ecall
 ret
 468:	8082                	ret

000000000000046a <lock_destroy>:
.global lock_destroy
lock_destroy:
 li a7, SYS_lock_destroy
 46a:	48e9                	li	a7,26
 ecall
 46c:	00000073          	ecall
 ret
 470:	8082                	ret

0000000000000472 <clone>:
.global clone
clone:
 li a7, SYS_clone
 472:	48ed                	li	a7,27
 ecall
 474:	00000073          	ecall
 ret
 478:	8082                	ret

000000000000047a <join>:
.global join
join:
 li a7, SYS_join
 47a:	48f1                	li	a7,28
 ecall
 47c:	00000073          	ecall
 ret
 480:	8082                	ret

0000000000000482 <getprocessinfo>:
.global getprocessinfo
getprocessinfo:
 li a7, SYS_getprocessinfo
 482:	48f5                	li	a7,29
 ecall
 484:	00000073          	ecall
 ret
 488:	8082                	ret

000000000000048a <shmget>:
.global shmget
shmget:
 li a7, SYS_shmget
 48a:	48f9                	li	a7,30
 ecall
 48c:	00000073          	ecall
 ret
 490:	8082                	ret

0000000000000492 <shmattach>:
.global shmattach
shmattach:
 li a7, SYS_shmattach
 492:	48fd                	li	a7,31
 ecall
 494:	00000073          	ecall
 ret
 498:	8082                	ret

000000000000049a <shmdetach>:
.global shmdetach
shmdetach:
 li a7, SYS_shmdetach
 49a:	02000893          	li	a7,32
 ecall
 49e:	00000073          	ecall
 ret
 4a2:	8082                	ret

00000000000004a4 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4a4:	1101                	addi	sp,sp,-32
 4a6:	ec06                	sd	ra,24(sp)
 4a8:	e822                	sd	s0,16(sp)
 4aa:	1000                	addi	s0,sp,32
 4ac:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4b0:	4605                	li	a2,1
 4b2:	fef40593          	addi	a1,s0,-17
 4b6:	ee3ff0ef          	jal	398 <write>
}
 4ba:	60e2                	ld	ra,24(sp)
 4bc:	6442                	ld	s0,16(sp)
 4be:	6105                	addi	sp,sp,32
 4c0:	8082                	ret

00000000000004c2 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 4c2:	715d                	addi	sp,sp,-80
 4c4:	e486                	sd	ra,72(sp)
 4c6:	e0a2                	sd	s0,64(sp)
 4c8:	f84a                	sd	s2,48(sp)
 4ca:	0880                	addi	s0,sp,80
 4cc:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 4ce:	c299                	beqz	a3,4d4 <printint+0x12>
 4d0:	0805c363          	bltz	a1,556 <printint+0x94>
  neg = 0;
 4d4:	4881                	li	a7,0
 4d6:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 4da:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 4dc:	00000517          	auipc	a0,0x0
 4e0:	52450513          	addi	a0,a0,1316 # a00 <digits>
 4e4:	883e                	mv	a6,a5
 4e6:	2785                	addiw	a5,a5,1
 4e8:	02c5f733          	remu	a4,a1,a2
 4ec:	972a                	add	a4,a4,a0
 4ee:	00074703          	lbu	a4,0(a4)
 4f2:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 4f6:	872e                	mv	a4,a1
 4f8:	02c5d5b3          	divu	a1,a1,a2
 4fc:	0685                	addi	a3,a3,1
 4fe:	fec773e3          	bgeu	a4,a2,4e4 <printint+0x22>
  if(neg)
 502:	00088b63          	beqz	a7,518 <printint+0x56>
    buf[i++] = '-';
 506:	fd078793          	addi	a5,a5,-48
 50a:	97a2                	add	a5,a5,s0
 50c:	02d00713          	li	a4,45
 510:	fee78423          	sb	a4,-24(a5)
 514:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
 518:	02f05a63          	blez	a5,54c <printint+0x8a>
 51c:	fc26                	sd	s1,56(sp)
 51e:	f44e                	sd	s3,40(sp)
 520:	fb840713          	addi	a4,s0,-72
 524:	00f704b3          	add	s1,a4,a5
 528:	fff70993          	addi	s3,a4,-1
 52c:	99be                	add	s3,s3,a5
 52e:	37fd                	addiw	a5,a5,-1
 530:	1782                	slli	a5,a5,0x20
 532:	9381                	srli	a5,a5,0x20
 534:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 538:	fff4c583          	lbu	a1,-1(s1)
 53c:	854a                	mv	a0,s2
 53e:	f67ff0ef          	jal	4a4 <putc>
  while(--i >= 0)
 542:	14fd                	addi	s1,s1,-1
 544:	ff349ae3          	bne	s1,s3,538 <printint+0x76>
 548:	74e2                	ld	s1,56(sp)
 54a:	79a2                	ld	s3,40(sp)
}
 54c:	60a6                	ld	ra,72(sp)
 54e:	6406                	ld	s0,64(sp)
 550:	7942                	ld	s2,48(sp)
 552:	6161                	addi	sp,sp,80
 554:	8082                	ret
    x = -xx;
 556:	40b005b3          	neg	a1,a1
    neg = 1;
 55a:	4885                	li	a7,1
    x = -xx;
 55c:	bfad                	j	4d6 <printint+0x14>

000000000000055e <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 55e:	711d                	addi	sp,sp,-96
 560:	ec86                	sd	ra,88(sp)
 562:	e8a2                	sd	s0,80(sp)
 564:	e0ca                	sd	s2,64(sp)
 566:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 568:	0005c903          	lbu	s2,0(a1)
 56c:	28090663          	beqz	s2,7f8 <vprintf+0x29a>
 570:	e4a6                	sd	s1,72(sp)
 572:	fc4e                	sd	s3,56(sp)
 574:	f852                	sd	s4,48(sp)
 576:	f456                	sd	s5,40(sp)
 578:	f05a                	sd	s6,32(sp)
 57a:	ec5e                	sd	s7,24(sp)
 57c:	e862                	sd	s8,16(sp)
 57e:	e466                	sd	s9,8(sp)
 580:	8b2a                	mv	s6,a0
 582:	8a2e                	mv	s4,a1
 584:	8bb2                	mv	s7,a2
  state = 0;
 586:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 588:	4481                	li	s1,0
 58a:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 58c:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 590:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 594:	06c00c93          	li	s9,108
 598:	a005                	j	5b8 <vprintf+0x5a>
        putc(fd, c0);
 59a:	85ca                	mv	a1,s2
 59c:	855a                	mv	a0,s6
 59e:	f07ff0ef          	jal	4a4 <putc>
 5a2:	a019                	j	5a8 <vprintf+0x4a>
    } else if(state == '%'){
 5a4:	03598263          	beq	s3,s5,5c8 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 5a8:	2485                	addiw	s1,s1,1
 5aa:	8726                	mv	a4,s1
 5ac:	009a07b3          	add	a5,s4,s1
 5b0:	0007c903          	lbu	s2,0(a5)
 5b4:	22090a63          	beqz	s2,7e8 <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 5b8:	0009079b          	sext.w	a5,s2
    if(state == 0){
 5bc:	fe0994e3          	bnez	s3,5a4 <vprintf+0x46>
      if(c0 == '%'){
 5c0:	fd579de3          	bne	a5,s5,59a <vprintf+0x3c>
        state = '%';
 5c4:	89be                	mv	s3,a5
 5c6:	b7cd                	j	5a8 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 5c8:	00ea06b3          	add	a3,s4,a4
 5cc:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 5d0:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 5d2:	c681                	beqz	a3,5da <vprintf+0x7c>
 5d4:	9752                	add	a4,a4,s4
 5d6:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 5da:	05878363          	beq	a5,s8,620 <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 5de:	05978d63          	beq	a5,s9,638 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 5e2:	07500713          	li	a4,117
 5e6:	0ee78763          	beq	a5,a4,6d4 <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 5ea:	07800713          	li	a4,120
 5ee:	12e78963          	beq	a5,a4,720 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 5f2:	07000713          	li	a4,112
 5f6:	14e78e63          	beq	a5,a4,752 <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 5fa:	06300713          	li	a4,99
 5fe:	18e78e63          	beq	a5,a4,79a <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 602:	07300713          	li	a4,115
 606:	1ae78463          	beq	a5,a4,7ae <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 60a:	02500713          	li	a4,37
 60e:	04e79563          	bne	a5,a4,658 <vprintf+0xfa>
        putc(fd, '%');
 612:	02500593          	li	a1,37
 616:	855a                	mv	a0,s6
 618:	e8dff0ef          	jal	4a4 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 61c:	4981                	li	s3,0
 61e:	b769                	j	5a8 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 620:	008b8913          	addi	s2,s7,8
 624:	4685                	li	a3,1
 626:	4629                	li	a2,10
 628:	000ba583          	lw	a1,0(s7)
 62c:	855a                	mv	a0,s6
 62e:	e95ff0ef          	jal	4c2 <printint>
 632:	8bca                	mv	s7,s2
      state = 0;
 634:	4981                	li	s3,0
 636:	bf8d                	j	5a8 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 638:	06400793          	li	a5,100
 63c:	02f68963          	beq	a3,a5,66e <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 640:	06c00793          	li	a5,108
 644:	04f68263          	beq	a3,a5,688 <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 648:	07500793          	li	a5,117
 64c:	0af68063          	beq	a3,a5,6ec <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 650:	07800793          	li	a5,120
 654:	0ef68263          	beq	a3,a5,738 <vprintf+0x1da>
        putc(fd, '%');
 658:	02500593          	li	a1,37
 65c:	855a                	mv	a0,s6
 65e:	e47ff0ef          	jal	4a4 <putc>
        putc(fd, c0);
 662:	85ca                	mv	a1,s2
 664:	855a                	mv	a0,s6
 666:	e3fff0ef          	jal	4a4 <putc>
      state = 0;
 66a:	4981                	li	s3,0
 66c:	bf35                	j	5a8 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 66e:	008b8913          	addi	s2,s7,8
 672:	4685                	li	a3,1
 674:	4629                	li	a2,10
 676:	000bb583          	ld	a1,0(s7)
 67a:	855a                	mv	a0,s6
 67c:	e47ff0ef          	jal	4c2 <printint>
        i += 1;
 680:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 682:	8bca                	mv	s7,s2
      state = 0;
 684:	4981                	li	s3,0
        i += 1;
 686:	b70d                	j	5a8 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 688:	06400793          	li	a5,100
 68c:	02f60763          	beq	a2,a5,6ba <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 690:	07500793          	li	a5,117
 694:	06f60963          	beq	a2,a5,706 <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 698:	07800793          	li	a5,120
 69c:	faf61ee3          	bne	a2,a5,658 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6a0:	008b8913          	addi	s2,s7,8
 6a4:	4681                	li	a3,0
 6a6:	4641                	li	a2,16
 6a8:	000bb583          	ld	a1,0(s7)
 6ac:	855a                	mv	a0,s6
 6ae:	e15ff0ef          	jal	4c2 <printint>
        i += 2;
 6b2:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 6b4:	8bca                	mv	s7,s2
      state = 0;
 6b6:	4981                	li	s3,0
        i += 2;
 6b8:	bdc5                	j	5a8 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 6ba:	008b8913          	addi	s2,s7,8
 6be:	4685                	li	a3,1
 6c0:	4629                	li	a2,10
 6c2:	000bb583          	ld	a1,0(s7)
 6c6:	855a                	mv	a0,s6
 6c8:	dfbff0ef          	jal	4c2 <printint>
        i += 2;
 6cc:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 6ce:	8bca                	mv	s7,s2
      state = 0;
 6d0:	4981                	li	s3,0
        i += 2;
 6d2:	bdd9                	j	5a8 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 6d4:	008b8913          	addi	s2,s7,8
 6d8:	4681                	li	a3,0
 6da:	4629                	li	a2,10
 6dc:	000be583          	lwu	a1,0(s7)
 6e0:	855a                	mv	a0,s6
 6e2:	de1ff0ef          	jal	4c2 <printint>
 6e6:	8bca                	mv	s7,s2
      state = 0;
 6e8:	4981                	li	s3,0
 6ea:	bd7d                	j	5a8 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6ec:	008b8913          	addi	s2,s7,8
 6f0:	4681                	li	a3,0
 6f2:	4629                	li	a2,10
 6f4:	000bb583          	ld	a1,0(s7)
 6f8:	855a                	mv	a0,s6
 6fa:	dc9ff0ef          	jal	4c2 <printint>
        i += 1;
 6fe:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 700:	8bca                	mv	s7,s2
      state = 0;
 702:	4981                	li	s3,0
        i += 1;
 704:	b555                	j	5a8 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 706:	008b8913          	addi	s2,s7,8
 70a:	4681                	li	a3,0
 70c:	4629                	li	a2,10
 70e:	000bb583          	ld	a1,0(s7)
 712:	855a                	mv	a0,s6
 714:	dafff0ef          	jal	4c2 <printint>
        i += 2;
 718:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 71a:	8bca                	mv	s7,s2
      state = 0;
 71c:	4981                	li	s3,0
        i += 2;
 71e:	b569                	j	5a8 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 720:	008b8913          	addi	s2,s7,8
 724:	4681                	li	a3,0
 726:	4641                	li	a2,16
 728:	000be583          	lwu	a1,0(s7)
 72c:	855a                	mv	a0,s6
 72e:	d95ff0ef          	jal	4c2 <printint>
 732:	8bca                	mv	s7,s2
      state = 0;
 734:	4981                	li	s3,0
 736:	bd8d                	j	5a8 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 738:	008b8913          	addi	s2,s7,8
 73c:	4681                	li	a3,0
 73e:	4641                	li	a2,16
 740:	000bb583          	ld	a1,0(s7)
 744:	855a                	mv	a0,s6
 746:	d7dff0ef          	jal	4c2 <printint>
        i += 1;
 74a:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 74c:	8bca                	mv	s7,s2
      state = 0;
 74e:	4981                	li	s3,0
        i += 1;
 750:	bda1                	j	5a8 <vprintf+0x4a>
 752:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 754:	008b8d13          	addi	s10,s7,8
 758:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 75c:	03000593          	li	a1,48
 760:	855a                	mv	a0,s6
 762:	d43ff0ef          	jal	4a4 <putc>
  putc(fd, 'x');
 766:	07800593          	li	a1,120
 76a:	855a                	mv	a0,s6
 76c:	d39ff0ef          	jal	4a4 <putc>
 770:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 772:	00000b97          	auipc	s7,0x0
 776:	28eb8b93          	addi	s7,s7,654 # a00 <digits>
 77a:	03c9d793          	srli	a5,s3,0x3c
 77e:	97de                	add	a5,a5,s7
 780:	0007c583          	lbu	a1,0(a5)
 784:	855a                	mv	a0,s6
 786:	d1fff0ef          	jal	4a4 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 78a:	0992                	slli	s3,s3,0x4
 78c:	397d                	addiw	s2,s2,-1
 78e:	fe0916e3          	bnez	s2,77a <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 792:	8bea                	mv	s7,s10
      state = 0;
 794:	4981                	li	s3,0
 796:	6d02                	ld	s10,0(sp)
 798:	bd01                	j	5a8 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 79a:	008b8913          	addi	s2,s7,8
 79e:	000bc583          	lbu	a1,0(s7)
 7a2:	855a                	mv	a0,s6
 7a4:	d01ff0ef          	jal	4a4 <putc>
 7a8:	8bca                	mv	s7,s2
      state = 0;
 7aa:	4981                	li	s3,0
 7ac:	bbf5                	j	5a8 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 7ae:	008b8993          	addi	s3,s7,8
 7b2:	000bb903          	ld	s2,0(s7)
 7b6:	00090f63          	beqz	s2,7d4 <vprintf+0x276>
        for(; *s; s++)
 7ba:	00094583          	lbu	a1,0(s2)
 7be:	c195                	beqz	a1,7e2 <vprintf+0x284>
          putc(fd, *s);
 7c0:	855a                	mv	a0,s6
 7c2:	ce3ff0ef          	jal	4a4 <putc>
        for(; *s; s++)
 7c6:	0905                	addi	s2,s2,1
 7c8:	00094583          	lbu	a1,0(s2)
 7cc:	f9f5                	bnez	a1,7c0 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 7ce:	8bce                	mv	s7,s3
      state = 0;
 7d0:	4981                	li	s3,0
 7d2:	bbd9                	j	5a8 <vprintf+0x4a>
          s = "(null)";
 7d4:	00000917          	auipc	s2,0x0
 7d8:	22490913          	addi	s2,s2,548 # 9f8 <malloc+0x118>
        for(; *s; s++)
 7dc:	02800593          	li	a1,40
 7e0:	b7c5                	j	7c0 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 7e2:	8bce                	mv	s7,s3
      state = 0;
 7e4:	4981                	li	s3,0
 7e6:	b3c9                	j	5a8 <vprintf+0x4a>
 7e8:	64a6                	ld	s1,72(sp)
 7ea:	79e2                	ld	s3,56(sp)
 7ec:	7a42                	ld	s4,48(sp)
 7ee:	7aa2                	ld	s5,40(sp)
 7f0:	7b02                	ld	s6,32(sp)
 7f2:	6be2                	ld	s7,24(sp)
 7f4:	6c42                	ld	s8,16(sp)
 7f6:	6ca2                	ld	s9,8(sp)
    }
  }
}
 7f8:	60e6                	ld	ra,88(sp)
 7fa:	6446                	ld	s0,80(sp)
 7fc:	6906                	ld	s2,64(sp)
 7fe:	6125                	addi	sp,sp,96
 800:	8082                	ret

0000000000000802 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 802:	715d                	addi	sp,sp,-80
 804:	ec06                	sd	ra,24(sp)
 806:	e822                	sd	s0,16(sp)
 808:	1000                	addi	s0,sp,32
 80a:	e010                	sd	a2,0(s0)
 80c:	e414                	sd	a3,8(s0)
 80e:	e818                	sd	a4,16(s0)
 810:	ec1c                	sd	a5,24(s0)
 812:	03043023          	sd	a6,32(s0)
 816:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 81a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 81e:	8622                	mv	a2,s0
 820:	d3fff0ef          	jal	55e <vprintf>
}
 824:	60e2                	ld	ra,24(sp)
 826:	6442                	ld	s0,16(sp)
 828:	6161                	addi	sp,sp,80
 82a:	8082                	ret

000000000000082c <printf>:

void
printf(const char *fmt, ...)
{
 82c:	711d                	addi	sp,sp,-96
 82e:	ec06                	sd	ra,24(sp)
 830:	e822                	sd	s0,16(sp)
 832:	1000                	addi	s0,sp,32
 834:	e40c                	sd	a1,8(s0)
 836:	e810                	sd	a2,16(s0)
 838:	ec14                	sd	a3,24(s0)
 83a:	f018                	sd	a4,32(s0)
 83c:	f41c                	sd	a5,40(s0)
 83e:	03043823          	sd	a6,48(s0)
 842:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 846:	00840613          	addi	a2,s0,8
 84a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 84e:	85aa                	mv	a1,a0
 850:	4505                	li	a0,1
 852:	d0dff0ef          	jal	55e <vprintf>
}
 856:	60e2                	ld	ra,24(sp)
 858:	6442                	ld	s0,16(sp)
 85a:	6125                	addi	sp,sp,96
 85c:	8082                	ret

000000000000085e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 85e:	1141                	addi	sp,sp,-16
 860:	e422                	sd	s0,8(sp)
 862:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 864:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 868:	00000797          	auipc	a5,0x0
 86c:	7987b783          	ld	a5,1944(a5) # 1000 <freep>
 870:	a02d                	j	89a <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 872:	4618                	lw	a4,8(a2)
 874:	9f2d                	addw	a4,a4,a1
 876:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 87a:	6398                	ld	a4,0(a5)
 87c:	6310                	ld	a2,0(a4)
 87e:	a83d                	j	8bc <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 880:	ff852703          	lw	a4,-8(a0)
 884:	9f31                	addw	a4,a4,a2
 886:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 888:	ff053683          	ld	a3,-16(a0)
 88c:	a091                	j	8d0 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 88e:	6398                	ld	a4,0(a5)
 890:	00e7e463          	bltu	a5,a4,898 <free+0x3a>
 894:	00e6ea63          	bltu	a3,a4,8a8 <free+0x4a>
{
 898:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 89a:	fed7fae3          	bgeu	a5,a3,88e <free+0x30>
 89e:	6398                	ld	a4,0(a5)
 8a0:	00e6e463          	bltu	a3,a4,8a8 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8a4:	fee7eae3          	bltu	a5,a4,898 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 8a8:	ff852583          	lw	a1,-8(a0)
 8ac:	6390                	ld	a2,0(a5)
 8ae:	02059813          	slli	a6,a1,0x20
 8b2:	01c85713          	srli	a4,a6,0x1c
 8b6:	9736                	add	a4,a4,a3
 8b8:	fae60de3          	beq	a2,a4,872 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 8bc:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8c0:	4790                	lw	a2,8(a5)
 8c2:	02061593          	slli	a1,a2,0x20
 8c6:	01c5d713          	srli	a4,a1,0x1c
 8ca:	973e                	add	a4,a4,a5
 8cc:	fae68ae3          	beq	a3,a4,880 <free+0x22>
    p->s.ptr = bp->s.ptr;
 8d0:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 8d2:	00000717          	auipc	a4,0x0
 8d6:	72f73723          	sd	a5,1838(a4) # 1000 <freep>
}
 8da:	6422                	ld	s0,8(sp)
 8dc:	0141                	addi	sp,sp,16
 8de:	8082                	ret

00000000000008e0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8e0:	7139                	addi	sp,sp,-64
 8e2:	fc06                	sd	ra,56(sp)
 8e4:	f822                	sd	s0,48(sp)
 8e6:	f426                	sd	s1,40(sp)
 8e8:	ec4e                	sd	s3,24(sp)
 8ea:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8ec:	02051493          	slli	s1,a0,0x20
 8f0:	9081                	srli	s1,s1,0x20
 8f2:	04bd                	addi	s1,s1,15
 8f4:	8091                	srli	s1,s1,0x4
 8f6:	0014899b          	addiw	s3,s1,1
 8fa:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 8fc:	00000517          	auipc	a0,0x0
 900:	70453503          	ld	a0,1796(a0) # 1000 <freep>
 904:	c915                	beqz	a0,938 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 906:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 908:	4798                	lw	a4,8(a5)
 90a:	08977a63          	bgeu	a4,s1,99e <malloc+0xbe>
 90e:	f04a                	sd	s2,32(sp)
 910:	e852                	sd	s4,16(sp)
 912:	e456                	sd	s5,8(sp)
 914:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 916:	8a4e                	mv	s4,s3
 918:	0009871b          	sext.w	a4,s3
 91c:	6685                	lui	a3,0x1
 91e:	00d77363          	bgeu	a4,a3,924 <malloc+0x44>
 922:	6a05                	lui	s4,0x1
 924:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 928:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 92c:	00000917          	auipc	s2,0x0
 930:	6d490913          	addi	s2,s2,1748 # 1000 <freep>
  if(p == SBRK_ERROR)
 934:	5afd                	li	s5,-1
 936:	a081                	j	976 <malloc+0x96>
 938:	f04a                	sd	s2,32(sp)
 93a:	e852                	sd	s4,16(sp)
 93c:	e456                	sd	s5,8(sp)
 93e:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 940:	00000797          	auipc	a5,0x0
 944:	6d078793          	addi	a5,a5,1744 # 1010 <base>
 948:	00000717          	auipc	a4,0x0
 94c:	6af73c23          	sd	a5,1720(a4) # 1000 <freep>
 950:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 952:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 956:	b7c1                	j	916 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 958:	6398                	ld	a4,0(a5)
 95a:	e118                	sd	a4,0(a0)
 95c:	a8a9                	j	9b6 <malloc+0xd6>
  hp->s.size = nu;
 95e:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 962:	0541                	addi	a0,a0,16
 964:	efbff0ef          	jal	85e <free>
  return freep;
 968:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 96c:	c12d                	beqz	a0,9ce <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 96e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 970:	4798                	lw	a4,8(a5)
 972:	02977263          	bgeu	a4,s1,996 <malloc+0xb6>
    if(p == freep)
 976:	00093703          	ld	a4,0(s2)
 97a:	853e                	mv	a0,a5
 97c:	fef719e3          	bne	a4,a5,96e <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 980:	8552                	mv	a0,s4
 982:	933ff0ef          	jal	2b4 <sbrk>
  if(p == SBRK_ERROR)
 986:	fd551ce3          	bne	a0,s5,95e <malloc+0x7e>
        return 0;
 98a:	4501                	li	a0,0
 98c:	7902                	ld	s2,32(sp)
 98e:	6a42                	ld	s4,16(sp)
 990:	6aa2                	ld	s5,8(sp)
 992:	6b02                	ld	s6,0(sp)
 994:	a03d                	j	9c2 <malloc+0xe2>
 996:	7902                	ld	s2,32(sp)
 998:	6a42                	ld	s4,16(sp)
 99a:	6aa2                	ld	s5,8(sp)
 99c:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 99e:	fae48de3          	beq	s1,a4,958 <malloc+0x78>
        p->s.size -= nunits;
 9a2:	4137073b          	subw	a4,a4,s3
 9a6:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9a8:	02071693          	slli	a3,a4,0x20
 9ac:	01c6d713          	srli	a4,a3,0x1c
 9b0:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9b2:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9b6:	00000717          	auipc	a4,0x0
 9ba:	64a73523          	sd	a0,1610(a4) # 1000 <freep>
      return (void*)(p + 1);
 9be:	01078513          	addi	a0,a5,16
  }
}
 9c2:	70e2                	ld	ra,56(sp)
 9c4:	7442                	ld	s0,48(sp)
 9c6:	74a2                	ld	s1,40(sp)
 9c8:	69e2                	ld	s3,24(sp)
 9ca:	6121                	addi	sp,sp,64
 9cc:	8082                	ret
 9ce:	7902                	ld	s2,32(sp)
 9d0:	6a42                	ld	s4,16(sp)
 9d2:	6aa2                	ld	s5,8(sp)
 9d4:	6b02                	ld	s6,0(sp)
 9d6:	b7f5                	j	9c2 <malloc+0xe2>
