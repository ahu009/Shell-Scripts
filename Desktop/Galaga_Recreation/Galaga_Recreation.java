package Movement;
import processing.core.PApplet;
import processing.core.PFont;

import java.util.Random;

public class ballMove extends PApplet{
	public int score = -1;
	public int blockSpeed = 1;
	public int tempHolderx;
	public int tempHoldery;
	public int speed = 5;
	public int x = 350;
	public int y = 400;
	public boolean endGame = false;
	public boolean moveUp = false;
	public boolean moveDown = false;
	public boolean moveRight = false;
	public boolean moveLeft = false;
	public boolean targetHit = false;
	public boolean isHit = true;
	public boolean scope = true;
	public int x_power_position;
	public int y_power_position;
	
	public boolean shouldDisplay = false;
	public boolean isFirst = true;
	public int numPowers = 0;
	String gun = "";
	String shield = "";
	String slow = "";
	String multiplier = "";
	public int temppowerx;
	public int temppowery;
	public boolean spawnPowerUp = true;
	public boolean powerUpHit = true;
	
	public boolean popShield = false;
	public boolean shieldBlink = false;
	public boolean shieldStatus = false;
	public boolean shieldDropStart = false;
	public int xShield;
	public int yShield;
	public int shieldImmune = 50;
	
	public boolean gunStatus = false;
	public boolean toFire = false;
	int[] bulletY = new int[200];
	int[] bulletX = new int[200];
	boolean[] bulletTrue = new boolean[200];
	public int bulletSpeed = 5;
	public int bulletChooser = 0;
	public int wallTimer = 1000;
	int differenceX;
	int differenceY;
	
	public boolean multiplyStatus = false;
	public int multiplyTime = 1000;
	
	public boolean slowStatus = false;
	public int speedHolder;
	public int slowTime = 800;
	public boolean onlyOnce = true;
	
	int randx;
	int randy;
	int blocksTimer = 100;
	int[] xAxis = new int[690];
	int[] yAxis = new int[690];
	int[] xAxis2 = new int[790];
	int[] yAxis2 = new int[790];
	boolean[] toIncrement = new boolean[690];
	boolean[] toIncrement2 = new boolean[790];
	int blockGenerateSpeed = 100;
	
	public void setup(){
		size(700,800);
		for(int i = 0; i < 50; i++){
			xAxis[i] = 0;
			yAxis[i] = 0;
			xAxis2[i] = 690;
			yAxis2[i] = 0;
			toIncrement[i] = false;
			toIncrement2[i] = false;
		}
		for(int i = 0; i < 200; i++){
			bulletTrue[i] = false;
		}
	}
	
	//main run
	public void draw(){
		if(!endGame){
			if(slowStatus){
				background(115, 255, 255);
			}
			else{
				background(255, 255, 255);
			}
			fire();
			bulletReady();
			drawBullets();
			//displayPowerUp();
			//newDifficulty();
			borders();
			displayScore();
			drawTarget();
			didHit();
			wallHitBox();
			drawBall();
			//drawBullets();
			blocksTimer();
			slow();
			multiplyLimit();
			PowerUp();
			displayPowerUp();
			if((ifDeath() || ifDeath2()) && shieldStatus == false && shieldImmune <= 0){
				endGame = true;
			}
			else if(ifDeath() || ifDeath2()){
				shieldStatus = false;
				shieldBlink = true;
			}
		}
		else{
			fill(0);
			textSize(50);
			text("GAME OVER", 350, 400);
			text("Press 'l' to play again", 150, 450);
		}
	}
	
	public void wallHitBox(){
		if(gunStatus){
			for(int i = 0; i < 200; i++){
				for(int j = 0; j < 690; j++){
					if(bulletTrue[i] && toIncrement[j]){
						differenceX = j - xAxis[j];
						differenceY = bulletY[i] - yAxis[j];
						if(differenceX < 0){
							differenceX *= -1;
						}
						if(differenceY < 0){
							differenceY *= -1;
						}
						if(differenceX <= 10 && differenceY <= 10){
							xAxis[j] = 0;
							yAxis[j] = 0;
							toIncrement[i] = false;
						}
					}
				}
			}
		}
	}
	
