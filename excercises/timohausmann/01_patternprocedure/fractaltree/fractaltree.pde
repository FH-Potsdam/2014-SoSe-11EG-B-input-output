/*
 * Fractaltree
 * @version 1.1
 * @author Timo Hausmann
 * @license MIT
 * https://github.com/FH-Potsdam/2014-SoSe-11EG-B-input-output/tree/master/excercises/timohausmann/01_patternprocedure/
 */

import peasy.*;

PeasyCam cam;
Tree myTree;
int maxNameLength;
String name;
PFont font;
PImage raster;
float sceneRotation;
float sceneRotationDelta;


/** 
 * Setup
 */
void setup() {

	size(1280, 720, P3D);

	cam = new PeasyCam(this, 400);
	cam.setMinimumDistance(500);
	cam.setMaximumDistance(1500);
	cam.setDistance(1000);
	cam.setYawRotationMode();

	maxNameLength = 6;
	
	sceneRotation = 0;
	sceneRotationDelta = 0.1;
	
	name = "";
	font = createFont("Courier New", 16);
	raster = loadImage("shadow.png");
        textureMode(NORMAL);

	randomSeed(1000);

	myTree = new Tree();
}


/** 
 * Draw
 */
void draw() {

	background(255);
	
	ambientLight(196, 196, 196);
        directionalLight(128, 128, 128, 0, 1, 0);

	translate(0, 400, 0);
	rotateY( radians(sceneRotation) );

	int size = 140;
        int textureResolution = 1;
        fill(128,128,128);
        noStroke();
        textureWrap(REPEAT);
        beginShape(QUADS);
		texture(raster);
		vertex(-size, 0, -size, 0, 0);
		vertex(size, 0, -size, textureResolution, 0);
		vertex(size, 0, size, textureResolution, textureResolution);
		vertex(-size, 0, size, 0, textureResolution);
        endShape();


	myTree.update();
	myTree.paint();

	sceneRotation += sceneRotationDelta;

	drawHud();
}


/** 
 * Draw HUD
 */
void drawHud() {

	String drawText = name;
	String cursorName = " ";
	
	if( frameCount/32 % 2 == 0 ) {
		cursorName = "█";
	}

	cam.beginHUD();

	noStroke();
	textFont(font);
	textAlign(CENTER);

	fill(128);
	text("Bitte gib deinen Namen ein:", width/2, height-64);

	fill(0);
	text(name + cursorName, width/2, height-42);

	cam.endHUD();
}


/** 
 * Kameradrehung bei MousePressed stoppen
 */
void mousePressed() {

	sceneRotationDelta = 0;
}


/** 
 * Kameradrehung bei MousePressed fortsetzen
 */
void mouseReleased() {

	sceneRotationDelta = 0.1;
}


/** 
 * Tastatureingaben
 */
void keyReleased() {

	if (key != CODED) {
		switch(key) {

			case ENTER:

				screenshot();
				break;

			case BACKSPACE:

				name = name.substring(0,max(0,name.length()-1));

				updateSeed();

				//Sonderfall für lange Namen - Drehungen neu generieren und abbrechen
				if( name.length() > maxNameLength-1 ) {

					myTree.randomizeRotation();
					return;
				}

				myTree.removeDepth();

				//Sonderfall für kurze Namen - die ersten 2 Buchstaben erzeugen eine zusätzliche Generation
				if( name.length() < 3 ) myTree.removeDepth();

				break;

			default:

				//Begrenzung auf A-Z & SPACE
				if((keyCode >= 65 && keyCode <= 90) || keyCode == 32 ) {

					name += key;

					updateSeed();

					//Sonderfall für lange Namen - Drehungen neu generieren und abbrechen
					if( name.length() > maxNameLength ) {

						myTree.randomizeRotation();
						return;
					}

					myTree.addDepth(false);

					//Sonderfall für kurze Namen - die ersten 2 Buchstaben erzeugen eine zusätzliche Generation
					if( name.length() < 3 ) myTree.addDepth(false);
				}

				break;
		}
	}
}


/** 
 * Zufallsseed aktualisieren
 */
void updateSeed() {

	int seed = 0;

	for(int i=0; i<name.length(); i++ ) {

		seed += int( name.charAt(i) );
	}

	randomSeed( seed );
}


/** 
 * Screenshot erstellen
 */
void screenshot() {

	String timestamp = year() + nf(month(),2) + nf(day(),2) + "-" + nf(hour(),2) + nf(minute(),2) + nf(second(),2);
	saveFrame("screenshot-" + name + "-" + timestamp + ".png");
}