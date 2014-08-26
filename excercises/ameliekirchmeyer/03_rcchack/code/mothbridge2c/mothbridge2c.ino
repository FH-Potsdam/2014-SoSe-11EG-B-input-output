// AMELIE KIRCHMEYER
// REMOTE CONTROLLED CAR HACK
// EINGABE. AUSGABE. - PROF. MONIKA HOINKIS & FABIAN MORON ZIRFAS
// SOMMERSEMESTER 2014

int PIN_B = 7;
int PIN_F = 8;
int PIN_B_high = 1;
int PIN_F_high = 1;
int motorspeed = 255;

int motor_1_A=6;                    // motor A Pin
int motor_1_B=5;                    // motor B Pin
int motor_1_speed=3;                // speed Pin

int motor_2_A=11;                    // motor A Pin
int motor_2_B=10;                    // motor B Pin
int motor_2_speed=9;                // speed Pin

void setup() {
  pinMode(PIN_B, INPUT);
  pinMode(PIN_F, INPUT);
  pinMode(motor_1_A,OUTPUT);        // pin A declared as OUTPUT
  pinMode(motor_1_B,OUTPUT);        // pin B declared as OUTPUT
  pinMode(motor_2_A,OUTPUT);        // pin A declared as OUTPUT
  pinMode(motor_2_B,OUTPUT);        // pin B declared as OUTPUT
  
  Serial.begin(9600);
}

void loop() {
  
  PIN_B_high = digitalRead(PIN_B);
  PIN_F_high = digitalRead(PIN_F);
  
  if(PIN_B_high == 0) {
    Serial.println("running backwards");
    digitalWrite(motor_1_B, LOW);
    digitalWrite(motor_1_A, HIGH);
    analogWrite(motor_1_speed, motorspeed);
    delay(2000);
    digitalWrite(motor_1_A, LOW);
    delay(1000);
    digitalWrite(motor_2_B, LOW);
    digitalWrite(motor_2_A, HIGH);
    analogWrite(motor_2_speed, motorspeed);
    delay(2000);
    digitalWrite(motor_2_A, LOW);
    delay(1000);
  }
  
  else if(PIN_F_high == 0) {
    Serial.println("running forward");
    digitalWrite(motor_1_A, LOW);
    digitalWrite(motor_1_B, HIGH);
    analogWrite(motor_1_speed, motorspeed);
    delay(2000);
    digitalWrite(motor_1_B, LOW);
    delay(1000);
    digitalWrite(motor_2_A, LOW);
    digitalWrite(motor_2_B, HIGH);
    analogWrite(motor_2_speed, motorspeed);
    delay(2000);
    digitalWrite(motor_2_B, LOW);
    delay(1000);
  }
  
  else if(PIN_F_high == 1 && PIN_B_high == 1) {
    digitalWrite(motor_1_A, LOW);
    digitalWrite(motor_1_B, LOW);
    analogWrite(motor_1_speed, 0);
    digitalWrite(motor_2_A, LOW);
    digitalWrite(motor_2_B, LOW);
    analogWrite(motor_2_speed, 0);
  }
}
