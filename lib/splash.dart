import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_up2/home.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
 
 @override
  void initState(){
    super.initState();
    navigateToHome();
  }

  void navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 1500), (){});
    Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => CurrentWeatherPage()));
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color.fromRGBO(100, 149, 237, 1),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              iconSize: 150,
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/spl.svg')),            
            const Text(
              "WEATHER UP",
              style: TextStyle(
                color: Color.fromARGB(255, 216, 210, 210),
                fontFamily: 'Raleway',
                fontSize: 30,
                fontWeight: FontWeight.w700
              ),
              ),
          ],
        ),
      ), 
    );
  }
}