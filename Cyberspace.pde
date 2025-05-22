class Cyberspace extends MiniGame {

  Stars[] stars = new Stars[60];
  ArrayList<Targets> targets = new ArrayList<Targets>();
  ArrayList<Projectile> projectiles = new ArrayList<Projectile>();
  Shooter player;
  int pos, proCount;

  int total = 5;
  int current = frameCount;

  String form = "Initial";
  boolean change = true;
  boolean posL = false;
  boolean posR = false;

  Cyberspace(boolean objStart, String name, double timerLength) {
    super(objStart, name, timerLength);
  }

  public void reset() {
    super.reset();
    // Put what your minigame needs to reset each time it is played here.

    pos = 0;
    proCount = 0;
    current = frameCount;
    form = "Initial";

    for (int i = 0; i < stars.length; i++) {
      stars[i] = new Stars();
    }

    targets.clear();

    for (int i = 0; i < total; i++) {
      targets.add(new Targets(((i + 1) * (width / (total + 1))) + random(0 - 25, 25), random((height / 10) + 25, (height / 2) - 50)));
    }

    player = new Shooter();
  }

  public void play() {
    super.play();
    // Put your minigame logic here.
    background(0);

    for (int i = 0; i < stars.length; i++) {
      stars[i].show(frameCount);
    }
    for (int i = 0; i < projectiles.size(); i++) {
      projectiles.get(i).show();
      if (projectiles.get(i).status()) {
        projectiles.remove(i);
      }
    }
    for (int j = 0; j < targets.size(); j++) {
      targets.get(j).show(frameCount, j, targets.size());
      for (int i = 0; i < projectiles.size(); i++) {
        if (targets.get(j).collision(projectiles.get(i))) {
          if (targets.get(j).check(projectiles.get(i))) {
            targets.remove(j);
          }
          projectiles.remove(i);
          break;
        }
      }
    }

    if (config.keys[0]) {
      if (change) {
        switch(form) {
        case "Light" :
          form = "Dark";
          break;
        case "Dark" :
          form = "Light";
          break;
        default :
          form = "Light";
          break;
        }
      }
      change = false;
      if (proCount == 0 || proCount % 5 == 0) {
        projectiles.add(new Projectile(pos, form));
      }
      proCount += 1;
    }
    if (!config.keys[0]) {
      change = true;
      proCount = 0;
    }
    if (config.keys[1] && !config.keys[3]) {
      pos -= 13;
      posL = true;
    } else if (!config.keys[1] && config.keys[3]) {
      pos += 13;
      posR = true;
    } else if (config.keys[1] && config.keys[3]) {
      if (posL) {
        pos += 13;
      }
      if (posR) {
        pos -= 13;
      }
    } else {
      pos += 0;
    }

    player.show(pos, form);

    if (targets.size() == 0) {
      objectiveComplete = true;
    }
  }
}

class Projectile {

  int x = width / 2;
  int y = 14 * (height / 16) - 19;
  String f;
  int posX, posY;

  Projectile(int posX, String f) {
    this.posX = x + posX;
    this.posY = y;
    this.f = f;
  }

  void show() {
    noStroke();
    switch(this.f) {
    case "Light" :
      fill(255);
      break;
    case "Dark" :
      fill(255, 0, 0);
      break;
    }
    beginShape();
    vertex(this.posX, this.posY - 19);
    vertex(this.posX - 3, this.posY - 16);
    vertex(this.posX - 3, this.posY + 16);
    vertex(this.posX, this.posY + 19);
    vertex(this.posX + 3, this.posY + 16);
    vertex(this.posX + 3, this.posY - 16);
    endShape(CLOSE);
    this.posY -= 19;
  }

  boolean status() {
    if (this.y + 30 < 0) {
      return true;
    } else {
      return false;
    }
  }
}

class Shooter {

  int x = width / 2;
  int y = 14 * (height / 16);
  String f;
  color c;
  int posX;

