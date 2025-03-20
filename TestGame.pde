class TestGame extends MiniGame {
  
  TestGame(boolean objComp, String name, double timerLength) {
    super(objComp, name, timerLength);
  }

  public String play() {
    super.play();
    background(255, 0, 0);
    textAlign(CENTER);
    text("Press Z", width / 2, height / 5);
    if (keyPressed && keyCode == 90) {
      this.objectiveComplete = true;
      System.out.println("boop");
    }
    if (this.objectiveComplete) {
      background(0, 255, 0);
    }
    return "Playing...";
  }
}