	public void fire(){
		if(toFire){
			bulletTrue[bulletChooser] = true;
			bulletChooser++;
			if(bulletChooser >= 199){
				bulletChooser = 199;
			}
		}
		if(gunStatus){
			wallTimer();
		}
	}
	
	//initializes all arrays to current position of ball
	public void bulletReady(){
		for(int i = 0; i < 200; i++){
			if(!bulletTrue[i]){
				bulletY[i] = y;
				bulletX[i] = x;
			}
		}
	}
	
	//draws bullets and increments 
	public void drawBullets(){
		for(int i = 0; i < 200; i++)
		{
			if(bulletTrue[i]){
				if(wallTimer <= 150)
				{
					fill(173, 173, 173);
					ellipse(bulletX[i],bulletY[i],8,15);
				}
				else{
					fill(217, 224, 7);
					ellipse(bulletX[i],bulletY[i],8,15);
				}
			}
		}
	}
	
	public void wallTimer(){
		wallTimer--;
		if(wallTimer <= 0){
			numPowers--;
			gunStatus = false;
			wallTimer = 1000;
			for(int i = 0; i < 200; ++i){
				bulletTrue[i] = false;
				gun = "";
			}
		}
	}
	
	public void slow(){
		if(slowStatus){
			if(onlyOnce){
				speedHolder = blockSpeed;
				onlyOnce = false;
			}
			blockSpeed = 1;
			slowTime--;
			if(slowTime <= 0)
			{
				slowStatus = false;
				slow = "";
				numPowers--;
				blockSpeed = speedHolder;
			}
		}
	}
	
	public void multiplyLimit(){
		if(multiplyStatus){
			multiplyTime--;
			if(multiplyTime <= 0){
				multiplyStatus = false;
				multiplier = "";
				numPowers--;
				
			}
		}
		
	}
	
	
	//starts shield
	//sets shield immunity to 50 incase it gets popped
	public void shield(){
		shieldStatus = true;
		shieldImmune = 50;
		
	}

	//drops immunity of shield(50 loops) after shield breaks
	//when shield immunity goes to 0, stop blinking graphics
	//prevents function from running unless breaking another shield
	public void shieldImmunitydrop(){
		if(shieldDropStart){
			shieldImmune--;
			if(shieldImmune == 49){
				popShield = true;
			}
			else{
				popShield = false;
			}
			if(popShield){
				numPowers--;
				shield = "";
				popShield = false;
			}
		}
		if(shieldImmune <= 0){
			shieldDropStart = false;
			shieldBlink = false;
		}
		
	}
	
	//shows on bottom left hand corner different power ups you have
	public void displayPowerUp(){
		fill(0);
		textSize(20);
		text("Power Up: ", 300, 760);
		text(gun, 400, 760);
		text(shield, 465, 760);
		text(slow, 550, 760);
		text(multiplier, 620, 760);
//		if(toFire){
//			text("True", 300, 300);
//		}
		if(gunStatus){
			textSize(32);
			fill(224, 97, 7);
			text("WALLS LEFT: ", 10, 99);
			int walls = 200 - bulletChooser - 1;
			text(walls, 200, 99);
			text(differenceX, 300, 300);
			text(differenceY, 400, 400);
		}
		if(slowStatus){
			textSize(32);
			fill(224, 97, 7);
			text("SLOWED", 10, 66);
			text(slowTime, 180, 66);
		}
		if(multiplyStatus){
			textSize(32);
			fill(224, 97, 7);
			text("x2 Multiplier!!!", 10, 32);
			text(multiplyTime, 280, 32);
		}
		//text(wallTimer, 300, 300);
		//text(slowTime, 500, 500);
	}
	