  void show(int posX, String f) {

    this.posX = x + posX;
    this.f = f;

    switch(this.f) {
    case "Light" :
      this.c = color(113, 245, 251);
      break;
    case "Dark" :
      this.c = color(255, 0, 0);
      break;
    default :
      this.c = color(155);
      break;
    }

    noStroke();

    fill(this.c);
    beginShape();
    vertex(this.posX, y - 25);
    vertex(this.posX - 4.5, y);
    vertex(this.posX + 4.5, y);
    endShape(CLOSE);

    fill(this.c);
    beginShape();
    vertex(this.posX - 10, y + 19);
    vertex(this.posX, y + 30);
    vertex(this.posX + 10, y + 19);
    endShape(CLOSE);

    fill(this.c);
    beginShape();
    vertex(this.posX - 12.5, y + 18.5);
    vertex(this.posX - 13.5, y + 27.5);
    vertex(this.posX - 19, y + 30);
    vertex(this.posX - 15.5, y + 23);
    vertex(this.posX - 8.5, y + 24.5);
    endShape(CLOSE);

    fill(this.c);
    beginShape();
    vertex(this.posX + 12.5, y + 18.5);
    vertex(this.posX + 13.5, y + 27.5);
    vertex(this.posX + 19, y + 30);
    vertex(this.posX + 15.5, y + 23);
    vertex(this.posX + 8.5, y + 24.5);
    endShape(CLOSE);

    fill(255);
    beginShape();
    vertex(this.posX, y - 6);
    vertex(this.posX - 3, y - 10);
    vertex(this.posX - 7.5, y + 9);
    vertex(this.posX - 13, y + 19);
    vertex(this.posX - 9, y + 25);
    vertex(this.posX, y + 21);
    vertex(this.posX + 9, y + 25);
    vertex(this.posX + 13, y + 19);
    vertex(this.posX + 7.5, y + 9);
    vertex(this.posX + 3, y - 10);
    endShape(CLOSE);

    fill(this.c);
    beginShape();
    vertex(this.posX, y - 5.5);
    vertex(this.posX - 3.5, y + 9);
    vertex(this.posX - 9.5, y + 21.5);
    vertex(this.posX, y + 16.5);
    vertex(this.posX + 9.5, y + 21.5);
    vertex(this.posX + 3.5, y + 9);
    endShape(CLOSE);

    fill(255);
    beginShape();
    vertex(this.posX, y + 9.5);
    vertex(this.posX - 3, y + 14.5);
    vertex(this.posX + 3, y + 14.5);
    endShape(CLOSE);
  }
}

class Stars {

  int x = (int)random(10, width - 10);
  int y = (int)random(10, height - 10);
  float blink;

  void show(int count) {

    strokeWeight(4);
    if (count % 5 == 0) {
      if (random(1) < 0.001) {
        blink = 0;
      } else {
        blink = 100 + random(0 - 50, 50);
      }
    }
    stroke(blink);
    blink = max(0, blink - 5);
    point(x, y);
  }
}

class Targets {

  int x, y, s, c;
  String f;
  color[] c1 = {color(199, 251, 244), color(215, 0, 0)};
  color[] c2 = {color(113, 245, 251), color(255, 0, 0)};

  Targets(float x, float y) {
    this.x = (int)x;
    this.y = (int)y;
    this.s = 65 / 2;
    this.c = (int)random(2);
  }

  void show(int count, int id, int amount) {
    if (count % 120 == 0 && count > 0) {
      this.x = (int)(((id + 1) * (width / (amount + 1))) + random(0 - 25, 25));
      this.y = (int)(random((height / 10) + 25, (height / 2) - 50));
      this.c = (int)random(2);
    }
    if (this.c == 0) {
      this.f = "Light";
    } else {
      this.f = "Dark";
    }

    stroke(c1[this.c]);
    strokeWeight(5);
    fill(c2[this.c]);
    rectMode(CENTER);
    rect(this.x, this.y, this.s * 2, this.s * 2);

    for (int i = 0; i < 3; i++) {
      if (i == 0) {
        strokeWeight(3);
      } else if (i == 1) {
        strokeWeight(0);
        fill(0);
      } else {
        fill(255);
      }

      beginShape();
      vertex(this.x - this.s + (i * 13), this.y);
      vertex(this.x, this.y - this.s + (i * 13));
      vertex(this.x + this.s - (i * 13), this.y);
      vertex(this.x, this.y + this.s - (i * 13));
      endShape(CLOSE);
    }
  }

  boolean collision(Projectile other) {
    if (this.x - this.s <= other.posX && this.y - this.s <= other.posY && this.x + this.s >= other.posX && this.y + this.s >= other.posY) {
      return true;
    } else {
      return false;
    }
  }

  boolean check(Projectile other) {
    if (this.f.equals(other.f)) {
      return true;
    } else {
      return false;
    }
  }
}
