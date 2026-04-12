
user/_init:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	e426                	sd	s1,8(sp)
   8:	e04a                	sd	s2,0(sp)
   a:	1000                	addi	s0,sp,32
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
   c:	4589                	li	a1,2
   e:	00001517          	auipc	a0,0x1
  12:	a3250513          	addi	a0,a0,-1486 # a40 <malloc+0xf8>
  16:	40a000ef          	jal	420 <open>
  1a:	04054563          	bltz	a0,64 <main+0x64>
    mknod("console", CONSOLE, 0);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
  1e:	4501                	li	a0,0
  20:	438000ef          	jal	458 <dup>
  dup(0);  // stderr
  24:	4501                	li	a0,0
  26:	432000ef          	jal	458 <dup>

  for(;;){
    printf("init: starting sh\n");
  2a:	00001917          	auipc	s2,0x1
  2e:	a1e90913          	addi	s2,s2,-1506 # a48 <malloc+0x100>
  32:	854a                	mv	a0,s2
  34:	061000ef          	jal	894 <printf>
    pid = fork();
  38:	3a0000ef          	jal	3d8 <fork>
  3c:	84aa                	mv	s1,a0
    if(pid < 0){
  3e:	04054363          	bltz	a0,84 <main+0x84>
      printf("init: fork failed\n");
      exit(1);
    }
    if(pid == 0){
  42:	c931                	beqz	a0,96 <main+0x96>
    }

    for(;;){
      // this call to wait() returns if the shell exits,
      // or if a parentless process exits.
      wpid = wait((int *) 0);
  44:	4501                	li	a0,0
  46:	3a2000ef          	jal	3e8 <wait>
      if(wpid == pid){
  4a:	fea484e3          	beq	s1,a0,32 <main+0x32>
        // the shell exited; restart it.
        break;
      } else if(wpid < 0){
  4e:	fe055be3          	bgez	a0,44 <main+0x44>
        printf("init: wait returned an error\n");
  52:	00001517          	auipc	a0,0x1
  56:	a4650513          	addi	a0,a0,-1466 # a98 <malloc+0x150>
  5a:	03b000ef          	jal	894 <printf>
        exit(1);
  5e:	4505                	li	a0,1
  60:	380000ef          	jal	3e0 <exit>
    mknod("console", CONSOLE, 0);
  64:	4601                	li	a2,0
  66:	4585                	li	a1,1
  68:	00001517          	auipc	a0,0x1
  6c:	9d850513          	addi	a0,a0,-1576 # a40 <malloc+0xf8>
  70:	3b8000ef          	jal	428 <mknod>
    open("console", O_RDWR);
  74:	4589                	li	a1,2
  76:	00001517          	auipc	a0,0x1
  7a:	9ca50513          	addi	a0,a0,-1590 # a40 <malloc+0xf8>
  7e:	3a2000ef          	jal	420 <open>
  82:	bf71                	j	1e <main+0x1e>
      printf("init: fork failed\n");
  84:	00001517          	auipc	a0,0x1
  88:	9dc50513          	addi	a0,a0,-1572 # a60 <malloc+0x118>
  8c:	009000ef          	jal	894 <printf>
      exit(1);
  90:	4505                	li	a0,1
  92:	34e000ef          	jal	3e0 <exit>
      exec("sh", argv);
  96:	00001597          	auipc	a1,0x1
  9a:	f6a58593          	addi	a1,a1,-150 # 1000 <argv>
  9e:	00001517          	auipc	a0,0x1
  a2:	9da50513          	addi	a0,a0,-1574 # a78 <malloc+0x130>
  a6:	372000ef          	jal	418 <exec>
      printf("init: exec sh failed\n");
  aa:	00001517          	auipc	a0,0x1
  ae:	9d650513          	addi	a0,a0,-1578 # a80 <malloc+0x138>
  b2:	7e2000ef          	jal	894 <printf>
      exit(1);
  b6:	4505                	li	a0,1
  b8:	328000ef          	jal	3e0 <exit>

00000000000000bc <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
  bc:	1141                	addi	sp,sp,-16
  be:	e406                	sd	ra,8(sp)
  c0:	e022                	sd	s0,0(sp)
  c2:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
  c4:	f3dff0ef          	jal	0 <main>
  exit(r);
  c8:	318000ef          	jal	3e0 <exit>

00000000000000cc <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  cc:	1141                	addi	sp,sp,-16
  ce:	e422                	sd	s0,8(sp)
  d0:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  d2:	87aa                	mv	a5,a0
  d4:	0585                	addi	a1,a1,1
  d6:	0785                	addi	a5,a5,1
  d8:	fff5c703          	lbu	a4,-1(a1)
  dc:	fee78fa3          	sb	a4,-1(a5)
  e0:	fb75                	bnez	a4,d4 <strcpy+0x8>
    ;
  return os;
}
  e2:	6422                	ld	s0,8(sp)
  e4:	0141                	addi	sp,sp,16
  e6:	8082                	ret

00000000000000e8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  e8:	1141                	addi	sp,sp,-16
  ea:	e422                	sd	s0,8(sp)
  ec:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  ee:	00054783          	lbu	a5,0(a0)
  f2:	cb91                	beqz	a5,106 <strcmp+0x1e>
  f4:	0005c703          	lbu	a4,0(a1)
  f8:	00f71763          	bne	a4,a5,106 <strcmp+0x1e>
    p++, q++;
  fc:	0505                	addi	a0,a0,1
  fe:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 100:	00054783          	lbu	a5,0(a0)
 104:	fbe5                	bnez	a5,f4 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 106:	0005c503          	lbu	a0,0(a1)
}
 10a:	40a7853b          	subw	a0,a5,a0
 10e:	6422                	ld	s0,8(sp)
 110:	0141                	addi	sp,sp,16
 112:	8082                	ret

0000000000000114 <strlen>:

uint
strlen(const char *s)
{
 114:	1141                	addi	sp,sp,-16
 116:	e422                	sd	s0,8(sp)
 118:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 11a:	00054783          	lbu	a5,0(a0)
 11e:	cf91                	beqz	a5,13a <strlen+0x26>
 120:	0505                	addi	a0,a0,1
 122:	87aa                	mv	a5,a0
 124:	86be                	mv	a3,a5
 126:	0785                	addi	a5,a5,1
 128:	fff7c703          	lbu	a4,-1(a5)
 12c:	ff65                	bnez	a4,124 <strlen+0x10>
 12e:	40a6853b          	subw	a0,a3,a0
 132:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 134:	6422                	ld	s0,8(sp)
 136:	0141                	addi	sp,sp,16
 138:	8082                	ret
  for(n = 0; s[n]; n++)
 13a:	4501                	li	a0,0
 13c:	bfe5                	j	134 <strlen+0x20>

000000000000013e <memset>:

void*
memset(void *dst, int c, uint n)
{
 13e:	1141                	addi	sp,sp,-16
 140:	e422                	sd	s0,8(sp)
 142:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 144:	ca19                	beqz	a2,15a <memset+0x1c>
 146:	87aa                	mv	a5,a0
 148:	1602                	slli	a2,a2,0x20
 14a:	9201                	srli	a2,a2,0x20
 14c:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 150:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 154:	0785                	addi	a5,a5,1
 156:	fee79de3          	bne	a5,a4,150 <memset+0x12>
  }
  return dst;
}
 15a:	6422                	ld	s0,8(sp)
 15c:	0141                	addi	sp,sp,16
 15e:	8082                	ret

0000000000000160 <strchr>:

char*
strchr(const char *s, char c)
{
 160:	1141                	addi	sp,sp,-16
 162:	e422                	sd	s0,8(sp)
 164:	0800                	addi	s0,sp,16
  for(; *s; s++)
 166:	00054783          	lbu	a5,0(a0)
 16a:	cb99                	beqz	a5,180 <strchr+0x20>
    if(*s == c)
 16c:	00f58763          	beq	a1,a5,17a <strchr+0x1a>
  for(; *s; s++)
 170:	0505                	addi	a0,a0,1
 172:	00054783          	lbu	a5,0(a0)
 176:	fbfd                	bnez	a5,16c <strchr+0xc>
      return (char*)s;
  return 0;
 178:	4501                	li	a0,0
}
 17a:	6422                	ld	s0,8(sp)
 17c:	0141                	addi	sp,sp,16
 17e:	8082                	ret
  return 0;
 180:	4501                	li	a0,0
 182:	bfe5                	j	17a <strchr+0x1a>

0000000000000184 <gets>:

char*
gets(char *buf, int max)
{
 184:	711d                	addi	sp,sp,-96
 186:	ec86                	sd	ra,88(sp)
 188:	e8a2                	sd	s0,80(sp)
 18a:	e4a6                	sd	s1,72(sp)
 18c:	e0ca                	sd	s2,64(sp)
 18e:	fc4e                	sd	s3,56(sp)
 190:	f852                	sd	s4,48(sp)
 192:	f456                	sd	s5,40(sp)
 194:	f05a                	sd	s6,32(sp)
 196:	ec5e                	sd	s7,24(sp)
 198:	1080                	addi	s0,sp,96
 19a:	8baa                	mv	s7,a0
 19c:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 19e:	892a                	mv	s2,a0
 1a0:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1a2:	4aa9                	li	s5,10
 1a4:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 1a6:	89a6                	mv	s3,s1
 1a8:	2485                	addiw	s1,s1,1
 1aa:	0344d663          	bge	s1,s4,1d6 <gets+0x52>
    cc = read(0, &c, 1);
 1ae:	4605                	li	a2,1
 1b0:	faf40593          	addi	a1,s0,-81
 1b4:	4501                	li	a0,0
 1b6:	242000ef          	jal	3f8 <read>
    if(cc < 1)
 1ba:	00a05e63          	blez	a0,1d6 <gets+0x52>
    buf[i++] = c;
 1be:	faf44783          	lbu	a5,-81(s0)
 1c2:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1c6:	01578763          	beq	a5,s5,1d4 <gets+0x50>
 1ca:	0905                	addi	s2,s2,1
 1cc:	fd679de3          	bne	a5,s6,1a6 <gets+0x22>
    buf[i++] = c;
 1d0:	89a6                	mv	s3,s1
 1d2:	a011                	j	1d6 <gets+0x52>
 1d4:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1d6:	99de                	add	s3,s3,s7
 1d8:	00098023          	sb	zero,0(s3)
  return buf;
}
 1dc:	855e                	mv	a0,s7
 1de:	60e6                	ld	ra,88(sp)
 1e0:	6446                	ld	s0,80(sp)
 1e2:	64a6                	ld	s1,72(sp)
 1e4:	6906                	ld	s2,64(sp)
 1e6:	79e2                	ld	s3,56(sp)
 1e8:	7a42                	ld	s4,48(sp)
 1ea:	7aa2                	ld	s5,40(sp)
 1ec:	7b02                	ld	s6,32(sp)
 1ee:	6be2                	ld	s7,24(sp)
 1f0:	6125                	addi	sp,sp,96
 1f2:	8082                	ret

00000000000001f4 <stat>:

int
stat(const char *n, struct stat *st)
{
 1f4:	1101                	addi	sp,sp,-32
 1f6:	ec06                	sd	ra,24(sp)
 1f8:	e822                	sd	s0,16(sp)
 1fa:	e04a                	sd	s2,0(sp)
 1fc:	1000                	addi	s0,sp,32
 1fe:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 200:	4581                	li	a1,0
 202:	21e000ef          	jal	420 <open>
  if(fd < 0)
 206:	02054263          	bltz	a0,22a <stat+0x36>
 20a:	e426                	sd	s1,8(sp)
 20c:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 20e:	85ca                	mv	a1,s2
 210:	228000ef          	jal	438 <fstat>
 214:	892a                	mv	s2,a0
  close(fd);
 216:	8526                	mv	a0,s1
 218:	1f0000ef          	jal	408 <close>
  return r;
 21c:	64a2                	ld	s1,8(sp)
}
 21e:	854a                	mv	a0,s2
 220:	60e2                	ld	ra,24(sp)
 222:	6442                	ld	s0,16(sp)
 224:	6902                	ld	s2,0(sp)
 226:	6105                	addi	sp,sp,32
 228:	8082                	ret
    return -1;
 22a:	597d                	li	s2,-1
 22c:	bfcd                	j	21e <stat+0x2a>

000000000000022e <atoi>:

int
atoi(const char *s)
{
 22e:	1141                	addi	sp,sp,-16
 230:	e422                	sd	s0,8(sp)
 232:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 234:	00054683          	lbu	a3,0(a0)
 238:	fd06879b          	addiw	a5,a3,-48
 23c:	0ff7f793          	zext.b	a5,a5
 240:	4625                	li	a2,9
 242:	02f66863          	bltu	a2,a5,272 <atoi+0x44>
 246:	872a                	mv	a4,a0
  n = 0;
 248:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 24a:	0705                	addi	a4,a4,1
 24c:	0025179b          	slliw	a5,a0,0x2
 250:	9fa9                	addw	a5,a5,a0
 252:	0017979b          	slliw	a5,a5,0x1
 256:	9fb5                	addw	a5,a5,a3
 258:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 25c:	00074683          	lbu	a3,0(a4)
 260:	fd06879b          	addiw	a5,a3,-48
 264:	0ff7f793          	zext.b	a5,a5
 268:	fef671e3          	bgeu	a2,a5,24a <atoi+0x1c>
  return n;
}
 26c:	6422                	ld	s0,8(sp)
 26e:	0141                	addi	sp,sp,16
 270:	8082                	ret
  n = 0;
 272:	4501                	li	a0,0
 274:	bfe5                	j	26c <atoi+0x3e>

0000000000000276 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 276:	1141                	addi	sp,sp,-16
 278:	e422                	sd	s0,8(sp)
 27a:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 27c:	02b57463          	bgeu	a0,a1,2a4 <memmove+0x2e>
    while(n-- > 0)
 280:	00c05f63          	blez	a2,29e <memmove+0x28>
 284:	1602                	slli	a2,a2,0x20
 286:	9201                	srli	a2,a2,0x20
 288:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 28c:	872a                	mv	a4,a0
      *dst++ = *src++;
 28e:	0585                	addi	a1,a1,1
 290:	0705                	addi	a4,a4,1
 292:	fff5c683          	lbu	a3,-1(a1)
 296:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 29a:	fef71ae3          	bne	a4,a5,28e <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 29e:	6422                	ld	s0,8(sp)
 2a0:	0141                	addi	sp,sp,16
 2a2:	8082                	ret
    dst += n;
 2a4:	00c50733          	add	a4,a0,a2
    src += n;
 2a8:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2aa:	fec05ae3          	blez	a2,29e <memmove+0x28>
 2ae:	fff6079b          	addiw	a5,a2,-1
 2b2:	1782                	slli	a5,a5,0x20
 2b4:	9381                	srli	a5,a5,0x20
 2b6:	fff7c793          	not	a5,a5
 2ba:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2bc:	15fd                	addi	a1,a1,-1
 2be:	177d                	addi	a4,a4,-1
 2c0:	0005c683          	lbu	a3,0(a1)
 2c4:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2c8:	fee79ae3          	bne	a5,a4,2bc <memmove+0x46>
 2cc:	bfc9                	j	29e <memmove+0x28>

00000000000002ce <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2ce:	1141                	addi	sp,sp,-16
 2d0:	e422                	sd	s0,8(sp)
 2d2:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2d4:	ca05                	beqz	a2,304 <memcmp+0x36>
 2d6:	fff6069b          	addiw	a3,a2,-1
 2da:	1682                	slli	a3,a3,0x20
 2dc:	9281                	srli	a3,a3,0x20
 2de:	0685                	addi	a3,a3,1
 2e0:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2e2:	00054783          	lbu	a5,0(a0)
 2e6:	0005c703          	lbu	a4,0(a1)
 2ea:	00e79863          	bne	a5,a4,2fa <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 2ee:	0505                	addi	a0,a0,1
    p2++;
 2f0:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2f2:	fed518e3          	bne	a0,a3,2e2 <memcmp+0x14>
  }
  return 0;
 2f6:	4501                	li	a0,0
 2f8:	a019                	j	2fe <memcmp+0x30>
      return *p1 - *p2;
 2fa:	40e7853b          	subw	a0,a5,a4
}
 2fe:	6422                	ld	s0,8(sp)
 300:	0141                	addi	sp,sp,16
 302:	8082                	ret
  return 0;
 304:	4501                	li	a0,0
 306:	bfe5                	j	2fe <memcmp+0x30>

