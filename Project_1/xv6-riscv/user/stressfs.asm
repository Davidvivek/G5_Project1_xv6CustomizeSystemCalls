
user/_stressfs:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:
#include "kernel/fs.h"
#include "kernel/fcntl.h"

int
main(int argc, char *argv[])
{
   0:	dd010113          	addi	sp,sp,-560
   4:	22113423          	sd	ra,552(sp)
   8:	22813023          	sd	s0,544(sp)
   c:	20913c23          	sd	s1,536(sp)
  10:	21213823          	sd	s2,528(sp)
  14:	1c00                	addi	s0,sp,560
  int fd, i;
  char path[] = "stressfs0";
  16:	00001797          	auipc	a5,0x1
  1a:	a7a78793          	addi	a5,a5,-1414 # a90 <malloc+0x12c>
  1e:	6398                	ld	a4,0(a5)
  20:	fce43823          	sd	a4,-48(s0)
  24:	0087d783          	lhu	a5,8(a5)
  28:	fcf41c23          	sh	a5,-40(s0)
  char data[512];

  printf("stressfs starting\n");
  2c:	00001517          	auipc	a0,0x1
  30:	a3450513          	addi	a0,a0,-1484 # a60 <malloc+0xfc>
  34:	07d000ef          	jal	8b0 <printf>
  memset(data, 'a', sizeof(data));
  38:	20000613          	li	a2,512
  3c:	06100593          	li	a1,97
  40:	dd040513          	addi	a0,s0,-560
  44:	116000ef          	jal	15a <memset>

  for(i = 0; i < 4; i++)
  48:	4481                	li	s1,0
  4a:	4911                	li	s2,4
    if(fork() > 0)
  4c:	3a8000ef          	jal	3f4 <fork>
  50:	00a04563          	bgtz	a0,5a <main+0x5a>
  for(i = 0; i < 4; i++)
  54:	2485                	addiw	s1,s1,1
  56:	ff249be3          	bne	s1,s2,4c <main+0x4c>
      break;

  printf("write %d\n", i);
  5a:	85a6                	mv	a1,s1
  5c:	00001517          	auipc	a0,0x1
  60:	a1c50513          	addi	a0,a0,-1508 # a78 <malloc+0x114>
  64:	04d000ef          	jal	8b0 <printf>

  path[8] += i;
  68:	fd844783          	lbu	a5,-40(s0)
  6c:	9fa5                	addw	a5,a5,s1
  6e:	fcf40c23          	sb	a5,-40(s0)
  fd = open(path, O_CREATE | O_RDWR);
  72:	20200593          	li	a1,514
  76:	fd040513          	addi	a0,s0,-48
  7a:	3c2000ef          	jal	43c <open>
  7e:	892a                	mv	s2,a0
  80:	44d1                	li	s1,20
  for(i = 0; i < 20; i++)
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  82:	20000613          	li	a2,512
  86:	dd040593          	addi	a1,s0,-560
  8a:	854a                	mv	a0,s2
  8c:	390000ef          	jal	41c <write>
  for(i = 0; i < 20; i++)
  90:	34fd                	addiw	s1,s1,-1
  92:	f8e5                	bnez	s1,82 <main+0x82>
  close(fd);
  94:	854a                	mv	a0,s2
  96:	38e000ef          	jal	424 <close>

  printf("read\n");
  9a:	00001517          	auipc	a0,0x1
  9e:	9ee50513          	addi	a0,a0,-1554 # a88 <malloc+0x124>
  a2:	00f000ef          	jal	8b0 <printf>

  fd = open(path, O_RDONLY);
  a6:	4581                	li	a1,0
  a8:	fd040513          	addi	a0,s0,-48
  ac:	390000ef          	jal	43c <open>
  b0:	892a                	mv	s2,a0
  b2:	44d1                	li	s1,20
  for (i = 0; i < 20; i++)
    read(fd, data, sizeof(data));
  b4:	20000613          	li	a2,512
  b8:	dd040593          	addi	a1,s0,-560
  bc:	854a                	mv	a0,s2
  be:	356000ef          	jal	414 <read>
  for (i = 0; i < 20; i++)
  c2:	34fd                	addiw	s1,s1,-1
  c4:	f8e5                	bnez	s1,b4 <main+0xb4>
  close(fd);
  c6:	854a                	mv	a0,s2
  c8:	35c000ef          	jal	424 <close>

  wait(0);
  cc:	4501                	li	a0,0
  ce:	336000ef          	jal	404 <wait>

  exit(0);
  d2:	4501                	li	a0,0
  d4:	328000ef          	jal	3fc <exit>

00000000000000d8 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
  d8:	1141                	addi	sp,sp,-16
  da:	e406                	sd	ra,8(sp)
  dc:	e022                	sd	s0,0(sp)
  de:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
  e0:	f21ff0ef          	jal	0 <main>
  exit(r);
  e4:	318000ef          	jal	3fc <exit>

00000000000000e8 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  e8:	1141                	addi	sp,sp,-16
  ea:	e422                	sd	s0,8(sp)
  ec:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  ee:	87aa                	mv	a5,a0
  f0:	0585                	addi	a1,a1,1
  f2:	0785                	addi	a5,a5,1
  f4:	fff5c703          	lbu	a4,-1(a1)
  f8:	fee78fa3          	sb	a4,-1(a5)
  fc:	fb75                	bnez	a4,f0 <strcpy+0x8>
    ;
  return os;
}
  fe:	6422                	ld	s0,8(sp)
 100:	0141                	addi	sp,sp,16
 102:	8082                	ret

0000000000000104 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 104:	1141                	addi	sp,sp,-16
 106:	e422                	sd	s0,8(sp)
 108:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 10a:	00054783          	lbu	a5,0(a0)
 10e:	cb91                	beqz	a5,122 <strcmp+0x1e>
 110:	0005c703          	lbu	a4,0(a1)
 114:	00f71763          	bne	a4,a5,122 <strcmp+0x1e>
    p++, q++;
 118:	0505                	addi	a0,a0,1
 11a:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 11c:	00054783          	lbu	a5,0(a0)
 120:	fbe5                	bnez	a5,110 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 122:	0005c503          	lbu	a0,0(a1)
}
 126:	40a7853b          	subw	a0,a5,a0
 12a:	6422                	ld	s0,8(sp)
 12c:	0141                	addi	sp,sp,16
 12e:	8082                	ret

0000000000000130 <strlen>:

uint
strlen(const char *s)
{
 130:	1141                	addi	sp,sp,-16
 132:	e422                	sd	s0,8(sp)
 134:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 136:	00054783          	lbu	a5,0(a0)
 13a:	cf91                	beqz	a5,156 <strlen+0x26>
 13c:	0505                	addi	a0,a0,1
 13e:	87aa                	mv	a5,a0
 140:	86be                	mv	a3,a5
 142:	0785                	addi	a5,a5,1
 144:	fff7c703          	lbu	a4,-1(a5)
 148:	ff65                	bnez	a4,140 <strlen+0x10>
 14a:	40a6853b          	subw	a0,a3,a0
 14e:	2505                	addiw	a0,a0,1
    ;
  return n;
}
 150:	6422                	ld	s0,8(sp)
 152:	0141                	addi	sp,sp,16
 154:	8082                	ret
  for(n = 0; s[n]; n++)
 156:	4501                	li	a0,0
 158:	bfe5                	j	150 <strlen+0x20>

