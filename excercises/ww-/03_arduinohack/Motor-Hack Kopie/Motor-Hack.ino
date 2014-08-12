/*
  Motor
  turning a motor clock then counter clock wise
  
  This example is part of the Fritzing Creator Kit: www.fritzing.org/creatorkit.
*/

int motor_L=6;                    // motor Links Pin // Hoch
int motor_R=5;                    // motor Rechts Pin // Runter
int motor_Speed=3;                // speed Pin
int poti_one = A0;
int poti_two = A1;
int motoristrechts = 0;
int motoristlinks = 0;
int autovorwaerts_pin = 7;
int autorueckwaerts_pin = 8;
int autovorwaerts_pin_is_high = 1;
int autorueckwaerts_pin_is_high = 1;
void setup(){
  Serial.begin(9600);
  pinMode(motor_L,OUTPUT);        // pin Links declared as OUTPUT
  pinMode(motor_R,OUTPUT);        // pin Rechts declared as OUTPUT
  
  pinMode(autovorwaerts_pin, INPUT);
    pinMode(autorueckwaerts_pin, INPUT);
}

void loop(){
  int potival_one = analogRead(poti_one);
  autovorwaerts_pin_is_high = digitalRead(autovorwaerts_pin);
  autorueckwaerts_pin_is_high = digitalRead(autorueckwaerts_pin);
  
  if(autovorwaerts_pin_is_high == 0){
  digitalWrite(motor_R, LOW);
  digitalWrite(motor_L, HIGH);
  delay(5);
  digitalWrite(motor_L, LOW);
  // dreh in die eine richtung 
  
  }else if(autorueckwaerts_pin_is_high == 0){
  digitalWrite(motor_L, LOW);
  digitalWrite(motor_R, HIGH);
  delay(5);
  digitalWrite(motor_R, LOW);
  // dreh in die andere richtung
  
  } else if(autovorwaerts_pin_is_high == 1 && autorueckwaerts_pin_is_high == 1 ){
  digitalWrite(motor_R, LOW);
  digitalWrite(motor_L, LOW);
  // hier wird nicht gesendet
  }
//  int potival_two = analogRead(poti_two);
//  delay(100);  
  Serial.print("Poti one is: ");
  Serial.println(potival_one);
//  delay(100);  

//  Serial.print("Poti two is: ");
//  Serial.println(potival_two);
//  digitalWrite(motor_L, LOW);
//  digitalWrite(motor_R, HIGH);
//if(potival_two > 1000 || potival_two < 100){
 // stop motor
//}

//if(potival_two > 1000){
//  // der motor ist rechts
//  motoristlinks = 0;
//
//  motoristrechts = 1;
//}
//
//if(potival_two < 100){
//  // der motor ist rechts
//  
//  motoristrechts = 0;
//  motoristlinks = 1;
//}


//  delay(800);

  
/*  analogWrite(motor_A,2550);     // motor Links pin switched to HIGH (+5V)
  analogWrite(motor_B,-2550);      // motor Rechts pin switched to LOW  (GND)
  for (int i=-2550; i<2550; i+=500){     // count up to 255 in steps of five 
    analogWrite(motor_Speed,i);   // and write it as speed to the speed pin
    delay(120);                    // wait 20 ms
  }
  for (int i=2550; i>-2550; i-=500){    // count down from 255 to 0 by 5
    analogWrite(motor_Speed,i);  // and write it as speed to the speed pin
    delay(120);                   // wait 20 ms
  }

  digitalWrite(motor_A,LOW);     // motor A pin switched to HIGH (GND) 
  digitalWrite(motor_B,HIGH);    // motor B pin switched to LOW  (+5V)
  for (int i=-2550; i<2550; i+=500){    // count up to 255 in steps of five 
    analogWrite(motor_Speed,i);  // and write it as speed to the speed pin
    delay(120);                   // wait 20 ms
  }
  for (int i=2550; i>-2550; i-=500){    // count down from 255 to 0 by 5
    analogWrite(motor_Speed,i);  // and write it as speed to the speed pin
    delay(120);                   // wait 20 ms
  }*/
}


