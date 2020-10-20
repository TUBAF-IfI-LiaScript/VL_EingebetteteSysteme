#include <avr/io.h>
#include <util/delay.h>

int main (void) {

   DDRF |= (1 << PF2);

   while(1) {
       PORTF ^= (1 << PF2);
       _delay_ms(500);
   }

   return 0;
}
