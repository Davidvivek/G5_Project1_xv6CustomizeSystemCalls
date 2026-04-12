
user/_forphan:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

char buf[BUFSZ];

int
main(int argc, char **argv)
{
   0:	7139                	addi	sp,sp,-64
   2:	fc06                	sd	ra,56(sp)
   4:	f822                	sd	s0,48(sp)
   6:	f426                	sd	s1,40(sp)
   8:	0080                	addi	s0,sp,64
  int fd = 0;
  char *s = argv[0];
   a:	6184                	ld	s1,0(a1)
  struct stat st;
  char *ff = "file0";
  
  if ((fd = open(ff, O_CREATE|O_WRONLY)) < 0) {
   c:	20100593          	li	a1,513
  10:	00001517          	auipc	a0,0x1
  14:	a4050513          	addi	a0,a0,-1472 # a50 <malloc+0x100>
  18:	410000ef          	jal	428 <open>
  1c:	04054463          	bltz	a0,64 <main+0x64>
    printf("%s: open failed\n", s);
    exit(1);
  }
  if(fstat(fd, &st) < 0){
  20:	fc840593          	addi	a1,s0,-56
  24:	41c000ef          	jal	440 <fstat>
  28:	04054863          	bltz	a0,78 <main+0x78>
    fprintf(2, "%s: cannot stat %s\n", s, "ff");
    exit(1);
  }
  if (unlink(ff) < 0) {
  2c:	00001517          	auipc	a0,0x1
  30:	a2450513          	addi	a0,a0,-1500 # a50 <malloc+0x100>
  34:	404000ef          	jal	438 <unlink>
  38:	04054f63          	bltz	a0,96 <main+0x96>
    printf("%s: unlink failed\n", s);
    exit(1);
  }
  if (open(ff, O_RDONLY) != -1) {
  3c:	4581                	li	a1,0
  3e:	00001517          	auipc	a0,0x1
  42:	a1250513          	addi	a0,a0,-1518 # a50 <malloc+0x100>
  46:	3e2000ef          	jal	428 <open>
  4a:	57fd                	li	a5,-1
  4c:	04f50f63          	beq	a0,a5,aa <main+0xaa>
    printf("%s: open successed\n", s);
  50:	85a6                	mv	a1,s1
  52:	00001517          	auipc	a0,0x1
  56:	a5e50513          	addi	a0,a0,-1442 # ab0 <malloc+0x160>
  5a:	043000ef          	jal	89c <printf>
    exit(1);
  5e:	4505                	li	a0,1
  60:	388000ef          	jal	3e8 <exit>
    printf("%s: open failed\n", s);
  64:	85a6                	mv	a1,s1
  66:	00001517          	auipc	a0,0x1
  6a:	9fa50513          	addi	a0,a0,-1542 # a60 <malloc+0x110>
  6e:	02f000ef          	jal	89c <printf>
    exit(1);
  72:	4505                	li	a0,1
  74:	374000ef          	jal	3e8 <exit>
    fprintf(2, "%s: cannot stat %s\n", s, "ff");
  78:	00001697          	auipc	a3,0x1
  7c:	a0068693          	addi	a3,a3,-1536 # a78 <malloc+0x128>
  80:	8626                	mv	a2,s1
  82:	00001597          	auipc	a1,0x1
  86:	9fe58593          	addi	a1,a1,-1538 # a80 <malloc+0x130>
  8a:	4509                	li	a0,2
  8c:	7e6000ef          	jal	872 <fprintf>
    exit(1);
  90:	4505                	li	a0,1
  92:	356000ef          	jal	3e8 <exit>
    printf("%s: unlink failed\n", s);
  96:	85a6                	mv	a1,s1
  98:	00001517          	auipc	a0,0x1
  9c:	a0050513          	addi	a0,a0,-1536 # a98 <malloc+0x148>
  a0:	7fc000ef          	jal	89c <printf>
    exit(1);
  a4:	4505                	li	a0,1
  a6:	342000ef          	jal	3e8 <exit>
  }
  printf("wait for kill and reclaim %d\n", st.ino);
  aa:	fcc42583          	lw	a1,-52(s0)
  ae:	00001517          	auipc	a0,0x1
  b2:	a1a50513          	addi	a0,a0,-1510 # ac8 <malloc+0x178>
  b6:	7e6000ef          	jal	89c <printf>
  // sit around until killed
  for(;;) pause(1000);
  ba:	3e800513          	li	a0,1000
  be:	3ba000ef          	jal	478 <pause>
  c2:	bfe5                	j	ba <main+0xba>

00000000000000c4 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
  c4:	1141                	addi	sp,sp,-16
  c6:	e406                	sd	ra,8(sp)
  c8:	e022                	sd	s0,0(sp)
  ca:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
  cc:	f35ff0ef          	jal	0 <main>
  exit(r);
  d0:	318000ef          	jal	3e8 <exit>

00000000000000d4 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  d4:	1141                	addi	sp,sp,-16
  d6:	e422                	sd	s0,8(sp)
  d8:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  da:	87aa                	mv	a5,a0
  dc:	0585                	addi	a1,a1,1
  de:	0785                	addi	a5,a5,1
  e0:	fff5c703          	lbu	a4,-1(a1)
  e4:	fee78fa3          	sb	a4,-1(a5)
  e8:	fb75                	bnez	a4,dc <strcpy+0x8>
    ;
  return os;
}
  ea:	6422                	ld	s0,8(sp)
  ec:	0141                	addi	sp,sp,16
  ee:	8082                	ret

00000000000000f0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  f0:	1141                	addi	sp,sp,-16
  f2:	e422                	sd	s0,8(sp)
  f4:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  f6:	00054783          	lbu	a5,0(a0)
  fa:	cb91                	beqz	a5,10e <strcmp+0x1e>
  fc:	0005c703          	lbu	a4,0(a1)
 100:	00f71763          	bne	a4,a5,10e <strcmp+0x1e>
    p++, q++;
 104:	0505                	addi	a0,a0,1
 106:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 108:	00054783          	lbu	a5,0(a0)
 10c:	fbe5                	bnez	a5,fc <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 10e:	0005c503          	lbu	a0,0(a1)
}
 112:	40a7853b          	subw	a0,a5,a0
 116:	6422                	ld	s0,8(sp)
 118:	0141                	addi	sp,sp,16
 11a:	8082                	ret

000000000000011c <strlen>:

