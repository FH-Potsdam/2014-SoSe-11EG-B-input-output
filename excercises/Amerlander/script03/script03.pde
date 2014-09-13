int x;
int y;
int vy;
int vx;
int anzahl = (int) random(10, 1000);
int i;
int punkt;
int genug=0;

void setup(){
  noStroke();
    size(800, 600);
    background(255);
    richtung();
    anfang();
    fill(255);
 //   rect(0,0,width,15);
 //   rect(0,height-15,width,15);
 //   rect(0,0,15,height);
 //   rect(width-15,0,15,height);
    stroke(0);
}


void draw(){
  genug=0;
//stroke(random(255), 0, 0);
      if(i == anzahl){
        println("Fertig");
        i++;
      }
    
      if((x>=width-20 || y>=height-20 || x<=20 || y<=20) && i < anzahl) { // neue Linie initiieren
      i++;
      println("Neue Linie Nummer "+i+" von "+anzahl);
    richtung();
    anfang();
      }
      
      
      for(int i = 0; i < 10; i++) {
        loadPixels();
          if(get(x,y) < -10) {
            richtung();
          }
          point(x,y);
        //  println("nachher: "+get(x,y));
            
          x = x + vx;
          y = y + vy;
          
      }
    
    

}

String timestamp;
void keyPressed(){
  if(key == 's'){
    timestamp = year() + nf(month(),2) + nf(day(),2) + "-"  + nf(hour(),2) + nf(minute(),2) + nf(second(),2);
    saveFrame("Bild-"+timestamp+".jpg");
}
}


void richtung() {
         // Richtung
        int richtung = (int) random(8);
        println("Richtung: "+richtung);
        if(richtung==0){
          vy = 0;
          vx = 1;
        }
        if(richtung==1){
          vy = 1;
          vx = 1;
        }
        if(richtung==2){
          vy = 1;
          vx = 0;
        }
        if(richtung==3){
          vy = 1;
          vx = -1;
        }
        if(richtung==4){
          vy = 0;
          vx = -1;
        }
        if(richtung==5){
          vy = -1;
          vx = -1;
        }
        if(richtung==6){
          vy = -1;
          vx = 0;
        }
        if(richtung==7){
          vy = -1;
          vx = 1;
        }
        
        int testx = x+vx;
        int testy = y+vy;

        if(get(testx,testy) < -10 && genug < 10) {
          richtung();
          genug++;
        }
        
}

void anfang() {
  // Anfang
        int start = (int) random(4); 
        println("Seite: "+start);
        if(start==0){
          x=20;
          y=int(random(height-40)+20);
        }
        if(start==1){
          x=width;
          y=int(random(height-40)+20);
        }
        if(start==2){
          x=int(random(width-40)+20);
          y=20;
        }
        if(start==3){
          x=int(random(width-40)+20);
          y=20;
        }
}
