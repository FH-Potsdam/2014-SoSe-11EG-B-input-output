class Stick {
	
	PVector rotation;
	int len;
	float depthFactor;
	ArrayList<Stick> children;
	ArrayList<Fruit> childrenFruit;
	
	
	Stick(PVector _rotation, int _len, float _depthFactor) {
		
		this.rotation = _rotation;
		this.len = _len;
		this.depthFactor = _depthFactor;
		
		this.children = new ArrayList<Stick>(); 
		this.childrenFruit = new ArrayList<Fruit>(); 
	}
	
	void addChild( Stick stick ) {
		
		this.children.add( stick );
	}

	void addFruit( Fruit fruit ) {
		
		this.childrenFruit.add( fruit );
	}
	
	void update() {
		
		for(int i=0;i<this.children.size();i++) {
			this.children.get(i).update();
		}
	}
	
	void paint() {
		
		float diameter = this.depthFactor*30;
		float drawLen = this.len;
		
		stroke(255,64);
		strokeWeight(1);
		fill(0);
		
		pushMatrix();
		rotateX( radians(this.rotation.x) );
		rotateY( radians(this.rotation.y) );
		rotateZ( radians(this.rotation.z) + radians( sin((frameCount/32.0) % 360)*0.5 ) );
		translate(0, -drawLen/2, 0);
		box(diameter, drawLen, diameter);
		
		translate(0, -drawLen/2, 0);
		
		
		for(int i=0;i<this.children.size();i++) {
			this.children.get(i).paint();
		}

		for(int i=0;i<this.childrenFruit.size();i++) {
			this.childrenFruit.get(i).paint();
		}
		
		popMatrix();
	}
}