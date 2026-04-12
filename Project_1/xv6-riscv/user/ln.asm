
user/_ln:     file format elf64-littleriscv


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
  if(argc != 3){
   8:	478d                	li	a5,3
   a:	00f50d63          	beq	a0,a5,24 <main+0x24>
   e:	e426                	sd	s1,8(sp)
    fprintf(2, "Usage: ln old new\n");
  10:	00001597          	auipc	a1,0x1
  14:	9d058593          	addi	a1,a1,-1584 # 9e0 <malloc+0x106>
  18:	4509                	li	a0,2
  1a:	7e2000ef          	jal	7fc <fprintf>
    exit(1);
  1e:	4505                	li	a0,1
  20:	352000ef          	jal	372 <exit>
  24:	e426                	sd	s1,8(sp)
  26:	84ae                	mv	s1,a1
  }
  if(link(argv[1], argv[2]) < 0)
  28:	698c                	ld	a1,16(a1)
  2a:	6488                	ld	a0,8(s1)
  2c:	3a6000ef          	jal	3d2 <link>
  30:	00054563          	bltz	a0,3a <main+0x3a>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  exit(0);
  34:	4501                	li	a0,0
  36:	33c000ef          	jal	372 <exit>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  3a:	6894                	ld	a3,16(s1)
  3c:	6490                	ld	a2,8(s1)
  3e:	00001597          	auipc	a1,0x1
  42:	9ba58593          	addi	a1,a1,-1606 # 9f8 <malloc+0x11e>
  46:	4509                	li	a0,2
  48:	7b4000ef          	jal	7fc <fprintf>
  4c:	b7e5                	j	34 <main+0x34>

000000000000004e <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
  4e:	1141                	addi	sp,sp,-16
  50:	e406                	sd	ra,8(sp)
  52:	e022                	sd	s0,0(sp)
  54:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
  56:	fabff0ef          	jal	0 <main>
  exit(r);
  5a:	318000ef          	jal	372 <exit>

000000000000005e <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  5e:	1141                	addi	sp,sp,-16
  60:	e422                	sd	s0,8(sp)
  62:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  64:	87aa                	mv	a5,a0
  66:	0585                	addi	a1,a1,1
  68:	0785                	addi	a5,a5,1
  6a:	fff5c703          	lbu	a4,-1(a1)
  6e:	fee78fa3          	sb	a4,-1(a5)
  72:	fb75                	bnez	a4,66 <strcpy+0x8>
    ;
  return os;
}
  74:	6422                	ld	s0,8(sp)
  76:	0141                	addi	sp,sp,16
  78:	8082                	ret

000000000000007a <strcmp>:

int
strcmp(const char *p, const char *q)
{
  7a:	1141                	addi	sp,sp,-16
  7c:	e422                	sd	s0,8(sp)
  7e:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  80:	00054783          	lbu	a5,0(a0)
  84:	cb91                	beqz	a5,98 <strcmp+0x1e>
  86:	0005c703          	lbu	a4,0(a1)
  8a:	00f71763          	bne	a4,a5,98 <strcmp+0x1e>
    p++, q++;
  8e:	0505                	addi	a0,a0,1
  90:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  92:	00054783          	lbu	a5,0(a0)
  96:	fbe5                	bnez	a5,86 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  98:	0005c503          	lbu	a0,0(a1)
}
  9c:	40a7853b          	subw	a0,a5,a0
  a0:	6422                	ld	s0,8(sp)
  a2:	0141                	addi	sp,sp,16
  a4:	8082                	ret

00000000000000a6 <strlen>:

uint
strlen(const char *s)
{
  a6:	1141                	addi	sp,sp,-16
  a8:	e422                	sd	s0,8(sp)
  aa:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  ac:	00054783          	lbu	a5,0(a0)
  b0:	cf91                	beqz	a5,cc <strlen+0x26>
  b2:	0505                	addi	a0,a0,1
  b4:	87aa                	mv	a5,a0
  b6:	86be                	mv	a3,a5
  b8:	0785                	addi	a5,a5,1
  ba:	fff7c703          	lbu	a4,-1(a5)
  be:	ff65                	bnez	a4,b6 <strlen+0x10>
  c0:	40a6853b          	subw	a0,a3,a0
  c4:	2505                	addiw	a0,a0,1
    ;
  return n;
}
  c6:	6422                	ld	s0,8(sp)
  c8:	0141                	addi	sp,sp,16
  ca:	8082                	ret
  for(n = 0; s[n]; n++)
  cc:	4501                	li	a0,0
  ce:	bfe5                	j	c6 <strlen+0x20>

00000000000000d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  d0:	1141                	addi	sp,sp,-16
  d2:	e422                	sd	s0,8(sp)
  d4:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
  d6:	ca19                	beqz	a2,ec <memset+0x1c>
  d8:	87aa                	mv	a5,a0
  da:	1602                	slli	a2,a2,0x20
  dc:	9201                	srli	a2,a2,0x20
  de:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
  e2:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
  e6:	0785                	addi	a5,a5,1
  e8:	fee79de3          	bne	a5,a4,e2 <memset+0x12>
  }
  return dst;
}
  ec:	6422                	ld	s0,8(sp)
  ee:	0141                	addi	sp,sp,16
  f0:	8082                	ret

00000000000000f2 <strchr>:

char*
strchr(const char *s, char c)
{
  f2:	1141                	addi	sp,sp,-16
  f4:	e422                	sd	s0,8(sp)
  f6:	0800                	addi	s0,sp,16
  for(; *s; s++)
  f8:	00054783          	lbu	a5,0(a0)
  fc:	cb99                	beqz	a5,112 <strchr+0x20>
    if(*s == c)
  fe:	00f58763          	beq	a1,a5,10c <strchr+0x1a>
  for(; *s; s++)
 102:	0505                	addi	a0,a0,1
 104:	00054783          	lbu	a5,0(a0)
 108:	fbfd                	bnez	a5,fe <strchr+0xc>
      return (char*)s;
  return 0;
 10a:	4501                	li	a0,0
}
 10c:	6422                	ld	s0,8(sp)
 10e:	0141                	addi	sp,sp,16
 110:	8082                	ret
  return 0;
 112:	4501                	li	a0,0
 114:	bfe5                	j	10c <strchr+0x1a>

0000000000000116 <gets>:

char*
gets(char *buf, int max)
{
 116:	711d                	addi	sp,sp,-96
 118:	ec86                	sd	ra,88(sp)
 11a:	e8a2                	sd	s0,80(sp)
 11c:	e4a6                	sd	s1,72(sp)
 11e:	e0ca                	sd	s2,64(sp)
 120:	fc4e                	sd	s3,56(sp)
 122:	f852                	sd	s4,48(sp)
 124:	f456                	sd	s5,40(sp)
 126:	f05a                	sd	s6,32(sp)
 128:	ec5e                	sd	s7,24(sp)
 12a:	1080                	addi	s0,sp,96
 12c:	8baa                	mv	s7,a0
 12e:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 130:	892a                	mv	s2,a0
 132:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 134:	4aa9                	li	s5,10
 136:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 138:	89a6                	mv	s3,s1
 13a:	2485                	addiw	s1,s1,1
 13c:	0344d663          	bge	s1,s4,168 <gets+0x52>
    cc = read(0, &c, 1);
 140:	4605                	li	a2,1
 142:	faf40593          	addi	a1,s0,-81
 146:	4501                	li	a0,0
 148:	242000ef          	jal	38a <read>
    if(cc < 1)
 14c:	00a05e63          	blez	a0,168 <gets+0x52>
    buf[i++] = c;
 150:	faf44783          	lbu	a5,-81(s0)
 154:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 158:	01578763          	beq	a5,s5,166 <gets+0x50>
 15c:	0905                	addi	s2,s2,1
 15e:	fd679de3          	bne	a5,s6,138 <gets+0x22>
    buf[i++] = c;
 162:	89a6                	mv	s3,s1
 164:	a011                	j	168 <gets+0x52>
 166:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 168:	99de                	add	s3,s3,s7
 16a:	00098023          	sb	zero,0(s3)
  return buf;
}
 16e:	855e                	mv	a0,s7
 170:	60e6                	ld	ra,88(sp)
 172:	6446                	ld	s0,80(sp)
 174:	64a6                	ld	s1,72(sp)
 176:	6906                	ld	s2,64(sp)
 178:	79e2                	ld	s3,56(sp)
 17a:	7a42                	ld	s4,48(sp)
 17c:	7aa2                	ld	s5,40(sp)
 17e:	7b02                	ld	s6,32(sp)
 180:	6be2                	ld	s7,24(sp)
 182:	6125                	addi	sp,sp,96
 184:	8082                	ret

0000000000000186 <stat>:

int
stat(const char *n, struct stat *st)
{
 186:	1101                	addi	sp,sp,-32
 188:	ec06                	sd	ra,24(sp)
 18a:	e822                	sd	s0,16(sp)
 18c:	e04a                	sd	s2,0(sp)
 18e:	1000                	addi	s0,sp,32
 190:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 192:	4581                	li	a1,0
 194:	21e000ef          	jal	3b2 <open>
  if(fd < 0)
 198:	02054263          	bltz	a0,1bc <stat+0x36>
 19c:	e426                	sd	s1,8(sp)
 19e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1a0:	85ca                	mv	a1,s2
 1a2:	228000ef          	jal	3ca <fstat>
 1a6:	892a                	mv	s2,a0
  close(fd);
 1a8:	8526                	mv	a0,s1
 1aa:	1f0000ef          	jal	39a <close>
  return r;
 1ae:	64a2                	ld	s1,8(sp)
}
 1b0:	854a                	mv	a0,s2
 1b2:	60e2                	ld	ra,24(sp)
 1b4:	6442                	ld	s0,16(sp)
 1b6:	6902                	ld	s2,0(sp)
 1b8:	6105                	addi	sp,sp,32
 1ba:	8082                	ret
    return -1;
 1bc:	597d                	li	s2,-1
 1be:	bfcd                	j	1b0 <stat+0x2a>

00000000000001c0 <atoi>:

int
atoi(const char *s)
{
 1c0:	1141                	addi	sp,sp,-16
 1c2:	e422                	sd	s0,8(sp)
 1c4:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1c6:	00054683          	lbu	a3,0(a0)
 1ca:	fd06879b          	addiw	a5,a3,-48
 1ce:	0ff7f793          	zext.b	a5,a5
 1d2:	4625                	li	a2,9
 1d4:	02f66863          	bltu	a2,a5,204 <atoi+0x44>
 1d8:	872a                	mv	a4,a0
  n = 0;
 1da:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 1dc:	0705                	addi	a4,a4,1
 1de:	0025179b          	slliw	a5,a0,0x2
 1e2:	9fa9                	addw	a5,a5,a0
 1e4:	0017979b          	slliw	a5,a5,0x1
 1e8:	9fb5                	addw	a5,a5,a3
 1ea:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 1ee:	00074683          	lbu	a3,0(a4)
 1f2:	fd06879b          	addiw	a5,a3,-48
 1f6:	0ff7f793          	zext.b	a5,a5
 1fa:	fef671e3          	bgeu	a2,a5,1dc <atoi+0x1c>
  return n;
}
 1fe:	6422                	ld	s0,8(sp)
 200:	0141                	addi	sp,sp,16
 202:	8082                	ret
  n = 0;
 204:	4501                	li	a0,0
 206:	bfe5                	j	1fe <atoi+0x3e>

0000000000000208 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 208:	1141                	addi	sp,sp,-16
 20a:	e422                	sd	s0,8(sp)
 20c:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 20e:	02b57463          	bgeu	a0,a1,236 <memmove+0x2e>
    while(n-- > 0)
 212:	00c05f63          	blez	a2,230 <memmove+0x28>
 216:	1602                	slli	a2,a2,0x20
 218:	9201                	srli	a2,a2,0x20
 21a:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 21e:	872a                	mv	a4,a0
      *dst++ = *src++;
 220:	0585                	addi	a1,a1,1
 222:	0705                	addi	a4,a4,1
 224:	fff5c683          	lbu	a3,-1(a1)
 228:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 22c:	fef71ae3          	bne	a4,a5,220 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 230:	6422                	ld	s0,8(sp)
 232:	0141                	addi	sp,sp,16
 234:	8082                	ret
    dst += n;
 236:	00c50733          	add	a4,a0,a2
    src += n;
 23a:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 23c:	fec05ae3          	blez	a2,230 <memmove+0x28>
 240:	fff6079b          	addiw	a5,a2,-1
 244:	1782                	slli	a5,a5,0x20
 246:	9381                	srli	a5,a5,0x20
 248:	fff7c793          	not	a5,a5
 24c:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 24e:	15fd                	addi	a1,a1,-1
 250:	177d                	addi	a4,a4,-1
 252:	0005c683          	lbu	a3,0(a1)
 256:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 25a:	fee79ae3          	bne	a5,a4,24e <memmove+0x46>
 25e:	bfc9                	j	230 <memmove+0x28>

