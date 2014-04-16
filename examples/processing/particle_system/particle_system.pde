/**
 * a particle system
 * @author fabiantheblind
 * written for Blockseminar @FHP Werkstattpraxis 14W4D-IL Interface-Labor
 * loosly based on http://processing.org/examples/multipleparticlesystems.html
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

System psys;
/**
 * Setup executed once
 */
void setup() {
  size(400,300);
  psys = new System(10, 10);
  // or use
  //psys = new System( width of Particle, height of Particle);
  // or use
  //psys = new System(number of new Particles, width of Particle, height of Particle, lifetime of Particle);
}

/**
 * The action loop
 */
void draw() {
  cls();// clear the screen
  psys.run();// run the system
}

// exchange mouseDragged with mouseClicked to see what happens
void mouseDragged() {
  psys.addParticle();
  psys.particles.add(new SuperParticle(mouseX, mouseY, 10, 1000));
}

void cls() {
  rectMode(CORNER);
  noStroke();
  fill(255,20);
  rect(0, 0, width, height);
}

