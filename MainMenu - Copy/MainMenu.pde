import processing.core.PApplet;
import processing.core.PImage;

public class MainMenu extends PApplet {

    PImage splashImage;
    String companyName = "RockStar V2";
    int splashScreenDuration = 3000;
    int splashStartTime;

    public static void main(String[] args) {
        PApplet.main("MainMenu");
    }

    public void settings() {
        size(800, 600);
    }

    public void setup() {
        splashImage = loadImage("placeholder.png");
        splashStartTime = millis();
        textAlign(CENTER, CENTER);
        textSize(40);
        fill(255);
    }

    public void draw() {
        background(0);

        // Display splash screen
        if (millis() - splashStartTime < splashScreenDuration) {
            image(splashImage, width / 2 - splashImage.width / 2, height / 2 - splashImage.height / 2);
            text(companyName, width / 2, height / 4);
        } else {
            displayMainMenu();
        }
    }

    void displayMainMenu() {
        background(0);
        text("Main Menu", width / 2, height / 2);
        // Add more main menu options and interactions here
    }
}
