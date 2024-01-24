#include <Arduino.h>
#include <stdint.h> // intxx_t und uintxx_t als Datentypen

int main(void)
{
  uint16_t result = 0;
 
  // enable ADC
  ADCSRA |= (1 << ADEN);
  // Setting the voltage reference to Arduino Input Power
  ADMUX |= (1<<REFS0);
  ADMUX &= ~(1<<REFS1);
  // ADC Frequency should be between 50kHz and 200kHz, Arduiono clock is 16MHz
  // setup the prescaler to 128 to get ADC Frequency of 16MHz/128 = 125kHz
  ADCSRA |= (1 << ADPS2) | (1 << ADPS1) | (1<<ADPS0);
  // set the ADC channel to ADC0
  ADMUX &= ~((1<<MUX3)|(1<<MUX2)|(1<<MUX1)|(1<<MUX0));
  // warmlaufen des ADC mittels "Dummy-Readout"
  // ADC starten
  ADCSRA |= (1<<ADSC);
  // wait till conversion finished 
  while (ADCSRA & (1<<ADSC)) {}
  // Preparation finished

  Serial.begin(9600);

  // Start continuous conversion 
  while (1)
  {
    result = 0;
    // start the conversion
    ADCSRA |= (1 << ADSC);
    // wait until it's finished
    while (ADCSRA & (1<<ADSC)) {}
    // get the result
    result = ADCW;
    
    Serial.print(result);
    Serial.print("\n");
    Serial.flush();
  }
 
  return 0;
}
