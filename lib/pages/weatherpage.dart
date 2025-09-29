import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/model/weathermodel.dart';
import 'package:weather_app/service/service.dart';

class Weatherpage extends StatefulWidget {
  const Weatherpage({super.key});

  @override
  State<Weatherpage> createState() => _WeatherpageState();
}

class _WeatherpageState extends State<Weatherpage> {
  
  //api key
  final _weatherservice = Weatherservice('2582d504f973f893822fc839e12c85b9');
  Weather? _weather;

  //fetch weather
  _fetchWeather() async{
    //get the current city
    String cityname = await _weatherservice.getCurrentCity();

    //get weater of that city
    try{
      final weather = await _weatherservice.getWeather(cityname);
      setState(() {
        _weather = weather;
      });
    }
    catch(e){
      print(e);
    }
  }

  //weather animation
  getWeatherAnimation(String? maincondition){
    if(maincondition==null) return'assets/sunny.json';

    switch(maincondition.toLowerCase()){
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/rainy.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rainy.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';

    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchWeather();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_on,size: 40,color: Colors.white,),
            Text(_weather?.cityname ??'loading city',style: TextStyle(color: Colors.amber[300],fontSize: 35,fontWeight: FontWeight.w800),),

            SizedBox(height: 150,width: 30,),
            
            //animation
            Lottie.asset(getWeatherAnimation(_weather?.maincondition)),

            SizedBox(height: 50,width: 30,),

            //temperature
            Text('${_weather?.temperature.round()}°c',style: TextStyle(color: Colors.white,fontSize: 30),),

            //weather condition
            Text(_weather?.maincondition ?? "",style: TextStyle(color: Colors.white),),
          ],
        ),
      ),
    );
  }
}