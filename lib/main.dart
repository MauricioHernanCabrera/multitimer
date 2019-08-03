import 'package:flutter/material.dart';
import 'package:multitimer/screens/edit_timer.dart';
import 'package:multitimer/screens/home.dart';
import 'package:multitimer/screens/new_timer.dart';

void main() {
  runApp(MaterialApp(
    title: 'Multimer',
    initialRoute: '/',
    routes: {
      '/': (context) => HomeScreen(),
      '/new': (context) => NewTimerScreen(),
      '/edit': (context) => EditTimerScreen(),
    },
  ));
}


