/**
 * a TUIO touch particle system
 * @author fabiantheblind
 * written for Blockseminar @FHP Werkstattpraxis 14W4D-IL Interface-Labor
 *
 * Copyright (c)  2014
 * Fabian "fabiantheblind" Morón Zirfas
 *
 *
 * TUIO integration based on
 *
 * TUIO processing demo - part of the reacTIVision project
 * http://reactivision.sourceforge.net/
 *
 * Copyright (c) 2005-2009 Martin Kaltenbrunner <mkalten@iua.upf.edu>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/

// we need to import the TUIO library
// and declare a TuioProcessing client variable
import TUIO.*;
import java.util.*;
TuioProcessing tuioClient;
ArrayList <Particle> particles; // this will hold all our particles


// these are some helper variables which are used
// to create scalable graphical feedback
float cursor_size = 15;
float object_size = 60;
float table_size = 760;
float scale_factor = 1;

/**
 * Setup executed once
 */
void setup() {
  size(1280,800);
  particles = new ArrayList<Particle>();// init particle list


  // we create an instance of the TuioProcessing client
  // since we add "this" class as an argument the TuioProcessing class expects
  // an implementation of the TUIO callback methods (see below)
    tuioClient  = new TuioProcessing(this);

}

/**
 * The action loop
 */
void draw() {
  cls();// clear the screen
  runParticleSystem();// run the syste,
  tuio_draw();
}

// within the tuio_draw method we retrieve a Vector (List) of TuioObject and TuioCursor (polling)
// from the TuioProcessing client and then loop over both lists to draw the graphical feedback.
void tuio_draw(){


   float obj_size = object_size*scale_factor;
  float cur_size = cursor_size*scale_factor;

  Vector tuioObjectList = tuioClient.getTuioObjects();
  for (int i=0;i<tuioObjectList.size();i++) {
     TuioObject tobj = (TuioObject)tuioObjectList.elementAt(i);
     stroke(0);
     fill(0);
     pushMatrix();
     translate(tobj.getScreenX(width),tobj.getScreenY(height));
     rotate(tobj.getAngle());
     rect(-obj_size/2,-obj_size/2,obj_size,obj_size);
     popMatrix();
     fill(255);
   }

   Vector tuioCursorList = tuioClient.getTuioCursors();
   for (int i=0;i<tuioCursorList.size();i++) {
      TuioCursor tcur = (TuioCursor)tuioCursorList.elementAt(i);
      Vector pointList = tcur.getPath();

      if (pointList.size()>0) {
        stroke(0,0,255);
        TuioPoint start_point = (TuioPoint)pointList.firstElement();;
        for (int j=0;j<pointList.size();j++) {
           TuioPoint end_point = (TuioPoint)pointList.elementAt(j);
           line(start_point.getScreenX(width),start_point.getScreenY(height),end_point.getScreenX(width),end_point.getScreenY(height));
           start_point = end_point;
        }

        stroke(192,192,192);
        fill(192,192,192);
        ellipse( tcur.getScreenX(width), tcur.getScreenY(height),cur_size,cur_size);
      }
   }

}
// these callback methods are called whenever a TUIO event occurs

// called when an object is added to the scene
void addTuioObject(TuioObject tobj) {
  println("add object "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle());
}

// called when an object is removed from the scene
void removeTuioObject(TuioObject tobj) {
  println("remove object "+tobj.getSymbolID()+" ("+tobj.getSessionID()+")");
}

// called when an object is moved
void updateTuioObject (TuioObject tobj) {
  println("update object "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle()
          +" "+tobj.getMotionSpeed()+" "+tobj.getRotationSpeed()+" "+tobj.getMotionAccel()+" "+tobj.getRotationAccel());
}

// called when a cursor is added to the scene
void addTuioCursor(TuioCursor tcur) {
    particles.add(new Particle(tcur.getScreenX(width),tcur.getScreenY(height),10,10));

  println("add cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY());
}

// called when a cursor is moved
void updateTuioCursor (TuioCursor tcur) {
    particles.add(new Particle(tcur.getScreenX(width),tcur.getScreenY(height),10,10));

  println("update cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY()
          +" "+tcur.getMotionSpeed()+" "+tcur.getMotionAccel());
}

// called when a cursor is removed from the scene
void removeTuioCursor(TuioCursor tcur) {
  println("remove cursor "+tcur.getCursorID()+" ("+tcur.getSessionID()+")");
}

// called after each message bundle
// representing the end of an image frame
void refresh(TuioTime bundleTime) {
  redraw();
}
/**
 * This loops thru the list of particles and runs every particle
 */
void runParticleSystem() {

   for (int i = particles.size()-1; i >= 0;i--) {
      Particle p = particles.get(i);
      p.run();
      if (p.dead == true) {
        particles.remove(i);
      }
    }

  // for (int i = 0; i < particles.size();i++) {
  //   particles.get(i).run();
  // }
}
void mouseClicked() {
  particles.add(new Particle(mouseX,mouseY,10,10));
}
void cls() {
  fill(255,200);
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
  boolean dead = false;
  int time = 0;
  int lifetime = 100;
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
        if (!this.dead) {
      this.time++;
      if (this.time > this.lifetime) {
        this.dead = true;
      }
    }
  }
  // now run that thing
  public void run(){
    display();
    update();
  }
}

