# 1 "main.c"
# 1 "/home/zug/Desktop/VL_EingebetteteSysteme/exampleCode/15_Timer/ExternalInterruptASMGeneration//"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "main.c"


# 1 "/usr/lib/avr/include/avr/io.h" 1 3
# 99 "/usr/lib/avr/include/avr/io.h" 3
# 1 "/usr/lib/avr/include/avr/sfr_defs.h" 1 3
# 126 "/usr/lib/avr/include/avr/sfr_defs.h" 3
# 1 "/usr/lib/avr/include/inttypes.h" 1 3
# 37 "/usr/lib/avr/include/inttypes.h" 3
# 1 "/usr/lib/gcc/avr/5.4.0/include/stdint.h" 1 3 4
# 9 "/usr/lib/gcc/avr/5.4.0/include/stdint.h" 3 4
# 1 "/usr/lib/avr/include/stdint.h" 1 3 4
# 125 "/usr/lib/avr/include/stdint.h" 3 4

# 125 "/usr/lib/avr/include/stdint.h" 3 4
typedef signed int int8_t __attribute__((__mode__(__QI__)));
typedef unsigned int uint8_t __attribute__((__mode__(__QI__)));
typedef signed int int16_t __attribute__ ((__mode__ (__HI__)));
typedef unsigned int uint16_t __attribute__ ((__mode__ (__HI__)));
typedef signed int int32_t __attribute__ ((__mode__ (__SI__)));
typedef unsigned int uint32_t __attribute__ ((__mode__ (__SI__)));

typedef signed int int64_t __attribute__((__mode__(__DI__)));
typedef unsigned int uint64_t __attribute__((__mode__(__DI__)));
# 146 "/usr/lib/avr/include/stdint.h" 3 4
typedef int16_t intptr_t;




typedef uint16_t uintptr_t;
# 163 "/usr/lib/avr/include/stdint.h" 3 4
typedef int8_t int_least8_t;




typedef uint8_t uint_least8_t;




typedef int16_t int_least16_t;




typedef uint16_t uint_least16_t;




typedef int32_t int_least32_t;




typedef uint32_t uint_least32_t;







typedef int64_t int_least64_t;






typedef uint64_t uint_least64_t;
# 217 "/usr/lib/avr/include/stdint.h" 3 4
typedef int8_t int_fast8_t;




typedef uint8_t uint_fast8_t;




typedef int16_t int_fast16_t;




typedef uint16_t uint_fast16_t;




typedef int32_t int_fast32_t;




typedef uint32_t uint_fast32_t;







typedef int64_t int_fast64_t;






typedef uint64_t uint_fast64_t;
# 277 "/usr/lib/avr/include/stdint.h" 3 4
typedef int64_t intmax_t;




typedef uint64_t uintmax_t;
# 10 "/usr/lib/gcc/avr/5.4.0/include/stdint.h" 2 3 4
# 38 "/usr/lib/avr/include/inttypes.h" 2 3
# 77 "/usr/lib/avr/include/inttypes.h" 3
typedef int32_t int_farptr_t;



typedef uint32_t uint_farptr_t;
# 127 "/usr/lib/avr/include/avr/sfr_defs.h" 2 3
# 100 "/usr/lib/avr/include/avr/io.h" 2 3
# 272 "/usr/lib/avr/include/avr/io.h" 3
# 1 "/usr/lib/avr/include/avr/iom328p.h" 1 3
# 273 "/usr/lib/avr/include/avr/io.h" 2 3
# 627 "/usr/lib/avr/include/avr/io.h" 3
# 1 "/usr/lib/avr/include/avr/portpins.h" 1 3
# 628 "/usr/lib/avr/include/avr/io.h" 2 3

# 1 "/usr/lib/avr/include/avr/common.h" 1 3
# 630 "/usr/lib/avr/include/avr/io.h" 2 3

# 1 "/usr/lib/avr/include/avr/version.h" 1 3
# 632 "/usr/lib/avr/include/avr/io.h" 2 3






# 1 "/usr/lib/avr/include/avr/fuse.h" 1 3
# 239 "/usr/lib/avr/include/avr/fuse.h" 3
typedef struct
{
    unsigned char low;
    unsigned char high;
    unsigned char extended;
} __fuse_t;
# 639 "/usr/lib/avr/include/avr/io.h" 2 3


# 1 "/usr/lib/avr/include/avr/lock.h" 1 3
# 642 "/usr/lib/avr/include/avr/io.h" 2 3
# 4 "main.c" 2
# 1 "/usr/lib/avr/include/avr/interrupt.h" 1 3
# 5 "main.c" 2

void __vector_1 (void) __attribute__ ((signal,used, externally_visible)) ; void __vector_1 (void) 
# 6 "main.c"
              {
  
# 7 "main.c" 3
 (*(volatile uint8_t *)((0x05) + 0x20)) 
# 7 "main.c"
       |= (1 << 
# 7 "main.c" 3
                5
# 7 "main.c"
                   );
}

int main (void) {
   
# 11 "main.c" 3
  (*(volatile uint8_t *)((0x04) + 0x20)) 
# 11 "main.c"
       |= (1 << 
# 11 "main.c" 3
                5
# 11 "main.c"
                   );
   
# 12 "main.c" 3
  (*(volatile uint8_t *)((0x0A) + 0x20)) 
# 12 "main.c"
       &= ~(1 << 
# 12 "main.c" 3
                 2
# 12 "main.c"
                     );
   
# 13 "main.c" 3
  (*(volatile uint8_t *)((0x0B) + 0x20)) 
# 13 "main.c"
        |= (1 << 
# 13 "main.c" 3
                 2
# 13 "main.c"
                       );
   
# 14 "main.c" 3
  (*(volatile uint8_t *)((0x1D) + 0x20)) 
# 14 "main.c"
        |= ( 1 << 
# 14 "main.c" 3
                  0
# 14 "main.c"
                      );
   
# 15 "main.c" 3
  (*(volatile uint8_t *)(0x69)) 
# 15 "main.c"
        |= ( 1 << 
# 15 "main.c" 3
                  1
# 15 "main.c"
                       );
   
# 16 "main.c" 3
  __asm__ __volatile__ ("sei" ::: "memory")
# 16 "main.c"
       ;
   while (1);
   return 0;
}