0000000000000308 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 308:	1141                	addi	sp,sp,-16
 30a:	e406                	sd	ra,8(sp)
 30c:	e022                	sd	s0,0(sp)
 30e:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 310:	f67ff0ef          	jal	276 <memmove>
}
 314:	60a2                	ld	ra,8(sp)
 316:	6402                	ld	s0,0(sp)
 318:	0141                	addi	sp,sp,16
 31a:	8082                	ret

000000000000031c <sbrk>:

char *
sbrk(int n) {
 31c:	1141                	addi	sp,sp,-16
 31e:	e406                	sd	ra,8(sp)
 320:	e022                	sd	s0,0(sp)
 322:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 324:	4585                	li	a1,1
 326:	142000ef          	jal	468 <sys_sbrk>
}
 32a:	60a2                	ld	ra,8(sp)
 32c:	6402                	ld	s0,0(sp)
 32e:	0141                	addi	sp,sp,16
 330:	8082                	ret

0000000000000332 <sbrklazy>:

char *
sbrklazy(int n) {
 332:	1141                	addi	sp,sp,-16
 334:	e406                	sd	ra,8(sp)
 336:	e022                	sd	s0,0(sp)
 338:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 33a:	4589                	li	a1,2
 33c:	12c000ef          	jal	468 <sys_sbrk>
}
 340:	60a2                	ld	ra,8(sp)
 342:	6402                	ld	s0,0(sp)
 344:	0141                	addi	sp,sp,16
 346:	8082                	ret

