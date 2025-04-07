class TestGame extends MiniGame {

  TestGame(boolean objStart, String name, double timerLength) {
    super(objStart, name, timerLength);
  }

  public void reset() {
    this.objectiveComplete = this.objectiveStartStatus;
    keyCode = 0;
    this.timer.timerEnd = false;
    this.timer.timerStart = true;
  }

  public void play() {
    super.play();
    background(255, 0, 0);
    textAlign(CENTER);
    text("Press Z", width / 2, height / 5);
    if (keyCode == 90) {
      this.objectiveComplete = true;
    }
    if (this.objectiveComplete) {
      background(0, 100, 0);
    }
  }
}
