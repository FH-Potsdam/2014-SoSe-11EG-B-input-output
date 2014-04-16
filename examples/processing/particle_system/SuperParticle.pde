/**
 * for more inheritance see
 * http://processing.org/examples/inheritance.html
 *
 */
class SuperParticle extends Particle {

  SuperParticle(float _x, float _y, int _d, int _l) {
    super( _x, _y, _d, _d, _l);
  }


  void display() {
    float alpha = map(super.time, 0, super.lifetime, 255, 0);
    stroke(#000000, alpha);// black stroke in HEX
    fill(#ffffff, alpha);
    pushMatrix();// set the matrix so it is always centered
    translate(super.x, super.y);// push it to our position
    ellipseMode(CENTER);// we want the rect to be centered
    rotate(radians(rotation));// rotate it takes radians as arg
    
    ellipse(0, 0, super.w, super.h);// draw the particle
//    
//    line(0, 0, super.w, super.h);
//    line(0, 0, -super.w, -super.h);
//    line(0, 0, -super.w, super.h);
//    line(0, 0, super.w, -super.h);
    point(0, 0);
    popMatrix();// push the matrix back
  }
}

