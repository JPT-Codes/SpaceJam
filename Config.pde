class Config {
  public int windowWidth = 1920;
  public int windowHeight = 1080;
  public int lives = 3;
  public int speedUp = 0;
  public double miniTimerMult = 1;
  public int score = 0;
  public int currentFloor = 0;
  public boolean[] keys = {false, false, false, false, false};

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

void keyPressed() {
  if (keyCode == CONTROL) {
    config.keys[0] = true;
  }
  if (keyCode == LEFT) {
    config.keys[1] =true;
  }
  if (keyCode == UP) {
    config.keys[2] = true;
  }
  if (keyCode == RIGHT) {
    config.keys[3] = true;
  }
  if (keyCode == DOWN) {
    config.keys[4] = true;
  }
}

void keyReleased() {
  if (keyCode == CONTROL) {
    config.keys[0] = false;
  }
  if (keyCode == LEFT) {
    config.keys[1] = false;
  }
  if (keyCode == UP) {
    config.keys[2] = false;
  }
  if (keyCode == RIGHT) {
    config.keys[3] = false;
  }
  if (keyCode == DOWN) {
    config.keys[4] = false;
  }
}
