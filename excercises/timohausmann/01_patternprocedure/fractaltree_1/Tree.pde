class Tree {
	
	int depth;
	int stickLength;
	Stick trunk;
	
	Tree(int _depth, int _stickLength) {
		
		this.depth = _depth;
		this.stickLength = _stickLength;
		this.trunk = this.create( new PVector(0, 0, 0), this.depth);
	}
	
	void update() {
		
		this.trunk.update();
	}
	
	void paint() {
		
		this.trunk.paint();
	}  
	
	
	Stick create(PVector rotation, int depth) {
		
		Stick newStick = new Stick(this, depth, rotation);
		
		if(depth > 0) {
			
			newStick.addChild( this.create( new PVector(
				0,
				random(0,90),
				-45
			), 
			depth - 1) );
			
			newStick.addChild( this.create( new PVector(
				0,
				random(0,90),
				45
			), 
			depth - 1) );

			//generate 4 children at 90° each
			/*newStick.addChild( this.create( new PVector(
				0,
				0,
				-45
			), 
			depth - 1) );

			newStick.addChild( this.create( new PVector(
				-45,
				0,
				0
			), 
			depth - 1) );

			newStick.addChild( this.create( new PVector(
				0,
				0,
				45
			), 
			depth - 1) );

			newStick.addChild( this.create( new PVector(
				45,
				0,
				0
			), 
			depth - 1) );*/
		}
		
		return newStick;
	}
	
}