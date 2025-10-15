
build/BlinkLEDs.elf:     file format elf32-avr


Disassembly of section .text:

00000000 <__vectors>:
   0:	0c 94 5d 00 	jmp	0xba	; 0xba <__ctors_end>
   4:	0c 94 85 00 	jmp	0x10a	; 0x10a <__bad_interrupt>
   8:	0c 94 85 00 	jmp	0x10a	; 0x10a <__bad_interrupt>
   c:	0c 94 85 00 	jmp	0x10a	; 0x10a <__bad_interrupt>
  10:	0c 94 85 00 	jmp	0x10a	; 0x10a <__bad_interrupt>
  14:	0c 94 85 00 	jmp	0x10a	; 0x10a <__bad_interrupt>
  18:	0c 94 85 00 	jmp	0x10a	; 0x10a <__bad_interrupt>
  1c:	0c 94 85 00 	jmp	0x10a	; 0x10a <__bad_interrupt>
  20:	0c 94 85 00 	jmp	0x10a	; 0x10a <__bad_interrupt>
  24:	0c 94 85 00 	jmp	0x10a	; 0x10a <__bad_interrupt>
  28:	0c 94 85 00 	jmp	0x10a	; 0x10a <__bad_interrupt>
  2c:	0c 94 85 00 	jmp	0x10a	; 0x10a <__bad_interrupt>
  30:	0c 94 85 00 	jmp	0x10a	; 0x10a <__bad_interrupt>
  34:	0c 94 85 00 	jmp	0x10a	; 0x10a <__bad_interrupt>
  38:	0c 94 85 00 	jmp	0x10a	; 0x10a <__bad_interrupt>
  3c:	0c 94 85 00 	jmp	0x10a	; 0x10a <__bad_interrupt>
  40:	0c 94 12 02 	jmp	0x424	; 0x424 <__vector_16>
  44:	0c 94 85 00 	jmp	0x10a	; 0x10a <__bad_interrupt>
  48:	0c 94 82 02 	jmp	0x504	; 0x504 <__vector_18>
  4c:	0c 94 5c 02 	jmp	0x4b8	; 0x4b8 <__vector_19>
  50:	0c 94 85 00 	jmp	0x10a	; 0x10a <__bad_interrupt>
  54:	0c 94 85 00 	jmp	0x10a	; 0x10a <__bad_interrupt>
  58:	0c 94 85 00 	jmp	0x10a	; 0x10a <__bad_interrupt>
  5c:	0c 94 85 00 	jmp	0x10a	; 0x10a <__bad_interrupt>
  60:	0c 94 85 00 	jmp	0x10a	; 0x10a <__bad_interrupt>
  64:	0c 94 85 00 	jmp	0x10a	; 0x10a <__bad_interrupt>

00000068 <__trampolines_end>:
  68:	00 00       	nop
  6a:	00 00       	nop
  6c:	24 00       	.word	0x0024	; ????
  6e:	27 00       	.word	0x0027	; ????
  70:	2a 00       	.word	0x002a	; ????

