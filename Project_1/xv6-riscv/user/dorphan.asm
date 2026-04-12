
user/_dorphan:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

char buf[BUFSZ];

int
main(int argc, char **argv)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	1000                	addi	s0,sp,32
  char *s = argv[0];
   a:	6184                	ld	s1,0(a1)

  if(mkdir("dd") != 0){
   c:	00001517          	auipc	a0,0x1
  10:	a0450513          	addi	a0,a0,-1532 # a10 <malloc+0xfa>
  14:	402000ef          	jal	416 <mkdir>
  18:	c919                	beqz	a0,2e <main+0x2e>
    printf("%s: mkdir dd failed\n", s);
  1a:	85a6                	mv	a1,s1
  1c:	00001517          	auipc	a0,0x1
  20:	9fc50513          	addi	a0,a0,-1540 # a18 <malloc+0x102>
  24:	03f000ef          	jal	862 <printf>
    exit(1);
  28:	4505                	li	a0,1
  2a:	384000ef          	jal	3ae <exit>
  }

  if(chdir("dd") != 0){
  2e:	00001517          	auipc	a0,0x1
  32:	9e250513          	addi	a0,a0,-1566 # a10 <malloc+0xfa>
  36:	3e8000ef          	jal	41e <chdir>
  3a:	c919                	beqz	a0,50 <main+0x50>
    printf("%s: chdir dd failed\n", s);
  3c:	85a6                	mv	a1,s1
  3e:	00001517          	auipc	a0,0x1
  42:	9f250513          	addi	a0,a0,-1550 # a30 <malloc+0x11a>
  46:	01d000ef          	jal	862 <printf>
    exit(1);
  4a:	4505                	li	a0,1
  4c:	362000ef          	jal	3ae <exit>
  }

  if (unlink("../dd") < 0) {
  50:	00001517          	auipc	a0,0x1
  54:	9f850513          	addi	a0,a0,-1544 # a48 <malloc+0x132>
  58:	3a6000ef          	jal	3fe <unlink>
  5c:	00054d63          	bltz	a0,76 <main+0x76>
    printf("%s: unlink failed\n", s);
    exit(1);
  }
  printf("wait for kill and reclaim\n");
  60:	00001517          	auipc	a0,0x1
  64:	a0850513          	addi	a0,a0,-1528 # a68 <malloc+0x152>
  68:	7fa000ef          	jal	862 <printf>
  // sit around until killed
  for(;;) pause(1000);
  6c:	3e800513          	li	a0,1000
  70:	3ce000ef          	jal	43e <pause>
  74:	bfe5                	j	6c <main+0x6c>
    printf("%s: unlink failed\n", s);
  76:	85a6                	mv	a1,s1
  78:	00001517          	auipc	a0,0x1
  7c:	9d850513          	addi	a0,a0,-1576 # a50 <malloc+0x13a>
  80:	7e2000ef          	jal	862 <printf>
    exit(1);
  84:	4505                	li	a0,1
  86:	328000ef          	jal	3ae <exit>

000000000000008a <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
  8a:	1141                	addi	sp,sp,-16
  8c:	e406                	sd	ra,8(sp)
  8e:	e022                	sd	s0,0(sp)
  90:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
  92:	f6fff0ef          	jal	0 <main>
  exit(r);
  96:	318000ef          	jal	3ae <exit>

000000000000009a <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  9a:	1141                	addi	sp,sp,-16
  9c:	e422                	sd	s0,8(sp)
  9e:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  a0:	87aa                	mv	a5,a0
  a2:	0585                	addi	a1,a1,1
  a4:	0785                	addi	a5,a5,1
  a6:	fff5c703          	lbu	a4,-1(a1)
  aa:	fee78fa3          	sb	a4,-1(a5)
  ae:	fb75                	bnez	a4,a2 <strcpy+0x8>
    ;
  return os;
}
  b0:	6422                	ld	s0,8(sp)
  b2:	0141                	addi	sp,sp,16
  b4:	8082                	ret

00000000000000b6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  b6:	1141                	addi	sp,sp,-16
  b8:	e422                	sd	s0,8(sp)
  ba:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  bc:	00054783          	lbu	a5,0(a0)
  c0:	cb91                	beqz	a5,d4 <strcmp+0x1e>
  c2:	0005c703          	lbu	a4,0(a1)
  c6:	00f71763          	bne	a4,a5,d4 <strcmp+0x1e>
    p++, q++;
  ca:	0505                	addi	a0,a0,1
  cc:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  ce:	00054783          	lbu	a5,0(a0)
  d2:	fbe5                	bnez	a5,c2 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  d4:	0005c503          	lbu	a0,0(a1)
}
  d8:	40a7853b          	subw	a0,a5,a0
  dc:	6422                	ld	s0,8(sp)
  de:	0141                	addi	sp,sp,16
  e0:	8082                	ret

00000000000000e2 <strlen>:

uint
strlen(const char *s)
{
  e2:	1141                	addi	sp,sp,-16
  e4:	e422                	sd	s0,8(sp)
  e6:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  e8:	00054783          	lbu	a5,0(a0)
  ec:	cf91                	beqz	a5,108 <strlen+0x26>
  ee:	0505                	addi	a0,a0,1
  f0:	87aa                	mv	a5,a0
  f2:	86be                	mv	a3,a5
  f4:	0785                	addi	a5,a5,1
  f6:	fff7c703          	lbu	a4,-1(a5)
  fa:	ff65                	bnez	a4,f2 <strlen+0x10>
  fc:	40a6853b          	subw	a0,a3,a0
 100:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 102:	6422                	ld	s0,8(sp)
 104:	0141                	addi	sp,sp,16
 106:	8082                	ret
  for(n = 0; s[n]; n++)
 108:	4501                	li	a0,0
 10a:	bfe5                	j	102 <strlen+0x20>

000000000000010c <memset>:

void*
memset(void *dst, int c, uint n)
{
 10c:	1141                	addi	sp,sp,-16
 10e:	e422                	sd	s0,8(sp)
 110:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 112:	ca19                	beqz	a2,128 <memset+0x1c>
 114:	87aa                	mv	a5,a0
 116:	1602                	slli	a2,a2,0x20
 118:	9201                	srli	a2,a2,0x20
 11a:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 11e:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 122:	0785                	addi	a5,a5,1
 124:	fee79de3          	bne	a5,a4,11e <memset+0x12>
  }
  return dst;
}
 128:	6422                	ld	s0,8(sp)
 12a:	0141                	addi	sp,sp,16
 12c:	8082                	ret

000000000000012e <strchr>:

