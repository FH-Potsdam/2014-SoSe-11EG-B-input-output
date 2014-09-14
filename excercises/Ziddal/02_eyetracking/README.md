Input = Eyetrack Table

Output = Image.

Der Text besteht aus 7 Zeilen, auf jeden Zeile wir den Satz:
''Mein Name ist Laura und ich mache ein Experiment mit dir'' aus sieben verschieden Sprache wiederholt.

Das Bild Zeigt wie lange einzelne Worte und Sätze beobachtet worden sind.

```sh


/**
 * A simple sketch for reading tsv files created by the tobii eyetracker @FH-Potsdam
 *
 * mostly based in the examples found here
 * http://www.processing.org/reference/loadTable_.html
 *
 */
Table table; // declare a table
int w, h; // for the size of the canvas
ArrayList <PVector> points;
ArrayList <Integer> timestamps;
ArrayList <Integer> fixations;
ArrayList <PVector> fixPoints;

void setup() {
  

  table = loadTable("juri_.tsv", "header, tsv");
  //get the size of the canvas from the MediaWidth and MediaHeight columns
  //w = table.getInt(0, "MediaWidth");
  //h = table.getInt(0, "MediaHeight");
   points = getGazePoints(table);
  timestamps = getTimestamps(table);
  fixations = getFix(table);
  fixPoints = getFixPoints(table);
  w=0;
  h=0;
    
  for (int i = 0 ; i < points.size();i++) {
    PVector p = points.get(i);
    //vertex(p.x, p.y); 
    p.x=p.x/2+10;
    p.y=p.y/2+10;
    if(p.x>w) w= (int)p.x;
    if(p.y>h) h= (int)p.y;
  }
  w+=20;
  h+=20;
  size(w, h);// now set the size depending on the media

 //noStroke();
  noFill();
  beginShape();
  for (int i = 0 ; i < points.size();i++) {
    PVector p = points.get(i);
    vertex(p.x, p.y);
  }
  endShape();
  //fill(255);
 
    for (int i = 0 ; i < fixations.size();i++) {
    Integer tdelta = fixations.get(i);
    PVector p = fixPoints.get(i);
    


  noStroke();
  fill(255, 255, 255, 130);
    ellipse(p.x/2, p.y/2,tdelta/10,tdelta/10);
  }
}
void draw() {
  // nothing to see here. move along
}
ArrayList <PVector> getGazePoints (Table t) {
  ArrayList<PVector>temp = new ArrayList<PVector>();
  // this is an Iterator loop see
  // http://processing.org/reference/javadoc/core/processing/data/TableRow.html
  // http://processing.org/reference/javadoc/core/processing/data/Table.html#rows()
  for (TableRow row : t.rows()) {
    // int timestamp = row.getInt("Timestamp"); // get an int from the current row
    // String number = row.getString("Number"); // get a string from the current row
    float x = row.getFloat("GazePointX"); // get a float from ...
    float y = row.getFloat("GazePointY"); // ...
    
    if (x == 0 && y == 0)
      continue;
    
    temp.add(new PVector(x, y));
  }
  return temp;
}

ArrayList <Integer> getTimestamps (Table t) {
  ArrayList<Integer>temp = new ArrayList<Integer>();
  // this is an Iterator loop see
  // http://processing.org/reference/javadoc/core/processing/data/TableRow.html
  // http://processing.org/reference/javadoc/core/processing/data/Table.html#rows()
  for (TableRow row : t.rows()) {
    // int timestamp = row.getInt("Timestamp"); // get an int from the current row
    // String number = row.getString("Number"); // get a string from the current row
    int x = row.getInt("Timestamp"); // get a float from ...
    temp.add(new Integer (x));
  }
  return temp;
}

ArrayList <Integer> getFix (Table t) {
  ArrayList<Integer>temp = new ArrayList<Integer>();
  // this is an Iterator loop see
  // http://processing.org/reference/javadoc/core/processing/data/TableRow.html
  // http://processing.org/reference/javadoc/core/processing/data/Table.html#rows()
  
  int currentTimestamp = 0;
  for (TableRow row : t.rows()) {
    int currentFocus = row.getInt("FixationIndex"); // get a float from ...
    try {
      temp.set(currentFocus,  temp.get(currentFocus) + (row.getInt("Timestamp") - currentTimestamp));
    } catch (Exception e) {
      temp.add(new Integer(0));
    }
    
    currentTimestamp = row.getInt("Timestamp"); 
  }
  return temp;
}


ArrayList <PVector> getFixPoints (Table t) {
  ArrayList<PVector>temp = new ArrayList<PVector>();
  // this is an Iterator loop see
  // http://processing.org/reference/javadoc/core/processing/data/TableRow.html
  // http://processing.org/reference/javadoc/core/processing/data/Table.html#rows()
  
  for (TableRow row : t.rows()) {
    float x = row.getFloat("GazePointX"); // get a float from ...
    float y = row.getFloat("GazePointY"); // ...

    try {
      temp.set(row.getInt("FixationIndex"), new PVector(x, y));
    } catch (Exception e) {
      temp.add(new PVector(x, y));
    }    
  }
  return temp;
}

```




