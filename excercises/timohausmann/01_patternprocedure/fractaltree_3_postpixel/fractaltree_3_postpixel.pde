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

  pushMatrix();
  rotateX(PI/2);
  stroke(64);
  noFill();
  rect(-400, -400, 800, 800);
  popMatrix();  

  myTree.update();
  myTree.paint();

// loadPixels();
// for (int i = 0; i < (width*height)-16; i+=16) {
//   pixels[i] = color(255,0,0);
// }
// updatePixels();

boolean[] myPixel = new boolean[width*height];

loadPixels();

  int col = 0;
  int row = 0;
  int grid = 2;

  while(((col) + (row*width)) < width*height) {

    if( pixels[(col) + (row*width)] != color(255) ) {
      myPixel[(col) + (row*width)] = true;
    }

    col += grid;

    if(col > width) {
      col = 0;
      row += grid;
    }

  }

updatePixels();

 background(255);

 loadPixels();
 for(int i=0;i<myPixel.length;i++) {
  if( myPixel[i] ) {
    pixels[i] = color(0);
  }
  
 }
 updatePixels();
}


void keyPressed() {
  
  if( key == 32 ) {
    createTree();
  }
}

