import 'package:flutter/material.dart';
import 'api.dart';
import 'upperWidget.dart';
import 'lowerWidget.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Weather",
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var upper;
  var lower;

  @override
  void initState() {
    super.initState();

    upper = fetchUpper();
    lower=fetchLower();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background.jpg"),
              fit: BoxFit.cover)),
      child: Column(
        children: <Widget>[
          FutureBuilder<Upper>(
            future: upper,
            builder: (context, snapshots) {
              if (snapshots.hasData) {
                return Container(
                  child: Column(
                    children: <Widget>[
                      UpperWidget(snapshots.data)
                      ],
                  ),
                );
              } else if (snapshots.hasError) {
                return Text("${snapshots.error}");
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
          FutureBuilder<List<Lower>>(
            future: lower,
            builder: (context,snapshots){
              if(snapshots.hasData){
                return  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: snapshots.data.map((currentDay){
                    return DayCard(currentDay.day,currentDay.temp[0].temperatureMax,currentDay.temp[0].temperatureMin);
                  }).toList(),
                );
              }else if (snapshots.hasError) {
                return Text("${snapshots.error}");
              }
              return CircularProgressIndicator();
            },
          )
        ],
      ),
    ));
  }
}
