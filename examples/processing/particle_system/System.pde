class System {
   int w = 5;
   int h = 5;
   int lifetime = 500;
   ArrayList <Particle> particles;



  //--------------------------------------
  //  CONSTRUCTOR
  //--------------------------------------
   System() {
    particles = new ArrayList<Particle>();
  }
  //--------------------------------------
  //  CONSTRUCTOR (overloaded)
  //--------------------------------------
   System( int _w, int _h) {
    this.w = _w;
    this.h = _h;
    particles = new ArrayList<Particle>();
  }
  //--------------------------------------
  //  CONSTRUCTOR (overloaded)
  //--------------------------------------
   System(int num, int _w, int _h, int _lifetime) {
    this.w = _w;
    this.h = _h;
    this.lifetime = _lifetime;
    particles = new ArrayList<Particle>();
    for (int i = 0; i < num; i++) {
      particles.add(new Particle(random(0, width), random(0, height), _w, _h, _lifetime));
    }
  }

  /**
   * This loops thru the list of particles and runs every particle
   */

   void run() {
    drawParticles();
  }

   void drawParticles() {
    for (int i = particles.size()-1; i >= 0;i--) {
      Particle p = particles.get(i); 
      p.run();
      if (p.dead == true) {
        particles.remove(i);
      }
    }
  } 

  void addParticle() {
    particles.add(new Particle(mouseX, mouseY, this.w, this.h, this.lifetime));
  }
}

