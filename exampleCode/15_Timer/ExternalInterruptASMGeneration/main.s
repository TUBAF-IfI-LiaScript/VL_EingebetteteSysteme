	.file	"main.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
 ;  GNU C11 (GCC) version 5.4.0 (avr)
 ; 	compiled by GNU C version 9.3.0, GMP version 6.2.0, MPFR version 4.0.2, MPC version 1.1.0
 ;  GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
 ;  options passed:  -fpreprocessed main.i -mn-flash=1 -mno-skip-bug
 ;  -mmcu=avr5 -auxbase-strip main.o -g -Os -fverbose-asm
 ;  options enabled:  -Wmisspelled-isr -faggressive-loop-optimizations
 ;  -falign-functions -falign-jumps -falign-labels -falign-loops
 ;  -fauto-inc-dec -fbranch-count-reg -fchkp-check-incomplete-type
 ;  -fchkp-check-read -fchkp-check-write -fchkp-instrument-calls
 ;  -fchkp-narrow-bounds -fchkp-optimize -fchkp-store-bounds
 ;  -fchkp-use-static-bounds -fchkp-use-static-const-bounds
 ;  -fchkp-use-wrappers -fcombine-stack-adjustments -fcommon -fcompare-elim
 ;  -fcprop-registers -fcrossjumping -fcse-follow-jumps -fdefer-pop
 ;  -fdevirtualize -fdevirtualize-speculatively -fdwarf2-cfi-asm
 ;  -fearly-inlining -feliminate-unused-debug-types
 ;  -fexpensive-optimizations -fforward-propagate -ffunction-cse -fgcse
 ;  -fgcse-lm -fgnu-runtime -fgnu-unique -fguess-branch-probability
 ;  -fhoist-adjacent-loads -fident -fif-conversion -fif-conversion2
 ;  -findirect-inlining -finline -finline-atomics -finline-functions
 ;  -finline-functions-called-once -finline-small-functions -fipa-cp
 ;  -fipa-cp-alignment -fipa-icf -fipa-icf-functions -fipa-icf-variables
 ;  -fipa-profile -fipa-pure-const -fipa-ra -fipa-reference -fipa-sra
 ;  -fira-hoist-pressure -fira-share-save-slots -fira-share-spill-slots
 ;  -fisolate-erroneous-paths-dereference -fivopts -fkeep-static-consts
 ;  -fleading-underscore -flifetime-dse -flra-remat -flto-odr-type-merging
 ;  -fmath-errno -fmerge-constants -fmerge-debug-strings
 ;  -fmove-loop-invariants -fomit-frame-pointer -foptimize-sibling-calls
 ;  -fpartial-inlining -fpeephole -fpeephole2 -fprefetch-loop-arrays
 ;  -freg-struct-return -freorder-blocks -freorder-functions
 ;  -frerun-cse-after-loop -fsched-critical-path-heuristic
 ;  -fsched-dep-count-heuristic -fsched-group-heuristic -fsched-interblock
 ;  -fsched-last-insn-heuristic -fsched-rank-heuristic -fsched-spec
 ;  -fsched-spec-insn-heuristic -fsched-stalled-insns-dep -fschedule-fusion
 ;  -fsemantic-interposition -fshow-column -fshrink-wrap -fsigned-zeros
 ;  -fsplit-ivs-in-unroller -fsplit-wide-types -fssa-phiopt -fstdarg-opt
 ;  -fstrict-aliasing -fstrict-overflow -fstrict-volatile-bitfields
 ;  -fsync-libcalls -fthread-jumps -ftoplevel-reorder -ftrapping-math
 ;  -ftree-bit-ccp -ftree-builtin-call-dce -ftree-ccp -ftree-ch
 ;  -ftree-coalesce-vars -ftree-copy-prop -ftree-copyrename -ftree-dce
 ;  -ftree-dominator-opts -ftree-dse -ftree-forwprop -ftree-fre
 ;  -ftree-loop-if-convert -ftree-loop-im -ftree-loop-ivcanon
 ;  -ftree-loop-optimize -ftree-parallelize-loops= -ftree-phiprop
 ;  -ftree-pre -ftree-pta -ftree-reassoc -ftree-scev-cprop -ftree-sink
 ;  -ftree-slsr -ftree-sra -ftree-switch-conversion -ftree-tail-merge
 ;  -ftree-ter -ftree-vrp -funit-at-a-time -fverbose-asm
 ;  -fzero-initialized-in-bss

	.stabs	"/home/zug/Desktop/VL_EingebetteteSysteme/exampleCode/15_Timer/ExternalInterruptASMGeneration/",100,0,2,.Ltext0
	.stabs	"main.c",100,0,2,.Ltext0
	.text
