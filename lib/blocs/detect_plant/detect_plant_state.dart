part of 'detect_plant_bloc.dart';

class DetectPlantState extends Equatable {
  final bool detectPlantLoading;
  final bool detectPlantSuccess;
  final String detectPlantError;
  final List<Recogition> recogitions;

  final bool searchPlantLoading;
  final List listPlants;
  final String searchPlantError;

  DetectPlantState({
    this.detectPlantLoading,
    this.detectPlantSuccess,
    this.detectPlantError,
    this.searchPlantLoading,
    this.listPlants,
    this.searchPlantError,
    this.recogitions,
  });
  factory DetectPlantState.empty() {
    return DetectPlantState(
      detectPlantError: '',
      detectPlantLoading: false,
      detectPlantSuccess: false,
      listPlants: [],
      searchPlantError: '',
      searchPlantLoading: false,
      recogitions: [],
    );
  }
  DetectPlantState copyWith({
    final bool detectPlantLoading,
    final bool detectPlantSuccess,
    final String detectPlantError,
    final bool searchPlantLoading,
    final List listPlants,
    final String searchPlantError,
    List<Recogition> recogitions,
  }) {
    return DetectPlantState(
      recogitions: recogitions ?? this.recogitions,
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
        this.recogitions,
        this.detectPlantLoading,
        this.detectPlantSuccess,
        this.detectPlantError,
        this.searchPlantLoading,
        this.listPlants,
        this.searchPlantError
      ];
}
