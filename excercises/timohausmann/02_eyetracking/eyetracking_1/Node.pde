class Node {

	PVector pos;
	PVector origPos;
	PVector velocity;
	int timestamp;
	boolean isAlive;


	/** 
	 * Constructor
	 */
	Node(float _x, float _y, int _timestamp) {
		
		this.isAlive = false;
		this.timestamp = _timestamp;

		this.pos = new PVector(_x, _y);
		this.origPos = this.pos.get();
		this.velocity = new PVector(0, 0);

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

		this.pos.add( this.velocity );

		this.velocity.mult( 0.9 );		
	}
	

	/** 
	 * Paint
	 */
	void paint() {

		if( !this.isAlive ) return;

		stroke(0, 0, 0, 128);
		line(this.pos.x, this.pos.y, this.origPos.x, this.origPos.y);

		/*fill(0, 0, 0, 128);
		noStroke();
		ellipse(this.pos.x, this.pos.y, diameter, diameter);*/
	}
}