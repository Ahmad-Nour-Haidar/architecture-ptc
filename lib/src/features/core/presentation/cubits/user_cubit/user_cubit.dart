import 'dart:async';

import 'package:architecture_ptc/core/data/datasource/storage/app_storage.dart';
import 'package:architecture_ptc/src/features/cache/data/models/users.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../core/domain/error_handler/network_exceptions.dart';

import '../../../../../../core/routing/app_router.dart';
import '../../../../../../core/widgets/constants.dart';
import '../../../../auth/domain/repositories/auth_repository.dart';


part 'user_state.dart';
part 'user_cubit.freezed.dart';

class UserCubit extends Cubit<UserState> {
  final AuthRepository _repository;
  String? photoProfileUrl;
  XFile? image;
  UserCubit(this._repository) : super(const UserState.initial());
  UserModel? user;
  String? emailOtp;
  String? codeOtp;




  void _initUser(BuildContext context) {
  }
  Future<void> _saveUser(BuildContext context) async {
    emit(const UserState.save());
    AppStorage.instance.writeData(AppStorage.TOKEN, user?.token);
    AppStorage.instance.writeData(AppStorage.LOGIN_TIME, DateTime.now().toIso8601String());
  }

  Future<void> disposeUser(BuildContext context) async {
    emit(const UserState.dispose());
    AppStorage.instance.removeData(AppStorage.TOKEN);
    AppStorage.instance.removeData(AppStorage.LOGIN_TIME);
    goRouter.pushReplacementNamed(AppRoute.splash.name);
  
  }

  Future<void> login(BuildContext context,
      {required String email, required String password}) async {
    emit(
      const UserState.loading(),
    );

    Constants.loading(context);

    final response = await _repository.login(email, password);

    response.when(
      success: (data) async {
        user = data.data;
        emit(
          UserState.success(user!, data.message),
        );
        await _saveUser(context);
        Constants.onSuccess(context,message: data.message);
        goRouter.pop();
          goRouter.pushReplacementNamed(AppRoute.navbar.name);
      },
      failure: (networkException) {
        goRouter.pop();
        emit(
          UserState.failure(networkException),
        );
        Constants.onFailure(context,message: NetworkExceptions.getErrorMessage(networkException));

      },
    );
  }


  Future<void> logout(BuildContext context) async {
    emit(
      const UserState.loading(),
    );
    Constants.loading(context);

    final response = await _repository.logout();

    response.when(
      success: (data) async {
        emit(
          UserState.success(null, data.message),
        );
        Constants.onSuccess(context,message: data.message);

        goRouter.pop();
          // Navigator.pop(context);
        await disposeUser(context);

      },
      failure: (networkException) async {

        goRouter.pop();
          // Navigator.pop(context);
        emit(
          UserState.failure(networkException),
        );

        Constants.onNetworkFailure(context,networkException:networkException);
      },
    );
  }

  Future<void> register(BuildContext context,
      {required String email,
        required String password,
        required String firstName,
        required String lastName,
        required String image,
        String? aboutMe,
      }) async {
    emit(
      const UserState.loading(),
    );
    Constants.loading(context);

    final response = await _repository.register(UserModel(
        email: email,
        firstName: firstName,
        lastName: lastName,
        password: password,

        image: image,
        about: aboutMe));
    response.when(
      success: (data) async {
        user = data.data;
        emit(
          UserState.success(user!, data.message),
        );
        await _saveUser(context);
       goRouter.pop();
        // if (user!.is_verified != null && !user!.is_verified!)
        //   goRouter.pushNamed(AppRoute.verifyEmail.name);
        // else
          goRouter.pushReplacementNamed(AppRoute.navbar.name);
   },
      failure: (networkException) {
        goRouter.pop();
        emit(UserState.failure(networkException),);
        Constants.onFailure(context,message: NetworkExceptions.getErrorMessage(networkException));

      },
    );
  }
  Future<void> getProfile(
    BuildContext context,
  ) async {
    emit(
      const UserState.loading(),
    );
    final response = await _repository.getProfile();
    response.when(
      success: (data) async {
        user = await data.data;
        emit(
          UserState.success(user!, data.message),
        );
        goRouter.pushReplacementNamed(AppRoute.navbar.name);
      },
      failure: (networkException) async {
        emit(UserState.failure(networkException),);
        Constants.onFailure(context,message: NetworkExceptions.getErrorMessage(networkException));
        goRouter.pushReplacementNamed(AppRoute.login.name);
      },
    );
  }


}
