import 'package:dio/dio.dart';
import '../../../../src/features/cache/data/models/users.dart';
import '../../../domain/services/api_service.dart';
import '../../../utils/app_url.dart';
import '../../models/base_model.dart';


class RemoteDataSource {
  final ApiServices _apiServices;

  RemoteDataSource(this._apiServices);

  Future<BaseModel> login(String email, String password) async {
    final response = await _apiServices.post(AppUrl.login,
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
    FormData formData = FormData.fromMap({
      "email": user.email,
      'password': user.password,
      "first_name": user.firstName,
      "last_name": user.lastName,
      "about": user.about,
    });
    final response = await _apiServices.post(AppUrl.register,
        formData: formData, hasToken: false);

    return BaseModel.fromJson(
      response,
      (json) => UserModel.fromJson(json),
    );
  }


  Future<BaseModel> logout() async {
    final response = await _apiServices.delete(AppUrl.logout, hasToken: true);

    return BaseModel(data: null, message: 'Done logout');
  }


  ///
  Future<BaseModel> getProfile() async {
    final response = await _apiServices.get(AppUrl.getProfile, hasToken: true);
    return BaseModel.fromJson(
      response,
      (json) => UserModel.fromJson(json),
    );
  }


}
