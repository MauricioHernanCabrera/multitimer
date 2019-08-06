import 'package:flutter/material.dart';
import 'package:multitimer/components/form_timer.dart';
import 'package:multitimer/models/timer.dart';

class EditTimerScreen extends StatelessWidget {
  @override
  TimerModel timer;
  EditTimerScreen({ this.timer });

  Widget build(BuildContext context) {
    return FormTimerComponent(timer: timer);
  }
}