0000000000000348 <thread_create>:
// thread_create allocates a page-sized stack, calls clone(fn, arg, stacktop).
// Returns the new thread's pid, or -1 on error.
// The stack is passed back via *stack so the caller can free it after join.
int
thread_create(void(*fn)(void*), void *arg, void **stack)
{
 348:	7179                	addi	sp,sp,-48
 34a:	f406                	sd	ra,40(sp)
 34c:	f022                	sd	s0,32(sp)
 34e:	e84a                	sd	s2,16(sp)
 350:	e44e                	sd	s3,8(sp)
 352:	e052                	sd	s4,0(sp)
 354:	1800                	addi	s0,sp,48
 356:	89aa                	mv	s3,a0
 358:	8a2e                	mv	s4,a1
 35a:	8932                	mv	s2,a2
  char *s = malloc(PGSIZE);
 35c:	6505                	lui	a0,0x1
 35e:	5ea000ef          	jal	948 <malloc>
  if(s == 0)
 362:	cd0d                	beqz	a0,39c <thread_create+0x54>
 364:	ec26                	sd	s1,24(sp)
 366:	84aa                	mv	s1,a0
    return -1;
  *stack = s;
 368:	00a93023          	sd	a0,0(s2)
  // Stack grows downward- pass the top of the allocated region.
  int pid = clone(fn, arg, s + PGSIZE);
 36c:	6605                	lui	a2,0x1
 36e:	962a                	add	a2,a2,a0
 370:	85d2                	mv	a1,s4
 372:	854e                	mv	a0,s3
 374:	166000ef          	jal	4da <clone>
  if(pid < 0){
 378:	00054a63          	bltz	a0,38c <thread_create+0x44>
 37c:	64e2                	ld	s1,24(sp)
    free(s);
    *stack = 0;
    return -1;
  }
  return pid;
}
 37e:	70a2                	ld	ra,40(sp)
 380:	7402                	ld	s0,32(sp)
 382:	6942                	ld	s2,16(sp)
 384:	69a2                	ld	s3,8(sp)
 386:	6a02                	ld	s4,0(sp)
 388:	6145                	addi	sp,sp,48
 38a:	8082                	ret
    free(s);
 38c:	8526                	mv	a0,s1
 38e:	538000ef          	jal	8c6 <free>
    *stack = 0;
 392:	00093023          	sd	zero,0(s2)
    return -1;
 396:	557d                	li	a0,-1
 398:	64e2                	ld	s1,24(sp)
 39a:	b7d5                	j	37e <thread_create+0x36>
    return -1;
 39c:	557d                	li	a0,-1
 39e:	b7c5                	j	37e <thread_create+0x36>