000000000000015a <memset>:

void*
memset(void *dst, int c, uint n)
{
 15a:	1141                	addi	sp,sp,-16
 15c:	e422                	sd	s0,8(sp)
 15e:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 160:	ca19                	beqz	a2,176 <memset+0x1c>
 162:	87aa                	mv	a5,a0
 164:	1602                	slli	a2,a2,0x20
 166:	9201                	srli	a2,a2,0x20
 168:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 16c:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 170:	0785                	addi	a5,a5,1
 172:	fee79de3          	bne	a5,a4,16c <memset+0x12>
  }
  return dst;
}
 176:	6422                	ld	s0,8(sp)
 178:	0141                	addi	sp,sp,16
 17a:	8082                	ret

000000000000017c <strchr>:

char*
strchr(const char *s, char c)
{
 17c:	1141                	addi	sp,sp,-16
 17e:	e422                	sd	s0,8(sp)
 180:	0800                	addi	s0,sp,16
  for(; *s; s++)
 182:	00054783          	lbu	a5,0(a0)
 186:	cb99                	beqz	a5,19c <strchr+0x20>
    if(*s == c)
 188:	00f58763          	beq	a1,a5,196 <strchr+0x1a>
  for(; *s; s++)
 18c:	0505                	addi	a0,a0,1
 18e:	00054783          	lbu	a5,0(a0)
 192:	fbfd                	bnez	a5,188 <strchr+0xc>
      return (char*)s;
  return 0;
 194:	4501                	li	a0,0
}
 196:	6422                	ld	s0,8(sp)
 198:	0141                	addi	sp,sp,16
 19a:	8082                	ret
  return 0;
 19c:	4501                	li	a0,0
 19e:	bfe5                	j	196 <strchr+0x1a>

00000000000001a0 <gets>:

char*
gets(char *buf, int max)
{
 1a0:	711d                	addi	sp,sp,-96
 1a2:	ec86                	sd	ra,88(sp)
 1a4:	e8a2                	sd	s0,80(sp)
 1a6:	e4a6                	sd	s1,72(sp)
 1a8:	e0ca                	sd	s2,64(sp)
 1aa:	fc4e                	sd	s3,56(sp)
 1ac:	f852                	sd	s4,48(sp)
 1ae:	f456                	sd	s5,40(sp)
 1b0:	f05a                	sd	s6,32(sp)
 1b2:	ec5e                	sd	s7,24(sp)
 1b4:	1080                	addi	s0,sp,96
 1b6:	8baa                	mv	s7,a0
 1b8:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1ba:	892a                	mv	s2,a0
 1bc:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 1be:	4aa9                	li	s5,10
 1c0:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 1c2:	89a6                	mv	s3,s1
 1c4:	2485                	addiw	s1,s1,1
 1c6:	0344d663          	bge	s1,s4,1f2 <gets+0x52>
    cc = read(0, &c, 1);
 1ca:	4605                	li	a2,1
 1cc:	faf40593          	addi	a1,s0,-81
 1d0:	4501                	li	a0,0
 1d2:	242000ef          	jal	414 <read>
    if(cc < 1)
 1d6:	00a05e63          	blez	a0,1f2 <gets+0x52>
    buf[i++] = c;
 1da:	faf44783          	lbu	a5,-81(s0)
 1de:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 1e2:	01578763          	beq	a5,s5,1f0 <gets+0x50>
 1e6:	0905                	addi	s2,s2,1
 1e8:	fd679de3          	bne	a5,s6,1c2 <gets+0x22>
    buf[i++] = c;
 1ec:	89a6                	mv	s3,s1
 1ee:	a011                	j	1f2 <gets+0x52>
 1f0:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 1f2:	99de                	add	s3,s3,s7
 1f4:	00098023          	sb	zero,0(s3)
  return buf;
}
 1f8:	855e                	mv	a0,s7
 1fa:	60e6                	ld	ra,88(sp)
 1fc:	6446                	ld	s0,80(sp)
 1fe:	64a6                	ld	s1,72(sp)
 200:	6906                	ld	s2,64(sp)
 202:	79e2                	ld	s3,56(sp)
 204:	7a42                	ld	s4,48(sp)
 206:	7aa2                	ld	s5,40(sp)
 208:	7b02                	ld	s6,32(sp)
 20a:	6be2                	ld	s7,24(sp)
 20c:	6125                	addi	sp,sp,96
 20e:	8082                	ret

0000000000000210 <stat>:

int
stat(const char *n, struct stat *st)
{
 210:	1101                	addi	sp,sp,-32
 212:	ec06                	sd	ra,24(sp)
 214:	e822                	sd	s0,16(sp)
 216:	e04a                	sd	s2,0(sp)
 218:	1000                	addi	s0,sp,32
 21a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 21c:	4581                	li	a1,0
 21e:	21e000ef          	jal	43c <open>
  if(fd < 0)
 222:	02054263          	bltz	a0,246 <stat+0x36>
 226:	e426                	sd	s1,8(sp)
 228:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 22a:	85ca                	mv	a1,s2
 22c:	228000ef          	jal	454 <fstat>
 230:	892a                	mv	s2,a0
  close(fd);
 232:	8526                	mv	a0,s1
 234:	1f0000ef          	jal	424 <close>
  return r;
 238:	64a2                	ld	s1,8(sp)
}
 23a:	854a                	mv	a0,s2
 23c:	60e2                	ld	ra,24(sp)
 23e:	6442                	ld	s0,16(sp)
 240:	6902                	ld	s2,0(sp)
 242:	6105                	addi	sp,sp,32
 244:	8082                	ret
    return -1;
 246:	597d                	li	s2,-1
 248:	bfcd                	j	23a <stat+0x2a>

000000000000024a <atoi>:

int
atoi(const char *s)
{
 24a:	1141                	addi	sp,sp,-16
 24c:	e422                	sd	s0,8(sp)
 24e:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 250:	00054683          	lbu	a3,0(a0)
 254:	fd06879b          	addiw	a5,a3,-48
 258:	0ff7f793          	zext.b	a5,a5
 25c:	4625                	li	a2,9
 25e:	02f66863          	bltu	a2,a5,28e <atoi+0x44>
 262:	872a                	mv	a4,a0
  n = 0;
 264:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 266:	0705                	addi	a4,a4,1
 268:	0025179b          	slliw	a5,a0,0x2
 26c:	9fa9                	addw	a5,a5,a0
 26e:	0017979b          	slliw	a5,a5,0x1
 272:	9fb5                	addw	a5,a5,a3
 274:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 278:	00074683          	lbu	a3,0(a4)
 27c:	fd06879b          	addiw	a5,a3,-48
 280:	0ff7f793          	zext.b	a5,a5
 284:	fef671e3          	bgeu	a2,a5,266 <atoi+0x1c>
  return n;
}
 288:	6422                	ld	s0,8(sp)
 28a:	0141                	addi	sp,sp,16
 28c:	8082                	ret
  n = 0;
 28e:	4501                	li	a0,0
 290:	bfe5                	j	288 <atoi+0x3e>

