import peasy.*;

PeasyCam cam;
Tree myTree;
String name;
PFont font;

void setup() {

	size(1280, 720, P3D);

	cam = new PeasyCam(this, 400);
	cam.setMinimumDistance(500);
	cam.setMaximumDistance(1500);
	cam.setDistance(1000);
	cam.setYawRotationMode();
	
	name = "";
	font = createFont("Courier New", 16);

	createTree();
}

void createTree() {
	
	myTree = new Tree();
}

void draw() {

	background(255);
	lights();

	translate(0, 400, 0);

	pushMatrix();
	rotateX(PI/2);
	stroke(64);
	noFill();
	rect(-400, -400, 800, 800);
	popMatrix();

	myTree.update();
	myTree.paint();

	drawHud();
}

void drawHud() {

	String drawText = name;
	color drawColor = color(0);

	if( name.length() == 0 ) {
		drawText = "Bitte gib deinen Namen ein";
		drawColor = color(128 + sin((frameCount/16.0) % 360)*64  );
	}

	cam.beginHUD();

	fill(drawColor);
	noStroke();
	textFont(font);
	textAlign(CENTER);
	text(drawText, width/2, height-42);

	cam.endHUD();
}


void keyReleased() {

	if (key != CODED) {
		switch(key) {
			case BACKSPACE:

				name = name.substring(0,max(0,name.length()-1));
				myTree.removeDepth();
				break;
			default:

				//constrain to A-Z & SPACE
				if((keyCode >= 65 && keyCode <= 90) || keyCode == 32 ) {
					name += key;

					float degree = 45;
					float lenModifier = 1;
					float diameterModifier = 1;

					if( keyCode != 32 ) {
						degree = map(keyCode, 65, 90, 15, 60);
					}

					myTree.addDepth( degree );
				}
		}
	}
}