uint
strlen(const char *s)
{
 11c:	1141                	addi	sp,sp,-16
 11e:	e422                	sd	s0,8(sp)
 120:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 122:	00054783          	lbu	a5,0(a0)
 126:	cf91                	beqz	a5,142 <strlen+0x26>
 128:	0505                	addi	a0,a0,1
 12a:	87aa                	mv	a5,a0
 12c:	86be                	mv	a3,a5
 12e:	0785                	addi	a5,a5,1
 130:	fff7c703          	lbu	a4,-1(a5)
 134:	ff65                	bnez	a4,12c <strlen+0x10>
 136:	40a6853b          	subw	a0,a3,a0
 13a:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 13c:	6422                	ld	s0,8(sp)
 13e:	0141                	addi	sp,sp,16
 140:	8082                	ret
  for(n = 0; s[n]; n++)
 142:	4501                	li	a0,0
 144:	bfe5                	j	13c <strlen+0x20>

0000000000000146 <memset>:

void*
memset(void *dst, int c, uint n)
{
 146:	1141                	addi	sp,sp,-16
 148:	e422                	sd	s0,8(sp)
 14a:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 14c:	ca19                	beqz	a2,162 <memset+0x1c>
 14e:	87aa                	mv	a5,a0
 150:	1602                	slli	a2,a2,0x20
 152:	9201                	srli	a2,a2,0x20
 154:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 158:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 15c:	0785                	addi	a5,a5,1
 15e:	fee79de3          	bne	a5,a4,158 <memset+0x12>
  }
  return dst;
}
 162:	6422                	ld	s0,8(sp)
 164:	0141                	addi	sp,sp,16
 166:	8082                	ret

0000000000000168 <strchr>:

char*
strchr(const char *s, char c)
{
 168:	1141                	addi	sp,sp,-16
 16a:	e422                	sd	s0,8(sp)
 16c:	0800                	addi	s0,sp,16
  for(; *s; s++)
 16e:	00054783          	lbu	a5,0(a0)
 172:	cb99                	beqz	a5,188 <strchr+0x20>
    if(*s == c)
 174:	00f58763          	beq	a1,a5,182 <strchr+0x1a>
  for(; *s; s++)
 178:	0505                	addi	a0,a0,1
 17a:	00054783          	lbu	a5,0(a0)
 17e:	fbfd                	bnez	a5,174 <strchr+0xc>
      return (char*)s;
  return 0;
 180:	4501                	li	a0,0
}
 182:	6422                	ld	s0,8(sp)
 184:	0141                	addi	sp,sp,16
 186:	8082                	ret
  return 0;
 188:	4501                	li	a0,0
 18a:	bfe5                	j	182 <strchr+0x1a>

000000000000018c <gets>:

char*
gets(char *buf, int max)
{
 18c:	711d                	addi	sp,sp,-96
 18e:	ec86                	sd	ra,88(sp)
 190:	e8a2                	sd	s0,80(sp)
 192:	e4a6                	sd	s1,72(sp)
 194:	e0ca                	sd	s2,64(sp)
 196:	fc4e                	sd	s3,56(sp)
 198:	f852                	sd	s4,48(sp)
 19a:	f456                	sd	s5,40(sp)
 19c:	f05a                	sd	s6,32(sp)
 19e:	ec5e                	sd	s7,24(sp)
 1a0:	1080                	addi	s0,sp,96
 1a2:	8baa                	mv	s7,a0
 1a4:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1a6:	892a                	mv	s2,a0
 1a8:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1aa:	4aa9                	li	s5,10
 1ac:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 1ae:	89a6                	mv	s3,s1
 1b0:	2485                	addiw	s1,s1,1
 1b2:	0344d663          	bge	s1,s4,1de <gets+0x52>
    cc = read(0, &c, 1);
 1b6:	4605                	li	a2,1
 1b8:	faf40593          	addi	a1,s0,-81
 1bc:	4501                	li	a0,0
 1be:	242000ef          	jal	400 <read>
    if(cc < 1)
 1c2:	00a05e63          	blez	a0,1de <gets+0x52>
    buf[i++] = c;
 1c6:	faf44783          	lbu	a5,-81(s0)
 1ca:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1ce:	01578763          	beq	a5,s5,1dc <gets+0x50>
 1d2:	0905                	addi	s2,s2,1
 1d4:	fd679de3          	bne	a5,s6,1ae <gets+0x22>
    buf[i++] = c;
 1d8:	89a6                	mv	s3,s1
 1da:	a011                	j	1de <gets+0x52>
 1dc:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1de:	99de                	add	s3,s3,s7
 1e0:	00098023          	sb	zero,0(s3)
  return buf;
}
 1e4:	855e                	mv	a0,s7
 1e6:	60e6                	ld	ra,88(sp)
 1e8:	6446                	ld	s0,80(sp)
 1ea:	64a6                	ld	s1,72(sp)
 1ec:	6906                	ld	s2,64(sp)
 1ee:	79e2                	ld	s3,56(sp)
 1f0:	7a42                	ld	s4,48(sp)
 1f2:	7aa2                	ld	s5,40(sp)
 1f4:	7b02                	ld	s6,32(sp)
 1f6:	6be2                	ld	s7,24(sp)
 1f8:	6125                	addi	sp,sp,96
 1fa:	8082                	ret

00000000000001fc <stat>:

int
stat(const char *n, struct stat *st)
{
 1fc:	1101                	addi	sp,sp,-32
 1fe:	ec06                	sd	ra,24(sp)
 200:	e822                	sd	s0,16(sp)
 202:	e04a                	sd	s2,0(sp)
 204:	1000                	addi	s0,sp,32
 206:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 208:	4581                	li	a1,0
 20a:	21e000ef          	jal	428 <open>
  if(fd < 0)
 20e:	02054263          	bltz	a0,232 <stat+0x36>
 212:	e426                	sd	s1,8(sp)
 214:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 216:	85ca                	mv	a1,s2
 218:	228000ef          	jal	440 <fstat>
 21c:	892a                	mv	s2,a0
  close(fd);
 21e:	8526                	mv	a0,s1
 220:	1f0000ef          	jal	410 <close>
  return r;
 224:	64a2                	ld	s1,8(sp)
}
 226:	854a                	mv	a0,s2
 228:	60e2                	ld	ra,24(sp)
 22a:	6442                	ld	s0,16(sp)
 22c:	6902                	ld	s2,0(sp)
 22e:	6105                	addi	sp,sp,32
 230:	8082                	ret
    return -1;
 232:	597d                	li	s2,-1
 234:	bfcd                	j	226 <stat+0x2a>

0000000000000236 <atoi>:

int
atoi(const char *s)
{
 236:	1141                	addi	sp,sp,-16
 238:	e422                	sd	s0,8(sp)
 23a:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 23c:	00054683          	lbu	a3,0(a0)
 240:	fd06879b          	addiw	a5,a3,-48
 244:	0ff7f793          	zext.b	a5,a5
 248:	4625                	li	a2,9
 24a:	02f66863          	bltu	a2,a5,27a <atoi+0x44>
 24e:	872a                	mv	a4,a0
  n = 0;
 250:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 252:	0705                	addi	a4,a4,1
 254:	0025179b          	slliw	a5,a0,0x2
 258:	9fa9                	addw	a5,a5,a0
 25a:	0017979b          	slliw	a5,a5,0x1
 25e:	9fb5                	addw	a5,a5,a3
 260:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 264:	00074683          	lbu	a3,0(a4)
 268:	fd06879b          	addiw	a5,a3,-48
 26c:	0ff7f793          	zext.b	a5,a5
 270:	fef671e3          	bgeu	a2,a5,252 <atoi+0x1c>
  return n;
}
 274:	6422                	ld	s0,8(sp)
 276:	0141                	addi	sp,sp,16
 278:	8082                	ret
  n = 0;
 27a:	4501                	li	a0,0
 27c:	bfe5                	j	274 <atoi+0x3e>