.Ltext0:
	.stabs	"gcc2_compiled.",60,0,0,0
	.stabs	"int:t(0,1)=r(0,1);-32768;32767;",128,0,0,0
	.stabs	"char:t(0,2)=r(0,2);0;127;",128,0,0,0
	.stabs	"long int:t(0,3)=@s32;r(0,3);020000000000;017777777777;",128,0,0,0
	.stabs	"unsigned int:t(0,4)=r(0,4);0;0177777;",128,0,0,0
	.stabs	"long unsigned int:t(0,5)=@s32;r(0,5);0;037777777777;",128,0,0,0
	.stabs	"__int128:t(0,6)=@s128;r(0,6);02000000000000000000000000000000000000000000;01777777777777777777777777777777777777777777;",128,0,0,0
	.stabs	"__int128 unsigned:t(0,7)=@s128;r(0,7);0;03777777777777777777777777777777777777777777;",128,0,0,0
	.stabs	"long long int:t(0,8)=@s64;r(0,8);01000000000000000000000;00777777777777777777777;",128,0,0,0
	.stabs	"long long unsigned int:t(0,9)=@s64;r(0,9);0;01777777777777777777777;",128,0,0,0
	.stabs	"short int:t(0,10)=r(0,10);-32768;32767;",128,0,0,0
	.stabs	"short unsigned int:t(0,11)=r(0,11);0;0177777;",128,0,0,0
	.stabs	"signed char:t(0,12)=@s8;r(0,12);-128;127;",128,0,0,0
	.stabs	"unsigned char:t(0,13)=@s8;r(0,13);0;255;",128,0,0,0
	.stabs	"float:t(0,14)=r(0,1);4;0;",128,0,0,0
	.stabs	"double:t(0,15)=r(0,1);4;0;",128,0,0,0
	.stabs	"long double:t(0,16)=r(0,1);4;0;",128,0,0,0
	.stabs	"short _Fract:t(0,17)=r(0,1);1;0;",128,0,0,0
	.stabs	"_Fract:t(0,18)=r(0,1);2;0;",128,0,0,0
	.stabs	"long _Fract:t(0,19)=r(0,1);4;0;",128,0,0,0
	.stabs	"long long _Fract:t(0,20)=r(0,1);8;0;",128,0,0,0
	.stabs	"unsigned short _Fract:t(0,21)=r(0,1);1;0;",128,0,0,0
	.stabs	"unsigned _Fract:t(0,22)=r(0,1);2;0;",128,0,0,0
	.stabs	"unsigned long _Fract:t(0,23)=r(0,1);4;0;",128,0,0,0
	.stabs	"unsigned long long _Fract:t(0,24)=r(0,1);8;0;",128,0,0,0
	.stabs	"_Sat short _Fract:t(0,25)=r(0,1);1;0;",128,0,0,0
	.stabs	"_Sat _Fract:t(0,26)=r(0,1);2;0;",128,0,0,0
	.stabs	"_Sat long _Fract:t(0,27)=r(0,1);4;0;",128,0,0,0
	.stabs	"_Sat long long _Fract:t(0,28)=r(0,1);8;0;",128,0,0,0
	.stabs	"_Sat unsigned short _Fract:t(0,29)=r(0,1);1;0;",128,0,0,0
	.stabs	"_Sat unsigned _Fract:t(0,30)=r(0,1);2;0;",128,0,0,0
	.stabs	"_Sat unsigned long _Fract:t(0,31)=r(0,1);4;0;",128,0,0,0
	.stabs	"_Sat unsigned long long _Fract:t(0,32)=r(0,1);8;0;",128,0,0,0
	.stabs	"short _Accum:t(0,33)=r(0,1);2;0;",128,0,0,0
	.stabs	"_Accum:t(0,34)=r(0,1);4;0;",128,0,0,0
	.stabs	"long _Accum:t(0,35)=r(0,1);8;0;",128,0,0,0
	.stabs	"long long _Accum:t(0,36)=r(0,1);8;0;",128,0,0,0
	.stabs	"unsigned short _Accum:t(0,37)=r(0,1);2;0;",128,0,0,0
	.stabs	"unsigned _Accum:t(0,38)=r(0,1);4;0;",128,0,0,0
	.stabs	"unsigned long _Accum:t(0,39)=r(0,1);8;0;",128,0,0,0
	.stabs	"unsigned long long _Accum:t(0,40)=r(0,1);8;0;",128,0,0,0
	.stabs	"_Sat short _Accum:t(0,41)=r(0,1);2;0;",128,0,0,0
	.stabs	"_Sat _Accum:t(0,42)=r(0,1);4;0;",128,0,0,0
	.stabs	"_Sat long _Accum:t(0,43)=r(0,1);8;0;",128,0,0,0
	.stabs	"_Sat long long _Accum:t(0,44)=r(0,1);8;0;",128,0,0,0
	.stabs	"_Sat unsigned short _Accum:t(0,45)=r(0,1);2;0;",128,0,0,0
	.stabs	"_Sat unsigned _Accum:t(0,46)=r(0,1);4;0;",128,0,0,0
	.stabs	"_Sat unsigned long _Accum:t(0,47)=r(0,1);8;0;",128,0,0,0
	.stabs	"_Sat unsigned long long _Accum:t(0,48)=r(0,1);8;0;",128,0,0,0
	.stabs	"void:t(0,49)=(0,49)",128,0,0,0
	.stabs	"/usr/lib/avr/include/avr/io.h",130,0,0,0
	.stabs	"/usr/lib/avr/include/avr/sfr_defs.h",130,0,0,0
	.stabs	"/usr/lib/avr/include/inttypes.h",130,0,0,0
	.stabs	"/usr/lib/gcc/avr/5.4.0/include/stdint.h",130,0,0,0
	.stabs	"/usr/lib/avr/include/stdint.h",130,0,0,0
	.stabs	"int8_t:t(5,1)=(0,12)",128,0,125,0
	.stabs	"uint8_t:t(5,2)=(0,13)",128,0,126,0
	.stabs	"int16_t:t(5,3)=(0,1)",128,0,127,0
	.stabs	"uint16_t:t(5,4)=(0,4)",128,0,128,0
	.stabs	"int32_t:t(5,5)=(0,3)",128,0,129,0
	.stabs	"uint32_t:t(5,6)=(0,5)",128,0,130,0
	.stabs	"int64_t:t(5,7)=(0,8)",128,0,132,0
	.stabs	"uint64_t:t(5,8)=(0,9)",128,0,133,0
	.stabs	"intptr_t:t(5,9)=(5,3)",128,0,146,0
	.stabs	"uintptr_t:t(5,10)=(5,4)",128,0,151,0
	.stabs	"int_least8_t:t(5,11)=(5,1)",128,0,163,0
	.stabs	"uint_least8_t:t(5,12)=(5,2)",128,0,168,0
	.stabs	"int_least16_t:t(5,13)=(5,3)",128,0,173,0
	.stabs	"uint_least16_t:t(5,14)=(5,4)",128,0,178,0
	.stabs	"int_least32_t:t(5,15)=(5,5)",128,0,183,0
	.stabs	"uint_least32_t:t(5,16)=(5,6)",128,0,188,0
	.stabs	"int_least64_t:t(5,17)=(5,7)",128,0,196,0
	.stabs	"uint_least64_t:t(5,18)=(5,8)",128,0,203,0
	.stabs	"int_fast8_t:t(5,19)=(5,1)",128,0,217,0
	.stabs	"uint_fast8_t:t(5,20)=(5,2)",128,0,222,0
	.stabs	"int_fast16_t:t(5,21)=(5,3)",128,0,227,0
	.stabs	"uint_fast16_t:t(5,22)=(5,4)",128,0,232,0
	.stabs	"int_fast32_t:t(5,23)=(5,5)",128,0,237,0
	.stabs	"uint_fast32_t:t(5,24)=(5,6)",128,0,242,0
	.stabs	"int_fast64_t:t(5,25)=(5,7)",128,0,250,0
	.stabs	"uint_fast64_t:t(5,26)=(5,8)",128,0,257,0
	.stabs	"intmax_t:t(5,27)=(5,7)",128,0,277,0
	.stabs	"uintmax_t:t(5,28)=(5,8)",128,0,282,0
	.stabn	162,0,0,0
	.stabn	162,0,0,0
	.stabs	"int_farptr_t:t(3,1)=(5,5)",128,0,77,0
	.stabs	"uint_farptr_t:t(3,2)=(5,6)",128,0,81,0
	.stabn	162,0,0,0
	.stabn	162,0,0,0
	.stabs	"/usr/lib/avr/include/avr/fuse.h",130,0,0,0
	.stabs	"__fuse_t:t(6,1)=(6,2)=s3low:(0,13),0,8;high:(0,13),8,8;extended:(0,13),16,8;;",128,0,244,0
	.stabn	162,0,0,0
	.stabn	162,0,0,0
	.stabs	"__vector_1:F(0,49)",36,0,6,__vector_1