char*
strchr(const char *s, char c)
{
 12e:	1141                	addi	sp,sp,-16
 130:	e422                	sd	s0,8(sp)
 132:	0800                	addi	s0,sp,16
  for(; *s; s++)
 134:	00054783          	lbu	a5,0(a0)
 138:	cb99                	beqz	a5,14e <strchr+0x20>
    if(*s == c)
 13a:	00f58763          	beq	a1,a5,148 <strchr+0x1a>
  for(; *s; s++)
 13e:	0505                	addi	a0,a0,1
 140:	00054783          	lbu	a5,0(a0)
 144:	fbfd                	bnez	a5,13a <strchr+0xc>
      return (char*)s;
  return 0;
 146:	4501                	li	a0,0
}
 148:	6422                	ld	s0,8(sp)
 14a:	0141                	addi	sp,sp,16
 14c:	8082                	ret
  return 0;
 14e:	4501                	li	a0,0
 150:	bfe5                	j	148 <strchr+0x1a>

0000000000000152 <gets>:

char*
gets(char *buf, int max)
{
 152:	711d                	addi	sp,sp,-96
 154:	ec86                	sd	ra,88(sp)
 156:	e8a2                	sd	s0,80(sp)
 158:	e4a6                	sd	s1,72(sp)
 15a:	e0ca                	sd	s2,64(sp)
 15c:	fc4e                	sd	s3,56(sp)
 15e:	f852                	sd	s4,48(sp)
 160:	f456                	sd	s5,40(sp)
 162:	f05a                	sd	s6,32(sp)
 164:	ec5e                	sd	s7,24(sp)
 166:	1080                	addi	s0,sp,96
 168:	8baa                	mv	s7,a0
 16a:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 16c:	892a                	mv	s2,a0
 16e:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 170:	4aa9                	li	s5,10
 172:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 174:	89a6                	mv	s3,s1
 176:	2485                	addiw	s1,s1,1
 178:	0344d663          	bge	s1,s4,1a4 <gets+0x52>
    cc = read(0, &c, 1);
 17c:	4605                	li	a2,1
 17e:	faf40593          	addi	a1,s0,-81
 182:	4501                	li	a0,0
 184:	242000ef          	jal	3c6 <read>
    if(cc < 1)
 188:	00a05e63          	blez	a0,1a4 <gets+0x52>
    buf[i++] = c;
 18c:	faf44783          	lbu	a5,-81(s0)
 190:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 194:	01578763          	beq	a5,s5,1a2 <gets+0x50>
 198:	0905                	addi	s2,s2,1
 19a:	fd679de3          	bne	a5,s6,174 <gets+0x22>
    buf[i++] = c;
 19e:	89a6                	mv	s3,s1
 1a0:	a011                	j	1a4 <gets+0x52>
 1a2:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1a4:	99de                	add	s3,s3,s7
 1a6:	00098023          	sb	zero,0(s3)
  return buf;
}
 1aa:	855e                	mv	a0,s7
 1ac:	60e6                	ld	ra,88(sp)
 1ae:	6446                	ld	s0,80(sp)
 1b0:	64a6                	ld	s1,72(sp)
 1b2:	6906                	ld	s2,64(sp)
 1b4:	79e2                	ld	s3,56(sp)
 1b6:	7a42                	ld	s4,48(sp)
 1b8:	7aa2                	ld	s5,40(sp)
 1ba:	7b02                	ld	s6,32(sp)
 1bc:	6be2                	ld	s7,24(sp)
 1be:	6125                	addi	sp,sp,96
 1c0:	8082                	ret

00000000000001c2 <stat>:

int
stat(const char *n, struct stat *st)
{
 1c2:	1101                	addi	sp,sp,-32
 1c4:	ec06                	sd	ra,24(sp)
 1c6:	e822                	sd	s0,16(sp)
 1c8:	e04a                	sd	s2,0(sp)
 1ca:	1000                	addi	s0,sp,32
 1cc:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1ce:	4581                	li	a1,0
 1d0:	21e000ef          	jal	3ee <open>
  if(fd < 0)
 1d4:	02054263          	bltz	a0,1f8 <stat+0x36>
 1d8:	e426                	sd	s1,8(sp)
 1da:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1dc:	85ca                	mv	a1,s2
 1de:	228000ef          	jal	406 <fstat>
 1e2:	892a                	mv	s2,a0
  close(fd);
 1e4:	8526                	mv	a0,s1
 1e6:	1f0000ef          	jal	3d6 <close>
  return r;
 1ea:	64a2                	ld	s1,8(sp)
}
 1ec:	854a                	mv	a0,s2
 1ee:	60e2                	ld	ra,24(sp)
 1f0:	6442                	ld	s0,16(sp)
 1f2:	6902                	ld	s2,0(sp)
 1f4:	6105                	addi	sp,sp,32
 1f6:	8082                	ret
    return -1;
 1f8:	597d                	li	s2,-1
 1fa:	bfcd                	j	1ec <stat+0x2a>

00000000000001fc <atoi>:

int
atoi(const char *s)
{
 1fc:	1141                	addi	sp,sp,-16
 1fe:	e422                	sd	s0,8(sp)
 200:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 202:	00054683          	lbu	a3,0(a0)
 206:	fd06879b          	addiw	a5,a3,-48
 20a:	0ff7f793          	zext.b	a5,a5
 20e:	4625                	li	a2,9
 210:	02f66863          	bltu	a2,a5,240 <atoi+0x44>
 214:	872a                	mv	a4,a0
  n = 0;
 216:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 218:	0705                	addi	a4,a4,1
 21a:	0025179b          	slliw	a5,a0,0x2
 21e:	9fa9                	addw	a5,a5,a0
 220:	0017979b          	slliw	a5,a5,0x1
 224:	9fb5                	addw	a5,a5,a3
 226:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 22a:	00074683          	lbu	a3,0(a4)
 22e:	fd06879b          	addiw	a5,a3,-48
 232:	0ff7f793          	zext.b	a5,a5
 236:	fef671e3          	bgeu	a2,a5,218 <atoi+0x1c>
  return n;
}
 23a:	6422                	ld	s0,8(sp)
 23c:	0141                	addi	sp,sp,16
 23e:	8082                	ret
  n = 0;
 240:	4501                	li	a0,0
 242:	bfe5                	j	23a <atoi+0x3e>