0000000000000260 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 260:	1141                	addi	sp,sp,-16
 262:	e422                	sd	s0,8(sp)
 264:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 266:	ca05                	beqz	a2,296 <memcmp+0x36>
 268:	fff6069b          	addiw	a3,a2,-1
 26c:	1682                	slli	a3,a3,0x20
 26e:	9281                	srli	a3,a3,0x20
 270:	0685                	addi	a3,a3,1
 272:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 274:	00054783          	lbu	a5,0(a0)
 278:	0005c703          	lbu	a4,0(a1)
 27c:	00e79863          	bne	a5,a4,28c <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 280:	0505                	addi	a0,a0,1
    p2++;
 282:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 284:	fed518e3          	bne	a0,a3,274 <memcmp+0x14>
  }
  return 0;
 288:	4501                	li	a0,0
 28a:	a019                	j	290 <memcmp+0x30>
      return *p1 - *p2;
 28c:	40e7853b          	subw	a0,a5,a4
}
 290:	6422                	ld	s0,8(sp)
 292:	0141                	addi	sp,sp,16
 294:	8082                	ret
  return 0;
 296:	4501                	li	a0,0
 298:	bfe5                	j	290 <memcmp+0x30>

000000000000029a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 29a:	1141                	addi	sp,sp,-16
 29c:	e406                	sd	ra,8(sp)
 29e:	e022                	sd	s0,0(sp)
 2a0:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2a2:	f67ff0ef          	jal	208 <memmove>
}
 2a6:	60a2                	ld	ra,8(sp)
 2a8:	6402                	ld	s0,0(sp)
 2aa:	0141                	addi	sp,sp,16
 2ac:	8082                	ret

00000000000002ae <sbrk>:

char *
sbrk(int n) {
 2ae:	1141                	addi	sp,sp,-16
 2b0:	e406                	sd	ra,8(sp)
 2b2:	e022                	sd	s0,0(sp)
 2b4:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 2b6:	4585                	li	a1,1
 2b8:	142000ef          	jal	3fa <sys_sbrk>
}
 2bc:	60a2                	ld	ra,8(sp)
 2be:	6402                	ld	s0,0(sp)
 2c0:	0141                	addi	sp,sp,16
 2c2:	8082                	ret

00000000000002c4 <sbrklazy>:

char *
sbrklazy(int n) {
 2c4:	1141                	addi	sp,sp,-16
 2c6:	e406                	sd	ra,8(sp)
 2c8:	e022                	sd	s0,0(sp)
 2ca:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 2cc:	4589                	li	a1,2
 2ce:	12c000ef          	jal	3fa <sys_sbrk>
}
 2d2:	60a2                	ld	ra,8(sp)
 2d4:	6402                	ld	s0,0(sp)
 2d6:	0141                	addi	sp,sp,16
 2d8:	8082                	ret

00000000000002da <thread_create>:
// thread_create allocates a page-sized stack, calls clone(fn, arg, stacktop).
// Returns the new thread's pid, or -1 on error.
// The stack is passed back via *stack so the caller can free it after join.
int
thread_create(void(*fn)(void*), void *arg, void **stack)
{
 2da:	7179                	addi	sp,sp,-48
 2dc:	f406                	sd	ra,40(sp)
 2de:	f022                	sd	s0,32(sp)
 2e0:	e84a                	sd	s2,16(sp)
 2e2:	e44e                	sd	s3,8(sp)
 2e4:	e052                	sd	s4,0(sp)
 2e6:	1800                	addi	s0,sp,48
 2e8:	89aa                	mv	s3,a0
 2ea:	8a2e                	mv	s4,a1
 2ec:	8932                	mv	s2,a2
  char *s = malloc(PGSIZE);
 2ee:	6505                	lui	a0,0x1
 2f0:	5ea000ef          	jal	8da <malloc>
  if(s == 0)
 2f4:	cd0d                	beqz	a0,32e <thread_create+0x54>
 2f6:	ec26                	sd	s1,24(sp)
 2f8:	84aa                	mv	s1,a0
    return -1;
  *stack = s;
 2fa:	00a93023          	sd	a0,0(s2)
  // Stack grows downward- pass the top of the allocated region.
  int pid = clone(fn, arg, s + PGSIZE);
 2fe:	6605                	lui	a2,0x1
 300:	962a                	add	a2,a2,a0
 302:	85d2                	mv	a1,s4
 304:	854e                	mv	a0,s3
 306:	166000ef          	jal	46c <clone>
  if(pid < 0){
 30a:	00054a63          	bltz	a0,31e <thread_create+0x44>
 30e:	64e2                	ld	s1,24(sp)
    free(s);
    *stack = 0;
    return -1;
  }
  return pid;
}
 310:	70a2                	ld	ra,40(sp)
 312:	7402                	ld	s0,32(sp)
 314:	6942                	ld	s2,16(sp)
 316:	69a2                	ld	s3,8(sp)
 318:	6a02                	ld	s4,0(sp)
 31a:	6145                	addi	sp,sp,48
 31c:	8082                	ret
    free(s);
 31e:	8526                	mv	a0,s1
 320:	538000ef          	jal	858 <free>
    *stack = 0;
 324:	00093023          	sd	zero,0(s2)
    return -1;
 328:	557d                	li	a0,-1
 32a:	64e2                	ld	s1,24(sp)
 32c:	b7d5                	j	310 <thread_create+0x36>
    return -1;
 32e:	557d                	li	a0,-1
 330:	b7c5                	j	310 <thread_create+0x36>

0000000000000332 <thread_join>:
// Wait for any child thread to exit.
// If stack is non-null, frees the memory pointed to by *stack and clears it.
// Returns the joined thread's pid, or -1 Son error.
int
thread_join(void **stack)
{
 332:	1101                	addi	sp,sp,-32
 334:	ec06                	sd	ra,24(sp)
 336:	e822                	sd	s0,16(sp)
 338:	e426                	sd	s1,8(sp)
 33a:	e04a                	sd	s2,0(sp)
 33c:	1000                	addi	s0,sp,32
 33e:	84aa                	mv	s1,a0
  int pid = join();
 340:	134000ef          	jal	474 <join>
  if(pid < 0)
 344:	02054163          	bltz	a0,366 <thread_join+0x34>
 348:	892a                	mv	s2,a0
    return -1;
  if(stack && *stack){
 34a:	c499                	beqz	s1,358 <thread_join+0x26>
 34c:	6088                	ld	a0,0(s1)
 34e:	c509                	beqz	a0,358 <thread_join+0x26>
    free(*stack);
 350:	508000ef          	jal	858 <free>
    *stack = 0;
 354:	0004b023          	sd	zero,0(s1)
  }
  return pid;
}
 358:	854a                	mv	a0,s2
 35a:	60e2                	ld	ra,24(sp)
 35c:	6442                	ld	s0,16(sp)
 35e:	64a2                	ld	s1,8(sp)
 360:	6902                	ld	s2,0(sp)
 362:	6105                	addi	sp,sp,32
 364:	8082                	ret
    return -1;
 366:	597d                	li	s2,-1
 368:	bfc5                	j	358 <thread_join+0x26>

