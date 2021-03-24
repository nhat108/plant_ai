import 'package:flower/configs/app_colors.dart';
import 'package:flower/configs/app_styles.dart';
import 'package:flutter/material.dart';

import 'fab.dart';
import 'list_my_plants/list_my_plants_widget.dart';
import 'recent_snap/recent_snap_widget.dart';

class MyPlantNavigator extends StatefulWidget {
  @override
  _MyPlantNavigatorState createState() => _MyPlantNavigatorState();
}

class _MyPlantNavigatorState extends State<MyPlantNavigator> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FABWidget(),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "My Plants",
                      style: AppStyles.bold(
                        size: 30,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Icon(
                            Icons.search,
                            size: 18,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Icon(
                            Icons.calendar_today,
                            size: 18,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Icon(
                            Icons.help,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 20,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  margin: EdgeInsets.symmetric(vertical: 20),
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                  child: TabBar(
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: AppColors.lightColor,
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabs: [
                        Tab(
                          child: Container(
                            child: Text(
                              "My plants",
                              style: AppStyles.regular(
                                  size: 18, color: Colors.black),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            child: Text(
                              "Recent Snap",
                              style: AppStyles.regular(
                                  size: 18, color: Colors.black),
                            ),
                          ),
                        ),
                      ]),
                ),
                Expanded(
                  child: TabBarView(children: [
                    ListMyPlantsWidget(),
                    RecentSnapWidget(),
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
