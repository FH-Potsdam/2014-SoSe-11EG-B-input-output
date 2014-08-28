int forward = 11;
int backward = 12;
int is_f_high = 1;
int is_b_high = 1;
#include <Servo.h>
int my_delay_value = 500;
int motor_A=5;
int motor_B=4;
int motor_Speed=3;

Servo myservo;  

int pos = 0;    // Sorvo startposition = 0 

void setup () {
  pinMode (forward, INPUT);
  pinMode (backward, INPUT);
  Serial.begin (9600);
  myservo.attach(13);  // Servo Steuerung auf Pin 13
  pinMode(motor_A,OUTPUT);
  pinMode(motor_B,OUTPUT); 
}

void loop () {
  is_f_high = digitalRead (forward);
  is_b_high = digitalRead (backward);

  if (is_f_high == 0) {

    Serial.println ("FORWARD");
    my_delay_value = 3000;          //Bügel Lange auf (Wenn mehr Besucher auf der Website)
    digitalWrite(motor_A,HIGH);
    analogWrite(motor_Speed,255);    // Motorgeschwindigkeit Schnell
  }

  if (is_b_high == 0) {

    Serial.println ("BACKWARD");
    my_delay_value = 500;            //Bügel kurz auf (Wenn weniger Besucher auf der Website)

    digitalWrite(motor_B,LOW);
    analogWrite(motor_Speed,200);   //Motorgeschwindigkeit langsam 


  }

  delay (100);

  myservo.write(65);              //Bügelöffnung in kurzen Schritten (Servo)
  delay(1000);                       
  myservo.write(68);               
  delay(80);                       
  myservo.write(70);              
  delay(80);                      
  myservo.write(72);               
  delay(80);                       
  myservo.write(74);              
  delay(80);                       
  myservo.write(76);              
  delay(80);                       
  myservo.write(78);              
  delay(80);                       
  myservo.write(80);              
  delay(80);                       
  myservo.write(82);             
  delay(80);                       
  myservo.write(84);              
  delay(80);                       
  myservo.write(86);               
  delay(80);                       
  myservo.write(88);              
  delay(80);                       
  myservo.write(90);             
  delay(my_delay_value);                      
}











