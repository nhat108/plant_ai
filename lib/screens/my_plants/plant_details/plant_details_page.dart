import 'package:flower/configs/app_colors.dart';
import 'package:flower/configs/app_styles.dart';
import 'package:flower/screens/my_plants/plant_details/app_bar.dart';
import 'package:flower/screens/my_plants/plant_details/notes/list_notes_page.dart';
import 'package:flower/screens/my_plants/plant_details/reminder/list_reminder_page.dart';
import 'package:flutter/material.dart';

class PlantDetailsPage extends StatefulWidget {
  @override
  _PlantDetailsPageState createState() => _PlantDetailsPageState();
}

class _PlantDetailsPageState extends State<PlantDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            PlantDetailsAppBar(),
            SliverList(
              delegate: SliverChildListDelegate(
                [
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
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 22),
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
                              "Reminder",
                              style: AppStyles.regular(
                                  size: 18, color: Colors.black),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            child: Text(
                              "Note",
                              style: AppStyles.regular(
                                  size: 18, color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            new SliverFillRemaining(
              child: TabBarView(
                children: <Widget>[
                  ListReminderPage(),
                  ListNotesPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
