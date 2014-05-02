class Fruit extends Node {

	float diameter;

	Fruit(Tree _tree, int _depth) {

		super(_tree, _depth);

		this.diameter = random(32,128);
	}


	void paint() {

		stroke(0);
		strokeWeight(2);
		noFill();
		ellipse(0,0, this.diameter, this.diameter);
	}
}