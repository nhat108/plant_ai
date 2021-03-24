import 'package:flower/configs/app_colors.dart';
import 'package:flower/screens/favourite/favourite_page.dart';
import 'package:flower/screens/home_page/home_page.dart';
import 'package:flower/screens/profile/profile_page.dart';
import 'package:flutter/material.dart';

import 'my_plants/my_plant_page.dart';

class NavigatorBuilder extends StatefulWidget {
  @override
  _NavigatorBuilderState createState() => _NavigatorBuilderState();
}

class _NavigatorBuilderState extends State<NavigatorBuilder> {
  List<Widget> pages = [];
  int _currentPage = 0;

  @override
  void initState() {
    pages = [
      HomePage(),
      MyPlantPage(),
      FavouritePage(),
      ProfilePage(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentPage],
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex: _currentPage,
        onChanged: (value) {
          setState(() {
            _currentPage = value;
          });
        },
      ),
    );
  }
}

class MyBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onChanged;

  const MyBottomNavigationBar(
      {Key key, @required this.currentIndex, @required this.onChanged})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor: AppColors.lightColor,
      currentIndex: currentIndex,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      onTap: onChanged,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.star,
            ),
            label: "My Plant"),
        BottomNavigationBarItem(icon: Icon(Icons.help), label: "Help"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
      ],
    );
  }
}
