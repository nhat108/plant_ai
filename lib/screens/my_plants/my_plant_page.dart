import 'dart:ui';

import 'package:flower/configs/assets.dart';
import 'package:flutter/material.dart';

import 'my_plant_navigator.dart';

class MyPlantPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<MyPlantPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AppAssets.plantBackground,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          // BackdropFilter(
          //   filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          //   child: Container(
          //     width: MediaQuery.of(context).size.width,
          //     height: MediaQuery.of(context).size.height,
          //     decoration: new BoxDecoration(
          //       color: Colors.white.withOpacity(0.5),
          //     ),
          //   ),
          // ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: new BoxDecoration(
              color: Colors.white.withOpacity(0.5),
            ),
          ),
          MyPlantNavigator(),
        ],
      ),
    );
  }
}
