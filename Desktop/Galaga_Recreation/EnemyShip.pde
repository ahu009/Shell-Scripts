class EnemyShip{
   int xPosition;
   int yPosition;
   boolean isDead;
   int travelSpeed; 
   int deathTime;
  
   EnemyShip(int RandX){
      xPosition = RandX;
      yPosition = 0;
      isDead = false;
      travelSpeed = 5;
      deathTime = 50;
   }
   
   void run(){
      drawEnemyShip();
      enemyShipTravel(); 
      checkIfDead();
   }
   
   int getXPosition(){
      return xPosition; 
   }
   
   int getYPosition(){
      return yPosition; 
   }
   
   void drawEnemyShip(){
     if(!isDead){
        image(enemyShip, xPosition, yPosition);  //alive model
     }
     else{
        image(enemyShipExplosion, xPosition, yPosition); //death model
         
     }
   }
   
   void enemyShipTravel(){
     if (!isDead){
        yPosition = yPosition + travelSpeed; 
        if (yPosition > 800){
           isDead = true; //frees space in array when enemy moves off map
        }
     }
   }
   
   boolean getIsDead(){
     if (isDead && deathTimer() == 0){ //have death model stay on map for one second after death
      return true;
     }
     else{
      return false;
    } 
   }
   
   int deathTimer(){
     if (deathTime != 0){ //timer for death model
        deathTime--;
     }
        return deathTime;
   }
   
   boolean hitByBulletX(int i){
       if (abs(xPosition - heroShip.ammunition[i].getXPosition()) < 50){
            return true; 
       }
       else{
          return false; 
       }
   }
   
   boolean hitByBulletY(int i){
       if (abs(yPosition - heroShip.ammunition[i].getYPosition()) < 30){
            return true; 
       }
       else{
          return false; 
       }
   }
   
   void checkIfDead(){
        int i = 0;
        while (heroShip.ammunition[i] != null){
           if (hitByBulletX(i) && hitByBulletY(i)){ 
              if (!isDead){
                heroShip.ammunition[i] = null;
                myMap.incrementScore();
                if (myMap.getScore() % 10 == 0 && myMap.getScore() != 0){ 
                    mySpawner.increaseDifficulty(); //increase difficulty every 10 points
                 }
              }
              isDead = true;
           }
           i++;
        }
    }
}




class EnemyShipSpawner{
    public EnemyShip[] spawner = new EnemyShip[50];
    int difficulty;
    
    EnemyShipSpawner(){
       for(int i = 0; i < 50; i++){
          spawner[i] = null;
       } 
       difficulty = 100;
    }
    
    void run(){
       spawnCoolDown(); 
       continueEnemyCycle();
    }
    
    int generateRandomNumber(int low, int high){
       int value = int(random(low, high)); 
       return value;
    }
    
    void increaseDifficulty(){
      if(difficulty > 10){   //difficulty cap (50)
         difficulty = difficulty - 10; 
      }
    }
    
    void spawnShip(){
        int i = 0;
        while(spawner[i] != null){
            i++;
        }
        spawner[i] = new EnemyShip(generateRandomNumber(0,790));
    }
    
    void spawnCoolDown(){
       if(generateRandomNumber(0, difficulty) == 1){
            spawnShip();
       } 
    }
     
    void continueEnemyCycle(){ 
       for(int i = 0; i < 50; i++){
          if (spawner[i] != null && !spawner[i].getIsDead()){
             spawner[i].run(); //run if alive
          }
          else if(spawner[i] != null && spawner[i].getIsDead()){
             spawner[i] = null; //remove from array if spaceship is dead
          }
       } 
    }
}
