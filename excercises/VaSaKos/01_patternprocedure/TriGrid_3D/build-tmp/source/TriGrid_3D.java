import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import peasy.*; 
import nervoussystem.obj.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class TriGrid_3D extends PApplet {



PeasyCam camera;

ArrayList <GridLine> lines; 

float radius = 80;

float x, y, z;
float oldX, oldY, oldZ;
int depth = 400;

Boolean saveIt = false;
boolean record;

public void setup()
{
  size( 1000, 1000, P3D );
  beginRecord("nervoussystem.obj.OBJExport", "filename.obj");
  background( 0 );
  strokeWeight( 4 );
  stroke( 0, 255, 222);

  camera = new PeasyCam(this, width/2, height/2, depth/2, 1000);
  

  lines = new ArrayList<GridLine>();

  x = width/2;
  y = height/2;
  z = depth/2;

  oldX = x;
  oldY = y;
  oldZ = z;


}

public void drawGridlines() {
  for (int i = 0; i < lines.size();i++) {
    GridLine currline = lines.get(i);
    currline.display();
  }
}

public void draw() {
  background( 0 );


  if (record) {
    beginRecord("nervoussystem.obj.OBJExport", "filename.obj"); //starten der Aufnahme
  }


  GridLine newGridline = createNextLine(); 
  lines.add(newGridline);
  drawGridlines();
  updateCoordiantes();

  if (saveIt) {
    saveFrame("images/TriGrid-Sketch-#####.png");
    saveIt = true;
  }
  if (record) {
    endRecord();
    record = false; //Ende der Aufnahme
  }

}
public void updateCoordiantes() {
  oldX = x;
  oldY = y;
  oldZ = z;

}

public GridLine createNextLine() {

  float angle = (TWO_PI / 6) * floor(random(-6, 6));
  x += cos( angle ) * radius;
  y += sin( angle ) * radius;
  z += sin( angle ) * radius;


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

public void keyPressed()
{
  if (key == 's') {
    saveIt = true;
  }
  if (key == 'r') {
    record = true;
  }
}

class GridLine {
  PVector start, end;
  GridLine(PVector _start, PVector _end) {
    this.end = _end;
    this.start = _start;
  }

  public void display() {

    stroke( 0, 255, 222, 255 );
    strokeWeight( 2 );
    line( this.start.x, this.start.y, this.start.z, this.end.x, this.end.y, this.end.z );

    strokeWeight( 10 );
    point( this.end.x, this.end.y, this.end.z );

  }
}

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "TriGrid_3D" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