000000000000027e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 27e:	1141                	addi	sp,sp,-16
 280:	e422                	sd	s0,8(sp)
 282:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 284:	02b57463          	bgeu	a0,a1,2ac <memmove+0x2e>
    while(n-- > 0)
 288:	00c05f63          	blez	a2,2a6 <memmove+0x28>
 28c:	1602                	slli	a2,a2,0x20
 28e:	9201                	srli	a2,a2,0x20
 290:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 294:	872a                	mv	a4,a0
      *dst++ = *src++;
 296:	0585                	addi	a1,a1,1
 298:	0705                	addi	a4,a4,1
 29a:	fff5c683          	lbu	a3,-1(a1)
 29e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2a2:	fef71ae3          	bne	a4,a5,296 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2a6:	6422                	ld	s0,8(sp)
 2a8:	0141                	addi	sp,sp,16
 2aa:	8082                	ret
    dst += n;
 2ac:	00c50733          	add	a4,a0,a2
    src += n;
 2b0:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2b2:	fec05ae3          	blez	a2,2a6 <memmove+0x28>
 2b6:	fff6079b          	addiw	a5,a2,-1
 2ba:	1782                	slli	a5,a5,0x20
 2bc:	9381                	srli	a5,a5,0x20
 2be:	fff7c793          	not	a5,a5
 2c2:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2c4:	15fd                	addi	a1,a1,-1
 2c6:	177d                	addi	a4,a4,-1
 2c8:	0005c683          	lbu	a3,0(a1)
 2cc:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2d0:	fee79ae3          	bne	a5,a4,2c4 <memmove+0x46>
 2d4:	bfc9                	j	2a6 <memmove+0x28>

00000000000002d6 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2d6:	1141                	addi	sp,sp,-16
 2d8:	e422                	sd	s0,8(sp)
 2da:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2dc:	ca05                	beqz	a2,30c <memcmp+0x36>
 2de:	fff6069b          	addiw	a3,a2,-1
 2e2:	1682                	slli	a3,a3,0x20
 2e4:	9281                	srli	a3,a3,0x20
 2e6:	0685                	addi	a3,a3,1
 2e8:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2ea:	00054783          	lbu	a5,0(a0)
 2ee:	0005c703          	lbu	a4,0(a1)
 2f2:	00e79863          	bne	a5,a4,302 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 2f6:	0505                	addi	a0,a0,1
    p2++;
 2f8:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2fa:	fed518e3          	bne	a0,a3,2ea <memcmp+0x14>
  }
  return 0;
 2fe:	4501                	li	a0,0
 300:	a019                	j	306 <memcmp+0x30>
      return *p1 - *p2;
 302:	40e7853b          	subw	a0,a5,a4
}
 306:	6422                	ld	s0,8(sp)
 308:	0141                	addi	sp,sp,16
 30a:	8082                	ret
  return 0;
 30c:	4501                	li	a0,0
 30e:	bfe5                	j	306 <memcmp+0x30>

0000000000000310 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 310:	1141                	addi	sp,sp,-16
 312:	e406                	sd	ra,8(sp)
 314:	e022                	sd	s0,0(sp)
 316:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 318:	f67ff0ef          	jal	27e <memmove>
}
 31c:	60a2                	ld	ra,8(sp)
 31e:	6402                	ld	s0,0(sp)
 320:	0141                	addi	sp,sp,16
 322:	8082                	ret

0000000000000324 <sbrk>:

char *
sbrk(int n) {
 324:	1141                	addi	sp,sp,-16
 326:	e406                	sd	ra,8(sp)
 328:	e022                	sd	s0,0(sp)
 32a:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 32c:	4585                	li	a1,1
 32e:	142000ef          	jal	470 <sys_sbrk>
}
 332:	60a2                	ld	ra,8(sp)
 334:	6402                	ld	s0,0(sp)
 336:	0141                	addi	sp,sp,16
 338:	8082                	ret

000000000000033a <sbrklazy>:

char *
sbrklazy(int n) {
 33a:	1141                	addi	sp,sp,-16
 33c:	e406                	sd	ra,8(sp)
 33e:	e022                	sd	s0,0(sp)
 340:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 342:	4589                	li	a1,2
 344:	12c000ef          	jal	470 <sys_sbrk>
}
 348:	60a2                	ld	ra,8(sp)
 34a:	6402                	ld	s0,0(sp)
 34c:	0141                	addi	sp,sp,16
 34e:	8082                	ret

0000000000000350 <thread_create>:
// thread_create allocates a page-sized stack, calls clone(fn, arg, stacktop).
// Returns the new thread's pid, or -1 on error.
// The stack is passed back via *stack so the caller can free it after join.
int
thread_create(void(*fn)(void*), void *arg, void **stack)
{
 350:	7179                	addi	sp,sp,-48
 352:	f406                	sd	ra,40(sp)
 354:	f022                	sd	s0,32(sp)
 356:	e84a                	sd	s2,16(sp)
 358:	e44e                	sd	s3,8(sp)
 35a:	e052                	sd	s4,0(sp)
 35c:	1800                	addi	s0,sp,48
 35e:	89aa                	mv	s3,a0
 360:	8a2e                	mv	s4,a1
 362:	8932                	mv	s2,a2
  char *s = malloc(PGSIZE);
 364:	6505                	lui	a0,0x1
 366:	5ea000ef          	jal	950 <malloc>
  if(s == 0)
 36a:	cd0d                	beqz	a0,3a4 <thread_create+0x54>
 36c:	ec26                	sd	s1,24(sp)
 36e:	84aa                	mv	s1,a0
    return -1;
  *stack = s;
 370:	00a93023          	sd	a0,0(s2)
  // Stack grows downward- pass the top of the allocated region.
  int pid = clone(fn, arg, s + PGSIZE);
 374:	6605                	lui	a2,0x1
 376:	962a                	add	a2,a2,a0
 378:	85d2                	mv	a1,s4
 37a:	854e                	mv	a0,s3
 37c:	166000ef          	jal	4e2 <clone>
  if(pid < 0){
 380:	00054a63          	bltz	a0,394 <thread_create+0x44>
 384:	64e2                	ld	s1,24(sp)
    free(s);
    *stack = 0;
    return -1;
  }
  return pid;
}
 386:	70a2                	ld	ra,40(sp)
 388:	7402                	ld	s0,32(sp)
 38a:	6942                	ld	s2,16(sp)
 38c:	69a2                	ld	s3,8(sp)
 38e:	6a02                	ld	s4,0(sp)
 390:	6145                	addi	sp,sp,48
 392:	8082                	ret
    free(s);
 394:	8526                	mv	a0,s1
 396:	538000ef          	jal	8ce <free>
    *stack = 0;
 39a:	00093023          	sd	zero,0(s2)
    return -1;
 39e:	557d                	li	a0,-1
 3a0:	64e2                	ld	s1,24(sp)
 3a2:	b7d5                	j	386 <thread_create+0x36>
    return -1;
 3a4:	557d                	li	a0,-1
 3a6:	b7c5                	j	386 <thread_create+0x36>

