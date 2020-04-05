import 'dart:async';
import 'package:darksky_weather/darksky_weather_io.dart';
import 'package:geolocator/geolocator.dart';
import 'days.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

var dayList = details();

class Upper {
  String summary;
  List<Placemark> placeName;
  int temp;
  Upper(this.summary, this.placeName, this.temp);
}

Future<Position> fetchLocation() async {
  return await Geolocator()
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
}

Future<Upper> fetchUpper(Position position) async {
  var darksky = new DarkSkyWeather(DotEnv().env['API_KEY'],
      language: Language.English, units: Units.Auto);

  var forecast = await darksky.getTimeMachineForecast(
      position.latitude, position.longitude, dayList[0].now);

  List<Placemark> placemark = await Geolocator()
      .placemarkFromCoordinates(position.latitude, position.longitude);

  return Upper(forecast.currently.summary, placemark,
      forecast.currently.temperature.toInt());
}

class Lower {
  String day;
  List<DailyDataPoint> temp;
  Lower(this.day, this.temp);
}

Future<List<Lower>> fetchLower(Position position) async {
  List<Lower> lowerList = [];

  var darksky = new DarkSkyWeather(DotEnv().env['API_KEY'],
      language: Language.English, units: Units.Auto);

  for (var i = 1; i < 7; i++) {
    var forecast = await darksky.getTimeMachineForecast(
        position.latitude, position.longitude, dayList[i].now);
    lowerList.add(Lower(dayList[i].day, forecast.daily.data));
  }
  return lowerList;
}
