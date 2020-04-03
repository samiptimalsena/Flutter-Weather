import 'package:flutter/material.dart';


class UpperWidget extends StatelessWidget {
  final data;
  UpperWidget(this.data);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top:100),
            child: Text(data.summary,style: TextStyle(
              color: Colors.white70,
              fontFamily:'Montserrat',
              fontSize: 40,
              fontWeight: FontWeight.w400
              ),
              ) ,
          ),
           Container(
            margin: const EdgeInsets.only(top:10),
            child: Text("${data.placeName[0].locality}",style: TextStyle(
              color: Colors.white54,
              fontFamily:"Roboto",
              fontSize:17 ,
              fontWeight: FontWeight.w400
              ),
              ) ,
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(30, 15, 0, 0),
            child: Text("${data.temp} ${String.fromCharCode(0x00B0)}",style: TextStyle(
              color: Colors.white70,
              fontFamily:"Roboto",
              fontSize:90 ,
              fontWeight: FontWeight.w400
              ),
              ) ,
          ),
        ],
      ),
    );
  }
}


