class Cyberspace extends MiniGame {

  Stars[] stars = new Stars[60];
  ArrayList<Targets> targets = new ArrayList<Targets>();
  ArrayList<Projectile> projectiles = new ArrayList<Projectile>();
  Shooter player;
  int pos, proCount;

  int total = 5;

  Cyberspace(boolean objStart, String name, double timerLength) {
    super(objStart, name, timerLength);
  }

  public void reset() {
    super.reset();
    // Put what your minigame needs to reset each time it is played here.

    pos = 0;
    proCount = 0;

    for (int i = 0; i < stars.length; i++) {
      stars[i] = new Stars();
      stars[i].show();
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
      stars[i].blink();
    }
    for (int i = 0; i < projectiles.size(); i++) {
      projectiles.get(i).show();
      if (projectiles.get(i).status()) {
        projectiles.remove(i);
      }
    }
    for (int j = 0; j < targets.size(); j++) {
      targets.get(j).show();
      for (int i = 0; i < projectiles.size(); i++) {
        if (targets.get(j).collision(projectiles.get(i))) {
          targets.remove(j);
          projectiles.remove(i);
          break;
        }
      }
    }

    if (config.keys[0]) {
      if (proCount == 0 || proCount % 6 == 0) {
        projectiles.add(new Projectile(pos));
      }
      proCount += 1;
    }
    if (!config.keys[0]) {
      proCount = 0;
    }
    if (config.keys[1]) {
      pos -= 10;
    }
    if (config.keys[3]) {
      pos += 10;
    }

    player.show(pos);

    if (targets.size() == 0) {
      objectiveComplete = true;
    }
  }
}

class Projectile {

  int x = width / 2;
  int y = 14 * (height / 16);
  int posX, posY;

  Projectile(int posX) {
    this.posX = x + posX;
    this.posY = y;
  }

  void show() {
    noStroke();
    fill(255);
    beginShape();
    vertex(this.posX, this.posY);
    vertex(this.posX - 3, this.posY + 3);
    vertex(this.posX - 3, this.posY + 16);
    vertex(this.posX, this.posY + 19);
    vertex(this.posX + 3, this.posY + 16);
    vertex(this.posX + 3, this.posY + 3);
    endShape(CLOSE);
    this.posY -= 15;
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
  int posX;

  void show(int posX) {

    this.posX = x + posX;

    noStroke();
    fill(255);
    beginShape();
    vertex(this.posX, y);
    vertex(this.posX - 6.5, y + 15);
    vertex(this.posX - 15, y + 30);
    vertex(this.posX - 5, y + 23);
    vertex(this.posX, y + 26);
    vertex(this.posX + 5, y + 23);
    vertex(this.posX + 15, y + 30);
    vertex(this.posX + 6.5, y + 15);
    endShape(CLOSE);
  }
}

class Stars {

  int x = (int)random(10, width - 10);
  int y = (int)random(10, height - 10);

  void show() {
    strokeCap(PROJECT);
  }

  void blink() {
    strokeWeight(4);
    if (random(1) < 0.001) {
      stroke(0);
    } else {
      stroke(100 + random(0 - 50, 50));
    }
    point(x, y);
  }
}

class Targets {

  int x, y, s;

  Targets(float x, float y) {
    this.x = (int)x;
    this.y = (int)y;
    this.s = 65 / 2;
  }

  void show() {
    stroke(215, 0, 0);
    strokeWeight(5);
    fill(255, 0, 0);
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
}
