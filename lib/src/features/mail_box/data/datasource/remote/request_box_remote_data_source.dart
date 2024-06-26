

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/data/models/base_model.dart';
import '../../../../../../core/domain/services/api_service.dart';
import '../../../../../../core/utils/app_url.dart';
import '../../../../core/data/models/file_model.dart';
import '../../models/info_box_model.dart';
import '../../models/request_box_model.dart';
import '../../models/type_model.dart';


class RequestBoxRemoteDataSource  {
  final ApiServices _apiServices;

  RequestBoxRemoteDataSource(this._apiServices);

  Future<BaseModel> uploadRequestFiles(BuildContext context,{required List<PlatformFile> files,String? key}) async {
    FormData formData =FormData();
    int i=0;
    for (PlatformFile item in files){
      formData.files.add(
        MapEntry("files[$i]", await MultipartFile.fromFile(item.path??'')),
      );
      i++;
    }
    final response = await _apiServices.postFiles(context,AppUrl.uploadFileRequestBox,
        key:key ,
        formData: formData,
        hasToken: true);
    return BaseModel.fromJson(
      response,
          (json) => FileModels.fromJson(json),
    );
  }
  Future<BaseModel> createRequestBox(
      { required RequestBox requestBox,
        List<int>? fileIds,}
      ) async {
    var body=requestBox.toJson();
    body['files_ids']=fileIds;
    final response = await _apiServices.post(AppUrl.requestMailBox,
        body: body,hasToken: true);
    return BaseModel(data: null, message:response['message']??"Create request successful");

  }


  Future<BaseModel> getRequestBoxById(
      {required int requestBoxId}
      ) async {
    final response = await _apiServices.get('${AppUrl.requestMailBoxById}$requestBoxId',
       hasToken: true);
    return BaseModel.fromJson(
      response,
          (json) => RequestBox.fromJson(json),
    );
  }
  Future<BaseModel> getInfoBox(

      ) async {

    final response = await _apiServices.get(AppUrl.getInfoMailBox,
        hasToken: true);
    return BaseModel.fromJson(
      response,
          (json) => InfoBox.fromJson(json),
    );
  }

  Future<BaseModel> getRequestBoxes(
  {required int? page, required String nameList }
  ) async {

    Map<String, String> queryParams={};
    if (page != null) queryParams = {"page": "$page"};
    final response = await _apiServices.get('${AppUrl.requestMailBox}/$nameList',
        queryParams: queryParams, hasToken: true);
    return BaseModel.fromJson(
      response,
          (json) => RequestBoxes.fromJson(json),
    );
  }

  Future<BaseModel> getRequestBoxTypes(
      {required int? page, required String? term }
      ) async {


    Map<String,String> queryParams={};
    if (page != null) queryParams.addAll( {"page": "$page"});
    if (term != null) queryParams.addAll({"term": term});

    final response = await _apiServices.get(AppUrl.requestBoxTypeGlobal,
        queryParams: queryParams, hasToken: true);

    return BaseModel.fromJson(
      response,
          (json) => BaseModels.fromJson(json,(itemJson)=>TypeModel.fromJson(itemJson)),
    );
  }

}
