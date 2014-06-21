#include <Servo.h>

/* 
 * Eingabe/Ausgabe - Hardware Hack
 * project: liquidTraffic
 * author: Felix Leupold
 */
 
/* 
 * just a test to get forward / backward signals from the toy car board
 * added servo
 * now moves accordingly to remote control
 */
 
//servo
Servo myservo;
int servoPin = 9;
int servoCurrentPos = 90;
int servoDir = 0;
int servoStep = 5;

//forward
int analogFwdPin = 0;
int valFwd = 0;

//backwards
int analogBwdPin = 1;
int valBwd = 0;

//pulse (left)
int pulsePin = 2;
int valPulse = 0;

//misc
int ledPin = 13;


void setup(){
  
  //are we living?
  pinMode(ledPin, OUTPUT);
  digitalWrite(ledPin,HIGH); 
  
  //servo is connected to digital pin
  myservo.attach(servoPin);
  
  //start serial communication
  Serial.begin(9600);
  
  //setup
  myservo.write(servoCurrentPos);
  delay(15); //give servo time to reach position
  
  //this should not happen
  Serial.println("!!!!!!!!!!!!!!!!");
  Serial.println("!!!! REBOOT !!!!");
  Serial.println("!!!!!!!!!!!!!!!!");
}

void loop(){
  
  //save old position temp.
  int servoBeforePos = servoCurrentPos;
  
  //reset servo moving direction
  servoDir = 0;
  
  //read analog pins for signals
  valFwd = analogRead(analogFwdPin);
  valBwd = analogRead(analogBwdPin);
  valPulse = analogRead(pulsePin);
  
  //log values, if we get a fwd or bwd signal
  if(valFwd > 100 || valBwd > 100 || valPulse > 100){
    
    //log the values
    Serial.print("fwd: ");
    Serial.println(valFwd);
    Serial.print("bwd: ");
    Serial.println(valBwd);
    Serial.print("pulse (left): ");
    Serial.println(valPulse);
    Serial.println("---------");
    
    //are we moving forward or backwards?
    if(valFwd > 50 && valFwd > valBwd && valBwd == 0){
      servoDir = servoStep;
    } else if(valBwd > 50 && valFwd < valBwd && valFwd == 0){
      servoDir = servoStep * -1;
    }
  }
  
  //add direction, if it's not getting out of degree bounds (min 0; max 179)
  if(servoCurrentPos+servoDir <= 179 && servoCurrentPos+servoDir >= 0){
    servoCurrentPos = servoCurrentPos + servoDir;
  }
  
  //update servo, if position changed
  if(servoCurrentPos != servoBeforePos){
    Serial.print("new pos ");
    Serial.println(servoCurrentPos);
    myservo.write(servoCurrentPos);
    Serial.println("---------");
    Serial.println("---------");
  }
  
  //give servo time to reach position
  delay(15);
}
