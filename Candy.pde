int QUANTITYOFCANDY = 1200;
int INITIALQUANTITYOFCANDY = 1200;
class Candy extends Element {
  // float weight;
  float targetRatio;
  Candy(PVector p, Camera c) {
    super(p, c);
    if (random(200) < 1) {
      img = loadImage("assets/img/cake.png");
      targetRatio = 0.18;
      ratio = 0;
      weight = 50;
      targetWeight = 500;
    } else {
      img = loadImage("assets/img/candy" + int(random(15)) + ".png");
      targetRatio = 1;
      ratio = 0;
      weight = 10;
      targetWeight = 10;
    }
    sizeX = img.width;
    sizeY = img.height;
  }
  void update() {
    if (ratio < targetRatio) {
      ratio += targetRatio / 10;
    }
    super.update();
  }
}
