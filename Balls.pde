Map map;
Camera camera;
Media media;
Rank rank;
ArrayList<Player> player = new ArrayList<Player>();
ArrayList<Candy> candies = new ArrayList<Candy>();
ArrayList<Cactus> cactuses = new ArrayList<Cactus>();
ArrayList<BallWithAI> ai = new ArrayList<BallWithAI>();
ArrayList<Star> star = new ArrayList<Star>();

// TODO:
// 2. mult players wall detect

void setup() {
  size(800, 480);
  smooth(2);
  init();
}
void draw() {
  frameRate(144);
  // println(frameRate);
  background(0);
  update();
}

void keyPressed() {
  char k = key;
  if (ACTION.hasValue("" + k)) {
    for (int i = player.size() - 1; i >= 0; i--) {
      player.get(i).action(k, true);
    }
  }
}

void keyReleased() {
  char k = key;
  if (ACTION.hasValue("" + k)) {
    for (int i = player.size() - 1; i >= 0; i--) {
      player.get(i).action(k, false);
    }
  }
}

void init() {
  camera = new Camera();
  map = new Map(new PVector(0, 0), camera);
  player.add(new Player(getRandomPVector(), player, camera));
  
  for (int i = 0; i < INITIALQUANTITYOFCANDY; i++) {
    candies.add(new Candy(getRandomPVector(), camera));
  }
  for (int i = 0; i < INITIALQUANTITYOFCACTUS; i++) {
    cactuses.add(new Cactus(getRandomPVector(), camera));
  }
  for (int i = 0; i < INITIALQUANTITYOFSTAR; i++) {
    star.add(new Star(getRandomPVector(), camera));
  }
  for (int i = 0; i < INITIALQUANTITYOFAI; i++) {
    ai.add(new BallWithAI(getRandomPVector(), ai, camera));
  }

  camera.bind(player);
  media = new Media();
  rank = new Rank(player, ai);
}

void update() {
  map.update();
  for (int i = candies.size() - 1; i < QUANTITYOFCANDY; i++) {
    candies.add(new Candy(getRandomPVector(), camera));
  }
  for (int i = cactuses.size() - 1; i < QUANTITYOFCACTUS; i++) {
    cactuses.add(new Cactus(getRandomPVector(), camera));
  }
  for (int i = ai.size() - 1; i < QUANTITYOFAI; i++) {
    ai.add(new BallWithAI(getRandomPVector(), ai, camera));
  }
  for (int i = candies.size() - 1; i >= 0; i--) {
    candies.get(i).update();
  }
  for (int i = cactuses.size() - 1; i >= 0; i--) {
    cactuses.get(i).update();
  }
  for (int i = star.size() - 1; i >= 0; i--) {
    star.get(i).update();
  }
  for (int i = ai.size() - 1; i >= 0; i--) {
    ai.get(i).update();
  }
  for (int i = player.size() - 1; i >= 0; i--) {
    player.get(i).update();
  }
  camera.update();
  rank.update();
  //swallowDetect();
  //attract();
  thread("swallowDetect");
  thread("attract");
  thread("randomEvent");
}