00000000000003a0 <thread_join>:
// Wait for any child thread to exit.
// If stack is non-null, frees the memory pointed to by *stack and clears it.
// Returns the joined thread's pid, or -1 Son error.
int
thread_join(void **stack)
{
 3a0:	1101                	addi	sp,sp,-32
 3a2:	ec06                	sd	ra,24(sp)
 3a4:	e822                	sd	s0,16(sp)
 3a6:	e426                	sd	s1,8(sp)
 3a8:	e04a                	sd	s2,0(sp)
 3aa:	1000                	addi	s0,sp,32
 3ac:	84aa                	mv	s1,a0
  int pid = join();
 3ae:	134000ef          	jal	4e2 <join>
  if(pid < 0)
 3b2:	02054163          	bltz	a0,3d4 <thread_join+0x34>
 3b6:	892a                	mv	s2,a0
    return -1;
  if(stack && *stack){
 3b8:	c499                	beqz	s1,3c6 <thread_join+0x26>
 3ba:	6088                	ld	a0,0(s1)
 3bc:	c509                	beqz	a0,3c6 <thread_join+0x26>
    free(*stack);
 3be:	508000ef          	jal	8c6 <free>
    *stack = 0;
 3c2:	0004b023          	sd	zero,0(s1)
  }
  return pid;
}
 3c6:	854a                	mv	a0,s2
 3c8:	60e2                	ld	ra,24(sp)
 3ca:	6442                	ld	s0,16(sp)
 3cc:	64a2                	ld	s1,8(sp)
 3ce:	6902                	ld	s2,0(sp)
 3d0:	6105                	addi	sp,sp,32
 3d2:	8082                	ret
    return -1;
 3d4:	597d                	li	s2,-1
 3d6:	bfc5                	j	3c6 <thread_join+0x26>

00000000000003d8 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3d8:	4885                	li	a7,1
 ecall
 3da:	00000073          	ecall
 ret
 3de:	8082                	ret

00000000000003e0 <exit>:
.global exit
exit:
 li a7, SYS_exit
 3e0:	4889                	li	a7,2
 ecall
 3e2:	00000073          	ecall
 ret
 3e6:	8082                	ret

00000000000003e8 <wait>:
.global wait
wait:
 li a7, SYS_wait
 3e8:	488d                	li	a7,3
 ecall
 3ea:	00000073          	ecall
 ret
 3ee:	8082                	ret

00000000000003f0 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 3f0:	4891                	li	a7,4
 ecall
 3f2:	00000073          	ecall
 ret
 3f6:	8082                	ret

00000000000003f8 <read>:
.global read
read:
 li a7, SYS_read
 3f8:	4895                	li	a7,5
 ecall
 3fa:	00000073          	ecall
 ret
 3fe:	8082                	ret

0000000000000400 <write>:
.global write
write:
 li a7, SYS_write
 400:	48c1                	li	a7,16
 ecall
 402:	00000073          	ecall
 ret
 406:	8082                	ret

0000000000000408 <close>:
.global close
close:
 li a7, SYS_close
 408:	48d5                	li	a7,21
 ecall
 40a:	00000073          	ecall
 ret
 40e:	8082                	ret

0000000000000410 <kill>:
.global kill
kill:
 li a7, SYS_kill
 410:	4899                	li	a7,6
 ecall
 412:	00000073          	ecall
 ret
 416:	8082                	ret

0000000000000418 <exec>:
.global exec
exec:
 li a7, SYS_exec
 418:	489d                	li	a7,7
 ecall
 41a:	00000073          	ecall
 ret
 41e:	8082                	ret

0000000000000420 <open>:
.global open
open:
 li a7, SYS_open
 420:	48bd                	li	a7,15
 ecall
 422:	00000073          	ecall
 ret
 426:	8082                	ret

0000000000000428 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 428:	48c5                	li	a7,17
 ecall
 42a:	00000073          	ecall
 ret
 42e:	8082                	ret

0000000000000430 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 430:	48c9                	li	a7,18
 ecall
 432:	00000073          	ecall
 ret
 436:	8082                	ret

0000000000000438 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 438:	48a1                	li	a7,8
 ecall
 43a:	00000073          	ecall
 ret
 43e:	8082                	ret

0000000000000440 <link>:
.global link
link:
 li a7, SYS_link
 440:	48cd                	li	a7,19
 ecall
 442:	00000073          	ecall
 ret
 446:	8082                	ret

0000000000000448 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 448:	48d1                	li	a7,20
 ecall
 44a:	00000073          	ecall
 ret
 44e:	8082                	ret

0000000000000450 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 450:	48a5                	li	a7,9
 ecall
 452:	00000073          	ecall
 ret
 456:	8082                	ret

0000000000000458 <dup>:
.global dup
dup:
 li a7, SYS_dup
 458:	48a9                	li	a7,10
 ecall
 45a:	00000073          	ecall
 ret
 45e:	8082                	ret

0000000000000460 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 460:	48ad                	li	a7,11
 ecall
 462:	00000073          	ecall
 ret
 466:	8082                	ret

0000000000000468 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 468:	48b1                	li	a7,12
 ecall
 46a:	00000073          	ecall
 ret
 46e:	8082                	ret

0000000000000470 <pause>:
.global pause
pause:
 li a7, SYS_pause
 470:	48b5                	li	a7,13
 ecall
 472:	00000073          	ecall
 ret
 476:	8082                	ret

0000000000000478 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 478:	48b9                	li	a7,14
 ecall
 47a:	00000073          	ecall
 ret
 47e:	8082                	ret

0000000000000480 <getppid>:
.global getppid
getppid:
 li a7, SYS_getppid
 480:	02100893          	li	a7,33
 ecall
 484:	00000073          	ecall
 ret
 488:	8082                	ret

000000000000048a <ps>:
.global ps
ps:
 li a7, SYS_ps
 48a:	02200893          	li	a7,34
 ecall
 48e:	00000073          	ecall
 ret
 492:	8082                	ret

0000000000000494 <trace>:
.global trace
trace:
 li a7, SYS_trace
 494:	02300893          	li	a7,35
 ecall
 498:	00000073          	ecall
 ret
 49c:	8082                	ret

000000000000049e <waitx>:
.global waitx
waitx:
 li a7, SYS_waitx
 49e:	02400893          	li	a7,36
 ecall
 4a2:	00000073          	ecall
 ret
 4a6:	8082                	ret

00000000000004a8 <getcount>:
.global getcount
getcount:
 li a7, SYS_getcount
 4a8:	02500893          	li	a7,37
 ecall
 4ac:	00000073          	ecall
 ret
 4b0:	8082                	ret

