class TestYourStrength extends MiniGame {
  private int zCount = 0;
  private int maxCount = (int)timerLength/1000 * 2;
  private int latch = 0;

  TestYourStrength(boolean objStart, String name, double timerLength) {
    super(objStart, name, timerLength);
  }

  private void zIncrement() {
    if (config.keys[0] && latch == 0) {
      zCount++;
      latch = 1;
    } else if (!config.keys[0]) {
      latch = 0;
    }
  }

  public void reset() {
    super.reset();
    this.zCount = 0;
    background(zCount, 0 + zCount * 4.5, 25 + zCount * 8);
    text("click CTRL " + maxCount + " times!", width/2, height/2 - 100);
    textAlign(CENTER);
    text("CTRL Pressed: " + zCount, width/2, height/2);
    // Put what your minigame needs to reset each time it is played here.
    //config.keys[0] = ctrl / action key
  }

  public void play() {
    super.play();
    zIncrement();
    textSize(45);
    background(zCount, 0 + zCount * 32, 0);
    fill(255);
    text("click CTRL " + maxCount + " times!", width/2, height/2 - 100);
    textAlign(CENTER);
    text("CTRL Pressed: " + zCount, width/2, height/2);

    if (this.zCount >= this.maxCount) {
      this.objectiveComplete = true;
    }
    if (this.objectiveComplete) {
      background(0, 200, 0);
    }
  }
}
