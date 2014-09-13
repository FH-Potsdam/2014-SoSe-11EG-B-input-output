ArrayList <Particle> agents;

void setup() {
  size(800, 600);
  agents = new ArrayList<Particle>();
}

void draw() {
  for (int i = 0; i < agents.size();i++) {
    agents.get(i).run();
  }
  
}

  void mouseDragged(){
    agents.add(new Particle(mouseX,mouseY));
  }



class Particle {

  float x = 0;
  float y = 0;

  Particle(float _x, float _y) {
    x = _x;
    y = _y;
  } // Constructor

  void display() {
    fill(random(255), random(255));
    pushMatrix();
    translate(x, y);
    ellipse(0, 0, 10, 10);
    popMatrix();
  }

  void move() {
    x += random(-5, 5);
    y += random(-1, 1);

    x = constrain(x, 0, width);
    y = constrain(y, 0, height);
  }

  void run() {
    display();
    move();
  }
}

