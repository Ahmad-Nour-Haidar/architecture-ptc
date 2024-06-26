
import '../../../../../core/data/datasource/remote/api_response.dart';
import '../../../../../core/data/models/base_model.dart';
import '../../../../../core/domain/error_handler/network_exceptions.dart';
import '../../data/remote/users_remote_data_source.dart';

class UsersRepository {
  final UsersRemoteDataSource _remoteDataSource;

  UsersRepository(this._remoteDataSource) ;

  Future<ApiResponse<BaseModel>> searchUserByTerm({required int? page,  String? term }) async {
    try {
      final response = await _remoteDataSource.searchUserByTerm(page:page,term:term);

      return ApiResponse.success(response);
    } catch (error) {

      return ApiResponse.failure(
        NetworkExceptions.getException(error),
      );
    }
  }
}
