class Food {
  PVector pos ;
  int type ;
  public Food() {
    this((random(1)<0.1)?0:1);
  }  
  public Food(int t) {
    this(t, random(20, width-20), random(20, height-20));
  } 
  public Food(Food f) {
    this(f.type, f.pos.x+int(random(-2,2))*16, f.pos.y+int(random(-2,2))*16);
  } 
  public Food(int t, float x, float y) {
    type = t;
    pos = new PVector(min(width-16,max(16,x)), min(height-16,max(16,y)));
  }
  public void show() {
    pushMatrix();
    translate(pos.x, pos.y);
    imageMode(CENTER);
    tint(255);
    image(vegImg[type], 0, 0);
    popMatrix();
  }
}