class Node {

	PVector pos;
	PVector velocity;
	int timestamp;
	int value;
	boolean isAlive;
        int colorType; 


	/** 
	 * Constructor
	 */
	Node(float _x, float _y, int _timestamp) {
		
		this.isAlive = false;
		this.value = 1;
		this.timestamp = _timestamp;

		this.pos = new PVector(_x, 0, _y);
		this.velocity = new PVector(0, 0, 0);

                if( random(1) > 0.5 ) {
                  this.colorType = 0;
                } else {
                  this.colorType = 1;
                }

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

			if( distance.mag() < 10 ) {

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
		fill(128, 128, 128);
                //jr.fill("ambient_occlusion", 150, 255, 255, 0, 0, 255, 50, 16);
                
                jrFill();
		sphereDetail(20);

		pushMatrix();
		translate(this.pos.x, this.pos.y, this.pos.z);
  		sphere(diameter);
  		popMatrix();
	}


void jrFill() {
  if( this.colorType == 0 ) {
 jr.fill("diffuse", 150, 255, 255);
  } else {
    jr.fill("diffuse", 255, 150, 40);
  }
}

}
