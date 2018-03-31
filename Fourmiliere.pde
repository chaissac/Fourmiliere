final float VMAX = 1.5, AMAX = 0.15 ; 
PImage[] antImg ;
PImage ground ;
PImage[] vegImg ;
Fourmi[] ants ;
ArrayList<Food> foods = new ArrayList<Food>();
int nb = 3 ;
boolean debug = true;

void setup() {
  size(800, 500, P3D);
  frameRate(60);
  PImage tmpAnt = loadImage("ants.png");
  ground = loadImage("ground.jpg");
  ground.resize(width, height);
  PImage tmpVeg = loadImage("vegetation.png");
  antImg = new PImage[4];
  for (int i=0; i<4; i++) {
    antImg[i] = createImage(128, 96, ARGB);
    antImg[i].copy(tmpAnt, (i%2)*128, int(i/2)*160, 128, 96, 0, 0, 128, 96);
    antImg[i].resize(24, 18);
    for (int j=0; j<5; j++) foods.add(new Food());
  }
  vegImg = new PImage[2];
  vegImg[0] = createImage(24, 24, ARGB);
  vegImg[0].copy(tmpVeg, 4, 164, 24, 24, 0, 0, 24, 24);
  vegImg[1] = createImage(24, 24, ARGB);
  vegImg[1].copy(tmpVeg, 100, 36, 24, 24, 0, 0, 24, 24);

  ants = new Fourmi[nb];
  for (int i=0; i<ants.length; i++) ants[i]=new Fourmi(random(20, width-20), random(20, height-20));
}

void draw() {
  background(ground);
  //if (random(1)<0.03) foods.add(new Food());
  for (Fourmi ant : ants) {
    ant.yum(foods);
    ant.move();
    ant.show();
  }
  float maxX = 0, maxY = 0;
  if (random(1)<0.1 && foods.size()<nb*5) foods.add(new Food());
  for (int i=foods.size()-1; i>=0; i--) {
    foods.get(i).show();
  }  
  println(maxX+" , "+maxY+" / "+foods.size()+" plants, frameRate "+frameRate);
}