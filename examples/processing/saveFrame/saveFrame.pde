/**
 * simple sketch for saving frames
 *
 * hit s to save an image
 */
void setup(){
size(500,500);
}

void draw(){
  // draw something here
  ellipse(random(width), random(height), 10, 10);
}


void keyPressed(){
  // important the s as to be in ' ' not in " "
  if(key == 's'){
  saveFrame("my-image-####.jpg");
  }
}
