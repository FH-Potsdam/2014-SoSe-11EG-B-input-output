import peasy.*;

PeasyCam cam;
Tree myTree;

void setup() {

  size(1280, 720, P3D);

  cam = new PeasyCam(this, 400);
  cam.setMinimumDistance(500);
  cam.setMaximumDistance(1500);
  cam.setDistance(1000);
  cam.setYawRotationMode();
  
  createTree();
}

void createTree() {
  
  myTree = new Tree(9, 20);
}

void draw() {

  background(255);
  lights();

  translate(0, 400, 0);

  myTree.update();
  myTree.paint();
}


void keyPressed() {
  
  if( key == 32 ) {
    createTree();
  }
}