00000000000004b2 <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 4b2:	48d9                	li	a7,22
 ecall
 4b4:	00000073          	ecall
 ret
 4b8:	8082                	ret

00000000000004ba <lock_create>:
.global lock_create
lock_create:
 li a7, SYS_lock_create
 4ba:	48dd                	li	a7,23
 ecall
 4bc:	00000073          	ecall
 ret
 4c0:	8082                	ret

00000000000004c2 <lock_acquire>:
.global lock_acquire
lock_acquire:
 li a7, SYS_lock_acquire
 4c2:	48e1                	li	a7,24
 ecall
 4c4:	00000073          	ecall
 ret
 4c8:	8082                	ret

00000000000004ca <lock_release>:
.global lock_release
lock_release:
 li a7, SYS_lock_release
 4ca:	48e5                	li	a7,25
 ecall
 4cc:	00000073          	ecall
 ret
 4d0:	8082                	ret

00000000000004d2 <lock_destroy>:
.global lock_destroy
lock_destroy:
 li a7, SYS_lock_destroy
 4d2:	48e9                	li	a7,26
 ecall
 4d4:	00000073          	ecall
 ret
 4d8:	8082                	ret

00000000000004da <clone>:
.global clone
clone:
 li a7, SYS_clone
 4da:	48ed                	li	a7,27
 ecall
 4dc:	00000073          	ecall
 ret
 4e0:	8082                	ret

00000000000004e2 <join>:
.global join
join:
 li a7, SYS_join
 4e2:	48f1                	li	a7,28
 ecall
 4e4:	00000073          	ecall
 ret
 4e8:	8082                	ret

00000000000004ea <getprocessinfo>:
.global getprocessinfo
getprocessinfo:
 li a7, SYS_getprocessinfo
 4ea:	48f5                	li	a7,29
 ecall
 4ec:	00000073          	ecall
 ret
 4f0:	8082                	ret

00000000000004f2 <shmget>:
.global shmget
shmget:
 li a7, SYS_shmget
 4f2:	48f9                	li	a7,30
 ecall
 4f4:	00000073          	ecall
 ret
 4f8:	8082                	ret

00000000000004fa <shmattach>:
.global shmattach
shmattach:
 li a7, SYS_shmattach
 4fa:	48fd                	li	a7,31
 ecall
 4fc:	00000073          	ecall
 ret
 500:	8082                	ret

0000000000000502 <shmdetach>:
.global shmdetach
shmdetach:
 li a7, SYS_shmdetach
 502:	02000893          	li	a7,32
 ecall
 506:	00000073          	ecall
 ret
 50a:	8082                	ret

000000000000050c <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 50c:	1101                	addi	sp,sp,-32
 50e:	ec06                	sd	ra,24(sp)
 510:	e822                	sd	s0,16(sp)
 512:	1000                	addi	s0,sp,32
 514:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 518:	4605                	li	a2,1
 51a:	fef40593          	addi	a1,s0,-17
 51e:	ee3ff0ef          	jal	400 <write>
}
 522:	60e2                	ld	ra,24(sp)
 524:	6442                	ld	s0,16(sp)
 526:	6105                	addi	sp,sp,32
 528:	8082                	ret

000000000000052a <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 52a:	715d                	addi	sp,sp,-80
 52c:	e486                	sd	ra,72(sp)
 52e:	e0a2                	sd	s0,64(sp)
 530:	f84a                	sd	s2,48(sp)
 532:	0880                	addi	s0,sp,80
 534:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 536:	c299                	beqz	a3,53c <printint+0x12>
 538:	0805c363          	bltz	a1,5be <printint+0x94>
  neg = 0;
 53c:	4881                	li	a7,0
 53e:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 542:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 544:	00000517          	auipc	a0,0x0
 548:	57c50513          	addi	a0,a0,1404 # ac0 <digits>
 54c:	883e                	mv	a6,a5
 54e:	2785                	addiw	a5,a5,1
 550:	02c5f733          	remu	a4,a1,a2
 554:	972a                	add	a4,a4,a0
 556:	00074703          	lbu	a4,0(a4)
 55a:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 55e:	872e                	mv	a4,a1
 560:	02c5d5b3          	divu	a1,a1,a2
 564:	0685                	addi	a3,a3,1
 566:	fec773e3          	bgeu	a4,a2,54c <printint+0x22>
  if(neg)
 56a:	00088b63          	beqz	a7,580 <printint+0x56>
    buf[i++] = '-';
 56e:	fd078793          	addi	a5,a5,-48
 572:	97a2                	add	a5,a5,s0
 574:	02d00713          	li	a4,45
 578:	fee78423          	sb	a4,-24(a5)
 57c:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
 580:	02f05a63          	blez	a5,5b4 <printint+0x8a>
 584:	fc26                	sd	s1,56(sp)
 586:	f44e                	sd	s3,40(sp)
 588:	fb840713          	addi	a4,s0,-72
 58c:	00f704b3          	add	s1,a4,a5
 590:	fff70993          	addi	s3,a4,-1
 594:	99be                	add	s3,s3,a5
 596:	37fd                	addiw	a5,a5,-1
 598:	1782                	slli	a5,a5,0x20
 59a:	9381                	srli	a5,a5,0x20
 59c:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 5a0:	fff4c583          	lbu	a1,-1(s1)
 5a4:	854a                	mv	a0,s2
 5a6:	f67ff0ef          	jal	50c <putc>
  while(--i >= 0)
 5aa:	14fd                	addi	s1,s1,-1
 5ac:	ff349ae3          	bne	s1,s3,5a0 <printint+0x76>
 5b0:	74e2                	ld	s1,56(sp)
 5b2:	79a2                	ld	s3,40(sp)
}
 5b4:	60a6                	ld	ra,72(sp)
 5b6:	6406                	ld	s0,64(sp)
 5b8:	7942                	ld	s2,48(sp)
 5ba:	6161                	addi	sp,sp,80
 5bc:	8082                	ret
    x = -xx;
 5be:	40b005b3          	neg	a1,a1
    neg = 1;
 5c2:	4885                	li	a7,1
    x = -xx;
 5c4:	bfad                	j	53e <printint+0x14>

