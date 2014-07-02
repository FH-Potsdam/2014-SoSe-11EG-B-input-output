#include <Servo.h>

/* 
 * Eingabe/Ausgabe - Hardware Hack
 * project: liquidTraffic
 * author: Felix Leupold
 */
 
/* 
 * now moves accordingly to remote control
 */
 
//servo
Servo myservo;

int servoMin = 45;
int servoMax = 105;

int servoPin = 9;
int servoCurrentPos = servoMin;
int servoDirBefore = 0;
int servoDir = 0;
long updateEvery = 1000 * 10;
long latestDirUpdate = updateEvery * -1;
int servoStep = 1;
int servoLockPosEvery = 10;
int lockPosToReach = servoCurrentPos;

//forward
int analogFwdPin = A0;
int valFwd = 0;

//backwards
int analogBwdPin = A1;
int valBwd = 0;

//pulse (left)
int pulsePin = A5;
int valPulse = 0;
int currentPulseState = 0;
int pulseAmplitude = 10;
int pulseStep = 2;
boolean doPulse = false;
int pulsePhase = 0;

//misc
int ledPin = 13;
int maxWaitPoints = 0;

void setup(){
  
  //are we living?
  pinMode(ledPin, OUTPUT);
  
  digitalWrite(ledPin, HIGH); 
  
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
  servoDirBefore = servoDir;
  servoDir = 0;
  
  //read analog pins for signals
  valFwd = analogRead(analogFwdPin);
  valBwd = analogRead(analogBwdPin);
//  valPulse = analogRead(pulsePin);
  valPulse = digitalRead(pulsePin);
  
  //log values, if we get a fwd or bwd signal
  if(valFwd > 100 || valBwd > 100){
    
    //log the values
//    Serial.print("fwd: ");
//    Serial.println(valFwd);
//    Serial.print("bwd: ");
//    Serial.println(valBwd);
//    Serial.print("pulse (left): ");
//    Serial.println(valPulse);

      
      Serial.println("time since update");
      Serial.println( (millis() - latestDirUpdate) );
    
    //are we moving forward or backwards?
    if(valFwd > 50 && valFwd > valBwd && valBwd < 50){
      
      if( (millis() - latestDirUpdate) > updateEvery ){
        latestDirUpdate = millis();
        lockPosToReach = constrain(servoCurrentPos + servoLockPosEvery, servoMin, servoMax);
      }
      
      Serial.println("--- > > > > > fwd");
    } else if(valBwd > 50 && valFwd < valBwd && valFwd < 50){
      
      if( (millis() - latestDirUpdate) > updateEvery ){
        latestDirUpdate = millis();
        lockPosToReach = constrain(servoCurrentPos + servoLockPosEvery * -1, servoMin, servoMax);
      }
      
      Serial.println("< < < < < --- bwd");
    }
    
    
  }
  
  Serial.println("lockPosToReach ");
  Serial.println(lockPosToReach);
  
  //check if lock pos is reached
  if(servoCurrentPos < lockPosToReach){
    servoDir = servoStep;
  } else if(servoCurrentPos > lockPosToReach){
    servoDir = servoStep * -1;
  }
  
  if(valPulse == LOW){
    Serial.println("PULSE!!! !!! !!! !!!");
    doPulse = true;
  } else {
    doPulse = false;
  }
  
  if(doPulse || pulsePhase != 0){
    
    servoDir = 0;
    
    if(pulsePhase == 0){
      pulsePhase = 1;
    }
    
    if(pulsePhase == 1){
      
      currentPulseState += pulseStep;
      servoCurrentPos += pulseStep;
      
      if(currentPulseState >= pulseAmplitude){
         pulsePhase++;
      }
      
      Serial.println("pulsePhase 0");
    }
    else if(pulsePhase == 2){
      
      currentPulseState += pulseStep * -1;
      servoCurrentPos += pulseStep * -1;
      
      if(currentPulseState <= (pulseAmplitude * -1) ){
         pulsePhase++;
      }
      
      Serial.println("pulsePhase 1");
    } else if(pulsePhase == 3) {
      
      currentPulseState += pulseStep;
      servoCurrentPos += pulseStep;
      
      if(currentPulseState >= 0){
        pulsePhase = 0;
        Serial.println("pulseEnd!");
      }
      
      Serial.println("pulsePhase 3");
    }
  }
  
  //add direction, if it's not getting out of degree bounds (min 0; max 179)  
  servoCurrentPos = constrain(servoCurrentPos + servoDir, servoMin, servoMax);
  
  //update servo, if position changed
  if(servoCurrentPos != servoBeforePos){
    Serial.println(servoCurrentPos);
    myservo.write(servoCurrentPos);
  }
  
  //just log something
  maxWaitPoints++;
  
  if(maxWaitPoints < 50){
    Serial.print(".");
  } else {
    Serial.println(".");
    maxWaitPoints = 0;
  }
  
  
  //give servo time to reach position
  delay( 50 );
}
