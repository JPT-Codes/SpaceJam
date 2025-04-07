class Config {
  public int windowWidth = 1920;
  public int windowHeight = 1080;
  public int lives = 3;
  public int speedUp = 0;
  public double miniTimerMult = 1;
  public int score = 0;
  public int currentFloor = 0;

  public void minigameResults(String winLose) {
    if (winLose.equalsIgnoreCase("LOSE")) {
      lives--;
      // TODO remove 1 lives icon from top
    }
    score++;
    this.currentFloor = score;
    if (score - speedUp == 10) {
      miniTimerMult += 0.2;
      speedUp = score;
    }
  }

  public boolean inMiniGame() {
    boolean inGame = false;
    if (this.score < this.currentFloor) {
      inGame = true;
    }
    return inGame;
  }
}
