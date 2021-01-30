boolean MUSICON = true;
boolean SOUNDON = true;

import ddf.minim.*;
Minim minim = new Minim(this);
class Media{
  AudioPlayer bgm;
  Media() {
    if (MUSICON) {
      bgm = minim.loadFile("assets/media/bgm.mp3");
      bgm.loop();
    }
  }
  /*void sound(String file) {
    if (SOUNDON) {
      AudioPlayer groove = minim.loadFile("assets/media/" + file);
      groove.play();
    }
  }*/
}
