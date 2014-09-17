int motor_A=5;                    // motor A Pin
int motor_B=3;                    // motor B Pin
int motor_Speed=6;                // speed Pin

int motor_in_A = 13;
int motor_in_B = 12;

void setup() {

  pinMode(motor_A,OUTPUT);
  pinMode(motor_B,OUTPUT);
  pinMode(motor_Speed,OUTPUT);  
  
  pinMode(motor_in_A,INPUT);
  pinMode(motor_in_B,INPUT);
  
  Serial.begin(9600);
}

void loop() {

  int sensor_A = digitalRead( motor_in_A );
  int sensor_B = digitalRead( motor_in_B );  
  
  if (sensor_A == 0 && sensor_B == 1) {
    analogWrite(motor_Speed,10);
    digitalWrite(motor_A,HIGH);
    digitalWrite(motor_B,LOW);
  } else if (sensor_A == 1 && sensor_B == 0) {
    analogWrite(motor_Speed,10);
    digitalWrite(motor_A,LOW);
    digitalWrite(motor_B,HIGH);
  } else {
    analogWrite(motor_Speed,0);
    digitalWrite(motor_A,LOW);
    digitalWrite(motor_B,LOW);
  }
  
  delay(1);
}