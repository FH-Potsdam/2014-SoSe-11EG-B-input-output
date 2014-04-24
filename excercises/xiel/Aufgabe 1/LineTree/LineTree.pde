/* 
 
 * starte in der Mitte des Bildes
 * zeichne eine gerade Linie
 * am Ende der Linie entspringen zwei neue Linien
 * am Ende dieser Linien entspringen wieder neue Linien, usw. halte dabei den ursprünglichen Spreitzwinkel bei
 
 
 */

ArrayList<GrowingLine> growingLines;

GrowingLine initialGrowingLine;

float angleAll;
boolean savedFrame;

void setup() {
	size(1024, 786, P2D);
	background(255);

	savedFrame = false;
	angleAll = random(180);

	growingLines = new ArrayList<GrowingLine>();

	initialGrowingLine = new GrowingLine(new PVector(width/2, height/2), new PVector(random(2)-1, random(2)-1), 0, 100, null );
	growingLines.add(initialGrowingLine);

	//frameRate(20);
	//smooth();
}

void keyPressed() {
	if (key == 's') {
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
	int livingLinesCount = 0;

	//check for each line, collisions with other lines
	for (int i = 0; i < linesCount; i++) {
		GrowingLine gLine = growingLines.get(i);

		//no need to check... is dead already
		if (gLine.isDead()) {
			continue;
		} else {
			livingLinesCount++;
		}

		for (int j = 0; j < linesCount; j++) {
			GrowingLine gLineToCheck = growingLines.get(j);

			//don't check collision with yourself or with your mother
			if (i == j || gLine.getMother() == gLineToCheck) {
				//println("me or my mother -- no need to check");
				continue;
			}

			//points
			PVector pA = gLineToCheck.getStartPosVector();
			PVector pB = gLineToCheck.getPosVector();
			PVector pC = gLine.getPosVector();

			//edge vectors
			PVector vA = PVector.sub(pC, pB);
			PVector vB = PVector.sub(pC, pA);
			PVector vC = PVector.sub(pA, pB);

			//edge lengths
			float a = PVector.dist(pC, pB);
			float b = PVector.dist(pC, pA);
			float c = PVector.dist(pA, pB);

			//float alpha = ;
			//float b = pB.dist(pC);

			//angles
			float alpha = acos((a * a - b * b - c * c) / (-2 * b * c));
			float beta = acos((b * b - c * c - a * a) / (-2 * c * a));
			float gamma = acos((c * c - a * a - b * b) / (-2 * a * b));

			float alphaDeg = degrees(alpha);
			float betaDeg = degrees(beta);
			float gammaDeg = degrees(gamma);

			//heights (on edges a,b,c)
			//float hA = b * sin(gamma);
			//float hB = c * sin(alpha);
			float hC = a * sin(beta);

			//kill line if it hits another one
			if(alphaDeg <= 90 && betaDeg <= 90 && hC <= .9) { //alphaDeg <= 90 && betaDeg <= 90 && hC <= .4
				// println("---");
				// println(alphaDeg +" "+ betaDeg);
				// println("height: "+ hC);
				// println("KILL!");
				gLine.kill();
			}
		}
	}

	if(livingLinesCount == 0 && savedFrame ==  false){
		saveFrame();
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

