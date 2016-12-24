// Put all the other classes here

class Background {
  PImage start1, start2, end1, end2, bg1, bg2, bg3, bg4;
  int x, speed;

  Background() {
    start1 = loadImage("img/start1.png");
    start2 = loadImage("img/start2.png");
    end1 = loadImage("img/end1.png");
    end2 = loadImage("img/end2.png");

    bg1 = loadImage("img/bg1.png");
    bg2 = loadImage("img/bg2.png");
    bg3 = loadImage("img/bg1.png");
    bg4 = loadImage("img/bg2.png");

    speed = 4;
  }

  void display() {
    switch(gameState) {
    case GAME_START:
      if (mouseX>=150 && mouseX<=450 && mouseY>=350 && mouseY<=430) {
        image(start1, 0, 0);
        if (mousePressed) {
          gameState = GAME_RUN;
        }
      }
      break;
    case GAME_RUN:
      if (640+x%1280>640) {
        image(bg1, -1280, 0, 640, 480);
      }
      if (0+x%1280>640) {
        image(bg2, -1280, 0, 640, 480);
      }
      if (1280+x%1280>640) {
        image(bg3, -1280, 0, 640, 480);
      }
      if (-1280+x%1280>640) {
        image(bg4, -1280, 0, 640, 480);
      }
      image(bg1, 640+x%1280, 0, 640, 480);
      image(bg2, 0+x%1280, 0, 640, 480);
      image(bg3, -640+x%1280, 0, 640, 480);
      image(bg4, -1280+x%1280, 0, 640, 480);
      x+=speed;
      break;
    case GAME_OVER:
      image(end2, 0, 0);     
      if ( mouseX>=180 && mouseX<=450 && mouseY>=280 && mouseY<=360) {
        image(end1, 0, 0);
        if (mousePressed) {
          gameState = GAME_START;
          initGame();
        }
      }
      break;
    }
  }
}
class bar {
  // ...
}