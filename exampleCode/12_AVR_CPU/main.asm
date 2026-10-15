
main.elf:     file format elf32-avr


Disassembly of section .text:

00000000 <__vectors>:
   0:	0c 94 34 00 	jmp	0x68	; 0x68 <__ctors_end>
   4:	0c 94 3e 00 	jmp	0x7c	; 0x7c <__bad_interrupt>
   8:	0c 94 3e 00 	jmp	0x7c	; 0x7c <__bad_interrupt>
   c:	0c 94 3e 00 	jmp	0x7c	; 0x7c <__bad_interrupt>
  10:	0c 94 3e 00 	jmp	0x7c	; 0x7c <__bad_interrupt>
  14:	0c 94 3e 00 	jmp	0x7c	; 0x7c <__bad_interrupt>
  18:	0c 94 3e 00 	jmp	0x7c	; 0x7c <__bad_interrupt>
  1c:	0c 94 3e 00 	jmp	0x7c	; 0x7c <__bad_interrupt>
  20:	0c 94 3e 00 	jmp	0x7c	; 0x7c <__bad_interrupt>
  24:	0c 94 3e 00 	jmp	0x7c	; 0x7c <__bad_interrupt>
  28:	0c 94 3e 00 	jmp	0x7c	; 0x7c <__bad_interrupt>
  2c:	0c 94 3e 00 	jmp	0x7c	; 0x7c <__bad_interrupt>
  30:	0c 94 3e 00 	jmp	0x7c	; 0x7c <__bad_interrupt>
  34:	0c 94 3e 00 	jmp	0x7c	; 0x7c <__bad_interrupt>
  38:	0c 94 3e 00 	jmp	0x7c	; 0x7c <__bad_interrupt>
  3c:	0c 94 3e 00 	jmp	0x7c	; 0x7c <__bad_interrupt>
  40:	0c 94 3e 00 	jmp	0x7c	; 0x7c <__bad_interrupt>
  44:	0c 94 3e 00 	jmp	0x7c	; 0x7c <__bad_interrupt>
  48:	0c 94 3e 00 	jmp	0x7c	; 0x7c <__bad_interrupt>
  4c:	0c 94 3e 00 	jmp	0x7c	; 0x7c <__bad_interrupt>
  50:	0c 94 3e 00 	jmp	0x7c	; 0x7c <__bad_interrupt>
  54:	0c 94 3e 00 	jmp	0x7c	; 0x7c <__bad_interrupt>
  58:	0c 94 3e 00 	jmp	0x7c	; 0x7c <__bad_interrupt>
  5c:	0c 94 3e 00 	jmp	0x7c	; 0x7c <__bad_interrupt>
  60:	0c 94 3e 00 	jmp	0x7c	; 0x7c <__bad_interrupt>
  64:	0c 94 3e 00 	jmp	0x7c	; 0x7c <__bad_interrupt>

00000068 <__ctors_end>:
  68:	11 24       	eor	r1, r1
  6a:	1f be       	out	0x3f, r1	; 63
  6c:	cf ef       	ldi	r28, 0xFF	; 255
  6e:	d8 e0       	ldi	r29, 0x08	; 8
  70:	de bf       	out	0x3e, r29	; 62
  72:	cd bf       	out	0x3d, r28	; 61
  74:	0e 94 40 00 	call	0x80	; 0x80 <main>
  78:	0c 94 0a 02 	jmp	0x414	; 0x414 <_exit>

0000007c <__bad_interrupt>:
  7c:	0c 94 00 00 	jmp	0	; 0x0 <__vectors>

