class Bullet{
   int xPosition;
   int yPosition;
   
   int bulletSpeed;
   
   boolean bulletFired;
   
   Bullet(){
      xPosition = heroShip.getXPosition() + 28;  //added 28 to fit with spaceship model
      yPosition = heroShip.getYPosition();
      bulletSpeed = 15;
      bulletFired = true;
   } 
   
   void run(){
      drawBullet();  
      bulletTravel(); 
   }
   
   void drawBullet(){
      fill(213,147,49); //orange on RGB
      ellipse(xPosition, yPosition, 10, 40); 
   }
   
   int getXPosition(){
      return xPosition; 
   }
   
   int getYPosition(){
      return yPosition; 
   }
   
   boolean getBulletFired(){
        return bulletFired;
   }

   void bulletTravel(){
      if (bulletFired){
         yPosition = yPosition - bulletSpeed;
         if (yPosition < 0){
            bulletFired = false; //frees space in array when cycle is over
         }
      }
   }
}

