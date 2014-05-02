class Node {

	Tree tree;
	int depth;
	float depthFactor;
	ArrayList<Node> children;


	/** 
	 * Constructor
	 * @param Tree _tree der zugehörige Baum
	 * @param int _depth die Ebenentiefe
	 */
	Node(Tree _tree, int _depth) {
		
		this.tree = _tree;
		this.depth = _depth;
		this.depthFactor = _depth/float(_tree.depth);
		
		this.children = new ArrayList<Node>(); 
	}
	

	/** 
	 * Fügt eine neue ChildNode hinzu
	 * @param Node _node Die hinzuzufügende ChildNode
	 */
	void addChild( Node _node ) {
		
		this.children.add( _node );
	}


	/** 
	 * Entfernt alle ChildNodes
	 */
	void removeAllChildren() {
		
		this.children.clear();
	}


	/** 
	 * Update
	 */
	void update() {

		this.depthFactor = this.depth/float(this.tree.depth);

		for(int i=0;i<this.children.size();i++) {
			this.children.get(i).update();
		}
	}
	

	/** 
	 * Paint
	 */
	void paint() {

		for(int i=0;i<this.children.size();i++) {
			this.children.get(i).paint();
		}
	}


	/** 
	 * randomizeRotation
	 */
	void randomizeRotation() {
	}
}