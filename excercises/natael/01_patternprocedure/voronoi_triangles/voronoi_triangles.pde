
import toxi.geom.*;
import toxi.geom.mesh2d.*;
import peasy.*;
import joons.JoonsRenderer;


// camera fov settings
float fov = PI / 1.5;
float aspect = 4/3f;
float zNear = 5;
float zFar = 10000;

// voronoi settings
float DSIZE = 1000000;
float noiseValue = 0.0;
int points = 50;

// timestamp
String timestamp;

// init objects
Voronoi voronoi;
PeasyCam cam;
JoonsRenderer jr;


void setup() {
  size(1280, 800, P3D);
  smooth();
  jr = new JoonsRenderer(this);

  // render settings
  jr.setSizeMultiplier(2);
  /*
  jr.setSampler("bucket");
  jr.setSizeMultiplier(1);
  jr.setAA(0, 2, 4); //setAA(minAA, maxAA, AASamples), increase AASamples to increase blur fidelity.
  jr.setCaustics(20);
  jr.setDOF(130, 3);
  */

  cam = new PeasyCam(this, width / 2, height / 2, 0, 500);
  voronoi = new Voronoi(DSIZE);

  noiseSeed(300);

  for(int x = 0; x < points; x++) {
    voronoi.addPoint(new Vec2D(random(0, width), random(0, height)));
  }

}

void draw() {
  jr.beginRecord();

  background(0);
  jr.background(0);

  perspective(fov, aspect, zNear, zFar);

  lights();


  // lighting from two sides!
  // 241, 156, 18
  // 4 is to dark
  // jr.fill("light", 115, 74, 8, 50);
  jr.fill("light", 89, 57, 6, 50);
  int z = 50;
  beginShape(QUADS);
    vertex(-z - 500, -z, 1000);
    vertex(-z - 500, z, 1000);
    vertex(z, z, 1200);
    vertex(z, -z, 1200);
  endShape();

  // 26, 188, 156
  // 9 is to dark
  jr.fill("light", 15, 102, 85, 50);
  int o = 50;
  beginShape(QUADS);
    vertex(900, -o, 1200);
    vertex(900, o, 1200);
    vertex(1400, o, 1000);
    vertex(1400, -o, 1000);
  endShape();


  // plane
  jr.fill("diffuse");
  int w = 10000;
  beginShape(QUADS);
    vertex(w, -w, -5);
    vertex(-w, -w, -5);
    vertex(-w, w, -5);
    vertex(w, w, -5);
  endShape();

  // stroke for triangles
  stroke(255, 255, 255);

  for (Triangle2D t : voronoi.getTriangles()) {
    Vec3D first = t.a.to3DXY();
    Vec3D second = t.b.to3DXY();
    Vec3D third = t.c.to3DXY();

    first.z = noise(noiseValue) * 50;

    // set material to diffuse
    jr.fill("diffuse", 255, 255, 255);

    beginShape(TRIANGLE);
      vertex(first.x, first.y, first.z);
      vertex(second.x, second.y, second.z);
      vertex(third.x, third.y, third.z);
     endShape();
  }


  jr.endRecord();
  jr.displayRendered(true);
}


void keyPressed() {
  if (key == 'n') {
    voronoi = new Voronoi(DSIZE);

    for(int x = 0; x < points; x++) {
      voronoi.addPoint(new Vec2D(random(0, width), random(0, height)));
    }
  }

  if (key == 'r') {
    jr.render();
  }

  if (key == 'p') {
    timestamp = year() + nf(month(),2) + nf(day(),2) + "-" + nf(hour(),2) + nf(minute(),2) + nf(second(),2);
    saveFrame("lines-" + timestamp + ".png");
  }
}