000000000000036a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 36a:	4885                	li	a7,1
 ecall
 36c:	00000073          	ecall
 ret
 370:	8082                	ret

0000000000000372 <exit>:
.global exit
exit:
 li a7, SYS_exit
 372:	4889                	li	a7,2
 ecall
 374:	00000073          	ecall
 ret
 378:	8082                	ret

000000000000037a <wait>:
.global wait
wait:
 li a7, SYS_wait
 37a:	488d                	li	a7,3
 ecall
 37c:	00000073          	ecall
 ret
 380:	8082                	ret

0000000000000382 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 382:	4891                	li	a7,4
 ecall
 384:	00000073          	ecall
 ret
 388:	8082                	ret

000000000000038a <read>:
.global read
read:
 li a7, SYS_read
 38a:	4895                	li	a7,5
 ecall
 38c:	00000073          	ecall
 ret
 390:	8082                	ret

0000000000000392 <write>:
.global write
write:
 li a7, SYS_write
 392:	48c1                	li	a7,16
 ecall
 394:	00000073          	ecall
 ret
 398:	8082                	ret

000000000000039a <close>:
.global close
close:
 li a7, SYS_close
 39a:	48d5                	li	a7,21
 ecall
 39c:	00000073          	ecall
 ret
 3a0:	8082                	ret

00000000000003a2 <kill>:
.global kill
kill:
 li a7, SYS_kill
 3a2:	4899                	li	a7,6
 ecall
 3a4:	00000073          	ecall
 ret
 3a8:	8082                	ret

00000000000003aa <exec>:
.global exec
exec:
 li a7, SYS_exec
 3aa:	489d                	li	a7,7
 ecall
 3ac:	00000073          	ecall
 ret
 3b0:	8082                	ret

00000000000003b2 <open>:
.global open
open:
 li a7, SYS_open
 3b2:	48bd                	li	a7,15
 ecall
 3b4:	00000073          	ecall
 ret
 3b8:	8082                	ret

00000000000003ba <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3ba:	48c5                	li	a7,17
 ecall
 3bc:	00000073          	ecall
 ret
 3c0:	8082                	ret

00000000000003c2 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3c2:	48c9                	li	a7,18
 ecall
 3c4:	00000073          	ecall
 ret
 3c8:	8082                	ret

00000000000003ca <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 3ca:	48a1                	li	a7,8
 ecall
 3cc:	00000073          	ecall
 ret
 3d0:	8082                	ret

00000000000003d2 <link>:
.global link
link:
 li a7, SYS_link
 3d2:	48cd                	li	a7,19
 ecall
 3d4:	00000073          	ecall
 ret
 3d8:	8082                	ret

00000000000003da <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 3da:	48d1                	li	a7,20
 ecall
 3dc:	00000073          	ecall
 ret
 3e0:	8082                	ret

00000000000003e2 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 3e2:	48a5                	li	a7,9
 ecall
 3e4:	00000073          	ecall
 ret
 3e8:	8082                	ret

00000000000003ea <dup>:
.global dup
dup:
 li a7, SYS_dup
 3ea:	48a9                	li	a7,10
 ecall
 3ec:	00000073          	ecall
 ret
 3f0:	8082                	ret

00000000000003f2 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 3f2:	48ad                	li	a7,11
 ecall
 3f4:	00000073          	ecall
 ret
 3f8:	8082                	ret

00000000000003fa <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 3fa:	48b1                	li	a7,12
 ecall
 3fc:	00000073          	ecall
 ret
 400:	8082                	ret

0000000000000402 <pause>:
.global pause
pause:
 li a7, SYS_pause
 402:	48b5                	li	a7,13
 ecall
 404:	00000073          	ecall
 ret
 408:	8082                	ret

000000000000040a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 40a:	48b9                	li	a7,14
 ecall
 40c:	00000073          	ecall
 ret
 410:	8082                	ret

0000000000000412 <getppid>:
.global getppid
getppid:
 li a7, SYS_getppid
 412:	02100893          	li	a7,33
 ecall
 416:	00000073          	ecall
 ret
 41a:	8082                	ret

000000000000041c <ps>:
.global ps
ps:
 li a7, SYS_ps
 41c:	02200893          	li	a7,34
 ecall
 420:	00000073          	ecall
 ret
 424:	8082                	ret

0000000000000426 <trace>:
.global trace
trace:
 li a7, SYS_trace
 426:	02300893          	li	a7,35
 ecall
 42a:	00000073          	ecall
 ret
 42e:	8082                	ret

0000000000000430 <waitx>:
.global waitx
waitx:
 li a7, SYS_waitx
 430:	02400893          	li	a7,36
 ecall
 434:	00000073          	ecall
 ret
 438:	8082                	ret

000000000000043a <getcount>:
.global getcount
getcount:
 li a7, SYS_getcount
 43a:	02500893          	li	a7,37
 ecall
 43e:	00000073          	ecall
 ret
 442:	8082                	ret

0000000000000444 <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 444:	48d9                	li	a7,22
 ecall
 446:	00000073          	ecall
 ret
 44a:	8082                	ret

000000000000044c <lock_create>:
.global lock_create
lock_create:
 li a7, SYS_lock_create
 44c:	48dd                	li	a7,23
 ecall
 44e:	00000073          	ecall
 ret
 452:	8082                	ret

0000000000000454 <lock_acquire>:
.global lock_acquire
lock_acquire:
 li a7, SYS_lock_acquire
 454:	48e1                	li	a7,24
 ecall
 456:	00000073          	ecall
 ret
 45a:	8082                	ret

000000000000045c <lock_release>:
.global lock_release
lock_release:
 li a7, SYS_lock_release
 45c:	48e5                	li	a7,25
 ecall
 45e:	00000073          	ecall
 ret
 462:	8082                	ret

0000000000000464 <lock_destroy>:
.global lock_destroy
lock_destroy:
 li a7, SYS_lock_destroy
 464:	48e9                	li	a7,26
 ecall
 466:	00000073          	ecall
 ret
 46a:	8082                	ret

000000000000046c <clone>:
.global clone
clone:
 li a7, SYS_clone
 46c:	48ed                	li	a7,27
 ecall
 46e:	00000073          	ecall
 ret
 472:	8082                	ret

