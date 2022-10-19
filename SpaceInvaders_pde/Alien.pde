class AlienA extends Alien{
  AlienA(float x, float y){
   super(x,y); 
    img1 = loadImage("../assets/alienA1.png");
    loadImage("../assets/alienA2.png");
  }
}
class AlienB extends Alien{
  AlienB(float x, float y){
   super(x,y); 
    img1 = loadImage("../assets/alienB1.png");
    loadImage("../assets/alienB2.png");
  }
}
class AlienC extends Alien{
  AlienC(float x, float y){
   super(x,y); 
    img1 = loadImage("../assets/alienC1.png");
    loadImage("../assets/alienC2.png");
  }
}
abstract class Alien extends Movil {
  // TODO soluciona el problema de rendimiento
  PImage img1 = loadImage("../assets/alienA1.png");
  PImage img2  = loadImage("../assets/alienA2.png");
  ArrayList<Bullet> bullets = new ArrayList<Bullet>();


  boolean alive = true;


  Alien(float x, float y) {
    AMOUT_MOVEMENT = 1;
    w=24;
    h=17;
    this.x=x;
    this.y=y;
    moveRight();
  }

  void draw() {
    //fill(255, 255, 255);
    if (Math.round(frameCount/15%2)==0) {
      image(img1, x, y);
    } else {
      image(img2, x, y);
    }
    //noStroke();
    //rect(x, y, w, h);
  }

  void checkWallCollision() {
    if (x<0) x=0;
    if (x+w>width) x=width-w;
  }
   void shot() {
    
      Bullet newBullet = new Bullet(x+w/2, y, Direction.DOWN);
      bullets.add(newBullet);
     
    
  }
}
