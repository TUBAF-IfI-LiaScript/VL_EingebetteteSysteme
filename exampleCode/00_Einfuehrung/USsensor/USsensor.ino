const int trigPin = 50;
const int echoPin = 52;

long duration;
int distance;

void setup() {
  pinMode(trigPin, OUTPUT); 
  pinMode(echoPin, INPUT); 
  Serial.begin(9600);
}

void loop() {
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);
  duration = pulseIn(echoPin, HIGH);
  // v = 0.034m/s
  // der Weg wird zwei mal zurückgelegt
  // s = t x v / 2
  distance= duration*0.034/2;
  Serial.print("Distance: ");
  Serial.println(distance);
}