0000000000000292 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 292:	1141                	addi	sp,sp,-16
 294:	e422                	sd	s0,8(sp)
 296:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 298:	02b57463          	bgeu	a0,a1,2c0 <memmove+0x2e>
    while(n-- > 0)
 29c:	00c05f63          	blez	a2,2ba <memmove+0x28>
 2a0:	1602                	slli	a2,a2,0x20
 2a2:	9201                	srli	a2,a2,0x20
 2a4:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 2a8:	872a                	mv	a4,a0
      *dst++ = *src++;
 2aa:	0585                	addi	a1,a1,1
 2ac:	0705                	addi	a4,a4,1
 2ae:	fff5c683          	lbu	a3,-1(a1)
 2b2:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 2b6:	fef71ae3          	bne	a4,a5,2aa <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 2ba:	6422                	ld	s0,8(sp)
 2bc:	0141                	addi	sp,sp,16
 2be:	8082                	ret
    dst += n;
 2c0:	00c50733          	add	a4,a0,a2
    src += n;
 2c4:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 2c6:	fec05ae3          	blez	a2,2ba <memmove+0x28>
 2ca:	fff6079b          	addiw	a5,a2,-1
 2ce:	1782                	slli	a5,a5,0x20
 2d0:	9381                	srli	a5,a5,0x20
 2d2:	fff7c793          	not	a5,a5
 2d6:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 2d8:	15fd                	addi	a1,a1,-1
 2da:	177d                	addi	a4,a4,-1
 2dc:	0005c683          	lbu	a3,0(a1)
 2e0:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 2e4:	fee79ae3          	bne	a5,a4,2d8 <memmove+0x46>
 2e8:	bfc9                	j	2ba <memmove+0x28>

00000000000002ea <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 2ea:	1141                	addi	sp,sp,-16
 2ec:	e422                	sd	s0,8(sp)
 2ee:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 2f0:	ca05                	beqz	a2,320 <memcmp+0x36>
 2f2:	fff6069b          	addiw	a3,a2,-1
 2f6:	1682                	slli	a3,a3,0x20
 2f8:	9281                	srli	a3,a3,0x20
 2fa:	0685                	addi	a3,a3,1
 2fc:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2fe:	00054783          	lbu	a5,0(a0)
 302:	0005c703          	lbu	a4,0(a1)
 306:	00e79863          	bne	a5,a4,316 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 30a:	0505                	addi	a0,a0,1
    p2++;
 30c:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 30e:	fed518e3          	bne	a0,a3,2fe <memcmp+0x14>
  }
  return 0;
 312:	4501                	li	a0,0
 314:	a019                	j	31a <memcmp+0x30>
      return *p1 - *p2;
 316:	40e7853b          	subw	a0,a5,a4
}
 31a:	6422                	ld	s0,8(sp)
 31c:	0141                	addi	sp,sp,16
 31e:	8082                	ret
  return 0;
 320:	4501                	li	a0,0
 322:	bfe5                	j	31a <memcmp+0x30>

0000000000000324 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 324:	1141                	addi	sp,sp,-16
 326:	e406                	sd	ra,8(sp)
 328:	e022                	sd	s0,0(sp)
 32a:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 32c:	f67ff0ef          	jal	292 <memmove>
}
 330:	60a2                	ld	ra,8(sp)
 332:	6402                	ld	s0,0(sp)
 334:	0141                	addi	sp,sp,16
 336:	8082                	ret

0000000000000338 <sbrk>:

char *
sbrk(int n) {
 338:	1141                	addi	sp,sp,-16
 33a:	e406                	sd	ra,8(sp)
 33c:	e022                	sd	s0,0(sp)
 33e:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 340:	4585                	li	a1,1
 342:	142000ef          	jal	484 <sys_sbrk>
}
 346:	60a2                	ld	ra,8(sp)
 348:	6402                	ld	s0,0(sp)
 34a:	0141                	addi	sp,sp,16
 34c:	8082                	ret

000000000000034e <sbrklazy>:

char *
sbrklazy(int n) {
 34e:	1141                	addi	sp,sp,-16
 350:	e406                	sd	ra,8(sp)
 352:	e022                	sd	s0,0(sp)
 354:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 356:	4589                	li	a1,2
 358:	12c000ef          	jal	484 <sys_sbrk>
}
 35c:	60a2                	ld	ra,8(sp)
 35e:	6402                	ld	s0,0(sp)
 360:	0141                	addi	sp,sp,16
 362:	8082                	ret

0000000000000364 <thread_create>:
// thread_create allocates a page-sized stack, calls clone(fn, arg, stacktop).
// Returns the new thread's pid, or -1 on error.
// The stack is passed back via *stack so the caller can free it after join.
int
thread_create(void(*fn)(void*), void *arg, void **stack)
{
 364:	7179                	addi	sp,sp,-48
 366:	f406                	sd	ra,40(sp)
 368:	f022                	sd	s0,32(sp)
 36a:	e84a                	sd	s2,16(sp)
 36c:	e44e                	sd	s3,8(sp)
 36e:	e052                	sd	s4,0(sp)
 370:	1800                	addi	s0,sp,48
 372:	89aa                	mv	s3,a0
 374:	8a2e                	mv	s4,a1
 376:	8932                	mv	s2,a2
  char *s = malloc(PGSIZE);
 378:	6505                	lui	a0,0x1
 37a:	5ea000ef          	jal	964 <malloc>
  if(s == 0)
 37e:	cd0d                	beqz	a0,3b8 <thread_create+0x54>
 380:	ec26                	sd	s1,24(sp)
 382:	84aa                	mv	s1,a0
    return -1;
  *stack = s;
 384:	00a93023          	sd	a0,0(s2)
  // Stack grows downward- pass the top of the allocated region.
  int pid = clone(fn, arg, s + PGSIZE);
 388:	6605                	lui	a2,0x1
 38a:	962a                	add	a2,a2,a0
 38c:	85d2                	mv	a1,s4
 38e:	854e                	mv	a0,s3
 390:	166000ef          	jal	4f6 <clone>
  if(pid < 0){
 394:	00054a63          	bltz	a0,3a8 <thread_create+0x44>
 398:	64e2                	ld	s1,24(sp)
    free(s);
    *stack = 0;
    return -1;
  }
  return pid;
}
 39a:	70a2                	ld	ra,40(sp)
 39c:	7402                	ld	s0,32(sp)
 39e:	6942                	ld	s2,16(sp)
 3a0:	69a2                	ld	s3,8(sp)
 3a2:	6a02                	ld	s4,0(sp)
 3a4:	6145                	addi	sp,sp,48
 3a6:	8082                	ret
    free(s);
 3a8:	8526                	mv	a0,s1
 3aa:	538000ef          	jal	8e2 <free>
    *stack = 0;
 3ae:	00093023          	sd	zero,0(s2)
    return -1;
 3b2:	557d                	li	a0,-1
 3b4:	64e2                	ld	s1,24(sp)
 3b6:	b7d5                	j	39a <thread_create+0x36>
    return -1;
 3b8:	557d                	li	a0,-1
 3ba:	b7c5                	j	39a <thread_create+0x36>