00000000000003a8 <thread_join>:
// Wait for any child thread to exit.
// If stack is non-null, frees the memory pointed to by *stack and clears it.
// Returns the joined thread's pid, or -1 Son error.
int
thread_join(void **stack)
{
 3a8:	1101                	addi	sp,sp,-32
 3aa:	ec06                	sd	ra,24(sp)
 3ac:	e822                	sd	s0,16(sp)
 3ae:	e426                	sd	s1,8(sp)
 3b0:	e04a                	sd	s2,0(sp)
 3b2:	1000                	addi	s0,sp,32
 3b4:	84aa                	mv	s1,a0
  int pid = join();
 3b6:	134000ef          	jal	4ea <join>
  if(pid < 0)
 3ba:	02054163          	bltz	a0,3dc <thread_join+0x34>
 3be:	892a                	mv	s2,a0
    return -1;
  if(stack && *stack){
 3c0:	c499                	beqz	s1,3ce <thread_join+0x26>
 3c2:	6088                	ld	a0,0(s1)
 3c4:	c509                	beqz	a0,3ce <thread_join+0x26>
    free(*stack);
 3c6:	508000ef          	jal	8ce <free>
    *stack = 0;
 3ca:	0004b023          	sd	zero,0(s1)
  }
  return pid;
}
 3ce:	854a                	mv	a0,s2
 3d0:	60e2                	ld	ra,24(sp)
 3d2:	6442                	ld	s0,16(sp)
 3d4:	64a2                	ld	s1,8(sp)
 3d6:	6902                	ld	s2,0(sp)
 3d8:	6105                	addi	sp,sp,32
 3da:	8082                	ret
    return -1;
 3dc:	597d                	li	s2,-1
 3de:	bfc5                	j	3ce <thread_join+0x26>

00000000000003e0 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3e0:	4885                	li	a7,1
 ecall
 3e2:	00000073          	ecall
 ret
 3e6:	8082                	ret

00000000000003e8 <exit>:
.global exit
exit:
 li a7, SYS_exit
 3e8:	4889                	li	a7,2
 ecall
 3ea:	00000073          	ecall
 ret
 3ee:	8082                	ret

00000000000003f0 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3f0:	488d                	li	a7,3
 ecall
 3f2:	00000073          	ecall
 ret
 3f6:	8082                	ret

00000000000003f8 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3f8:	4891                	li	a7,4
 ecall
 3fa:	00000073          	ecall
 ret
 3fe:	8082                	ret

0000000000000400 <read>:
.global read
read:
 li a7, SYS_read
 400:	4895                	li	a7,5
 ecall
 402:	00000073          	ecall
 ret
 406:	8082                	ret

0000000000000408 <write>:
.global write
write:
 li a7, SYS_write
 408:	48c1                	li	a7,16
 ecall
 40a:	00000073          	ecall
 ret
 40e:	8082                	ret

0000000000000410 <close>:
.global close
close:
 li a7, SYS_close
 410:	48d5                	li	a7,21
 ecall
 412:	00000073          	ecall
 ret
 416:	8082                	ret

0000000000000418 <kill>:
.global kill
kill:
 li a7, SYS_kill
 418:	4899                	li	a7,6
 ecall
 41a:	00000073          	ecall
 ret
 41e:	8082                	ret

0000000000000420 <exec>:
.global exec
exec:
 li a7, SYS_exec
 420:	489d                	li	a7,7
 ecall
 422:	00000073          	ecall
 ret
 426:	8082                	ret

0000000000000428 <open>:
.global open
open:
 li a7, SYS_open
 428:	48bd                	li	a7,15
 ecall
 42a:	00000073          	ecall
 ret
 42e:	8082                	ret

0000000000000430 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 430:	48c5                	li	a7,17
 ecall
 432:	00000073          	ecall
 ret
 436:	8082                	ret

0000000000000438 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 438:	48c9                	li	a7,18
 ecall
 43a:	00000073          	ecall
 ret
 43e:	8082                	ret

0000000000000440 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 440:	48a1                	li	a7,8
 ecall
 442:	00000073          	ecall
 ret
 446:	8082                	ret

0000000000000448 <link>:
.global link
link:
 li a7, SYS_link
 448:	48cd                	li	a7,19
 ecall
 44a:	00000073          	ecall
 ret
 44e:	8082                	ret

0000000000000450 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 450:	48d1                	li	a7,20
 ecall
 452:	00000073          	ecall
 ret
 456:	8082                	ret

0000000000000458 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 458:	48a5                	li	a7,9
 ecall
 45a:	00000073          	ecall
 ret
 45e:	8082                	ret

0000000000000460 <dup>:
.global dup
dup:
 li a7, SYS_dup
 460:	48a9                	li	a7,10
 ecall
 462:	00000073          	ecall
 ret
 466:	8082                	ret

0000000000000468 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 468:	48ad                	li	a7,11
 ecall
 46a:	00000073          	ecall
 ret
 46e:	8082                	ret

0000000000000470 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 470:	48b1                	li	a7,12
 ecall
 472:	00000073          	ecall
 ret
 476:	8082                	ret

0000000000000478 <pause>:
.global pause
pause:
 li a7, SYS_pause
 478:	48b5                	li	a7,13
 ecall
 47a:	00000073          	ecall
 ret
 47e:	8082                	ret

0000000000000480 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 480:	48b9                	li	a7,14
 ecall
 482:	00000073          	ecall
 ret
 486:	8082                	ret

0000000000000488 <getppid>:
.global getppid
getppid:
 li a7, SYS_getppid
 488:	02100893          	li	a7,33
 ecall
 48c:	00000073          	ecall
 ret
 490:	8082                	ret

0000000000000492 <ps>:
.global ps
ps:
 li a7, SYS_ps
 492:	02200893          	li	a7,34
 ecall
 496:	00000073          	ecall
 ret
 49a:	8082                	ret

000000000000049c <trace>:
.global trace
trace:
 li a7, SYS_trace
 49c:	02300893          	li	a7,35
 ecall
 4a0:	00000073          	ecall
 ret
 4a4:	8082                	ret

00000000000004a6 <waitx>:
.global waitx
waitx:
 li a7, SYS_waitx
 4a6:	02400893          	li	a7,36
 ecall
 4aa:	00000073          	ecall
 ret
 4ae:	8082                	ret

