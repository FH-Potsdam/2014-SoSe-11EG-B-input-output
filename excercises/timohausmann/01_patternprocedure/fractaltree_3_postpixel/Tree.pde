class Tree {
	
	int depth;
	int stickLength;
	color colour;
	Stick trunk;
	
	Tree(int _depth, int _stickLength) {
		
		this.depth = _depth;
		this.stickLength = _stickLength;
		this.colour = color(random(255), random(255), random(255) );
		this.trunk = this.create( new PVector(0, 0, 0), this.depth);
	}
	
	void update() {
		
		this.trunk.update();
	}
	
	void paint() {
		
		this.trunk.paint();
	}  
	
	
	Stick create(PVector rotation, int depth) {
		
		boolean hasChildren = false;
		int len = depth * this.stickLength; 
		float depthFactor = depth/float(this.depth);
		Stick newStick = new Stick(rotation, len, depthFactor);
		
		if(depth > 0) {
			
			if( random(0,1) > 0.2 ) {
				
				hasChildren = true;
				newStick.addChild( this.create( new PVector(0,	random(0,90), -random(15,30) ), depth - 1) );
			}

			if( random(0,1) > 0.2 ) {

				hasChildren = true;
				newStick.addChild( this.create( new PVector(0,	random(0,90), random(15,30) ), depth - 1) );
			}
		}

		if( !hasChildren ) {
			newStick.addFruit( new Fruit(this.colour, depthFactor) );
		}
		
		return newStick;
	}
	
}