class AilenLibrarian extends MiniGame {
  int foundBookYippee = (int) random(0, 5);
  boolean youAlreadyWentFool = false;
  //an array for colors and book names.
  color[] colors = {(color(255, 0, 0)), (color(0, 0, 255)), (color(0, 255, 0)), (color(255, 165, 0)), (color(255, 255, 0))};
  String[] bookNames = {"red", "blue", "green", "orange", "yellow"};
  String[] controls = {"CTRL", "LEFT", "UP", "RIGHT", "DOWN"};

  AilenLibrarian(boolean objStart, String name, double timerLength) {
    super(objStart, name, timerLength); 
  }

  public void reset() {
    super.reset();
    foundBookYippee = (int) random(5);
    youAlreadyWentFool = false;
  }

  public void play() {
    super.play();
    background(88, 57, 39);
    //this is our background
    stroke(131, 100, 62);
    strokeWeight(50);
    line(0, 21, 2000, 21);
    line(0, height/3, 2000, height/3);
    line(0, height/1.5, 2000, height/1.5);
    line(0, height -21, 1971, height -21);
    line(0, height/1.5, 2000, height/1.5);
    line(21, 0, 21, 1100);
    line(1899, 0, 1899, 1100);

    fill(0);
    textSize(75);
    text("Find the " + bookNames[foundBookYippee] + " book!", width/2, height/5);

    for (int i = 0; i < colors.length; i++) {
      fill(colors[i]);
      //makes 5 rect. how do we differentiate (hope i spelt right) the different "books"
      stroke(0);
      strokeWeight(1);
      rectMode(CENTER);
      rect(110 + i * 425, height/1.74, 100, 150);

      textAlign(CENTER);
      textSize(25);
      fill(0);
      text(controls[i], 110 + i * 425, height/1.74);
    }


    if (youAlreadyWentFool == false) {
      if ( config.keys[0] && foundBookYippee == 0) {
        this.objectiveComplete = true;
      } else if ( config.keys[1] && foundBookYippee == 1) {
        this.objectiveComplete = true;
      } else if ( config.keys[2] && foundBookYippee == 2) {
        this.objectiveComplete = true;
      } else if ( config.keys[3] && foundBookYippee == 3) {
        this.objectiveComplete = true;
      } else if ( config.keys[4] && foundBookYippee == 4) {
        this.objectiveComplete = true;
      } else if (!objectiveComplete) {
        this.objectiveComplete = false;
      }
      if (keyPressed) {
        youAlreadyWentFool = true;
      }
    }
    if (this.objectiveComplete == true) {
      background(0, 255, 0);
      textAlign(CENTER);
      fill(0);
      textSize(200);
      text("You WIN!!!", width/2, height /2 );
    }
    if (youAlreadyWentFool == true && this.objectiveComplete == false) {
      background(200, 0, 0);
      textAlign(CENTER);
      fill(0);
      textSize(200);
      text("You FAILED", width/2, height /2 );
    }
  }
}
