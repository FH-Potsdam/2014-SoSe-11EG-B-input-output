class Tree {
	
	int depth;
	JSONObject routine;
	int stickLength;
	int stickDiameter;
	Stick trunk;

	/**
	 * @var nodeIndex
	 * Zweidimensionale ArrayList, speichert alle Nodes nach ihrer Tiefe im Baum
	 * z.B. nodeIndex.get(2) liefert eine ArrayList aller Nodes der 2. Tiefe
	 */
	ArrayList<ArrayList> nodeIndex;
	

	/** 
	 * Constructor
	 */
	Tree() {

		//trunk depth
		this.depth = 1;

		this.stickLength = 200;
		this.stickDiameter = 30;

		this.trunk = new Stick(this, 1, new PVector(0,0,0));

		this.nodeIndex = new ArrayList<ArrayList>();
		this.nodeIndex.add( new ArrayList<Node>() );
		this.nodeIndex.get(0).add( this.trunk );

		this.addDepth(true);
	}


	/** 
	 * Eine weitere Verzweigungsebene hinzufügen 
	 * @param boolean _forceChildren Wenn true, erzwingt zwei Verzweigungen
	 */
	void addDepth( boolean _forceChildren ) {

		//letzte Ebene merken
		ArrayList<Node> priorNodes = this.nodeIndex.get( this.depth-1 );

		//Tiefe des Baumes erhöhen
		this.depth += 1;

		//neue Ebene anlegen
		this.nodeIndex.add( new ArrayList<Node>() );

		//neue Ebene merken
		ArrayList<Node> newNodes = this.nodeIndex.get( this.depth-1 );

		//Für jedes Element der letzten Ebene ...
		for( int i=0; i<priorNodes.size(); i++ ) {

			//Aktuelles Element
			Node currentNode = priorNodes.get(i);

			if( _forceChildren || random(0,1) > 0.2 ) {
				Stick child1 = new Stick( this, this.depth, new PVector(0, 45, random(15,45)) );
				currentNode.addChild( child1 );
				newNodes.add( child1 );
			}

			if( _forceChildren || random(0,1) > 0.2 ) {
				Stick child2 = new Stick( this, this.depth, new PVector(0, 45, -random(15,45)) );
				currentNode.addChild( child2 );
				newNodes.add( child2 );
			}
		}
	}


	/** 
	 * Alle Nodes der letzten Verzweigungsebene entfernen
	 */
	void removeDepth() {

		//mindestens trunk + erste Spaltung
		if( this.depth == 2 ) return;

		//vorletzte Ebene merken
		//(um die letzte Ebene zu entfernen, müssen die Children der vorletzten Ebene entfernt werden)
		ArrayList<Node> lastNodes = this.nodeIndex.get( this.depth-2 );

		//Für jedes Element der vorletzte Ebene ...
		for( int i=0; i<lastNodes.size(); i++ ) {

			//Aktuelles Element
			Node currentNode = lastNodes.get(i);

			//Alle Children entfernen
			currentNode.removeAllChildren();
		}

		//letzte Ebene aus dem NodeIndex entfernen
		this.nodeIndex.remove( this.depth-1 );

		//Tiefe des Baumes verringern
		this.depth -= 1;
	}

	/**
	 * Drehung aller Nodes ab der ersten Ebene neu generieren
	 */
	void randomizeRotation() {

		ArrayList<Stick> splitNodes = this.nodeIndex.get(1);

		for( int i=0; i<splitNodes.size(); i++ ) {

			splitNodes.get(i).randomizeRotation();
		}
	}
	

	/** 
	 * Update
	 */
	void update() {
		
		this.trunk.update();
	}


	/** 
	 * Paint
	 */
	void paint() {
		
		this.trunk.paint();
	}
}