0000000000000474 <join>:
.global join
join:
 li a7, SYS_join
 474:	48f1                	li	a7,28
 ecall
 476:	00000073          	ecall
 ret
 47a:	8082                	ret

000000000000047c <getprocessinfo>:
.global getprocessinfo
getprocessinfo:
 li a7, SYS_getprocessinfo
 47c:	48f5                	li	a7,29
 ecall
 47e:	00000073          	ecall
 ret
 482:	8082                	ret

0000000000000484 <shmget>:
.global shmget
shmget:
 li a7, SYS_shmget
 484:	48f9                	li	a7,30
 ecall
 486:	00000073          	ecall
 ret
 48a:	8082                	ret

000000000000048c <shmattach>:
.global shmattach
shmattach:
 li a7, SYS_shmattach
 48c:	48fd                	li	a7,31
 ecall
 48e:	00000073          	ecall
 ret
 492:	8082                	ret

0000000000000494 <shmdetach>:
.global shmdetach
shmdetach:
 li a7, SYS_shmdetach
 494:	02000893          	li	a7,32
 ecall
 498:	00000073          	ecall
 ret
 49c:	8082                	ret

000000000000049e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 49e:	1101                	addi	sp,sp,-32
 4a0:	ec06                	sd	ra,24(sp)
 4a2:	e822                	sd	s0,16(sp)
 4a4:	1000                	addi	s0,sp,32
 4a6:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4aa:	4605                	li	a2,1
 4ac:	fef40593          	addi	a1,s0,-17
 4b0:	ee3ff0ef          	jal	392 <write>
}
 4b4:	60e2                	ld	ra,24(sp)
 4b6:	6442                	ld	s0,16(sp)
 4b8:	6105                	addi	sp,sp,32
 4ba:	8082                	ret

00000000000004bc <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 4bc:	715d                	addi	sp,sp,-80
 4be:	e486                	sd	ra,72(sp)
 4c0:	e0a2                	sd	s0,64(sp)
 4c2:	f84a                	sd	s2,48(sp)
 4c4:	0880                	addi	s0,sp,80
 4c6:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 4c8:	c299                	beqz	a3,4ce <printint+0x12>
 4ca:	0805c363          	bltz	a1,550 <printint+0x94>
  neg = 0;
 4ce:	4881                	li	a7,0
 4d0:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 4d4:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 4d6:	00000517          	auipc	a0,0x0
 4da:	54250513          	addi	a0,a0,1346 # a18 <digits>
 4de:	883e                	mv	a6,a5
 4e0:	2785                	addiw	a5,a5,1
 4e2:	02c5f733          	remu	a4,a1,a2
 4e6:	972a                	add	a4,a4,a0
 4e8:	00074703          	lbu	a4,0(a4)
 4ec:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 4f0:	872e                	mv	a4,a1
 4f2:	02c5d5b3          	divu	a1,a1,a2
 4f6:	0685                	addi	a3,a3,1
 4f8:	fec773e3          	bgeu	a4,a2,4de <printint+0x22>
  if(neg)
 4fc:	00088b63          	beqz	a7,512 <printint+0x56>
    buf[i++] = '-';
 500:	fd078793          	addi	a5,a5,-48
 504:	97a2                	add	a5,a5,s0
 506:	02d00713          	li	a4,45
 50a:	fee78423          	sb	a4,-24(a5)
 50e:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
 512:	02f05a63          	blez	a5,546 <printint+0x8a>
 516:	fc26                	sd	s1,56(sp)
 518:	f44e                	sd	s3,40(sp)
 51a:	fb840713          	addi	a4,s0,-72
 51e:	00f704b3          	add	s1,a4,a5
 522:	fff70993          	addi	s3,a4,-1
 526:	99be                	add	s3,s3,a5
 528:	37fd                	addiw	a5,a5,-1
 52a:	1782                	slli	a5,a5,0x20
 52c:	9381                	srli	a5,a5,0x20
 52e:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 532:	fff4c583          	lbu	a1,-1(s1)
 536:	854a                	mv	a0,s2
 538:	f67ff0ef          	jal	49e <putc>
  while(--i >= 0)
 53c:	14fd                	addi	s1,s1,-1
 53e:	ff349ae3          	bne	s1,s3,532 <printint+0x76>
 542:	74e2                	ld	s1,56(sp)
 544:	79a2                	ld	s3,40(sp)
}
 546:	60a6                	ld	ra,72(sp)
 548:	6406                	ld	s0,64(sp)
 54a:	7942                	ld	s2,48(sp)
 54c:	6161                	addi	sp,sp,80
 54e:	8082                	ret
    x = -xx;
 550:	40b005b3          	neg	a1,a1
    neg = 1;
 554:	4885                	li	a7,1
    x = -xx;
 556:	bfad                	j	4d0 <printint+0x14>