00000000000004b0 <getcount>:
.global getcount
getcount:
 li a7, SYS_getcount
 4b0:	02500893          	li	a7,37
 ecall
 4b4:	00000073          	ecall
 ret
 4b8:	8082                	ret

00000000000004ba <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 4ba:	48d9                	li	a7,22
 ecall
 4bc:	00000073          	ecall
 ret
 4c0:	8082                	ret

00000000000004c2 <lock_create>:
.global lock_create
lock_create:
 li a7, SYS_lock_create
 4c2:	48dd                	li	a7,23
 ecall
 4c4:	00000073          	ecall
 ret
 4c8:	8082                	ret

00000000000004ca <lock_acquire>:
.global lock_acquire
lock_acquire:
 li a7, SYS_lock_acquire
 4ca:	48e1                	li	a7,24
 ecall
 4cc:	00000073          	ecall
 ret
 4d0:	8082                	ret

00000000000004d2 <lock_release>:
.global lock_release
lock_release:
 li a7, SYS_lock_release
 4d2:	48e5                	li	a7,25
 ecall
 4d4:	00000073          	ecall
 ret
 4d8:	8082                	ret

00000000000004da <lock_destroy>:
.global lock_destroy
lock_destroy:
 li a7, SYS_lock_destroy
 4da:	48e9                	li	a7,26
 ecall
 4dc:	00000073          	ecall
 ret
 4e0:	8082                	ret

00000000000004e2 <clone>:
.global clone
clone:
 li a7, SYS_clone
 4e2:	48ed                	li	a7,27
 ecall
 4e4:	00000073          	ecall
 ret
 4e8:	8082                	ret

00000000000004ea <join>:
.global join
join:
 li a7, SYS_join
 4ea:	48f1                	li	a7,28
 ecall
 4ec:	00000073          	ecall
 ret
 4f0:	8082                	ret

00000000000004f2 <getprocessinfo>:
.global getprocessinfo
getprocessinfo:
 li a7, SYS_getprocessinfo
 4f2:	48f5                	li	a7,29
 ecall
 4f4:	00000073          	ecall
 ret
 4f8:	8082                	ret

00000000000004fa <shmget>:
.global shmget
shmget:
 li a7, SYS_shmget
 4fa:	48f9                	li	a7,30
 ecall
 4fc:	00000073          	ecall
 ret
 500:	8082                	ret

0000000000000502 <shmattach>:
.global shmattach
shmattach:
 li a7, SYS_shmattach
 502:	48fd                	li	a7,31
 ecall
 504:	00000073          	ecall
 ret
 508:	8082                	ret

000000000000050a <shmdetach>:
.global shmdetach
shmdetach:
 li a7, SYS_shmdetach
 50a:	02000893          	li	a7,32
 ecall
 50e:	00000073          	ecall
 ret
 512:	8082                	ret

0000000000000514 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 514:	1101                	addi	sp,sp,-32
 516:	ec06                	sd	ra,24(sp)
 518:	e822                	sd	s0,16(sp)
 51a:	1000                	addi	s0,sp,32
 51c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 520:	4605                	li	a2,1
 522:	fef40593          	addi	a1,s0,-17
 526:	ee3ff0ef          	jal	408 <write>
}
 52a:	60e2                	ld	ra,24(sp)
 52c:	6442                	ld	s0,16(sp)
 52e:	6105                	addi	sp,sp,32
 530:	8082                	ret

0000000000000532 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 532:	715d                	addi	sp,sp,-80
 534:	e486                	sd	ra,72(sp)
 536:	e0a2                	sd	s0,64(sp)
 538:	f84a                	sd	s2,48(sp)
 53a:	0880                	addi	s0,sp,80
 53c:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 53e:	c299                	beqz	a3,544 <printint+0x12>
 540:	0805c363          	bltz	a1,5c6 <printint+0x94>
  neg = 0;
 544:	4881                	li	a7,0
 546:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 54a:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 54c:	00000517          	auipc	a0,0x0
 550:	5a450513          	addi	a0,a0,1444 # af0 <digits>
 554:	883e                	mv	a6,a5
 556:	2785                	addiw	a5,a5,1
 558:	02c5f733          	remu	a4,a1,a2
 55c:	972a                	add	a4,a4,a0
 55e:	00074703          	lbu	a4,0(a4)
 562:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 566:	872e                	mv	a4,a1
 568:	02c5d5b3          	divu	a1,a1,a2
 56c:	0685                	addi	a3,a3,1
 56e:	fec773e3          	bgeu	a4,a2,554 <printint+0x22>
  if(neg)
 572:	00088b63          	beqz	a7,588 <printint+0x56>
    buf[i++] = '-';
 576:	fd078793          	addi	a5,a5,-48
 57a:	97a2                	add	a5,a5,s0
 57c:	02d00713          	li	a4,45
 580:	fee78423          	sb	a4,-24(a5)
 584:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
 588:	02f05a63          	blez	a5,5bc <printint+0x8a>
 58c:	fc26                	sd	s1,56(sp)
 58e:	f44e                	sd	s3,40(sp)
 590:	fb840713          	addi	a4,s0,-72
 594:	00f704b3          	add	s1,a4,a5
 598:	fff70993          	addi	s3,a4,-1
 59c:	99be                	add	s3,s3,a5
 59e:	37fd                	addiw	a5,a5,-1
 5a0:	1782                	slli	a5,a5,0x20
 5a2:	9381                	srli	a5,a5,0x20
 5a4:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 5a8:	fff4c583          	lbu	a1,-1(s1)
 5ac:	854a                	mv	a0,s2
 5ae:	f67ff0ef          	jal	514 <putc>
  while(--i >= 0)
 5b2:	14fd                	addi	s1,s1,-1
 5b4:	ff349ae3          	bne	s1,s3,5a8 <printint+0x76>
 5b8:	74e2                	ld	s1,56(sp)
 5ba:	79a2                	ld	s3,40(sp)
}
 5bc:	60a6                	ld	ra,72(sp)
 5be:	6406                	ld	s0,64(sp)
 5c0:	7942                	ld	s2,48(sp)
 5c2:	6161                	addi	sp,sp,80
 5c4:	8082                	ret
    x = -xx;
 5c6:	40b005b3          	neg	a1,a1
    neg = 1;
 5ca:	4885                	li	a7,1
    x = -xx;
 5cc:	bfad                	j	546 <printint+0x14>

