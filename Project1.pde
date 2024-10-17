import java.util.*;

PVector rVector;
PVector lVector;
List<Particle> rFlare;
List<Particle> lFlare;
PImage hand;
PImage cloud1;
PImage cloud2;
PImage land;
PImage skull;
PFont titleFont;
PFont subtitFont;
float imageOsc;

void setup() {
  size(500, 850);
  
  rVector = new PVector(width/2+50, height/2-200);
  lVector = new PVector(width/2-38, height/2-200);
  rFlare = new ArrayList();
  lFlare = new ArrayList();
  hand = loadImage("hand.png");
  cloud1 = loadImage("cloud1.png");
  cloud2 = loadImage("cloud2.png");
  land = loadImage("Hemisphere_land.png");
  skull = loadImage("skull.png");
  titleFont = createFont("BebasNeue-Regular.otf", 128);
  subtitFont = createFont("GAELA.otf", 30);
  imageOsc = 0;
}

void draw() {
  background(0);
  imageMode(CENTER);
  tint(50*Math.abs(sin(imageOsc*0.1)));
  
  image(skull, width/2, 220, 1126*0.3,1308*0.3);
  
  tint(100);
  
  imageOsc += radians(2);
  image(hand, width/2+10, height/2+110+5*sin(imageOsc*0.7));
  fill(0);
  circle(width+180, height/2+200+8*sin(imageOsc), 500);
  
  fill(0, 0, 200, 100);
  circle(width/2+4, height/2-6+5*sin(imageOsc*0.7), 103);
  tint(80);
  image(land, width/2+4, height/2-6+5*sin(imageOsc*0.7), 110, 110);
  
  tint(170-100*abs(sin(imageOsc*0.3)));
  image(cloud1, width/2+4, height/2-6+5*sin(imageOsc*0.7), 103, 103);
  tint(170-100*abs(cos(imageOsc*0.3)));
  image(cloud2, width/2+4, height/2-6+5*sin(imageOsc*0.7), 103, 103);
  
  fill(100);
  textAlign(CENTER);
  textFont(subtitFont, 30);
  text("Vol. 16 The half elf God-kin", width/2, height/2+315);
  textFont(subtitFont, 20);
  text("The world is all yours.", width/2, 70);
  text("| Kagune Maruyama", width/2+100, height/2+350);
  textFont(titleFont, 125);
  text("OVERLORD", width/2, height/2+280);
  
  for(int i = 0; i < rFlare.size(); i++){
    rFlare.get(i).applyForce(new PVector(0.1, -0.05));
    lFlare.get(i).applyForce(new PVector(-0.1, -0.05));
  }
  
  for (int i = rFlare.size()-1; i >= 0; i--) {
    Particle pr = rFlare.get(i);
    Particle pl = lFlare.get(i);
    pr.run();
    pl.run();
    if (pr.lifespan <= 0.0) rFlare.remove(i);
    if (pl.lifespan <= 0.0) lFlare.remove(i);
  }
  
  rFlare.add(new Particle(rVector));
  lFlare.add(new Particle(lVector));

}

class Particle {
  PVector loc;
  PVector vel;
  PVector acc;
  float lifespan;

  Particle(PVector l) {
    acc = new PVector(0, 0);
    vel = new PVector(randomGaussian()*0.3, randomGaussian()*0.3);
    loc = l.copy();
    lifespan = 150.0;
  }

  void run() {
    update();
    draw();
  }

  void applyForce(PVector f) {
    acc.add(f);
  }  

  void update() {
    vel.add(acc);
    loc.add(vel);
    lifespan -= 2.0;
    acc.mult(0);
  }

  void draw() {
    fill(150*abs(sin(imageOsc*0.1)), 0, 0, 255*lifespan/150);
    noStroke();
    circle(loc.x, loc.y, 20*lifespan/150);
  }
}
