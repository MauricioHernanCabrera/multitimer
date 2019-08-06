import 'dart:async';
import 'package:flutter/material.dart';
import 'package:multitimer/models/time.dart';
import 'package:multitimer/models/timer.dart';
import 'package:multitimer/screens/edit_timer.dart';
import 'package:vibration/vibration.dart';

class TimerItemComponent extends StatelessWidget {
  TimerModel timer;
  Function setTimer;
  Function removeTimer;
  int index;

  TimerItemComponent({
    this.timer,
    this.setTimer,
    this.index,
    this.removeTimer
  });

  bool timerFinished(TimeModel time) => (time.minutes <= 0 && time.seconds <= 0);

  void handleEditTimer (context) async {
    TimerModel timerUpdate = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditTimerScreen(timer: timer),
      ),
    ) as TimerModel;
    if (timerUpdate != null) {
      // setTimer(timer, index);
      print('Se actualizo');
    } else {
      print('No paso nada');
    }
  }

  void startTimer () {
    if (timerFinished(timer.time)) {
      restartTimer();
    } else {
      timer.active = true;
      timer.interval = new Timer.periodic(const Duration(seconds:1), (Timer t) {
        reduceTime();
      });
    }
    this.setTimer(timer, index);
  }

  void pauseTimer () {
    timer.active = false;
    timer.interval.cancel();
    this.setTimer(timer, index);
  }

  void restartTimer () {
    timer.time.minutes = timer.defaultTime.minutes;
    timer.time.seconds = timer.defaultTime.seconds;

    if (timer.interval is Timer) {
      timer.interval.cancel();
    }

    timer.active = false;
    timer.interval = null;
    this.setTimer(timer, index);
  }

  void reduceTime () async {
    int minutes = timer.time.minutes;
    int seconds = timer.time.seconds;
    
    if (timerFinished(timer.time)) {
      restartTimer();
      if (await Vibration.hasVibrator()) {
        Vibration.vibrate(pattern: [500, 1000, 500, 2000]);
      }
    } else {
      if (seconds == 0 && minutes > 0) {
        minutes--;
        seconds = 60;
      }

      seconds--;

      timer.time.minutes = minutes;
      timer.time.seconds = seconds;
    }

    this.setTimer(timer, index);
  }

  RaisedButton getButtonInitOrPause () {
    if (timer.active) {
      return RaisedButton(
        onPressed: pauseTimer,
        textColor: Colors.white,
        color: Color.fromRGBO(0, 0, 0, 0.15),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Color.fromRGBO(0, 0, 0, 0),
            width: 3.0
          ),
          borderRadius: BorderRadius.circular(5.0)
        ),
        child: Icon(
          Icons.pause,
          color: Colors.white,
          size: 32,
        ),
        elevation: 0,
      );
    } else {
      return RaisedButton(
        onPressed: startTimer,
        textColor: Colors.white,
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Color.fromRGBO(0, 0, 0, 0.15),
            width: 3.0
          ),
          borderRadius: BorderRadius.circular(5.0)
        ),
        child: Icon(
          Icons.play_arrow,
          color: Colors.white,
          size: 32,
        ),
        elevation: 0,
      );
    }
  }

  formatTime(TimeModel time) {
    return '${padTwo(time.minutes.toString())}m : ${padTwo(time.seconds.toString())}s';
  }

  padTwo(String str) {
    return str.length == 2? str : '0$str';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: timer.color,
        borderRadius: BorderRadius.circular(10.0)
      ),
      margin: EdgeInsets.only(
        top: 10.0
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Text(
                  timer.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.white
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.delete),
                    tooltip: 'Remove time',
                    color: Colors.white,
                    iconSize: 32.0,
                    onPressed: () async {
                      restartTimer();
                      removeTimer(index);
                      final snackBar = SnackBar(content: Text('Timer removed!'));
                      Scaffold.of(context).showSnackBar(snackBar);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    tooltip: 'Edit time',
                    color: Colors.white,
                    iconSize: 32.0,
                    disabledColor: Color.fromRGBO(0, 0, 0, 0.15),
                    onPressed: timer.active? null : () => handleEditTimer(context)
                  ),
                ],
              )
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                formatTime(timer.time),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.only(
              top: 10.0
            ),
            child: Row(
              children: <Widget>[
                RaisedButton(
                  onPressed: restartTimer,
                  textColor: Colors.white,
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Color.fromRGBO(0, 0, 0, 0.15),
                      width: 3.0
                    ),
                    borderRadius: BorderRadius.circular(5.0)
                  ),
                  child: Icon(
                    Icons.stop,
                    color: Colors.white,
                    size: 32,
                  ),
                  elevation: 0,
                ),
                Container(
                  margin: EdgeInsets.only(right: 10.0),
                  child: null
                ),
                getButtonInitOrPause()
              ],
            ),
          )
        ],
      ),
    );
  }
}