0000000000000558 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 558:	711d                	addi	sp,sp,-96
 55a:	ec86                	sd	ra,88(sp)
 55c:	e8a2                	sd	s0,80(sp)
 55e:	e0ca                	sd	s2,64(sp)
 560:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 562:	0005c903          	lbu	s2,0(a1)
 566:	28090663          	beqz	s2,7f2 <vprintf+0x29a>
 56a:	e4a6                	sd	s1,72(sp)
 56c:	fc4e                	sd	s3,56(sp)
 56e:	f852                	sd	s4,48(sp)
 570:	f456                	sd	s5,40(sp)
 572:	f05a                	sd	s6,32(sp)
 574:	ec5e                	sd	s7,24(sp)
 576:	e862                	sd	s8,16(sp)
 578:	e466                	sd	s9,8(sp)
 57a:	8b2a                	mv	s6,a0
 57c:	8a2e                	mv	s4,a1
 57e:	8bb2                	mv	s7,a2
  state = 0;
 580:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 582:	4481                	li	s1,0
 584:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 586:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 58a:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 58e:	06c00c93          	li	s9,108
 592:	a005                	j	5b2 <vprintf+0x5a>
        putc(fd, c0);
 594:	85ca                	mv	a1,s2
 596:	855a                	mv	a0,s6
 598:	f07ff0ef          	jal	49e <putc>
 59c:	a019                	j	5a2 <vprintf+0x4a>
    } else if(state == '%'){
 59e:	03598263          	beq	s3,s5,5c2 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 5a2:	2485                	addiw	s1,s1,1
 5a4:	8726                	mv	a4,s1
 5a6:	009a07b3          	add	a5,s4,s1
 5aa:	0007c903          	lbu	s2,0(a5)
 5ae:	22090a63          	beqz	s2,7e2 <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 5b2:	0009079b          	sext.w	a5,s2
    if(state == 0){
 5b6:	fe0994e3          	bnez	s3,59e <vprintf+0x46>
      if(c0 == '%'){
 5ba:	fd579de3          	bne	a5,s5,594 <vprintf+0x3c>
        state = '%';
 5be:	89be                	mv	s3,a5
 5c0:	b7cd                	j	5a2 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 5c2:	00ea06b3          	add	a3,s4,a4
 5c6:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 5ca:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 5cc:	c681                	beqz	a3,5d4 <vprintf+0x7c>
 5ce:	9752                	add	a4,a4,s4
 5d0:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 5d4:	05878363          	beq	a5,s8,61a <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 5d8:	05978d63          	beq	a5,s9,632 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 5dc:	07500713          	li	a4,117
 5e0:	0ee78763          	beq	a5,a4,6ce <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 5e4:	07800713          	li	a4,120
 5e8:	12e78963          	beq	a5,a4,71a <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 5ec:	07000713          	li	a4,112
 5f0:	14e78e63          	beq	a5,a4,74c <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 5f4:	06300713          	li	a4,99
 5f8:	18e78e63          	beq	a5,a4,794 <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 5fc:	07300713          	li	a4,115
 600:	1ae78463          	beq	a5,a4,7a8 <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 604:	02500713          	li	a4,37
 608:	04e79563          	bne	a5,a4,652 <vprintf+0xfa>
        putc(fd, '%');
 60c:	02500593          	li	a1,37
 610:	855a                	mv	a0,s6
 612:	e8dff0ef          	jal	49e <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 616:	4981                	li	s3,0
 618:	b769                	j	5a2 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 61a:	008b8913          	addi	s2,s7,8
 61e:	4685                	li	a3,1
 620:	4629                	li	a2,10
 622:	000ba583          	lw	a1,0(s7)
 626:	855a                	mv	a0,s6
 628:	e95ff0ef          	jal	4bc <printint>
 62c:	8bca                	mv	s7,s2
      state = 0;
 62e:	4981                	li	s3,0
 630:	bf8d                	j	5a2 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 632:	06400793          	li	a5,100
 636:	02f68963          	beq	a3,a5,668 <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 63a:	06c00793          	li	a5,108
 63e:	04f68263          	beq	a3,a5,682 <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 642:	07500793          	li	a5,117
 646:	0af68063          	beq	a3,a5,6e6 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 64a:	07800793          	li	a5,120
 64e:	0ef68263          	beq	a3,a5,732 <vprintf+0x1da>
        putc(fd, '%');
 652:	02500593          	li	a1,37
 656:	855a                	mv	a0,s6
 658:	e47ff0ef          	jal	49e <putc>
        putc(fd, c0);
 65c:	85ca                	mv	a1,s2
 65e:	855a                	mv	a0,s6
 660:	e3fff0ef          	jal	49e <putc>
      state = 0;
 664:	4981                	li	s3,0
 666:	bf35                	j	5a2 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 668:	008b8913          	addi	s2,s7,8
 66c:	4685                	li	a3,1
 66e:	4629                	li	a2,10
 670:	000bb583          	ld	a1,0(s7)
 674:	855a                	mv	a0,s6
 676:	e47ff0ef          	jal	4bc <printint>
        i += 1;
 67a:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 67c:	8bca                	mv	s7,s2
      state = 0;
 67e:	4981                	li	s3,0
        i += 1;
 680:	b70d                	j	5a2 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 682:	06400793          	li	a5,100
 686:	02f60763          	beq	a2,a5,6b4 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 68a:	07500793          	li	a5,117
 68e:	06f60963          	beq	a2,a5,700 <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 692:	07800793          	li	a5,120
 696:	faf61ee3          	bne	a2,a5,652 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 69a:	008b8913          	addi	s2,s7,8
 69e:	4681                	li	a3,0
 6a0:	4641                	li	a2,16
 6a2:	000bb583          	ld	a1,0(s7)
 6a6:	855a                	mv	a0,s6
 6a8:	e15ff0ef          	jal	4bc <printint>
        i += 2;
 6ac:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 6ae:	8bca                	mv	s7,s2
      state = 0;
 6b0:	4981                	li	s3,0
        i += 2;
 6b2:	bdc5                	j	5a2 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 6b4:	008b8913          	addi	s2,s7,8
 6b8:	4685                	li	a3,1
 6ba:	4629                	li	a2,10
 6bc:	000bb583          	ld	a1,0(s7)
 6c0:	855a                	mv	a0,s6
 6c2:	dfbff0ef          	jal	4bc <printint>
        i += 2;
 6c6:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 6c8:	8bca                	mv	s7,s2
      state = 0;
 6ca:	4981                	li	s3,0
        i += 2;
 6cc:	bdd9                	j	5a2 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 6ce:	008b8913          	addi	s2,s7,8
 6d2:	4681                	li	a3,0
 6d4:	4629                	li	a2,10
 6d6:	000be583          	lwu	a1,0(s7)
 6da:	855a                	mv	a0,s6
 6dc:	de1ff0ef          	jal	4bc <printint>
 6e0:	8bca                	mv	s7,s2
      state = 0;
 6e2:	4981                	li	s3,0
 6e4:	bd7d                	j	5a2 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 6e6:	008b8913          	addi	s2,s7,8
 6ea:	4681                	li	a3,0
 6ec:	4629                	li	a2,10
 6ee:	000bb583          	ld	a1,0(s7)
 6f2:	855a                	mv	a0,s6
 6f4:	dc9ff0ef          	jal	4bc <printint>
        i += 1;
 6f8:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 6fa:	8bca                	mv	s7,s2
      state = 0;
 6fc:	4981                	li	s3,0
        i += 1;
 6fe:	b555                	j	5a2 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 700:	008b8913          	addi	s2,s7,8
 704:	4681                	li	a3,0
 706:	4629                	li	a2,10
 708:	000bb583          	ld	a1,0(s7)
 70c:	855a                	mv	a0,s6
 70e:	dafff0ef          	jal	4bc <printint>
        i += 2;
 712:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 714:	8bca                	mv	s7,s2
      state = 0;
 716:	4981                	li	s3,0
        i += 2;
 718:	b569                	j	5a2 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 71a:	008b8913          	addi	s2,s7,8
 71e:	4681                	li	a3,0
 720:	4641                	li	a2,16
 722:	000be583          	lwu	a1,0(s7)
 726:	855a                	mv	a0,s6
 728:	d95ff0ef          	jal	4bc <printint>
 72c:	8bca                	mv	s7,s2
      state = 0;
 72e:	4981                	li	s3,0
 730:	bd8d                	j	5a2 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 732:	008b8913          	addi	s2,s7,8
 736:	4681                	li	a3,0
 738:	4641                	li	a2,16
 73a:	000bb583          	ld	a1,0(s7)
 73e:	855a                	mv	a0,s6
 740:	d7dff0ef          	jal	4bc <printint>
        i += 1;
 744:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 746:	8bca                	mv	s7,s2
      state = 0;
 748:	4981                	li	s3,0
        i += 1;
 74a:	bda1                	j	5a2 <vprintf+0x4a>
 74c:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 74e:	008b8d13          	addi	s10,s7,8
 752:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 756:	03000593          	li	a1,48
 75a:	855a                	mv	a0,s6
 75c:	d43ff0ef          	jal	49e <putc>
  putc(fd, 'x');
 760:	07800593          	li	a1,120
 764:	855a                	mv	a0,s6
 766:	d39ff0ef          	jal	49e <putc>
 76a:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 76c:	00000b97          	auipc	s7,0x0
 770:	2acb8b93          	addi	s7,s7,684 # a18 <digits>
 774:	03c9d793          	srli	a5,s3,0x3c
 778:	97de                	add	a5,a5,s7
 77a:	0007c583          	lbu	a1,0(a5)
 77e:	855a                	mv	a0,s6
 780:	d1fff0ef          	jal	49e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 784:	0992                	slli	s3,s3,0x4
 786:	397d                	addiw	s2,s2,-1
 788:	fe0916e3          	bnez	s2,774 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 78c:	8bea                	mv	s7,s10
      state = 0;
 78e:	4981                	li	s3,0
 790:	6d02                	ld	s10,0(sp)
 792:	bd01                	j	5a2 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 794:	008b8913          	addi	s2,s7,8
 798:	000bc583          	lbu	a1,0(s7)
 79c:	855a                	mv	a0,s6
 79e:	d01ff0ef          	jal	49e <putc>
 7a2:	8bca                	mv	s7,s2
      state = 0;
 7a4:	4981                	li	s3,0
 7a6:	bbf5                	j	5a2 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 7a8:	008b8993          	addi	s3,s7,8
 7ac:	000bb903          	ld	s2,0(s7)
 7b0:	00090f63          	beqz	s2,7ce <vprintf+0x276>
        for(; *s; s++)
 7b4:	00094583          	lbu	a1,0(s2)
 7b8:	c195                	beqz	a1,7dc <vprintf+0x284>
          putc(fd, *s);
 7ba:	855a                	mv	a0,s6
 7bc:	ce3ff0ef          	jal	49e <putc>
        for(; *s; s++)
 7c0:	0905                	addi	s2,s2,1
 7c2:	00094583          	lbu	a1,0(s2)
 7c6:	f9f5                	bnez	a1,7ba <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 7c8:	8bce                	mv	s7,s3
      state = 0;
 7ca:	4981                	li	s3,0
 7cc:	bbd9                	j	5a2 <vprintf+0x4a>
          s = "(null)";
 7ce:	00000917          	auipc	s2,0x0
 7d2:	24290913          	addi	s2,s2,578 # a10 <malloc+0x136>
        for(; *s; s++)
 7d6:	02800593          	li	a1,40
 7da:	b7c5                	j	7ba <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 7dc:	8bce                	mv	s7,s3
      state = 0;
 7de:	4981                	li	s3,0
 7e0:	b3c9                	j	5a2 <vprintf+0x4a>
 7e2:	64a6                	ld	s1,72(sp)
 7e4:	79e2                	ld	s3,56(sp)
 7e6:	7a42                	ld	s4,48(sp)
 7e8:	7aa2                	ld	s5,40(sp)
 7ea:	7b02                	ld	s6,32(sp)
 7ec:	6be2                	ld	s7,24(sp)
 7ee:	6c42                	ld	s8,16(sp)
 7f0:	6ca2                	ld	s9,8(sp)
    }
  }
}
 7f2:	60e6                	ld	ra,88(sp)
 7f4:	6446                	ld	s0,80(sp)
 7f6:	6906                	ld	s2,64(sp)
 7f8:	6125                	addi	sp,sp,96
 7fa:	8082                	ret

