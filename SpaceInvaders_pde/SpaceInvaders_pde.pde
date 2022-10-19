import processing.sound.*;

import java.util.stream.Collectors;
Player player;
ArrayList<Alien> aliens;
SoundFile sound ;
SoundFile soundExplosion;
void setup() {
  size(400, 300);
  sound = new SoundFile(this, "../assets/laser.mp3");
   soundExplosion = new SoundFile(this, "../assets/explosion.mp3");
  player = new Player();
  aliens = new ArrayList<Alien>();


  for (int i=0; i<5; i++) {
    aliens.add(new AlienA(i*60+10, 10));
  }
  for (int i=0; i<5; i++) {
    aliens.add(new AlienB(i*60+10, 40));
  }
  for (int i=0; i<5; i++) {
    aliens.add(new AlienC(i*60+10, 80));
  }
}

void draw() {
  //borrar pantalla
  background(0, 0, 0);
  player.checkWallCollision();
  player.updatePosition();
  player.draw();

  //disparo del player
  for (Bullet bullet : player.bullets) {
    bullet.updatePosition();
    bullet.draw();
  }

  //Gestion de disparos para eliminarlos
   for(Bullet bullet : player.bullets){
   if(bullet.checkWallCollision()){
   player.bullets.remove(bullet);
   break;
   }
   }
  // funciones de orden superior y lamdas Hace lo mismo que lo de arriba
  player.bullets=(ArrayList) player.bullets.stream()
    .filter(bullet->!bullet.checkWallCollision())
    .collect(Collectors.toList());

  //Eliminar el alien cuando el 1er disparo lo toque y haga un sonido
  if(player.bullets.size()>0){
    Bullet oldShot = player.bullets.get(0);
    for(Alien alien: aliens){
     if( collideRectRect(oldShot.x,oldShot.y,oldShot.w, oldShot.h,
                            alien.x,alien.y,alien.w,alien.h)){
           aliens.remove(alien);
           player.bullets.remove(player.bullets.get(0));
           soundExplosion.play();
           break;
                            }                  
    }
}
  //Gestionar la naves
  for (Alien alien : aliens) {
    alien.updatePosition();
    alien.draw();
  }
  //movimiento de las naves
  boolean colisionRight =false;
  boolean colisionLeft=false;
  for(Alien alien :aliens){
   if(alien.x + alien.velX + alien.w > width){//pared derecha
     colisionRight=true;
     break;
   }
   if(alien.x + alien.velX < 0){//pared izquierda
     colisionLeft=true;
     break;
   }
  }
  if(colisionRight == true){
    for(Alien alien : aliens){
      alien.moveLeft();
      alien.moveDown();
    }
  }
  
  if(colisionLeft == true){
    for(Alien alien : aliens){
      alien.moveRight();
      alien.moveDown();
    }
  }
//dispara las naves de forma aleatoria
for(Alien alien : aliens){
 
 if((int) random(600)==1)  alien.shot(); 
 
  for(Bullet bullet :alien.bullets){
   bullet.updatePosition();
   bullet.draw();
  }
}

//control de que nos de un disparo y termina el juego
for(Alien alien : aliens){
 for(Bullet bullet: alien.bullets){
  if(collideRectRect(bullet.x,bullet.y, bullet.w, bullet.h,
                    player.x,player.y, player.w, player.h)){
            textSize(56);
            textAlign(CENTER);
            fill(255,0,0);
            String msg = "GAME OVER";
          
            text(msg, width/2, height/2);
            frameRate(0);
        }
   
   }
  
}


}
boolean collideRectRect(float xa,float ya,float wa,
float ha, float xb,float yb,float wb,float hb){
 return xa+wa>=xb && xa<= xb+wb && ya+ha >= yb && ya<= yb+hb;
 }
void mouseMoved() {
  player.x=mouseX-player.w/2;
  /*float dist = mouseX-player.x;
   if(dist>0) player.moveRight();
   else player.moveLeft();*/
}
void mousePressed() {
  player.shot();
  sound.play();
}
