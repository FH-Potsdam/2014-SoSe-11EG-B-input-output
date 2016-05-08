/* 
 sketch_140423f_shape 
 */
import processing.pdf.*;

Shape MyForm;
Shape MyForm2;

void setup() {
  size (1300,  1300);
  beginRecord (PDF, "vectors.pdf");

  create();
}

void create() {

  int EdgeCount = int(random(3, 3)); 
  MyForm = new Shape(EdgeCount);
  MyForm2 = new Shape(EdgeCount);
} 


void draw() {

  background(255);
  strokeWeight(4);
  stroke(255,79,68);
  MyForm.display();
  MyForm2.display();
  for (int i = 0; i< MyForm.Edges.size(); i++) {
    PVector p= MyForm.Edges.get(i);
    PVector p2= MyForm2.Edges.get(i);
    line(p.x, p.y, p2.x, p2.y);
  }
}

void keyPressed() {
  create();
  if (key == 'q') {
    endRecord (); 
  }
}
