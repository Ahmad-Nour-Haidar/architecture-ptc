part of 'file_manager_cubit.dart';

@freezed
class FileManagerState with _$FileManagerState {
  const factory FileManagerState.initial() = _Initial;
  const factory FileManagerState.dispose() = _Dispose;
  const factory FileManagerState.change(List<FileModel> data,) = _Change;

}

