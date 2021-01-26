#ifndef F_CPU
#define F_CPU 16000000UL // 16 MHz clock speed
#endif

int main(void){
  Serial.begin(9600);
  DDRB |=  (1<<PORTB1); //Define OCR1A as Output 
  TCCR1A |= (1<<COM1A1) | (1<<WGM10);  //Set Timer Register   
  TCCR1B |= (1<<WGM12) | (1<<CS11); 
  OCR1A = 0;
  int timer;
  while(1) {
      while(timer < 255){ //Fade from low to high
         timer++;
         OCR1A = timer;
         _delay_ms(20);
         Serial.print("Auf ");
         Serial.println(timer);
      } 
      while(timer > 1){ //Fade from high to low
         timer--;
         OCR1A = timer;
         _delay_ms(20);
         Serial.print("Ab  ");
         Serial.println(timer);
      }
   }
}
