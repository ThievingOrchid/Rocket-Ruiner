public class Rocket {
  float x, y, xTangent, yTangent;
  int wide=10;
  int high=20;
  float left, top, right, bot;
  PVector pos, vel, accel;  
  boolean upHeld=false; 
  String spin="dont";
  float angle=0;
  float fuel=100; 
  Rocket() {
    pos=new PVector(width/2, height);
    vel=new PVector(0, 0); 
    accel=new PVector(0, 0);
  }
  void paint() {
    fill(0);
    rect(10, 25, fuel*2, 10);//draw fuel;
    translate(pos.x, pos.y); 
    if (spin.equals("clock")) {//rotate clockwise
      angle+=PI/50;
    }
    if (spin.equals("counter")) {//rotate coutner-clockwise
      angle-=PI/50;
    }
    if (healthChecker.health>0) {//player is alive
      rotate(angle);
      fill(0, 192, 255);
      noStroke();
      rect(-10, -20, wide, high);//draw the rocket
    } else {//player is dead, draw explosion
      noFill();      
      image(img, -25, -40, 40, 40);
      vel=new PVector(0, 0);
      accel=new PVector(0, 0);
    }
  }
  void update() {   
    if (upHeld)
      fuel=Math.max(fuel-.1, 0);
    if (vel.y<0) {//when going up, go towards the front of the rocket
      pos.y+=(vel.y*Math.cos(angle));
      pos.x-=(vel.y*Math.sin(angle));
    } else {//when dropping to earth, just drop
      pos.add(vel);
    }
    vel.add(accel);
    vel.x=constrain(vel.x, -20, 20);
    vel.y=constrain(vel.y, -25, 25);
  }

  void collision() {
    if (pos.y>height) {
      pos.y=height;
      damageChecker();
      vel.y=0;
      accel.y=0;
    }
    if (pos.y<20) {
      damageChecker();
      pos.y=20;
      vel.y=0;
      accel.y=.1;
    }
    if (pos.x<25||pos.x>width) {
      damageChecker();
      vel.x=0;
      vel.y=0;   
      pos.x=constrain(pos.x, 25, width);
    }//dont go outside x axis of window
  }
  void upHeldChanger(String action) {//handles the 'UP' key
    if (action.equals("pressed")&&fuel>0&&healthChecker.health>0) {
      //player is holding up. If they have fuel, accelerate up.
      upHeld=true;     
      accel.y=-.2;
      accel.y=constrain(accel.y, -2, 5);
    }
    if (action.equals("released")) {
      //player released up, stop going up
      upHeld=false;
      accel.y=.3;
    }
  }

  void platFormCollision() {
    for (Platform p : platforms) {//rocket lands on platform
      if (pos.y+high>p.top&&pos.y+high<p.bot+5&&pos.x+wide-10>p.left&&pos.x-10<p.right&&(abs(vel.y)>4||vel.y>0)) {
        damageChecker();       
        pos.y=p.top;
        angle=0;
        vel.y=0;
        vel.x=0;
        accel.y=0;
      }
      //rocket hits bottom of platform

      else if (pos.y<p.bot+20&&pos.y-20>p.top&&pos.x+wide>p.left&&pos.x-10<p.right&&vel.y<0) {
        damageChecker();
        pos.y=p.bot+30;
        vel.y=0;
        vel.x=0;
        //print("hit bot");
      }
    }
  }
  void damageChecker() {
    if (vel.y>7||vel.y<-7) 
      healthChecker.change(-Math.abs(vel.y)*2);
  }
}