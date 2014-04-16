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

  initialGrowingLine = new GrowingLine(new PVector(width/2, height/2), new PVector(random(2)-1, random(2)-1), 0, 100 );
  growingLines.add(initialGrowingLine);

  smooth();
}



void draw () {

  updateGrowingLines();
}

void updateGrowingLines() {
  ArrayList<GrowingLine> newLinesFromLines = new ArrayList<GrowingLine>();

  loadPixels();

  for (GrowingLine gLine : growingLines) {
    gLine.update();
    gLine.display();

    updatePixels();

    if ( gLine.hasEnded() && !gLine.isDead() ) {
      newLinesFromLines.add(gLine);
      gLine.kill();
    }
  }

  for (GrowingLine gLine : newLinesFromLines) {
    createNewLinesFrom(gLine);
  }
}

void findAndKillCollidingLines() {
  
}

void createNewLinesFrom(GrowingLine gLine) {
  println("createNewLines");

  //float angle = random(180);
  float angle = angleAll;
  float counterAngle = 360 - angle;

  //float newLength = random(50, 100);
  float newLength = 100;

  //GrowingLine rebornOne = ;
  growingLines.add( new GrowingLine(gLine.getPosVector(), gLine.getDirectionVector(), angle, newLength ) );
  growingLines.add( new GrowingLine(gLine.getPosVector(), gLine.getDirectionVector(), counterAngle, newLength ) );
}

