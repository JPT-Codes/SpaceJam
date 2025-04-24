class PressAllArrows extends MiniGame {

  PressAllArrows(boolean objStart, String name, double timerLength) {
    super(objStart, name, timerLength);
  }

  public void reset() {
    super.reset();
  }

  public void play() {
    super.play();
    background(150, 150, 250);
    textSize(40);
    textAlign(CENTER);
    text("Press all arrow keys at once!", width / 2, height / 5);

    // controls
    boolean leftPressed = config.keys[1]; 
    boolean upPressed = config.keys[2]; 
    boolean rightPressed = config.keys[3]; 
    boolean downPressed = config.keys[4];


    fill(upPressed ? color(0, 255, 0) : color(255, 0, 0));
    text("↑", width / 2 - 100, height / 2);

    fill(leftPressed ? color(0, 255, 0) : color(255, 0, 0));
    text("←", width / 2 - 50, height / 2);

    fill(downPressed ? color(0, 255, 0) : color(255, 0, 0));
    text("↓", width / 2 + 50, height / 2);

    fill(rightPressed ? color(0, 255, 0) : color(255, 0, 0));
    text("→", width / 2 + 100, height / 2);

    // all keys pressed
    if (upPressed && downPressed && leftPressed && rightPressed) {
      this.objectiveComplete = true;
    }

    // win msg
    if (this.objectiveComplete) {
      background(0, 200, 0);
      text("You won!", width / 2, height / 2 + 50);
    }
  }
}
