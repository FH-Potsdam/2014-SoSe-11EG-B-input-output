Table table;
ArrayList <Node> nodes;
int firstTimestamp;
float playbackSpeed;

void setup() {

	playbackSpeed = 1;
	nodes = new ArrayList<Node>();
	
	table = loadTable("../data/Rec 02-All-Data.tsv", "header, tsv");

	int w = table.getInt(0, "MediaWidth");
	int h = table.getInt(0, "MediaHeight");
	size(w, h);

	createNodes(table, "01.Epic.gif");
	//createNodes(table, "tumblr_n3wtbeYwAY1sr3eb2o1_500.jpg");
	
}
void draw() {

	int currentTimestamp = millis();
	if( frameCount == 1 ) {
		firstTimestamp = currentTimestamp;
	}
	currentTimestamp -= firstTimestamp;

	background(255);
	
	for(int i=0; i<nodes.size(); i++) {

		Node currentNode = nodes.get(i);

		currentNode.update( int( currentTimestamp*playbackSpeed ) );
		currentNode.paint();
	}
}



void createNodes(Table t, String _media) {

	int firstTimestamp = 0;
	
	ArrayList<PVector>temp = new ArrayList<PVector>();
	
	for( TableRow row : t.rows() ) {
		
		float x = row.getFloat("GazePointX");
		float y = row.getFloat("GazePointY");
		int timestamp = row.getInt("Timestamp");
		String media = row.getString("StimuliName");

		if( 	Float.isNaN(x) || x <= 0 || x > width ||
			Float.isNaN(y) || y <= 0 || y > height ||
			!media.equals(_media) ) {

			continue;
		}

		if( nodes.size() == 0 ) {
			firstTimestamp = timestamp;
		}

		nodes.add( new Node(x, y, timestamp - firstTimestamp) );
	}
}

