import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import '../../../core/utils/app_url.dart';
import '../../../src/features/core/presentation/cubits/upload_manager_cubit/upload_manager_cubit.dart';
import '../../data/datasource/storage/app_storage.dart';
import 'api_service.dart';

class ApiServicesImp implements ApiServices {
  final Dio _dio;
  late Map<String, dynamic> _headers;

  ApiServicesImp(this._dio) {
    _dio.options
      ..baseUrl = baseUrl
      ..responseType = ResponseType.plain
      ..sendTimeout =const Duration(minutes: 1)
      ..receiveTimeout = const Duration(minutes: 1)
      ..connectTimeout = const Duration(seconds: 10)
      ..followRedirects = true;
    _dio.interceptors.add(dioLoggerInterceptor);
  }

  Future<void> setHeaders(bool hasToken) async {
    _headers = {
      "Accept": "application/json",

      "accept-timezone":DateTime.now().timeZoneName,
      "Authorization":
          hasToken ? "Bearer ${( AppStorage.instance.readData(AppStorage.TOKEN))}" : null,
      // "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhaG1hZDEiLCJleHAiOjE2NzE4Nzc2MTMsImlhdCI6MTY3MTUxNzYxM30.ipa9KNJP2QhloBMtC0g0P0lwfGZlhGw9aWXQTC02G74":null,

    };

  }

  @override
  Future delete(String path,
      {Map<String, dynamic>? queryParams,
      Map<String, dynamic>? body,
      bool? hasToken}) async {
    try {
      await setHeaders(hasToken ?? true);
      final response = await _dio.delete(
        path,
        queryParameters: queryParams,
        data: body,
        options: Options(headers: _headers),
      );
      return _handleResponseAsJson(response);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future get(String path,
      {Map<String, String>? queryParams, bool? hasToken}) async {
    try {
      await setHeaders(hasToken ?? true);
      final response = await _dio.get(
        path,
        queryParameters: queryParams,
        options: Options(headers: _headers),
      );
      return _handleResponseAsJson(response);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future post(String path,
      {Map<String, dynamic>? queryParams,
      Map<String, dynamic>? body,
      FormData? formData,
      bool? hasToken}) async {
    try {
      await setHeaders(hasToken ?? true);

      final response = await _dio.post(
        path,
        queryParameters: queryParams,
        data: formData ?? body,
        options:
            Options(headers: _headers, contentType: Headers.jsonContentType),
      );

      return _handleResponseAsJson(response);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future reqHttp(BuildContext context, String path,
      {Map<String, dynamic>? queryParams,
      Map<String, String> body = const {},
      String typeRequest = "POST",
      String? key,
      List<http.MultipartFile> multipartFile = const [],
      bool? hasToken}) async {
    try {
      await setHeaders(hasToken ?? true);
      var headers = {"Accept": "application/json"};
      if (hasToken ?? true) {
        String token = "Bearer ${( AppStorage.instance.readData(AppStorage.TOKEN))}";
        headers['Authorization'] = token;
      }
      final mRequest = http.MultipartRequest(typeRequest, Uri.parse(path))
        ..files.addAll(multipartFile)
        ..fields.addAll(body)
        ..headers.addAll(headers);

      final response = await mRequest.send().timeout(const Duration(minutes: 1));
      return jsonDecode(await response.stream.transform(utf8.decoder).first);
    } catch (error) {
      //BlocProvider.of<UploadManagerCubit>(context).failureUploadFile(key:key);
      rethrow;
    }
  }

  @override
  Future postFiles(BuildContext context, String path,
      {Map<String, dynamic>? queryParams,
      Map<String, dynamic>? body,
      String? key,
      FormData? formData,
      bool? hasToken}) async {
    try {
      await setHeaders(hasToken ?? true);

      final response = await _dio.post(path,
          queryParameters: queryParams,
          data: formData ?? body,
          options:
              Options(headers: _headers, contentType: Headers.jsonContentType),
          onSendProgress: (sent, total) {
        if (total != -1) {

          var progress = (sent / total * 100).toStringAsFixed(0);
          BlocProvider.of<UploadManagerCubit>(context)
              .uploadFile(key: key, progress: progress);
        }
      }, onReceiveProgress: (sent, total) {
        if (total != -1) {
          var progress = (sent / total * 100).toStringAsFixed(0);
          print('Download progress: $progress%');
        }
      });
      BlocProvider.of<UploadManagerCubit>(context).completeUploadFile(key: key);
      return _handleResponseAsJson(response);
    } catch (error) {
      BlocProvider.of<UploadManagerCubit>(context).failureUploadFile(key: key);
      rethrow;
    }
  }

  dynamic _handleResponseAsJson(Response response) {
    final responseAsJson = response.data.toString().isEmpty
        ? {}
        : jsonDecode(response.data.toString());
    return responseAsJson;
  }

  @override
  Future postList(String path,
      {Map<String, String>? queryParams,
      List? body,
      FormData? formData,
      bool? hasToken}) async {
    try {
      setHeaders(hasToken ?? true);
      final response = await _dio.post(
        path,
        queryParameters: queryParams,
        data: formData ?? body,
        options:
            Options(headers: _headers, contentType: Headers.jsonContentType),
      );
      return _handleResponseAsJson(response);
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future put(String path,
      {Map<String, dynamic>? queryParams,
      Map<String, dynamic>? body,
      FormData? formData,
      bool? hasToken}) async {
    try {
      await setHeaders(hasToken ?? true);

      final response = await _dio.put(
        path,
        queryParameters: queryParams,
        data: formData ?? body,
        options:
            Options(headers: _headers, contentType: Headers.jsonContentType),
      );
      return _handleResponseAsJson(response);
    } catch (error) {
      rethrow;
    }
  }

  final dioLoggerInterceptor =
  InterceptorsWrapper(onRequest: (RequestOptions options, handler) {
    String headers = "";
    options.headers.forEach((key, value) {
      headers += "| $key: $value";
    });
    log("┌------------------------------------------------------------------------------");
    log('''| [DIO] Request: ${options.method} ${options.uri}
| ${options.data.toString()}
| Headers:\n$headers''');
    log("├------------------------------------------------------------------------------");
    handler.next(options); //continue
  }, onResponse: (Response response, handler) async {
    log(response.data.toString());
    log("└------------------------------------------------------------------------------");
    handler.next(response);
    // return response; // continue
  }, onError: (DioException error, handler) async {
    log("| [DIO] Error: ${error.error}: ${error.response.toString()}");
    log("└------------------------------------------------------------------------------");
    handler.next(error); //continue
  });
}
