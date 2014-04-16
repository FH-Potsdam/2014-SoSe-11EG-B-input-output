
/*
line 


desiredLength

dirVector / angle

newPosVector
oldPosVector
currentLength

ended
- when line hits canvas edge
- when line hits dark pixel
- line reaches desired length

*/

class GrowingLine {
  
  //position
  PVector startPosVector;
  PVector oldPosVector;
  PVector newPosVector;
  PVector directionVector;
  
  //length
  float currentLength;
  float desiredLength;
  
  //properties
  boolean ended;
  boolean dead;
  
  GrowingLine(PVector startPointVector, PVector oldDirectionVector, float angle, float wantedLength) {
    
    //properties
    ended = false;
    dead = false;
    
    //setup length of growing line
    currentLength = 0;
    desiredLength = wantedLength;
    
    //setup vectors of growing line
    startPosVector = new PVector();
    startPosVector.add(startPointVector);
    
    oldPosVector = new PVector();
    oldPosVector.add(startPointVector);
    
    newPosVector = new PVector();
    newPosVector.add(startPointVector);
    
    directionVector = new PVector();
    directionVector.add(oldDirectionVector);
    directionVector.rotate(radians(angle));
    directionVector.normalize();
    //directionVector.mult(1.5);
    
    newPosVector.add(directionVector);
  }
  
  PVector getDirectionVector(){
    return directionVector;
  }
  
  PVector getPosVector(){
    return newPosVector;
  }
  
  boolean hasEnded(){
    return ended;
  }
  
  boolean isDead(){
    return dead;
  }
  
  void kill(){
    dead = true;
  }
  
  void update(){
    
    if(dead){ return; }
    
    //grow line
    if(!ended && !dead){
      oldPosVector = newPosVector;
      newPosVector = PVector.add(oldPosVector, directionVector);
      currentLength++;
    }
    
    //if line reached desired length, it's ready to give birth to new lines
    if(currentLength >= desiredLength){
      ended = true;
    }
    
    //check if line is dead and so will not give birth to new lines
    if(newPosVector.x >= width
    || newPosVector.x <= 0
    || newPosVector.y >= height
    || newPosVector.y <= 0
    //|| usedPixelAhead() 
    ){
      dead = true;
      println("line hit edge of canvas or used pixel ahead");
    }
  }
  
  boolean usedPixelAhead(){
    int x = round(newPosVector.x);
    int y = round(newPosVector.y);
    
    //get pixel at point
    color colorOfPixelAhead = pixels[ y * x + x];
    
    println( str(colorOfPixelAhead) );
    println( str(color(255)) );
    
    if( colorOfPixelAhead == color(0) ){
      println("used pixel ahead");
    }
    
    return false;
    //return colorOfPixelAhead == color(0);
  }
  
  void display(){
    line(oldPosVector.x, oldPosVector.y, newPosVector.x, newPosVector.y);
  }
  
}





