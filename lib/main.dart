import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'api.dart';
import 'upperWidget.dart';
import 'lowerWidget.dart';

Future main() async {
  await DotEnv().load('.env');
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
  Position position;

  Future<Position> initialize() async {
    position = await fetchLocation();
    return position;
  }

  @override
  void initState() {
    super.initState();
    initialize().then((result) {
      setState(() {
        upper = fetchUpper(result);
        lower = fetchLower(result);
      });
    });
  }

  Future<Null> refreshList() async {
    await new Future.delayed(new Duration(seconds: 3));
    position = await fetchLocation();
    setState(() {
      upper = fetchUpper(position);
      lower = fetchLower(position);
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: (DateTime.now().hour < 6 || DateTime.now().hour > 18)
                  ? AssetImage("assets/images/night.jpg")
                  : AssetImage("assets/images/day.jpg"),
              fit: BoxFit.cover)),
      child: RefreshIndicator(
        onRefresh: refreshList,
        child: ListView(
          children: <Widget>[
            FutureBuilder<Upper>(
              future: upper,
              builder: (context, snapshots) {
                if (snapshots.hasData) {
                  return Container(
                    child: Column(
                      children: <Widget>[UpperWidget(snapshots.data)],
                    ),
                  );
                } else if (snapshots.hasError) {
                  return Text("${snapshots.error}");
                }
                return Container();
              },
            ),
            FutureBuilder<List<Lower>>(
              future: lower,
              builder: (context, snapshots) {
                if (snapshots.hasData) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: snapshots.data.map((currentDay) {
                      return DayCard(
                          currentDay.day,
                          currentDay.temp[0].temperatureMax,
                          currentDay.temp[0].temperatureMin);
                    }).toList(),
                  );
                } else if (snapshots.hasError) {
                  return Text("${snapshots.error}");
                }
                return Column(
                  children: <Widget>[CircularProgressIndicator()],
                );
              },
            )
          ],
        ),
      ),
    ));
  }
}