0000000000000244 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 244:	1141                	addi	sp,sp,-16
 246:	e422                	sd	s0,8(sp)
 248:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 24a:	02b57463          	bgeu	a0,a1,272 <memmove+0x2e>
    while(n-- > 0)
 24e:	00c05f63          	blez	a2,26c <memmove+0x28>
 252:	1602                	slli	a2,a2,0x20
 254:	9201                	srli	a2,a2,0x20
 256:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 25a:	872a                	mv	a4,a0
      *dst++ = *src++;
 25c:	0585                	addi	a1,a1,1
 25e:	0705                	addi	a4,a4,1
 260:	fff5c683          	lbu	a3,-1(a1)
 264:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 268:	fef71ae3          	bne	a4,a5,25c <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 26c:	6422                	ld	s0,8(sp)
 26e:	0141                	addi	sp,sp,16
 270:	8082                	ret
    dst += n;
 272:	00c50733          	add	a4,a0,a2
    src += n;
 276:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 278:	fec05ae3          	blez	a2,26c <memmove+0x28>
 27c:	fff6079b          	addiw	a5,a2,-1
 280:	1782                	slli	a5,a5,0x20
 282:	9381                	srli	a5,a5,0x20
 284:	fff7c793          	not	a5,a5
 288:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 28a:	15fd                	addi	a1,a1,-1
 28c:	177d                	addi	a4,a4,-1
 28e:	0005c683          	lbu	a3,0(a1)
 292:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 296:	fee79ae3          	bne	a5,a4,28a <memmove+0x46>
 29a:	bfc9                	j	26c <memmove+0x28>

000000000000029c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 29c:	1141                	addi	sp,sp,-16
 29e:	e422                	sd	s0,8(sp)
 2a0:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2a2:	ca05                	beqz	a2,2d2 <memcmp+0x36>
 2a4:	fff6069b          	addiw	a3,a2,-1
 2a8:	1682                	slli	a3,a3,0x20
 2aa:	9281                	srli	a3,a3,0x20
 2ac:	0685                	addi	a3,a3,1
 2ae:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2b0:	00054783          	lbu	a5,0(a0)
 2b4:	0005c703          	lbu	a4,0(a1)
 2b8:	00e79863          	bne	a5,a4,2c8 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 2bc:	0505                	addi	a0,a0,1
    p2++;
 2be:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2c0:	fed518e3          	bne	a0,a3,2b0 <memcmp+0x14>
  }
  return 0;
 2c4:	4501                	li	a0,0
 2c6:	a019                	j	2cc <memcmp+0x30>
      return *p1 - *p2;
 2c8:	40e7853b          	subw	a0,a5,a4
}
 2cc:	6422                	ld	s0,8(sp)
 2ce:	0141                	addi	sp,sp,16
 2d0:	8082                	ret
  return 0;
 2d2:	4501                	li	a0,0
 2d4:	bfe5                	j	2cc <memcmp+0x30>

00000000000002d6 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2d6:	1141                	addi	sp,sp,-16
 2d8:	e406                	sd	ra,8(sp)
 2da:	e022                	sd	s0,0(sp)
 2dc:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2de:	f67ff0ef          	jal	244 <memmove>
}
 2e2:	60a2                	ld	ra,8(sp)
 2e4:	6402                	ld	s0,0(sp)
 2e6:	0141                	addi	sp,sp,16
 2e8:	8082                	ret

00000000000002ea <sbrk>:

char *
sbrk(int n) {
 2ea:	1141                	addi	sp,sp,-16
 2ec:	e406                	sd	ra,8(sp)
 2ee:	e022                	sd	s0,0(sp)
 2f0:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 2f2:	4585                	li	a1,1
 2f4:	142000ef          	jal	436 <sys_sbrk>
}
 2f8:	60a2                	ld	ra,8(sp)
 2fa:	6402                	ld	s0,0(sp)
 2fc:	0141                	addi	sp,sp,16
 2fe:	8082                	ret

0000000000000300 <sbrklazy>:

char *
sbrklazy(int n) {
 300:	1141                	addi	sp,sp,-16
 302:	e406                	sd	ra,8(sp)
 304:	e022                	sd	s0,0(sp)
 306:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 308:	4589                	li	a1,2
 30a:	12c000ef          	jal	436 <sys_sbrk>
}
 30e:	60a2                	ld	ra,8(sp)
 310:	6402                	ld	s0,0(sp)
 312:	0141                	addi	sp,sp,16
 314:	8082                	ret

0000000000000316 <thread_create>:
// thread_create allocates a page-sized stack, calls clone(fn, arg, stacktop).
// Returns the new thread's pid, or -1 on error.
// The stack is passed back via *stack so the caller can free it after join.
int
thread_create(void(*fn)(void*), void *arg, void **stack)
{
 316:	7179                	addi	sp,sp,-48
 318:	f406                	sd	ra,40(sp)
 31a:	f022                	sd	s0,32(sp)
 31c:	e84a                	sd	s2,16(sp)
 31e:	e44e                	sd	s3,8(sp)
 320:	e052                	sd	s4,0(sp)
 322:	1800                	addi	s0,sp,48
 324:	89aa                	mv	s3,a0
 326:	8a2e                	mv	s4,a1
 328:	8932                	mv	s2,a2
  char *s = malloc(PGSIZE);
 32a:	6505                	lui	a0,0x1
 32c:	5ea000ef          	jal	916 <malloc>
  if(s == 0)
 330:	cd0d                	beqz	a0,36a <thread_create+0x54>
 332:	ec26                	sd	s1,24(sp)
 334:	84aa                	mv	s1,a0
    return -1;
  *stack = s;
 336:	00a93023          	sd	a0,0(s2)
  // Stack grows downward- pass the top of the allocated region.
  int pid = clone(fn, arg, s + PGSIZE);
 33a:	6605                	lui	a2,0x1
 33c:	962a                	add	a2,a2,a0
 33e:	85d2                	mv	a1,s4
 340:	854e                	mv	a0,s3
 342:	166000ef          	jal	4a8 <clone>
  if(pid < 0){
 346:	00054a63          	bltz	a0,35a <thread_create+0x44>
 34a:	64e2                	ld	s1,24(sp)
    free(s);
    *stack = 0;
    return -1;
  }
  return pid;
}
 34c:	70a2                	ld	ra,40(sp)
 34e:	7402                	ld	s0,32(sp)
 350:	6942                	ld	s2,16(sp)
 352:	69a2                	ld	s3,8(sp)
 354:	6a02                	ld	s4,0(sp)
 356:	6145                	addi	sp,sp,48
 358:	8082                	ret
    free(s);
 35a:	8526                	mv	a0,s1
 35c:	538000ef          	jal	894 <free>
    *stack = 0;
 360:	00093023          	sd	zero,0(s2)
    return -1;
 364:	557d                	li	a0,-1
 366:	64e2                	ld	s1,24(sp)
 368:	b7d5                	j	34c <thread_create+0x36>
    return -1;
 36a:	557d                	li	a0,-1
 36c:	b7c5                	j	34c <thread_create+0x36>

