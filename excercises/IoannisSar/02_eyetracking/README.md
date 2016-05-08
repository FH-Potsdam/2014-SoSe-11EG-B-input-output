#Eye Tracking

Zu dieser Aufgabe sollten wir ein typographisches Plakat erstellen und dazu eine kurze Leseanweisung verfassen. Das Plakat wurde dann von mehreren Kommilitonen im Eye-Tracking Labor angeschaut und anschließend vom Tobii ausgewertet.

</br>

###Zu betrachtende Poster:


![01_poster](https://raw.githubusercontent.com/FH-Potsdam/2014-SoSe-11EG-B-input-output/master/excercises/IoannisSar/02_eyetracking/02_images/01_poster.png)

![02_poster](https://raw.githubusercontent.com/FH-Potsdam/2014-SoSe-11EG-B-input-output/master/excercises/IoannisSar/02_eyetracking/02_images/02_poster.png)

![03_poster](https://raw.githubusercontent.com/FH-Potsdam/2014-SoSe-11EG-B-input-output/master/excercises/IoannisSar/02_eyetracking/02_images/03_poster.png)


</br>

###Ausführung


Ich habe lange überlegt wie ich mein Plakat aufstellen möchte. Letztendlich entschied ich mich für einen Text, der im Kontext zur augenblicklichen, unsichtbaren Interaktion zwischen Proband und Plakat zu verstehen ist. Meine Leseanweisung lautete: "Versuche einen Lesefluss zu finden". Folgenden Text habe ich in 3 verschiedenen Leseflüssen auf die vorgegebene Größe von 1200 x 1024 gebracht: "I am about to create connections between a bunch of letters."

Enstanden ist eine Auswertung der Augenbewegung in Form einer .tsv-Datei.
Um den Code auszuführen benutzten wir erneut Processing.

</br>

###Ausführender Code

```
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

  table = loadTable("04_anna/anna_track_03.tsv", "header, tsv");
  // get the size of the canvas from the MediaWidth and MediaHeight columns
  w = table.getInt(0, "MediaWidth");
  h = table.getInt(0, "MediaHeight");
  size(1200, 1050);// now set the size depending on the media
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
    strokeWeight(1);
    stroke(145);
    background(160);
  }
  endShape();

  // now draw the points  
  for (int i = 0 ; i < points.size();i++) {
    PVector p = points.get(i);
    ellipse(p.x, p.y, 2.5, 2.5);// draw the single PVector
    fill(80);
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

```
</br>


###Entstandende Plakatserie

![01.2_eyetracking_end](https://raw.githubusercontent.com/FH-Potsdam/2014-SoSe-11EG-B-input-output/master/excercises/IoannisSar/02_eyetracking/02_images/01.2_eyetracking_end.png)

![02.2_eyetracking_end](https://raw.githubusercontent.com/FH-Potsdam/2014-SoSe-11EG-B-input-output/master/excercises/IoannisSar/02_eyetracking/02_images/02.2_eyetracking_end.png)

![03.2_eyetracking_end](https://raw.githubusercontent.com/FH-Potsdam/2014-SoSe-11EG-B-input-output/master/excercises/IoannisSar/02_eyetracking/02_images/03.2_eyetracking_end.png)

</br>

###Detail


20 Sekunden Zeit gab es pro Plakat. Ich habe die finalen Datensätze dann noch entsprechend weiterverarbeitet und kleinere Details händisch hinzugefügt, sodass sich die Bedeutung und der Gedanke hinter dem Plakat bei näherer Betrachtung klarer hervorhebt.

</br>

![04_poster_detail](https://raw.githubusercontent.com/FH-Potsdam/2014-SoSe-11EG-B-input-output/master/excercises/IoannisSar/02_eyetracking/02_images/04_poster_detail.jpg)







