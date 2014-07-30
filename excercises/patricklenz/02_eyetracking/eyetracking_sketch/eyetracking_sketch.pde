Table table; // declare a table
int w, h; // for the size of the canvas
ArrayList <PVector> points; // will hold the GazePoints X/Y


void setup() {
  table = loadTable("rec04-All-Data.tsv", "header, tsv");
  //w = table.getInt(0, "MediaWidth");
  //h = table.getInt(0, "MediaHeight");
  println(w);
  println(h);
  points = getPoints(table);
  
  size(1280,1024,P3D);
  background(0);
  
  
  beginShape();
  for (int i = 0 ; i < points.size();i++)
  {
    PVector p = points.get(i);
    stroke(random(62,118),random(182,235),random(205,215),random(0,255));
    noFill();
    vertex(p.x, p.y, p.z); // draw it
  }
  endShape(CLOSE);
  
}


void draw() {}


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
    float z = row.getFloat("ValidityRight");
    if(Float.isNaN(x) || x <= 0 || x > width){
      continue;
    }
    if(Float.isNaN(y) || y <= 0 || y > height){
      continue;
    }
    temp.add(new PVector(x, y));
  }
  return temp;
}
