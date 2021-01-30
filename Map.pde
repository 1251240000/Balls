float[] startPos = {440, 260};
float[] endPos = {5200, 3100};

class Map extends Element {
  Map(PVector p, Camera c) {
    super(p, c);
    img = loadImage("assets/img/bggrid.png");
    sizeX = img.width;
    sizeY = img.height;
  }
  void drawSelf() {
    if (!invalid) {
      translate(
        width/2 - cam.x + pos.x, 
        height/2 - cam.y + pos.y
      );
      image(img, 0, 0, sizeX * ratio * cam.altitude, sizeY * ratio * cam.altitude);
    }
  }
}
