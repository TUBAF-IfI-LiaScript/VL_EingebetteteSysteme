#include <Wire.h>
#include <LiquidCrystal_PCF8574.h>
#include <NewPing.h>

#define trigPin  12
#define echoPin  11
#define MAX_DISTANCE 350 // Maximum sensor distance is rated at 400-500cm.

int lcdi2c = 0x27; // <- Hart eingecodete Adresse, die nur für unser
                   // Beispiel funktioniert, vgl. Datenblatt

LiquidCrystal_PCF8574 lcd(lcdi2c);
NewPing sonar(trigPin, echoPin, MAX_DISTANCE); // NewPing setup of pins and maximum distance.

void setup()
{
  lcd.begin(16, 2);
  lcd.setBacklight(255);
  lcd.clear();

  Serial.begin(9600);
  Serial.print("Los geht's");
}

void loop()
{
  Serial.print("Dist---->: ");
  Serial.println(sonar.ping_cm());

  lcd.clear();
  lcd.setCursor(0, 0);
  lcd.print("#CrossLab 2023");
  lcd.setCursor(0, 1);
  int value = sonar.ping_cm();
  if (value >= 100)                   lcd.print("   ");
  if ((value < 100) && (value >=10))  lcd.print("    ");
  if (value < 10)                     lcd.print("     ");
  lcd.print(value);
  lcd.print(" cm");
  delay(400);
}