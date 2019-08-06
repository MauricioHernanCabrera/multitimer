import 'package:flutter/material.dart';

class SelectDurationComponent extends StatelessWidget {
  List numbers = [
    0,1,2,3,4,5,6,7,8,9,
    10,11,12,13,14,15,16,17,18,19,
    20,21,22,23,24,25,26,27,28,29,
    30,31,32,33,34,35,36,37,38,39,
    40,41,42,43,44,45,46,47,48,49,
    50,51,52,53,54,55,56,57,58,59,
  ];
  int numberActive;
  Function setNumberActive;
  String title;

  SelectDurationComponent({
    this.title = 'Placeholder',
    this.numberActive = 1,
    this.setNumberActive,
  });

  BoxDecoration styleNumberActive (int index) {
    if (index == numberActive) {
      return BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.blueAccent,
            width: 2
          )
        )
      );
    } else {
      return null;
    }
  }

  @override

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 10.0
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 10.0
              ),
            ),
          ),
          Container(
            height: 48.0,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(
                numbers.length,
                (i) => Container(
                  child: InkWell(
                    child: Container(
                      padding: EdgeInsets.only(
                        top: 15.0,
                        bottom: 15.0,
                        left: 15.0,
                        right: 15.0,
                      ),
                      decoration: styleNumberActive(i),
                      child: Text(
                        "${numbers[i]}",
                        style: TextStyle(
                          fontSize: 16.0
                        )
                      )
                    ),
                    onTap: () {
                      setNumberActive(i);
                    },
                  ),
                )
              ),
            ),
          )
        ],
      ),
    );
    // return Flexible(
    //   child: Container(
    //     decoration: BoxDecoration(
    //       color: Colors.red,
    //     ),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         Container(
    //           decoration: BoxDecoration(
    //             color: Colors.blue,
    //           ),
    //           margin: EdgeInsets.only(
    //             top: 10.0
    //           ),
    //           child: Text(
    //             title,
    //             style: TextStyle(
    //               fontSize: 10.0
    //             ),
    //           ),
    //         ),
            // ListView(
            //   scrollDirection: Axis.horizontal,
            //   children: List.generate(
            //     numbers.length,
            //     (i) => Container(
            //       decoration: BoxDecoration(
            //         color: Colors.blue,
            //       ),
            //       child: InkWell(
            //         child: Container(
            //           decoration: BoxDecoration(
            //             color: Colors.green
            //           ),
            //           padding: EdgeInsets.all(10.0),
            //           // decoration: styleNumberActive(i),
            //           child: Text(
            //             "${numbers[i]}",
            //             style: TextStyle(
            //               fontSize: 16.0
            //             )
            //           )
            //         ),
            //         onTap: () {
            //           setNumberActive(i);
            //         },
            //       ),
            //     )
            //   ),
            // )
    //       ],
    //     ),
    //   )
    // );

  }
}