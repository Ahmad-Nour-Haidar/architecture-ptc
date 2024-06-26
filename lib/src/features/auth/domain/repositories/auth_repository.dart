
import '../../../../../core/data/datasource/remote/api_response.dart';
import '../../../../../core/data/models/base_model.dart';
import '../../../../../core/domain/error_handler/network_exceptions.dart';
import '../../../cache/data/models/users.dart';
import '../../data/datasource/remote/auth_remote_data_source.dart';


class AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;

  AuthRepository(this._remoteDataSource) ;

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

  Future<ApiResponse<BaseModel>> logout({String? accountType}) async {
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