00000000000003bc <thread_join>:
// Wait for any child thread to exit.
// If stack is non-null, frees the memory pointed to by *stack and clears it.
// Returns the joined thread's pid, or -1 Son error.
int
thread_join(void **stack)
{
 3bc:	1101                	addi	sp,sp,-32
 3be:	ec06                	sd	ra,24(sp)
 3c0:	e822                	sd	s0,16(sp)
 3c2:	e426                	sd	s1,8(sp)
 3c4:	e04a                	sd	s2,0(sp)
 3c6:	1000                	addi	s0,sp,32
 3c8:	84aa                	mv	s1,a0
  int pid = join();
 3ca:	134000ef          	jal	4fe <join>
  if(pid < 0)
 3ce:	02054163          	bltz	a0,3f0 <thread_join+0x34>
 3d2:	892a                	mv	s2,a0
    return -1;
  if(stack && *stack){
 3d4:	c499                	beqz	s1,3e2 <thread_join+0x26>
 3d6:	6088                	ld	a0,0(s1)
 3d8:	c509                	beqz	a0,3e2 <thread_join+0x26>
    free(*stack);
 3da:	508000ef          	jal	8e2 <free>
    *stack = 0;
 3de:	0004b023          	sd	zero,0(s1)
  }
  return pid;
}
 3e2:	854a                	mv	a0,s2
 3e4:	60e2                	ld	ra,24(sp)
 3e6:	6442                	ld	s0,16(sp)
 3e8:	64a2                	ld	s1,8(sp)
 3ea:	6902                	ld	s2,0(sp)
 3ec:	6105                	addi	sp,sp,32
 3ee:	8082                	ret
    return -1;
 3f0:	597d                	li	s2,-1
 3f2:	bfc5                	j	3e2 <thread_join+0x26>

00000000000003f4 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 3f4:	4885                	li	a7,1
 ecall
 3f6:	00000073          	ecall
 ret
 3fa:	8082                	ret

00000000000003fc <exit>:
.global exit
exit:
 li a7, SYS_exit
 3fc:	4889                	li	a7,2
 ecall
 3fe:	00000073          	ecall
 ret
 402:	8082                	ret

0000000000000404 <wait>:
.global wait
wait:
 li a7, SYS_wait
 404:	488d                	li	a7,3
 ecall
 406:	00000073          	ecall
 ret
 40a:	8082                	ret

000000000000040c <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 40c:	4891                	li	a7,4
 ecall
 40e:	00000073          	ecall
 ret
 412:	8082                	ret

0000000000000414 <read>:
.global read
read:
 li a7, SYS_read
 414:	4895                	li	a7,5
 ecall
 416:	00000073          	ecall
 ret
 41a:	8082                	ret

000000000000041c <write>:
.global write
write:
 li a7, SYS_write
 41c:	48c1                	li	a7,16
 ecall
 41e:	00000073          	ecall
 ret
 422:	8082                	ret

0000000000000424 <close>:
.global close
close:
 li a7, SYS_close
 424:	48d5                	li	a7,21
 ecall
 426:	00000073          	ecall
 ret
 42a:	8082                	ret

000000000000042c <kill>:
.global kill
kill:
 li a7, SYS_kill
 42c:	4899                	li	a7,6
 ecall
 42e:	00000073          	ecall
 ret
 432:	8082                	ret

0000000000000434 <exec>:
.global exec
exec:
 li a7, SYS_exec
 434:	489d                	li	a7,7
 ecall
 436:	00000073          	ecall
 ret
 43a:	8082                	ret

000000000000043c <open>:
.global open
open:
 li a7, SYS_open
 43c:	48bd                	li	a7,15
 ecall
 43e:	00000073          	ecall
 ret
 442:	8082                	ret

0000000000000444 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 444:	48c5                	li	a7,17
 ecall
 446:	00000073          	ecall
 ret
 44a:	8082                	ret

000000000000044c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 44c:	48c9                	li	a7,18
 ecall
 44e:	00000073          	ecall
 ret
 452:	8082                	ret

0000000000000454 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 454:	48a1                	li	a7,8
 ecall
 456:	00000073          	ecall
 ret
 45a:	8082                	ret

000000000000045c <link>:
.global link
link:
 li a7, SYS_link
 45c:	48cd                	li	a7,19
 ecall
 45e:	00000073          	ecall
 ret
 462:	8082                	ret

0000000000000464 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 464:	48d1                	li	a7,20
 ecall
 466:	00000073          	ecall
 ret
 46a:	8082                	ret

000000000000046c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 46c:	48a5                	li	a7,9
 ecall
 46e:	00000073          	ecall
 ret
 472:	8082                	ret

0000000000000474 <dup>:
.global dup
dup:
 li a7, SYS_dup
 474:	48a9                	li	a7,10
 ecall
 476:	00000073          	ecall
 ret
 47a:	8082                	ret

000000000000047c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 47c:	48ad                	li	a7,11
 ecall
 47e:	00000073          	ecall
 ret
 482:	8082                	ret

0000000000000484 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 484:	48b1                	li	a7,12
 ecall
 486:	00000073          	ecall
 ret
 48a:	8082                	ret

000000000000048c <pause>:
.global pause
pause:
 li a7, SYS_pause
 48c:	48b5                	li	a7,13
 ecall
 48e:	00000073          	ecall
 ret
 492:	8082                	ret

0000000000000494 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 494:	48b9                	li	a7,14
 ecall
 496:	00000073          	ecall
 ret
 49a:	8082                	ret

000000000000049c <getppid>:
.global getppid
getppid:
 li a7, SYS_getppid
 49c:	02100893          	li	a7,33
 ecall
 4a0:	00000073          	ecall
 ret
 4a4:	8082                	ret

00000000000004a6 <ps>:
.global ps
ps:
 li a7, SYS_ps
 4a6:	02200893          	li	a7,34
 ecall
 4aa:	00000073          	ecall
 ret
 4ae:	8082                	ret

00000000000004b0 <trace>:
.global trace
trace:
 li a7, SYS_trace
 4b0:	02300893          	li	a7,35
 ecall
 4b4:	00000073          	ecall
 ret
 4b8:	8082                	ret

00000000000004ba <waitx>:
.global waitx
waitx:
 li a7, SYS_waitx
 4ba:	02400893          	li	a7,36
 ecall
 4be:	00000073          	ecall
 ret
 4c2:	8082                	ret

