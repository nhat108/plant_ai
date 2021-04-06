part of 'plant_details_bloc.dart';

class PlantDetailsState extends Equatable {
  final bool getPlantDetailsLoading;
  final PlantDetails plantDetails;
  final String getPlantDetailsError;

  PlantDetailsState(
      {this.getPlantDetailsLoading,
      this.plantDetails,
      this.getPlantDetailsError});

  factory PlantDetailsState.empty() {
    return PlantDetailsState(
      getPlantDetailsError: '',
      getPlantDetailsLoading: false,
      plantDetails: null,
    );
  }
  PlantDetailsState copyWith({
    bool getPlantDetailsLoading,
    PlantDetails plantDetails,
    String getPlantDetailsError,
  }) {
    return PlantDetailsState(
      getPlantDetailsLoading:
          getPlantDetailsLoading ?? this.getPlantDetailsLoading,
      getPlantDetailsError: getPlantDetailsError ?? this.getPlantDetailsError,
      plantDetails: plantDetails ?? this.plantDetails,
    );
  }

  @override
  List<Object> get props => [
        this.getPlantDetailsLoading,
        this.plantDetails,
        this.getPlantDetailsError
      ];
}