00000000000005c6 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5c6:	711d                	addi	sp,sp,-96
 5c8:	ec86                	sd	ra,88(sp)
 5ca:	e8a2                	sd	s0,80(sp)
 5cc:	e0ca                	sd	s2,64(sp)
 5ce:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5d0:	0005c903          	lbu	s2,0(a1)
 5d4:	28090663          	beqz	s2,860 <vprintf+0x29a>
 5d8:	e4a6                	sd	s1,72(sp)
 5da:	fc4e                	sd	s3,56(sp)
 5dc:	f852                	sd	s4,48(sp)
 5de:	f456                	sd	s5,40(sp)
 5e0:	f05a                	sd	s6,32(sp)
 5e2:	ec5e                	sd	s7,24(sp)
 5e4:	e862                	sd	s8,16(sp)
 5e6:	e466                	sd	s9,8(sp)
 5e8:	8b2a                	mv	s6,a0
 5ea:	8a2e                	mv	s4,a1
 5ec:	8bb2                	mv	s7,a2
  state = 0;
 5ee:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 5f0:	4481                	li	s1,0
 5f2:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 5f4:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 5f8:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 5fc:	06c00c93          	li	s9,108
 600:	a005                	j	620 <vprintf+0x5a>
        putc(fd, c0);
 602:	85ca                	mv	a1,s2
 604:	855a                	mv	a0,s6
 606:	f07ff0ef          	jal	50c <putc>
 60a:	a019                	j	610 <vprintf+0x4a>
    } else if(state == '%'){
 60c:	03598263          	beq	s3,s5,630 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 610:	2485                	addiw	s1,s1,1
 612:	8726                	mv	a4,s1
 614:	009a07b3          	add	a5,s4,s1
 618:	0007c903          	lbu	s2,0(a5)
 61c:	22090a63          	beqz	s2,850 <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 620:	0009079b          	sext.w	a5,s2
    if(state == 0){
 624:	fe0994e3          	bnez	s3,60c <vprintf+0x46>
      if(c0 == '%'){
 628:	fd579de3          	bne	a5,s5,602 <vprintf+0x3c>
        state = '%';
 62c:	89be                	mv	s3,a5
 62e:	b7cd                	j	610 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 630:	00ea06b3          	add	a3,s4,a4
 634:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 638:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 63a:	c681                	beqz	a3,642 <vprintf+0x7c>
 63c:	9752                	add	a4,a4,s4
 63e:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 642:	05878363          	beq	a5,s8,688 <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 646:	05978d63          	beq	a5,s9,6a0 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 64a:	07500713          	li	a4,117
 64e:	0ee78763          	beq	a5,a4,73c <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 652:	07800713          	li	a4,120
 656:	12e78963          	beq	a5,a4,788 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 65a:	07000713          	li	a4,112
 65e:	14e78e63          	beq	a5,a4,7ba <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 662:	06300713          	li	a4,99
 666:	18e78e63          	beq	a5,a4,802 <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 66a:	07300713          	li	a4,115
 66e:	1ae78463          	beq	a5,a4,816 <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 672:	02500713          	li	a4,37
 676:	04e79563          	bne	a5,a4,6c0 <vprintf+0xfa>
        putc(fd, '%');
 67a:	02500593          	li	a1,37
 67e:	855a                	mv	a0,s6
 680:	e8dff0ef          	jal	50c <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 684:	4981                	li	s3,0
 686:	b769                	j	610 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 688:	008b8913          	addi	s2,s7,8
 68c:	4685                	li	a3,1
 68e:	4629                	li	a2,10
 690:	000ba583          	lw	a1,0(s7)
 694:	855a                	mv	a0,s6
 696:	e95ff0ef          	jal	52a <printint>
 69a:	8bca                	mv	s7,s2
      state = 0;
 69c:	4981                	li	s3,0
 69e:	bf8d                	j	610 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 6a0:	06400793          	li	a5,100
 6a4:	02f68963          	beq	a3,a5,6d6 <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 6a8:	06c00793          	li	a5,108
 6ac:	04f68263          	beq	a3,a5,6f0 <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 6b0:	07500793          	li	a5,117
 6b4:	0af68063          	beq	a3,a5,754 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 6b8:	07800793          	li	a5,120
 6bc:	0ef68263          	beq	a3,a5,7a0 <vprintf+0x1da>
        putc(fd, '%');
 6c0:	02500593          	li	a1,37
 6c4:	855a                	mv	a0,s6
 6c6:	e47ff0ef          	jal	50c <putc>
        putc(fd, c0);
 6ca:	85ca                	mv	a1,s2
 6cc:	855a                	mv	a0,s6
 6ce:	e3fff0ef          	jal	50c <putc>
      state = 0;
 6d2:	4981                	li	s3,0
 6d4:	bf35                	j	610 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 6d6:	008b8913          	addi	s2,s7,8
 6da:	4685                	li	a3,1
 6dc:	4629                	li	a2,10
 6de:	000bb583          	ld	a1,0(s7)
 6e2:	855a                	mv	a0,s6
 6e4:	e47ff0ef          	jal	52a <printint>
        i += 1;
 6e8:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 6ea:	8bca                	mv	s7,s2
      state = 0;
 6ec:	4981                	li	s3,0
        i += 1;
 6ee:	b70d                	j	610 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 6f0:	06400793          	li	a5,100
 6f4:	02f60763          	beq	a2,a5,722 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 6f8:	07500793          	li	a5,117
 6fc:	06f60963          	beq	a2,a5,76e <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 700:	07800793          	li	a5,120
 704:	faf61ee3          	bne	a2,a5,6c0 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 708:	008b8913          	addi	s2,s7,8
 70c:	4681                	li	a3,0
 70e:	4641                	li	a2,16
 710:	000bb583          	ld	a1,0(s7)
 714:	855a                	mv	a0,s6
 716:	e15ff0ef          	jal	52a <printint>
        i += 2;
 71a:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 71c:	8bca                	mv	s7,s2
      state = 0;
 71e:	4981                	li	s3,0
        i += 2;
 720:	bdc5                	j	610 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 722:	008b8913          	addi	s2,s7,8
 726:	4685                	li	a3,1
 728:	4629                	li	a2,10
 72a:	000bb583          	ld	a1,0(s7)
 72e:	855a                	mv	a0,s6
 730:	dfbff0ef          	jal	52a <printint>
        i += 2;
 734:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 736:	8bca                	mv	s7,s2
      state = 0;
 738:	4981                	li	s3,0
        i += 2;
 73a:	bdd9                	j	610 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 73c:	008b8913          	addi	s2,s7,8
 740:	4681                	li	a3,0
 742:	4629                	li	a2,10
 744:	000be583          	lwu	a1,0(s7)
 748:	855a                	mv	a0,s6
 74a:	de1ff0ef          	jal	52a <printint>
 74e:	8bca                	mv	s7,s2
      state = 0;
 750:	4981                	li	s3,0
 752:	bd7d                	j	610 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 754:	008b8913          	addi	s2,s7,8
 758:	4681                	li	a3,0
 75a:	4629                	li	a2,10
 75c:	000bb583          	ld	a1,0(s7)
 760:	855a                	mv	a0,s6
 762:	dc9ff0ef          	jal	52a <printint>
        i += 1;
 766:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 768:	8bca                	mv	s7,s2
      state = 0;
 76a:	4981                	li	s3,0
        i += 1;
 76c:	b555                	j	610 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 76e:	008b8913          	addi	s2,s7,8
 772:	4681                	li	a3,0
 774:	4629                	li	a2,10
 776:	000bb583          	ld	a1,0(s7)
 77a:	855a                	mv	a0,s6
 77c:	dafff0ef          	jal	52a <printint>
        i += 2;
 780:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 782:	8bca                	mv	s7,s2
      state = 0;
 784:	4981                	li	s3,0
        i += 2;
 786:	b569                	j	610 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 788:	008b8913          	addi	s2,s7,8
 78c:	4681                	li	a3,0
 78e:	4641                	li	a2,16
 790:	000be583          	lwu	a1,0(s7)
 794:	855a                	mv	a0,s6
 796:	d95ff0ef          	jal	52a <printint>
 79a:	8bca                	mv	s7,s2
      state = 0;
 79c:	4981                	li	s3,0
 79e:	bd8d                	j	610 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 7a0:	008b8913          	addi	s2,s7,8
 7a4:	4681                	li	a3,0
 7a6:	4641                	li	a2,16
 7a8:	000bb583          	ld	a1,0(s7)
 7ac:	855a                	mv	a0,s6
 7ae:	d7dff0ef          	jal	52a <printint>
        i += 1;
 7b2:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 7b4:	8bca                	mv	s7,s2
      state = 0;
 7b6:	4981                	li	s3,0
        i += 1;
 7b8:	bda1                	j	610 <vprintf+0x4a>
 7ba:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 7bc:	008b8d13          	addi	s10,s7,8
 7c0:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 7c4:	03000593          	li	a1,48
 7c8:	855a                	mv	a0,s6
 7ca:	d43ff0ef          	jal	50c <putc>
  putc(fd, 'x');
 7ce:	07800593          	li	a1,120
 7d2:	855a                	mv	a0,s6
 7d4:	d39ff0ef          	jal	50c <putc>
 7d8:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7da:	00000b97          	auipc	s7,0x0
 7de:	2e6b8b93          	addi	s7,s7,742 # ac0 <digits>
 7e2:	03c9d793          	srli	a5,s3,0x3c
 7e6:	97de                	add	a5,a5,s7
 7e8:	0007c583          	lbu	a1,0(a5)
 7ec:	855a                	mv	a0,s6
 7ee:	d1fff0ef          	jal	50c <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 7f2:	0992                	slli	s3,s3,0x4
 7f4:	397d                	addiw	s2,s2,-1
 7f6:	fe0916e3          	bnez	s2,7e2 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 7fa:	8bea                	mv	s7,s10
      state = 0;
 7fc:	4981                	li	s3,0
 7fe:	6d02                	ld	s10,0(sp)
 800:	bd01                	j	610 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 802:	008b8913          	addi	s2,s7,8
 806:	000bc583          	lbu	a1,0(s7)
 80a:	855a                	mv	a0,s6
 80c:	d01ff0ef          	jal	50c <putc>
 810:	8bca                	mv	s7,s2
      state = 0;
 812:	4981                	li	s3,0
 814:	bbf5                	j	610 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 816:	008b8993          	addi	s3,s7,8
 81a:	000bb903          	ld	s2,0(s7)
 81e:	00090f63          	beqz	s2,83c <vprintf+0x276>
        for(; *s; s++)
 822:	00094583          	lbu	a1,0(s2)
 826:	c195                	beqz	a1,84a <vprintf+0x284>
          putc(fd, *s);
 828:	855a                	mv	a0,s6
 82a:	ce3ff0ef          	jal	50c <putc>
        for(; *s; s++)
 82e:	0905                	addi	s2,s2,1
 830:	00094583          	lbu	a1,0(s2)
 834:	f9f5                	bnez	a1,828 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 836:	8bce                	mv	s7,s3
      state = 0;
 838:	4981                	li	s3,0
 83a:	bbd9                	j	610 <vprintf+0x4a>
          s = "(null)";
 83c:	00000917          	auipc	s2,0x0
 840:	27c90913          	addi	s2,s2,636 # ab8 <malloc+0x170>
        for(; *s; s++)
 844:	02800593          	li	a1,40
 848:	b7c5                	j	828 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 84a:	8bce                	mv	s7,s3
      state = 0;
 84c:	4981                	li	s3,0
 84e:	b3c9                	j	610 <vprintf+0x4a>
 850:	64a6                	ld	s1,72(sp)
 852:	79e2                	ld	s3,56(sp)
 854:	7a42                	ld	s4,48(sp)
 856:	7aa2                	ld	s5,40(sp)
 858:	7b02                	ld	s6,32(sp)
 85a:	6be2                	ld	s7,24(sp)
 85c:	6c42                	ld	s8,16(sp)
 85e:	6ca2                	ld	s9,8(sp)
    }
  }
}
 860:	60e6                	ld	ra,88(sp)
 862:	6446                	ld	s0,80(sp)
 864:	6906                	ld	s2,64(sp)
 866:	6125                	addi	sp,sp,96
 868:	8082                	ret

