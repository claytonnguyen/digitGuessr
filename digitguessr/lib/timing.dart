import 'dart:async';

class Timing{
  final seconds;
  var timeLeft;
  Function getTimeLeft;
  Function callback;
  bool cancel = false;
  Timing({required this.seconds, required this.callback, required this.getTimeLeft}){
    var timeLeft = seconds;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if(!cancel){
        //print(timer.tick);
        //print('seconds left: ${seconds - timer.tick}');
        timeLeft = (seconds + 1) - timer.tick;
        timeLeft--;
        getTimeLeft(timeLeft);
        if (timeLeft == 0) {
          //print('Cancel timer from no time');
          callback();
          timer.cancel();
        }
      } else {
        timer.cancel();
        //print('Cancel timer from user input');
      }
    });
  }
  stop(){
    //print('canceling timer');
    cancel = true;
  }
}