00000000000004c4 <getcount>:
.global getcount
getcount:
 li a7, SYS_getcount
 4c4:	02500893          	li	a7,37
 ecall
 4c8:	00000073          	ecall
 ret
 4cc:	8082                	ret

00000000000004ce <getcwd>:
.global getcwd
getcwd:
 li a7, SYS_getcwd
 4ce:	48d9                	li	a7,22
 ecall
 4d0:	00000073          	ecall
 ret
 4d4:	8082                	ret

00000000000004d6 <lock_create>:
.global lock_create
lock_create:
 li a7, SYS_lock_create
 4d6:	48dd                	li	a7,23
 ecall
 4d8:	00000073          	ecall
 ret
 4dc:	8082                	ret

00000000000004de <lock_acquire>:
.global lock_acquire
lock_acquire:
 li a7, SYS_lock_acquire
 4de:	48e1                	li	a7,24
 ecall
 4e0:	00000073          	ecall
 ret
 4e4:	8082                	ret

00000000000004e6 <lock_release>:
.global lock_release
lock_release:
 li a7, SYS_lock_release
 4e6:	48e5                	li	a7,25
 ecall
 4e8:	00000073          	ecall
 ret
 4ec:	8082                	ret

00000000000004ee <lock_destroy>:
.global lock_destroy
lock_destroy:
 li a7, SYS_lock_destroy
 4ee:	48e9                	li	a7,26
 ecall
 4f0:	00000073          	ecall
 ret
 4f4:	8082                	ret

00000000000004f6 <clone>:
.global clone
clone:
 li a7, SYS_clone
 4f6:	48ed                	li	a7,27
 ecall
 4f8:	00000073          	ecall
 ret
 4fc:	8082                	ret

00000000000004fe <join>:
.global join
join:
 li a7, SYS_join
 4fe:	48f1                	li	a7,28
 ecall
 500:	00000073          	ecall
 ret
 504:	8082                	ret

0000000000000506 <getprocessinfo>:
.global getprocessinfo
getprocessinfo:
 li a7, SYS_getprocessinfo
 506:	48f5                	li	a7,29
 ecall
 508:	00000073          	ecall
 ret
 50c:	8082                	ret

000000000000050e <shmget>:
.global shmget
shmget:
 li a7, SYS_shmget
 50e:	48f9                	li	a7,30
 ecall
 510:	00000073          	ecall
 ret
 514:	8082                	ret

0000000000000516 <shmattach>:
.global shmattach
shmattach:
 li a7, SYS_shmattach
 516:	48fd                	li	a7,31
 ecall
 518:	00000073          	ecall
 ret
 51c:	8082                	ret

000000000000051e <shmdetach>:
.global shmdetach
shmdetach:
 li a7, SYS_shmdetach
 51e:	02000893          	li	a7,32
 ecall
 522:	00000073          	ecall
 ret
 526:	8082                	ret

0000000000000528 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 528:	1101                	addi	sp,sp,-32
 52a:	ec06                	sd	ra,24(sp)
 52c:	e822                	sd	s0,16(sp)
 52e:	1000                	addi	s0,sp,32
 530:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 534:	4605                	li	a2,1
 536:	fef40593          	addi	a1,s0,-17
 53a:	ee3ff0ef          	jal	41c <write>
}
 53e:	60e2                	ld	ra,24(sp)
 540:	6442                	ld	s0,16(sp)
 542:	6105                	addi	sp,sp,32
 544:	8082                	ret

0000000000000546 <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 546:	715d                	addi	sp,sp,-80
 548:	e486                	sd	ra,72(sp)
 54a:	e0a2                	sd	s0,64(sp)
 54c:	f84a                	sd	s2,48(sp)
 54e:	0880                	addi	s0,sp,80
 550:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 552:	c299                	beqz	a3,558 <printint+0x12>
 554:	0805c363          	bltz	a1,5da <printint+0x94>
  neg = 0;
 558:	4881                	li	a7,0
 55a:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 55e:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 560:	00000517          	auipc	a0,0x0
 564:	54850513          	addi	a0,a0,1352 # aa8 <digits>
 568:	883e                	mv	a6,a5
 56a:	2785                	addiw	a5,a5,1
 56c:	02c5f733          	remu	a4,a1,a2
 570:	972a                	add	a4,a4,a0
 572:	00074703          	lbu	a4,0(a4)
 576:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 57a:	872e                	mv	a4,a1
 57c:	02c5d5b3          	divu	a1,a1,a2
 580:	0685                	addi	a3,a3,1
 582:	fec773e3          	bgeu	a4,a2,568 <printint+0x22>
  if(neg)
 586:	00088b63          	beqz	a7,59c <printint+0x56>
    buf[i++] = '-';
 58a:	fd078793          	addi	a5,a5,-48
 58e:	97a2                	add	a5,a5,s0
 590:	02d00713          	li	a4,45
 594:	fee78423          	sb	a4,-24(a5)
 598:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
 59c:	02f05a63          	blez	a5,5d0 <printint+0x8a>
 5a0:	fc26                	sd	s1,56(sp)
 5a2:	f44e                	sd	s3,40(sp)
 5a4:	fb840713          	addi	a4,s0,-72
 5a8:	00f704b3          	add	s1,a4,a5
 5ac:	fff70993          	addi	s3,a4,-1
 5b0:	99be                	add	s3,s3,a5
 5b2:	37fd                	addiw	a5,a5,-1
 5b4:	1782                	slli	a5,a5,0x20
 5b6:	9381                	srli	a5,a5,0x20
 5b8:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 5bc:	fff4c583          	lbu	a1,-1(s1)
 5c0:	854a                	mv	a0,s2
 5c2:	f67ff0ef          	jal	528 <putc>
  while(--i >= 0)
 5c6:	14fd                	addi	s1,s1,-1
 5c8:	ff349ae3          	bne	s1,s3,5bc <printint+0x76>
 5cc:	74e2                	ld	s1,56(sp)
 5ce:	79a2                	ld	s3,40(sp)
}
 5d0:	60a6                	ld	ra,72(sp)
 5d2:	6406                	ld	s0,64(sp)
 5d4:	7942                	ld	s2,48(sp)
 5d6:	6161                	addi	sp,sp,80
 5d8:	8082                	ret
    x = -xx;
 5da:	40b005b3          	neg	a1,a1
    neg = 1;
 5de:	4885                	li	a7,1
    x = -xx;
 5e0:	bfad                	j	55a <printint+0x14>

