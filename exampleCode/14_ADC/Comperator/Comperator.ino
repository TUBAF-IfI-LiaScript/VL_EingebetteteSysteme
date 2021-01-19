#define F_CPU 16000000UL
#include <avr/io.h>

int main()
{
  ADCSRB = (1<<ACME);
  DDRB = (1<<PB5);
  
  while(1)
  {
    if (ACSR & (1<<ACO))/* Check ACO bit of ACSR register */
    PORTB = (1<<PB5); /* Turn ON PB5 pin */ 
    else    /* If ACO bit is zero */ 
    PORTB &= ~(1 << PB5); /* Then turn OFF PB5 pin */   
  } 
}
