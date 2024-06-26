import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
abstract class ApiServices {
  Future<dynamic> get(String path,
      {Map<String, String>? queryParams, bool? hasToken});

  Future post(
    String path, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? body,
    FormData? formData,
    bool? hasToken,
  });

  Future reqHttp(BuildContext context,String path,
      {Map<String, dynamic>? queryParams,
        Map<String, String> body=const {},
        String typeRequest="POST",
        String? key,
        List<http.MultipartFile> multipartFile=const[],bool? hasToken});

  Future postFiles(BuildContext context,
      String path, {
        Map<String, dynamic>? queryParams,
        Map<String, dynamic>? body,
        FormData? formData,
        String? key,
        bool? hasToken,
      });

  Future postList(
      String path, {
        Map<String, String>? queryParams,
        List<dynamic>? body,
        FormData? formData,
        bool? hasToken,
      });
  Future put(
      String path, {
        Map<String, dynamic>? queryParams,
        Map<String, dynamic>? body,
        FormData? formData,
        bool? hasToken,
      });
  Future<dynamic> delete(
    String path, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? body,
    bool? hasToken,
  });
}
