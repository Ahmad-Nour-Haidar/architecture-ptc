part of 'user_cubit.dart';

@freezed
class UserState with _$UserState {
  const factory UserState.initial() = _Initial;
  const factory UserState.dispose() = _Dispose;
  const factory UserState.save() = _Save;
  const factory UserState.loading() = _Loading;
  const factory UserState.upload() = _Upload;
  const factory UserState.updatePassword() = _UpdatePassword;
  const factory UserState.failure(NetworkExceptions? networkException) = _Failure;
  const factory UserState.success(UserModel? data,String? message) = _Success;
}

