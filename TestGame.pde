class TestGame extends MiniGame {

  TestGame(boolean objStart, String name, double timerLength) {
    super(objStart, name, timerLength);
  }

  public void reset() {
    super.reset();
  }

  public void play() {
    super.play();
    background(255, 0, 0);
    textAlign(CENTER);
    text("Press CTRL", width / 2, height / 5);
    if (config.keys[0]) {
      this.objectiveComplete = true;
    }
    if (this.objectiveComplete) {
      background(0, 100, 0);
    }
  }
}
