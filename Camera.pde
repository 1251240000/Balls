float BASE_ALTITUDE = 1;
class Camera extends PVector {
  ArrayList<Player> bindPlayer;
  float altitude = 1;
  PImage img;
  Camera() {
    img = loadImage("assets/img/bgframe.png");
  }
  void bind(ArrayList<Player> p) {
    if (p.size() == 1) {
      x = p.get(0).pos.x;
      y = p.get(0).pos.y;
    }
    bindPlayer = p;
  }
  void update() {
    image(img, 0, 0);
    if (bindPlayer.size() == 1) {
      altitude = (bindPlayer.get(0).defaultRatio / bindPlayer.get(0).ratio - 1) / 2 + 1;
      //x = bindPlayer.get(0).pos.x;
      //y = bindPlayer.get(0).pos.y;
      altitude *= BASE_ALTITUDE;
      add((bindPlayer.get(0).pos.copy().mult(altitude).sub(this)).mult(0.3));
    } else if (bindPlayer.size() > 1) {
      PVector direct = new PVector(0, 0);
      for (Player p: bindPlayer) {
        altitude = min(altitude, (p.defaultRatio / p.ratio - 1) / 2 + 1);
        direct.add(p.pos.copy());
      }
      direct.mult(1.0 / bindPlayer.size());
      // aaltitude *= BASE_ALTITUDE;
      add(direct.mult(altitude).sub(this).mult(0.3));
    }

  }
}
