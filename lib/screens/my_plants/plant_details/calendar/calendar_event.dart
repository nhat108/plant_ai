import 'package:flower/blocs/firestore/firestore_bloc_bloc.dart';
import 'package:flower/configs/app_colors.dart';
import 'package:flower/models/plant.dart';
import 'package:flower/models/reminder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:intl/intl.dart';

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

  String getNameOption(CareOptions option) {
    switch (option) {
      case CareOptions.Water:
        return "Tuới nước";
        break;
      case CareOptions.Fertilize:
        return "Bón phân";
        break;
      case CareOptions.Rotate:
        return "Xoay hướng";
        break;
      case CareOptions.Prune:
        return 'Tỉa cành';
        break;
      case CareOptions.Harvest:
        return "Thu hoạch";
        break;
      default:
        return '';
    }
  }

  List<Event> convertRemiderToEvent(List<Reminder> reminders) {
    return reminders
        .map((e) {
          String title = e.plantName;
          String careOption = getNameOption(CareOptions.values[e.type]);
          DateTime morningTime;
          DateTime eveningTime;
          DateTime createdAt = DateTime.now();
          DateType dateType = e.dateType;
          List<DateTime> dateRepeat = [];
          dateRepeat.add(createdAt);
          int max = 10;
          if (e.isMorningOn) {
            morningTime = DateTime.parse(e.morningTime);
          }
          if (e.isMorningOn) {
            eveningTime = DateTime.parse(e.eveningTime);
          }
          switch (dateType) {
            case DateType.Day:
              if (e.repeat) {
                var number = e.number;
                while (number > 0) {
                  var nextDate = dateRepeat.last.add(Duration(days: e.number));
                  dateRepeat.add(nextDate);
                  number--;
                }
              }
              break;
            case DateType.Week:
              if (e.repeat) {
                var number = e.number;
                while (number > 0) {
                  var nextDate =
                      dateRepeat.last.add(Duration(days: e.number + 7));
                  dateRepeat.add(nextDate);
                  number--;
                }
              }
              break;
            case DateType.Month:
              if (e.repeat) {
                var number = e.number;
                while (number > 0) {
                  var nextDate =
                      dateRepeat.last.add(Duration(days: e.number + 30));
                  dateRepeat.add(nextDate);
                  number--;
                }
              }
              break;
            case DateType.Year:
              if (e.repeat) {
                var number = e.number;
                while (number > 0) {
                  var nextDate =
                      dateRepeat.last.add(Duration(days: e.number + 365));
                  dateRepeat.add(nextDate);
                  number--;
                }
              }
              break;
          }
          dateRepeat = dateRepeat
              .map((e) {
                List<DateTime> list = [];
                if (morningTime != null) {
                  list.add(DateTime(e.year, e.month, e.day, morningTime.hour,
                      morningTime.minute));
                }
                if (eveningTime != null) {
                  list.add(DateTime(e.year, e.month, e.day, eveningTime.hour,
                      eveningTime.minute));
                }

                return list;
              })
              .toList()
              .expand((element) => element)
              .toList();

          return dateRepeat.map((e) {
            return Event(
              title: title,
              description: careOption,
              dateTime: DateFormat('yyyy-MM-dd HH:mm').format(e),
            );
          }).toList();
        })
        .toList()
        .expand((element) => element)
        .toList();
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
        if (state.listReminders.isNotEmpty) {
          var list = convertRemiderToEvent(state.listReminders);
          return EventCalendar(events: list);
        }
        return Container();
      }),
    );
  }
}
