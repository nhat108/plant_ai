import 'package:flower/configs/app_colors.dart';
import 'package:flower/configs/assets.dart';
import 'package:flower/screens/favourite/favourite_page.dart';
import 'package:flower/screens/home_page/home_page.dart';
import 'package:flower/screens/profile/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
      unselectedItemColor: Colors.grey[400],
      currentIndex: currentIndex,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      onTap: onChanged,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            AppAssets.homeIcon,
            width: 18,
            color: Colors.grey[400],
          ),
          activeIcon: SvgPicture.asset(
            AppAssets.homeIcon,
            width: 18,
            color: AppColors.primaryColor,
          ),
          label: "Home",
        ),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppAssets.leafIcon3,
              width: 18,
              color: Colors.grey[400],
            ),
            activeIcon: SvgPicture.asset(
              AppAssets.leafIcon3,
              width: 18,
              color: AppColors.primaryColor,
            ),
            label: "My Plant"),
        BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppAssets.helpIcon,
              width: 18,
              color: Colors.grey[400],
            ),
            activeIcon: SvgPicture.asset(
              AppAssets.helpIcon,
              width: 18,
              color: AppColors.primaryColor,
            ),
            label: "Help"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
      ],
    );
  }
}
