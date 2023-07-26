import 'package:flutter/material.dart';
import 'package:weather_up2/api.dart';

Column buildAppBar(BuildContext context) {
    return const  Column(
        children: [
          SizedBox(height: 10,),
           Text(
            'Weather Up',
              style: TextStyle(
                  color: Color.fromRGBO(240, 248, 255, 1),
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
          ),
           Text('Realtime Weather Upates!',
            style: TextStyle(
                  color: Color.fromRGBO(240, 248, 255, 1),
                  fontSize: 20),
          ),
        ],);
}

Container cardForDayWeather(Weather weather) {
    return Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Color.fromARGB(255, 204, 204, 204),
          ),
        ),
        width: 300,
        child:  Column(
          children: [
            const SizedBox(height: 10),
            Text(weather.day),
            const SizedBox(height: 20),
            // SvgPicture.asset('assets/img.svg', color: Colors.yellow),
            // Image.asset("assets/img.png"),
            Image(
              image: NetworkImage('http://openweathermap.org/img/wn/${weather.imgUrl}@4x.png'),
            ),
            const SizedBox(height: 15),
            Text(weather.name,
            style: const TextStyle(
                fontFamily: 'Raleway' ,
                fontSize: 30),
                ),
            const SizedBox(height: 10),
            myCustomText(weather.main),
            const SizedBox(height: 5),
            myCustomText(weather.description),
            const SizedBox(height: 10),
            myCustomText('Temp : ${weather.temp} C'),
            const SizedBox(height: 10),
            myCustomText('Feels like: ${weather.feelsLike} C'),
            const SizedBox(height: 10),
            myCustomText('Max Temp: ${weather.maxTemp}C'),
            const SizedBox(height: 10),
            myCustomText('Clouds: ${weather.clouds}%'),
            const SizedBox(height: 10),
            myCustomText('Humidity: ${weather.humidity}%'),
            const SizedBox(height: 10),
            myCustomText('Pressure: ${weather.pressure}mb'),
            const SizedBox(height: 10),
            myCustomText('Windspeed: ${weather.windSpeed}m/s'),
            const SizedBox(height: 10),
            myCustomText('Sunrise : ${weather.sunrise}'),
            const SizedBox(height: 10),
            myCustomText('Sunset : ${weather.sunset}'),
            const SizedBox(height: 10),
          ]
        ),
      );
  }

  Text myCustomText(String data){
    return Text(
      data,
      style: const TextStyle(
        fontFamily: 'Raleway' ,
        fontSize: 20));
  }
