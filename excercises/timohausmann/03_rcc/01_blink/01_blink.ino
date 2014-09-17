int pin = 8;
int interval = 500;
int dir = -1;

void setup() {
  
  Serial.begin(9600);
  pinMode(pin, OUTPUT);
}


void loop() {
  
  interval += 50 * dir;
  
  if( dir == 1 && interval > 500 ) {
    interval = 500;
    dir = -1;
  }
  
  if( dir == -1 && interval < 50 ) {
    interval = 50;
    dir = 1;
  }
  
  Serial.println("WHEN I SAY HEY YOU SAY HO! HEY!"); 
  
  digitalWrite(pin, HIGH);
  delay(interval);
  
  Serial.println("HO!");
  
  digitalWrite(pin, LOW);  
  delay(interval);  
}