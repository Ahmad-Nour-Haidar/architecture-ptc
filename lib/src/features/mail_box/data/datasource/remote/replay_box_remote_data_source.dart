
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import '../../../../../../core/data/models/base_model.dart';
import '../../../../../../core/domain/services/api_service.dart';
import '../../../../../../core/utils/app_url.dart';
import '../../../../core/data/models/file_model.dart';
import '../../models/replay_box_model.dart';


class ReplayBoxRemoteDataSource  {
  final ApiServices _apiServices;

  ReplayBoxRemoteDataSource(this._apiServices);
  Future<BaseModel> uploadReplayFiles({required List<PlatformFile> files,}) async {
    FormData formData =FormData();
    int i=0;
    for (PlatformFile item in files){
      formData.files.add(
        MapEntry("files[$i]", await MultipartFile.fromFile(item.path??'')),
      );
      i++;
    }
    final response = await _apiServices.post(AppUrl.uploadFileReplayBox,
        formData: formData,
        hasToken: true);
    return BaseModel.fromJson(
      response,
          (json) => FileModels.fromJson(json),
    );
  }
  Future<BaseModel> createReplayBox(
      { required ReplayBox replayBox,
        List<int>? fileIds,}
      ) async {
    var body=replayBox.toJson();
    body['files_ids']=fileIds;
    final response = await _apiServices.post(AppUrl.createReplayBoxBox,
        body: body,hasToken: true);
    return BaseModel(data: null, message:response['message']??"Create replay successful");

  }

  Future<BaseModel> getReplayBoxById(
      {required int replayBoxId}
      ) async {
    final response = await _apiServices.get('${AppUrl.replayMailboxById}$replayBoxId',
       hasToken: true);
    return BaseModel.fromJson(
      response,
          (json) => ReplayBox.fromJson(json),
    );
  }

  Future<BaseModel> getReplayBoxes(
  {required int? page}
  ) async {

    Map<String, String> queryParams={};
    if (page != null) queryParams = {"page": "$page"};
    final response = await _apiServices.get(AppUrl.replayMailbox,
        queryParams: queryParams, hasToken: true);
    return BaseModel.fromJson(
      response,
          (json) => ReplayBoxes.fromJson(json),
    );
  }

  Future<BaseModel> deleteReplayBox(
      { required int replayBoxId}
      ) async {
    final response = await _apiServices.delete('${AppUrl.replayMailboxById}/$replayBoxId',
      hasToken: true);
    return BaseModel(data: null, message:response['message']??"Delete replay successful");
  }
  Future<BaseModel> updateReplayBox(
      { required ReplayBox replayBox,
        required int replayBoxId,
        List<int>? fileIds,
      }
      ) async {
    var body=replayBox.toJson();
    if(fileIds!=null) {
      body['files_ids']=fileIds;
    }
    final response = await _apiServices.put('${AppUrl.replayMailboxById}/$replayBoxId',
        body: body,hasToken: true);
    return BaseModel(data: null, message:response['message']??"Update replay successful");

  }

}
