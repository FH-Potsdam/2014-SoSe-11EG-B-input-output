class Node {

	Tree tree;
	int depth;
	float depthFactor;
	ArrayList<Node> children;


	Node(Tree _tree, int _depth) {
		
		this.tree = _tree;
		this.depth = _depth;
		this.depthFactor = _depth/float(_tree.depth);
		
		this.children = new ArrayList<Node>(); 
	}
	
	void addChild( Node _node ) {
		
		this.children.add( _node );
	}

	void removeAllChildren() {
		
		this.children.clear();
	}

	void update() {

		this.depthFactor = this.depth/float(this.tree.depth);

		for(int i=0;i<this.children.size();i++) {
			this.children.get(i).update();
		}
	}
	
	void paint() {

		for(int i=0;i<this.children.size();i++) {
			this.children.get(i).paint();
		}
	}

	void randomizeRotation() {
		//jesus christ ...
	}
}