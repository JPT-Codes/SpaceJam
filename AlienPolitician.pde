class AlienPolitician extends MiniGame {
  int[] crowdHeights = {285, 355, 425}; // Possible heights of crowd members
  int[] crowdMemberHeights = new int[20]; // Heights for each crowd member
  //we need to take the frame player ducks, and 120 frames (can be changed later) later, force the stand up
  int startDuck = -1;
  int duckTime = 35  ;
  // Text attack variables
  int textSpeed;
  String[] phrases = {"LIE!", "FAKE!", "BOOO!", "WE WANT THE TRUTH!", "NO MORE TAXES!", "WHAT IS YOUR PLAN?", "NO TAXES! PLEASE!", "L (this is an intentional phrase)", "HOW MUCH IS EGG!?"}; // Array of possible phrases
  String attackText = "";  // The current phrase being thrown at the politician
  int textX = -100;        // Starts offscreen (text starts moving from here)
  int textY = 750;         // Fixed Y position for the text
  boolean textActive = true; // Is the text attack active or not?
  boolean youOnlyDuckTwice = false;
  boolean politicalLatch = false;
  boolean duckReleased = true;

  boolean wallCheck = false;
  int thinkingColor = 0;
  int rand = (int)random(0, 1);


  // Ducking variables
  int currentY = 710;      // Y position of the top of the politician; changes if ducking
  int bodyHeight = 240;    // Total body height of the politician

  AlienPolitician(boolean objStart, String name, double timerLength) {
    super(objStart, name, timerLength);
  }

  public void reset() {
    super.reset();
    textX = -100; // Reset text position off the screen
    textActive = true; // Set text to be active again
    attackText = phrases[(int)random(phrases.length)]; // Pick a random phrase to attack

    // Assign random heights to each crowd member
    for (int i = 0; i < crowdMemberHeights.length; i++) {
      int heightChoice = (int)random(0, 3); // Randomly pick a height choice (0, 1, or 2)
      crowdMemberHeights[i] = crowdHeights[heightChoice]; // Assign the random height to the crowd member
    }
    startDuck = 0;
    youOnlyDuckTwice = false;
    currentY = 710;
    thinkingColor = 0;
    wallCheck = false;
    rand = (int)random(0, 50);
  }

  private void checkDuck() {
    // If key is released, allow future ducks
    if (!config.keys[4]) {
      duckReleased = true;
    }

    // Only allow duck if key was released since last duck
    if (duckReleased && !youOnlyDuckTwice && config.keys[4]) {
      youOnlyDuckTwice = true;
      startDuck = frameCount;
      duckReleased = false; // prevent re-trigger until released again
    }
  }




  private void ducker() {
    if (youOnlyDuckTwice) {
      if (frameCount < (startDuck + duckTime)) {
        currentY = 790;
        bodyHeight = 160;
      } else {
        currentY = 710;
        bodyHeight = 240;
        youOnlyDuckTwice = false;
        politicalLatch = false;
      }
    }
  }


  private void politician() {
    // Duck if down key is held (controls if the politician is ducking or standing)


    //if (config.keys[4]) {
    //  currentY = 790;  // Duck: move the whole body lower when DOWN key is pressed
    //} else {

    //  currentY = 710;  // Stand back up if DOWN key is not pressed
    //}

    rectMode(CORNER);
    fill(125);
    rect(1500, currentY, 80, bodyHeight); // Draw the politician's body

    fill(0);
    rect(1500, 850, 80, 100); // Draw the overcoat

    fill(255);
    triangle(1500, 850, 1540, 900, 1580, 850); // Draw the inner suit

    fill(0, 200, 200);
    noStroke();
    rect(1535, 850, 10, 30); // Draw the tie
    triangle(1535, 880, 1545, 880, 1540, 900); // Draw the tie bottom

    fill(100, 57, 39);
    stroke(1);
    rect(1400, 950, 1920, 1920); // Draw the stage
  }

  private void crowd() {
    // Loop through all crowd members and draw them based on their assigned heights
    for (int i = 0; i < crowdMemberHeights.length; i++) {
      rectMode(CENTER);
      fill(0);
      stroke(1);
      rect(20 + i * 65, 1030, 60, crowdMemberHeights[i]); // Draw each crowd member at a different height
    }
  }


  private void thinkerCrowd() {
    if (!wallCheck) {
      if (rand == 12) {
        thinkingColor = 200;
      } else {
        wallCheck = true;
      }
    }




    fill(0, thinkingColor, thinkingColor);
    rect(996, 1000, 60, 425);
  }
  private void questionDodge() {
    // Check if the text attack is active and move it across the screen
    if (textActive) {
      fill(255);
      textSize(32);
      text(attackText, textX, textY); // Display the attack text at its current position
      if (timerLength/1000 > 4) {
        textSpeed = 8;
      } else if (timerLength/1000 <= 4) {
        textSpeed = 16;
      }
      textX += textSpeed; // Move the text to the right

      // Collision check: If the text is over the politician and in the right height range, it's a hit
      if ((textX > 1500 && textX < 1580) && (textY > currentY && textY < (currentY + bodyHeight))) {
        // If the politician is hit, end the timer and mark the objective as incomplete
        timer.timerEnd = true;
        objectiveComplete = false;
        textActive = false; // Stop the text from moving
      }

      // If the text moves off the screen to the right, it means the politician dodged it successfully
      if (textX > width) {
        timer.timerEnd = true;
        objectiveComplete = true;
        textActive = false; // Stop the text attack
      }
    }
  }

  public void play() {

    super.play();
    background(30, 9, 57);
    textSize(40);
    textAlign(CENTER);
    text("DUCK THE QUESTIONS!!!!", width/2, height/3);
    checkDuck();
    ducker();
    politician();
    crowd();
    thinkerCrowd();
    questionDodge();
  }
}
