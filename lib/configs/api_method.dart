import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flower/utils/constants.dart';

enum Method { post, put, patch, delete, get }

class ApiClient {
  final dio = Dio();

  Future<Response> request(
    url,
    Method method, {
    body,
    isAuth,
    Map<String, dynamic> params,
    headers,
    isUrl,
    isTranslate = false,
    versionAPI = 'v1',
    Duration cacheDuration,
    bool isForceRefresh = false,
    String customDomain,
    String primaryKey,
  }) async {
    try {
      final _baseUrl = '${Constants.BASE_URL}/api/$versionAPI';

      Map header = {
        // 'Content-Type': 'application/json',
        'Connection': "keep-alive"
      };

      String _url = _baseUrl + url;
      if (params == null) {
        params = {
          'token': Constants.API_KEY,
        };
      } else {
        params = {
          'token': Constants.API_KEY,
        }..addAll(params);
      }

      if (method == Method.post) {
        return await dio.post(_url,
            data: body,
            options: Options(
              headers: header,
            ),
            queryParameters: params);
      } else if (method == Method.put) {
        return await dio.put(_url,
            data: body,
            options: Options(headers: header),
            queryParameters: params);
      } else if (method == Method.patch) {
        return await dio.patch(_url,
            data: body,
            options: Options(headers: header),
            queryParameters: params);
      } else if (method == Method.delete) {
        return await dio.delete(_url,
            options: Options(headers: header), queryParameters: params);
      }

      return await dio.get(_url, queryParameters: params);
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> requestUploadImage(url, Method method, File file) async {
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(file.path, filename: fileName),
    });

    // formData.add('file', new UploadFileInfo(file, file.path.split("/").last));

    return await request(url, method, body: formData);
  }
}
