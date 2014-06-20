/*
 * Eyetracking 2
 * @version 1.0
 * @author Timo Hausmann
 * @license MIT
 */

import peasy.*;

String filename;
String medianame;

PeasyCam cam;
Table table;
ArrayList <Node> nodes;
int firstTimestamp;
float playbackSpeed;

int w;
int h;

PFont font;
PImage raster;


/** 
 * Setup
 */
void setup() {
  

	playbackSpeed = 1; //Wiedergabegeschwindigkeit (Faktor), 1=normal 

	filename = "Rec 01-All-Data.tsv";
	medianame = "01.Epic.gif";
	//medianame = "tumblr_n3wtbeYwAY1sr3eb2o1_500.jpg";


	nodes = new ArrayList<Node>();

	font = createFont("Courier New", 16);
        raster = loadImage("texture_4.png");
        textureMode(NORMAL);
	
	table = loadTable("../data/" + filename, "header, tsv");

	size(1280, 800, P3D);

	createNodes(table, medianame);

	cam = new PeasyCam(this, 400);
	cam.setMinimumDistance(200);
	cam.setMaximumDistance(1500);
	cam.setDistance(520);

	cam.setRotations(2.958, 0.361, -3.073);
}


/** 
 * Draw
 */
void draw() {        
  
        int currentTimestamp = millis();
        if( frameCount == 1 ) {
          firstTimestamp = currentTimestamp;
        }
        currentTimestamp -= firstTimestamp;

        background(255);
        ambientLight(196, 196, 196);
        directionalLight(128, 128, 128, 0, 1, 1);
        
        int size = 600;
        int textureResolution = 64;
        fill(128,128,128);
        noStroke();
        textureWrap(REPEAT);
        beginShape(QUADS);
		texture(raster);
		vertex(-size, 0, -size, 0, 0);
		vertex(size, 0, -size, textureResolution, 0);
		vertex(size, 0, size, textureResolution, textureResolution);
		vertex(-size, 0, size, 0, textureResolution);
        endShape();

	for(int i=0; i<nodes.size(); i++) {

		Node currentNode = nodes.get(i);

		currentNode.update( int( currentTimestamp*playbackSpeed ) );
		currentNode.paint();
	}


	drawHud();
}


/** 
 * Draw HUD
 */
void drawHud() {

	float[] rotations = cam.getRotations();

	cam.beginHUD();

	fill(128);
	noStroke();
	textFont(font);
	textAlign(CENTER);

	for(int i=0; i<rotations.length; i++) {

		text( rotations[i], 32, 32*(i+1) );
	}

	cam.endHUD();
}


/** 
 * createNodes
 * @param Table t 		Tabelle mit GazePointX, GazePointY, Timestamp, StimuliName
 * @param String _media 	Dateiname, nach dem gefiltert werden soll
 */
void createNodes(Table table, String _media) {
  
        int w = table.getInt(0, "MediaWidth");
        int h = table.getInt(0, "MediaHeight");

	int firstTimestamp = 0;
	
	ArrayList<PVector>temp = new ArrayList<PVector>();
	
	for( TableRow row : table.rows() ) {
  
                String media = row.getString("StimuliName");
                if( !media.equals(_media) ) {
                    continue;
                }
		
		float x = row.getFloat("GazePointX") - (w/2);
		float y = row.getFloat("GazePointY") - (h/2);
		int timestamp = row.getInt("Timestamp");

		if( nodes.size() == 0 ) {
			firstTimestamp = timestamp;
		}

		nodes.add( new Node(x, y, timestamp - firstTimestamp) );
	}
}



/** 
 * Tastatureingaben
 */
void keyReleased() {

	if (key != CODED) {
		switch(key) {

			case ENTER:

				screenshot();
				break;

			default:

				break;
		}
	}
}



/** 
 * Screenshot erstellen
 */
void screenshot() {

	String timestamp = year() + nf(month(),2) + nf(day(),2) + "-" + nf(hour(),2) + nf(minute(),2) + nf(second(),2);
	saveFrame("screenshot-" + filename + "-" + medianame + "-" + timestamp + ".png");
}