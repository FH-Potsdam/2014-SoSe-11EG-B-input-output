int x; int y; int vy; int vx; int anzahl = (int) random(10, 1000); int i; int punkt;

void setup(){
    size(800, 600);
    background(255);
    richtung(); anfang();
}

void draw(){
      if(i == anzahl){ println("Fertig"); i++; } // Fertig mit zeichnen
      if((x>=width-20 || y>=height-20 || x<=20 || y<=20) && i < anzahl) { // neue Linie initiieren
      i++; richtung(); anfang();
      }
      
      for(int i = 0; i < 10; i++) {
        loadPixels();
        if(get(x,y) < -10) { richtung(); }
        point(x,y);
        x = x + vx; y = y + vy;
      }
}

void richtung() {
        int richtung = (int) random(8);
        if(richtung==0){ vy = 0; vx = 1; }
        if(richtung==1){ vy = 1; vx = 1; }
        if(richtung==2){ vy = 1; vx = 0; }
        if(richtung==3){ vy = 1; vx = -1; }
        if(richtung==4){ vy = 0; vx = -1; }
        if(richtung==5){ vy = -1; vx = -1; }
        if(richtung==6){ vy = -1; vx = 0; }
        if(richtung==7){ vy = -1; vx = 1; }
}

void anfang() {
        int start = (int) random(4); 
        if(start==0){ x=20; y=int(random(height-40)+20); }
        if(start==1){ x=width; y=int(random(height-40)+20); }
        if(start==2){ x=int(random(width-40)+20); y=20; }
        if(start==3){ x=int(random(width-40)+20); y=20; }
}





