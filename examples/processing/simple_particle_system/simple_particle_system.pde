/**
 * a really simple particle system
 * @author fabiantheblind
 * written for Blockseminar @FHP Werkstattpraxis 14W4D-IL Interface-Labor
 *
 * Copyright (c)  2014
 * Fabian "fabiantheblind" Morón Zirfas
 * Permission is hereby granted, free of charge, to any
 * person obtaining a copy of this software and associated
 * documentation files (the "Software"), to deal in the Software
 * without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to  permit persons to
 * whom the Software is furnished to do so, subject to
 * the following conditions:
 * The above copyright notice and this permission notice
 * shall be included in all copies or substantial portions of the Software.
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
 * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF  CONTRACT,
 * TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTIO
 * WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 * see also http://www.opensource.org/licenses/mit-license.php
 *
 */


ArrayList <Particle> particles; // this will hold all our particles

/**
 * Setup executed once
 */
void setup() {
  particles = new ArrayList<Particle>();// init particle list
}

/**
 * The action loop
 */
void draw() {
  cls();// clear the screen
  runParticleSystem();// run the syste,
}

/**
 * This loops thru the list of particles and runs every particle
 */
void runParticleSystem() {

  for (int i = 0; i < particles.size();i++) {
    particles.get(i).run();
  }
}
void mouseClicked() {
  particles.add(new Particle(mouseX,mouseY,10,10));
}
void cls() {
  rectMode(CORNER);
  noStroke();
  rect(0, 0, width, height);
}
/**
 * The particle class
 */
class Particle {
  public int w, h;
  public float x, y;
  public int rotation = 0;

  //--------------------------------------
  //  CONSTRUCTOR
  //--------------------------------------
  public Particle (float _x, float _y, int _w, int _h) {
    this.x = _x;
    this.y = _y;
    this.w = _w;
    this.h = _h;
  }

  //Show it
  private void display() {
    stroke(#000000);// black stroke in HEX
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
  private void turn() {
    rotation++;
  }

  /**
   * move the particle
   */
  private void move() {
    float _x = this.x;// get the current value x
    float _y = this.y;// get the current value y
    _x += random(-1, 1);// change it
    _y += random(-1, 1);// change it
    this.x = constrain(_x, 0, width);// constrain it to the screen
    this.y = constrain(_y, 0, height);// constrain it to the screen
  }
  // update its state
  private void update() {
    turn();
    move();
  }
  // now run that thing
  public void run(){
    display();
    update();
  }
}

