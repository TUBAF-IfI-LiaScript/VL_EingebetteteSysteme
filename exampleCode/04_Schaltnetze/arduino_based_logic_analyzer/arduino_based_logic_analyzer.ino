// Input variable
const char pin_var_A=5;          // An die zugehörigen Pins kann ich mich nicht 
const char pin_var_B=6;          // mehr erinnern. Diese müssten Sie direkt am 
const char pin_var_C=7;          // Board ablesen
// Output variable
const char pin_var_Y=9;

void setup() {
  pinMode(LED_BUILTIN, OUTPUT);  // Control light
  pinMode(pin_var_A, OUTPUT);
  pinMode(pin_var_B, OUTPUT);
  pinMode(pin_var_C, OUTPUT);
  pinMode(pin_var_Y, INPUT);
  Serial.begin(9600);            // Konfiguration der seriellen Schnittstelle
  
  digitalWrite(LED_BUILTIN, HIGH);  
  Serial.println("Evaluating truth table !");
  Serial.println("A B C Y\n--------\n");
  for (char i=0; i<8; i++){
    for (char bit=2; bit>=0; bit--){
    	if (i & (1<<bit)){         // Bisher erfolgt hier nur die Ausgabe
    		Serial.print("1 ");      // Sie müssten die Bits noch setzen und löschen
    	}                          // sowie das Ergebnis einlesen
      else{
      	Serial.print("0 ");
      }
    }
    Serial.println("");
  }
}

void loop() {

}