00000080 <main>:
  80:	cf 93       	push	r28
  82:	df 93       	push	r29
  84:	cd b7       	in	r28, 0x3d	; 61
  86:	de b7       	in	r29, 0x3e	; 62
  88:	65 97       	sbiw	r28, 0x15	; 21
  8a:	de bf       	out	0x3e, r29	; 62
  8c:	cd bf       	out	0x3d, r28	; 61
  8e:	80 e2       	ldi	r24, 0x20	; 32
  90:	90 e1       	ldi	r25, 0x10	; 16
  92:	9c 83       	std	Y+4, r25	; 0x04
  94:	8b 83       	std	Y+3, r24	; 0x03
  96:	8f ef       	ldi	r24, 0xFF	; 255
  98:	8d 83       	std	Y+5, r24	; 0x05
  9a:	8d 81       	ldd	r24, Y+5	; 0x05
  9c:	48 2f       	mov	r20, r24
  9e:	88 0f       	add	r24, r24
  a0:	55 0b       	sbc	r21, r21
  a2:	2b 81       	ldd	r18, Y+3	; 0x03
  a4:	3c 81       	ldd	r19, Y+4	; 0x04
  a6:	42 9f       	mul	r20, r18
  a8:	c0 01       	movw	r24, r0
  aa:	43 9f       	mul	r20, r19
  ac:	90 0d       	add	r25, r0
  ae:	52 9f       	mul	r21, r18
  b0:	90 0d       	add	r25, r0
  b2:	11 24       	eor	r1, r1
  b4:	9f 83       	std	Y+7, r25	; 0x07
  b6:	8e 83       	std	Y+6, r24	; 0x06
  b8:	05 c0       	rjmp	.+10     	; 0xc4 <main+0x44>
  ba:	89 81       	ldd	r24, Y+1	; 0x01
  bc:	9a 81       	ldd	r25, Y+2	; 0x02
  be:	01 96       	adiw	r24, 0x01	; 1
  c0:	9a 83       	std	Y+2, r25	; 0x02
  c2:	89 83       	std	Y+1, r24	; 0x01
  c4:	29 81       	ldd	r18, Y+1	; 0x01
  c6:	3a 81       	ldd	r19, Y+2	; 0x02
  c8:	8e 81       	ldd	r24, Y+6	; 0x06
  ca:	9f 81       	ldd	r25, Y+7	; 0x07
  cc:	28 17       	cp	r18, r24
  ce:	39 07       	cpc	r19, r25
  d0:	a4 f3       	brlt	.-24     	; 0xba <main+0x3a>
  d2:	84 e2       	ldi	r24, 0x24	; 36
  d4:	90 e0       	ldi	r25, 0x00	; 0
  d6:	24 e2       	ldi	r18, 0x24	; 36
  d8:	30 e0       	ldi	r19, 0x00	; 0
  da:	f9 01       	movw	r30, r18
  dc:	20 81       	ld	r18, Z
  de:	21 60       	ori	r18, 0x01	; 1
  e0:	fc 01       	movw	r30, r24
  e2:	20 83       	st	Z, r18
  e4:	85 e2       	ldi	r24, 0x25	; 37
  e6:	90 e0       	ldi	r25, 0x00	; 0
  e8:	25 e2       	ldi	r18, 0x25	; 37
  ea:	30 e0       	ldi	r19, 0x00	; 0
  ec:	f9 01       	movw	r30, r18
  ee:	30 81       	ld	r19, Z
  f0:	21 e0       	ldi	r18, 0x01	; 1
  f2:	23 27       	eor	r18, r19
  f4:	fc 01       	movw	r30, r24
  f6:	20 83       	st	Z, r18
  f8:	80 e0       	ldi	r24, 0x00	; 0
  fa:	90 e0       	ldi	r25, 0x00	; 0
  fc:	ae e7       	ldi	r26, 0x7E	; 126
  fe:	b3 e4       	ldi	r27, 0x43	; 67
 100:	88 87       	std	Y+8, r24	; 0x08
 102:	99 87       	std	Y+9, r25	; 0x09
 104:	aa 87       	std	Y+10, r26	; 0x0a
 106:	bb 87       	std	Y+11, r27	; 0x0b
 108:	20 e0       	ldi	r18, 0x00	; 0
 10a:	30 e0       	ldi	r19, 0x00	; 0
 10c:	4a ef       	ldi	r20, 0xFA	; 250
 10e:	54 e4       	ldi	r21, 0x44	; 68
 110:	68 85       	ldd	r22, Y+8	; 0x08
 112:	79 85       	ldd	r23, Y+9	; 0x09
 114:	8a 85       	ldd	r24, Y+10	; 0x0a
 116:	9b 85       	ldd	r25, Y+11	; 0x0b
 118:	0e 94 75 01 	call	0x2ea	; 0x2ea <__mulsf3>
 11c:	dc 01       	movw	r26, r24
 11e:	cb 01       	movw	r24, r22
 120:	8c 87       	std	Y+12, r24	; 0x0c
 122:	9d 87       	std	Y+13, r25	; 0x0d
 124:	ae 87       	std	Y+14, r26	; 0x0e
 126:	bf 87       	std	Y+15, r27	; 0x0f
 128:	20 e0       	ldi	r18, 0x00	; 0
 12a:	30 e0       	ldi	r19, 0x00	; 0
 12c:	40 e8       	ldi	r20, 0x80	; 128
 12e:	5f e3       	ldi	r21, 0x3F	; 63
 130:	6c 85       	ldd	r22, Y+12	; 0x0c
 132:	7d 85       	ldd	r23, Y+13	; 0x0d
 134:	8e 85       	ldd	r24, Y+14	; 0x0e
 136:	9f 85       	ldd	r25, Y+15	; 0x0f
 138:	0e 94 ef 00 	call	0x1de	; 0x1de <__cmpsf2>
 13c:	88 23       	and	r24, r24
 13e:	2c f4       	brge	.+10     	; 0x14a <main+0xca>
 140:	81 e0       	ldi	r24, 0x01	; 1
 142:	90 e0       	ldi	r25, 0x00	; 0
 144:	99 8b       	std	Y+17, r25	; 0x11
 146:	88 8b       	std	Y+16, r24	; 0x10
 148:	3f c0       	rjmp	.+126    	; 0x1c8 <main+0x148>
 14a:	20 e0       	ldi	r18, 0x00	; 0
 14c:	3f ef       	ldi	r19, 0xFF	; 255
 14e:	4f e7       	ldi	r20, 0x7F	; 127
 150:	57 e4       	ldi	r21, 0x47	; 71
 152:	6c 85       	ldd	r22, Y+12	; 0x0c
 154:	7d 85       	ldd	r23, Y+13	; 0x0d
 156:	8e 85       	ldd	r24, Y+14	; 0x0e
 158:	9f 85       	ldd	r25, Y+15	; 0x0f
 15a:	0e 94 70 01 	call	0x2e0	; 0x2e0 <__gesf2>
 15e:	18 16       	cp	r1, r24
 160:	4c f5       	brge	.+82     	; 0x1b4 <main+0x134>
 162:	20 e0       	ldi	r18, 0x00	; 0
 164:	30 e0       	ldi	r19, 0x00	; 0
 166:	40 e2       	ldi	r20, 0x20	; 32
 168:	51 e4       	ldi	r21, 0x41	; 65
 16a:	68 85       	ldd	r22, Y+8	; 0x08
 16c:	79 85       	ldd	r23, Y+9	; 0x09
 16e:	8a 85       	ldd	r24, Y+10	; 0x0a
 170:	9b 85       	ldd	r25, Y+11	; 0x0b
 172:	0e 94 75 01 	call	0x2ea	; 0x2ea <__mulsf3>
 176:	dc 01       	movw	r26, r24
 178:	cb 01       	movw	r24, r22
 17a:	bc 01       	movw	r22, r24
 17c:	cd 01       	movw	r24, r26
 17e:	0e 94 f4 00 	call	0x1e8	; 0x1e8 <__fixunssfsi>
 182:	dc 01       	movw	r26, r24
 184:	cb 01       	movw	r24, r22
 186:	99 8b       	std	Y+17, r25	; 0x11
 188:	88 8b       	std	Y+16, r24	; 0x10
 18a:	0f c0       	rjmp	.+30     	; 0x1aa <main+0x12a>
 18c:	88 ec       	ldi	r24, 0xC8	; 200
 18e:	90 e0       	ldi	r25, 0x00	; 0
 190:	9b 8b       	std	Y+19, r25	; 0x13
 192:	8a 8b       	std	Y+18, r24	; 0x12
 194:	8a 89       	ldd	r24, Y+18	; 0x12
 196:	9b 89       	ldd	r25, Y+19	; 0x13
 198:	01 97       	sbiw	r24, 0x01	; 1
 19a:	f1 f7       	brne	.-4      	; 0x198 <main+0x118>
 19c:	9b 8b       	std	Y+19, r25	; 0x13
 19e:	8a 8b       	std	Y+18, r24	; 0x12
 1a0:	88 89       	ldd	r24, Y+16	; 0x10
 1a2:	99 89       	ldd	r25, Y+17	; 0x11
 1a4:	01 97       	sbiw	r24, 0x01	; 1
 1a6:	99 8b       	std	Y+17, r25	; 0x11
 1a8:	88 8b       	std	Y+16, r24	; 0x10
 1aa:	88 89       	ldd	r24, Y+16	; 0x10
 1ac:	99 89       	ldd	r25, Y+17	; 0x11
 1ae:	89 2b       	or	r24, r25
 1b0:	69 f7       	brne	.-38     	; 0x18c <main+0x10c>
 1b2:	14 c0       	rjmp	.+40     	; 0x1dc <main+0x15c>
 1b4:	6c 85       	ldd	r22, Y+12	; 0x0c
 1b6:	7d 85       	ldd	r23, Y+13	; 0x0d
 1b8:	8e 85       	ldd	r24, Y+14	; 0x0e
 1ba:	9f 85       	ldd	r25, Y+15	; 0x0f
 1bc:	0e 94 f4 00 	call	0x1e8	; 0x1e8 <__fixunssfsi>
 1c0:	dc 01       	movw	r26, r24
 1c2:	cb 01       	movw	r24, r22
 1c4:	99 8b       	std	Y+17, r25	; 0x11
 1c6:	88 8b       	std	Y+16, r24	; 0x10
 1c8:	88 89       	ldd	r24, Y+16	; 0x10
 1ca:	99 89       	ldd	r25, Y+17	; 0x11
 1cc:	9d 8b       	std	Y+21, r25	; 0x15
 1ce:	8c 8b       	std	Y+20, r24	; 0x14
 1d0:	8c 89       	ldd	r24, Y+20	; 0x14
 1d2:	9d 89       	ldd	r25, Y+21	; 0x15
 1d4:	01 97       	sbiw	r24, 0x01	; 1
 1d6:	f1 f7       	brne	.-4      	; 0x1d4 <main+0x154>
 1d8:	9d 8b       	std	Y+21, r25	; 0x15
 1da:	8c 8b       	std	Y+20, r24	; 0x14
 1dc:	83 cf       	rjmp	.-250    	; 0xe4 <main+0x64>

