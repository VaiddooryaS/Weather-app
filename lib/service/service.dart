import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/model/weathermodel.dart';

class Weatherservice{

static const BASE_URL ="http://api.openweathermap.org/data/2.5/weather";
final String apikey;

Weatherservice(this.apikey);

Future<Weather> getWeather(String cityname) async{
  final response = await http.get(Uri.parse('$BASE_URL?q=$cityname&appid=$apikey&units=metric'));

  if(response.statusCode==200){
    return Weather.fromJson(jsonDecode(response.body));
  }
  else{
    throw Exception('failed the api load');
  }
}

Future<String> getCurrentCity()async{

  //get permission from user
  LocationPermission permission = await Geolocator.checkPermission();
  if(permission == LocationPermission.denied){
    permission = await Geolocator.requestPermission();
  }

  //get the current location of the user
  Position position = await Geolocator.getCurrentPosition(
    // ignore: deprecated_member_use
    desiredAccuracy: LocationAccuracy.high);

  //convert the loaction into a list of placemark objects
  List<Placemark> placemark = await placemarkFromCoordinates(position.latitude, position.longitude);

  //extract the cityname from the fist placemark
  String? city = placemark[0].locality;

  return city??"";
}
}