/**
 * A simple sketch for reading tsv files created by the tobii eyetracker @FH-Potsdam
 *
 * mostly based in the examples found here
 * http://www.processing.org/reference/loadTable_.html
 *
 */

import processing.pdf.*;
boolean record = false;
Table table; // declare a table
int w, h; // for the size of the canvas
ArrayList <PVector> points; // will hold the GazePoints X/Y
void setup() {

  table = loadTable("Rec 05-All-Data.tsv", "header, tsv");
  // get the size of the canvas from the MediaWidth and MediaHeight columns
  w = table.getInt(0, "MediaWidth");
  h = table.getInt(0, "MediaHeight");
  size(1300, 1200);// now set the size depending on the media
  points = getPoints(table);

}




void draw() {
  // nothing to see here. move along
if(record == true){
  
  String timestamp = year() + nf(month(),2) + nf(day(),2) + "-" + nf(hour(),2) + nf(minute(),2) + nf(second(),2);
  beginRecord(PDF,"test" + timestamp+".pdf");
}
  // draw the lines with vertex
  noFill();

  beginShape();
  // loop all the points to get the single PVector
  for (int i = 0 ; i < points.size();i++) {
    PVector p = points.get(i);
    vertex(p.x, p.y); // draw it
    strokeWeight(0.5);
    stroke(1);
    background(190);
  }
  endShape();

  // now draw the points  
  for (int i = 0 ; i < points.size();i++) {
    PVector p = points.get(i);
    ellipse(p.x, p.y, 1.7, 1.7);// draw the single PVector
    fill(#3e3efc);
  }

if(record == true){
endRecord();
record = false;
}
//  println("Finished.");
//  exit();
  
}

void keyPressed(){

  if(key == 's'){
    record = true;
    
  
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
    if (Float.isNaN(x) || x <= 0 || x > width) {
      continue;
    }
    if (Float.isNaN(y) || y <= 0 || y > height) {
      continue;
    }
    temp.add(new PVector(x, y));
  }
  return temp;
}

