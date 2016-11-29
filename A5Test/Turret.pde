public class Turret {
  int x, y;
  float time=millis();  
  ArrayList<Bullet> bullets;

  Turret(int x, int y) {
    this.x=x;
    this.y=y;
    bullets=new ArrayList<Bullet>();
  }
  void paint() {
    image(turret, x, y, 40, 40);
    for (Bullet b : bullets) {
      b.update();
      b.draw();
    }
  }
  void bulletRemoval() {
    for (Bullet b : bullets) {//concurrentModification exception
      b.removeDetector();
    }
  }

  void shootPlayer() {
    if (millis()>time) {  
      bullets.add(new Bullet(x, y, -1, 1));
      time = millis()+1800;
    }
  }
}