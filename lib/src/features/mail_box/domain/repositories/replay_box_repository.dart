
import 'package:file_picker/file_picker.dart';
import '../../../../../core/data/datasource/remote/api_response.dart';
import '../../../../../core/data/models/base_model.dart';
import '../../../../../core/domain/error_handler/network_exceptions.dart';
import '../../data/datasource/remote/replay_box_remote_data_source.dart';
import '../../data/models/replay_box_model.dart';


class ReplayBoxRepository {
  final ReplayBoxRemoteDataSource _remoteDataSource;

  ReplayBoxRepository(this._remoteDataSource) ;

  Future<ApiResponse<BaseModel>> createReplayBox(
      { required ReplayBox replayBox,
        List<int>? fileIds,}) async {
    try {
      final response = await _remoteDataSource.createReplayBox(replayBox:replayBox,fileIds:fileIds);
      return ApiResponse.success(response);
    } catch (error) {
      return ApiResponse.failure(
        NetworkExceptions.getException(error),
      );
    }
  }
  Future<ApiResponse<BaseModel>> getReplayBoxById({required int replayBoxId}) async {
    try {
      final response = await _remoteDataSource.getReplayBoxById(replayBoxId:replayBoxId);
      return ApiResponse.success(response);
    } catch (error) {
      return ApiResponse.failure(
        NetworkExceptions.getException(error),
      );
    }
  }
  Future<ApiResponse<BaseModel>> getReplayBoxes({required int? page}) async {
    try {
      final response = await _remoteDataSource.getReplayBoxes(page:page);
      return ApiResponse.success(response);
    } catch (error) {
      return ApiResponse.failure(
        NetworkExceptions.getException(error),
      );
    }
  }
  Future<ApiResponse<BaseModel>> uploadReplayFiles({required List<PlatformFile> files,}) async {
    try {
      final response = await _remoteDataSource.uploadReplayFiles(files:files);
      return ApiResponse.success(response);
    } catch (error) {
      return ApiResponse.failure(
        NetworkExceptions.getException(error),
      );
    }
  }
  Future<ApiResponse<BaseModel>> updateReplayBox(
      { required ReplayBox replayBox,
        List<int>? fileIds,
      required int replayBoxId}) async {
    try {
      final response = await _remoteDataSource.updateReplayBox(replayBox:replayBox, replayBoxId: replayBoxId);
      return ApiResponse.success(response);
    } catch (error) {
      return ApiResponse.failure(
        NetworkExceptions.getException(error),
      );
    }
  }
  Future<ApiResponse<BaseModel>> deleteReplayBox(
      { required int replayBoxId}) async {
    try {
      final response = await _remoteDataSource.deleteReplayBox(replayBoxId:replayBoxId);
      return ApiResponse.success(response);
    } catch (error) {
      return ApiResponse.failure(
        NetworkExceptions.getException(error),
      );
    }
  }
}
