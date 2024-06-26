

import 'package:architecture_ptc/src/features/cache/data/models/users.dart';
import '../../../../../../core/data/models/base_model.dart';
import '../../../../../../core/domain/services/api_service.dart';
import '../../../../../../core/utils/app_url.dart';


class AuthRemoteDataSource  {
  final ApiServices _apiServices;

  AuthRemoteDataSource(this._apiServices);

  Future<BaseModel> login(String email, String password) async {

    final response = await _apiServices.post(
        AppUrl.login,
        body: {
          "email": email,
          "password": password,
        },
        hasToken: false);

    return BaseModel.fromJson(
      response,
          (json) => UserModel.fromJson(json),
    );
  }

  Future<BaseModel> register(UserModel user) async {
   var data= {
      "email": user.email,
      'password': user.password,
      'password_confirmation': user.password,
      "first_name": user.firstName,
      "last_name": user.lastName,
      "about": user.about,
    };
    final response = await _apiServices.post(AppUrl.register,
        body: data, hasToken: false);

    return BaseModel.fromJson(
      response,
          (json) => UserModel.fromJson(json),
    );
  }




  Future<BaseModel> logout() async {
    final response = await _apiServices.delete(AppUrl.logout, hasToken: true);

    return BaseModel(data: null, message: 'Done logout');
  }
  Future<BaseModel> getProfile() async {
    final response = await _apiServices.get(AppUrl.getProfile, hasToken: true);
    return BaseModel.fromJson(
      response,
          (json) => UserModel.fromJson(json),
    );
  }
}