	//function to regulate time before each spawn of powerup
	//can not have more than three power ups 
	public void powerUpSpawn(){
		if(numPowers < 3){
			Random generate = new Random();
			int value = generate.nextInt(1000);
			if(value < 10){
				spawnPowerUp = true;
				shouldDisplay = true;
			}
			else{
				spawnPowerUp = false;
			}
		}
		else{
			spawnPowerUp = false;
		}
	}
	
	//randomly decides which power up to pick. 
	//cannot choose same power up if already active
	public void powerUpDecide(){
		boolean didChoose = false;
		
		while(didChoose == false){
			Random generate = new Random();
			int val = generate.nextInt(4);
			if(val == 0 && gunStatus == false){
				//implement last
				gun = "Wall";
				gunStatus = true;
				didChoose = true;
				bulletChooser = 0;
			}
			else if(val == 1 && shieldStatus == false){
				shield = "Shield";
				shield();
				didChoose = true;
			}
			else if(val == 2 && slowStatus == false){
				//make slower
				slow = "Slow";
				slowTime = 800;
				onlyOnce = true;
				slowStatus = true;
				didChoose = true;
			}
			else if(val == 3 && multiplyStatus == false){
				//multiply points gathered by 2 for short amount of time
				multiplier = "x2";
				multiplyTime = 1000;
				multiplyStatus = true;
				didChoose = true;
			}
			else{
				didChoose = false;
			}
		}
	}
	
	//checks if ball collides with power up
	//when collides, decides which power up to choose in realtime
	public void powerUpHit(){
		int xval = x - x_power_position;
		int yval = y - y_power_position;
		if(xval <= 0){
			xval *= -1;
		}
		if( yval <= 0){
			yval *= -1;
		}
		if(xval <= 18 && yval <= 18){
			powerUpHit = true;
			powerUpDecide();

		}
		else{
			powerUpHit = false;
		}
	}
	
	//if previous powerup was already collected: can run
	// if powerupSpawn decides to spawn: created graphics of powerup
	// chooses random location to spawn powerup
	public void PowerUp(){
		if(powerUpHit){
			powerUpSpawn();
			if(spawnPowerUp){
				Random generate = new Random();
				x_power_position = generate.nextInt(680) + 10;
				y_power_position = generate.nextInt(750) + 10;
				temppowerx = x_power_position;
				temppowery = y_power_position;
				//change position later
				numPowers++;
			}
		}
		//bugfix: graphic wont pop up until actually spawned
		if(spawnPowerUp){
			powerUpHit();
			fill(124, 128, 146);
			ellipse(temppowerx, temppowery, 25, 25);
			textSize(22);
			fill(0);
			text("?", x_power_position - 4, y_power_position + 7);
		}
	}
	
	//make blocks from new difficulty continue travel across screen
	//if block completes its run, return array index to 0 and array picker to false
	public void newDifficultyBlocks(){
		for(int i = 789; i >= 0; i--){
			if(toIncrement2[i]){
				xAxis2[i] -= blockSpeed;
				fill(103,40,203);
				rect(xAxis2[i], i, 30, 30);
			}
			if(xAxis2[i] <= 0){
				xAxis2[i] = 690;
				toIncrement2[i] = false;
			}
		}
	}
	
	//if score is greater than 30, generate a random block to come sideways
	public void newDifficulty(){
		if(score >= 30){
			Random generate = new Random();
			int randNum = generate.nextInt(690);
			toIncrement2[randNum] = true;
		}
	}
	
	//increase speed of falling blocks
	public void blockSpeedIncrease(){
		if(score % 10 == 0){
			if(slowStatus)
			{
				speedHolder++;
			}
			else
			{
				blockSpeed++;
			}
			blockGenerateSpeed -= 10;
		}
	}
	
