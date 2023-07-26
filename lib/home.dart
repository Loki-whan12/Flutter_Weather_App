import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weather_up2/api.dart';
import 'package:weather_up2/bottom_nav.dart';
import 'package:weather_up2/features.dart';
import 'package:http/http.dart' as http;

class CurrentWeatherPage extends StatefulWidget {
  const CurrentWeatherPage({super.key});

  @override
  State<CurrentWeatherPage> createState() => _CurrentWeatherPageState();
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage> {
  final textController = TextEditingController();
  String cityName = "London"; 
  late Future getWeather;

  @override
  void initState(){
    super.initState();

    getWeather = getWeatherData(cityName);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        elevation: 10.0,
        foregroundColor: Colors.cyanAccent,
        child: Icon(Icons.refresh),
        onPressed: (){
          setState(() {
            getWeather = getWeatherData(cityName);
          });
        },
        ),
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 80,
        flexibleSpace: buildAppBar(context),
      ),
      body: ListView(
        children: [ Column(
          children: [
            topBarWidget(),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: (){
                if(textController.text == ""){
                  Fluttertoast.showToast(msg: "Sorry you have to enter a city!", webPosition: "center");
                }
                if(textController.text == cityName){
                  Fluttertoast.showToast(msg: "Enter a diffrent city!", webPosition: "center");
                }else{
                  setState((){
                    cityName = textController.text;
                    getWeather = getWeatherData(cityName);
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
              ),
              child: Text("Get Weather"),),
            const SizedBox(height: 10),
            inputDataFutureBuilder(cityName),
            const SizedBox(height: 20),
            ],
            
          ),
        ]
      ),
      bottomNavigationBar: homebottomNavBar(context),  
    );
  }

  Container topBarWidget() {
    return Container(
    margin: const EdgeInsets.only(bottom: 20),
    height: 100,
    child: Stack(children: <Widget>[
      Container(
        padding: const EdgeInsets.only(bottom: 36 + 20),
        height: 80,
        decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36))),
      ),
      Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 54,
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    offset: const Offset(0, 10),
                    blurRadius: 50,
                    color: Colors.white.withOpacity(0.23))
              ],
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: const InputDecoration(
                        hintText: 'Enter a city',
                        hintStyle: TextStyle(color: Colors.black),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none),
                  ),
                ),
                const Icon(Icons.search)
              ],
            ),
          ))
    ]),
  );
  }

  FutureBuilder inputDataFutureBuilder(String cityName){
    Weather weather = Weather(day: "", imgUrl: "", name: "",
      main: "", description: "", temp: "", feelsLike: "",
      maxTemp: "", clouds: "", humidity: "", pressure: "",
      windSpeed: "", sunrise: "", sunset: "");
    return FutureBuilder(
                  future: getWeather, 
                  builder: (context, snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return CircularProgressIndicator();
                    }
    
                    if(snapshot.hasData){
                      final weatherFromJson = snapshot.data;
    DateTime.fromMillisecondsSinceEpoch(1684929490 * 1000);
                      var day = DateTime.fromMillisecondsSinceEpoch(weatherFromJson!['dt'] * 1000);
                      weather.day = "${day.year}-${day.month}-${day.day}-${day.hour}-${day.minute}-${day.second}";
                      weather.imgUrl = weatherFromJson['weather'][0]['icon'].toString();
                      weather.name = weatherFromJson['name'].toString();
                      weather.main = weatherFromJson['weather'][0]['main'].toString();
                      weather.description = weatherFromJson['weather'][0]['description'].toString();
                      weather.temp = weatherFromJson['main']['temp'].toString();
                      weather.feelsLike = weatherFromJson['main']['feels_like'].toString();
                      weather.maxTemp = weatherFromJson['main']['temp_max'].toString();
                      weather.clouds = weatherFromJson['clouds']['all'].toString();
                      weather.humidity = weatherFromJson['main']['humidity'].toString();
                      weather.pressure = weatherFromJson['main']['pressure'].toString();
                      weather.windSpeed = weatherFromJson['wind']['speed'].toString();
                      var sunRise = DateTime.fromMillisecondsSinceEpoch(weatherFromJson['sys']['sunrise'] * 1000); 
                      var sunSet = DateTime.fromMillisecondsSinceEpoch(weatherFromJson['sys']['sunset'] * 1000);
                      weather.sunrise = "${sunRise.year}-${sunRise.month}-${sunRise.day}-${sunRise.hour}-${sunRise.minute}-${sunRise.second}";
                      weather.sunset  = "${sunSet.year}-${sunSet.month}-${sunSet.day}-${sunSet.hour}-${sunSet.minute}-${sunSet.second}";
                      return cardForDayWeather(weather);
                    }else{
                      // return CircularProgressIndicator();
                      return Text("Error in getting weather info");
                    }
                  }
                );
  }



  Future getWeatherData(String city) async {
    String apiKey = "ec872a0df70b06ca2c9b30e1d7178a62";
    var url = "http://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric&lang=en";
    
    final response = await http.get(Uri.parse(url));

    if(response.statusCode == 200){
      // return Weather.fromJSON(jsonDecode(response.body));
      final data = jsonDecode(response.body);
      return data;
    }else{
      throw Exception("Failed to get Data.");
    }
  }
}