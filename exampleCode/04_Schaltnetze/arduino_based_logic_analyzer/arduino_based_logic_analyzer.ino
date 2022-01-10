// Input variable
const char pin_var_A = 13;
const char pin_var_B = 12;
const char pin_var_C = 11;
// Output variable
const char pin_var_Y = 7;
const char pin_var_Z = 5;

pin_var_A = 16;

void setup()
{
  pinMode(pin_var_A, OUTPUT);
  pinMode(pin_var_B, OUTPUT);
  pinMode(pin_var_C, OUTPUT);
  pinMode(pin_var_Y, INPUT);
  pinMode(pin_var_Z, INPUT);
  
  Serial.begin(9600); 
  Serial.println("Logic analyzer - Version 1.0\n");
  Serial.println(" A  B  C  Y  Z");
  Serial.println("---------------");

  for (char i = 0; i < 8; i++) {
    for (char bit = 2; bit >= 0; bit--) {
      // Anlegen der Pegel am IC
      if (i & (1 << bit)) {
        Serial.print(" 1 ");
        if (bit == 2) digitalWrite(pin_var_C, HIGH);
        if (bit == 1) digitalWrite(pin_var_B, HIGH);
        if (bit == 0) digitalWrite(pin_var_A, HIGH);
      }
      else
      {
        Serial.print(" 0 ");
        if (bit == 2) digitalWrite(pin_var_C, LOW);
        if (bit == 1) digitalWrite(pin_var_B, LOW);
        if (bit == 0) digitalWrite(pin_var_A, LOW);
      }
    }

    delay(1000);                       //Pause
    int y = digitalRead(pin_var_Y);    // Einlesen des Wertes in die Variable Y
    Serial.print(" ");
    Serial.print(y);                   // Ausgabe des Wertes
    int z = digitalRead(pin_var_Z);    // Einlesen des Wertes in die Variable Z
    Serial.print("  ");
    Serial.print(z);                   // Ausgabe des Wertes
    Serial.println(" ");               // Zeilenumbruch für die Darstellung
    delay(1000);
  }  
}

void loop () {

}
