public class Timer {
  long tickTime;
  long secondsTime;
  long endTime;
  double end;
  int seconds = 1000;
  int tick = 500;
  int timeLeft;
  boolean timerEnd = false;
  boolean timerStart = true;

  void startTimer(double miniTimerConst, double miniTimerMult) {
    // miniTimerCost is how long you want your minigame to last, in milliseconds
    //miniTimerMult shouldn't be set when calling this, it should be a variable from another class (probably Config) TBD
    if (miniTimerMult < 1) {
      miniTimerMult = 1;
    } else if (miniTimerMult > 2) {
      miniTimerMult = 2;
    } // makes sure that the multiplier can't be less than 1 or greater than 2

    if (timerStart) {
      end = miniTimerConst / miniTimerMult; //Apply Time Left Multiplier
      timeLeft = (int) Math.round(end/1000); //Set time to Seconds instead of Milliseconds
      tickTime = millis();
      secondsTime = millis();
      endTime = millis();
      println(timeLeft);
      timerStart = false;
    } //Starts Timers

    if (millis() - secondsTime >= seconds && !timerEnd) {
      timeLeft--;
      println(timeLeft); //Bomb Display
      secondsTime = millis(); //Reset Every Second
    }

    if (millis() - tickTime >= tick && !timerEnd) {
      println("tick"); //Fuse Tick
      tickTime = millis();
    }

    if (millis() - endTime >= end && !timerEnd) {
      println("Time's Up!"); //Bomb Explodes
      timerEnd = true;
    }
  }
}
// Currently only prints the timer, need to change
// to updating the shown Timer later
