import 'dart:async';
import 'package:darksky_weather/darksky_weather_io.dart';
import 'package:geolocator/geolocator.dart';

class Album {
  final double temp;
  final String summary;
  String time;
  List<Placemark> placemark;
  Album(this.temp, this.summary, this.time, this.placemark);
}


Future<Album> fetchAlbum() async {
  Position position = await Geolocator()
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  var darksky = new DarkSkyWeather("13f7dd369b83ddedb72bc4e38f67bd60",
      language: Language.English, units: Units.Auto);
  var forecast =
      await darksky.getForecast(position.latitude, position.longitude);
  List<Placemark> placemark = await Geolocator()
      .placemarkFromCoordinates(position.latitude, position.longitude);

  return Album(forecast.currently.temperature, forecast.currently.summary,
      forecast.hourly.icon, placemark);
}