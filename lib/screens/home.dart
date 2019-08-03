import 'package:flutter/material.dart';
import 'package:multitimer/components/timer-item.dart';
import 'package:multitimer/models/time.dart';
import 'package:multitimer/models/timer.dart';


class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List _timers = <TimerModel>[
    TimerModel(
      title: 'Huevo',
      time: TimeModel(minutes: 1, seconds: 0),
      defaultTime: TimeModel(minutes: 1, seconds: 0),
      interval: null,
      color: Color.fromRGBO(122, 199, 12, 1.0)
    ),
    TimerModel(
      title: 'Pizza masa',
      time: TimeModel(minutes: 0, seconds: 30),
      defaultTime: TimeModel(minutes: 0, seconds: 30),
      interval: null,
      color: Color.fromRGBO(28, 176, 246, 1.0)
    ),
    TimerModel(
      title: 'Hamburguesa',
      time: TimeModel(minutes: 0, seconds: 30),
      defaultTime: TimeModel(minutes: 0, seconds: 30),
      interval: null,
      color: Color.fromRGBO(255, 176, 32, 1.0)
    ),
    TimerModel(
      title: 'Hamburguesa',
      time: TimeModel(minutes: 0, seconds: 30),
      defaultTime: TimeModel(minutes: 0, seconds: 30),
      interval: null,
      color: Color.fromRGBO(250, 129, 27, 1.0)
    ),
    TimerModel(
      title: 'Hamburguesa',
      time: TimeModel(minutes: 0, seconds: 30),
      defaultTime: TimeModel(minutes: 0, seconds: 30),
      interval: null,
      color: Color.fromRGBO(211, 49, 49, 1.0)
    ),
    TimerModel(
      title: 'Hamburguesa',
      time: TimeModel(minutes: 0, seconds: 30),
      defaultTime: TimeModel(minutes: 0, seconds: 30),
      interval: null,
      color: Color.fromRGBO(133, 73, 186, 1.0)
    ),
    TimerModel(
      title: 'Hamburguesa',
      time: TimeModel(minutes: 0, seconds: 30),
      defaultTime: TimeModel(minutes: 0, seconds: 30),
      interval: null,
      color: Color.fromRGBO(134, 78, 27, 1.0)
    ),
  ];

  void setTimer (TimerModel timer, int index) {
    setState(() {
      _timers[index] = timer;
    });
  }

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Multitimer',
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: ListView(
          // children: <Widget>[
          //   TimerItemComponent(timer: _timer, setTimer: setTimer)
          // ],
          children: List<TimerItemComponent>.generate(
            _timers.length,
            (i) => TimerItemComponent(timer: _timers[i], setTimer: setTimer, index: i)
          )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/new');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