000001de <__cmpsf2>:
 1de:	0e 94 23 01 	call	0x246	; 0x246 <__fp_cmp>
 1e2:	08 f4       	brcc	.+2      	; 0x1e6 <__cmpsf2+0x8>
 1e4:	81 e0       	ldi	r24, 0x01	; 1
 1e6:	08 95       	ret

000001e8 <__fixunssfsi>:
 1e8:	0e 94 4f 01 	call	0x29e	; 0x29e <__fp_splitA>
 1ec:	88 f0       	brcs	.+34     	; 0x210 <__fixunssfsi+0x28>
 1ee:	9f 57       	subi	r25, 0x7F	; 127
 1f0:	98 f0       	brcs	.+38     	; 0x218 <__fixunssfsi+0x30>
 1f2:	b9 2f       	mov	r27, r25
 1f4:	99 27       	eor	r25, r25
 1f6:	b7 51       	subi	r27, 0x17	; 23
 1f8:	b0 f0       	brcs	.+44     	; 0x226 <__fixunssfsi+0x3e>
 1fa:	e1 f0       	breq	.+56     	; 0x234 <__fixunssfsi+0x4c>
 1fc:	66 0f       	add	r22, r22
 1fe:	77 1f       	adc	r23, r23
 200:	88 1f       	adc	r24, r24
 202:	99 1f       	adc	r25, r25
 204:	1a f0       	brmi	.+6      	; 0x20c <__fixunssfsi+0x24>
 206:	ba 95       	dec	r27
 208:	c9 f7       	brne	.-14     	; 0x1fc <__fixunssfsi+0x14>
 20a:	14 c0       	rjmp	.+40     	; 0x234 <__fixunssfsi+0x4c>
 20c:	b1 30       	cpi	r27, 0x01	; 1
 20e:	91 f0       	breq	.+36     	; 0x234 <__fixunssfsi+0x4c>
 210:	0e 94 69 01 	call	0x2d2	; 0x2d2 <__fp_zero>
 214:	b1 e0       	ldi	r27, 0x01	; 1
 216:	08 95       	ret
 218:	0c 94 69 01 	jmp	0x2d2	; 0x2d2 <__fp_zero>
 21c:	67 2f       	mov	r22, r23
 21e:	78 2f       	mov	r23, r24
 220:	88 27       	eor	r24, r24
 222:	b8 5f       	subi	r27, 0xF8	; 248
 224:	39 f0       	breq	.+14     	; 0x234 <__fixunssfsi+0x4c>
 226:	b9 3f       	cpi	r27, 0xF9	; 249
 228:	cc f3       	brlt	.-14     	; 0x21c <__fixunssfsi+0x34>
 22a:	86 95       	lsr	r24
 22c:	77 95       	ror	r23
 22e:	67 95       	ror	r22
 230:	b3 95       	inc	r27
 232:	d9 f7       	brne	.-10     	; 0x22a <__fixunssfsi+0x42>
 234:	3e f4       	brtc	.+14     	; 0x244 <__fixunssfsi+0x5c>
 236:	90 95       	com	r25
 238:	80 95       	com	r24
 23a:	70 95       	com	r23
 23c:	61 95       	neg	r22
 23e:	7f 4f       	sbci	r23, 0xFF	; 255
 240:	8f 4f       	sbci	r24, 0xFF	; 255
 242:	9f 4f       	sbci	r25, 0xFF	; 255
 244:	08 95       	ret

