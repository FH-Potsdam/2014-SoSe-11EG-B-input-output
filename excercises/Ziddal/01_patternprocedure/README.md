Aus Namen werden Freie Formen generiert:

Jeder Buchstabe erzeugt eine Ellipse;

Jeder Ellipse verbindet sich mit der nächste und generiert die Formen;

Die Farbe sind eine Mischung aus zufällige Werte zwiechen 0 und 255 und der Wert jedes Buchstabe nach ASCII Code.

```sh
import controlP5.*;
ControlP5 impLettere;

String name = "";

void controlEvent(ControlEvent theEvent) {
  //println("got a control event from controller with id "+theEvent.getController());
       if (theEvent.isFrom(impLettere.getController("name")))
    println("the event" + theEvent.getStringValue());
   int numberOfPoints = theEvent.getStringValue().length();
   println("numberOfPoints" + theEvent.getStringValue().length());
    //int numberOfPoints = name.length();//50;
     PVector [] mypoints = new  PVector [numberOfPoints];
    
   
    
    
beginShape ();

 //for(int i = 0; i < mypoints.length;i++){
 //}
  //println(mypoints);
  
  
  for(int j = 0; j <  mypoints.length; j = j + 1){
   
   PVector p = new PVector(random(width),random(height));
    mypoints[j] = p;
    //PVector p = mypoints[j];
     for(int c = 0; c < numberOfPoints;c++){
       
    char iniziale =(name.charAt(c));
    int var = iniziale++;
     //PVector p = new PVector(random(width-var),random(height-var));
   // mypoints[j] = p;
    println("iniziale" + iniziale);
    
    //int var=numberOfPoints;
    //fill(var+var,(var/3)*2,var);
    //fill(10,60*2,90);
    //fill(random(255),random(255),random(255));
   //fill(random(var),random(var),random(var));
    //fill(random(var),random(var),random(var));
    noStroke();
    //fill(0);
    //vertex(var+p.x,var+p.y);
    //fill(random(255-var),0,0,random(255-var));
    //fill(random(255+var),0,0,random(255+var));
    fill(random(255+var),random(255+var),random(255+var));
    //fill(var,var,var);
    //fill(0,90);
     //vertex(p.x-var,p.y-var);
    //ellipse (p.x-var,p.y-var,var-90,var-90);
    ellipse (p.x,p.y,var-90,var-90);
    //vertex(p.x-var,p.y-var);
   }
   //fill(random(255),random(255),random(255));
   fill(random(255),0,0,random(255));
   vertex(p.x,p.y);
  
    //println("x e y" + p.x,p.y);

  } endShape();
  
               println("numeroPunti" + numberOfPoints);
   
}
    
    

 


void setup(){
  background(255);
size(800,600);
impLettere = new ControlP5(this);

impLettere.addTextfield("name")
     .setColor(250)
     .setPosition(650, 550)
     .setSize(100, 20);
    
     //.setBackground(0);
     //.setControllerSize();
     
     
}
void draw(){
}

```