00000000000005ce <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5ce:	711d                	addi	sp,sp,-96
 5d0:	ec86                	sd	ra,88(sp)
 5d2:	e8a2                	sd	s0,80(sp)
 5d4:	e0ca                	sd	s2,64(sp)
 5d6:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5d8:	0005c903          	lbu	s2,0(a1)
 5dc:	28090663          	beqz	s2,868 <vprintf+0x29a>
 5e0:	e4a6                	sd	s1,72(sp)
 5e2:	fc4e                	sd	s3,56(sp)
 5e4:	f852                	sd	s4,48(sp)
 5e6:	f456                	sd	s5,40(sp)
 5e8:	f05a                	sd	s6,32(sp)
 5ea:	ec5e                	sd	s7,24(sp)
 5ec:	e862                	sd	s8,16(sp)
 5ee:	e466                	sd	s9,8(sp)
 5f0:	8b2a                	mv	s6,a0
 5f2:	8a2e                	mv	s4,a1
 5f4:	8bb2                	mv	s7,a2
  state = 0;
 5f6:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 5f8:	4481                	li	s1,0
 5fa:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 5fc:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 600:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 604:	06c00c93          	li	s9,108
 608:	a005                	j	628 <vprintf+0x5a>
        putc(fd, c0);
 60a:	85ca                	mv	a1,s2
 60c:	855a                	mv	a0,s6
 60e:	f07ff0ef          	jal	514 <putc>
 612:	a019                	j	618 <vprintf+0x4a>
    } else if(state == '%'){
 614:	03598263          	beq	s3,s5,638 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 618:	2485                	addiw	s1,s1,1
 61a:	8726                	mv	a4,s1
 61c:	009a07b3          	add	a5,s4,s1
 620:	0007c903          	lbu	s2,0(a5)
 624:	22090a63          	beqz	s2,858 <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 628:	0009079b          	sext.w	a5,s2
    if(state == 0){
 62c:	fe0994e3          	bnez	s3,614 <vprintf+0x46>
      if(c0 == '%'){
 630:	fd579de3          	bne	a5,s5,60a <vprintf+0x3c>
        state = '%';
 634:	89be                	mv	s3,a5
 636:	b7cd                	j	618 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 638:	00ea06b3          	add	a3,s4,a4
 63c:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 640:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 642:	c681                	beqz	a3,64a <vprintf+0x7c>
 644:	9752                	add	a4,a4,s4
 646:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 64a:	05878363          	beq	a5,s8,690 <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 64e:	05978d63          	beq	a5,s9,6a8 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 652:	07500713          	li	a4,117
 656:	0ee78763          	beq	a5,a4,744 <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 65a:	07800713          	li	a4,120
 65e:	12e78963          	beq	a5,a4,790 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 662:	07000713          	li	a4,112
 666:	14e78e63          	beq	a5,a4,7c2 <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 66a:	06300713          	li	a4,99
 66e:	18e78e63          	beq	a5,a4,80a <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 672:	07300713          	li	a4,115
 676:	1ae78463          	beq	a5,a4,81e <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 67a:	02500713          	li	a4,37
 67e:	04e79563          	bne	a5,a4,6c8 <vprintf+0xfa>
        putc(fd, '%');
 682:	02500593          	li	a1,37
 686:	855a                	mv	a0,s6
 688:	e8dff0ef          	jal	514 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 68c:	4981                	li	s3,0
 68e:	b769                	j	618 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 690:	008b8913          	addi	s2,s7,8
 694:	4685                	li	a3,1
 696:	4629                	li	a2,10
 698:	000ba583          	lw	a1,0(s7)
 69c:	855a                	mv	a0,s6
 69e:	e95ff0ef          	jal	532 <printint>
 6a2:	8bca                	mv	s7,s2
      state = 0;
 6a4:	4981                	li	s3,0
 6a6:	bf8d                	j	618 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 6a8:	06400793          	li	a5,100
 6ac:	02f68963          	beq	a3,a5,6de <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 6b0:	06c00793          	li	a5,108
 6b4:	04f68263          	beq	a3,a5,6f8 <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 6b8:	07500793          	li	a5,117
 6bc:	0af68063          	beq	a3,a5,75c <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 6c0:	07800793          	li	a5,120
 6c4:	0ef68263          	beq	a3,a5,7a8 <vprintf+0x1da>
        putc(fd, '%');
 6c8:	02500593          	li	a1,37
 6cc:	855a                	mv	a0,s6
 6ce:	e47ff0ef          	jal	514 <putc>
        putc(fd, c0);
 6d2:	85ca                	mv	a1,s2
 6d4:	855a                	mv	a0,s6
 6d6:	e3fff0ef          	jal	514 <putc>
      state = 0;
 6da:	4981                	li	s3,0
 6dc:	bf35                	j	618 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 6de:	008b8913          	addi	s2,s7,8
 6e2:	4685                	li	a3,1
 6e4:	4629                	li	a2,10
 6e6:	000bb583          	ld	a1,0(s7)
 6ea:	855a                	mv	a0,s6
 6ec:	e47ff0ef          	jal	532 <printint>
        i += 1;
 6f0:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 6f2:	8bca                	mv	s7,s2
      state = 0;
 6f4:	4981                	li	s3,0
        i += 1;
 6f6:	b70d                	j	618 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 6f8:	06400793          	li	a5,100
 6fc:	02f60763          	beq	a2,a5,72a <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 700:	07500793          	li	a5,117
 704:	06f60963          	beq	a2,a5,776 <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 708:	07800793          	li	a5,120
 70c:	faf61ee3          	bne	a2,a5,6c8 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 710:	008b8913          	addi	s2,s7,8
 714:	4681                	li	a3,0
 716:	4641                	li	a2,16
 718:	000bb583          	ld	a1,0(s7)
 71c:	855a                	mv	a0,s6
 71e:	e15ff0ef          	jal	532 <printint>
        i += 2;
 722:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 724:	8bca                	mv	s7,s2
      state = 0;
 726:	4981                	li	s3,0
        i += 2;
 728:	bdc5                	j	618 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 72a:	008b8913          	addi	s2,s7,8
 72e:	4685                	li	a3,1
 730:	4629                	li	a2,10
 732:	000bb583          	ld	a1,0(s7)
 736:	855a                	mv	a0,s6
 738:	dfbff0ef          	jal	532 <printint>
        i += 2;
 73c:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 73e:	8bca                	mv	s7,s2
      state = 0;
 740:	4981                	li	s3,0
        i += 2;
 742:	bdd9                	j	618 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 744:	008b8913          	addi	s2,s7,8
 748:	4681                	li	a3,0
 74a:	4629                	li	a2,10
 74c:	000be583          	lwu	a1,0(s7)
 750:	855a                	mv	a0,s6
 752:	de1ff0ef          	jal	532 <printint>
 756:	8bca                	mv	s7,s2
      state = 0;
 758:	4981                	li	s3,0
 75a:	bd7d                	j	618 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 75c:	008b8913          	addi	s2,s7,8
 760:	4681                	li	a3,0
 762:	4629                	li	a2,10
 764:	000bb583          	ld	a1,0(s7)
 768:	855a                	mv	a0,s6
 76a:	dc9ff0ef          	jal	532 <printint>
        i += 1;
 76e:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 770:	8bca                	mv	s7,s2
      state = 0;
 772:	4981                	li	s3,0
        i += 1;
 774:	b555                	j	618 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 776:	008b8913          	addi	s2,s7,8
 77a:	4681                	li	a3,0
 77c:	4629                	li	a2,10
 77e:	000bb583          	ld	a1,0(s7)
 782:	855a                	mv	a0,s6
 784:	dafff0ef          	jal	532 <printint>
        i += 2;
 788:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 78a:	8bca                	mv	s7,s2
      state = 0;
 78c:	4981                	li	s3,0
        i += 2;
 78e:	b569                	j	618 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 790:	008b8913          	addi	s2,s7,8
 794:	4681                	li	a3,0
 796:	4641                	li	a2,16
 798:	000be583          	lwu	a1,0(s7)
 79c:	855a                	mv	a0,s6
 79e:	d95ff0ef          	jal	532 <printint>
 7a2:	8bca                	mv	s7,s2
      state = 0;
 7a4:	4981                	li	s3,0
 7a6:	bd8d                	j	618 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 7a8:	008b8913          	addi	s2,s7,8
 7ac:	4681                	li	a3,0
 7ae:	4641                	li	a2,16
 7b0:	000bb583          	ld	a1,0(s7)
 7b4:	855a                	mv	a0,s6
 7b6:	d7dff0ef          	jal	532 <printint>
        i += 1;
 7ba:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 7bc:	8bca                	mv	s7,s2
      state = 0;
 7be:	4981                	li	s3,0
        i += 1;
 7c0:	bda1                	j	618 <vprintf+0x4a>
 7c2:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 7c4:	008b8d13          	addi	s10,s7,8
 7c8:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 7cc:	03000593          	li	a1,48
 7d0:	855a                	mv	a0,s6
 7d2:	d43ff0ef          	jal	514 <putc>
  putc(fd, 'x');
 7d6:	07800593          	li	a1,120
 7da:	855a                	mv	a0,s6
 7dc:	d39ff0ef          	jal	514 <putc>
 7e0:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7e2:	00000b97          	auipc	s7,0x0
 7e6:	30eb8b93          	addi	s7,s7,782 # af0 <digits>
 7ea:	03c9d793          	srli	a5,s3,0x3c
 7ee:	97de                	add	a5,a5,s7
 7f0:	0007c583          	lbu	a1,0(a5)
 7f4:	855a                	mv	a0,s6
 7f6:	d1fff0ef          	jal	514 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7fa:	0992                	slli	s3,s3,0x4
 7fc:	397d                	addiw	s2,s2,-1
 7fe:	fe0916e3          	bnez	s2,7ea <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 802:	8bea                	mv	s7,s10
      state = 0;
 804:	4981                	li	s3,0
 806:	6d02                	ld	s10,0(sp)
 808:	bd01                	j	618 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 80a:	008b8913          	addi	s2,s7,8
 80e:	000bc583          	lbu	a1,0(s7)
 812:	855a                	mv	a0,s6
 814:	d01ff0ef          	jal	514 <putc>
 818:	8bca                	mv	s7,s2
      state = 0;
 81a:	4981                	li	s3,0
 81c:	bbf5                	j	618 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 81e:	008b8993          	addi	s3,s7,8
 822:	000bb903          	ld	s2,0(s7)
 826:	00090f63          	beqz	s2,844 <vprintf+0x276>
        for(; *s; s++)
 82a:	00094583          	lbu	a1,0(s2)
 82e:	c195                	beqz	a1,852 <vprintf+0x284>
          putc(fd, *s);
 830:	855a                	mv	a0,s6
 832:	ce3ff0ef          	jal	514 <putc>
        for(; *s; s++)
 836:	0905                	addi	s2,s2,1
 838:	00094583          	lbu	a1,0(s2)
 83c:	f9f5                	bnez	a1,830 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 83e:	8bce                	mv	s7,s3
      state = 0;
 840:	4981                	li	s3,0
 842:	bbd9                	j	618 <vprintf+0x4a>
          s = "(null)";
 844:	00000917          	auipc	s2,0x0
 848:	2a490913          	addi	s2,s2,676 # ae8 <malloc+0x198>
        for(; *s; s++)
 84c:	02800593          	li	a1,40
 850:	b7c5                	j	830 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 852:	8bce                	mv	s7,s3
      state = 0;
 854:	4981                	li	s3,0
 856:	b3c9                	j	618 <vprintf+0x4a>
 858:	64a6                	ld	s1,72(sp)
 85a:	79e2                	ld	s3,56(sp)
 85c:	7a42                	ld	s4,48(sp)
 85e:	7aa2                	ld	s5,40(sp)
 860:	7b02                	ld	s6,32(sp)
 862:	6be2                	ld	s7,24(sp)
 864:	6c42                	ld	s8,16(sp)
 866:	6ca2                	ld	s9,8(sp)
    }
  }
}
 868:	60e6                	ld	ra,88(sp)
 86a:	6446                	ld	s0,80(sp)
 86c:	6906                	ld	s2,64(sp)
 86e:	6125                	addi	sp,sp,96
 870:	8082                	ret

