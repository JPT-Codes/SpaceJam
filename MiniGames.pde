class MiniGames {
  MiniGame testGame = new TestGame(false, "testGame", 3000);
  MiniGame testYourStrength = new TestYourStrength(false, "testStrength", 3000);
  MiniGame alienLibrarian = new AlienLibrarian(false, "AlienLibrarian", 5000);
MiniGame pressAllArrows = new PressAllArrows(false, "PressAllArrows", 5000);
  MiniGame cyberspace = new Cyberspace(false, "Cyberspace", 10000); 
  int numOfGames = 4;
  int currentGame;
  MiniGame[] miniGames = {cyberspace, testGame, testYourStrength, alienLibrarian, pressAllArrows};
  ArrayList<String> recentGames = new ArrayList<String>();

  public void miniGameChooser() {
    int randGame;
    do {
      randGame = (int)random(numOfGames);
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
