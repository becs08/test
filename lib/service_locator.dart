
import 'package:get_it/get_it.dart';

import 'core/network/dio_client.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'data/repositories/user_repository_impl.dart';
import 'data/source/auth_api_service.dart';
import 'data/source/auth_local_service.dart';
import 'data/source/user_api_service.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/repositories/user_repository.dart';
import 'domain/usecases/auth/is_logged_in_usecase.dart';
import 'domain/usecases/auth/login_usecase.dart';
import 'domain/usecases/auth/logout_usecase.dart';
import 'domain/usecases/user/get_user_infos_usecase.dart';

final sl = GetIt.instance;

void setupServiceLocator(){
  //HTTP DIO Client
  sl.registerSingleton<DioClient>(DioClient());

  //Services
  sl.registerSingleton<AuthApiService>(AuthApiServiceImpl());
  sl.registerSingleton<AuthLocalService>(AuthLocalServiceImpl());
  sl.registerSingleton<UserApiService>(UserApiServiceImpl());

  //Repositories
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<UserRepository>(UserRepositoryImpl());

  //Usecases
  sl.registerSingleton<LoginUseCase>(LoginUseCase());
  sl.registerSingleton<IsLoggedInUseCase>(IsLoggedInUseCase());
  sl.registerSingleton<LogoutUseCase>(LogoutUseCase());
  sl.registerSingleton<GetUserInfosUseCase>(GetUserInfosUseCase());

}