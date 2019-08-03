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

  TimerModel({
    this.time,
    this.title,
    this.active = false,
    this.defaultTime,
    this.interval,
    this.color,
  });
}