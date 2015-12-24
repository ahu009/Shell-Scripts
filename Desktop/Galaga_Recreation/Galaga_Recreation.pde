PImage myShip;
PImage myShipExplosion;
PImage enemyShip;
PImage enemyShipExplosion;
PImage enemyShipShooter;

SpaceShip heroShip = new SpaceShip();
Map myMap = new Map();
EnemyShipSpawner mySpawner = new EnemyShipSpawner();
EnemyShipShooter enemyShooter = new EnemyShipShooter();


void setup(){
  myMap.drawMap();
  myShip = loadImage("spaceShip.jpg");
  myShipExplosion = loadImage("spaceShipExplosion.jpg");
  enemyShip = loadImage("enemyShip.jpg");
  enemyShipExplosion = loadImage("enemyShipExplosion.jpg");
  enemyShipShooter = loadImage("galaga_enemies.jpg");
}

void draw(){
  myMap.drawMap();
  myMap.displayScore();
  if (!heroShip.isGameOver()){ //will only run process when heroship is alive
    heroShip.run();
    mySpawner.run();
    enemyShooter.run();
  }
  else{
     heroShip.drawShip(); //death model
  }
}

  
