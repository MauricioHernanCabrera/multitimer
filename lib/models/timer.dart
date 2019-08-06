import 'package:flutter/material.dart';

import './time.dart';
import 'dart:async';

class TimerModel {
  TimeModel time;
  TimeModel defaultTime;
  String title;
  bool active;
  Timer interval;
  Color color;
  int id = DateTime.now().millisecondsSinceEpoch;

  TimerModel({
    this.time,
    this.title,
    this.active = false,
    this.defaultTime,
    this.interval = null,
    this.color = const Color.fromRGBO(122, 199, 12, 1.0),
  });
}