	//controls rate at which blocks spawn
	public void blocksTimer(){
		blocksTimer++;
		if(blocksTimer % blockGenerateSpeed == 0){
			fallingBlock();
			newDifficulty();
		}
		newDifficultyBlocks();
		//update block position every loop
			newDifficultyBlocks();
			for(int i = 0; i < 690; i++){
				if(toIncrement[i] == true){
					if(score == 30 || score == 31){
						blockSpeed = 1;
						blockGenerateSpeed = 100;
						fill(0);
						text("New Difficulty", 200, 200);
					}
					yAxis[i] += blockSpeed;
					fill(103,40,203);
					rect(i, yAxis[i], 30, 30);
				}
				if(yAxis[i] >= 800){
					yAxis[i] = 0;
					toIncrement[i] = false;
			}
		}
	}
	
	//prevents ball from moving out of map
	public void borders(){
		if(x <= 0){
			x = 0;
		}
		else if( x >= 700){
			x = 700;
		}
		
		if(y <= 0){
			y = 0;
		}
		else if( y >= 750){
			y = 750;
		}
	}
	
	//checks if ball hitbox meets block hitbox
	public boolean ifDeath(){
		for(int i = 0; i < 690; i++){
			if(toIncrement[i] == true){
				int closeEnuf = i - x;
				int closeEnuf1 = yAxis[i] - y;
				boolean negativeDisty = false;
				boolean negativeDistx = false;
				if(closeEnuf < 0){
					closeEnuf *= -1;
					negativeDistx = true;
				}
				if(closeEnuf1 < 0){
					closeEnuf1 *= -1;
					negativeDisty = true;
					
				}
				if(negativeDistx == true && negativeDisty == true){
					if(closeEnuf1 <= 50 && closeEnuf <= 50){
						shieldDropStart = true;
						return true;
						//coming from right
					}	
				}
				else if(negativeDisty == true && negativeDistx == false){
					if(closeEnuf1 <= 30 && closeEnuf <= 20){
						shieldDropStart = true;
						return true;
						//coming from left
					}
				}
				else if (negativeDisty == false && negativeDistx == true){
					if(closeEnuf1 <= 20 && closeEnuf <= 20){
						shieldDropStart = true;
						return true;
						//coming from top
					}
				}
				else{
					if(closeEnuf1 <= 20 && closeEnuf <= 20){
						shieldDropStart = true;
						return true;
						//coming from top
				}
				
			}
		}
	}
		return false;
	}
	
	//check if ball hits a block coming sideways
	public boolean ifDeath2(){
		for(int i = 0; i < 790; i++){
			if(toIncrement2[i]){
				int closeEnuf = xAxis2[i] - x;
				int closeEnuf1 = i - y;
				boolean negativeDisty = false;
				boolean negativeDistx = false;
				if(closeEnuf < 0){
					closeEnuf *= -1;
					negativeDistx = true;
				}
				if(closeEnuf1 < 0){
					closeEnuf1 *= -1;
					negativeDisty = true;
					
				}
				if(negativeDistx == true && negativeDisty == true){
					if(closeEnuf1 <= 50 && closeEnuf <= 50){
						shieldDropStart = true;
						return true;
						//coming from top
					}	
				}
				else if(negativeDisty == true){
					if(closeEnuf1 <= 30 && closeEnuf <= 20){
						shieldDropStart = true;
						return true;
						//coming from left
					}
				}
				else{
					if(closeEnuf1 <= 20 && closeEnuf <= 20){
						shieldDropStart = true;
						return true;
						//coming from top
					}
				}
			}
		}
		return false;
	}
		
	
	//displays score on bottom left hand corner
	public void displayScore(){
		fill(0);
		textSize(32);
		text("Score: ", 10, 760);
		if(isHit)
		{
			if(multiplyStatus){
				score += 2;
			}
			else{
				score++;
			}
			if(blockSpeed < 5){
				blockSpeedIncrease();
			}
		}
		text(score, 150, 760);
	}
	
