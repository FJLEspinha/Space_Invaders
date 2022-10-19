enum Direction {
  UP, DOWN
};
class Bullet extends Movil {
  final float AMOUT_MOVEMENT = 4;


  Bullet(float x, float y, Direction dir) {
    this.x=x;
    this.y=y;

    this.velY = dir==Direction.UP? -AMOUT_MOVEMENT: +AMOUT_MOVEMENT;
    w=3;
    h=5;
  }
  void draw() {
    fill(255, 0, 0);
    //noStroke();
    rect(x, y, w, h);
  }

  boolean checkWallCollision() {
    if (y<0) return true;
    if (y-h> height) return true;
    return false;
  }
}
