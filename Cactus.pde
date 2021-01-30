int QUANTITYOFCACTUS = 30;
int INITIALQUANTITYOFCACTUS = 30;
class Cactus extends Candy {
  Cactus(PVector p, Camera c){
    super(p, c);
    img = loadImage("assets/img/cactus.png");
    targetRatio = random(0.4, 0.8);
    weight = targetRatio / 0.18 * 500;
    targetWeight = weight;
    sizeX = img.width;
    sizeY = img.height;
  }
}