000000000000036e <thread_join>:
// Wait for any child thread to exit.
// If stack is non-null, frees the memory pointed to by *stack and clears it.
// Returns the joined thread's pid, or -1 Son error.
int
thread_join(void **stack)
{
 36e:	1101                	addi	sp,sp,-32
 370:	ec06                	sd	ra,24(sp)
 372:	e822                	sd	s0,16(sp)
 374:	e426                	sd	s1,8(sp)
 376:	e04a                	sd	s2,0(sp)
 378:	1000                	addi	s0,sp,32
 37a:	84aa                	mv	s1,a0
  int pid = join();
 37c:	134000ef          	jal	4b0 <join>
  if(pid < 0)
 380:	02054163          	bltz	a0,3a2 <thread_join+0x34>
 384:	892a                	mv	s2,a0
    return -1;
  if(stack && *stack){
 386:	c499                	beqz	s1,394 <thread_join+0x26>
 388:	6088                	ld	a0,0(s1)
 38a:	c509                	beqz	a0,394 <thread_join+0x26>
    free(*stack);
 38c:	508000ef          	jal	894 <free>
    *stack = 0;
 390:	0004b023          	sd	zero,0(s1)
  }
  return pid;
}
 394:	854a                	mv	a0,s2
 396:	60e2                	ld	ra,24(sp)
 398:	6442                	ld	s0,16(sp)
 39a:	64a2                	ld	s1,8(sp)
 39c:	6902                	ld	s2,0(sp)
 39e:	6105                	addi	sp,sp,32
 3a0:	8082                	ret
    return -1;
 3a2:	597d                	li	s2,-1
 3a4:	bfc5                	j	394 <thread_join+0x26>

00000000000003a6 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3a6:	4885                	li	a7,1
 ecall
 3a8:	00000073          	ecall
 ret
 3ac:	8082                	ret

00000000000003ae <exit>:
.global exit
exit:
 li a7, SYS_exit
 3ae:	4889                	li	a7,2
 ecall
 3b0:	00000073          	ecall
 ret
 3b4:	8082                	ret

00000000000003b6 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3b6:	488d                	li	a7,3
 ecall
 3b8:	00000073          	ecall
 ret
 3bc:	8082                	ret

00000000000003be <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3be:	4891                	li	a7,4
 ecall
 3c0:	00000073          	ecall
 ret
 3c4:	8082                	ret

00000000000003c6 <read>:
.global read
read:
 li a7, SYS_read
 3c6:	4895                	li	a7,5
 ecall
 3c8:	00000073          	ecall
 ret
 3cc:	8082                	ret

00000000000003ce <write>:
.global write
write:
 li a7, SYS_write
 3ce:	48c1                	li	a7,16
 ecall
 3d0:	00000073          	ecall
 ret
 3d4:	8082                	ret

00000000000003d6 <close>:
.global close
close:
 li a7, SYS_close
 3d6:	48d5                	li	a7,21
 ecall
 3d8:	00000073          	ecall
 ret
 3dc:	8082                	ret

00000000000003de <kill>:
.global kill
kill:
 li a7, SYS_kill
 3de:	4899                	li	a7,6
 ecall
 3e0:	00000073          	ecall
 ret
 3e4:	8082                	ret

00000000000003e6 <exec>:
.global exec
exec:
 li a7, SYS_exec
 3e6:	489d                	li	a7,7
 ecall
 3e8:	00000073          	ecall
 ret
 3ec:	8082                	ret

00000000000003ee <open>:
.global open
open:
 li a7, SYS_open
 3ee:	48bd                	li	a7,15
 ecall
 3f0:	00000073          	ecall
 ret
 3f4:	8082                	ret

00000000000003f6 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 3f6:	48c5                	li	a7,17
 ecall
 3f8:	00000073          	ecall
 ret
 3fc:	8082                	ret

00000000000003fe <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 3fe:	48c9                	li	a7,18
 ecall
 400:	00000073          	ecall
 ret
 404:	8082                	ret

0000000000000406 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 406:	48a1                	li	a7,8
 ecall
 408:	00000073          	ecall
 ret
 40c:	8082                	ret

000000000000040e <link>:
.global link
link:
 li a7, SYS_link
 40e:	48cd                	li	a7,19
 ecall
 410:	00000073          	ecall
 ret
 414:	8082                	ret

0000000000000416 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 416:	48d1                	li	a7,20
 ecall
 418:	00000073          	ecall
 ret
 41c:	8082                	ret

000000000000041e <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 41e:	48a5                	li	a7,9
 ecall
 420:	00000073          	ecall
 ret
 424:	8082                	ret

0000000000000426 <dup>:
.global dup
dup:
 li a7, SYS_dup
 426:	48a9                	li	a7,10
 ecall
 428:	00000073          	ecall
 ret
 42c:	8082                	ret

000000000000042e <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 42e:	48ad                	li	a7,11
 ecall
 430:	00000073          	ecall
 ret
 434:	8082                	ret

0000000000000436 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 436:	48b1                	li	a7,12
 ecall
 438:	00000073          	ecall
 ret
 43c:	8082                	ret

000000000000043e <pause>:
.global pause
pause:
 li a7, SYS_pause
 43e:	48b5                	li	a7,13
 ecall
 440:	00000073          	ecall
 ret
 444:	8082                	ret

0000000000000446 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 446:	48b9                	li	a7,14
 ecall
 448:	00000073          	ecall
 ret
 44c:	8082                	ret

000000000000044e <getppid>:
.global getppid
getppid:
 li a7, SYS_getppid
 44e:	02100893          	li	a7,33
 ecall
 452:	00000073          	ecall
 ret
 456:	8082                	ret

0000000000000458 <ps>:
.global ps
ps:
 li a7, SYS_ps
 458:	02200893          	li	a7,34
 ecall
 45c:	00000073          	ecall
 ret
 460:	8082                	ret

0000000000000462 <trace>:
.global trace
trace:
 li a7, SYS_trace
 462:	02300893          	li	a7,35
 ecall
 466:	00000073          	ecall
 ret
 46a:	8082                	ret

000000000000046c <waitx>:
.global waitx
waitx:
 li a7, SYS_waitx
 46c:	02400893          	li	a7,36
 ecall
 470:	00000073          	ecall
 ret
 474:	8082                	ret

0000000000000476 <getcount>:
.global getcount
getcount:
 li a7, SYS_getcount
 476:	02500893          	li	a7,37
 ecall
 47a:	00000073          	ecall
 ret
 47e:	8082                	ret

0000000000000480 <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 480:	48d9                	li	a7,22
 ecall
 482:	00000073          	ecall
 ret
 486:	8082                	ret

0000000000000488 <lock_create>:
.global lock_create
lock_create:
 li a7, SYS_lock_create
 488:	48dd                	li	a7,23
 ecall
 48a:	00000073          	ecall
 ret
 48e:	8082                	ret

0000000000000490 <lock_acquire>:
.global lock_acquire
lock_acquire:
 li a7, SYS_lock_acquire
 490:	48e1                	li	a7,24
 ecall
 492:	00000073          	ecall
 ret
 496:	8082                	ret

