import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../core/data/datasource/configuration/data_configuration.dart';
import '../../../../../../core/data/datasource/storage/app_storage.dart';
import '../user_cubit/user_cubit.dart';

part 'splash_state.dart';
part 'splash_cubit.freezed.dart';

class SplashCubit extends Cubit<SplashState>    {
  SplashCubit() : super(const SplashState.initial());


  Future<void> _loadSplash(BuildContext context)  async {
    emit(const SplashState.loading());
    AppStorage.instance.init();
    await  BlocProvider.of<UserCubit>(context).getProfile(context);
    // await Future.delayed( const Duration(seconds: 5), () {
    //   goRouter.pushReplacementNamed(AppRoute.navbar.name);
    // });

  }
  Future<void> _initSplash(BuildContext context) async {
    emit(const SplashState.initial());
    await AppStorage.instance.init();
    await initDataConfiguration();


  }
  Future<void> initSplash(BuildContext context) async {
    await _initSplash(context);
     await _loadSplash(context);
  }




}