00000246 <__fp_cmp>:
 246:	99 0f       	add	r25, r25
 248:	00 08       	sbc	r0, r0
 24a:	55 0f       	add	r21, r21
 24c:	aa 0b       	sbc	r26, r26
 24e:	e0 e8       	ldi	r30, 0x80	; 128
 250:	fe ef       	ldi	r31, 0xFE	; 254
 252:	16 16       	cp	r1, r22
 254:	17 06       	cpc	r1, r23
 256:	e8 07       	cpc	r30, r24
 258:	f9 07       	cpc	r31, r25
 25a:	c0 f0       	brcs	.+48     	; 0x28c <__fp_cmp+0x46>
 25c:	12 16       	cp	r1, r18
 25e:	13 06       	cpc	r1, r19
 260:	e4 07       	cpc	r30, r20
 262:	f5 07       	cpc	r31, r21
 264:	98 f0       	brcs	.+38     	; 0x28c <__fp_cmp+0x46>
 266:	62 1b       	sub	r22, r18
 268:	73 0b       	sbc	r23, r19
 26a:	84 0b       	sbc	r24, r20
 26c:	95 0b       	sbc	r25, r21
 26e:	39 f4       	brne	.+14     	; 0x27e <__fp_cmp+0x38>
 270:	0a 26       	eor	r0, r26
 272:	61 f0       	breq	.+24     	; 0x28c <__fp_cmp+0x46>
 274:	23 2b       	or	r18, r19
 276:	24 2b       	or	r18, r20
 278:	25 2b       	or	r18, r21
 27a:	21 f4       	brne	.+8      	; 0x284 <__fp_cmp+0x3e>
 27c:	08 95       	ret
 27e:	0a 26       	eor	r0, r26
 280:	09 f4       	brne	.+2      	; 0x284 <__fp_cmp+0x3e>
 282:	a1 40       	sbci	r26, 0x01	; 1
 284:	a6 95       	lsr	r26
 286:	8f ef       	ldi	r24, 0xFF	; 255
 288:	81 1d       	adc	r24, r1
 28a:	81 1d       	adc	r24, r1
 28c:	08 95       	ret

