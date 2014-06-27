int pin_B = 8;
int pin_F = 7;
int didsomething = 0;

int poti = A0;
int poti_speed = A5;
int motor_FFWD=6;                    // motor A Pin
int motor_BCKWD=5;                    // motor B Pin
int motor_Speed=3;                // speed Pin
int is_b_high = 1;
int is_f_high = 1;
int motor_SPEED = 3;
int speed_val = 200;

void setup(){
  pinMode(pin_B, INPUT);
  pinMode(pin_F, INPUT);
  pinMode(motor_FFWD,OUTPUT);        // pin FFWD declared as OUTPUT
  pinMode(motor_BCKWD,OUTPUT);        // pin BCKWD declared as OUTPUT

}

void loop(){
  int is_b_high = digitalRead(pin_B);
  int is_f_high = digitalRead(pin_F);
//   speed_val = map(analogRead(poti_speed),0,1023,0,255);

  if(is_b_high == 0 && didsomething == 0){
    //   run bckwd
    digitalWrite(motor_FFWD, LOW);
    digitalWrite(motor_BCKWD, HIGH);
    analogWrite(motor_SPEED, speed_val);
    delay(5);
    digitalWrite(motor_BCKWD, LOW);
    didsomething = 1;
  }
   if(is_f_high == 0 && didsomething == 0){
    // run ffwd
    digitalWrite(motor_BCKWD, LOW);
    digitalWrite(motor_FFWD, HIGH);
    analogWrite(motor_SPEED, speed_val);
    delay(5);
    digitalWrite(motor_BCKWD, LOW);
    didsomething = 1;
  }
   if (is_b_high == 1 && is_f_high == 1){
    // do nothing
    digitalWrite(motor_BCKWD, LOW);
    digitalWrite(motor_FFWD, LOW);
    didsomething = 0;

  }




}