0000000000000498 <lock_release>:
.global lock_release
lock_release:
 li a7, SYS_lock_release
 498:	48e5                	li	a7,25
 ecall
 49a:	00000073          	ecall
 ret
 49e:	8082                	ret

00000000000004a0 <lock_destroy>:
.global lock_destroy
lock_destroy:
 li a7, SYS_lock_destroy
 4a0:	48e9                	li	a7,26
 ecall
 4a2:	00000073          	ecall
 ret
 4a6:	8082                	ret

00000000000004a8 <clone>:
.global clone
clone:
 li a7, SYS_clone
 4a8:	48ed                	li	a7,27
 ecall
 4aa:	00000073          	ecall
 ret
 4ae:	8082                	ret

00000000000004b0 <join>:
.global join
join:
 li a7, SYS_join
 4b0:	48f1                	li	a7,28
 ecall
 4b2:	00000073          	ecall
 ret
 4b6:	8082                	ret

00000000000004b8 <getprocessinfo>:
.global getprocessinfo
getprocessinfo:
 li a7, SYS_getprocessinfo
 4b8:	48f5                	li	a7,29
 ecall
 4ba:	00000073          	ecall
 ret
 4be:	8082                	ret

00000000000004c0 <shmget>:
.global shmget
shmget:
 li a7, SYS_shmget
 4c0:	48f9                	li	a7,30
 ecall
 4c2:	00000073          	ecall
 ret
 4c6:	8082                	ret

00000000000004c8 <shmattach>:
.global shmattach
shmattach:
 li a7, SYS_shmattach
 4c8:	48fd                	li	a7,31
 ecall
 4ca:	00000073          	ecall
 ret
 4ce:	8082                	ret

00000000000004d0 <shmdetach>:
.global shmdetach
shmdetach:
 li a7, SYS_shmdetach
 4d0:	02000893          	li	a7,32
 ecall
 4d4:	00000073          	ecall
 ret
 4d8:	8082                	ret

00000000000004da <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 4da:	1101                	addi	sp,sp,-32
 4dc:	ec06                	sd	ra,24(sp)
 4de:	e822                	sd	s0,16(sp)
 4e0:	1000                	addi	s0,sp,32
 4e2:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 4e6:	4605                	li	a2,1
 4e8:	fef40593          	addi	a1,s0,-17
 4ec:	ee3ff0ef          	jal	3ce <write>
}
 4f0:	60e2                	ld	ra,24(sp)
 4f2:	6442                	ld	s0,16(sp)
 4f4:	6105                	addi	sp,sp,32
 4f6:	8082                	ret

00000000000004f8 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 4f8:	715d                	addi	sp,sp,-80
 4fa:	e486                	sd	ra,72(sp)
 4fc:	e0a2                	sd	s0,64(sp)
 4fe:	f84a                	sd	s2,48(sp)
 500:	0880                	addi	s0,sp,80
 502:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 504:	c299                	beqz	a3,50a <printint+0x12>
 506:	0805c363          	bltz	a1,58c <printint+0x94>
  neg = 0;
 50a:	4881                	li	a7,0
 50c:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 510:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 512:	00000517          	auipc	a0,0x0
 516:	57e50513          	addi	a0,a0,1406 # a90 <digits>
 51a:	883e                	mv	a6,a5
 51c:	2785                	addiw	a5,a5,1
 51e:	02c5f733          	remu	a4,a1,a2
 522:	972a                	add	a4,a4,a0
 524:	00074703          	lbu	a4,0(a4)
 528:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 52c:	872e                	mv	a4,a1
 52e:	02c5d5b3          	divu	a1,a1,a2
 532:	0685                	addi	a3,a3,1
 534:	fec773e3          	bgeu	a4,a2,51a <printint+0x22>
  if(neg)
 538:	00088b63          	beqz	a7,54e <printint+0x56>
    buf[i++] = '-';
 53c:	fd078793          	addi	a5,a5,-48
 540:	97a2                	add	a5,a5,s0
 542:	02d00713          	li	a4,45
 546:	fee78423          	sb	a4,-24(a5)
 54a:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
 54e:	02f05a63          	blez	a5,582 <printint+0x8a>
 552:	fc26                	sd	s1,56(sp)
 554:	f44e                	sd	s3,40(sp)
 556:	fb840713          	addi	a4,s0,-72
 55a:	00f704b3          	add	s1,a4,a5
 55e:	fff70993          	addi	s3,a4,-1
 562:	99be                	add	s3,s3,a5
 564:	37fd                	addiw	a5,a5,-1
 566:	1782                	slli	a5,a5,0x20
 568:	9381                	srli	a5,a5,0x20
 56a:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 56e:	fff4c583          	lbu	a1,-1(s1)
 572:	854a                	mv	a0,s2
 574:	f67ff0ef          	jal	4da <putc>
  while(--i >= 0)
 578:	14fd                	addi	s1,s1,-1
 57a:	ff349ae3          	bne	s1,s3,56e <printint+0x76>
 57e:	74e2                	ld	s1,56(sp)
 580:	79a2                	ld	s3,40(sp)
}
 582:	60a6                	ld	ra,72(sp)
 584:	6406                	ld	s0,64(sp)
 586:	7942                	ld	s2,48(sp)
 588:	6161                	addi	sp,sp,80
 58a:	8082                	ret
    x = -xx;
 58c:	40b005b3          	neg	a1,a1
    neg = 1;
 590:	4885                	li	a7,1
    x = -xx;
 592:	bfad                	j	50c <printint+0x14>

