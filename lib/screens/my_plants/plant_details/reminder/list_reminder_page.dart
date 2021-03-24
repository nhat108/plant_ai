import 'package:flower/configs/app_colors.dart';
import 'package:flower/configs/app_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListReminderPage extends StatefulWidget {
  @override
  _ListReminderPageState createState() => _ListReminderPageState();
}

class _ListReminderPageState extends State<ListReminderPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Care Options",
              style: AppStyles.medium(size: 18, color: AppColors.primaryColor),
            ),
            Divider(
              height: 35,
            ),
            Column(
              children: List.generate(5, (index) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Icon(
                            Icons.ac_unit,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Water",
                                style: AppStyles.medium(size: 20),
                              ),
                              Text(
                                "Every 2 months | Evening: 18:00",
                                style: AppStyles.light(),
                              )
                            ],
                          ),
                        ),
                        CupertinoSwitch(value: true, onChanged: (value) {})
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Divider(
                      height: 1,
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
