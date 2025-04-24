class SpaceShipDefense extends MiniGame {
  Timer timer = new Timer();
  int astronautX = 480;
  int astronautY = config.windowHeight/2;
  int astronautHeight = 100;
  int astronautWidth = 50;
  int asteroidsBlocked = 0;
  double astronautYSpeed = 0;
  int startupDelay = 0;
  Asteroids[] asteroids = new Asteroids[2];
  boolean shipDestroyed = false;

  SpaceShipDefense(boolean objStart, String name, double timerLength) {
    super(objStart, name, timerLength);
  }

  public void reset() {
    super.reset();
    astronautY = config.windowHeight/2;
    astronautYSpeed = 0;
    asteroidsBlocked = 0;
    startupDelay = 0;
    shipDestroyed = false;
  }

  public void play() {
    super.play();
    background(25);
    
    // Asteroid Creation
    if (startupDelay < asteroids.length) {
      for (int i = 0; i < asteroids.length; i++) {
        asteroids[i] = new Asteroids();
        asteroids[i].x += 100 * i;
        startupDelay += 1;
      }
    }
    
    // Movement
    if (!shipDestroyed && !objectiveComplete && keyPressed && key == CODED && keyCode == UP && astronautYSpeed >= -5) {
      astronautYSpeed -= 0.2;
    }

    if (!shipDestroyed && !objectiveComplete && keyPressed && key == CODED && keyCode == DOWN && astronautYSpeed <= 5) {
      astronautYSpeed += 0.2;
    }

    if (!keyPressed && astronautYSpeed > 0) {
      astronautYSpeed -= 0.1;
    } else if (!keyPressed && astronautYSpeed < 0) {
      astronautYSpeed += 0.1;
    }

    if (shipDestroyed || objectiveComplete) {
      if (!keyPressed && astronautYSpeed > 0) {
        astronautYSpeed -= 0.1;
      } else if (!keyPressed && astronautYSpeed < 0) {
        astronautYSpeed += 0.1;
      }
    }
    
    // Show Asteroids
    for (int i = 0; i < asteroids.length; i++) {
      asteroids[i].show();

      // Check If Ship Is Destroyed
      if (asteroids[i].x <= 200 && !asteroids[i].asteroidDestroyed) {
        asteroids[i].destroyShip();
        shipDestroyed = true;
      }
      
      // Block Asteroids
      if (asteroids[i].x - asteroids[i].radius <= astronautX
        && asteroids[i].x + asteroids[i].radius >= astronautX
        && asteroids[i].y - asteroids[i].radius <= astronautY
        && asteroids[i].y + asteroids[i].radius >= astronautY) {
        asteroids[i].destroyAsteroid();
        asteroidsBlocked++;
      }
    
      // Top and Bottom Walls
      if (astronautY + astronautHeight/2 > config.windowHeight) {
        astronautYSpeed = 0;
        astronautY = config.windowHeight - astronautHeight/2;
      } else if (astronautY - astronautHeight/2 < 0) {
        astronautYSpeed = 0;
        astronautY = astronautHeight/2;
      }
      
      // Create All Objects
      astronautY += astronautYSpeed;
      rectMode(CENTER);
      fill(0, 0, 150);
      rect(100, config.windowHeight/2, 200, config.windowHeight);
      fill(150, 0, 0);
      rect(astronautX, astronautY, astronautWidth, astronautHeight);
      ellipse(astronautX, astronautY, astronautWidth, astronautHeight);
    }
      
      // Complete Minigame
      if (asteroidsBlocked >= 2) {
        objectiveComplete = true;
      } else {
        objectiveComplete = false;
    }
  }
}


class Asteroids { // Math
  float speed = random(8, 10);
  float x = config.windowWidth + (200 * random(1, 8));
  float y = random(config.windowHeight);
  float targetX = 100;
  float targetY = random(config.windowHeight/6, 5 * config.windowHeight/6);
  float diffX = targetX - x;
  float diffY = targetY - y;
  float dist = sqrt((diffX * diffX) + (diffY * diffY));
  float dx = (speed / dist) * diffX;
  float dy = (speed / dist) * diffY;
  float radius = random(50, 100);
  boolean asteroidDestroyed = false;

  public void show() {
    if (!asteroidDestroyed) { // Make Asteroid Disappear
      fill(200);
      noStroke();
      circle(x, y, radius);
    } // Movement
    x += round(dx);
    y += round(dy);
  }

  public void destroyAsteroid() { // Destroy The Asteroid
    asteroidDestroyed = true;
    y = 2000;
  }

  public void destroyShip() { // Player Fails To Block Asteroid
    x = 2000;
    y = -2000;
    dx = 0;
    dy = 0;
  }
}
