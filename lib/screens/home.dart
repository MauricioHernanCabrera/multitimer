import 'package:flutter/material.dart';
import 'package:multitimer/components/timer_item.dart';
import 'package:multitimer/models/timer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List _timers = <TimerModel>[];

  void handleNewTimer () async {
    TimerModel timer = await Navigator.pushNamed(context, '/new') as TimerModel;
    if (timer != null) {
      _timers.add(timer);
    }
  }

  void setTimer (TimerModel timer, int index) {
    setState(() {
      _timers[index] = timer;
    });
  }

  void removeTimer (int index) {
    setState(() {
      _timers.removeAt(index); 
    });
  }

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(240, 240, 240, 1.0),
      appBar: AppBar(
        title: Text(
          'Multitimer',
          style: TextStyle(
            color: Color.fromRGBO(76, 76, 76, 1.0),
            fontSize: 28.0,
            fontWeight: FontWeight.bold
          ),
        ),
        elevation: 0.0,
        backgroundColor: Color.fromRGBO(240, 240, 240, 1.0),
        bottom: PreferredSize(
          child: Container(
            color: Color.fromRGBO(221, 221, 221, 1.0),
            height: 2.0,
          ),
          preferredSize: Size.fromHeight(2.0)
        ),
      ),



      body: Container(
        margin: EdgeInsets.only(
          // top: 10,
          left: 10,
          right: 10
        ),
        child: ListView(
          padding: EdgeInsets.only(
            bottom: 10
          ),
          children: List<TimerItemComponent>.generate(
            _timers.length,
            (i) => TimerItemComponent(
              timer: _timers[i],
              setTimer: setTimer,
              index: i,
              removeTimer: removeTimer
            )
          )
        ),
      ),



      floatingActionButton: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(119, 119, 119, 1.0),
          borderRadius: BorderRadius.circular(50.0),
          border: Border.all(
            color: Color.fromRGBO(76, 76, 76, 1.0),
            width: 3
          )
        ),
        padding: EdgeInsets.all(5.0),
        child: IconButton(
          icon: Icon(Icons.add),
          color: Colors.white,
          iconSize: 24.0,
          onPressed: handleNewTimer,
        ),
      )
    );
  }
}