0000000000000872 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 872:	715d                	addi	sp,sp,-80
 874:	ec06                	sd	ra,24(sp)
 876:	e822                	sd	s0,16(sp)
 878:	1000                	addi	s0,sp,32
 87a:	e010                	sd	a2,0(s0)
 87c:	e414                	sd	a3,8(s0)
 87e:	e818                	sd	a4,16(s0)
 880:	ec1c                	sd	a5,24(s0)
 882:	03043023          	sd	a6,32(s0)
 886:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 88a:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 88e:	8622                	mv	a2,s0
 890:	d3fff0ef          	jal	5ce <vprintf>
}
 894:	60e2                	ld	ra,24(sp)
 896:	6442                	ld	s0,16(sp)
 898:	6161                	addi	sp,sp,80
 89a:	8082                	ret

000000000000089c <printf>:

void
printf(const char *fmt, ...)
{
 89c:	711d                	addi	sp,sp,-96
 89e:	ec06                	sd	ra,24(sp)
 8a0:	e822                	sd	s0,16(sp)
 8a2:	1000                	addi	s0,sp,32
 8a4:	e40c                	sd	a1,8(s0)
 8a6:	e810                	sd	a2,16(s0)
 8a8:	ec14                	sd	a3,24(s0)
 8aa:	f018                	sd	a4,32(s0)
 8ac:	f41c                	sd	a5,40(s0)
 8ae:	03043823          	sd	a6,48(s0)
 8b2:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 8b6:	00840613          	addi	a2,s0,8
 8ba:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 8be:	85aa                	mv	a1,a0
 8c0:	4505                	li	a0,1
 8c2:	d0dff0ef          	jal	5ce <vprintf>
}
 8c6:	60e2                	ld	ra,24(sp)
 8c8:	6442                	ld	s0,16(sp)
 8ca:	6125                	addi	sp,sp,96
 8cc:	8082                	ret

