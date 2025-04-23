Config config;
UI ui;
Splash splash;
MiniGames gameList;
int scene = 1;

void settings() {
  fullScreen();
}

void setup() {
  config = new Config();
  ui= new UI();
  splash = new Splash();
  splash.preload();
  surface.setSize(config.windowWidth, config.windowHeight);
  gameList = new MiniGames();
  //surface.setLocation(0, 0);
}

void draw() {
  //TODO pull the SplashScreen class and display
  background(255);
  if (scene == 0) {
    splash.display();
  }
  //TODO pull the MainMenu class and display
  if (scene == 1) {
    gameList.startMiniGame();
    ui.showUI(gameList.miniGames[gameList.currentGame].timer);
  }
}
