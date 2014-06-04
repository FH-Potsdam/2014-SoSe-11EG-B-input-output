class Node {

	PVector pos;
	PVector velocity;
	int timestamp;
	int value;
	boolean isAlive;


	/** 
	 * Constructor
	 */
	Node(float _x, float _y, int _timestamp) {
		
		this.isAlive = false;
		this.value = 1;
		this.timestamp = _timestamp;

		this.pos = new PVector(_x, 0, _y);
		this.velocity = new PVector(0, 0, 0);

		if( nodes.size() > 0 ) {

			Node prevNode = nodes.get( nodes.size() - 1 );

			PVector distance = prevNode.pos.get();
			distance.sub( this.pos );
			distance.mult(-0.2);
			this.velocity = distance;
		}
	}


	/** 
	 * Update
	 */
	void update(int _currentTimestamp) {

		if( this.timestamp < _currentTimestamp ) {
			this.isAlive = true;
		} else {
			return;
		}


		ArrayList<Node> neighbours = new ArrayList<Node>();

		for(int i=0; i<nodes.size(); i++) {

			Node currentNode = nodes.get(i);

			if( !currentNode.isAlive || this == currentNode ) continue;

			PVector distance = this.pos.get();
			distance.sub( currentNode.pos );

			if( distance.mag() < 15 ) {

				neighbours.add( currentNode );
			}
		}

		for(int i=0; i<neighbours.size(); i++) {

			Node currentNode = neighbours.get(i);
			int index = nodes.indexOf( currentNode );

			this.value += currentNode.value;

			nodes.remove( currentNode );
		}


		this.pos.add( this.velocity );

		this.velocity.mult( 0.9 );		
	}
	

	/** 
	 * Paint
	 */
	void paint() {

		if( !this.isAlive ) return;

		int diameter = 19 + this.value;
		noStroke();
		

		pushMatrix();
		translate(this.pos.x, this.pos.y, this.pos.z);
		
		/*
		fill(128 + (this.value*2), 128, 128);
		rotateX(PI/4);
		rotateY(PI/4);
		box(diameter, diameter, diameter);
		*/
		

		/*
		stroke(128);
		strokeWeight(2);
		fill(255 - (this.value/2), 255 - (this.value/2), 255);
		box(diameter/2, diameter*4, diameter/2);
		*/
		
		
		fill(96 + (this.value*1), 128, 156 + (this.value*2));
		rotateX(PI/4);
		box(diameter, diameter*2, diameter);
		

		/*
		fill(128, 128 + (this.value*2), 128 + (this.value*1));
		rotateX(PI/4);
		rotateY(PI/4);
		box(diameter*2, diameter, diameter);
		*/

		/*
		fill(128 + (this.value*2), 128 + (this.value*1), 128);
		rotateX(PI/random(1,8));
		rotateY(PI/random(1,8));
		box(diameter, diameter, diameter);
		*/

		/*
		fill(128 + (this.value*2), 96 + (this.value*1), 96);
		sphereDetail(3);
		rotateZ(PI/4);
		sphere(diameter);
		*/

		/*
		fill(128, 128 + (this.value*2), 128 + (this.value*1));
		sphere(diameter);
		*/
		
  		popMatrix();
	}
}