00000000000008ce <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8ce:	1141                	addi	sp,sp,-16
 8d0:	e422                	sd	s0,8(sp)
 8d2:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8d4:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8d8:	00000797          	auipc	a5,0x0
 8dc:	7287b783          	ld	a5,1832(a5) # 1000 <freep>
 8e0:	a02d                	j	90a <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8e2:	4618                	lw	a4,8(a2)
 8e4:	9f2d                	addw	a4,a4,a1
 8e6:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8ea:	6398                	ld	a4,0(a5)
 8ec:	6310                	ld	a2,0(a4)
 8ee:	a83d                	j	92c <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8f0:	ff852703          	lw	a4,-8(a0)
 8f4:	9f31                	addw	a4,a4,a2
 8f6:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 8f8:	ff053683          	ld	a3,-16(a0)
 8fc:	a091                	j	940 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8fe:	6398                	ld	a4,0(a5)
 900:	00e7e463          	bltu	a5,a4,908 <free+0x3a>
 904:	00e6ea63          	bltu	a3,a4,918 <free+0x4a>
{
 908:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 90a:	fed7fae3          	bgeu	a5,a3,8fe <free+0x30>
 90e:	6398                	ld	a4,0(a5)
 910:	00e6e463          	bltu	a3,a4,918 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 914:	fee7eae3          	bltu	a5,a4,908 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 918:	ff852583          	lw	a1,-8(a0)
 91c:	6390                	ld	a2,0(a5)
 91e:	02059813          	slli	a6,a1,0x20
 922:	01c85713          	srli	a4,a6,0x1c
 926:	9736                	add	a4,a4,a3
 928:	fae60de3          	beq	a2,a4,8e2 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 92c:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 930:	4790                	lw	a2,8(a5)
 932:	02061593          	slli	a1,a2,0x20
 936:	01c5d713          	srli	a4,a1,0x1c
 93a:	973e                	add	a4,a4,a5
 93c:	fae68ae3          	beq	a3,a4,8f0 <free+0x22>
    p->s.ptr = bp->s.ptr;
 940:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 942:	00000717          	auipc	a4,0x0
 946:	6af73f23          	sd	a5,1726(a4) # 1000 <freep>
}
 94a:	6422                	ld	s0,8(sp)
 94c:	0141                	addi	sp,sp,16
 94e:	8082                	ret

0000000000000950 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 950:	7139                	addi	sp,sp,-64
 952:	fc06                	sd	ra,56(sp)
 954:	f822                	sd	s0,48(sp)
 956:	f426                	sd	s1,40(sp)
 958:	ec4e                	sd	s3,24(sp)
 95a:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 95c:	02051493          	slli	s1,a0,0x20
 960:	9081                	srli	s1,s1,0x20
 962:	04bd                	addi	s1,s1,15
 964:	8091                	srli	s1,s1,0x4
 966:	0014899b          	addiw	s3,s1,1
 96a:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 96c:	00000517          	auipc	a0,0x0
 970:	69453503          	ld	a0,1684(a0) # 1000 <freep>
 974:	c915                	beqz	a0,9a8 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 976:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 978:	4798                	lw	a4,8(a5)
 97a:	08977a63          	bgeu	a4,s1,a0e <malloc+0xbe>
 97e:	f04a                	sd	s2,32(sp)
 980:	e852                	sd	s4,16(sp)
 982:	e456                	sd	s5,8(sp)
 984:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 986:	8a4e                	mv	s4,s3
 988:	0009871b          	sext.w	a4,s3
 98c:	6685                	lui	a3,0x1
 98e:	00d77363          	bgeu	a4,a3,994 <malloc+0x44>
 992:	6a05                	lui	s4,0x1
 994:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 998:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 99c:	00000917          	auipc	s2,0x0
 9a0:	66490913          	addi	s2,s2,1636 # 1000 <freep>
  if(p == SBRK_ERROR)
 9a4:	5afd                	li	s5,-1
 9a6:	a081                	j	9e6 <malloc+0x96>
 9a8:	f04a                	sd	s2,32(sp)
 9aa:	e852                	sd	s4,16(sp)
 9ac:	e456                	sd	s5,8(sp)
 9ae:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 9b0:	00001797          	auipc	a5,0x1
 9b4:	85878793          	addi	a5,a5,-1960 # 1208 <base>
 9b8:	00000717          	auipc	a4,0x0
 9bc:	64f73423          	sd	a5,1608(a4) # 1000 <freep>
 9c0:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 9c2:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 9c6:	b7c1                	j	986 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 9c8:	6398                	ld	a4,0(a5)
 9ca:	e118                	sd	a4,0(a0)
 9cc:	a8a9                	j	a26 <malloc+0xd6>
  hp->s.size = nu;
 9ce:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 9d2:	0541                	addi	a0,a0,16
 9d4:	efbff0ef          	jal	8ce <free>
  return freep;
 9d8:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 9dc:	c12d                	beqz	a0,a3e <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9de:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9e0:	4798                	lw	a4,8(a5)
 9e2:	02977263          	bgeu	a4,s1,a06 <malloc+0xb6>
    if(p == freep)
 9e6:	00093703          	ld	a4,0(s2)
 9ea:	853e                	mv	a0,a5
 9ec:	fef719e3          	bne	a4,a5,9de <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 9f0:	8552                	mv	a0,s4
 9f2:	933ff0ef          	jal	324 <sbrk>
  if(p == SBRK_ERROR)
 9f6:	fd551ce3          	bne	a0,s5,9ce <malloc+0x7e>
        return 0;
 9fa:	4501                	li	a0,0
 9fc:	7902                	ld	s2,32(sp)
 9fe:	6a42                	ld	s4,16(sp)
 a00:	6aa2                	ld	s5,8(sp)
 a02:	6b02                	ld	s6,0(sp)
 a04:	a03d                	j	a32 <malloc+0xe2>
 a06:	7902                	ld	s2,32(sp)
 a08:	6a42                	ld	s4,16(sp)
 a0a:	6aa2                	ld	s5,8(sp)
 a0c:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 a0e:	fae48de3          	beq	s1,a4,9c8 <malloc+0x78>
        p->s.size -= nunits;
 a12:	4137073b          	subw	a4,a4,s3
 a16:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a18:	02071693          	slli	a3,a4,0x20
 a1c:	01c6d713          	srli	a4,a3,0x1c
 a20:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a22:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a26:	00000717          	auipc	a4,0x0
 a2a:	5ca73d23          	sd	a0,1498(a4) # 1000 <freep>
      return (void*)(p + 1);
 a2e:	01078513          	addi	a0,a5,16
  }
}
 a32:	70e2                	ld	ra,56(sp)
 a34:	7442                	ld	s0,48(sp)
 a36:	74a2                	ld	s1,40(sp)
 a38:	69e2                	ld	s3,24(sp)
 a3a:	6121                	addi	sp,sp,64
 a3c:	8082                	ret
 a3e:	7902                	ld	s2,32(sp)
 a40:	6a42                	ld	s4,16(sp)
 a42:	6aa2                	ld	s5,8(sp)
 a44:	6b02                	ld	s6,0(sp)
 a46:	b7f5                	j	a32 <malloc+0xe2>
