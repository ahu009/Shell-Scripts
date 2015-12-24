class enemyBullet{
    int xPosition;
    int yPosition;
    
    int bulletSpeed;
    
    boolean bulletFired;
  
    enemyBullet(){
        xPosition = enemyShooter.getXPosition() + 20;
        yPosition = enemyShooter.getYPosition() + 40;
        bulletSpeed = 8;
        bulletFired = true;
    }
    
    int getXPosition(){
         return xPosition; 
    }
    
    int getYPosition(){
         return yPosition; 
    }
    
    boolean isFired(){
       return bulletFired; 
    }
    
    void run(){
        drawBullet();
        bulletTravel();
    }
    
    void drawBullet(){
         fill(255,0,0);
         ellipse(xPosition, yPosition, 10, 40); 
    }
    
    void bulletTravel(){
         if (bulletFired){
              yPosition = yPosition + bulletSpeed;
              if (yPosition >= 800){
                   bulletFired = false; 
              }
         } 
    }
  
}
