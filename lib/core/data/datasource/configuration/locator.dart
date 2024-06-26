import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../../../src/features/auth/data/datasource/remote/auth_remote_data_source.dart';
import '../../../../src/features/auth/domain/repositories/auth_repository.dart';
import '../../../../src/features/core/presentation/cubits/file_manager_cubit/file_manager_cubit.dart';
import '../../../../src/features/core/presentation/cubits/splash_cubit/splash_cubit.dart';
import '../../../../src/features/core/presentation/cubits/user_cubit/user_cubit.dart';
import '../../../../src/features/mail_box/data/datasource/remote/request_box_remote_data_source.dart';
import '../../../../src/features/mail_box/domain/repositories/request_box_repository.dart';
import '../../../../src/features/mail_box/presentation/cubits/request_box_cubit/request_box_cubit.dart';
import '../../../domain/services/api_service.dart';
import '../../../domain/services/api_services_imp.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<Dio>(() => Dio());
  locator.registerLazySingleton<ApiServices>(() => ApiServicesImp(locator()));
  locator.registerLazySingleton<AuthRepository>(
      () => AuthRepository(AuthRemoteDataSource(locator())));
  locator.registerLazySingleton<RequestBoxRepository>(
      () => RequestBoxRepository(RequestBoxRemoteDataSource(locator())));

  // Registering the cubits
  locator.registerFactory<SplashCubit>(() => SplashCubit());
  locator
      .registerFactory<UserCubit>(() => UserCubit(locator<AuthRepository>()));
  locator.registerFactory<RequestBoxCubit>(
      () => RequestBoxCubit(locator<RequestBoxRepository>()));
  locator.registerFactory<FileManagerCubit>(() => FileManagerCubit());
}
