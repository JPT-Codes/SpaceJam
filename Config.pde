public int windowWidth = 1920;
public int windowHeight = 1080;
public int lives = 3;
public int score = 0;

public void minigameResults (String winLose) {
  if (winLose.equalsIgnoreCase("WIN")) {
    score++;
    // TODO play animation and sound
    // TODO show lives (may change later)
    // TODO start next minigame
  } else if (winLose.equalsIgnoreCase("LOSE")) {
    lives--;
    // TODO play animation and sound
    // TODO remove 1 lives icon from top, maybe tie the images to the lives variable
    // TODO start next minigame
  } else {
    println("Something Broke...");
  } //This should be called whenever a Minigame finishes with whether or not they lost as a string or "win" or "lose"
  //Unfinished
}
