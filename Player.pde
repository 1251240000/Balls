int PLAYER_TEAM = int(random(8));
class Player extends Ball {
  ArrayList<Player> group;
  Player(PVector p, ArrayList<Player> g, Camera c) {
    super(p, c);
    img = loadImage("assets/img/ball" + PLAYER_TEAM + ".png");
    sizeX = img.width;
    sizeY = img.height;
    group = g;
    // targetWeight = 2500;
  }
  void action(char k, boolean t) {
    if (k == ' ' && !t) {
      fissure();
    } else {
      directSwitch.setBoolean("" + k, t);
    }
  }
void fissure() {
    if (targetWeight > 1500) {
      sound("fissure.wav");
      PVector p = pos.copy();
      p = vel.copy().normalize();
      Player new_ball = new Player(pos.copy().add(p.copy().mult(sizeX * ratio / 2)), player, camera);
      new_ball.move(p.copy().normalize().mult(20));
      new_ball.targetWeight = targetWeight / 2;
      new_ball.increase();
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
      sound("burst.mp3");
      Player new_ball = new Player(pos.copy().add(p.copy().mult(sizeX * ratio / 2)), player, camera);
      new_ball.move(p.copy().mult(10));
      if (targetWeight > 5 * w) {
        new_ball.weight = w / 4;
        new_ball.targetWeight = w / 4;
      } else {
        new_ball.weight = targetWeight / 4;
        new_ball.targetWeight = targetWeight / 4;
      }
      new_ball.increase();
      new_ball.img = img;
      for (int i = 0; i < 4; i++) {
        new_ball.directSwitch.setBoolean(ACTION.get(i), true == directSwitch.getBoolean(ACTION.get(i)));
      }
      group.add(new_ball);
    }
    if (targetWeight <= 5 * w) {
      group.remove(this);
    } else {
      targetWeight -= 4 * w;
    }
  }
}



  //int rebirthTiming = 0;
  /*void rebirth(PVector p) {
    pos = p;
    invalid = true;
    rebirthTiming = 30;
  }*/
  

    /*if (rebirthTiming > 0) {
      rebirthTiming -= 1;
      if (rebirthTiming == 0) {
        invalid = false;
      }
    }*/
