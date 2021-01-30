StringList ACTION = new StringList("w", "a", "s", "d", " ");
ArrayList<PVector> DIRECTS = new ArrayList<PVector>() {{
  add(new PVector(0, -1)); 
  add(new PVector(-1, 0)); 
  add(new PVector(0, 1)); 
  add(new PVector(1, 0)); 
}};

abstract class Ball extends Element {
  float defaultWeight = 1000;
  JSONObject directSwitch = new JSONObject() {{
    setBoolean("w", false);
    setBoolean("a", false);
    setBoolean("s", false);
    setBoolean("d", false);
  }};
  Ball(PVector p, Camera c) {
    super(p, c);
    defaultRatio = 0.18;
    targetWeight = 1000;
    ratio = defaultRatio;
  }
  void sound(String file) {
    //if (SOUNDON) {
    //  AudioPlayer groove = minim.loadFile("assets/media/" + file);
    //  groove.play();
    //}
  }
  void checkWalls() {
    if (pos.x < startPos[0] + sizeX * ratio / 2) {
      directSwitch.setBoolean("a", false);
    }
    if (pos.x > endPos[0] - sizeX * ratio / 2) {
      directSwitch.setBoolean("d", false);
    }
    if (pos.y < startPos[1] + sizeY * ratio / 2) {
      directSwitch.setBoolean("w", false);
    }
    if (pos.y > endPos[1] - sizeY * ratio / 2) {
      directSwitch.setBoolean("s", false);
    }
  }
  boolean swallow(Element c) {
    if (pos.dist(c.pos) - abs(sizeX * ratio - c.sizeX * c.ratio) / 2 < 3 * ratio / defaultRatio) {
      if (sizeX * ratio > c.sizeX * c.ratio) {
        targetWeight += c.targetWeight;
        return true;
      }
    }
    return false;
  }
  void increase() {
    if (weight - targetWeight < 0) {
      weight += (targetWeight - weight) / 10;
      ratio = defaultRatio * pow(weight / defaultWeight, 0.5);
    }
    if (weight - targetWeight > 0) {
      weight -= (weight - targetWeight) / 10;
      ratio = defaultRatio * pow(weight / defaultWeight, 0.5);
    }
  }

  void update() {
    if (!invalid) {
      increase();
      checkWalls();
      for (int i=0; i<4; i++) {
        if (directSwitch.getBoolean(ACTION.get(i))) {
          move(DIRECTS.get(i).copy().mult(min(0.9, defaultWeight / weight)));
        }
      }
      super.update();
    }
  }
}
