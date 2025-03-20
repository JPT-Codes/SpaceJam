class MiniGame {
    Config config = new Config();
    Timer timer = new Timer();
    boolean objectiveComplete;
    String name;
    double timerLength;
    
    MiniGame(boolean objComp, String name, double timerLength) {
        this.objectiveComplete = objComp;
        this.name = name;
        this.timerLength = timerLength;
    }
    
    public String play() {
        timer.startTimer(this.timerLength, config.miniTimerMult);
        if (timer.timerEnd) {
            if (objectiveComplete) {
                return "WIN";
            } else {
                return "LOSE";
            }
        }
        return "Playing...";
    }
}
