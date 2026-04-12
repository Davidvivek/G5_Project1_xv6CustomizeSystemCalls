
user/_logstress:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
main(int argc, char **argv)
{
  int fd, n;
  enum { N = 250, SZ=2000 };
  
  for (int i = 1; i < argc; i++){
   0:	4785                	li	a5,1
   2:	0ea7df63          	bge	a5,a0,100 <main+0x100>
{
   6:	7139                	addi	sp,sp,-64
   8:	fc06                	sd	ra,56(sp)
   a:	f822                	sd	s0,48(sp)
   c:	f426                	sd	s1,40(sp)
   e:	f04a                	sd	s2,32(sp)
  10:	ec4e                	sd	s3,24(sp)
  12:	0080                	addi	s0,sp,64
  14:	892a                	mv	s2,a0
  16:	89ae                	mv	s3,a1
  for (int i = 1; i < argc; i++){
  18:	4485                	li	s1,1
  1a:	a011                	j	1e <main+0x1e>
  1c:	84be                	mv	s1,a5
    int pid1 = fork();
  1e:	402000ef          	jal	420 <fork>
    if(pid1 < 0){
  22:	00054963          	bltz	a0,34 <main+0x34>
      printf("%s: fork failed\n", argv[0]);
      exit(1);
    }
    if(pid1 == 0) {
  26:	c11d                	beqz	a0,4c <main+0x4c>
  for (int i = 1; i < argc; i++){
  28:	0014879b          	addiw	a5,s1,1
  2c:	fef918e3          	bne	s2,a5,1c <main+0x1c>
      }
      exit(0);
    }
  }
  int xstatus;
  for(int i = 1; i < argc; i++){
  30:	4905                	li	s2,1
  32:	a04d                	j	d4 <main+0xd4>
  34:	e852                	sd	s4,16(sp)
      printf("%s: fork failed\n", argv[0]);
  36:	0009b583          	ld	a1,0(s3)
  3a:	00001517          	auipc	a0,0x1
  3e:	a5650513          	addi	a0,a0,-1450 # a90 <malloc+0x100>
  42:	09b000ef          	jal	8dc <printf>
      exit(1);
  46:	4505                	li	a0,1
  48:	3e0000ef          	jal	428 <exit>
  4c:	e852                	sd	s4,16(sp)
      fd = open(argv[i], O_CREATE | O_RDWR);
  4e:	00349a13          	slli	s4,s1,0x3
  52:	9a4e                	add	s4,s4,s3
  54:	20200593          	li	a1,514
  58:	000a3503          	ld	a0,0(s4)
  5c:	40c000ef          	jal	468 <open>
  60:	892a                	mv	s2,a0
      if(fd < 0){
  62:	04054163          	bltz	a0,a4 <main+0xa4>
      memset(buf, '0'+i, SZ);
  66:	7d000613          	li	a2,2000
  6a:	0304859b          	addiw	a1,s1,48
  6e:	00001517          	auipc	a0,0x1
  72:	fa250513          	addi	a0,a0,-94 # 1010 <buf>
  76:	110000ef          	jal	186 <memset>
  7a:	0fa00493          	li	s1,250
        if((n = write(fd, buf, SZ)) != SZ){
  7e:	00001997          	auipc	s3,0x1
  82:	f9298993          	addi	s3,s3,-110 # 1010 <buf>
  86:	7d000613          	li	a2,2000
  8a:	85ce                	mv	a1,s3
  8c:	854a                	mv	a0,s2
  8e:	3ba000ef          	jal	448 <write>
  92:	7d000793          	li	a5,2000
  96:	02f51463          	bne	a0,a5,be <main+0xbe>
      for(i = 0; i < N; i++){
  9a:	34fd                	addiw	s1,s1,-1
  9c:	f4ed                	bnez	s1,86 <main+0x86>
      exit(0);
  9e:	4501                	li	a0,0
  a0:	388000ef          	jal	428 <exit>
        printf("%s: create %s failed\n", argv[0], argv[i]);
  a4:	000a3603          	ld	a2,0(s4)
  a8:	0009b583          	ld	a1,0(s3)
  ac:	00001517          	auipc	a0,0x1
  b0:	9fc50513          	addi	a0,a0,-1540 # aa8 <malloc+0x118>
  b4:	029000ef          	jal	8dc <printf>
        exit(1);
  b8:	4505                	li	a0,1
  ba:	36e000ef          	jal	428 <exit>
          printf("write failed %d\n", n);
  be:	85aa                	mv	a1,a0
  c0:	00001517          	auipc	a0,0x1
  c4:	a0050513          	addi	a0,a0,-1536 # ac0 <malloc+0x130>
  c8:	015000ef          	jal	8dc <printf>
          exit(1);
  cc:	4505                	li	a0,1
  ce:	35a000ef          	jal	428 <exit>
  d2:	893e                	mv	s2,a5
    wait(&xstatus);
  d4:	fcc40513          	addi	a0,s0,-52
  d8:	358000ef          	jal	430 <wait>
    if(xstatus != 0)
  dc:	fcc42503          	lw	a0,-52(s0)
  e0:	ed09                	bnez	a0,fa <main+0xfa>
  for(int i = 1; i < argc; i++){
  e2:	0019079b          	addiw	a5,s2,1
  e6:	ff2496e3          	bne	s1,s2,d2 <main+0xd2>
      exit(xstatus);
  }
  return 0;
}
  ea:	4501                	li	a0,0
  ec:	70e2                	ld	ra,56(sp)
  ee:	7442                	ld	s0,48(sp)
  f0:	74a2                	ld	s1,40(sp)
  f2:	7902                	ld	s2,32(sp)
  f4:	69e2                	ld	s3,24(sp)
  f6:	6121                	addi	sp,sp,64
  f8:	8082                	ret
  fa:	e852                	sd	s4,16(sp)
      exit(xstatus);
  fc:	32c000ef          	jal	428 <exit>
}
 100:	4501                	li	a0,0
 102:	8082                	ret

0000000000000104 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
 104:	1141                	addi	sp,sp,-16
 106:	e406                	sd	ra,8(sp)
 108:	e022                	sd	s0,0(sp)
 10a:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
 10c:	ef5ff0ef          	jal	0 <main>
  exit(r);
 110:	318000ef          	jal	428 <exit>

0000000000000114 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
 114:	1141                	addi	sp,sp,-16
 116:	e422                	sd	s0,8(sp)
 118:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 11a:	87aa                	mv	a5,a0
 11c:	0585                	addi	a1,a1,1
 11e:	0785                	addi	a5,a5,1
 120:	fff5c703          	lbu	a4,-1(a1)
 124:	fee78fa3          	sb	a4,-1(a5)
 128:	fb75                	bnez	a4,11c <strcpy+0x8>
    ;
  return os;
}
 12a:	6422                	ld	s0,8(sp)
 12c:	0141                	addi	sp,sp,16
 12e:	8082                	ret

0000000000000130 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 130:	1141                	addi	sp,sp,-16
 132:	e422                	sd	s0,8(sp)
 134:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 136:	00054783          	lbu	a5,0(a0)
 13a:	cb91                	beqz	a5,14e <strcmp+0x1e>
 13c:	0005c703          	lbu	a4,0(a1)
 140:	00f71763          	bne	a4,a5,14e <strcmp+0x1e>
    p++, q++;
 144:	0505                	addi	a0,a0,1
 146:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 148:	00054783          	lbu	a5,0(a0)
 14c:	fbe5                	bnez	a5,13c <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 14e:	0005c503          	lbu	a0,0(a1)
}
 152:	40a7853b          	subw	a0,a5,a0
 156:	6422                	ld	s0,8(sp)
 158:	0141                	addi	sp,sp,16
 15a:	8082                	ret

000000000000015c <strlen>:

uint
strlen(const char *s)
{
 15c:	1141                	addi	sp,sp,-16
 15e:	e422                	sd	s0,8(sp)
 160:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 162:	00054783          	lbu	a5,0(a0)
 166:	cf91                	beqz	a5,182 <strlen+0x26>
 168:	0505                	addi	a0,a0,1
 16a:	87aa                	mv	a5,a0
 16c:	86be                	mv	a3,a5
 16e:	0785                	addi	a5,a5,1
 170:	fff7c703          	lbu	a4,-1(a5)
 174:	ff65                	bnez	a4,16c <strlen+0x10>
 176:	40a6853b          	subw	a0,a3,a0
 17a:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 17c:	6422                	ld	s0,8(sp)
 17e:	0141                	addi	sp,sp,16
 180:	8082                	ret
  for(n = 0; s[n]; n++)
 182:	4501                	li	a0,0
 184:	bfe5                	j	17c <strlen+0x20>

0000000000000186 <memset>:

void*
memset(void *dst, int c, uint n)
{
 186:	1141                	addi	sp,sp,-16
 188:	e422                	sd	s0,8(sp)
 18a:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 18c:	ca19                	beqz	a2,1a2 <memset+0x1c>
 18e:	87aa                	mv	a5,a0
 190:	1602                	slli	a2,a2,0x20
 192:	9201                	srli	a2,a2,0x20
 194:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 198:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 19c:	0785                	addi	a5,a5,1
 19e:	fee79de3          	bne	a5,a4,198 <memset+0x12>
  }
  return dst;
}
 1a2:	6422                	ld	s0,8(sp)
 1a4:	0141                	addi	sp,sp,16
 1a6:	8082                	ret

00000000000001a8 <strchr>:

char*
strchr(const char *s, char c)
{
 1a8:	1141                	addi	sp,sp,-16
 1aa:	e422                	sd	s0,8(sp)
 1ac:	0800                	addi	s0,sp,16
  for(; *s; s++)
 1ae:	00054783          	lbu	a5,0(a0)
 1b2:	cb99                	beqz	a5,1c8 <strchr+0x20>
    if(*s == c)
 1b4:	00f58763          	beq	a1,a5,1c2 <strchr+0x1a>
  for(; *s; s++)
 1b8:	0505                	addi	a0,a0,1
 1ba:	00054783          	lbu	a5,0(a0)
 1be:	fbfd                	bnez	a5,1b4 <strchr+0xc>
      return (char*)s;
  return 0;
 1c0:	4501                	li	a0,0
}
 1c2:	6422                	ld	s0,8(sp)
 1c4:	0141                	addi	sp,sp,16
 1c6:	8082                	ret
  return 0;
 1c8:	4501                	li	a0,0
 1ca:	bfe5                	j	1c2 <strchr+0x1a>

00000000000001cc <gets>:

char*
gets(char *buf, int max)
{
 1cc:	711d                	addi	sp,sp,-96
 1ce:	ec86                	sd	ra,88(sp)
 1d0:	e8a2                	sd	s0,80(sp)
 1d2:	e4a6                	sd	s1,72(sp)
 1d4:	e0ca                	sd	s2,64(sp)
 1d6:	fc4e                	sd	s3,56(sp)
 1d8:	f852                	sd	s4,48(sp)
 1da:	f456                	sd	s5,40(sp)
 1dc:	f05a                	sd	s6,32(sp)
 1de:	ec5e                	sd	s7,24(sp)
 1e0:	1080                	addi	s0,sp,96
 1e2:	8baa                	mv	s7,a0
 1e4:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1e6:	892a                	mv	s2,a0
 1e8:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1ea:	4aa9                	li	s5,10
 1ec:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 1ee:	89a6                	mv	s3,s1
 1f0:	2485                	addiw	s1,s1,1
 1f2:	0344d663          	bge	s1,s4,21e <gets+0x52>
    cc = read(0, &c, 1);
 1f6:	4605                	li	a2,1
 1f8:	faf40593          	addi	a1,s0,-81
 1fc:	4501                	li	a0,0
 1fe:	242000ef          	jal	440 <read>
    if(cc < 1)
 202:	00a05e63          	blez	a0,21e <gets+0x52>
    buf[i++] = c;
 206:	faf44783          	lbu	a5,-81(s0)
 20a:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 20e:	01578763          	beq	a5,s5,21c <gets+0x50>
 212:	0905                	addi	s2,s2,1
 214:	fd679de3          	bne	a5,s6,1ee <gets+0x22>
    buf[i++] = c;
 218:	89a6                	mv	s3,s1
 21a:	a011                	j	21e <gets+0x52>
 21c:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 21e:	99de                	add	s3,s3,s7
 220:	00098023          	sb	zero,0(s3)
  return buf;
}
 224:	855e                	mv	a0,s7
 226:	60e6                	ld	ra,88(sp)
 228:	6446                	ld	s0,80(sp)
 22a:	64a6                	ld	s1,72(sp)
 22c:	6906                	ld	s2,64(sp)
 22e:	79e2                	ld	s3,56(sp)
 230:	7a42                	ld	s4,48(sp)
 232:	7aa2                	ld	s5,40(sp)
 234:	7b02                	ld	s6,32(sp)
 236:	6be2                	ld	s7,24(sp)
 238:	6125                	addi	sp,sp,96
 23a:	8082                	ret

000000000000023c <stat>:

int
stat(const char *n, struct stat *st)
{
 23c:	1101                	addi	sp,sp,-32
 23e:	ec06                	sd	ra,24(sp)
 240:	e822                	sd	s0,16(sp)
 242:	e04a                	sd	s2,0(sp)
 244:	1000                	addi	s0,sp,32
 246:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 248:	4581                	li	a1,0
 24a:	21e000ef          	jal	468 <open>
  if(fd < 0)
 24e:	02054263          	bltz	a0,272 <stat+0x36>
 252:	e426                	sd	s1,8(sp)
 254:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 256:	85ca                	mv	a1,s2
 258:	228000ef          	jal	480 <fstat>
 25c:	892a                	mv	s2,a0
  close(fd);
 25e:	8526                	mv	a0,s1
 260:	1f0000ef          	jal	450 <close>
  return r;
 264:	64a2                	ld	s1,8(sp)
}
 266:	854a                	mv	a0,s2
 268:	60e2                	ld	ra,24(sp)
 26a:	6442                	ld	s0,16(sp)
 26c:	6902                	ld	s2,0(sp)
 26e:	6105                	addi	sp,sp,32
 270:	8082                	ret
    return -1;
 272:	597d                	li	s2,-1
 274:	bfcd                	j	266 <stat+0x2a>

0000000000000276 <atoi>:

int
atoi(const char *s)
{
 276:	1141                	addi	sp,sp,-16
 278:	e422                	sd	s0,8(sp)
 27a:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 27c:	00054683          	lbu	a3,0(a0)
 280:	fd06879b          	addiw	a5,a3,-48
 284:	0ff7f793          	zext.b	a5,a5
 288:	4625                	li	a2,9
 28a:	02f66863          	bltu	a2,a5,2ba <atoi+0x44>
 28e:	872a                	mv	a4,a0
  n = 0;
 290:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 292:	0705                	addi	a4,a4,1
 294:	0025179b          	slliw	a5,a0,0x2
 298:	9fa9                	addw	a5,a5,a0
 29a:	0017979b          	slliw	a5,a5,0x1
 29e:	9fb5                	addw	a5,a5,a3
 2a0:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 2a4:	00074683          	lbu	a3,0(a4)
 2a8:	fd06879b          	addiw	a5,a3,-48
 2ac:	0ff7f793          	zext.b	a5,a5
 2b0:	fef671e3          	bgeu	a2,a5,292 <atoi+0x1c>
  return n;
}
 2b4:	6422                	ld	s0,8(sp)
 2b6:	0141                	addi	sp,sp,16
 2b8:	8082                	ret
  n = 0;
 2ba:	4501                	li	a0,0
 2bc:	bfe5                	j	2b4 <atoi+0x3e>

00000000000002be <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2be:	1141                	addi	sp,sp,-16
 2c0:	e422                	sd	s0,8(sp)
 2c2:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 2c4:	02b57463          	bgeu	a0,a1,2ec <memmove+0x2e>
    while(n-- > 0)
 2c8:	00c05f63          	blez	a2,2e6 <memmove+0x28>
 2cc:	1602                	slli	a2,a2,0x20
 2ce:	9201                	srli	a2,a2,0x20
 2d0:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2d4:	872a                	mv	a4,a0
      *dst++ = *src++;
 2d6:	0585                	addi	a1,a1,1
 2d8:	0705                	addi	a4,a4,1
 2da:	fff5c683          	lbu	a3,-1(a1)
 2de:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2e2:	fef71ae3          	bne	a4,a5,2d6 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2e6:	6422                	ld	s0,8(sp)
 2e8:	0141                	addi	sp,sp,16
 2ea:	8082                	ret
    dst += n;
 2ec:	00c50733          	add	a4,a0,a2
    src += n;
 2f0:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2f2:	fec05ae3          	blez	a2,2e6 <memmove+0x28>
 2f6:	fff6079b          	addiw	a5,a2,-1
 2fa:	1782                	slli	a5,a5,0x20
 2fc:	9381                	srli	a5,a5,0x20
 2fe:	fff7c793          	not	a5,a5
 302:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 304:	15fd                	addi	a1,a1,-1
 306:	177d                	addi	a4,a4,-1
 308:	0005c683          	lbu	a3,0(a1)
 30c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 310:	fee79ae3          	bne	a5,a4,304 <memmove+0x46>
 314:	bfc9                	j	2e6 <memmove+0x28>

0000000000000316 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 316:	1141                	addi	sp,sp,-16
 318:	e422                	sd	s0,8(sp)
 31a:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 31c:	ca05                	beqz	a2,34c <memcmp+0x36>
 31e:	fff6069b          	addiw	a3,a2,-1
 322:	1682                	slli	a3,a3,0x20
 324:	9281                	srli	a3,a3,0x20
 326:	0685                	addi	a3,a3,1
 328:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 32a:	00054783          	lbu	a5,0(a0)
 32e:	0005c703          	lbu	a4,0(a1)
 332:	00e79863          	bne	a5,a4,342 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 336:	0505                	addi	a0,a0,1
    p2++;
 338:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 33a:	fed518e3          	bne	a0,a3,32a <memcmp+0x14>
  }
  return 0;
 33e:	4501                	li	a0,0
 340:	a019                	j	346 <memcmp+0x30>
      return *p1 - *p2;
 342:	40e7853b          	subw	a0,a5,a4
}
 346:	6422                	ld	s0,8(sp)
 348:	0141                	addi	sp,sp,16
 34a:	8082                	ret
  return 0;
 34c:	4501                	li	a0,0
 34e:	bfe5                	j	346 <memcmp+0x30>

0000000000000350 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 350:	1141                	addi	sp,sp,-16
 352:	e406                	sd	ra,8(sp)
 354:	e022                	sd	s0,0(sp)
 356:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 358:	f67ff0ef          	jal	2be <memmove>
}
 35c:	60a2                	ld	ra,8(sp)
 35e:	6402                	ld	s0,0(sp)
 360:	0141                	addi	sp,sp,16
 362:	8082                	ret