0000000000000594 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 594:	711d                	addi	sp,sp,-96
 596:	ec86                	sd	ra,88(sp)
 598:	e8a2                	sd	s0,80(sp)
 59a:	e0ca                	sd	s2,64(sp)
 59c:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 59e:	0005c903          	lbu	s2,0(a1)
 5a2:	28090663          	beqz	s2,82e <vprintf+0x29a>
 5a6:	e4a6                	sd	s1,72(sp)
 5a8:	fc4e                	sd	s3,56(sp)
 5aa:	f852                	sd	s4,48(sp)
 5ac:	f456                	sd	s5,40(sp)
 5ae:	f05a                	sd	s6,32(sp)
 5b0:	ec5e                	sd	s7,24(sp)
 5b2:	e862                	sd	s8,16(sp)
 5b4:	e466                	sd	s9,8(sp)
 5b6:	8b2a                	mv	s6,a0
 5b8:	8a2e                	mv	s4,a1
 5ba:	8bb2                	mv	s7,a2
  state = 0;
 5bc:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 5be:	4481                	li	s1,0
 5c0:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 5c2:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 5c6:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 5ca:	06c00c93          	li	s9,108
 5ce:	a005                	j	5ee <vprintf+0x5a>
        putc(fd, c0);
 5d0:	85ca                	mv	a1,s2
 5d2:	855a                	mv	a0,s6
 5d4:	f07ff0ef          	jal	4da <putc>
 5d8:	a019                	j	5de <vprintf+0x4a>
    } else if(state == '%'){
 5da:	03598263          	beq	s3,s5,5fe <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 5de:	2485                	addiw	s1,s1,1
 5e0:	8726                	mv	a4,s1
 5e2:	009a07b3          	add	a5,s4,s1
 5e6:	0007c903          	lbu	s2,0(a5)
 5ea:	22090a63          	beqz	s2,81e <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 5ee:	0009079b          	sext.w	a5,s2
    if(state == 0){
 5f2:	fe0994e3          	bnez	s3,5da <vprintf+0x46>
      if(c0 == '%'){
 5f6:	fd579de3          	bne	a5,s5,5d0 <vprintf+0x3c>
        state = '%';
 5fa:	89be                	mv	s3,a5
 5fc:	b7cd                	j	5de <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 5fe:	00ea06b3          	add	a3,s4,a4
 602:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 606:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 608:	c681                	beqz	a3,610 <vprintf+0x7c>
 60a:	9752                	add	a4,a4,s4
 60c:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 610:	05878363          	beq	a5,s8,656 <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 614:	05978d63          	beq	a5,s9,66e <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 618:	07500713          	li	a4,117
 61c:	0ee78763          	beq	a5,a4,70a <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 620:	07800713          	li	a4,120
 624:	12e78963          	beq	a5,a4,756 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 628:	07000713          	li	a4,112
 62c:	14e78e63          	beq	a5,a4,788 <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 630:	06300713          	li	a4,99
 634:	18e78e63          	beq	a5,a4,7d0 <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 638:	07300713          	li	a4,115
 63c:	1ae78463          	beq	a5,a4,7e4 <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 640:	02500713          	li	a4,37
 644:	04e79563          	bne	a5,a4,68e <vprintf+0xfa>
        putc(fd, '%');
 648:	02500593          	li	a1,37
 64c:	855a                	mv	a0,s6
 64e:	e8dff0ef          	jal	4da <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 652:	4981                	li	s3,0
 654:	b769                	j	5de <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 656:	008b8913          	addi	s2,s7,8
 65a:	4685                	li	a3,1
 65c:	4629                	li	a2,10
 65e:	000ba583          	lw	a1,0(s7)
 662:	855a                	mv	a0,s6
 664:	e95ff0ef          	jal	4f8 <printint>
 668:	8bca                	mv	s7,s2
      state = 0;
 66a:	4981                	li	s3,0
 66c:	bf8d                	j	5de <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 66e:	06400793          	li	a5,100
 672:	02f68963          	beq	a3,a5,6a4 <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 676:	06c00793          	li	a5,108
 67a:	04f68263          	beq	a3,a5,6be <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 67e:	07500793          	li	a5,117
 682:	0af68063          	beq	a3,a5,722 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 686:	07800793          	li	a5,120
 68a:	0ef68263          	beq	a3,a5,76e <vprintf+0x1da>
        putc(fd, '%');
 68e:	02500593          	li	a1,37
 692:	855a                	mv	a0,s6
 694:	e47ff0ef          	jal	4da <putc>
        putc(fd, c0);
 698:	85ca                	mv	a1,s2
 69a:	855a                	mv	a0,s6
 69c:	e3fff0ef          	jal	4da <putc>
      state = 0;
 6a0:	4981                	li	s3,0
 6a2:	bf35                	j	5de <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 6a4:	008b8913          	addi	s2,s7,8
 6a8:	4685                	li	a3,1
 6aa:	4629                	li	a2,10
 6ac:	000bb583          	ld	a1,0(s7)
 6b0:	855a                	mv	a0,s6
 6b2:	e47ff0ef          	jal	4f8 <printint>
        i += 1;
 6b6:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 6b8:	8bca                	mv	s7,s2
      state = 0;
 6ba:	4981                	li	s3,0
        i += 1;
 6bc:	b70d                	j	5de <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 6be:	06400793          	li	a5,100
 6c2:	02f60763          	beq	a2,a5,6f0 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 6c6:	07500793          	li	a5,117
 6ca:	06f60963          	beq	a2,a5,73c <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 6ce:	07800793          	li	a5,120
 6d2:	faf61ee3          	bne	a2,a5,68e <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 6d6:	008b8913          	addi	s2,s7,8
 6da:	4681                	li	a3,0
 6dc:	4641                	li	a2,16
 6de:	000bb583          	ld	a1,0(s7)
 6e2:	855a                	mv	a0,s6
 6e4:	e15ff0ef          	jal	4f8 <printint>
        i += 2;
 6e8:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 6ea:	8bca                	mv	s7,s2
      state = 0;
 6ec:	4981                	li	s3,0
        i += 2;
 6ee:	bdc5                	j	5de <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 6f0:	008b8913          	addi	s2,s7,8
 6f4:	4685                	li	a3,1
 6f6:	4629                	li	a2,10
 6f8:	000bb583          	ld	a1,0(s7)
 6fc:	855a                	mv	a0,s6
 6fe:	dfbff0ef          	jal	4f8 <printint>
        i += 2;
 702:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 704:	8bca                	mv	s7,s2
      state = 0;
 706:	4981                	li	s3,0
        i += 2;
 708:	bdd9                	j	5de <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 70a:	008b8913          	addi	s2,s7,8
 70e:	4681                	li	a3,0
 710:	4629                	li	a2,10
 712:	000be583          	lwu	a1,0(s7)
 716:	855a                	mv	a0,s6
 718:	de1ff0ef          	jal	4f8 <printint>
 71c:	8bca                	mv	s7,s2
      state = 0;
 71e:	4981                	li	s3,0
 720:	bd7d                	j	5de <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 722:	008b8913          	addi	s2,s7,8
 726:	4681                	li	a3,0
 728:	4629                	li	a2,10
 72a:	000bb583          	ld	a1,0(s7)
 72e:	855a                	mv	a0,s6
 730:	dc9ff0ef          	jal	4f8 <printint>
        i += 1;
 734:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 736:	8bca                	mv	s7,s2
      state = 0;
 738:	4981                	li	s3,0
        i += 1;
 73a:	b555                	j	5de <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 73c:	008b8913          	addi	s2,s7,8
 740:	4681                	li	a3,0
 742:	4629                	li	a2,10
 744:	000bb583          	ld	a1,0(s7)
 748:	855a                	mv	a0,s6
 74a:	dafff0ef          	jal	4f8 <printint>
        i += 2;
 74e:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 750:	8bca                	mv	s7,s2
      state = 0;
 752:	4981                	li	s3,0
        i += 2;
 754:	b569                	j	5de <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 756:	008b8913          	addi	s2,s7,8
 75a:	4681                	li	a3,0
 75c:	4641                	li	a2,16
 75e:	000be583          	lwu	a1,0(s7)
 762:	855a                	mv	a0,s6
 764:	d95ff0ef          	jal	4f8 <printint>
 768:	8bca                	mv	s7,s2
      state = 0;
 76a:	4981                	li	s3,0
 76c:	bd8d                	j	5de <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 76e:	008b8913          	addi	s2,s7,8
 772:	4681                	li	a3,0
 774:	4641                	li	a2,16
 776:	000bb583          	ld	a1,0(s7)
 77a:	855a                	mv	a0,s6
 77c:	d7dff0ef          	jal	4f8 <printint>
        i += 1;
 780:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 782:	8bca                	mv	s7,s2
      state = 0;
 784:	4981                	li	s3,0
        i += 1;
 786:	bda1                	j	5de <vprintf+0x4a>
 788:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 78a:	008b8d13          	addi	s10,s7,8
 78e:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 792:	03000593          	li	a1,48
 796:	855a                	mv	a0,s6
 798:	d43ff0ef          	jal	4da <putc>
  putc(fd, 'x');
 79c:	07800593          	li	a1,120
 7a0:	855a                	mv	a0,s6
 7a2:	d39ff0ef          	jal	4da <putc>
 7a6:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7a8:	00000b97          	auipc	s7,0x0
 7ac:	2e8b8b93          	addi	s7,s7,744 # a90 <digits>
 7b0:	03c9d793          	srli	a5,s3,0x3c
 7b4:	97de                	add	a5,a5,s7
 7b6:	0007c583          	lbu	a1,0(a5)
 7ba:	855a                	mv	a0,s6
 7bc:	d1fff0ef          	jal	4da <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7c0:	0992                	slli	s3,s3,0x4
 7c2:	397d                	addiw	s2,s2,-1
 7c4:	fe0916e3          	bnez	s2,7b0 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 7c8:	8bea                	mv	s7,s10
      state = 0;
 7ca:	4981                	li	s3,0
 7cc:	6d02                	ld	s10,0(sp)
 7ce:	bd01                	j	5de <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 7d0:	008b8913          	addi	s2,s7,8
 7d4:	000bc583          	lbu	a1,0(s7)
 7d8:	855a                	mv	a0,s6
 7da:	d01ff0ef          	jal	4da <putc>
 7de:	8bca                	mv	s7,s2
      state = 0;
 7e0:	4981                	li	s3,0
 7e2:	bbf5                	j	5de <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 7e4:	008b8993          	addi	s3,s7,8
 7e8:	000bb903          	ld	s2,0(s7)
 7ec:	00090f63          	beqz	s2,80a <vprintf+0x276>
        for(; *s; s++)
 7f0:	00094583          	lbu	a1,0(s2)
 7f4:	c195                	beqz	a1,818 <vprintf+0x284>
          putc(fd, *s);
 7f6:	855a                	mv	a0,s6
 7f8:	ce3ff0ef          	jal	4da <putc>
        for(; *s; s++)
 7fc:	0905                	addi	s2,s2,1
 7fe:	00094583          	lbu	a1,0(s2)
 802:	f9f5                	bnez	a1,7f6 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 804:	8bce                	mv	s7,s3
      state = 0;
 806:	4981                	li	s3,0
 808:	bbd9                	j	5de <vprintf+0x4a>
          s = "(null)";
 80a:	00000917          	auipc	s2,0x0
 80e:	27e90913          	addi	s2,s2,638 # a88 <malloc+0x172>
        for(; *s; s++)
 812:	02800593          	li	a1,40
 816:	b7c5                	j	7f6 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 818:	8bce                	mv	s7,s3
      state = 0;
 81a:	4981                	li	s3,0
 81c:	b3c9                	j	5de <vprintf+0x4a>
 81e:	64a6                	ld	s1,72(sp)
 820:	79e2                	ld	s3,56(sp)
 822:	7a42                	ld	s4,48(sp)
 824:	7aa2                	ld	s5,40(sp)
 826:	7b02                	ld	s6,32(sp)
 828:	6be2                	ld	s7,24(sp)
 82a:	6c42                	ld	s8,16(sp)
 82c:	6ca2                	ld	s9,8(sp)
    }
  }
}
 82e:	60e6                	ld	ra,88(sp)
 830:	6446                	ld	s0,80(sp)
 832:	6906                	ld	s2,64(sp)
 834:	6125                	addi	sp,sp,96
 836:	8082                	ret

