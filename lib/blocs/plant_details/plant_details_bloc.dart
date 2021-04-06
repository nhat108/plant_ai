import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flower/models/plant.dart';
import 'package:flower/repository/trefle_api_client.dart';
import 'package:meta/meta.dart';

part 'plant_details_event.dart';
part 'plant_details_state.dart';

class PlantDetailsBloc extends Bloc<PlantDetailsEvent, PlantDetailsState> {
  PlantDetailsBloc() : super(PlantDetailsState.empty());

  @override
  Stream<PlantDetailsState> mapEventToState(
    PlantDetailsEvent event,
  ) async* {
    if (event is GetPlantDetailsById) {
      try {
        yield state.copyWith(
          getPlantDetailsError: '',
          getPlantDetailsLoading: false,
        );
        final model = await TrefleApiClient().getPlantDetails(event.id);
        yield state.copyWith(
          getPlantDetailsLoading: false,
          plantDetails: model,
        );
      } catch (e) {
        yield state.copyWith(
          getPlantDetailsError: e.toString(),
          getPlantDetailsLoading: false,
        );
      }
    }
  }
}
