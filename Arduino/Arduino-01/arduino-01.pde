int ledPinRed1=13;
int ledPinYellow1=12;
int ledPinRed2=11;
int ledPinGreen=10;
int ledPinRed3=9;
int ledPinYellow2=8;
int ledPinRed4=7;

int soundKlack=6;
int soundSin=5;

void setup()
{
  pinMode(ledPinRed1, OUTPUT);
  pinMode(ledPinYellow1, OUTPUT);
  pinMode(ledPinRed2, OUTPUT);
  pinMode(ledPinGreen, OUTPUT);
  pinMode(ledPinRed3, OUTPUT);
  pinMode(ledPinYellow2, OUTPUT);
  pinMode(ledPinRed4, OUTPUT);
  
  pinMode(soundKlack, OUTPUT);
  pinMode(soundSin, OUTPUT);
}

void loop()
{
  blinkRed();
  
  sound();
  
  blinkGreen();

  sound();
  
  blinkYellow();
  
  sound();
  
  analogWrite(soundSin, 200);
  delay(100);
  analogWrite(soundSin, 0);
    
  analogWrite(soundSin, 500);
  delay(200);
  analogWrite(soundSin, 0);
    
  analogWrite(soundSin, 1000);
  delay(400);
  analogWrite(soundSin, 0);
}

void sound()
{
  digitalWrite(soundKlack, LOW);
  delay(100);
  digitalWrite(soundKlack, HIGH);
}

void blinkRed()
{
  digitalWrite(ledPinRed1, HIGH);
  digitalWrite(ledPinRed2, HIGH);
  digitalWrite(ledPinRed3, HIGH);
  digitalWrite(ledPinRed4, HIGH);
  delay(500);
  digitalWrite(ledPinRed1, LOW);
  digitalWrite(ledPinRed2, LOW);
  digitalWrite(ledPinRed3, LOW);
  digitalWrite(ledPinRed4, LOW);
}

void blinkYellow()
{
  digitalWrite(ledPinYellow1, HIGH);
  digitalWrite(ledPinYellow2, HIGH);
  delay(500);
  digitalWrite(ledPinYellow1, LOW);
  digitalWrite(ledPinYellow2, LOW);
}

void blinkGreen()
{
  digitalWrite(ledPinGreen, HIGH);
  delay(500);
  digitalWrite(ledPinGreen, LOW);
}
