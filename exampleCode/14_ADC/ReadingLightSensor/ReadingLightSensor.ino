#ifndef F_CPU
#define F_CPU 16000000UL // 16 MHz clock speed
#endif

#include <avr/io.h>
#include <util/delay.h>

int readADC(int channel) {
  int i; int result = 0;
  // Den ADC aktivieren und Teilungsfaktor auf 64 stellen
  ADCSRA = (1<<ADEN) | (1<<ADPS2) | (1<<ADPS1);
  // Kanal des Multiplexers & Interne Referenzspannung (2,56 V)
  ADMUX = channel | (1<<REFS1) | (1<<REFS0);
  // Den ADC initialisieren und einen sog. Dummyreadout machen
  ADCSRA |= (1<<ADSC);
  while(ADCSRA & (1<<ADSC));
  //4 Leseoperationen
  for(i=0; i<4; i++) {
    ADCSRA |= (1<<ADSC);
    while(ADCSRA & (1<<ADSC)); // Auf Ergebnis warten...
    result += ADCW; }
  // ADC wieder deaktivieren
  ADCSRA &= ~(1<<ADEN);
  return result>>2;
}

int main(void)
{
  Serial.begin(9600);
  while (1) //infinite loop
  {
    int result = readADC(0);
    Serial.println(result);
    Serial.flush();
    _delay_ms(10); //1 second delay
  }
  return  0; // wird nie erreicht
}