00000000000007fc <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 7fc:	715d                	addi	sp,sp,-80
 7fe:	ec06                	sd	ra,24(sp)
 800:	e822                	sd	s0,16(sp)
 802:	1000                	addi	s0,sp,32
 804:	e010                	sd	a2,0(s0)
 806:	e414                	sd	a3,8(s0)
 808:	e818                	sd	a4,16(s0)
 80a:	ec1c                	sd	a5,24(s0)
 80c:	03043023          	sd	a6,32(s0)
 810:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 814:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 818:	8622                	mv	a2,s0
 81a:	d3fff0ef          	jal	558 <vprintf>
}
 81e:	60e2                	ld	ra,24(sp)
 820:	6442                	ld	s0,16(sp)
 822:	6161                	addi	sp,sp,80
 824:	8082                	ret

0000000000000826 <printf>:

void
printf(const char *fmt, ...)
{
 826:	711d                	addi	sp,sp,-96
 828:	ec06                	sd	ra,24(sp)
 82a:	e822                	sd	s0,16(sp)
 82c:	1000                	addi	s0,sp,32
 82e:	e40c                	sd	a1,8(s0)
 830:	e810                	sd	a2,16(s0)
 832:	ec14                	sd	a3,24(s0)
 834:	f018                	sd	a4,32(s0)
 836:	f41c                	sd	a5,40(s0)
 838:	03043823          	sd	a6,48(s0)
 83c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 840:	00840613          	addi	a2,s0,8
 844:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 848:	85aa                	mv	a1,a0
 84a:	4505                	li	a0,1
 84c:	d0dff0ef          	jal	558 <vprintf>
}
 850:	60e2                	ld	ra,24(sp)
 852:	6442                	ld	s0,16(sp)
 854:	6125                	addi	sp,sp,96
 856:	8082                	ret

