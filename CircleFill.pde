class CircleFill extends MiniGame {
  private int act = 1;
  private int latch = 0;
  CircleFill(boolean objStart, String name, double timerLength) {
    super(objStart, name, timerLength);
  }

  public void reset() {
    super.reset();
    act = 1;
    // Put what your minigame needs to reset each time it is played here.
  }

  public void play() {
    super.play();
    // Put your minigame logic here.
    pushMatrix();
    translate(width/2, height/2);
    background(0);
    strokeWeight(16);
    noFill();
    textSize(50);
    text("MASH CTRL", -100, 0);
    stroke(random(255), random(255), random(255));
    keycheck();
    rotate(-HALF_PI);
    arc(0, 0, 800, 800, 0, radians(parseInt(act)*(360/20)));
    popMatrix();
  }
  void keycheck() {
    if (config.keys[0] == true && latch == 0){
      act += 1;
      latch = 1;
    } else if(!config.keys[0]) {
      latch = 0; 
    }
    if(act >= 21){
      text("YAY :)", -30, 100);
      objectiveComplete = true;
    } 
  }
}