0000000000000364 <sbrk>:

char *
sbrk(int n) {
 364:	1141                	addi	sp,sp,-16
 366:	e406                	sd	ra,8(sp)
 368:	e022                	sd	s0,0(sp)
 36a:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 36c:	4585                	li	a1,1
 36e:	142000ef          	jal	4b0 <sys_sbrk>
}
 372:	60a2                	ld	ra,8(sp)
 374:	6402                	ld	s0,0(sp)
 376:	0141                	addi	sp,sp,16
 378:	8082                	ret

000000000000037a <sbrklazy>:

char *
sbrklazy(int n) {
 37a:	1141                	addi	sp,sp,-16
 37c:	e406                	sd	ra,8(sp)
 37e:	e022                	sd	s0,0(sp)
 380:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 382:	4589                	li	a1,2
 384:	12c000ef          	jal	4b0 <sys_sbrk>
}
 388:	60a2                	ld	ra,8(sp)
 38a:	6402                	ld	s0,0(sp)
 38c:	0141                	addi	sp,sp,16
 38e:	8082                	ret

0000000000000390 <thread_create>:
// thread_create allocates a page-sized stack, calls clone(fn, arg, stacktop).
// Returns the new thread's pid, or -1 on error.
// The stack is passed back via *stack so the caller can free it after join.
int
thread_create(void(*fn)(void*), void *arg, void **stack)
{
 390:	7179                	addi	sp,sp,-48
 392:	f406                	sd	ra,40(sp)
 394:	f022                	sd	s0,32(sp)
 396:	e84a                	sd	s2,16(sp)
 398:	e44e                	sd	s3,8(sp)
 39a:	e052                	sd	s4,0(sp)
 39c:	1800                	addi	s0,sp,48
 39e:	89aa                	mv	s3,a0
 3a0:	8a2e                	mv	s4,a1
 3a2:	8932                	mv	s2,a2
  char *s = malloc(PGSIZE);
 3a4:	6505                	lui	a0,0x1
 3a6:	5ea000ef          	jal	990 <malloc>
  if(s == 0)
 3aa:	cd0d                	beqz	a0,3e4 <thread_create+0x54>
 3ac:	ec26                	sd	s1,24(sp)
 3ae:	84aa                	mv	s1,a0
    return -1;
  *stack = s;
 3b0:	00a93023          	sd	a0,0(s2)
  // Stack grows downward- pass the top of the allocated region.
  int pid = clone(fn, arg, s + PGSIZE);
 3b4:	6605                	lui	a2,0x1
 3b6:	962a                	add	a2,a2,a0
 3b8:	85d2                	mv	a1,s4
 3ba:	854e                	mv	a0,s3
 3bc:	166000ef          	jal	522 <clone>
  if(pid < 0){
 3c0:	00054a63          	bltz	a0,3d4 <thread_create+0x44>
 3c4:	64e2                	ld	s1,24(sp)
    free(s);
    *stack = 0;
    return -1;
  }
  return pid;
}
 3c6:	70a2                	ld	ra,40(sp)
 3c8:	7402                	ld	s0,32(sp)
 3ca:	6942                	ld	s2,16(sp)
 3cc:	69a2                	ld	s3,8(sp)
 3ce:	6a02                	ld	s4,0(sp)
 3d0:	6145                	addi	sp,sp,48
 3d2:	8082                	ret
    free(s);
 3d4:	8526                	mv	a0,s1
 3d6:	538000ef          	jal	90e <free>
    *stack = 0;
 3da:	00093023          	sd	zero,0(s2)
    return -1;
 3de:	557d                	li	a0,-1
 3e0:	64e2                	ld	s1,24(sp)
 3e2:	b7d5                	j	3c6 <thread_create+0x36>
    return -1;
 3e4:	557d                	li	a0,-1
 3e6:	b7c5                	j	3c6 <thread_create+0x36>

