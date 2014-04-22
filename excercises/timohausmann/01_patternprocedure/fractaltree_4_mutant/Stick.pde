class Stick {
	
	Tree tree;
	PVector rotation;
	float len;
	float diameter;
	float depthFactor;
	ArrayList<Stick> children;
	
	
	Stick(Tree _tree, int _depth, PVector _rotation) {
		
		this.tree = _tree;
		this.depthFactor = _depth/float(_tree.depth);
		this.len = _depth * _tree.stickLength;
		this.rotation = _rotation;
		this.diameter = this.depthFactor*30;
		this.children = new ArrayList<Stick>();

		if( random(0,1) > 0.8 ) {
			this.diameter *= 2;
		}
		if( random(0,1) > 0.8 ) {
			this.len *= 2;
		}
	}
	
	void addChild( Stick stick ) {
		
		this.children.add( stick );
	}
	
	void update() {
		
		//this.rotation.y += 0.1;
		
		for(int i=0;i<this.children.size();i++) {
			this.children.get(i).update();
		}
	}
	
	void paint() {
		
		float swingZ = radians( sin((frameCount/32.0) % 360)*0.5 );
		
		stroke(255,64);
		fill(0);
		
		pushMatrix();
		rotateX( radians(this.rotation.x) );
		rotateY( radians(this.rotation.y) );
		rotateZ( radians(this.rotation.z) + swingZ );
		translate(0, -this.len/2, 0);
		box(this.diameter, this.len, this.diameter);
		
		translate(0, -this.len/2, 0);
		
		for(int i=0;i<this.children.size();i++) {
			this.children.get(i).paint();
		}
		
		popMatrix();
	}
}