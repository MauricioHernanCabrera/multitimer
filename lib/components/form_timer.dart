import 'package:flutter/material.dart';
import 'package:multitimer/components/select_color.dart';
import 'package:multitimer/components/select_duration.dart';

import 'package:multitimer/models/time.dart';
import 'package:multitimer/models/timer.dart';

class FormTimerComponent extends StatefulWidget {
  TimerModel timer;

  FormTimerComponent({
    Key key,
    this.timer = null,
  }): super(key: key);
  @override
  _FormTimerComponentState createState() => _FormTimerComponentState();
}

class _FormTimerComponentState extends State<FormTimerComponent> {
  String title;
  String btnSubmit;
  TimerModel timer;
  TextEditingController controller = new TextEditingController();

  void initState() {
    super.initState();
    setState(() {
      if (widget.timer == null) {
        title = 'New timer';
        btnSubmit = 'ADD';
        timer = TimerModel(
          title: '',
          time: TimeModel(minutes: 0, seconds: 0),
          defaultTime: TimeModel(minutes: 0, seconds: 0),
        );
      } else {
        title = 'Update timer';
        btnSubmit = 'UPDATE';
        timer = widget.timer;
      }
      controller.text = timer.title;
    });
  }

  void setColorActive (Color color) {
    setState(() {
      timer.color = color;
    });
  }


  void setMinuteActive (int number) {
    setState(() {
      timer.time.minutes = number;
    });
  }

  void setSecondActive (int number) {
    setState(() {
      timer.time.seconds = number;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,

      backgroundColor: Color.fromRGBO(240, 240, 240, 1.0),

      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color.fromRGBO(76, 76, 76, 1.0),
        ),
        title: Text(
          title,
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
          left: 10.0,
          right: 10.0,
          top: 10.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Title",
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
            Flexible(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Time of pizza'
                ),
                controller: controller,
                onChanged: (String str) {
                  setState(() {
                    timer.title = str;
                  });
                },
              ),
            ),


            Container(
              margin: EdgeInsets.only(
                top: 20.0,
                bottom: 10.0
              ),
              child: Text("Duration",
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ),
            SelectDurationComponent(
              numberActive: timer.time.minutes,
              title: 'Minutes',
              setNumberActive: setMinuteActive
            ),
            SelectDurationComponent(
              numberActive: timer.time.seconds,
              title: 'Seconds',
              setNumberActive: setSecondActive
            ),

            SelectColorComponent(
              colorActive: timer.color,
              setColorActive: setColorActive
            )
          ],
        ),
      ),

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Color.fromRGBO(221, 221, 221, 1.0),
              width: 2.0
            )
          )
        ),
        padding: EdgeInsets.only(
          left: 10.0,
          right: 10.0
        ),
        child: Row(
          children: <Widget>[
            FlatButton(
              onPressed: () {
                setState(() {
                  timer = TimerModel(
                    title: '',
                    time: TimeModel(minutes: 0, seconds: 0),
                    defaultTime: TimeModel(minutes: 0, seconds: 0),
                  );
                });
                controller.text = '';
              },
              child: Text(
                "RESET",
                style: TextStyle(
                  fontSize: 16.0,
                  color: Color.fromRGBO(76, 76, 76, 1.0)
                ),
              ),
            ),
            Expanded(child: Text(""), flex: 1),
            RaisedButton(
              onPressed: () {
                timer.defaultTime = TimeModel(
                  minutes: timer.time.minutes,
                  seconds: timer.time.seconds,
                );
                Navigator.pop(context, timer);
              },
              textColor: Colors.white,
              color: Color.fromRGBO(119, 119, 119, 1.0),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Color.fromRGBO(76, 76, 76, 1.0),
                  width: 3.0
                ),
                borderRadius: BorderRadius.circular(10.0)
              ),
              child: Text(
                btnSubmit,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold
                ),
              ),
              elevation: 0,
            ),
          ],
        )
      ),
    );
  }
}

