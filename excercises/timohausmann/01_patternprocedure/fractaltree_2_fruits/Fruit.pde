class Fruit {

	float diameter;
	color colour;

	Fruit(color _colour, float _depthFactor) {

		//this.diameter = 30 + (_depthFactor*70);
		this.diameter = random(32,128);
		this.colour = _colour;
	}

	void update() {


	}

	void paint() {

		//stroke(this.colour);
		stroke(0);
		strokeWeight(2);
		noFill();
		ellipse(0,0,diameter, diameter);
	}
}