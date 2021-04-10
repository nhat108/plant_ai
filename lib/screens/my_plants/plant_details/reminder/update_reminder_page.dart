import 'package:flower/blocs/firestore/firestore_bloc_bloc.dart';
import 'package:flower/configs/app_colors.dart';
import 'package:flower/configs/app_styles.dart';
import 'package:flower/configs/assets.dart';
import 'package:flower/models/plant.dart';
import 'package:flower/models/reminder.dart';
import 'package:flower/screens/home_page/detect_plant/widgets/loading_widget.dart';
import 'package:flower/utils/custom_dialog.dart';
import 'package:flower/utils/helper.dart';
import 'package:flower/widgets/expanded_widget.dart';
import 'package:flower/widgets/loading_overlay_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:numberpicker/numberpicker.dart';

class UpdateReminderPage extends StatefulWidget {
  final CareOptions option;
  final Reminder reminder;
  final Plant plant;

  const UpdateReminderPage(
      {Key key,
      @required this.option,
      @required this.reminder,
      @required this.plant})
      : super(key: key);
  @override
  _UpdateReminderPageState createState() => _UpdateReminderPageState();
}

class _UpdateReminderPageState extends State<UpdateReminderPage> {
  Reminder reminder = Reminder();
  @override
  void initState() {
    super.initState();
    reminder = widget.reminder;
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
    return BlocListener<FirestoreBlocBloc, FirestoreBlocState>(
      listener: (_, state) {
        if (state.saveReminderError.isNotEmpty) {
          CustomDialog.showError(context, message: state.saveReminderError);
        }
        if (state.saveReminderSuccess) {
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<FirestoreBlocBloc, FirestoreBlocState>(
          builder: (context, state) {
        return LoadingOverlayWidget(
          isLoading: state.saveReminderLoading,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 23, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${getNameOption(widget.option)}",
                        style: AppStyles.medium(size: 18)),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancel",
                        style: AppStyles.regular(
                            size: 18, color: AppColors.primaryColor),
                      ),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 16, bottom: 16),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey[200]),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        AppAssets.flowerIcon,
                        width: 15,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text("${widget.plant.commonName}")
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 0, bottom: 16),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.primaryColor,
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        child: Icon(
                          Icons.sync,
                          size: 16,
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
                              "Repeat",
                              style: AppStyles.medium(
                                  size: 15, color: Colors.white),
                            ),
                            Text(
                              "Every ${reminder.number} ${getDateType(reminder.dateType)}",
                              style: AppStyles.light(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      CupertinoSwitch(
                          value: reminder.repeat,
                          onChanged: (value) {
                            setState(() {
                              reminder = reminder.copyWith(repeat: value);
                            });
                          }),
                    ],
                  ),
                ),
                ExpandedSection(
                  expand: reminder.repeat,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey[200]),
                    ),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 40,
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey[200]),
                          ),
                          child: Text(
                            "Every",
                            style: AppStyles.medium(
                                size: 18, color: AppColors.primaryColor),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          child: NumberPicker.integer(
                            initialValue: reminder.number,
                            minValue: 1,
                            maxValue: 6,
                            itemExtent: 40,
                            selectedTextStyle: AppStyles.medium(
                                size: 18, color: AppColors.primaryColor),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey[200]),
                            ),
                            onChanged: (value) {
                              setState(() {
                                reminder = reminder.copyWith(number: value);
                              });
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          child: NumberPicker.integer(
                            initialValue: reminder.dateType.index,
                            minValue: 0,
                            maxValue: DateType.values.length - 1,
                            itemExtent: 40,
                            selectedTextStyle: AppStyles.medium(
                                size: 18, color: AppColors.primaryColor),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey[200]),
                            ),
                            textMapper: (value) {
                              return getDateType(
                                  DateType.values[int.parse(value)]);
                            },
                            onChanged: (value) {
                              setState(() {
                                reminder = reminder.copyWith(
                                    dateType: DateType
                                        .values[int.parse(value.toString())]);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  "Time of day",
                  style: AppStyles.medium(size: 15),
                ),
                Text(
                  "(Tap to edit)",
                  style: AppStyles.regular(size: 12),
                ),
                Divider(
                  height: 20,
                  // color: AppColors.greyColor,
                ),
                GestureDetector(
                  onTap: () {
                    DatePicker.showTime12hPicker(context,
                        currentTime: DateTime.parse(reminder.morningTime),
                        onConfirm: (value) {
                      setState(() {
                        reminder = reminder.copyWith(
                            morningTime: value.toIso8601String());
                      });
                    });
                  },
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.yellow,
                        ),
                        padding: EdgeInsets.all(6),
                        child: SvgPicture.asset(
                          AppAssets.sunIcon,
                          color: Colors.white,
                          width: 22,
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
                              'Morning',
                              style: AppStyles.medium(size: 15),
                            ),
                            Text(
                              "Remind at ${Helper.formatDateTime(reminder.morningTime, 'hh:mm a')}",
                              style: AppStyles.light(),
                            )
                          ],
                        ),
                      ),
                      CupertinoSwitch(
                          value: reminder.isMorningOn,
                          onChanged: (value) {
                            setState(() {
                              reminder = reminder.copyWith(isMorningOn: value);
                            });
                          }),
                    ],
                  ),
                ),
                Divider(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    DatePicker.showTime12hPicker(context,
                        currentTime: DateTime.parse(reminder.eveningTime),
                        onConfirm: (value) {
                      setState(() {
                        reminder = reminder.copyWith(
                            eveningTime: value.toIso8601String());
                      });
                    });
                  },
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black,
                        ),
                        padding: EdgeInsets.all(6),
                        child: SvgPicture.asset(
                          AppAssets.nightIcon,
                          color: Colors.white,
                          width: 22,
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
                              'Evening',
                              style: AppStyles.medium(size: 15),
                            ),
                            Text(
                              "Remind at ${Helper.formatDateTime(reminder.eveningTime, 'hh:mm a')}",
                              style: AppStyles.light(),
                            )
                          ],
                        ),
                      ),
                      CupertinoSwitch(
                          value: reminder.isEveningOn,
                          onChanged: (value) {
                            setState(() {
                              reminder = reminder.copyWith(isEveningOn: value);
                            });
                          }),
                    ],
                  ),
                ),
                Divider(
                  height: 20,
                ),
                Expanded(
                    child: Align(
                  alignment: Alignment.bottomCenter,
                  child: RaisedButton(
                    color: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    onPressed: () {
                      BlocProvider.of<FirestoreBlocBloc>(context).add(
                          SaveReminder(
                              plantId: widget.plant.id.toString(),
                              body: reminder.toMap()));
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 23, vertical: 10),
                      child: Text(
                        'Save',
                        style: AppStyles.medium(color: Colors.white),
                      ),
                    ),
                  ),
                ))
              ],
            ),
          ),
        );
      }),
    );
  }
}
