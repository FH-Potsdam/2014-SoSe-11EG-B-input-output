/**
 * Simple sketch that shows the power of arraylists
 * it draws a trail that follows the mouse
 * @author: Fabian "fabiantheblind" Morón Zirfas
 * @license: WTFPL
 */
ArrayList <PVector> trail;// define our trail list
// executed once
void setup(){
  size(500,400); // the sketch size
  trail = new ArrayList<PVector>();// init the list
}
// executed all the time
void draw(){
  background(255); // delete the bg
  draw_trail();// draw the trail
// line(mouseX,mouseY,pmouseX,pmouseY);// this is another way to draw 2 point trails
}
/**
 * So here is the trick.
 * If the mouse is dragged we store the locations
 * in our arraylist.
 * We constrain the list to 100 points with the while loop
 */
void mouseDragged(){

  trail.add(new PVector(mouseX,mouseY));// add the location of the mouse
  // if the list has more then 100 entries remove the first one
  while(trail.size() > 100){
    trail.remove(0);
  }
//  println(trail);
}
/**
 * Lets draw the trail
 * we loop thru our arraylist and draw every point we find in there
 *
 */
void draw_trail(){
  beginShape();
  for(int i = 0; i < trail.size();i++){
    vertex(trail.get(i).x, trail.get(i).y);
  }
  endShape();
}
//pretty simple eh?