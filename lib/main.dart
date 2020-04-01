import 'package:flutter/material.dart';
import 'api.dart';

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
  var futureAlbum;

  @override
  void initState() {
    super.initState();

    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Weather"),
        ),
        body:Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.jpg"),
              fit: BoxFit.cover
            )
          ),
          child:Column(
            //crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
           FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshots) {
              if (snapshots.hasData) {
                return Container(
                  child: Column(
                    children: <Widget>[
                      Text("${snapshots.data.temp}"),
                      Text(snapshots.data.summary),
                      Text("${snapshots.data.time}"),
                      Text("${snapshots.data.placemark[0].name}")
                    ],
                  ),
                );
              } else if (snapshots.hasError) {
                return Text("${snapshots.error}");
              }
              return CircularProgressIndicator();
            },
          ),
        ],)  ,
        )
        
        );
  }
}