0000028e <__fp_split3>:
 28e:	57 fd       	sbrc	r21, 7
 290:	90 58       	subi	r25, 0x80	; 128
 292:	44 0f       	add	r20, r20
 294:	55 1f       	adc	r21, r21
 296:	59 f0       	breq	.+22     	; 0x2ae <__fp_splitA+0x10>
 298:	5f 3f       	cpi	r21, 0xFF	; 255
 29a:	71 f0       	breq	.+28     	; 0x2b8 <__fp_splitA+0x1a>
 29c:	47 95       	ror	r20

0000029e <__fp_splitA>:
 29e:	88 0f       	add	r24, r24
 2a0:	97 fb       	bst	r25, 7
 2a2:	99 1f       	adc	r25, r25
 2a4:	61 f0       	breq	.+24     	; 0x2be <__fp_splitA+0x20>
 2a6:	9f 3f       	cpi	r25, 0xFF	; 255
 2a8:	79 f0       	breq	.+30     	; 0x2c8 <__fp_splitA+0x2a>
 2aa:	87 95       	ror	r24
 2ac:	08 95       	ret
 2ae:	12 16       	cp	r1, r18
 2b0:	13 06       	cpc	r1, r19
 2b2:	14 06       	cpc	r1, r20
 2b4:	55 1f       	adc	r21, r21
 2b6:	f2 cf       	rjmp	.-28     	; 0x29c <__fp_split3+0xe>
 2b8:	46 95       	lsr	r20
 2ba:	f1 df       	rcall	.-30     	; 0x29e <__fp_splitA>
 2bc:	08 c0       	rjmp	.+16     	; 0x2ce <__fp_splitA+0x30>
 2be:	16 16       	cp	r1, r22
 2c0:	17 06       	cpc	r1, r23
 2c2:	18 06       	cpc	r1, r24
 2c4:	99 1f       	adc	r25, r25
 2c6:	f1 cf       	rjmp	.-30     	; 0x2aa <__fp_splitA+0xc>
 2c8:	86 95       	lsr	r24
 2ca:	71 05       	cpc	r23, r1
 2cc:	61 05       	cpc	r22, r1
 2ce:	08 94       	sec
 2d0:	08 95       	ret

