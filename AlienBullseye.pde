class AlienBullseye extends MiniGame {
  int squareX;
  int squareY;
  int squareSize = 30;
  int targetX;
  int targetY;
  int targetWidth = 80;
  int targetHeight = 40;

  AlienBullseye(boolean objStart, String name, double timerLength) {
    super(objStart, name, timerLength);
  }

  public void reset() {
    super.reset();
    squareY = config.windowHeight / 2 - squareSize / 2;
    targetY = config.windowHeight / 2 - targetHeight / 2;
    targetX = int(random(config.windowWidth / 2, config.windowWidth - targetWidth - 10));
    squareX = 0;
  }

  public void play() {
    super.play();
    background(0);
    fill(255);
    textAlign(CENTER);
    text("HIT THE RECTANGLE!", config.windowWidth/2, 450);
    fill(255);
    textAlign(CENTER);
    textSize(20);

    if (!this.objectiveComplete) {
      // Move square
      float speedPerFrame = (float)config.windowWidth / ((float)timerLength / 1000.0 * frameRate);
      squareX += max(1, int(speedPerFrame));

      // Draw moving square
      fill(0, 255, 0);
      rect(squareX, squareY, squareSize, squareSize);

      // Draw target rectangle
      fill(255, 0, 0);
      rect(targetX, targetY, targetWidth, targetHeight);

      // Check if player pressed CONTROL
      if (config.keys[0]) {
        if (squareX + squareSize > targetX && squareX < targetX + targetWidth) {
          this.objectiveComplete = true;
          config.minigameResults("WIN");
        } else {
          this.objectiveComplete = false;
          config.minigameResults("LOSE");
        }
        config.keys[0] = false; // Reset key state
      }

      // Check if square moved past screen
      if (squareX > config.windowWidth) {
        this.objectiveComplete = false;
        config.minigameResults("LOSE");
      }
    } else {
      this.objectiveComplete = true;
      config.minigameResults("WIN");
    }
  }
}
