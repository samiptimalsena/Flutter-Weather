import 'dart:async';
import 'package:darksky_weather/darksky_weather_io.dart';
import 'package:geolocator/geolocator.dart';
//import 'days.dart';

class Album {
  String summary;
  List<Placemark> placeName;
  int temp;
  Album(this.summary,this.placeName,this.temp);
}

Future<Album> fetchAlbum() async {
  //var dayList = details();
  Position position = await Geolocator()
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  var darksky = new DarkSkyWeather("13f7dd369b83ddedb72bc4e38f67bd60",
      language: Language.English, units: Units.Auto);
  var forecast = await darksky.getTimeMachineForecast(
      position.latitude, position.longitude, DateTime.parse("2020-04-01"));

  List<Placemark> placemark = await Geolocator()
      .placemarkFromCoordinates(position.latitude, position.longitude);

  return Album(forecast.currently.summary,placemark,forecast.currently.temperature.toInt());
}
