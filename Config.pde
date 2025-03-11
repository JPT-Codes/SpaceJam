class Config {
  public int windowWidth = 1920;
  public int windowHeight = 1080;
  public int lives = 3;
  public int speedUp = 0;
  public double miniTimerMult = 1;
  public int score = 0;

  public void minigameResults (String winLose) {
    if (winLose.equalsIgnoreCase("WIN")) {
      score++;
      if (score - speedUp == 10){
        miniTimerMult += 0.2;
        speedUp = score;
      }
    } else if (winLose.equalsIgnoreCase("LOSE")) {
      lives--;
      // TODO remove 1 lives icon from top
      // TODO start next minigame
    } else {
      println("Something Broke...");
    } //This should be called whenever a Minigame finishes with whether or not they lost as a string of "win" or "lose"
    //Unfinished
  }
}
