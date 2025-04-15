class MiniGames {
  TestGame testGame = new TestGame(false, "testGame", 3000);
  int numOfGames = 1;
  int currentGame;
  MiniGame[] miniGames = {testGame};
  ArrayList<String> recentGames = new ArrayList<String>();

  public void miniGameChooser() {
    int randGame;
    do {
      randGame = (int)random(numOfGames - 1);
    } while (/*recentGames.contains(miniGames[randGame].name*/ false);
    recentGames.add(miniGames[randGame].name);
    this.purgeRecentGames();
    currentGame = randGame;
  }

  public void purgeRecentGames() {
    if (recentGames.size() > 3) {
      recentGames.remove(0);
    }
  }

  public void startMiniGame() {
    if (!config.inMiniGame()) {
      config.currentFloor++;
      miniGameChooser();
      miniGames[currentGame].reset();
    } else {
      miniGames[currentGame].play();
    }
  }
}