.global	__vector_1
	.type	__vector_1, @function
__vector_1:
	.stabd	46,0,0
	.stabn	68,0,6,.LM0-.LFBB1
.LM0:
.LFBB1:
	push r1	 ; 
	push r0	 ; 
	in r0,__SREG__	 ; ,
	push r0	 ; 
	clr __zero_reg__	 ; 
/* prologue: Signal */
/* frame size = 0 */
/* stack size = 3 */
.L__stack_usage = 3
	.stabn	68,0,7,.LM1-.LFBB1
.LM1:
	sbi 0x5,5	 ; ,
/* epilogue start */
	.stabn	68,0,8,.LM2-.LFBB1
.LM2:
	pop r0	 ; 
	out __SREG__,r0	 ; ,
	pop r0	 ; 
	pop r1	 ; 
	reti
	.size	__vector_1, .-__vector_1
.Lscope1:
	.stabs	"",36,0,0,.Lscope1-.LFBB1
	.stabd	78,0,0
	.section	.text.startup,"ax",@progbits
	.stabs	"main:F(0,1)",36,0,10,main
.global	main
	.type	main, @function
main:
	.stabd	46,0,0
	.stabn	68,0,10,.LM3-.LFBB2
.LM3:
.LFBB2:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	.stabn	68,0,11,.LM4-.LFBB2
.LM4:
	sbi 0x4,5	 ; ,
	.stabn	68,0,12,.LM5-.LFBB2
.LM5:
	cbi 0xa,2	 ; ,
	.stabn	68,0,13,.LM6-.LFBB2
.LM6:
	sbi 0xb,2	 ; ,
	.stabn	68,0,14,.LM7-.LFBB2
.LM7:
	sbi 0x1d,0	 ; ,
	.stabn	68,0,15,.LM8-.LFBB2
.LM8:
	lds r24,105	 ;  D.1640, MEM[(volatile uint8_t *)105B]
	ori r24,lo8(2)	 ;  D.1640,
	sts 105,r24	 ;  MEM[(volatile uint8_t *)105B], D.1640
	.stabn	68,0,16,.LM9-.LFBB2
.LM9:
/* #APP */
 ;  16 "main.c" 1
	sei
 ;  0 "" 2
/* #NOAPP */
.L3:
	rjmp .L3	 ; 
	.size	main, .-main
.Lscope2:
	.stabs	"",36,0,0,.Lscope2-.LFBB2
	.stabd	78,0,0
	.text
	.stabs	"",100,0,0,.Letext0
.Letext0:
	.ident	"GCC: (GNU) 5.4.0"
