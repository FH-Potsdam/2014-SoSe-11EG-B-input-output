float xcenter;
float ycenter;
float rad = random(100, 500);
float angle;
int cx = 300;
int cy = 300;
float p =3;
float q = 250;
PImage img_w1; //Bilder Definitionen
PImage img_o1;
PImage img_r1;
PImage img_l1;
PImage img_d1;
//
PImage img_w2;
PImage img_r2;
PImage img_o2;
PImage img_n2;
PImage img_g2;


void setup() {
 

  size (800, 800);
  
  smooth ();
  background(255);
  
  img_w1 = loadImage("img_w1.png"); //Bilder Ladung Translator
  img_o1 = loadImage("img_o1.png");
  img_r1 = loadImage("img_r1.png");
  img_l1 = loadImage("img_l1.png");
  img_d1 = loadImage("img_d1.png");

  img_w2 = loadImage("img_w2.png"); //Bilder Ladung Schreibmaschiene
  img_r2 = loadImage("img_r2.png");
  img_o2 = loadImage("img_o2.png");
  img_n2 = loadImage("img_n2.png");
  img_g2 = loadImage("img_g2.png");

  xcenter = width / 2;
  ycenter = height / 2;
}

void draw () {
  fill (0, 4);
  rect (0, 400, 400, 400);
  fill (255, 2);
  rect (400, 400, 800, 800);
  fill (0, 10);
  rect (400, 0, 400, 400);

  println(millis()%20);
  int m = millis();

  if (millis()%30 ==3) {
    angle=-angle;
    
  }



 


  float rad = angle;
  float x = xcenter + cos(angle) * rad;
  float y =ycenter + sin (angle) * rad;


  //if (millis()%30 == 5) {
    
   //angle = angle % m;
    
   
  //}
  //fill (0,random(255));
  //ellipse (x,y,20,20);

  //fill (200,random(255));
  //ellipse (x,y,p,q);
  image(img_w1, x-200, y+200); //Bilderreihe Translator (World)
  image(img_o1, x-100, y+100);
  image(img_r1, x, y);
  image(img_l1, x+100, y-100);
  image(img_d1, x+200, y-200);

  image(img_w2, x-200, y-200); //Bilderreihe Schreibmaschiene (Wrong)
  image(img_r2, x-100, y-100);
  
  image(img_n2, x+100, y+100);
  image(img_g2, x+200, y+200);
  
  fill(random(xcenter,rad),2);
  ellipse(x,y,x+angle+rad,y+angle+rad);



  //x=x+1;
  //y=y+2;
  
  float t = millis()/400.0f;
  int e = (int)(xcenter+rad*cos(t));
  int f = (int)(ycenter+rad*sin(t));
  
  if (angle < 400) {
    x=x+10;
  y=y+10;
    
   
    
   
  }else{
     x=--x;
    y=-y;
  }
  

  
  


  if (rad > 40) {

    angle = angle+1;
  }
  if (x > width) {
    angle= -2+angle;
    rad = rad/10;
  }

  if (rad < 50) {

    angle= angle +1;
  }

  //if (rad > 260) {
  // angle = random(0,300);
  // }

  if (rad>150) {
    x=y;
  }
}
void drehen () {




}
//if(y>20) {

//y = y+1;
//}

