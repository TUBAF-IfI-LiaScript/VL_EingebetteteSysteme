// Input variable
const int pins[]  = {13, 12, 11}; 
int pin_count = sizeof(pins) / sizeof(pins[0]);
// Output variable
const char pin_var_Y = 7;
const char pin_var_Z = 5;

void readWritePin(int pin){
    int y = digitalRead(pin);    
    Serial.print(" ");
    Serial.print(y);  
    Serial.print(" "); 
}

void setup()
{
  Serial.begin(9600); 
  Serial.println("Logic analyzer - Version 1.0\n");
  
  for (int i=0; i<pin_count; i++){
    pinMode(pins[i], OUTPUT);
  }
  pinMode(pin_var_Y, INPUT);
  pinMode(pin_var_Z, INPUT);

  Serial.println(" A  B  C  Y  Z");
  Serial.println("---------------");

  for (char i = 0; i < 8; i++) {
    for (char bit = 2; bit >= 0; bit--) {
      // Anlegen der Pegel am IC
      
      if (i & (1 << bit)) {
        Serial.print(" 1 ");
        digitalWrite(pins[bit], HIGH);
      }
      else
      {
        Serial.print(" 0 ");
        digitalWrite(pins[bit], LOW);
      }
    }
    delay(1000);                       //Pause
    readWritePin(pin_var_Y);
    readWritePin(pin_var_Z);
    Serial.println(" ");               // Zeilenumbruch für die Darstellung
    delay(1000);
  }  
}

void loop () {

}
