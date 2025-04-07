class MiniGame {
  Timer timer = new Timer();
  boolean objectiveStartStatus;
  boolean objectiveComplete;
  String name;
  double timerLength;

  MiniGame(boolean objStart, String name, double timerLength) {
    this.objectiveStartStatus = objStart;
    this.objectiveComplete = objStart;
    this.name = name;
    this.timerLength = timerLength;
  }
  public void reset() {
    this.objectiveComplete = this.objectiveStartStatus;
    this.timer.timerEnd = false;
    this.timer.timerStart = true;
    keyCode = 0;
  }

  public void play() {
    timer.startTimer(this.timerLength, config.miniTimerMult);
    if (timer.timerEnd) {
      if (this.objectiveComplete) {
        System.out.println("win");
        config.minigameResults("WIN");
      } else {
        System.out.println("lose");
        config.minigameResults("LOSE");
      }
    }
  }
}
