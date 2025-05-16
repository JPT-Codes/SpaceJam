class SimonSays extends MiniGame {


  public boolean[] keys = {false, false, false, false, false};

  boolean keyIsPressed = false;
  boolean turnSimon = true;

  boolean objectiveComplete = false;
  boolean gameFailed = false;
  boolean winnerWinnerChickenDinner = false;
  boolean oneKey = false;

  boolean onlyRed = false;
  boolean onlyBlue = false;
  boolean onlyYellow = false;
  boolean onlyGreen = false;

  int[] simonTalk = new int[3];
  color[] simonColors = {#76E641, #FE5C5C, #468FF3, #FAEF55};

  int correctSequence = 0;
  int i = 0;
  int a = 0;

  color redOff = color(224, 32, 32);
  color yellowOff = color(218, 199, 35);
  color blueOff = color(30, 103, 203);
  color greenOff = color(78, 180, 35);

  SimonSays(boolean objStart, String name, double timerLength) {
    super(objStart, name, timerLength);
  }

  public void reset() {
    super.reset();

    objectiveComplete = false;
    gameFailed = false;
    winnerWinnerChickenDinner = false;
    correctSequence = 0;
    i = 0;
    a = 0;
  }

  public void play() {
    super.play();

    ///KEY CONTROLS///

    if (config.keys[1] && !onlyBlue && !onlyRed && !onlyYellow) {
      keyIsPressed = true;
      onlyGreen = true;
    }
    if (config.keys[2] && !onlyBlue && !onlyGreen && !onlyYellow) {
      config.keys[2] = true;
      keyIsPressed = true;
      onlyRed = true;
    }
    if (config.keys[3] && !onlyGreen && !onlyRed && !onlyYellow) {
      keyIsPressed = true;
      onlyBlue = true;
    }
    if (config.keys[4] && !onlyBlue && !onlyRed && !onlyGreen) {
      keyIsPressed = true;
      onlyYellow = true;
    }


    if (config.keys[1]) {
      keyIsPressed = false;
      oneKey = false;
      onlyGreen = false;
    }
    if (config.keys[2]) {
      keyIsPressed = false;
      oneKey = false;
      onlyRed = false;
    }
    if (config.keys[3]) {
      keyIsPressed = false;
      oneKey = false;
      onlyBlue = false;
    }
    if (config.keys[4]) {
      keyIsPressed = false;
      oneKey = false;
      onlyYellow = false;
    }

    ///SIMON LOGIC///

    for (int i = 0; i < simonTalk.length; i++) {
      simonTalk[i] = (int) random(1, 5);
    }


    if (turnSimon == true && i < simonTalk.length) {
      if (keys[simonTalk[i]] && !gameFailed && !oneKey) {
        correctSequence++;
        i++;
        oneKey = true;
        keyIsPressed = false;
        if (correctSequence == 3 && i == 3) {
          gameFailed = false;
          winnerWinnerChickenDinner = true;
          turnSimon = false;
          objectiveComplete = true;
        }
      } else if (!keys[simonTalk[i]] && keyIsPressed && !oneKey) {
        keyIsPressed = false;
        gameFailed = true;
        turnSimon = false;
        objectiveComplete = false;
      }
    }

    ///GAME VISUAL///

    background(255);
    strokeWeight(4);
    stroke(0);
    fill(0);
    circle(width/2, height/2, 900);

    if (keys[3] && !gameFailed || winnerWinnerChickenDinner) {
      fill(simonColors[2]);
    } else {
      fill(blueOff);
    }
    arc(width/2, height/2, 750, 750, -QUARTER_PI, QUARTER_PI); //BLUE RIGHT 3

    if (keys[4] && !gameFailed || winnerWinnerChickenDinner) {
      fill(simonColors[3]);
    } else {
      fill(yellowOff);
    }
    arc(width/2, height/2, 750, 750, QUARTER_PI, PI - QUARTER_PI); //YELLOW DOWN 4

    if (keys[1] && !gameFailed || winnerWinnerChickenDinner) {
      fill(simonColors[0]);
    } else {
      fill(greenOff);
    }
    arc(width/2, height/2, 750, 750, HALF_PI + QUARTER_PI, PI + QUARTER_PI); //GREEN LEFT 1

    if (keys[2] && !gameFailed || winnerWinnerChickenDinner) {
      fill(simonColors[1]);
    } else {
      fill(redOff);
    }
    arc(width/2, height/2, 750, 750, -HALF_PI - QUARTER_PI, -QUARTER_PI); //RED UP 2

    fill(0);
    circle(width/2, height/2, 350);

    strokeWeight(80);
    line(685, 265, 1235, 815);
    line(685, 815, 1235, 265);

    ///DIRECTIONS VISUAL///

    textSize(128);
    strokeWeight(16);
    stroke(255);
    fill(255, 255, 255);
    textAlign(CENTER);
    if (!objectiveComplete) {
      if (i >= 2 && simonTalk[0] == simonTalk[1] && simonTalk[1] == simonTalk[2]) {
        text("AGAIN x2", width/2, height/2);
      } else if (i >= 1 && simonTalk[(i - 1)] == simonTalk[i]) {
        text("AGAIN", width/2, height/2);
      } else if (simonTalk[i] == 1) {
        text("GREEN!!!", width/2, height/2);
      } else if (simonTalk[i] == 2) {
        text("RED!!!", width/2, height/2);
      } else if (simonTalk[i] == 3) {
        text("BLUE!!!", width/2, height/2);
      } else if (simonTalk[i] == 4) {
        text("YELLOW!!!", width/2, height/2);
      }
    }

    ///WIN VISUAL///

    if (gameFailed) {
      rectMode(CENTER);
      fill(255, 0, 0, 125);
      rect(width/2, height/2, width + 20, height + 20);
      textAlign(CENTER);
      textSize(128);
      strokeWeight(16);
      stroke(255, 255, 255);
      fill(255, 0, 0);
      text("SIMON DIDN'T SAY THAT >:-(", width/2, height/2);
    }

    if (winnerWinnerChickenDinner) {
      rectMode(CENTER);
      fill(0, 255, 0, 125);
      rect(width/2, height/2, width + 20, height + 20);
      textAlign(CENTER);
      textSize(128);
      strokeWeight(16);
      stroke(255, 255, 255);
      fill(0, 255, 0);
      text("YOU LISTENED TO SIMON :-)", width/2, height/2);
    }
  }
