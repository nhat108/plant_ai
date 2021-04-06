import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flower/configs/assets.dart';
import 'package:flower/models/plant.dart';
import 'package:flower/models/recognition.dart';
import 'package:flower/repository/trefle_api_client.dart';
import 'package:flower/utils/constants.dart';
import 'package:meta/meta.dart';
import 'package:tflite/tflite.dart';
part 'detect_plant_event.dart';
part 'detect_plant_state.dart';

class DetectPlantBloc extends Bloc<DetectPlantEvent, DetectPlantState> {
  DetectPlantBloc() : super(DetectPlantState.empty()) {
    _initModel();
  }
  bool loadMoreDone = false;
  _initModel() async {
    try {
      Tflite.close();
      print('loading...');
      await Tflite.loadModel(
        model: AppAssets.plantModel,
        labels: AppAssets.plantLabel,
      );
      loadMoreDone = true;
      // await _detectPlant();

      print('load model done');
    } catch (e) {
      print('error $e');
    }
  }

  @override
  Future<void> close() async {
    await Tflite.close();
    return super.close();
  }

  @override
  Stream<DetectPlantState> mapEventToState(
    DetectPlantEvent event,
  ) async* {
    if (event is DetectPlant) {
      try {
        yield state.copyWith(detectPlantLoading: true, detectPlantError: '');
        var results = await Tflite.runModelOnImage(
          path: event.imagePath,
          threshold: 0.5,
          imageMean: 127.5,
          imageStd: 127.5,
          numResults: 2,
        );
        List<Recogition> listRecogitions =
            results.map((e) => Recogition.fromJson(e)).toList();
        if (listRecogitions.isNotEmpty) {
          var recogition = listRecogitions.first;
          var name = Constants.MAP_PLANT_TEXT[recogition.detectedClass];
          add(SearchPlant(
            query: name,
          ));
        }
        yield state.copyWith(
          detectPlantLoading: false,
          detectPlantSuccess: true,
        );
      } catch (e) {
        yield state.copyWith(
          detectPlantError: e.toString(),
          detectPlantLoading: false,
        );
      }
      yield state.copyWith(
        detectPlantLoading: false,
        detectPlantSuccess: false,
      );
    }
    if (event is SearchPlant) {
      try {
        yield state.copyWith(
          searchPlantLoading: true,
        );
        final results = await TrefleApiClient().searchPlant(event.query);
        yield state.copyWith(searchPlantLoading: false, listPlants: results);
      } catch (e) {
        yield state.copyWith(
          detectPlantError: e.toString(),
          detectPlantLoading: false,
        );
      }
    }
  }
}