00000000000003e8 <thread_join>:
// Wait for any child thread to exit.
// If stack is non-null, frees the memory pointed to by *stack and clears it.
// Returns the joined thread's pid, or -1 Son error.
int
thread_join(void **stack)
{
 3e8:	1101                	addi	sp,sp,-32
 3ea:	ec06                	sd	ra,24(sp)
 3ec:	e822                	sd	s0,16(sp)
 3ee:	e426                	sd	s1,8(sp)
 3f0:	e04a                	sd	s2,0(sp)
 3f2:	1000                	addi	s0,sp,32
 3f4:	84aa                	mv	s1,a0
  int pid = join();
 3f6:	134000ef          	jal	52a <join>
  if(pid < 0)
 3fa:	02054163          	bltz	a0,41c <thread_join+0x34>
 3fe:	892a                	mv	s2,a0
    return -1;
  if(stack && *stack){
 400:	c499                	beqz	s1,40e <thread_join+0x26>
 402:	6088                	ld	a0,0(s1)
 404:	c509                	beqz	a0,40e <thread_join+0x26>
    free(*stack);
 406:	508000ef          	jal	90e <free>
    *stack = 0;
 40a:	0004b023          	sd	zero,0(s1)
  }
  return pid;
}
 40e:	854a                	mv	a0,s2
 410:	60e2                	ld	ra,24(sp)
 412:	6442                	ld	s0,16(sp)
 414:	64a2                	ld	s1,8(sp)
 416:	6902                	ld	s2,0(sp)
 418:	6105                	addi	sp,sp,32
 41a:	8082                	ret
    return -1;
 41c:	597d                	li	s2,-1
 41e:	bfc5                	j	40e <thread_join+0x26>

