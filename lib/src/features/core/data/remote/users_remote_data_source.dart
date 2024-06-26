
import '../../../../../core/data/models/base_model.dart';

import '../../../../../core/domain/services/api_service.dart';
import '../../../../../core/utils/app_url.dart';
import '../../../cache/data/models/users.dart';


class UsersRemoteDataSource  {
  final ApiServices _apiServices;

  UsersRemoteDataSource(this._apiServices);
  Future<BaseModel> searchUserByTerm(
      {required int? page, required String? term }
      ) async {
    var queryParams={"name":term??''};
    if (page != null) queryParams["page"] ="$page";
    final response = await _apiServices.get(AppUrl.searchUsersByTerm,
        queryParams: queryParams, hasToken: true);

    return BaseModel.fromJson(
      response,
          (json) => BaseModels.fromJson(json,(itemJson)=>UserModel.fromJson(itemJson)),
    );
  }

}
