class Stick extends Node {
	
	PVector rotation;
	PVector targetRotation;
	PVector dimensions;
	PVector targetDimensions;
	
	
	Stick(Tree _tree, int _depth, PVector _rotation) {

		super(_tree, _depth);

		this.dimensions = new PVector(0, 0, 0);
		this.targetDimensions = new PVector(0, 0, 0);
		
		this.rotation = new PVector(0, 0, 0);
		this.targetRotation = _rotation;
	}

	void setRotation( PVector _rotation ) {

		this.rotation = _rotation;
	}

	void update() {

		super.update();

		int stickLength = this.tree.stickLength;
		int stickDiameter = this.tree.stickDiameter;

		float len = map(this.depthFactor, 0, 1, stickLength, stickLength/4.0 );
		float diameter = map(this.depthFactor, 0, 1, stickDiameter, stickDiameter/4.0 );

		this.targetDimensions.x = diameter;
		this.targetDimensions.y = len;
		this.targetDimensions.z = diameter;

		PVector deltaDimensions = this.targetDimensions.get();
		deltaDimensions.sub( this.dimensions );
		deltaDimensions.mult(0.1);
		this.dimensions.add( deltaDimensions );

		PVector deltaRotation = this.targetRotation.get();
		deltaRotation.sub( this.rotation );
		deltaRotation.mult(0.05);
		this.rotation.add( deltaRotation );
	}
	
	void paint() {
		
		float swingZ = radians( sin((frameCount/32.0) % 360)*0.5 );
		
		strokeWeight(1);
		stroke(255,64);
		fill(0);
		
		pushMatrix();
		rotateX( radians(this.rotation.x) );
		rotateY( radians(this.rotation.y) );
		rotateZ( radians(this.rotation.z) + swingZ );
		translate(0, -this.dimensions.y/2, 0);
		box(this.dimensions.x, this.dimensions.y, this.dimensions.z);
		
		translate(0, -this.dimensions.y/2, 0);
		
		
		for(int i=0;i<this.children.size();i++) {
			this.children.get(i).paint();
		}
		
		popMatrix();
	}
}