import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:myfeed/app/interfaces/services/http_service_interface.dart';
import 'package:myfeed/app/exceptions/exceptions.dart';

class DioHttpService implements IHttpService {
  DioHttpService({
    required this.dio,
  });

  final Dio dio;

  @override
  Future<dynamic> get({
    required String url,
    Map<String, dynamic>? headers,
    Duration timeout = const Duration(seconds: 6),
  }) async {
    try {
      final Response response = await dio.get(
        url,
        options: Options(
          headers: headers,
          receiveTimeout: timeout.inMilliseconds,
        ),
      );

      return response.data;
    } on DioError catch (e) {
      debugPrint(e.message);
      throw TryAgainLaterException();
    }
  }

  @override
  Future<dynamic> delete({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    Duration timeout = const Duration(seconds: 6),
  }) async {
    try {
      Response response = await dio.delete(
        url,
        data: body,
        options: Options(
          headers: headers,
          receiveTimeout: timeout.inMilliseconds,
        ),
      );

      return response.data;
    } on DioError catch (e) {
      debugPrint(e.message);
      throw TryAgainLaterException();
    }
  }

  @override
  Future<dynamic> post({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    Duration timeout = const Duration(seconds: 6),
  }) async {
    try {
      Response response = await dio.post(
        url,
        data: body,
        options: Options(
          headers: headers,
          receiveTimeout: timeout.inMilliseconds,
        ),
      );

      return response.data;
    } on DioError catch (e) {
      debugPrint(e.message);
      throw TryAgainLaterException();
    }
  }

  @override
  Future<dynamic> put({
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    Duration timeout = const Duration(seconds: 6),
  }) async {
    try {
      Response response = await dio.put(
        url,
        data: body,
        options: Options(
          headers: headers,
          receiveTimeout: timeout.inMilliseconds,
        ),
      );

      return response.data;
    } on DioError catch (e) {
      debugPrint(e.message);
      throw TryAgainLaterException();
    }
  }
}
