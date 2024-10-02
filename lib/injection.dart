import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:test_app/cubit/my_cubit.dart';
import 'package:test_app/my_repo.dart';
import 'package:test_app/web_service.dart';

final getIt = GetIt.instance;

void initGetIt() {
  getIt
      .registerLazySingleton<WebService>(() => WebService(createAndSetupDio()));
  getIt.registerLazySingleton<MyRepo>(() => MyRepo(getIt()));
  getIt.registerLazySingleton<MyCubit>(() => MyCubit(getIt()));
}

Dio createAndSetupDio() {
  Dio dio = Dio();
  dio
    ..options.connectTimeout
    ..options.receiveTimeout;

  dio.interceptors.add(LogInterceptor(
    responseBody: true,
    error: true,
    requestHeader: false,
    responseHeader: false,
    request: true,
    requestBody: true,
  ));

  return dio;
}