000000000000086a <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 86a:	715d                	addi	sp,sp,-80
 86c:	ec06                	sd	ra,24(sp)
 86e:	e822                	sd	s0,16(sp)
 870:	1000                	addi	s0,sp,32
 872:	e010                	sd	a2,0(s0)
 874:	e414                	sd	a3,8(s0)
 876:	e818                	sd	a4,16(s0)
 878:	ec1c                	sd	a5,24(s0)
 87a:	03043023          	sd	a6,32(s0)
 87e:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 882:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 886:	8622                	mv	a2,s0
 888:	d3fff0ef          	jal	5c6 <vprintf>
}
 88c:	60e2                	ld	ra,24(sp)
 88e:	6442                	ld	s0,16(sp)
 890:	6161                	addi	sp,sp,80
 892:	8082                	ret

0000000000000894 <printf>:

void
printf(const char *fmt, ...)
{
 894:	711d                	addi	sp,sp,-96
 896:	ec06                	sd	ra,24(sp)
 898:	e822                	sd	s0,16(sp)
 89a:	1000                	addi	s0,sp,32
 89c:	e40c                	sd	a1,8(s0)
 89e:	e810                	sd	a2,16(s0)
 8a0:	ec14                	sd	a3,24(s0)
 8a2:	f018                	sd	a4,32(s0)
 8a4:	f41c                	sd	a5,40(s0)
 8a6:	03043823          	sd	a6,48(s0)
 8aa:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 8ae:	00840613          	addi	a2,s0,8
 8b2:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 8b6:	85aa                	mv	a1,a0
 8b8:	4505                	li	a0,1
 8ba:	d0dff0ef          	jal	5c6 <vprintf>
}
 8be:	60e2                	ld	ra,24(sp)
 8c0:	6442                	ld	s0,16(sp)
 8c2:	6125                	addi	sp,sp,96
 8c4:	8082                	ret

