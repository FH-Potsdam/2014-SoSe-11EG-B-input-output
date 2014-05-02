float radius = 40;

float x, y;
float x2, y2;
float oldX, oldY;
float oldX2, oldY2;

Boolean fade = false;

Boolean saveIt = false;

void setup()
{
    size( 800, 800 );
    background( 0 );
    

    
    x = width/2;
    y = height/2;
    x2 = width/2;
    y2 = height/2;
    
    oldX = x;
    oldY = y;

    oldX2 = x;
    oldY2 = y;

    strokeWeight( 10 );
    stroke(0,255,200, 100);
    point( x, y );

    strokeWeight( 10 );
    stroke(0, 100);
    point( x2, y2 );
    frameRate(3000);

}

void draw()
{
    if (fade) {
        noStroke();
        fill( 0, 1 );
        rect( 0, 0, width, height );
    }
    
    float angle = (TWO_PI / 6) * random( -6,6 );
    x += cos( angle ) * radius;
    y += sin( angle ) * radius;
    float angle2 = (TWO_PI / 2) * random( -6,6 );
    x2 += cos( angle2 ) * radius;
    y2 += sin( angle2 ) * radius;
    
    if ( x < 0 || x > width ) {
        x = oldX;
        y = oldY;
    }
    
    if ( y < 0 || y > height) {
        x = oldX;
        y = oldY;
    }
    
    if ( x2 < 0 || x2 > width ) {
        x2 = oldX2;
        y2 = oldY2;
    }
    
    if ( y2 < 0 || y2 > height) {
        x2 = oldX2;
        y2 = oldY2;
    }
    strokeWeight( 2 );
    stroke(0, 255,200, 60 );
    line( x, y, oldX, oldY );

    strokeWeight( 6 );
    stroke(0, 100);
    line( x2, y2, oldX2, oldY2 );

    strokeWeight( 10 );
    stroke(0,255,200, 60);
    point( x, y );

    strokeWeight( 20 );
    stroke(0, 100);
    point( x2, y2 );
    
    oldX = x;
    oldY = y;

    oldX2 = x2;
    oldY2 = y2;
    
    if (saveIt) {
        saveFrame("images/TriGrid-Sketch-#####.png");
        saveIt = false;
    }
    
}

void keyPressed()
{
    if (key == 'f') {
        fade = !fade;
    }
    
    if (key == 's') {
        saveIt = true;
    }
}
