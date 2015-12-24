class SpaceShip{
  boolean isDead;
  
  boolean moveRight;
  boolean moveLeft;
  
  int xPosition;
  int yPosition;
  
  public Bullet[] ammunition = new Bullet[100];
  
  SpaceShip(){
      isDead = false;
      moveLeft = false;
      moveRight = false;
      xPosition = 400;
      yPosition = 700;
  }
  
  void run(){
     drawShip();
     move();
     continueBullets();
     checkIfDead();
  }
  
  void drawShip(){
     if (!isDead){
       image(myShip, xPosition, yPosition); 
     }
     else{
       image(myShipExplosion, xPosition, yPosition);
     }
  }
  
  int getXPosition(){
     return xPosition; 
  }
  
  int getYPosition(){
     return yPosition; 
  }
  
  void moveSetter(String rightOrLeft, String trueOrFalse){
     if (rightOrLeft == "right"){
        if (trueOrFalse == "true"){
          moveRight = true;
        }
        else if (trueOrFalse == "false"){
           moveRight = false;
        } 
     }
     else if (rightOrLeft == "left"){
        if (trueOrFalse == "true"){
           moveLeft = true; 
        }
        else if (trueOrFalse == "false"){
           moveLeft = false;
        }
     } 
  }
  
  void move(){
     if (moveRight == true){
        xPosition = xPosition + 10;
        if (xPosition > 780){
           xPosition = 780; 
        }
     } 
     else if (moveLeft == true){
        xPosition = xPosition - 10; 
        if (xPosition < 20){
           xPosition = 20; 
        }
     }
  }
  
  void fireBullet(){
       int i = 0;
       while(ammunition[i] != null){
           i = i + 1;
       }
       ammunition[i] = new Bullet();
  }
   
   boolean shouldContinueBullets(int bulletIndex){
      if (ammunition[bulletIndex] != null && ammunition[bulletIndex].getBulletFired()){
         return true; 
      }
      else{
         return false; 
      }
   }
   
   void continueBullets(){
      for(int i = 0; i < 100; i++){
         if (shouldContinueBullets(i)){
             ammunition[i].run();
         }
         freeAmmunitionSpace(i);
      }  
   }
  
  boolean shouldFreeAmmunitionSpace(int bulletIndex){
     if (ammunition[bulletIndex] != null && !ammunition[bulletIndex].getBulletFired()){
        return true;
     }
     else{
        return false;
     } 
  }
  
  void freeAmmunitionSpace(int bulletIndex){
       if (shouldFreeAmmunitionSpace(bulletIndex)){
           ammunition[bulletIndex] = null;
       }
  }
  
  boolean enemyShipCollision(){
    for(int i = 0; i < 50; i++){
       if (mySpawner.spawner[i] != null && abs(xPosition - mySpawner.spawner[i].getXPosition()) < 50){
         if (abs(yPosition - mySpawner.spawner[i].getYPosition()) < 50){
            return true;
         }
       }
       
    }
    return false;
  }
  
  boolean enemyBulletCollision(){
     for(int i = 0; i < 30; i++){
          if (enemyShooter.ammunition[i] != null && abs(xPosition - enemyShooter.ammunition[i].getXPosition()) < 40){
               if (abs(yPosition - enemyShooter.ammunition[i].getYPosition()) < 10){
                    return true;
               } 
          }
     } 
     return false;
  }
  
  void checkIfDead(){
      if (enemyShipCollision() || enemyBulletCollision()){
         isDead = true; 
      }
  }
  
  boolean isGameOver(){
    if (isDead){
        return true; 
    }
    else{
        return false;
    }
  }
  
}

 void keyPressed(){
     if (key == 'd'){
        heroShip.moveSetter("right", "true");
     }
     else if (key == 'a'){
        heroShip.moveSetter("left", "true");
     }
     if (key == 'k'){
        heroShip.fireBullet();
     }
  }
  
  void keyReleased(){
     if (key == 'd'){
        heroShip.moveSetter("right", "false");
     } 
     else if (key == 'a'){
        heroShip.moveSetter("left", "false");
     }
  } 