00000072 <port_to_output_PGM>:
  72:	00 00 00 00 25 00 28 00 2b 00                       ....%.(.+.

0000007c <digital_pin_to_port_PGM>:
  7c:	04 04 04 04 04 04 04 04 02 02 02 02 02 02 03 03     ................
  8c:	03 03 03 03                                         ....

00000090 <digital_pin_to_bit_mask_PGM>:
  90:	01 02 04 08 10 20 40 80 01 02 04 08 10 20 01 02     ..... @...... ..
  a0:	04 08 10 20                                         ... 

000000a4 <digital_pin_to_timer_PGM>:
  a4:	00 00 00 08 00 02 01 00 00 03 04 07 00 00 00 00     ................
  b4:	00 00 00 00                                         ....

000000b8 <__ctors_start>:
  b8:	f8 03       	fmulsu	r23, r16

000000ba <__ctors_end>:
  ba:	11 24       	eor	r1, r1
  bc:	1f be       	out	0x3f, r1	; 63
  be:	cf ef       	ldi	r28, 0xFF	; 255
  c0:	d8 e0       	ldi	r29, 0x08	; 8
  c2:	de bf       	out	0x3e, r29	; 62
  c4:	cd bf       	out	0x3d, r28	; 61

000000c6 <__do_copy_data>:
  c6:	11 e0       	ldi	r17, 0x01	; 1
  c8:	a0 e0       	ldi	r26, 0x00	; 0
  ca:	b1 e0       	ldi	r27, 0x01	; 1
  cc:	ee e9       	ldi	r30, 0x9E	; 158
  ce:	f8 e0       	ldi	r31, 0x08	; 8
  d0:	02 c0       	rjmp	.+4      	; 0xd6 <__do_copy_data+0x10>
  d2:	05 90       	lpm	r0, Z+
  d4:	0d 92       	st	X+, r0
  d6:	a0 32       	cpi	r26, 0x20	; 32
  d8:	b1 07       	cpc	r27, r17
  da:	d9 f7       	brne	.-10     	; 0xd2 <__do_copy_data+0xc>

000000dc <__do_clear_bss>:
  dc:	21 e0       	ldi	r18, 0x01	; 1
  de:	a0 e2       	ldi	r26, 0x20	; 32
  e0:	b1 e0       	ldi	r27, 0x01	; 1
  e2:	01 c0       	rjmp	.+2      	; 0xe6 <.do_clear_bss_start>

000000e4 <.do_clear_bss_loop>:
  e4:	1d 92       	st	X+, r1

000000e6 <.do_clear_bss_start>:
  e6:	a8 3c       	cpi	r26, 0xC8	; 200
  e8:	b2 07       	cpc	r27, r18
  ea:	e1 f7       	brne	.-8      	; 0xe4 <.do_clear_bss_loop>

000000ec <__do_global_ctors>:
  ec:	10 e0       	ldi	r17, 0x00	; 0
  ee:	cd e5       	ldi	r28, 0x5D	; 93
  f0:	d0 e0       	ldi	r29, 0x00	; 0
  f2:	04 c0       	rjmp	.+8      	; 0xfc <__do_global_ctors+0x10>
  f4:	21 97       	sbiw	r28, 0x01	; 1
  f6:	fe 01       	movw	r30, r28
  f8:	0e 94 47 04 	call	0x88e	; 0x88e <__tablejump2__>
  fc:	cc 35       	cpi	r28, 0x5C	; 92
  fe:	d1 07       	cpc	r29, r17
 100:	c9 f7       	brne	.-14     	; 0xf4 <__do_global_ctors+0x8>
 102:	0e 94 b4 02 	call	0x568	; 0x568 <main>
 106:	0c 94 4d 04 	jmp	0x89a	; 0x89a <_exit>

0000010a <__bad_interrupt>:
 10a:	0c 94 00 00 	jmp	0	; 0x0 <__vectors>

0000010e <digitalWrite>:
 10e:	90 e0       	ldi	r25, 0x00	; 0
 110:	fc 01       	movw	r30, r24
 112:	ec 55       	subi	r30, 0x5C	; 92
 114:	ff 4f       	sbci	r31, 0xFF	; 255
 116:	24 91       	lpm	r18, Z
 118:	fc 01       	movw	r30, r24
 11a:	e0 57       	subi	r30, 0x70	; 112
 11c:	ff 4f       	sbci	r31, 0xFF	; 255
 11e:	34 91       	lpm	r19, Z
 120:	fc 01       	movw	r30, r24
 122:	e4 58       	subi	r30, 0x84	; 132
 124:	ff 4f       	sbci	r31, 0xFF	; 255
 126:	e4 91       	lpm	r30, Z
 128:	ee 23       	and	r30, r30
 12a:	c9 f0       	breq	.+50     	; 0x15e <digitalWrite+0x50>
 12c:	22 23       	and	r18, r18
 12e:	39 f0       	breq	.+14     	; 0x13e <digitalWrite+0x30>
 130:	23 30       	cpi	r18, 0x03	; 3
 132:	01 f1       	breq	.+64     	; 0x174 <digitalWrite+0x66>
 134:	a8 f4       	brcc	.+42     	; 0x160 <digitalWrite+0x52>
 136:	21 30       	cpi	r18, 0x01	; 1
 138:	19 f1       	breq	.+70     	; 0x180 <digitalWrite+0x72>
 13a:	22 30       	cpi	r18, 0x02	; 2
 13c:	29 f1       	breq	.+74     	; 0x188 <digitalWrite+0x7a>
 13e:	f0 e0       	ldi	r31, 0x00	; 0
 140:	ee 0f       	add	r30, r30
 142:	ff 1f       	adc	r31, r31
 144:	ee 58       	subi	r30, 0x8E	; 142
 146:	ff 4f       	sbci	r31, 0xFF	; 255
 148:	a5 91       	lpm	r26, Z+
 14a:	b4 91       	lpm	r27, Z
 14c:	8f b7       	in	r24, 0x3f	; 63
 14e:	f8 94       	cli
 150:	ec 91       	ld	r30, X
 152:	61 11       	cpse	r22, r1
 154:	26 c0       	rjmp	.+76     	; 0x1a2 <digitalWrite+0x94>
 156:	30 95       	com	r19
 158:	3e 23       	and	r19, r30
 15a:	3c 93       	st	X, r19
 15c:	8f bf       	out	0x3f, r24	; 63
 15e:	08 95       	ret
 160:	27 30       	cpi	r18, 0x07	; 7
 162:	a9 f0       	breq	.+42     	; 0x18e <digitalWrite+0x80>
 164:	28 30       	cpi	r18, 0x08	; 8
 166:	c9 f0       	breq	.+50     	; 0x19a <digitalWrite+0x8c>
 168:	24 30       	cpi	r18, 0x04	; 4
 16a:	49 f7       	brne	.-46     	; 0x13e <digitalWrite+0x30>
 16c:	80 91 80 00 	lds	r24, 0x0080	; 0x800080 <__DATA_REGION_ORIGIN__+0x20>
 170:	8f 7d       	andi	r24, 0xDF	; 223
 172:	03 c0       	rjmp	.+6      	; 0x17a <digitalWrite+0x6c>
 174:	80 91 80 00 	lds	r24, 0x0080	; 0x800080 <__DATA_REGION_ORIGIN__+0x20>
 178:	8f 77       	andi	r24, 0x7F	; 127
 17a:	80 93 80 00 	sts	0x0080, r24	; 0x800080 <__DATA_REGION_ORIGIN__+0x20>
 17e:	df cf       	rjmp	.-66     	; 0x13e <digitalWrite+0x30>
 180:	84 b5       	in	r24, 0x24	; 36
 182:	8f 77       	andi	r24, 0x7F	; 127
 184:	84 bd       	out	0x24, r24	; 36
 186:	db cf       	rjmp	.-74     	; 0x13e <digitalWrite+0x30>
 188:	84 b5       	in	r24, 0x24	; 36
 18a:	8f 7d       	andi	r24, 0xDF	; 223
 18c:	fb cf       	rjmp	.-10     	; 0x184 <digitalWrite+0x76>
 18e:	80 91 b0 00 	lds	r24, 0x00B0	; 0x8000b0 <__DATA_REGION_ORIGIN__+0x50>
 192:	8f 77       	andi	r24, 0x7F	; 127
 194:	80 93 b0 00 	sts	0x00B0, r24	; 0x8000b0 <__DATA_REGION_ORIGIN__+0x50>
 198:	d2 cf       	rjmp	.-92     	; 0x13e <digitalWrite+0x30>
 19a:	80 91 b0 00 	lds	r24, 0x00B0	; 0x8000b0 <__DATA_REGION_ORIGIN__+0x50>
 19e:	8f 7d       	andi	r24, 0xDF	; 223
 1a0:	f9 cf       	rjmp	.-14     	; 0x194 <digitalWrite+0x86>
 1a2:	3e 2b       	or	r19, r30
 1a4:	da cf       	rjmp	.-76     	; 0x15a <digitalWrite+0x4c>

000001a6 <micros>:
 1a6:	3f b7       	in	r19, 0x3f	; 63
 1a8:	f8 94       	cli
 1aa:	80 91 27 01 	lds	r24, 0x0127	; 0x800127 <timer0_overflow_count>
 1ae:	90 91 28 01 	lds	r25, 0x0128	; 0x800128 <timer0_overflow_count+0x1>
 1b2:	a0 91 29 01 	lds	r26, 0x0129	; 0x800129 <timer0_overflow_count+0x2>
 1b6:	b0 91 2a 01 	lds	r27, 0x012A	; 0x80012a <timer0_overflow_count+0x3>
 1ba:	26 b5       	in	r18, 0x26	; 38
 1bc:	a8 9b       	sbis	0x15, 0	; 21
 1be:	05 c0       	rjmp	.+10     	; 0x1ca <micros+0x24>
 1c0:	2f 3f       	cpi	r18, 0xFF	; 255
 1c2:	19 f0       	breq	.+6      	; 0x1ca <micros+0x24>
 1c4:	01 96       	adiw	r24, 0x01	; 1
 1c6:	a1 1d       	adc	r26, r1
 1c8:	b1 1d       	adc	r27, r1
 1ca:	3f bf       	out	0x3f, r19	; 63
 1cc:	ba 2f       	mov	r27, r26
 1ce:	a9 2f       	mov	r26, r25
 1d0:	98 2f       	mov	r25, r24
 1d2:	88 27       	eor	r24, r24
 1d4:	bc 01       	movw	r22, r24
 1d6:	cd 01       	movw	r24, r26
 1d8:	62 0f       	add	r22, r18
 1da:	71 1d       	adc	r23, r1
 1dc:	81 1d       	adc	r24, r1
 1de:	91 1d       	adc	r25, r1
 1e0:	42 e0       	ldi	r20, 0x02	; 2
 1e2:	66 0f       	add	r22, r22
 1e4:	77 1f       	adc	r23, r23
 1e6:	88 1f       	adc	r24, r24
 1e8:	99 1f       	adc	r25, r25
 1ea:	4a 95       	dec	r20
 1ec:	d1 f7       	brne	.-12     	; 0x1e2 <micros+0x3c>
 1ee:	08 95       	ret

000001f0 <_ZN5Print5writeEPKhj>:
 1f0:	af 92       	push	r10
 1f2:	bf 92       	push	r11
 1f4:	cf 92       	push	r12
 1f6:	df 92       	push	r13
 1f8:	ef 92       	push	r14
 1fa:	ff 92       	push	r15
 1fc:	0f 93       	push	r16
 1fe:	1f 93       	push	r17
 200:	cf 93       	push	r28
 202:	df 93       	push	r29
 204:	6c 01       	movw	r12, r24
 206:	7b 01       	movw	r14, r22
 208:	8b 01       	movw	r16, r22
 20a:	04 0f       	add	r16, r20
 20c:	15 1f       	adc	r17, r21
 20e:	eb 01       	movw	r28, r22
 210:	5e 01       	movw	r10, r28
 212:	ae 18       	sub	r10, r14
 214:	bf 08       	sbc	r11, r15
 216:	c0 17       	cp	r28, r16
 218:	d1 07       	cpc	r29, r17
 21a:	59 f0       	breq	.+22     	; 0x232 <_ZN5Print5writeEPKhj+0x42>
 21c:	69 91       	ld	r22, Y+
 21e:	d6 01       	movw	r26, r12
 220:	ed 91       	ld	r30, X+
 222:	fc 91       	ld	r31, X
 224:	01 90       	ld	r0, Z+
 226:	f0 81       	ld	r31, Z
 228:	e0 2d       	mov	r30, r0
 22a:	c6 01       	movw	r24, r12
 22c:	09 95       	icall
 22e:	89 2b       	or	r24, r25
 230:	79 f7       	brne	.-34     	; 0x210 <_ZN5Print5writeEPKhj+0x20>
 232:	c5 01       	movw	r24, r10
 234:	df 91       	pop	r29
 236:	cf 91       	pop	r28
 238:	1f 91       	pop	r17
 23a:	0f 91       	pop	r16
 23c:	ff 90       	pop	r15
 23e:	ef 90       	pop	r14
 240:	df 90       	pop	r13
 242:	cf 90       	pop	r12
 244:	bf 90       	pop	r11
 246:	af 90       	pop	r10
 248:	08 95       	ret

0000024a <_ZN14HardwareSerial17availableForWriteEv>:
 24a:	fc 01       	movw	r30, r24
 24c:	53 8d       	ldd	r21, Z+27	; 0x1b
 24e:	44 8d       	ldd	r20, Z+28	; 0x1c
 250:	25 2f       	mov	r18, r21
 252:	30 e0       	ldi	r19, 0x00	; 0
 254:	84 2f       	mov	r24, r20
 256:	90 e0       	ldi	r25, 0x00	; 0
 258:	82 1b       	sub	r24, r18
 25a:	93 0b       	sbc	r25, r19
 25c:	54 17       	cp	r21, r20
 25e:	10 f0       	brcs	.+4      	; 0x264 <_ZN14HardwareSerial17availableForWriteEv+0x1a>
 260:	cf 96       	adiw	r24, 0x3f	; 63
 262:	08 95       	ret
 264:	01 97       	sbiw	r24, 0x01	; 1
 266:	08 95       	ret

00000268 <_ZN14HardwareSerial4readEv>:
 268:	fc 01       	movw	r30, r24
 26a:	91 8d       	ldd	r25, Z+25	; 0x19
 26c:	82 8d       	ldd	r24, Z+26	; 0x1a
 26e:	98 17       	cp	r25, r24
 270:	61 f0       	breq	.+24     	; 0x28a <_ZN14HardwareSerial4readEv+0x22>
 272:	a2 8d       	ldd	r26, Z+26	; 0x1a
 274:	ae 0f       	add	r26, r30
 276:	bf 2f       	mov	r27, r31
 278:	b1 1d       	adc	r27, r1
 27a:	5d 96       	adiw	r26, 0x1d	; 29
 27c:	8c 91       	ld	r24, X
 27e:	92 8d       	ldd	r25, Z+26	; 0x1a
 280:	9f 5f       	subi	r25, 0xFF	; 255
 282:	9f 73       	andi	r25, 0x3F	; 63
 284:	92 8f       	std	Z+26, r25	; 0x1a
 286:	90 e0       	ldi	r25, 0x00	; 0
 288:	08 95       	ret
 28a:	8f ef       	ldi	r24, 0xFF	; 255
 28c:	9f ef       	ldi	r25, 0xFF	; 255
 28e:	08 95       	ret

00000290 <_ZN14HardwareSerial4peekEv>:
 290:	fc 01       	movw	r30, r24
 292:	91 8d       	ldd	r25, Z+25	; 0x19
 294:	82 8d       	ldd	r24, Z+26	; 0x1a
 296:	98 17       	cp	r25, r24
 298:	31 f0       	breq	.+12     	; 0x2a6 <_ZN14HardwareSerial4peekEv+0x16>
 29a:	82 8d       	ldd	r24, Z+26	; 0x1a
 29c:	e8 0f       	add	r30, r24
 29e:	f1 1d       	adc	r31, r1
 2a0:	85 8d       	ldd	r24, Z+29	; 0x1d
 2a2:	90 e0       	ldi	r25, 0x00	; 0
 2a4:	08 95       	ret
 2a6:	8f ef       	ldi	r24, 0xFF	; 255
 2a8:	9f ef       	ldi	r25, 0xFF	; 255
 2aa:	08 95       	ret

000002ac <_ZN14HardwareSerial9availableEv>:
 2ac:	fc 01       	movw	r30, r24
 2ae:	91 8d       	ldd	r25, Z+25	; 0x19
 2b0:	22 8d       	ldd	r18, Z+26	; 0x1a
 2b2:	89 2f       	mov	r24, r25
 2b4:	90 e0       	ldi	r25, 0x00	; 0
 2b6:	80 5c       	subi	r24, 0xC0	; 192
 2b8:	9f 4f       	sbci	r25, 0xFF	; 255
 2ba:	82 1b       	sub	r24, r18
 2bc:	91 09       	sbc	r25, r1
 2be:	8f 73       	andi	r24, 0x3F	; 63
 2c0:	99 27       	eor	r25, r25
 2c2:	08 95       	ret

000002c4 <_Z17Serial0_availablev>:
 2c4:	8b e2       	ldi	r24, 0x2B	; 43
 2c6:	91 e0       	ldi	r25, 0x01	; 1
 2c8:	0e 94 56 01 	call	0x2ac	; 0x2ac <_ZN14HardwareSerial9availableEv>
 2cc:	21 e0       	ldi	r18, 0x01	; 1
 2ce:	89 2b       	or	r24, r25
 2d0:	09 f4       	brne	.+2      	; 0x2d4 <_Z17Serial0_availablev+0x10>
 2d2:	20 e0       	ldi	r18, 0x00	; 0
 2d4:	82 2f       	mov	r24, r18
 2d6:	08 95       	ret

000002d8 <_Z14serialEventRunv>:
 2d8:	80 e0       	ldi	r24, 0x00	; 0
 2da:	90 e0       	ldi	r25, 0x00	; 0
 2dc:	89 2b       	or	r24, r25
 2de:	29 f0       	breq	.+10     	; 0x2ea <_Z14serialEventRunv+0x12>
 2e0:	0e 94 62 01 	call	0x2c4	; 0x2c4 <_Z17Serial0_availablev>
 2e4:	81 11       	cpse	r24, r1
 2e6:	0c 94 00 00 	jmp	0	; 0x0 <__vectors>
 2ea:	08 95       	ret

000002ec <_ZN14HardwareSerial17_tx_udr_empty_irqEv>:
 2ec:	fc 01       	movw	r30, r24
 2ee:	a4 8d       	ldd	r26, Z+28	; 0x1c
 2f0:	a8 0f       	add	r26, r24
 2f2:	b9 2f       	mov	r27, r25
 2f4:	b1 1d       	adc	r27, r1
 2f6:	a3 5a       	subi	r26, 0xA3	; 163
 2f8:	bf 4f       	sbci	r27, 0xFF	; 255
 2fa:	2c 91       	ld	r18, X
 2fc:	84 8d       	ldd	r24, Z+28	; 0x1c
 2fe:	90 e0       	ldi	r25, 0x00	; 0
 300:	01 96       	adiw	r24, 0x01	; 1
 302:	8f 73       	andi	r24, 0x3F	; 63
 304:	99 27       	eor	r25, r25
 306:	84 8f       	std	Z+28, r24	; 0x1c
 308:	a6 89       	ldd	r26, Z+22	; 0x16
 30a:	b7 89       	ldd	r27, Z+23	; 0x17
 30c:	2c 93       	st	X, r18
 30e:	a0 89       	ldd	r26, Z+16	; 0x10
 310:	b1 89       	ldd	r27, Z+17	; 0x11
 312:	8c 91       	ld	r24, X
 314:	83 70       	andi	r24, 0x03	; 3
 316:	80 64       	ori	r24, 0x40	; 64
 318:	8c 93       	st	X, r24
 31a:	93 8d       	ldd	r25, Z+27	; 0x1b
 31c:	84 8d       	ldd	r24, Z+28	; 0x1c
 31e:	98 13       	cpse	r25, r24
 320:	06 c0       	rjmp	.+12     	; 0x32e <_ZN14HardwareSerial17_tx_udr_empty_irqEv+0x42>
 322:	02 88       	ldd	r0, Z+18	; 0x12
 324:	f3 89       	ldd	r31, Z+19	; 0x13
 326:	e0 2d       	mov	r30, r0
 328:	80 81       	ld	r24, Z
 32a:	8f 7d       	andi	r24, 0xDF	; 223
 32c:	80 83       	st	Z, r24
 32e:	08 95       	ret

00000330 <_ZN14HardwareSerial5writeEh>:
 330:	ef 92       	push	r14
 332:	ff 92       	push	r15
 334:	0f 93       	push	r16
 336:	1f 93       	push	r17
 338:	cf 93       	push	r28
 33a:	df 93       	push	r29
 33c:	ec 01       	movw	r28, r24
 33e:	81 e0       	ldi	r24, 0x01	; 1
 340:	88 8f       	std	Y+24, r24	; 0x18
 342:	9b 8d       	ldd	r25, Y+27	; 0x1b
 344:	8c 8d       	ldd	r24, Y+28	; 0x1c
 346:	98 13       	cpse	r25, r24
 348:	1a c0       	rjmp	.+52     	; 0x37e <_ZN14HardwareSerial5writeEh+0x4e>
 34a:	e8 89       	ldd	r30, Y+16	; 0x10
 34c:	f9 89       	ldd	r31, Y+17	; 0x11
 34e:	80 81       	ld	r24, Z
 350:	85 ff       	sbrs	r24, 5
 352:	15 c0       	rjmp	.+42     	; 0x37e <_ZN14HardwareSerial5writeEh+0x4e>
 354:	9f b7       	in	r25, 0x3f	; 63
 356:	f8 94       	cli
 358:	ee 89       	ldd	r30, Y+22	; 0x16
 35a:	ff 89       	ldd	r31, Y+23	; 0x17
 35c:	60 83       	st	Z, r22
 35e:	e8 89       	ldd	r30, Y+16	; 0x10
 360:	f9 89       	ldd	r31, Y+17	; 0x11
 362:	80 81       	ld	r24, Z
 364:	83 70       	andi	r24, 0x03	; 3
 366:	80 64       	ori	r24, 0x40	; 64
 368:	80 83       	st	Z, r24
 36a:	9f bf       	out	0x3f, r25	; 63
 36c:	81 e0       	ldi	r24, 0x01	; 1
 36e:	90 e0       	ldi	r25, 0x00	; 0
 370:	df 91       	pop	r29
 372:	cf 91       	pop	r28
 374:	1f 91       	pop	r17
 376:	0f 91       	pop	r16
 378:	ff 90       	pop	r15
 37a:	ef 90       	pop	r14
 37c:	08 95       	ret
 37e:	f6 2e       	mov	r15, r22
 380:	0b 8d       	ldd	r16, Y+27	; 0x1b
 382:	10 e0       	ldi	r17, 0x00	; 0
 384:	0f 5f       	subi	r16, 0xFF	; 255
 386:	1f 4f       	sbci	r17, 0xFF	; 255
 388:	0f 73       	andi	r16, 0x3F	; 63
 38a:	11 27       	eor	r17, r17
 38c:	e0 2e       	mov	r14, r16
 38e:	8c 8d       	ldd	r24, Y+28	; 0x1c
 390:	8e 11       	cpse	r24, r14
 392:	0c c0       	rjmp	.+24     	; 0x3ac <_ZN14HardwareSerial5writeEh+0x7c>
 394:	0f b6       	in	r0, 0x3f	; 63
 396:	07 fc       	sbrc	r0, 7
 398:	fa cf       	rjmp	.-12     	; 0x38e <_ZN14HardwareSerial5writeEh+0x5e>
 39a:	e8 89       	ldd	r30, Y+16	; 0x10
 39c:	f9 89       	ldd	r31, Y+17	; 0x11
 39e:	80 81       	ld	r24, Z
 3a0:	85 ff       	sbrs	r24, 5
 3a2:	f5 cf       	rjmp	.-22     	; 0x38e <_ZN14HardwareSerial5writeEh+0x5e>
 3a4:	ce 01       	movw	r24, r28
 3a6:	0e 94 76 01 	call	0x2ec	; 0x2ec <_ZN14HardwareSerial17_tx_udr_empty_irqEv>
 3aa:	f1 cf       	rjmp	.-30     	; 0x38e <_ZN14HardwareSerial5writeEh+0x5e>
 3ac:	eb 8d       	ldd	r30, Y+27	; 0x1b
 3ae:	ec 0f       	add	r30, r28
 3b0:	fd 2f       	mov	r31, r29
 3b2:	f1 1d       	adc	r31, r1
 3b4:	e3 5a       	subi	r30, 0xA3	; 163
 3b6:	ff 4f       	sbci	r31, 0xFF	; 255
 3b8:	f0 82       	st	Z, r15
 3ba:	9f b7       	in	r25, 0x3f	; 63
 3bc:	f8 94       	cli
 3be:	0b 8f       	std	Y+27, r16	; 0x1b
 3c0:	ea 89       	ldd	r30, Y+18	; 0x12
 3c2:	fb 89       	ldd	r31, Y+19	; 0x13
 3c4:	80 81       	ld	r24, Z
 3c6:	80 62       	ori	r24, 0x20	; 32
 3c8:	cf cf       	rjmp	.-98     	; 0x368 <_ZN14HardwareSerial5writeEh+0x38>

000003ca <_ZN14HardwareSerial5flushEv>:
 3ca:	cf 93       	push	r28
 3cc:	df 93       	push	r29
 3ce:	ec 01       	movw	r28, r24
 3d0:	88 8d       	ldd	r24, Y+24	; 0x18
 3d2:	88 23       	and	r24, r24
 3d4:	b9 f0       	breq	.+46     	; 0x404 <__LOCK_REGION_LENGTH__+0x4>
 3d6:	aa 89       	ldd	r26, Y+18	; 0x12
 3d8:	bb 89       	ldd	r27, Y+19	; 0x13
 3da:	e8 89       	ldd	r30, Y+16	; 0x10
 3dc:	f9 89       	ldd	r31, Y+17	; 0x11
 3de:	8c 91       	ld	r24, X
 3e0:	85 fd       	sbrc	r24, 5
 3e2:	03 c0       	rjmp	.+6      	; 0x3ea <_ZN14HardwareSerial5flushEv+0x20>
 3e4:	80 81       	ld	r24, Z
 3e6:	86 fd       	sbrc	r24, 6
 3e8:	0d c0       	rjmp	.+26     	; 0x404 <__LOCK_REGION_LENGTH__+0x4>
 3ea:	0f b6       	in	r0, 0x3f	; 63
 3ec:	07 fc       	sbrc	r0, 7
 3ee:	f7 cf       	rjmp	.-18     	; 0x3de <_ZN14HardwareSerial5flushEv+0x14>
 3f0:	8c 91       	ld	r24, X
 3f2:	85 ff       	sbrs	r24, 5
 3f4:	f2 cf       	rjmp	.-28     	; 0x3da <_ZN14HardwareSerial5flushEv+0x10>
 3f6:	80 81       	ld	r24, Z
 3f8:	85 ff       	sbrs	r24, 5
 3fa:	ed cf       	rjmp	.-38     	; 0x3d6 <_ZN14HardwareSerial5flushEv+0xc>
 3fc:	ce 01       	movw	r24, r28
 3fe:	0e 94 76 01 	call	0x2ec	; 0x2ec <_ZN14HardwareSerial17_tx_udr_empty_irqEv>
 402:	e9 cf       	rjmp	.-46     	; 0x3d6 <_ZN14HardwareSerial5flushEv+0xc>
 404:	df 91       	pop	r29
 406:	cf 91       	pop	r28
 408:	08 95       	ret

0000040a <_ZN5Print5writeEPKc.part.2.constprop.12>:
 40a:	fc 01       	movw	r30, r24
 40c:	01 90       	ld	r0, Z+
 40e:	00 20       	and	r0, r0
 410:	e9 f7       	brne	.-6      	; 0x40c <_ZN5Print5writeEPKc.part.2.constprop.12+0x2>
 412:	31 97       	sbiw	r30, 0x01	; 1
 414:	af 01       	movw	r20, r30
 416:	48 1b       	sub	r20, r24
 418:	59 0b       	sbc	r21, r25
 41a:	bc 01       	movw	r22, r24
 41c:	8b e2       	ldi	r24, 0x2B	; 43
 41e:	91 e0       	ldi	r25, 0x01	; 1
 420:	0c 94 f8 00 	jmp	0x1f0	; 0x1f0 <_ZN5Print5writeEPKhj>

00000424 <__vector_16>:
 424:	1f 92       	push	r1
 426:	0f 92       	push	r0
 428:	0f b6       	in	r0, 0x3f	; 63
 42a:	0f 92       	push	r0
 42c:	11 24       	eor	r1, r1
 42e:	2f 93       	push	r18
 430:	3f 93       	push	r19
 432:	8f 93       	push	r24
 434:	9f 93       	push	r25
 436:	af 93       	push	r26
 438:	bf 93       	push	r27
 43a:	80 91 23 01 	lds	r24, 0x0123	; 0x800123 <timer0_millis>
 43e:	90 91 24 01 	lds	r25, 0x0124	; 0x800124 <timer0_millis+0x1>
 442:	a0 91 25 01 	lds	r26, 0x0125	; 0x800125 <timer0_millis+0x2>
 446:	b0 91 26 01 	lds	r27, 0x0126	; 0x800126 <timer0_millis+0x3>
 44a:	30 91 22 01 	lds	r19, 0x0122	; 0x800122 <timer0_fract>
 44e:	23 e0       	ldi	r18, 0x03	; 3
 450:	23 0f       	add	r18, r19
 452:	2d 37       	cpi	r18, 0x7D	; 125
 454:	58 f5       	brcc	.+86     	; 0x4ac <__vector_16+0x88>
 456:	01 96       	adiw	r24, 0x01	; 1
 458:	a1 1d       	adc	r26, r1
 45a:	b1 1d       	adc	r27, r1
 45c:	20 93 22 01 	sts	0x0122, r18	; 0x800122 <timer0_fract>
 460:	80 93 23 01 	sts	0x0123, r24	; 0x800123 <timer0_millis>
 464:	90 93 24 01 	sts	0x0124, r25	; 0x800124 <timer0_millis+0x1>
 468:	a0 93 25 01 	sts	0x0125, r26	; 0x800125 <timer0_millis+0x2>
 46c:	b0 93 26 01 	sts	0x0126, r27	; 0x800126 <timer0_millis+0x3>
 470:	80 91 27 01 	lds	r24, 0x0127	; 0x800127 <timer0_overflow_count>
 474:	90 91 28 01 	lds	r25, 0x0128	; 0x800128 <timer0_overflow_count+0x1>
 478:	a0 91 29 01 	lds	r26, 0x0129	; 0x800129 <timer0_overflow_count+0x2>
 47c:	b0 91 2a 01 	lds	r27, 0x012A	; 0x80012a <timer0_overflow_count+0x3>
 480:	01 96       	adiw	r24, 0x01	; 1
 482:	a1 1d       	adc	r26, r1
 484:	b1 1d       	adc	r27, r1
 486:	80 93 27 01 	sts	0x0127, r24	; 0x800127 <timer0_overflow_count>
 48a:	90 93 28 01 	sts	0x0128, r25	; 0x800128 <timer0_overflow_count+0x1>
 48e:	a0 93 29 01 	sts	0x0129, r26	; 0x800129 <timer0_overflow_count+0x2>
 492:	b0 93 2a 01 	sts	0x012A, r27	; 0x80012a <timer0_overflow_count+0x3>
 496:	bf 91       	pop	r27
 498:	af 91       	pop	r26
 49a:	9f 91       	pop	r25
 49c:	8f 91       	pop	r24
 49e:	3f 91       	pop	r19
 4a0:	2f 91       	pop	r18
 4a2:	0f 90       	pop	r0
 4a4:	0f be       	out	0x3f, r0	; 63
 4a6:	0f 90       	pop	r0
 4a8:	1f 90       	pop	r1
 4aa:	18 95       	reti
 4ac:	26 e8       	ldi	r18, 0x86	; 134
 4ae:	23 0f       	add	r18, r19
 4b0:	02 96       	adiw	r24, 0x02	; 2
 4b2:	a1 1d       	adc	r26, r1
 4b4:	b1 1d       	adc	r27, r1
 4b6:	d2 cf       	rjmp	.-92     	; 0x45c <__vector_16+0x38>

000004b8 <__vector_19>:
 4b8:	1f 92       	push	r1
 4ba:	0f 92       	push	r0
 4bc:	0f b6       	in	r0, 0x3f	; 63
 4be:	0f 92       	push	r0
 4c0:	11 24       	eor	r1, r1
 4c2:	2f 93       	push	r18
 4c4:	3f 93       	push	r19
 4c6:	4f 93       	push	r20
 4c8:	5f 93       	push	r21
 4ca:	6f 93       	push	r22
 4cc:	7f 93       	push	r23
 4ce:	8f 93       	push	r24
 4d0:	9f 93       	push	r25
 4d2:	af 93       	push	r26
 4d4:	bf 93       	push	r27
 4d6:	ef 93       	push	r30
 4d8:	ff 93       	push	r31
 4da:	8b e2       	ldi	r24, 0x2B	; 43
 4dc:	91 e0       	ldi	r25, 0x01	; 1
 4de:	0e 94 76 01 	call	0x2ec	; 0x2ec <_ZN14HardwareSerial17_tx_udr_empty_irqEv>
 4e2:	ff 91       	pop	r31
 4e4:	ef 91       	pop	r30
 4e6:	bf 91       	pop	r27
 4e8:	af 91       	pop	r26
 4ea:	9f 91       	pop	r25
 4ec:	8f 91       	pop	r24
 4ee:	7f 91       	pop	r23
 4f0:	6f 91       	pop	r22
 4f2:	5f 91       	pop	r21
 4f4:	4f 91       	pop	r20
 4f6:	3f 91       	pop	r19
 4f8:	2f 91       	pop	r18
 4fa:	0f 90       	pop	r0
 4fc:	0f be       	out	0x3f, r0	; 63
 4fe:	0f 90       	pop	r0
 500:	1f 90       	pop	r1
 502:	18 95       	reti

00000504 <__vector_18>:
 504:	1f 92       	push	r1
 506:	0f 92       	push	r0
 508:	0f b6       	in	r0, 0x3f	; 63
 50a:	0f 92       	push	r0
 50c:	11 24       	eor	r1, r1
 50e:	2f 93       	push	r18
 510:	8f 93       	push	r24
 512:	9f 93       	push	r25
 514:	ef 93       	push	r30
 516:	ff 93       	push	r31
 518:	e0 91 3b 01 	lds	r30, 0x013B	; 0x80013b <Serial+0x10>
 51c:	f0 91 3c 01 	lds	r31, 0x013C	; 0x80013c <Serial+0x11>
 520:	80 81       	ld	r24, Z
 522:	e0 91 41 01 	lds	r30, 0x0141	; 0x800141 <Serial+0x16>
 526:	f0 91 42 01 	lds	r31, 0x0142	; 0x800142 <Serial+0x17>
 52a:	82 fd       	sbrc	r24, 2
 52c:	1b c0       	rjmp	.+54     	; 0x564 <__vector_18+0x60>
 52e:	90 81       	ld	r25, Z
 530:	80 91 44 01 	lds	r24, 0x0144	; 0x800144 <Serial+0x19>
 534:	8f 5f       	subi	r24, 0xFF	; 255
 536:	8f 73       	andi	r24, 0x3F	; 63
 538:	20 91 45 01 	lds	r18, 0x0145	; 0x800145 <Serial+0x1a>
 53c:	82 17       	cp	r24, r18
 53e:	41 f0       	breq	.+16     	; 0x550 <__vector_18+0x4c>
 540:	e0 91 44 01 	lds	r30, 0x0144	; 0x800144 <Serial+0x19>
 544:	f0 e0       	ldi	r31, 0x00	; 0
 546:	e5 5d       	subi	r30, 0xD5	; 213
 548:	fe 4f       	sbci	r31, 0xFE	; 254
 54a:	95 8f       	std	Z+29, r25	; 0x1d
 54c:	80 93 44 01 	sts	0x0144, r24	; 0x800144 <Serial+0x19>
 550:	ff 91       	pop	r31
 552:	ef 91       	pop	r30
 554:	9f 91       	pop	r25
 556:	8f 91       	pop	r24
 558:	2f 91       	pop	r18
 55a:	0f 90       	pop	r0
 55c:	0f be       	out	0x3f, r0	; 63
 55e:	0f 90       	pop	r0
 560:	1f 90       	pop	r1
 562:	18 95       	reti
 564:	80 81       	ld	r24, Z
 566:	f4 cf       	rjmp	.-24     	; 0x550 <__vector_18+0x4c>

00000568 <main>:
 568:	cf 93       	push	r28
 56a:	df 93       	push	r29
 56c:	cd b7       	in	r28, 0x3d	; 61
 56e:	de b7       	in	r29, 0x3e	; 62
 570:	a1 97       	sbiw	r28, 0x21	; 33
 572:	0f b6       	in	r0, 0x3f	; 63
 574:	f8 94       	cli
 576:	de bf       	out	0x3e, r29	; 62
 578:	0f be       	out	0x3f, r0	; 63
 57a:	cd bf       	out	0x3d, r28	; 61
 57c:	78 94       	sei
 57e:	84 b5       	in	r24, 0x24	; 36
 580:	82 60       	ori	r24, 0x02	; 2
 582:	84 bd       	out	0x24, r24	; 36
 584:	84 b5       	in	r24, 0x24	; 36
 586:	81 60       	ori	r24, 0x01	; 1
 588:	84 bd       	out	0x24, r24	; 36
 58a:	85 b5       	in	r24, 0x25	; 37
 58c:	82 60       	ori	r24, 0x02	; 2
 58e:	85 bd       	out	0x25, r24	; 37
 590:	85 b5       	in	r24, 0x25	; 37
 592:	81 60       	ori	r24, 0x01	; 1
 594:	85 bd       	out	0x25, r24	; 37
 596:	80 91 6e 00 	lds	r24, 0x006E	; 0x80006e <__DATA_REGION_ORIGIN__+0xe>
 59a:	81 60       	ori	r24, 0x01	; 1
 59c:	80 93 6e 00 	sts	0x006E, r24	; 0x80006e <__DATA_REGION_ORIGIN__+0xe>
 5a0:	10 92 81 00 	sts	0x0081, r1	; 0x800081 <__DATA_REGION_ORIGIN__+0x21>
 5a4:	80 91 81 00 	lds	r24, 0x0081	; 0x800081 <__DATA_REGION_ORIGIN__+0x21>
 5a8:	82 60       	ori	r24, 0x02	; 2
 5aa:	80 93 81 00 	sts	0x0081, r24	; 0x800081 <__DATA_REGION_ORIGIN__+0x21>
 5ae:	80 91 81 00 	lds	r24, 0x0081	; 0x800081 <__DATA_REGION_ORIGIN__+0x21>
 5b2:	81 60       	ori	r24, 0x01	; 1
 5b4:	80 93 81 00 	sts	0x0081, r24	; 0x800081 <__DATA_REGION_ORIGIN__+0x21>
 5b8:	80 91 80 00 	lds	r24, 0x0080	; 0x800080 <__DATA_REGION_ORIGIN__+0x20>
 5bc:	81 60       	ori	r24, 0x01	; 1
 5be:	80 93 80 00 	sts	0x0080, r24	; 0x800080 <__DATA_REGION_ORIGIN__+0x20>
 5c2:	80 91 b1 00 	lds	r24, 0x00B1	; 0x8000b1 <__DATA_REGION_ORIGIN__+0x51>
 5c6:	84 60       	ori	r24, 0x04	; 4
 5c8:	80 93 b1 00 	sts	0x00B1, r24	; 0x8000b1 <__DATA_REGION_ORIGIN__+0x51>
 5cc:	80 91 b0 00 	lds	r24, 0x00B0	; 0x8000b0 <__DATA_REGION_ORIGIN__+0x50>
 5d0:	81 60       	ori	r24, 0x01	; 1
 5d2:	80 93 b0 00 	sts	0x00B0, r24	; 0x8000b0 <__DATA_REGION_ORIGIN__+0x50>
 5d6:	80 91 7a 00 	lds	r24, 0x007A	; 0x80007a <__DATA_REGION_ORIGIN__+0x1a>
 5da:	84 60       	ori	r24, 0x04	; 4
 5dc:	80 93 7a 00 	sts	0x007A, r24	; 0x80007a <__DATA_REGION_ORIGIN__+0x1a>
 5e0:	80 91 7a 00 	lds	r24, 0x007A	; 0x80007a <__DATA_REGION_ORIGIN__+0x1a>
 5e4:	82 60       	ori	r24, 0x02	; 2
 5e6:	80 93 7a 00 	sts	0x007A, r24	; 0x80007a <__DATA_REGION_ORIGIN__+0x1a>
 5ea:	80 91 7a 00 	lds	r24, 0x007A	; 0x80007a <__DATA_REGION_ORIGIN__+0x1a>
 5ee:	81 60       	ori	r24, 0x01	; 1
 5f0:	80 93 7a 00 	sts	0x007A, r24	; 0x80007a <__DATA_REGION_ORIGIN__+0x1a>
 5f4:	80 91 7a 00 	lds	r24, 0x007A	; 0x80007a <__DATA_REGION_ORIGIN__+0x1a>
 5f8:	80 68       	ori	r24, 0x80	; 128
 5fa:	80 93 7a 00 	sts	0x007A, r24	; 0x80007a <__DATA_REGION_ORIGIN__+0x1a>
 5fe:	10 92 c1 00 	sts	0x00C1, r1	; 0x8000c1 <__DATA_REGION_ORIGIN__+0x61>
 602:	e0 91 3b 01 	lds	r30, 0x013B	; 0x80013b <Serial+0x10>
 606:	f0 91 3c 01 	lds	r31, 0x013C	; 0x80013c <Serial+0x11>
 60a:	82 e0       	ldi	r24, 0x02	; 2
 60c:	80 83       	st	Z, r24
 60e:	e0 91 37 01 	lds	r30, 0x0137	; 0x800137 <Serial+0xc>
 612:	f0 91 38 01 	lds	r31, 0x0138	; 0x800138 <Serial+0xd>
 616:	10 82       	st	Z, r1
 618:	e0 91 39 01 	lds	r30, 0x0139	; 0x800139 <Serial+0xe>
 61c:	f0 91 3a 01 	lds	r31, 0x013A	; 0x80013a <Serial+0xf>
 620:	80 e1       	ldi	r24, 0x10	; 16
 622:	80 83       	st	Z, r24
 624:	10 92 43 01 	sts	0x0143, r1	; 0x800143 <Serial+0x18>
 628:	e0 91 3f 01 	lds	r30, 0x013F	; 0x80013f <Serial+0x14>
 62c:	f0 91 40 01 	lds	r31, 0x0140	; 0x800140 <Serial+0x15>
 630:	86 e0       	ldi	r24, 0x06	; 6
 632:	80 83       	st	Z, r24
 634:	e0 91 3d 01 	lds	r30, 0x013D	; 0x80013d <Serial+0x12>
 638:	f0 91 3e 01 	lds	r31, 0x013E	; 0x80013e <Serial+0x13>
 63c:	80 81       	ld	r24, Z
 63e:	80 61       	ori	r24, 0x10	; 16
 640:	80 83       	st	Z, r24
 642:	e0 91 3d 01 	lds	r30, 0x013D	; 0x80013d <Serial+0x12>
 646:	f0 91 3e 01 	lds	r31, 0x013E	; 0x80013e <Serial+0x13>
 64a:	80 81       	ld	r24, Z
 64c:	88 60       	ori	r24, 0x08	; 8
 64e:	80 83       	st	Z, r24
 650:	e0 91 3d 01 	lds	r30, 0x013D	; 0x80013d <Serial+0x12>
 654:	f0 91 3e 01 	lds	r31, 0x013E	; 0x80013e <Serial+0x13>
 658:	80 81       	ld	r24, Z
 65a:	80 68       	ori	r24, 0x80	; 128
 65c:	80 83       	st	Z, r24
 65e:	e0 91 3d 01 	lds	r30, 0x013D	; 0x80013d <Serial+0x12>
 662:	f0 91 3e 01 	lds	r31, 0x013E	; 0x80013e <Serial+0x13>
 666:	80 81       	ld	r24, Z
 668:	8f 7d       	andi	r24, 0xDF	; 223
 66a:	80 83       	st	Z, r24
 66c:	a2 e1       	ldi	r26, 0x12	; 18
 66e:	b1 e0       	ldi	r27, 0x01	; 1
 670:	26 e1       	ldi	r18, 0x16	; 22
 672:	31 e0       	ldi	r19, 0x01	; 1
 674:	8d 91       	ld	r24, X+
 676:	90 e0       	ldi	r25, 0x00	; 0
 678:	fc 01       	movw	r30, r24
 67a:	e0 57       	subi	r30, 0x70	; 112
 67c:	ff 4f       	sbci	r31, 0xFF	; 255
 67e:	64 91       	lpm	r22, Z
 680:	84 58       	subi	r24, 0x84	; 132
 682:	9f 4f       	sbci	r25, 0xFF	; 255
 684:	fc 01       	movw	r30, r24
 686:	84 91       	lpm	r24, Z
 688:	88 23       	and	r24, r24
 68a:	a1 f0       	breq	.+40     	; 0x6b4 <main+0x14c>
 68c:	90 e0       	ldi	r25, 0x00	; 0
 68e:	88 0f       	add	r24, r24
 690:	99 1f       	adc	r25, r25
 692:	fc 01       	movw	r30, r24
 694:	e8 59       	subi	r30, 0x98	; 152
 696:	ff 4f       	sbci	r31, 0xFF	; 255
 698:	45 91       	lpm	r20, Z+
 69a:	54 91       	lpm	r21, Z
 69c:	fc 01       	movw	r30, r24
 69e:	ee 58       	subi	r30, 0x8E	; 142
 6a0:	ff 4f       	sbci	r31, 0xFF	; 255
 6a2:	85 91       	lpm	r24, Z+
 6a4:	94 91       	lpm	r25, Z
 6a6:	8f b7       	in	r24, 0x3f	; 63
 6a8:	f8 94       	cli
 6aa:	fa 01       	movw	r30, r20
 6ac:	90 81       	ld	r25, Z
 6ae:	96 2b       	or	r25, r22
 6b0:	90 83       	st	Z, r25
 6b2:	8f bf       	out	0x3f, r24	; 63
 6b4:	2a 17       	cp	r18, r26
 6b6:	3b 07       	cpc	r19, r27
 6b8:	e9 f6       	brne	.-70     	; 0x674 <main+0x10c>
 6ba:	9a e0       	ldi	r25, 0x0A	; 10
 6bc:	49 2e       	mov	r4, r25
 6be:	51 2c       	mov	r5, r1
 6c0:	61 2c       	mov	r6, r1
 6c2:	71 2c       	mov	r7, r1
 6c4:	86 e1       	ldi	r24, 0x16	; 22
 6c6:	91 e0       	ldi	r25, 0x01	; 1
 6c8:	0e 94 05 02 	call	0x40a	; 0x40a <_ZN5Print5writeEPKc.part.2.constprop.12>
 6cc:	c0 90 20 01 	lds	r12, 0x0120	; 0x800120 <__data_end>
 6d0:	d0 90 21 01 	lds	r13, 0x0121	; 0x800121 <__data_end+0x1>
 6d4:	0d 2c       	mov	r0, r13
 6d6:	00 0c       	add	r0, r0
 6d8:	ee 08       	sbc	r14, r14
 6da:	ff 08       	sbc	r15, r15
 6dc:	f7 fe       	sbrs	r15, 7
 6de:	72 c0       	rjmp	.+228    	; 0x7c4 <main+0x25c>
 6e0:	6d e2       	ldi	r22, 0x2D	; 45
 6e2:	8b e2       	ldi	r24, 0x2B	; 43
 6e4:	91 e0       	ldi	r25, 0x01	; 1
 6e6:	0e 94 98 01 	call	0x330	; 0x330 <_ZN14HardwareSerial5writeEh>
 6ea:	22 27       	eor	r18, r18
 6ec:	33 27       	eor	r19, r19
 6ee:	a9 01       	movw	r20, r18
 6f0:	2c 19       	sub	r18, r12
 6f2:	3d 09       	sbc	r19, r13
 6f4:	4e 09       	sbc	r20, r14
 6f6:	5f 09       	sbc	r21, r15
 6f8:	19 a2       	std	Y+33, r1	; 0x21
 6fa:	8e 01       	movw	r16, r28
 6fc:	0f 5d       	subi	r16, 0xDF	; 223
 6fe:	1f 4f       	sbci	r17, 0xFF	; 255
 700:	ca 01       	movw	r24, r20
 702:	b9 01       	movw	r22, r18
 704:	a3 01       	movw	r20, r6
 706:	92 01       	movw	r18, r4
 708:	0e 94 25 04 	call	0x84a	; 0x84a <__udivmodsi4>
 70c:	60 5d       	subi	r22, 0xD0	; 208
 70e:	f8 01       	movw	r30, r16
 710:	62 93       	st	-Z, r22
 712:	8f 01       	movw	r16, r30
 714:	21 15       	cp	r18, r1
 716:	31 05       	cpc	r19, r1
 718:	41 05       	cpc	r20, r1
 71a:	51 05       	cpc	r21, r1
 71c:	89 f7       	brne	.-30     	; 0x700 <main+0x198>
 71e:	01 15       	cp	r16, r1
 720:	11 05       	cpc	r17, r1
 722:	19 f0       	breq	.+6      	; 0x72a <main+0x1c2>
 724:	c8 01       	movw	r24, r16
 726:	0e 94 05 02 	call	0x40a	; 0x40a <_ZN5Print5writeEPKc.part.2.constprop.12>
 72a:	8c e1       	ldi	r24, 0x1C	; 28
 72c:	91 e0       	ldi	r25, 0x01	; 1
 72e:	0e 94 05 02 	call	0x40a	; 0x40a <_ZN5Print5writeEPKc.part.2.constprop.12>
 732:	00 91 20 01 	lds	r16, 0x0120	; 0x800120 <__data_end>
 736:	10 91 21 01 	lds	r17, 0x0121	; 0x800121 <__data_end+0x1>
 73a:	f8 01       	movw	r30, r16
 73c:	ee 5e       	subi	r30, 0xEE	; 238
 73e:	fe 4f       	sbci	r31, 0xFE	; 254
 740:	30 80       	ld	r3, Z
 742:	61 e0       	ldi	r22, 0x01	; 1
 744:	83 2d       	mov	r24, r3
 746:	0e 94 87 00 	call	0x10e	; 0x10e <digitalWrite>
 74a:	0e 94 d3 00 	call	0x1a6	; 0x1a6 <micros>
 74e:	4b 01       	movw	r8, r22
 750:	5c 01       	movw	r10, r24
 752:	8a ef       	ldi	r24, 0xFA	; 250
 754:	c8 2e       	mov	r12, r24
 756:	d1 2c       	mov	r13, r1
 758:	e1 2c       	mov	r14, r1
 75a:	f1 2c       	mov	r15, r1
 75c:	0e 94 d3 00 	call	0x1a6	; 0x1a6 <micros>
 760:	68 19       	sub	r22, r8
 762:	79 09       	sbc	r23, r9
 764:	8a 09       	sbc	r24, r10
 766:	9b 09       	sbc	r25, r11
 768:	68 3e       	cpi	r22, 0xE8	; 232
 76a:	73 40       	sbci	r23, 0x03	; 3
 76c:	81 05       	cpc	r24, r1
 76e:	91 05       	cpc	r25, r1
 770:	a8 f3       	brcs	.-22     	; 0x75c <main+0x1f4>
 772:	f1 e0       	ldi	r31, 0x01	; 1
 774:	cf 1a       	sub	r12, r31
 776:	d1 08       	sbc	r13, r1
 778:	e1 08       	sbc	r14, r1
 77a:	f1 08       	sbc	r15, r1
 77c:	28 ee       	ldi	r18, 0xE8	; 232
 77e:	82 0e       	add	r8, r18
 780:	23 e0       	ldi	r18, 0x03	; 3
 782:	92 1e       	adc	r9, r18
 784:	a1 1c       	adc	r10, r1
 786:	b1 1c       	adc	r11, r1
 788:	c1 14       	cp	r12, r1
 78a:	d1 04       	cpc	r13, r1
 78c:	e1 04       	cpc	r14, r1
 78e:	f1 04       	cpc	r15, r1
 790:	29 f7       	brne	.-54     	; 0x75c <main+0x1f4>
 792:	60 e0       	ldi	r22, 0x00	; 0
 794:	83 2d       	mov	r24, r3
 796:	0e 94 87 00 	call	0x10e	; 0x10e <digitalWrite>
 79a:	0f 5f       	subi	r16, 0xFF	; 255
 79c:	1f 4f       	sbci	r17, 0xFF	; 255
 79e:	03 70       	andi	r16, 0x03	; 3
 7a0:	11 27       	eor	r17, r17
 7a2:	10 93 21 01 	sts	0x0121, r17	; 0x800121 <__data_end+0x1>
 7a6:	00 93 20 01 	sts	0x0120, r16	; 0x800120 <__data_end>
 7aa:	80 e0       	ldi	r24, 0x00	; 0
 7ac:	90 e0       	ldi	r25, 0x00	; 0
 7ae:	89 2b       	or	r24, r25
 7b0:	09 f4       	brne	.+2      	; 0x7b4 <main+0x24c>
 7b2:	88 cf       	rjmp	.-240    	; 0x6c4 <main+0x15c>
 7b4:	0e 94 62 01 	call	0x2c4	; 0x2c4 <_Z17Serial0_availablev>
 7b8:	88 23       	and	r24, r24
 7ba:	09 f4       	brne	.+2      	; 0x7be <main+0x256>
 7bc:	83 cf       	rjmp	.-250    	; 0x6c4 <main+0x15c>
 7be:	0e 94 00 00 	call	0	; 0x0 <__vectors>
 7c2:	80 cf       	rjmp	.-256    	; 0x6c4 <main+0x15c>
 7c4:	a7 01       	movw	r20, r14
 7c6:	96 01       	movw	r18, r12
 7c8:	19 a2       	std	Y+33, r1	; 0x21
 7ca:	8e 01       	movw	r16, r28
 7cc:	0f 5d       	subi	r16, 0xDF	; 223
 7ce:	1f 4f       	sbci	r17, 0xFF	; 255
 7d0:	ca 01       	movw	r24, r20
 7d2:	b9 01       	movw	r22, r18
 7d4:	a3 01       	movw	r20, r6
 7d6:	92 01       	movw	r18, r4
 7d8:	0e 94 25 04 	call	0x84a	; 0x84a <__udivmodsi4>
 7dc:	60 5d       	subi	r22, 0xD0	; 208
 7de:	f8 01       	movw	r30, r16
 7e0:	62 93       	st	-Z, r22
 7e2:	8f 01       	movw	r16, r30
 7e4:	21 15       	cp	r18, r1
 7e6:	31 05       	cpc	r19, r1
 7e8:	41 05       	cpc	r20, r1
 7ea:	51 05       	cpc	r21, r1
 7ec:	89 f7       	brne	.-30     	; 0x7d0 <main+0x268>
 7ee:	97 cf       	rjmp	.-210    	; 0x71e <main+0x1b6>

000007f0 <_GLOBAL__sub_I___vector_18>:
 7f0:	eb e2       	ldi	r30, 0x2B	; 43
 7f2:	f1 e0       	ldi	r31, 0x01	; 1
 7f4:	13 82       	std	Z+3, r1	; 0x03
 7f6:	12 82       	std	Z+2, r1	; 0x02
 7f8:	88 ee       	ldi	r24, 0xE8	; 232
 7fa:	93 e0       	ldi	r25, 0x03	; 3
 7fc:	a0 e0       	ldi	r26, 0x00	; 0
 7fe:	b0 e0       	ldi	r27, 0x00	; 0
 800:	84 83       	std	Z+4, r24	; 0x04
 802:	95 83       	std	Z+5, r25	; 0x05
 804:	a6 83       	std	Z+6, r26	; 0x06
 806:	b7 83       	std	Z+7, r27	; 0x07
 808:	84 e0       	ldi	r24, 0x04	; 4
 80a:	91 e0       	ldi	r25, 0x01	; 1
 80c:	91 83       	std	Z+1, r25	; 0x01
 80e:	80 83       	st	Z, r24
 810:	85 ec       	ldi	r24, 0xC5	; 197
 812:	90 e0       	ldi	r25, 0x00	; 0
 814:	95 87       	std	Z+13, r25	; 0x0d
 816:	84 87       	std	Z+12, r24	; 0x0c
 818:	84 ec       	ldi	r24, 0xC4	; 196
 81a:	90 e0       	ldi	r25, 0x00	; 0
 81c:	97 87       	std	Z+15, r25	; 0x0f
 81e:	86 87       	std	Z+14, r24	; 0x0e
 820:	80 ec       	ldi	r24, 0xC0	; 192
 822:	90 e0       	ldi	r25, 0x00	; 0
 824:	91 8b       	std	Z+17, r25	; 0x11
 826:	80 8b       	std	Z+16, r24	; 0x10
 828:	81 ec       	ldi	r24, 0xC1	; 193
 82a:	90 e0       	ldi	r25, 0x00	; 0
 82c:	93 8b       	std	Z+19, r25	; 0x13
 82e:	82 8b       	std	Z+18, r24	; 0x12
 830:	82 ec       	ldi	r24, 0xC2	; 194
 832:	90 e0       	ldi	r25, 0x00	; 0
 834:	95 8b       	std	Z+21, r25	; 0x15
 836:	84 8b       	std	Z+20, r24	; 0x14
 838:	86 ec       	ldi	r24, 0xC6	; 198
 83a:	90 e0       	ldi	r25, 0x00	; 0
 83c:	97 8b       	std	Z+23, r25	; 0x17
 83e:	86 8b       	std	Z+22, r24	; 0x16
 840:	11 8e       	std	Z+25, r1	; 0x19
 842:	12 8e       	std	Z+26, r1	; 0x1a
 844:	13 8e       	std	Z+27, r1	; 0x1b
 846:	14 8e       	std	Z+28, r1	; 0x1c
 848:	08 95       	ret

0000084a <__udivmodsi4>:
 84a:	a1 e2       	ldi	r26, 0x21	; 33
 84c:	1a 2e       	mov	r1, r26
 84e:	aa 1b       	sub	r26, r26
 850:	bb 1b       	sub	r27, r27
 852:	fd 01       	movw	r30, r26
 854:	0d c0       	rjmp	.+26     	; 0x870 <__udivmodsi4_ep>

00000856 <__udivmodsi4_loop>:
 856:	aa 1f       	adc	r26, r26
 858:	bb 1f       	adc	r27, r27
 85a:	ee 1f       	adc	r30, r30
 85c:	ff 1f       	adc	r31, r31
 85e:	a2 17       	cp	r26, r18
 860:	b3 07       	cpc	r27, r19
 862:	e4 07       	cpc	r30, r20
 864:	f5 07       	cpc	r31, r21
 866:	20 f0       	brcs	.+8      	; 0x870 <__udivmodsi4_ep>
 868:	a2 1b       	sub	r26, r18
 86a:	b3 0b       	sbc	r27, r19
 86c:	e4 0b       	sbc	r30, r20
 86e:	f5 0b       	sbc	r31, r21

00000870 <__udivmodsi4_ep>:
 870:	66 1f       	adc	r22, r22
 872:	77 1f       	adc	r23, r23
 874:	88 1f       	adc	r24, r24
 876:	99 1f       	adc	r25, r25
 878:	1a 94       	dec	r1
 87a:	69 f7       	brne	.-38     	; 0x856 <__udivmodsi4_loop>
 87c:	60 95       	com	r22
 87e:	70 95       	com	r23
 880:	80 95       	com	r24
 882:	90 95       	com	r25
 884:	9b 01       	movw	r18, r22
 886:	ac 01       	movw	r20, r24
 888:	bd 01       	movw	r22, r26
 88a:	cf 01       	movw	r24, r30
 88c:	08 95       	ret

0000088e <__tablejump2__>:
 88e:	ee 0f       	add	r30, r30
 890:	ff 1f       	adc	r31, r31
 892:	05 90       	lpm	r0, Z+
 894:	f4 91       	lpm	r31, Z
 896:	e0 2d       	mov	r30, r0
 898:	09 94       	ijmp

0000089a <_exit>:
 89a:	f8 94       	cli

0000089c <__stop_program>:
 89c:	ff cf       	rjmp	.-2      	; 0x89c <__stop_program>
