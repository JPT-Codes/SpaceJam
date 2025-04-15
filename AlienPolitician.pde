class AlienPolitician extends MiniGame {

  AlienPolitician(boolean objStart, String name, double timerLength) {
    super(objStart, name, timerLength);
  }

  public void reset() {
    super.reset();
    // Put what your minigame needs to reset each time it is played here. 
  }

  public void play() {
    super.play();
    background(30,9,57);
    //we need the politician
    //do we use a rectangle? a circle that jump or "crouches" behind the podium?
    // it vanishes behind it
    fill(125);
    rect(1500, 710, 80, 240);
    fill(100, 57, 39); 
    rect(1400, 950, 1920, 1920);
  }
}
