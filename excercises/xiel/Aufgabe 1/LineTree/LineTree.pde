/* 
 
 * starte in der Mitte des Bildes
 * zeichne eine gerade Linie
 * am Ende der Linie entspringen zwei neue Linien
 * am Ende dieser Linien entspringen wieder neue Linien, usw. halte dabei den ursprünglichen Spreitzwinkel bei
 
 
 */

ArrayList<GrowingLine> growingLines;

GrowingLine initialGrowingLine;

float angleAll;

void setup() {
  size(1024, 786, P2D);
  background(255);

  angleAll = random(180);

  growingLines = new ArrayList<GrowingLine>();

  initialGrowingLine = new GrowingLine(new PVector(width/2, height/2), new PVector(random(2)-1, random(2)-1), 0, 100, null );
  growingLines.add(initialGrowingLine);

  //frameRate(20);
  //smooth();
}

void keyPressed() {
  if(key == 's'){
    saveFrame("LineTree-#####.png");
  }
}

void draw () {

  updateGrowingLines();
}

void updateGrowingLines() {
  ArrayList<GrowingLine> newLinesFromLines = new ArrayList<GrowingLine>();

  for (GrowingLine gLine : growingLines) {
    gLine.update();
    gLine.display();

    if ( gLine.hasEnded() && !gLine.isDead() ) {
      newLinesFromLines.add(gLine);
      gLine.kill();
    }
  }

  findAndKillCollidingLines();

  for (GrowingLine gLine : newLinesFromLines) {
    createNewLinesFrom(gLine);
  }
}

void findAndKillCollidingLines() {
  //println("findAndKillCollidingLines");

  int linesCount = growingLines.size();

  //check for each line, collisions with other lines
  for (int i = 0; i < linesCount; i++) {
    GrowingLine gLine = growingLines.get(i);

    //no need to check... is dead already
    if (gLine.isDead()) {
      continue;
    }

    for (int j = 0; j < linesCount; j++) {
      GrowingLine gLineToCheck = growingLines.get(j);

      //don't check collision with yourself or with your mother
      if (i == j || gLine.getMother() == gLineToCheck) {
        println("me or my mother!");
        continue;
      }

      PVector ownPosVect = gLine.getPosVector();
      PVector startPos = gLineToCheck.getStartPosVector();
      PVector currentPos = gLineToCheck.getPosVector();

      float a = startPos.dist(currentPos);
      float b = startPos.dist(ownPosVect);
      float c = currentPos.dist(ownPosVect);

      float alpha = degrees( acos( (sq(b)+sq(c)-sq(a)) / (2*a*c) ) );

      //      float a = sqrt( sq(abs(startPosX-currentPosX)) + sq(abs(startPosY-currentPosY)) );
      //      float b = sqrt( sq(abs(startPosX-ownX)) + sq(abs(startPosY-ownY)) );
      //      float c = sqrt( sq(abs(currentPosX-ownX)) + sq(abs(currentPosY-ownY)) );

      //check if all angles are <= 90 deg 

      float distance = sqrt( sq(c) - ( sq( sq(a)+sq(c)-sq(b) ) / ( 4*sq(a) ) ) );

      println("----");
      println(distance);
      println(a + " " + b + " " + c);
      println("alpha: " + alpha);

      if (distance < 1 && alpha < 45) {
        println("KILL!");
//        println(distance);
//        println(a + " " + b + " " + c);
//        println(alpha);
        //gLine.kill();
      }
    }
  }
}

void createNewLinesFrom(GrowingLine gLine) {
  //println("createNewLines");

  //float angle = random(180);
  float angle = angleAll;
  float counterAngle = 360 - angle;

  //float newLength = random(50, 100);
  float newLength = 100;

  growingLines.add( new GrowingLine(gLine.getPosVector(), gLine.getDirectionVector(), angle, newLength, gLine ) );
  growingLines.add( new GrowingLine(gLine.getPosVector(), gLine.getDirectionVector(), counterAngle, newLength, gLine ) );
}

