class Stick {
  
  Tree tree;
  PVector rotation;
  float len;
  float depthFactor;
  float diameter;
  color colour;  
  ArrayList<Stick> children;
  
  
  Stick(Tree _tree, int _depth, PVector _rotation) {
    
    this.tree = _tree;
    this.rotation = _rotation;
    this.len = _depth * _tree.stickLength;
    this.depthFactor = _depth/float(_tree.depth);
    this.diameter = this.depthFactor*30;
    
    this.children = new ArrayList<Stick>(); 
    this.colour = color( random(40), ((1-depthFactor)*50) + random(140), random(40) );
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
    
    //float swingZ = radians( sin((frameCount/16.0) % 360)*0.5 );
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