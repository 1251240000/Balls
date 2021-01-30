int QUANTITYOFAI = 15;
int INITIALQUANTITYOFAI = 15;

class BallWithAI extends Ball {
  ArrayList<BallWithAI> group;
  int nextTurn;
  boolean chasing = false;
  int team;
  BallWithAI(PVector p, ArrayList<BallWithAI> g, Camera c) {
    super(p, c);
    team = int(random(8));
    while (team == PLAYER_TEAM) {
      team = int(random(8));
    }
    img = loadImage("assets/img/ball" + team + ".png");
    sizeX = img.width;
    sizeY = img.height;
    ratio = defaultRatio;
    group = g;
    nextTurn = int(random(10, 120));
  }
  void fissure() {
    if (targetWeight > 1500) {
      PVector p = pos.copy();
      p = vel.copy().normalize();
      BallWithAI new_ball = new BallWithAI(pos.copy().add(p.copy().mult(sizeX * ratio / 2)), group, camera);
      new_ball.move(p.copy().normalize().mult(20));
      new_ball.targetWeight = targetWeight / 2;
      new_ball.increase();
      new_ball.team = team;
      new_ball.img = img;
      new_ball.directSwitch = directSwitch;
      for (int i = 0; i < 4; i++) {
        new_ball.directSwitch.setBoolean(ACTION.get(i), true == directSwitch.getBoolean(ACTION.get(i)));
      }
      group.add(new_ball);
      targetWeight = targetWeight / 2;
    }
  }
  void burst(float w) {
    for (PVector p: DIRECTS) {
      BallWithAI new_ball = new BallWithAI(pos.copy().add(p.copy().mult(sizeX * ratio / 2)), group, camera);
      new_ball.move(p.copy().mult(20));
      if (targetWeight > 5 * w) {
        new_ball.weight = w / 4;
        new_ball.targetWeight = w / 4;
      } else {
        new_ball.weight = targetWeight / 4;
        new_ball.targetWeight = targetWeight / 4;
      }
      new_ball.increase();
      new_ball.team = team;
      new_ball.img = img;
      group.add(new_ball);
    }
    if (targetWeight <= 5 * w) {
      group.remove(this);
    } else {
      targetWeight -= 4 * w;
    }
  }
  void getDirection() {
    nextTurn -= 1;
    if (nextTurn <= 0) {
      nextTurn = int(random(10, 120));
      for (int i = 0; i < 4; i++) {
        directSwitch.setBoolean(ACTION.get(i), int(random(2)) == 1);
      };
    }
  }
  void chase(PVector p) {
    chasing = true;
    nextTurn = 15;
    directSwitch.setBoolean("a", pos.x > p.x + sizeX * ratio / 20); 
    directSwitch.setBoolean("d", pos.x < p.x -  sizeX * ratio / 20);
    directSwitch.setBoolean("w", pos.y > p.y + sizeY * ratio / 20);
    directSwitch.setBoolean("s", pos.y < p.y - sizeY * ratio / 20);
  }
  void update() {
    if (!invalid) {
      increase();
      checkWalls();
      getDirection();
      super.update();
    }
  }
}
