/*
 * GrowingLine class
 * by Felix Leupold (xiel)
 * ------------------------------
 * - a GrowingLine grows until it reaches it's desiredLength, then it ends (ended property)
 * - a GrowingLine dies if it hits the edge of the canvas or another GrowingLine (dead property)
 * - a GrowingLine gives birth to two new GrowingLines if it ends and is not dead
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
  GrowingLine mother;

  GrowingLine(PVector startPointVector, PVector oldDirectionVector, float angle, float wantedLength, GrowingLine _mother) {

    //properties
    ended = false;
    dead = false;
    mother = _mother; 

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
  
  GrowingLine getMother(){
    return mother;
  }

  PVector getStartPosVector() {
    return startPosVector;
  }

  PVector getDirectionVector() {
    return directionVector;
  }

  PVector getPosVector() {
    return newPosVector;
  }

  boolean hasEnded() {
    return ended;
  }

  boolean isDead() {
    return dead;
  }

  void kill() {
    dead = true;
  }

  void update() {

    if (dead) { 
      return;
    }

    //grow line
    if (!ended && !dead) {
      oldPosVector = newPosVector;
      newPosVector = PVector.add(oldPosVector, directionVector);
      currentLength++;
    }

    //if line reached desired length, it's ready to give birth to new lines
    if (currentLength >= desiredLength) {
      ended = true;
    }

    //check if line is dead and so will not give birth to new lines
    if (newPosVector.x >= width
      || newPosVector.x <= 0
      || newPosVector.y >= height
      || newPosVector.y <= 0
      ) {
      dead = true;
      println("line hit edge of canvas");
    }
  }


  void display() {

    if(useVertex){
      vertex(newPosVector.x, newPosVector.y);
    } else {
      line(oldPosVector.x, oldPosVector.y, newPosVector.x, newPosVector.y);
    }
    
  }
}



