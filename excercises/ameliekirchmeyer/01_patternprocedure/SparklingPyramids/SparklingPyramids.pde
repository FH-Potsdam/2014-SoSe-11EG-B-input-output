// Amelie Kirchmeyer - April 2014

ArrayList<Polygon> mylines;

void setup() {
  
  size(1500, 1500);
  frameRate(10);
  mylines = new ArrayList<Polygon>();
  generate();
}

void draw() {
  
  background(0);
  ellipse(width/2, height/2, 5, 5);
  for (int i = 0; i < mylines.size(); i++) {
    Polygon current = mylines.get(i);
    current.display();
  }
}

class Polygon {
  
  PVector start;
  PVector aim;
  
  Polygon() {
    start = new PVector(width/2, height/2);
    aim = new PVector(random(50, height-50), random(50, height-50));
  }
  
  void display() {
    stroke(255);
    line(start.x, start.y, aim.x, aim.y);
    for(int i = 0; i < mylines.size(); i++) {
       Polygon current = mylines.get(i);
       line(aim.x, aim.y, current.aim.x, current.aim.y);
       ellipse(current.aim.x, current.aim.y, 5, 5);
    }
  }
}

void generate() {
  
  mylines.clear();
  float amount = random(2, 10);
  for (int i = 0; i < amount; i++) {
    mylines.add(new Polygon());
  }
}

void keyPressed() {
  
  if(key == 'n') {
    generate();
  }
  
  if(key == 's') {
    saveFrame("objekt-#####.png");
    println(frameCount);
  }
}