0000000000000420 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 420:	4885                	li	a7,1
 ecall
 422:	00000073          	ecall
 ret
 426:	8082                	ret

0000000000000428 <exit>:
.global exit
exit:
 li a7, SYS_exit
 428:	4889                	li	a7,2
 ecall
 42a:	00000073          	ecall
 ret
 42e:	8082                	ret

0000000000000430 <wait>:
.global wait
wait:
 li a7, SYS_wait
 430:	488d                	li	a7,3
 ecall
 432:	00000073          	ecall
 ret
 436:	8082                	ret

0000000000000438 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 438:	4891                	li	a7,4
 ecall
 43a:	00000073          	ecall
 ret
 43e:	8082                	ret

0000000000000440 <read>:
.global read
read:
 li a7, SYS_read
 440:	4895                	li	a7,5
 ecall
 442:	00000073          	ecall
 ret
 446:	8082                	ret

0000000000000448 <write>:
.global write
write:
 li a7, SYS_write
 448:	48c1                	li	a7,16
 ecall
 44a:	00000073          	ecall
 ret
 44e:	8082                	ret

0000000000000450 <close>:
.global close
close:
 li a7, SYS_close
 450:	48d5                	li	a7,21
 ecall
 452:	00000073          	ecall
 ret
 456:	8082                	ret

0000000000000458 <kill>:
.global kill
kill:
 li a7, SYS_kill
 458:	4899                	li	a7,6
 ecall
 45a:	00000073          	ecall
 ret
 45e:	8082                	ret

0000000000000460 <exec>:
.global exec
exec:
 li a7, SYS_exec
 460:	489d                	li	a7,7
 ecall
 462:	00000073          	ecall
 ret
 466:	8082                	ret

0000000000000468 <open>:
.global open
open:
 li a7, SYS_open
 468:	48bd                	li	a7,15
 ecall
 46a:	00000073          	ecall
 ret
 46e:	8082                	ret

0000000000000470 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 470:	48c5                	li	a7,17
 ecall
 472:	00000073          	ecall
 ret
 476:	8082                	ret

0000000000000478 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 478:	48c9                	li	a7,18
 ecall
 47a:	00000073          	ecall
 ret
 47e:	8082                	ret

0000000000000480 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 480:	48a1                	li	a7,8
 ecall
 482:	00000073          	ecall
 ret
 486:	8082                	ret

0000000000000488 <link>:
.global link
link:
 li a7, SYS_link
 488:	48cd                	li	a7,19
 ecall
 48a:	00000073          	ecall
 ret
 48e:	8082                	ret

0000000000000490 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 490:	48d1                	li	a7,20
 ecall
 492:	00000073          	ecall
 ret
 496:	8082                	ret

0000000000000498 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 498:	48a5                	li	a7,9
 ecall
 49a:	00000073          	ecall
 ret
 49e:	8082                	ret

00000000000004a0 <dup>:
.global dup
dup:
 li a7, SYS_dup
 4a0:	48a9                	li	a7,10
 ecall
 4a2:	00000073          	ecall
 ret
 4a6:	8082                	ret

00000000000004a8 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 4a8:	48ad                	li	a7,11
 ecall
 4aa:	00000073          	ecall
 ret
 4ae:	8082                	ret

00000000000004b0 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 4b0:	48b1                	li	a7,12
 ecall
 4b2:	00000073          	ecall
 ret
 4b6:	8082                	ret

00000000000004b8 <pause>:
.global pause
pause:
 li a7, SYS_pause
 4b8:	48b5                	li	a7,13
 ecall
 4ba:	00000073          	ecall
 ret
 4be:	8082                	ret

00000000000004c0 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 4c0:	48b9                	li	a7,14
 ecall
 4c2:	00000073          	ecall
 ret
 4c6:	8082                	ret

