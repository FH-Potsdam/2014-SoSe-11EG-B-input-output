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

boolean goFullscreen = true;

boolean sketchFullScreen() {
	return goFullscreen;
}

void setup() {

	if(goFullscreen){
		size(displayWidth, displayHeight, P3D);
	} else {
		size(1280, 1024, P3D);
	}

	//setup peasy cam
	cam = new PeasyCam(this, width/2, height/2, 0, 400);
	cam.setYawRotationMode();

	//load table
	table = loadTable("Rec-03-All-Data-neg.tsv", "header, tsv");

	//get points from table (negative associations)
	pointsNegative = getPoints(table);

	table = loadTable("Rec-03-All-Data-pos.tsv", "header, tsv");

	//get points from table (positive associations)
	pointsPositive = getPoints(table);
}

void draw() {
	background(17, 22, 30);
	noStroke();

	//lights
	lights();
	directionalLight(126, 126, 126, 0, 0, -1);
	ambientLight(255, 255, 255);

	//shape negative
	fill(200, 20, 35, 255/2.5);
	beginShape();
	for (int i = 0 ; i < pointsNegative.size();i++) {
		PVector p = pointsNegative.get(i);
		vertex(p.x, p.y, p.z * .5 );
	}
	endShape(CLOSE);


	//shape positive
	fill(20, 200, 35, 255/2.5);
	beginShape();
	for (int i = 0 ; i < pointsPositive.size();i++) {
		PVector p = pointsPositive.get(i);
		vertex(p.x, p.y, p.z * -.5 );
	}
	endShape(CLOSE);
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