import 'package:architecture_ptc/src/features/mail_box/data/models/info_box_model.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/data/models/base_model.dart';
import '../../../../../../core/domain/services/api_service.dart';
import '../../../../../../core/utils/app_url.dart';
import '../../../../core/data/models/file_model.dart';
import '../../models/request_box_model.dart';
import '../../models/type_model.dart';

class RequestBoxRemoteDataSource {
  final ApiServices _apiServices;

  RequestBoxRemoteDataSource(this._apiServices);

  Future<BaseModel> uploadRequestFiles(BuildContext context,
      {required List<PlatformFile> files, String? key}) async {
    FormData formData = FormData();
    int i = 0;
    for (PlatformFile item in files) {
      formData.files.add(
        MapEntry("files[$i]", await MultipartFile.fromFile(item.path ?? '')),
      );
      i++;
    }
    final response = await _apiServices.postFiles(
        context, AppUrl.uploadFileRequestBox,
        key: key, formData: formData, hasToken: true);
    return BaseModel.fromJson(
      response,
      (json) => FileModels.fromJson(json),
    );
  }

  Future<BaseModel> createRequestBox({
    required RequestBox requestBox,
    List<int>? fileIds,
  }) async {
    return BaseModel(data: null);

    ///code here
  }

  Future<BaseModel> getRequestBoxById({required int requestBoxId}) async {
    return BaseModel(data: null);

    ///code here
  }

  Future<BaseModel> getInfoBox() async {
    final response = await _apiServices.get(
      AppUrl.getInfoMailBox,
      hasToken: true,
    );

    return BaseModel.fromJson(
      response,
      (json) => InfoBox.fromJson(json),
    );
  }

  Future<BaseModel> getRequestBoxes({
    required int? page,
    required String nameList,
  }) async {
    final queryParams = <String, String>{
      if (page != null) 'page': page.toString(),
    };

    final response = await _apiServices.get(
      '${AppUrl.requestMailBox}/$nameList',
      queryParams: queryParams,
      hasToken: true,
    );
    return BaseModel.fromJson(
      response,
      (json) => BaseModels.fromJson(
        json,
        (itemJson) => RequestBox.fromJson(itemJson),
      ),
    );

    ///code here
  }

  Future<BaseModel> getRequestBoxTypes(
      {required int? page, required String? term}) async {
    Map<String, String> queryParams = {};
    if (page != null) queryParams.addAll({"page": "$page"});
    if (term != null) queryParams.addAll({"term": term});

    final response = await _apiServices.get(AppUrl.requestBoxTypeGlobal,
        queryParams: queryParams, hasToken: true);

    return BaseModel.fromJson(
      response,
      (json) => BaseModels.fromJson(
        json,
        (itemJson) => TypeModel.fromJson(itemJson),
      ),
    );
  }
}
