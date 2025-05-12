class AlienAlien extends MiniGame {
  int alienX = width/2;
  int alienY = 1000;
  int alienW = 50;
  int alienH = 50;
  float alienSpeed = 6;

  int spotLightX = 0;
  int spotLightY = 0;
  int spotLightW = 175;
  int spotLightH = 175;

  int vertLightX = 0;
  int vertLightY = 0;
  int vertLightW = 175;
  int vertLightH = 175;

  int chaseLightX = 0;
  int chaseLightY = 0;
  int chaseLightW = 125;
  int chaseLightH = 125;

  int shipX = width/2;
  int shipY = 150;
  int shipW = 100;
  int shipH = 150;

  float youCantEscape = 1;
  float chaserYouCantEscape = 0;
  int imGettingMAD = 0;
  
  int yAiming = 9;
  int xAiming = 3;

  int spotFlash = 255;
  int fillerLight = 255;
  
  boolean STUNNED = false;
  
  int alienRuns = 0;


  AlienAlien(boolean objStart, String name, double timerLength) {
    super(objStart, name, timerLength);
  }

  public void reset() {
    super.reset();
    //counts how many times you have gotten the game
    alienRuns++;

    alienX = width/2;
    alienY = 1000;
    youCantEscape = 1;
    imGettingMAD = 0;

    spotLightX = 150;
    spotLightY = height/2;

    vertLightX = width/2;
    vertLightY = 150;


    chaseLightX = width/2;
    chaseLightY = height/2;

    chaserYouCantEscape = 1.25;
    yAiming = 7;
    xAiming = 4;
    
    //future run proof concept
    //it essentially means every 5 more runs (after 5), get 1 extra pixel speed
    if (alienRuns > 5) {
      alienSpeed = (6 + alienRuns / 5) - 1;
    } else {
      alienSpeed = 6;
    }
    STUNNED = false;
  }

  private void alien() {
    //mr gross picked this for our nefarious alien
    fill(#cdc1cb);
    
    //make alien and controls
    rect(alienX, alienY, alienW, alienH);
    if (config.keys[2]) {
      alienY -= alienSpeed;
    }
    if (config.keys[4]) {
      alienY += alienSpeed;
    }
    if (config.keys[1]) {
      alienX -= alienSpeed;
    }
    if (config.keys[3]) {
      alienX += alienSpeed;
    }


    //if spotLights hit you and stun, you recover here VERY slowly.
    if (alienSpeed < 6 && alienSpeed > 0) {
      //watch in horror as you're caught type of speed increase.
      alienSpeed += .05;
    }
    
    //very basic edge wall collision
    if (alienX > width){
    alienX -= 10;
    }
    if (alienX < 0){
    alienX += 10;
    }
    if (alienY > height){
    alienY -= 10;
    }
    if (alienY < 0){
    alienY += 10;
    }
  }

  private void whereIsAlien() {
    //x axis launcher light
    
    rectMode(CENTER);
    rect(spotLightX, spotLightY, spotLightW, spotLightH);
    fill(spotFlash, spotFlash, fillerLight);
    //makes it look like spotlight (but it's a square!!!!) :evil:
    circle(spotLightX, spotLightY, 250);

    //example: if y is up or down from alien, move down/up to meet him

    if (spotLightY < alienY) {
      spotLightY+= yAiming;
    } else if (spotLightY > alienY) {
      spotLightY-= yAiming;
    }

    //if you aren't at x move to it, else move to it
    //so it NEVER stops.

    if (spotLightX < alienX) {
      spotLightX+= youCantEscape - 1;
    } else {
      spotLightX+= youCantEscape - 1;
    }

    //vertlight; follows same idea

    rect(vertLightX, vertLightY, vertLightW, vertLightH);
    circle(vertLightX, vertLightY, 250);

    if (vertLightY < alienY) {
      vertLightY+= youCantEscape - 1;
    } else {
      vertLightY+= youCantEscape - 1;
    }
    if (vertLightX < alienX) {
      vertLightX+= xAiming;
    } else if (vertLightX > alienX) {
      vertLightX-= xAiming;
    }


    //chaser light
    
    
    if (STUNNED == false) {
      //flashes red when it starts to move faster. otherwise its just white
      fill(spotFlash, fillerLight, fillerLight);
    } else
    {
      //if hit by other lights, turns this one perma-red with minor flash
      fill(random(100, 255), 0, 0);
    }
    rect(chaseLightX, chaseLightY, chaseLightW, chaseLightH);
    circle(chaseLightX, chaseLightY, 175);
    
    //same as other lights, but it can go backwards as well to meet you
    
    if (chaseLightY < alienY) {
      chaseLightY+= chaserYouCantEscape;
    } else if (chaseLightY > alienY) {
      chaseLightY-= chaserYouCantEscape;
    }
    if (chaseLightX < alienX) {
      chaseLightX+= chaserYouCantEscape;
    } else if (chaseLightX > alienX) {
      chaseLightX-= chaserYouCantEscape;
    }
  }


  private void getOverHere() {
    //get start frame
    if (imGettingMAD == 0) {
      imGettingMAD = frameCount;
    }
    //15 guaranteed frames plus a random extra amount up to one second before the lights kick in
    if (frameCount > imGettingMAD + 15 + (int)random(60)) {
      //increases launcher lights speeds by 2 pixels every frame.
      youCantEscape += 2 ;
      //if not stunned, increase chaser by .025 every frame up to a cap .5 slower than base player
      if (!STUNNED) {
        if (chaserYouCantEscape < alienSpeed - .5) {
          chaserYouCantEscape += .025;
        }
      } else {
        if (chaserYouCantEscape < 15) {
          chaserYouCantEscape ++;
        }
      }
      //the y/x is disabled for the launching lights
      yAiming = 0;
      xAiming = 0;

      // light flash after a few ticks of "lightspeed" to give you a warning (why didn't i name it that!!!)
      fillerLight = 0;
      if (youCantEscape > 6) {
        fillerLight = 255;
      }
    }
  }

  private void ship() {
    fill(225);
    //only thing that really needs collision check is this, the hull of the rocket.
    rect(shipX, shipY, shipW, shipH);

    //the rest is cosmetic
    fill(75);
    triangle(width/2 - 50, 75, width/2 + 50, 75, width/2, 25 );
    rect(width/2, 250, 75, 50);
    fill(0, 200, 200);
    circle(width/2, 130, 50);
  }

  //x, y, w, h for the two rectangles colliding
  private boolean hitDetect(int x1, int y1, int w1, int h1, int x2, int y2, int w2, int h2) {
    //aabb collision check from online (to save time)
    if (x1 < x2 + w2 && x2 < x1 + w1 && y1 < y2 + h2 && y2 < y1 + h1) {
      return true;
    } else {

      return false;
    }
  }


  public void play() {
    super.play();
    textAlign(CENTER);
    background(25);
    textSize(35);
    text("Sneak aboard the ship!!", width/2, height/2);



    getOverHere();
    ship();
    whereIsAlien();
    alien();

    //essentially if Al Ien (his government name) touches an inner rectangle of the spotlights, or the ship, lose or win respectively.
    if (hitDetect(alienX, alienY, alienW, alienH, spotLightX, spotLightY, spotLightW, spotLightH)) {
      //vert and spot just stun now, which leads to your death, but scarier, which is nice.
      alienSpeed = 2.25;
      background(255, 200, 0);
      //stun pop up
      textSize(75);
      fill(0);
      STUNNED = true;
      text("STUNNED!", width/2, height/2);
    }
    if (hitDetect(alienX, alienY, alienW, alienH, vertLightX, vertLightY, vertLightW, vertLightH)) {
      alienSpeed = 2.25;
      background(255, 200, 0);
      textAlign(CENTER);
      textSize(75);
      fill(0);
      STUNNED = true;
      text("STUNNED!", width/2, height/2);
    }
    if (hitDetect(alienX, alienY, alienW, alienH, chaseLightX, chaseLightY, chaseLightW, chaseLightH)) {
      objectiveComplete = false;
      //yep, chaser is the only one that can end the run. pretty fun fact
      alienSpeed = 0;
      background(255, 0, 0);
      textSize(75);
      text("you were CAUGHT!", width/2, height/2);
    }
    if (hitDetect(alienX, alienY, alienW, alienH, shipX, shipY, shipW, shipH)) {
      objectiveComplete = true;
      //just in case chaser light fails a winner
      chaserYouCantEscape = 0;
      alienSpeed = 0;
      background(0, 200, 0);
      textSize(25);
      text("yipie  you made it      on  !", width/2, height/2);
    }
  }
}
