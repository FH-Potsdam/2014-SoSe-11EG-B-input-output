ArrayList <PVector>mylist;

void setup() {
  size (500,400);
  mylist = new ArrayList<PVector> (1);
  
  
}

void draw() {
  background (255);
  noFill();
  beginShape();
  for(int i = 0; i< mylist.size(); i++){
    PVector p= mylist.get(i);
    vertex(p.x, p.y);
    
    
    
  }
  
  endShape ();
  
  
}

void mouseDragged() {
  while(mylist.size() > 100){
    mylist.remove(0);
  
  
  
  
  }
mylist.add(new PVector (mouseX, mouseY));




}

void keyPressed() {
  
  if(key == 's'){
    saveFrame("funkeylines.jpg");
    
  }
}
