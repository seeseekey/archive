#include <Servo.h> 
 
Servo servo;

int pushButton=4;

int ledRed=3;
int ledGreen=2;
 
void setup() 
{ 
  pinMode(pushButton, INPUT);
  
  pinMode(ledRed, OUTPUT);
  pinMode(ledGreen, OUTPUT);
  
  servo.attach(9);
  
  digitalWrite(pushButton, HIGH); //Pull up Widerstand aktivieren
} 
 
 
void loop() 
{ 
  int pressed=digitalRead(pushButton);
  
  digitalWrite(ledGreen, LOW);
  digitalWrite(ledRed, HIGH);
  
  if(pressed==LOW)
  {
    digitalWrite(ledGreen, HIGH);
    digitalWrite(ledRed, LOW);
    
    servo.write(360);
    delay(2000); 
    servo.write(0);
  }
  
  delay(15);
} 
