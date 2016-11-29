public class Bullet {
  int x, y;
  PVector vel=new PVector();
  boolean shouldRemove=false;
  Bullet(int x, int y, float velX, float velY) {
    this.x=x;
    this.y=y;
    vel.x=velX;
    vel.y=velY;
  }
  void update() {
    x+=vel.x;
    y+=vel.y;
  }
  void draw() {
    if (shouldRemove)
      return;
    fill(0);
    stroke(0);
    ellipse(x, y, 4, 4);
  }
  void removeDetector() {
    if (x>rocket.pos.x-10&&x<rocket.pos.x-10+rocket.wide)
      if (y>rocket.pos.y-20&&y<rocket.pos.y)
        shouldRemove= true;
  }
}