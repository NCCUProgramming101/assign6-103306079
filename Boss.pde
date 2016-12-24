class Boss extends Enemy {
  Boss (float x, float y) {
    super(x, y) ;
    
    img = loadImage("img/boss.png");
    speed = 3;
    life = 5;
  }
}