0000000000000838 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 838:	715d                	addi	sp,sp,-80
 83a:	ec06                	sd	ra,24(sp)
 83c:	e822                	sd	s0,16(sp)
 83e:	1000                	addi	s0,sp,32
 840:	e010                	sd	a2,0(s0)
 842:	e414                	sd	a3,8(s0)
 844:	e818                	sd	a4,16(s0)
 846:	ec1c                	sd	a5,24(s0)
 848:	03043023          	sd	a6,32(s0)
 84c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 850:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 854:	8622                	mv	a2,s0
 856:	d3fff0ef          	jal	594 <vprintf>
}
 85a:	60e2                	ld	ra,24(sp)
 85c:	6442                	ld	s0,16(sp)
 85e:	6161                	addi	sp,sp,80
 860:	8082                	ret

0000000000000862 <printf>:

void
printf(const char *fmt, ...)
{
 862:	711d                	addi	sp,sp,-96
 864:	ec06                	sd	ra,24(sp)
 866:	e822                	sd	s0,16(sp)
 868:	1000                	addi	s0,sp,32
 86a:	e40c                	sd	a1,8(s0)
 86c:	e810                	sd	a2,16(s0)
 86e:	ec14                	sd	a3,24(s0)
 870:	f018                	sd	a4,32(s0)
 872:	f41c                	sd	a5,40(s0)
 874:	03043823          	sd	a6,48(s0)
 878:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 87c:	00840613          	addi	a2,s0,8
 880:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 884:	85aa                	mv	a1,a0
 886:	4505                	li	a0,1
 888:	d0dff0ef          	jal	594 <vprintf>
}
 88c:	60e2                	ld	ra,24(sp)
 88e:	6442                	ld	s0,16(sp)
 890:	6125                	addi	sp,sp,96
 892:	8082                	ret

