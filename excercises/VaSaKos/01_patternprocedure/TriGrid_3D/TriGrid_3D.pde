import peasy.*;
PeasyCam camera;

ArrayList <GridLine> lines;   // angefangen mit der arraylist

float radius = 50;

float x, y, z;
float oldX, oldY, oldZ;
int depth = 800;

//Boolean fade = false;
Boolean saveIt = false;

void setup()
{
  size( 1000, 1000, P3D );
  background( 0 );
  strokeWeight( 2 );
  stroke( 0, 255, 222);

  camera = new PeasyCam(this, width/2, height/2, depth/2, 500);

  lines = new ArrayList<GridLine>();   // angefangen mit der arraylist

  x = width/2;
  y = height/2;
  z = depth/2;

  oldX = x;
  oldY = y;
  oldZ = z;

}

void drawGridlines() {
  for (int i = 0; i < lines.size();i++) {
    GridLine currline = lines.get(i);
    currline.display();
  }
}

void draw() {
  background( 0 );

  GridLine newGridline = createNextLine(); 
  lines.add(newGridline);
  drawGridlines();
  updateCoordiantes();

  if (saveIt) {
    saveFrame("images/TriGrid-Sketch-#####.png");
    saveIt = false;
  }
}
void updateCoordiantes() {
  oldX = x;
  oldY = y;
  oldZ = z;
}

GridLine createNextLine() {

  float angle = (TWO_PI / 6) * floor(random( -6, 6 ));
  x += cos( angle ) * radius;
  y += sin( angle ) * radius;
  z += cos( angle ) * radius;

  if ( x < 0 || x > width ) {
    x = oldX;
  }

  if ( y < 0 || y > height) {
    y = oldY;
  }
  if ( z < 0 || z > depth) {
    z = oldZ;
  }

  return new GridLine(new PVector(x, y, z), new PVector(oldX, oldY, oldZ));
}

void keyPressed()
{
  /*
    if (key == 'f') {
   fade = !fade;
   }
   */

  if (key == 's') {
    saveIt = true;
  }
}

class GridLine {
  PVector start, end;
  GridLine(PVector _start, PVector _end) {
    this.end = _end;
    this.start = _start;
  }

  public void display() {
    stroke( 0, 255, 222, 100 );
    strokeWeight( 2 );
    line( this.start.x, this.start.y, this.start.z, this.end.x, this.end.y, this.end.z );
  }
}

