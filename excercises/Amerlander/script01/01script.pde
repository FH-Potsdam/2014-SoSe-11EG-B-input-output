Particle hans;

void setup(){
    size(800, 600);
}

void draw(){
hans = new Particle(10,10);
}


class Particle {
  
  float x = 0;
  float y = 0;
  
  Particle(float _x, float _y){
    x = _x;
    y = _y;
  } // Constructor
}