00000000000005e2 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 5e2:	711d                	addi	sp,sp,-96
 5e4:	ec86                	sd	ra,88(sp)
 5e6:	e8a2                	sd	s0,80(sp)
 5e8:	e0ca                	sd	s2,64(sp)
 5ea:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 5ec:	0005c903          	lbu	s2,0(a1)
 5f0:	28090663          	beqz	s2,87c <vprintf+0x29a>
 5f4:	e4a6                	sd	s1,72(sp)
 5f6:	fc4e                	sd	s3,56(sp)
 5f8:	f852                	sd	s4,48(sp)
 5fa:	f456                	sd	s5,40(sp)
 5fc:	f05a                	sd	s6,32(sp)
 5fe:	ec5e                	sd	s7,24(sp)
 600:	e862                	sd	s8,16(sp)
 602:	e466                	sd	s9,8(sp)
 604:	8b2a                	mv	s6,a0
 606:	8a2e                	mv	s4,a1
 608:	8bb2                	mv	s7,a2
  state = 0;
 60a:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 60c:	4481                	li	s1,0
 60e:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 610:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 614:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 618:	06c00c93          	li	s9,108
 61c:	a005                	j	63c <vprintf+0x5a>
        putc(fd, c0);
 61e:	85ca                	mv	a1,s2
 620:	855a                	mv	a0,s6
 622:	f07ff0ef          	jal	528 <putc>
 626:	a019                	j	62c <vprintf+0x4a>
    } else if(state == '%'){
 628:	03598263          	beq	s3,s5,64c <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 62c:	2485                	addiw	s1,s1,1
 62e:	8726                	mv	a4,s1
 630:	009a07b3          	add	a5,s4,s1
 634:	0007c903          	lbu	s2,0(a5)
 638:	22090a63          	beqz	s2,86c <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 63c:	0009079b          	sext.w	a5,s2
    if(state == 0){
 640:	fe0994e3          	bnez	s3,628 <vprintf+0x46>
      if(c0 == '%'){
 644:	fd579de3          	bne	a5,s5,61e <vprintf+0x3c>
        state = '%';
 648:	89be                	mv	s3,a5
 64a:	b7cd                	j	62c <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 64c:	00ea06b3          	add	a3,s4,a4
 650:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 654:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 656:	c681                	beqz	a3,65e <vprintf+0x7c>
 658:	9752                	add	a4,a4,s4
 65a:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 65e:	05878363          	beq	a5,s8,6a4 <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 662:	05978d63          	beq	a5,s9,6bc <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 666:	07500713          	li	a4,117
 66a:	0ee78763          	beq	a5,a4,758 <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 66e:	07800713          	li	a4,120
 672:	12e78963          	beq	a5,a4,7a4 <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 676:	07000713          	li	a4,112
 67a:	14e78e63          	beq	a5,a4,7d6 <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 67e:	06300713          	li	a4,99
 682:	18e78e63          	beq	a5,a4,81e <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 686:	07300713          	li	a4,115
 68a:	1ae78463          	beq	a5,a4,832 <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 68e:	02500713          	li	a4,37
 692:	04e79563          	bne	a5,a4,6dc <vprintf+0xfa>
        putc(fd, '%');
 696:	02500593          	li	a1,37
 69a:	855a                	mv	a0,s6
 69c:	e8dff0ef          	jal	528 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 6a0:	4981                	li	s3,0
 6a2:	b769                	j	62c <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 6a4:	008b8913          	addi	s2,s7,8
 6a8:	4685                	li	a3,1
 6aa:	4629                	li	a2,10
 6ac:	000ba583          	lw	a1,0(s7)
 6b0:	855a                	mv	a0,s6
 6b2:	e95ff0ef          	jal	546 <printint>
 6b6:	8bca                	mv	s7,s2
      state = 0;
 6b8:	4981                	li	s3,0
 6ba:	bf8d                	j	62c <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 6bc:	06400793          	li	a5,100
 6c0:	02f68963          	beq	a3,a5,6f2 <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 6c4:	06c00793          	li	a5,108
 6c8:	04f68263          	beq	a3,a5,70c <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 6cc:	07500793          	li	a5,117
 6d0:	0af68063          	beq	a3,a5,770 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 6d4:	07800793          	li	a5,120
 6d8:	0ef68263          	beq	a3,a5,7bc <vprintf+0x1da>
        putc(fd, '%');
 6dc:	02500593          	li	a1,37
 6e0:	855a                	mv	a0,s6
 6e2:	e47ff0ef          	jal	528 <putc>
        putc(fd, c0);
 6e6:	85ca                	mv	a1,s2
 6e8:	855a                	mv	a0,s6
 6ea:	e3fff0ef          	jal	528 <putc>
      state = 0;
 6ee:	4981                	li	s3,0
 6f0:	bf35                	j	62c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 6f2:	008b8913          	addi	s2,s7,8
 6f6:	4685                	li	a3,1
 6f8:	4629                	li	a2,10
 6fa:	000bb583          	ld	a1,0(s7)
 6fe:	855a                	mv	a0,s6
 700:	e47ff0ef          	jal	546 <printint>
        i += 1;
 704:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 706:	8bca                	mv	s7,s2
      state = 0;
 708:	4981                	li	s3,0
        i += 1;
 70a:	b70d                	j	62c <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 70c:	06400793          	li	a5,100
 710:	02f60763          	beq	a2,a5,73e <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 714:	07500793          	li	a5,117
 718:	06f60963          	beq	a2,a5,78a <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 71c:	07800793          	li	a5,120
 720:	faf61ee3          	bne	a2,a5,6dc <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 724:	008b8913          	addi	s2,s7,8
 728:	4681                	li	a3,0
 72a:	4641                	li	a2,16
 72c:	000bb583          	ld	a1,0(s7)
 730:	855a                	mv	a0,s6
 732:	e15ff0ef          	jal	546 <printint>
        i += 2;
 736:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 738:	8bca                	mv	s7,s2
      state = 0;
 73a:	4981                	li	s3,0
        i += 2;
 73c:	bdc5                	j	62c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 73e:	008b8913          	addi	s2,s7,8
 742:	4685                	li	a3,1
 744:	4629                	li	a2,10
 746:	000bb583          	ld	a1,0(s7)
 74a:	855a                	mv	a0,s6
 74c:	dfbff0ef          	jal	546 <printint>
        i += 2;
 750:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 752:	8bca                	mv	s7,s2
      state = 0;
 754:	4981                	li	s3,0
        i += 2;
 756:	bdd9                	j	62c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 758:	008b8913          	addi	s2,s7,8
 75c:	4681                	li	a3,0
 75e:	4629                	li	a2,10
 760:	000be583          	lwu	a1,0(s7)
 764:	855a                	mv	a0,s6
 766:	de1ff0ef          	jal	546 <printint>
 76a:	8bca                	mv	s7,s2
      state = 0;
 76c:	4981                	li	s3,0
 76e:	bd7d                	j	62c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 770:	008b8913          	addi	s2,s7,8
 774:	4681                	li	a3,0
 776:	4629                	li	a2,10
 778:	000bb583          	ld	a1,0(s7)
 77c:	855a                	mv	a0,s6
 77e:	dc9ff0ef          	jal	546 <printint>
        i += 1;
 782:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 784:	8bca                	mv	s7,s2
      state = 0;
 786:	4981                	li	s3,0
        i += 1;
 788:	b555                	j	62c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 78a:	008b8913          	addi	s2,s7,8
 78e:	4681                	li	a3,0
 790:	4629                	li	a2,10
 792:	000bb583          	ld	a1,0(s7)
 796:	855a                	mv	a0,s6
 798:	dafff0ef          	jal	546 <printint>
        i += 2;
 79c:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 79e:	8bca                	mv	s7,s2
      state = 0;
 7a0:	4981                	li	s3,0
        i += 2;
 7a2:	b569                	j	62c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 7a4:	008b8913          	addi	s2,s7,8
 7a8:	4681                	li	a3,0
 7aa:	4641                	li	a2,16
 7ac:	000be583          	lwu	a1,0(s7)
 7b0:	855a                	mv	a0,s6
 7b2:	d95ff0ef          	jal	546 <printint>
 7b6:	8bca                	mv	s7,s2
      state = 0;
 7b8:	4981                	li	s3,0
 7ba:	bd8d                	j	62c <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 7bc:	008b8913          	addi	s2,s7,8
 7c0:	4681                	li	a3,0
 7c2:	4641                	li	a2,16
 7c4:	000bb583          	ld	a1,0(s7)
 7c8:	855a                	mv	a0,s6
 7ca:	d7dff0ef          	jal	546 <printint>
        i += 1;
 7ce:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 7d0:	8bca                	mv	s7,s2
      state = 0;
 7d2:	4981                	li	s3,0
        i += 1;
 7d4:	bda1                	j	62c <vprintf+0x4a>
 7d6:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 7d8:	008b8d13          	addi	s10,s7,8
 7dc:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 7e0:	03000593          	li	a1,48
 7e4:	855a                	mv	a0,s6
 7e6:	d43ff0ef          	jal	528 <putc>
  putc(fd, 'x');
 7ea:	07800593          	li	a1,120
 7ee:	855a                	mv	a0,s6
 7f0:	d39ff0ef          	jal	528 <putc>
 7f4:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 7f6:	00000b97          	auipc	s7,0x0
 7fa:	2b2b8b93          	addi	s7,s7,690 # aa8 <digits>
 7fe:	03c9d793          	srli	a5,s3,0x3c
 802:	97de                	add	a5,a5,s7
 804:	0007c583          	lbu	a1,0(a5)
 808:	855a                	mv	a0,s6
 80a:	d1fff0ef          	jal	528 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 80e:	0992                	slli	s3,s3,0x4
 810:	397d                	addiw	s2,s2,-1
 812:	fe0916e3          	bnez	s2,7fe <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 816:	8bea                	mv	s7,s10
      state = 0;
 818:	4981                	li	s3,0
 81a:	6d02                	ld	s10,0(sp)
 81c:	bd01                	j	62c <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 81e:	008b8913          	addi	s2,s7,8
 822:	000bc583          	lbu	a1,0(s7)
 826:	855a                	mv	a0,s6
 828:	d01ff0ef          	jal	528 <putc>
 82c:	8bca                	mv	s7,s2
      state = 0;
 82e:	4981                	li	s3,0
 830:	bbf5                	j	62c <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 832:	008b8993          	addi	s3,s7,8
 836:	000bb903          	ld	s2,0(s7)
 83a:	00090f63          	beqz	s2,858 <vprintf+0x276>
        for(; *s; s++)
 83e:	00094583          	lbu	a1,0(s2)
 842:	c195                	beqz	a1,866 <vprintf+0x284>
          putc(fd, *s);
 844:	855a                	mv	a0,s6
 846:	ce3ff0ef          	jal	528 <putc>
        for(; *s; s++)
 84a:	0905                	addi	s2,s2,1
 84c:	00094583          	lbu	a1,0(s2)
 850:	f9f5                	bnez	a1,844 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 852:	8bce                	mv	s7,s3
      state = 0;
 854:	4981                	li	s3,0
 856:	bbd9                	j	62c <vprintf+0x4a>
          s = "(null)";
 858:	00000917          	auipc	s2,0x0
 85c:	24890913          	addi	s2,s2,584 # aa0 <malloc+0x13c>
        for(; *s; s++)
 860:	02800593          	li	a1,40
 864:	b7c5                	j	844 <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 866:	8bce                	mv	s7,s3
      state = 0;
 868:	4981                	li	s3,0
 86a:	b3c9                	j	62c <vprintf+0x4a>
 86c:	64a6                	ld	s1,72(sp)
 86e:	79e2                	ld	s3,56(sp)
 870:	7a42                	ld	s4,48(sp)
 872:	7aa2                	ld	s5,40(sp)
 874:	7b02                	ld	s6,32(sp)
 876:	6be2                	ld	s7,24(sp)
 878:	6c42                	ld	s8,16(sp)
 87a:	6ca2                	ld	s9,8(sp)
    }
  }
}
 87c:	60e6                	ld	ra,88(sp)
 87e:	6446                	ld	s0,80(sp)
 880:	6906                	ld	s2,64(sp)
 882:	6125                	addi	sp,sp,96
 884:	8082                	ret

