class Fourmi {
  PVector pos, vel, acc ;
  float load, age, health, hunger, velMax, accMax ;
  float index;
  float[] dna;
  public Fourmi(float x, float y) {
    velMax = VMAX ;
    accMax = AMAX ;
    pos = new PVector(x, y) ;
    vel = PVector.random2D().mult(random(0, velMax)) ;
    acc = new PVector(0, 0) ;
    load = 0 ;
    age = 0 ;
    health = 100 ;
    hunger = 50 ;
    index = 0 ;
    dna = new float[10];
    dna[0]=random(-.1,.1);
    dna[1]=1;
  }
  void apply(PVector f) {
    acc.add(f);
  }
  void target(float x, float y) {
    target(new PVector(x, y));
  }
  void target(PVector t) {
    apply(PVector.sub(PVector.sub(t, pos), vel).limit(accMax));
  }
  void yum(ArrayList<Food> f) {
    if (hunger>10) {
      Food closestFood = null;
      float closestD = 999999999;
      for (int i = f.size() - 1; i >= 0; i--) {
        float d = pos.dist(f.get(i).pos);
        if (d < max(hunger, health)*3 && d < closestD) {
          closestD = d;
          closestFood = f.get(i);
          if (d < 10) {
            health += (closestFood.type==0)?-20:5;
            hunger -= (closestFood.type==1)?10:2;
            f.remove(i);
            //f.add(new Food());
          }
        }
      }
      if (closestFood!=null) {
        target(closestFood.pos.copy().mult(dna[closestFood.type]));
      }
    }
  }
  void move() {
    if (acc.magSq()==0 && random(1)<.1) apply(PVector.random2D().sub(vel).limit(accMax));
    vel.add(acc).limit(velMax*health/100);
    pos.add(vel);
    acc.mult(0);
    float v = vel.mag();
    index+=v/2;
    if (round(index)>3) index = 0 ;
    //if (pos.x<8 || pos.x>width-8) vel.set(-vel.x,vel.y);
    //if (pos.y<8 || pos.y>height-8) vel.set(vel.x,-vel.y);
    if (pos.x<20 || pos.x>width-20 || pos.y<20 || pos.y>height-20) target(width/2, height/2);
    hunger+=.05;
    hunger=min(100, hunger);
    health+=(hunger<50)?.1:-.1;
    health=min(100, health);
  }
  void show() {
    if (health>0) {
      pushMatrix();
      translate(pos.x, pos.y);
      rotate(vel.heading());
      if (debug) {
        ellipseMode(CENTER);
        strokeWeight(1);
        noFill();
        stroke(#00FF00);
        ellipse(0, 0, hunger, hunger);
        stroke(int(health*2.5));
        ellipse(0, 0, health, health);
      }
      imageMode(CENTER);
      tint(map(health, 0, 100, 255, 0), 0, 0);
      image(antImg[round(index)], 0, 0);
      popMatrix();
    }
  }
}