00000000000004c8 <getppid>:
.global getppid
getppid:
 li a7, SYS_getppid
 4c8:	02100893          	li	a7,33
 ecall
 4cc:	00000073          	ecall
 ret
 4d0:	8082                	ret

00000000000004d2 <ps>:
.global ps
ps:
 li a7, SYS_ps
 4d2:	02200893          	li	a7,34
 ecall
 4d6:	00000073          	ecall
 ret
 4da:	8082                	ret

00000000000004dc <trace>:
.global trace
trace:
 li a7, SYS_trace
 4dc:	02300893          	li	a7,35
 ecall
 4e0:	00000073          	ecall
 ret
 4e4:	8082                	ret

00000000000004e6 <waitx>:
.global waitx
waitx:
 li a7, SYS_waitx
 4e6:	02400893          	li	a7,36
 ecall
 4ea:	00000073          	ecall
 ret
 4ee:	8082                	ret

00000000000004f0 <getcount>:
.global getcount
getcount:
 li a7, SYS_getcount
 4f0:	02500893          	li	a7,37
 ecall
 4f4:	00000073          	ecall
 ret
 4f8:	8082                	ret

00000000000004fa <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 4fa:	48d9                	li	a7,22
 ecall
 4fc:	00000073          	ecall
 ret
 500:	8082                	ret

0000000000000502 <lock_create>:
.global lock_create
lock_create:
 li a7, SYS_lock_create
 502:	48dd                	li	a7,23
 ecall
 504:	00000073          	ecall
 ret
 508:	8082                	ret

000000000000050a <lock_acquire>:
.global lock_acquire
lock_acquire:
 li a7, SYS_lock_acquire
 50a:	48e1                	li	a7,24
 ecall
 50c:	00000073          	ecall
 ret
 510:	8082                	ret

0000000000000512 <lock_release>:
.global lock_release
lock_release:
 li a7, SYS_lock_release
 512:	48e5                	li	a7,25
 ecall
 514:	00000073          	ecall
 ret
 518:	8082                	ret

000000000000051a <lock_destroy>:
.global lock_destroy
lock_destroy:
 li a7, SYS_lock_destroy
 51a:	48e9                	li	a7,26
 ecall
 51c:	00000073          	ecall
 ret
 520:	8082                	ret

0000000000000522 <clone>:
.global clone
clone:
 li a7, SYS_clone
 522:	48ed                	li	a7,27
 ecall
 524:	00000073          	ecall
 ret
 528:	8082                	ret

000000000000052a <join>:
.global join
join:
 li a7, SYS_join
 52a:	48f1                	li	a7,28
 ecall
 52c:	00000073          	ecall
 ret
 530:	8082                	ret

0000000000000532 <getprocessinfo>:
.global getprocessinfo
getprocessinfo:
 li a7, SYS_getprocessinfo
 532:	48f5                	li	a7,29
 ecall
 534:	00000073          	ecall
 ret
 538:	8082                	ret

000000000000053a <shmget>:
.global shmget
shmget:
 li a7, SYS_shmget
 53a:	48f9                	li	a7,30
 ecall
 53c:	00000073          	ecall
 ret
 540:	8082                	ret

0000000000000542 <shmattach>:
.global shmattach
shmattach:
 li a7, SYS_shmattach
 542:	48fd                	li	a7,31
 ecall
 544:	00000073          	ecall
 ret
 548:	8082                	ret

000000000000054a <shmdetach>:
.global shmdetach
shmdetach:
 li a7, SYS_shmdetach
 54a:	02000893          	li	a7,32
 ecall
 54e:	00000073          	ecall
 ret
 552:	8082                	ret

0000000000000554 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 554:	1101                	addi	sp,sp,-32
 556:	ec06                	sd	ra,24(sp)
 558:	e822                	sd	s0,16(sp)
 55a:	1000                	addi	s0,sp,32
 55c:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 560:	4605                	li	a2,1
 562:	fef40593          	addi	a1,s0,-17
 566:	ee3ff0ef          	jal	448 <write>
}
 56a:	60e2                	ld	ra,24(sp)
 56c:	6442                	ld	s0,16(sp)
 56e:	6105                	addi	sp,sp,32
 570:	8082                	ret

0000000000000572 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 572:	715d                	addi	sp,sp,-80
 574:	e486                	sd	ra,72(sp)
 576:	e0a2                	sd	s0,64(sp)
 578:	f84a                	sd	s2,48(sp)
 57a:	0880                	addi	s0,sp,80
 57c:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 57e:	c299                	beqz	a3,584 <printint+0x12>
 580:	0805c363          	bltz	a1,606 <printint+0x94>
  neg = 0;
 584:	4881                	li	a7,0
 586:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 58a:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 58c:	00000517          	auipc	a0,0x0
 590:	55450513          	addi	a0,a0,1364 # ae0 <digits>
 594:	883e                	mv	a6,a5
 596:	2785                	addiw	a5,a5,1
 598:	02c5f733          	remu	a4,a1,a2
 59c:	972a                	add	a4,a4,a0
 59e:	00074703          	lbu	a4,0(a4)
 5a2:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 5a6:	872e                	mv	a4,a1
 5a8:	02c5d5b3          	divu	a1,a1,a2
 5ac:	0685                	addi	a3,a3,1
 5ae:	fec773e3          	bgeu	a4,a2,594 <printint+0x22>
  if(neg)
 5b2:	00088b63          	beqz	a7,5c8 <printint+0x56>
    buf[i++] = '-';
 5b6:	fd078793          	addi	a5,a5,-48
 5ba:	97a2                	add	a5,a5,s0
 5bc:	02d00713          	li	a4,45
 5c0:	fee78423          	sb	a4,-24(a5)
 5c4:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
 5c8:	02f05a63          	blez	a5,5fc <printint+0x8a>
 5cc:	fc26                	sd	s1,56(sp)
 5ce:	f44e                	sd	s3,40(sp)
 5d0:	fb840713          	addi	a4,s0,-72
 5d4:	00f704b3          	add	s1,a4,a5
 5d8:	fff70993          	addi	s3,a4,-1
 5dc:	99be                	add	s3,s3,a5
 5de:	37fd                	addiw	a5,a5,-1
 5e0:	1782                	slli	a5,a5,0x20
 5e2:	9381                	srli	a5,a5,0x20
 5e4:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 5e8:	fff4c583          	lbu	a1,-1(s1)
 5ec:	854a                	mv	a0,s2
 5ee:	f67ff0ef          	jal	554 <putc>
  while(--i >= 0)
 5f2:	14fd                	addi	s1,s1,-1
 5f4:	ff349ae3          	bne	s1,s3,5e8 <printint+0x76>
 5f8:	74e2                	ld	s1,56(sp)
 5fa:	79a2                	ld	s3,40(sp)
}
 5fc:	60a6                	ld	ra,72(sp)
 5fe:	6406                	ld	s0,64(sp)
 600:	7942                	ld	s2,48(sp)
 602:	6161                	addi	sp,sp,80
 604:	8082                	ret
    x = -xx;
 606:	40b005b3          	neg	a1,a1
    neg = 1;
 60a:	4885                	li	a7,1
    x = -xx;
 60c:	bfad                	j	586 <printint+0x14>

