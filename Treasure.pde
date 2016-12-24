class Treasure {
  PImage img;
  float x, y;
  float size;

  Treasure() {
    img = loadImage("img/treasure.png");
    this.size = random(0,1)<0.5 ? 1: 1.4; 
    x = floor(random(50, 590));
    y = floor(random(50, 430));    
  }

  void display() {
    image(img, x, y, img.width*size, img.height*size);
  }
}