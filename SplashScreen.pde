class Splash {
  PImage img;
  int startTime;

  Splash() {
    startTime = millis();
  }

  void preload() {
    this.img = loadImage("r.png"); // Fixed image path
  }

  void display() {
    if (millis() - startTime < 1000) { // hard coded 1000 millisecond
      image(img, width/3, height/3, img.width/4, img.height/4);
    }
  }
}
