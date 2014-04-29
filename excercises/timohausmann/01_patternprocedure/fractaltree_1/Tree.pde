class Tree {
	
	int depth;
	JSONObject routine;
	int stickLength;
	int stickDiameter;
	Stick trunk;

	/*
	 * @var nodeIndex
	 * Zweidimensionale ArrayList, speichert alle Nodes nach ihrer Tiefe im Baum
	 * z.B. nodeIndex.get(2) liefert eine ArrayList aller Nodes der 2. Tiefe
	 */
	ArrayList<ArrayList> nodeIndex;
	
	Tree() {

		this.depth = 1;

		this.stickLength = 200;
		this.stickDiameter = 30;

		this.trunk = new Stick(this, 1, new PVector(0,0,0));

		this.nodeIndex = new ArrayList<ArrayList>();
		this.nodeIndex.add( new ArrayList<Node>() );
		this.nodeIndex.get(0).add( this.trunk );
	}

	void addDepth( float _degree ) {

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

			//Zwei Children erzeugen
			Stick child1 = new Stick(this, this.depth, new PVector(0, 45, -_degree) );
			Stick child2 = new Stick(this, this.depth, new PVector(0, 45, _degree) );

			//Children zum aktuellen Element hinzufügen
			currentNode.addChild( child1 );
			currentNode.addChild( child2 );

			//Children zum NodeIndex hinzufügen
			newNodes.add( child1 );
			newNodes.add( child2 );
		}
	}

	void removeDepth() {

		if( this.depth == 1 ) return;

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
	
	void update() {
		
		this.trunk.update();
	}

	void paint() {
		
		this.trunk.paint();
	}
}