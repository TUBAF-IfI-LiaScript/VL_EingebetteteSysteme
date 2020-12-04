void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);

  pinMode(13, OUTPUT);
  pinMode(12, OUTPUT);
  pinMode(11, OUTPUT);

  pinMode(5, INPUT);
  pinMode(7, INPUT);

}

void loop() {
  // put your main code here, to run repeatedly:

  for (byte i = 0; i < 8; i++){  
    bool A = false;
    bool B = false;
    bool C = false;

    switch (i) {
      case 0: C = false; B = false; A = false; break;
      case 1: C = true; B = false; A = false; break;
      case 2: C = false; B = true; A = false; break;
      case 3: C = true; B = true; A = false; break;
      case 4: C = false; B = false; A = true; break;
      case 5: C = true; B = false; A = true; break;
      case 6: C = false; B = true; A = true; break;
      case 7: C = true; B = true; A = true; break;
    }
    
    out(A,B,C);
    delay(1500);
    Serial.print(i);
    Serial.print(": ");
    Serial.print(digitalRead(5));
    Serial.print(",");
    Serial.print(digitalRead(7));
    Serial.print(",");
    Serial.println(analogRead(0));
    delay(1500);

    

  }

}

void out(bool A, bool B, bool C) {
  if (A) {
    digitalWrite(13, HIGH);
  } else {
    digitalWrite(13, LOW);
  }

    if (B) {
    digitalWrite(12, HIGH);
  } else {
    digitalWrite(12, LOW);
  }

    if (C) {
    digitalWrite(11, HIGH);
  } else {
    digitalWrite(11, LOW);
  }
}
