import 'package:flower/blocs/firestore/firestore_bloc_bloc.dart';
import 'package:flower/configs/app_colors.dart';
import 'package:flower/models/reminder.dart';
import 'package:flower/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';

class CalendarEventPage extends StatefulWidget {
  @override
  _CalendarEventPageState createState() => _CalendarEventPageState();
}

class _CalendarEventPageState extends State<CalendarEventPage> {
  @override
  void initState() {
    BlocProvider.of<FirestoreBlocBloc>(context).add(GetListReminders());
    super.initState();
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        leading: IconButton(
          icon: Icon(
            Icons.clear,
            color: AppColors.primaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),
      body: BlocBuilder<FirestoreBlocBloc, FirestoreBlocState>(
          builder: (context, state) {
        return EventCalendar(
            events: state.listReminders.map((e) {
          var reminder = e;
          List<String> descripions = [];

          try {
            if (reminder != null) {
              if (reminder.isMorningOn) {
                descripions.add(
                  'Morning ${Helper.formatDateTime(reminder.morningTime, 'hh:mm a')}',
                );
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
          DateTime date;
          DateTime now = DateTime.now();
          if (reminder.isMorningOn) {
            date = DateTime.parse(reminder.morningTime);
          }
          if (reminder.isMorningOn) {
            date = DateTime.parse(reminder.eveningTime);
          }
          if(date!=null){
            
          }

          return Event(
            title: '${e.plantName}',
            description: descripions.isEmpty
                ? ''
                : '${descripions.reduce((value, element) => value + " | " + element)}',
            dateTime: '2021-04-10 20:00',
          );
        }).toList());
      }),
    );
  }
}
