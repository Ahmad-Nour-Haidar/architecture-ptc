import 'package:architecture_ptc/core/domain/services/api_service.dart';
import 'package:architecture_ptc/core/domain/services/api_services_imp.dart';
import 'package:architecture_ptc/src/features/auth/data/datasource/remote/auth_remote_data_source.dart';
import 'package:architecture_ptc/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:architecture_ptc/src/features/mail_box/data/datasource/remote/replay_box_remote_data_source.dart';
import 'package:architecture_ptc/src/features/mail_box/data/datasource/remote/request_box_remote_data_source.dart';
import 'package:architecture_ptc/src/features/mail_box/domain/repositories/replay_box_repository.dart';
import 'package:architecture_ptc/src/features/mail_box/domain/repositories/request_box_repository.dart';
import 'package:dio/dio.dart';

class BlocProviderSingleton {
  static final BlocProviderSingleton _instance = BlocProviderSingleton._internal();
  static BlocProviderSingleton get instance => _instance;

  factory BlocProviderSingleton() {
    return _instance;
  }

  BlocProviderSingleton._internal();

}


final Dio dio=  Dio();
final ApiServices apiServices=ApiServicesImp(dio);
final AuthRepository authRepository=  AuthRepository(AuthRemoteDataSource(apiServices));
final RequestBoxRepository requestBoxRepository=  RequestBoxRepository(RequestBoxRemoteDataSource(apiServices));
final ReplayBoxRepository replayBoxRepository=  ReplayBoxRepository(ReplayBoxRemoteDataSource(apiServices));


