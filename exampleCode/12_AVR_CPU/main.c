#define F_CPU 8000000UL

#include <avr/io.h>
#include <util/delay.h>

int main (void) {

   int16_t a = 0x1020;
   int8_t b = 0xFF;
   int r = a * b;
   
   for (int i; i < r; i++) r+1;

   DDRB |= (1 << PB0);

   while(1) {
       PORTB ^= (1 << PB0);
       _delay_ms(254);
   }

   return 0;
}