0000000000000886 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 886:	715d                	addi	sp,sp,-80
 888:	ec06                	sd	ra,24(sp)
 88a:	e822                	sd	s0,16(sp)
 88c:	1000                	addi	s0,sp,32
 88e:	e010                	sd	a2,0(s0)
 890:	e414                	sd	a3,8(s0)
 892:	e818                	sd	a4,16(s0)
 894:	ec1c                	sd	a5,24(s0)
 896:	03043023          	sd	a6,32(s0)
 89a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 89e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 8a2:	8622                	mv	a2,s0
 8a4:	d3fff0ef          	jal	5e2 <vprintf>
}
 8a8:	60e2                	ld	ra,24(sp)
 8aa:	6442                	ld	s0,16(sp)
 8ac:	6161                	addi	sp,sp,80
 8ae:	8082                	ret

00000000000008b0 <printf>:

void
printf(const char *fmt, ...)
{
 8b0:	711d                	addi	sp,sp,-96
 8b2:	ec06                	sd	ra,24(sp)
 8b4:	e822                	sd	s0,16(sp)
 8b6:	1000                	addi	s0,sp,32
 8b8:	e40c                	sd	a1,8(s0)
 8ba:	e810                	sd	a2,16(s0)
 8bc:	ec14                	sd	a3,24(s0)
 8be:	f018                	sd	a4,32(s0)
 8c0:	f41c                	sd	a5,40(s0)
 8c2:	03043823          	sd	a6,48(s0)
 8c6:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 8ca:	00840613          	addi	a2,s0,8
 8ce:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 8d2:	85aa                	mv	a1,a0
 8d4:	4505                	li	a0,1
 8d6:	d0dff0ef          	jal	5e2 <vprintf>
}
 8da:	60e2                	ld	ra,24(sp)
 8dc:	6442                	ld	s0,16(sp)
 8de:	6125                	addi	sp,sp,96
 8e0:	8082                	ret

