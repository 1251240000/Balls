class Rank{
  PImage img;
  PVector pos;
  ArrayList<Player> ps;
  ArrayList<BallWithAI> as;
  FloatDict scoreRank = new FloatDict();
  StringDict playerName = new StringDict() {{
    set("0", "Uranus");
    set("1", "Jupiter");
    set("2", "Mercury");
    set("3", "Neptune");
    set("4", "Mars");
    set("5", "Pluto");
    set("6", "Venus");
    set("7", "Saturn");
  }};
  Rank(ArrayList<Player> p, ArrayList<BallWithAI> a) {
    img = loadImage("assets/img/rankboard.png");
    pos = new PVector(625, 10);
    ps = p;
    as = a;
  }
  void update() {
    image(img, pos.x, pos.y);
    textSize(18);
    fill(224);
    text("Rank", 685, 30);
    
    for (int i = 0; i < 8; i++) {
      scoreRank.set(playerName.get("" + i), 0);
    }
    for (Player p: ps) {
      scoreRank.add(playerName.get("" + PLAYER_TEAM), p.targetWeight);
    }
    for (BallWithAI a: as) {
      scoreRank.add(playerName.get("" + a.team), a.targetWeight);
    }
    scoreRank.sortValuesReverse();
    textSize(14);
    for (int i = 0; i < 8; i++) {
      String name = scoreRank.keyArray()[i];
      if (name == playerName.get("" + PLAYER_TEAM)) {
        fill(224, 128, 128);
      } else {
        fill(224);
      }
      text(name, 640, 54 + i * 23);
      text(int(scoreRank.get(name)), 720, 54 + i * 23);
    }
  }
}
