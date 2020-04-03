import 'package:flutter/material.dart';

class DayCard extends StatelessWidget {
  final day;
  final tempMax;
  final tempMin;
  DayCard(this.day, this.tempMax,this.tempMin);

  

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(day,style: TextStyle(
            fontFamily: "Roboto",
            fontSize:18,
            color: Colors.white54
          )),
          Text("${(tempMax+tempMin)~/2}"),
        ],
      ),
    );
  }
}
