// Constants
void settings() {
  size(1000, 1000);
}

color b1, b2;
Rocket rocket;
Health healthChecker;
ArrayList <Platform> platforms;
ArrayList<Turret> turrets;
boolean gameStarted=false;
PImage img;
PImage turret;
void setup() { 
  img= loadImage("explosion.png");
  turret=loadImage("turret.png");
  reset();
}

void draw() {   
  if (gameStarted) {
    setGradient();
    healthChecker.paint();
    for (Platform p : platforms)
      p.paint();
    for (Turret t : turrets) {
      t.paint();
      t.shootPlayer();
      t.bulletRemoval();
    }
    rocket.paint();      
    rocket.update();
    rocket.collision();
    rocket.platFormCollision();
  } else {
    background(50, 50, 255);
    textSize(30);
    fill(255, 175, 0);
    text("Rocket Ruiner", width/2-75, height/2-50);
    textSize(20);
    text("Press Enter to Start", width/2-69, height/2);
    textSize(15);
    text("Press R to Restart", width/2-45, height/2+40);
  }
}

void setGradient() {
  int y=0;
  color c1 = color(255, 84, 4);
  color c2 = color(255, 175, 0);
  noFill(); 
  for (int i = y; i <= y+height; i++) {
    float inter = map(i, y, y+height, 0, 1);
    color c = lerpColor(c1, c2, inter);
    stroke(c);
    line(0, i, width, i);
  }
}
void keyPressed() {
  if (keyCode==UP) 
    rocket.upHeldChanger("pressed");
  if (keyCode==LEFT) 
    rocket.spin="counter";  
  if (keyCode==RIGHT) 
    rocket.spin="clock";   
  if (key==ENTER)
    gameStarted=true;
  if (key=='k')
    healthChecker.health=0;
  if (key=='r') {
    gameStarted=false;
    reset();
  }
}
void keyReleased() {
  if (keyCode==UP)
    rocket.upHeldChanger("released");
  if (keyCode==LEFT||keyCode==RIGHT) {
    rocket.spin="dont";
  }
}
void reset() {
  rocket=new Rocket();
  healthChecker=new Health();
  platforms=new ArrayList <Platform>(); 
  platforms.add(new Platform(width/3, height/2, 40, 20));
  platforms.add(new Platform(600, height/2, 40, 20));
  turrets=new ArrayList <Turret>();
  turrets.add(new Turret(width-40, 40));
}