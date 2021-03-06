import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final String note;
  final String date;
  final String name;
  final List<String> images;
  final String id;

  Note({this.note, this.id, this.date, this.name, this.images});

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      note: json['note'],
      date: json['date'],
      images: (json['images'] as List).map((e) => e.toString()).toList(),
      name: json['name'],
      id: json['id'],
    );
  }

  @override
  List<Object> get props =>
      [this.note, this.date, this.name, this.images, this.id];
}