000002d2 <__fp_zero>:
 2d2:	e8 94       	clt

000002d4 <__fp_szero>:
 2d4:	bb 27       	eor	r27, r27
 2d6:	66 27       	eor	r22, r22
 2d8:	77 27       	eor	r23, r23
 2da:	cb 01       	movw	r24, r22
 2dc:	97 f9       	bld	r25, 7
 2de:	08 95       	ret

000002e0 <__gesf2>:
 2e0:	0e 94 23 01 	call	0x246	; 0x246 <__fp_cmp>
 2e4:	08 f4       	brcc	.+2      	; 0x2e8 <__gesf2+0x8>
 2e6:	8f ef       	ldi	r24, 0xFF	; 255
 2e8:	08 95       	ret

000002ea <__mulsf3>:
 2ea:	0e 94 88 01 	call	0x310	; 0x310 <__mulsf3x>
 2ee:	0c 94 f9 01 	jmp	0x3f2	; 0x3f2 <__fp_round>
 2f2:	0e 94 eb 01 	call	0x3d6	; 0x3d6 <__fp_pscA>
 2f6:	38 f0       	brcs	.+14     	; 0x306 <__mulsf3+0x1c>
 2f8:	0e 94 f2 01 	call	0x3e4	; 0x3e4 <__fp_pscB>
 2fc:	20 f0       	brcs	.+8      	; 0x306 <__mulsf3+0x1c>
 2fe:	95 23       	and	r25, r21
 300:	11 f0       	breq	.+4      	; 0x306 <__mulsf3+0x1c>
 302:	0c 94 e2 01 	jmp	0x3c4	; 0x3c4 <__fp_inf>
 306:	0c 94 e8 01 	jmp	0x3d0	; 0x3d0 <__fp_nan>
 30a:	11 24       	eor	r1, r1
 30c:	0c 94 6a 01 	jmp	0x2d4	; 0x2d4 <__fp_szero>

