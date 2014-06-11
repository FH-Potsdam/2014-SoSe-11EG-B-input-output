/*
 * Eyetracking 0
 * @version 1.0
 * @author Timo Hausmann
 * @license MIT
 */

Table table;
ArrayList<PVector> points;

String filename;
String medianame;
int tolerance;

int w;
int h;


/** 
 * Setup
 */
void setup() {

	tolerance = 8; //Pixelbereich, in dem einzelne Punkte zusammengeführt werden. 0=alle Punkte sichtbar
	filename = "Rec 02-All-Data.tsv";
	medianame = "01.Epic.gif";
	//medianame = "tumblr_n3wtbeYwAY1sr3eb2o1_500.jpg";
	
	table = loadTable("../data/" + filename, "header, tsv");
	w = table.getInt(0, "MediaWidth");
	h = table.getInt(0, "MediaHeight");
	points = createPoints(table, medianame);

	size(1280, 800);
	applyTolerance();
}


/** 
 * applyTolerance
 */
void applyTolerance() {

	if( tolerance <= 0 ) return;

	ArrayList<PVector> neighbours = new ArrayList<PVector>();

	for(int i=0; i<points.size(); i++) {

		PVector iPoint = points.get(i);

		for(int j=0; j<points.size(); j++) {

			if( i == j ) continue;

			PVector jPoint = points.get(j);
			PVector distance = iPoint.get();
			distance.sub( jPoint );

			if( distance.mag() < tolerance ) {

				neighbours.add( jPoint );
			}
		}
	}

	for(int i=0; i<neighbours.size(); i++) {

		PVector currentNode = neighbours.get(i);
		
		points.remove( currentNode );
	}
}


/** 
 * Draw
 */
void draw() {

	background(255);

	translate(width/2, height/2);

	beginShape();
	for(int i=0; i<points.size(); i++) {

		PVector currentNode = points.get(i);

		noStroke();
		fill(0);
		vertex( currentNode.x, currentNode.y);
		ellipse( currentNode.x, currentNode.y, 4, 4);
	}
	noFill();
	stroke(0);
	endShape();
}


/** 
 * createPoints
 * @param Table t 		Tabelle mit GazePointX, GazePointY, StimuliName
 * @param String _media 	Dateiname, nach dem gefiltert werden soll
 */
ArrayList<PVector> createPoints(Table t, String _media) {

	
	ArrayList<PVector>temp = new ArrayList<PVector>();
	
	for( TableRow row : t.rows() ) {
		
		float x = row.getFloat("GazePointX") - (w/2);
		float y = row.getFloat("GazePointY") - (h/2);
		String media = row.getString("StimuliName");

		if( !media.equals(_media) ) {
			continue;
		}

		temp.add( new PVector(x, y) );
	}

	return temp;
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
	saveFrame("screenshot-" + filename + "-" + medianame + "-" + tolerance + "-" + timestamp + ".png");
}