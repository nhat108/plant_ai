part of 'plant_details_bloc.dart';

abstract class PlantDetailsEvent {}

class GetPlantDetailsById extends PlantDetailsEvent {
  final String id;

  GetPlantDetailsById({@required this.id});
}
