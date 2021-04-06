import 'package:flower/configs/api_method.dart';
import 'package:flower/configs/api_url.dart';
import 'package:flower/models/plant.dart';

class TrefleApiClient extends ApiClient {
  Future<List<Plant>> searchPlant(String query) async {
    try {
      final String url = ApiUrl.search;
      final response = await request(url, Method.get, params: {'q': query});
      return (response.data['data'] as List)?.map((e) {
        return Plant.fromJson(e);
      })?.toList();
    } catch (e) {
      throw e;
    }
  }

  Future<PlantDetails> getPlantDetails(String id) async {
    try {
      final String url = ApiUrl.plantDetails.replaceAll('{plantId}', id);
      final response = await request(url, Method.get);
      return PlantDetails.fromJson(response.data['data']);
    } catch (e) {
      throw e;
    }
  }
}
