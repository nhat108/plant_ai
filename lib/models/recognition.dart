import 'package:equatable/equatable.dart';

class Recogition extends Equatable {
  final double confidenceInClass;
  final String detectedClass;
  final Rect rect;

  Recogition({this.confidenceInClass, this.detectedClass, this.rect});

  factory Recogition.fromJson(dynamic json) {
    return Recogition(
      confidenceInClass: json['confidence'],
      detectedClass: json['label'],
      rect: json['rect'],
    );
  }
  @override
  List<Object> get props =>
      [this.confidenceInClass, this.detectedClass, this.rect];
}

class Rect extends Equatable {
  final double w;
  final double x;
  final double h;
  final double y;

  Rect({this.w, this.x, this.h, this.y});

  factory Rect.fromJson(Map<String, dynamic> json) {
    return Rect(
      w: json['w'],
      x: json['x'],
      h: json['h'],
      y: json['y'],
    );
  }
  @override
  List<Object> get props => [this.w, this.x, this.h, this.y];
}
