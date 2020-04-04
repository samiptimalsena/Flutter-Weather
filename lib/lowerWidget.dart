import 'package:flutter/material.dart';

class DayCard extends StatelessWidget {
  final day;
  final tempMax;
  final tempMin;
  DayCard(this.day, this.tempMax,this.tempMin);
  
  

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    return Container(
      margin: new EdgeInsets.fromLTRB(0, height/2.05, 0, 0),
      child: Column(
        children: <Widget>[
          Text(day,style: TextStyle(
            fontFamily: "Montserrat",
            fontSize:15,
            color: Colors.white54
          )),
          Container(
            margin: const EdgeInsets.fromLTRB(8, 20, 0, 0),
            child:Text("${(tempMax+tempMin)~/2} ${String.fromCharCode(0x00B0)}",style: TextStyle(
            fontFamily: "Roboto",
            fontSize:18,
            color: Colors.white38
          )) ,)
          ,
        ],
      ),
    );
  }
}