0000000000000858 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 858:	1141                	addi	sp,sp,-16
 85a:	e422                	sd	s0,8(sp)
 85c:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 85e:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 862:	00000797          	auipc	a5,0x0
 866:	79e7b783          	ld	a5,1950(a5) # 1000 <freep>
 86a:	a02d                	j	894 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 86c:	4618                	lw	a4,8(a2)
 86e:	9f2d                	addw	a4,a4,a1
 870:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 874:	6398                	ld	a4,0(a5)
 876:	6310                	ld	a2,0(a4)
 878:	a83d                	j	8b6 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 87a:	ff852703          	lw	a4,-8(a0)
 87e:	9f31                	addw	a4,a4,a2
 880:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 882:	ff053683          	ld	a3,-16(a0)
 886:	a091                	j	8ca <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 888:	6398                	ld	a4,0(a5)
 88a:	00e7e463          	bltu	a5,a4,892 <free+0x3a>
 88e:	00e6ea63          	bltu	a3,a4,8a2 <free+0x4a>
{
 892:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 894:	fed7fae3          	bgeu	a5,a3,888 <free+0x30>
 898:	6398                	ld	a4,0(a5)
 89a:	00e6e463          	bltu	a3,a4,8a2 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 89e:	fee7eae3          	bltu	a5,a4,892 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 8a2:	ff852583          	lw	a1,-8(a0)
 8a6:	6390                	ld	a2,0(a5)
 8a8:	02059813          	slli	a6,a1,0x20
 8ac:	01c85713          	srli	a4,a6,0x1c
 8b0:	9736                	add	a4,a4,a3
 8b2:	fae60de3          	beq	a2,a4,86c <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 8b6:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8ba:	4790                	lw	a2,8(a5)
 8bc:	02061593          	slli	a1,a2,0x20
 8c0:	01c5d713          	srli	a4,a1,0x1c
 8c4:	973e                	add	a4,a4,a5
 8c6:	fae68ae3          	beq	a3,a4,87a <free+0x22>
    p->s.ptr = bp->s.ptr;
 8ca:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 8cc:	00000717          	auipc	a4,0x0
 8d0:	72f73a23          	sd	a5,1844(a4) # 1000 <freep>
}
 8d4:	6422                	ld	s0,8(sp)
 8d6:	0141                	addi	sp,sp,16
 8d8:	8082                	ret

00000000000008da <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 8da:	7139                	addi	sp,sp,-64
 8dc:	fc06                	sd	ra,56(sp)
 8de:	f822                	sd	s0,48(sp)
 8e0:	f426                	sd	s1,40(sp)
 8e2:	ec4e                	sd	s3,24(sp)
 8e4:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8e6:	02051493          	slli	s1,a0,0x20
 8ea:	9081                	srli	s1,s1,0x20
 8ec:	04bd                	addi	s1,s1,15
 8ee:	8091                	srli	s1,s1,0x4
 8f0:	0014899b          	addiw	s3,s1,1
 8f4:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 8f6:	00000517          	auipc	a0,0x0
 8fa:	70a53503          	ld	a0,1802(a0) # 1000 <freep>
 8fe:	c915                	beqz	a0,932 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 900:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 902:	4798                	lw	a4,8(a5)
 904:	08977a63          	bgeu	a4,s1,998 <malloc+0xbe>
 908:	f04a                	sd	s2,32(sp)
 90a:	e852                	sd	s4,16(sp)
 90c:	e456                	sd	s5,8(sp)
 90e:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 910:	8a4e                	mv	s4,s3
 912:	0009871b          	sext.w	a4,s3
 916:	6685                	lui	a3,0x1
 918:	00d77363          	bgeu	a4,a3,91e <malloc+0x44>
 91c:	6a05                	lui	s4,0x1
 91e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 922:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 926:	00000917          	auipc	s2,0x0
 92a:	6da90913          	addi	s2,s2,1754 # 1000 <freep>
  if(p == SBRK_ERROR)
 92e:	5afd                	li	s5,-1
 930:	a081                	j	970 <malloc+0x96>
 932:	f04a                	sd	s2,32(sp)
 934:	e852                	sd	s4,16(sp)
 936:	e456                	sd	s5,8(sp)
 938:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 93a:	00000797          	auipc	a5,0x0
 93e:	6d678793          	addi	a5,a5,1750 # 1010 <base>
 942:	00000717          	auipc	a4,0x0
 946:	6af73f23          	sd	a5,1726(a4) # 1000 <freep>
 94a:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 94c:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 950:	b7c1                	j	910 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 952:	6398                	ld	a4,0(a5)
 954:	e118                	sd	a4,0(a0)
 956:	a8a9                	j	9b0 <malloc+0xd6>
  hp->s.size = nu;
 958:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 95c:	0541                	addi	a0,a0,16
 95e:	efbff0ef          	jal	858 <free>
  return freep;
 962:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 966:	c12d                	beqz	a0,9c8 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 968:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 96a:	4798                	lw	a4,8(a5)
 96c:	02977263          	bgeu	a4,s1,990 <malloc+0xb6>
    if(p == freep)
 970:	00093703          	ld	a4,0(s2)
 974:	853e                	mv	a0,a5
 976:	fef719e3          	bne	a4,a5,968 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 97a:	8552                	mv	a0,s4
 97c:	933ff0ef          	jal	2ae <sbrk>
  if(p == SBRK_ERROR)
 980:	fd551ce3          	bne	a0,s5,958 <malloc+0x7e>
        return 0;
 984:	4501                	li	a0,0
 986:	7902                	ld	s2,32(sp)
 988:	6a42                	ld	s4,16(sp)
 98a:	6aa2                	ld	s5,8(sp)
 98c:	6b02                	ld	s6,0(sp)
 98e:	a03d                	j	9bc <malloc+0xe2>
 990:	7902                	ld	s2,32(sp)
 992:	6a42                	ld	s4,16(sp)
 994:	6aa2                	ld	s5,8(sp)
 996:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 998:	fae48de3          	beq	s1,a4,952 <malloc+0x78>
        p->s.size -= nunits;
 99c:	4137073b          	subw	a4,a4,s3
 9a0:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9a2:	02071693          	slli	a3,a4,0x20
 9a6:	01c6d713          	srli	a4,a3,0x1c
 9aa:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9ac:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9b0:	00000717          	auipc	a4,0x0
 9b4:	64a73823          	sd	a0,1616(a4) # 1000 <freep>
      return (void*)(p + 1);
 9b8:	01078513          	addi	a0,a5,16
  }
}
 9bc:	70e2                	ld	ra,56(sp)
 9be:	7442                	ld	s0,48(sp)
 9c0:	74a2                	ld	s1,40(sp)
 9c2:	69e2                	ld	s3,24(sp)
 9c4:	6121                	addi	sp,sp,64
 9c6:	8082                	ret
 9c8:	7902                	ld	s2,32(sp)
 9ca:	6a42                	ld	s4,16(sp)
 9cc:	6aa2                	ld	s5,8(sp)
 9ce:	6b02                	ld	s6,0(sp)
 9d0:	b7f5                	j	9bc <malloc+0xe2>
