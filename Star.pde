int QUANTITYOFSTAR = 1;
int INITIALQUANTITYOFSTAR = 10;

boolean EVENT_SLOWDOWN = false;
boolean EVENT_SPEEDUP = false;
boolean EVENT_ALTITUDEUP = false;
boolean EVENT_ALTITUDEDOWN = false;

int EVENT_DURATION = 0;

class Star extends Candy {
  PImage img_shake1;
  PImage img_shake2;
  int shaking = 0;
  Star(PVector p, Camera c){
    super(p, c);
    img_shake1 = loadImage("assets/img/star0.png");
    img_shake2 = loadImage("assets/img/star1.png");
    img = img_shake1;
    targetRatio = 0.2;
    weight = 10;
    targetWeight = 100;
    sizeX = img.width;
    sizeY = img.height;
  }
  void update() {
    shaking += 1;
    if (shaking % int(frameRate) < frameRate / 2) {
      img = img_shake1;
    } else {
      img = img_shake2;
    }
    if (shaking >= 100) {
      shaking = 0;
    }
    super.update();
  }
  void event() {
    int e = int(random(2));
    EVENT_DURATION = int(random(7, 15) * frameRate);
    switch (e) {
      case 0:
        EVENT_SLOWDOWN = true;
        BASE_SPEED = 0.5;
        break;
      case 1:
        EVENT_SPEEDUP = true;
        BASE_SPEED = 1.5;
        break;
      case 2:
        EVENT_ALTITUDEUP = true;
        BASE_ALTITUDE = 1.5;
        break;
      case 3:
        EVENT_ALTITUDEDOWN = true;
        BASE_ALTITUDE = 0.5;
        break;
    }
  }
}
