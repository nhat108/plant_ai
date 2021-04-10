import 'package:flower/blocs/firestore/firestore_bloc_bloc.dart';
import 'package:flower/configs/app_colors.dart';
import 'package:flower/configs/app_styles.dart';
import 'package:flower/configs/assets.dart';
import 'package:flower/models/plant.dart';
import 'package:flower/models/reminder.dart';
import 'package:flower/screens/my_plants/plant_details/reminder/update_reminder_page.dart';
import 'package:flower/utils/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ListReminderPage extends StatefulWidget {
  final Plant plant;

  const ListReminderPage({Key key, @required this.plant}) : super(key: key);
  @override
  _ListReminderPageState createState() => _ListReminderPageState();
}

class _ListReminderPageState extends State<ListReminderPage> {
  String getIconPath(CareOptions option) {
    switch (option) {
      case CareOptions.Water:
        return AppAssets.waterIcon;
        break;
      case CareOptions.Fertilize:
        return AppAssets.fertilizeIcon;
        break;
      case CareOptions.Rotate:
        return AppAssets.rotationIcon;
        break;
      case CareOptions.Prune:
        return AppAssets.pruneIcon;
        break;
      case CareOptions.Harvest:
        return AppAssets.harvestIcon;
        break;
      default:
        return '';
    }
  }

  String getNameOption(CareOptions option) {
    switch (option) {
      case CareOptions.Water:
        return "Water";
        break;
      case CareOptions.Fertilize:
        return "Fertilize";
        break;
      case CareOptions.Rotate:
        return "Rotate";
        break;
      case CareOptions.Prune:
        return 'Prune';
        break;
      case CareOptions.Harvest:
        return "Harvest";
        break;
      default:
        return '';
    }
  }

  String getDateType(DateType type) {
    switch (type) {
      case DateType.Day:
        return 'Day';
        break;
      case DateType.Week:
        return 'Week';
        break;
      case DateType.Month:
        return 'Month';
        break;
      case DateType.Year:
        return 'Year';
        break;
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Reminder>>(
        stream: BlocProvider.of<FirestoreBlocBloc>(context)
            .getListReminders(widget.plant.id.toString()),
        builder: (context, snapshot) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Care Options",
                    style: AppStyles.medium(
                        size: 18, color: AppColors.primaryColor),
                  ),
                  Divider(
                    height: 35,
                  ),
                  Column(
                    children: List.generate(CareOptions.values.length, (index) {
                      var option = CareOptions.values[index];
                      Reminder reminder;
                      List<String> descripions = [];
                      if (snapshot.data?.isNotEmpty ?? false) {
                        try {
                          reminder = snapshot.data.firstWhere(
                              (element) => element.type == option.index,
                              orElse: null);
                          if (reminder != null) {
                            if (reminder.isMorningOn) {
                              descripions.add(
                                  'Morning ${Helper.formatDateTime(reminder.morningTime, 'hh:mm a')}');
                            }
                            if (reminder.isEveningOn) {
                              descripions.add(
                                  'Evening ${Helper.formatDateTime(reminder.eveningTime, 'hh:mm a')}');
                            }
                            if (descripions.isNotEmpty) {
                              if (reminder.repeat) {
                                descripions.insert(0,
                                    'Every ${reminder.number} ${getDateType(reminder.dateType)}(s)');
                              }
                            }
                          }
                        } catch (e) {}
                      }

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
                                  color: Colors.blue[50],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: SvgPicture.asset(
                                  getIconPath(option),
                                  width: 20,
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
                                      "${getNameOption(option)}",
                                      style: AppStyles.medium(size: 20),
                                    ),
                                    Text(
                                      descripions.isEmpty
                                          ? 'Unset'
                                          : descripions.reduce(
                                              (value, element) =>
                                                  value + ' | ' + element),
                                      style: AppStyles.light(),
                                    )
                                  ],
                                ),
                              ),
                              CupertinoSwitch(
                                value: descripions.isNotEmpty,
                                onChanged: (value) {
                                  showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      builder: (_) {
                                        return UpdateReminderPage(
                                            plant: widget.plant,
                                            option: option,
                                            reminder: reminder ??
                                                Reminder.defaultData(
                                                    option.index));
                                      });
                                },
                              )
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
        });
  }
}
