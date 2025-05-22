class SimonSays extends MiniGame {
  int[] simonSays = {0, 0, 0};
  boolean yellowPressed = false;
  boolean greenPressed = false;
  boolean redPressed = false;
  boolean bluePressed = false;
  boolean gameFailed = false;
  boolean pressOnce = false;

  int currentSimon = 0;

  color yellowFill = color(200, 200, 0);
  color greenFill = color(0, 0, 200);
  color redFill = color(200, 0, 0);
  color blueFill = color(0, 200, 0);
  color bgColor = color(255, 255, 255);

  SimonSays(boolean objStart, String name, double timerLength) {
    super(objStart, name, timerLength);
  }

  public void reset() {
    super.reset();
    for (int i = 0; i < simonSays.length; i++) {
      simonSays[i] = (int)random(1, 5);
    }
    currentSimon = 0;
    yellowPressed = false;
    greenPressed = false;
    redPressed = false;
    bluePressed = false;
    gameFailed = false;
    pressOnce = false;
    bgColor = color(255, 255, 255);
  }


  public void play() {
    super.play();
    background(bgColor);
    
    // Game "Pad"
    fill(0);
    ellipse(config.windowWidth/2, config.windowHeight/2, 700, 700);
    fill(yellowFill);
    arc(config.windowWidth/2, config.windowHeight/2, 600, 600, PI/4, 3 * PI/4);
    fill(greenFill);
    arc(config.windowWidth/2, config.windowHeight/2, 600, 600, 3 * PI/4, 5 * PI/4);
    fill(redFill);
    arc(config.windowWidth/2, config.windowHeight/2, 600, 600, 5 * PI/4, 7 * PI/4);
    fill(blueFill);
    arc(config.windowWidth/2, config.windowHeight/2, 600, 600, 7 * PI/4, 9 * PI/4);
    fill(0);
    ellipse(config.windowWidth/2, config.windowHeight/2, 250, 250);
    strokeWeight(50);
    line(config.windowWidth/2 + 220, config.windowHeight/2 - 220, config.windowWidth/2 - 220, config.windowHeight/2 + 220);
    line(config.windowWidth/2 - 220, config.windowHeight/2 - 220, config.windowWidth/2 + 220, config.windowHeight/2 + 220);

    // Green
    if (config.keys[1] && !redPressed && !bluePressed && !yellowPressed) {
      greenPressed = true;
      greenFill = color(0, 0, 255);
    } else {
      greenFill = color(0, 0, 200);
      greenPressed = false;
    }
    
    // Red
    if (config.keys[2] && !bluePressed && !yellowPressed && !greenPressed) {
      redPressed = true;
      redFill = color(255, 0, 0);
    } else {
      redFill = color(200, 0, 0);
      redPressed = false;
    }

    // Blue
    if (config.keys[3] && !yellowPressed && !greenPressed && !redPressed) {
      bluePressed = true;
      blueFill = color(0, 255, 0);
    } else {
      blueFill = color(0, 200, 0);
      bluePressed = false;
    }

    // Yellow
    if (config.keys[4] && !greenPressed && !redPressed && !bluePressed) {
      yellowPressed = true;
      yellowFill = color(255, 255, 0);
    } else {
      yellowFill = color(200, 200, 0);
      yellowPressed = false;
    }

    // When You Fail
    if (gameFailed) {
      fill(255, 0, 0);
      textAlign(CENTER);
      textSize(50);
      bgColor = color(255, 0, 0);
      fill(0);
      text("FAIL", config.windowWidth/2, config.windowHeight/10);
    }

    // Simon Says
    if (!gameFailed && currentSimon < simonSays.length) {
      if (simonSays[currentSimon] == 4) {
        text("YELLOW!", config.windowWidth/2, config.windowHeight/10);
      } else if (simonSays[currentSimon] == 3) {
        text("GREEN!", config.windowWidth/2, config.windowHeight/10);
      } else if (simonSays[currentSimon] == 2) {
        text("RED!", config.windowWidth/2, config.windowHeight/10);
      } else if (simonSays[currentSimon] == 1) {
        text("BLUE!", config.windowWidth/2, config.windowHeight/10);
      }
    }

    // Progression
    if (currentSimon < simonSays.length && config.keys[simonSays[currentSimon]] && !pressOnce && !gameFailed) {
      currentSimon++;
      bgColor = color(0, 255, 0);
      pressOnce = true;
    } else if (!yellowPressed && !greenPressed && !redPressed && !bluePressed && !gameFailed) {
      pressOnce = false;
      bgColor = color(255, 255, 255);
    }
    
    // Failure
    if (currentSimon < simonSays.length && !pressOnce && config.keys[4] && simonSays[currentSimon] != 4) {
      gameFailed = true;
    } else if (currentSimon < simonSays.length && !pressOnce && config.keys[3] && simonSays[currentSimon] != 3) {
      gameFailed = true;
    } else if (currentSimon < simonSays.length && !pressOnce && config.keys[2] && simonSays[currentSimon] != 2) {
      gameFailed = true;
    } else if (currentSimon < simonSays.length && !pressOnce && config.keys[3] && simonSays[currentSimon] != 2) {
      gameFailed = true;
    }

    // Completion
    if (currentSimon >= simonSays.length && !gameFailed) {
      objectiveComplete = true;
      text("CONGRATS!", config.windowWidth/2, config.windowHeight/10);
      bgColor = color(0, 0, 255);
    }
  }
}
