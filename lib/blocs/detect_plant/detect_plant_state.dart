part of 'detect_plant_bloc.dart';

class DetectPlantState extends Equatable {
  final bool detectPlantLoading;
  final bool detectPlantSuccess;
  final String detectPlantError;

  final bool searchPlantLoading;
  final List<Plant> listPlants;
  final String searchPlantError;

  DetectPlantState(
      {this.detectPlantLoading,
      this.detectPlantSuccess,
      this.detectPlantError,
      this.searchPlantLoading,
      this.listPlants,
      this.searchPlantError});
  factory DetectPlantState.empty() {
    return DetectPlantState(
      detectPlantError: '',
      detectPlantLoading: false,
      detectPlantSuccess: false,
      listPlants: [],
      searchPlantError: '',
      searchPlantLoading: false,
    );
  }
  DetectPlantState copyWith({
    final bool detectPlantLoading,
    final bool detectPlantSuccess,
    final String detectPlantError,
    final bool searchPlantLoading,
    final List<Plant> listPlants,
    final String searchPlantError,
  }) {
    return DetectPlantState(
      detectPlantError: detectPlantError ?? this.detectPlantError,
      detectPlantLoading: detectPlantLoading ?? this.detectPlantLoading,
      detectPlantSuccess: detectPlantSuccess ?? this.detectPlantSuccess,
      listPlants: listPlants ?? this.listPlants,
      searchPlantError: searchPlantError ?? this.searchPlantError,
      searchPlantLoading: searchPlantLoading ?? this.searchPlantLoading,
    );
  }

  @override
  List<Object> get props => [
        this.detectPlantLoading,
        this.detectPlantSuccess,
        this.detectPlantError,
        this.searchPlantLoading,
        this.listPlants,
        this.searchPlantError
      ];
}
