class Enemy {

  float x, y ;
  PImage img ; 
  float speed; 
  int life;

  // int life ; // if you want to make Boss class , use it.

  Enemy (float x, float y) {

    img = loadImage("img/enemy.png");
    this.x = x;
    this.y = y;
    speed = 5 ;
    life = 1;
  }

  void display () {
    image(img, x, y);
  }
  void move () {
    x+=speed;
  }

  boolean isHit (float bx, float by, float bw, float bh ) {

    boolean collisionX = (this.x + this.img.width >= bx) && (bx + bw >= this.x);
    boolean collisionY = (this.y + this.img.height >= by) && (by + bh >= this.y);

    return collisionX && collisionY;
  }
}