enum DateType {
  Day,
  Week,
  Month,
  Year,
}

class Reminder {
  final int type;
  final String morningTime;
  final String eveningTime;
  final bool repeat;
  final int number;
  final DateType dateType;
  final bool isMorningOn;
  final bool isEveningOn;
  Reminder({
    this.type,
    this.morningTime,
    this.eveningTime,
    this.repeat,
    this.number,
    this.dateType,
    this.isEveningOn,
    this.isMorningOn,
  });
  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
        dateType: DateType.values[json['date_type']],
        eveningTime: json['evening_time'],
        morningTime: json['morning_time'],
        number: json['number'],
        repeat: json['repeat'],
        type: json['type'],
        isEveningOn: json['is_evening_on'],
        isMorningOn: json['is_morning_on']);
  }
  Map<String, dynamic> toMap() {
    return {
      'date_type': dateType.index,
      'evening_time': eveningTime,
      'morning_time': morningTime,
      'number': number,
      'repeat': repeat,
      'type': type,
      'is_evening_on': isEveningOn,
      'is_morning_on': isMorningOn,
    };
  }

  factory Reminder.defaultData(int type) {
    return Reminder(
        type: type,
        dateType: DateType.Day,
        eveningTime: '20120227 18:00:00',
        morningTime: '20120227 10:00:00',
        number: 1,
        repeat: true,
        isEveningOn: false,
        isMorningOn: true);
  }
  Reminder copyWith({
    final int type,
    final String morningTime,
    final String eveningTime,
    final bool repeat,
    final int number,
    final DateType dateType,
    final bool isMorningOn,
    final bool isEveningOn,
  }) {
    return Reminder(
      type: type ?? this.type,
      dateType: dateType ?? this.dateType,
      eveningTime: eveningTime ?? this.eveningTime,
      isEveningOn: isEveningOn ?? this.isEveningOn,
      isMorningOn: isMorningOn ?? this.isMorningOn,
      morningTime: morningTime ?? this.morningTime,
      number: number ?? this.number,
      repeat: repeat ?? this.repeat,
    );
  }
}
