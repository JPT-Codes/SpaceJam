class LightChallenge extends MiniGame {

  Particles[] particles = new Particles[60];
  Cursor player;
  ArrayList<Panels> panels = new ArrayList<Panels>();

  boolean[] movement = {true, true, true, true};
  boolean result = false;

  int index = (int)random(9);
  int posX = (index % 3) - 1;
  int posY = (index / 3) - 1;
  int score = 9;

  color c = color(219, 229, 241);

  LightChallenge(boolean objStart, String name, double timerLength) {
    super(objStart, name, timerLength);
  }

  public void reset() {
    super.reset();
    // Put what your minigame needs to reset each time it is played here.
    smooth();

    if (result) {
      result = false;
      index = (int)random(9);
      posX = (index % 3) - 1;
      posY = (index / 3) - 1;
      score = 9;
      c = color(219, 229, 241);
    }

    for (int i = 0; i < particles.length; i++) {
      particles[i] = new Particles();

      panels.clear();
    }
    for (int j = 0; j < 3; j++) {
      for (int i = 0; i < 3; i++) {
        panels.add(new Panels(i - 1, j - 1, i + (j * 3), index, "Active"));
      }
    }
    if (index != 4) {
      score -= 1;
    }

    player = new Cursor();
  }

  public void play() {
    super.play();
    // Put your minigame logic here.
    background(c);

    for (int i = 0; i < particles.length; i++) {
      particles[i].show();
    }
    for (int i = 0; i < panels.size(); i++) {
      panels.get(i).show();
      switch(panels.get(i).land(player)) {
      case"Pressing" :
        score -= 1;
        break;
      case"Standing" :
        score += 0;
        break;
      case"Incorrect" :
        result = true;
        break;
      }
    }

    if (config.keys[1] && movement[0] && !result) {
      posX = max( -1, posX - 1);
      movement[0] = false;
    }
    if (!config.keys[1] && !movement[0] && !result) {
      movement[0] = true;
    }
    if (config.keys[2] && movement[1] && !result) {
      posY = max( -1, posY - 1);
      movement[1] = false;
    }
    if (!config.keys[2] && !movement[1] && !result) {
      movement[1] = true;
    }
    if (config.keys[3] && movement[2] && !result) {
      posX = min(posX + 1, 1);
      movement[2] = false;
    }
    if (!config.keys[3] && !movement[2] && !result) {
      movement[2] = true;
    }
    if (config.keys[4] && movement[3] && !result) {
      posY = min(posY + 1, 1);
      movement[3] = false;
    }
    if (!config.keys[4] && !movement[3] && !result) {
      movement[3] = true;
    }

    player.show(posX, posY);

    if (score == 0 || result) {
      result = true;
      if (score != 0) {
        c = color(252, 195, 204);
      } else {
        c = color(205, 226, 184);
        objectiveComplete = true;
      }
    }
    println(score);
  }
}

class Panels {

  int x, y, s, r, id, start;
  String stat;
  color c1, c2;

  Panels(int x, int y, int id, int start, String stat) {
    this.x = (width / 2) + (x * 190);
    this.y = (height / 2) + (y * 190);
    this.id = id;
    this.start = start;

    this.s = 160 / 2;
    this.r = 10;

    this.c1 = color(199, 251, 244);
    this.c2 = color(113, 245, 251);

    this.stat = stat;
  }

  void show() {
    stroke(this.c1);
    fill(this.c2);
    strokeWeight(6);
    beginShape();
    vertex(this.x + (this.s - this.r), this.y - this.s);
    vertex(this.x + this.s, this.y - (this.s - this.r));
    vertex(this.x + this.s, this.y + (this.s - this.r));
    vertex(this.x + (this.s - this.r), this.y + this.s);
    vertex(this.x - (this.s - this.r), this.y + this.s);
    vertex(this.x - this.s, this.y + (this.s - this.r));
    vertex(this.x - this.s, this.y - (this.s - this.r));
    vertex(this.x - (this.s - this.r), this.y - this.s);
    endShape(CLOSE);

    if (this.id == this.start) {
      beginShape();
      vertex(this.x, this.y - (this.s - 5));
      vertex(this.x + (this.s - 5), this.y);
      vertex(this.x, this.y + (this.s - 5));
      vertex(this.x - (this.s - 5), this.y);
      endShape(CLOSE);

      noStroke();
      fill(this.c1);
      beginShape();
      vertex(this.x, this.y - (this.s - 25));
      vertex(this.x + (this.s - 25), this.y);
      vertex(this.x, this.y + (this.s - 25));
      vertex(this.x - (this.s - 25), this.y);
      endShape(CLOSE);
    }

    if (this.id == 4 && this.start != 4) {
      this.c1 = color(10, 138, 203);
      this.c2 = color(11, 97, 202);
      this.stat = "Closed";
    }
  }

  String land(Cursor other) {
    if (this.x - this.s <= other.x && this.y - this.s <= other.y && this.x + this.s >= other.x && this.y + this.s >= other.y) {
      switch(this.stat) {
      case "Active" :
        this.c1 = color(10, 138, 203);
        this.c2 = color(11, 97, 202);
        this.stat = "Pressing";
        break;
      case "Pressing" :
        this.stat = "Standing";
        break;
      case "Closed" :
        this.stat = "Incorrect";
        break;
      }
    } else {
      switch(this.stat) {
      case "Active" :
        break;
      case "Standing" :
        this.stat = "Closed";
        break;
      case "Incorrect" :
        break;
      }
    }
    return this.stat;
  }
}

class Cursor {

  int x, y, posX, posY;

  void show(int posX, int posY) {

    x = (width / 2) + (posX * 190);
    y = (height / 2) + (posY * 190);

    noFill();
    stroke(230, 242, 129);
    strokeWeight(6);
    ellipse(x, y, 35, 35);
    noStroke();
    fill(251, 251, 251);
    ellipse(x, y, 15, 15);
  }
}

class Particles {

  float x = random(10, width - 10);
  float y = random(10, height - 10);

  void show() {
    noStroke();
    fill(255);
    rect(x, y, 3, 3);
    y -= 0.5;

    if (y <= -10) {
      x = random(10, width - 10);
      y = height + 10;
    }
  }
}
