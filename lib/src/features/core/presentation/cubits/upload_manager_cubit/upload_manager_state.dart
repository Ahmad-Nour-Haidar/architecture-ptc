part of 'upload_manager_cubit.dart';

@freezed
class UploadManagerState with _$UploadManagerState {
  const factory UploadManagerState.initial() = _Initial;
  const factory UploadManagerState.dispose() = _Dispose;
  const factory UploadManagerState.save() = _Save;
  const factory UploadManagerState.loading() = _Loading;
  const factory UploadManagerState.upload(InfoFile? data,String? progress) = _Upload;
  const factory UploadManagerState.pause(InfoFile? data) = _Pause;
  const factory UploadManagerState.failure(NetworkExceptions? networkException) = _Failure;
  const factory UploadManagerState.success(InfoFile? data,String? message) = _Success;
}

