/*
 * Eyetracking 1
 * @version 1.0
 * @author Timo Hausmann
 * @license MIT
 */

String filename;
String medianame;

Table table;
ArrayList <Node> nodes;

int firstTimestamp;
float playbackSpeed;


/** 
 * Setup
 */
void setup() {

	playbackSpeed = 1; //Wiedergabegeschwindigkeit (Faktor), 1=normal 

	filename = "Rec 02-All-Data.tsv";
	//medianame = "01.Epic.gif";
	medianame = "tumblr_n3wtbeYwAY1sr3eb2o1_500.jpg";
	

	nodes = new ArrayList<Node>();
	
	table = loadTable("../data/" + filename, "header, tsv");
	int w = table.getInt(0, "MediaWidth");
	int h = table.getInt(0, "MediaHeight");
	
	size(w, h);
	createNodes(table, medianame);
	
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
	
	for(int i=0; i<nodes.size(); i++) {

		Node currentNode = nodes.get(i);

		currentNode.update( int( currentTimestamp*playbackSpeed ) );
		currentNode.paint();
	}
}


/** 
 * createNodes
 * @param Table t 		Tabelle mit GazePointX, GazePointY, Timestamp, StimuliName
 * @param String _media 	Dateiname, nach dem gefiltert werden soll
 */
void createNodes(Table t, String _media) {

	int firstTimestamp = 0;
	
	ArrayList<PVector>temp = new ArrayList<PVector>();
	
	for( TableRow row : t.rows() ) {
		
		float x = row.getFloat("GazePointX");
		float y = row.getFloat("GazePointY");
		int timestamp = row.getInt("Timestamp");
		String media = row.getString("StimuliName");

		if( !media.equals(_media) ) {
			continue;
		}

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