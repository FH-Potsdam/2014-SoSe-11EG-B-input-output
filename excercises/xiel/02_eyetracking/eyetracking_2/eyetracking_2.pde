import peasy.test.*;
import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;

//variables for camera 
PeasyCam cam;

//variables to store data from eyetracking
Table table;
ArrayList <PVector> pointsNegative;
ArrayList <PVector> pointsPositive;

int currentMax = 0;

boolean goFullscreen = true;

boolean sketchFullScreen() {
	return goFullscreen;
}

void setup() {

	if(goFullscreen){
		size(displayWidth, displayHeight, P3D);
	} else {
		size(1024, 768, P3D);
	}

	//setup peasy cam
	cam = new PeasyCam(this, width/2, height/2, 0, 700);
	cam.rotateX(0);
	cam.rotateY(90);

	//load table
	table = loadTable("Rec-03-All-Data-neg.tsv", "header, tsv");

	//get points from table (negative associations)
	pointsNegative = getPoints(table);

	table = loadTable("Rec-03-All-Data-pos.tsv", "header, tsv");

	//get points from table (positive associations)
	pointsPositive = getPoints(table);
}

void draw() {
	background(120);
	noStroke();

	cam.rotateY(0.003);

	//lights
	lights();
	directionalLight(126, 126, 126, 0, 0, -1);
	ambientLight(255, 255, 255);

	//shape negative
	stroke(0, 0, 0, 255/2);
	fill(0, 0, 0, 255/2.5);
	beginShape();
	for (int i = 0 ; i < pointsNegative.size();i++) {

		if(i >= currentMax){
			continue;
		}

		PVector p = pointsNegative.get(i);
		vertex(p.x, p.y, p.z * .5 );
	}
	endShape(CLOSE);


	//shape positive
	stroke(255,255,255, 255/2);
	fill(200, 200, 200, 255/2.5);
	beginShape();
	for (int i = 0 ; i < pointsPositive.size();i++) {

		if(i >= currentMax){
			continue;
		}

		PVector p = pointsPositive.get(i);
		vertex(p.x, p.y, p.z * -.5 );
	}
	endShape(CLOSE);

	currentMax += 1;

	if(currentMax > pointsNegative.size() && currentMax > pointsNegative.size()){
		currentMax = 0;
	}
}

void keyReleased() {
	if (key == 's') {
		String timestamp = year() + nf(month(),2) + nf(day(),2) + "-" + nf(hour(),2) + nf(minute(),2) + nf(second(),2);
		saveFrame("frame/"+ timestamp +"-#####.png");
	}
}

ArrayList <PVector> getPoints (Table t) {
	ArrayList<PVector>temp = new ArrayList<PVector>();
	// this is an Iterator loop see
	// http://processing.org/reference/javadoc/core/processing/data/TableRow.html
	// http://processing.org/reference/javadoc/core/processing/data/Table.html#rows()
	for (TableRow row : t.rows()) {
		// int timestamp = row.getInt("Timestamp"); // get an int from the current row
		// String number = row.getString("Number"); // get a string from the current row

		float x = row.getFloat("GazePointX"); // get a float from ...
		float y = row.getFloat("GazePointY"); // ...
		float z = row.getFloat("FixationDuration"); // ...

		if(Float.isNaN(x) || x <= 0 || x > width){
			continue;
		}
		if(Float.isNaN(y) || y <= 0 || y > height){
			continue;
		}
		if(Float.isNaN(z)){
			continue;
		}
		temp.add(new PVector(x, y, z));
	}
	return temp;
}