000000000000060e <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 60e:	711d                	addi	sp,sp,-96
 610:	ec86                	sd	ra,88(sp)
 612:	e8a2                	sd	s0,80(sp)
 614:	e0ca                	sd	s2,64(sp)
 616:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 618:	0005c903          	lbu	s2,0(a1)
 61c:	28090663          	beqz	s2,8a8 <vprintf+0x29a>
 620:	e4a6                	sd	s1,72(sp)
 622:	fc4e                	sd	s3,56(sp)
 624:	f852                	sd	s4,48(sp)
 626:	f456                	sd	s5,40(sp)
 628:	f05a                	sd	s6,32(sp)
 62a:	ec5e                	sd	s7,24(sp)
 62c:	e862                	sd	s8,16(sp)
 62e:	e466                	sd	s9,8(sp)
 630:	8b2a                	mv	s6,a0
 632:	8a2e                	mv	s4,a1
 634:	8bb2                	mv	s7,a2
  state = 0;
 636:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 638:	4481                	li	s1,0
 63a:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 63c:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 640:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 644:	06c00c93          	li	s9,108
 648:	a005                	j	668 <vprintf+0x5a>
        putc(fd, c0);
 64a:	85ca                	mv	a1,s2
 64c:	855a                	mv	a0,s6
 64e:	f07ff0ef          	jal	554 <putc>
 652:	a019                	j	658 <vprintf+0x4a>
    } else if(state == '%'){
 654:	03598263          	beq	s3,s5,678 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 658:	2485                	addiw	s1,s1,1
 65a:	8726                	mv	a4,s1
 65c:	009a07b3          	add	a5,s4,s1
 660:	0007c903          	lbu	s2,0(a5)
 664:	22090a63          	beqz	s2,898 <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 668:	0009079b          	sext.w	a5,s2
    if(state == 0){
 66c:	fe0994e3          	bnez	s3,654 <vprintf+0x46>
      if(c0 == '%'){
 670:	fd579de3          	bne	a5,s5,64a <vprintf+0x3c>
        state = '%';
 674:	89be                	mv	s3,a5
 676:	b7cd                	j	658 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 678:	00ea06b3          	add	a3,s4,a4
 67c:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 680:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 682:	c681                	beqz	a3,68a <vprintf+0x7c>
 684:	9752                	add	a4,a4,s4
 686:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 68a:	05878363          	beq	a5,s8,6d0 <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 68e:	05978d63          	beq	a5,s9,6e8 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 692:	07500713          	li	a4,117
 696:	0ee78763          	beq	a5,a4,784 <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 69a:	07800713          	li	a4,120
 69e:	12e78963          	beq	a5,a4,7d0 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 6a2:	07000713          	li	a4,112
 6a6:	14e78e63          	beq	a5,a4,802 <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 6aa:	06300713          	li	a4,99
 6ae:	18e78e63          	beq	a5,a4,84a <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 6b2:	07300713          	li	a4,115
 6b6:	1ae78463          	beq	a5,a4,85e <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 6ba:	02500713          	li	a4,37
 6be:	04e79563          	bne	a5,a4,708 <vprintf+0xfa>
        putc(fd, '%');
 6c2:	02500593          	li	a1,37
 6c6:	855a                	mv	a0,s6
 6c8:	e8dff0ef          	jal	554 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 6cc:	4981                	li	s3,0
 6ce:	b769                	j	658 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 6d0:	008b8913          	addi	s2,s7,8
 6d4:	4685                	li	a3,1
 6d6:	4629                	li	a2,10
 6d8:	000ba583          	lw	a1,0(s7)
 6dc:	855a                	mv	a0,s6
 6de:	e95ff0ef          	jal	572 <printint>
 6e2:	8bca                	mv	s7,s2
      state = 0;
 6e4:	4981                	li	s3,0
 6e6:	bf8d                	j	658 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 6e8:	06400793          	li	a5,100
 6ec:	02f68963          	beq	a3,a5,71e <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 6f0:	06c00793          	li	a5,108
 6f4:	04f68263          	beq	a3,a5,738 <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 6f8:	07500793          	li	a5,117
 6fc:	0af68063          	beq	a3,a5,79c <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 700:	07800793          	li	a5,120
 704:	0ef68263          	beq	a3,a5,7e8 <vprintf+0x1da>
        putc(fd, '%');
 708:	02500593          	li	a1,37
 70c:	855a                	mv	a0,s6
 70e:	e47ff0ef          	jal	554 <putc>
        putc(fd, c0);
 712:	85ca                	mv	a1,s2
 714:	855a                	mv	a0,s6
 716:	e3fff0ef          	jal	554 <putc>
      state = 0;
 71a:	4981                	li	s3,0
 71c:	bf35                	j	658 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 71e:	008b8913          	addi	s2,s7,8
 722:	4685                	li	a3,1
 724:	4629                	li	a2,10
 726:	000bb583          	ld	a1,0(s7)
 72a:	855a                	mv	a0,s6
 72c:	e47ff0ef          	jal	572 <printint>
        i += 1;
 730:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 732:	8bca                	mv	s7,s2
      state = 0;
 734:	4981                	li	s3,0
        i += 1;
 736:	b70d                	j	658 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 738:	06400793          	li	a5,100
 73c:	02f60763          	beq	a2,a5,76a <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 740:	07500793          	li	a5,117
 744:	06f60963          	beq	a2,a5,7b6 <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 748:	07800793          	li	a5,120
 74c:	faf61ee3          	bne	a2,a5,708 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 750:	008b8913          	addi	s2,s7,8
 754:	4681                	li	a3,0
 756:	4641                	li	a2,16
 758:	000bb583          	ld	a1,0(s7)
 75c:	855a                	mv	a0,s6
 75e:	e15ff0ef          	jal	572 <printint>
        i += 2;
 762:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 764:	8bca                	mv	s7,s2
      state = 0;
 766:	4981                	li	s3,0
        i += 2;
 768:	bdc5                	j	658 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 76a:	008b8913          	addi	s2,s7,8
 76e:	4685                	li	a3,1
 770:	4629                	li	a2,10
 772:	000bb583          	ld	a1,0(s7)
 776:	855a                	mv	a0,s6
 778:	dfbff0ef          	jal	572 <printint>
        i += 2;
 77c:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 77e:	8bca                	mv	s7,s2
      state = 0;
 780:	4981                	li	s3,0
        i += 2;
 782:	bdd9                	j	658 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 784:	008b8913          	addi	s2,s7,8
 788:	4681                	li	a3,0
 78a:	4629                	li	a2,10
 78c:	000be583          	lwu	a1,0(s7)
 790:	855a                	mv	a0,s6
 792:	de1ff0ef          	jal	572 <printint>
 796:	8bca                	mv	s7,s2
      state = 0;
 798:	4981                	li	s3,0
 79a:	bd7d                	j	658 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 79c:	008b8913          	addi	s2,s7,8
 7a0:	4681                	li	a3,0
 7a2:	4629                	li	a2,10
 7a4:	000bb583          	ld	a1,0(s7)
 7a8:	855a                	mv	a0,s6
 7aa:	dc9ff0ef          	jal	572 <printint>
        i += 1;
 7ae:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 7b0:	8bca                	mv	s7,s2
      state = 0;
 7b2:	4981                	li	s3,0
        i += 1;
 7b4:	b555                	j	658 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 7b6:	008b8913          	addi	s2,s7,8
 7ba:	4681                	li	a3,0
 7bc:	4629                	li	a2,10
 7be:	000bb583          	ld	a1,0(s7)
 7c2:	855a                	mv	a0,s6
 7c4:	dafff0ef          	jal	572 <printint>
        i += 2;
 7c8:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 7ca:	8bca                	mv	s7,s2
      state = 0;
 7cc:	4981                	li	s3,0
        i += 2;
 7ce:	b569                	j	658 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 7d0:	008b8913          	addi	s2,s7,8
 7d4:	4681                	li	a3,0
 7d6:	4641                	li	a2,16
 7d8:	000be583          	lwu	a1,0(s7)
 7dc:	855a                	mv	a0,s6
 7de:	d95ff0ef          	jal	572 <printint>
 7e2:	8bca                	mv	s7,s2
      state = 0;
 7e4:	4981                	li	s3,0
 7e6:	bd8d                	j	658 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 7e8:	008b8913          	addi	s2,s7,8
 7ec:	4681                	li	a3,0
 7ee:	4641                	li	a2,16
 7f0:	000bb583          	ld	a1,0(s7)
 7f4:	855a                	mv	a0,s6
 7f6:	d7dff0ef          	jal	572 <printint>
        i += 1;
 7fa:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 7fc:	8bca                	mv	s7,s2
      state = 0;
 7fe:	4981                	li	s3,0
        i += 1;
 800:	bda1                	j	658 <vprintf+0x4a>
 802:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 804:	008b8d13          	addi	s10,s7,8
 808:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 80c:	03000593          	li	a1,48
 810:	855a                	mv	a0,s6
 812:	d43ff0ef          	jal	554 <putc>
  putc(fd, 'x');
 816:	07800593          	li	a1,120
 81a:	855a                	mv	a0,s6
 81c:	d39ff0ef          	jal	554 <putc>
 820:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 822:	00000b97          	auipc	s7,0x0
 826:	2beb8b93          	addi	s7,s7,702 # ae0 <digits>
 82a:	03c9d793          	srli	a5,s3,0x3c
 82e:	97de                	add	a5,a5,s7
 830:	0007c583          	lbu	a1,0(a5)
 834:	855a                	mv	a0,s6
 836:	d1fff0ef          	jal	554 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 83a:	0992                	slli	s3,s3,0x4
 83c:	397d                	addiw	s2,s2,-1
 83e:	fe0916e3          	bnez	s2,82a <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 842:	8bea                	mv	s7,s10
      state = 0;
 844:	4981                	li	s3,0
 846:	6d02                	ld	s10,0(sp)
 848:	bd01                	j	658 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 84a:	008b8913          	addi	s2,s7,8
 84e:	000bc583          	lbu	a1,0(s7)
 852:	855a                	mv	a0,s6
 854:	d01ff0ef          	jal	554 <putc>
 858:	8bca                	mv	s7,s2
      state = 0;
 85a:	4981                	li	s3,0
 85c:	bbf5                	j	658 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 85e:	008b8993          	addi	s3,s7,8
 862:	000bb903          	ld	s2,0(s7)
 866:	00090f63          	beqz	s2,884 <vprintf+0x276>
        for(; *s; s++)
 86a:	00094583          	lbu	a1,0(s2)
 86e:	c195                	beqz	a1,892 <vprintf+0x284>
          putc(fd, *s);
 870:	855a                	mv	a0,s6
 872:	ce3ff0ef          	jal	554 <putc>
        for(; *s; s++)
 876:	0905                	addi	s2,s2,1
 878:	00094583          	lbu	a1,0(s2)
 87c:	f9f5                	bnez	a1,870 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 87e:	8bce                	mv	s7,s3
      state = 0;
 880:	4981                	li	s3,0
 882:	bbd9                	j	658 <vprintf+0x4a>
          s = "(null)";
 884:	00000917          	auipc	s2,0x0
 888:	25490913          	addi	s2,s2,596 # ad8 <malloc+0x148>
        for(; *s; s++)
 88c:	02800593          	li	a1,40
 890:	b7c5                	j	870 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 892:	8bce                	mv	s7,s3
      state = 0;
 894:	4981                	li	s3,0
 896:	b3c9                	j	658 <vprintf+0x4a>
 898:	64a6                	ld	s1,72(sp)
 89a:	79e2                	ld	s3,56(sp)
 89c:	7a42                	ld	s4,48(sp)
 89e:	7aa2                	ld	s5,40(sp)
 8a0:	7b02                	ld	s6,32(sp)
 8a2:	6be2                	ld	s7,24(sp)
 8a4:	6c42                	ld	s8,16(sp)
 8a6:	6ca2                	ld	s9,8(sp)
    }
  }
}
 8a8:	60e6                	ld	ra,88(sp)
 8aa:	6446                	ld	s0,80(sp)
 8ac:	6906                	ld	s2,64(sp)
 8ae:	6125                	addi	sp,sp,96
 8b0:	8082                	ret

