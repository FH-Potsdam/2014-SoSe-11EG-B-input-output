import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.pdf.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class TriGrid extends PApplet {


boolean record;


float radius = 35;

float x, y;
float oldX, oldY;

Boolean fade = false;

String timestamp;
Boolean saveIt = false;

public void setup()
{
    size( 1200, 800);
    beginRecord(PDF, "frame-####.pdf"); 
    background( 0 );
    strokeWeight( 2 );
    stroke( 0, 255, 222);
    
    x = width/2;
    y = height/2;
    
    oldX = x;
    oldY = y;

    stroke(255, 0);
    strokeWeight( 6 );
    point( x, y );
    frameRate(10);

    
}

public void draw()
{

    if (fade) {
        noStroke();
        fill( 0, 2 );
        rect( 0, 0, width, height );
    }
    
    float angle = (TWO_PI / 6) * floor(random( -6,6 ));
    x += cos( angle ) * radius;
    y += sin( angle ) * radius;
    
    if ( x < 0 || x > width ) {
        x = oldX;
        y = oldY;
    }
    
    if ( y < 0 || y > height) {
        x = oldX;
        y = oldY;
    }
    
    stroke( 0, 255, 222, 50 );
    strokeWeight( 2 );
    line( x, y, oldX, oldY );
    stroke(255, 100);
    strokeWeight( 4 );
    point( x, y );
    
    oldX = x;
    oldY = y;
    
    if (saveIt) {
        saveFrame("images/TriGrid-Sketch-#####.png");
        saveIt = false;
    }

    if (record) {
    endRecord();
    }
}

public void mousePressed() {
  record = true;
}


public void keyPressed(){
    if(key == 's'){
    timestamp = nf(day(),2) + "." + nf(month(),2) + "." + year() + "_" + nf(hour(),2) + "-" + nf(minute(),2) + "-" + nf(second(),2);
    saveFrame("images/TriGrid-"+timestamp+".jpg");
    }
        if (key == 'f') {
        fade = !fade;
    }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "TriGrid" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
