class HPBar {
  int x, y ;
  PImage img ;

  HPBar (int x, int y, String imgPath) {
    this.x = x ;
    this.y = y ;
    img = loadImage(imgPath);
  }

  void display(int hp) {
    noStroke();
    fill(255, 0, 0);
    rect(10, 5, hp, 20);

    image(img, x, y);
  }
  
  
}