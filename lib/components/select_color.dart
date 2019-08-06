import 'package:flutter/material.dart';

class SelectColorComponent extends StatelessWidget {
  List colors = [
    Color.fromRGBO(122, 199, 12, 1.0),
    Color.fromRGBO(28, 176, 246, 1.0),
    Color.fromRGBO(255, 176, 32, 1.0),
    Color.fromRGBO(250, 129, 27, 1.0),
    Color.fromRGBO(211, 49, 49, 1.0),
    Color.fromRGBO(133, 73, 186, 1.0),
    Color.fromRGBO(134, 78, 27, 1.0)
  ];

  Color colorActive;

  Function setColorActive;

  SelectColorComponent({
    this.colorActive,
    this.setColorActive,
  });

  Widget styleColorActive (Color color) {
    if (color == colorActive) {
      return Center(
        child: Container(
          child: Icon(
            Icons.check,
            color: Colors.white,
            size: 32.0,
          )
        ),
      );
    } else {
      return null;
    }
  }
  
  @override

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 10.0
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Color",
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
          Container(
            height: 100.0,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(
              top: 10.0,
              bottom: 10.0,
            ),

            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(
                colors.length,
                (i) => Container(
                  height: 100.0,
                  width: 100.0,
                  margin: EdgeInsets.only(
                    right: 10.0,
                  ),
                  decoration: BoxDecoration(
                    color: colors[i],
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(50.0),
                    child: styleColorActive(colors[i]),
                    onTap: () {
                      setColorActive(colors[i]);
                    },
                  ),
                )
              ),
            ),
          )

        ],
      ),
    );
  }
}