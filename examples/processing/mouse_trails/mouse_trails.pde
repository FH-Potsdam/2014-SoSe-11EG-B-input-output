/**
 * Simple sketch that shows the power of arraylists
 * it draws a trails that follows the mouse
 * @author: Fabian "fabiantheblind" Morón Zirfas
 * @license: WTFPL
 */
ArrayList <ArrayList> trails;
ArrayList <PVector> onetrail;

// executed once
void setup() {
  size(500, 400); // the sketch size
  trails = new ArrayList<ArrayList>();
}
// executed all the time
void draw() {
  noFill();
  background(255); // delete the bg
  draw_trail();// draw the trail
}

// if the mouse is pressed we create anew list
void mousePressed() {
  onetrail = new ArrayList<PVector>();
}

// if the mouse is released we add the list to the 
// list of lists
void mouseReleased() {
  trails.add(onetrail);
}
/**
 * So here is the trick.
 * If the mouse is dragged we store the locations
 * in our arraylist.
 * We constrain the list to 100 points with the while loop
 */
void mouseDragged() {
  onetrail.add(new PVector(mouseX, mouseY));// add the location of the mouse

  // this is just to see
  // where we are drawing
  beginShape();
  for (int i = 0; i < onetrail.size();i++) {
    PVector p = (PVector) onetrail.get(i); 
    vertex(p.x, p.y);
  }
  endShape();
}
/**
 * Lets draw the trail
 * we loop thru our arraylist and draw every point we find in there
 *
 */
void draw_trail() {
  for (int i = 0; i < trails.size();i++) {
    beginShape();
    for (int j = 0; j < trails.get(i).size();j++) {
      PVector p = (PVector)trails.get(i).get(j); 
      vertex(p.x, p.y);
    }
    endShape();
  }
}
//not so simple anymore. eh?

