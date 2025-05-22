class MiniGames {
  MiniGame testGame = new TestGame(false, "testGame", 3000);
  MiniGame testYourStrength = new TestYourStrength(false, "testStrength", 3000);
  MiniGame alienLibrarian = new AlienLibrarian(false, "AlienLibrarian", 5000);
  MiniGame pressAllArrows = new PressAllArrows(false, "PressAllArrows", 5000);
  MiniGame cyberspace = new Cyberspace(false, "Cyberspace", 10000);
  MiniGame spaceShipDefense = new SpaceShipDefense(true, "SpaceShipDefense", 8000);
  MiniGame alienPolitician = new AlienPolitician(true, "AlienPolitician", 3000);
  MiniGame lightChallenge = new LightChallenge(false, "LightChallenge", 4000);
  MiniGame circleFill = new CircleFill(false, "CircleFill", 7000);
  MiniGame circleFill2 = new CircleFillV2(false, "CircleFill2", 7000);
  MiniGame alienalien = new AlienAlien(false, "AlienAlien", 6000);
  MiniGame lightchase = new LightChasing(false, "LightChase", 6000);
  MiniGame theClaw = new TheClaw(false, "TheClaw", 3000);
  MiniGame simonSays = new SimonSays(false, "SimonSays", 5000);
  MiniGame counter = new Counter(false, "Counter", 5000);
  MiniGame arrowOrder = new ArrowOrder(false, "ArrowOrder", 5000);
  int numOfGames = 16;
  int currentGame;
  MiniGame[] miniGames = {arrowOrder, counter, simonSays, lightchase, alienalien, testGame, testYourStrength, alienLibrarian, pressAllArrows, cyberspace, spaceShipDefense, alienPolitician, lightChallenge, circleFill, circleFill2, theClaw};
  ArrayList<String> recentGames = new ArrayList<String>();

  public void miniGameChooser() {
    int randGame;
    do {
      randGame = (int)random(numOfGames);
    } while (recentGames.contains(miniGames[randGame].name));
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
