class Stick extends Node {
	
	/** 
	 * @var rotation
	 * Die aktuelle Drehung
	 */
	PVector rotation;

	/** 
	 * @var targetRotation
	 * Die eigentliche "Zieldrehung", zu der animiert wird
	 */
	PVector targetRotation;

	/** 
	 * @var dimensions
	 * Die aktuellen Abmessungen
	 */
	PVector dimensions;

	/** 
	 * @var targetDimensions
	 * Die eigentlichen "Zielabmessungen", zu denen animiert wird
	 */
	PVector targetDimensions;

	/**
	 * @var diameterModifier
	 * @var lenModifier
	 * Diese Faktoren modifizieren den Durchmesser bzw. die Länge
	 */
	float diameterModifier;
	float lenModifier;
	
	
	/** 
	 * Constructor
	 * @param Tree _tree der zugehörige Baum
	 * @param int _depth die Ebenentiefe
	 * @param PVector _rotation ein dreidimensionaler Vektor mit Grad-Drehungen
	 */
	Stick(Tree _tree, int _depth, PVector _rotation) {

		super(_tree, _depth);

		this.dimensions = new PVector(0, 0, 0);
		this.targetDimensions = new PVector(0, 0, 0);
		
		this.rotation = new PVector(0, 0, 0);
		this.targetRotation = _rotation;

		this.diameterModifier = 1;
		this.lenModifier = random(0.5, 1);
	}


	/** 
	 * Update
	 */
	void update() {

		super.update();

		int stickLength = this.tree.stickLength;
		int stickDiameter = this.tree.stickDiameter;

		float len = map(this.depthFactor, 0, 1, stickLength, stickLength/4.0 );
		float diameter = map(this.depthFactor, 0, 1, stickDiameter, stickDiameter/4.0 );

		diameter *= this.diameterModifier;
		len *= this.lenModifier;

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
	

	/** 
	 * Paint
	 */
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


	/** 
	 * neue zufällige Drehung generieren
	 */
	void randomizeRotation() {

		int sign = this.targetRotation.z < 0 ? -1 : 1;

		this.targetRotation.z = random(15, 45) * sign;

		for(int i=0;i<this.children.size();i++) {

			this.children.get(i).randomizeRotation();
		}
	}
}