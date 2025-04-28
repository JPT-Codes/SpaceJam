class UI {
  void showLives() {
    fill(0);
    rect(0, 0, 150, 60);
    fill(255);
    textSize(40);
    text("Lives: " + config.lives, 70, 40);
  }

  void showLevel() {
    fill(0);
    rect(width - 160, 0, 160, 60);
    fill(255);
    textSize(40);
    text("Level: " + config.currentFloor, width - 80, 40);
  }

  void showTimer(Timer time) {
    if (config.inMiniGame()) {
      fill(0);
      rect(0, height - 60, 220, 60);
      fill(255);
      textSize(40);
      text("Time Left: " + time.timeLeft, 105, height - 20);
    }
  }

  void showUI(Timer time) {
    rectMode(CORNER);
    textAlign(CENTER, BASELINE);
    ui.showLives();
    ui.showLevel();
    ui.showTimer(time);
  }
}
