int pinffwd = A0;
//Von Fabian

int pinbckwd = A1;
int pinright = A2;
int pinleft = A3;
 
void setup(){
  Serial.begin(9600);
  // use this only if you are on an Arduino Uno or sonething similar
  // and you are using the 3.3V Pin to power the rc-car
  // you also need to connect the AREF pin to the 3.3V pin
  analogReference(EXTERNAL);
}
 
void loop(){
  int left = analogRead(pinleft);
  int right = analogRead(pinright);
  int ffwd = analogRead(pinffwd);
  int bckwd = analogRead(pinbckwd);
 
  delay(100);
 
  if(left < 100){
    Serial.println("left");
  }
 
  if(right < 100){
    Serial.println("right");
  }
  if(ffwd < 100){
    Serial.println("ffwd");
  }
  if(bckwd < 100){
    Serial.println("backwd");
  }
 
}


![20140702-002](https://cloud.githubusercontent.com/assets/7230814/4355911/c106816e-4252-11e4-8c4c-2ae9ec2514a8.jpeg)

