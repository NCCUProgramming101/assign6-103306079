int gameState;
final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_OVER = 2;

Background background;

HPBar hpbar;
int blood = (200/100)*20;

Treasure treasure;
Fighter fighter ; 

// 戰隊的最大值
final int enemyAmount = 8 ;

// 用來管理所有的 enemy 和 boss
Enemy[] enemyArray = new Enemy[enemyAmount] ;


// shared images ; 
PImage enemyImg ;

// enemy states
int enemyState ;
final int E_LINE = 0    ;
final int E_SLASH = 1   ; 
final int E_DIAMOND = 2 ;
final int E_BOSS = 3    ;


// FlameManager 
FlameManager flameManager ; 
final int yourFrameRate = 30 ;

//bullet
int bulletIndex = 0;
Bullet[] bulletArray = new Bullet[5];

int score;

void setup () {
  size(640, 480);

  background = new Background();
  hpbar = new HPBar(1, 0, "img/hp.png");
  treasure = new Treasure();

  enemyImg = loadImage("img/enemy.png");
  enemyState = E_LINE ;
  arrangeLineEnemy() ;

  fighter      = new Fighter ();
  flameManager = new FlameManager( yourFrameRate / 5 ) ; // this means update 5 images in 1 second.

  for (int i=0; i<5; i++) {
    bulletArray[i] = new Bullet();
  }

  initGame();
}

void draw () {
  switch(gameState) {
  case GAME_START:
    background.display();
    break;

  case GAME_RUN:
    background.display();
    treasure.display();

    if (blood<=0) {
      gameState = GAME_OVER;
    }
    if (blood>=(200/100)*100) {
      blood = (200/100)*100;
    }
    hpbar.display(blood);
    
    
    // +_+ : add some code in the fighter.display method ;
    fighter.display();  
    fighter.move();
    if (fighter.isHit(treasure.x, treasure.y, treasure.img.width, treasure.img.height )) {
      if (treasure.size==1) {
        blood +=(200/100)*10;
      } else {
        blood +=(200/100)*20;
      }
      treasure = new Treasure();
    }

    //===============
    //  ENEMY COLLISION TEST 
    //===============

    for (int i = 0; i < enemyAmount; i++) {
      enemyArray[i].move() ;
      // +_+ : collision detection : enemy & bullets  
      // ....
      for (int j=0; j<5; j++) {
        if (enemyArray[i].isHit(bulletArray[j].x, bulletArray[j].y, bulletArray[j].img.width, bulletArray[j].img.height ) && bulletArray[j].alive) {
          scoreChange(20);
          flameManager.add(enemyArray[i].x, enemyArray[i].y );
          enemyArray[i].life--;
          if (enemyArray[i].life == 0) {
            enemyArray[i].y =2000 ;
          }

          bulletArray[j].alive = false;
          bulletArray[j].y=-1000;
        }
      }

      // +_+ : collision detection : enemy & fighter
      if (enemyArray[i].isHit(fighter.x, fighter.y, fighter.img.width, fighter.img.height )) {
        if (enemyState == 3) {
          blood -= (200/100)*50;
        } else {
          blood -= (200/100)*20;
        }

        //  +_+ : explosion
        flameManager.add(enemyArray[i].x, enemyArray[i].y );
        //  +_+ : then move out the enemy 
        enemyArray[i].y =  2000;
      }
      // +_+ : show the enemy 
      enemyArray[i].display();
    }

    if (enemyFinished()) {
      enemyState = (enemyState +1)%4;
      switch(enemyState) {
      case E_LINE:
        arrangeLineEnemy ();
        break;
      case E_SLASH:
        arrangeSlashEnemy ();
        break;
      case E_DIAMOND:
        arrangeDiamondEnemy ();
        break;
      case E_BOSS:
        arrangeBossEnemy () ;
        break;
      }
    }

    // +_+ : this will draw all flames.
    flameManager.display();

    for (int i=0; i<5; i++) {
      if (bulletArray[i].alive==true) {
        bulletArray[i].display();
        bulletArray[i].move();
      }
    }

    textSize(30);
    text("Score: "+score, 10, height-20);
    break;
  case GAME_OVER :
    background.display();
    break;
  }
}



void keyPressed() {
  fighter.keyPressed(keyCode) ;

  // +_+ : don't forget to shoot bullet.
}
void keyReleased() {
  fighter.keyReleased(keyCode) ;
  if ( keyCode == ' ') {
    if (gameState == GAME_RUN) {
      if (bulletArray[bulletIndex].alive == false) {
        bulletArray[bulletIndex].alive = true;
        bulletArray[bulletIndex].x = fighter.x-30;
        bulletArray[bulletIndex].y = fighter.y+15;
        bulletIndex ++;
      }   
      if (bulletIndex> 4) {
        bulletIndex=0;
      }
    }
  }
}


//===============
//  FUNCTIONS :
//===============
//  use them directly.

boolean enemyFinished() { 

  // if all enemy is out of screen    -> return true
  // if any enemy is inside of screen -> return false 

  for (int i = 0; i < 8; i++) {
    if (enemyArray[i].x < width) {
      return false ;
    }
  }
  return true ;
}


void arrangeLineEnemy () {
  float  y = random (0, 480 - 5 * enemyImg.height);
  for (int i = 0; i < 8; i++) {
    if (i < 5 ) {
      enemyArray[i] = new Enemy( -50 - i * (enemyImg.width + 10), y ) ;
    } else {
      enemyArray[i] = new Enemy( width, y ) ;
    }
  }
}
void arrangeSlashEnemy () {
  float y = random (0, 480 - 5 * enemyImg.width );
  for (int i = 0; i < 8; i++) {
    if (i < 5 ) {
      enemyArray[i] = new Enemy( -50 - i * 51, y + i * enemyImg.height ) ;
    } else {
      enemyArray[i] = new Enemy( width, y ) ;
    }
  }
}
void arrangeDiamondEnemy () {
  float cx = -250 ;
  float cy = random(0 + 2 * enemyImg.height, 480 - 3 * enemyImg.height ) ;  
  int numPerSide = 3 ;

  int index = 0;
  for (int i = 0; i < numPerSide - 1; i++) {
    int rx = numPerSide - 1 - i ;
    int ry = i ;

    enemyArray[index++] = new Enemy( cx + rx * enemyImg.width, cy + ry * enemyImg.height );
    enemyArray[index++] = new Enemy( cx - rx * enemyImg.width, cy - ry * enemyImg.height );
    enemyArray[index++] = new Enemy( cx + ry * enemyImg.width, cy - rx * enemyImg.height );
    enemyArray[index++] = new Enemy( cx - ry * enemyImg.width, cy + rx * enemyImg.height );
  }
}

void arrangeBossEnemy () {
  float y = random( 0, height - 5 * (enemyImg.height + 10) ) ; 
  for (int i = 0; i < 8; i++) {
    if (i < 5 ) {
      enemyArray[i] = new Boss( - width, y + i * (enemyImg.height + 10 ) ) ;
    } else {
      enemyArray[i] = new Boss ( width, y ) ;
    }
  }
}

void scoreChange(int value) {
  score += value;
}

void initGame() {
  blood  = (200/100)*20;

  enemyState = E_LINE ;
  arrangeLineEnemy() ;

  treasure = new Treasure();

  fighter      = new Fighter ();

  flameManager = new FlameManager( yourFrameRate / 5 ) ; // this means update 5 images in 1 second.

  score = 0;

  gameState = GAME_START;
}