class Weather{
  String day;
  String imgUrl;
  String name;
  String main;
  String description;
  String temp;
  String feelsLike;
  String maxTemp;
  String clouds;
  String humidity;
  String pressure;
  String windSpeed;
  String sunrise;
  String sunset;

  Weather({required this.day, required this.imgUrl,
    required this.name, required this.main,
    required this.description, required this.temp,
    required this.feelsLike, required this.maxTemp,
    required this.clouds, required this.humidity, required this.pressure, 
    required this.windSpeed, required this.sunrise,
    required this.sunset});
}