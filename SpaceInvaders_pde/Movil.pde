class Movil {
  float AMOUT_MOVEMENT = 4;
  float x;
  float y;
  float velX;
  float velY;
  float w;
  float h;


  void updatePosition() {
    x+=velX;
    y+=velY;
  }

  void moveRight() {
    velX=+AMOUT_MOVEMENT;
  }
  void moveLeft() {
    velX=-AMOUT_MOVEMENT;
  }
  void moveDown() {
    y+=30;
  }
}
