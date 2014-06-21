#include <Servo.h>

/* 
 * Eingabe/Ausgabe - Hardware Hack
 * project: liquidTraffic
 * author: Felix Leupold
 */
 
/* 
 * just a test to get forward / backward signals from the toy car board
 * added servo (moves back and furth automatically)
 */
 
Servo myservo;
int servoPin = 9;

int servoCurrentPos = 0;
int servoDir = 1;

//forward
int analogFwdPin = 0;
int valFwd = 0;

//backwards
int analogBwdPin = 1;
int valBwd = 0;

int ledPin = 13;


void setup(){
  pinMode(ledPin, OUTPUT);
  myservo.attach(servoPin);
  
  Serial.begin(9600);
}

void loop(){
  //read analog pins for signals
  valFwd = analogRead(analogFwdPin);
  valBwd = analogRead(analogBwdPin);
  
  //log values, if we get a fwd or bwd signal
  if(valFwd != 0 || valBwd != 0){
    Serial.print("fwd: ");
    Serial.println(valFwd);
    
    Serial.print("bwd: ");
    Serial.println(valBwd);
    Serial.println("---------");
  }
  
  if(servoCurrentPos+servoDir > 179 || servoCurrentPos+servoDir < 0){
    servoDir = servoDir * -1;
  }
  
  servoCurrentPos = servoCurrentPos + servoDir;
  
  myservo.write(servoCurrentPos);

  digitalWrite(ledPin,HIGH);
  delay(5);
  digitalWrite(ledPin,LOW);
  delay(10);
}
