class CircleFillV2 extends MiniGame {
  private PShape scirc;
  private PShape wcirc;
  private PShape ecirc;
  private PShape ncirc;
  private int s = int(random(254));
  private int w = int(random(254));
  private int e = int(random(254));
  private int n = int(random(254));
  private int latch = 0;
  CircleFillV2(boolean objStart, String name, double timerLength) {
    super(objStart, name, timerLength);
  }

  public void reset() {
    super.reset();
    // Put what your minigame needs to reset each time it is played here.
    s = int(random(254));
    w = int(random(254));
    e = int(random(254));
    n = int(random(254));
  }

  public void play() {
    super.play();
    // Put your minigame logic here.
    pushMatrix();
    background(0);
    translate(width/2, height/2);
    scirc = createShape();
    beginShape();
    fill(255);
    arc(0, height/2, 200, 200, 0, 2*PI);
    beginContour();
    fill(s);
    stroke(0);
    arc(0, height/2, 199, 199, 0, 2*PI);
    endContour();
    endShape();
    //south shape creation
    wcirc = createShape();
    beginShape();
    fill(255);
    arc(-width/2, 0, 200, 200, 0, 2*PI);
    beginContour();
    fill(w);
    arc(-width/2, 0, 199, 199, 0, 2*PI);
    endContour();
    endShape();
    // west shape creation
    ecirc = createShape();
    beginShape();
    fill(255);
    arc(width/2, 0, 200, 200, 0, 2*PI);
    beginContour();
    fill(e);
    arc(width/2, 0, 199, 199, 0, 2*PI);
    endContour();
    endShape();
    //east shape creation
    ncirc = createShape();
    beginShape();
    fill(255);
    arc(0, -height/2, 200, 200, 0, 2*PI);
    beginContour();
    fill(n);
    stroke(0);
    arc(0, -height/2, 199, 199, 0, 2*PI);
    endContour();
    endShape();
    //north shape creation
    textSize(30);
    fill(255);
    text("Hold Direction and mash ctrl", -150, 0);
    keyCheck();
    detectOverFill();
    shape(scirc);
    shape(ncirc);
    shape(wcirc);
    shape(ecirc);
    popMatrix();
  }
  void keyCheck() {
    if (config.keys[0] == true && latch == 0 && config.keys[1] == true) {
      w += 20;
      latch = 1;
    } else if (config.keys[0] == true && latch == 0 && config.keys[2] == true) {
      n += 20;
      latch = 1;
    } else if (config.keys[0] == true && latch == 0 && config.keys[3] == true) {
      e += 20;
      latch = 1;
    } else if (config.keys[0] == true && latch == 0 && config.keys[4] == true) {
      s += 20;
      latch = 1;
    } else if (!config.keys[0]) {
      latch = 0;
    }
  }
  void detectOverFill() {
    if (w > 255) {
      w = 255;
      fill(#00FF00);
      textSize(30);
      text("FILLED", -width/2 + 200, 0);
    }
    if (n > 255) {
      n = 255;
      fill(#00FF00);
      textSize(30);
      text("FILLED", 0, -height/2 + 200);
    }
    if (e > 255) {
      e = 255;
      fill(#00FF00);
      textSize(30);
      text("FILLED", width/2 - 200, 0);
    }
    if (s > 255) {
      s  = 255;
      fill(#00FF00);
      textSize(30);
      text("FILLED", 0, height/2 - 200);
    }
    if (w == 255 && s == 255 && e == 255 && n == 255) {
      text("YAY :)", -30, 100);
      objectiveComplete = true;
    }
  }
}
