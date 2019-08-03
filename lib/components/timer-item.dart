import 'dart:async';
import 'package:flutter/material.dart';
import 'package:multitimer/models/time.dart';
import 'package:multitimer/models/timer.dart';

class TimerItemComponent extends StatelessWidget {
  TimerModel timer;
  Function setTimer;
  int index;

  TimerItemComponent({ this.timer, this.setTimer, this.index });

  bool timerFinished(TimeModel time) => (time.minutes <= 0 && time.seconds <= 0);

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

  void reduceTime () {
    int minutes = timer.time.minutes;
    int seconds = timer.time.seconds;

    if (timerFinished(timer.time)) {
      restartTimer();
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
        color: timer.color,
        child: Icon(
          Icons.pause,
          color: Colors.white,
          size: 32,
        )
      );
    } else {
      return RaisedButton(
        onPressed: startTimer,
        textColor: Colors.white,
        color: timer.color,
        child: Icon(
          Icons.play_arrow,
          color: Colors.white,
          size: 32,
        )
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
        bottom: 10.0
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
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    tooltip: 'Edit time',
                    color: Colors.white,
                    iconSize: 32.0,
                    onPressed: () {
                      Navigator.pushNamed(context, '/edit');
                    },
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
                  color: timer.color,
                  child: Icon(
                    Icons.stop,
                    color: Colors.white,
                    size: 32,
                  )
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
