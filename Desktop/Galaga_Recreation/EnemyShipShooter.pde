class EnemyShipShooter{
    int xPosition;
    int yPosition;
    
    int speed;
    
    int bulletFireFrequency;
    
    boolean moveRight;
    boolean moveLeft;
    
    public enemyBullet[] ammunition = new enemyBullet[30];
    
    EnemyShipShooter(){
       bulletFireFrequency = 100;
       speed = 5;
       xPosition = 400;
       yPosition = 10; 
       moveRight = true; // moves right first
       moveLeft = false;
    }
    
    void run(){
        drawShip();
        movement();
        fireBullet();
        continueBullet();
    }
    
    int generateRandomNumber(int low, int high){
       int value = int(random(low, high)); 
       //println(value);
       return value;
    }
    
    void fireBullet(){
         if (generateRandomNumber(0, bulletFireFrequency) == 1){
              int i = 0;
              while (ammunition[i] != null){
                 i++;
              } 
              ammunition[i] = new enemyBullet();
         }
    }
    
    void continueBullet(){
       for(int i = 0; i < 30; i++){
            if (ammunition[i] != null && ammunition[i].isFired()){
                 ammunition[i].run(); 
            }
            if (ammunition[i] != null && !ammunition[i].isFired()){
                 ammunition[i] = null;
            }
       } 
    }
    
    int getXPosition(){
       return xPosition; 
    }
    
    int getYPosition(){
       return yPosition; 
    }
    
    void drawShip(){
       image(enemyShipShooter, xPosition, yPosition); 
    }
    
    void movement(){
        if (moveRight && xPosition < 800){
           xPosition = xPosition + speed; 
        }
        else if (xPosition >= 800){
           moveLeft = true;
           moveRight = false;
        }
        
        if (moveLeft && xPosition > 0){
           xPosition = xPosition - speed; 
        }
        else if (xPosition <= 0){
           moveRight = true; 
           moveLeft = false;
        }
    }
  
  
  
}
