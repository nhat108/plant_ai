part of 'detect_plant_bloc.dart';

abstract class DetectPlantEvent {}

class DetectPlant extends DetectPlantEvent {
  final String imagePath;

  DetectPlant({@required this.imagePath});
}

class SearchPlant extends DetectPlantEvent {
  final String query;

  SearchPlant({@required this.query});
}
