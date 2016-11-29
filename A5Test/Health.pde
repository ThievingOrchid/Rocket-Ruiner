public class Health {
  int health=100;
  float r=0;
  float g=255;
  float b=0;
  color current=color(r, g, b);

  void paint() {
    colorCorrector();
    fill(current);
    rect(10, 10, health*2, 10);
  }
  void change(float
    change) {
    health+=change;
    health=constrain(health, 0, 100);
  }
  void colorCorrector() {
    g=map(health, 0, 100, 0, 255);
    r=255-g;
    current=color(r, g, b);
  }
}