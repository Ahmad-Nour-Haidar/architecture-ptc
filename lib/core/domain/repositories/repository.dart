import 'package:architecture_ptc/src/features/cache/data/models/users.dart';
import '../../data/datasource/remote/api_response.dart';
import '../../data/datasource/remote/remote_data_source.dart';
import '../../data/models/base_model.dart';
import '../error_handler/network_exceptions.dart';

class Repository {
  final RemoteDataSource _remoteDataSource;

  Repository(this._remoteDataSource);

  Future<ApiResponse<BaseModel>> login(String email, String password) async {
    try {
      final response = await _remoteDataSource.login(email, password);

      return ApiResponse.success(response);
    } catch (error) {
      return ApiResponse.failure(
        NetworkExceptions.getException(error),
      );
    }
  }

  Future<ApiResponse<BaseModel>> register(UserModel user) async {
    try {
      final response = await _remoteDataSource.register(user);
      return ApiResponse.success(response);
    } catch (error) {
      return ApiResponse.failure(
        NetworkExceptions.getException(error),
      );
    }
  }




  Future<ApiResponse<BaseModel>> logout() async {
    try {
      final response = await _remoteDataSource.logout();
      return ApiResponse.success(response);
    } catch (error) {
      return ApiResponse.failure(
        NetworkExceptions.getException(error),
      );
    }
  }

  Future<ApiResponse<BaseModel>> getProfile() async {
    try {
      final response = await _remoteDataSource.getProfile();
      return ApiResponse.success(response);
    } catch (error) {
      return ApiResponse.failure(
        NetworkExceptions.getException(error),
      );
    }
  }

}
