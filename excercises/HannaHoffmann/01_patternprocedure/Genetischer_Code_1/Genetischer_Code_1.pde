float x;
float y;
//float Kommerzahlen (ganze Zahlen wären int)

float richtungx;
float richtungy;
//global definiert.


void setup() {

  background(250);
  size(800, 600);

  x=width/2;
  y=height/2;
  richtung();
  
  smooth(8);
  
    fill(255); // füllung
    stroke(255, 0, 0); //Kontur wird rot  
  beginShape();
    vertex(30, 30);
    vertex(400, 10);
    vertex(780, 20);
    vertex(770, 300);
    vertex(790, 590);
    vertex(400, 590);
    vertex(30, 560);
  endShape(CLOSE);
  
  stroke(0);//Line schwarz
}



void draw() {


  loadPixels();
  int pixel = get((int)x, (int)y);
  if (pixel == (-65536) || pixel == (-328966) ) { 
    // Wenn Pixelfarbe rot oder grau, Richtungswechsel)
    richtung();
  }
  point(x, y);

  x = x+richtungx;
  y = y+richtungy;
}
//Endlosschleife der Gerade

void richtung() {
  richtungx = random(-1, 1); //Richtung wird zufällig bestimmt zwischen -1 und +1
  richtungy = random(-1, 1);
}

String timestamp;
void keyPressed(){
if(key == 's'){
timestamp = year() + nf(month(),2) + nf(day(),2) + "-" + nf(hour(),2) + nf(minute(),2) + nf(second(),2);
saveFrame("lines-"+timestamp+".jpg");
}
}

//Speichern mit "s"
