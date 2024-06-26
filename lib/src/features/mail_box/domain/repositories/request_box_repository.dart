
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../../../../../core/data/datasource/remote/api_response.dart';
import '../../../../../core/data/models/base_model.dart';
import '../../../../../core/domain/error_handler/network_exceptions.dart';
import '../../data/datasource/remote/request_box_remote_data_source.dart';
import '../../data/models/request_box_model.dart';


class RequestBoxRepository {
  final RequestBoxRemoteDataSource _remoteDataSource;

  RequestBoxRepository(this._remoteDataSource) ;

  Future<ApiResponse<BaseModel>> createRequestBox({
    required RequestBox requestBox,
    List<int>? fileIds,
  }) async {
    try {
      final response = await _remoteDataSource.createRequestBox(
          requestBox:requestBox,fileIds:fileIds
      );
      return ApiResponse.success(response);
    } catch (error) {
      return ApiResponse.failure(
        NetworkExceptions.getException(error),
      );
    }
  }
  Future<ApiResponse<BaseModel>> getRequestBoxById({required int requestBoxId}) async {
    try {
      final response = await _remoteDataSource.getRequestBoxById(requestBoxId:requestBoxId);
      return ApiResponse.success(response);
    } catch (error) {
      return ApiResponse.failure(
        NetworkExceptions.getException(error),
      );
    }
  }
  Future<ApiResponse<BaseModel>> getRequestBoxes({required int? page, required String nameList }) async {
    try {
      final response = await _remoteDataSource.getRequestBoxes(page:page,nameList:nameList);
      return ApiResponse.success(response);
    } catch (error) {

      return ApiResponse.failure(
        NetworkExceptions.getException(error),
      );
    }
  }

  Future<ApiResponse<BaseModel>> getRequestBoxTypes({required int? page, required String? term }) async {
    try {
      final response = await _remoteDataSource.getRequestBoxTypes(page:page,term:term);
      return ApiResponse.success(response);
    } catch (error) {

      return ApiResponse.failure(
        NetworkExceptions.getException(error),
      );
    }
  }
  Future<ApiResponse<BaseModel>> getInfoBox() async {
    try {
      final response = await _remoteDataSource.getInfoBox();
      return ApiResponse.success(response);
    } catch (error) {
      return ApiResponse.failure(
        NetworkExceptions.getException(error),
      );
    }
  }

  Future<ApiResponse<BaseModel>> uploadRequestFiles(BuildContext context,{required List<PlatformFile> files,String? key}) async {
    try {
      final response = await _remoteDataSource.uploadRequestFiles(context,files:files,key: key);
      return ApiResponse.success(response);
    } catch (error) {
      return ApiResponse.failure(
        NetworkExceptions.getException(error),
      );
    }
  }
}
