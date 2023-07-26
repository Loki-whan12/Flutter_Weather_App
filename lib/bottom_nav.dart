import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


Container homebottomNavBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      height: 50,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            offset: const Offset(0, -10),
            blurRadius: 30,
            color: Colors.blue.withOpacity(0.23))
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
              onPressed: () {
              },
              icon: SvgPicture.asset('assets/home.svg', color: Colors.blue)),
        ],
      ),
    );
}