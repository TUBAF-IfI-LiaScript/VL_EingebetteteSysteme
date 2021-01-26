#define F_CPU 16000000UL

#include <avr/io.h>
#include <avr/interrupt.h>

// Interrupt subroutine for ADC conversion complete interrupt
ISR(ADC_vect) {
   Serial.println(ADCW); 
   if(ADCW >= 600)            
       PORTB |= (1 << PB5);
   else
       PORTB &=~(1 << PB5);
   ADCSRA |= (1<<ADSC);       
}

int main(void)
{
    Serial.begin(9600);
    DDRB |= (1 << PB5);  
    ADMUX = (1<<REFS0);  
    ADCSRA |= (1 << ADPS2) | (1 << ADPS1) | (1<<ADPS0) | (1<<ADEN)|(1<<ADIE);              
    sei();                            // Set the I-bit in SREG
    ADCSRA |= (1<<ADSC);              // Start the first conversion
    
    int i = 0;
    while (1) {
       Serial.print("Ich rechne fleißig ... ");
       Serial.println(i++);
       _delay_ms(50);
    }

    return 0;                         // This line will never be executed

}
