#ifndef F_CPU
#define F_CPU 16000000UL // 16 MHz clock speed
#endif

#include <avr/io.h>
#include <util/delay.h>

int main(void)
{
  Serial.begin(9600);
  DDRB = 0;
  PORTB = 0xFF;
 
  TCCR1A = 0; // Normal Mode
  //         1024 als Prescale-Wert     Rising edge
  TCCR1B  = (1 << CS12) | (1 <<CS10) | (1 << ICES1);  
  TIFR1 = (1<<ICF1);
  //TIMSK1 |= (1 << ICIE1); // enable Interrupt

  while (1) //infinite loop
  {
      Serial.println("Waiting for Button push");
      Serial.flush();
      TCNT1 = 0;
      while ((TIFR1 & (1<<ICF1)) == 0);
      TIFR1 = (1<<ICF1);
      Serial.println(ICR1);
      Serial.flush();
      _delay_ms(500);
  }
  return  0;
}
