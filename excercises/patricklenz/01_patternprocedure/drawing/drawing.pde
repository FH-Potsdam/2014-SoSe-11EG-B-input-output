SuperStrecke Strecke;
float ROTATION_PARAM = 45;     // Winkel
float MOTION_SCALE   = 8.0;    // Skalierung (Länge der einzelnen Teile)
float BIAS           = 50;    // Beeinflussung der Richtung (Rechts oder links abknicken)
byte  DIRECT_SWITCH  = 5;      // Zeit, wann Richtung gewechselt werden soll
 
 

void setup()
{
  size(800,800);
  //background(255);
 
  Strecke=new SuperStrecke(new PVector(width/2, height/2), new PVector(1,0,0)); //Startpunkt
}
 
 
void draw()
{
  Strecke.run(); //Los!
}


class SuperStrecke
{
  //CLASS VARIABLES
  PVector pos;            // Aktuelle Position
  PVector vel;            // Aktuelle Geschwindigkeit -- here we are simply calculating the vector to the next Strecke position (nextPos = pos + velocity)
  PVector[] posHistory;     
  int tCounter;           
  boolean stopped;        
 
  //CLASS CONSTRUCTOR
  SuperStrecke(PVector _P, PVector _V){
     // the starting point
     pos      = _P;          
    // the starting velocity
    vel      = _V;     
     // appearance
    tCounter = 0;       
    stopped  = false;
    posHistory = new PVector[0];
    posHistory = (PVector[]) append( posHistory, pos.get() );
  }
 
  //CLASS BEHAVIORS
 
  
  void run(){
    // calculate new position
    if(!stopped){
      updatePos();
      constrain2Borders();
    }
    // Call drawing methods
    renderStrecke();
  }
 
  
  void updatePos(){
    if(tCounter < DIRECT_SWITCH){
      // make the new position
      vel.normalize();
      vel.mult(MOTION_SCALE);
      pos.add(vel);
      tCounter++;
    }else{
      // change direction -- here we use a random switch!
      if(random(1) > 0.35) vel = vectorRotate(2, vel, ROTATION_PARAM);
      else vel = vectorRotate(2, vel, -ROTATION_PARAM);
      vel.normalize();      
      vel.mult(MOTION_SCALE);
      pos.add(vel);
      tCounter = 1;
    }
    posHistory = (PVector[]) append( posHistory, pos.get() );
  }
 
  // Strecke zeichnen
  void renderStrecke(){    
    stroke(0);
    strokeWeight(2);
    noFill();
    
    line( posHistory[posHistory.length-2].x, posHistory[posHistory.length-2].y, posHistory[posHistory.length-1].x, posHistory[posHistory.length-1].y );
  }
 
  // Anhalten, wenn Fenster verlassen wird
  void constrain2Borders(){
    if(pos.x < 0) stopMe();
    if(pos.y < 0) stopMe();
    if(pos.x > width) stopMe();
    if(pos.y > height) stopMe();
  }
 
  // Eigentliche Stop Funktion
  void stopMe(){
    stopped = true;
    posHistory = (PVector[]) append( posHistory, pos.get() );
    
    
    // Für die Präsentation only
    //background(255);
    setup();
  }
 
 
  // Vektor Kacke da
 
  //----------------------------------------------------- ROTATE ABOUT CARDINAL AXIS (THETA SHOULD BE IN DEGREES!!!)  
  PVector vectorRotate(int AXIS, PVector V, float ANGLE){
 
    //------ convert angle in degres to radians --- all trig uses radians!
    float rotationParam = radians(ANGLE);  
 
    //------ get the values out of the incoming vector!
    float xx = V.x; 
    float yy = V.y; 
    float zz = V.z; 
 
    //------ X AXIS
    if(AXIS == 0){
      yy = V.y * cos(rotationParam) - V.z * sin(rotationParam);
      zz = V.y * sin(rotationParam) + V.z * cos(rotationParam);
    }    
    //------ Y AXIS
    if(AXIS == 1){      
      xx = V.z * sin(rotationParam) + V.x * cos(rotationParam);  
      zz = V.z * cos(rotationParam) - V.x * sin(rotationParam);          
    }    
    //------ Z AXIS
    if(AXIS == 2){
      xx = V.x * cos(rotationParam) - V.y * sin(rotationParam);
      yy = V.x * sin(rotationParam) + V.y * cos(rotationParam);
    }   
    PVector result = new PVector(xx,yy,zz);
    return result.get();
  }
 
}
