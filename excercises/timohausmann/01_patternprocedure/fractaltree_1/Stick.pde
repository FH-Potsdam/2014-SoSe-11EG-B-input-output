class Stick {
  
  PVector rotation;
  int len;
  float depthFactor;
  color colour;  
  ArrayList<Stick> children;
  
  
  Stick(PVector _rotation, int _len, float _depthFactor) {
    
    this.rotation = _rotation;
    this.len = _len;
    this.depthFactor = _depthFactor;
    
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
    
    float diameter = this.depthFactor*30;
    
    stroke(255,64);
    fill(0);
    
    pushMatrix();
    rotateX( radians(this.rotation.x) );
    rotateY( radians(this.rotation.y) );
    rotateZ( radians(this.rotation.z) + radians( sin((frameCount/16.0) % 360)*0.5 ) );
    translate(0, -this.len/2, 0);
    box(diameter, this.len, diameter);
    
    translate(0, -this.len/2, 0);
    
    
    for(int i=0;i<this.children.size();i++) {
      this.children.get(i).paint();
    }
    
    popMatrix();
  }
}