00000000000008c6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8c6:	1141                	addi	sp,sp,-16
 8c8:	e422                	sd	s0,8(sp)
 8ca:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8cc:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8d0:	00000797          	auipc	a5,0x0
 8d4:	7407b783          	ld	a5,1856(a5) # 1010 <freep>
 8d8:	a02d                	j	902 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8da:	4618                	lw	a4,8(a2)
 8dc:	9f2d                	addw	a4,a4,a1
 8de:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8e2:	6398                	ld	a4,0(a5)
 8e4:	6310                	ld	a2,0(a4)
 8e6:	a83d                	j	924 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 8e8:	ff852703          	lw	a4,-8(a0)
 8ec:	9f31                	addw	a4,a4,a2
 8ee:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 8f0:	ff053683          	ld	a3,-16(a0)
 8f4:	a091                	j	938 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 8f6:	6398                	ld	a4,0(a5)
 8f8:	00e7e463          	bltu	a5,a4,900 <free+0x3a>
 8fc:	00e6ea63          	bltu	a3,a4,910 <free+0x4a>
{
 900:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 902:	fed7fae3          	bgeu	a5,a3,8f6 <free+0x30>
 906:	6398                	ld	a4,0(a5)
 908:	00e6e463          	bltu	a3,a4,910 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 90c:	fee7eae3          	bltu	a5,a4,900 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 910:	ff852583          	lw	a1,-8(a0)
 914:	6390                	ld	a2,0(a5)
 916:	02059813          	slli	a6,a1,0x20
 91a:	01c85713          	srli	a4,a6,0x1c
 91e:	9736                	add	a4,a4,a3
 920:	fae60de3          	beq	a2,a4,8da <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 924:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 928:	4790                	lw	a2,8(a5)
 92a:	02061593          	slli	a1,a2,0x20
 92e:	01c5d713          	srli	a4,a1,0x1c
 932:	973e                	add	a4,a4,a5
 934:	fae68ae3          	beq	a3,a4,8e8 <free+0x22>
    p->s.ptr = bp->s.ptr;
 938:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 93a:	00000717          	auipc	a4,0x0
 93e:	6cf73b23          	sd	a5,1750(a4) # 1010 <freep>
}
 942:	6422                	ld	s0,8(sp)
 944:	0141                	addi	sp,sp,16
 946:	8082                	ret

0000000000000948 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 948:	7139                	addi	sp,sp,-64
 94a:	fc06                	sd	ra,56(sp)
 94c:	f822                	sd	s0,48(sp)
 94e:	f426                	sd	s1,40(sp)
 950:	ec4e                	sd	s3,24(sp)
 952:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 954:	02051493          	slli	s1,a0,0x20
 958:	9081                	srli	s1,s1,0x20
 95a:	04bd                	addi	s1,s1,15
 95c:	8091                	srli	s1,s1,0x4
 95e:	0014899b          	addiw	s3,s1,1
 962:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 964:	00000517          	auipc	a0,0x0
 968:	6ac53503          	ld	a0,1708(a0) # 1010 <freep>
 96c:	c915                	beqz	a0,9a0 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 96e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 970:	4798                	lw	a4,8(a5)
 972:	08977a63          	bgeu	a4,s1,a06 <malloc+0xbe>
 976:	f04a                	sd	s2,32(sp)
 978:	e852                	sd	s4,16(sp)
 97a:	e456                	sd	s5,8(sp)
 97c:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 97e:	8a4e                	mv	s4,s3
 980:	0009871b          	sext.w	a4,s3
 984:	6685                	lui	a3,0x1
 986:	00d77363          	bgeu	a4,a3,98c <malloc+0x44>
 98a:	6a05                	lui	s4,0x1
 98c:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 990:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 994:	00000917          	auipc	s2,0x0
 998:	67c90913          	addi	s2,s2,1660 # 1010 <freep>
  if(p == SBRK_ERROR)
 99c:	5afd                	li	s5,-1
 99e:	a081                	j	9de <malloc+0x96>
 9a0:	f04a                	sd	s2,32(sp)
 9a2:	e852                	sd	s4,16(sp)
 9a4:	e456                	sd	s5,8(sp)
 9a6:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 9a8:	00000797          	auipc	a5,0x0
 9ac:	67878793          	addi	a5,a5,1656 # 1020 <base>
 9b0:	00000717          	auipc	a4,0x0
 9b4:	66f73023          	sd	a5,1632(a4) # 1010 <freep>
 9b8:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 9ba:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 9be:	b7c1                	j	97e <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 9c0:	6398                	ld	a4,0(a5)
 9c2:	e118                	sd	a4,0(a0)
 9c4:	a8a9                	j	a1e <malloc+0xd6>
  hp->s.size = nu;
 9c6:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 9ca:	0541                	addi	a0,a0,16
 9cc:	efbff0ef          	jal	8c6 <free>
  return freep;
 9d0:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 9d4:	c12d                	beqz	a0,a36 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9d6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9d8:	4798                	lw	a4,8(a5)
 9da:	02977263          	bgeu	a4,s1,9fe <malloc+0xb6>
    if(p == freep)
 9de:	00093703          	ld	a4,0(s2)
 9e2:	853e                	mv	a0,a5
 9e4:	fef719e3          	bne	a4,a5,9d6 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 9e8:	8552                	mv	a0,s4
 9ea:	933ff0ef          	jal	31c <sbrk>
  if(p == SBRK_ERROR)
 9ee:	fd551ce3          	bne	a0,s5,9c6 <malloc+0x7e>
        return 0;
 9f2:	4501                	li	a0,0
 9f4:	7902                	ld	s2,32(sp)
 9f6:	6a42                	ld	s4,16(sp)
 9f8:	6aa2                	ld	s5,8(sp)
 9fa:	6b02                	ld	s6,0(sp)
 9fc:	a03d                	j	a2a <malloc+0xe2>
 9fe:	7902                	ld	s2,32(sp)
 a00:	6a42                	ld	s4,16(sp)
 a02:	6aa2                	ld	s5,8(sp)
 a04:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 a06:	fae48de3          	beq	s1,a4,9c0 <malloc+0x78>
        p->s.size -= nunits;
 a0a:	4137073b          	subw	a4,a4,s3
 a0e:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a10:	02071693          	slli	a3,a4,0x20
 a14:	01c6d713          	srli	a4,a3,0x1c
 a18:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a1a:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a1e:	00000717          	auipc	a4,0x0
 a22:	5ea73923          	sd	a0,1522(a4) # 1010 <freep>
      return (void*)(p + 1);
 a26:	01078513          	addi	a0,a5,16
  }
}
 a2a:	70e2                	ld	ra,56(sp)
 a2c:	7442                	ld	s0,48(sp)
 a2e:	74a2                	ld	s1,40(sp)
 a30:	69e2                	ld	s3,24(sp)
 a32:	6121                	addi	sp,sp,64
 a34:	8082                	ret
 a36:	7902                	ld	s2,32(sp)
 a38:	6a42                	ld	s4,16(sp)
 a3a:	6aa2                	ld	s5,8(sp)
 a3c:	6b02                	ld	s6,0(sp)
 a3e:	b7f5                	j	a2a <malloc+0xe2>
