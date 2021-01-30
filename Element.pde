float BASE_SPEED = 1;
abstract class Element {
  PVector pos, vel;
  PImage img;
  Camera cam;
  float sizeX, sizeY;
  float ratio = 1;
  float defaultRatio = 1;
  float weight = 0;
  float targetWeight = 0;
  boolean invalid = false;
  Element(PVector p, Camera c) {
    pos = p;
    cam = c;
    vel = new PVector(0 ,0);
  }
  void drawSelf() {
    if (!invalid) {
      translate(
        width/2 - cam.x + pos.x * cam.altitude - sizeX * ratio * cam.altitude / 2, 
        height/2 - cam.y + pos.y * cam.altitude - sizeY * ratio * cam.altitude / 2
      );
      image(img, 0, 0, sizeX * ratio * cam.altitude, sizeY * ratio * cam.altitude);
    }
  }
  void move(PVector v) {
    vel.add(v.copy().mult(BASE_SPEED * 60 / frameRate));
  }
  void update() {
    if (!invalid) {
      pos.add(vel);
      vel.mult(0.8);
      pushMatrix();
      drawSelf();
      popMatrix();
    }
  }
}
