/**
 * The particle class
 */
class Particle {
  int w, h;
  float x, y;
  int rotation = 0;
  boolean dead = false;
  int time = 0;
  int lifetime = 100;

  //--------------------------------------
  //  CONSTRUCTOR
  //--------------------------------------
  Particle (int _w, int _h) {
    this.w = _w;
    this.h = _h;
  }
  //--------------------------------------
  //  CONSTRUCTOR (overloaded)
  //--------------------------------------  
  Particle (float _x, float _y, int _w, int _h, int _l) {
    this.x = _x;
    this.y = _y;
    this.w = _w;
    this.h = _h;
    this.lifetime = _l;
  }

  //Show it
  void display() {
    float alpha = map(time, 0, lifetime, 255, 0);
    stroke(#000000, alpha);// black stroke in HEX
    fill(#ffffff, alpha);
    pushMatrix();// set the matrix so it is always centered
    translate(this.x, this.y);// push it to our position
    rectMode(CENTER);// we want the rect to be centered
    rotate(radians(rotation));// rotate it takes radians as arg
    rect(0, 0, this.w, this.h);// draw the particle
    popMatrix();// push the matrix back
  }

  /**
   * This updates the rotation per loop by one
   */
  void turn() {
    rotation++;
  }

  /**
   * move the particle
   */
  void move() {
    float _x = this.x;// get the current value x
    float _y = this.y;// get the current value y
    _x += random(-1, 1);// change it
    _y += random(-1, 1);// change it
    this.x = constrain(_x, 0, width);// constrain it to the screen
    this.y = constrain(_y, 0, height);// constrain it to the screen
  }
  // update its state
  void update() {
    turn();
    move();

    if (!this.dead) {
      this.time++;
      if (this.time > this.lifetime) {
        this.dead = true;
      }
    }
  }
  // now run that thing
  void run() {
    display();
    update();
  }
}

