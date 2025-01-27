class Splash {
  PImage img;
  int startTime;

  Splash() {
    img = loadImage("r.png"); // Fixed image path
    startTime = millis();
  }

  void display() {
    if (millis() - startTime < 1000) { // hard coded 500 millisecond
      image(img, width/3, height/3, img.width/4, img.height/4);
    }
  }
}