00000310 <__mulsf3x>:
 310:	0e 94 47 01 	call	0x28e	; 0x28e <__fp_split3>
 314:	70 f3       	brcs	.-36     	; 0x2f2 <__mulsf3+0x8>

00000316 <__mulsf3_pse>:
 316:	95 9f       	mul	r25, r21
 318:	c1 f3       	breq	.-16     	; 0x30a <__mulsf3+0x20>
 31a:	95 0f       	add	r25, r21
 31c:	50 e0       	ldi	r21, 0x00	; 0
 31e:	55 1f       	adc	r21, r21
 320:	62 9f       	mul	r22, r18
 322:	f0 01       	movw	r30, r0
 324:	72 9f       	mul	r23, r18
 326:	bb 27       	eor	r27, r27
 328:	f0 0d       	add	r31, r0
 32a:	b1 1d       	adc	r27, r1
 32c:	63 9f       	mul	r22, r19
 32e:	aa 27       	eor	r26, r26
 330:	f0 0d       	add	r31, r0
 332:	b1 1d       	adc	r27, r1
 334:	aa 1f       	adc	r26, r26
 336:	64 9f       	mul	r22, r20
 338:	66 27       	eor	r22, r22
 33a:	b0 0d       	add	r27, r0
 33c:	a1 1d       	adc	r26, r1
 33e:	66 1f       	adc	r22, r22
 340:	82 9f       	mul	r24, r18
 342:	22 27       	eor	r18, r18
 344:	b0 0d       	add	r27, r0
 346:	a1 1d       	adc	r26, r1
 348:	62 1f       	adc	r22, r18
 34a:	73 9f       	mul	r23, r19
 34c:	b0 0d       	add	r27, r0
 34e:	a1 1d       	adc	r26, r1
 350:	62 1f       	adc	r22, r18
 352:	83 9f       	mul	r24, r19
 354:	a0 0d       	add	r26, r0
 356:	61 1d       	adc	r22, r1
 358:	22 1f       	adc	r18, r18
 35a:	74 9f       	mul	r23, r20
 35c:	33 27       	eor	r19, r19
 35e:	a0 0d       	add	r26, r0
 360:	61 1d       	adc	r22, r1
 362:	23 1f       	adc	r18, r19
 364:	84 9f       	mul	r24, r20
 366:	60 0d       	add	r22, r0
 368:	21 1d       	adc	r18, r1
 36a:	82 2f       	mov	r24, r18
 36c:	76 2f       	mov	r23, r22
 36e:	6a 2f       	mov	r22, r26
 370:	11 24       	eor	r1, r1
 372:	9f 57       	subi	r25, 0x7F	; 127
 374:	50 40       	sbci	r21, 0x00	; 0
 376:	9a f0       	brmi	.+38     	; 0x39e <__mulsf3_pse+0x88>
 378:	f1 f0       	breq	.+60     	; 0x3b6 <__mulsf3_pse+0xa0>
 37a:	88 23       	and	r24, r24
 37c:	4a f0       	brmi	.+18     	; 0x390 <__mulsf3_pse+0x7a>
 37e:	ee 0f       	add	r30, r30
 380:	ff 1f       	adc	r31, r31
 382:	bb 1f       	adc	r27, r27
 384:	66 1f       	adc	r22, r22
 386:	77 1f       	adc	r23, r23
 388:	88 1f       	adc	r24, r24
 38a:	91 50       	subi	r25, 0x01	; 1
 38c:	50 40       	sbci	r21, 0x00	; 0
 38e:	a9 f7       	brne	.-22     	; 0x37a <__mulsf3_pse+0x64>
 390:	9e 3f       	cpi	r25, 0xFE	; 254
 392:	51 05       	cpc	r21, r1
 394:	80 f0       	brcs	.+32     	; 0x3b6 <__mulsf3_pse+0xa0>
 396:	0c 94 e2 01 	jmp	0x3c4	; 0x3c4 <__fp_inf>
 39a:	0c 94 6a 01 	jmp	0x2d4	; 0x2d4 <__fp_szero>
 39e:	5f 3f       	cpi	r21, 0xFF	; 255
 3a0:	e4 f3       	brlt	.-8      	; 0x39a <__mulsf3_pse+0x84>
 3a2:	98 3e       	cpi	r25, 0xE8	; 232
 3a4:	d4 f3       	brlt	.-12     	; 0x39a <__mulsf3_pse+0x84>
 3a6:	86 95       	lsr	r24
 3a8:	77 95       	ror	r23
 3aa:	67 95       	ror	r22
 3ac:	b7 95       	ror	r27
 3ae:	f7 95       	ror	r31
 3b0:	e7 95       	ror	r30
 3b2:	9f 5f       	subi	r25, 0xFF	; 255
 3b4:	c1 f7       	brne	.-16     	; 0x3a6 <__mulsf3_pse+0x90>
 3b6:	fe 2b       	or	r31, r30
 3b8:	88 0f       	add	r24, r24
 3ba:	91 1d       	adc	r25, r1
 3bc:	96 95       	lsr	r25
 3be:	87 95       	ror	r24
 3c0:	97 f9       	bld	r25, 7
 3c2:	08 95       	ret

