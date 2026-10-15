#define F_CPU 16000000UL

#include <avr/io.h>
#include <avr/interrupt.h>

ISR(INT0_vect) {
  // Interrupt Service Routine für INT0
  PORTB |= (1 << PB5);
  Serial.print("Here!");
}

int main (void) {
   Serial.begin(9600);
   DDRB |= (1 << PB5);
   DDRD &= ~(1 << DDD2);    
   PORTD |= (1 << PORTD2);   
   EIMSK |= ( 1 << INT0);
   EICRA |= ( 1 << ISC01);
   sei(); 

   int i = 0;
   while (1) {
      Serial.print("Ich rechne fleißig ... ");
      Serial.println(i++);
      _delay_ms(50);
   }
   return 0;
}
