class Weather{
  final String cityname;
  final String maincondition;
  final double temperature;

  Weather({required this.cityname,
  required this.maincondition,
  required this.temperature});

  factory Weather.fromJson(Map<String,dynamic> json){
    return Weather(
      cityname: json['name'],
      maincondition: json['weather'][0]['main'],
      temperature: json['main']['temp'].toDouble());
  }
  
}
