class Cyberspace extends MiniGame {
  
  Stars[] stars = new Stars[60];
  ArrayList<Targets> targets = new ArrayList<Targets>();
  ArrayList<Projectile> projectiles = new ArrayList<Projectile>();
  Shooter player;
  int position = 0;

  Cyberspace(boolean objStart, String name, double timerLength) {
    super(objStart, name, timerLength);
  }

  public void reset() {
    super.reset();
    // Put what your minigame needs to reset each time it is played here.
    
    for (int i = 0; i < stars.length; i++) {
        stars[i] = new Stars();
        stars[i].show();
    }
    
    targets.clear();
    
    for (int i = 0; i < 3; i++) {
        targets.add(new Targets(((i + 1) * (width / 4)) + random(0 - 30, 30), random((height / 10) + 30,(height / 2) - 60)));
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
        if (frameCount % 10 == 0) {
            projectiles.add(new Projectile(position));
        }
    }
    if (config.keys[1]) {
        position -= 20;
    }
    if (config.keys[3]) {
        position += 20;
    }
    
    player.show(position);
    
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
        vertex(this.posX - 3, this.posY);
        vertex(this.posX - 3, this.posY + 15);
        vertex(this.posX + 3, this.posY + 15);
        vertex(this.posX + 3, this.posY);
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
        vertex(this.posX - 15, y + 30);
        vertex(this.posX, y + 20);
        vertex(this.posX + 15, y + 30);
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
        if (random(1) < 0.001) {
            stroke(0);
        } else {
            stroke(100 + random(0 - 50, 50));
        }
        point(x, y);
    }
}

class Targets {
    
    int x, y;
    
    Targets(float x, float y) {
        this.x = (int)x;
        this.y = (int)y;
    }
    
    void show() {
        stroke(215, 0, 0);
        strokeWeight(5);
        fill(255, 0, 0);
        square(this.x, this.y, 60);
    }
    
    boolean collision(Projectile other) {
        if (this.x <= other.posX && this.y <= other.posY && this.x + 60 >= other.posX && this.y + 60 >= other.posY) {
            return true;
        } else {
            return false;
        }
    }
}