	//randomly choose position of where to spawn block
	public void fallingBlock(){
		Random generate = new Random();
		int index1 = generate.nextInt(690);
		toIncrement[index1] = true;
	}
	
	//draws graphic of target
	public void drawTarget(){
		if(isHit){
			if(score < 30){
				Random generate = new Random();
				randx = generate.nextInt(680);
				randy = generate.nextInt(620) + 150;
				tempHolderx = randx;
				tempHoldery = randy;
			}
			else{
				Random generate = new Random();
				randx = generate.nextInt(530);
				randy = generate.nextInt(620) + 150;
				tempHolderx = randx;
				tempHoldery = randy;
			}
		}
		fill(0);
		ellipse(tempHolderx, tempHoldery, 10, 10);
	}
	
	//draw graphic of ball
	public void drawBall(){
		move();
		if(shieldStatus == true){
			xShield = x;
			yShield = y;
			fill(0);
			ellipse(xShield, yShield, 50, 50);
		}
		else if(shieldBlink == true && shieldImmune > 5){
			fill(227, 235, 84);
			ellipse(x, y, 50, 50);
		}
		shieldImmunitydrop();
		fill(255,0,0);
		ellipse(x,y,40,40);
	}
	
	//check if key pressed
	public void keyPressed(){
		if(key == 'd'){
			moveRight = true;
			//bulletRight = true;
		}
		if(key == 'a'){
			moveLeft = true;
			//bulletLeft = true;
		}
		if(key == 'w'){
			moveUp = true;
			//bulletUp = true;
		}
		if(key == 's'){
			moveDown = true;
			//bulletDown = true;
		}
		if(gunStatus){
			if(key == 'm'){
				toFire = true;
			}
		}
		//UPDATE LATER: bug where power up stays when game resets
		if(key == 'l'){
			shieldImmune = 0;
			endGame = false;
			onlyOnce = true;
			shieldStatus = false;
			slowStatus = false;
			gunStatus = false;
			multiplyStatus = false;
			powerUpHit = true;
			multiplyTime = 1000;
			slowTime = 800;
			x = 350;
			y = 400;
			numPowers = 0;
			gun = "";
			shield = "";
			slow = "";
			multiplier = "";
			score = 0;
			blockSpeed = 2;
			blockGenerateSpeed = 100;
			for(int i = 0; i < 690; i++){
				xAxis[i] = 0;
				yAxis[i] = 0;
				toIncrement[i] = false;
			}
			for(int i = 0; i < 790; i++){
				xAxis2[i] = 690;
				yAxis2[i] = 0;
				toIncrement2[i] = false;
			}
			for(int i = 0; i < 200; i++){
				bulletTrue[i] = false;
			}
		}
	}
	
	//check if key released
	public void keyReleased(){
		if(key == 'd'){
			moveRight = false;
		}
		if(key == 'a'){
			moveLeft = false;
		}
		if(key == 'w'){
			moveUp = false;
		}
		if(key == 's'){
			moveDown = false;
		}
		if(gunStatus){
			if(key == 'm'){
				toFire = false;
			}
		}
	}
	
	//update ball position if respective keypressed
	public void move(){
		if(moveRight){
			x += speed;
		}
		if(moveLeft){
			x -= speed;
		}
		if(moveDown){
			y += speed;
		}
		if(moveUp){
			y -= speed;
		}
	}
	
	//check if ball hitbox meets target hitbox
	public void didHit(){
		int closeEnufx = x - randx;
		int closeEnufy = y - randy;
		if(closeEnufx < 0)
		{
			closeEnufx = closeEnufx * -1;
		}
		if(closeEnufy < 0)
		{
			closeEnufy = closeEnufy * -1;
		}
		if(closeEnufx < 20 && closeEnufy < 20){
			isHit =  true;
		}
		else{
			isHit = false;
		}
	}	
}
