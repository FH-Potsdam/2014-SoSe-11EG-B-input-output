import joons.JoonsRenderer;
import peasy.*;

PeasyCam cam;
Table table;
ArrayList <Node> nodes;
int firstTimestamp;

JoonsRenderer jr;

void setup() {
  size(800, 600, P3D);
  jr = new JoonsRenderer(this);
  jr.setSampler("ipr"); //Rendering mode, either "ipr" or "bucket".
  jr.setSizeMultiplier(2); //Set size of PNG file as a multiple of Processing sketch size.
  jr.setAA(-2, 0); //Set anti aliasing, (aaMin, aaMax, aaSamples). aaMin & aaMax = .. -2, -1, .. , 1, 2 ..; aaMin < aaMax.
  jr.setCaustics(10); //Set caustics. 1, 5, 10 .., affects quality of light reflected & refracted through glass.
  
  cam = new PeasyCam(this, 400);
  cam.setMinimumDistance(0);
  cam.setMaximumDistance(1000);
  cam.setDistance(200);
  
  
  nodes = new ArrayList<Node>();
  
  table = loadTable("../data/Rec 02-All-Data.tsv", "header, tsv");
  createNodes(table, "01.Epic.gif");
}

void draw() {
  
  int currentTimestamp = millis();
  if( frameCount == 1 ) {
    firstTimestamp = currentTimestamp;
  }
  currentTimestamp -= firstTimestamp;
  
  
  jr.beginRecord(); //Make sure to include things you want rendered.
  //camera(eyeX, eyeY, eyeZ, centerX, centerY, centerZ, upX, upY, upZ);
  //perspective(fov, aspect, zNear, zFar);

  jr.background(0, 255, 255); //(gray), or (r, g, b), like Processing.
  jr.background("gi_instant"); //Global illumination.
  //jr.background("gi_ambient_occlusion"); //Global illumination, ambient occlusion mode.

  jr.background("cornell_box", 100, 100, 100); //Cornell box, width, height, depth.
  
  for(int i=0; i<nodes.size(); i++) {

    Node currentNode = nodes.get(i);

    currentNode.update( currentTimestamp );
    currentNode.paint();
  }

  jr.endRecord(); //Make sure to end record.
  jr.displayRendered(true); //Display rendered image if render is completed, and the argument is true.
}

void keyPressed() {
  if (key == 'r' || key == 'R') jr.render(); //Press 'r' key to start rendering.
}



void createNodes(Table t, String _media) {

  int firstTimestamp = 0;
  
  ArrayList<PVector>temp = new ArrayList<PVector>();
  
  for( TableRow row : t.rows() ) {
    
    float x = row.getFloat("GazePointX");
    float y = row.getFloat("GazePointY");
    int timestamp = row.getInt("Timestamp");
    String media = row.getString("StimuliName");

    if(   Float.isNaN(x) || x <= 0 || x > width ||
      Float.isNaN(y) || y <= 0 || y > height ||
      !media.equals(_media) ) {

      continue;
    }

    if( nodes.size() == 0 ) {
      firstTimestamp = timestamp;
    }

    nodes.add( new Node(x, y, timestamp - firstTimestamp) );
  }
}
