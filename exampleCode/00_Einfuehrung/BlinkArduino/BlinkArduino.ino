char led_id=A2;

void setup() {
  pinMode(led_id, OUTPUT);
}


void loop() {
  digitalWrite(led_id, HIGH); 
  delay(1000); 
  digitalWrite(led_id, LOW); 
  delay(1000); 
}