00000000000008e2 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8e2:	1141                	addi	sp,sp,-16
 8e4:	e422                	sd	s0,8(sp)
 8e6:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 8e8:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8ec:	00000797          	auipc	a5,0x0
 8f0:	7147b783          	ld	a5,1812(a5) # 1000 <freep>
 8f4:	a02d                	j	91e <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 8f6:	4618                	lw	a4,8(a2)
 8f8:	9f2d                	addw	a4,a4,a1
 8fa:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 8fe:	6398                	ld	a4,0(a5)
 900:	6310                	ld	a2,0(a4)
 902:	a83d                	j	940 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 904:	ff852703          	lw	a4,-8(a0)
 908:	9f31                	addw	a4,a4,a2
 90a:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 90c:	ff053683          	ld	a3,-16(a0)
 910:	a091                	j	954 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 912:	6398                	ld	a4,0(a5)
 914:	00e7e463          	bltu	a5,a4,91c <free+0x3a>
 918:	00e6ea63          	bltu	a3,a4,92c <free+0x4a>
{
 91c:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 91e:	fed7fae3          	bgeu	a5,a3,912 <free+0x30>
 922:	6398                	ld	a4,0(a5)
 924:	00e6e463          	bltu	a3,a4,92c <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 928:	fee7eae3          	bltu	a5,a4,91c <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 92c:	ff852583          	lw	a1,-8(a0)
 930:	6390                	ld	a2,0(a5)
 932:	02059813          	slli	a6,a1,0x20
 936:	01c85713          	srli	a4,a6,0x1c
 93a:	9736                	add	a4,a4,a3
 93c:	fae60de3          	beq	a2,a4,8f6 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 940:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 944:	4790                	lw	a2,8(a5)
 946:	02061593          	slli	a1,a2,0x20
 94a:	01c5d713          	srli	a4,a1,0x1c
 94e:	973e                	add	a4,a4,a5
 950:	fae68ae3          	beq	a3,a4,904 <free+0x22>
    p->s.ptr = bp->s.ptr;
 954:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 956:	00000717          	auipc	a4,0x0
 95a:	6af73523          	sd	a5,1706(a4) # 1000 <freep>
}
 95e:	6422                	ld	s0,8(sp)
 960:	0141                	addi	sp,sp,16
 962:	8082                	ret

0000000000000964 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 964:	7139                	addi	sp,sp,-64
 966:	fc06                	sd	ra,56(sp)
 968:	f822                	sd	s0,48(sp)
 96a:	f426                	sd	s1,40(sp)
 96c:	ec4e                	sd	s3,24(sp)
 96e:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 970:	02051493          	slli	s1,a0,0x20
 974:	9081                	srli	s1,s1,0x20
 976:	04bd                	addi	s1,s1,15
 978:	8091                	srli	s1,s1,0x4
 97a:	0014899b          	addiw	s3,s1,1
 97e:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 980:	00000517          	auipc	a0,0x0
 984:	68053503          	ld	a0,1664(a0) # 1000 <freep>
 988:	c915                	beqz	a0,9bc <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 98a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 98c:	4798                	lw	a4,8(a5)
 98e:	08977a63          	bgeu	a4,s1,a22 <malloc+0xbe>
 992:	f04a                	sd	s2,32(sp)
 994:	e852                	sd	s4,16(sp)
 996:	e456                	sd	s5,8(sp)
 998:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 99a:	8a4e                	mv	s4,s3
 99c:	0009871b          	sext.w	a4,s3
 9a0:	6685                	lui	a3,0x1
 9a2:	00d77363          	bgeu	a4,a3,9a8 <malloc+0x44>
 9a6:	6a05                	lui	s4,0x1
 9a8:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 9ac:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 9b0:	00000917          	auipc	s2,0x0
 9b4:	65090913          	addi	s2,s2,1616 # 1000 <freep>
  if(p == SBRK_ERROR)
 9b8:	5afd                	li	s5,-1
 9ba:	a081                	j	9fa <malloc+0x96>
 9bc:	f04a                	sd	s2,32(sp)
 9be:	e852                	sd	s4,16(sp)
 9c0:	e456                	sd	s5,8(sp)
 9c2:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 9c4:	00000797          	auipc	a5,0x0
 9c8:	64c78793          	addi	a5,a5,1612 # 1010 <base>
 9cc:	00000717          	auipc	a4,0x0
 9d0:	62f73a23          	sd	a5,1588(a4) # 1000 <freep>
 9d4:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 9d6:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 9da:	b7c1                	j	99a <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 9dc:	6398                	ld	a4,0(a5)
 9de:	e118                	sd	a4,0(a0)
 9e0:	a8a9                	j	a3a <malloc+0xd6>
  hp->s.size = nu;
 9e2:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 9e6:	0541                	addi	a0,a0,16
 9e8:	efbff0ef          	jal	8e2 <free>
  return freep;
 9ec:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 9f0:	c12d                	beqz	a0,a52 <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9f2:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 9f4:	4798                	lw	a4,8(a5)
 9f6:	02977263          	bgeu	a4,s1,a1a <malloc+0xb6>
    if(p == freep)
 9fa:	00093703          	ld	a4,0(s2)
 9fe:	853e                	mv	a0,a5
 a00:	fef719e3          	bne	a4,a5,9f2 <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 a04:	8552                	mv	a0,s4
 a06:	933ff0ef          	jal	338 <sbrk>
  if(p == SBRK_ERROR)
 a0a:	fd551ce3          	bne	a0,s5,9e2 <malloc+0x7e>
        return 0;
 a0e:	4501                	li	a0,0
 a10:	7902                	ld	s2,32(sp)
 a12:	6a42                	ld	s4,16(sp)
 a14:	6aa2                	ld	s5,8(sp)
 a16:	6b02                	ld	s6,0(sp)
 a18:	a03d                	j	a46 <malloc+0xe2>
 a1a:	7902                	ld	s2,32(sp)
 a1c:	6a42                	ld	s4,16(sp)
 a1e:	6aa2                	ld	s5,8(sp)
 a20:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 a22:	fae48de3          	beq	s1,a4,9dc <malloc+0x78>
        p->s.size -= nunits;
 a26:	4137073b          	subw	a4,a4,s3
 a2a:	c798                	sw	a4,8(a5)
        p += p->s.size;
 a2c:	02071693          	slli	a3,a4,0x20
 a30:	01c6d713          	srli	a4,a3,0x1c
 a34:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 a36:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 a3a:	00000717          	auipc	a4,0x0
 a3e:	5ca73323          	sd	a0,1478(a4) # 1000 <freep>
      return (void*)(p + 1);
 a42:	01078513          	addi	a0,a5,16
  }
}
 a46:	70e2                	ld	ra,56(sp)
 a48:	7442                	ld	s0,48(sp)
 a4a:	74a2                	ld	s1,40(sp)
 a4c:	69e2                	ld	s3,24(sp)
 a4e:	6121                	addi	sp,sp,64
 a50:	8082                	ret
 a52:	7902                	ld	s2,32(sp)
 a54:	6a42                	ld	s4,16(sp)
 a56:	6aa2                	ld	s5,8(sp)
 a58:	6b02                	ld	s6,0(sp)
 a5a:	b7f5                	j	a46 <malloc+0xe2>