000003c4 <__fp_inf>:
 3c4:	97 f9       	bld	r25, 7
 3c6:	9f 67       	ori	r25, 0x7F	; 127
 3c8:	80 e8       	ldi	r24, 0x80	; 128
 3ca:	70 e0       	ldi	r23, 0x00	; 0
 3cc:	60 e0       	ldi	r22, 0x00	; 0
 3ce:	08 95       	ret

000003d0 <__fp_nan>:
 3d0:	9f ef       	ldi	r25, 0xFF	; 255
 3d2:	80 ec       	ldi	r24, 0xC0	; 192
 3d4:	08 95       	ret

000003d6 <__fp_pscA>:
 3d6:	00 24       	eor	r0, r0
 3d8:	0a 94       	dec	r0
 3da:	16 16       	cp	r1, r22
 3dc:	17 06       	cpc	r1, r23
 3de:	18 06       	cpc	r1, r24
 3e0:	09 06       	cpc	r0, r25
 3e2:	08 95       	ret

000003e4 <__fp_pscB>:
 3e4:	00 24       	eor	r0, r0
 3e6:	0a 94       	dec	r0
 3e8:	12 16       	cp	r1, r18
 3ea:	13 06       	cpc	r1, r19
 3ec:	14 06       	cpc	r1, r20
 3ee:	05 06       	cpc	r0, r21
 3f0:	08 95       	ret

000003f2 <__fp_round>:
 3f2:	09 2e       	mov	r0, r25
 3f4:	03 94       	inc	r0
 3f6:	00 0c       	add	r0, r0
 3f8:	11 f4       	brne	.+4      	; 0x3fe <__fp_round+0xc>
 3fa:	88 23       	and	r24, r24
 3fc:	52 f0       	brmi	.+20     	; 0x412 <__LOCK_REGION_LENGTH__+0x12>
 3fe:	bb 0f       	add	r27, r27
 400:	40 f4       	brcc	.+16     	; 0x412 <__LOCK_REGION_LENGTH__+0x12>
 402:	bf 2b       	or	r27, r31
 404:	11 f4       	brne	.+4      	; 0x40a <__LOCK_REGION_LENGTH__+0xa>
 406:	60 ff       	sbrs	r22, 0
 408:	04 c0       	rjmp	.+8      	; 0x412 <__LOCK_REGION_LENGTH__+0x12>
 40a:	6f 5f       	subi	r22, 0xFF	; 255
 40c:	7f 4f       	sbci	r23, 0xFF	; 255
 40e:	8f 4f       	sbci	r24, 0xFF	; 255
 410:	9f 4f       	sbci	r25, 0xFF	; 255
 412:	08 95       	ret

00000414 <_exit>:
 414:	f8 94       	cli

00000416 <__stop_program>:
 416:	ff cf       	rjmp	.-2      	; 0x416 <__stop_program>