0000000000000894 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 894:	1141                	addi	sp,sp,-16
 896:	e422                	sd	s0,8(sp)
 898:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 89a:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 89e:	00000797          	auipc	a5,0x0
 8a2:	7627b783          	ld	a5,1890(a5) # 1000 <freep>
 8a6:	a02d                	j	8d0 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8a8:	4618                	lw	a4,8(a2)
 8aa:	9f2d                	addw	a4,a4,a1
 8ac:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8b0:	6398                	ld	a4,0(a5)
 8b2:	6310                	ld	a2,0(a4)
 8b4:	a83d                	j	8f2 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8b6:	ff852703          	lw	a4,-8(a0)
 8ba:	9f31                	addw	a4,a4,a2
 8bc:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 8be:	ff053683          	ld	a3,-16(a0)
 8c2:	a091                	j	906 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8c4:	6398                	ld	a4,0(a5)
 8c6:	00e7e463          	bltu	a5,a4,8ce <free+0x3a>
 8ca:	00e6ea63          	bltu	a3,a4,8de <free+0x4a>
{
 8ce:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8d0:	fed7fae3          	bgeu	a5,a3,8c4 <free+0x30>
 8d4:	6398                	ld	a4,0(a5)
 8d6:	00e6e463          	bltu	a3,a4,8de <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8da:	fee7eae3          	bltu	a5,a4,8ce <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 8de:	ff852583          	lw	a1,-8(a0)
 8e2:	6390                	ld	a2,0(a5)
 8e4:	02059813          	slli	a6,a1,0x20
 8e8:	01c85713          	srli	a4,a6,0x1c
 8ec:	9736                	add	a4,a4,a3
 8ee:	fae60de3          	beq	a2,a4,8a8 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 8f2:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 8f6:	4790                	lw	a2,8(a5)
 8f8:	02061593          	slli	a1,a2,0x20
 8fc:	01c5d713          	srli	a4,a1,0x1c
 900:	973e                	add	a4,a4,a5
 902:	fae68ae3          	beq	a3,a4,8b6 <free+0x22>
    p->s.ptr = bp->s.ptr;
 906:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 908:	00000717          	auipc	a4,0x0
 90c:	6ef73c23          	sd	a5,1784(a4) # 1000 <freep>
}
 910:	6422                	ld	s0,8(sp)
 912:	0141                	addi	sp,sp,16
 914:	8082                	ret

0000000000000916 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 916:	7139                	addi	sp,sp,-64
 918:	fc06                	sd	ra,56(sp)
 91a:	f822                	sd	s0,48(sp)
 91c:	f426                	sd	s1,40(sp)
 91e:	ec4e                	sd	s3,24(sp)
 920:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 922:	02051493          	slli	s1,a0,0x20
 926:	9081                	srli	s1,s1,0x20
 928:	04bd                	addi	s1,s1,15
 92a:	8091                	srli	s1,s1,0x4
 92c:	0014899b          	addiw	s3,s1,1
 930:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 932:	00000517          	auipc	a0,0x0
 936:	6ce53503          	ld	a0,1742(a0) # 1000 <freep>
 93a:	c915                	beqz	a0,96e <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 93c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 93e:	4798                	lw	a4,8(a5)
 940:	08977a63          	bgeu	a4,s1,9d4 <malloc+0xbe>
 944:	f04a                	sd	s2,32(sp)
 946:	e852                	sd	s4,16(sp)
 948:	e456                	sd	s5,8(sp)
 94a:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 94c:	8a4e                	mv	s4,s3
 94e:	0009871b          	sext.w	a4,s3
 952:	6685                	lui	a3,0x1
 954:	00d77363          	bgeu	a4,a3,95a <malloc+0x44>
 958:	6a05                	lui	s4,0x1
 95a:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 95e:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 962:	00000917          	auipc	s2,0x0
 966:	69e90913          	addi	s2,s2,1694 # 1000 <freep>
  if(p == SBRK_ERROR)
 96a:	5afd                	li	s5,-1
 96c:	a081                	j	9ac <malloc+0x96>
 96e:	f04a                	sd	s2,32(sp)
 970:	e852                	sd	s4,16(sp)
 972:	e456                	sd	s5,8(sp)
 974:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 976:	00001797          	auipc	a5,0x1
 97a:	89278793          	addi	a5,a5,-1902 # 1208 <base>
 97e:	00000717          	auipc	a4,0x0
 982:	68f73123          	sd	a5,1666(a4) # 1000 <freep>
 986:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 988:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 98c:	b7c1                	j	94c <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 98e:	6398                	ld	a4,0(a5)
 990:	e118                	sd	a4,0(a0)
 992:	a8a9                	j	9ec <malloc+0xd6>
  hp->s.size = nu;
 994:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 998:	0541                	addi	a0,a0,16
 99a:	efbff0ef          	jal	894 <free>
  return freep;
 99e:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 9a2:	c12d                	beqz	a0,a04 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9a4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9a6:	4798                	lw	a4,8(a5)
 9a8:	02977263          	bgeu	a4,s1,9cc <malloc+0xb6>
    if(p == freep)
 9ac:	00093703          	ld	a4,0(s2)
 9b0:	853e                	mv	a0,a5
 9b2:	fef719e3          	bne	a4,a5,9a4 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 9b6:	8552                	mv	a0,s4
 9b8:	933ff0ef          	jal	2ea <sbrk>
  if(p == SBRK_ERROR)
 9bc:	fd551ce3          	bne	a0,s5,994 <malloc+0x7e>
        return 0;
 9c0:	4501                	li	a0,0
 9c2:	7902                	ld	s2,32(sp)
 9c4:	6a42                	ld	s4,16(sp)
 9c6:	6aa2                	ld	s5,8(sp)
 9c8:	6b02                	ld	s6,0(sp)
 9ca:	a03d                	j	9f8 <malloc+0xe2>
 9cc:	7902                	ld	s2,32(sp)
 9ce:	6a42                	ld	s4,16(sp)
 9d0:	6aa2                	ld	s5,8(sp)
 9d2:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 9d4:	fae48de3          	beq	s1,a4,98e <malloc+0x78>
        p->s.size -= nunits;
 9d8:	4137073b          	subw	a4,a4,s3
 9dc:	c798                	sw	a4,8(a5)
        p += p->s.size;
 9de:	02071693          	slli	a3,a4,0x20
 9e2:	01c6d713          	srli	a4,a3,0x1c
 9e6:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 9e8:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 9ec:	00000717          	auipc	a4,0x0
 9f0:	60a73a23          	sd	a0,1556(a4) # 1000 <freep>
      return (void*)(p + 1);
 9f4:	01078513          	addi	a0,a5,16
  }
}
 9f8:	70e2                	ld	ra,56(sp)
 9fa:	7442                	ld	s0,48(sp)
 9fc:	74a2                	ld	s1,40(sp)
 9fe:	69e2                	ld	s3,24(sp)
 a00:	6121                	addi	sp,sp,64
 a02:	8082                	ret
 a04:	7902                	ld	s2,32(sp)
 a06:	6a42                	ld	s4,16(sp)
 a08:	6aa2                	ld	s5,8(sp)
 a0a:	6b02                	ld	s6,0(sp)
 a0c:	b7f5                	j	9f8 <malloc+0xe2>
