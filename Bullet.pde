class Bullet {
  // https://gist.github.com/RadianSmile/7e612560ac37c9cd84d03fb0dfa32a19
  PImage img;
  boolean alive;
  float x;
  float y;
  int speed;

  Bullet() {
    img = loadImage("img/shoot.png");
    alive  = false;
    speed = 8;
  }

  void display() {   
    image(img, x, y);
  }

  void move() {
    x-=speed;

    if (x<0) {
      alive  = false;
    }
  }
}