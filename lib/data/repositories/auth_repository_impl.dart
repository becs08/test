import 'package:obi/core/constants/key_names.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repositories/auth_repository.dart';
import '../../service_locator.dart';
import '../models/auth/login_request.dart';
import '../models/auth/login_response.dart';
import '../models/auth/register_request.dart';
import '../source/auth_api_service.dart';
import '../source/auth_local_service.dart';

class AuthRepositoryImpl extends AuthRepository{
  @override
  Future<Either<String,LoginResponse>> login(LoginRequest request) async {
    Either<String,LoginResponse> result =  await sl<AuthApiService>().login(request);
    return result.fold(
        (error){
          return Left(error);
        },
        (data) async {
          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          sharedPreferences.setString(KeyNames.jwt, data.token);
          return Right(data);
        }
    );
  }

  @override
  Future<Either> register(RegisterRequest request) {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  Future<bool> isLoggedIn() async {
    return await sl<AuthLocalService>().isLoggedIn();
  }

  @override
  Future<Either> logout() async {
    return await sl<AuthLocalService>().logout();
  }

}