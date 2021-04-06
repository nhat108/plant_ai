import 'dart:collection';
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
    versionAPI = 'v1.0',
    Duration cacheDuration,
    bool isForceRefresh = false,
    String customDomain,
    String primaryKey,
  }) async {
    try {
      final _baseUrl = '${customDomain ?? Constants.BASE_URL}/api/$versionAPI';
      final hasToken = isAuth != null ? isAuth : true;
      final hasUserOtherUrl = isUrl ?? false;
      Map _headers = {
        // 'Content-Type': 'application/json',
        'Connection': "keep-alive"
      };
      // Map _headers = {};

      // if (hasToken) {
      //   if (await LocalStorage().hasExpireToken())
      //     await LocalStorage().refreshToken();
      //   final _token = await LocalStorage().getToken();
      //   _headers['Authorization'] = 'Bearer $_token';
      // }
      var combinedMap = _headers;
      if (_headers != null && headers != null) {
        var mapList = [_headers, headers];
        _headers.addAll(headers);
        combinedMap = mapList.reduce((map1, map2) => map1..addAll(map2));
      }
      Map<String, String> header = HashMap.from(combinedMap);
      String _url;
      // if (hasUserOtherUrl) {
      //   _url = url;
      // } else {
      //   _url = _baseUrl + url;
      //   String localLanguageCode = await LocalStorage().getCurrentLanguage();
      //   if (isTranslate) {
      //     _url = _url +
      //         '${_url.contains('?') ? '&' : '?'}lang=${localLanguageCode != 'none' ? localLanguageCode : 'en'}';
      //   }
      // }

      params = {
        'token': Constants.API_KEY,
      }..addAll(params);
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