00000000000008b2 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 8b2:	715d                	addi	sp,sp,-80
 8b4:	ec06                	sd	ra,24(sp)
 8b6:	e822                	sd	s0,16(sp)
 8b8:	1000                	addi	s0,sp,32
 8ba:	e010                	sd	a2,0(s0)
 8bc:	e414                	sd	a3,8(s0)
 8be:	e818                	sd	a4,16(s0)
 8c0:	ec1c                	sd	a5,24(s0)
 8c2:	03043023          	sd	a6,32(s0)
 8c6:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 8ca:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 8ce:	8622                	mv	a2,s0
 8d0:	d3fff0ef          	jal	60e <vprintf>
}
 8d4:	60e2                	ld	ra,24(sp)
 8d6:	6442                	ld	s0,16(sp)
 8d8:	6161                	addi	sp,sp,80
 8da:	8082                	ret

00000000000008dc <printf>:

void
printf(const char *fmt, ...)
{
 8dc:	711d                	addi	sp,sp,-96
 8de:	ec06                	sd	ra,24(sp)
 8e0:	e822                	sd	s0,16(sp)
 8e2:	1000                	addi	s0,sp,32
 8e4:	e40c                	sd	a1,8(s0)
 8e6:	e810                	sd	a2,16(s0)
 8e8:	ec14                	sd	a3,24(s0)
 8ea:	f018                	sd	a4,32(s0)
 8ec:	f41c                	sd	a5,40(s0)
 8ee:	03043823          	sd	a6,48(s0)
 8f2:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 8f6:	00840613          	addi	a2,s0,8
 8fa:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 8fe:	85aa                	mv	a1,a0
 900:	4505                	li	a0,1
 902:	d0dff0ef          	jal	60e <vprintf>
}
 906:	60e2                	ld	ra,24(sp)
 908:	6442                	ld	s0,16(sp)
 90a:	6125                	addi	sp,sp,96
 90c:	8082                	ret