void swallowDetect() {
  try{
    // candies swallow detect
    for (int i = candies.size() - 1; i >= 0; i--) {
      boolean destoryed = false;
      for (int j = player.size() - 1; j >= 0; j--) {
        if (player.get(j).swallow(candies.get(i))) {
          candies.remove(i);
          destoryed = true;
          break;
        }
      }
      if (destoryed) {continue; }
      for (int j = ai.size() - 1; j >= 0; j--) {
        if (ai.get(j).swallow(candies.get(i))) {
          candies.remove(i);
          break;
        }
      }
    }
    // cactuses swallow detect
    for (int i = cactuses.size() - 1; i >= 0; i--) {
      for (int j = player.size() - 1; j >= 0; j--) {
        if (player.get(j).swallow(cactuses.get(i))) {
          float weight = cactuses.get(i).weight;
          cactuses.remove(i);
          player.get(j).burst(weight);
          break;
        }
      }
      for (int j = ai.size() - 1; j >= 0; j--) {
        if (ai.get(j).swallow(cactuses.get(i))) {
          float weight = cactuses.get(i).weight;
          cactuses.remove(i);
          ai.get(j).burst(weight);
          break;
        }
      }
    }
    // stars swallow detect
    for (int i = star.size() - 1; i >= 0; i--) {
      for (int j = player.size() - 1; j >= 0; j--) {
        if (player.get(j).swallow(star.get(i))) {
          player.get(j).sound("event.mp3");
          star.get(i).event();
          star.remove(i);
          break;
        }
      }
      for (int j = ai.size() - 1; j >= 0; j--) {
        if (ai.get(j).swallow(star.get(i))) {
          ai.get(j).sound("event.mp3");
          star.get(i).event();
          star.remove(i);
          break;
        }
      }
    }
    // enemies swallow detect
    for (int i = player.size() - 1; i >= 0; i--) {
      for (int j = ai.size() - 1; j >= 0; j--) {
        if (player.get(i).swallow(ai.get(j))) {
          ai.remove(j);
          continue;
        }
        if (ai.get(j).swallow(player.get(i))) {
          player.remove(i);
          break;
        }
      }
    }
    for (int i = ai.size() - 1; i >= 0; i--) {
      for (int j = ai.size() - 1; j >= 0; j--) {
        if (i != j) {
          if (ai.get(i).swallow(ai.get(j))) {
            ai.remove(j);
            if (j < i) i--;
            continue;
          }
          if (ai.get(j).swallow(ai.get(i))) {
            ai.remove(i);
            if (i < j) j--;
            break;
          }
        }
      }
    }
    if (player.size() <= 0) {
      player.add(new Player(getRandomPVector(), player, camera));
    }
    // player swallow detect
    for (int i = player.size() - 1; i >= 0; i--) {
      for (int j = player.size() - 1; j >= 0; j--) {
        if (i != j) {
          if (player.get(i).swallow(player.get(j))) {
            player.remove(j);
            if (j < i) i--;
            continue;
          }
          if (player.get(j).swallow(player.get(i))) {
            player.remove(i);
            if (i < j) j--;
            break;
          }
        }
      }
    }
  } catch(Exception e) {
  }
}
void attract() {
  if (player.size() > 1) {
      PVector direct = new PVector(0, 0);
      for (Player p: player) {
        direct.add(p.pos.copy());
      }
      direct = direct.mult(1.0/ player.size());
      for (Player p: player) {
        PVector v = direct.copy().sub(p.pos);
        p.move(v.mult(1.0 / 10000 + 1 / p.pos.dist(v)));
      }
  }
  for (BallWithAI a: ai) {
    for (Player p: player) {
      float d = a.pos.dist(p.pos);
      if (d < a.sizeX * a.ratio * 3 && a.weight > p.weight) {
        a.chase(p.pos);
        continue;
      } else if (a.chasing){
        // a.chase(a.pos.copy().sub(p.pos.copy().sub(a.pos.copy()).mult(-1)));
        // a.getDirection();
      }
    }
  }
  for (int i = ai.size() - 1; i >= 0; i--) {
    for (int j = ai.size() - 1; j >= 0; j--) {
      if (i != j && ai.get(i).team == ai.get(j).team) {
        float d = ai.get(i).pos.dist(ai.get(j).pos);
        if (d < ai.get(i).sizeX * ai.get(i).ratio * 10 && ai.get(i).weight < ai.get(j).weight) {
          ai.get(i).chase(ai.get(j).pos);
          continue;
        } else if (ai.get(i).chasing){
          // ai.get(i).getDirection();
        }
      }
    }
  }
}

void randomEvent() {
  if (EVENT_DURATION > 1) {
    EVENT_DURATION -= 1;
  } else if (EVENT_DURATION == 1) {
    EVENT_SLOWDOWN = false;
    EVENT_SPEEDUP = false;
    EVENT_ALTITUDEUP = false;
    EVENT_ALTITUDEDOWN = false;
    BASE_SPEED = 1;
    BASE_ALTITUDE = 1;
    EVENT_DURATION = 0;
  }
}

PVector getRandomPVector() {
  return new PVector(random(startPos[0], endPos[0]), random(startPos[1], endPos[1]));
}
