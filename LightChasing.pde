class LightChasing extends MiniGame {

  Particles2[] particles = new Particles2[60];
  Cursor2 player;
  ArrayList<Panels2> panels = new ArrayList<Panels2>();

  boolean[] movement = {true, true};
  boolean result = true;
  boolean change = false;
  boolean initial = true;

  int index = 2;
  int place = index;
  int score = 0;
  int req = 6;
  int current = frameCount;

  int posX = 2 - index;

  color c = color(219, 229, 241);

  LightChasing(boolean objStart, String name, double timerLength) {
    super(objStart, name, timerLength);
  }

  public void reset() {
    super.reset();
    // Put what your minigame needs to reset each time it is played here.
    smooth();

    result = true;
    change = false;
    initial = true;
    index = 2;
    place = index;
    score = 0;
    req = 6;
    posX = 2 - index;
    c = color(219, 229, 241);

    current = frameCount;

    for (int i = 0; i < particles.length; i++) {
      particles[i] = new Particles2();
    }

    panels.clear();

    for (int i = 0; i < 5; i++) {
      if (i == index) {
        panels.add(new Panels2(i - 2, i, "Start"));
      } else {
        panels.add(new Panels2(i - 2, i, "Off"));
      }
    }

    player = new Cursor2();
  }

  public void play() {
    super.play();
    // Put your minigame logic here.
    background(c);

    for (int i = 0; i < particles.length; i++) {
      particles[i].show();
    }
    for (int i = 0; i < panels.size(); i++) {
      switch(panels.get(i).land(player, current, frameCount)) {
      case "Press" :
        if (initial) {
          score += 0;
          initial = false;
          result = false;
        } else {
          score += 1;
        }
        if (score < req) {
          change = true;
        } else {
          objectiveComplete = true;
          result = true;
          c = color(209, 255, 189);
        }
        break;
      }
      if (change) {
        switch(index) {
        case 0 :
          index = (int)random(1, panels.size());
          break;
        case 4 :
          index = (int)random(0, panels.size());
          break;
        default :
          if ((int)random(2) == 0) {
            index = (int)random(0, index);
          } else {
            index = (int)random(index + 1, panels.size());
          }
          break;
        }
        break;
      }
    }
    for (int i = 0; i < panels.size(); i++) {
      panels.get(i).show(change, index, result);
    }
    if (change) {
      change = false;
    }

    if (config.keys[1] && movement[0] && !result) {
      posX = max( -2, posX - 1);
      movement[0] = false;
    }
    if (!config.keys[1] && !movement[0] && !result) {
      movement[0] = true;
    }
    if (config.keys[3] && movement[1] && !result) {
      posX = min(posX + 1, 2);
      movement[1] = false;
    }
    if (!config.keys[3] && !movement[1] && !result) {
      movement[1] = true;
    }

    player.show(posX);
  }
}

class Cursor2 {

  int x, y, posX;

  void show(int posX) {

    x = (width / 2) + (posX * 190);
    y = (height / 2);

    noFill();
    stroke(255);
    strokeWeight(6);
    ellipse(x, y, 35, 35);
    noStroke();
    fill(255);
    ellipse(x, y, 15, 15);
  }
}

class Panels2 {
  int x, y, s, r, t, id;
  String stat;
  color c1, c2;

  Panels2(int x, int id, String stat) {
    this.x = (width / 2) + (x * 190);
    this.y = (height / 2);
    this.id = id;

    this.s = 160 / 2;
    this.r = 10;
    this.t = 0;

    this.c1 = color(199, 251, 244);
    this.c2 = color(113, 245, 251);

    this.stat = stat;
  }

  void show(boolean change, int start, boolean result) {
    switch(this.stat) {
    case "Start" :
      c1 = color(255, 249, 231);
      c2 = color(253, 241, 173);
      break;
    case "On" :
      c1 = color(221, 255, 119);
      c2 = color(187, 255, 119);
      break;
    default :
      this.c1 = color(199, 251, 244);
      this.c2 = color(113, 245, 251);
      if (change && this.id == start && !result) {
        c1 = color(221, 255, 119);
        c2 = color(187, 255, 119);
        this.stat = "On";
      }
      break;
    }
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
  }

  String land(Cursor2 other, int current, int count) {
    if (this.x - this.s <= other.x && this.y - this.s <= other.y && this.x + this.s >= other.x && this.y + this.s >= other.y) {
      switch(this.stat) {
      case "Start" :
        if (count - current >= 30) {
          this.stat = "Press";
        }
        break;
      case "On" :
        this.stat = "Press";
        break;
      case "Press" :
        this.stat = "Off";
        break;
      }
    } else {
      switch(this.stat) {
      case "Off":
        break;
      }
    }
    return this.stat;
  }
}

class Particles2 {
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
