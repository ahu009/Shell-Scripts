class Map{
  int mapSizeX;
  int mapSizeY;
  int mapColorRed;
  int mapColorBlue;
  int mapColorGreen;
  int mapScore;
 
  Map(){
     mapSizeX = 800; 
     mapSizeY = 800;
     mapColorRed = 0;
     mapColorBlue = 0;
     mapColorGreen = 0;
     mapScore = 0;
  }
  
  void displayScore(){
     textSize(32);
     fill(255,255,255);
     text("Score:", 10, 790);
     text(mapScore, 120, 790);
  }
  
  int getScore(){
     return mapScore; 
  }
  
  void incrementScore(){
     mapScore++; 
  }
  
  void drawMap(){
     size(mapSizeX, mapSizeY);
     background(mapColorRed, mapColorBlue, mapColorGreen); 
     
     if (heroShip.isGameOver()){
        fill(255,255,255);
        textSize(60);
        text("Game", 300, 400);
        text("Over", 315, 500);
     }
  }
  
  void colorMap(int red, int green, int blue){
     background(red, green, blue); 
  }
}