000000000000090e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 90e:	1141                	addi	sp,sp,-16
 910:	e422                	sd	s0,8(sp)
 912:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 914:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 918:	00000797          	auipc	a5,0x0
 91c:	6e87b783          	ld	a5,1768(a5) # 1000 <freep>
 920:	a02d                	j	94a <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 922:	4618                	lw	a4,8(a2)
 924:	9f2d                	addw	a4,a4,a1
 926:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 92a:	6398                	ld	a4,0(a5)
 92c:	6310                	ld	a2,0(a4)
 92e:	a83d                	j	96c <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 930:	ff852703          	lw	a4,-8(a0)
 934:	9f31                	addw	a4,a4,a2
 936:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 938:	ff053683          	ld	a3,-16(a0)
 93c:	a091                	j	980 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 93e:	6398                	ld	a4,0(a5)
 940:	00e7e463          	bltu	a5,a4,948 <free+0x3a>
 944:	00e6ea63          	bltu	a3,a4,958 <free+0x4a>
{
 948:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 94a:	fed7fae3          	bgeu	a5,a3,93e <free+0x30>
 94e:	6398                	ld	a4,0(a5)
 950:	00e6e463          	bltu	a3,a4,958 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 954:	fee7eae3          	bltu	a5,a4,948 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 958:	ff852583          	lw	a1,-8(a0)
 95c:	6390                	ld	a2,0(a5)
 95e:	02059813          	slli	a6,a1,0x20
 962:	01c85713          	srli	a4,a6,0x1c
 966:	9736                	add	a4,a4,a3
 968:	fae60de3          	beq	a2,a4,922 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 96c:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 970:	4790                	lw	a2,8(a5)
 972:	02061593          	slli	a1,a2,0x20
 976:	01c5d713          	srli	a4,a1,0x1c
 97a:	973e                	add	a4,a4,a5
 97c:	fae68ae3          	beq	a3,a4,930 <free+0x22>
    p->s.ptr = bp->s.ptr;
 980:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 982:	00000717          	auipc	a4,0x0
 986:	66f73f23          	sd	a5,1662(a4) # 1000 <freep>
}
 98a:	6422                	ld	s0,8(sp)
 98c:	0141                	addi	sp,sp,16
 98e:	8082                	ret

0000000000000990 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 990:	7139                	addi	sp,sp,-64
 992:	fc06                	sd	ra,56(sp)
 994:	f822                	sd	s0,48(sp)
 996:	f426                	sd	s1,40(sp)
 998:	ec4e                	sd	s3,24(sp)
 99a:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 99c:	02051493          	slli	s1,a0,0x20
 9a0:	9081                	srli	s1,s1,0x20
 9a2:	04bd                	addi	s1,s1,15
 9a4:	8091                	srli	s1,s1,0x4
 9a6:	0014899b          	addiw	s3,s1,1
 9aa:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 9ac:	00000517          	auipc	a0,0x0
 9b0:	65453503          	ld	a0,1620(a0) # 1000 <freep>
 9b4:	c915                	beqz	a0,9e8 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9b6:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9b8:	4798                	lw	a4,8(a5)
 9ba:	08977a63          	bgeu	a4,s1,a4e <malloc+0xbe>
 9be:	f04a                	sd	s2,32(sp)
 9c0:	e852                	sd	s4,16(sp)
 9c2:	e456                	sd	s5,8(sp)
 9c4:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 9c6:	8a4e                	mv	s4,s3
 9c8:	0009871b          	sext.w	a4,s3
 9cc:	6685                	lui	a3,0x1
 9ce:	00d77363          	bgeu	a4,a3,9d4 <malloc+0x44>
 9d2:	6a05                	lui	s4,0x1
 9d4:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 9d8:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9dc:	00000917          	auipc	s2,0x0
 9e0:	62490913          	addi	s2,s2,1572 # 1000 <freep>
  if(p == SBRK_ERROR)
 9e4:	5afd                	li	s5,-1
 9e6:	a081                	j	a26 <malloc+0x96>
 9e8:	f04a                	sd	s2,32(sp)
 9ea:	e852                	sd	s4,16(sp)
 9ec:	e456                	sd	s5,8(sp)
 9ee:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 9f0:	00001797          	auipc	a5,0x1
 9f4:	81878793          	addi	a5,a5,-2024 # 1208 <base>
 9f8:	00000717          	auipc	a4,0x0
 9fc:	60f73423          	sd	a5,1544(a4) # 1000 <freep>
 a00:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 a02:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 a06:	b7c1                	j	9c6 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 a08:	6398                	ld	a4,0(a5)
 a0a:	e118                	sd	a4,0(a0)
 a0c:	a8a9                	j	a66 <malloc+0xd6>
  hp->s.size = nu;
 a0e:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 a12:	0541                	addi	a0,a0,16
 a14:	efbff0ef          	jal	90e <free>
  return freep;
 a18:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 a1c:	c12d                	beqz	a0,a7e <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a1e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 a20:	4798                	lw	a4,8(a5)
 a22:	02977263          	bgeu	a4,s1,a46 <malloc+0xb6>
    if(p == freep)
 a26:	00093703          	ld	a4,0(s2)
 a2a:	853e                	mv	a0,a5
 a2c:	fef719e3          	bne	a4,a5,a1e <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 a30:	8552                	mv	a0,s4
 a32:	933ff0ef          	jal	364 <sbrk>
  if(p == SBRK_ERROR)
 a36:	fd551ce3          	bne	a0,s5,a0e <malloc+0x7e>
        return 0;
 a3a:	4501                	li	a0,0
 a3c:	7902                	ld	s2,32(sp)
 a3e:	6a42                	ld	s4,16(sp)
 a40:	6aa2                	ld	s5,8(sp)
 a42:	6b02                	ld	s6,0(sp)
 a44:	a03d                	j	a72 <malloc+0xe2>
 a46:	7902                	ld	s2,32(sp)
 a48:	6a42                	ld	s4,16(sp)
 a4a:	6aa2                	ld	s5,8(sp)
 a4c:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 a4e:	fae48de3          	beq	s1,a4,a08 <malloc+0x78>
        p->s.size -= nunits;
 a52:	4137073b          	subw	a4,a4,s3
 a56:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a58:	02071693          	slli	a3,a4,0x20
 a5c:	01c6d713          	srli	a4,a3,0x1c
 a60:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a62:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a66:	00000717          	auipc	a4,0x0
 a6a:	58a73d23          	sd	a0,1434(a4) # 1000 <freep>
      return (void*)(p + 1);
 a6e:	01078513          	addi	a0,a5,16
  }
}
 a72:	70e2                	ld	ra,56(sp)
 a74:	7442                	ld	s0,48(sp)
 a76:	74a2                	ld	s1,40(sp)
 a78:	69e2                	ld	s3,24(sp)
 a7a:	6121                	addi	sp,sp,64
 a7c:	8082                	ret
 a7e:	7902                	ld	s2,32(sp)
 a80:	6a42                	ld	s4,16(sp)
 a82:	6aa2                	ld	s5,8(sp)
 a84:	6b02                	ld	s6,0(sp)
 a86:	b7f5                	j	a72 <malloc+0xe2>
