class TheClaw extends MiniGame {
  Ball ball = new Ball();
  Claw claw = new Claw();
  boolean clickOnce = true;

  TheClaw(boolean objStart, String name, double timerLength) {
    super(objStart, name, timerLength);
  }

  public void reset() {
    super.reset();
    clickOnce = true;
    
    ball.x = random(width/2 - ball.radius - 500, width/2 + ball.radius + 500);
    ball.speed = 20 * config.miniTimerMult;
    ball.randomDirection = (int)random(0, 2);
    ball.startDirection = true;
    ball.grabbed = false;
    ball.missed = false;
    
    claw.y = 3*height/4;
    claw.create = true;
    claw.grab = false;
  }

  public void play() {
    super.play();
    background(0);
    textSize(40);
    textAlign(CENTER);

    if (config.keys[0]) {
      claw.grab();
      if (ball.x > width/2 - 31.25 - ball.radius && ball.x < width/2 + 31.25 + ball.radius && clickOnce) {
        ball.grab();
        clickOnce = false;
      } else if (clickOnce) {
        ball.hahaMissed();
      }
    }

    ball.show();
    claw.show();
    if (ball.grabbed) {
      this.objectiveComplete = true;
    }
  }
}

class Ball {
  float radius = 50;
  float x = random(width/2 - radius - 500, width/2 + radius + 500);
  double speed = 20 * config.miniTimerMult;
  int randomDirection = (int)random(0, 2);
  boolean startDirection = true;
  boolean grabbed = false;
  boolean missed = false;

  public void grab() {
    speed = 0;
    x = width/2;
    grabbed = true;
  }

  public void hahaMissed() {
    speed = 0;
    missed = true;
  }

  public void show() {
    fill(255);
    if (missed) {
      text("HAHAHAHA", x, height/3 - radius * 1.5);
    } else if (grabbed) {
      text("LET GO OF ME!", x, height/3 - radius * 1.5);
    }
    
    if (startDirection == true && randomDirection == 0) {
      speed *= -1;
      startDirection = false;
    }

    circle(x, height/3, radius);
    x += speed;

    if (x < width/2 - radius - 500) {
      speed *= -1;
    } else if (x > width/2 + radius + 500) {
      speed *= -1;
    }
  }
}

class Claw {
  PShape claw;
  PShape clawClosed;
  float y = 3*height/4;
  boolean create = true;
  boolean grab = false;


  public void grab() {
    y = height/3 - 17.5;
    grab = true;
  }


  public void show() {
    if (create) {
      clawClosed = createShape();
      clawClosed.beginShape();
      clawClosed.fill(200);
      clawClosed.strokeWeight(2.5);
      clawClosed.vertex(0, 50);
      clawClosed.vertex(20, 35);
      clawClosed.vertex(30, 15);
      clawClosed.vertex(20, -5);
      clawClosed.vertex(5, -10);
      clawClosed.vertex(10, -30);
      clawClosed.vertex(30, -22.5);
      clawClosed.vertex(50, 15);
      clawClosed.vertex(37.5, 45);
      clawClosed.vertex(15, 60);
      clawClosed.vertex(15, 1080);
      clawClosed.vertex(-15, 1080);
      clawClosed.vertex(-15, 60);
      clawClosed.vertex(-37.5, 45);
      clawClosed.vertex(-50, 15);
      clawClosed.vertex(-30, -22.5);
      clawClosed.vertex(-10, -30);
      clawClosed.vertex(-5, -10);
      clawClosed.vertex(-20, -5);
      clawClosed.vertex(-30, 15);
      clawClosed.vertex(-20, 35);
      clawClosed.endShape(CLOSE);



      claw = createShape();
      claw.beginShape();
      claw.fill(200);
      claw.strokeWeight(2.5);
      claw.vertex(0, 50);
      claw.vertex(25, 40);
      claw.vertex(40, 30);
      claw.vertex(45, 10);
      claw.vertex(45, 0);
      claw.vertex(62.5, -2.5);
      claw.vertex(62.5, 12.5);
      claw.vertex(57.5, 35);
      claw.vertex(40, 50);
      claw.vertex(15, 60);
      claw.vertex(15, 1080);
      claw.vertex(-15, 1080);
      claw.vertex(-15, 60);
      claw.vertex(-40, 50);
      claw.vertex(-57.5, 35);
      claw.vertex(-62.5, 12.5);
      claw.vertex(-62.5, -2.5);
      claw.vertex(-45, 0);
      claw.vertex(-45, 10);
      claw.vertex(-40, 30);
      claw.vertex(-25, 40);
      claw.endShape(CLOSE);
    }

    if (!grab) {
      shape(claw, width/2, y);
    } else {
      shape(clawClosed, width/2, y);
    }
  }
}
